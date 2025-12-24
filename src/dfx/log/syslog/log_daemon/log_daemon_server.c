/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_daemon_server.h"
#include "hdclog_device_init.h"
#include "log_file_dump_c.h"
#include "msn_config.h"
#include "hbm_detect.h"
#include "cpu_detect.h"
#include "log_print.h"
#include "adx_component_api_c.h"
#include "file_monitor_core.h"

int32_t LogDaemonServersInit(void)
{
    int32_t ret = ServerMgrInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "server manager init error");
    ret = FileDumpInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "register file dump component error");
    ret = FileMonitorInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "register file monitor component error");
    ret = CpuDetectServerInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "register cpu detect component error");
    ret = ServerCreateEx(COMPONENT_LOG_LEVEL, HdclogDeviceInit, IdeDeviceLogProcess, HdclogDeviceDestroy);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "register log level component error");
    ret = ServerCreateEx(COMPONENT_MSNPUREPORT, MsnCmdInit, MsnCmdProcess, MsnCmdDestory);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "register msnpureport component error");
    ret = ServerCreateEx(COMPONENT_HBM_DETECT, HbmDetectInit, HbmDetectProcess, HbmDetectDestroy);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "register hbm detect component error");
    ret = ServersStart();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "startup component server error");
    return ret;
}

void LogDaemonServersExit(void)
{
    ServerMgrExit();
	FileDumpExit();
    FileMonitorExit();
    CpuDetectServerExit();
}