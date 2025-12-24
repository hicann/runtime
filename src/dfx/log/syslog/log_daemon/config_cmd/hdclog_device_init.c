/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdclog_device_init.h"

#include <malloc.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <unistd.h>
#include <stdbool.h>

#include "securec.h"
#include "log_system_api.h"

#include "log_config_api.h"
#include "log_common.h"
#include "hdclog_com.h"
#include "msg_queue.h"
#include "log_print.h"
#include "log_drv.h"
#include "log_cmd.h"
#include "config_common.h"

int32_t HdclogDeviceInit(void)
{
    if (LogCmdInitMutex() != CONFIG_OK) {
        return HDCLOG_MUTEX_INIT_FAILED;
    }
    return HDCLOG_SUCCESSED;
}

int32_t HdclogDeviceDestroy(void)
{
    (void)LogCmdDestoryMutex();
    return HDCLOG_SUCCESSED;
}

/*
 * @brief: response level setting result to host
 * @param [in]session: hdc session
 * @param [in]errMsg: level setting error message
 * @param [in]errLen: level setting error length
 * @return: HDCLOG_SUCCESSED: succeed; others: failed
 */
STATIC HdclogErr LogCmdRespSettingResult(HDC_SESSION session, const char *errMsg, size_t errLen)
{
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)session;
    int32_t ret = AdxSendMsgByHandle(&handle, IDE_FILE_GETD_REQ, errMsg, (uint32_t)errLen);
    if (ret < 0) {
        SELF_LOG_ERROR("write level setting result to host failed, result=%d.", ret);
        return HDCLOG_WRITE_FAILED;
    }

    return HDCLOG_SUCCESSED;
}

/*
 * @brief: check whether the total string contains substrings
 * @param [in]str: total string
 * @param [in]subStr: substrings
 * @return: contains: true; not contains: false
 */
STATIC bool IsContainsStr(const char *str, const char *subStr)
{
    return strstr(str, subStr) != NULL;
}

/*
 * @brief: parse device message, and notify the process of dlog and slog
 * @param [in]session: hdc session
 * @param [in]msg: request info from client
 * @return: HDCLOG_SUCCESSED: succeed; others: failed
 */
STATIC HdclogErr ParseDeviceLogCmd(HDC_SESSION session, const LogDataMsg *msg)
{
    if ((msg->sliceLen >= MSG_MAX_LEN) || (msg->sliceLen <= 0)) {
        SELF_LOG_WARN("request length is illegal, request_length=%u.", msg->sliceLen);
        (void)LogCmdRespSettingResult(session, LEVEL_INFO_ERROR_MSG, strlen(LEVEL_INFO_ERROR_MSG));
        return HDCLOG_INIT_FAILED;
    }

    LogCmdMsg rcvMsg = {0, -1, ""};
    int32_t ret = LogCmdSendLogMsg(&rcvMsg, (const char *)msg->data, msg->devId);
    if (ret != CONFIG_OK) {
        if (ret == CONFIG_LOG_MSGQUEUE_FAILED) {
            (void)LogCmdRespSettingResult(session, SLOGD_ERROR_MSG, strlen(SLOGD_ERROR_MSG));
        } else {
            (void)LogCmdRespSettingResult(session, UNKNOWN_ERROR_MSG, strlen(UNKNOWN_ERROR_MSG));
        }
        return HDCLOG_MSGQUEUE_RECV_FAILED;
    }

    if (strcmp(LEVEL_SETTING_SUCCESS, rcvMsg.msgData) == 0) {
        SELF_LOG_INFO("set device level succeed.");
    } else if (IsContainsStr(rcvMsg.msgData, GET_DEVICE_LOG_LEVEL_SUCCESS_FLAG)) {
        SELF_LOG_INFO("get device level succeed.");
    } else {
        SELF_LOG_ERROR("set device level failed, result_info=%s.", rcvMsg.msgData);
    }
    return LogCmdRespSettingResult(session, rcvMsg.msgData, strlen(rcvMsg.msgData));
}

/*
 * @brief:judge if compute power group
 * @param [in]session: hdc session
 * @param [in]runEnv: run env value
 * @param [in]vfId: vfid value
 * @return: HDCLOG_SUCCESSED: true; others: false
 */
