# Turing Solution Platform Development Department Agent Skill Development Specification V1.0

## 1 Overview

### 1.1 Purpose and scope

This specification unifies the design, authoring, testing, review, release, and maintenance requirements for general-purpose Agent Skills in the Turing Solution Platform Development Department. It directly governs Agent Skill deliverables and their development, review, and maintenance activities, and primarily targets Skill developers and maintainers.

Requirements that are common across components and can be executed uniformly belong to this specification. Requirements that apply only to a specific repository, such as the Skill name prefix, tool commands, file formats, and business processes used by a specific module, are defined by the component internal specification.

A component specification can add component-specific requirements and reference the common rules in this specification by rule number. It must not copy common rules and modify them independently.

### 1.2 Skill ownership and maintenance location

Determine ownership before creating a Skill:

| Skill type                           | Official maintenance location        | Applicable specification   |
| ---------------------------------- | ------------- | ------ |
| General Skill reused across repositories and independent of a single component's internal implementation          | `cannbot` repository | This specification    |
| Component-specific Skill that serves only a single component, or depends on the component's internal code, process, and environment | Corresponding component repository       | Component internal specification |

Do not maintain duplicate official versions of general Skills in component repositories. This specification does not force component-specific Skills into `cannbot`. When a component repository needs a general Skill, install or reference only the official version in `cannbot`. When ownership is unclear, first have a manual review confirm the maintenance repository and owner, then start development.

### 1.3 Rule levels and exceptions

Rules in Chapter 2 and later chapters use the following two levels:

| Level | Meaning |
| --- | --- |
| Requirement | Admission condition; merge and release are not allowed when it is not met |
| Recommendation | Default practice; when not adopted, explain the reason and alternative measures in the review material |

Rule applicability and level can be determined during review based on the specific scenario and risk. When downgrading a "requirement" to a "recommendation", record the rule number, scope of application, rationale, impact, and review conclusion.

### 1.4 Specification conflicts

General Skills first comply with the security, compatibility, and contribution specifications of the `cannbot` repository, then comply with this specification, the Agent Skills open specification, and the target Agent platform official specification in order. Component-specific Skills first comply with the security, compatibility, and contribution specifications of the component repository and the component internal specification, then comply with the open format requirements.

This specification does not replace component internal specifications, and component internal specifications do not change the merge conditions of general Skills in `cannbot`. When a conflict occurs, the review material must record the conflict source, scope of application, and resolution.

### 1.5 Skill content organization

Skill content is divided into three layers:

1. **Discovery layer**: `name` and `description`, used to decide whether to invoke the Skill;
2. **Execution layer**: the `SKILL.md` body, that is, the Markdown content after the YAML frontmatter ends, used to store the core workflow, boundaries, decision conditions, and completion criteria;
3. **Resource layer**: `references/`, `scripts/`, and `assets/`, read or executed as the task requires.

Write invocation conditions in `description`. Write detailed steps in the `SKILL.md` body. Split conditional material and deterministic operations into resource directories by purpose. Later chapters define the specific requirements for the three layers of content.

### 1.6 Rule numbering

Rule numbers use `G.<Element>.<Number>`:

- `G` is the first letter of Guideline and indicates a rule;
- `Element` is a three-letter English abbreviation of the rule category. The specific values and meanings are listed in the following table;
- `Number` is the sequence number of the rule within its category. It increments from 1 and uses two Arabic numerals, padded with a leading 0 when fewer than two digits. For example, the first rule in the creation condition category is numbered `G.CRE.01`.

Define each clause in only one chapter. Other chapters reference it by number and do not copy the clause content. Each rule must clearly state the responsible party or regulated object, and independently explain who executes what requirement at what stage. When referencing other rules, this rule must still retain the complete core requirement.

| Category | Content |
| --- | --- |
| `CRE` (Creation) | Creation conditions, task boundaries, input and output |
| `STR` (Structure) | Directories, files, and links |
| `MET` (Metadata) | Naming, frontmatter, and invocation conditions |
| `BOD` (Body) | `SKILL.md` body and execution workflow |
| `RES` (Resources) | references, assets, and dependencies |
| `SCR` (Scripts) | scripts, parameters, output, and tests |
| `SRC` (Sources) | Information sources and maintenance |
| `SEC` (Security) | Security, permissions, and data |
| `EVL` (Evaluation) | Evaluation, tests, and metrics |
| `REL` (Release) | Development, change regression, and release |
| `MNT` (Maintenance) | Maintenance, versions, and decommission |

## 2 Skill creation conditions and task boundaries

### 2.1 Creation conditions

#### G.CRE.01 Prove a real capability gap before creation

**【Level】** Requirement

**【Description】**

Before adding a Skill, use real task records to prove that the Agent repeatedly makes errors, omissions, unnecessary follow-up questions, or inconsistent results. Do not add a Skill without a reproducible capability gap.

Every Skill adds invocation conflicts and loading cost. Do not create a Skill only because some explanation can be written as a Skill.

#### G.CRE.02 Prefer an appropriate hosting location

**【Level】** Requirement

**【Description】**

Before creating a Skill, determine whether a Skill should host the content based on the content's effective scope and usage:

| Content | Location |
| --- | --- |
| Short rules that always apply across the repository | `AGENTS.md` |
| Stable specifications for human readers | `docs/` or official repository documentation |
| Multi-step workflows under a specific user intent | Skill |
| Real-time external system capabilities | MCP, CLI, or API |
| Complex orchestration with multiple roles and long state | Agent, workflow, or plugin |

After deciding that a Skill hosts the content, choose the corresponding file or directory based on the content purpose:

| Skill content | File or directory |
| --- | --- |
| Name, invocation conditions, core workflow, task boundaries, and completion conditions | `SKILL.md` |
| Detailed material read only under specific conditions | `references/`, see `G.RES.01` to `G.RES.03` for specific requirements |
| Deterministic, repetitive operations | `scripts/`, see `G.SCR.01` to `G.SCR.05` for specific requirements |
| Static files copied or processed during output | `assets/`, see `G.RES.04` for specific requirements |
| Evaluation cases | `evals/`, see `G.EVL.01` for creation conditions |
| Platform adaptation configuration | `agents/`, see `G.MET.05` for specific requirements |

Create only the directories the task actually needs, and follow `G.STR.03` for the directory structure.

### 2.2 Task boundaries

#### G.CRE.03 One Skill handles only one primary user intent

**【Level】** Requirement

**【Description】**

A Skill can cover the design, execution, and verification steps under the same user intent, but must not mix unrelated tasks. Split multiple independent intents into composable Skills or delegate them to workflow orchestration.

#### G.CRE.04 Define the operation boundaries of different tasks

**【Level】** Requirement

**【Description】**

The `SKILL.md` body defines the delivery boundary by task type and sets the default permissions per `G.SEC.01`:

- Diagnostic Skill: when the user only asks for the root cause, do not perform a fix;
- Code review Skill: report only evidence, impact, and recommendations; do not modify files by default;
- Test Skill: fix only issues within the scope of this test, and distinguish product defects from test defects;
- Development Skill: complete the implementation and run the build, tests, and checks corresponding to the change scope; do not treat "code generated" as completion.

#### G.CRE.05 State the responsibility scope and adjacent boundaries

**【Level】** Requirement

**【Description】**

The `SKILL.md` body states the tasks it is responsible for, the tasks it is not responsible for, and the division of labor with adjacent Skills. It also specifies that for requests beyond the responsibility boundary, the Agent must not change the task goal or execute other tasks. When existing information cannot determine a unique choice, ask only the key questions that change the result.

When creating or modifying a Skill, check only the registered Skills that may handle the same user request. A Skill qualifies as an adjacent Skill when it meets any of the following conditions:

- belongs to the same domain or module;
- handles the same or similar task objects;
- accepts the same type of input or produces the same type of output;
- the invocation scenarios or user expressions in `description` overlap.

First search for candidates through the Skill index and the `name` and `description` in the repository. Do not analyze every Skill one by one. When an adjacent Skill is found, state the division of responsibilities and verify the invocation boundary with negative cases. When no candidate is found, do not invent an adjacent Skill.

### 2.3 Input, output, and completion conditions

#### G.CRE.06 Define output, stop conditions, and completion criteria

**【Level】** Requirement

**【Description】**

The `SKILL.md` body describes the output content. When generating files, it describes the save location. It also describes the build, tests, or checks to run before completion, and the stop conditions and failure output when work cannot continue. Define the completion condition as: the user task is actually complete and passes the build, tests, and checks corresponding to the task scope. Do not define "report output" or "code generated" directly as completion.

