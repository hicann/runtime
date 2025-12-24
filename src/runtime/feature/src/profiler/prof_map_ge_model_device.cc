/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_map_ge_model_device.hpp"

#include "runtime.hpp"
#include "driver.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

ProfMapGeModelDevice &ProfMapGeModelDevice::Instance()
{
    static ProfMapGeModelDevice instance;
    return instance;
}

void ProfMapGeModelDevice::SetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "set drv devId:%u by geModelIdx:%u.", deviceId, geModelIdx);
    const std::unique_lock<std::mutex> lk(mapMutex_);
    (void)modelDeviceMap_.insert(std::pair<uint32_t, uint32_t>(geModelIdx, deviceId));
}

void ProfMapGeModelDevice::UnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "unset drv devId:%u by geModelIdx:%u.", deviceId, geModelIdx);
    const std::unique_lock<std::mutex> lk(mapMutex_);
    (void)modelDeviceMap_.erase(geModelIdx);
}

rtError_t ProfMapGeModelDevice::GetDeviceIdByGeModelIdx(const uint32_t geModelIdx, uint32_t * const deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "get deviceId by geModelIdx:%u.", geModelIdx);
    const std::unique_lock<std::mutex> lk(mapMutex_);
    const auto iter = modelDeviceMap_.find(geModelIdx);
    if (iter != modelDeviceMap_.end()) {
        *deviceId = iter->second;
        RT_LOG(RT_LOG_DEBUG, "get deviceId by geModelIdx:%u, deviceId:%u",
            geModelIdx, *deviceId);
        return RT_ERROR_NONE;
    }
    RT_LOG(RT_LOG_ERROR, "Device of geModelIdx:%u does not exist!", geModelIdx);
    return RT_ERROR_PROF_FIND_FAIL;
}

void ProfMapGeModelDevice::DelAllData()
{
    RT_LOG(RT_LOG_DEBUG, "delete all map info.");
    const std::unique_lock<std::mutex> lk(mapMutex_);
    modelDeviceMap_.clear();
}

}  // namespace runtime
}  // namespace cce
