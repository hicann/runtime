/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACER_MGR_OPERATE_H
#define TRACER_MGR_OPERATE_H

#include "tracer_core.h"

#ifdef __cplusplus
extern "C" {
#endif

#define TRACE_MAGIC         0xD928U
#define TRACE_VERSION       0x0003U

typedef struct TraceLogCtrl {
    uint32_t magic;
    uint32_t version;
    uint64_t realTime;
    char name[TRACE_NAME_LENGTH];		    // entry name
    uint32_t num;		                    // number of list
    int8_t reserve[4];
} TraceLogCtrl;

TraStatus TracerScheduleInit(Tracer *tracer);
TraStatus TracerScheduleExit(Tracer *tracer);
TraObjHandle TracerScheduleObjCreate(Tracer *tracer, const char *name, const TraceAttr *attr);
TraObjHandle TracerScheduleObjGet(Tracer *tracer, const char *name);
TraStatus TracerScheduleObjSubmit(Tracer *tracer, TraObjHandle handle,
    uint8_t bufferType, const void *buffer, uint32_t bufSize);
TraStatus TracerScheduleObjDestroy(Tracer *tracer, TraObjHandle handle);
TraStatus TracerScheduleSave(Tracer *tracer, TracerObject *obj);
TraStatus TracerScheduleReport(Tracer *tracer, TracerObject *obj);

TraStatus TracerScheduleSafeSave(Tracer *tracer, uint64_t timeStamp);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif