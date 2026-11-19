# Error Message Rectification Principles

This document captures the overall principles for Runtime/ACL Error Message rectification. Use it to determine general issues such as the rectification boundary, user errors and internal errors, parameter sources, the first failure site, defensive programming, repeated structured reporting, and print formats. For error codes, macro selection, and message templates, refer to the topic-specific specifications in the same directory.

## Core principles

The goal of Error Message rectification is to improve user readability and fault locating efficiency:

- User errors guide the user to resolve the problem independently, and the message must state the parameter, the actual value, the expected value, or an explicit cause.
- Internal errors precisely locate the internal failure point, and the message must state the function, object, return code, or key context.
- When you analyze a call point, you must read the context and understand the business scenario and trigger cause of the error. Do not apply rules mechanically.
- The core basis for error classification is the error trigger source and whether the user needs, and is able to understand and handle, the error.

## Rectification boundary

Rectification handles only structured error reporting and the necessary matching of macros, error codes, and texts. It does not change business behavior.

Allowed rectifications:

- Error messages of `RT_LOG_OUTER_MSG_IMPL`, `RT_LOG_INNER_MSG`, and their wrapper chains in Runtime.
- Error messages that directly use `REPORT_INPUT_ERROR` and `REPORT_INNER_ERROR` in Runtime.
- Error messages of `ReportInputError`, `ReportInnerError`, and `ACL_LOG_INNER_ERROR` in ACL.
- Structured error reporting points where the error code selection and macro usage are clearly unreasonable.

Prohibited actions:

- Do not modify return values, for example keep `RT_ERROR_INVALID_PARAM` and `ACL_ERROR_INVALID_PARAM` unchanged.
- Do not modify condition checks, flow control, or cleanup logic.
- Do not modify normal log levels, for example do not change `ERROR` to `WARN` or `DEBUG`.
- Do not mechanically convert normal logs into structured reporting.
- Do not replace wrapper macros with underlying macros for message rectification. When the wrapper macro is correct, prefer to modify only the macro parameters or the text.

Usually do not rectify:

- Normal logs in Runtime such as `RT_LOG_ERROR`, `RT_LOG_DEBUG`, `RT_LOG_INFO`, and `RT_LOG_WARNING`.
- Normal logs in ACL such as `ACL_LOG_ERROR`, `ACL_LOG_DEBUG`, `ACL_LOG_INFO`, and `ACL_LOG_WARN`.
- Logs in defensive programming that are used only for internal diagnosis.

## User errors and internal errors

The core question for distinguishing user errors from internal errors is whether the user can resolve the problem by modifying parameters, the environment, or the invocation method.

User errors:

- The error is triggered by user input parameters, user configuration, user call sequence, or user-controlled resource requests.
- The user can solve the problem by adjusting their own behavior according to the documentation or the error message.
- Typical scenarios include invalid parameters, null pointer parameters, invalid paths, unsupported features, unsupported systems or devices, incorrect API call sequences, and insufficient resources.
- Runtime uses user-type EE error codes and reports them through user error macros/interfaces. ACL uses EH error codes and reports them through `ReportInputError`.

Internal errors:

- The error is triggered by an internal state, internal variable, or internal logic exception in Runtime/ACL.
- The user cannot directly solve the problem by modifying API parameters or the invocation method, and usually needs technical support or internal diagnosis.
- Typical scenarios include internal state exceptions, internal buffer operation failures, and defensive scenarios that should not occur.
- Runtime internal errors mainly use `EE9999` or only normal logs.

Quick check:

1. Does the error parameter come from user input or user configuration.
2. Can the user solve the problem by modifying their own parameters, environment, or invocation method.
3. Can the error message guide the user to resolve the problem independently.

If any answer is "yes", usually handle the error as a user error. If all answers are "no", handle it as an internal error.

Examples:

```cpp
// User error: priority comes from an external interface input parameter, and the user can resolve the problem by modifying the call parameter.
COND_RETURN_AND_MSG_OUTER_WITH_PARAM(priority > 2, RT_ERROR_INVALID_PARAM,
    priority, "[0, 2]");

// Internal error: internalState is an internal Runtime state, and the user cannot directly solve the problem by modifying an API parameter.
COND_RETURN_AND_MSG_INNER(internalState == nullptr, RT_ERROR_INTERNAL_ERROR,
    "Internal error in %s: state is null", __func__);
```

## Parameter source determination

The parameter source matters more than the function name. The same system call failure can be classified differently because the parameter sources differ.

- Interface parameters in public API header files are user parameters.
- Formal parameters forwarded directly from public APIs in the ACL Impl layer are user parameters.
- Formal parameters of internal private functions in Impl or Runtime need call chain tracing: if they come from public interface parameters, treat them as user parameters; if they come from internal variables, treat them as internal parameters.
- Temporary variables, member variables, and internal state objects defined inside a function are usually treated as internal parameters or internal state.
- When a system call or a security function involves both user parameters and internal parameters, if the failure can be triggered by a user parameter, usually handle it as a user error.

Do not determine the error category only by the function name, such as `memcpy_s`, `malloc`, or a driver interface. Determine it by combining the parameter source, the call layer, and user controllability.

## First failure site principle

The first failure site is the initial location where the error occurs, that is, the direct error source.

The first failure site usually has the following characteristics:

- It is the location where a direct call fails or an exception condition first holds true.
- The error is not simply returned from a lower-layer function.
- The current context best knows the failed object, parameters, return code, and cause.

Handling principles:

- Exception: on the path where an aclrt/rt external interface function returns an error code, the entry function is the user-visible error reporting boundary, and the first failure site principle and the duplicate deduplication principle for repeated structured reporting do not apply. Even if a lower layer has already reported an ErrMsg for the same error, the entry function still needs to report an ErrMsg again, so that the external interface has interface-level error information.
- Except for the above exception scenario, the error source must print logs sufficient for locating the problem. When it returns an error code, in principle it must also report an ErrMsg at the same time.
- If the current function only receives an error code returned by a lower layer, and the lower layer has already reported the same error, the current function only needs to return the error code and print normal logs as needed.
- In a multi-layer call chain, report the same error structurally only at the most appropriate first failure site.
- The source that reports an internal error must also keep locatable context, so that generic failure information is not printed only at the outer layer.

Examples:

```cpp
// First failure site: malloc fails directly, and the current context best knows size and the return result.
void *ptr = malloc(size);
if (ptr == nullptr) {
    RT_LOG_ERROR("Failed to allocate %zu bytes memory.", size);
    COND_PROC_RETURN_AND_MSG_ALLOC_FAILED(ptr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        (void)0, std::to_string(size));
}

// Not the first failure site: the error is returned from a lower layer, and the lower layer has already reported the same error.
rtError_t ret = AllocateMemory(size, &ptr);
if (ret != RT_SUCCESS) {
    RT_LOG_ERROR("AllocateMemory failed with error %d.", ret);
    return ret;
}
```

## Defensive programming

Defensive programming covers exception scenarios that should not occur in theory. Usually an upper layer has already validated them, or an internal convention guarantees that the condition does not hold true.

Determination basis:

- An upstream function has already validated and intercepted the error.
- Conventions between internal modules guarantee that the parameter or state is valid.
- The code logic guarantees that the condition does not hold true in theory.
- The check condition is closer to an internal assertion or fallback protection.

Handling principles:

- In defensive programming scenarios, print only normal logs and do not report structured errors.
- Do not wrap defensive checks as user errors.
- If a defensive check is actually located at a user-visible entry, or user input can directly trigger it, do not handle it as a defensive scenario, and report it as a user error.

Examples:

```cpp
// The upper-layer function has validated and guaranteed stream != nullptr.
rtError_t ProcessStreamInternal(rtStream_t stream) {
    if (stream == nullptr) {
        // Defensive programming: should not occur in theory, keep only the normal log.
        RT_LOG_ERROR("Unexpected null stream in internal function %s.", __func__);
        return RT_ERROR_INTERNAL_ERROR;
    }
    // ... business logic
    return RT_SUCCESS;
}

// External entry: user input of nullptr can directly trigger it, so an ErrMsg must be reported.
rtError_t rtProcessStream(rtStream_t stream) {
    NULL_PTR_RETURN_MSG_OUTER(stream, RT_ERROR_INVALID_PARAM);
    return ProcessStreamInternal(stream);
}
```

## Repeated structured reporting

Except for the aclrt/rt external interface entry exception, the same error must not be structurally reported multiple times in a call chain.

Check method:

1. Locate the current structured reporting point.
2. Trace the upper-layer calls and lower-layer return paths of the current function.
3. Confirm whether the same error has been reported at a location closer to the source.
4. Except for the aclrt/rt external interface entry exception, if the error has already been reported, the current call point only returns the error code and prints normal logs as needed.

Determination principles:

- Handle the aclrt/rt external interface entry exception according to the exception clause in the "First failure site principle" chapter.
- If an upper layer has already reported the same error, the current function does not report it again.
- If a lower layer has already reported the same error, the upper layer does not wrap it again as a new structured error.
- Different error sources or different failure branches must each have an ErrMsg. Do not report again on paths that a lower layer has already reported, and you can add reporting at an upper layer for paths where reporting is missing.
- The same ErrMsg output must not contain exactly identical structured messages.
- Messages with different error codes or wording but the same failure fact and no effective additional information are substantively identical and are also prohibited.
- Remove redundant ErrMsgs from the call stack as much as possible. When an intermediate layer only expresses "the call failed" or repeats the root cause of a lower layer, delete the reporting at the intermediate layer.
- If the information at the first error point is incomplete, but the acl/rt interface layer can add the call scenario or extra locating information, keep the reporting at the first error point and the interface layer, and delete the redundant reporting at intermediate layers.
- Keep an intermediate layer only when it provides unique information that neither the first error point nor the interface layer can reasonably express, and it must not be exactly identical or substantively identical to other layers.
- Before you delete or move reporting, confirm that every actually reachable error path that should be structurally reported still has a suitable ErrMsg, and that return codes, cleanup order, and other business logic do not change.
- If the current function directly produces an error and no lower layer reports it, the current function reports it as the first failure site.
- If a driver interface or lower-layer module has completed internal handling, for example when driver memory-related errors are handled by existing dedicated methods such as `DRV_MALLOC_ERROR_PROCESS` or `DRV_ERROR_PROCESS`, the external caller must avoid repeated structured reporting.
- Normal `RT_LOG_*` logs are not structured duplicate reporting. Do not rely on the container deduplication of ErrorManager instead of the above checks.

Examples:

```cpp
// First failure site: the underlying function directly detects the malloc failure and reports it.
rtError_t AllocateMemoryInternal(size_t size, void **ptr) {
    *ptr = malloc(size);
    if (*ptr == nullptr) {
        COND_PROC_RETURN_AND_MSG_ALLOC_FAILED(*ptr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            (void)0, std::to_string(size));
    }
    return RT_SUCCESS;
}

// Intermediate layer: the lower layer has already reported the same error, so do not report it structurally again.
rtError_t CreateBufferInternal(size_t size, Buffer *buf) {
    void *ptr = nullptr;
    rtError_t ret = AllocateMemoryInternal(size, &ptr);
    if (ret != RT_SUCCESS) {
        RT_LOG_ERROR("Failed to allocate memory for buffer in %s.", __func__);
        return ret;
    }
    // ... business logic
    return RT_SUCCESS;
}

// External entry exception: the entry function is the user-visible reporting boundary, so even if the lower layer has reported the error, it must report the interface-level ErrMsg again.
rtError_t rtCreateBuffer(size_t size, rtBuffer_t *buffer) {
    Buffer buf;
    rtError_t ret = CreateBufferInternal(size, &buf);
    if (ret != RT_SUCCESS) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, std::to_string(size));
        return ret;
    }
    // ... business logic
    return RT_SUCCESS;
}
```

## Print format specifications

Error Message print formats must follow the specifications below to ensure that the information is clear, standardized, and easy for users to understand.

### Enumeration value print specification

**Rule 1: Print enumeration values passed by the user**

For enumeration parameters passed by the user, print them using the enum-to-string function in the format `EnumName(value)`:
- Valid value examples: `GLOBAL(0)`, `THREAD_LOCAL(1)`, `RELAXED(2)`
- Invalid value (not in the enumeration definition) example: `UNKNOWN(100)`, and the numeric value must be printed at the same time

**Rule 2: Describe the expected value (valid value range)**

| Expected value type | Description method | Example |
|-----------|---------|------|
| Continuous range `[a, b)` or `[a, b]` | Keep the original range description | `[0, 10]` |
| Discrete enumeration values (one or more specific enumeration values) | Use the `EnumName(value)` format, consistent with rule 1 | `RELAXED(2)` or `GLOBAL(0) THREAD_LOCAL(1)` |

**Rule 3: Print the chip type (chipType)**

The chip type (chipType) is an internal enumeration and does not use the enum-to-string format of rule 1. Print only the numeric value and do not print the enumeration name.

```cpp
// src/runtime/api/api_c_standard_soc.cc:593
COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER((priority != RT_STREAM_GREATEST_PRIORITY) &&
    (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_CREATE_PRIORITY_GREATEST)),
    RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, __func__, StreamPriorityToString(priority).c_str(), "priority",
    "The priority can be set to RT_STREAM_GREATEST_PRIORITY only when chipType is " + std::to_string(CHIP_DC) +
    ". The actual chipType is " + std::to_string(chipType));
```

### Parameter print specification

- For user input parameters, print the parameter name and the parameter value or address, so that the user can accurately locate the problem parameter.
- Do not use the `[%s]` bracket format. Use `%s` directly or integrate the variable into the sentence. The bracket format of numeric variables (`%u`, `%d`, and so on), such as `label [%u]`, is not subject to this restriction.

### Proper noun print specification

Proper nouns must use the correct case and format, keep the original text unsplit, and use a consistent format.

Common proper nouns:
- AI CPU
- ACL Graph
- SQ/CQ
- IPC Notify

### ID parameter print specification

Print format for identifiers such as `stream id` and `model id`:
- `stream (stream_id=%d)`
- `model (model_id=%d)`
- `event (event_id=%d)`
- `notify (notify_id=%u)`

### Internal function name print specification

Print internal function names as functional descriptions and avoid printing the function name directly, so that users can understand the message.

Examples:
- Recommended: `Failed to allocate memory for internal buffer.`
- Not recommended: `Malloc failed.`

### EE9999/EH9999 sentence specification

For internal errors (EE9999/EH9999), use the `Failed to` sentence pattern to clearly describe the failed operation.

Example: `Failed to allocate memory for internal buffer.`

### Sentence completeness specification

Use a complete sentence to express the error message:
- Capitalize the first letter.
- Decide whether to add a period at the end of the sentence according to the error code type.

### Error message Reason description specification

The `Reason: %s` part of ErrMessage describes the specific cause of the error and must follow the specifications below:

- Reason must briefly describe the specific cause of the failure and avoid repeating information already expressed by ErrMessage.
- State not only the cause of the problem, but also the actions that the user can take to solve it.
- The Reason content must be consistent with the context and help the user understand the root cause of the failure.
