# Introduction

## Purpose

This section describes the purpose of the document and identifies the target readers. It states that the document describes the software requirements and design of a requirement, feature, or interface change in the Runtime repository.

## Scope

This section describes the content that the document includes and excludes. It identifies which modules, interfaces, platforms, tests, and document synchronization work are within the scope of this design.

# General Overview

This section describes general factors that affect the product and product requirements. It does not describe specific requirement details. Instead, it builds context for the subsequent specific requirements, design, and tests.

## Software Overview

### Project Introduction

Describe the background of this design. For example: Is this requirement an enhancement of an existing Runtime capability, a refactoring of a submodule, an extension of a public API, or a new capability for a new platform or scenario?

### Product Environment Introduction

Describe the overall environment that Runtime forms together with other components, products, and platforms.

1. If the capability is independent and self-contained, state it here.
2. If the capability is part of a larger system:

> A. Describe the responsibility boundaries of related components and identify the interface boundaries.
>
> B. Identify the main external interfaces involved in this requirement, for example `aclrt*`, `rt*`, driver, toolchain, profiling, and dump.
>
> C. Describe related hardware platforms, chip capabilities, the Host environment, external dependencies, and device-side limitations.

Use block diagrams to describe component relationships, call directions, and external interfaces.

## Software Functions

Outline the main functions that this requirement must implement. Provide only a high-level description here, and put the detailed design in subsequent chapters. Organize the content by function domain, for example:

* ACL open interfaces
* Runtime core capabilities (device/context/stream/event/notify/memory/model)
* Test and maintenance capabilities (profiling/dump/log)
* Toolchain or platform adaptation capabilities

## Design Constraints

Describe the items that restrict development choices, for example:

* Platform capability limitations
* Public API/ABI compatibility requirements
* Directory boundary constraints
* Build macro constraints
* Performance, memory, log, and thread model limitations

## Assumptions and Dependencies

Describe the upstream and downstream versions, driver capabilities, third-party components, public libraries, test environment, and document prerequisites that this iteration depends on.

# Feature 1 Requirements Analysis and Design

## Overall Introduction

## Functional Requirements

### Functional Requirement 1

> Use short words as the functional requirement name. Do not use "Functional Requirement (1)" as the function name.

1. Introduction

> List the functional requirements related to this feature one by one. Include the expected behavior in normal flows, with error input, in illegal states, and with invalid input. Requirements should be concise, complete, unambiguous, and verifiable. Mark uncertain information as "To be determined" when needed.

2. Input

> This subparagraph should contain the following:
>
> A. A detailed description of all input data, including source, quantity, unit, timing, range, precision, and tolerance.
>
> B. References to interface specifications or interface control documents.

3. Processing

> This subparagraph should describe the following:
>
> A. Input validity check.
>
> B. Key operation steps and event timing.
>
> C. Handling of exception scenarios, for example overflow, communication failure, driver return exception, resource allocation failure, and unsupported capability.
>
> D. Any input-to-output conversion method, state machine, or key algorithm.
>
> E. Validity detection of output results.

4. Output

> This subparagraph should contain the following:
>
> A. A detailed description of all output data, return values, side effects, logs, files, callbacks, or state changes.
>
> B. References to interface specifications or interface control documents.

### Functional Requirement 2

## Non-Functional Requirements

### Maintainability

### Testability

### Portability

### Reliability

### Platform Requirements

Runtime must be compatible with multiple SoC types, multiple driver capabilities, and multiple running environments. In designs of common paths, handle differences preferably through capability query, configuration registration, and platform isolation directories. Avoid hardcoding platform branches directly in general logic.

### Feature Cross Analysis

This section directly lists the impact assessment of this requirement on the following typical domains. State at minimum whether each domain is involved and the reason:

* `include/external/acl/` open interfaces
* `pkg_inc/runtime/` externally released header files
* Boundary between `src/runtime/api/` and `src/runtime/core|feature/`
* device/context/stream/event/notify/memory/model
* dump/profiling/log/toolchain
* Platform adaptation directories and driver interaction
* Test projects, documents, and examples

## Performance

### Interface Call Latency

*For requirements that involve open interfaces or high-frequency internal interfaces, evaluate the impact of added logic on interface latency. Focus on identifying extra branches, locks, string processing, logs, and memory allocation in hot paths.*

### Memory and Resource Usage

*Evaluate the impact of the new feature on the usage of resources such as memory, stream, event, context, threads, and handles. For added resident resources, explain the lifecycle, upper limit, and release timing.*

### Execution Performance

*Evaluate the impact of all execution-state related code on task submission, scheduling, synchronization, copy, and device execution paths. If the impact occurs on a high-frequency path, quantify it at the microsecond or nanosecond level as much as possible.*

### Maintainability and Log Overhead

*For changes related to profiling, dump, trace, and logs, evaluate whether they introduce extra collection overhead, IO jitter, or massive logs.*

## Interface Design

### Added/Modified Interface Description

*For added or modified interfaces, define the interface prototype, parameter constraints, return values, thread safety requirements, lifecycle requirements, and version compatibility policy.*

### Interface Check Items

| **Check item** | **Sub-check item** | **Involved** |
|------------|--------------|--------------|
| **Interface description** | Whether the interface requires review, and the review must focus on interface compatibility, call constraints, and resource lifecycle | |
| **Interface description** | Whether supplementary material, examples, or migration instructions are required | |
| **Interface description** | Whether the interface document defines the interface prototype, function, return values, and error codes | |
| **Interface compatibility** | Whether modifications in `include/`, `include/external/acl/`, and `pkg_inc/runtime/` remain backward compatible | |
| **Interface compatibility** | Whether the interface signature has a breaking change | |
| **Interface compatibility** | Whether deprecated interfaces are marked instead of deleted directly | |
| **Interface compatibility** | Whether an enum adds `XX_MAX` or affects multi-version matching compatibility | |
| **Interface constraints** | Whether the interface involves constraints such as call timing, thread context, device/context, and memory ownership | |
| **Interface constraints** | Whether the interface reports a clear error when calls do not meet the constraint conditions | |
| **Directory conventions** | Whether content is added to `pkg_inc/runtime/runtime` by mistake, and whether the content should be placed in `pkg_inc/runtime/rt_external*` or another open boundary | |
| **Document synchronization** | When you modify `include/external/acl/acl_rt.h`, whether the corresponding document in `docs/` is updated accordingly | |
| **Document synchronization** | When you modify `include/external/acl/error_codes/rt_error_codes.h`, whether `docs/zh/api_ref/25_data_types_and_operation_APIs.md` is updated accordingly | |
| **Test** | Whether a separate UT/ST/compatibility test case is required | |

## Software Design

### Key Data Structures

### Key Technologies/Algorithms

### Process Design

### Modifications to Submodules

*If the design involves changes to the main process of a submodule, directory boundaries, or call directions, describe the changes in responsibility boundaries and the affected modules.*

### Error Handling

#### System Errors

*Describe how to handle system-level errors such as memory allocation failure, driver failure, resource creation failure, thread creation failure, and file or directory failure.*

#### Interface Errors

*Describe the error codes, error messages, and propagation policy exposed to external entities.*

### Runtime Design Supplementary Check Items

| **Check item** | **Check item description** | **Involved** |
|------------|----------------|--------------|
| **Architecture boundary** | Non-`api` directories in `src/runtime` should not call methods of the `api` directory. For example, the `feature` directory should not access `Api::Instance` | |
| **Compile macro** | The `src/runtime` directory allows only `STATIC_RT_LIB`, `RUNTIME_API`, `CFG_DEV_PLATFORM_PC`, and compiler built-in macros. Do not add other compile macros | |
| **External input check** | Whether check policies are defined for user API parameters, driver return values, configuration files, environment variables, and external file paths | |
| **Resource lifecycle** | For added memory, handles, threads, callbacks, caches, and singleton resources, whether the lifecycle, release path, and exception recovery policy are defined | |
| **Cross-SO destruction risk** | Whether static or global objects make cross-SO calls, release cross-SO objects, or depend on the unload order during the destruction phase | |
| **Hot path logs** | Whether the performance impact of added logs, string concatenation, and maintainability instrumentation in hot paths is evaluated | |

## Security Check

### Coding Guidelines

See [coding-guidelines.md](coding-guidelines.md)

### Design Check Items

| **Check item** | **Check item description** | **Involved** |
|------------|----------------|--------------|
| **Resource lifecycle management** | Resources with an excessively long lifecycle may cause resource insufficiency, slower response, and system crashes. Define whether a resource is process-level, device-level, context-level, or call-level | |
| **Thread creation** | Whether a new thread needs to copy context information such as ThreadLocalContext and ErrorContext, and whether the thread name needs to be set | |
| **Global state recovery** | Whether the design modifies the SoC type, device, environment variables, singleton state, or static cache. If so, how do tests and exception paths restore the state | |
| **External data usage** | Whether external input may serve as an array index, length, offset, memory allocation size, or enum value in critical logic | |
| **Logs and sensitive information** | Whether sensitive information is printed, whether the error log level is inappropriate, or whether hot path logs are excessive | |

## Compatibility Check

Focus on the following compatibility issues:

* Whether an old application or old interface still works on a new Runtime version
* Whether the open boundaries in `include/` and `pkg_inc/` introduce ABI/API incompatibility
* Whether added enum values, structure fields, and enabled reserved parameters affect old logic
* Whether documents, examples, and tests cover compatibility scenarios

## Document Synchronization

If this design involves changes to open interfaces, error codes, or user-visible behavior, define the list of documents to update accordingly, for example:

* `docs/zh/api_ref/`
* `docs/zh/dev_guide/`
* `example/`
* Migration instructions, FAQ, and release notes

## DT Design

### Test Boundaries

*Test entry (which interface or component the test is based on), test exit (which data checks are performed), stubbing modules, dependent environment, and cleanup scope.*

### Test Design

*Describe which types of test cases need to be designed. Export them to a test case list. Test case types generally include UT and ST, and include compatibility tests, performance tests, and special regression when necessary.*

| **Test category** | **Key test item** | **Test method** | **Test case type** |
|--------------|----------------|--------------|--------------|
| **Function** | | | |
| **Exception handling** | | | |
| **Performance** | | | |
| **Compatibility** | | | |
| **Resources and leaks** | | | |
| **Feature cross** | | | |

### Test Framework Design

### Test Implementation Supplementary Check Items

| **Check item** | **Check item description** | **Involved** |
|------------|----------------|--------------|
| **Assertion completeness** | Every test case must verify results with `EXPECT`/`ASSERT` assertions. Do not only call interfaces without validation | |
| **Mock cleanup** | Whether every test class `verify` or `reset` mock objects in `TearDown` to ensure test isolation | |
| **Private member access** | Whether unnecessary use of `#define private public` / `#define protected public` is avoided | |
| **SetChipType** | Whether direct calls to `SetChipType` in UT are minimized, and whether recovery logic exists when the call is necessary | |
| **Pointer member recovery** | If a test modifies class pointer members, global pointers, or singleton state, whether the original values are restored when the test exits | |
