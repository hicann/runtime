/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_RB_LOG_H
#define TRACE_RB_LOG_H

#include <stdint.h>
#include <time.h>
#include <stdbool.h>
#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define RB_LOG_MSG_HEAD_RESERVE_LENGTH 2U
#define RB_LOG_CTRL_NAME_LENGTH 32U

typedef struct RbMsgHead {
    uint64_t cycle;         // number of cycles when writing msg, relative number of cycles when creating ring buffer
    uint32_t txtSize;
    bool busy;              // msg block is busy or not
    uint8_t bufferType;     // buffer type of entry handle
    char reserve[RB_LOG_MSG_HEAD_RESERVE_LENGTH];
} RbMsgHead;

typedef struct RbLogMsg {
    RbMsgHead head;
    char txt[0];
} RbLogMsg;

typedef struct RbLogMsgTime {
    struct tm sec;
    uint64_t nsec;
} RbLogMsgTime;

typedef struct RbLogCtrl {
    char name[RB_LOG_CTRL_NAME_LENGTH];
    uint64_t writeIdx;
    uint64_t realTime;
    uint64_t monotonicTime;
    uint64_t cpuFreq;
    int32_t minutesWest;
    uint32_t readIdx;
    uint32_t bufSize;
    uint32_t mask;
    uint32_t msgSize;
    uint32_t msgTxtSize;
    uint32_t errCount;
} RbLogCtrl;

typedef struct TraceStructField {
    char name[TRACE_NAME_LENGTH];		    // field name
    uint8_t type;		                    // field type
    uint8_t mode;		                    // storage mode of the field
    uint16_t length;		                // bytes occupied by this field
    int8_t reserve[4];
} TraceStructField;

typedef struct RbLog {
    struct RbLogCtrl head;
    struct TraceStructEntry entry[TRACE_STRUCT_ENTRY_MAX_NUM];
    char msg[0];
} RbLog;

struct RbLog *TraceRbLogCreate(const char *name, const TraceAttr *attr);
void TraceRbLogDestroy(struct RbLog *rb);
TraStatus TraceRbLogGetCopyOfRingBuffer(struct RbLog **newRb, struct RbLog *rb);
TraStatus TraceRbLogWriteRbMsg(struct RbLog *rb, uint8_t bufferType, const char *buffer, uint32_t bufSize);
TraStatus TraceRbLogWriteRbMsgNoLock(struct RbLog *rb, uint8_t bufferType, const char *buffer, uint32_t bufSize);
void TraceRbLogPrepareForRead(struct RbLog *rb);
TraStatus TraceRbLogReadRbMsg(struct RbLog *rb, char *timeStr, uint32_t timeStrSize, char **buffer);
TraStatus TraceRbLogReadOriRbMsg(struct RbLog *rb, char **buffer, uint32_t *bufLen);
TraStatus TraceRbLogReadRbMsgSafe(struct RbLog *rb, char *timeStr, uint32_t timeStrSize, char **buffer);
TraStatus TraceRbLogReadOriRbMsgSafe(struct RbLog *rb, char **buffer, uint32_t *bufLen, uint64_t *cycle);
uint32_t TracerRbLogGetMsgNum(const RbLog *rb);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
