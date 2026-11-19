# Error Message Reporting Macro Usage Specification

This document describes the parameter style, control flow characteristics, applicable scenarios, and selection rules of ErrMsg reporting macros. It helps developers choose the correct reporting macro based on the error code and service scenario.

---

## Background

### Two Ways to Record Errors

Runtime code has two ways to record errors:

1. **RT_LOG log**: Record logs through `RT_LOG_*` macros. The log is written only to the log file, and the caller cannot obtain it programmatically.

2. **ErrMsg report**: Report structured error information through ErrorManager. The caller can obtain it programmatically.

### Complete Process of ErrMsg

```
Error occurs → Call the reporting macro → ErrorManager stores the error → Caller obtains the error information
```

- **Report**: Call an ErrMsg reporting macro in code (such as `COND_RETURN_AND_MSG_OUTER`)
- **Store**: The macro finally calls the core function of ErrorManager and stores the error information in thread-local storage
- **Obtain**:
  - Internal caller: Obtain through `GetErrMgrErrorMessage()` or `GetRawErrorMessages()`
  - External user: Obtain through the `aclGetRecentErrMsg()` interface

### Error Code Format

The error code format is a 6-character string: **E + module identifier + 4 digits**

| Module Identifier | Module Name | Example Error Code |
|---------|---------|-----------|
| E | Runtime | EE1001, EE9999 |
| H | ACL | EH0007, EH9999 |
| I | HCCL | EI9999 |
| L | Driver | EL9999 |
| K | Profiling | EK9999 |
| Z | Common operator error code and operator API execution interface error code | EZ9999 |

### Two Types of Errors

- **Internal error** (the last four digits of the error code are 9999): No JSON template. Only the original message is recorded. It is used for internal logic errors. For example, EE9999, EI9999, and EL9999.
- **External error** (the last four digits of the error code are 0001 to 8999): Has a JSON template (defined in `error_code.json`) that contains title/cause/solution and is displayed to users. For example, EE1001 and EH0007.

### Four Core Reporting Functions

The code encapsulates many ErrMsg reporting macros. These macros finally call four core functions of ErrorManager:

1. **`ReportInterErrMessage()`**: Reports internal errors (EX9999) and directly stores the original message
2. **`ReportErrMessage()`**: Reports external errors (EX0001 to EX8999) and fills the JSON template through args_map
3. **`ATCReportErrMessage()`**: Reports external errors and fills the JSON template through key/value vectors (the same function as the previous one, but with a different parameter form)
4. **`ReportErrMsgWithoutTpl()`**: Reports user-defined errors (EU0000 to EU9999). There is no template, and the message is stored directly.

---

# I. Runtime Module (Code Directory: `src/runtime/`)

---

## 1. Macro Table Column Definitions

The macro tables in the following sections use the following columns to describe the characteristics of each macro. The meaning and optional values of each column are defined as follows:

### Return Type

| Value | Meaning |
|----|------|
| rtError_t | Returns a Runtime internal error code |
| void | No return value (`return;`) |
| ACL error code (rt conversion) | Calls `GetRtExtErrCodeAndSetGlobalErr()` to convert rtError_t to an ACL external error code and sets the global error code |
| None | Only reports or jumps. Does not return a value through return |

### Condition Type

| Value | Meaning |
|----|------|
| Custom condition | Caller passes any boolean expression (usually with `unlikely()`) |
| Null pointer | Checks `PTR == nullptr` |
| Zero value | Checks `PARAM == 0U` |
| Error code != NONE | Checks `ERRCODE != RT_ERROR_NONE` |
| Unconditional | Unconditional report (does not check a condition) |

### PROC

| Value | Meaning |
|----|------|
| Yes | The macro runs an arbitrary statement before reporting (such as releasing resources or closing handles). The corresponding macro name usually contains `PROC` |
| No | The macro does not run a preceding statement |

### GOTO

| Value | Meaning |
|----|------|
| Yes | The macro runs `goto LABEL` after reporting to jump to the error handling label. It may also assign a value to the ERROR variable |
| No | The macro does not run goto |

### Set Global Error Code

| Value | Meaning |
|----|------|
| Yes | The macro calls `GetRtExtErrCodeAndSetGlobalErr()` during reporting to convert rtError_t to an ACL error code and sets the global error code |
| No | The macro only reports ErrMsg and does not set the global error code |

### Recommendation Level

| Value | Meaning |
|----|------|
| Recommended | Primary macro. The scenario is clear. Use it first in new code |
| Specific scenario | Has a clear applicable scenario but is less general than recommended macros |
| Use with caution | Has constraints or overlaps with recommended macros. Confirm before use |
| Do not use | Has design defects. Do not use it in new code |
---

## 2. String Format Description

ErrMsg macros have two ways to pass strings that you must distinguish when using them:

### printf Style (Used by _INNER Macros)

The `_INNER` macro series (such as `COND_RETURN_AND_MSG_INNER`) uses printf-style `format, ...` parameters. Developers pass the format string and variadic parameters directly:

```cpp
COND_RETURN_AND_MSG_INNER(ptr == nullptr, RT_ERROR_INVALID_VALUE,
    "Init failed, devId=%u, size=%zu", devId, size);
```

