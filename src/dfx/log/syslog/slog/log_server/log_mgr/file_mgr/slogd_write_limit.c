/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_write_limit.h"
#include "log_print.h"
#include "log_file_info.h"
#include "slogd_config_mgr.h"

#define TIME_HOUR_TO_SECOND         3600
#define SELF_USE_PREFERRED_PERCENT  80U
#define SELF_USE_PREFERRED_HUNDRED  100U

// debug: 7.377M/h, security: 1.475M/h, run: 3.148M/h
STATIC const uint32_t FLOW_SETTING_INFO[LOG_TYPE_NUM] = {7735345U, 1546650U, 3300917U};

STATIC LogStatus WriteFileLimitGetSpec(int32_t type, uint32_t totalSize, uint32_t currSize, uint32_t *currSpec)
{
    ONE_ACT_WARN_LOG(type >= (int32_t)LOG_TYPE_NUM, return LOG_INVALID_PARAM, "[input] invalid log type %d.", type);
    ONE_ACT_WARN_LOG(currSpec == NULL, return LOG_INVALID_PTR, "[input] current specification is null.");
    uint32_t typeSpec = FLOW_SETTING_INFO[type];
    const uint32_t baseBytes = 102400U;
    uint32_t curr = currSize / baseBytes;
    uint32_t total = totalSize / baseBytes;
    *currSpec = curr * typeSpec / total;
    return LOG_SUCCESS;
}

STATIC INLINE uint32_t WriteFileLimitGetResultSize(uint32_t totalSize)
{
    return totalSize * SELF_USE_PREFERRED_PERCENT / SELF_USE_PREFERRED_HUNDRED;
}

STATIC LogStatus WriteFileLimitCreate(WriteFileLimit *limit, uint32_t currSpec)
{
    ONE_ACT_WARN_LOG(limit == NULL, return LOG_SUCCESS, "[input] write file limit pointer is null.");
    limit->writeSpecification = currSpec;
    limit->sharedConfig.totalSize = (WRITE_LIMIT_PERIOD_NUM - WriteFileLimitGetResultSize(WRITE_LIMIT_PERIOD_NUM)) *
        limit->writeSpecification;
    for (uint32_t i = 0; i < WRITE_LIMIT_PERIOD_NUM; ++i) {
        limit->periodConfig[i].totalSize = WriteFileLimitGetResultSize(limit->writeSpecification);
    }
    int32_t ret = clock_gettime(CLOCK_MONOTONIC, &limit->startTime);
    ONE_ACT_ERR_LOG(ret != EOK, return LOG_FAILURE, "get start time failed, ret: %d", ret);

    return LOG_SUCCESS;
}

LogStatus WriteFileLimitInit(WriteFileLimit **limit, int32_t type, uint32_t totalSize, uint32_t currSize)
{
    if (!SlogdConfigMgrGetWriteFileLimit()) {
        return LOG_SUCCESS;
    }
    ONE_ACT_WARN_LOG(limit == NULL, return LOG_INVALID_PTR, "[input] limit pointer is null.");
    ONE_ACT_WARN_LOG(*limit != NULL, return LOG_INVALID_PARAM, "limit pointer is initialized.");
    *limit = (WriteFileLimit *)LogMalloc(sizeof(WriteFileLimit));
    ONE_ACT_ERR_LOG(*limit == NULL, return LOG_FAILURE, "malloc struct limit failed, strerr=%s.",
        strerror(ToolGetErrorCode()));
    uint32_t spec = 0U;
    LogStatus status = WriteFileLimitGetSpec(type, totalSize, currSize, &spec);
    if (status != LOG_SUCCESS) {
        WriteFileLimitUnInit(limit);
        SELF_LOG_ERROR("get write limit specification failed, ret: %d.", status);
        return status;
    } 
    status = WriteFileLimitCreate(*limit, spec);
    if (status != LOG_SUCCESS) {
        WriteFileLimitUnInit(limit);
        SELF_LOG_ERROR("create write limit failed, ret: %d.", status);
        return status;
    }
    return LOG_SUCCESS;
}

void WriteFileLimitUnInit(WriteFileLimit **limit)
{
    if (!SlogdConfigMgrGetWriteFileLimit()) {
        return;
    }
    ONE_ACT_WARN_LOG(limit == NULL, return, "[input] limit pointer is null.");
    ONE_ACT_NO_LOG(*limit == NULL, return);
    XFREE(*limit);
}

STATIC void WriteFileLimitRefresh(WriteFileLimit *limit, const char *label)
{
    PeriodConfig *periodConfig = &limit->periodConfig[limit->periodIndex];
    if (periodConfig->isLimit) {
        SELF_LOG_INFO("write limit refresh, %s discard logs size: %ubytes this period.", label, periodConfig->dropSize);
    }
    if (limit->periodIndex == WRITE_LIMIT_PERIOD_NUM - 1U) {
        limit->sharedConfig.totalSize = limit->writeSpecification;
        limit->sharedConfig.usedSize = 0U;

        uint32_t indexNum = 0U;
        while (indexNum < WRITE_LIMIT_PERIOD_NUM) {
            limit->periodConfig[indexNum].isLimit = false;
            limit->periodConfig[indexNum].usedSize = 0U;
            limit->periodConfig[indexNum].dropSize = 0U;
            indexNum++;
        }
    } else {
        limit->sharedConfig.totalSize += periodConfig->totalSize - periodConfig->usedSize;
    }
    limit->startTime.tv_sec += TIME_HOUR_TO_SECOND;
    limit->periodIndex = (limit->periodIndex + 1U) % WRITE_LIMIT_PERIOD_NUM;
}

/**
* @brief        : if the current time is in the next period, refresh the limit
* @param [in]   : limit      the write file limit to process
* @return       : true: process the limit success; false: process the limit failed
*/
STATIC bool WriteFileLimitTimeProcess(WriteFileLimit *limit, const char *label)
{
    struct timespec currentTime = { 0, 0 };
    int32_t ret = clock_gettime(CLOCK_MONOTONIC, &currentTime);
    ONE_ACT_ERR_LOG(ret != EOK, return false, "get current time failed, ret: %d.", ret);

    if (currentTime.tv_sec < limit->startTime.tv_sec) {
        SELF_LOG_ERROR("time compare exception, current time: %lds, start time: %lds.",
            currentTime.tv_sec, limit->startTime.tv_sec);
        return false;
    }
    if (currentTime.tv_sec - limit->startTime.tv_sec <= TIME_HOUR_TO_SECOND) {
        return true;
    }

    int64_t jumpPeriod = (currentTime.tv_sec - limit->startTime.tv_sec) / TIME_HOUR_TO_SECOND;
    while (jumpPeriod != 0) {
        WriteFileLimitRefresh(limit, label);
        jumpPeriod--;
    }
    return true;
}

STATIC void WriteFileLimitAddDropSize(uint32_t *dropSize, uint32_t dataLen)
{
    if (*dropSize == UINT32_MAX) {
        return;
    }
    if (UINT32_MAX - *dropSize < dataLen) {
        *dropSize = UINT32_MAX;
        SELF_LOG_WARN("current period dropped log size is over UINT32_MAX");
        return;
    }
    *dropSize += dataLen;
}

/**
* @brief        : decide the current log data is written according to limited state and data length
* @param [in]   : limit       the write file limit to process
* @param [in]   : dataLen     current log data length
* @return       : true: write log pass; false: write log reject
*/
STATIC bool WriteFileLimitSizeProcess(WriteFileLimit *limit, uint32_t dataLen, const char* label)
{
    PeriodConfig *periodConfig = &limit->periodConfig[limit->periodIndex];
    // already limited in this period
    if (periodConfig->isLimit) {
        WriteFileLimitAddDropSize(&periodConfig->dropSize, dataLen);
        return false;
    }
    uint32_t currLeftSize = periodConfig->totalSize - periodConfig->usedSize;
    // use only the current left size
    if (currLeftSize >= dataLen) {
        periodConfig->usedSize += dataLen;
        return true;
    }
    // need to use the shared left size
    currLeftSize += limit->sharedConfig.totalSize - limit->sharedConfig.usedSize;
    if (currLeftSize >= dataLen) {
        uint32_t currUsedSize = dataLen - (periodConfig->totalSize - periodConfig->usedSize);
        limit->sharedConfig.usedSize += currUsedSize;
        periodConfig->usedSize = periodConfig->totalSize;
        return true;
    }
    // the first limited in this period
    WriteFileLimitAddDropSize(&periodConfig->dropSize, dataLen);
    periodConfig->isLimit = true;
    SELF_LOG_INFO("write limit: %s exceeded the upper limit, discard subsequent logs this period.", label);
    return false;
}

/**
* @brief        : check whether current log data writing is limited
* @param [in]   : limit      the write file limit to check
* @param [in]   : dataLen    current log data length
* @return       : true: unlimited, write log pass; false: limited, write log reject
*/
bool WriteFileLimitCheck(WriteFileLimit *limit, uint32_t dataLen, const char* label)
{
    if (!SlogdConfigMgrGetWriteFileLimit() || (limit == NULL)) {
        return true;
    }

    if (!WriteFileLimitTimeProcess(limit, label)) {
        SELF_LOG_ERROR("write limit check time process failed, discard current log data.");
        return false;
    }

    return WriteFileLimitSizeProcess(limit, dataLen, label);
}