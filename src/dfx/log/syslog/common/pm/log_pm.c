/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_pm.h"
#include "log_monitor.h"
#include "log_print.h"

/**
 * @brief       : log process monitor start
 * @param [in]  : flagLog         process type
 * @param [in]  : isDocker        is in docker
 * @return      : ==0: sucess; !=0: failures
 */
LogStatus LogPmStart(uint32_t flagLog, bool isDocker)
{
    int32_t ret = RegisterSRNotifyCallback();
    if (ret != 0) {
        SELF_LOG_ERROR("RegisterSRNotifyCallback failed");
        return LOG_FAILURE;
    }
    if ((isDocker == false) && (LogMonitorStart(flagLog) != LOG_SUCCESS)) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : log process monitor stop
 * @return      : NA
 */
void LogPmStop(void)
{
    LogMonitorStop();
}

/**
 * @brief       : log process monitor get system status
 * @return      : system state
 */
enum SystemState LogPmGetSystemStatus(void)
{
    return GetSystemState();
}

LogStatus LogSetDaemonize(void)
{
    int32_t noChdir = 0;
    int32_t noClose = 1;
    if (daemon(noChdir, noClose) < 0) {
        SELF_LOG_ERROR("create daemon failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}