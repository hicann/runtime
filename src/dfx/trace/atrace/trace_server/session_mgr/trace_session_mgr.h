/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_SESSION_MGR_H
#define TRACE_SESSION_MGR_H

#include "atrace_types.h"
#include "trace_queue.h"
#include "trace_adx_api.h"
#include "adiag_utils.h"
#include "adiag_lock.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define DELETED_SESSION_LIST        0
#define SESSION_LIST                1

#define SESSION_TIME_INTERVAL       100 // 100ms

typedef struct SessionPidDevIdNode {
    struct SessionPidDevIdNode *next;
    const void *handle;
    int32_t pid;
    int32_t devId;
    int32_t timeout; // ms
    char eventTime[TIMESTAMP_MAX_LENGTH];
    TraceQueue *queue;
} SessionNode;

typedef void (*TraceSeverSendDataFunc)(SessionNode *sessionNode, int8_t listFlag);

TraStatus TraceServerSessionInit(void);
void TraceServerSessionExit(void);

void TraceServerHandleDeletedSessionNode(TraceSeverSendDataFunc func);
void TraceServerHandleSessionNode(TraceSeverSendDataFunc func);

SessionNode* TraceServerGetSessionNode(int32_t pid, int32_t devId);
TraStatus TraceServerInsertSessionNode(const void *handle, int32_t pid, int32_t devId, int32_t timeout);
TraStatus TraceServerDeleteSessionNode(const void *handle, int32_t pid, int32_t devId);

bool TraceIsSessionNodeListNull(void);
bool TraceIsDeletedSessionNodeListNull(void);

void TraceServerSessionLock(void);
void TraceServerSessionUnlock(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif