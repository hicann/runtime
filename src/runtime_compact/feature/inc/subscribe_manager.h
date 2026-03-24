/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_C_FEATURE_SUBSCRIBE_MANAGER_H
#define RUNTIME_C_FEATURE_SUBSCRIBE_MANAGER_H

#include "sort_vector.h"
#include "error_codes/rt_error_codes.h"
#include "runtime/base.h"
#include "stream.h"
#include "hal_ts.h"
#if defined(__cplusplus)
extern "C" {
#endif

#define PID_INVALID_LEN 32U

uint64_t GetCurSubscribeId(void);
rtError_t SubscribeReport(uint64_t threadId, rtStream_t stm, SUBSCRIBE_TYPE type);
rtError_t UnSubscribeReport(uint64_t threadId, rtStream_t stm, SUBSCRIBE_TYPE type);

#if defined(__cplusplus)
}
#endif

#endif // RUNTIME_C_FEATURE_SUBSCRIBE_MANAGER_H
