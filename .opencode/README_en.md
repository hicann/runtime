# Runtime Repository Agent Skills Planning

## Runtime Repository Skills List

> **Note**: In the list, `[x]` indicates that the skill is ready, and `[ ]` indicates that the skill is still in planning and has not been implemented yet.

- [x] **gitcode-issue** — Read Issue details, read and reply to comments. Trigger command: `Read issue 168 and submit pr to fix`
- [x] **gitcode-pr** — Create PR, cherry-pick code to commercial branches. Trigger command: `Review pr 1437` or `Create pr to develop branch`
- [ ] **superpowers** — Requirement development (generate software design documents, coding, generate test cases). Trigger command: `Develop requirement, requirements...`
- [x] **runtime-code-review** — Review local code and GitCode PR following various coding standards and module software design constraints
- [x] **runtime-errmsg-rectification** — Runtime Error Message rectification: review error codes, reporting macros, error messages, and reporting boundaries. Trigger command: `Perform Error Message rectification` or `Review Error Message reporting correctness`
- [x] **errmsg-ut-setup** — Set up an ErrMsg real-reporting UT verification framework, allowing `ErrorManager::ATCReportErrMessage` to call the real implementation and print formatted ErrMsg. Trigger command: `Verify ErrMsg reporting rectification result` or `Run ErrMsg UT verification`
- [ ] **gitcode-pipeline** — Trigger pipeline tasks, query pipeline status, get failed task logs
- [ ] **runtime-dt-runner** — Compile and execute UT/ST test cases
- [ ] **runtime-tester** — Generate test cases, execute test cases in environments with NPU
- [ ] **api-doc-generator** — Generate documentation for external APIs
- [ ] **install-cann-toolkit** — Download latest CANN toolkit package and install

## Agent Supported Workflows

- Requirement development: Complete the entire workflow from software design to coding and verification. Use gitcode-pr to submit PR, personally review code, use gitcode-pipeline to trigger pipeline, and periodically get results. If the pipeline fails, you can get the corresponding failed task logs, locally modify code, and resubmit PR to monitor the pipeline.
- Issue fix: Modify code, and the subsequent PR submission workflow is the same as above.
- Resolve issue: Use gitcode-issue to read issue and comments. If code or document modifications are involved, the workflow is the same as above.
- Execute test cases or samples: Use runtime-test to execute test cases in real environments

## Runtime Repository Skills Path

- Project team shared, hoping to achieve default installation or update when starting agent
- Skills only used in runtime repository can be directly submitted to the runtime repository `.claude/skills` directory
- Skills shared across multiple repositories have source code in a public repository (currently https://gitcode.com/cann-agent/skills). When starting agent, skills will be automatically downloaded or updated to the `.claude/skills` directory

> **Note**: Cross-repository shared skills like `gitcode-issue` and `gitcode-pr` are not maintained in the Runtime repository's `.claude/skills` directory. Their source code is stored in a public repository. When starting an agent in the runtime directory, they will be automatically downloaded and installed to the local `.claude/skills` directory.

## Agent Auxiliary Workflow
```mermaid
flowchart TB
    subgraph Entry Nodes
        A1[Requirement Development]
        A2[Issue Fix]
        A3[Issue Handling]
    end

    subgraph Decision
        B1{Need<br/>code changes?}
        B2{Need<br/>design phase?}
    end

    subgraph Design Phase
        C1[Software Design<br/>Requirement Specification]
    end

    subgraph Coding Verification Phase
        D1[Write Code]
        D2[Execute ut/st]
        D3[runtime-code-review<br/>agent review code]
        D4[runtime-tester<br/>local verification]
    end

    subgraph PR Workflow
        E1[gitcode-pr<br/>Create PR]
        E2[Personal Code Review]
        E3[gitcode-pipeline<br/>Trigger Pipeline]
        E4[gitcode-pipeline<br/>Periodically Get<br/>Pipeline Results]
    end

    subgraph Pipeline Result Handling
        F1{gitcode-pipeline<br/>Pipeline<br/>passed?}
        F2[gitcode-pipeline<br/>Get Failed<br/>Task Logs]
        F3[Agent Local Fix]
    end

   subgraph Push Code
        I1[gitcode-pr<br/>Submit Code]
    end

    subgraph Complete
        H1[Workflow End]
    end

    %% Entry to Decision
    A1 --> B2
    A2 --> B1
    A3 --> B1

    %% Design Decision
    B2 -->|Yes| C1
    B2 -->|No| D1
    C1 --> D1

    %% Coding Decision
    B1 -->|Yes| D1
    B1 -->|No| H1

    %% Coding to PR
    D1 --> D2
    D2 --> D3
    D3 --> D4
    D4 --> E1

    %% PR Workflow
    E1 --> E2
    E2 --> E3
    E3 --> E4
    E4 --> F1

    %% Pipeline Result Handling
    F1 -->|Pass| H1
    F1 -->|Fail| F2
    F2 --> F3
    F3 --> I1
    I1 --> E3

```