## 3 Directories and files

### 3.1 Standard directories

#### G.STR.01 A Skill maintains only one official version

**【Level】** Requirement

**【Description】**

General Skills maintain the official version in `.agents/skills/<skill-name>/` of the `cannbot` repository. Component-specific Skills maintain the official version in `.agents/skills/<skill-name>/` of the corresponding component repository. A Skill can have only one official maintenance location. Platform directories such as `.claude/skills/` can store only auto-generated copies, verified links, or adaptation files that contain only platform differences. Do not manually copy the complete `SKILL.md` body and modify each copy separately.

#### G.STR.02 Use the required entry file and a non-empty `SKILL.md` body

**【Level】** Requirement

**【Description】**

Each Skill root directory contains `SKILL.md` with exactly matching case. The file starts with parseable YAML frontmatter, and the `SKILL.md` body is non-empty.

#### G.STR.03 Create only directories that are actually used

**【Level】** Requirement

**【Description】**

A standard Skill can contain the following directories as needed:

```text
<skill-name>/
├── SKILL.md
├── references/          # Optional: material the Agent reads conditionally
├── scripts/             # Optional: executable scripts
├── assets/              # Optional: static resources for output
├── evals/               # Created per G.EVL.01: evaluation cases for this Skill
└── agents/              # Optional: platform adaptation configuration
```

Optional directories must not be empty when they exist, and do not commit placeholder files such as `.gitkeep`. Use plural directory names. Do not create `reference/`, `script/`, or `asset/`.

Follow `G.EVL.01` for the creation conditions and minimum case requirements of `evals/`.

#### G.STR.04 Do not add extra description documents inside a Skill

**【Level】** Requirement

**【Description】**

Do not add a separate `README.md`, `CHANGELOG.md`, installation manual, or quick reference manual inside a Skill. Write Skill usage instructions in `SKILL.md` or `references/`. Maintain change history through Git or the repository release system.

### 3.2 Files and links

#### G.STR.05 Use relative paths and ensure links are valid

**【Level】** Requirement

**【Description】**

Links inside a Skill use relative paths and forward slashes from the Skill root directory. Relative links point to committed files. External links are accessible to the target users and execution environment.

#### G.STR.06 Use consistent text encoding and clean up unrelated files

**【Level】** Requirement

**【Description】**

Text files inside a Skill use UTF-8. Line endings and script execution permissions follow the rules of the containing repository. Do not commit editor backups, build results, runtime state, temporary files, or unreplaced template placeholders.

Documentation can use defined parameter placeholders, such as `{model_name}`. Explain the meaning of a placeholder on the same page.

#### G.STR.07 Check explicit dependencies and reference synchronization

**【Level】** Requirement

**【Description】**

When declaring explicit Skill, Agent, or workflow dependencies, check that the dependency objects exist and that the dependency graph has no cycles. When a regular Skill has no dependency field, do not add platform-specific fields just for the check.

After adding or removing a Skill or changing a Skill name, update the index, dependencies, platform configuration, script paths, and related Agent names accordingly.

## 4 Naming, metadata, and invocation conditions

### 4.1 Skill naming

#### G.MET.01 Use a valid and identifiable Skill name

**【Level】** Requirement

**【Description】**

`name` meets the following conditions:

- no more than 64 characters in length;
- contains only lowercase English letters, digits, and hyphens;
- does not start or end with a hyphen and does not contain consecutive hyphens;
- matches the Skill directory name character by character;
- is globally unique within the repository (auto-generated compatibility copies are not counted repeatedly).

#### G.MET.02 Skills strongly related to a module use a unique module prefix

**【Level】** Requirement

**【Description】**

Global general Skills and repository-wide general Skills do not require a module prefix. Skills strongly related to a specific module implementation, interface, or process use a "module prefix + behavior or object" name. The component specification defines a unique prefix for each module.

#### G.MET.03 Avoid vague names

**【Level】** Recommendation

**【Description】**

Skill names should describe the specific capability. The "domain + action or object" form is recommended. Names should avoid vague words such as `helper`, `tools`, and `common`, and should not use only an internal class name or directory name.

### 4.2 `frontmatter` fields

#### G.MET.04 Use parseable standard frontmatter

**【Level】** Requirement

**【Description】**

`SKILL.md` starts with YAML frontmatter wrapped by `---`. Public Skills explicitly declare `name` and `description`.

