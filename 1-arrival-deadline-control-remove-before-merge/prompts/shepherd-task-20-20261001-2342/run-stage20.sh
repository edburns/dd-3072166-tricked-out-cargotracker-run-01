#!/usr/bin/env bash
set -Eeuo pipefail

REPO='edburns/dd-3072166-tricked-out-cargotracker-run-01'
PARENT_ISSUE=1
LOG='/home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342'
BODY_VERIFIER='/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-github-issue-body.sh'
CHILD_LINK_VERIFIER='/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-stage20-child-links.sh'
LEDGER="$LOG/creation-ledger.json"
RESULT="$LOG/stage-20-result.json"
PRE_CHILDREN="$LOG/pre-creation-children.json"
FINAL_CHILDREN="$LOG/final-children.json"
CURRENT_OPERATION='initialization'

atomic_write() {
  local destination="$1" content="$2" temporary
  temporary="$(mktemp "$(dirname "$destination")/.stage20.XXXXXX")"
  printf '%s\n' "$content" >"$temporary"
  mv "$temporary" "$destination"
}

update_ledger_flag() {
  local number="$1" field="$2" value="$3" updated
  updated="$(
    jq \
      --argjson number "$number" \
      --arg field "$field" \
      --argjson value "$value" \
      'map(if .number == $number then .[$field] = $value else . end)' \
      "$LEDGER"
  )" || return 1
  atomic_write "$LEDGER" "$updated"
}

fetch_normalized_children() {
  local output
  output="$(gh api "repos/$REPO/issues/$PARENT_ISSUE/sub_issues" --paginate --slurp)"
  printf '%s' "$output" |
    jq 'if length == 0 then [] elif all(.[]; type == "array") then add else . end'
}

reconcile_failure() {
  local exit_code="$1" error_message="$2" children='[]' updated result
  trap - ERR
  set +e

  if [[ -f "$LEDGER" ]]; then
    children="$(fetch_normalized_children 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
      updated="$(
        jq \
          --argjson children "$children" \
          'map(. as $entry | .linked = any($children[]; .id == $entry.id))' \
          "$LEDGER"
      )"
      atomic_write "$LEDGER" "$updated"
    fi
  fi

  result="$(
    jq -n \
      --arg error "$CURRENT_OPERATION: $error_message (exit $exit_code)" \
      '{
        schemaVersion: 1,
        status: "failed",
        ledgerFile: "creation-ledger.json",
        operationError: $error
      }'
  )"
  atomic_write "$RESULT" "$result"

  printf 'Stage 20 failed during %s: %s (exit %s)\n' \
    "$CURRENT_OPERATION" "$error_message" "$exit_code" >&2
  if [[ -f "$LEDGER" ]] && [[ "$(jq 'length' "$LEDGER" 2>/dev/null)" -gt 0 ]]; then
    jq -r \
      '.[] | "#\(.number) | \(.title) | \(.url) | \(.bodyFile) | body_verified=\(.body_verified) | linked=\(.linked)"' \
      "$LEDGER" >&2
    jq -r \
      '.[] | "gh issue delete \(.number) --repo '\'''"$REPO"''\'' --yes"' \
      "$LEDGER" >&2
    printf 'No automatic rollback was performed. Delete every issue in the ledger before invoking this skill again.\n' >&2
  else
    printf 'No issues were created; no cleanup is required.\n' >&2
  fi
  exit "$exit_code"
}

on_error() {
  local exit_code="$1" line="$2"
  reconcile_failure "$exit_code" "unexpected command failure at script line $line"
}
trap 'on_error "$?" "$LINENO"' ERR

append_ledger_entry() {
  local subsection="$1" relative_body="$2" created_json="$3" updated
  updated="$(
    jq \
      --arg subsection "$subsection" \
      --arg bodyFile "$relative_body" \
      --argjson issue "$created_json" \
      '. + [{
        implementationSubsection: $subsection,
        bodyFile: $bodyFile,
        id: $issue.id,
        number: $issue.number,
        title: $issue.title,
        url: $issue.html_url,
        body_verified: false,
        linked: false
      }]' \
      "$LEDGER"
  )"
  atomic_write "$LEDGER" "$updated"
}

create_verify_link() {
  local subsection="$1" title="$2" relative_body="$3"
  local body_file="$LOG/$relative_body" created issue_number issue_id issue_json attempt linked=false

  CURRENT_OPERATION="creating $subsection"
  created="$(
    gh api "repos/$REPO/issues" \
      -X POST \
      -f title="$title" \
      -F "body=@$body_file" \
      --jq '{id,number,node_id,html_url,title}'
  )"
  append_ledger_entry "$subsection" "$relative_body" "$created"
  issue_number="$(jq -r '.number' <<<"$created")"
  issue_id="$(jq -r '.id' <<<"$created")"

  CURRENT_OPERATION="verifying body for issue #$issue_number"
  issue_json="$(
    "$BODY_VERIFIER" \
      "$REPO" \
      "$issue_number" \
      "$body_file" \
      6 \
      5 \
      "$LOG/issue-$issue_number-body-verification-failure.json"
  )"
  jq -e --argjson number "$issue_number" \
    '.number == $number and .state == "open" and (.assignees | length == 0)' \
    <<<"$issue_json" >/dev/null
  update_ledger_flag "$issue_number" body_verified true

  CURRENT_OPERATION="linking issue #$issue_number to parent #$PARENT_ISSUE"
  for attempt in 1 2 3; do
    if printf '{"sub_issue_id": %s}' "$issue_id" |
      gh api "repos/$REPO/issues/$PARENT_ISSUE/sub_issues" -X POST --input - >/dev/null; then
      linked=true
      break
    fi
    sleep 2
  done
  [[ "$linked" == true ]] || return 1
  update_ledger_flag "$issue_number" linked true
}

CURRENT_OPERATION='capturing pre-creation children'
atomic_write "$PRE_CHILDREN" "$(fetch_normalized_children)"
atomic_write "$LEDGER" '[]'
atomic_write "$RESULT" '{
  "schemaVersion": 1,
  "status": "in_progress",
  "ledgerFile": "creation-ledger.json",
  "operationError": null
}'

create_verify_link \
  '4.1 — Issue 1: Add the application-layer deadline change operation' \
  '4.1 — Add the application-layer deadline change operation' \
  'issue-bodies/01-4-1-body.md'
create_verify_link \
  '4.2 — Issue 2: Expose deadline changes through the booking facade' \
  '4.2 — Expose deadline changes through the booking facade' \
  'issue-bodies/02-4-2-body.md'
create_verify_link \
  '4.3 — Issue 3: Implement the deadline editor backing model' \
  '4.3 — Implement the deadline editor backing model' \
  'issue-bodies/03-4-3-body.md'
create_verify_link \
  '4.4 — Issue 4: Implement the PrimeFaces deadline dialog' \
  '4.4 — Implement the PrimeFaces deadline dialog' \
  'issue-bodies/04-4-4-body.md'
create_verify_link \
  '4.5 — Issue 5: Integrate deadline editing into the Administration dashboard' \
  '4.5 — Integrate deadline editing into the Administration dashboard' \
  'issue-bodies/05-4-5-body.md'

CURRENT_OPERATION='capturing final children'
atomic_write "$FINAL_CHILDREN" "$(fetch_normalized_children)"

CURRENT_OPERATION='verifying child links and order'
"$CHILD_LINK_VERIFIER" "$PRE_CHILDREN" "$FINAL_CHILDREN" "$LEDGER"

CURRENT_OPERATION='verifying final issue postconditions'
while IFS=$'\t' read -r issue_number relative_body; do
  issue_json="$(
    "$BODY_VERIFIER" \
      "$REPO" \
      "$issue_number" \
      "$LOG/$relative_body" \
      6 \
      5 \
      "$LOG/issue-$issue_number-final-body-verification-failure.json"
  )"
  jq -e --argjson number "$issue_number" \
    '.number == $number and .state == "open" and (.assignees | length == 0)' \
    <<<"$issue_json" >/dev/null
done < <(jq -r '.[] | [.number, .bodyFile] | @tsv' "$LEDGER")

CURRENT_OPERATION='writing successful stage result'
atomic_write "$RESULT" '{
  "schemaVersion": 1,
  "status": "complete",
  "ledgerFile": "creation-ledger.json",
  "operationError": null
}'

trap - ERR
jq -e \
  '.status == "complete" and .operationError == null and .ledgerFile == "creation-ledger.json"' \
  "$RESULT" >/dev/null
jq -e \
  'length == 5 and all(.[]; .body_verified == true and .linked == true)' \
  "$LEDGER" >/dev/null
jq -r '.[] | [.implementationSubsection, .number, .title, .url] | @tsv' "$LEDGER"
