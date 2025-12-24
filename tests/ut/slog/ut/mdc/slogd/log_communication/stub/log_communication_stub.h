/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_COMMUNICATION_STUB_H
#define LOG_COMMUNICATION_STUB_H

#include "log_pm_sig.h"
#include "slogd_flush.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

int32_t LogGetSigNo_stub(void);
void SlogdFlushToBuf_stub(const char *msg, uint32_t msgLen, const LogInfo *info);
const char *GetBufferStr(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // LOG_COMMUNICATION_STUB_H