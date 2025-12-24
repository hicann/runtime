/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_ATTR_H
#define TRACE_ATTR_H

#include "atrace_types.h"
#include "adiag_utils.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define TRACER_TYPE_NUM          TRACER_TYPE_MAX

#define PLATFORM_DEVICE_SIDE     0U
#define PLATFORM_HOST_SIDE       1U
#define PLATFORM_INVALID_VALUE   10000U

typedef struct TraceCoreAttr {
    uint32_t platform;
    int32_t pid;
    int32_t pgid;   // process group id
    uint32_t uid;
    uint32_t gid;
    char timeStamp[TIMESTAMP_MAX_LENGTH];
    int32_t envTimeout; // ms
} TraceCoreAttr;

typedef struct TraceInnerAttr {
    TraceCoreAttr systemAttr;
    TraceGlobalAttr userAttr;
} TraceInnerAttr;

TraStatus TraceAttrInit(void);
void TraceAttrExit(void);

bool AtraceCheckSupported(void);
int32_t TraceAttrGetPid(void);
int32_t TraceAttrGetPgid(void);
uint32_t TraceAttrGetUid(void);
uint32_t TraceAttrGetGid(void);
int32_t TraceGetTimeout(void);
const char *TraceAttrGetTime(void);
TraStatus TraceSetGlobalAttr(const TraceGlobalAttr *attr);
uint8_t TraceAttrGetSaveMode(void);
uint8_t TraceAttrGetGlobalDevId(void);
uint32_t TraceAttrGetGlobalPid(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif

