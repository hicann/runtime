/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tracer_mgr_operate.h"
#include "tracer_mgr_operate_inner.h"
#include "trace_attr.h"
#include "stacktrace_dumper.h"
#include "adiag_utils.h"
#include "trace_recorder.h"
#include "adiag_print.h"
#include "trace_system_api.h"

#define SCHEDULE_RB_SIZE    1024U
#define SCHEDULE_SIGNAL_NUM 12U
#define TRACE_INNER_EVENT_NAME "trace_inner_event"

typedef struct  TracerDeleteNode {
    uint64_t interval;
    intptr_t handle;
} TracerDeleteNode;

typedef struct  TracerExitNode {
    char objName[MAX_OBJECT_NAME_LENGTH];
    void *data;
} TracerExitNode;

TraObjHandle TracerScheduleObjCreate(Tracer *tracer, const char *name, const TraceAttr *attr)
{
    (void)AdiagLockGet(&tracer->mgr->lock);
    for (int32_t i = 0; i < MAX_OBJECT_NUM; i++) {
        TracerObject *obj = &tracer->mgr->obj[i];
        if (obj->status == (int32_t)OBJ_STATUS_INIT) {
            RbLog *data = TraceRbLogCreate(name, attr);
            if (data == NULL) {
                (void)AdiagLockRelease(&tracer->mgr->lock);
                return TRACE_INVALID_HANDLE;
            }
            size_t len = strlen(name);
            if (len >= MAX_OBJECT_NAME_LENGTH) {
                ADIAG_ERR("name len(%zu bytes) is invalid, must less then %u bytes", len, MAX_OBJECT_NAME_LENGTH);
                (void)AdiagLockRelease(&tracer->mgr->lock);
                TraceRbLogDestroy(data);
                return TRACE_INVALID_HANDLE;
            }
            int32_t ret = strncpy_s(obj->name, MAX_OBJECT_NAME_LENGTH, name, len);
            if (ret != 0) {
                (void)AdiagLockRelease(&tracer->mgr->lock);
                TraceRbLogDestroy(data);
                return TRACE_INVALID_HANDLE;
            }
            obj->data = (void *)data;
            obj->status = OBJ_STATUS_WORKING;
            obj->pid = TraceGetPid();
            obj->exitSave = attr->exitSave;
            obj->tracerType = TRACER_TYPE_SCHEDULE;
            obj->noLock = attr->noLock;
            (void)AdiagLockRelease(&tracer->mgr->lock);
            ADIAG_RUN_INF("create object %s successfully, exitSave(%s), noLock(%s).",
                name, (attr->exitSave) ? "true" : "false", (attr->noLock == TRACE_LOCK_FREE) ? "true" : "false");
            return (TraObjHandle)obj;
        }
    }
    (void)AdiagLockRelease(&tracer->mgr->lock);
    return TRACE_INVALID_HANDLE;
}

TraObjHandle TracerScheduleObjGet(Tracer *tracer, const char *name)
{
    (void)AdiagLockGet(&tracer->mgr->lock);
    for (int32_t i = 0; i < MAX_OBJECT_NUM; i++) {
        if ((strncmp(name, tracer->mgr->obj[i].name, MAX_OBJECT_NAME_LENGTH) == 0) &&
            (tracer->mgr->obj[i].status == (int32_t)OBJ_STATUS_WORKING)) {
            (void)AdiagLockRelease(&tracer->mgr->lock);
            return (TraObjHandle)&tracer->mgr->obj[i];
        }
    }
    (void)AdiagLockRelease(&tracer->mgr->lock);
    return TRACE_INVALID_HANDLE;
}

TraStatus TracerScheduleObjSubmit(Tracer *tracer, TraObjHandle handle,
    uint8_t bufferType, const void *buffer, uint32_t bufSize)
{
    TracerObject *obj = &tracer->mgr->obj[handle];
    int32_t status = obj->status;
    if (status != (int32_t)OBJ_STATUS_WORKING) {
        ADIAG_ERR("object is not working, status=%d.", status);
        return TRACE_FAILURE;
    }
    TraStatus ret = TraceRbLogWriteRbMsg((RbLog *)obj->data, bufferType, (const char *)buffer, bufSize);
    return ret;
}

STATIC TraStatus TraceExitCompareName(const void *nodeName, const void *name)
{
    if (nodeName == NULL || name == NULL) {
        return TRACE_FAILURE;
    }
    if (strcmp((const char *)nodeName, (const char *)name) == 0) {
        return TRACE_SUCCESS;
    }
    return TRACE_FAILURE;
}

/**
 * @brief      push node to exit list
 * @param [in] tracer:      pointer of tracer
 * @param [in] obj:         pointer of object
 * @return     TraStatus
 */
STATIC TraStatus TracerSchedulePushExitList(Tracer *tracer, TracerObject *obj)
{
    if (obj->pid != TraceGetPid()) {
        return TRACE_FAILURE;
    }
    ADIAG_CHK_EXPR_ACTION(obj->data == NULL, return TRACE_FAILURE, "object is invalid.");

    TracerExitNode *node = (TracerExitNode *)AdiagMalloc(sizeof(TracerExitNode));
    ADIAG_CHK_EXPR_ACTION(node == NULL, return TRACE_FAILURE, "malloc exit node failed.");

    errno_t err = strncpy_s(node->objName, MAX_OBJECT_NAME_LENGTH, obj->name, strlen(obj->name));
    if (err != 0) {
        AdiagFree(node);
        return TRACE_FAILURE;
    }

    node->data = obj->data;
    void *data = AdiagListForEach(&tracer->mgr->exitList, TraceExitCompareName, (const void *)node->objName);
    if (data != NULL) {
        ADIAG_INF("object[%s] has been inserted to exit list.", node->objName);
        TracerExitNode *oldNode = (TracerExitNode *)data;
        (void)AdiagListRemove(&tracer->mgr->exitList, data);
        TraceRbLogDestroy((RbLog *)oldNode->data);
        AdiagFree(data);
    }
    AdiagStatus ret = AdiagListInsert(&tracer->mgr->exitList, (void *)node);
    if (ret != ADIAG_SUCCESS) {
        AdiagFree(node);
        ADIAG_ERR("insert node to exit list failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }
    obj->data = NULL;
    return TRACE_SUCCESS;
}

/**
 * @brief      save data to exit file
 * @param [in] objName:     object name
 * @param [in] data:        data
 * @param [in] timeStamp:   exit dir time
 * @return     TraStatus
 */
STATIC TraStatus TracerScheduleExitSave(const char *objName, void *data, uint64_t timeStamp)
{
    char dirTime[TIMESTAMP_MAX_LENGTH] = {0};
    TraStatus ret = TimestampToFileStr(timeStamp, dirTime, TIMESTAMP_MAX_LENGTH);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE,
        "get time string failed, ret=%d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));

    struct RbLog *newRb = NULL;
    ret = TraceRbLogGetCopyOfRingBuffer(&newRb, (RbLog *)data);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "get copy of ring buffer failed.");

    if (TracerScheduleCheckListEmpty(newRb)) {
        TracerScheduleSaveObjData(newRb, dirTime, TRACER_EVENT_EXIT, objName);
    } else {
        TracerScheduleSaveObjBinData(newRb, dirTime, TRACER_EVENT_EXIT, objName);
        for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
            (void)AdiagListDestroy(newRb->entry[i].list);
            ADIAG_SAFE_FREE(newRb->entry[i].list);
        }
    }
    ADIAG_SAFE_FREE(newRb);
    return TRACE_SUCCESS;
}

/**
 * @brief      pop node from exit list
 * @param [in] tracer:      pointer of tracer
 * @return     NA
 */
STATIC void TracerSchedulePopExitList(Tracer *tracer)
{
    uint64_t exitTime = GetRealTime();
    TracerExitNode *node = (TracerExitNode *)AdiagListTakeOut(&tracer->mgr->exitList);
    while (node != NULL) {
        TraStatus ret = TracerScheduleExitSave(node->objName, node->data, exitTime);
        if (ret != TRACE_SUCCESS) {
            ADIAG_WAR("can not save obj[%s] when exit, ret=%d.", node->objName, ret);
        }
        TraceRbLogDestroy((RbLog *)node->data);
        node->data = NULL;
        ADIAG_SAFE_FREE(node);
        node = (TracerExitNode *)AdiagListTakeOut(&tracer->mgr->exitList);
    }
}

STATIC TraStatus TracerScheduleObjProbe(Tracer *tracer)
{
    // 获取超时的时间的obj
    (void)AdiagLockGet(&tracer->mgr->lock);
    TracerDeleteNode *node = (TracerDeleteNode *)AdiagListTakeOut(&tracer->mgr->deleteList);
    if (node != NULL) {
        TracerObject *obj = (TracerObject *)(node->handle);
        (void)memset_s(obj->name, MAX_OBJECT_NAME_LENGTH, 0, MAX_OBJECT_NAME_LENGTH);
        obj->status = OBJ_STATUS_INIT;
        TraceRbLogDestroy((RbLog *)obj->data);
        obj->data = NULL;
        ADIAG_SAFE_FREE(node);
    }
    (void)AdiagLockRelease(&tracer->mgr->lock);
    return TRACE_SUCCESS;
}

TraStatus TracerScheduleObjDestroy(Tracer *tracer, TraObjHandle handle)
{
    TracerObject *obj = (TracerObject *)handle;
    if (obj == NULL) {
        return TRACE_FAILURE;
    }
    (void)AdiagLockGet(&tracer->mgr->lock);
    obj->status = OBJ_STATUS_IDLE;
    if (obj->exitSave) {
        (void)TracerSchedulePushExitList(tracer, obj);
    }
    TracerDeleteNode *node = (TracerDeleteNode *)AdiagMalloc(sizeof(TracerDeleteNode));
    if (node == NULL) {
        ADIAG_ERR("malloc delete node failed.");
        (void)AdiagLockRelease(&tracer->mgr->lock);
        return TRACE_FAILURE;
    }
    node->interval = 0; // get time stamp to calculate the time difference
    node->handle = handle;
    AdiagStatus ret = AdiagListInsert(&(tracer->mgr->deleteList), (void *)node);
    if (ret != ADIAG_SUCCESS) {
        AdiagFree(node);
        ADIAG_ERR("insert node to list failed.");
        (void)AdiagLockRelease(&tracer->mgr->lock);
        return TRACE_FAILURE;
    }
    ADIAG_RUN_INF("destroy object %s, exitSave(%s).", obj->name, (obj->exitSave) ? "true" : "false");
    (void)AdiagLockRelease(&tracer->mgr->lock);

    // create thread to execute probe
    (void)TracerScheduleObjProbe(tracer);

    return TRACE_SUCCESS;
}

bool TracerScheduleCheckListEmpty(struct RbLog *newRb)
{
    if (newRb == NULL) {
        return true;
    }
    bool isListNull = true;
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if ((newRb->entry[i].list != NULL) && (!ListEmpty(&((struct AdiagList *)newRb->entry[i].list)->list))) {
            isListNull = false;
            break;
        }
    }
    return isListNull;
}

STATIC TraStatus TracerScheduleSaveObject(TracerObject *obj, const char *timestamp)
{
    if ((obj->status != (int32_t)OBJ_STATUS_WORKING) || (obj->pid != TraceGetPid())) {
        return TRACE_SUCCESS;
    }

    struct RbLog *newRb = NULL;
    TraStatus ret = TraceRbLogGetCopyOfRingBuffer(&newRb, (RbLog *)obj->data);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("get copy of ring buffer failed.");
        return TRACE_FAILURE;
    }
    if (TracerScheduleCheckListEmpty(newRb)) {
        TracerScheduleSaveObjData(newRb, timestamp, TRACER_SCHEDULE_NAME, obj->name);
    } else {
        TracerScheduleSaveObjBinData(newRb, timestamp, TRACER_SCHEDULE_NAME, obj->name);
        for (uint32_t entryIndex = 0; entryIndex < TRACE_STRUCT_ENTRY_MAX_NUM; entryIndex++) {
            (void)AdiagListDestroy(newRb->entry[entryIndex].list);
            ADIAG_SAFE_FREE(newRb->entry[entryIndex].list);
        }
    }
    ADIAG_SAFE_FREE(newRb);
    return TRACE_SUCCESS;
}

TraStatus TracerScheduleSave(Tracer *tracer, TracerObject *obj)
{
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    TraStatus ret = TimestampToFileStr(GetRealTime(), timestamp, TIMESTAMP_MAX_LENGTH);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "get time string failed, ret=%d, strerr=%s.",
        ret, strerror(AdiagGetErrorCode()));

    (void)AdiagLockGet(&tracer->mgr->lock);
    if (obj != NULL) {
        ret = TracerScheduleSaveObject(obj, timestamp);
        if (ret != TRACE_SUCCESS) {
            (void)AdiagLockRelease(&tracer->mgr->lock);
            return TRACE_FAILURE;
        }
    } else {
        for (int32_t i = 0; i < MAX_OBJECT_NUM; i++) {
            ret = TracerScheduleSaveObject(&tracer->mgr->obj[i], timestamp);
            if (ret != TRACE_SUCCESS) {
                (void)AdiagLockRelease(&tracer->mgr->lock);
                return TRACE_FAILURE;
            }
        }
    }
    (void)AdiagLockRelease(&tracer->mgr->lock);
    return TRACE_SUCCESS;
}

