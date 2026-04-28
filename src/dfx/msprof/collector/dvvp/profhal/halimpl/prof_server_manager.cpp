/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_server_manager.h"
#include "msprof_dlog.h"

namespace Dvvp {
namespace Hal {
namespace Server {
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
ServerManager::ServerManager()
{}

ServerManager::~ServerManager()
{
    (void)ProfServerFinal();
}

int32_t ServerManager::ProfHelperServerInit(uint32_t devId)
{
    UNUSED(devId);
    MSPROF_LOGI("Prof helper server is deprecated.");
    return PROFILING_SUCCESS;
}

int32_t ServerManager::ProfServerInit(uint32_t moduleType, const ProfHalModuleConfig *moduleConfig,
    uint32_t length)
{
    std::unique_lock<std::mutex> lk(halMtx_);
    int32_t ret = PROFILING_SUCCESS;
    for (uint32_t i = 0; i < moduleConfig->devIdListNums; i++) {
        uint32_t devId = moduleConfig->devIdList[i];
        MSPROF_LOGI("Process ProfStartHostServer of device %u", devId);
        if (devId >= DEFAULT_HOST_ID) {
            continue;
        }
        if (moduleType == PROF_HAL_HELPER) {
            ret = ProfHelperServerInit(devId);
        }
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Device[%u] with module config length %u init server fail", devId, length);
            return ret;
        }
    }
    MSPROF_LOGI("Success to init host hdc server manager");
    return PROFILING_SUCCESS;
}

int32_t ServerManager::ProfServerFinal()
{
    return PROFILING_SUCCESS;
}

void ServerManager::SetFlushModuleCallback(const ProfHalFlushModuleCallback func)
{
    UNUSED(func);
    MSPROF_LOGI("Prof flush callback is deprecated.");
}

void ServerManager::SetSendAicpuDataCallback(const ProfHalSendAicpuDataCallback func)
{
    UNUSED(func);
    MSPROF_LOGI("Prof aicpu callback is deprecated.");
}

void ServerManager::SetHelperDirCallback(const ProfHalHelperDirCallback func)
{
    UNUSED(func);
    MSPROF_LOGI("Prof helper dir callback is deprecated.");
}

void ServerManager::SetSendHelperDataCallback(const ProfHalSendHelperDataCallback func)
{
    UNUSED(func);
    MSPROF_LOGI("Prof helper data callback is deprecated.");
}
}
}
}