/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SERVER_MGR_H
#define SERVER_MGR_H
#include <stdbool.h>
#include "adx_service_config.h"
#include "log_system_api.h"
#ifdef __cplusplus
extern "C" {
#endif
#define SERVER_LONG_LINK      0
#define SERVER_LONG_LINK_STOP 1
#define SERVER_SHORT_LINK     2
#define SERVER_LINK_TYPE_MAX  3
#define ENV_ALL               0
#define ENV_NON_DOCKER        1 // 1 & 3
#define ENV_TYPE_MAX          2
#define SERVER_MSG_SIZE       128

int32_t ServerMgrInit(void);
void ServerMgrExit(void);

typedef AdxComponentInit ServerComponentInit;
typedef AdxComponentProcess ServerComponentProcess;
typedef AdxComponentUnInit ServerComponentUnInit;

struct ServerMgr;
typedef struct ServerMgr* ServerHandle;
typedef int32_t (*ServerStart)(ServerHandle handle);
typedef void (*ServerStop)(void);

typedef struct ServerMgr{
    bool init; // init is used only once; true: be used; false: free
    bool processFlag; // true: running process exists; false: no running process
    bool monitorRunFlag; // true: running status; false: stopped status
    ToolThread monitorTid; // tid of session monitor
    AdxCommConHandle handle;
    uint32_t maxNum;
    uint32_t linkedNum;
    uint32_t linkType;
    int32_t runEnv;
    ServerStart start;
    ServerStop stop;
    ToolMutex lock;
} ServerMgr;

// total 256 byte
typedef struct {
    uint32_t magic;
    uint32_t version;
    int32_t retCode;
    uint8_t reserve[116];  // reserve 124 bytes
    char retMsg[SERVER_MSG_SIZE]; // msg length 128 bytes
} ServerResultInfo;

typedef struct {
    uint32_t num;
    uint32_t linkType;
    int32_t runEnv;
} ServerAttr;

int32_t ServerCreate(ComponentType type, ServerStart start, ServerStop stop, ServerAttr *attr);
int32_t ServerCreateEx(ComponentType type, ServerComponentInit init, ServerComponentProcess process,
    ServerComponentUnInit uninit);
void ServerRelease(ComponentType type);
int32_t ServersStart(void);
int32_t ServerSyncFile(ServerHandle handle, const char *srcFileName, const char *dstFileName);
int32_t ServerSendMsg(ServerHandle handle, const char *msg, uint32_t msgLen);
int32_t ServerRecvMsg(ServerHandle handle, char **msg, uint32_t *msgLen, uint32_t timeout);

#ifdef __cplusplus
}
#endif
#endif