frontmatter supports the following fields:

| Field              | Required  | Constraint                                                           |
| --------------- | --- | ------------------------------------------------------------ |
| `name`          | Yes   | No more than 64 characters; use only lowercase letters, digits, and hyphens; match the Skill directory name exactly. See `G.MET.01` for details. |
| `description`   | Yes   | No more than 1024 characters; describe the Skill function and invocation conditions. See `G.MET.06` for details.             |
| `license`       | No   | Use a short license name, or reference a license file in the Skill directory.                              |
| `compatibility` | No   | No more than 500 characters; fill in only when the Skill has explicit requirements on the target product, system packages, network access, or runtime environment.          |
| `metadata`      | No   | Keys and values are strings, used to record additional attributes not covered by standard fields; does not require `version`.                   |

`license`, `compatibility`, and `metadata` are optional descriptive fields. A Skill must not rely on the target platform's parsing result of these fields to control invocation, permissions, or the execution workflow.

```yaml
---
name: ascendc-kernel-reviewer
description: Review the correctness and performance of Ascend C Kernels. Use when the user submits Kernel source code or requests analysis of memory transfer, Tiling splitting, pipeline parallelism, and performance reports.
license: Apache-2.0
compatibility: Requires the CANN toolchain and the Ascend NPU runtime environment
metadata:
  owner: npu-infra
---
```

When a new common frontmatter field is genuinely required, first define its name, type, whether it is mandatory, default value, and compatible behavior in the `cannbot` specification, and add corresponding parsing and validation tests. Do not write fields that the specification and validator do not yet support into the public `SKILL.md`.

#### G.MET.05 Isolate platform-specific fields

**【Level】** Requirement

**【Description】**

Write invocation parameters, tool permissions, interface presentation, and execution policies that affect only a specific platform into the corresponding platform adaptation file, not the public `SKILL.md`. Platform adaptation files must not change the Skill task scope, invocation conditions, permission boundary, and completion criteria.

For example, `allowed-tools` is supported by only some platforms and is a platform-specific field. When tool permissions need to be configured, write that configuration into the target platform adaptation file.

### 4.3 Authoring `description`

#### G.MET.06 `description` states the core task, representative trigger scenarios, and key boundaries

**【Level】** Requirement

**【Description】**

`description` is an invocation rule, not marketing copy or a summary of the `SKILL.md` body. The content briefly states the Skill core task and output, representative user trigger scenarios, and the key boundaries most easily confused with other Skills.

Do not exhaustively list all user expressions, inapplicable scenarios, or exception branches in `description`. Write the complete responsibility boundary and known limitations in the `SKILL.md` body. Maintain more positive and negative expressions and their expected results in `evals/`.

Place key intents at the front, and keep the length of `description` within 1024 characters.

#### G.MET.07 `description` and the `SKILL.md` body use consistent terminology

**【Level】** Requirement

**【Description】**

The task names, object names, and boundary terms in `description` are consistent with the `SKILL.md` body. Do not use multiple names for the same concept.

#### G.MET.08 Maintain the invocation boundary with positive and negative cases

**【Level】** Requirement

**【Description】**

When adding or modifying `description`, regenerate the positive and negative cases for that Skill.

## 5 `SKILL.md` body and execution workflow

### 5.1 `SKILL.md` body content

#### G.BOD.01 The `SKILL.md` body contains only the core information the task needs

**【Level】** Requirement

**【Description】**

The `SKILL.md` body uses direct, executable statements and focuses on domain rules, decision conditions, the execution workflow, and easily missed cases. Do not explain general basic knowledge such as Git, programming languages, Markdown, or shell, and do not replace specific rules with role descriptions such as "you are a top expert in a domain".

#### G.BOD.02 The `SKILL.md` body must contain complete task information

**【Level】** Requirement

**【Description】**

The `SKILL.md` body is not required to follow fixed headings. Include the following as applicable:

- required input and prerequisites;
- information sources used;
- work steps;
- decision conditions, branches, and exceptions;
- output, stop conditions, and completion checks;
- known limitations and common errors;
- resources read or executed as needed.

Do not create empty chapters for inapplicable content.

### 5.2 Steps, branches, and exceptions

#### G.BOD.03 State input, action, decision criteria, and output for each key step

**【Level】** Requirement

**【Description】**

