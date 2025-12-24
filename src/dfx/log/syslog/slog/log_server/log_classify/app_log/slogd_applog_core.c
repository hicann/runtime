/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */


#include "slogd_applog_core.h"
#include "slogd_appnum_watch.h"
#include "slogd_applog_report.h"
#include "slogd_applog_flush.h"
#include "slogd_recv_core.h"
#include "slogd_flush.h"
#include "slogd_config_mgr.h"

STATIC bool SlogdApplogCheckLogType(const LogInfo *info)
{
    return info->processType == APPLICATION;
}

static int32_t SlogdApplogResInit(void)
{
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        // if storage rule is common, need init buffer first
        if (SlogdConfigMgrGetStorageMode(DEBUG_APP_LOG_TYPE + i) != STORAGE_RULE_COMMON) {
            continue;
        }
        uint32_t bufSize = SlogdConfigMgrGetBufSize(DEBUG_APP_LOG_TYPE + i);
        int32_t ret = SlogdBufferInit(DEBUG_APP_LOG_TYPE + i, bufSize, 0, NULL);
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR("init buffer for applog[%d] failed.", i);
            for (int32_t j = 0; j < i; j++) {
                SlogdBufferExit(DEBUG_APP_LOG_TYPE + j, NULL);
            }
            return LOG_FAILURE;
        }
    }
    return LOG_SUCCESS;
}

static void SlogdApplogResExit(void)
{
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        SlogdBufferExit(DEBUG_APP_LOG_TYPE + i, NULL);
    }
}

#ifdef APP_LOG_WATCH

STATIC int32_t SlogdApplogWirte(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    return SlogdFlushToAppBuf(msg, msgLen, info);
}

STATIC int32_t SlogdApplogFlush(void *buffer, uint32_t bufferLen, bool flushFlag)
{
    (void)flushFlag;
    ONE_ACT_ERR_LOG(buffer == NULL, return LOG_FAILURE, "input buffer is NULL.");
    return SlogdApplogFlushToFile(buffer, bufferLen);
}

#elif defined APP_LOG_REPORT
STATIC int32_t SlogdApplogWirte(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    return SlogdAppLogFlushToBufByReport(msg, msgLen, info);
}

STATIC int32_t SlogdApplogFlush(void *buffer, uint32_t bufferLen, bool flushFlag)
{
    (void)buffer;
    (void)bufferLen;
    (void)flushFlag;
    return SlogdAppLogReport();
}

#endif

static int32_t SlogdApplogRegister(void)
{
    int32_t ret = 0;
    LogDistributeNode distributeNode = {APP_LOG_PRIORITY, SlogdApplogCheckLogType, SlogdApplogWirte};
    ret = SlogdDistributeRegister(&distributeNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "app log register distribute node failed, ret=%d.", ret);

    LogFlushNode flushNode = {COMMON_THREAD_TYPE, APP_LOG_PRIORITY, SlogdApplogFlush, NULL};
    ret = SlogdFlushRegister(&flushNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "app log register flush node failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

LogStatus SlogdApplogInit(int32_t devId)
{
    // debug/run/sec等的app子目录的老化线程
    CreateAppLogWatchThread();

    // resource init
    if (SlogdApplogResInit() != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
#ifdef APP_LOG_REPORT
    (void)SlogdAppLogReportInit(devId);
#endif
    (void)devId;
    (void)SlogdApplogFlushInit();

    int32_t ret = SlogdApplogRegister();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdApplogExit(void)
{
    SlogdApplogFlushExit();
#ifdef APP_LOG_REPORT
    (void)SlogdAppLogReportExit();
#endif
    SlogdApplogResExit();
    return;
}