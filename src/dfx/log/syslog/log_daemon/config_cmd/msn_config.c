/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msn_config.h"
#include <sys/msg.h>
#include "log_common.h"
#include "log_print.h"
#include "log_drv.h"
#include "driver_api.h"
#include "config_common.h"
#include "log_cmd.h"
#include "ts_cmd.h"

#define COMMAND_INFO_ERROR_MSG      "The format of the received command is invalid"
#define SET_LOG_LEVEL_FAIL_MSG      "Set log level failed, check slogdlog for more information"
#define LOG_GET_RUN_ENV_ERROR       "Get run env type failed"
#define LOG_GET_VFID_ERROR          "Get vfid failed"
#define ONLY_EXCLUSIVE_ENV          "Not support in container or virtualized device environment"
#define FLUSH_REGISTER_ERROR        "Flush register failed, please try again later"
#define FLUSH_REGISTER_NOT_SUPPORT  "This chip platform not support manual flush register"
#define FLUSH_REGISTER_SUCCESS      "Flush register success"

/**
 * @brief: init for msnpureport request, create mutex lock
 * @return: CONFIG_OK: succeed; others: failed
 */
int32_t MsnCmdInit(void)
{
    return LogCmdInitMutex();
}

/**
 * @brief: destory mutex lock
 * @return: CONFIG_OK: succeed; others: failed
 */
int32_t MsnCmdDestory(void)
{
    return LogCmdDestoryMutex();
}

/**
 * @brief: send result to host through adcore
 * @param [in] handle: hdc handle
 * @param [in] resultBuf: result buffer pointer
 * @param [in] resultLen: result buffer used length
 * @param [in] isError: if error occur
 * @return: CONFIG_OK: succeed; others: failed
 */
STATIC int32_t CmdRespSettingResult(const CommHandle *handle, const char *resultBuf, size_t resultLen, bool isError)
{
    size_t configLen = resultLen + 1U;
    size_t buffLen = sizeof(struct ConfigInfo) + configLen;
    struct ConfigInfo *configInfo = (struct ConfigInfo *)LogMalloc(buffLen);
    ONE_ACT_ERR_LOG(configInfo == NULL, return CONFIG_MALLOC_FAILED, "malloc failed.");
    
    configInfo->len = (uint32_t)configLen;
    configInfo->isError = isError;
    int32_t ret = memcpy_s(configInfo->value, configLen, resultBuf, resultLen);
    TWO_ACT_ERR_LOG(ret != EOK, XFREE(configInfo), return CONFIG_MEM_WRITE_FAILED, "memcpy_s failed, ret:%d", ret);

    ret = AdxSendMsgByHandle(handle, IDE_MSN_REQ, (char *)configInfo, (uint32_t)buffLen);
    if (isError) {
        SELF_LOG_ERROR("send configInfo->len:%u, configInfo->value:%s, return:%d",
            configInfo->len, configInfo->value, ret);
    } else {
        SELF_LOG_INFO("send configInfo->len:%u, configInfo->value:%s, return:%d",
            configInfo->len, configInfo->value, ret);
    }
    if (ret != IDE_DAEMON_OK) {
        XFREE(configInfo);
        SELF_LOG_ERROR("write result to host failed, return:%d.", ret);
        return CONFIG_ERROR;
    }
    XFREE(configInfo);

    return CONFIG_OK;
}