**Do not** concatenate with `std::string` before passing:
```cpp
// Incorrect usage: causes the .so file to bloat
std::string msg = "Init failed, devId=" + std::to_string(devId);
COND_RETURN_AND_MSG_INNER(ptr == nullptr, RT_ERROR_INVALID_VALUE, "%s", msg.c_str());
```

If you need to pre-format a string (for example, when the message content requires dynamic concatenation), you must use the `RtFmtMsg` function:
```cpp
// Correct usage
COND_RETURN_AND_MSG_INNER(ptr == nullptr, RT_ERROR_INVALID_VALUE,
    "%s", RtFmtMsg("Init failed, devId=%u, reason=%s", devId, reason).c_str());
```

### Structured Parameter Style (Used by _OUTER Macros)

The `_OUTER` macro series (such as `COND_RETURN_AND_MSG_OUTER`) uses structured parameters. `ErrorCodeProcess` automatically converts each parameter to a string and matches the `%s` placeholder of the X-macro template in `error_code_meta.h`. The number of parameters must match the template.

```cpp
COND_RETURN_AND_MSG_OUTER(ret != RT_ERROR_NONE, RT_ERROR_FEATURE_NOT_SUPPORT,
    ErrorCode::EE1006, __func__, "stream mode switching");
```

For a reason parameter that requires dynamic concatenation, likewise **do not** add `std::string` directly. Use `RtFmtMsg`:
```cpp
// Incorrect usage: causes the .so file to bloat
COND_RETURN_AND_MSG_OUTER(..., ErrorCode::EE1016, __func__,
    "Changing stream " + std::to_string(id) + " is not supported");

// Correct usage
COND_RETURN_AND_MSG_OUTER(..., ErrorCode::EE1016, __func__,
    RtFmtMsg("Changing stream %u is not supported", id));
```

> **Why is adding `std::string` prohibited?** `std::string` concatenation generates many temporary string objects and template instantiation code in the compilation product, which significantly bloats the .so file. `RtFmtMsg` uses a stack `char[]` buffer plus `snprintf`, so the compilation product is more compact.

### Semantic Function Description (_WITH_DESC / _WITH_FUNC_DESC Variants)

Some `_OUTER` macros provide `_WITH_DESC` or `_WITH_FUNC_DESC` suffix variants. The difference is how the function description is passed:

| Variant Suffix | Function Description Source | Example |
|---------|------------|------|
| No suffix (such as `RT_LOG_OUTER_MSG_WITH_FUNC`) | `__func__` (C++ function name) | `"MemCopySync"` |
| `_WITH_DESC` / `_WITH_FUNC_DESC` | Caller passes the `funcDesc` string | `"Synchronous memory copy"` |

`__func__` is a function name generated by the compiler and is not friendly to users. `_WITH_DESC` / `_WITH_FUNC_DESC` variants allow a semantic description string, which makes the error message easier to understand.

**Selection recommendation**: For non-interface-layer code in new code (functions that do not start with acl, rt, or aclrt), preferentially use `_WITH_DESC` / `_WITH_FUNC_DESC` variants and pass a string that describes the semantics of the current operation. For example:

```cpp
// Recommended: use a semantic description
RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "Closing the IPC shared memory");

// Not recommended: use __func__ (the function name is meaningless to users)
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005);
```

---

## 3. External Error Code Macros

External error codes have JSON templates. Users can obtain the formatted message with title/cause/solution through `GetErrMgrErrorMessage()`.

### EE1003 - Invalid_Argument (Parameter Value Validation)

Use it when a parameter value is invalid. The macro automatically injects the parameter name string, and the developer only needs to pass the parameter value and the expected value. The `_DESC` variant additionally receives a `FUNC_DESC` parameter for the semantic function description (see the "Semantic Function Description" section).

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_OUTER_WITH_PARAM | rtError_t | Custom condition | No | No | No | Recommended | — |
| COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC | rtError_t | Custom condition | No | No | No | Recommended | — |
| COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME | rtError_t | Custom condition | No | No | No | Recommended | — |
| COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_DESC | rtError_t | Custom condition | No | No | No | Recommended | — |
| ZERO_RETURN_AND_MSG_OUTER | rtError_t | Zero value | No | No | No | Recommended | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM | ACL error code (rt conversion) | Custom condition | No | No | Yes | Recommended | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM_NAME | ACL error code (rt conversion) | Custom condition | No | No | Yes | Recommended | — |
| RT_LOG_OUTER_MSG_INVALID_PARAM | None | Unconditional | No | No | No | Specific scenario | — |
| RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC | None | Unconditional | No | No | No | Specific scenario | — |

### EE1004 - Invalid_Argument_Null_Pointer

Dedicated to null pointer checks. The macro automatically uses `#PTR` (parameter name stringification), so you do not need to pass it manually. The `_WITH_FUNC_DESC` variant additionally receives a `FUNC_DESC` parameter for the semantic function description (see the "Semantic Function Description" section).

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| NULL_PTR_RETURN_MSG_OUTER | rtError_t | Null pointer | No | No | No | Recommended | — |
| NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC | rtError_t | Null pointer | No | No | No | Recommended | — |
| PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE | ACL error code (rt conversion) | Null pointer | No | No | Yes | Recommended | — |

### EE1010 - Execution_Error_Invalid_Context

Validates the ownership relationship of objects such as stream/model/context. The macro automatically injects `__func__` and the object name.

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_INVALID_CONTEXT | rtError_t | Custom condition | No | No | No | Recommended | — |
| RT_LOG_OUTER_MSG_INVALID_CONTEXT | None | Unconditional | No | No | No | Specific scenario | — |

### EE1013 - Resource_Error_Insufficient_Host_Memory

Dedicated to memory allocation failures. `bufSize` is the size of the memory requested for allocation.

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_PROC_RETURN_AND_MSG_ALLOC_FAILED | rtError_t | Custom condition | Yes | No | No | Recommended | — |

### EE1016 - Stream_Capture_Mode_Not_Support

Dedicated to stream capture mode checks. It checks whether the current context supports the capture operation. If not supported, it reports EE1016 and returns `RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT`. The actual ErrMsg report is completed inside the `CheckCaptureModeSupport()` function through `RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1016, funcName, reason)`. The `_WITH_DESC` variant passes a semantic function description instead of `__func__` (see the "Semantic Function Description" section).

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN | None | Custom condition | No | No | No | Recommended | — |
| CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_DESC | None | Custom condition | No | No | No | Recommended | — |

### EE1017 - Invalid_Argument (Reserved Parameter Validation)

Used for reserved parameter validation. `param` is the parameter name, and `reason` is the invalid reason.

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_RESERVED_PARAM | rtError_t | Custom condition | No | No | No | Recommended | — |
| RT_LOG_OUTER_MSG_RESERVED_PARAM | None | Unconditional | No | No | No | Specific scenario | — |

### EE1001 - Invalid_Argument

**Do not use.** The EE1001 error code and its dedicated macros (`COND_RETURN_OUT_ERROR_MSG_CALL` and `COND_PROC_RETURN_OUT_ERROR_MSG_CALL`) must not be used in new code. Use them only for fallback logic.


### Common External Error Code Primary Encapsulation Macros

Applicable to external error codes without dedicated macros, such as EE1005 to EE1021 (except the EE1016 capture mode scenario), EE2002, WE0000, and WE0001. The caller passes the `ErrorCode` enum value and the corresponding parameters.

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_OUTER | rtError_t | Custom condition | No | No | No | Recommended | — |
| COND_RETURN_VOID_AND_MSG_OUTER | void | Custom condition | No | No | No | Recommended | — |
| COND_PROC_RETURN_AND_MSG_OUTER | rtError_t | Custom condition | Yes | No | No | Recommended | — |
| COND_PROC_RETURN_VOID_AND_MSG_OUTER | void | Custom condition | Yes | No | No | Recommended | — |
| COND_GOTO_MSG_OUTER | None | Custom condition | No | Yes | No | Recommended | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER | ACL error code (rt conversion) | Custom condition | No | No | Yes | Recommended | — |
| COND_RETURN_EXT_WARNCODE_AND_MSG_OUTER | ACL error code (rt conversion) | Custom condition | No | No | Yes | Recommended | — |
---

### Common External Error Code Underlying Reporting Macros

Call ErrorManager or the underlying log interface directly. Applicable to special scenarios that high-level macros cannot meet. Some macros already have better alternatives and should not be used directly.

| Macro Name | Error Code Filling Method | Actual Error Code | Report Type | Recommendation Level | Alternative Macro |
|------|--------------|-----------|---------|---------|--------|
| RT_LOG_OUTER_MSG | Explicit input | String error code | External | Specific scenario | — |
| RT_LOG_OUTER_MSG_IMPL | Explicit input | ErrorCode enum | External | Specific scenario | — |
| RT_LOG_OUTER_MSG_WITH_FUNC | Explicit input | ErrorCode enum | External | Specific scenario | — |
| RT_LOG_OUTER_MSG_WITH_FUNC_DESC | Explicit input | ErrorCode enum | External | Specific scenario | — |
| REPORT_INPUT_ERROR | Explicit input | String error code | External | **Cannot be used directly** | — |
| REPORT_ENV_ERROR | Explicit input | String error code | External | **Cannot be used directly** | — |
---

### API Layer Fallback Macros

**Only for fallback screen output at the rt interface layer. Do not use in other scenarios.**

**Mapping rule**: Internal mapping through the switch in `FuncErrorReason()`:

| rtError_t | Reported Error Code | Reporting Method |
|-----------|-----------|---------|
| RT_ERROR_INVALID_VALUE | EE1001 | RT_LOG_OUTER_MSG (printf) |
| RT_ERROR_CONTEXT_NULL | EE1001 | RT_LOG_OUTER_MSG (printf) |
| RT_ERROR_FEATURE_NOT_SUPPORT | EE1001 | RT_LOG_OUTER_MSG (printf) |
| RT_ERROR_INVALID_HANDLE | EE1017 | RT_LOG_OUTER_MSG_IMPL (independent parameter) |
| RT_ERROR_STREAM_SYNC_TIMEOUT | EE1002 | RT_LOG_OUTER_MSG (printf) |
| default | EE9999 | RT_LOG_CALL_MSG(ERR_MODULE_GE) |

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| ERROR_RETURN_WITH_EXT_ERRCODE | ACL error code (rt conversion) | Error code != NONE | No | No | Yes | Recommended | — |
| REPORT_FUNC_ERROR_REASON | None | None | No | No | No | Cannot be used directly | ERROR_RETURN_WITH_EXT_ERRCODE |
---


