/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_SESSION_MANAGE_H
#define LOG_SESSION_MANAGE_H

#include "log_common.h"
#include "log_system_api.h"


#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    SESSION_SINGLE_EXPORT,
    SESSION_CONTINUES_EXPORT
} SessionType;

typedef struct {
    void *session;
    SessionType type;
} SessionItem;

typedef struct SessionPidDevIdNode {
    struct SessionPidDevIdNode *next;
    uintptr_t session;
    int32_t pid;
    int32_t devId;
    int32_t timeout;
} SessionNode;

typedef void (*LogSeverSendDataFunc)(uint32_t pid, uint32_t devId, int32_t timeout);

LogRt InitSessionList(void);
void FreeSessionList(void);
LogRt DeleteSessionNode(uintptr_t session, int32_t pid, int32_t devId);
LogRt InsertSessionNode(uintptr_t session, int32_t pid, int32_t devId);
SessionNode* GetSessionNode(uint32_t pid, uint32_t devId);
void PushDeletedSessionNode(SessionNode *node);
SessionNode* PopDeletedSessionNode(void);
SessionNode* GetDeletedSessionNode(uint32_t pid, uint32_t devId);
bool IsSessionNodeListNull(void);
void HandleInvalidSessionNode(void);
void HandleDeletedSessionNode(LogSeverSendDataFunc func);
int32_t SendDataToSessionNode(uint32_t pid, uint32_t devId, const char *buf, size_t bufLen);
int32_t SessionMgrAddSession(const SessionItem *item);
int32_t SessionMgrGetSession(SessionItem *item);
int32_t SessionMgrSendMsg(const SessionItem *handle, const char *data, uint32_t len);
int32_t SessionMgrDeleteSession(const SessionItem *item);
#ifdef __cplusplus
}
#endif
#endif