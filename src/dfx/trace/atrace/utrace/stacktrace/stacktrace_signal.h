/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_SIGNAL_H
#define STACKTRACE_SIGNAL_H

#include "stacktrace_logger.h"
#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
#define REGISTER_SIGNAL_NUM 13U

typedef struct TraceSignalInfo {
    int32_t signo;
    siginfo_t *siginfo;
    void *ucontext;
    uint64_t timeStamp;
} TraceSignalInfo;

typedef TraStatus (*TraceSignalHandle)(const TraceSignalInfo *);

TraStatus TraceSignalInit(void);
void TraceSignalExit(void);

TraStatus TraceSignalAddFunc(const int32_t *signo, uint32_t size, TraceSignalHandle func);
bool TraceSignalCheckExit(void);
void TraceSignalSetHandleFlag(bool value);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif