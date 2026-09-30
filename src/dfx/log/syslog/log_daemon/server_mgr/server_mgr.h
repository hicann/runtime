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

typedef struct ServerMgr {
    bool init;           // init is used only once; true: be used; false: free
    bool processFlag;    // true: running process exists; false: no running process
    bool monitorRunFlag; // true: running status; false: stopped status
    // CommHandle 所有权：仅在 ServerProcess 的 start 返回成功后置位，表示句柄已移交组件、
    // 由 session monitor 负责释放。置位前句柄归框架侧（RunProcessTask 在 Process 返回失败时释放），
    // 监控线程此时销毁句柄会与框架侧构成 double free
    bool handleOwned;
    // 请求代际：每次 ServerProcess 接管节点时递增，监控线程创建时捕获当时代际，
    // 收尾时仅当代际未变（节点未被新请求接管）才处理节点级状态（销毁句柄/递减计数），
    // 否则只做自身退出，避免旧线程误销毁新请求的句柄、破坏新请求的并发计数
    uint32_t generation;
    ToolThread monitorTid; // tid of session monitor
    ComponentType comp;    // component type of this node, the session monitor thread uses it
    AdxCommConHandle handle;
    uint32_t maxNum;
    uint32_t linkedNum;
    uint32_t linkType;
    int32_t runEnv;
    ServerStart start;
    ServerStop stop;
    ServerSend send;
    ServerRecv recv;
    ToolMutex lock;
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

// UT 构建下 STATIC 展开为空，模块内部符号具备外部链接，在此导出声明供用例引用
#if defined _LOG_UT_ || defined __IDE_UT
extern ServerMgr g_serverMgr[NR_COMPONENTS];
int32_t ServerProcess(const CommHandle* handle, const void* msg, uint32_t len);
int32_t ServerWaitStop(ServerHandle handle);
// 监控线程的私有上下文（与 server_mgr.c 中的定义保持一致），用例直接构造后调线程体。
// UT 栈上构造时 onHeap 置 false（线程体内不 free）
typedef struct {
    ServerHandle mgr;
    uint32_t generation;
    bool onHeap;
} SessionMonitorCtx;
void* SessionMonitorProcess(void* arg);
#endif

#ifdef __cplusplus
}
#endif
#endif