## 4. Internal Error Code Macros

Internal error codes have no JSON template. Only one error is displayed as the first error in one error retrieval: the first external error code is preferentially taken as the first error (with title/cause/solution), and all others enter TraceBack. If all reports in this retrieval are internal error codes, the first one is taken as the first error (format `XX9999: Inner Error!`), and the others enter TraceBack.

### _INNER Series (EE9999)

Maps to EE9999 (or WE9999) and applies to Runtime internal logic errors. Uses printf-style format strings.

**Mapping rule**: `_INNER` suffix macros are mapped through the `RT_LOG_LEVEL_TO_ERR_MSG[]` array: RT_LOG_ERROR → EE9999, RT_LOG_WARNING → WE9999, others → INVALID_HEAD (exception, do not use).

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| NULL_STREAM_PTR_RETURN_MSG | rtError_t | Null pointer | No | No | No | Recommended | — |
| NULL_PTR_RETURN_MSG | rtError_t | Null pointer | No | No | No | Recommended | — |
| NULL_PTR_PROC_RETURN_ERROR_MSG_INNER | rtError_t | Null pointer | Yes | No | No | Recommended | — |
| NULL_PTR_GOTO_MSG_INNER | None | Null pointer | No | Yes | No | Recommended | — |
| ZERO_RETURN_MSG | rtError_t | Zero value | No | No | No | Use with caution | COND_RETURN_AND_MSG_INNER or ZERO_RETURN_AND_MSG_OUTER |
| COND_RETURN_AND_MSG_INNER | rtError_t | Custom condition | No | No | No | Recommended | — |
| COND_RETURN_VOID_AND_MSG_INNER | void | Custom condition | No | No | No | Recommended | — |
| COND_AND_MSG_INNER | None | Custom condition | No | No | No | Recommended | — |
| COND_PROC_RETURN_ERROR_MSG_INNER | rtError_t | Custom condition | Yes | No | No | Recommended | — |
| COND_RETURN_ERROR_MSG_INNER | rtError_t | Custom condition | No | No | No | Use with caution | COND_RETURN_AND_MSG_INNER |
| COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER | None | Custom condition | No | Yes | No | Recommended | — |
| COND_PROC_GOTO_MSG_INNER | None | Custom condition | Yes | Yes | No | Recommended | — |
| ERROR_RETURN_MSG_INNER | rtError_t | Error code != NONE | No | No | No | Recommended | — |
| ERROR_PROC_RETURN_MSG_INNER | rtError_t | Error code != NONE | Yes | No | No | Recommended | — |
| ERROR_GOTO_MSG_INNER | None | Error code != NONE | No | Yes | No | Recommended | — |
| ERROR_PROC_GOTO_MSG_INNER | None | Error code != NONE | Yes | Yes | No | Recommended | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_INNER | ACL error code (rt conversion) | Custom condition | No | No | Yes | Recommended | — |
### _CALL Series (MODULE_TYPE Mapping)

Maps to the internal error code of the corresponding module through MODULE_TYPE. Applicable to cross-module error reporting to mark the error source.

**Mapping rule**: `_CALL` suffix macros are mapped through the `RT_MODULE_TYPE_TO_ERR_MSG[]` array:

| MODULE_TYPE | Mapped Error Code | Description |
|-------------|-----------|------|
| ERR_MODULE_AICPU | E39999 | AI CPU module |
| ERR_MODULE_DRV | EL9999 | Driver module |
| ERR_MODULE_HCCL | EI9999 | HCCL module |
| ERR_MODULE_GE | EE9999 | GE module (do not use for new additions) |
| ERR_MODULE_PROFILE | EK9999 | Profiling module |
| ERR_MODULE_TBE | EZ9999 | TBE module |
| ERR_MODULE_SYSTEM | EE9999 | System module |
| ERR_MODULE_RTS | EE9999 | RTS module |
| ERR_MODULE_FE | E29999 | FE module |
| ERR_MODULE_AICPU_TIMEOUT | E30008 | AI CPU timeout |
| ERR_MODULE_INVALID_ARGUMENT | EE1001 | Invalid parameter |