STATIC bool JudgeIfComputePowerGroup(HDC_SESSION session, int32_t vfId)
{
    if (vfId != 0) {
        SELF_LOG_WARN("compute power group, vfId=%d.", vfId);
        (void)LogCmdRespSettingResult(session, COMPUTE_POWER_GROUP, strlen(COMPUTE_POWER_GROUP));
        return true;
    }
    return false;
}

STATIC HdclogErr PreProcessBeforeParseCmd(HDC_SESSION session)
{
    int32_t runEnv = 0;
    if (DrvDevIdGetBySession(session, HDC_SESSION_ATTR_RUN_ENV, &runEnv) != 0) {
        SELF_LOG_ERROR("get run env type by session failed");
        (void)LogCmdRespSettingResult(session, UNKNOWN_ERROR_MSG, strlen(UNKNOWN_ERROR_MSG));
        return HDCLOG_IDE_GET_EVN_OR_VFID_FAILED;
    }

    if (runEnv == DRV_SESSION_RUN_ENV_VIRTUAL_CONTAINER) {
        SELF_LOG_ERROR("not support in virtual env docker.");
        (void)LogCmdRespSettingResult(session, VIRTUAL_ENV_NOT_SUPPORT_MSG, strlen(VIRTUAL_ENV_NOT_SUPPORT_MSG));
        return HDCLOG_SETTING_LEVEL_FAILED;
    }

    int32_t vfId = 0;
    int32_t ret = DrvDevIdGetBySession(session, (int32_t)HDC_SESSION_ATTR_VFID, &vfId);
    if (ret != HDCLOG_SUCCESSED) {
        SELF_LOG_ERROR("ide get vfid by session failed, ret=%d.", ret);
        (void)LogCmdRespSettingResult(session, UNKNOWN_ERROR_MSG, strlen(UNKNOWN_ERROR_MSG));
        return HDCLOG_IDE_GET_EVN_OR_VFID_FAILED;
    }

    if (JudgeIfComputePowerGroup(session, vfId)) {
        // compute power group: multiple hosts use one device, prohibit operating log level
        return HDCLOG_COMPUTE_POWER_GROUP;
    }

    return HDCLOG_SUCCESSED;
}

/*
 * @brief: process level setting cmd
 * @param [in]session: hdc session
 * @param [in]req: request info from client
 * @return: HDCLOG_SUCCESSED: succeed; others: failed
 */
int32_t IdeDeviceLogProcess(const CommHandle *command, const void* value, uint32_t len)
{
    if ((command == NULL) || (value == NULL)) {
        return HDCLOG_EMPTY_QUEUE;
    }
    HDC_SESSION session = (HDC_SESSION)command->session;
    LogDataMsg *msg = (LogDataMsg *)LogMalloc(len + 1);
    ONE_ACT_ERR_LOG(msg == NULL, return HDCLOG_MALLOC_FAILED, "malloc failed.")
    int32_t ret = memcpy_s(msg, len + 1, value, len);
    TWO_ACT_ERR_LOG(ret != EOK, XFREE(msg), return HDCLOG_CREATE_SHARE_MEMORY_FAILED, "memcpy_s failed.");
    HdclogErr preRes = PreProcessBeforeParseCmd(session);
    TWO_ACT_NO_LOG(preRes != HDCLOG_SUCCESSED, XFREE(msg), return preRes);

    if (session == NULL) {
        SELF_LOG_WARN("[input] session is null.");
        XFREE(msg);
        return HDCLOG_EMPTY_QUEUE;
    }
    HdclogErr res = HDCLOG_SUCCESSED;
    if (msg == NULL) {
        SELF_LOG_WARN("[input] request is null.");
        (void)LogCmdRespSettingResult(session, UNKNOWN_ERROR_MSG, strlen(UNKNOWN_ERROR_MSG));
        res = HDCLOG_EMPTY_QUEUE;
    } else {
        res = ParseDeviceLogCmd(session, msg);
        SELF_LOG_INFO("operate device level finished, result=%d.", (int32_t)res);
    }

    HdclogErr respRes = LogCmdRespSettingResult(session, HDC_END_MSG, strlen(HDC_END_MSG));
    if (respRes != HDCLOG_SUCCESSED) {
        SELF_LOG_ERROR("response end message to host failed, ret=%d.", (int32_t)respRes);
        XFREE(msg);
        return respRes;
    }
    XFREE(msg);
    return res;
}