# Error Message Review Checklist

## Overview

Use this checklist to check whether ErrMsg macro changes are compliant. Focus on **the text quality of the dual-source error_code.json / error_code_meta.h**, **macro parameter count matching**, **ErrMsg syntax issues**, and **parameter type**.

## 1. error_code.json Validation

### Validation item — Dual-source synchronization validation of error_code.json and error_code_meta.h
(1) When you add or modify an error code, **you must update both places** and keep them consistent:

| File | Purpose | Consumer |
|------|------|--------|
| `src/dfx/error_manager/error_code.json` | External error code metadata | `ErrorManager::ATCReportErrMessage` (ATC / external reporting path) |
| `src/runtime/core/inc/common/error_code_meta.h` → `RUNTIME_ERROR_CODE_TABLE` | X-Macro metadata table | `GetParamNames()` / `PrintErrMsgToLog()` |

(2) The ErrMessage template **must be exactly the same** (including punctuation and spaces).
(3) The parameter names and parameter count in Arglist **must be exactly the same**.
(4) If you update only one place and omit the other, the message reported by ATC is inconsistent with the message printed by the runtime, or the parameter count validation fails.

### Validation item — ErrMessage text validation

(1) The first letter is not capitalized: The first English letter should be uppercase (except placeholders).
(2) Missing period at the end: A complete sentence should end with a period. If the last `%s` is an independent `extend_info` and the template has no period, this is a design choice.
(3) The number of `%s` does not match Arglist: The number of `%s` in ErrMessage must equal the number of Arglist parameters.
(4) `[%s]` bracket format: Do not use the `[%s]` bracket format for string variables in ErrMessage. Use `%s` directly or integrate it into the sentence.
(5) Object ID missing: If ErrMessage involves stream/model/event/notify objects, it must print their ID values.

### Validation item — suggestion validation

(1) suggestion is missing
(2) In suggestion, do not use the newline character `\n` to separate multiple messages. Use a space instead. Handle special cases separately.
(3) Missing space after the number: Add a space after `1.`/`2.`.
(4) Consistently use N/A: `NA` → `N/A`.
(5) The first letter is not capitalized: The first English letter should be uppercase.
(6) Missing period at the end: A complete sentence should end with a period. N/A does not need one.
(7) Grammar errors: Subject-verb agreement, tense, prepositions, and spelling.

## 2. Using Macros at Modification Points + Error Code Validation

### Validation item — Parameter count validation

In `RUNTIME_ERROR_CODE_TABLE` of `error_code_meta.h`, each EE/EH error code has an Arglist parameter, which indicates the parameters required by the current error code. If the number of passed parameters is wrong, the ErrMsg screen report fails.

Parameter count calculation rule:

```
Valid parameter count == Size of GetParamNames(ErrorCode)
```

`PrintErrMsgToLog` returns directly and prints a warning log when the parameter count does not match.

**EE-layer macro parameter calculation rules:**

(1) The lowest-level external error code screen macro `RT_LOG_OUTER_MSG_IMPL` does not automatically add any parameters.

(2) The macro that automatically prepends the function name, `RT_LOG_OUTER_MSG_WITH_FUNC`, and its re-wrapped macros automatically add `__func__` as the first parameter. **Valid parameters = 1 + len(args)**. Do not manually pass `__func__` again. `RT_LOG_OUTER_MSG_WITH_FUNC_DESC` and its wrapper macros (such as `RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC`) behave similarly, but they automatically add the `funcDesc` passed by the caller instead of `__func__`.

(3) Dedicated macros usually handle common parameters automatically to simplify usage. Calculate valid parameters based on the actual situation. For example, the `RT_LOG_OUTER_MSG_INVALID_PARAM` macro is dedicated to EE1003. Its expansion chain is:

```
RT_LOG_OUTER_MSG_INVALID_PARAM(parm, expect)
  → RT_LOG_OUTER_MSG_WITH_FUNC(EE1003, (parm), #parm, expect)
    → RT_LOG_OUTER_MSG_IMPL(EE1003, __func__, (parm), #parm, expect)
```

Valid parameters = 3 + len(args). EE1003 expects 4 parameters, so the variable parameter should be 1 (that is, the expected value expect). `RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC(funcDesc, parm, expect)` has the same expansion chain. It only replaces `__func__` with `funcDesc`.

**EH-layer macro description:**

