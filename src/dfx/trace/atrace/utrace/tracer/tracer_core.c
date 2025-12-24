/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tracer_core.h"
#include "adiag_print.h"
#include "stacktrace_signal.h"
#include "tracer_schedule.h"
#include "trace_rb_log.h"
#include "adiag_utils.h"
#include "trace_system_api.h"

STATIC Tracer g_tracers[TRACER_TYPE_MAX] = {
    {TRACER_SCHEDULE_NAME,    TracerScheduleRegister, TracerScheduleUnregister, NULL},
    {"progress",   NULL, NULL, NULL},
    {"statistics", NULL, NULL, NULL},
};

TraStatus TracerObjSubmit(TraHandle handle, uint8_t bufferType, const void *buffer, uint32_t bufSize)
{
    if (handle < 0) {
        return TRACE_FAILURE;
    }
    TracerObject *obj = (TracerObject *)handle;
    if (obj == NULL) {
        return TRACE_FAILURE;
    }
    if (obj->status != (int32_t)OBJ_STATUS_WORKING) {
        ADIAG_ERR("object[%s] is not working, status=%d.", obj->name, obj->status);
        return TRACE_FAILURE;
    }
    if (obj->noLock == TRACE_LOCK_FREE) {
        return TraceRbLogWriteRbMsgNoLock((RbLog *)obj->data, bufferType, (const char *)buffer, bufSize);
    } else {
        return TraceRbLogWriteRbMsg((RbLog *)obj->data, bufferType, (const char *)buffer, bufSize);
    }
}

TraHandle TracerObjCreate(TracerType tracerType, const char *objName, const TraceAttr *attr)
{
    ADIAG_CHK_NULL_PTR(attr, return TRACE_INVALID_HANDLE);

    if ((g_tracers[tracerType].mgr != NULL) && (g_tracers[tracerType].mgr->op.tracerCreateFunc != NULL)) {
        TraObjHandle hdl = g_tracers[tracerType].mgr->op.tracerCreateFunc(&g_tracers[tracerType], objName, attr);
        return hdl;
    }
    ADIAG_ERR("%d, g_tracers[tracerType].mgr %p", tracerType, g_tracers[tracerType].mgr);
    return TRACE_INVALID_HANDLE;
}

TraHandle TracerObjGet(TracerType tracerType, const char *objName)
{
    ADIAG_CHK_EXPR_ACTION(tracerType >= TRACER_TYPE_MAX, return TRACE_INVALID_HANDLE,
        "tracer type %d is invalid.", (int32_t)tracerType);
    ADIAG_CHK_NULL_PTR(objName, return TRACE_INVALID_HANDLE);

    if ((g_tracers[tracerType].mgr != NULL) && (g_tracers[tracerType].mgr->op.tracerGetFunc != NULL)) {
        TraObjHandle hdl = g_tracers[tracerType].mgr->op.tracerGetFunc(&g_tracers[tracerType], objName);
        return hdl;
    }

    return TRACE_INVALID_HANDLE;
}

void TracerObjDestroy(TraHandle handle)
{
    if (handle < 0) {
        ADIAG_ERR("handle %ld is invalid.", (long)handle);
        return;
    }
    TracerObject *obj = (TracerObject *)handle;
    if (obj == NULL) {
        ADIAG_ERR("handle is null.");
        return;
    }

    for (uint8_t i = 0; i < obj->relatedEventNum; i++) {
        (void)TraceEventUnbindTrace(obj->relatedEvent[i], handle);
    }
    obj->relatedEventNum = 0;

    int32_t tracerType = obj->tracerType;
    ADIAG_CHK_EXPR_ACTION(tracerType >= (int32_t)TRACER_TYPE_MAX, return, "handle %ld is invalid.", (long)handle);
    ADIAG_DBG("AtraceDestroy [%s].", obj->name);
    if ((g_tracers[tracerType].mgr != NULL) && (g_tracers[tracerType].mgr->op.tracerDestroyFunc != NULL)) {
        (void)g_tracers[tracerType].mgr->op.tracerDestroyFunc(&g_tracers[tracerType], handle);
    }
}

TraStatus TracerSave(TracerType tracerType, bool syncFlag)
{
    ADIAG_CHK_EXPR_ACTION(tracerType >= TRACER_TYPE_MAX, return TRACE_INVALID_PARAM,
        "tracer type %d is invalid.", (int32_t)tracerType);
    TracerMgr *mgr = g_tracers[tracerType].mgr;
    if ((mgr == NULL) || mgr->op.tracerSaveFunc == NULL || mgr->op.tracerReportFunc == NULL) {
        ADIAG_ERR("tracer manager has not been initialized or has been finalized");
        return TRACE_FAILURE;
    }
    (void)syncFlag;
    return TraceEventReport(mgr->innerEvent);
}

TraStatus TracerSaveTracer(Tracer *tracer)
{
    if ((tracer->mgr == NULL) || tracer->mgr->op.tracerSaveFunc == NULL) {
        ADIAG_ERR("tracer manager has not been initialized or has been finalized");
        return TRACE_FAILURE;
    }
    return (tracer->mgr->op.tracerSaveFunc)(tracer, NULL);
}

TraStatus TracerSaveObj(TracerObject *obj)
{
    ADIAG_CHK_NULL_PTR(obj, return TRACE_FAILURE);

    Tracer *tracer = &g_tracers[obj->tracerType];
    if ((tracer->mgr == NULL) || tracer->mgr->op.tracerSaveFunc == NULL) {
        ADIAG_ERR("tracer manager has not been initialized or has been finalized");
        return TRACE_FAILURE;
    }
    return (tracer->mgr->op.tracerSaveFunc)(tracer, obj);
}

TraStatus TracerInit(void)
{
    for (int32_t i = 0; i < (int32_t)TRACER_TYPE_MAX; i++) {
        if (g_tracers[i].tracerRegisterFunc != NULL) {
            TraStatus ret = g_tracers[i].tracerRegisterFunc(&g_tracers[i]);
            if (ret != TRACE_SUCCESS) {
                ADIAG_ERR("%s tracer register failed.", g_tracers[i].name);
                return TRACE_FAILURE;
            }
        }

        if ((g_tracers[i].mgr != NULL) && (g_tracers[i].mgr->op.tracerInitFunc != NULL)) {
            TraStatus ret = g_tracers[i].mgr->op.tracerInitFunc(&g_tracers[i]);
            if (ret != TRACE_SUCCESS) {
                ADIAG_ERR("%s tracer init failed.", g_tracers[i].name);
                return TRACE_FAILURE;
            }
        }
    }

    return TRACE_SUCCESS;
}

void TracerExit(void)
{
    for (int32_t i = 0; i < (int32_t)TRACER_TYPE_MAX; i++) {
        if ((g_tracers[i].mgr != NULL) && (g_tracers[i].mgr->op.tracerExitFunc != NULL)) {
            TraStatus ret = g_tracers[i].mgr->op.tracerExitFunc(&g_tracers[i]);
            if (ret != TRACE_SUCCESS) {
                ADIAG_ERR("%s tracer exit failed.", g_tracers[i].name);
            }
        }

        if (g_tracers[i].tracerUnregisterFunc != NULL) {
            TraStatus ret = g_tracers[i].tracerUnregisterFunc(&g_tracers[i]);
            if (ret != TRACE_SUCCESS) {
                ADIAG_ERR("%s tracer unregister failed.", g_tracers[i].name);
            }
        }
    }
}

void *TracerStructEntryListInit(void)
{
    void *list = AdiagMalloc(sizeof(struct AdiagList));
    if (list == NULL) {
        ADIAG_ERR("malloc for struct entry failed.");
        return NULL;
    }
    if (AdiagListInit((struct AdiagList *)list) != TRACE_SUCCESS) {
        ADIAG_ERR("init trace list failed.");
        ADIAG_SAFE_FREE(list);
        return NULL;
    }
    return list;
}

void TracerStructEntryName(TraceStructEntry *entry, const char *name)
{
    if ((entry == NULL) || (name == NULL)) {
        return;
    }
    errno_t ret = strcpy_s(entry->name, TRACE_NAME_LENGTH, name);
    if (ret != EOK) {
        ADIAG_WAR("[%s]entry name is invalid.", name);
        (void)memset_s(entry->name, TRACE_NAME_LENGTH, 0, TRACE_NAME_LENGTH);
    }
}


STATIC TraStatus TracerStructParamCheck(TraceStructEntry *entry, const char *name, uint8_t type, uint8_t mode)
{
    if ((entry == NULL) || (entry->list == NULL)) {
        ADIAG_ERR("entry is invalid, please init entry first.");
        return TRACE_FAILURE;
    }
    if (name == NULL) {
        ADIAG_ERR("field name is invalid.");
        return TRACE_FAILURE;
    }

    if (((type > TRACE_STRUCT_FIELD_TYPE_UINT64) && (type < TRACE_STRUCT_ARRAY_TYPE_CHAR)) ||
        (type > TRACE_STRUCT_ARRAY_TYPE_UINT64)) {
        ADIAG_ERR("struct type[%u] is invalid.", (uint32_t)type);
        return TRACE_FAILURE;
    }
    if (mode > TRACE_STRUCT_SHOW_MODE_CHAR) {
        ADIAG_ERR("struct mode[%u] is invalid.", (uint32_t)mode);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

void TracerStructItemSet(TraceStructEntry *entry, const char *name, uint8_t type, uint8_t mode, uint16_t length)
{
    if (TracerStructParamCheck(entry, name, type, mode) != TRACE_SUCCESS) {
        ADIAG_ERR("input is invalid, add atrace struct item failed.");
        return;
    }
    TraceStructField *item = (TraceStructField *)AdiagMalloc(sizeof(TraceStructField));
    if (item == NULL) {
        ADIAG_ERR("[%s]malloc for struct field failed, field name = %s.", entry->name, name);
        return;
    }
    errno_t ret = strcpy_s(item->name, TRACE_NAME_LENGTH, name);
    if (ret != EOK) {
        ADIAG_ERR("[%s]memcpy for struct field failed, field name = %s.", entry->name, name);
        ADIAG_SAFE_FREE(item);
        return;
    }
    item->type = type;
    item->mode = mode;
    item->length = length;
    if (AdiagListInsert((struct AdiagList *)(entry->list), item) != ADIAG_SUCCESS) {
        ADIAG_ERR("[%s]trace struct insert to list failed, field name = %s.", entry->name, name);
        ADIAG_SAFE_FREE(item);
    }
}

STATIC INLINE void TraceStructEntryListExit(struct AdiagList *list)
{
    if (list != NULL) {
        (void)AdiagListDestroy(list);
        ADIAG_SAFE_FREE(list);
    }
}

void TracerStructEntryExit(TraceStructEntry *entry)
{
    if (entry != NULL) {
        (void)TraceStructEntryListExit((struct AdiagList *)entry->list);
        entry->list = NULL;
    }
}

TraceStructEntry *TraceStructEntryCreate(const char *name)
{
    TraceStructEntry *en = AdiagMalloc(sizeof(TraceStructEntry));
    if (en == NULL) {
        return NULL;
    }
    struct AdiagList *list = TracerStructEntryListInit();
    en->list = (void *)list;
    TracerStructEntryName(en, name);
    return en;
}

void TraceStructEntryDestroy(TraceStructEntry *en)
{
    if (en != NULL) {
        TracerStructEntryExit(en);
        ADIAG_SAFE_FREE(en);
    }
}

void TraceStructItemFieldSet(TraceStructEntry *en, const char *item, uint8_t type, uint8_t mode, uint16_t len)
{
    TracerStructItemSet(en, item, type, mode, len);
}

void TraceStructItemArraySet(TraceStructEntry *en, const char *item, uint8_t type, uint8_t mode, uint16_t len)
{
    TracerStructItemSet(en, item, type, mode, len);
}

void TraceStructSetAttr(TraceStructEntry *en, uint8_t type, TraceAttr *attr)
{
    if ((attr != NULL) && (en != NULL) && (type < TRACE_STRUCT_ENTRY_MAX_NUM)) {
        attr->handle[type] = en;
    }
}

STATIC bool CheckHandleValid(TraHandle handle)
{
    if (handle <= 0) {
        ADIAG_ERR("invalid handle %lld", handle);
        return false;
    }
    return true;
}

TraStatus TraceBindEvent(TraHandle handle, TraEventHandle eventHandle)
{
    if (!CheckHandleValid(handle)) {
        ADIAG_ERR("trace bind event failed");
        return TRACE_INVALID_PARAM;
    }
    TracerObject *tracer = (TracerObject *)handle;
    ADIAG_CHK_EXPR_ACTION(tracer == NULL, return TRACE_INVALID_PARAM, "invalid param handle %lld", handle);
    if (tracer->relatedEventNum >= MAX_RELATED_EVENT_NUM) {
        ADIAG_ERR("event bound to tracer exceeds the upper limit %u", MAX_RELATED_EVENT_NUM);
        return TRACE_FAILURE;
    }
    tracer->relatedEvent[tracer->relatedEventNum] = eventHandle;
    tracer->relatedEventNum++;
    return TRACE_SUCCESS;
}

TraStatus TraceUnbindEvent(TraHandle handle, TraEventHandle eventHandle)
{
    if (!CheckHandleValid(handle)) {
        ADIAG_ERR("trace bind event failed");
        return TRACE_INVALID_PARAM;
    }
    TracerObject *tracer = (TracerObject *)handle;
    ADIAG_CHK_EXPR_ACTION(tracer == NULL, return TRACE_INVALID_PARAM, "invalid param handle %lld", handle);
    if (tracer->relatedEventNum == 0) {
        ADIAG_ERR("tracer has no related event");
        return TRACE_FAILURE;
    }
    for (uint8_t i = 0; i < tracer->relatedEventNum; i++) {
        if (tracer->relatedEvent[i] == eventHandle) {
            tracer->relatedEvent[i] = tracer->relatedEvent[tracer->relatedEventNum - 1U];
            tracer->relatedEventNum--;
            return TRACE_SUCCESS;
        }
    }
    ADIAG_ERR("event %lld has not been bound to handle %lld", eventHandle, handle);
    return TRACE_FAILURE;
}