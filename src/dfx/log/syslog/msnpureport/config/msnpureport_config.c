/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_config.h"
#include <string.h>
#include "mmpa_api.h"
#include "adcore_api.h"
#include "msnpureport_print.h"
#include "msnpureport_utils.h"

#define MSG_MAX_LEN 1024

static int32_t MsnGetResult(const ArgInfo *argInfo, char *resultBuf, uint32_t bufLen)
{
    size_t valueLen = sizeof(struct MsnReq) + (size_t)argInfo->valueLen;
    size_t sendLen = sizeof(TlvReq) + valueLen;
    TlvReq *req = (TlvReq *)MsnMalloc(sendLen);
    ONE_ACT_ERR_LOG(req == NULL, return EN_ERROR, "malloc TlvReq memory failed, device id:%u", argInfo->deviceId);
    req->type = COMPONENT_MSNPUREPORT;
    req->devId = (int32_t)argInfo->deviceId;
    req->len = (int32_t)valueLen;

    struct MsnReq *msnReq = (struct MsnReq *)req->value;
    msnReq->cmdType = argInfo->cmdType;
    msnReq->subCmd = argInfo->subCmd;
    msnReq->valueLen = argInfo->valueLen;
    if (argInfo->cmdType == CONFIG_SET) {
        errno_t err = memcpy_s(msnReq->value, msnReq->valueLen, argInfo->value, argInfo->valueLen);
        if (err != EOK) {
            SELF_LOG_ERROR("memory copy failed, err: %d", err);
            MsnFree(req);
            return EN_ERROR;
        }
    }
    SELF_LOG_INFO("Device id:%u, MsnReq: cmdType:%d, subCmd:%u, valueLen:%u bytes, value:%.*s",
        argInfo->deviceId, (int32_t)msnReq->cmdType, msnReq->subCmd, msnReq->valueLen, (int32_t)msnReq->valueLen,
        msnReq->value);

    const uint32_t timeout = 30 * 1000; // timeout 30s
    int32_t ret = AdxDevCommShortLink(HDC_SERVICE_TYPE_IDE_FILE_TRANS, req, resultBuf, bufLen, timeout);
    MsnFree(req);
    ONE_ACT_ERR_LOG(ret != IDE_DAEMON_OK, return EN_ERROR,
                    "Get device message failed, device id: %u, ret: %d.", argInfo->deviceId, ret);
    return EN_OK;
}

int32_t MsnConfig(const ArgInfo *argInfo)
{
    ONE_ACT_ERR_LOG(argInfo == NULL, return EN_ERROR, "argInfo is NULL");
    ONE_ACT_ERR_LOG(argInfo->cmdType == INVALID_CMD, return EN_ERROR, "cmdType is INVALID_CMD");

    char resultBuf[MSG_MAX_LEN] = {0};
    int32_t ret = MsnGetResult(argInfo, resultBuf, MSG_MAX_LEN);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    struct ConfigInfo *configInfo = (struct ConfigInfo *)resultBuf;
    SELF_LOG_INFO("configInfo: len:%u bytes, value:%s, devId:%u", configInfo->len, configInfo->value, argInfo->deviceId);
    if ((configInfo->len != strlen(configInfo->value) + 1) && (configInfo->len != 0)) {  // return a string
        SELF_LOG_ERROR("check value length failed, device id:%u.", argInfo->deviceId);
        return EN_ERROR;
    }

    if (configInfo->isError) {
        if (argInfo->cmdType == REPORT) {
            MSNPU_WAR("%s, device id:%u.", configInfo->value, argInfo->deviceId);
        } else {
            MSNPU_PRINT_ERROR("%s, device id:%u.", configInfo->value, argInfo->deviceId);
        }
        return EN_ERROR;
    }

    if (argInfo->cmdType == CONFIG_GET) {
        MsnPrintInfo(argInfo->deviceId, configInfo->value);
    } else {
        MSNPU_PRINT("%s, device id:%u.", configInfo->value, argInfo->deviceId);
    }

    return EN_OK;
}