/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TRACER_CORE_H
#define TRACER_CORE_H

#include "adiag_list.h"
#include "adiag_lock.h"
#include "trace_event.h"
#include "trace_rb_log.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define MAX_TRACER_NAME_LENGTH  16U
#define MAX_OBJECT_NAME_LENGTH  32U
#define MAX_OBJECT_NUM          100
#define MAX_RELATED_EVENT_NUM   64U

typedef TraHandle TraObjHandle;
typedef struct Tracer Tracer;

enum ObjStatus {
    OBJ_STATUS_INIT,
    OBJ_STATUS_WORKING,
    OBJ_STATUS_IDLE
};

typedef struct TracerObject {
    char name[MAX_OBJECT_NAME_LENGTH];
    int32_t status; // 0:init 1:working 2:idle
    int32_t pid;
    void *data;
    bool exitSave;
    uint8_t noLock;
    uint8_t tracerType;
    uint8_t relatedEventNum;
    TraEventHandle relatedEvent[MAX_RELATED_EVENT_NUM];
} TracerObject;

typedef TraStatus (*TracerInitFunc)(Tracer *tracer);
typedef TraStatus (*TracerExitFunc)(Tracer *tracer);
typedef TraStatus (*TracerSaveFunc)(Tracer *tracer, TracerObject *obj);
typedef TraObjHandle (*TracerCreateFunc)(Tracer *tracer, const char *name, const TraceAttr *attr);
typedef TraObjHandle (*TracerGetFunc)(Tracer *tracer, const char *name);
typedef TraStatus (*TracerSubmitFunc)(Tracer *tracer, TraObjHandle handle,
    uint8_t bufferType, const void *buffer, uint32_t bufSize);
typedef TraStatus (*TracerDestroyFunc)(Tracer *tracer, TraObjHandle handle);
typedef struct TracerOperate {
    TracerInitFunc tracerInitFunc;
    TracerExitFunc tracerExitFunc;
    TracerSaveFunc tracerSaveFunc;
    TracerSaveFunc tracerReportFunc;
    TracerCreateFunc tracerCreateFunc;
    TracerGetFunc tracerGetFunc;
    TracerSubmitFunc tracerSubmitFunc;
    TracerDestroyFunc tracerDestroyFunc;
} TracerOperate;

typedef struct TracerMgr {
    int32_t rbType;
    int32_t ouputType;
    TraEventHandle innerEvent;
    AdiagLock lock;
    struct TracerObject obj[MAX_OBJECT_NUM];
    struct AdiagList deleteList;
    struct AdiagList exitList;
    struct TracerOperate op;
} TracerMgr;

typedef TraStatus (*TracerRegisterFunc)(Tracer *tracer);
typedef TraStatus (*TracerUnregisterFunc)(Tracer *tracer);
struct Tracer {
    char name[MAX_TRACER_NAME_LENGTH];
    TracerRegisterFunc tracerRegisterFunc;
    TracerUnregisterFunc tracerUnregisterFunc;
    struct TracerMgr *mgr;
};

TraStatus TracerInit(void);
void TracerExit(void);

TraHandle TracerObjCreate(TracerType tracerType, const char *objName, const TraceAttr *attr);
TraHandle TracerObjGet(TracerType tracerType, const char *objName);
TraStatus TracerObjSubmit(TraHandle handle, uint8_t bufferType, const void *buffer, uint32_t bufSize);
void TracerObjDestroy(TraHandle handle);
void *TracerStructEntryListInit(void);
void TracerStructEntryName(TraceStructEntry *entry, const char *name);
void TracerStructItemSet(TraceStructEntry *entry, const char *name, uint8_t type, uint8_t mode, uint16_t length);
void TracerStructEntryExit(TraceStructEntry *entry);
TraceStructEntry *TraceStructEntryCreate(const char *name);
void TraceStructEntryDestroy(TraceStructEntry *en);
void TraceStructItemFieldSet(TraceStructEntry *en, const char *item, uint8_t type, uint8_t mode, uint16_t len);
void TraceStructItemArraySet(TraceStructEntry *en, const char *item, uint8_t type, uint8_t mode, uint16_t len);
void TraceStructSetAttr(TraceStructEntry *en, uint8_t type, TraceAttr *attr);
TraStatus TracerSave(TracerType tracerType, bool syncFlag);
TraStatus TracerSaveTracer(Tracer *tracer);
TraStatus TracerSaveObj(TracerObject *obj);
TraStatus TraceBindEvent(TraHandle handle, TraEventHandle eventHandle);
TraStatus TraceUnbindEvent(TraHandle handle, TraEventHandle eventHandle);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif