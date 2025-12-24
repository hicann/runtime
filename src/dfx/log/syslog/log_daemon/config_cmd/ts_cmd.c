/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ts_cmd.h"
#include "securec.h"
#include "ascend_hal.h"
#include "driver_api.h"
#include "log_print.h"
#include "task_scheduler_error.h"

#define CONFIG_ITEM_NUM     5U
#define CONFIG_INFO_BUF_LEN 64U

#define DRV_NOT_READY              "Driver api wait timeout"
#define DRV_ERROR                  "Set config failed, check slogdlog for more information"
#define TS_NOT_SUPPORT             "This chip platform does not support"
#define TS_CORE_ID_INVALID         "The specified core id is invalid"
#define TS_CORE_ID_PF_DOWN         "The specified core is pg down core and does not support the operation"
#define TS_NOT_SUPPORT_CORE        "This chip platform not support core mask"
#define TS_NOT_SUPPORT_AIV_CORE    "This chip platform not support aiv core"
#define TS_CORE_NOT_IN_POOL        "The specified core maybe not in pool"
#define TS_POOLING_STATUS_FAIL     "The specified core need pooling status"

// Synchronize with TS
enum CmdKey {
    LOG_CMD_SET_LOG_LEVEL = 0,
    LOG_CMD_SET_ICACHE_OFFSET,
    LOG_CMD_SET_RECOVER_ACC,
    LOG_CMD_SET_COREID_AIC_SWITCH,
    LOG_CMD_SET_COREID_AIV_SWITCH,
    LOG_CMD_SET_SINGLE_COMMIT,
    LOG_CMD_SET_RESERVED,
};

static const char *g_tsErrorMsgMap[] = {
    [TS_ERROR_FEATURE_NOT_SUPPORT] = TS_NOT_SUPPORT,
    [TS_LOG_DEAMON_RESET_ACC_SWITCH_INVALID] = DRV_ERROR,
    [TS_LOG_DEAMON_CORE_SWITCH_INVALID] = DRV_ERROR,
    [TS_LOG_DEAMON_CORE_ID_INVALID] = TS_CORE_ID_INVALID,
    [TS_LOG_DEAMON_NO_VALID_CORE_ID] = TS_CORE_ID_INVALID,
    [TS_LOG_DEAMON_CORE_ID_PG_DOWN] = TS_CORE_ID_PF_DOWN,
    [TS_LOG_DEAMON_NOT_SUPPORT_CORE_MASK] = TS_NOT_SUPPORT_CORE,
    [TS_LOG_DEAMON_SINGLE_COMMIT_INVALID] = DRV_ERROR,
    [TS_LOG_DEAMON_NOT_SUPPORT_AIV_CORE_MASK] = TS_NOT_SUPPORT_AIV_CORE,
    [TS_LOG_DEAMON_NOT_IN_POOL] = TS_CORE_NOT_IN_POOL,
    [TS_LOG_DEAMON_CORE_POOLING_STATUS_FAIL] = TS_POOLING_STATUS_FAIL,
};

static const uint32_t CMD_MAP_TO_KEY[INVALID_TYPE] = {
    [ICACHE_RANGE] = LOG_CMD_SET_ICACHE_OFFSET,
    [ACCELERATOR_RECOVER] = LOG_CMD_SET_RECOVER_ACC,
    [AIC_SWITCH] = LOG_CMD_SET_COREID_AIC_SWITCH,
    [AIV_SWITCH] = LOG_CMD_SET_COREID_AIV_SWITCH,
    [SINGLE_COMMIT] = LOG_CMD_SET_SINGLE_COMMIT
};

static const char *g_cmdMapToStr[LOG_CMD_SET_RESERVED] = {
    [LOG_CMD_SET_ICACHE_OFFSET] = "icache check range",
    [LOG_CMD_SET_RECOVER_ACC] = "accelerator recover switch",
    [LOG_CMD_SET_COREID_AIC_SWITCH] = "aic core switch",
    [LOG_CMD_SET_COREID_AIV_SWITCH] = "aiv core switch",
    [LOG_CMD_SET_SINGLE_COMMIT] = "single commit mode",
};

#ifdef CONFIG_EXPAND

#define TS_CHANNEL LOG_CHANNEL_TYPE_TS_PROC

// define by TS
typedef struct {
    uint32_t bitmap0;
    uint32_t bitmap1;
    uint32_t bitmap2;
    uint32_t bitmap3;
    uint8_t resv[4];
} DfxCoreGetMask;

// define by TS
typedef struct {
    uint32_t key;           // log dfx sub_cmd
    ts_error_t retVal;      // 出参，ts返回给工具的返回值
    union {                 // 20 bytes
        DfxCoreGetMask  getMask;
        DfxCoreSetMask  setMask;
        DfxCommon       common;
    };
} LogCmdInfo;

static int32_t HandleGetValue(char *value, uint32_t valueLen, const LogCmdInfo *cmdInfo)
{
    ONE_ACT_ERR_LOG(cmdInfo->retVal != TS_SUCCESS, return CONFIG_ERROR,
        "get value of key %u failed, TS return:%d", cmdInfo->key, cmdInfo->retVal);
    int32_t ret = 0;
    const char *resultStrMap[] = {[0] = "Disable", [1] = "Enable"};
    switch (cmdInfo->key) {
        case LOG_CMD_SET_ICACHE_OFFSET:
            ret = sprintf_s(value, valueLen, "Icache check Range:%u,", cmdInfo->common.value);
            break;
        case LOG_CMD_SET_RECOVER_ACC:
            ONE_ACT_ERR_LOG((cmdInfo->common.value != 0) && (cmdInfo->common.value != 1), return CONFIG_ERROR,
                "get accelerator recover mode invalid, value:%u", cmdInfo->common.value);
            ret = sprintf_s(value, valueLen, "Accelerator Recover:%s,", resultStrMap[cmdInfo->common.value]);
            break;
        case LOG_CMD_SET_COREID_AIC_SWITCH:
            ret = sprintf_s(value, valueLen, "Aic Coremask:0x%x%x%x%x,", cmdInfo->getMask.bitmap3,
                cmdInfo->getMask.bitmap2, cmdInfo->getMask.bitmap1, cmdInfo->getMask.bitmap0);
            break;
        case LOG_CMD_SET_COREID_AIV_SWITCH:
            ret = sprintf_s(value, valueLen, "Aiv Coremask:0x%x%x%x%x,", cmdInfo->getMask.bitmap3,
                cmdInfo->getMask.bitmap2, cmdInfo->getMask.bitmap1, cmdInfo->getMask.bitmap0);
            break;
        case LOG_CMD_SET_SINGLE_COMMIT:
            ONE_ACT_ERR_LOG((cmdInfo->common.value != 0) && (cmdInfo->common.value != 1), return CONFIG_ERROR,
                "get single commit mode invalid, value:%u", cmdInfo->common.value);
            ret = sprintf_s(value, valueLen, "Aic Singlecommit:%s,", resultStrMap[cmdInfo->common.value]);
            break;
        default:
            SELF_LOG_ERROR("invalid cmd %u", cmdInfo->key);
            return CONFIG_ERROR;    // clean code
    }
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s for cmd %u failed, strerr:%s", cmdInfo->key, strerror(errno));
        return CONFIG_ERROR;
    }
    return CONFIG_OK;
}

static int32_t HandleSetValue(const struct MsnReq *req, LogCmdInfo *cmdInfo)
{
    switch (req->subCmd) {
        case ICACHE_RANGE:
        case ACCELERATOR_RECOVER:
        case SINGLE_COMMIT:
            cmdInfo->common = *(DfxCommon*)req->value;
            SELF_LOG_INFO("set cmd:%u, value:%u", req->subCmd, cmdInfo->common.value);
            break;
        case AIC_SWITCH:
        case AIV_SWITCH:
            cmdInfo->setMask = *(DfxCoreSetMask*)req->value;
            SELF_LOG_INFO("set core mask, cmd:%u, coreSwitch:%hhu, num:%hhu, core id:%hhu, %hhu, %hhu, %hhu",
                req->subCmd, cmdInfo->setMask.coreSwitch, cmdInfo->setMask.configNum,
                cmdInfo->setMask.coreId[CORE_ID0], cmdInfo->setMask.coreId[CORE_ID1],
                cmdInfo->setMask.coreId[CORE_ID2], cmdInfo->setMask.coreId[CORE_ID3]);
            break;
        default:
            break;
    }
    return CONFIG_OK;
}

#else // OBP

#define TS_CHANNEL LOG_CHANNEL_TYPE_TS

#pragma pack(1)
typedef struct {
    uint32_t key;
    uint64_t value;
} LogCmdInfo;
#pragma pack()

union CoreMask {
    struct {
        uint8_t coreId[CORE_ID_MAX];
        uint8_t reserve[3];
        uint8_t operation;
    };
    uint64_t value;
};

static int32_t HandleGetValue(char *value, uint32_t valueLen, const LogCmdInfo *cmdInfo)
{
    int32_t ret = 0;
    const char *resultStrMap[] = {[0] = "Disable", [1] = "Enable"};
    switch (cmdInfo->key) {
        case LOG_CMD_SET_ICACHE_OFFSET:
            ret = sprintf_s(value, valueLen, "Icache check Range:%lu,", cmdInfo->value);
            break;
        case LOG_CMD_SET_RECOVER_ACC:
            ONE_ACT_ERR_LOG((cmdInfo->value != 0) && (cmdInfo->value != 1), return CONFIG_ERROR,
                "get accelerator recover mode invalid, value:%lu", cmdInfo->value);
            ret = sprintf_s(value, valueLen, "Accelerator Recover:%s,", resultStrMap[cmdInfo->value]);
            break;
        case LOG_CMD_SET_COREID_AIC_SWITCH:
            ret = sprintf_s(value, valueLen, "Aic Coremask:0x%lx,", cmdInfo->value);
            break;
        case LOG_CMD_SET_COREID_AIV_SWITCH:
            ret = sprintf_s(value, valueLen, "Aiv Coremask:0x%lx,", cmdInfo->value);
            break;
        case LOG_CMD_SET_SINGLE_COMMIT:
            ONE_ACT_ERR_LOG((cmdInfo->value != 0) && (cmdInfo->value != 1), return CONFIG_ERROR,
                "get single commit mode invalid, value:%lu", cmdInfo->value);
            ret = sprintf_s(value, valueLen, "Aic Singlecommit:%s,", resultStrMap[cmdInfo->value]);
            break;
        default:
            SELF_LOG_ERROR("invalid cmd %u", cmdInfo->key);
            return CONFIG_ERROR;    // clean code
    }
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s for cmd %u failed, strerr:%s", cmdInfo->key, strerror(errno));
        return CONFIG_ERROR;
    }
    return CONFIG_OK;
}

static int32_t HandleSetValue(const struct MsnReq *req, LogCmdInfo *cmdInfo)
{
    switch (req->subCmd) {
        case ICACHE_RANGE: {
            const DfxCommon* common = (const DfxCommon*)req->value;
            if (common->value > MAX_ICACHE_CHECK_RANGE) {
                SELF_LOG_ERROR("key %u value check failed, value:%u", cmdInfo->key, common->value);
                return CONFIG_INVALID_PARAM;
            }
            cmdInfo->value = common->value;
            break;
        }
        case ACCELERATOR_RECOVER:
        case SINGLE_COMMIT:{
            const DfxCommon* common = (const DfxCommon*)req->value;
            if (common->value != 0 && common->value != 1) {
                SELF_LOG_ERROR("key %u value check failed, value:%u", cmdInfo->key, common->value);
                return CONFIG_INVALID_PARAM;
            }
            cmdInfo->value = common->value;
            break;
        }
        case AIC_SWITCH:
        case AIV_SWITCH: {
            const DfxCoreSetMask *setMask = (const DfxCoreSetMask*)req->value;
            union CoreMask coreMask = {.coreId={[0 ... 3]=0xFF}, .reserve={0}, .operation=0};
            if (setMask->coreSwitch == RESTORE_CORE) {
                coreMask = (union CoreMask){.coreId={0}, .reserve={0}, .operation=1};
            } else {
                coreMask.operation = setMask->coreSwitch;
                for (int32_t i = 0; i < setMask->configNum; ++i) {
                    coreMask.coreId[i] = setMask->coreId[i];
                }
            }
            cmdInfo->value = coreMask.value;
        }
        default:
            break;
    }

    return CONFIG_OK;
}
#endif

/**
 * @brief: cat value to result buffer
 * @param [in] resultBuf: result buffer
 * @param [in] bufLen: result buffer length
 * @param [in] value: result string pointer
 * @return: CONFIG_OK: succeed; others: failed
 */
