/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_main.h"
#include "log_pm_sig.h"
#include "slogd_argv.h"
#include "log_system_api.h"
#include "log_common.h"
#include "log_pm.h"
#include "slogd_service.h"
#include "log_print.h"
#include "slogd_trace_server.h"

STATIC INLINE void SlogdSignalInit(void)
{
    // Set up signal handlers (so that they interrupt read())
    LogSignalRecord(SIGTERM);
    LogSignalRecord(SIGINT);
    LogSignalIgn(SIGHUP);
    LogSignalIgn(SIGPIPE);
}

STATIC LogStatus SlogdServiceInit(int32_t devId, int32_t level, bool isDocker)
{
    // 1. init log service
    LogStatus ret = LogServiceInit(devId, level, isDocker);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init log service failed and quit slogd process.");

    // 2. init signal
    SlogdSignalInit();

    // 3. start process monitor if not in docker
    ret = LogPmStart(SLOGD_MONITOR_FLAG, isDocker);
    TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, LogServiceExit(),
        return LOG_FAILURE, "log monitor start failed and quit slogd process.");
    return LOG_SUCCESS;
}

STATIC void SlogdServiceProcess(int32_t devId)
{
    // 1. log service process
    LogServiceProcess(devId);
}

STATIC void SlogdServiceExit(void)
{
    // 1. process monitor exit
    LogPmStop();

    // 2. log service exit
    LogServiceExit();
}

/*
 * @brief       : main function
 * @param [in]  : int argc          cmdline param
 * @param [in]  : char *argv[]      cmdline param
 * @return      : ==0: sucess; !=0: failures
 */
int32_t MAIN(int32_t argc, char **argv)
{
    SELF_LOG_INFO("slogd process init");
    // 1. init and parse args, -1 denotes pf, 32 to 63 denotes vf
    struct SlogdOptions opt = { 0, 0, -1, false };
    LogStatus ret = SlogdInitArgs(argc, argv, &opt);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);

    // 2. service init
    ret = SlogdServiceInit(opt.v, opt.l, opt.d);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);
    LogTraceServiceInit(opt.v);

    // 3. service process
    ret = LogTraceServiceProcess();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("slogd process init trace service failed, ret = %d", ret);
        LogTraceServiceExit();
        SlogdServiceExit();
        return LOG_FAILURE;
    }

    SELF_LOG_INFO("slogd process start, devId=%d", opt.v);
    SlogdServiceProcess(opt.v);

    // 4. service exit
    // call printself log before free source, or it will write to default path
    SELF_LOG_ERROR("slogd process quit, signal=%d.", LogGetSigNo());
    LogTraceServiceExit();
    SlogdServiceExit();
    
    return LOG_SUCCESS;
}
