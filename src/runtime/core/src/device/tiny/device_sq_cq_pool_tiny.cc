/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_sq_cq_pool.hpp"

namespace cce {
namespace runtime {

DeviceSqCqPool::DeviceSqCqPool(Device* const dev) : NoCopy(), device_(dev) {}

DeviceSqCqPool::~DeviceSqCqPool() = default;

rtError_t DeviceSqCqPool::Init(void) const { return RT_ERROR_NONE; }

rtError_t DeviceSqCqPool::AllocSqCqFromDrv(
    rtDeviceSqCqInfo_t* const sqCqInfo, const uint32_t drvFlag, const int32_t retryCount) const
{
    UNUSED(sqCqInfo);
    UNUSED(drvFlag);
    UNUSED(retryCount);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t DeviceSqCqPool::SetSqRegVirtualAddrToDevice(const uint32_t sqId, const uint64_t sqRegVirtualAddr) const
{
    UNUSED(sqId);
    UNUSED(sqRegVirtualAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t DeviceSqCqPool::AllocSqRegVirtualAddr(const uint32_t sqId, uint64_t& sqRegVirtualAddr) const
{
    UNUSED(sqId);
    UNUSED(sqRegVirtualAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t DeviceSqCqPool::FreeSqCqToDrv(const uint32_t sqId, const uint32_t cqId) const
{
    UNUSED(sqId);
    UNUSED(cqId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t DeviceSqCqPool::BatchAllocSqCq(const uint32_t allcocNum, const int32_t retryCount)
{
    UNUSED(allcocNum);
    UNUSED(retryCount);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void DeviceSqCqPool::PreAllocSqCq(void) {}

rtError_t DeviceSqCqPool::AllocSqCqForAutoSplit(rtDeviceSqCqInfo_t* const sqCqInfo) const
{
    UNUSED(sqCqInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

uint32_t DeviceSqCqPool::GetSqCqPoolFreeResNum(void) { return 0U; }

rtError_t DeviceSqCqPool::TryFreeSqCqToDrv(void) { return RT_ERROR_NONE; }

void DeviceSqCqPool::FreeOccupyList(void) {}

void DeviceSqCqPool::FreeReallocatedSqCqToDrv(
    const std::list<rtDeviceSqCqInfo_t>::iterator begin, const std::list<rtDeviceSqCqInfo_t>::iterator end) const
{
    UNUSED(begin);
    UNUSED(end);
}

rtError_t DeviceSqCqPool::ReAllocSqCqForFreeList(void) { return RT_ERROR_NONE; }

rtError_t DeviceSqCqPool::AllocSqCq(const uint32_t allcocNum, rtDeviceSqCqInfo_t* const sqCqList)
{
    UNUSED(allcocNum);
    UNUSED(sqCqList);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t DeviceSqCqPool::FreeSqCq(
    const rtDeviceSqCqInfo_t* const sqCqInfo, const uint32_t freeNum, const FreePolicy policy)
{
    UNUSED(sqCqInfo);
    UNUSED(freeNum);
    UNUSED(policy);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

uint32_t DeviceSqCqPool::GetSqCqPoolTotalResNum(void) { return 0U; }

} // namespace runtime
} // namespace cce