Each key step in the `SKILL.md` body states: what input to use, what action to perform, what criteria to judge by, and what output to produce. Complex rules should provide a minimal command, input snippet, or output snippet so that the result can be checked against it.

### 5.3 Parameters

#### G.BOD.04 Describe parameters in natural language and do not depend on a specific platform

**【Level】** Requirement

**【Description】**

The `SKILL.md` body uses natural language to describe how to identify parameters and must not directly depend on host placeholders such as `$0` and `$ARGUMENTS`. Platform adaptation files are responsible for converting platform explicit parameters into the required input.

### 5.4 Size and on-demand loading

#### G.BOD.05 Control the number of lines in SKILL.md

**【Level】** Requirement

**【Description】**

The entire `SKILL.md` is no larger than 500 lines.

#### G.BOD.06 Define the read conditions for auxiliary files

**【Level】** Requirement

**【Description】**

The `SKILL.md` body directly states under what conditions to read which `references/` file or execute which script. Do not require the Agent to load the entire resource directory at startup. Follow `G.RES.02` for the reference hierarchy of reference files.

#### G.BOD.07 The `SKILL.md` body must not contain time-sensitive, version-sensitive, or other easily outdated information

**【Level】** Requirement

**【Description】**

Explanations in the `SKILL.md` body and `references/` intended for long-term maintenance must not directly contain easily outdated information such as fixed dates, fixed version numbers, temporary version status, quotas, image addresses, or personnel lists. When task execution genuinely needs version, address, quota, or owner information, read it from the official repository configuration, dependency files, or maintenance list, and reference the corresponding path.

Version information used to describe the compatibility scope, lock dependencies, or reproduce actual test results should be recorded in the corresponding configuration or evidence and is not covered by the prohibition in this rule.

## 6 References, scripts, resources, and dependencies

### 6.1 `references/`

#### G.RES.01 `references/` holds only detailed material read conditionally

**【Level】** Requirement

**【Description】**

`references/` is used only to store domain knowledge, rules, and description documents that the Agent needs to read only under specific conditions. Each reference file covers only one topic, and its file name describes the content.

Do not put rules that the Agent needs to understand into `assets/`. Do not create a separate reference file for content that a few sentences in `SKILL.md` can state clearly.

#### G.RES.02 `SKILL.md` must directly reference required reference files

**【Level】** Requirement

**【Description】**

`SKILL.md` directly references the reference files required to execute the task. Non-required extended material can continue to navigate through a first-level index, but do not put key rules only in second-level or deeper references. Longer reference files should provide a table of contents or search keywords.

#### G.RES.03 Reference official material and do not maintain duplicate copies

**【Level】** Requirement

**【Description】**

When the repository already has a coding specification, design description, interface document, or template, reference the official file in the Skill and do not copy the official file content. When an external offline copy is genuinely required, record the source, license, version or commit, synchronization date, and update responsibility.

### 6.2 `scripts/`

#### G.SCR.01 Add scripts only for deterministic and repetitive operations

**【Level】** Recommendation

**【Description】**

Prefer scripts when an operation needs a stable result, runs repeatedly, is prone to manual errors, or suits machine validation. Do not add an extra script for a one-time simple operation that clear instructions can already complete stably.

#### G.SCR.02 A script must have a clear execution entry point and declare dependencies

**【Level】** Requirement

**【Description】**

An executable script can run independently of the Agent. The code, configuration, and dependencies the script needs are provided with the Skill or explicitly declared. The script is self-contained, or declares the runtime environment, external dependencies, and verified versions in the file header, a dependency file, or the `SKILL.md` body.

When the script has explicit dependencies, state the dependency name, purpose, version requirement, and verified version. Use exact versions for execution environments that need full reproduction. When a version range is allowed, also record the verified version.

#### G.SCR.03 Script parameters and run entry points must be clear

**【Level】** Requirement

**【Description】**

The script file name states the responsibility and follows the naming rules of the containing repository. Do not use names that cannot indicate the purpose, such as `script1.py` and `utils.py`. Parameter names should be stable with clear semantics. The `SKILL.md` body states the execution entry point, required parameters, and output purpose.

Prefer reusing existing repository environment variables. When adding an environment variable or switch, state its meaning, value range, and default behavior.

#### G.SCR.04 Scripts must not hard-code private environments or directly execute remote content

**【Level】** Requirement

**【Description】**

Pass paths through Skill-root-relative paths, parameters, or declared environment variables. Do not hard-code personal directories, HOME, installation directories, or platform Skill directories. Scripts must not contain keys, tokens, personal addresses, or unrelated internal service addresses. Do not use `curl | bash`, `iwr | iex`, or similar methods to directly execute unreviewed remote content.

#### G.SCR.05 Scripts must have tests and usage instructions

**【Level】** Requirement

**【Description】**

Provide corresponding tests for scripts, and follow `G.EVL.02` for the specific coverage items. The review material provides the actual run results of the script and describes the invocation scenario, input, and output.

When adding a script, follow the copyright header and license rules of the containing repository. When adapting third-party code, retain the source and upstream copyright.

### 6.3 `assets/`

#### G.RES.04 `assets/` holds only static resources needed for output

**【Level】** Requirement

**【Description】**

`assets/` holds only static resources that are directly copied or processed when generating output, such as templates, code skeletons, icons, and fonts. Put rules and description documents that the Agent needs to read and understand into `references/`, not `assets/`.

Do not commit temporary files, build artifacts, or unreviewed executable binaries in `assets/`. Static binary templates required by the task can be committed. Check their source, license, size, and security before committing.

## 7 Information sources and maintenance

### 7.1 Information sources

#### G.SRC.01 A Skill must declare the information sources the task depends on

**【Level】** Requirement

**【Description】**

The `SKILL.md` body describes the repository specifications, code, tests, build files, official documentation, or other material the task depends on. The component specification defines component-specific information sources and their priority.

### 7.2 External material and knowledge maintenance

#### G.SRC.02 Maintain only one official source for each piece of domain knowledge

**【Level】** Requirement

**【Description】**

Designate a single official maintenance location and owner for long-term domain rules, and reference that location in the Skill. Do not maintain the same content separately in multiple Skills. When the source becomes invalid, the API changes, or the directory is adjusted, update the references and compatibility tests. When the source can no longer be maintained, stop referencing it. When no alternative source can be found, decommission the related Skill.

## 8 Security, permissions, and data

### 8.1 Least privilege and task scope

#### G.SEC.01 Use the least privilege required to complete the task by default

**【Level】** Requirement

**【Description】**

Knowledge query, architecture analysis, diagnosis, and code review Skills limit the default operation scope to read-only in the `SKILL.md` body. Modification Skills limit the writable scope to repository files involved in the user request in the `SKILL.md` body, and state the least privilege required to complete the task.

### 8.2 High-risk operations

#### G.SEC.02 High-risk Skills must set runtime authorization checkpoints

**【Level】** Requirement

**【Description】**

Skills that involve remote writes, software or dependency installation, system configuration changes, administrator operations, deletion, overwrite, file moves, or other hard-to-recover operations mark high-risk steps in the `SKILL.md` body and set explicit runtime authorization checkpoints.

The `SKILL.md` body specifies: before executing a high-risk step, check whether the user authorization covers the operation target, scope, and impact; after execution, verify the actual result. Do not define command parameters or script confirmation options as user authorization.

### 8.3 Sensitive information

#### G.SEC.03 Keys and sensitive information must not be written into Skills, repositories, or output

**【Level】** Requirement

**【Description】**

Do not write tokens, passwords, certificate private keys, or other sensitive information into frontmatter, the `SKILL.md` body, scripts, evaluation samples, repository files, or prompts, logs, reports, and uncontrolled temporary files generated during development. When a Skill genuinely needs sensitive information, the `SKILL.md` body or script specifies reading it from a controlled key store or controlled input, and masks the output.

### 8.4 Workspace and content restrictions

#### G.SEC.04 Temporary artifacts must not pollute the Skill directory

**【Level】** Requirement

**【Description】**

For Skills that generate temporary files, external repositories, reports, or build results, the `SKILL.md` body or script specifies writing these contents to the repository agreed directory or a temporary directory, not the Skill source directory. When the task completes, describe the files added, modified, retained, and not cleaned up. Skill deliverables must not depend on global files on the developer machine to run.

#### G.SEC.05 A Skill must not change user default behavior

**【Level】** Requirement

**【Description】**

The `SKILL.md` body and scripts must not require the Agent to enable third-party plugins, modify the Agent default configuration, or change the default behavior of the user environment without authorization.

## 9 Evaluation and testing

