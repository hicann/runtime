/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_event.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "tracer_core.h"

#define TRACE_EVENT_THREAD_WAIT_INTERVAL  1000U  // 1000ms
typedef struct {
    mmMutex_t mutex;
    mmCond cond;
    mmThread tid;
    int32_t status;
} ThreadCondInfo;

typedef struct TraceEventsMgr {
    struct AdiagList eventList;
    struct AdiagList saveList;
    ThreadCondInfo eventProcessThread;
} TraceEventsMgr;

STATIC TraceEventsMgr *g_eventsMgr = NULL;

STATIC bool CheckEventNameValid(const char *name)
{
    if (name == NULL) {
        ADIAG_ERR("invalid name NULL");
        return false;
    }
    if ((strlen(name) + 1U) > MAX_EVENT_NAME_LENGTH) {
        ADIAG_ERR("size of event name exceeds the upper limit of %u", MAX_EVENT_NAME_LENGTH);
        return false;
    }
    return true;
}

STATIC bool CheckEventHandleValid(TraEventHandle eventHandle)
{
    if (eventHandle <= 0) {
        ADIAG_ERR("invalid event handle %lld", eventHandle);
        return false;
    }
    void *data = AdiagListGetNode(&g_eventsMgr->eventList, (TraceEventNode *)eventHandle);
    if (data == NULL) {
        ADIAG_ERR("invalid event handle %lld", eventHandle);
        return false;
    }
    return true;
}

STATIC bool CheckEventAttrValid(const TraceEventAttr *attr)
{
    if (attr == NULL) {
        ADIAG_ERR("invalid event attr NULL");
        return false;
    }
    // limitedNum is of type uint16_t with range [0, 65535], no need to check
    ADIAG_INF("limitedNum %u.", attr->limitedNum);
    return true;
}

STATIC INLINE bool TraceEventReportNumLimited(TraceEventNode *node)
{
    if (node->attr.limitedNum == 0) {
        return false;
    }
    if (node->reportNum < node->attr.limitedNum) {
        return false;
    }
    return true;
}

STATIC TraStatus TraceEventCompareName(const void *nodeName, const void *name)
{
    if (nodeName == NULL || name == NULL) {
        return TRACE_FAILURE;
    }
    if (strcmp((const char *)nodeName, (const char *)name) == 0) {
        return TRACE_SUCCESS;
    }
    return TRACE_FAILURE;
}

STATIC TraStatus TraceEventSave(void *arg)
{
    if (arg == NULL) {
        return TRACE_SUCCESS;
    }
    TraceEventNode *node = (TraceEventNode *)arg;
    TracerObject *obj = NULL;
    TraStatus ret = TRACE_SUCCESS;
    if (node->relatedTracer != 0) {
        // process inner event
        if (TracerSaveTracer((Tracer *)node->relatedTracer) != TRACE_SUCCESS) {
            ADIAG_ERR("save trace for event %s failed", node->eventName);
            ret = TRACE_FAILURE;
        } else {
            ADIAG_DBG("save trace for event %s", node->eventName);
        }
    }
    for (uint8_t i = 0; i < node->relatedTraceObjNum; i++) {
        obj = (TracerObject *)node->relatedTraceObj[i];
        if (TracerSaveObj(obj) != TRACE_SUCCESS) {
            ADIAG_ERR("save trace for event %s handle %s failed", node->eventName, obj->name);
            ret = TRACE_FAILURE;
        } else {
            ADIAG_DBG("save trace %s for event %s", obj->name, node->eventName);
        }
    }
    return ret;
}

/**
 * @brief       init trace event
 * @return      TraStatus
 */
TraStatus TraceEventInit(void)
{
    g_eventsMgr = (TraceEventsMgr *)AdiagMalloc(sizeof(TraceEventsMgr));
    if (g_eventsMgr == NULL) {
        ADIAG_ERR("malloc g_eventsMgr failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    TraStatus ret = AdiagListInit(&g_eventsMgr->eventList);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("init event list failed, ret=%d.", ret);
        AdiagFree(g_eventsMgr);
        g_eventsMgr = NULL;
        return TRACE_FAILURE;
    }
    ret = AdiagListInit(&g_eventsMgr->saveList);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("init save list failed, ret=%d.", ret);
        (void)AdiagListDestroy(&g_eventsMgr->eventList);
        AdiagFree(g_eventsMgr);
        g_eventsMgr = NULL;
        return TRACE_FAILURE;
    }
    ADIAG_INF("init trace event successfully");
    return TRACE_SUCCESS;
}

/**
 * @brief       exit trace event
 * @return      NA
 */
void TraceEventExit(void)
{
    if (g_eventsMgr != NULL) {
        (void)AdiagListDestroy(&g_eventsMgr->saveList);
        (void)AdiagListDestroy(&g_eventsMgr->eventList);
        AdiagFree(g_eventsMgr);
        g_eventsMgr = NULL;
    }
    return;
}

