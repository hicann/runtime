/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <utility>
#include "tprt.hpp"
#include "tprt_error_code.h"
#include "tprt_base.hpp"
namespace cce {
namespace tprt {
TprtManage *TprtManage::tprt_ = nullptr;
TprtManage::TprtManage()
{
}

TprtManage::~TprtManage()
{
    TPRT_LOG(TPRT_LOG_EVENT, "~TprtManage");
    for (auto it = deviceMap_.begin(); it != deviceMap_.end();) {
        uint32_t devId = it->first;
        it++;
        (void)TprtDeviceClose(devId);
    }
}

void TprtManage::TprtInitCfg(const TprtCfgInfo_t *cfg)
{
    sqcqMaxNum_ = cfg->sqcqMaxNum;
    sqcqMaxDepth_ = cfg->sqcqMaxDepth;
    timeoutMonitorUint_ = cfg->timeoutMonitorUint;  // unit:ms
    defaultExeTimeout_ = cfg->defaultExeTimeout;  // unit:ms
}

uint32_t TprtManage::TprtDeviceOpen(const uint32_t devId, const TprtCfgInfo_t *cfg)
{
    std::unique_lock<std::mutex> tprtDeviceMapLock(deviceIdToDeviceMapLock_);
    if (deviceMap_.empty()) {
        TprtInitCfg(cfg);
    }

    auto devInfo = deviceMap_.find(devId);
    if (devInfo == deviceMap_.end()) {
        TprtDevice *device = new TprtDevice(devId);
        if (device == nullptr) {
            TPRT_LOG(TPRT_LOG_ERROR, "TprtDeviceOpen failed, device_id=%u.", devId);
            return TPRT_DEVICE_NEW_FAILED;
        }
        deviceMap_.insert(std::make_pair(devId, device));
    } else {
        TPRT_LOG(TPRT_LOG_ERROR, "Device already exists, device_id=%u.", devId);
        return TPRT_DEVICE_INVALID;
    }
    return TPRT_SUCCESS;
}

uint32_t TprtManage::TprtDeviceClose(const uint32_t devId)
{
    TprtDevice *device = GetDeviceByDevId(devId);
    if (device == nullptr) {
        TPRT_LOG(TPRT_LOG_WARNING, "device does not exist, devId=%u.", devId);
        return TPRT_DEVICE_INVALID;
    }
    uint32_t error = device->TprtDeviceStop();
    if (error == TPRT_SUCCESS) {
        TprtDeleteDeviceByDevId(devId);
        DELETE_O(device);
    }
    return error;
}

TprtDevice *TprtManage::GetDeviceByDevId(const uint32_t devId)
{
    std::unique_lock<std::mutex> tprtDeviceMapLock(deviceIdToDeviceMapLock_);
    auto devInfo = deviceMap_.find(devId);
    if (devInfo == deviceMap_.end()) {
        TPRT_LOG(TPRT_LOG_ERROR, "device does not exist, devId=%u.", devId);
        return nullptr;
    }
    return devInfo->second;
}

void TprtManage::TprtDeleteDeviceByDevId(const uint32_t devId)
{
    std::unique_lock<std::mutex> tprtDeviceMapLock(deviceIdToDeviceMapLock_);
    auto devInfo = deviceMap_.find(devId);
    if (devInfo != deviceMap_.end()) {
        deviceMap_.erase(devInfo);
    } else {
        TPRT_LOG(TPRT_LOG_ERROR, "device does not exist, devId=%u", devId);
    }
}

bool TprtManage::IsQueueFull(const uint16_t head, const uint16_t tail, const uint32_t allocNum) const
{
    const uint32_t queueTailIdx = (tail + allocNum) % sqcqMaxDepth_;
    if (((tail < head) && ((tail + 1U) >= head)) ||
        ((tail > head) && ((tail + 1U) >= sqcqMaxDepth_) && (queueTailIdx >= head))) {
        return true;
    }
    return false;
}

}  // namespace runtime
}  // namespace cce