/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_ERROR_LOG_API_H
#define AICPU_ERROR_LOG_API_H

#include <queue>
#include <string>
#include "common/type_def.h"

namespace aicpu {
    void InitAicpuErrorLog();

    void RestoreErrorLog(const char_t * const funcName, const char_t * const filePath, const int32_t lineNumber,
                         const uint64_t tid, const char_t * const format, ...);

    __attribute__((weak)) void PrintErrorLog();
    __attribute__((weak)) bool HasErrorLog();
}

#endif