STATIC int32_t CheckEnvSupport(const CommHandle *handle, const struct MsnReq *req)
{
    int32_t runEnv = RUN_ENV_UNKNOW;
    int32_t ret = DrvDevIdGetBySession((HDC_SESSION)handle->session, (int32_t)HDC_SESSION_ATTR_RUN_ENV, &runEnv);
    if (ret != 0) {
        (void)CmdRespSettingResult(handle, LOG_GET_RUN_ENV_ERROR, strlen(LOG_GET_RUN_ENV_ERROR), true);
        return CONFIG_ERROR;
    }
    int32_t vfId = 0;
    ret = DrvDevIdGetBySession((HDC_SESSION)handle->session, (int32_t)HDC_SESSION_ATTR_VFID, &vfId);
    if (ret != 0) {
        SELF_LOG_ERROR("Get vfid by session failed, ret=%d.", ret);
        (void)CmdRespSettingResult(handle, LOG_GET_VFID_ERROR, strlen(LOG_GET_VFID_ERROR), true);
        return CONFIG_ERROR;
    }

    if ((req->cmdType == CONFIG_GET) || (req->cmdType == CONFIG_SET)) {
        if (runEnv == RUN_ENV_VIRTUAL_CONTAINER) {
            SELF_LOG_ERROR("Not support in virtual env docker.");
            (void)CmdRespSettingResult(handle, VIRTUAL_ENV_NOT_SUPPORT_MSG, strlen(VIRTUAL_ENV_NOT_SUPPORT_MSG), true);
            return CONFIG_ERROR;
        }
        if (vfId != 0) {
            SELF_LOG_WARN("only support vfid 0, current vfId=%d.", vfId);
            (void)CmdRespSettingResult(handle, COMPUTE_POWER_GROUP, strlen(COMPUTE_POWER_GROUP), true);
            return CONFIG_ERROR;
        }
        return CONFIG_OK;
    }

    if (req->cmdType == REPORT) {
        if (((runEnv != RUN_ENV_PHYSICAL) && (runEnv != RUN_ENV_VIRTUAL))) {
            SELF_LOG_ERROR("Not in exclusive environment, env:%d", runEnv);
            (void)CmdRespSettingResult(handle, ONLY_EXCLUSIVE_ENV, strlen(ONLY_EXCLUSIVE_ENV), true);
            return CONFIG_ERROR;
        }
        return CONFIG_OK;
    }

    return CONFIG_ERROR;
}

/**
 * @brief: handle config get command
 * @param [in] handle: hdc CommHandle
 * @param [in] req: MsnReq pointer
 * @return: CONFIG_OK: succeed; others: failed
 */
STATIC int32_t ConfigGetHandle(const CommHandle *handle, uint16_t devId)
{
    char resultBuf[RESULT_BUFFER_LEN] = {0};
    TsCmdGetConfig(resultBuf, RESULT_BUFFER_LEN, devId);

    uint32_t resultLen = (uint32_t)strlen(resultBuf);
    if (resultLen >= (RESULT_BUFFER_LEN - 1)) {
        SELF_LOG_WARN("resultBuf not enough");
        return CmdRespSettingResult(handle, resultBuf, resultLen, false);
    }
    resultBuf[resultLen++] = '|';
    (void)LogCmdGetLogLevel(resultBuf, &resultLen, devId);

    return CmdRespSettingResult(handle, resultBuf, resultLen, false);
}

/**
 * @brief: handle config set cmd
 * @param [in] session: hdc session
 * @param [in] req:     MsnReq pointer
 * @return: CONFIG_OK: succeed; others: failed
 */
STATIC int32_t ConfigSetHandle(const CommHandle *handle, const struct MsnReq *req, uint16_t devId)
{
    if (req->subCmd == (uint32_t)LOG_LEVEL) {
        int32_t ret = LogCmdSetLogLevel(req->value, devId);
        if (ret != CONFIG_OK) {
            (void)CmdRespSettingResult(handle, SET_LOG_LEVEL_FAIL_MSG, strlen(SET_LOG_LEVEL_FAIL_MSG), true);
            return ret;
        }
        return CmdRespSettingResult(handle, SET_SUCCESS_MSG, strlen(SET_SUCCESS_MSG), false);
    }

    char result[RESULT_BUFFER_LEN] = {0};
    if ((req->subCmd >= (uint32_t)ICACHE_RANGE) && (req->subCmd <= (uint32_t)SINGLE_COMMIT)) {
        int32_t ret = TsCmdSetConfig(req, devId, result, RESULT_BUFFER_LEN);
        if (ret != CONFIG_OK) {
            (void)CmdRespSettingResult(handle, result, strlen(result), true);
            return ret;
        }
        return CmdRespSettingResult(handle, result, strlen(result), false);
    }

    return CmdRespSettingResult(handle, COMMAND_INFO_ERROR_MSG, strlen(COMMAND_INFO_ERROR_MSG), true);
}

