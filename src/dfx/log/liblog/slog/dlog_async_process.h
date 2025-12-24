/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_NSYC_PROCESS_H
#define DLOG_NSYC_PROCESS_H

#include "high_mem.h"
#include "dlog_iam.h"
#include "dlog_attr.h"
#include "dlog_message.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void DlogWriteToBuf(const LogMsg *logMsg);
void DlogFlushBuf(void);
void DlogUpdateFlierLevelStatus(void);

int32_t DlogAsyncInit(void);
void DlogAsyncExit(void);

void CheckPid(void);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // DLOG_NSYC_PROCESS_H
