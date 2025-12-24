/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hbm_detect.h"
#include "ascend_hal.h"
#include "log_print.h"
#include "log_common.h"
#include "log_drv.h"

#define HBM_MESSAGE_MAX_SIZE     1024U
#define HBM_COMMAND_SUDO         "sudo"
#define HBM_COMMAND_HEAD         "/usr/bin/hbmtester"
#define HBM_COMMAND_ADDR         "--address"
#define HBM_COMMAND_RUN          "--run -t 8"
#define HBM_COMMAND_FREE         "--free"
#define HBM_COMMAND_STOP         "sudo /usr/bin/hbmtester --stop"
#define HBM_COMMAND_IS_RUNNING   "ps|grep hbmtester|grep -v grep|wc -l"
#define HBM_COMMAND_RESULT       "echo $?"
#define HBM_COMMAND_ZERO         "0\n"

#define HBM_THREAD_ATTR          { 1, 0, 0, 0, 0, 1, 128 * 1024 } // Default ThreadSize(128KB)
#define NON_DOCKER               1
#define VM_NON_DOCKER            3

#define HBM_THREAD_STATUS_INIT          0
#define HBM_THREAD_STATUS_RUN           1
#define HBM_THREAD_STATUS_WAIT_EXIT     2
STATIC uint32_t g_hbmThreadStatus = HBM_THREAD_STATUS_INIT;

#define HBM_REPLY_PROHIBIT_CONTAINER       "prohibit container operate hbmtester"
#define HBM_REPLY_PROHIBIT_CONCURRENT      "prohibit concurrent hbmtester execution"
#define HBM_REPLY_HBMTESTER_FAILED         "hbmtester return error after execution"
#define HBM_REPLY_INVLAID_INPUT            "check input validity failed"
#define HBM_REPLY_SHELL_ERROR              "shell execution result error"
#define HBM_REPLY_SYSTEM_FUNCTION          "system function failed"
#define HBM_REPLY_FILE_NOT_EXIST           "hbmtester not exist"
#define HBM_REPLY_ADDR_SUCCESS             "set addr success"
#define HBM_REPLY_ADDR_FAIL                "set addr fail"
#define HBM_REPLY_DETECT_SUCCESS           "detect success"
#define HBM_REPLY_DETECT_FAIL              "detect fail"

#define HBM_RUN_MONITOR_SLEEP_TIME         100 // 100ms
#define HBM_COMMAND_LENGTH_MAX             128U

typedef int32_t (*HbmDetectFgetsProcess)(const CommHandle *handle, const char *buffer, size_t len);

 /**
 * @brief       : check if handle is valid
 * @param [in]  : handle      handle for communicating with the peer end
 * @return      : LOG_SUCCESS: succ; others: fail
 */
STATIC int32_t HbmDetectIsHandleValid(const CommHandle *handle)
{
    if (handle == NULL) {
        // this process does not require communication
        return LOG_FAILURE;
    }
    int32_t status = 0;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_STATUS, &status);
    if ((ret != LOG_SUCCESS) || (status == HDC_SESSION_STATUS_CLOSE)) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : check if the info got from host is valid by field comparison
 * @param [in]  : hbmInfo    hbm detect info to be checked
 * @return      : LOG_SUCCESS: valid; LOG_FAILURE: invalid
 */
STATIC int32_t HbmDetectCheckInfoValid(const AmlHbmDetectInfo *hbmInfo)
{
    if (hbmInfo->magic != HBM_AML_MAGIC_NUM) {
        SELF_LOG_ERROR("check field magic failed, configure: %u, current: %u", HBM_AML_MAGIC_NUM, hbmInfo->magic);
        return LOG_FAILURE;
    }
    if (hbmInfo->version < HBM_AML_VERSION) {
        SELF_LOG_ERROR("check field version failed, configure: %u, current: %u", HBM_AML_VERSION, hbmInfo->version);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : send specified message and end message to host
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : msg        message to be sent
 * @param [in]  : len        length of message
 */
STATIC void HbmDetectReplyMsg(const CommHandle *handle, const char *msg, uint32_t len)
{
    if (handle == NULL) {
        // need not send message this time
        return;
    }
    int32_t ret = AdxSendMsg(handle, msg, len);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "reply message to host failed, ret=%d, message=%s", ret, msg);
    ret = AdxSendMsg(handle, HDC_END_MSG, strlen(HDC_END_MSG));
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "reply end message to host failed, ret=%d", ret);
}

 /**
 * @brief       : check if peer end is docker by hdc interface
 * @param [in]  : handle     handle for communicating with the peer end
 * @return      : LOG_SUCCESS: not docker
 */
STATIC int32_t HbmDetectCheckContainer(const CommHandle *handle)
{
    int32_t runEnv = 0;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_RUN_ENV, &runEnv);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("get run env failed, %d.", ret);
        HbmDetectReplyMsg(handle, HBM_REPLY_SYSTEM_FUNCTION, strlen(HBM_REPLY_SYSTEM_FUNCTION));
        return LOG_FAILURE;
    }
    if (runEnv != NON_DOCKER && runEnv != VM_NON_DOCKER) {
        SELF_LOG_WARN("prohibit container operate hbmtester, runEnv=%d.", runEnv);
        HbmDetectReplyMsg(handle, HBM_REPLY_PROHIBIT_CONTAINER, strlen(HBM_REPLY_PROHIBIT_CONTAINER));
        return LOG_INVALID_PARAM;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : popen command and process result by registered function
 * @param [in]  : handle       handle for communicating with the peer end
 * @param [in]  : cmd          command to execute
 * @param [in]  : func         function for process result from fgets
 * @param [in]  : resultNum    expected number of rows in result, <0 means unlimited
 * @return      : LOG_SUCCESS: succ; else: fail
 */
STATIC int32_t HbmDetectPopenCommand(const CommHandle *handle, const char *cmd, HbmDetectFgetsProcess func,
    int32_t resultNum)
{
    FILE *fp = popen(cmd, "r");
    ONE_ACT_ERR_LOG(fp == NULL, return LOG_FAILURE, "popen failed, cmd=%s, strerr=%s",
        cmd, strerror(ToolGetErrorCode()));
    char *result = (char *)LogMalloc(HBM_MESSAGE_MAX_SIZE);
    if (result == NULL) {
        SELF_LOG_ERROR("malloc running result failed, strerr=%s", strerror(ToolGetErrorCode()));
        pclose(fp);
        return LOG_FAILURE;
    }
    int32_t ret = LOG_SUCCESS;
    int32_t rowNum = 0;
    while (fgets(result, HBM_MESSAGE_MAX_SIZE, fp) != NULL) {
        rowNum++;
        if (func != NULL) {
            ret = func(handle, result, strlen(result));
        }
    }

    if ((ret == LOG_SUCCESS) && (resultNum >= 0) && (rowNum != resultNum)) {
        SELF_LOG_ERROR("command [%s] execution result error, resultNum=%d", cmd, rowNum);
        HbmDetectReplyMsg(handle, HBM_REPLY_SHELL_ERROR, strlen(HBM_REPLY_SHELL_ERROR));
        ret = LOG_FAILURE;
    }

    LogFree(result);
    pclose(fp);
    return ret;
}

 /**
 * @brief       : Whether the command HBM_COMMAND_RESULT execution result meets the expectation
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : buffer     result of fgets
 * @param [in]  : len        result length
 * @return      : LOG_SUCCESS: execution succ
 */
STATIC int32_t HbmDetectHbmExecutionResultProcess(const CommHandle *handle, const char *buffer, size_t len)
{
    if ((len != strlen(HBM_COMMAND_ZERO)) || (strncmp(buffer, HBM_COMMAND_ZERO, len) != 0)) {
        SELF_LOG_ERROR("%s, result=%s", HBM_REPLY_HBMTESTER_FAILED, buffer);
        HbmDetectReplyMsg(handle, HBM_REPLY_HBMTESTER_FAILED, strlen(HBM_REPLY_HBMTESTER_FAILED));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : get hbmtester execution result
 * @param [in]  : handle      handle for communicating with the peer end
 * @return      : LOG_SUCCESS: succ; LOG_FAILURE: fail
 */
STATIC int32_t HbmDetectGetResult(const CommHandle *handle)
{
    // echo $?
    return HbmDetectPopenCommand(handle, HBM_COMMAND_RESULT, HbmDetectHbmExecutionResultProcess, 1);
}

 /**
 * @brief       : Whether the command HBM_COMMAND_IS_RUNNING execution result meets the expectation
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : buffer     result of fgets
 * @param [in]  : len        result length
 * @return      : LOG_SUCCESS: execution succ
 */
STATIC int32_t HbmDetectHbmCheckRunningProcess(const CommHandle *handle, const char *buffer, size_t len)
{
    if ((len != strlen(HBM_COMMAND_ZERO)) || (strncmp(buffer, HBM_COMMAND_ZERO, len) != 0)) {
        SELF_LOG_WARN("%s, result=%s", HBM_REPLY_PROHIBIT_CONCURRENT, buffer);
        HbmDetectReplyMsg(handle, HBM_REPLY_PROHIBIT_CONCURRENT, strlen(HBM_REPLY_PROHIBIT_CONCURRENT));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC int32_t HbmDetectIsHbmRunning(const CommHandle *handle)
{
    return HbmDetectPopenCommand(handle, HBM_COMMAND_IS_RUNNING, HbmDetectHbmCheckRunningProcess, 1);
}

 /**
 * @brief       : check if hbmtester is executable
 * @param [in]  : handle      handle for communicating with the peer end
 * @return      : LOG_SUCCESS: succ; LOG_FAILURE: fail
 */
STATIC int32_t HbmDetectCheckHbmExecutable(const CommHandle *handle)
{
    int32_t ret = ToolAccessWithMode(HBM_COMMAND_HEAD, F_OK);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("the executable file %s does not exist.", HBM_COMMAND_HEAD);
        HbmDetectReplyMsg(handle, HBM_REPLY_FILE_NOT_EXIST, strlen(HBM_REPLY_FILE_NOT_EXIST));
        return LOG_FAILURE;
    }

    ret = HbmDetectIsHbmRunning(handle);
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

STATIC int32_t HbmDetectStopHbmtester(void)
{
    return HbmDetectPopenCommand(NULL, HBM_COMMAND_STOP, NULL, 0);
}

STATIC void *HbmDetectProcessThread(void *arg)
{
    CommHandle *handle = (CommHandle *)arg;
    NO_ACT_WARN_LOG(ToolSetThreadName("HBMRunMonitor") != SYS_OK, "can not set thread name(HBMRunMonitor).");

    while (g_hbmThreadStatus == HBM_THREAD_STATUS_RUN) {
        if (HbmDetectIsHandleValid(handle) != LOG_SUCCESS) {
            SELF_LOG_ERROR("hbm run monitor: handle is invalid");
            HbmDetectStopHbmtester();
            break;
        }
        (void)ToolSleep(HBM_RUN_MONITOR_SLEEP_TIME); // 100ms
    }

    SELF_LOG_INFO("hbm run monitor exit, g_hbmThreadStatus=%u", g_hbmThreadStatus);
    g_hbmThreadStatus = HBM_THREAD_STATUS_WAIT_EXIT;
    return NULL;
}

STATIC int32_t HbmDetectOperateSetAddr(const CommHandle *handle, const AmlHbmDetectInfo *hbmInfo)
{
    char hbmCommand[HBM_COMMAND_LENGTH_MAX] = { 0 };
    int32_t ret = LOG_SUCCESS;
    for (uint32_t i = 0; i < hbmInfo->num; ++i) {
        (void)memset_s(hbmCommand, HBM_COMMAND_LENGTH_MAX, 0, HBM_COMMAND_LENGTH_MAX);
        ret = sprintf_s(hbmCommand, HBM_COMMAND_LENGTH_MAX - 1, "%s %s %s 0x%llx-0x%llx", HBM_COMMAND_SUDO,
            HBM_COMMAND_HEAD, HBM_COMMAND_ADDR, hbmInfo->info[i].startAddr, hbmInfo->info[i].endAddr);
        ONE_ACT_ERR_LOG(ret == LOG_FAILURE, continue, "sprintf_s hdm addr info[%u] command error", i);
        SELF_LOG_INFO("hbm_detect set addr command, %s", hbmCommand);
        ret = HbmDetectPopenCommand(handle, hbmCommand, NULL, -1);
        ONE_ACT_NO_LOG(ret == LOG_FAILURE, continue);
    }

    int32_t addrResult = HbmDetectGetResult(handle);
    if (addrResult == LOG_SUCCESS) {
        HbmDetectReplyMsg(handle, HBM_REPLY_ADDR_SUCCESS, strlen(HBM_REPLY_ADDR_SUCCESS));
        ret = LOG_SUCCESS;
        SELF_LOG_INFO("hbm_detect set addr success");
    } else {
        HbmDetectReplyMsg(handle, HBM_REPLY_ADDR_FAIL, strlen(HBM_REPLY_ADDR_FAIL));
        ret = LOG_FAILURE;
        SELF_LOG_ERROR("hbm_detect set addr fail");
    }
    return ret;
}

STATIC int32_t HbmDetectStartDetectMonitor(const CommHandle *handle)
{
    // start process
    g_hbmThreadStatus = HBM_THREAD_STATUS_RUN;
    pthread_t tid = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = HbmDetectProcessThread;
    funcBlock.pulArg = (void *)handle;
    ToolThreadAttr threadAttr = HBM_THREAD_ATTR;
    int32_t ret = ToolCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
    if (ret != LOG_SUCCESS) {
        g_hbmThreadStatus = HBM_THREAD_STATUS_WAIT_EXIT;
        SELF_LOG_ERROR("create thread failed, result=%d.", ret);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC int32_t HbmDetectOperateDetect(const CommHandle *handle, const AmlHbmDetectInfo *hbmInfo)
{
    char hbmCommand[HBM_COMMAND_LENGTH_MAX] = { 0 };
    int32_t ret = sprintf_s(hbmCommand, HBM_COMMAND_LENGTH_MAX - 1, "%s %s %s",
        HBM_COMMAND_SUDO, HBM_COMMAND_HEAD, HBM_COMMAND_RUN);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s hdm run command error");
        HbmDetectReplyMsg(handle, HBM_REPLY_SYSTEM_FUNCTION, strlen(HBM_REPLY_SYSTEM_FUNCTION));
        return LOG_FAILURE;
    }
    if (hbmInfo->operate == OPERATE_RUN_FREE) {
        ret = sprintf_s(hbmCommand,  HBM_COMMAND_LENGTH_MAX - 1, "%s %s", hbmCommand, HBM_COMMAND_FREE) ;
        if (ret == -1) {
            SELF_LOG_ERROR("sprintf_s hdm run free command error");
            HbmDetectReplyMsg(handle, HBM_REPLY_SYSTEM_FUNCTION, strlen(HBM_REPLY_SYSTEM_FUNCTION));
            return LOG_FAILURE;
        }
    }
    SELF_LOG_INFO("hbm_detect run command, %s", hbmCommand);

    ret = HbmDetectStartDetectMonitor(handle);
    ONE_ACT_NO_LOG(ret == LOG_FAILURE, return ret);

    ret = HbmDetectPopenCommand(handle, hbmCommand, NULL, -1);
    ONE_ACT_ERR_LOG(ret == LOG_FAILURE, return LOG_FAILURE, "hbmtester run failed");

    g_hbmThreadStatus = HBM_THREAD_STATUS_WAIT_EXIT;

    int32_t detectResult = HbmDetectGetResult(handle);
    if (detectResult == LOG_SUCCESS) {
        HbmDetectReplyMsg(handle, HBM_REPLY_DETECT_SUCCESS, strlen(HBM_REPLY_DETECT_SUCCESS));
        ret = LOG_SUCCESS;
    } else {
        HbmDetectReplyMsg(handle, HBM_REPLY_DETECT_FAIL, strlen(HBM_REPLY_DETECT_FAIL));
        ret = LOG_FAILURE;
        SELF_LOG_ERROR("hbm_detect do detect fail");
    }

    return ret;
}

int32_t HbmDetectInit(void)
{
    if (HbmDetectIsHbmRunning(NULL) == LOG_FAILURE) {
        HbmDetectStopHbmtester();
    }
    return LOG_SUCCESS;
}

int32_t HbmDetectDestroy(void)
{
    if (HbmDetectIsHbmRunning(NULL) == LOG_FAILURE) {
        HbmDetectStopHbmtester();
    }
    return LOG_SUCCESS;
}

int32_t HbmDetectProcess(const CommHandle *handle, const void *value, uint32_t len)
{
    SELF_LOG_INFO("the hbm_detect process start");
    if (handle == NULL) {
        SELF_LOG_ERROR("invalid input, handle is null");
        return LOG_FAILURE;
    }
    if (value == NULL) {
        SELF_LOG_ERROR("invalid input, value is null");
        HbmDetectReplyMsg(handle, HBM_REPLY_INVLAID_INPUT, strlen(HBM_REPLY_INVLAID_INPUT));
        return LOG_FAILURE;
    }
    if  (len < sizeof(LogDataMsg)) {
        SELF_LOG_ERROR("invalid input, length of value is %u", len);
        HbmDetectReplyMsg(handle, HBM_REPLY_INVLAID_INPUT, strlen(HBM_REPLY_INVLAID_INPUT));
        return LOG_FAILURE;
    }

    if (HbmDetectCheckContainer(handle) != LOG_SUCCESS) {
        return LOG_SUCCESS;
    }

    if (HbmDetectCheckHbmExecutable(handle) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    const LogDataMsg *msg = (const LogDataMsg *)value;
    const AmlHbmDetectInfo *hbmInfo = (const AmlHbmDetectInfo *)msg->data;
    if (hbmInfo == NULL) {
        SELF_LOG_ERROR("invalid input, hbm info is null");
        return LOG_FAILURE;
    }

    if (HbmDetectCheckInfoValid(hbmInfo) != LOG_SUCCESS) {
        HbmDetectReplyMsg(handle, HBM_REPLY_INVLAID_INPUT, strlen(HBM_REPLY_INVLAID_INPUT));
        return LOG_FAILURE;
    }

    int32_t ret = LOG_SUCCESS;
    if (hbmInfo->operate == OPERATE_SET_ADDR) {
        ret = HbmDetectOperateSetAddr(handle, hbmInfo);
    } else if (hbmInfo->operate == OPERATE_RUN || hbmInfo->operate == OPERATE_RUN_FREE) {
        ret = HbmDetectOperateDetect(handle, hbmInfo);
    } else {
        SELF_LOG_ERROR("invalid input, operate type is %d", (int32_t)hbmInfo->operate);
        HbmDetectReplyMsg(handle, HBM_REPLY_INVLAID_INPUT, strlen(HBM_REPLY_INVLAID_INPUT));
        ret = LOG_FAILURE;
    }

    return ret;
}