STATIC int32_t ReportHandle(const CommHandle *handle, uint16_t devId)
{
#ifdef CONFIG_EXPAND
    uint32_t channelType = LOG_CHANNEL_TYPE_IMU;
#else
    uint32_t channelType = LOG_CHANNEL_TYPE_LPM3;
#endif
    int32_t ret = LogSetDfxParam(devId, channelType, &channelType, 1);  // data, dataLen not use, but can not be NULL
    if (ret != LOG_OK) {
        if (ret == LOG_NOT_SUPPORT) {
            return CmdRespSettingResult(handle, FLUSH_REGISTER_NOT_SUPPORT, strlen(FLUSH_REGISTER_NOT_SUPPORT), true);
        }
        return CmdRespSettingResult(handle, FLUSH_REGISTER_ERROR, strlen(FLUSH_REGISTER_ERROR), true);
    }
    return CmdRespSettingResult(handle, FLUSH_REGISTER_SUCCESS, strlen(FLUSH_REGISTER_SUCCESS), false);
}

/**
 * @brief: parse msnpureport cmd
 * @param [in] handle: hdc command handle
 * @param [in] req: MsnReq pointer
 * @return: CONFIG_OK: succeed; others: failed
 */
STATIC int32_t ParseDeviceCmd(const CommHandle *handle, const struct MsnReq *req, uint16_t devId)
{
    if (CheckEnvSupport(handle, req) != CONFIG_OK) {
        return CONFIG_ERROR;
    }
    int32_t ret = CONFIG_OK;

    switch (req->cmdType) {
        case CONFIG_GET:
            ret = ConfigGetHandle(handle, devId);
            break;
        case CONFIG_SET:
            ret = ConfigSetHandle(handle, req, devId);
            break;
        case REPORT:
            ret = ReportHandle(handle, devId);
            break;
        default:
            ret = CONFIG_INVALID_PARAM;
            break;
    }
    return ret;
}

/**
 * @brief: process msnpureport cmd
 * @param [in] command: hdc command handle
 * @param [in] value: request info from client
 * @param [in] len: request info length
 * @return: CONFIG_OK: succeed; others: failed
 */
int32_t MsnCmdProcess(const CommHandle *command, const void* value, uint32_t len)
{
    const size_t minSize = sizeof(LogDataMsg) + sizeof(struct MsnReq);
    if ((command == NULL) || (value == NULL) || (len < (uint32_t)minSize)) {
        SELF_LOG_ERROR("command is NULL or value is NULL or len too small");
        return CONFIG_INVALID_PARAM;
    }

    int32_t ret = CONFIG_OK;
    do {
        const LogDataMsg *msg = (const LogDataMsg *)value;
        if (msg->sliceLen > MSG_MAX_LEN) {
            SELF_LOG_WARN("request length is illegal, request_length=%u.", msg->sliceLen);
            CmdRespSettingResult(command, COMMAND_INFO_ERROR_MSG, strlen(COMMAND_INFO_ERROR_MSG), true);
            ret = CONFIG_INVALID_PARAM;
            break;
        }
        const struct MsnReq *req = (const struct MsnReq *)msg->data;
        if (len - (uint32_t)minSize != req->valueLen) {
            SELF_LOG_ERROR("get length:%u not meet the expected value.", len);
            CmdRespSettingResult(command, COMMAND_INFO_ERROR_MSG, strlen(COMMAND_INFO_ERROR_MSG), true);
            ret = CONFIG_INVALID_PARAM;
            break;
        }
        SELF_LOG_INFO("receive request: deviceId:%hu, MsnReq: cmdType:%d, subCmd:%u, valueLen:%u, value:%.*s",
            msg->devId, (int32_t)req->cmdType, req->subCmd, req->valueLen, (int32_t)req->valueLen, req->value);

        ret = ParseDeviceCmd(command, req, msg->devId);
        SELF_LOG_INFO("operate command finished, ret=%d", ret);
    } while (0);

    int32_t respRes = AdxSendMsgByHandle(command, IDE_MSN_REQ, HDC_END_MSG, (uint32_t)strlen(HDC_END_MSG));
    ONE_ACT_ERR_LOG(respRes != IDE_DAEMON_OK, return respRes,
        "response end message to host failed, result=%d.", respRes);

    return ret;
}