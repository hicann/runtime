/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifdef ATRACE_API
#include "atrace_api.h"
#else
#include "utrace_api.h"
#endif
#include "trace_attr.h"
#include "tracer_core.h"
#include "adiag_print.h"
#include "adiag_list.h"
#include "trace_event.h"

#ifdef ATRACE_API
#define TRACE_API(func) Atrace##func
#else
#define TRACE_API(func) Utrace##func
#endif

/**
 * @brief       Create trace handle.
 * @param [in]  tracerType:    trace type
 * @param [in]  objName:       objName object name
 * @return      atrace handle
 */
TraHandle TRACE_API(Create)(TracerType tracerType, const char *objName)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceCreate is not supported on device side");
        return TRACE_UNSUPPORTED_HANDLE;
    }
    ADIAG_CHK_EXPR_ACTION(tracerType >= TRACER_TYPE_MAX, return TRACE_INVALID_HANDLE,
        "tracer type %d is invalid.", (int32_t)tracerType);
    ADIAG_CHK_NULL_PTR(objName, return TRACE_INVALID_HANDLE);

    TraceAttr attr = {0};
    attr.exitSave = false;
    TraHandle ret = TracerObjCreate(tracerType, objName, &attr);
    ADIAG_DBG("AtraceCreate [%s].", objName);
    return ret;
}

/**
 * @brief       Create trace handle.
 * @param [in]  tracerType:    trace type
 * @param [in]  objName:       object name
 * @param [in]  attr:          object attribute
 * @return      atrace handle
 */
TraHandle TRACE_API(CreateWithAttr)(TracerType tracerType, const char *objName, const TraceAttr *attr)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceCreate is not supported on device side");
        return TRACE_UNSUPPORTED_HANDLE;
    }
    ADIAG_CHK_EXPR_ACTION(tracerType >= TRACER_TYPE_MAX, return TRACE_INVALID_HANDLE,
        "tracer type %d is invalid.", (int32_t)tracerType);
    ADIAG_CHK_NULL_PTR(objName, return TRACE_INVALID_HANDLE);

    TraHandle ret = TracerObjCreate(tracerType, objName, attr);
    ADIAG_DBG("AtraceCreateWithAttr [%s].", objName);
    return ret;
}

/**
 * @brief       Get trace handle
 * @param [in]  tracerType:    trace type
 * @param [in]  objName:       objName object name
 * @return      atrace handle
 */
TraHandle TRACE_API(GetHandle)(TracerType tracerType, const char *objName)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceGetHandle is not supported on device side");
        return TRACE_UNSUPPORTED_HANDLE;
    }
    return TracerObjGet(tracerType, objName);
}

/**
 * @brief       Submit trace info
 * @param [in]  handle:    trace handle
 * @param [in]  buffer:    trace info buffer
 * @param [in]  bufSize:   size of buffer
 * @return      TraStatus
 */
TraStatus TRACE_API(Submit)(TraHandle handle, const void *buffer, uint32_t bufSize)
{
    return TracerObjSubmit(handle, 0, buffer, bufSize);
}
 
/**
 * @brief       Submit trace info by buffer type
 * @param [in]  handle:         trace handle
 * @param [in]  bufferType:     buffer type
 * @param [in]  buffer:         trace info buffer
 * @param [in]  bufSize:        size of buffer
 * @return      TraStatus
 */
TraStatus TRACE_API(SubmitByType)(TraHandle handle, uint8_t bufferType, const void *buffer, uint32_t bufSize)
{
    return TracerObjSubmit(handle, bufferType, buffer, bufSize);
}

/**
 * @brief       Destroy trace handle
 * @param [in]  handle:    trace handle
 * @return      NA
 */
void TRACE_API(Destroy)(TraHandle handle)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceDestroy is not supported on device side");
        return;
    }
    TracerObjDestroy(handle);
}

/**
 * @brief       Save trace info for all handle of tracerType
 * @param [in]  tracerType:    trace type to be saved
 * @param [in]  syncFlag:      synchronous or asynchronous
 * @return      TraStatus
 */
TraStatus TRACE_API(Save)(TracerType tracerType, bool syncFlag)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceSave is not supported on device side");
        return TRACE_UNSUPPORTED;
    }
    ADIAG_INF("AtraceSave start, tracerType: %d, syncFlag: %d", (int32_t)tracerType, (int32_t)syncFlag);

    TraStatus ret = TracerSave(tracerType, syncFlag);
    ADIAG_INF("AtraceSave end, ret=%d.", ret);
    return ret;
}

/**
 * @brief       init atrace struct entry list
 * @return      atrace entry list
 */
void *TRACE_API(StructEntryListInit)(void)
{
    return TracerStructEntryListInit();
}

/**
 * @brief       set atrace entry name
 * @param [in]  entry:      trace struct entry
 * @param [in]  name:       entry name
 * @return      NA
 */
void TRACE_API(StructEntryName)(TraceStructEntry *entry, const char *name)
{
    return TracerStructEntryName(entry, name);
}

/**
 * @brief       add atrace struct item
 * @param [in]  entry:          trace struct entry
 * @param [in]  name:           item name
 * @param [in]  type:           item type
 * @param [in]  mode:           item save mode
 * @param [in]  bytes:          bytes occupied by a single element
 * @param [in]  length:         bytes occupied by this item
 * @return      NA
 */
void TRACE_API(StructItemSet)(TraceStructEntry *entry, const char *name, uint8_t type, uint8_t mode, uint16_t length)
{
    return TracerStructItemSet(entry, name, type, mode, length);
}

/**
 * @brief       atrace struct entry exit
 * @param [in]  entry:      trace struct entry
 * @return      NA
 */
void TRACE_API(StructEntryExit)(TraceStructEntry *entry)
{
    return TracerStructEntryExit(entry);
}

TraceStructEntry *TRACE_API(StructEntryCreate)(const char *name)
{
    return TraceStructEntryCreate(name);
}

void TRACE_API(StructEntryDestroy)(TraceStructEntry *en)
{
    TraceStructEntryDestroy(en);
}

void TRACE_API(StructItemFieldSet)(TraceStructEntry *en, const char *item, uint8_t type, uint8_t mode, uint16_t len)
{
    TraceStructItemFieldSet(en, item, type, mode, len);
}

void TRACE_API(StructItemArraySet)(TraceStructEntry *en, const char *item, uint8_t type, uint8_t mode, uint16_t len)
{
    TraceStructItemArraySet(en, item, type, mode, len);
}

void TRACE_API(StructSetAttr)(TraceStructEntry *en, uint8_t type, TraceAttr *attr)
{
    TraceStructSetAttr(en, type, attr);
}

/*
 * @brief       Create trace event.
 * @param [in]  eventName:     event name
 * @return      event handle
 */
TraEventHandle TRACE_API(EventCreate)(const char *eventName)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventCreate is not supported on device side");
        return TRACE_UNSUPPORTED_HANDLE;
    }
    return TraceEventCreate(eventName);
}

/**
 * @brief       Get event handle
 * @param [in]  eventName:     event name
 * @return      event handle
 */
TraEventHandle TRACE_API(EventGetHandle)(const char *eventName)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventGetHandle is not supported on device side");
        return TRACE_UNSUPPORTED_HANDLE;
    }
    return TraceEventGetHandle(eventName);
}


/**
 * @brief       Destroy event handle
 * @param [in]  eventHandle:    event handle
 * @return      NA
 */
void TRACE_API(EventDestroy)(TraEventHandle eventHandle)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventDestroy is not supported on device side");
        return;
    }
    TraceEventDestroy(eventHandle);
}

/**
 * @brief       Bind event handle with trace handle
 * @param [in]  eventHandle:    event handle
 * @param [in]  handle:         trace handle
 * @return      TraStatus
 */
TraStatus TRACE_API(EventBindTrace)(TraEventHandle eventHandle, TraHandle handle)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventBindTrace is not supported on device side");
        return TRACE_UNSUPPORTED;
    }
    return TraceEventBindTrace(eventHandle, handle);
}

/**
 * @brief       Set event attr
 * @param [in]  eventHandle:    event handle
 * @param [in]  attr:           event attribute
 * @return      TraStatus
 */
TraStatus TRACE_API(EventSetAttr)(TraEventHandle eventHandle, const TraceEventAttr *attr)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventSetAttr is not supported on device side");
        return TRACE_UNSUPPORTED;
    }
    return TraceEventSetAttr(eventHandle, attr);
}

/**
 * @brief       Report event and save the bound trace log to disk
 * @param [in]  eventHandle:    event handle
 * @return      TraStatus
 */
TraStatus TRACE_API(EventReport)(TraEventHandle eventHandle)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventReport is not supported on device side");
        return TRACE_UNSUPPORTED;
    }
    return TraceEventReport(eventHandle);
}

/**
 * @brief       Report event and save the bound trace log to disk sync
 * @param [in]  eventHandle:    event handle
 * @return      TraStatus
 */
TraStatus TRACE_API(EventReportSync)(TraEventHandle eventHandle)
{
    if (!AtraceCheckSupported()) {
        ADIAG_WAR("AtraceEventReport is not supported on device side");
        return TRACE_UNSUPPORTED;
    }
    return TraceEventReport(eventHandle);
}

#ifdef UTRACE_API
/**
 * @brief       set global attribute
 * @param [in]  attr:           global attribute
 * @return      TraStatus
 */
TraStatus UtraceSetGlobalAttr(const TraceGlobalAttr *attr)
{
    return TraceSetGlobalAttr(attr);
}
#endif