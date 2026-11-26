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
#define SERVER_LONG_LINK 0
#define SERVER_LONG_LINK_STOP 1
#define SERVER_SHORT_LINK 2
#define SERVER_LINK_TYPE_MAX 3
#define ENV_ALL 0
#define ENV_NON_DOCKER 1 // 1 & 3
#define ENV_TYPE_MAX 2
#define SERVER_MSG_SIZE 128

int32_t ServerMgrInit(void);
void ServerMgrExit(void);

typedef AdxComponentInit ServerComponentInit;
typedef AdxComponentProcess ServerComponentProcess;
typedef AdxComponentUnInit ServerComponentUnInit;

struct ServerMgr;
typedef struct ServerMgr* ServerHandle;
typedef int32_t (*ServerStart)(ServerHandle handle);
typedef void (*ServerStop)(void);
typedef int32_t (*ServerSend)(ServerHandle, const char*, uint32_t);
typedef int32_t (*ServerRecv)(ServerHandle, char**, uint32_t*, uint32_t);

// per-session comm reference node: created when ServerProcess publishes a session handle,
// destroyed together with the handle. refs counts every holder of the comm handle (the
// session monitor's lifetime reference plus in-flight requests); dying marks a handle
// detached by its monitor or rolled back by ServerProcess. Nodes are kept in commList and
// referenced by pointer: each generation is counted on its own node, references of
// different sessions never mix, so a generation is destroyed exactly once by its own
// last releaser.
typedef struct ServerCommNode {
    AdxCommConHandle comm;
    uint32_t refs;
    bool dying;
    struct ServerCommNode* next;
} ServerCommNode;

typedef struct ServerMgr {
    bool init;             // init is used only once; true: be used; false: free
    bool processFlag;      // true: running process exists; false: no running process
    bool monitorRunFlag;   // true: running status; false: stopped status
    ToolThread monitorTid; // tid of session monitor
    // commList and current are guarded by stateLock (lock order: lock -> stateLock).
    // The session monitor tail and the acquire/release paths take stateLock ONLY: a caller
    // joining the monitor under lock (SessionMonitorCreate) must never share a lock with the
    // joined thread, otherwise concurrent session turnover can deadlock.
    ServerCommNode* commList; // all session generations, a dying node leaves the list when its refs drops to 0
    ServerCommNode* current;  // the published session node, the only source of new references
    uint32_t maxNum;
    uint32_t linkedNum;
    uint32_t linkType;
    int32_t runEnv;
    ServerStart start;
    ServerStop stop;
    ServerSend send;
    ServerRecv recv;
    ToolMutex lock;
    ToolMutex stateLock;
} ServerMgr;

// total 256 byte
typedef struct {
    uint32_t magic;
    uint32_t version;
    int32_t retCode;
    uint8_t reserve[116];         // reserve 124 bytes
    char retMsg[SERVER_MSG_SIZE]; // msg length 128 bytes
} ServerResultInfo;

typedef struct {
    uint32_t num;
    uint32_t linkType;
    int32_t runEnv;
} ServerAttr;

int32_t ServerCreate(ComponentType type, ServerStart start, ServerStop stop, ServerAttr* attr);
int32_t ServerCreateEx(
    ComponentType type, ServerComponentInit init, ServerComponentProcess process, ServerComponentUnInit uninit);
void ServerRelease(ComponentType type);
int32_t ServersStart(void);
int32_t ServerSyncFile(ServerHandle handle, const char* srcFileName, const char* dstFileName);
int32_t ServerSendMsg(ServerHandle handle, const char* msg, uint32_t msgLen);
int32_t ServerRecvMsg(ServerHandle handle, char** msg, uint32_t* msgLen, uint32_t timeout);

#ifdef __cplusplus
}
#endif
#endif