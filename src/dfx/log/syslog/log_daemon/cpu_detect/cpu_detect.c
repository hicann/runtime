/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cpu_detect.h"
#include "log_print.h"
#include "detect_errcode.h"
#include "server_mgr.h"
#include "log_common.h"
#include "dlfcn.h"

#define CPU_DETECT_REPLY_MSG_SUCCESS           "cpu detect success"
#define CPU_DETECT_REPLY_MSG_FAILURE           "cpu detect failed"
#define CPU_DETECT_REPLY_MSG_INVALID_MESSAGE   "cpu detect failed, invalid message struct"
#define CPU_DETECT_REPLY_MSG_TESTCASE_FAIL     "cpu detect failed, testcase run failed"
#define CPU_DETECT_REPLY_MSG_FW_FAIL           "cpu detect failed, execution framework run failed"

#define CPU_DETECT_SO_PATH              "libcpu_detect.so"
#define CPU_DETECT_RECV_TIME            1000
#define CPU_DETECT_TESTCASE_FAIL        100

typedef int32_t (*CpuDetectStartFunc)(uint32_t timeout);
typedef void (*CpuDetectStopFunc)(void);

typedef struct {
    void *dlHandle;
    CpuDetectStartFunc cpuDetectStart;
    CpuDetectStopFunc cpuDetectStop;
} CpuDetectMgr;

STATIC CpuDetectMgr g_cpuDetectMgr = {0};

STATIC int32_t CpuDetectServerReplyMsg(const ServerHandle handle, int32_t replyCode, const char *msg)
{
    CpuDetectResultInfo retInfo = {0};
    retInfo.magic = CPU_DETECT_MAGIC_NUM;
    retInfo.version = CPU_DETECT_VERSION;
    retInfo.retCode = replyCode;
    errno_t err = memcpy_s(retInfo.retMsg, CPU_DETECT_MSG_SIZE, msg, strlen(msg));
    ONE_ACT_ERR_LOG(err != EOK, return DETECT_FAILURE, "reply message to host failed, ret=%d, replyCode=%d,  message=%s",
        (int32_t)err, replyCode, msg);

    int32_t ret = ServerSendMsg(handle, (const char *)&retInfo, sizeof(retInfo));
    ONE_ACT_ERR_LOG(ret != 0, return DETECT_FAILURE, "reply message to host failed, ret=%d, replyCode=%d,  message=%s",
        ret, replyCode, msg);

    return DETECT_SUCCESS;
}

STATIC void CpuDetectServerStop(void)
{
    if (g_cpuDetectMgr.cpuDetectStop != NULL) {
        g_cpuDetectMgr.cpuDetectStop();
    }
}

STATIC int32_t CpuDetectServerCheckMsg(const CpuDetectInfo *msg)
{
    ONE_ACT_ERR_LOG(msg == NULL, return DETECT_FAILURE, "invalid message: null.");
    ONE_ACT_ERR_LOG(msg->magic != CPU_DETECT_MAGIC_NUM, return DETECT_FAILURE, "invalid message magic: %u", msg->magic);
    ONE_ACT_ERR_LOG(msg->cmdType != CPU_DETECT_CMD_START, return DETECT_FAILURE, "invalid cmd type : %u", msg->cmdType);
    return DETECT_SUCCESS;
}

STATIC int32_t CpuDetectServerProcess(const ServerHandle handle, const CpuDetectInfo *msg)
{
    int32_t err = CpuDetectServerCheckMsg(msg);
    if (err != DETECT_SUCCESS) {
        SELF_LOG_ERROR("cpu detect check msg failed");
        CpuDetectServerReplyMsg(handle, DETECT_ERROR_INVALID_ARGUMENT, CPU_DETECT_REPLY_MSG_INVALID_MESSAGE);
        return DETECT_FAILURE;
    }

    int32_t ret = g_cpuDetectMgr.cpuDetectStart(msg->timeout);
    if (ret == 0) {
        SELF_LOG_INFO("cpu detect run success");
        CpuDetectServerReplyMsg(handle, DETECT_SUCCESS, CPU_DETECT_REPLY_MSG_SUCCESS);
        return DETECT_SUCCESS;
    } else if (ret == CPU_DETECT_TESTCASE_FAIL) {
        SELF_LOG_ERROR("cpu detect run failed with %d", ret);
        CpuDetectServerReplyMsg(handle, DETECT_ERROR_TESTCASE_FAIL, CPU_DETECT_REPLY_MSG_TESTCASE_FAIL);
        return DETECT_SUCCESS;
    } else {
        SELF_LOG_ERROR("cpu detect run failed with %d", ret);
        CpuDetectServerReplyMsg(handle, DETECT_FAILURE, CPU_DETECT_REPLY_MSG_FW_FAIL); 
        return DETECT_FAILURE;
    }
}

STATIC int32_t CpuDetectServerStart(const ServerHandle handle)
{
    SELF_LOG_INFO("the cpu detect process start");
    if (handle == NULL) {
        SELF_LOG_ERROR("invalid input, handle is null");
        return DETECT_FAILURE;
    }

    uint32_t msgLength = (uint32_t)sizeof(CpuDetectInfo);
    CpuDetectInfo *msg = (CpuDetectInfo *)LogMalloc(msgLength);
    ONE_ACT_ERR_LOG(msg == NULL, return LOG_FAILURE,
        "malloc for receive message buffer failed, strerr=%s.", strerror(ToolGetErrorCode()));
    int32_t err = ServerRecvMsg(handle, (char **)&msg, &msgLength, CPU_DETECT_RECV_TIME);
    if ((err != 0) || (msgLength != (uint32_t)sizeof(CpuDetectInfo))) {
        SELF_LOG_ERROR("cpu detect recv failed with %d.", err);
        free(msg);
        return DETECT_FAILURE;
    }

    int32_t ret = CpuDetectServerProcess(handle, msg);
    free(msg);
    return ret;
}

STATIC void CpuDetectServerDestroyHandle(void)
{
    if (g_cpuDetectMgr.dlHandle != NULL) {
        dlclose(g_cpuDetectMgr.dlHandle);
        g_cpuDetectMgr.dlHandle = NULL;
        g_cpuDetectMgr.cpuDetectStart = NULL;
        g_cpuDetectMgr.cpuDetectStop = NULL;
    }
}

STATIC int32_t CpuDetectServerInitHandle(void)
{
    g_cpuDetectMgr.dlHandle = dlopen(CPU_DETECT_SO_PATH, RTLD_GLOBAL | RTLD_NOW);
    if (g_cpuDetectMgr.dlHandle == NULL) {
        SELF_LOG_WARN("cpu detection can not open so file.");
        return DETECT_SUCCESS;
    }
    g_cpuDetectMgr.cpuDetectStart = (CpuDetectStartFunc)dlsym(g_cpuDetectMgr.dlHandle, "CpuDetectStart");
    g_cpuDetectMgr.cpuDetectStop = (CpuDetectStopFunc)dlsym(g_cpuDetectMgr.dlHandle, "CpuDetectStop");
    if ((g_cpuDetectMgr.cpuDetectStart == NULL) || (g_cpuDetectMgr.cpuDetectStop == NULL)) {
        SELF_LOG_ERROR("cpu detection find func failed");
        CpuDetectServerDestroyHandle();
        return DETECT_FAILURE;
    }

    return DETECT_SUCCESS;
}

int32_t CpuDetectServerInit(void)
{
    int32_t ret = CpuDetectServerInitHandle();
    if (ret != DETECT_SUCCESS) {
        SELF_LOG_ERROR("cpu detect init handle failed.");
        return DETECT_FAILURE;
    }

    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK_STOP;
    attr.runEnv = ENV_NON_DOCKER;
    int32_t err = ServerCreate(COMPONENT_CPU_DETECT, CpuDetectServerStart, CpuDetectServerStop, &attr);
    if (err != 0) {
        CpuDetectServerDestroyHandle();
        return DETECT_FAILURE;
    }
    return DETECT_SUCCESS;
}

void CpuDetectServerExit(void)
{
    CpuDetectServerDestroyHandle();
    ServerRelease(COMPONENT_CPU_DETECT);
}