### 9.1 Evaluation preparation and cases

#### G.EVL.01 Provide at least one positive and one negative evaluation case

**【Level】** Requirement

**【Description】**

When adding a Skill or modifying content that affects Skill behavior, create `evals/` with at least 1 positive case and 1 negative case, and provide the corresponding verification results. A positive case verifies that the Skill works normally in applicable tasks. A negative case verifies that the Skill does not handle requests outside its scope. The component specification can require more cases based on component risk.

### 9.2 Script cases

#### G.EVL.02 Script cases cover interfaces and side effects

**【Level】** Requirement

**【Description】**

When adding a script or modifying a script input or output, provide at least 1 normal input case and 1 abnormal input case, with the corresponding verification results. Provide actual run results and usage instructions per `G.SCR.05`.

## 10 Review and release

### 10.1 Development process

#### G.REL.01 Develop Skills in an evaluation-first order

**【Level】** Recommendation

**【Description】**

Develop a Skill in the following order: record the real problem, determine boundaries and permissions, write the minimum evaluation cases first, then write `description`, the `SKILL.md` body, and resources. After completing applicable checks and evaluation, submit for review.

### 10.2 Change regression

#### G.REL.02 Run affected regression after a change

**【Level】** Requirement

**【Description】**

When modifying `description`, permission boundaries, script side effects, or the core workflow, run the full regression within the affected scope. When only modifying wording, also judge whether it changes invocation, terminology, or completion criteria, and run the corresponding cases. After adding or removing a Skill or changing a Skill name, also check all references per `G.STR.07`.

### 10.3 Release and installation

#### G.REL.03 Release content contains only files needed for running, maintenance, and validation

**【Level】** Requirement

**【Description】**

A Skill release package can contain only the files needed to run, maintain, and validate the Skill, including `SKILL.md`, actually used scripts, references, static resources, platform adaptation files, and evaluation files, and it complies with the directory structure defined in `G.STR.03`. Check unrelated files per `G.STR.04`, `G.STR.06`, and `G.RES.04`, and check licenses and third-party sources per `G.SCR.05`, `G.RES.03`, and `G.RES.04`.

#### G.REL.04 Validate discovery and invocation after installation

**【Level】** Requirement

**【Description】**

After installation or synchronization, verify that the target Agent can discover the Skill, parse the frontmatter, invoke it correctly, and access the required resources. When performing a cross-repository installation, record the upstream version and checksum.

## 11 Maintenance, versions, and decommission

### 11.1 Versions and compatibility

#### G.MNT.01 Use version identifiers as release needs require

**【Level】** Recommendation

**【Description】**

The common specification does not require each Skill to have an independent version number. When independent release, cross-repository installation, or compatibility management is needed, use a string version, tag, or commit to identify the version.

#### G.MNT.02 Compatibility descriptions must be truthful and verifiable

**【Level】** Requirement

**【Description】**

Compatibility descriptions can record only verified environment requirements that affect operation. When the support scope changes, update the compatibility description, known limitations in the `SKILL.md` body, dependency versions, and cross-platform tests accordingly. Do not write an unverified platform as supported.

### 11.2 Decommission and merge

#### G.MNT.03 Decommission or merge a Skill when conditions are met

**【Level】** Recommendation

**【Description】**

Evaluate decommissioning or merging a Skill in the following cases:

- the capability is stably covered by the model, system prompt, `AGENTS.md`, or a unified tool;
- it has not been used for a long time and has high loading cost;
- it duplicates another Skill and cannot establish a clear boundary;
- the domain knowledge is outdated and has no maintainer;
- security or maintenance cost exceeds the actual benefit.

Before decommissioning a Skill, confirm through regression that the alternative stably covers the original task.

## Appendix A Minimal Skill sample

### A.1 Minimal directory

```text
.agents/skills/report-reviewer/
├── SKILL.md
├── references/
│   └── review-checks.md
└── evals/
    └── routing-cases.yaml
```

Create only the directories actually needed. The example above has no scripts or output resources, so it does not create `scripts/` or `assets/`.

### A.2 Minimal SKILL.md