The EH series error codes (ACL layer) use `acl::AclErrorLogManager::ReportInputError` to report. They pass parameters through a key-value string vector and do not go through the `RT_LOG_OUTER_MSG_*` macro chain. The parameter count validation rule is the same: The number of passed values must equal the number of Arglist parameters.

Sources of the `func` parameter for ACL-layer macros:
- Macros without a suffix (such as `ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT`): Automatically obtain the function name through `GetFuncNameWithoutImplSuffix(__func__)` (remove the `Impl` suffix).
- `_WITH_FUNC_DESC` / `_AND_FUNC_DESC` variants (such as `ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT_AND_FUNC_DESC` and `ACL_REQUIRES_POSITIVE_REPORT_WITH_FUNC_DESC`): Use the `funcDesc` string passed by the caller.
- When you manually call `ReportInputError`, the caller passes the `func` value. Non-interface-layer code should pass a semantic description instead of `__func__`.

### Validation item — Parameter value validation

(1) Avoid using `std::string` concatenation for parameter values: This method creates temporary variables and increases the size of the so. Recommend using the `RtFmtMsg` function (defined in `rt_log.h`) to pass a formatted string to the macro.

(2) Missing or duplicate period at the end: When you pass an external error code through a structured parameter macro, whether the parameter needs a period at the end depends on the ErrMessage template.

- If there is a period **after** `%s` in the template → **do not add a period** to the passed parameter (avoid double periods "..").
- If there is no period **after** `%s` in the template and the parameter is a complete English sentence → **add a period**.

## 3. Common Errors

### 3.1 Duplicate __func__ with WITH_FUNC and manual __func__

```
// ✗ WITH_FUNC adds __func__ automatically. Passing it manually again causes duplication → parameters=5, EE1011 expects 4
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1011, __func__, ver, "ver", "msg");
// ✓ Pass only the variable parameters → parameters=1+3=4
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1011, ver, "ver", "msg");
```

### 3.2 NA vs N/A

```
"suggestion": { "Solution": "NA" }    // ✗ Use "N/A"
"suggestion": { "Solution": "N/A" }   // ✓
```

### 3.3 Duplicate period

```
// ✗ The last %s in the EE1011 ErrMessage template is followed by a period. Adding another period to the reason parameter causes duplication.
COND_RETURN_AND_MSG_OUTER(!trueStream->IsModelStream(), RT_ERROR_STREAM_MODEL,
    ErrorCode::EE1011, __func__, 0, "trueStream->modelNum",
    "The stream is not bound to a model.");

// ✓ Do not add a period to the reason parameter.
COND_RETURN_AND_MSG_OUTER(!trueStream->IsModelStream(), RT_ERROR_STREAM_MODEL,
    ErrorCode::EE1011, __func__, 0, "trueStream->modelNum",
    "The stream is not bound to a model");
```

> Note: `COND_RETURN_AND_MSG_OUTER` expands to `RT_LOG_OUTER_MSG_IMPL` (it does not automatically add `__func__`). Therefore, manually passing `__func__` here is correct. This differs from the WITH_FUNC duplication issue in 3.1.

### 3.4 Numeric words in logs are not unified

In logs and error message strings, replace the standalone word `zero` with `0`. Do not replace hyphenated compound words (`zero-size`, `non-zero`, `divide-by-zero`, `zero-copy`) or technical terms (`zero copy`).

```text
// ✗ count is zero, greater than zero
// ✓ count is 0, greater than 0
// ✓ zero-size memcpy (hyphenated compound words are not replaced)
// ✓ zero copy task (technical terms are not replaced)
```

## 4. Source File Index

| File | Purpose |
|------|------|
| `src/runtime/core/inc/common/error_code_meta.h` | X-Macro error code metadata table `RUNTIME_ERROR_CODE_TABLE` (data source for GetParamNames / PrintErrMsgToLog) |
| `src/dfx/error_manager/error_code.json` | External error code metadata (data source for ATCReportErrMessage) |
| `src/runtime/core/inc/base.hpp` | Core macro definitions + `ErrorCodeProcess` template function |
| `src/runtime/core/inc/common/rt_log.h` | `ErrorCode` enum + declarations of `GetParamNames` / `PrintErrMsgToLog` / `RtFmtMsg` |
| `src/runtime/core/inc/common/error_message_manage.hpp` | `COND_*` wrapper macros + dedicated macros |
| `src/runtime/api/api_c.h` | API-layer macros (including `COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER`) |
| `src/runtime/core/src/common/rt_log.cc` | Implementation of `GetParamNames` + `PrintErrMsgToLog` + `DispatchErrMsg` |