TraStatus TracerScheduleReport(Tracer *tracer, TracerObject *obj)
{
    // create thread to save
    return TracerScheduleSave(tracer, obj);
}

/**
 * @brief       add func to signal list
 * @param [in]  data:       data
 * @param [in]  timeStamp:  dir timestamp
 * @return      TraStatus
 */
STATIC TraStatus TracerScheduleSignalCallback(void *data, uint64_t timeStamp)
{
    if (data == NULL) {
        return TRACE_INVALID_PARAM;
    }

    Tracer *tracer = (Tracer *)data;
    return TracerScheduleSafeSave(tracer, timeStamp);
}

STATIC TraStatus TracerScheduleEventInit(Tracer *tracer)
{
    // 注册信号量，回调实现安全save
    TraStatus ret = TraceDumperSetCallback(TracerScheduleSignalCallback, (void *)tracer);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return ret, "schedule tracer set callback failed, ret=%d.", ret);

    // add inner event
    tracer->mgr->innerEvent = TraceEventCreate(TRACE_INNER_EVENT_NAME);
    if (tracer->mgr->innerEvent < 0) {
        ADIAG_ERR("create trace inner event failed, ret=%lld", tracer->mgr->innerEvent);
        return TRACE_FAILURE;
    }
    ret = TraceEventBindTracer(tracer->mgr->innerEvent, (TracerHandle)tracer);
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("bind inner event to tracer failed");
        TraceEventDestroy(tracer->mgr->innerEvent);
        tracer->mgr->innerEvent = 0;
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

TraStatus TracerScheduleInit(Tracer *tracer)
{
    tracer->mgr->ouputType = 0;
    tracer->mgr->rbType = 0;
    (void)AdiagLockInit(&tracer->mgr->lock);
    TraStatus ret = AdiagListInit(&tracer->mgr->deleteList);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "tracer init delete list failed, ret=%d.", ret);
    ret = AdiagListInit(&tracer->mgr->exitList);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "tracer init exit list failed, ret=%d.", ret);

    ret = TracerScheduleEventInit(tracer);
    ADIAG_CHK_EXPR_ACTION(ret != TRACE_SUCCESS, return TRACE_FAILURE, "tracer init event failed, ret=%d.", ret);

    return TRACE_SUCCESS;
}

STATIC void TracerScheduleEventExit(Tracer *tracer)
{
    (void)TraceEventUnbindTracer(tracer->mgr->innerEvent, (TracerHandle)tracer);
    TraceEventDestroy(tracer->mgr->innerEvent);
    tracer->mgr->innerEvent = 0;
}

/**
 * @brief      destroy all object when exit
 * @param [in] tracer:      pointer of tracer
 * @return     NA
 */
STATIC void TracerScheduleObjDestroyAll(Tracer *tracer)
{
    (void)AdiagLockGet(&tracer->mgr->lock);
    for (int32_t i = 0; i < MAX_OBJECT_NUM; i++) {
        TracerObject *obj = &tracer->mgr->obj[i];
        if (obj->status != (int32_t)OBJ_STATUS_INIT) {
            obj->status = (int32_t)OBJ_STATUS_INIT;
            if (obj->exitSave) {
                (void)TracerSchedulePushExitList(tracer, obj);
            }
            (void)memset_s(obj->name, MAX_OBJECT_NAME_LENGTH, 0, MAX_OBJECT_NAME_LENGTH);
            TraceRbLogDestroy((RbLog *)obj->data);
            obj->data = NULL;
        }
    }
    TracerSchedulePopExitList(tracer);
    (void)AdiagLockRelease(&tracer->mgr->lock);
}

TraStatus TracerScheduleExit(Tracer *tracer)
{
    TracerScheduleObjDestroyAll(tracer);
    TracerScheduleEventExit(tracer);
    AdiagStatus ret = AdiagListDestroy(&tracer->mgr->deleteList);
    if (ret != ADIAG_SUCCESS) {
        ADIAG_ERR("destroy delete list failed, ret=%d.", ret);
    }
    ret = AdiagListDestroy(&tracer->mgr->exitList);
    if (ret != ADIAG_SUCCESS) {
        ADIAG_ERR("destroy exit list failed, ret=%d.", ret);
    }

    (void)AdiagLockDestroy(&tracer->mgr->lock);
    return ret;
}