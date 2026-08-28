/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TESTS_UT_MSPROF_STUB_ERROR_MANAGER_STUB2_H
#define TESTS_UT_MSPROF_STUB_ERROR_MANAGER_STUB2_H

#include <string>
#include <vector>
#include "msprof_error_manager.h"

namespace MsprofUtestStub {
void ResetMsprofLastInputErrorCode();
void RecordMsprofInputErrorCode(const std::string& errorCode);
void RecordMsprofInputErrorCode(const std::string& errorCode, const std::vector<std::string>& values);
const std::string& GetMsprofLastInputErrorCode();
const std::vector<std::string>& GetMsprofLastInputErrorValues();
} // namespace MsprofUtestStub

#ifdef MSPROF_INPUT_ERROR
#undef MSPROF_INPUT_ERROR
#endif
#ifdef MSPROF_ENV_ERROR
#undef MSPROF_ENV_ERROR
#endif
#ifdef MSPROF_INNER_ERROR
#undef MSPROF_INNER_ERROR
#endif
#ifdef MSPROF_CALL_ERROR
#undef MSPROF_CALL_ERROR
#endif

#ifdef MSPROF_ENABLE_INPUT_ERROR_STUB
#define MSPROF_INPUT_ERROR(error_code, key, value) MsprofUtestStub::RecordMsprofInputErrorCode(error_code, value)
#define MSPROF_ENV_ERROR(error_code, key, value) MsprofUtestStub::RecordMsprofInputErrorCode(error_code, value)
#else
#define MSPROF_INPUT_ERROR(error_code, key, value)
#define MSPROF_ENV_ERROR(error_code, key, value)
#endif
#define MSPROF_INNER_ERROR(error_code, fmt, ...)
#define MSPROF_CALL_ERROR MSPROF_INNER_ERROR

#endif // TESTS_UT_MSPROF_STUB_ERROR_MANAGER_STUB2_H
