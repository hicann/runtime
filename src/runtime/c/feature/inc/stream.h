/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_C_FEATURE_STREAM_H
#define RUNTIME_C_FEATURE_STREAM_H

#include "common.h"
#include "runtime/rt.h"
#include "hal_ts.h"
#if defined(__cplusplus)
extern "C" {
#endif

// stream
Stream* CreateStream(Context* curCtx, rtStreamConfigHandle *handle, rtError_t *error);
rtError_t FreeStream(Stream *stream);
uint64_t GetStreamThreadID(rtStream_t stm, SUBSCRIBE_TYPE type);
bool SetStreamThreadID(rtStream_t stm, SUBSCRIBE_TYPE type, uint64_t threadId);
void ResetStreamThreadID(rtStream_t stm, SUBSCRIBE_TYPE type);
uint32_t GetStreamDeviceId(rtStream_t stm);
uint32_t GetStreamSqID(rtStream_t stm);

#if defined(__cplusplus)
}
#endif

#endif // RUNTIME_C_FEATURE_BASE_H