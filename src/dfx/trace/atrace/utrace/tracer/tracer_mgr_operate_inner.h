/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACER_MGR_OPERATE_INNER_H
#define TRACER_MGR_OPERATE_INNER_H

#include "trace_rb_log.h"

#ifdef __cplusplus
extern "C" {
#endif

#define TRACE_POS_HOST      (0b00000000U) // first bit stands for trace pos
#define TRACE_POS_DEVICE    (0b10000000U)

#define TRACE_TYPE_BIN      0U

typedef struct TraceCtrlHead {
    uint32_t magic;
    uint32_t version;
    uint8_t pos;
    uint8_t typeRes[2];
    uint8_t traceType;
    uint32_t structSize;
    uint32_t dataSize;
    int32_t minutesWest;            // minutes west of Greenwich
    uint64_t realTime;
    uint64_t cpuFreq;
    int8_t reserve[8];
} TraceCtrlHead;
 
typedef struct TraceStructHead {
    char structName[TRACE_NAME_LENGTH];
    uint32_t itemNum;
    uint8_t structType;
    int8_t reserve[3];
} TraceStructHead;
 
typedef struct TraceStructSegmentHead {
    uint32_t structCount;
    int8_t reserve[36];
} TraceStructSegmentHead;
 
typedef struct TraceStructDataHead {
    uint32_t msgSize;
    uint32_t msgTxtSize;
    uint32_t msgNum;
    int8_t reserve[4];
} TraceStructDataHead;

void TracerScheduleSaveObjData(struct RbLog *newRb, const char *timeStr, const char *eventName, const char *objName);
void TracerScheduleSaveObjBinData(struct RbLog *newRb, const char *timeStr, const char *eventName, const char *objName);
bool TracerScheduleCheckListEmpty(struct RbLog *newRb);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif