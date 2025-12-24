/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PKG_INC_BASE_ERR_MGR_H_
#define PKG_INC_BASE_ERR_MGR_H_

#include <memory>
#include "base/err_msg.h"

namespace error_message {
struct ErrorManagerContext {
  uint64_t work_stream_id = 0; // default value 0, invalid value
  uint64_t reserved[7] = {0};
};

enum class ErrorMessageMode : uint32_t {
  // 0:内置模式，采用上下文粒度记录错误码，1：以进程为粒度
  INTERNAL_MODE = 0U,
  PROCESS_MODE = 1U,
  // add mode here
  ERR_MSG_MODE_MAX = 10U
};
using char_t = char;
using unique_const_char_array = std::unique_ptr<const char_t[]>;
struct ErrMsgRawItem {
  unique_const_char_array error_id;
  unique_const_char_array error_title;
  unique_const_char_array error_message;
  unique_const_char_array possible_cause;
  unique_const_char_array solution;
  std::vector<unique_const_char_array> args_key;
  std::vector<unique_const_char_array> args_value;
  unique_const_char_array report_time;
};

/**
 * @brief init error manager with error message mode
 * @param [in] error_mode: error mode, see ErrorMessageMode definition
 * @return int32_t 0(success) -1(fail)
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
int32_t ErrMgrInit(ErrorMessageMode error_mode) WEAK_SYMBOL;

/**
 * @brief Get Error manager context
 * @return An error manager context
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
ErrorManagerContext GetErrMgrContext() WEAK_SYMBOL;

/**
 * @brief Set Error manager context
 * @param [in] An error manager context
 * @return void
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
void SetErrMgrContext(ErrorManagerContext error_context) WEAK_SYMBOL;

/**
 * @brief Get error message from error manager
 * @return unique_const_char_array, error message
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
unique_const_char_array GetErrMgrErrorMessage() WEAK_SYMBOL;

/**
 * @brief Get warning message from error manager
 * @return unique_const_char_array, warning message
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
unique_const_char_array GetErrMgrWarningMessage() WEAK_SYMBOL;

/**
 * @brief Get raw error message from error manager
 * @return the complete info of the error message
 */
GE_FUNC_HOST_VISIBILITY GE_FUNC_DEV_VISIBILITY
std::vector<ErrMsgRawItem> GetErrMgrRawErrorMessages() WEAK_SYMBOL;
}  // namespace error_message

#endif  // PKG_INC_BASE_ERR_MGR_H_
