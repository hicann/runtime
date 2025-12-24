/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msn_operate_log_level.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "ascend_hal.h"
#include "mmpa_api.h"
#include "adcore_api.h"
#include "log_platform.h"
#include "log_system_api.h"
#include "msnpureport_print.h"
#include "msnpureport_common.h"

#define MAX_ERRSTR_LEN               128
#define MSG_MAX_LEN                  1024
#define COMPUTE_POWER_GROUP_FLAG     26
#define DEVICE_LEVEL_SETTING_SUCCESS "set device_%d level success."
#define LEVEL_SETTING_SUCCESS        "++OK++"
#define LEVEL_GETTING_SUCCESS        "[global]"
#define COMPUTE_POWER_GROUP          "multiple hosts use one device, prohibit operating log level"

typedef void*   MsnMemHandle;

#define XFREE(ptr) do {                                   \
    if ((ptr) != NULL) {                                  \
        free(ptr);                                        \
    }                                                     \
    (ptr) = NULL;                                         \
} while (0)

/**
 * @brief       : malloc specify size space and clear
 * @param [in]  : size          space size
 * @return      : NON-NULL_PTR succeed; NULL_PTR failed
 */
STATIC MsnMemHandle MsnXmalloc(size_t size)
{
    int32_t err;

    if (size == 0) {
        return NULL;
    }

    MsnMemHandle val = malloc(size);
    if (val == NULL) {
        MSNPU_ERR("ran out of memory while trying to allocate %zu bytes", size);
        return NULL;
    }

    err = memset_s(val, size, 0, size);
    if (err != EOK) {
        MSNPU_ERR("memory clear failed, err: %d", err);
        XFREE(val);
        return NULL;
    }

    return val;
}

/**
 * @brief       : set or get device level
 * @param [in]  : client          hdc client
 * @param [in]  : req             request info from client
 * @param [in]  : logLevelResult  log level result
 * @param [in]  : logOperatonType log operaton type
 * @return      : EN_OK: succeed; others: failed
 */
STATIC int32_t MsnOperateDeviceLevel(const struct tlv_req *req, char *logLevelResult, \
                                     int32_t logLevelResultLength, int32_t logOperatonType)
{
    char *resultBuf = (char *)MsnXmalloc(MSG_MAX_LEN);
    if (resultBuf == NULL) {
        char errBuf[MAX_ERRSTR_LEN + 1];
        memset_s(errBuf, sizeof(errBuf), 0, sizeof(errBuf));
        MSNPU_ERR("Malloc failed, strerr=%s.", mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
        return EN_ERROR;
    }
    int32_t err = AdxSendMsgAndGetResultByType(HDC_SERVICE_TYPE_IDE_FILE_TRANS, req, resultBuf, MSG_MAX_LEN);
    if (err == EN_ERROR) {
        MSNPU_ERR("Receive device level operation result failed, ret=%d.", err);
    } else if (strcmp(COMPUTE_POWER_GROUP, resultBuf) == 0) {
        err = COMPUTE_POWER_GROUP_FLAG;
    } else {
        int32_t strcpyRes = strncpy_s(logLevelResult, (size_t)logLevelResultLength, resultBuf, MSG_MAX_LEN);
        if (strcpyRes != EOK) {
            err = EN_ERROR;
            char errBuf[MAX_ERRSTR_LEN + 1];
            memset_s(errBuf, sizeof(errBuf), 0, sizeof(errBuf));
            MSNPU_ERR("Strncpy_s device level result failed, result=%d, strerr=%s.",
                strcpyRes, mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
        } else {
            int32_t strcmpRes = 0;
            if (logOperatonType == (int32_t)CONFIG_GET) {
                strcmpRes = strncmp(LEVEL_GETTING_SUCCESS, resultBuf, strlen(LEVEL_GETTING_SUCCESS));
            } else {
                strcmpRes = strcmp(LEVEL_SETTING_SUCCESS, resultBuf);
            }
            (strcmpRes == 0) ? (err = EN_OK) : (err = EN_ERROR);
        }
    }

    // recycle resource
    XFREE(resultBuf);
    return err;
}

/**
 * @brief       : Create a data frame to send tlv
 * @param [in]  : dev_id        device id
 * @param [in]  : value         the value to send
 * @param [in]  : value_len     the length of value
 * @param [in]  : buf           the data frame to send tlv
 * @param [in]  : buf_len       the data length of frame
 * @return      : EN_OK succ;   EN_ERROR failed
 */
STATIC int32_t MsnCreatePacket(int32_t devId, const char *value, uint32_t valueLen, void **buf, uint32_t *bufLen)
{
    if (value == NULL || buf == NULL || bufLen == NULL) {
        MSNPU_ERR("input invalid parameter");
        return EN_ERROR;
    }

    if (valueLen + sizeof(struct tlv_req) + 1 > INT32_MAX) {
        MSNPU_ERR("bigger than INT32_MAX, value_len: %u, tlv_len: %lu", valueLen, sizeof(struct tlv_req));
        return EN_ERROR;
    }

    uint32_t mallocValueLen = valueLen + 1;
    uint32_t sendLen = sizeof(struct tlv_req) + mallocValueLen;
    char *sendBuf = (char *)MsnXmalloc(sendLen);
    if (sendBuf == NULL) {
        MSNPU_ERR("malloc memory failed");
        return EN_ERROR;
    }
    IdeTlvReq req = (IdeTlvReq)sendBuf;
    req->type = IDE_LOG_LEVEL_REQ;
    req->dev_id = devId;
    req->len = (int32_t)valueLen;
    int32_t err = memcpy_s(req->value, mallocValueLen, value, valueLen);
    if (err != EOK) {
        MSNPU_ERR("memory copy failed, err: %d", err);
        XFREE(req);
        return EN_ERROR;
    }

    *buf = (MsnMemHandle)sendBuf;
    *bufLen = sizeof(struct tlv_req) + valueLen;

    return EN_OK;
}

/**
 * @brief       : set or get device log level
 * @param [in]  : devId           device id
 * @param [in]  : logLevel        device log level(debug/info/warning/error/null etc.)
 * @param [in]  : logLevelResult  log level result
 * @param [in]  : logOperatonType log operation type(set or get log level)
 * @return      : EN_OK success;  other failed
 */
int32_t MsnOperateDeviceLogLevel(uint16_t devId, const char *logLevel, char *logLevelResult,
                                 int32_t logLevelResultLength, int32_t logOperatonType)
{
    int32_t err = EN_ERROR;
    if (logLevel == NULL) {
        MSNPU_ERR("Set device log level input parameter invalied");
        return err;
    }

    uint32_t sendLen = 0;
    void *reqBuf = NULL;
    err = MsnCreatePacket(devId, logLevel, (uint32_t)strlen(logLevel), &reqBuf, &sendLen);
    if (err != EN_OK) {
        MSNPU_ERR("Create Packet failed, err: %d", err);
        XFREE(reqBuf);
        return EN_ERROR;
    }

    struct tlv_req *req = (struct tlv_req *)reqBuf;
    err = MsnOperateDeviceLevel(req, logLevelResult, logLevelResultLength, logOperatonType);
    if (err != EN_OK) {
        if (err == COMPUTE_POWER_GROUP_FLAG) {
            MSNPU_WAR("Multiple hosts use one device, prohibit operating log level");
        } else {
            MSNPU_ERR("%s device log level exception! device id = %u.",
                logOperatonType == (int32_t)CONFIG_GET ? "Get" : "Set", devId);
        }
        XFREE(reqBuf);
        return EN_ERROR;
    }

    XFREE(reqBuf);
    return EN_OK;
}
