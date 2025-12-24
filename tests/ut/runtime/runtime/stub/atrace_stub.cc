/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "atrace_api.h"

TraHandle AtraceCreate(TracerType tracerType, const char *objName)
{
    return 0;
}

TraEventHandle AtraceEventCreate(const char *eventName)
{
    return 0;
}

TraStatus AtraceEventSetAttr(TraEventHandle eventHandle, const TraceEventAttr *attr)
{
    return TRACE_SUCCESS;
}

TraStatus AtraceEventBindTrace(TraEventHandle eventHandle, TraHandle handle)
{
    return TRACE_SUCCESS;
}

TraStatus AtraceEventReport(TraEventHandle eventHandle)
{
    return TRACE_SUCCESS;
}

void AtraceEventDestroy(TraEventHandle eventHandle)
{}

void AtraceDestroy(TraHandle handle)
{
    return;
}

TraStatus AtraceSubmit(TraHandle handle, const void *buffer, uint32_t bufSize)
{
    return 0;
}

TraStatus AtraceSave(TracerType tracerType, bool SyncFlag)
{
    return 0;
}

int AtraceReportStart(int devId)
{
    return 0;
}

void AtraceReportStop(int devId)
{
    return;
}