/**
 * @brief       create trace event, add trace event node to eventList
 * @param [in]  eventName:    name of trace event
 * @return      eventHandle if create success, TRACE_INVALID_HANDLE otherwise
 */
TraEventHandle TraceEventCreate(const char *eventName)
{
    if (!CheckEventNameValid(eventName)) {
        ADIAG_ERR("atrace create event failed");
        return TRACE_INVALID_HANDLE;
    }
    if (g_eventsMgr == NULL) {
        ADIAG_ERR("g_eventsMgr has not been init successfully.");
        return TRACE_INVALID_HANDLE;
    }
    void *data = AdiagListForEach(&g_eventsMgr->eventList, TraceEventCompareName, eventName);
    if (data != NULL) {
        ADIAG_ERR("duplicated trace event name %s", eventName);
        return TRACE_INVALID_HANDLE;
    }
    TraceEventNode *node = (TraceEventNode *)AdiagMalloc(sizeof(TraceEventNode));
    if (node == NULL) {
        ADIAG_ERR("malloc node failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_INVALID_HANDLE;
    }
    errno_t err = strcpy_s(node->eventName, sizeof(node->eventName), eventName);
    if (err != EOK) {
        ADIAG_ERR("strcpy_s event_name [%s] failed, ret : %d", eventName, err);
        AdiagFree(node);
        return TRACE_INVALID_HANDLE;
    }
    node->processFunc = TraceEventSave;
    AdiagStatus ret = AdiagListInsert(&g_eventsMgr->eventList, node);
    if (ret != ADIAG_SUCCESS) {
        ADIAG_ERR("insert node to event list failed, ret=%d.", ret);
        AdiagFree(node);
        return TRACE_INVALID_HANDLE;
    }
    ADIAG_DBG("insert event %s to event list", node->eventName);
    return (TraEventHandle)node;
}

/**
 * @brief       get event handle by eventName
 * @param [in]  eventName:    name of trace event
 * @return      eventHandle if found, TRACE_INVALID_HANDLE otherwise
 */
TraEventHandle TraceEventGetHandle(const char *eventName)
{
    if (!CheckEventNameValid(eventName)) {
        ADIAG_ERR("atrace get event handle failed");
        return TRACE_INVALID_HANDLE;
    }
    void *data = AdiagListForEach(&g_eventsMgr->eventList, TraceEventCompareName, eventName);
    if (data == NULL) {
        return TRACE_INVALID_HANDLE;
    }
    return (TraEventHandle)data;
}

/**
 * @brief       destroy event handle, process all event in saveList before destroy
 * @param [in]  eventHandle:    event handle, handle of event node
 * @return      NA
 */
void TraceEventDestroy(TraEventHandle eventHandle)
{
    if (!CheckEventHandleValid(eventHandle)) {
        ADIAG_ERR("atrace destroy event failed");
        return;
    }
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    ADIAG_CHK_EXPR_ACTION(node == NULL, return, "invalid param eventHandle %lld", eventHandle);
    for (uint8_t i = 0; i < node->relatedTraceObjNum; i++) {
        (void)TraceUnbindEvent(node->relatedTraceObj[i], eventHandle);
    }
    (void)AdiagListRemoveAll(&g_eventsMgr->saveList, node, TraceEventSave);
    AdiagStatus ret = AdiagListRemove(&g_eventsMgr->eventList, node);
    if (ret != ADIAG_SUCCESS) {
        ADIAG_ERR("remove event from event list failed.");
    } else {
        ADIAG_DBG("delete event %s from event list", node->eventName);
    }
    ADIAG_SAFE_FREE(node);
}

/**
 * @brief       bind tracer to trace event
 * @param [in]  eventHandle:    event handle, handle of event node
 * @param [in]  tracer:         tracer handle
 * @return      TraStatus
 */
TraStatus TraceEventBindTracer(TraEventHandle eventHandle, TracerHandle tracer)
{
    if (!CheckEventHandleValid(eventHandle)) {
        ADIAG_ERR("atrace event bind tracer failed");
        return TRACE_INVALID_PARAM;
    }
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    ADIAG_CHK_EXPR_ACTION(node == NULL, return TRACE_INVALID_PARAM, "invalid param eventHandle %lld", eventHandle);

    if (node->relatedTracer != 0) {
        ADIAG_ERR("event %s has been bound to tracer", node->eventName);
        return TRACE_FAILURE;
    }
    node->relatedTracer = tracer;
    return TRACE_SUCCESS;
}

/**
 * @brief       unbind tracer with trace event
 * @param [in]  eventHandle:    event handle, handle of event node
 * @param [in]  tracer:         tracer handle
 * @return      TraStatus
 */
TraStatus TraceEventUnbindTracer(TraEventHandle eventHandle, TracerHandle tracer)
{
    if (!CheckEventHandleValid(eventHandle)) {
        ADIAG_ERR("atrace event bind tracer failed");
        return TRACE_INVALID_PARAM;
    }
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    ADIAG_CHK_EXPR_ACTION(node == NULL, return TRACE_INVALID_PARAM, "invalid param eventHandle %lld", eventHandle);
    if (node->relatedTracer != tracer) {
        ADIAG_ERR("event %s has not been bound to tracer", node->eventName);
        return TRACE_FAILURE;
    }
    node->relatedTracer = 0;
    return TRACE_SUCCESS;
}

/**
 * @brief       bind trace object to trace event and bind trace event to trace object
 * @param [in]  eventHandle:    event handle, handle of event node
 * @param [in]  handle:         trace object handle
 * @return      TraStatus
 */
TraStatus TraceEventBindTrace(TraEventHandle eventHandle, TraHandle handle)
{
    if (!CheckEventHandleValid(eventHandle)) {
        ADIAG_ERR("atrace event bind trace failed");
        return TRACE_INVALID_PARAM;
    }
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    ADIAG_CHK_EXPR_ACTION(node == NULL, return TRACE_INVALID_PARAM, "invalid param eventHandle %lld", eventHandle);
    if (node->relatedTraceObjNum >= MAX_RELATED_TRACER_NUM) {
        ADIAG_ERR("trace bound to event exceeds the upper limit %u", MAX_RELATED_TRACER_NUM);
        return TRACE_FAILURE;
    }
    TraStatus ret = TraceBindEvent(handle, eventHandle);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    node->relatedTraceObj[node->relatedTraceObjNum] = handle;
    node->relatedTraceObjNum++;
    return TRACE_SUCCESS;
}

/**
 * @brief       unbind trace event with trace object
 * @param [in]  eventHandle:    event handle, handle of event node
 * @param [in]  handle:         trace object handle
 * @return      TraStatus
 */
TraStatus TraceEventUnbindTrace(TraEventHandle eventHandle, TraHandle handle)
{
    if (!CheckEventHandleValid(eventHandle)) {
        ADIAG_ERR("atrace event unbind trace failed");
        return TRACE_INVALID_PARAM;
    }
    ADIAG_CHK_EXPR_ACTION(handle < 0, return TRACE_INVALID_PARAM, "invalid param handle %lld", eventHandle);
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    uint8_t j = 0;
    for (uint8_t i = 0; i < node->relatedTraceObjNum; i++) {
        if (node->relatedTraceObj[i] != handle) {
            node->relatedTraceObj[j] = node->relatedTraceObj[i];
            j++;
        }
    }
    node->relatedTraceObjNum = j;
    return TRACE_SUCCESS;
}

/**
 * @brief       set event trace attr
 * @param [in]  eventHandle:    event handle, handle of event node
 * @param [in]  attr:           event attr
 * @return      TraStatus
 */
TraStatus TraceEventSetAttr(TraEventHandle eventHandle, const TraceEventAttr *attr)
{
    if (!CheckEventHandleValid(eventHandle) || !CheckEventAttrValid(attr)) {
        ADIAG_ERR("atrace event report failed");
        return TRACE_INVALID_PARAM;
    }
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    ADIAG_CHK_EXPR_ACTION(node == NULL, return TRACE_INVALID_PARAM, "invalid param eventHandle %lld", eventHandle);
    errno_t ret = memcpy_s(&node->attr, sizeof(TraceEventAttr), attr, sizeof(TraceEventAttr));
    if (ret != EOK) {
        ADIAG_ERR("memcpy attr failed, ret : %d", ret);
        return TRACE_FAILURE;
    }
    ADIAG_INF("set trace event attr limitedNum: %hu", node->attr.limitedNum);
    return TRACE_SUCCESS;
}

/**
 * @brief       report trace event and process event
 * @param [in]  eventHandle:    event handle, handle of event node
 * @return      TraStatus
 */
TraStatus TraceEventReport(TraEventHandle eventHandle)
{
    if (!CheckEventHandleValid(eventHandle)) {
        ADIAG_ERR("atrace event report failed");
        return TRACE_INVALID_HANDLE;
    }
    TraceEventNode *node = (TraceEventNode *)eventHandle;
    ADIAG_CHK_EXPR_ACTION(node == NULL, return TRACE_INVALID_PARAM, "invalid param eventHandle %lld", eventHandle);
    if (node->relatedTraceObjNum == 0 && node->relatedTracer == 0) {
        ADIAG_WAR("trace event [%s] has not been bound to tracer, ignored", node->eventName);
        return TRACE_SUCCESS;
    }
    if (TraceEventReportNumLimited(node)) {
        ADIAG_WAR("the number of trace event[%s] reports has reached the upper limit %hu, ignored",
            node->eventName, node->attr.limitedNum);
        return TRACE_SUCCESS;
    }
    if (node->attr.limitedNum != 0) {
        node->reportNum++;  // ensure reportNum will be no more than limitedNum
    }
    TraStatus ret = TraceEventSave(node);
    ADIAG_DBG("AtraceEventReport [%s], ret=%d.", node->eventName, ret);
    return ret;
}