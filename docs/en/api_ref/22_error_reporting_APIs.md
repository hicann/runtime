# 22. Error Reporting APIs

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:35:19.437Z pushedAt=2026-11-09T10:43:04.186Z nl=2 -->

This chapter describes the error reporting APIs, which are used to register and report various predefined and custom error messages.

- [Usage Notes](#usage-notes)
- [`int32_t ReportInnerErrMsg(const char_t *file_name, const char_t *func, uint32_t line, const char *error_code, const char_t *format, ...)`](#ReportInnerErrMsg): Used to report predefined internal error messages of CANN. Reports information about the call site, such as the file name, function name, and line number.
- [`int32_t ReportPredefinedErrMsg(const char *error_code, ...)`](#ReportPredefinedErrMsg): Used to report predefined user-type error messages of CANN.
- [`int32_t ReportUserDefinedErrMsg(const char *error_code, const char *format, ...)`](#ReportUserDefinedErrMsg): Used by developers to report custom error codes. The U code segment is recommended, for example, EU0001.
- [`int32_t RegisterFormatErrorMessage(const char *error_msg, size_t error_msg_len)`](#RegisterFormatErrorMessage): After calling this API to register predefined error code information with CANN in the specified JSON format, call the ReportPredefinedErrMsg API to report the error code.

<a id="usage-notes"></a>

## Usage Notes

The APIs in this chapter are used only in custom development of CANN components and custom operator development scenarios. This document describes the functions and parameters of these APIs, so that you can understand their roles in the CANN open source code and better use or modify the CANN open source code.

Paths of the header file and library file of the error reporting APIs:

- Path of the included header file (the APIs in this header file are in the ge namespace): ${INSTALL_DIR}/include/base/err_msg.h
- Path of the dependent library file: ${INSTALL_DIR}/lib64/liberror_manager.so

Replace ${INSTALL_DIR} with the path where CANN software files are stored after installation. For example, if you install CANN as the root user, the default storage path is /usr/local/Ascend/cann.

<br>
<br>
<br>

<a class="method_anchor" id="ReportInnerErrMsg"></a>

## ReportInnerErrMsg

```text
int32_t ReportInnerErrMsg(const char_t *file_name, const char_t *func, uint32_t line, const char *error_code, const char_t *format, ...)
```

### Applicable Products

<!-- npu="950" id1 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3 products: Supported
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2 products: Supported
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas inference products: Supported
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas training products: Supported
<!-- end id6 -->
<!-- @ref: runtime/res/docs/zh/api_ref/22_error_reporting_APIs_res.md#id1 -->

### Description

Reports the predefined internal error messages of CANN, along with some information about the call site, such as the file name, function name, and line number.

When this API is used, if the format string provided by the user exceeds 1024 characters (including the trailing \0), the API returns error code -1, indicating failure. For example, if the format string is "Error:%s" and the passed string is 1000 characters long, the total length is 1007 with "Error:" and the trailing "\0", so the API call succeeds. However, if the passed string is 1020 characters long, the total length becomes 1027 with "Error:" and the trailing "\0", which exceeds 1024, so the API call fails.

For this API, the macro REPORT_INNER_ERR_MSG that encapsulates it is also provided. The macro is defined as follows:

```text
#define REPORT_INNER_ERR_MSG(error_code, format, ...) \
    (void)ge::ReportInnerErrMsg(__FILE__, __FUNCTION__, __LINE__, (error_code), (format), ##__VA_ARGS__)
```

### Parameters

| Parameter Name | Input/Output | Description |
| --- | --- | --- |
| file_name | Input | File name, indicating the file in which the user calls the ReportInnerErrMsg API. It is fixed to \_\_FILE\_\_. |
| func | Input | Function name, indicating the function in which the user calls the ReportInnerErrMsg API. It is fixed to \_\_FUNCTION\_\_. |
| line | Input | Line number, indicating the line on which the user calls the ReportInnerErrMsg API. It is fixed to \_\_LINE\_\_. |
| error_code | Input | Internal error predefined by CANN.<br>The error code is represented by six characters, for example, E19999. The first character indicates the level, which can be E, W, or I, representing error, warning, and information respectively. The second character indicates the module. The last four characters indicate the error code, where 9000 to 9999 are internal error codes. |
| format | Input | Error message.<br>When a formatting function is called, the types and number of parameters in format must be consistent with the types and number of the actual parameters. |
| ... | Input | Variable parameters in format, added based on the error message. |

### Return Values

- 0: Success.
- -1: Failure.

<br>
<br>
<br>

<a class="method_anchor" id="ReportPredefinedErrMsg"></a>

## ReportPredefinedErrMsg

- Error code information without parameters:

    ```c
    int32_t ReportPredefinedErrMsg(const char *error_code)
    ```

- Error code information with parameters:

    ```c
    int32_t ReportPredefinedErrMsg(const char *error_code, const std::vector<const char *> &key, const std::vector<const char *> &value)
    ```

### Applicable Products

<!-- npu="950" id8 -->
- Ascend 950PR&950DT products: Supported
<!-- end id8 -->
<!-- npu="A3" id9 -->
- Atlas A3 products: Supported
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2 products: Supported
<!-- end id10 -->
<!-- npu="310b" id11 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id11 -->
<!-- npu="310p" id12 -->
- Atlas inference products: Supported
<!-- end id12 -->
<!-- npu="910" id13 -->
- Atlas training products: Supported
<!-- end id13 -->
<!-- @ref: runtime/res/docs/zh/api_ref/22_error_reporting_APIs_res.md#id2 -->

### Description

Reports the predefined user-type error message of CANN.

For this API, the macro **REPORT_PREDEFINED_ERR_MSG** that encapsulates this API is also provided. The macro is defined as follows:

```text
#define REPORT_PREDEFINED_ERRMSG_CHOOSER(_1, _2, _3, NAME, ...) NAME
#define REPORT_PREDEFINED_ERRMSG_1PARAMS(error_code) error_message::ReportPredefinedErrMsg(error_code)
#define REPORT_PREDEFINED_ERRMSG_3PARAMS(error_code, key, value)                                                       \
  error_message::ReportPredefinedErrMsg((error_code), (key), (value))
#define REPORT_PREDEFINED_ERR_MSG(...)                                                                                 \
  REPORT_PREDEFINED_ERRMSG_CHOOSER(__VA_ARGS__, REPORT_PREDEFINED_ERRMSG_3PARAMS, ,                                    \
                                   REPORT_PREDEFINED_ERRMSG_1PARAMS)(__VA_ARGS__)
```

### Parameters

| Parameter Name | Input/Output | Description |
| --- | --- | --- |
| error_code | Input | The error code is represented by six characters, for example, E10001. The first character indicates the level, which can be E, W, or I, representing error, warning, and information, respectively. The second character indicates the module. The last four characters indicate the error code, where 0000 to 8999 are custom errors.<br>For the custom errors predefined by CANN, see the error code reference in [*Troubleshooting*](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/troubleshooting/error_code_desc.md). |
| key | Input | A predefined parameter.<br>For the parameters supported by each error code, see the Arglist field in the error_code.json file. |
| value | Input | The actual value corresponding to the parameter in key.<br>These actual values replace the placeholders in the ErrMessage field of the error_code.json file to obtain the final error code information. |

### Return Values

- 0: Success.
- -1: Failure.

<br>
<br>
<br>

<a class="method_anchor" id="ReportUserDefinedErrMsg"></a>

## ReportUserDefinedErrMsg

```c
int32_t ReportUserDefinedErrMsg(const char *error_code, const char *format, ...)
```

### Applicable Products

<!-- npu="950" id15 -->
- Ascend 950PR&950DT products: Supported
<!-- end id15 -->
<!-- npu="A3" id16 -->
- Atlas A3 products: Supported
<!-- end id16 -->
<!-- npu="910b" id17 -->
- Atlas A2 products: Supported
<!-- end id17 -->
<!-- npu="310b" id18 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id18 -->
<!-- npu="310p" id19 -->
- Atlas inference products: Supported
<!-- end id19 -->
<!-- npu="910" id20 -->
- Atlas training products: Supported
<!-- end id20 -->
<!-- @ref: runtime/res/docs/zh/api_ref/22_error_reporting_APIs_res.md#id3 -->

### Description

Used by developers to report custom error codes. The U code segment is recommended, for example, EU0001.

A six-character format is recommended. For non-recommended forms such as spaces, non-six-character codes, or codes ending with 8888 or 9999, the function reports the error code EU0000 internally.

When this API is used, if the length of the format string provided by the user exceeds 1024 (including the trailing \0), the API returns error code -1, indicating failure. For example, if the format string is "Error:%s" and the length of the passed string is 1000, the total length is 1007 with "Error:" and the trailing "\0", so the API call succeeds. However, if the length of the passed string is 1020, the total length becomes 1027 with "Error:" and the trailing "\0", which exceeds 1024, so the API call fails.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | --- | --- |
| error_code | Input | Custom error code. |
| format | Input | Error message corresponding to the error code. |
| ... | Input | Variable arguments in format, representing the variable values corresponding to the placeholders in format. |

### Return Values

- 0: Success.
- -1: Failure.

<br>
<br>
<br>

<a class="method_anchor" id="RegisterFormatErrorMessage"></a>

## RegisterFormatErrorMessage

```c
int32_t RegisterFormatErrorMessage(const char *error_msg, size_t error_msg_len)
```

### Applicable Products

<!-- npu="950" id22 -->
- Ascend 950PR&950DT products: Supported
<!-- end id22 -->
<!-- npu="A3" id23 -->
- Atlas A3 products: Supported
<!-- end id23 -->
<!-- npu="910b" id24 -->
- Atlas A2 products: Supported
<!-- end id24 -->
<!-- npu="310b" id25 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id25 -->
<!-- npu="310p" id26 -->
- Atlas inference products: Supported
<!-- end id26 -->
<!-- npu="910" id27 -->
- Atlas training products: Supported
<!-- end id27 -->
<!-- @ref: runtime/res/docs/zh/api_ref/22_error_reporting_APIs_res.md#id4 -->

### Description

After registering the predefined error code information with CANN by calling this API in the specified JSON format, call the [ReportPredefinedErrMsg](#ReportPredefinedErrMsg) API to report the error code.

For ease of use, the macro **REG_FORMAT_ERROR_MSG** is encapsulated. You can directly use this macro for registration. The macro defines a static variable for registration, and the registration is completed when the process is loaded.

```text
#define REG_FORMAT_ERROR_MSG(error_msg, error_msg_len) \
  REG_FORMAT_ERROR_MSG_UNIQ_HELPER((error_msg), (error_msg_len), __COUNTER__)
#define REG_FORMAT_ERROR_MSG_UNIQ_HELPER(error_msg, error_msg_len, counter) \
  REG_FORMAT_ERROR_MSG_UNIQ((error_msg), (error_msg_len), counter)
#define REG_FORMAT_ERROR_MSG_UNIQ(error_msg, error_msg_len, counter) \
  static const auto register_error_msg_##counter ATTRIBUTE_USED = []() -> int32_t { \
    return error_message::RegisterFormatErrorMessage((error_msg), (error_msg_len)); \
  }()
```

### Parameters

| Parameter Name | Input/Output | Description |
| --- | --- | --- |
| error_msg | Input | Error code information. Multiple error codes can be registered at a time.<br>The error code information must be organized in JSON format. For an example, see [Example](#example). |
| error_msg_len | Input | Length of error_msg, excluding the trailing '\0'. |

### Return Values

- 0: Success.
- -1: Failure.

<a id="Example"></a>

### Example

The error_msg error code information must be organized in JSON format. error_info_list is an array of error information objects and must contain at least one element. The meaning of each field is as follows:

- errClass: Error classification.
- errTitle: Error title.
- ErrCode: Error code. Ensure that it does not duplicate any existing error code. For existing error codes, see the error code reference in [*Troubleshooting*](https://gitcode.com/cann/docs/blob/9.2.0/docs/en/troubleshooting/error_code_desc.md).
- ErrMessage: Error message, in which format placeholders (%s) can be included.
- Arglist: Parameter list used to describe the parameters corresponding to the placeholders in ErrMessage. The length of the parameter list must be equal to the number of format placeholders in ErrMessage.
- suggestion: Suggestion information, including:
    - Possible Cause: Possible cause.
    - Solution: Solution.

```text
#include <string>
#include "base/err_msg.h"

const std::string error_msg = R"(
{
    "error_info_list": 
    [
        {
            "errClass": "GE Errors",
            "errTitle": "Invalid_Dynamic_Shape_Argument",
            "ErrCode": "E10018",
            "ErrMessage": "Value [%s] for shape [%s] is invalid. When [--dynamic_batch_size] is included, only batch size N can be -1 in [--input_shape].",
            "Arglist": "shape,index",
            "suggestion": {
                "Possible Cause": "When [--dynamic_batch_size] is included, only batch size N can be -1 in the shape.",
                "Solution": "Try again with a valid [--input_shape] argument. Make sure that non-batch size axes are not -1."
            }
        },        
        {
           "errClass": "GE Errors",
           "errTitle": "Invalid_--input_shape_Argument",
           "ErrCode": "E10019",
           "ErrMessage": "When [--dynamic_image_size] is included, only the height and width axes can be -1 in [--input_shape].",
           "Arglist": "",
           "suggestion": {
                "Possible Cause": "When [--dynamic_image_size] is included, only the height and width axes can be -1 in the shape.",
                "Solution": "Try again with a valid [--input_shape] argument. Make sure that axes other than height and width are not -1."
            }
        }
    ]
}
)";

REG_FORMAT_ERROR_MSG(error_msg.c_str(), error_msg.size());
```
