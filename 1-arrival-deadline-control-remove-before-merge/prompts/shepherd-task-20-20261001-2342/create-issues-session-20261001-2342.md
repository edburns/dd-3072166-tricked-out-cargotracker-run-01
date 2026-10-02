# Copilot CLI Session

> [!NOTE]
> - **Session ID:** `ce736d12-784f-4899-8cd5-8375f83af814`  
> - **Started:** 10/1/2026, 11:42:14 PM  
> - **Duration:** 2m 26s  
> - **Exported:** 10/1/2026, 11:44:41 PM  

---

<sub>4s</sub>

### User

Invoke skill `shepherd-task-20-create-issues-from-plan` with these inputs:

- CAMPAIGN_ID: 4583b192-2c95-45de-a888-34bed4d26fdf
- LESSON_PROPAGATION: off
- REPO: edburns/dd-3072166-tricked-out-cargotracker-run-01
- BASE_BRANCH: edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control
- PARENT_ISSUE: 1
- PLAN_DIRECTORY: 1-arrival-deadline-control-remove-before-merge
- PLAN_FILE_NAME: add-change-arrival-deadline-feature-ignorance-reduction-plan.md
- QUESTIONS_SECTION: ## Phase 3 — Ignorance reduction: questions to answer before writing code
- IMPLEMENTATION_SECTION: ## Phase 4 — Implementation (five serial issues)
- EXPECTED_TASK_COUNT: 5
- BASE_REMOTE: origin
- LOG_DIRECTORY: /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342
- DRAFT_VALIDATOR: /home/edburns/.copilot/plugins/shepherd-task/scripts/validate-stage20-drafts.sh
- ISSUE_BODY_VERIFIER: /home/edburns/.copilot/plugins/shepherd-task/scripts/verify-github-issue-body.sh
- CHILD_LINK_VERIFIER: /home/edburns/.copilot/plugins/shepherd-task/scripts/verify-stage20-child-links.sh

Fixture pagination response contract (mandatory):

- `gh api ... --paginate --slurp` returns a JSON array of page payloads, so a
  one-page response has the shape `[[{...}]]`, not `[{...}]`.
- Before indexing child issue fields such as `.id`, normalize the response to
  one flat issue array exactly once.
- In Bash, use:
  `jq 'if length == 0 then [] elif all(.[]; type == "array") then add else . end'`.
- In PowerShell, capture the `gh` output and `$LASTEXITCODE` first, then pass
  the complete JSON through the same `jq` normalization before
  `ConvertFrom-Json`.
- Use the normalized flat array for the pre-creation baseline, final child
  count/order checks, and failure reconciliation. Do not apply `add` a second
  time to an already-flat array.

---

<sub>7s</sub>

### `skill`

**shepherd-task-20-create-issues-from-plan**

<details>
<summary>Arguments</summary>

```json
{
  "skill": "shepherd-task-20-create-issues-from-plan"
}
```

</details>

```
Skill "shepherd-task-20-create-issues-from-plan" loaded successfully. Follow the instructions in the skill context.
```


---

<sub>10s</sub>

### Copilot

I’m validating the campaign inputs, branch state, plan structure, scripts, and issue-type support before any GitHub mutation.

---

<sub>19s</sub>

### `bash`

**Validate local inputs and branch**

$ set -euo pipefail
LOG='/home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342'
mkdir -p "$LOG/issue-bodies"
test -d "$LOG" && test -w "$LOG"
test -x '/home/edburns/.copilot/plugins/shepherd-task/scripts/validate-stage20-drafts.sh'
test -x '/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-github-issue-body.sh'
test -x '/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-stage20-child-links.sh'
printf 'log_and_scripts_ok\n'
git remote -v
git branch --list 'edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control'
git ls-remote --heads origin 'edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control'
git status --short

<details>
<summary>9 lines</summary>

```
log_and_scripts_ok
origin	git@github.com:edburns/dd-3072166-tricked-out-cargotracker-run-01.git (fetch)
origin	git@github.com:edburns/dd-3072166-tricked-out-cargotracker-run-01.git (push)
* edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control
675d8c332a0b0ac99af8f02f6e454e81b4bebb2f	refs/heads/edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control
?? 1-arrival-deadline-control-remove-before-merge/.stage20-after.3660314
?? 1-arrival-deadline-control-remove-before-merge/.stage20-before.3660314
?? 1-arrival-deadline-control-remove-before-merge/prompts/
<shellId: 3 completed with exit code 0>
```

</details>


---

<sub>19s</sub>

### `bash`

**Validate GitHub repository inputs**

$ set -euo pipefail
REPO='edburns/dd-3072166-tricked-out-cargotracker-run-01'
BASE='edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control'
gh api "repos/$REPO" --jq '{default_branch,owner:{login:.owner.login,type:.owner.type}}'
gh api "repos/$REPO/branches/$BASE" --jq '{name,sha:.commit.sha}'
gh api "repos/$REPO/issues/1" --jq '{number,state,title,repository_url}'

```
{"default_branch":"edburns/dd-3016202-cargotracker-devoxx-be-2026-experiment","owner":{"login":"edburns","type":"User"}}
{"name":"edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control","sha":"675d8c332a0b0ac99af8f02f6e454e81b4bebb2f"}
{"number":1,"repository_url":"https://api.github.com/repos/edburns/dd-3072166-tricked-out-cargotracker-run-01","state":"open","title":"[Campaign][off] Cargo Tracker arrival-deadline control"}
<shellId: 0 completed with exit code 0>
```


---

<sub>19s</sub>

### `bash`

**Fetch normalized existing children**

$ set -euo pipefail
REPO='edburns/dd-3072166-tricked-out-cargotracker-run-01'
raw="$(gh api "repos/$REPO/issues/1/sub_issues" --paginate --slurp)"
printf '%s' "$raw" | jq 'if length == 0 then [] elif all(.[]; type == "array") then add else . end'

```
[]
<shellId: 2 completed with exit code 0>
```


---

<sub>19s</sub>

### `bash`

**Read plan and campaign manifest**

$ set -euo pipefail
BASE='edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control'
DIR='1-arrival-deadline-control-remove-before-merge'
git show "$BASE:$DIR/add-change-arrival-deadline-feature-ignorance-reduction-plan.md"
printf '\n---CAMPAIGN---\n'
git show "$BASE:$DIR/shepherd-campaign.json"
printf '\n---LESSONS EXISTS---\n'
git cat-file -e "$BASE:$DIR/campaign-lessons.md" && echo yes

<details>
<summary>12 lines</summary>

```
Output too large to read at once (34.4 KB). Saved to: /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt
Consider using tools like rg (for searching), head/tail (for viewing start/end), view with view_range (for specific sections), or jq (for JSON) to examine portions of the output.

Preview (first 500 chars):
# Implementation plan: Change Arrival Deadline Date (`eclipse-ee4j/cargotracker#64`)

Human DRI: Ed Burns
Starting commit: `eac2f312760dc7d5b47bea75989294559c024cdc` (`Make the system ready for implementation`)
Working directory: repository root of the current campaign worktree
Cargo Tracker Maven application: `demo/`
Runtime baseline: Java 17, Java EE 7 (`javax.*`), Open Liberty 26.0.0.8, PrimeFaces 8.0
Baseline run instructions: `demo/README.md`
Baseline preparation: fixed source branch and im
<shellId: 1 completed with exit code 0>
```

</details>


---

<sub>19s</sub>

### `view`

**view the file at /home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/01-1682-java-tool-ergonomics.md.**

/home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/01-1682-java-tool-ergonomics.md (lines 1-220)

<details>
<summary>15 lines</summary>

```
# Example 01: 1682-java-tool-ergonomics-prompts-remove-before-merge

Read `copilot-sdk/1682-java-tool-ergonomics-prompts-remove-before-merge/dd-3018003-ignorance-reduction-for-implementation-plan.md` (the plan) to get the context.

✅✅Pay very close attention to each **Resolution:** to the questions in `Phase 3 — Ignorance reduction: questions to answer before writing code`.

In this session, we are creating issues of type **Task** as children of Epic https://github.com/github/copilot-sdk/issues/1682 . These issues correspond to the sub-sections in `## Phase 4 — Implementation (the build order)`.

I want you to use `gh` to create issues as sub-issues of 1682.

- I will dispatch these issues by assigning them to an agent. Leave them unassigned for now.

- The description you put in the issues you create is the specification for the work the agent assigned to the issue must do. Therefore, you need to be very specific and targeted when writing the description.

- Set the type to **Task**.

- Each issue will be worked on and resolved in serial. You can assume:
  - All issues will operate in this topic branch of `upstream`: `edburns/1682-java-tool-ergonomics`.

  - The assignee agent has access to the topic branch and, most importantly, to the prompts in the directory `1682-java-tool-ergonomics-prompts-remove-before-merge`, which includes the plan. Therefore, you can instruct the agent to access the plan by reference, you don't need to reference it by value directly in the issue.

- The sub-sections of `## Phase 4 — Implementation (the build order)` have essential details for each corresponding **Task**.

- Instruct the agent to read the entire plan before working.

- Instruct the agent to carefully re-read the relevant sections of the plan. ❌❌You can't just say, "read the relevant sections of the plan". ✅✅In the description of the issue, list exactly what sections of the plan apply to this particular issue.
- Though the sub-sections of `## Phase 4 — Implementation (the build order)` have essential details for each corresponding **Task**, I want you to carefully consider if there are additional gating tests you can add so that as the agent proceeds from one task to the next, the likelihood of rework is reduced.
```

</details>


---

<sub>19s</sub>

### `view`

**view the file at /home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/02-1810-java-tool-as-lambda.md.**

/home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/02-1810-java-tool-as-lambda.md (lines 1-220)

<details>
<summary>12 lines</summary>

```
# Example 02: 1810-java-tool-ergonomics-tool-as-lambda-remove-before-merge

Carefully read the plan `copilot-sdk/1810-java-tool-ergonomics-tool-as-lambda-remove-before-merge/1810-ignorance-reduction-for-implementation-plan.md`.

We have completed Phases 1 - 3. We are now on Phase 4.

For each sub item in Phase 4, file a child issue of Feature #1810.

Use `gh` to look at Epic #1682 and its child issues for the standard of verbosity and concreteness for issue descriptions.

The issue should be assignable to a coding agent and there must be sufficient detail in the description for the agent to proceed to completion.

Pull out the specific relevant content from Phase 3 as it applies to this current issue in Phase 4.

Tell the agent to take `edburns/1810-java-tool-ergonomics-tool-as-lambda` as the base branch. When I assign the issue to the coding agent, I will set this as the base branch.

Tell the agent to read `1810-java-tool-ergonomics-tool-as-lambda-remove-before-merge/1810-ignorance-reduction-for-implementation-plan.md`, which is present on the branch, for context.

Tell the agent which sub-item within Phase 4 they are solving.

Tell the agent that each issue will be assigned, resolved and merged to the base branch in the order in which they appear in the plan.

No work is to start until I assign each issue to the coding agent, in turn.
```

</details>


---

<sub>19s</sub>

### `view`

**view the file at /home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/03-dd-3017826-java-real-estate-demo.md.**

/home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/03-dd-3017826-java-real-estate-demo.md (lines 1-240)

<details>
<summary>14 lines</summary>

```
# Example 03: dd-3017826-java-real-estate-demo-remove-before-merge

Read `dd-3017826-java-real-estate-demo-remove-before-merge\dd-3017826-java-real-estate-demo-ignorance-reduction-plan.md` (the plan) to get the context.

✅✅Pay very close attention to each **Resolution:** to the questions in `Phase 2 — Ignorance reduction: questions to answer before writing code`.

In this session, we are creating sub-issues as children of https://github.com/edburns/Build26-BRK206-your-agent-anywhere-multiclient-multidevice-with-github-copilot-sdk/issues/2 . These issues correspond to the sub-sections in `## Phase 3 — Implementation (build order)`.

I want you to use `gh` to create issues as sub-issues of #2.

- I will dispatch these issues by assigning them to an agent. Leave them unassigned for now.

- The description you put in the issues you create is the specification for the work the agent assigned to the issue must do. Therefore, you need to be very specific and targeted when writing the description.

- Each issue will be worked on and resolved in serial. You can assume:
  - All issues will operate in this topic branch of `origin`: `edburns/2-build-out-demo`.

  - The assignee agent has access to the topic branch and, most importantly, to the prompts in the directory `dd-3017826-java-real-estate-demo-remove-before-merge`, which includes the plan. Therefore, you can instruct the agent to access the plan by reference, you don't need to reference it by value directly in the issue.

- The sub-sections of `## Phase 3 — Implementation (build order)` have essential details for each corresponding sub-issue.

- Instruct the agent to read the entire plan before working.

- Instruct the agent to carefully re-read the relevant sections of the plan. ❌❌You can't just say, "read the relevant sections of the plan". ✅✅In the description of the issue, list exactly what sections of the plan apply to this particular issue.
- Though the sub-sections of `## Phase 3 — Implementation (build order)` have essential details for each corresponding sub-issue, I want you to carefully consider if there are additional gating tests you can add so that as the agent proceeds from one task to the next, the likelihood of rework is reduced.
```

</details>


---

<sub>19s</sub>

### `view`

**view the file at /home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/04-28-python-agent-demo.md.**

/home/edburns/.copilot/skills/shepherd-task-20-create-issues-from-plan/examples/04-28-python-agent-demo.md (lines 1-220)

<details>
<summary>16 lines</summary>

```
# Example 04: 28-python-agent-demo-remove-before-merge

Read `28-python-agent-demo-remove-before-merge/28-python-agent-demo-ignorance-reduction-plan.md` (the plan) to get the context.

✅✅Pay very close attention to each **Resolution:** to the questions in `Phase 2 — Ignorance reduction: questions to answer before writing code`. These pertain to the implementation tasks in Phase 3. ✅✅✅ Include relevant spike findings as self-contained prose in the issue description; do not direct the agent to spike directories or source files.

In this session, we are creating sub-issues as children of https://github.com/edburns/Build26-BRK206-your-agent-anywhere-multiclient-multidevice-with-github-copilot-sdk/issues/28 . These issues correspond to the sub-sections in `## Phase 3 — Implementation (build order)`.

I want you to use `gh` to create issues as sub-issues of #28

- I will dispatch these issues by assigning them to an agent. Leave them unassigned for now.

- The description you put in the issues you create is the specification for the work the agent assigned to the issue must do. Therefore, you need to be very specific and targeted when writing the description.

- Again, ✅✅For each **Resolution:** to the questions in `Phase 2 — Ignorance reduction: questions to answer before writing code`, include the relevant Resolution values in the issue description. These pertain to the implementation tasks in Phase 3. ✅✅✅ State relevant spike findings directly in the issue body with enough detail to implement them without reading spike code.

- For tasks dealing with the UI, make sure to refer to the relevant screengrabs, but only ones within `28-python-agent-demo-remove-before-merge/`.

- Each issue will be worked on and resolved in serial. You can assume:
  - All issues will operate in this topic branch of `origin`: `edburns/28-python-agent-demo`.

  - The assignee agent has access to the topic branch and, most importantly, to the prompts in the directory `28-python-agent-demo-remove-before-merge/`, which includes the plan. Therefore, you can instruct the agent to access the plan by reference, you don't need to reference it by value directly in the issue.

- The sub-sections of `## Phase 3 — Implementation (build order)` have essential details for each corresponding sub-issue.

- Instruct the agent to read the entire plan before working.

- Instruct the agent to carefully re-read the relevant sections of the plan. ❌❌You can't just say, "read the relevant sections of the plan". ✅✅In the description of the issue, list exactly what sections of the plan apply to this particular issue.
- Though the sub-sections of `## Phase 3 — Implementation (build order)` have essential details for each corresponding sub-issue, I want you to carefully consider if there are additional gating tests you can add so that as the agent proceeds from one task to the next, the likelihood of rework is reduced.
```

</details>


---

<sub>19s</sub>

### `view`

**view the file at /home/edburns/.copilot/plugins/shepherd-task/scripts/validate-stage20-drafts.sh.**

/home/edburns/.copilot/plugins/shepherd-task/scripts/validate-stage20-drafts.sh (lines 1-260)

<details>
<summary>65 lines</summary>

```
#!/usr/bin/env bash
# shepherd-task-version: 1.0.4

set -euo pipefail