| Macro Name | Return Type | Condition Type | PROC | GOTO | Set Global Error Code | Recommendation Level | Alternative Macro |
|------|---------|---------|------|------|--------------|---------|--------|
| NULL_PTR_PROC_RETURN_ERROR_MSG_CALL | rtError_t | Null pointer | Yes | No | No | Specific scenario | — |
| NULL_PTR_GOTO_MSG_CALL | None | Null pointer | No | Yes | No | Specific scenario | — |
| COND_RETURN_ERROR_MSG_CALL | rtError_t | Custom condition | No | No | No | Specific scenario | — |
| COND_PROC_RETURN_ERROR_MSG_CALL | rtError_t | Custom condition | Yes | No | No | Specific scenario | — |
| COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL | None | Custom condition | No | Yes | No | Specific scenario | — |
| COND_PROC_GOTO_MSG_CALL | None | Custom condition | Yes | Yes | No | Specific scenario | — |
| ERROR_RETURN_MSG_CALL | rtError_t | Error code != NONE | No | No | No | Specific scenario | — |
| ERROR_PROC_RETURN_MSG_CALL | rtError_t | Error code != NONE | Yes | No | No | Specific scenario | — |
| ERROR_GOTO_MSG_CALL | None | Error code != NONE | No | Yes | No | Specific scenario | — |
| ERROR_PROC_GOTO_MSG_CALL | None | Error code != NONE | Yes | Yes | No | Specific scenario | — |

### Internal Error Code Underlying Reporting Macros

Call ErrorManager or the underlying log interface directly. Applicable to special scenarios that high-level macros cannot meet. Some macros already have better alternatives and should not be used directly.

| Macro Name | Error Code Filling Method | Actual Error Code | Report Type | Recommendation Level | Alternative Macro |
|------|--------------|-----------|---------|---------|--------|
| RT_LOG_INNER_MSG | Mapping | RT_LOG_LEVEL | Internal | Specific scenario | — |
| RT_LOG_CALL_MSG | Mapping | MODULE_TYPE | Internal | Specific scenario | — |
| RT_LOG_CALL_MSG_NO_RT_LOG | Mapping | MODULE_TYPE | Internal | **Cannot be used directly** | RT_LOG_CALL_MSG |
| REPORT_INNER_ERROR | Explicit input | String error code | Internal | **Cannot be used directly** | RT_LOG_INNER_MSG |
| REPORT_CALL_ERROR | Explicit input | String error code | Internal | **Cannot be used directly** | RT_LOG_CALL_MSG |

---

## 5. Quick Selection Guide

Select the macro that meets your requirements as follows:

```
Does the error code I want to report have a dedicated macro?
├─ Yes (EE1003/EE1004/EE1010/EE1013/EE1016/EE1017, see Section 3)
│   └─ Can the dedicated macro meet my scenario? (Judge by PROC/GOTO/return type/set global error code)
│       ├─ Yes → Use the dedicated macro
│       └─ No
│           └─ Can a common macro meet my scenario?
│               ├─ Yes → Use a common macro (see "Common External Error Code Primary Encapsulation Macros" in Section 3)
│               └─ No → Use an underlying macro (see "Common External Error Code Underlying Reporting Macros" in Section 3)
│
└─ No (EE1001 is prohibited. EE1005 to EE1023, EE2002, WE0000, and WE0001 have no dedicated macro)
    └─ Can a common macro meet my scenario?
        ├─ Yes → Use a common macro (see "Common External Error Code Primary Encapsulation Macros" in Section 3)
        └─ No → Use an underlying macro (see "Common External Error Code Underlying Reporting Macros" in Section 3)
```

For internal error codes (EE9999 / MODULE_TYPE mapping), the selection method is similar:

```
I want to report an internal error code
├─ The current code belongs to the Runtime module itself → Use the _INNER series (see Section 4)
│   └─ Can the _INNER primary macro meet my scenario?
│       ├─ Yes → Use the _INNER primary macro
│       └─ No → Use an _INNER underlying macro (see "Internal Error Code Underlying Reporting Macros" in Section 4)
│
└─ The current code calls another module (GE/DRV/HCCL and so on) and needs to mark the error source
    → Use the _CALL series + the corresponding ERR_MODULE_xxx (see Section 4)
```

For API layer fallback scenarios (only for the rt interface layer):

```
I want to make a fallback return in an rt API entry function
└─ Use ERROR_RETURN_WITH_EXT_ERRCODE (see "API Layer Fallback Macros" in Section 3)
```

# II. ACL Module (Code Directory: `src/acl/`)

> Organization principle: Use EH error codes as the main dimension. Dedicated macros take precedence over common macros.

---

## 1. Macro Table Column Definitions

The macro tables in the following sections use the following columns to describe the characteristics of each macro. The meaning and optional values of each column are defined as follows:

### Return Type

| Value | Meaning |
|----|------|
| aclError | Returns an ACL error code (such as `ACL_ERROR_INVALID_PARAM`) |
| nullptr | Returns a null pointer |
| void | No return value (`return;`) |
| Original return value | Passes through the return value of the called function (such as rtError_t and ge::Status) |
| None | Only reports logs and does not change the control flow |

### Condition Type

| Value | Meaning |
|----|------|
| Null pointer | Checks `val == nullptr` |
| Parameter value | Checks whether the parameter value is valid (range, positive or negative, equality, and so on) |
| Return value != OK | Checks whether the return value of the called function is unsuccessful |
| Custom condition | Caller passes any boolean expression |
| Unconditional | Unconditional report (does not check a condition) |

### Report ErrMsg

| Value | Meaning |
|----|------|
| EH00xx | Reports a predefined EH error code through `AclErrorLogManager::ReportInputError()` |
| EH9999 | Reports an internal error through `AclErrorLogManager::ReportInnerError()` or `ReportCallError()` |

---

## 2. EH Error Code Reference

| Constant Name | Error Code | Purpose |
|--------|--------|------|
| `INVALID_PARAM_MSG` | EH0001 | Invalid parameter (general) |
| `INVALID_NULL_POINTER_MSG` | EH0002 | Null pointer (general) |
| `INVALID_PATH_MSG` | EH0003 | Invalid path |
| `INVALID_FILE_MSG` | EH0004 | Invalid file |
| `INVALID_AIPP_MSG` | EH0005 | Invalid AIPP parameter |
| `UNSUPPORTED_FEATURE_MSG` | EH0006 | Unsupported feature |
| `INVALID_VALUE_MSG` | EH0007 | Invalid value (with expected value) |
| `NULL_POINTER_FUNC_MSG` | EH0008 | Null pointer (function parameter) |
| `INVALID_PARAM_REASON_MSG` | EH0009 | Invalid parameter (with reason) |
| `ALLOC_MEMORY_FAILED_MSG` | EH0010 | Memory allocation failure |
| `UNSUPPORTED_SYSTEM_MSG` | EH0011 | Unsupported system |
| `INVALID_PARAM_NO_VALUE_MSG` | EH0012 | Invalid parameter (no value) |
| `STANDARD_FUNC_FAILED_MSG` | EH0013 | Standard function call failure |
| `LOAD_DYNAMIC_LIBRARY_FAILED_MSG` | EH0015 | Dynamic library loading or required symbol resolution failure |
| (Hardcoded) | EH9999 | Internal error/call error (fallback) |

---

## 3. Null Pointer Check Macros (EH0008)

Checks whether a pointer is `nullptr`. If so, it reports an EH0008 error and returns. This is the most frequently used macro family in the ACL layer (used in 472+ places). The `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants replace `__func__` with the semantic description passed by the caller (see "Semantic Function Description" in Section 8).

| Macro Name | Return Type | Condition Type | Report ErrMsg | Recommendation Level | Alternative Macro |
|------|---------|---------|------------|---------|--------|
| ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT | ACL_ERROR_INVALID_PARAM | Null pointer | EH0008 | Recommended | — |
| ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT_AND_FUNC_DESC | ACL_ERROR_INVALID_PARAM | Null pointer | EH0008 | Recommended | — |
| ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT | Caller specified | Null pointer | EH0008 | Recommended | — |
| ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT_WITH_FUNC_DESC | Caller specified | Null pointer | EH0008 | Recommended | — |
| ACL_REQUIRES_NOT_NULL_RET_NULL_INPUT_REPORT | nullptr | Null pointer | EH0008 | Recommended | — |
| ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT_WITH_PRAM_NAME | ACL_ERROR_INVALID_PARAM | Null pointer | EH0008 | Specific scenario | — |

**Notes**:
- `ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT` is the preferred macro. It returns `ACL_ERROR_INVALID_PARAM` and reports EH0008
- `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants additionally receive a `funcDesc` parameter for non-interface-layer code to pass a semantic function description
- `_WITH_PRAM_NAME` variant is used when the parameter name differs from the variable name

---

## 4. Parameter Value Validation Macros (EH0007 / EH0009 / EH0012)

### EH0007 - Invalid Value (with Expected Value)

Use it when a parameter value is invalid. The macro automatically injects `__func__`, the parameter value, the parameter name, and the expected value. The `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants replace `__func__` with the semantic description passed by the caller (see "Semantic Function Description" in Section 8).

| Macro Name | Return Type | Condition Type | Report ErrMsg | Recommendation Level | Alternative Macro |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_VALUE_WITH_EXPECT | ACL_ERROR_INVALID_PARAM | Parameter value (negated) | EH0007 | Recommended | — |
| ACL_CHECK_INVALID_VALUE_WITH_EXPECT_RET | Caller specified | Parameter value (negated) | EH0007 | Recommended | — |
| ACL_CHECK_INVALID_VALUE_WITH_DESC | Caller specified | Parameter value (negated) | EH0007 | Specific scenario | — |
| ACL_CHECK_INVALID_VALUE_WITH_DESC_AND_FUNC_DESC | Caller specified | Parameter value (negated) | EH0007 | Specific scenario | — |
| ACL_REQUIRES_PARAM_EQUAL_REPORT | ACL_ERROR_INVALID_PARAM | Parameter value (not equal) | EH0007 | Recommended | — |
| ACL_REQUIRES_POSITIVE_REPORT | ACL_ERROR_INVALID_PARAM | Parameter value (<=0) | EH0007 | Recommended | — |
| ACL_REQUIRES_POSITIVE_REPORT_WITH_FUNC_DESC | ACL_ERROR_INVALID_PARAM | Parameter value (<=0) | EH0007 | Recommended | — |

**Notes**:
- The condition of the `ACL_CHECK_INVALID_VALUE_WITH_EXPECT` series is **negated**: `if (!(condition))` means an error is reported when the condition is not met
- `ACL_REQUIRES_PARAM_EQUAL_REPORT` is used when the parameter must equal a specific value
- `ACL_REQUIRES_POSITIVE_REPORT` is used when the parameter must be a positive number
- `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants additionally receive a `funcDesc` parameter for non-interface-layer code to pass a semantic function description

### EH0009 - Invalid Parameter (with Reason)

Use it when a parameter is invalid and the reason needs to be explained in detail. The `_AND_FUNC_DESC` variant replaces `__func__` with the semantic description passed by the caller (see "Semantic Function Description" in Section 8).

| Macro Name | Return Type | Condition Type | Report ErrMsg | Recommendation Level | Alternative Macro |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_PARAM_WITH_REASON | ACL_ERROR_INVALID_PARAM | Custom condition | EH0009 | Recommended | — |
| ACL_CHECK_INVALID_PARAM_WITH_REASON_AND_FUNC_DESC | ACL_ERROR_INVALID_PARAM | Custom condition | EH0009 | Recommended | — |
| ACL_CHECK_INVALID_PARAM_WITH_REASON_RET | Caller specified | Custom condition | EH0009 | Recommended | — |
| ACL_CHECK_INVALID_PARAM_WITH_REASON_RET_AND_FUNC_DESC | Caller specified | Custom condition | EH0009 | Recommended | — |
| ACL_CHECK_INVALID_PARAM_WITH_REASON_DESC_RET | Caller specified | Custom condition | EH0009 | Specific scenario | — |
| ACL_CHECK_RESERVED_PARAM_REPORT_RET | Caller specified | Parameter value (not equal) | EH0009 | Recommended | — |

**Notes**:
- `ACL_CHECK_RESERVED_PARAM_REPORT_RET` is dedicated to reserved parameter validation (the parameter must equal a value, such as `flags == 0`)
- `ACL_CHECK_INVALID_PARAM_WITH_REASON_DESC_RET` is used when the parameter name and parameter value need to be passed manually (not `#param` stringification)
- `_AND_FUNC_DESC` variant additionally receives a `funcDesc` parameter for non-interface-layer code to pass a semantic function description

### EH0012 - Invalid Parameter (No Value)

Use it when a parameter is invalid but the parameter value does not need to be displayed.

| Macro Name | Return Type | Condition Type | Report ErrMsg | Recommendation Level | Alternative Macro |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_PARAM_NO_VALUE | ACL_ERROR_INVALID_PARAM | Custom condition (negated) | EH0012 | Recommended | — |

---

## 5. File Validation Macros (EH0004)

Use it when the file path is invalid or the file fails to open.

| Macro Name | Return Type | Condition Type | Report ErrMsg | Recommendation Level | Alternative Macro |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_FILE_MSG_RET | Caller specified | Custom condition | EH0004 | Recommended | — |
| ACL_CHECK_FILE_OPEN_FAILED | Caller specified | Custom condition (negated) | EH0004 | Recommended | — |

**Notes**:
- `ACL_CHECK_FILE_OPEN_FAILED` automatically obtains `strerror(errno)` as the failure reason
- `ACL_CHECK_INVALID_FILE_MSG_RET` requires the reason to be passed manually

---

## 6. Memory Allocation Validation Macros (EH0010)

Use it when memory allocation fails.

| Macro Name | Return Type | Condition Type | Report ErrMsg | Recommendation Level | Alternative Macro |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_MALLOC_RESULT_REPORT_RET | Caller specified | Null pointer | EH0010 | Recommended | — |

**Notes**:
- Reports EH0010 (with buf_size). The return type is specified by the caller (it can be nullptr or an error code)

---

## 7. Internal Error Reporting Macros (EH9999)

Reports the EH9999 internal error code.

### Report Only (Do Not Change the Control Flow)

| Macro Name | Return Type | Condition Type | Recommendation Level |
|------|---------|---------|---------|
| ACL_LOG_INNER_ERROR / ACL_LOG_CALL_ERROR | None | Unconditional | Recommended |

**Notes**:
- The two macros have exactly the same implementation (both call `AclErrorLogManager::ReportInnerError()` → `REPORT_INNER_ERR_MSG("EH9999", ...)`)

### Condition Check + Report + Return

| Macro Name | Return Type | Condition Type | Recommendation Level |
|------|---------|---------|---------|
| ACL_CHECK_WITH_INNER_MESSAGE_AND_RETURN | Caller specified | Custom condition (negated) | Recommended |
| ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT | ACL_ERROR_INVALID_PARAM | Null pointer | Specific scenario |
| ACL_CHECK_MALLOC_RESULT | ACL_ERROR_BAD_ALLOC | Null pointer | Specific scenario |
| ACL_REQUIRES_EQ | ACL_ERROR_INVALID_PARAM | Parameter value (not equal) | Specific scenario |
| ACL_REQUIRES_LE | ACL_ERROR_INVALID_PARAM | Parameter value (greater than) | Specific scenario |

**Notes**:
- `ACL_CHECK_WITH_INNER_MESSAGE_AND_RETURN`: The condition is negated (`if (!(exp))`), and it is the most general
- `ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT`: Null pointer check + EH9999. If you need to report EH0008, use the macro in Section 3
- `ACL_CHECK_MALLOC_RESULT`: Memory allocation failure. It always returns `ACL_ERROR_BAD_ALLOC`. If you need to report EH0010, use `ACL_CHECK_MALLOC_RESULT_REPORT_RET`

