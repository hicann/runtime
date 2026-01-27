/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUPROCESS_WEAK_LOG_H
#define AICPUPROCESS_WEAK_LOG_H

#include "dlog_pub.h"

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus
LOG_FUNC_VISIBILITY int32_t __attribute__((weak)) CheckLogLevel(int32_t moduleId, int32_t logLevel);
#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus
#endif  // AICPUPROCESS_WEAK_LOG_H