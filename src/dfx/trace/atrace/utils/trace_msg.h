/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TRACE_MSG_H
#define TRACE_MSG_H

#include "atrace_types.h"
#include "adiag_utils.h"

#define TRACE_HELLO_MSG         1U
#define TRACE_START_MSG         2U
#define TRACE_EVENT_MSG         3U
#define TRACE_END_MSG           4U

#define TRACE_HEAD_MAGIC        0xC327U
#define TRACE_HEAD_VERSION      0x0001U

#define EVENT_NAME_MAX_LENGTH   32

typedef struct {
    uint8_t msgType; // 1: hello; 2: start; 3: event; 4: end
    char reserve1[3];
    uint16_t magic;
    uint16_t version;
    uint64_t featureFlag;
    char reserve2[32];
} TraceHelloMsg;

typedef struct {
    uint8_t msgType; // 1: hello; 2: start; 3: event; 4: end
    char reserve1[3];
    int32_t timeout; // ms
    char reserve2[24];
} TraceStartMsg;

typedef struct {
    uint8_t msgType; // 1: hello; 2: start; 3: event; 4: end
    char reserve[31];
} TraceEndMsg;

#define TRACE_MSG_SEQFLAG_START     0
#define TRACE_MSG_SEQFLAG_MIDDLE    1
#define TRACE_MSG_SEQFLAG_END       2
#define TRACE_MSG_SEQFLAG_SINGLE    3

typedef struct {
    uint8_t msgType; // 1: hello; 2: start; 3: event; 4: end
    uint8_t eventType;
    uint8_t seqFlag; // 0: mult-start; 1: mult-middle; 2: mult-end; 3:single
    uint8_t reserve1;
    uint32_t devId;
    int32_t pid;
    uint32_t sequence;
    char eventName[EVENT_NAME_MAX_LENGTH];    // ts_devid_event
    char eventTime[TIMESTAMP_MAX_LENGTH];
    uint8_t saveType; // bin/txt
    char reserve[34];
    uint32_t bufLen;
    char buf[0];
} TraceEventMsg;


#define UTRACE_HEAD_MAGIC        0xB812U
#define UTRACE_HEAD_VERSION      0x0002U

typedef struct {
    uint16_t magic;
    uint16_t version;
    uint32_t hostPid;
    uint32_t devicePid;
    uint32_t deviceId;
    char objName[TRACE_NAME_LENGTH];
    char eventTime[TIMESTAMP_MAX_LENGTH];
    char res[5];
    uint8_t tracerType; // TraceType
    uint8_t saveType; // bin/txt
    uint32_t dataLength;
    char data[0];
} UtraceMsg;

#endif