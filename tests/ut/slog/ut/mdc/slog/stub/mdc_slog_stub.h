/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MDC_SLOG_STUB_H
#define MDC_SLOG_STUB_H

#include "log_iam_pub.h"
#include "iam.h"
#include "unified_timer.h"
#include "library_load.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

int32_t SlogIamIoctl(int32_t fd, uint32_t cmd, struct IAMIoctlArg *arg);
int32_t SlogIamIoctlStub(int32_t fd, uint32_t cmd, struct IAMIoctlArg *arg);
int32_t clock_gettime_stub(clockid_t clock_id, struct timespec *tp);
void ResetStatus(void);

void *logDlopen(const char *fileName, int mode);
int logDlclose(void *handle);
void *logDlsym(void *handle, const char* funcName);
void DlogCreateCmdFile(int32_t clockId);
int32_t DlogGetLogLossNum(char *msg, int32_t mode);
void SlogSetEventLevel(int32_t level);
void DlogStopSendThread(void);

void SlogSetLevel(int32_t level);
#ifdef __cplusplus
}
#endif // __cplusplus

#endif