```markdown
---
name: report-reviewer
description: Review the factual basis, structure, and conclusions of a technical report, and output check results with original text locations. Use when the user submits a report or requests a content review; do not rewrite the report directly, and do not generate a new report.
---

# Technical report review

## Input and prerequisites

- The target report;
- The writing and fact-source requirements applicable to the current repository;
- The intended readers. Ask the user only when the material cannot confirm it and it affects the conclusion.

## Workflow

1. Read the target report and determine the scope of facts, inferences, conclusions, and recommendations.
2. When the report contains technical conclusions, read `references/review-checks.md`.
3. Select applicable check items per the component specification. Record the path, symbol, conclusion, and unverified reason for each item.
4. Stay read-only and do not modify files. When a fix is needed, first explain the scope to the user and obtain explicit instructions.

## Acceptance criteria

- Every issue has reviewable evidence;
- Facts, inferences, and unverified items are separated;
- No applicable fact or structure check is missed;
- There are no unauthorized write operations.

## Known limitations

- When source data is missing, do not claim that the values in the report are verified.
```

The minimal sample demonstrates only the structure and does not replace component business rules. An actual Skill does not need to create empty chapters for inapplicable content.

## Appendix B Development, evaluation, and release checklist

### B.1 Creation and design

- [ ] There is a reproducible real task gap (`G.CRE.01`).
- [ ] Confirmed that Skill is the appropriate hosting location (`G.CRE.02`).
- [ ] The primary user intent, adjacent boundaries, permissions, and completion conditions are clear (`G.CRE.03` to `G.CRE.06`).
- [ ] `name` is valid, unique, and consistent with the directory (`G.MET.01`).
- [ ] `description` states the task, trigger scenarios, and boundaries (`G.MET.06` to `G.MET.08`).

### B.2 Authoring and testing

- [ ] The `SKILL.md` body is non-empty, and the entire file is no more than 500 lines (`G.STR.02`, `G.BOD.05`).
- [ ] The directory structure, relative links, dependencies, and platform files comply with `G.STR.03` to `G.STR.07`; the target platform can discover and invoke the Skill, per `G.REL.04`.
- [ ] Each key step has input, action, decision criteria, and output (`G.BOD.03`).
- [ ] References, scripts, static resources, and dependencies are placed by purpose (Chapter 6).
- [ ] Information sources and official maintenance locations comply with `G.SRC.01` to `G.SRC.02`.
- [ ] Permission, security, sensitive data, and workspace checks pass (Chapter 8).
- [ ] There is at least one positive and one negative evaluation case with verification results (Chapter 9).

### B.3 Review and release

- [ ] Affected invocations, scripts, permissions, and references have been regressed per `G.REL.02`; platform adaptation changes should also be verified per `G.MET.05` and `G.REL.04`.
- [ ] The release content is clean and discoverable and invocable after installation (`G.REL.03`, `G.REL.04`).
- [ ] The official knowledge source and maintenance owner have been designated (`G.SRC.02`), and applicable decommission conditions are defined (`G.MNT.03`).

## Appendix C Platform and component adaptation

### C.1 Platform adaptation requirements

- Common frontmatter and platform-specific fields: `G.MET.04`, `G.MET.05`;
- Tasks, boundaries, and permissions of platform adaptation: `G.MET.05`;
- Discovery and invocation validation after installation: `G.REL.04`.

### C.2 Skill ownership

Follow Section 1.2 and `G.STR.01` for the official maintenance location of a Skill. Follow Section 1.1 for common rules and component differences.

## Appendix D References

### D.1 Related component specifications

1. [RTS skills development specification and guide](https://gitcode.com/xiao_cun/RuntimeAgent/blob/main/guidelines/RTS%20skills开发规范&指南.md)
2. [Framework team Skill specification](https://gitcode.com/xiao_cun/RuntimeAgent/blob/main/guidelines/框架组skill规范.md)
3. [Matrix and communication programming Skill specification](https://gitcode.com/xiao_cun/RuntimeAgent/blob/main/guidelines/矩阵&通信编程skill规范_V2.md)
4. [Model Agent asset development specification](https://gitcode.com/xiao_cun/RuntimeAgent/blob/main/guidelines/模型Agent资产开发规范.md)

### D.2 External material

1. [Agent Skills open specification](https://agentskills.io/specification)
2. [Claude API Agent Skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
3. [Claude Code Skills](https://code.claude.com/docs/en/skills)
4. [Claude Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
5. [OpenAI Codex Skills](https://developers.openai.com/codex/skills)
6. [Anthropic Agent Skills engineering practices](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)
