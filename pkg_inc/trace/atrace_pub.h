/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ATRACE_PUB_H
#define ATRACE_PUB_H

#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif
/**
 * @brief       Create trace handle.
 * @param [in]  tracerType:    trace type
 * @param [in]  objName:       object name
 * @return      atrace handle
 */
TRACE_EXPORT TraHandle AtraceCreate(TracerType tracerType, const char *objName) __attribute((weak));

/**
 * @brief       Create trace handle.
 * @param [in]  tracerType:    trace type
 * @param [in]  objName:       object name
 * @param [in]  attr:          object attribute
 * @return      atrace handle
 */
TRACE_EXPORT TraHandle
    AtraceCreateWithAttr(TracerType tracerType, const char *objName, const TraceAttr *attr) __attribute((weak));

/**
 * @brief       Get trace handle
 * @param [in]  tracerType:    trace type
 * @param [in]  objName:       object name
 * @return      atrace handle
 */
TRACE_EXPORT TraHandle AtraceGetHandle(TracerType tracerType, const char *objName) __attribute((weak));

/**
 * @brief       Submite trace info
 * @param [in]  handle:    trace handle
 * @param [in]  buffer:    trace info buffer
 * @param [in]  bufSize:   size of buffer
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceSubmit(TraHandle handle, const void *buffer, uint32_t bufSize) __attribute((weak));

/**
 * @brief       Destroy trace handle
 * @param [in]  handle:    trace handle
 * @return      NA
 */
TRACE_EXPORT void AtraceDestroy(TraHandle handle) __attribute((weak));

/**
 * @brief       Save trace info for all handle of tracerType
 * @param [in]  tracerType:    trace type to be saved
 * @param [in]  syncFlag:      synchronize or asynchronizing
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceSave(TracerType tracerType, bool syncFlag) __attribute((weak));

/**
 * @brief       Submit trace info by buffer type
 * @param [in]  handle:         trace handle
 * @param [in]  bufferType:     buffer type
 * @param [in]  buffer:         trace info buffer
 * @param [in]  bufSize:        size of buffer
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceSubmitByType(TraHandle handle, uint8_t bufferType,
    const void *buffer, uint32_t bufSize) __attribute((weak));

/**
 * @brief           create trace struct entry with name
 * @param [in]      name:       trace struct entry name
 * @return          success:trace struct entry  fail:null
 */
TRACE_EXPORT TraceStructEntry *AtraceStructEntryCreate(const char *name) __attribute((weak));

/**
 * @brief           destroy trace struct entry
 * @param [in]      name:       trace struct entry name
 * @return          NA
 */
TRACE_EXPORT void AtraceStructEntryDestroy(TraceStructEntry *en) __attribute((weak));

/**
 * @brief           define trace struct item
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @param [in]      type:       item type
 * @param [in]      mode:       item save mode
 * @param [in]      len:        bytes occupied by this item
 * @return          NA
 */
TRACE_EXPORT void AtraceStructItemFieldSet(TraceStructEntry *en, const char *item,
    uint8_t type, uint8_t mode, uint16_t len) __attribute((weak));

/**
 * @brief           define trace struct item if array
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @param [in]      type:       item type
 * @param [in]      mode:       item save mode
 * @param [in]      len:        bytes occupied by this item
 * @return          NA
 */
TRACE_EXPORT void AtraceStructItemArraySet(TraceStructEntry *en, const char *item,
    uint8_t type, uint8_t mode, uint16_t len) __attribute((weak));

/**
 * @brief           set trace struct to trace attribute
 * @param [in]      en:         trace struct entry
 * @param [in]      type:       trace buffer type
 * @param [in/out]  attr:       object attribute
 * @return          NA
 */
TRACE_EXPORT void AtraceStructSetAttr(TraceStructEntry *en, uint8_t type, TraceAttr *attr) __attribute((weak));

/**
 * @brief       Create trace event.
 * @param [in]  eventName:     event name
 * @return      event handle
 */
TRACE_EXPORT TraEventHandle AtraceEventCreate(const char *eventName) __attribute((weak));

/**
 * @brief       Get event handle
 * @param [in]  eventName:     event name
 * @return      event handle
 */
TRACE_EXPORT TraEventHandle AtraceEventGetHandle(const char *eventName) __attribute((weak));

/**
 * @brief       Destroy event handle
 * @param [in]  eventHandle:    event handle
 * @return      NA
 */
TRACE_EXPORT void AtraceEventDestroy(TraEventHandle eventHandle) __attribute((weak));

/**
 * @brief       Bind event handle with trace handle
 * @param [in]  eventHandle:    event handle
 * @param [in]  handle:         trace handle
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceEventBindTrace(TraEventHandle eventHandle, TraHandle handle) __attribute((weak));

/**
 * @brief       Set event attr
 * @param [in]  eventHandle:    event handle
 * @param [in]  attr:           event attribute
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceEventSetAttr(TraEventHandle eventHandle, const TraceEventAttr *attr) __attribute((weak));

/**
 * @brief       Report event and save the bound trace log to disk
 * @param [in]  eventHandle:    event handle
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceEventReportSync(TraEventHandle eventHandle) __attribute((weak));

/**
 * @brief       set global attribute
 * @param [in]  attr:           global attribute
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceSetGlobalAttr(const TraceGlobalAttr *attr) __attribute((weak));

#ifdef __cplusplus
}
#endif // end of the 'extern "C"' block

#endif