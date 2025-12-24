/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include "tsd/tsd_client.h"
#include <unistd.h>
#include "ascend_hal.h"
#include "ai_drv_dev_api.h"
#include "adprof_collector.h"
#include "prof_dev_api.h"

namespace {
    uint32_t devId;
    pid_t pid = 12345;
}

uint32_t TsdProcessOpen(const uint32_t logicDeviceId, ProcOpenArgs *openArgs)
{
    if (openArgs->procType != TSD_SUB_PROC_ADPROF) {
        return 1;
    }
    devId = logicDeviceId;
    int argc = openArgs->extParamCnt + 1;
    const char* argv[argc];
    argv[0] = "adprof";
    for (int i = 0; i < openArgs->extParamCnt; i++) {
        argv[i + 1] = openArgs->extParamList[i].paramInfo;
    }
    AdprofStart(argc, argv);
    openArgs->subPid = &pid;
    return tsd::TSD_OK;
}

uint32_t ProcessCloseSubProcList(const uint32_t logicDeviceId, const ProcStatusParam *closeList,
                                 const uint32_t listSize)
{
    if (logicDeviceId != devId || closeList->pid != pid) {
        return 1;
    }
    AdprofStop();
    return tsd::TSD_OK;
}

uint32_t TsdGetProcListStatus(const uint32_t logicDeviceId, ProcStatusParam *pidInfo, const uint32_t arrayLen)
{
    if (logicDeviceId != devId || pidInfo->pid != pid) {
        return 1;
    }
    pidInfo->curStat = SUB_PROCESS_STATUS_NORMAL;
    return tsd::TSD_OK;
}

uint32_t TsdCapabilityGet(const uint32_t logicDeviceId, const int32_t type, const uint64_t ptr)
{
    uint64_t *supportLevel = (uint64_t *)(ptr);
    constexpr uint32_t TSD_SUPPORT_ADPROF_BIT = 3U;
    *supportLevel = 1U << TSD_SUPPORT_ADPROF_BIT;
    return tsd::TSD_OK;
}