[[ $# -eq 3 ]] || {
    echo "Usage: $0 <body-directory> <expected-count> <off|campaign>" >&2
    exit 1
}

body_directory="$1"
expected_count="$2"
lesson_propagation="$3"

[[ -d "$body_directory" ]] || {
    echo "Stage-20 body directory does not exist: $body_directory" >&2
    exit 1
}
[[ "$expected_count" =~ ^[1-9][0-9]*$ ]] || {
    echo "Expected count must be a positive integer." >&2
    exit 1
}
[[ "$lesson_propagation" == "off" || "$lesson_propagation" == "campaign" ]] || {
    echo "Lesson propagation must be off or campaign." >&2
    exit 1
}

body_files=()
for body_file in "$body_directory"/*-body.md; do
    [[ -f "$body_file" ]] || continue
    [[ "$body_file" != *-observed-body.md ]] || continue
    body_files+=("$body_file")
done
[[ ${#body_files[@]} -eq $expected_count ]] || {
    echo "Expected $expected_count persisted stage-20 body files; found ${#body_files[@]}." >&2
    exit 1
}

required_headings=(
    '## Campaign context and required reading'
    '## Branch and execution order'
    '## Implement'
    '## Completion gates'
    '## Out of scope'
)

for body_file in "${body_files[@]}"; do
    [[ -s "$body_file" && "$(awk 'END { print NR }' "$body_file")" -gt 1 ]] || {
        echo "Persisted issue body must contain physical Markdown lines: $body_file" >&2
        exit 1
    }
    first_nonblank="$(awk 'NF { print; exit }' "$body_file")"
    [[ "$first_nonblank" =~ ^##[[:space:]]+[^[:space:]] ]] || {
        echo "Persisted issue body must begin with a level-two heading: $body_file" >&2
        exit 1
    }
    for heading in "${required_headings[@]}"; do
        grep -Fqx -- "$heading" "$body_file" || {
            echo "Persisted issue body is missing the physical heading '$heading': $body_file" >&2
            exit 1
        }
    done
    if [[ "$lesson_propagation" == "campaign" ]]; then
        grep -Fqx -- '## Campaign lessons (REQUIRED)' "$body_file" || {
            echo "Treatment issue body is missing its campaign-lessons heading: $body_file" >&2
            exit 1
        }
    elif grep -Fqx -- '## Campaign lessons (REQUIRED)' "$body_file"; then
        echo "Control issue body unexpectedly contains a campaign-lessons heading: $body_file" >&2
        exit 1
    fi
done
```

</details>


---

<sub>19s</sub>

### `view`

**view the file at /home/edburns/.copilot/plugins/shepherd-task/scripts/verify-stage20-child-links.sh.**

/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-stage20-child-links.sh (lines 1-260)

<details>
<summary>30 lines</summary>

```
#!/usr/bin/env bash
# shepherd-task-version: 1.0.4

set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <PRE_CREATION_CHILDREN_JSON> <FINAL_CHILDREN_JSON> <CREATION_LEDGER_JSON>" >&2
    exit 2
fi

for command_name in jq; do
    command -v "$command_name" >/dev/null 2>&1 || {
        echo "Error: Required command '$command_name' was not found." >&2
        exit 1
    }
done

script_dir="$(cd "$(dirname "$0")" && pwd)"
filter_path="$script_dir/verify-stage20-child-links.jq"
[[ -f "$filter_path" ]] || {
    echo "Error: Stage-20 child-link verification filter was not found: $filter_path" >&2
    exit 1
}

for input_path in "$@"; do
    [[ -f "$input_path" ]] || {
        echo "Error: Stage-20 child-link verification input was not found: $input_path" >&2
        exit 1
    }
done

jq -n \
    --slurpfile baseline "$1" \
    --slurpfile final "$2" \
    --slurpfile ledger "$3" \
    -f "$filter_path"
```

</details>


---

<sub>22s</sub>

### Copilot

Validation passed: the topic branch exists, differs from the default branch, parent #1 is open, the owner is a user (so issues will be untyped), and there are no existing children. I’m now extracting the five task specifications and every resolved constraint before drafting.

---

<sub>24s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 1-220)

<details>
<summary>171 lines</summary>

````
# Implementation plan: Change Arrival Deadline Date (`eclipse-ee4j/cargotracker#64`)

Human DRI: Ed Burns
Starting commit: `eac2f312760dc7d5b47bea75989294559c024cdc` (`Make the system ready for implementation`)
Working directory: repository root of the current campaign worktree
Cargo Tracker Maven application: `demo/`
Runtime baseline: Java 17, Java EE 7 (`javax.*`), Open Liberty 26.0.0.8, PrimeFaces 8.0
Baseline run instructions: `demo/README.md`
Baseline preparation: fixed source branch and immutable SHA validated by the campaign fixture
Historical issue: `eclipse-ee4j/cargotracker#64`

Related directories and files:

- `demo/src/main/java/org/eclipse/cargotracker/application/`
- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/`
- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/`
- `demo/src/main/webapp/admin/dialogs/`
- `demo/src/main/webapp/admin/tables/listNotRouted.xhtml`
- `demo/src/test/java/org/eclipse/cargotracker/application/BookingServiceTest.java`

---

## Goal

Add an Administration dashboard operation that lets a shipping administrator
change the arrival deadline of a cargo listed in the **Not Routed Cargo** table.
The operation must preserve Cargo Tracker's layered architecture:

1. The application service owns the domain mutation.
2. The booking facade shields the web layer from domain types.
3. A JSF backing bean loads and submits the editable date.
4. A PrimeFaces dynamic dialog presents the editor.
5. The existing Not Routed Cargo table opens the dialog and refreshes after a
   successful update.

### User-visible acceptance behavior

Using the stable sample cargo `DEF789`:

1. Start the application with Java 17:

   ```bash
   cd demo && ./mvnw clean package -Popenliberty liberty:run
   ```

2. Open `http://localhost:8080/cargo-tracker/`.
3. Select **Administration**.
4. Find `DEF789` in the **Not Routed Cargo** table.
5. The Deadline cell displays its date together with an edit icon.
6. Hovering over the deadline displays:
   `Click to change cargo arrival deadline date.`
7. Selecting the deadline opens a modal dialog titled **Change Deadline**.
8. The dialog displays the cargo's origin and destination as read-only
   context.
9. The date editor is initialized to the cargo's current arrival deadline.
10. Selecting a different date and pressing **Update** closes the dialog and
    refreshes the Administration view.
11. The new date is shown in the Not Routed Cargo table.
12. Reloading the page continues to show the new date for the lifetime of the
    running in-memory sample application.
13. Pressing **Cancel** closes the dialog without changing the deadline.

### Domain acceptance behavior

Changing the deadline must:

- locate the cargo by `TrackingId`;
- preserve its existing origin;
- preserve its existing destination;
- replace only the arrival deadline in its `RouteSpecification`;
- apply the specification through `Cargo.specifyNewRoute(...)`;
- preserve the currently assigned itinerary rather than silently discarding
  it;
- allow the domain model to recalculate routing status and delivery-derived
  values against the new route specification;
- persist the changed cargo through `CargoRepository.store(...)`.

### Hard scope constraints

- Begin from commit `eac2f312760dc7d5b47bea75989294559c024cdc`.
- Preserve Java EE 7 and the `javax.*` namespace.
- Preserve the Java 7 source/target level used by this historical codebase.
- Run the application on JDK 17 using the existing Open Liberty profile.
- Do not migrate the application to Jakarta EE 8+, Jakarta EE 9+, Spring, or a
  different UI framework.
- Do not replace the in-memory Derby configuration or the Open Liberty runtime.
- Do not redesign unrelated cargo booking, routing, destination editing,
  messaging, batch, REST, or persistence behavior.
- Do not copy commits or files from feature-bearing branches. This plan is the
  implementation specification.
- Implement the five build issues below in order. Each issue must be complete
  and gated before the next issue begins.

---

## Completed phases

### Phase 1 ✅ — Establish a runnable feature-absent baseline

- Commit `eac2f312760dc7d5b47bea75989294559c024cdc` is based on the historical
  feature-absent commit and contains only the compatibility work needed to run
  the sample on JDK 17 and Open Liberty.
- `cd demo && ./mvnw clean package -Popenliberty liberty:run` starts the application.
- The home page and Administration flows return HTTP 200.
- JSF view metadata is placed at `UIViewRoot` scope for MyFaces compatibility.
- The internal routing REST client works without a Jersey/MOXy classloading
  conflict.
- The scheduled batch job has the local authorization it needs.

### Phase 2 ✅ — Verify the before and after user experience

- Before implementation, `DEF789` appears in the Not Routed Cargo table with a
  plain-text deadline and no edit operation.
- The neighboring Destination column demonstrates the existing PrimeFaces
  dynamic-dialog interaction pattern.
- The desired after behavior has been manually exercised: open the deadline
  editor, choose a new date, update, refresh the table, and observe the
  persisted value.
- The historical architectural boundaries and affected files have been
  identified.

---

## Phase 3 — Ignorance reduction: questions to answer before writing code

Resolve these questions before production implementation begins. The
recommendations intentionally define the desired design closely enough that an
implementing agent should not need to invent a different architecture.

### 3.1 — Which cargos expose the edit operation?

**Question:** Should deadline editing be exposed for all cargos or only for
cargos displayed in the Not Routed Cargo table?

The requested feature originates in the Administration dashboard's Not Routed
Cargo table. Other tables represent routed, misrouted, claimed, or otherwise
progressed cargo. Adding the affordance to every table would expand the feature
and require additional business rules about changing deadlines after handling
has begun.

| Option | UI scope | Trade-off |
|--------|----------|-----------|
| A | Not Routed Cargo table only | Matches the requested feature and the established destination-edit affordance. |
| B | Every Administration cargo table | Broader capability, but introduces lifecycle and authorization questions outside the request. |
| C | Cargo details page only | Avoids table complexity but does not meet the requested dashboard interaction. |

The application-service operation itself does not need to encode a UI-table
restriction. It should accept a tracking ID and apply the domain mutation to
the located cargo. The presentation layer determines where the operation is
offered.

**Recommendation:** Option A. Add the edit affordance only to
`demo/src/main/webapp/admin/tables/listNotRouted.xhtml`. Keep the application
operation generally usable for a valid cargo.

**Resolution:**

Select Option A. Expose the edit affordance only in
`demo/src/main/webapp/admin/tables/listNotRouted.xhtml`. The application and facade
operations remain generally callable for any cargo that can be found by
tracking ID; they do not encode knowledge of dashboard table membership.

### 3.2 — What is the exact domain mutation?

**Question:** Should the feature mutate the existing `RouteSpecification`, add
a setter to `Cargo`, or replace the specification using the existing domain
operation?

`RouteSpecification` is a value object describing origin, destination, and
arrival deadline. The existing `changeDestination(...)` implementation already
establishes the correct pattern: create a replacement specification, call
`Cargo.specifyNewRoute(...)`, and store the aggregate.

Proposed application-service shape:

```java
void changeDeadline(TrackingId trackingId, Date deadline);
```

Proposed implementation:

```java
Cargo cargo = cargoRepository.find(trackingId);
RouteSpecification specification = new RouteSpecification(
        cargo.getOrigin(),
        cargo.getRouteSpecification().getDestination(),
        deadline);

cargo.specifyNewRoute(specification);
cargoRepository.store(cargo);
```

Calling `specifyNewRoute(...)` is significant. It lets the aggregate recalculate
delivery and routing status relative to the new specification. Direct field
mutation or a persistence-only update would bypass that behavior.

**Recommendation:** Replace the `RouteSpecification` through
`Cargo.specifyNewRoute(...)`. Preserve origin, destination, and itinerary.
Persist using the existing repository. Do not add a deadline setter to the
domain model.

**Resolution:**

Use the same aggregate-update pattern as `changeDestination(...)`. Add
`BookingService.changeDeadline(TrackingId, Date)` and implement it by loading
the cargo, constructing a new `RouteSpecification` from the existing origin,
existing destination, and supplied deadline, calling
`cargo.specifyNewRoute(...)`, and storing the cargo through
`cargoRepository.store(...)`. Do not add mutable deadline setters to the domain
objects.

### 3.3 — What should happen to an existing itinerary and delivery state?

**Question:** When a routed cargo's deadline changes, should its itinerary be
cleared, retained, or recomputed?

Although the UI initially exposes the feature only for unrouted cargo, the
application operation should have deterministic domain behavior if invoked for
a routed cargo. The existing `changeDestination(...)` behavior preserves the
assigned itinerary and lets `Cargo.specifyNewRoute(...)` recalculate whether
````

</details>


---

<sub>24s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 221-440)

<details>
<summary>162 lines</summary>

````
that itinerary still satisfies the new specification.

The core application test should deliberately invoke the operation after:

1. booking a cargo;
2. requesting route candidates;
3. assigning an itinerary;
4. changing its destination;
5. changing its deadline.

This sequence verifies that the feature uses the aggregate correctly rather
than assuming the cargo always has an empty itinerary.

**Recommendation:** Preserve the itinerary. Let the domain model recompute
routing and delivery-derived state. Assert all unaffected fields explicitly in
`BookingServiceTest`.

**Resolution:**

Retain the existing itinerary. Do not clear, replace, or reroute it as part of
the deadline change. `Cargo.specifyNewRoute(...)` recalculates the delivery
snapshot and routing status against the replacement specification. In the
established sequential application test, the assigned itinerary remains
unchanged and the cargo remains `MISROUTED` after the deadline changes.

### 3.4 — What type crosses the facade boundary?

**Question:** Should the booking facade accept a `Date`, a formatted string, or
a newly introduced request DTO?

The existing facade already uses `java.util.Date` for
`bookNewCargo(...)`. Introducing another representation for this one operation
would create unnecessary conversion code and depart from the historical
application style.

Proposed facade shape:

```java
void changeDeadline(String trackingId, Date arrivalDeadline);
```

The implementation converts only the identifier:

```java
bookingService.changeDeadline(
        new TrackingId(trackingId),
        arrivalDeadline);
```

**Recommendation:** Use `String` for the tracking ID and `java.util.Date` for
the deadline. Do not expose `TrackingId`, `Cargo`, or `RouteSpecification` to
the JSF layer and do not introduce a new DTO solely for this command.

**Resolution:**

Add `void changeDeadline(String trackingId, Date arrivalDeadline)` to
`BookingServiceFacade`. `DefaultBookingServiceFacade` converts the string to
`new TrackingId(trackingId)` and passes the same `Date` to
`BookingService.changeDeadline(...)`. No new command DTO or formatted-string
service parameter is introduced.

### 3.5 — How is the DTO's formatted deadline converted for editing?

**Question:** `CargoRoute` exposes its deadline as formatted strings, while
`p:datePicker` binds naturally to `java.util.Date`. How should the backing bean
initialize the editor?

At the starting commit:

- `CargoRoute.getArrivalDeadline()` returns
  `MM/dd/yyyy hh:mm a z`.
- `CargoRoute.getArrivalDeadlineDate()` returns only the date component.
- The table displays `getArrivalDeadlineDate()`.

Options:

| Option | Approach | Trade-off |
|--------|----------|-----------|
| A | Parse `cargo.getArrivalDeadlineDate()` with `MM/dd/yyyy` | Small, localized change; preserves the existing DTO contract. |
| B | Add a `Date` property to `CargoRoute` | Cleaner typing, but broadens a DTO used throughout the application. |
| C | Reload the domain object in the backing bean | Violates the facade boundary. |

The formatter/parser must be created per operation or per view bean; do not add
a shared mutable `SimpleDateFormat`.

**Recommendation:** Option A. Load `CargoRoute` through
`BookingServiceFacade.loadCargoForRouting(trackingId)` and parse
`cargo.getArrivalDeadlineDate()` using `new SimpleDateFormat("MM/dd/yyyy")`.
Surface an explicit failure if the existing DTO value cannot be parsed; do not
silently submit a null date.

**Resolution:**

Use Option A and keep date conversion inside the view-scoped editor bean. The
existing implementation loads the `CargoRoute`, creates
`new SimpleDateFormat("MM/dd/yyyy")`, and parses the leading date portion of
`cargo.getArrivalDeadline()`. Because that value begins with `MM/dd/yyyy`,
`SimpleDateFormat.parse(...)` obtains the same date that
`getArrivalDeadlineDate()` displays. A per-load formatter is used, so no shared
mutable formatter is added.

### 3.6 — Which JSF bean scopes and interaction pattern should be used?

**Question:** Should deadline editing introduce a new navigation page, use an
inline editor, or mirror the existing Change Destination dynamic-dialog
pattern?

The baseline already contains:

- `ChangeDestination`, a CDI `@Named` and JSF `@ViewScoped` editor bean;
- `ChangeDestinationDialog`, a session-scoped JSF managed bean that opens and
  closes a PrimeFaces dynamic dialog;
- `changeDestination.xhtml`, a dialog view;
- a `dialogReturn` Ajax listener that refreshes `tableNotRouted`.

Using the same pattern minimizes changes and provides a consistent user
experience.

Proposed bean names:

```text
changeArrivalDeadlineDate
changeArrivalDeadlineDateDialog
```

**Recommendation:** Add a serializable CDI `@Named @ViewScoped`
`ChangeArrivalDeadlineDate` editor and a serializable
`@ManagedBean(name = "changeArrivalDeadlineDateDialog") @SessionScoped`
launcher. Mirror the existing destination-dialog lifecycle rather than
introducing a new navigation or inline-edit framework.

**Resolution:**

Mirror the existing Change Destination interaction. Implement
`ChangeArrivalDeadlineDate` as a serializable CDI `@Named @ViewScoped` bean and
`ChangeArrivalDeadlineDateDialog` as a serializable
`@ManagedBean(name = "changeArrivalDeadlineDateDialog") @SessionScoped` bean.
Use a PrimeFaces dynamic dialog rather than navigation to a full page or inline
cell editing.

### 3.7 — What is the dynamic-dialog contract?

**Question:** What path, request parameters, dimensions, and close result should
the PrimeFaces dialog use?

The launcher needs one parameter, `trackingId`, supplied as a
`Map<String, List<String>>`. The dialog metadata binds the parameter and invokes
the editor bean's `load()` action.

Proposed launcher contract:

```java
PrimeFaces.current().dialog().openDynamic(
        "/admin/dialogs/changeArrivalDeadlineDate.xhtml",
        options,
        params);
```

Required options:

| Option | Value |
|--------|-------|
| `modal` | `true` |
| `draggable` | `true` |
| `resizable` | `false` |
| `contentWidth` | `410` |
| `contentHeight` | `280` |

Required completion behavior:

- successful update: `closeDynamic("DONE")`;
- cancel: `closeDynamic("")`;
- caller listens for `dialogReturn` and updates `tableNotRouted`.

Because Open Liberty uses MyFaces, `<f:metadata>` must be a direct child of the
view root, before `<h:head>` and `<h:body>`. It must not be nested inside
`<h:body>`.

**Recommendation:** Use the contract above and preserve the metadata placement
required by the prepared baseline.

**Resolution:**

Open `/admin/dialogs/changeArrivalDeadlineDate.xhtml` with a single
`trackingId` request parameter and these options: modal and draggable are
`true`, resizable is `false`, content width is `410`, and content height is
`280`. Successful submission closes with `"DONE"`; cancellation closes with
the empty string. The caller handles `dialogReturn` and updates
`tableNotRouted`. Place the dialog's `<f:metadata>` directly under the root
`<html>` element, before `<h:head>` and `<h:body>`, so the known MyFaces
`UIViewRoot` requirement is satisfied.

### 3.8 — What date validation is required?

**Question:** Must the new deadline be non-null, in the future, after the
current date, or after itinerary completion?

The requested feature is an administrative correction to an existing arrival
deadline. No new domain policy about future dates is part of the request.
Inventing such a rule could reject dates accepted by existing cargo booking or
`RouteSpecification` behavior.

The UI must nevertheless prevent a null submission because the operation
requires a concrete replacement deadline.

**Recommendation:** Require a date value in the JSF form and display a normal
Faces validation message when it is absent. Do not add a new minimum-date,
future-date, or itinerary-date business rule. Continue to rely on the existing
domain model for its established invariants.

**Resolution:**

Require a non-null date selection, but add no new chronological business rule.
In particular, do not require the replacement deadline to be after today,
after the old deadline, or after every itinerary leg. Pass the selected
`java.util.Date` to the existing domain construction path and let the current
`RouteSpecification` invariants apply.

### 3.9 — How will the feature be tested on the prepared historical baseline?
````

</details>


---

<sub>24s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 441-700)

<details>
<summary>189 lines</summary>

````
**Question:** Which automated and runtime tests are mandatory, given that the
historical JUnit/Arquillian suite is configured for a remote Payara 4
container, while the prepared production baseline runs on JDK 17/Open Liberty?

The starting POM deliberately leaves `skipTests=true`. The Open Liberty profile
builds and compiles all test sources but does not provide a Liberty Arquillian
adapter. Modernizing the entire integration-test runtime is outside this
feature's scope.

The feature still needs layered evidence:

1. Extend `BookingServiceTest` with the domain/application assertions that
   specify the deadline mutation.
2. Ensure all test sources compile as part of
   `cd demo && ./mvnw clean package -Popenliberty`.
3. Add focused JUnit tests for facade and backing-bean delegation where they
   can run without a container, using hand-written fakes rather than adding a
   mocking framework.
4. Perform mandatory end-to-end verification against the running Open Liberty
   application.
5. Preserve the existing Payara Arquillian test path; do not delete, disable,
   or rewrite it to manufacture a passing result.

**Spike needed:** Before Issue 1 implementation, run the starting commit's
standard Open Liberty package command and record whether tests are compiled but
skipped. Confirm the new `BookingServiceTest` method can be added without
expanding the runtime modernization scope.

**Recommendation:** Treat the JDK 17/Open Liberty build plus HTTP/UI acceptance
as the mandatory executable gate. Keep the historical Arquillian test as a
precise application-layer specification and run it only when its documented
Payara environment is available.

**Resolution:**

Extend the existing sequential Arquillian `BookingServiceTest` with
`testChangeDeadline()` after `testChangeDestination()`. The test changes the
deadline by one month, reloads the cargo through JPA, and asserts the complete
set of preserved and recalculated domain state described above. The prepared
Open Liberty build compiles this test but retains the historical default
`skipTests=true`; executing that Arquillian suite still requires its documented
remote Payara environment. Therefore the mandatory executable gates are the
JDK 17 Open Liberty package/start command, direct HTTP checks, and the complete
`DEF789` browser acceptance flow. No Arquillian-runtime modernization or new
mocking dependency is part of this feature.

---

## Phase 4 — Implementation (five serial issues)

Implement these issues in order. Each issue should be a separate commit. Do not
start an issue until the previous issue's gating criteria are satisfied.

### 4.1 — Issue 1: Add the application-layer deadline change operation

**What to build**

Add the core use case to the application layer. This issue must contain no JSF
or PrimeFaces changes.

**Files to modify**

- `demo/src/main/java/org/eclipse/cargotracker/application/BookingService.java`
- `demo/src/main/java/org/eclipse/cargotracker/application/internal/DefaultBookingService.java`
- `demo/src/test/java/org/eclipse/cargotracker/application/BookingServiceTest.java`

**Required API**

```java
void changeDeadline(TrackingId trackingId, Date deadline);
```

**Required implementation behavior**

1. Load the cargo using `cargoRepository.find(trackingId)`.
2. Obtain the current destination from
   `cargo.getRouteSpecification().getDestination()`.
3. Construct a replacement `RouteSpecification` from:
   - `cargo.getOrigin()`;
   - the current destination;
   - the new deadline.
4. Apply it using `cargo.specifyNewRoute(routeSpecification)`.
5. Persist using `cargoRepository.store(cargo)`.
6. Log the tracking ID and new deadline at `Level.INFO`, following the style of
   `changeDestination(...)`.

Do not:

- add a setter to `Cargo` or `RouteSpecification`;
- modify the origin or destination;
- clear or replace the itinerary directly;
- update persistence entities behind the aggregate's back.

**Tests to write first**

Append a sequential `testChangeDeadline()` case to `BookingServiceTest` after
`testChangeDestination()`. Build a new deadline one month after the test's
original `deadline`, invoke the service, reload the cargo with
`Cargo.findByTrackingId`, and assert:

- origin remains Chicago;
- destination remains Helsinki;
- stored deadline is the same calendar day as the requested new deadline;
- assigned itinerary remains unchanged;
- transport status remains `NOT_RECEIVED`;
- last known location remains `Location.UNKNOWN`;
- current voyage remains `Voyage.NONE`;
- cargo is not marked misdirected;
- estimated time of arrival is `Delivery.ETA_UNKOWN`;
- next expected activity is `Delivery.NO_ACTIVITY`;
- cargo is not unloaded at destination;
- routing status reflects the domain model's recalculation and remains
  `MISROUTED` for the established test sequence.

**Gating criteria**

- The test source compiles.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.
- No web, facade, REST, Liberty, or persistence configuration files change in
  this issue.

### 4.2 — Issue 2: Expose deadline changes through the booking facade

**What to build**

Expose the use case to presentation clients without leaking domain identifier
types into the web layer.

**Files to modify**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/BookingServiceFacade.java`
- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacade.java`

**Optional focused test file**

- `demo/src/test/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacadeTest.java`

**Required API**

```java
void changeDeadline(String trackingId, Date arrivalDeadline);
```

**Required implementation**

```java
bookingService.changeDeadline(
        new TrackingId(trackingId),
        arrivalDeadline);
```

The facade must not:

- load and mutate `Cargo` itself;
- call `CargoRepository.store(...)`;
- parse a formatted date;
- introduce JSF or PrimeFaces types.

**Tests**

Where a container-free test is added, use a hand-written `BookingService` fake
or spy and prove that:

- the same `Date` object/value reaches the application service;
- the tracking-ID string is converted to an equivalent `TrackingId`;
- the facade delegates exactly once;
- no repository work is duplicated in the facade.

Do not add Mockito or another dependency solely for this test.

**Gating criteria**

- Existing facade consumers still compile.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.
- The application-layer test added in Issue 1 remains unchanged and compiling.

### 4.3 — Issue 3: Implement the deadline editor backing model

**What to build**

Add the view-scoped backing bean that loads a cargo's current deadline and
submits a replacement deadline through the booking facade. Do not add the
dialog launcher or XHTML in this issue.

**File to create**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDate.java`

**Required bean shape**

```java
@Named
@ViewScoped
public class ChangeArrivalDeadlineDate implements Serializable {
    private static final long serialVersionUID = 1L;

    private String trackingId;
    private CargoRoute cargo;
    private Date arrivalDeadlineDate;

    @Inject
    private BookingServiceFacade bookingServiceFacade;
}
```

Required properties and methods:

- `getTrackingId()` / `setTrackingId(String)`
- `getCargo()`
- `getArrivalDeadlineDate()` / `setArrivalDeadlineDate(Date)`
- `load()`
- `changeArrivalDeadline()`

**Load behavior**

1. Call `bookingServiceFacade.loadCargoForRouting(trackingId)`.
2. Store the returned `CargoRoute`.
3. Parse `cargo.getArrivalDeadlineDate()` using `MM/dd/yyyy`.
4. Store the resulting `Date` in `arrivalDeadlineDate`.
5. Do not query a repository or domain object directly.
6. Do not ignore a parsing failure or merely print its stack trace. Surface a
   clear application/view error consistent with existing JSF behavior.

**Submit behavior**

1. Refuse a null date through JSF validation or explicit bean validation.
2. Call
   `bookingServiceFacade.changeDeadline(trackingId, arrivalDeadlineDate)`.
3. Close the dynamic dialog with:

   ```java
   PrimeFaces.current().dialog().closeDynamic("DONE");
   ```

4. Do not close the dialog if the facade call fails.

**Tests to write**

Add a container-free JUnit test if practical, using a hand-written fake facade,
that proves:

- `load()` requests the correct tracking ID;
- `load()` converts an `MM/dd/yyyy` DTO date into the editable `Date`;
- `changeArrivalDeadline()` delegates the selected date and tracking ID;
- a malformed DTO deadline is surfaced rather than converted to null;
- a null selected date is rejected.

Do not add a mocking framework solely for these tests.

**Gating criteria**

- The bean is serializable and uses the established CDI/JSF annotations.
- The bean references only facade DTOs, not domain model classes.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.

### 4.4 — Issue 4: Implement the PrimeFaces deadline dialog

**What to build**

Add the session-scoped dialog launcher and the dynamic dialog view. The dialog
````

</details>


---

<sub>24s</sub>

### `bash`

**List campaign resources**

$ set -euo pipefail
BASE='edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control'
DIR='1-arrival-deadline-control-remove-before-merge'
git ls-tree -r --name-only "$BASE" -- "$DIR" | sed -n '1,240p'

```
1-arrival-deadline-control-remove-before-merge/add-change-arrival-deadline-feature-ignorance-reduction-plan.md
1-arrival-deadline-control-remove-before-merge/campaign-lessons.md
1-arrival-deadline-control-remove-before-merge/shepherd-campaign.json
1-arrival-deadline-control-remove-before-merge/shepherd-test-experiment.json
<shellId: 4 completed with exit code 0>
```


---

<sub>24s</sub>

### `view`

**view the file at /home/edburns/.copilot/plugins/shepherd-task/scripts/verify-github-issue-body.sh.**

/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-github-issue-body.sh (lines 1-260)

<details>
<summary>131 lines</summary>

```
#!/usr/bin/env bash
# shepherd-task-version: 1.0.4
set -euo pipefail

fail() {
    printf 'verify-github-issue-body: %s\n' "$*" >&2
    exit 1
}

[[ $# -ge 3 && $# -le 6 ]] ||
    fail "usage: $0 OWNER/REPO ISSUE_NUMBER EXPECTED_BODY_PATH [MAX_ATTEMPTS] [DELAY_SECONDS] [DIAGNOSTIC_PATH]"

repository="$1"
issue_number="$2"
expected_body_path="$3"
max_attempts="${4:-6}"
delay_seconds="${5:-5}"
diagnostic_path="${6:-}"
gh_command="${GH_COMMAND:-gh}"

[[ "$repository" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] ||
    fail "invalid repository: $repository"
[[ "$issue_number" =~ ^[1-9][0-9]*$ ]] ||
    fail "invalid issue number: $issue_number"
[[ "$max_attempts" =~ ^[1-9][0-9]*$ ]] ||
    fail "MAX_ATTEMPTS must be a positive integer"
[[ "$delay_seconds" =~ ^[0-9]+$ ]] ||
    fail "DELAY_SECONDS must be a non-negative integer"
[[ -f "$expected_body_path" ]] ||
    fail "expected issue body file not found: $expected_body_path"

temp_directory="$(mktemp -d)"
trap 'rm -rf "$temp_directory"' EXIT
response_path="$temp_directory/response.json"
actual_path="$temp_directory/actual.txt"
actual_normalized="$temp_directory/actual-normalized.txt"
expected_normalized="$temp_directory/expected-normalized.txt"

normalize_file() {
    jq -b -Rsj 'gsub("\r\n|\r"; "\n")' "$1" >"$2"
}

equivalent_files() {
    local actual="$1"
    local expected="$2"
    local candidate="$temp_directory/candidate.txt"

    cmp -s -- "$actual" "$expected" && return 0
    cp "$actual" "$candidate"
    printf '\n' >>"$candidate"
    cmp -s -- "$candidate" "$expected" && return 0
    cp "$expected" "$candidate"
    printf '\n' >>"$candidate"
    cmp -s -- "$actual" "$candidate"
}

sha256_file() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | awk '{print $1}'
    else
        shasum -a 256 "$1" | awk '{print $1}'
    fi
}

write_diagnostic() {
    local reason="$1"
    local attempts="$2"
    [[ -n "$diagnostic_path" ]] || return 0

    mkdir -p "$(dirname "$diagnostic_path")"
    local expected_length actual_length expected_hash actual_hash first_offset
    expected_length="$(wc -c <"$expected_normalized" | tr -d ' ')"
    actual_length="$(wc -c <"$actual_normalized" | tr -d ' ')"
    expected_hash="$(sha256_file "$expected_normalized")"
    actual_hash="$(sha256_file "$actual_normalized")"
    first_offset="$( (cmp -l -- "$actual_normalized" "$expected_normalized" 2>/dev/null || true) | awk 'NR == 1 { print $1 - 1 }')"
    [[ -n "$first_offset" ]] || first_offset="null"

    jq -n \
        --arg repository "$repository" \
        --argjson issueNumber "$issue_number" \
        --arg endpoint "repos/$repository/issues/$issue_number" \
        --argjson attempts "$attempts" \
        --arg observedAt "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
        --arg reason "$reason" \
        --argjson expectedLength "$expected_length" \
        --argjson actualLength "$actual_length" \
        --arg expectedSha256 "$expected_hash" \
        --arg actualSha256 "$actual_hash" \
        --argjson firstDifferenceOffset "$first_offset" \
        '{
            schemaVersion: 1,
            repository: $repository,
            issueNumber: $issueNumber,
            endpoint: $endpoint,
            attempts: $attempts,
            observedAt: $observedAt,
            reason: $reason,
            expectedLength: $expectedLength,
            actualLength: $actualLength,
            expectedSha256: $expectedSha256,
            actualSha256: $actualSha256,
            firstDifferenceOffset: $firstDifferenceOffset
        }' >"$diagnostic_path"
}

normalize_file "$expected_body_path" "$expected_normalized"
last_reason=""

for ((attempt = 1; attempt <= max_attempts; attempt++)); do
    set +e
    "$gh_command" api "repos/$repository/issues/$issue_number" >"$response_path" 2>"$temp_directory/error.txt"
    exit_code=$?
    set -e

    if [[ $exit_code -ne 0 ]]; then
        last_reason="GitHub REST request failed with exit code $exit_code."
        error_message="$(cat "$temp_directory/error.txt")"
        authentication_error_pattern='HTTP[[:space:]]+(401|403)|[Aa]uthentication|[Nn][Oo][Tt][[:space:]]authorized|[Rr]esource[[:space:]]not[[:space:]]accessible'
        if [[ "$error_message" =~ $authentication_error_pattern ]]; then
            : >"$actual_normalized"
            write_diagnostic "$last_reason" "$attempt"
            fail "unable to fetch issue #$issue_number from $repository: $error_message"
        fi
    elif ! jq -e 'type == "object" and has("body")' "$response_path" >/dev/null 2>&1; then
        last_reason="GitHub REST response was invalid JSON."
    else
        jq -b -j '.body // ""' "$response_path" >"$actual_path"
        normalize_file "$actual_path" "$actual_normalized"
        if equivalent_files "$actual_normalized" "$expected_normalized"; then
            cat "$response_path"
            exit 0
        fi
        last_reason="GitHub issue body differs from the persisted draft."
    fi

    if [[ $attempt -lt $max_attempts ]]; then
        printf 'verify-github-issue-body: %s Retrying issue #%s body verification (%s/%s).\n' \
            "$last_reason" "$issue_number" "$attempt" "$max_attempts" >&2
        ((delay_seconds > 0)) && sleep "$delay_seconds"
    fi
done

[[ -f "$actual_normalized" ]] || : >"$actual_normalized"
write_diagnostic "$last_reason" "$max_attempts"
diagnostic_suffix=""
[[ -z "$diagnostic_path" ]] || diagnostic_suffix=" Diagnostic: $diagnostic_path"
fail "issue #$issue_number body verification failed after $max_attempts attempts. $last_reason$diagnostic_suffix"
```

</details>


---

<sub>29s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 400-560)

<details>
<summary>124 lines</summary>

````
required by the prepared baseline.

**Resolution:**

Open `/admin/dialogs/changeArrivalDeadlineDate.xhtml` with a single
`trackingId` request parameter and these options: modal and draggable are
`true`, resizable is `false`, content width is `410`, and content height is
`280`. Successful submission closes with `"DONE"`; cancellation closes with
the empty string. The caller handles `dialogReturn` and updates
`tableNotRouted`. Place the dialog's `<f:metadata>` directly under the root
`<html>` element, before `<h:head>` and `<h:body>`, so the known MyFaces
`UIViewRoot` requirement is satisfied.

### 3.8 — What date validation is required?

**Question:** Must the new deadline be non-null, in the future, after the
current date, or after itinerary completion?

The requested feature is an administrative correction to an existing arrival
deadline. No new domain policy about future dates is part of the request.
Inventing such a rule could reject dates accepted by existing cargo booking or
`RouteSpecification` behavior.

The UI must nevertheless prevent a null submission because the operation
requires a concrete replacement deadline.

**Recommendation:** Require a date value in the JSF form and display a normal
Faces validation message when it is absent. Do not add a new minimum-date,
future-date, or itinerary-date business rule. Continue to rely on the existing
domain model for its established invariants.

**Resolution:**

Require a non-null date selection, but add no new chronological business rule.
In particular, do not require the replacement deadline to be after today,
after the old deadline, or after every itinerary leg. Pass the selected
`java.util.Date` to the existing domain construction path and let the current
`RouteSpecification` invariants apply.

### 3.9 — How will the feature be tested on the prepared historical baseline?

**Question:** Which automated and runtime tests are mandatory, given that the
historical JUnit/Arquillian suite is configured for a remote Payara 4
container, while the prepared production baseline runs on JDK 17/Open Liberty?

The starting POM deliberately leaves `skipTests=true`. The Open Liberty profile
builds and compiles all test sources but does not provide a Liberty Arquillian
adapter. Modernizing the entire integration-test runtime is outside this
feature's scope.

The feature still needs layered evidence:

1. Extend `BookingServiceTest` with the domain/application assertions that
   specify the deadline mutation.
2. Ensure all test sources compile as part of
   `cd demo && ./mvnw clean package -Popenliberty`.
3. Add focused JUnit tests for facade and backing-bean delegation where they
   can run without a container, using hand-written fakes rather than adding a
   mocking framework.
4. Perform mandatory end-to-end verification against the running Open Liberty
   application.
5. Preserve the existing Payara Arquillian test path; do not delete, disable,
   or rewrite it to manufacture a passing result.

**Spike needed:** Before Issue 1 implementation, run the starting commit's
standard Open Liberty package command and record whether tests are compiled but
skipped. Confirm the new `BookingServiceTest` method can be added without
expanding the runtime modernization scope.

**Recommendation:** Treat the JDK 17/Open Liberty build plus HTTP/UI acceptance
as the mandatory executable gate. Keep the historical Arquillian test as a
precise application-layer specification and run it only when its documented
Payara environment is available.

**Resolution:**

Extend the existing sequential Arquillian `BookingServiceTest` with
`testChangeDeadline()` after `testChangeDestination()`. The test changes the
deadline by one month, reloads the cargo through JPA, and asserts the complete
set of preserved and recalculated domain state described above. The prepared
Open Liberty build compiles this test but retains the historical default
`skipTests=true`; executing that Arquillian suite still requires its documented
remote Payara environment. Therefore the mandatory executable gates are the
JDK 17 Open Liberty package/start command, direct HTTP checks, and the complete
`DEF789` browser acceptance flow. No Arquillian-runtime modernization or new
mocking dependency is part of this feature.

---

## Phase 4 — Implementation (five serial issues)

Implement these issues in order. Each issue should be a separate commit. Do not
start an issue until the previous issue's gating criteria are satisfied.

### 4.1 — Issue 1: Add the application-layer deadline change operation

**What to build**

Add the core use case to the application layer. This issue must contain no JSF
or PrimeFaces changes.

**Files to modify**

- `demo/src/main/java/org/eclipse/cargotracker/application/BookingService.java`
- `demo/src/main/java/org/eclipse/cargotracker/application/internal/DefaultBookingService.java`
- `demo/src/test/java/org/eclipse/cargotracker/application/BookingServiceTest.java`

**Required API**

```java
void changeDeadline(TrackingId trackingId, Date deadline);
```

**Required implementation behavior**

1. Load the cargo using `cargoRepository.find(trackingId)`.
2. Obtain the current destination from
   `cargo.getRouteSpecification().getDestination()`.
3. Construct a replacement `RouteSpecification` from:
   - `cargo.getOrigin()`;
   - the current destination;
   - the new deadline.
4. Apply it using `cargo.specifyNewRoute(routeSpecification)`.
5. Persist using `cargoRepository.store(cargo)`.
6. Log the tracking ID and new deadline at `Level.INFO`, following the style of
   `changeDestination(...)`.

Do not:

- add a setter to `Cargo` or `RouteSpecification`;
- modify the origin or destination;
- clear or replace the itinerary directly;
- update persistence entities behind the aggregate's back.

**Tests to write first**

Append a sequential `testChangeDeadline()` case to `BookingServiceTest` after
`testChangeDestination()`. Build a new deadline one month after the test's
original `deadline`, invoke the service, reload the cargo with
`Cargo.findByTrackingId`, and assert:

- origin remains Chicago;
- destination remains Helsinki;
- stored deadline is the same calendar day as the requested new deadline;
- assigned itinerary remains unchanged;
- transport status remains `NOT_RECEIVED`;
- last known location remains `Location.UNKNOWN`;
- current voyage remains `Voyage.NONE`;
- cargo is not marked misdirected;
- estimated time of arrival is `Delivery.ETA_UNKOWN`;
- next expected activity is `Delivery.NO_ACTIVITY`;
- cargo is not unloaded at destination;
- routing status reflects the domain model's recalculation and remains
  `MISROUTED` for the established test sequence.

**Gating criteria**

- The test source compiles.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.
- No web, facade, REST, Liberty, or persistence configuration files change in
  this issue.
````

</details>


---

<sub>29s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 561-760)

<details>
<summary>138 lines</summary>

````

### 4.2 — Issue 2: Expose deadline changes through the booking facade

**What to build**

Expose the use case to presentation clients without leaking domain identifier
types into the web layer.

**Files to modify**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/BookingServiceFacade.java`
- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacade.java`

**Optional focused test file**

- `demo/src/test/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacadeTest.java`

**Required API**

```java
void changeDeadline(String trackingId, Date arrivalDeadline);
```

**Required implementation**

```java
bookingService.changeDeadline(
        new TrackingId(trackingId),
        arrivalDeadline);
```

The facade must not:

- load and mutate `Cargo` itself;
- call `CargoRepository.store(...)`;
- parse a formatted date;
- introduce JSF or PrimeFaces types.

**Tests**

Where a container-free test is added, use a hand-written `BookingService` fake
or spy and prove that:

- the same `Date` object/value reaches the application service;
- the tracking-ID string is converted to an equivalent `TrackingId`;
- the facade delegates exactly once;
- no repository work is duplicated in the facade.

Do not add Mockito or another dependency solely for this test.

**Gating criteria**

- Existing facade consumers still compile.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.
- The application-layer test added in Issue 1 remains unchanged and compiling.

### 4.3 — Issue 3: Implement the deadline editor backing model

**What to build**

Add the view-scoped backing bean that loads a cargo's current deadline and
submits a replacement deadline through the booking facade. Do not add the
dialog launcher or XHTML in this issue.

**File to create**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDate.java`

**Required bean shape**

```java
@Named
@ViewScoped
public class ChangeArrivalDeadlineDate implements Serializable {
    private static final long serialVersionUID = 1L;

    private String trackingId;
    private CargoRoute cargo;
    private Date arrivalDeadlineDate;

    @Inject
    private BookingServiceFacade bookingServiceFacade;
}
```

Required properties and methods:

- `getTrackingId()` / `setTrackingId(String)`
- `getCargo()`
- `getArrivalDeadlineDate()` / `setArrivalDeadlineDate(Date)`
- `load()`
- `changeArrivalDeadline()`

**Load behavior**

1. Call `bookingServiceFacade.loadCargoForRouting(trackingId)`.
2. Store the returned `CargoRoute`.
3. Parse `cargo.getArrivalDeadlineDate()` using `MM/dd/yyyy`.
4. Store the resulting `Date` in `arrivalDeadlineDate`.
5. Do not query a repository or domain object directly.
6. Do not ignore a parsing failure or merely print its stack trace. Surface a
   clear application/view error consistent with existing JSF behavior.

**Submit behavior**

1. Refuse a null date through JSF validation or explicit bean validation.
2. Call
   `bookingServiceFacade.changeDeadline(trackingId, arrivalDeadlineDate)`.
3. Close the dynamic dialog with:

   ```java
   PrimeFaces.current().dialog().closeDynamic("DONE");
   ```

4. Do not close the dialog if the facade call fails.

**Tests to write**

Add a container-free JUnit test if practical, using a hand-written fake facade,
that proves:

- `load()` requests the correct tracking ID;
- `load()` converts an `MM/dd/yyyy` DTO date into the editable `Date`;
- `changeArrivalDeadline()` delegates the selected date and tracking ID;
- a malformed DTO deadline is surfaced rather than converted to null;
- a null selected date is rejected.

Do not add a mocking framework solely for these tests.

**Gating criteria**

- The bean is serializable and uses the established CDI/JSF annotations.
- The bean references only facade DTOs, not domain model classes.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.

### 4.4 — Issue 4: Implement the PrimeFaces deadline dialog

**What to build**

Add the session-scoped dialog launcher and the dynamic dialog view. The dialog
must work when addressed directly with a `trackingId` query parameter, but it
is not yet linked from the dashboard in this issue.

**Files to create**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDateDialog.java`
- `demo/src/main/webapp/admin/dialogs/changeArrivalDeadlineDate.xhtml`

**Launcher requirements**

Use:

```java
@ManagedBean(name = "changeArrivalDeadlineDateDialog")
@SessionScoped
```

Implement:

- `showDialog(String trackingId)`
- `handleReturn(SelectEvent event)`
- `cancel()`

`showDialog(...)` must:

- set the options documented in Question 3.7;
- pass `trackingId` as a dynamic-dialog request parameter;
- open `/admin/dialogs/changeArrivalDeadlineDate.xhtml`.

`cancel()` must close the dialog without invoking the facade.

**XHTML requirements**

The page title must be:

```xhtml
<title>Change Deadline</title>
```

Place metadata directly beneath the root `<html>` element and before
`<h:head>`:

```xhtml
<f:metadata>
    <f:viewParam name="trackingId"
                 value="#{changeArrivalDeadlineDate.trackingId}"/>
    <f:viewAction action="#{changeArrivalDeadlineDate.load}"/>
</f:metadata>
```

The form must display:

- `Origin:` and `changeArrivalDeadlineDate.cargo.originName`;
- `Destination:` and
  `changeArrivalDeadlineDate.cargo.finalDestinationName`;
- `Deadline:` and a `p:datePicker` bound to
  `changeArrivalDeadlineDate.arrivalDeadlineDate`;
- **Cancel**, invoking
  `changeArrivalDeadlineDateDialog.cancel()`;
- **Update**, invoking
````

</details>


---

<sub>29s</sub>

### `bash`

**Verify manifest and plan headings**

$ set -euo pipefail
BASE='edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control'
DIR='1-arrival-deadline-control-remove-before-merge'
git show "$BASE:$DIR/shepherd-campaign.json" | jq .
printf '\nheadings:\n'
git show "$BASE:$DIR/add-change-arrival-deadline-feature-ignorance-reduction-plan.md" | grep '^##\|^###'

<details>
<summary>43 lines</summary>

```
{
  "schemaVersion": 1,
  "campaignId": "4583b192-2c95-45de-a888-34bed4d26fdf",
  "campaignIssueNumber": 1,
  "campaignShortname": "arrival-deadline-control",
  "repository": "edburns/dd-3072166-tricked-out-cargotracker-run-01",
  "baseBranch": "edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control",
  "lessonPropagation": "off",
  "campaignMetadataDirectory": "1-arrival-deadline-control-remove-before-merge",
  "lessonsFile": "campaign-lessons.md",
  "createdBy": {
    "shepherdTaskVersion": "1.0.4",
    "stageOutcomeProtocolVersion": 1
  },
  "createdAt": "2026-10-01T23:42:10Z"
}

headings:
## Goal
### User-visible acceptance behavior
### Domain acceptance behavior
### Hard scope constraints
## Completed phases
### Phase 1 ✅ — Establish a runnable feature-absent baseline
### Phase 2 ✅ — Verify the before and after user experience
## Phase 3 — Ignorance reduction: questions to answer before writing code
### 3.1 — Which cargos expose the edit operation?
### 3.2 — What is the exact domain mutation?
### 3.3 — What should happen to an existing itinerary and delivery state?
### 3.4 — What type crosses the facade boundary?
### 3.5 — How is the DTO's formatted deadline converted for editing?
### 3.6 — Which JSF bean scopes and interaction pattern should be used?
### 3.7 — What is the dynamic-dialog contract?
### 3.8 — What date validation is required?
### 3.9 — How will the feature be tested on the prepared historical baseline?
## Phase 4 — Implementation (five serial issues)
### 4.1 — Issue 1: Add the application-layer deadline change operation
### 4.2 — Issue 2: Expose deadline changes through the booking facade
### 4.3 — Issue 3: Implement the deadline editor backing model
### 4.4 — Issue 4: Implement the PrimeFaces deadline dialog
### 4.5 — Issue 5: Integrate deadline editing into the Administration dashboard
## Phase 5 — Documentation and implementation handoff
## Cross-cutting concerns
<shellId: 5 completed with exit code 0>
```

</details>


---

<sub>31s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 500-680)

<details>
<summary>130 lines</summary>

````

**Files to modify**

- `demo/src/main/java/org/eclipse/cargotracker/application/BookingService.java`
- `demo/src/main/java/org/eclipse/cargotracker/application/internal/DefaultBookingService.java`
- `demo/src/test/java/org/eclipse/cargotracker/application/BookingServiceTest.java`

**Required API**

```java
void changeDeadline(TrackingId trackingId, Date deadline);
```

**Required implementation behavior**

1. Load the cargo using `cargoRepository.find(trackingId)`.
2. Obtain the current destination from
   `cargo.getRouteSpecification().getDestination()`.
3. Construct a replacement `RouteSpecification` from:
   - `cargo.getOrigin()`;
   - the current destination;
   - the new deadline.
4. Apply it using `cargo.specifyNewRoute(routeSpecification)`.
5. Persist using `cargoRepository.store(cargo)`.
6. Log the tracking ID and new deadline at `Level.INFO`, following the style of
   `changeDestination(...)`.

Do not:

- add a setter to `Cargo` or `RouteSpecification`;
- modify the origin or destination;
- clear or replace the itinerary directly;
- update persistence entities behind the aggregate's back.

**Tests to write first**

Append a sequential `testChangeDeadline()` case to `BookingServiceTest` after
`testChangeDestination()`. Build a new deadline one month after the test's
original `deadline`, invoke the service, reload the cargo with
`Cargo.findByTrackingId`, and assert:

- origin remains Chicago;
- destination remains Helsinki;
- stored deadline is the same calendar day as the requested new deadline;
- assigned itinerary remains unchanged;
- transport status remains `NOT_RECEIVED`;
- last known location remains `Location.UNKNOWN`;
- current voyage remains `Voyage.NONE`;
- cargo is not marked misdirected;
- estimated time of arrival is `Delivery.ETA_UNKOWN`;
- next expected activity is `Delivery.NO_ACTIVITY`;
- cargo is not unloaded at destination;
- routing status reflects the domain model's recalculation and remains
  `MISROUTED` for the established test sequence.

**Gating criteria**

- The test source compiles.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.
- No web, facade, REST, Liberty, or persistence configuration files change in
  this issue.

### 4.2 — Issue 2: Expose deadline changes through the booking facade

**What to build**

Expose the use case to presentation clients without leaking domain identifier
types into the web layer.

**Files to modify**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/BookingServiceFacade.java`
- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacade.java`

**Optional focused test file**

- `demo/src/test/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacadeTest.java`

**Required API**

```java
void changeDeadline(String trackingId, Date arrivalDeadline);
```

**Required implementation**

```java
bookingService.changeDeadline(
        new TrackingId(trackingId),
        arrivalDeadline);
```

The facade must not:

- load and mutate `Cargo` itself;
- call `CargoRepository.store(...)`;
- parse a formatted date;
- introduce JSF or PrimeFaces types.

**Tests**

Where a container-free test is added, use a hand-written `BookingService` fake
or spy and prove that:

- the same `Date` object/value reaches the application service;
- the tracking-ID string is converted to an equivalent `TrackingId`;
- the facade delegates exactly once;
- no repository work is duplicated in the facade.

Do not add Mockito or another dependency solely for this test.

**Gating criteria**

- Existing facade consumers still compile.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.
- The application-layer test added in Issue 1 remains unchanged and compiling.

### 4.3 — Issue 3: Implement the deadline editor backing model

**What to build**

Add the view-scoped backing bean that loads a cargo's current deadline and
submits a replacement deadline through the booking facade. Do not add the
dialog launcher or XHTML in this issue.

**File to create**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDate.java`

**Required bean shape**

```java
@Named
@ViewScoped
public class ChangeArrivalDeadlineDate implements Serializable {
    private static final long serialVersionUID = 1L;

    private String trackingId;
    private CargoRoute cargo;
    private Date arrivalDeadlineDate;

    @Inject
    private BookingServiceFacade bookingServiceFacade;
}
```

Required properties and methods:

- `getTrackingId()` / `setTrackingId(String)`
- `getCargo()`
- `getArrivalDeadlineDate()` / `setArrivalDeadlineDate(Date)`
- `load()`
- `changeArrivalDeadline()`

**Load behavior**

1. Call `bookingServiceFacade.loadCargoForRouting(trackingId)`.
2. Store the returned `CargoRoute`.
3. Parse `cargo.getArrivalDeadlineDate()` using `MM/dd/yyyy`.
4. Store the resulting `Date` in `arrivalDeadlineDate`.
5. Do not query a repository or domain object directly.
6. Do not ignore a parsing failure or merely print its stack trace. Surface a
   clear application/view error consistent with existing JSF behavior.

**Submit behavior**

1. Refuse a null date through JSF validation or explicit bean validation.
2. Call
   `bookingServiceFacade.changeDeadline(trackingId, arrivalDeadlineDate)`.
3. Close the dynamic dialog with:

   ```java
   PrimeFaces.current().dialog().closeDynamic("DONE");
   ```

4. Do not close the dialog if the facade call fails.

**Tests to write**

Add a container-free JUnit test if practical, using a hand-written fake facade,
that proves:
````

</details>


---

<sub>33s</sub>

### `view`

**view the file at /tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt.**

/tmp/1790898152969-copilot-tool-output-3660444-93cf1fdb-55e5-4bf8-b955-dc889ad5b22c.txt (lines 680-900)

<details>
<summary>162 lines</summary>

````
that proves:

- `load()` requests the correct tracking ID;
- `load()` converts an `MM/dd/yyyy` DTO date into the editable `Date`;
- `changeArrivalDeadline()` delegates the selected date and tracking ID;
- a malformed DTO deadline is surfaced rather than converted to null;
- a null selected date is rejected.

Do not add a mocking framework solely for these tests.

**Gating criteria**

- The bean is serializable and uses the established CDI/JSF annotations.
- The bean references only facade DTOs, not domain model classes.
- `cd demo && ./mvnw clean package -Popenliberty` succeeds on JDK 17.

### 4.4 — Issue 4: Implement the PrimeFaces deadline dialog

**What to build**

Add the session-scoped dialog launcher and the dynamic dialog view. The dialog
must work when addressed directly with a `trackingId` query parameter, but it
is not yet linked from the dashboard in this issue.

**Files to create**

- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDateDialog.java`
- `demo/src/main/webapp/admin/dialogs/changeArrivalDeadlineDate.xhtml`

**Launcher requirements**

Use:

```java
@ManagedBean(name = "changeArrivalDeadlineDateDialog")
@SessionScoped
```

Implement:

- `showDialog(String trackingId)`
- `handleReturn(SelectEvent event)`
- `cancel()`

`showDialog(...)` must:

- set the options documented in Question 3.7;
- pass `trackingId` as a dynamic-dialog request parameter;
- open `/admin/dialogs/changeArrivalDeadlineDate.xhtml`.

`cancel()` must close the dialog without invoking the facade.

**XHTML requirements**

The page title must be:

```xhtml
<title>Change Deadline</title>
```

Place metadata directly beneath the root `<html>` element and before
`<h:head>`:

```xhtml
<f:metadata>
    <f:viewParam name="trackingId"
                 value="#{changeArrivalDeadlineDate.trackingId}"/>
    <f:viewAction action="#{changeArrivalDeadlineDate.load}"/>
</f:metadata>
```

The form must display:

- `Origin:` and `changeArrivalDeadlineDate.cargo.originName`;
- `Destination:` and
  `changeArrivalDeadlineDate.cargo.finalDestinationName`;
- `Deadline:` and a `p:datePicker` bound to
  `changeArrivalDeadlineDate.arrivalDeadlineDate`;
- **Cancel**, invoking
  `changeArrivalDeadlineDateDialog.cancel()`;
- **Update**, invoking
  `changeArrivalDeadlineDate.changeArrivalDeadline()`.

The date picker must require a value. The Update action must reload or refresh
the calling Administration view after a successful dialog close, following the
existing destination-dialog behavior.

**Runtime tests**

With the application running, request:

```text
http://localhost:8080/cargo-tracker/admin/dialogs/changeArrivalDeadlineDate.xhtml?trackingId=DEF789
```

Verify:

- HTTP 200;
- title is **Change Deadline**;
- origin and destination render;
- the existing deadline is selected;
- no `TagException`, `Parent UIComponent`, `FacesException`, or server error is
  present;
- Cancel does not change the persisted deadline;
- Update changes the deadline.

**Gating criteria**

- `cd demo && ./mvnw clean package -Popenliberty liberty:run` succeeds on JDK 17.
- Direct dialog loading and both actions work.
- Destination editing continues to work.
- Stop Liberty cleanly before completing the issue.

### 4.5 — Issue 5: Integrate deadline editing into the Administration dashboard

**What to build**

Replace the plain deadline text in the Not Routed Cargo table with the
PrimeFaces command-link affordance that opens the completed dialog and refreshes
the table after return.

**File to modify**

- `demo/src/main/webapp/admin/tables/listNotRouted.xhtml`

**Required UI shape**

Within the existing Deadline column, add a `p:commandLink` that:

- calls
  `changeArrivalDeadlineDateDialog.showDialog(cargoNotRouted.trackingId)`;
- retains the displayed
  `cargoNotRouted.arrivalDeadlineDate`;
- adds the existing Font Awesome edit icon style;
- uses a stable component ID such as `arrivalDeadlineToUpdate`;
- listens for `dialogReturn`;
- invokes
  `changeArrivalDeadlineDateDialog.handleReturn`;
- updates `tableNotRouted`;
- provides the tooltip:
  `Click to change cargo arrival deadline date.`

Follow the adjacent Destination column's established structure and styling. Do
not alter tracking-ID routing or destination editing.

**End-to-end acceptance test**

1. Start from a clean build on JDK 17:

   ```bash
   cd demo && ./mvnw clean package -Popenliberty liberty:run
   ```

2. Confirm the home page returns HTTP 200.
3. Open Administration and locate `DEF789`.
4. Record the original deadline.
5. Confirm the deadline now has an edit icon and tooltip.
6. Open the deadline dialog.
7. Confirm origin and destination identify the same cargo.
8. Choose a visibly different date.
9. Press **Update**.
10. Confirm the dialog closes and the Not Routed Cargo table refreshes.
11. Confirm the table shows the selected date.
12. Reload the browser and confirm the selected date remains.
13. Reopen the dialog and confirm the editor initializes to the changed date.
14. Press **Cancel** and confirm no additional change occurs.
15. Verify the Destination edit dialog still opens.
16. Verify selecting `DEF789` for routing still loads without an error page.

**Log acceptance**

The final run must contain none of:

- `<f:metadata> Parent UIComponent`;
- `TagException`;
- `VerifyError`;
- `FacesException`;
- `CWWKZ0002E` or `CWWKZ0003E`;
- recurring batch authorization failures;
- new FFDC files attributable to this feature.

Transient JMS activation-order warnings are acceptable only if all message
endpoints subsequently activate, as established by the prepared baseline.

**Final regression and scope checks**

- `cd demo && ./mvnw clean package -Popenliberty` succeeds.
- The existing test sources and the new deadline test compile.
- No Java EE namespace migration occurred.
- No Open Liberty, Derby, Jackson, JSF metadata, batch authorization, or REST
  compatibility fix from the starting commit was reverted.
- The feature affects only the intended application, facade, web, dialog,
  table, and test surfaces.
- Stop Liberty cleanly.

---

## Phase 5 — Documentation and implementation handoff

- Update `demo/README.md` only if user-facing Administration capabilities are
  enumerated there; add one concise sentence that administrators can change an
  unrouted cargo's arrival deadline.
- Record the exact JDK 17 run command in the final issue or pull-request
  description:

  ```bash
  cd demo && ./mvnw clean package -Popenliberty liberty:run
  ```

- Include `DEF789` and the before/after deadline values in the acceptance
  evidence.
- State explicitly that data is in-memory and resets when the application is
  rebuilt/restarted.

---

## Cross-cutting concerns

| Concern | Required handling |
|---------|--------------------|
| Domain-driven design | Mutate the aggregate through `Cargo.specifyNewRoute(...)`; do not bypass it with persistence-level field updates. |
````

</details>


---

<sub>39s</sub>

### Copilot

All nine blocking questions have substantive resolutions; none remain unresolved. The decisive findings are the aggregate replacement pattern, itinerary preservation, `String`/`Date` facade boundary, per-load date parsing, the existing dynamic-dialog architecture, MyFaces metadata placement, non-null-only validation, and Open Liberty/runtime acceptance rather than Arquillian modernization. I’m persisting all five complete drafts before the first mutation.

---

<sub>1m 25s</sub>

### `apply_patch`

<details>
<summary>Arguments</summary>

````json
"*** Begin Patch\n*** Add File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/01-4-1-body.md\n+## Campaign context and required reading\n+\n+On the `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` branch, the directory `1-arrival-deadline-control-remove-before-merge` contains the plan (`add-change-arrival-deadline-feature-ignorance-reduction-plan.md`) and supporting resources (diagrams, decision records). Spike subdirectories are research artifacts — read the plan's Resolution sections for findings, not the spike source code.\n+\n+Before implementation, read the entire plan. Then re-read these exact sections:\n+\n+- `## Goal`, including `### Domain acceptance behavior` and `### Hard scope constraints`\n+- `### 3.2 — What is the exact domain mutation?`\n+- `### 3.3 — What should happen to an existing itinerary and delivery state?`\n+- `### 3.9 — How will the feature be tested on the prepared historical baseline?`\n+- `### 4.1 — Issue 1: Add the application-layer deadline change operation`\n+- `## Cross-cutting concerns`\n+\n+The resolved design is mandatory:\n+\n+- Add `BookingService.changeDeadline(TrackingId, Date)`.\n+- Load the cargo, preserve its existing origin and destination, create a replacement `RouteSpecification` with the supplied deadline, apply it through `Cargo.specifyNewRoute(...)`, and store the aggregate.\n+- Preserve the assigned itinerary. Do not clear, replace, or reroute it. Let the aggregate recalculate delivery-derived state and routing status; in the established sequential test, the cargo remains `MISROUTED`.\n+- The research established that the prepared Open Liberty build compiles the historical Arquillian test source while retaining default `skipTests=true`. Executing Arquillian still requires the documented remote Payara environment; do not modernize that runtime or manufacture a passing result.\n+\n+## Branch and execution order\n+\n+Target `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` from remote `origin`. This is task 1 of 5. The tasks are assigned, completed, and merged serially in plan order. Do not begin work until this issue is assigned. Later tasks must build on this merged result.\n+\n+Preserve Java EE 7, `javax.*`, Java 17 execution, Open Liberty, the existing Derby setup, and the `cargo-tracker.war` deployment. Run Maven Wrapper commands from `demo/` with the repository-required Java 17 environment.\n+\n+## Implement\n+\n+Modify only the application API, its implementation, and the application-layer test:\n+\n+- `demo/src/main/java/org/eclipse/cargotracker/application/BookingService.java`\n+- `demo/src/main/java/org/eclipse/cargotracker/application/internal/DefaultBookingService.java`\n+- `demo/src/test/java/org/eclipse/cargotracker/application/BookingServiceTest.java`\n+\n+Add:\n+\n+```java\n+void changeDeadline(TrackingId trackingId, Date deadline);\n+```\n+\n+In `DefaultBookingService`:\n+\n+1. Load the cargo with `cargoRepository.find(trackingId)`.\n+2. Read the current destination from `cargo.getRouteSpecification().getDestination()`.\n+3. Construct a replacement `RouteSpecification` from `cargo.getOrigin()`, the current destination, and the supplied deadline.\n+4. Call `cargo.specifyNewRoute(routeSpecification)`.\n+5. Call `cargoRepository.store(cargo)`.\n+6. Log the tracking ID and new deadline at `Level.INFO`, matching `changeDestination(...)` style.\n+\n+Write the test first. Append sequential `testChangeDeadline()` immediately after `testChangeDestination()`. Advance the original test deadline by one month, invoke the service, reload with `Cargo.findByTrackingId`, and assert:\n+\n+- origin is still Chicago;\n+- destination is still Helsinki;\n+- the stored deadline is the requested calendar day;\n+- the assigned itinerary is unchanged;\n+- transport status is `NOT_RECEIVED`;\n+- last known location is `Location.UNKNOWN`;\n+- current voyage is `Voyage.NONE`;\n+- the cargo is not misdirected;\n+- ETA is `Delivery.ETA_UNKOWN`;\n+- next expected activity is `Delivery.NO_ACTIVITY`;\n+- the cargo is not unloaded at destination;\n+- routing status is `MISROUTED`.\n+\n+## Completion gates\n+\n+- `BookingServiceTest` compiles with the new sequential test after `testChangeDestination()`.\n+- From `demo/`, `./mvnw clean package -Popenliberty` succeeds under Java 17 using the required tee-to-log discipline.\n+- Review the diff and confirm no web, facade, REST, Liberty, Derby, or persistence-configuration file changed.\n+- Confirm the implementation invokes `Cargo.specifyNewRoute(...)` and `CargoRepository.store(...)`, preserves origin/destination/itinerary, and has no direct persistence-field update.\n+- Preserve the historical Arquillian path unchanged; document that execution requires its remote Payara environment and that the Open Liberty package gate compiles but skips it by default.\n+\n+## Out of scope\n+\n+- No JSF, PrimeFaces, facade, REST, dialog, table, or configuration changes.\n+- No setter on `Cargo` or `RouteSpecification`.\n+- No itinerary clearing, replacement, or rerouting.\n+- No Jakarta migration, runtime replacement, test-runtime modernization, mocking dependency, or broad dependency upgrade.\n+- No copying code or commits from feature-bearing branches or spike artifacts.\n*** Add File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/02-4-2-body.md\n+## Campaign context and required reading\n+\n+On the `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` branch, the directory `1-arrival-deadline-control-remove-before-merge` contains the plan (`add-change-arrival-deadline-feature-ignorance-reduction-plan.md`) and supporting resources (diagrams, decision records). Spike subdirectories are research artifacts — read the plan's Resolution sections for findings, not the spike source code.\n+\n+Before implementation, read the entire plan. Then re-read these exact sections:\n+\n+- `## Goal`, including `### Domain acceptance behavior` and `### Hard scope constraints`\n+- `### 3.2 — What is the exact domain mutation?`\n+- `### 3.4 — What type crosses the facade boundary?`\n+- `### 3.9 — How will the feature be tested on the prepared historical baseline?`\n+- `### 4.2 — Issue 2: Expose deadline changes through the booking facade`\n+- `## Cross-cutting concerns`\n+\n+The resolved facade contract is `void changeDeadline(String trackingId, Date arrivalDeadline)`. Convert only the identifier with `new TrackingId(trackingId)` and pass the same `Date` to the application service. Do not expose domain objects to presentation clients or introduce a command DTO or formatted-string service parameter. Research also established that focused container-free tests should use hand-written fakes rather than adding a mocking framework.\n+\n+## Branch and execution order\n+\n+Target `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` from remote `origin`. This is task 2 of 5. The tasks are assigned, completed, and merged serially in plan order. Do not begin until task 1 has merged and this issue is assigned.\n+\n+Preserve Java EE 7, `javax.*`, Java 17 execution, Open Liberty, the existing Derby setup, and the `cargo-tracker.war` deployment.\n+\n+## Implement\n+\n+Modify:\n+\n+- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/BookingServiceFacade.java`\n+- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacade.java`\n+\n+Optionally add a focused test at:\n+\n+- `demo/src/test/java/org/eclipse/cargotracker/interfaces/booking/facade/internal/DefaultBookingServiceFacadeTest.java`\n+\n+Add this facade API:\n+\n+```java\n+void changeDeadline(String trackingId, Date arrivalDeadline);\n+```\n+\n+Delegate exactly once:\n+\n+```java\n+bookingService.changeDeadline(\n+        new TrackingId(trackingId),\n+        arrivalDeadline);\n+```\n+\n+If a focused test is practical within the existing test setup, use a hand-written `BookingService` fake/spy and prove that the equivalent `TrackingId` and same `Date` value/object reach the application service exactly once. The facade must not perform repository work.\n+\n+## Completion gates\n+\n+- Existing facade consumers compile.\n+- From `demo/`, `./mvnw clean package -Popenliberty` succeeds under Java 17 using the required tee-to-log discipline.\n+- The application-layer test from task 1 remains unchanged and compiles.\n+- A focused test, if added, proves one delegation with an equivalent identifier and unchanged date without a new test dependency.\n+- Diff inspection confirms the facade does not load/mutate `Cargo`, access `CargoRepository`, parse dates, or import JSF/PrimeFaces types.\n+\n+## Out of scope\n+\n+- No domain mutation or persistence logic in the facade.\n+- No JSF bean, dialog, XHTML, or dashboard changes.\n+- No new DTO, formatted date parameter, Mockito, or other mocking dependency.\n+- No Jakarta migration, application-server replacement, or broad dependency upgrade.\n+- No copying code or commits from feature-bearing branches or spike artifacts.\n*** Add File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/03-4-3-body.md\n+## Campaign context and required reading\n+\n+On the `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` branch, the directory `1-arrival-deadline-control-remove-before-merge` contains the plan (`add-change-arrival-deadline-feature-ignorance-reduction-plan.md`) and supporting resources (diagrams, decision records). Spike subdirectories are research artifacts — read the plan's Resolution sections for findings, not the spike source code.\n+\n+Before implementation, read the entire plan. Then re-read these exact sections:\n+\n+- `## Goal`, including `### User-visible acceptance behavior` and `### Hard scope constraints`\n+- `### 3.4 — What type crosses the facade boundary?`\n+- `### 3.5 — How is the DTO's formatted deadline converted for editing?`\n+- `### 3.6 — Which JSF bean scopes and interaction pattern should be used?`\n+- `### 3.8 — What date validation is required?`\n+- `### 3.9 — How will the feature be tested on the prepared historical baseline?`\n+- `### 4.3 — Issue 3: Implement the deadline editor backing model`\n+- `## Cross-cutting concerns`\n+\n+The resolved design uses a serializable CDI `@Named @ViewScoped` editor. It loads only the facade `CargoRoute`, parses the displayed `MM/dd/yyyy` date with a per-load `SimpleDateFormat`, and passes `String` plus `Date` back through the facade. The plan records that the full arrival-deadline string starts with the same date component; keep conversion local and do not add a shared mutable formatter. A malformed stored date must surface as an explicit view/application failure. Only non-null is required; invent no future-date or itinerary chronology policy.\n+\n+## Branch and execution order\n+\n+Target `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` from remote `origin`. This is task 3 of 5. The tasks are assigned, completed, and merged serially in plan order. Do not begin until task 2 has merged and this issue is assigned.\n+\n+Preserve Java EE 7 and `javax.*`; do not use Jakarta annotations.\n+\n+## Implement\n+\n+Create:\n+\n+- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDate.java`\n+\n+Required shape:\n+\n+```java\n+@Named\n+@ViewScoped\n+public class ChangeArrivalDeadlineDate implements Serializable {\n+    private static final long serialVersionUID = 1L;\n+\n+    private String trackingId;\n+    private CargoRoute cargo;\n+    private Date arrivalDeadlineDate;\n+\n+    @Inject\n+    private BookingServiceFacade bookingServiceFacade;\n+}\n+```\n+\n+Provide `getTrackingId()`, `setTrackingId(String)`, `getCargo()`, `getArrivalDeadlineDate()`, `setArrivalDeadlineDate(Date)`, `load()`, and `changeArrivalDeadline()`.\n+\n+`load()` must:\n+\n+1. call `bookingServiceFacade.loadCargoForRouting(trackingId)`;\n+2. retain the returned `CargoRoute`;\n+3. parse the DTO's displayed date as `MM/dd/yyyy` with a formatter created for this load;\n+4. initialize `arrivalDeadlineDate`;\n+5. surface malformed data clearly and consistently with existing JSF error handling rather than returning null or printing a stack trace.\n+\n+`changeArrivalDeadline()` must reject null, call `bookingServiceFacade.changeDeadline(trackingId, arrivalDeadlineDate)`, and only after successful return call:\n+\n+```java\n+PrimeFaces.current().dialog().closeDynamic(\"DONE\");\n+```\n+\n+If practical in the current setup, add a container-free JUnit test with a hand-written facade fake proving correct load identifier, date conversion, delegation, malformed-date failure, and null rejection.\n+\n+## Completion gates\n+\n+- The bean compiles, is serializable, and uses the established CDI/JSF annotations under `javax.*`.\n+- From `demo/`, `./mvnw clean package -Popenliberty` succeeds under Java 17 using the required tee-to-log discipline.\n+- The bean imports facade DTO/API types but no domain model or repository type.\n+- Tests or focused inspection prove parsing failure is explicit, null is rejected, facade failure cannot close the dialog, and successful delegation closes with `\"DONE\"`.\n+- Any focused test uses a hand-written fake and no new mocking dependency.\n+\n+## Out of scope\n+\n+- No dialog launcher, XHTML, dashboard link, repository access, or domain-object access.\n+- No shared mutable `SimpleDateFormat`.\n+- No minimum, future, after-old-deadline, or after-itinerary date rule.\n+- No new command DTO or string-formatted facade command.\n+- No Jakarta migration, runtime replacement, or broad dependency upgrade.\n+- No copying code or commits from feature-bearing branches or spike artifacts.\n*** Add File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/04-4-4-body.md\n+## Campaign context and required reading\n+\n+On the `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` branch, the directory `1-arrival-deadline-control-remove-before-merge` contains the plan (`add-change-arrival-deadline-feature-ignorance-reduction-plan.md`) and supporting resources (diagrams, decision records). Spike subdirectories are research artifacts — read the plan's Resolution sections for findings, not the spike source code.\n+\n+Before implementation, read the entire plan. Then re-read these exact sections:\n+\n+- `## Goal`, including `### User-visible acceptance behavior` and `### Hard scope constraints`\n+- `### Phase 1 ✅ — Establish a runnable feature-absent baseline`\n+- `### 3.5 — How is the DTO's formatted deadline converted for editing?`\n+- `### 3.6 — Which JSF bean scopes and interaction pattern should be used?`\n+- `### 3.7 — What is the dynamic-dialog contract?`\n+- `### 3.8 — What date validation is required?`\n+- `### 3.9 — How will the feature be tested on the prepared historical baseline?`\n+- `### 4.4 — Issue 4: Implement the PrimeFaces deadline dialog`\n+- `## Cross-cutting concerns`\n+\n+The resolved interaction mirrors Change Destination: a serializable session-scoped JSF managed launcher opens a PrimeFaces dynamic dialog backed by the task-3 view bean. Use a `trackingId` request parameter; options are modal `true`, draggable `true`, resizable `false`, content width `410`, content height `280`. Success returns `\"DONE\"` and Cancel returns `\"\"`. The research established that MyFaces requires `<f:metadata>` directly under the root `<html>` before `<h:head>` and `<h:body>`; nesting it in the body causes runtime failure.\n+\n+## Branch and execution order\n+\n+Target `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` from remote `origin`. This is task 4 of 5. The tasks are assigned, completed, and merged serially in plan order. Do not begin until task 3 has merged and this issue is assigned.\n+\n+Preserve Java EE 7, `javax.*`, PrimeFaces 8, Java 17 execution, and Open Liberty.\n+\n+## Implement\n+\n+Create:\n+\n+- `demo/src/main/java/org/eclipse/cargotracker/interfaces/booking/web/ChangeArrivalDeadlineDateDialog.java`\n+- `demo/src/main/webapp/admin/dialogs/changeArrivalDeadlineDate.xhtml`\n+\n+The launcher must be serializable and use:\n+\n+```java\n+@ManagedBean(name = \"changeArrivalDeadlineDateDialog\")\n+@SessionScoped\n+```\n+\n+Implement `showDialog(String trackingId)`, `handleReturn(SelectEvent event)`, and `cancel()`. Open `/admin/dialogs/changeArrivalDeadlineDate.xhtml` with the exact options above and a `Map<String, List<String>>` containing only `trackingId`. Cancel must close with an empty string and must not call the facade.\n+\n+The XHTML title is `Change Deadline`. Place this metadata directly below `<html>` and before `<h:head>`:\n+\n+```xhtml\n+<f:metadata>\n+    <f:viewParam name=\"trackingId\"\n+                 value=\"#{changeArrivalDeadlineDate.trackingId}\"/>\n+    <f:viewAction action=\"#{changeArrivalDeadlineDate.load}\"/>\n+</f:metadata>\n+```\n+\n+Display read-only Origin and Destination values from `changeArrivalDeadlineDate.cargo`, and a required `p:datePicker` bound to `changeArrivalDeadlineDate.arrivalDeadlineDate`. Provide Cancel via `changeArrivalDeadlineDateDialog.cancel()` and Update via `changeArrivalDeadlineDate.changeArrivalDeadline()`. Follow existing dialog styling and message conventions.\n+\n+## Completion gates\n+\n+- From `demo/`, `./mvnw clean package -Popenliberty liberty:run` starts successfully under Java 17 using the required tee-to-log discipline.\n+- Directly request `/cargo-tracker/admin/dialogs/changeArrivalDeadlineDate.xhtml?trackingId=DEF789` and verify HTTP 200, title `Change Deadline`, origin/destination rendering, and initialized current deadline.\n+- Verify empty submission shows normal required-field validation.\n+- Verify Cancel closes without changing the persisted deadline.\n+- Verify Update changes the deadline and closes only after successful facade return.\n+- Verify destination editing still works.\n+- Inspect the run log for absence of `TagException`, `Parent UIComponent`, `FacesException`, server errors, or feature-attributable FFDC.\n+- Stop Liberty cleanly before completing the issue.\n+\n+## Out of scope\n+\n+- Do not add the dashboard command link yet.\n+- Do not alter domain/application/facade behavior from earlier tasks.\n+- Do not add navigation to a full page, inline cell editing, or a chronological date rule.\n+- Do not move `<f:metadata>` into `<h:body>`.\n+- No Jakarta migration, UI-framework/runtime replacement, or broad dependency upgrade.\n+- No copying code or commits from feature-bearing branches or spike artifacts.\n*** Add File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/05-4-5-body.md\n+## Campaign context and required reading\n+\n+On the `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` branch, the directory `1-arrival-deadline-control-remove-before-merge` contains the plan (`add-change-arrival-deadline-feature-ignorance-reduction-plan.md`) and supporting resources (diagrams, decision records). Spike subdirectories are research artifacts — read the plan's Resolution sections for findings, not the spike source code.\n+\n+Before implementation, read the entire plan. Then re-read these exact sections:\n+\n+- `## Goal`, including `### User-visible acceptance behavior`, `### Domain acceptance behavior`, and `### Hard scope constraints`\n+- `### Phase 1 ✅ — Establish a runnable feature-absent baseline`\n+- `### Phase 2 ✅ — Verify the before and after user experience`\n+- `### 3.1 — Which cargos expose the edit operation?`\n+- `### 3.6 — Which JSF bean scopes and interaction pattern should be used?`\n+- `### 3.7 — What is the dynamic-dialog contract?`\n+- `### 3.8 — What date validation is required?`\n+- `### 3.9 — How will the feature be tested on the prepared historical baseline?`\n+- `### 4.5 — Issue 5: Integrate deadline editing into the Administration dashboard`\n+- `## Phase 5 — Documentation and implementation handoff`\n+- `## Cross-cutting concerns`\n+\n+The resolution limits the affordance to `listNotRouted.xhtml`; application/facade APIs remain generally callable. Mirror the adjacent Destination command-link/dialog-return pattern. The required tooltip is exactly `Click to change cargo arrival deadline date.` The caller refreshes `tableNotRouted`. Research established the mandatory executable evidence: Java 17/Open Liberty package/start, direct HTTP checks, and the complete `DEF789` browser flow. Do not modernize the historical Payara Arquillian runtime.\n+\n+## Branch and execution order\n+\n+Target `edburns/dd-3016202-cargotracker-devoxx-be-2026-add-feature-control` from remote `origin`. This is task 5 of 5. The tasks are assigned, completed, and merged serially in plan order. Do not begin until task 4 has merged and this issue is assigned.\n+\n+Preserve Java EE 7, `javax.*`, PrimeFaces 8, Java 17 execution, Open Liberty, Derby, and all compatibility fixes from the starting branch.\n+\n+## Implement\n+\n+Modify:\n+\n+- `demo/src/main/webapp/admin/tables/listNotRouted.xhtml`\n+\n+In the existing Deadline column, replace plain text with a `p:commandLink` that:\n+\n+- calls `changeArrivalDeadlineDateDialog.showDialog(cargoNotRouted.trackingId)`;\n+- continues displaying `cargoNotRouted.arrivalDeadlineDate`;\n+- uses the existing Font Awesome edit-icon style;\n+- has a stable ID such as `arrivalDeadlineToUpdate`;\n+- listens for `dialogReturn`;\n+- invokes `changeArrivalDeadlineDateDialog.handleReturn`;\n+- updates `tableNotRouted`;\n+- exposes the exact tooltip `Click to change cargo arrival deadline date.`\n+\n+Follow the adjacent Destination column's structure and styling without changing destination editing, tracking-ID routing, or other Administration tables.\n+\n+Update `demo/README.md` only if it enumerates user-facing Administration capabilities; if so, add one concise sentence about changing an unrouted cargo's arrival deadline.\n+\n+## Completion gates\n+\n+- From `demo/`, `./mvnw clean package -Popenliberty` succeeds under Java 17 using the required tee-to-log discipline and existing/new test sources compile.\n+- Start with `./mvnw clean package -Popenliberty liberty:run` under Java 17 and confirm the home page returns HTTP 200.\n+- Complete the full browser flow with `DEF789`: record the old deadline; verify icon/tooltip; open the dialog; verify matching origin/destination and initialized date; select a visibly different date; Update; verify close and table refresh; reload and verify persistence for the running in-memory application; reopen and verify the new initial date; Cancel and verify no further change.\n+- Verify the Destination dialog still opens and selecting `DEF789` for routing does not produce an error page.\n+- Inspect logs for absence of `<f:metadata> Parent UIComponent`, `TagException`, `VerifyError`, `FacesException`, `CWWKZ0002E`, `CWWKZ0003E`, recurring batch authorization failures, and new feature-attributable FFDC. Transient JMS activation-order warnings are acceptable only if all endpoints subsequently activate.\n+- Confirm no Java EE namespace migration and no Liberty, Derby, Jackson, JSF metadata, batch authorization, or REST compatibility fix was reverted.\n+- Record the exact run command, `DEF789`, old/new deadline values, and the in-memory reset caveat in PR evidence. Stop Liberty cleanly.\n+\n+## Out of scope\n+\n+- No deadline affordance in routed, misrouted, claimed, details, or other cargo views.\n+- No changes to destination editing, tracking-ID routing, domain/application/facade contracts, or persistence.\n+- No new date chronology rule.\n+- No Arquillian modernization, mocking dependency, Jakarta migration, runtime/UI-framework replacement, or broad dependency upgrade.\n+- No copying code or commits from feature-bearing branches or spike artifacts.\n*** End Patch\n"
````

</details>

```
Added 5 file(s): /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/01-4-1-body.md, /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/02-4-2-body.md, /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/03-4-3-body.md, /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/04-4-4-body.md, /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/issue-bodies/05-4-5-body.md
```


---

<sub>1m 29s</sub>

### `bash`

**Validate all persisted issue drafts**

$ set -euo pipefail
LOG='/home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342'
VALIDATOR='/home/edburns/.copilot/plugins/shepherd-task/scripts/validate-stage20-drafts.sh'
"$VALIDATOR" "$LOG/issue-bodies" 5 off
for file in "$LOG"/issue-bodies/*-body.md; do
  printf '%s\t%s lines\t%s bytes\n' "$(basename "$file")" "$(wc -l < "$file")" "$(wc -c < "$file")"
done
printf 'draft_validation_ok\n'

<details>
<summary>7 lines</summary>

```
01-4-1-body.md	79 lines	5028 bytes
02-4-2-body.md	63 lines	3581 bytes
03-4-3-body.md	80 lines	4428 bytes
04-4-4-body.md	71 lines	4619 bytes
05-4-5-body.md	64 lines	5024 bytes
draft_validation_ok
<shellId: 6 completed with exit code 0>
```

</details>


---

<sub>1m 41s</sub>

### Copilot

All five persisted drafts passed the supplied validator with intact multiline Markdown. Children will be created **without an issue type** because this user-owned repository cannot provide organization issue types; creation will now proceed one at a time with body verification and parent linking after each issue.

---

<sub>2m 0s</sub>

### `apply_patch`

<details>
<summary>Arguments</summary>

```json
"*** Begin Patch\n*** Add File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/run-stage20.sh\n+#!/usr/bin/env bash\n+set -Eeuo pipefail\n+\n+REPO='edburns/dd-3072166-tricked-out-cargotracker-run-01'\n+PARENT_ISSUE=1\n+LOG='/home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342'\n+BODY_VERIFIER='/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-github-issue-body.sh'\n+CHILD_LINK_VERIFIER='/home/edburns/.copilot/plugins/shepherd-task/scripts/verify-stage20-child-links.sh'\n+LEDGER=\"$LOG/creation-ledger.json\"\n+RESULT=\"$LOG/stage-20-result.json\"\n+PRE_CHILDREN=\"$LOG/pre-creation-children.json\"\n+FINAL_CHILDREN=\"$LOG/final-children.json\"\n+CURRENT_OPERATION='initialization'\n+\n+atomic_write() {\n+  local destination=\"$1\" content=\"$2\" temporary\n+  temporary=\"$(mktemp \"$(dirname \"$destination\")/.stage20.XXXXXX\")\"\n+  printf '%s\\n' \"$content\" >\"$temporary\"\n+  mv \"$temporary\" \"$destination\"\n+}\n+\n+update_ledger_flag() {\n+  local number=\"$1\" field=\"$2\" value=\"$3\" updated\n+  updated=\"$(\n+    jq \\\n+      --argjson number \"$number\" \\\n+      --arg field \"$field\" \\\n+      --argjson value \"$value\" \\\n+      'map(if .number == $number then .[$field] = $value else . end)' \\\n+      \"$LEDGER\"\n+  )\" || return 1\n+  atomic_write \"$LEDGER\" \"$updated\"\n+}\n+\n+fetch_normalized_children() {\n+  local output\n+  output=\"$(gh api \"repos/$REPO/issues/$PARENT_ISSUE/sub_issues\" --paginate --slurp)\"\n+  printf '%s' \"$output\" |\n+    jq 'if length == 0 then [] elif all(.[]; type == \"array\") then add else . end'\n+}\n+\n+reconcile_failure() {\n+  local exit_code=\"$1\" error_message=\"$2\" children='[]' updated result\n+  trap - ERR\n+  set +e\n+\n+  if [[ -f \"$LEDGER\" ]]; then\n+    children=\"$(fetch_normalized_children 2>/dev/null)\"\n+    if [[ $? -eq 0 ]]; then\n+      updated=\"$(\n+        jq \\\n+          --argjson children \"$children\" \\\n+          'map(.linked = ([ $children[] | select(.id == .id) ] | length > 0))' \\\n+          \"$LEDGER\"\n+      )\"\n+      # Reconcile by comparing each ledger ID against the server child IDs.\n+      updated=\"$(\n+        jq \\\n+          --argjson children \"$children\" \\\n+          'map(. as $entry | .linked = any($children[]; .id == $entry.id))' \\\n+          \"$LEDGER\"\n+      )\"\n+      atomic_write \"$LEDGER\" \"$updated\"\n+    fi\n+  fi\n+\n+  result=\"$(\n+    jq -n \\\n+      --arg error \"$CURRENT_OPERATION: $error_message (exit $exit_code)\" \\\n+      '{\n+        schemaVersion: 1,\n+        status: \"failed\",\n+        ledgerFile: \"creation-ledger.json\",\n+        operationError: $error\n+      }'\n+  )\"\n+  atomic_write \"$RESULT\" \"$result\"\n+\n+  printf 'Stage 20 failed during %s: %s (exit %s)\\n' \\\n+    \"$CURRENT_OPERATION\" \"$error_message\" \"$exit_code\" >&2\n+  if [[ -f \"$LEDGER\" ]] && [[ \"$(jq 'length' \"$LEDGER\" 2>/dev/null)\" -gt 0 ]]; then\n+    jq -r \\\n+      '.[] | \"#\\(.number) | \\(.title) | \\(.url) | \\(.bodyFile) | body_verified=\\(.body_verified) | linked=\\(.linked)\"' \\\n+      \"$LEDGER\" >&2\n+    jq -r \\\n+      '.[] | \"gh issue delete \\(.number) --repo '\\'''\"$REPO\"''\\'' --yes\"' \\\n+      \"$LEDGER\" >&2\n+    printf 'No automatic rollback was performed. Delete every issue in the ledger before invoking this skill again.\\n' >&2\n+  else\n+    printf 'No issues were created; no cleanup is required.\\n' >&2\n+  fi\n+  exit \"$exit_code\"\n+}\n+\n+on_error() {\n+  local exit_code=\"$1\" line=\"$2\"\n+  reconcile_failure \"$exit_code\" \"unexpected command failure at script line $line\"\n+}\n+trap 'on_error \"$?\" \"$LINENO\"' ERR\n+\n+append_ledger_entry() {\n+  local subsection=\"$1\" relative_body=\"$2\" created_json=\"$3\" updated\n+  updated=\"$(\n+    jq \\\n+      --arg subsection \"$subsection\" \\\n+      --arg bodyFile \"$relative_body\" \\\n+      --argjson issue \"$created_json\" \\\n+      '. + [{\n+        implementationSubsection: $subsection,\n+        bodyFile: $bodyFile,\n+        id: $issue.id,\n+        number: $issue.number,\n+        title: $issue.title,\n+        url: $issue.html_url,\n+        body_verified: false,\n+        linked: false\n+      }]' \\\n+      \"$LEDGER\"\n+  )\"\n+  atomic_write \"$LEDGER\" \"$updated\"\n+}\n+\n+create_verify_link() {\n+  local subsection=\"$1\" title=\"$2\" relative_body=\"$3\"\n+  local body_file=\"$LOG/$relative_body\" created issue_number issue_id issue_json attempt linked=false\n+\n+  CURRENT_OPERATION=\"creating $subsection\"\n+  created=\"$(\n+    gh api \"repos/$REPO/issues\" \\\n+      -X POST \\\n+      -f title=\"$title\" \\\n+      -F \"body=@$body_file\" \\\n+      --jq '{id,number,node_id,html_url,title}'\n+  )\"\n+  append_ledger_entry \"$subsection\" \"$relative_body\" \"$created\"\n+  issue_number=\"$(jq -r '.number' <<<\"$created\")\"\n+  issue_id=\"$(jq -r '.id' <<<\"$created\")\"\n+\n+  CURRENT_OPERATION=\"verifying body for issue #$issue_number\"\n+  issue_json=\"$(\n+    \"$BODY_VERIFIER\" \\\n+      \"$REPO\" \\\n+      \"$issue_number\" \\\n+      \"$body_file\" \\\n+      6 \\\n+      5 \\\n+      \"$LOG/issue-$issue_number-body-verification-failure.json\"\n+  )\"\n+  jq -e --argjson number \"$issue_number\" \\\n+    '.number == $number and .state == \"open\" and (.assignees | length == 0)' \\\n+    <<<\"$issue_json\" >/dev/null\n+  update_ledger_flag \"$issue_number\" body_verified true\n+\n+  CURRENT_OPERATION=\"linking issue #$issue_number to parent #$PARENT_ISSUE\"\n+  for attempt in 1 2 3; do\n+    if printf '{\"sub_issue_id\": %s}' \"$issue_id\" |\n+      gh api \"repos/$REPO/issues/$PARENT_ISSUE/sub_issues\" -X POST --input - >/dev/null; then\n+      linked=true\n+      break\n+    fi\n+    sleep 2\n+  done\n+  [[ \"$linked\" == true ]] || return 1\n+  update_ledger_flag \"$issue_number\" linked true\n+}\n+\n+CURRENT_OPERATION='capturing pre-creation children'\n+atomic_write \"$PRE_CHILDREN\" \"$(fetch_normalized_children)\"\n+atomic_write \"$LEDGER\" '[]'\n+atomic_write \"$RESULT\" '{\n+  \"schemaVersion\": 1,\n+  \"status\": \"in_progress\",\n+  \"ledgerFile\": \"creation-ledger.json\",\n+  \"operationError\": null\n+}'\n+\n+create_verify_link \\\n+  '4.1 — Issue 1: Add the application-layer deadline change operation' \\\n+  '4.1 — Add the application-layer deadline change operation' \\\n+  'issue-bodies/01-4-1-body.md'\n+create_verify_link \\\n+  '4.2 — Issue 2: Expose deadline changes through the booking facade' \\\n+  '4.2 — Expose deadline changes through the booking facade' \\\n+  'issue-bodies/02-4-2-body.md'\n+create_verify_link \\\n+  '4.3 — Issue 3: Implement the deadline editor backing model' \\\n+  '4.3 — Implement the deadline editor backing model' \\\n+  'issue-bodies/03-4-3-body.md'\n+create_verify_link \\\n+  '4.4 — Issue 4: Implement the PrimeFaces deadline dialog' \\\n+  '4.4 — Implement the PrimeFaces deadline dialog' \\\n+  'issue-bodies/04-4-4-body.md'\n+create_verify_link \\\n+  '4.5 — Issue 5: Integrate deadline editing into the Administration dashboard' \\\n+  '4.5 — Integrate deadline editing into the Administration dashboard' \\\n+  'issue-bodies/05-4-5-body.md'\n+\n+CURRENT_OPERATION='capturing final children'\n+atomic_write \"$FINAL_CHILDREN\" \"$(fetch_normalized_children)\"\n+\n+CURRENT_OPERATION='verifying child links and order'\n+\"$CHILD_LINK_VERIFIER\" \"$PRE_CHILDREN\" \"$FINAL_CHILDREN\" \"$LEDGER\"\n+\n+CURRENT_OPERATION='verifying final issue postconditions'\n+while IFS=$'\\t' read -r issue_number relative_body; do\n+  issue_json=\"$(\n+    \"$BODY_VERIFIER\" \\\n+      \"$REPO\" \\\n+      \"$issue_number\" \\\n+      \"$LOG/$relative_body\" \\\n+      6 \\\n+      5 \\\n+      \"$LOG/issue-$issue_number-final-body-verification-failure.json\"\n+  )\"\n+  jq -e --argjson number \"$issue_number\" \\\n+    '.number == $number and .state == \"open\" and (.assignees | length == 0)' \\\n+    <<<\"$issue_json\" >/dev/null\n+done < <(jq -r '.[] | [.number, .bodyFile] | @tsv' \"$LEDGER\")\n+\n+CURRENT_OPERATION='writing successful stage result'\n+atomic_write \"$RESULT\" '{\n+  \"schemaVersion\": 1,\n+  \"status\": \"complete\",\n+  \"ledgerFile\": \"creation-ledger.json\",\n+  \"operationError\": null\n+}'\n+\n+trap - ERR\n+jq -e \\\n+  '.status == \"complete\" and .operationError == null and .ledgerFile == \"creation-ledger.json\"' \\\n+  \"$RESULT\" >/dev/null\n+jq -e \\\n+  'length == 5 and all(.[]; .body_verified == true and .linked == true)' \\\n+  \"$LEDGER\" >/dev/null\n+jq -r '.[] | [.implementationSubsection, .number, .title, .url] | @tsv' \"$LEDGER\"\n*** End Patch\n"
```

</details>

```
Added 1 file(s): /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/run-stage20.sh
```


---

<sub>2m 6s</sub>

### `apply_patch`

<details>
<summary>Arguments</summary>

```json
"*** Begin Patch\n*** Update File: 1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/run-stage20.sh\n@@\n     children=\"$(fetch_normalized_children 2>/dev/null)\"\n     if [[ $? -eq 0 ]]; then\n-      updated=\"$(\n-        jq \\\n-          --argjson children \"$children\" \\\n-          'map(.linked = ([ $children[] | select(.id == .id) ] | length > 0))' \\\n-          \"$LEDGER\"\n-      )\"\n-      # Reconcile by comparing each ledger ID against the server child IDs.\n       updated=\"$(\n         jq \\\n           --argjson children \"$children\" \\\n*** End Patch\n"
```

</details>

```
Modified 1 file(s): /home/edburns/workareas/dd-3072166-tricked-out-cargotracker-run-01-shepherd-control/1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/run-stage20.sh
```


---

<sub>2m 20s</sub>

### `bash`

**Create and verify five child issues**

$ bash '1-arrival-deadline-control-remove-before-merge/prompts/shepherd-task-20-20261001-2342/run-stage20.sh'

<details>
<summary>18 lines</summary>

```
{
  "baselineCount": 0,
  "ledgerCount": 5,
  "finalCount": 5,
  "newIssueIds": [
    5670730586,
    5670730826,
    5670731076,
    5670731319,
    5670731532
  ]
}
4.1 — Issue 1: Add the application-layer deadline change operation	2	4.1 — Add the application-layer deadline change operation	https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/2
4.2 — Issue 2: Expose deadline changes through the booking facade	3	4.2 — Expose deadline changes through the booking facade	https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/3
4.3 — Issue 3: Implement the deadline editor backing model	4	4.3 — Implement the deadline editor backing model	https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/4
4.4 — Issue 4: Implement the PrimeFaces deadline dialog	5	4.4 — Implement the PrimeFaces deadline dialog	https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/5
4.5 — Issue 5: Integrate deadline editing into the Administration dashboard	6	4.5 — Integrate deadline editing into the Administration dashboard	https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/6
<shellId: 7 completed with exit code 0>
```

</details>


---

<sub>2m 23s</sub>

### Copilot

Created and verified five ordered, unassigned child issues under #1. All issue bodies match persisted drafts, child links/order passed the supplied verifier, and `stage-20-result.json` is `complete`.

| Subsection | Issue | Title |
|---|---:|---|
| 4.1 | [#2](https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/2) | Add the application-layer deadline change operation |
| 4.2 | [#3](https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/3) | Expose deadline changes through the booking facade |
| 4.3 | [#4](https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/4) | Implement the deadline editor backing model |
| 4.4 | [#5](https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/5) | Implement the PrimeFaces deadline dialog |
| 4.5 | [#6](https://github.com/edburns/dd-3072166-tricked-out-cargotracker-run-01/issues/6) | Integrate deadline editing into the Administration dashboard |

**Given list:** `2,3,4,5,6`

**Suggested stage 25 invocation:** Invoke `shepherd-task-25-given-list` with repository `edburns/dd-3072166-tricked-out-cargotracker-run-01`, ordered issues `2,3,4,5,6`, and plan directory `1-arrival-deadline-control-remove-before-merge`. Campaign mode will be derived from the manifest.

The issues were created **without an issue type** because the repository is user-owned and organization issue types are unavailable.

---

<sub>Generated by [GitHub Copilot CLI](https://github.com/features/copilot/cli)</sub>
