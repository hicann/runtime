/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INC_EXTERNAL_BASE_ERR_MSG_H_
#define INC_EXTERNAL_BASE_ERR_MSG_H_

#include <cstdint>
#include <vector>
#include <memory>

#if defined(__GNUC__)
#ifndef GE_FUNC_HOST_VISIBILITY
#if defined(HOST_VISIBILITY)
#define GE_FUNC_HOST_VISIBILITY __attribute__((visibility("default")))
#else
#define GE_FUNC_HOST_VISIBILITY
#endif
#endif  // GE_FUNC_HOST_VISIBILITY

#ifndef GE_FUNC_DEV_VISIBILITY
#if defined(DEV_VISIBILITY)
#define GE_FUNC_DEV_VISIBILITY __attribute__((visibility("default")))
#else
#define GE_FUNC_DEV_VISIBILITY
#endif
#endif  // GE_FUNC_DEV_VISIBILITY

#ifndef WEAK_SYMBOL
#define WEAK_SYMBOL __attribute__((weak))
#endif

#ifndef FORMAT_PRINTF
#define FORMAT_PRINTF(format_idx, first_arg) __attribute__((format(printf, (format_idx), (first_arg))))
#endif
#else
#ifndef GE_FUNC_HOST_VISIBILITY
#define GE_FUNC_HOST_VISIBILITY
#endif

#ifndef GE_FUNC_DEV_VISIBILITY
#define GE_FUNC_DEV_VISIBILITY
#endif

#ifndef WEAK_SYMBOL
#define WEAK_SYMBOL
#endif

#ifndef FORMAT_PRINTF
#define FORMAT_PRINTF(format_idx, first_arg)
#endif
#endif  // defined(__GNUC__)

#ifdef __GNUC__
#define ATTRIBUTE_USED __attribute__((used))
#else
#define ATTRIBUTE_USED
#endif

#define REPORT_INNER_ERR_MSG(error_code, format, ...)                                                                  \
  (void) error_message::ReportInnerErrMsg(__FILE__, __FUNCTION__, __LINE__, (error_code), (format), ##__VA_ARGS__)

#define REPORT_USER_DEFINED_ERR_MSG(error_code, format, ...)                                                           \
  (void) error_message::ReportUserDefinedErrMsg((error_code), (format), ##__VA_ARGS__)

#define REPORT_PREDEFINED_ERRMSG_CHOOSER(_1, _2, _3, NAME, ...) NAME

#define REPORT_PREDEFINED_ERRMSG_1PARAMS(error_code) error_message::ReportPredefinedErrMsg(error_code)

#define REPORT_PREDEFINED_ERRMSG_3PARAMS(error_code, key, value)                                                       \
  error_message::ReportPredefinedErrMsg((error_code), (key), (value))

#define REPORT_PREDEFINED_ERR_MSG(...)                                                                                 \
  REPORT_PREDEFINED_ERRMSG_CHOOSER(__VA_ARGS__, REPORT_PREDEFINED_ERRMSG_3PARAMS, ,                                    \
                                   REPORT_PREDEFINED_ERRMSG_1PARAMS)(__VA_ARGS__)

#define REG_FORMAT_ERROR_MSG(error_msg, error_msg_len)                                                                 \
  REG_FORMAT_ERROR_MSG_UNIQ_HELPER((error_msg), (error_msg_len), __COUNTER__)

#define REG_FORMAT_ERROR_MSG_UNIQ_HELPER(error_msg, error_msg_len, counter)                                            \
  REG_FORMAT_ERROR_MSG_UNIQ((error_msg), (error_msg_len), counter)

#define REG_FORMAT_ERROR_MSG_UNIQ(error_msg, error_msg_len, counter)                                                   \
  static const auto &register_error_msg_##counter ATTRIBUTE_USED = []() -> int32_t {                                   \
    return error_message::RegisterFormatErrorMessage((error_msg), (error_msg_len));                                    \
  }()

namespace error_message {
constexpr size_t const LIMIT_PER_MSG = 1024U;
using char_t = char;

/**
 * Register format error message
 * @param [in] error_msg: register >= 1 error message, use json format
 * @param [in] error_msg_len: error message len, not contain '\0'
 * @return int32_t 0(success) -1(fail)
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
int32_t RegisterFormatErrorMessage(const char *error_msg, size_t error_msg_len) WEAK_SYMBOL;
/**
 * Report inner error message
 * @param [in] file_name: report file name
 * @param [in] func: report function name
 * @param [in] line: report line number of file_name
 * @param [in] error_code: predefined error code
 * @param [in] format: format of error message
 * @param [in] ...: value of arguments
 */

GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
int32_t ReportInnerErrMsg(const char *file_name, const char *func, uint32_t line, const char *error_code,
                          const char *format, ...) FORMAT_PRINTF(5, 6) WEAK_SYMBOL;

/**
 * Report user defined error message
 * @param [in] error_code: user defined error code, support EU0000 ~ EU9999
 * @param [in] format: format of error message
 * @param [in] ...: value of arguments
 * @return int32_t 0(success) -1(fail)
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
int32_t ReportUserDefinedErrMsg(const char *error_code, const char *format, ...) FORMAT_PRINTF(2, 3) WEAK_SYMBOL;

/**
 * Report CANN predefined error message
 * @param [in] error_code: predefined error code
 * @param [in] key: vector parameter key
 * @param [in] value: vector parameter value
 * @return int32_t 0(success) -1(fail)
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
int32_t ReportPredefinedErrMsg(const char *error_code, const std::vector<const char *> &key,
                               const std::vector<const char *> &value) WEAK_SYMBOL;

/**
 * Report CANN predefined error message
 * @param [in] error_code: predefined error code
 * @return int32_t 0(success) -1(fail)
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
int32_t ReportPredefinedErrMsg(const char *error_code) WEAK_SYMBOL;

}  // namespace error_message

namespace ge {
using error_message::ReportInnerErrMsg;
using error_message::ReportPredefinedErrMsg;
using error_message::ReportUserDefinedErrMsg;
} // namespace ge

#endif  // INC_EXTERNAL_BASE_ERR_MSG_H_