STATIC int32_t SaveToResult(char *resultBuf, uint32_t bufLen, const char *value)
{
    if (strlen(resultBuf) + strlen(value) + 1 > bufLen) {
        SELF_LOG_ERROR("resultBuf not enough");
        return CONFIG_BUFFER_NOT_ENOUGH;
    }
    int32_t ret = strcat_s(resultBuf, bufLen, value);
    if (ret != EOK) {
        SELF_LOG_ERROR("strcat_s failed, ret:%d", ret);
        return CONFIG_MEM_WRITE_FAILED;
    }
    return CONFIG_OK;
}

void TsCmdGetConfig(char *resultBuf, uint32_t bufLen, uint16_t devId)
{
    LogCmdInfo cmdInfo = {0};
    int32_t ret = 0;
    for (uint32_t i = LOG_CMD_SET_ICACHE_OFFSET; i < LOG_CMD_SET_RESERVED; ++i) {
        cmdInfo.key = i;
        ret = LogGetDfxParam(devId, TS_CHANNEL, (void*)&cmdInfo, sizeof(cmdInfo));
        ONE_ACT_ERR_LOG(ret != LOG_OK, continue, "get failed of key %u failed, driver return:%d", i, ret);

        char value[CONFIG_INFO_BUF_LEN] = {0};
        ret = HandleGetValue(value, CONFIG_INFO_BUF_LEN, &cmdInfo);
        if (ret != CONFIG_OK) {
            continue;
        }

        ret = SaveToResult(resultBuf, bufLen, value);
        if (ret == CONFIG_BUFFER_NOT_ENOUGH) {
            break;
        }
    }
}

STATIC void HandleErrorCode(int32_t drvRet, ts_error_t tsRet, const char **result)
{
    switch (drvRet) {
        case LOG_OK:
            if (tsRet == TS_SUCCESS) {
                break;
            } else if ((tsRet >= TS_ERROR_FEATURE_NOT_SUPPORT) &&
                       (tsRet <= TS_LOG_DEAMON_CORE_POOLING_STATUS_FAIL)) {
                *result = g_tsErrorMsgMap[tsRet];
            } else {
                *result = DRV_ERROR;
            }
            SELF_LOG_ERROR("set config failed, tsRet:%d", (int32_t)tsRet);
            break;
        case LOG_ERROR:
            *result = DRV_ERROR;
            break;
        case LOG_NOT_READY:
            *result = DRV_NOT_READY;
            break;
        case LOG_NOT_SUPPORT:
            *result = TS_NOT_SUPPORT;
            break;
        default:
            *result = DRV_ERROR;
            SELF_LOG_ERROR("set config failed, driver ret:%d", drvRet);
            break;
    }
}

int32_t TsCmdSetConfig(const struct MsnReq *req, uint16_t devId, char *resultBuf, uint32_t bufLen)
{
    ONE_ACT_ERR_LOG(req == NULL, return CONFIG_INVALID_PARAM, "req is NULL");
    ONE_ACT_ERR_LOG(req->valueLen != sizeof(DfxCommon), return CONFIG_INVALID_PARAM,
        "valueLen:%u check failed, expect:%zu.", req->valueLen, sizeof(DfxCommon));
    ONE_ACT_ERR_LOG(resultBuf == NULL, return CONFIG_INVALID_PARAM, "resultBuf is NULL");

    LogCmdInfo cmdInfo = {0};
    cmdInfo.key = CMD_MAP_TO_KEY[req->subCmd];
    int32_t ret = HandleSetValue(req, &cmdInfo);
    if (ret != CONFIG_OK) {
        return ret;
    }
    ret = LogSetDfxParam(devId, TS_CHANNEL, (void*)&cmdInfo, sizeof(cmdInfo));

#ifdef CONFIG_EXPAND
    int32_t drvRet = ret;
    ts_error_t tsRet = cmdInfo.retVal;
#else   // OBP
    int32_t drvRet = ret > DRV_ERROR_RESERVED ? LOG_OK : ret;
    ts_error_t tsRet = ret > (int32_t)DRV_ERROR_RESERVED ?
        (ts_error_t)(ret - (int32_t)DRV_ERROR_RESERVED) : TS_SUCCESS;
#endif
    const char *result = SET_SUCCESS_MSG;
    HandleErrorCode(drvRet, tsRet, &result);
    if (strcmp(result, TS_NOT_SUPPORT) == 0) {
        (void)sprintf_s(resultBuf, bufLen, "%s set %s", result, g_cmdMapToStr[req->subCmd]);
    } else {
        (void)strcpy_s(resultBuf, bufLen, result);
    }

    return ret;
}