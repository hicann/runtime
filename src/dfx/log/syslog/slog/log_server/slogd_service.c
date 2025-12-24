/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_service.h"
#include "operate_loglevel.h"
#include "slogd_config_mgr.h"
#include "slogd_applog_core.h"
#include "slogd_communication.h"
#include "slogd_firmware_log.h"
#include "slogd_dev_mgr.h"
#include "slogd_group_log.h"
#include "slogd_syslog.h"
#include "slogd_eventlog.h"
#include "slogd_recv_msg.h"
#include "slogd_flush.h"
#include "log_pm_sig.h"
#include "slogd_recv_core.h"

static int32_t SlogdPreProcessInit(void)
{
    int32_t ret = SlogdReceiveInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init distribute failed, ret=%d.", ret);
    ret = SlogdCommunicationInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init communication failed, ret=%d.", ret);
    return LOG_SUCCESS;
}

STATIC void SlogdLogClassifyExit(void)
{
    SlogdFirmwareLogExit();
    SlogdEventlogExit();
    SlogdSyslogExit();
    SlogdGroupLogExit();
    SlogdApplogExit();
}

static void SlogdPreProcessExit(void)
{
    SlogdCommunicationExit();
    SlogdReceiveExit();
}

STATIC void ReleaseResource(void)
{
    LogRecordSigNo(1);
    SlogdPreProcessExit();
    SlogdFlushExit();
    SlogdLogClassifyExit();
    SlogdLevelExit();
    SlogdConfigMgrExit();
}

STATIC LogStatus SlogdLogClassifyInit(int32_t devId, bool isDocker)
{
    LogStatus ret = SlogdGroupLogInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "group log init failed, ret=%d.", ret);

    ret = SlogdEventlogInit(devId, isDocker);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "event log init failed, ret=%d.", ret);

    ret = SlogdSyslogInit(devId, isDocker);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "sys log init failed, ret=%d.", ret);

    ret = SlogdApplogInit(devId);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "app log init failed, ret=%d.", ret);

    ret = SlogdFirmwareLogInit(devId, isDocker);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "firmware log init failed, ret=%d.", ret);
    return LOG_SUCCESS;
}

LogStatus LogServiceInit(int32_t devId, int32_t level, bool isDocker)
{
    // 1. init all conf items
    SlogdConfigMgrInit();
    SlogdInitDeviceId();

    // 2. init level
    LogStatus ret = SlogdLevelInit(devId, level, isDocker);
    TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, ReleaseResource(),
        return LOG_FAILURE, "init level failed and quit slogd process.");

    if (SlogdIsDevicePooling()) {
        SELF_LOG_INFO("no need to init log service in pooling device.");
        return LOG_SUCCESS;
    }
    // 3. init buffer to record message
    ret = SlogdLogClassifyInit(devId, isDocker);
    TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, ReleaseResource(),
        return LOG_FAILURE, "init log classify failed and quit slogd process.");

    // 4. init flush
    ret = SlogdFlushInit();
    TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, ReleaseResource(),
        return LOG_FAILURE, "init flush failed and quit slogd process.");

    // 5. init preprocess
    ret = SlogdPreProcessInit();
    TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, ReleaseResource(),
        return LOG_FAILURE, "init preprocess failed and quit slogd process.");

    return LOG_SUCCESS;
}

void LogServiceProcess(int32_t devId)
{
    if (SlogdIsDevicePooling()) {
        SELF_LOG_INFO("no need to receive message in pooling device.");
        while (LogGetSigNo() == 0) {
            (void)ToolSleep(TOOL_ONE_THOUSAND); // no need to receive in pooling device.
        }
    } else {
        SELF_LOG_INFO("start to recv message.");
        SlogdMessageRecv(devId);
    }
}

void LogServiceExit(void)
{
    ReleaseResource();
}