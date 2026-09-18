/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 * -----------------------------------------------------------------------------------------------------------
 * Description: libascend_trace.so 桩实现。用于小型化芯片等不需要 trace 功能的形态,
 * 替换真实库后保证上下游依赖接口调用正常返回(静默成功语义):
 *   - Handle 创建类返回固定有效假句柄, 调用方(如 runtime.cc 判 handle < 0)不会认为失败;
 *   - 状态类返回 TRACE_SUCCESS, 调用方不会打告警或错误日志;
 *   - void 类为空实现。
 * 导出符号与真实库保持一致: atrace_pub.h 19 个 + atrace_api.h 7 个 + atrace_stackcore_api.h 1 个, 共 27 个。
 */

#include <stddef.h>
#include "atrace_api.h"
#include "atrace_pub.h"
#include "atrace_stackcore_api.h"

#define ATRACE_STUB_FAKE_HANDLE ((TraHandle)1)
#define ATRACE_STUB_FAKE_EVENT_HANDLE ((TraEventHandle)1)

static TraceStructEntry g_atraceStubStructEntry = {0};

TraHandle AtraceCreate(TracerType tracerType, const char* objName)
{
    (void)tracerType;
    (void)objName;
    return ATRACE_STUB_FAKE_HANDLE;
}

TraHandle AtraceCreateWithAttr(TracerType tracerType, const char* objName, const TraceAttr* attr)
{
    (void)tracerType;
    (void)objName;
    (void)attr;
    return ATRACE_STUB_FAKE_HANDLE;
}

TraHandle AtraceGetHandle(TracerType tracerType, const char* objName)
{
    (void)tracerType;
    (void)objName;
    return ATRACE_STUB_FAKE_HANDLE;
}

TraEventHandle AtraceEventCreate(const char* eventName)
{
    (void)eventName;
    return ATRACE_STUB_FAKE_EVENT_HANDLE;
}

TraEventHandle AtraceEventGetHandle(const char* eventName)
{
    (void)eventName;
    return ATRACE_STUB_FAKE_EVENT_HANDLE;
}

TraceStructEntry* AtraceStructEntryCreate(const char* name)
{
    (void)name;
    return &g_atraceStubStructEntry;
}

TraStatus AtraceSubmit(TraHandle handle, const void* buffer, uint32_t bufSize)
{
    (void)handle;
    (void)buffer;
    (void)bufSize;
    return TRACE_SUCCESS;
}

TraStatus AtraceSubmitByType(TraHandle handle, uint8_t bufferType, const void* buffer, uint32_t bufSize)
{
    (void)handle;
    (void)bufferType;
    (void)buffer;
    (void)bufSize;
    return TRACE_SUCCESS;
}

void AtraceDestroy(TraHandle handle) { (void)handle; }

TraStatus AtraceSave(TracerType tracerType, bool syncFlag)
{
    (void)tracerType;
    (void)syncFlag;
    return TRACE_SUCCESS;
}

void AtraceStructEntryDestroy(TraceStructEntry* en) { (void)en; }

void AtraceStructItemFieldSet(TraceStructEntry* en, const char* item, uint8_t type, uint8_t mode, uint16_t len)
{
    (void)en;
    (void)item;
    (void)type;
    (void)mode;
    (void)len;
}

void AtraceStructItemArraySet(TraceStructEntry* en, const char* item, uint8_t type, uint8_t mode, uint16_t len)
{
    (void)en;
    (void)item;
    (void)type;
    (void)mode;
    (void)len;
}

void AtraceStructSetAttr(TraceStructEntry* en, uint8_t type, TraceAttr* attr)
{
    (void)en;
    (void)type;
    (void)attr;
}

TraStatus AtraceEventBindTrace(TraEventHandle eventHandle, TraHandle handle)
{
    (void)eventHandle;
    (void)handle;
    return TRACE_SUCCESS;
}

TraStatus AtraceEventSetAttr(TraEventHandle eventHandle, const TraceEventAttr* attr)
{
    (void)eventHandle;
    (void)attr;
    return TRACE_SUCCESS;
}

TraStatus AtraceEventReportSync(TraEventHandle eventHandle)
{
    (void)eventHandle;
    return TRACE_SUCCESS;
}

TraStatus AtraceSetGlobalAttr(const TraceGlobalAttr* attr)
{
    (void)attr;
    return TRACE_SUCCESS;
}

void AtraceEventDestroy(TraEventHandle eventHandle) { (void)eventHandle; }

void* AtraceStructEntryListInit(void) { return NULL; }

void AtraceStructEntryName(TraceStructEntry* entry, const char* name)
{
    (void)entry;
    (void)name;
}

void AtraceStructItemSet(TraceStructEntry* entry, const char* name, uint8_t type, uint8_t mode, uint16_t length)
{
    (void)entry;
    (void)name;
    (void)type;
    (void)mode;
    (void)length;
}

void AtraceStructEntryExit(TraceStructEntry* entry) { (void)entry; }

TraStatus AtraceEventReport(TraEventHandle eventHandle)
{
    (void)eventHandle;
    return TRACE_SUCCESS;
}

TraStatus AtraceReportStart(int32_t devId)
{
    (void)devId;
    return TRACE_SUCCESS;
}

void AtraceReportStop(int32_t devId) { (void)devId; }

TraStatus AtraceStackcoreParse(const char* filePath, uint32_t len)
{
    (void)filePath;
    (void)len;
    return TRACE_SUCCESS;
}
