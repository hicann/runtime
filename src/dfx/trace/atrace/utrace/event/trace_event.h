/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_EVENT_H
#define TRACE_EVENT_H

#include "atrace_types.h"
#include "trace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define MAX_RELATED_TRACER_NUM 5U
#define MAX_EVENT_NAME_LENGTH 32U
typedef TraStatus (*ProcessFunc)(void *);
typedef TraStatus (*ProbeFunc)(const void *);
typedef struct EventProbeInfo {
    int32_t interval;
    ProbeFunc func;
} EventProbeInfo;

typedef struct TraceEventNode {
    char eventName[MAX_EVENT_NAME_LENGTH];
    TraHandle relatedTraceObj[MAX_RELATED_TRACER_NUM];
    ProcessFunc processFunc;
    EventProbeInfo probe;
    TraceEventAttr attr;
    TracerHandle relatedTracer;
    uint8_t relatedTraceObjNum;
    uint16_t reportNum;
} TraceEventNode;

TraStatus TraceEventInit(void);
void TraceEventExit(void);
TraEventHandle TraceEventCreate(const char *eventName);
TraEventHandle TraceEventGetHandle(const char *eventName);
void TraceEventDestroy(TraEventHandle eventHandle);
TraStatus TraceEventBindTrace(TraEventHandle eventHandle, TraHandle handle);
TraStatus TraceEventUnbindTrace(TraEventHandle eventHandle, TraHandle handle);
TraStatus TraceEventSetAttr(TraEventHandle eventHandle, const TraceEventAttr *attr);
TraStatus TraceEventReport(TraEventHandle eventHandle);
TraStatus TraceEventBindTracer(TraEventHandle eventHandle, TracerHandle tracer);
TraStatus TraceEventUnbindTracer(TraEventHandle eventHandle, TracerHandle tracer);


#ifdef __cplusplus
}
#endif // __cplusplus
#endif