### Return Value Check + Report + Pass Through

| Macro Name | Return Type | Condition Type | Recommendation Level |
|------|---------|---------|---------|
| ACL_REQUIRES_OK_WITH_INNER_MESSAGE | Original return value | Return value != OK | Recommended |
| ACL_REQUIRES_CALL_RTS_OK | Original return value | Return value != NONE | Recommended |
| ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT | Original return value | Return value != NONE | Recommended |
| ACL_REQUIRES_RTS_OK | Original return value | Return value != NONE | Recommended |
| ACL_REQUIRES_CALL_GE_OK | Original return value | Return value != ge::SUCCESS | Recommended |
| ACL_REQUIRES_EOK | ACL_ERROR_FAILURE | Return value != EOK | Recommended |

**Notes**:
- `ACL_REQUIRES_CALL_RTS_OK` handles `ACL_ERROR_RT_FEATURE_NOT_SUPPORT` specially: it only prints a WARN log and does not report ErrMsg. Other failures report EH9999
- `ACL_REQUIRES_RTS_OK_WARN_NOT_SUPPORT` handles `ACL_ERROR_RT_FEATURE_NOT_SUPPORT` specially: it only prints a WARN log. Other failures do not report ErrMsg (rt already performs fallback screen output, and acl does not report repeatedly)
- `ACL_REQUIRES_RTS_OK` is used when the rt interface has already performed fallback screen output through `ERROR_RETURN_WITH_EXT_ERRCODE`. The acl side does not report repeatedly. It only returns `ACL_GET_ERRCODE_RTS(__ret)` and does not report ErrMsg
- `ACL_REQUIRES_EOK` is used for secure functions (such as memcpy_s) and always returns `ACL_ERROR_FAILURE`

---

## 8. Semantic Function Description (_WITH_FUNC_DESC / _AND_FUNC_DESC Variants)

The ACL layer provides `_WITH_FUNC_DESC` or `_AND_FUNC_DESC` suffix variants for some macros. The difference is how the function description is passed:

| Variant Suffix | Function Description Source | Example |
|---------|------------|------|
| No suffix (such as `ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT`) | `__func__` (C++ function name, with the `Impl` suffix automatically removed) | `"aclrtMemcpy"` |
| `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` | Caller passes the `funcDesc` string | `"Checking the synchronous memory copy parameter validity"` |

> **Naming note**: The two suffixes have exactly the same function. Both replace `__func__` with the `funcDesc` passed by the caller. The suffix choice depends on the base macro name: when the base macro name ends with `_REPORT`, the new variant uses `_WITH_FUNC_DESC` (such as `ACL_REQUIRES_POSITIVE_REPORT_WITH_FUNC_DESC`). In other cases, it uses `_AND_FUNC_DESC` (such as `ACL_CHECK_INVALID_VALUE_WITH_DESC_AND_FUNC_DESC`).

A macro without a suffix automatically obtains the function name through `GetFuncNameWithoutImplSuffix(__func__)`. `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants allow a semantic description string, which makes the error message easier to understand.

**Selection recommendation**: For non-interface-layer code in new code (functions that do not start with `acl`, `rt`, or `aclrt`), preferentially use `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants and pass a string that describes the semantics of the current operation. For example:

```cpp
// Recommended: use a semantic description in non-interface-layer code
ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT_AND_FUNC_DESC(dst, "Checking the synchronous memory copy parameter validity");

// Interface-layer functions (aclrtXxx) can use the macro without a suffix. __func__ is already a meaningful interface name
ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
```

For scenarios that call `AclErrorLogManager::ReportInputError()` manually, likewise replace `__func__` with a semantic description string:

```cpp
// Recommended: pass a semantic description in non-interface-layer code
acl::AclErrorLogManager::ReportInputError(
    acl::INVALID_VALUE_MSG, std::vector<const char*>({"func", "value", "param", "expect"}),
    std::vector<const char*>({"Memory copy type conversion", acl::GetMemcpyKindDesc(kind), "kind", "..."}));
```

---

## 9. Quick Selection Guide

```
Does the error code I want to report have a dedicated macro?
├─ Yes (null pointer→EH0008, parameter value→EH0007/EH0009/EH0012, file→EH0004, memory→EH0010, see Sections 3 to 6)
│   └─ Can the dedicated macro meet my scenario? (Judge by return type/condition type)
│       ├─ Yes → Use the dedicated macro (for non-interface-layer code, preferentially use _WITH_FUNC_DESC / _AND_FUNC_DESC variants, see Section 8)
│       └─ No → Call AclErrorLogManager::ReportInputError() manually (see the notes below) or develop a new macro
│
└─ No (EH0001/EH0003/EH0006/EH0011/EH0013 and so on have no dedicated macro)
    └─ Call AclErrorLogManager::ReportInputError() manually (see the notes below) or develop a new macro
```

**Usage example**:
```cpp
acl::AclErrorLogManager::ReportInputError(acl::INVALID_PATH_MSG,
    std::vector<const char *>({"path", "reason"}),
    std::vector<const char *>({path, "file not found"}));
```


