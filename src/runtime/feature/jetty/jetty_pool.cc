/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "jetty_pool.h"
#include "runtime.hpp"
#include "npu_driver.hpp"
#include "common/internal_error_define.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

JettyPool::JettyPool(uint32_t deviceId) : deviceId_(deviceId)
{
    h2dJettyPool_.reserve(JETTY_POOL_H2D_MAX_SIZE);
    d2dJettyPool_.reserve(JETTY_POOL_D2D_MAX_SIZE);
    RT_LOG(RT_LOG_INFO, "Jetty pool created, device_id=%u.", deviceId_);
}

JettyPool::~JettyPool()
{
    Clear();
}

rtError_t JettyPool::CreateJetty(JettyType type, uint32_t depth, JettyInfo &jettyInfo) const
{
    Driver* const driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    if (driver == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    uint32_t dir = (type == JettyType::JETTY_TYPE_H2D) ? TRS_ASYNC_JETTY_HOST_DEVICE : TRS_ASYNC_JETTY_DEVICE_TO_DEVICE;
    uint64_t handle = 0U;

    rtError_t error = driver->AsyncDmaJettyCreate(deviceId_, 1U, depth, dir, &handle);
    ERROR_RETURN_MSG_INNER(error, "Create jetty failed, device_id=%u, type=%d, depth=%u, ret=%d.",
        deviceId_, static_cast<int32_t>(type), depth, error);

    uint32_t dieId = 0U;
    uint32_t functionId = 0U;
    uint32_t jettyId = 0U;
    error = driver->AsyncDmaJettyQuery(deviceId_, handle, dieId, functionId, jettyId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Query jetty failed, device_id=%u, handle=%llu, ret=%d.",
            deviceId_, handle, error);
        (void)driver->AsyncDmaJettyDestroy(deviceId_, handle);
        return error;
    }

    jettyInfo.handle = handle;
    jettyInfo.dieId = dieId;
    jettyInfo.functionId = functionId;
    jettyInfo.jettyId = jettyId;
    jettyInfo.depth = depth;
    jettyInfo.type = type;
    jettyInfo.state = JettyState::FREE;

    RT_LOG(RT_LOG_INFO, "Create jetty success, device_id=%u, type=%d, depth=%u, jetty_id=%u, die_id=%u, func_id=%u.",
        deviceId_, static_cast<int32_t>(type), depth, jettyId, dieId, functionId);
    return RT_ERROR_NONE;
}

rtError_t JettyPool::ReserveJetty(JettyType type)
{
    std::lock_guard<std::mutex> lock(poolLock_);
    std::vector<JettyInfo> &pool = (type == JettyType::JETTY_TYPE_H2D) ? h2dJettyPool_ : d2dJettyPool_;
    uint32_t maxSize = (type == JettyType::JETTY_TYPE_H2D) ? JETTY_POOL_H2D_MAX_SIZE : JETTY_POOL_D2D_MAX_SIZE;
    if (pool.size() < maxSize) {
        JettyInfo newJetty;
        rtError_t error = CreateJetty(type, JETTY_DEPTH_STANDARD, newJetty);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        newJetty.state = JettyState::FREE;
        pool.push_back(newJetty);
        RT_LOG(RT_LOG_INFO, "Create jetty (FREE), device_id=%u, type=%d, jetty_id=%u.",
            deviceId_, static_cast<int32_t>(type), newJetty.jettyId);
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_DEBUG, "Jetty pool exhausted, device_id=%u, type=%d.",
        deviceId_, static_cast<int32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t JettyPool::ReleaseJetty(uint64_t handle, JettyType type)
{
    std::lock_guard<std::mutex> lock(poolLock_);

    Driver* const driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    if (driver == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    std::vector<JettyInfo> &pool = (type == JettyType::JETTY_TYPE_H2D) ? h2dJettyPool_ : d2dJettyPool_;
    for (auto it = pool.begin(); it != pool.end(); ++it) {
        if (it->handle == handle) {
            rtError_t ret = driver->AsyncDmaJettyDestroy(deviceId_, it->handle);
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "Destroy jetty failed, device_id=%u, type=%d, jetty_id=%u, ret=%d.",
                    deviceId_, static_cast<int32_t>(type), it->jettyId, static_cast<int32_t>(ret));
                return ret;
            }
            RT_LOG(RT_LOG_INFO, "Release jetty success, device_id=%u, type=%d, jetty_id=%u.",
                deviceId_, static_cast<int32_t>(type), it->jettyId);
            pool.erase(it);
            return RT_ERROR_NONE;
        }
    }

    return RT_ERROR_INVALID_VALUE;
}

rtError_t JettyPool::AcquireJetty(JettyType type, JettyInfo &jettyInfo)
{
    std::lock_guard<std::mutex> lock(poolLock_);
    JettyInfo *freeJetty = nullptr;
    if (FindJettyByState(type, JettyState::FREE, freeJetty)) {
        freeJetty->state = JettyState::BOUND;
        jettyInfo = *freeJetty;
        RT_LOG(RT_LOG_INFO, "Acquire jetty (FREE->BOUND), device_id=%u, type=%d, jetty_id=%u.",
            deviceId_, static_cast<int32_t>(type), freeJetty->jettyId);
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_WARNING, "No FREE jetty to acquire, device_id=%u, type=%d.", deviceId_, static_cast<int32_t>(type));
    return RT_ERROR_JETTY_POOL_NO_RESOURCES;
}

rtError_t JettyPool::MarkFree(uint64_t handle)
{
    std::lock_guard<std::mutex> lock(poolLock_);

    JettyInfo *jetty = nullptr;
    if (!FindJettyByHandle(handle, jetty)) {
        RT_LOG(RT_LOG_ERROR, "Jetty not found for MarkFree, device_id=%u, handle=%llu.",
            deviceId_, handle);
        return RT_ERROR_INVALID_VALUE;
    }

    jetty->state = JettyState::FREE;
    RT_LOG(RT_LOG_INFO, "Mark jetty free success, device_id=%u, jetty_id=%u.",
        deviceId_, jetty->jettyId);
    return RT_ERROR_NONE;
}

rtError_t JettyPool::CreateLargeDepthJetty(JettyType type, uint32_t depth, JettyInfo &jettyInfo)
{
    if (depth < JETTY_DEPTH_STANDARD) {
        RT_LOG(RT_LOG_ERROR, "Invalid large depth jetty depth=%u.", depth);
        return RT_ERROR_INVALID_VALUE;
    }

    std::lock_guard<std::mutex> lock(poolLock_);

    JettyInfo newJetty;
    rtError_t error = CreateJetty(type, depth, newJetty);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    newJetty.state = JettyState::BOUND;
    largeJettyPool_.push_back(newJetty);
    jettyInfo = newJetty;

    RT_LOG(RT_LOG_INFO, "Create large depth jetty success, device_id=%u, type=%d, depth=%u, jetty_id=%u.",
        deviceId_, static_cast<int32_t>(type), depth, newJetty.jettyId);
    return RT_ERROR_NONE;
}

rtError_t JettyPool::DestroyLargeDepthJetty(uint64_t handle)
{
    std::lock_guard<std::mutex> lock(poolLock_);

    Driver* const driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    if (driver == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    for (auto it = largeJettyPool_.begin(); it != largeJettyPool_.end(); ++it) {
        if (it->handle == handle) {
            rtError_t ret = driver->AsyncDmaJettyDestroy(deviceId_, it->handle);
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "Destroy large depth jetty failed, device_id=%u, handle=%llu, ret=%d.",
                    deviceId_, handle, static_cast<int32_t>(ret));
                return ret;
            }
            RT_LOG(RT_LOG_INFO, "Destroy large depth jetty success, device_id=%u, handle=%llu, jetty_id=%u.",
                deviceId_, handle, it->jettyId);
            largeJettyPool_.erase(it);
            return RT_ERROR_NONE;
        }
    }

    return RT_ERROR_INVALID_VALUE;
}

rtError_t JettyPool::GetJettyInfoByHandle(uint64_t handle, JettyInfo &jettyInfo)
{
    std::lock_guard<std::mutex> lock(poolLock_);

    JettyInfo *jetty = nullptr;
    if (!FindJettyByHandle(handle, jetty) || jetty == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Jetty not found for GetJettyInfoByHandle, device_id=%u, handle=%llu.",
            deviceId_, handle);
        return RT_ERROR_INVALID_VALUE;
    }

    jettyInfo = *jetty;
    return RT_ERROR_NONE;
}

rtError_t JettyPool::QueryJettyInfo(uint64_t handle, uint32_t &dieId, uint32_t &functionId, uint32_t &jettyId) const
{
    Driver* const driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    if (driver == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    return driver->AsyncDmaJettyQuery(deviceId_, handle, dieId, functionId, jettyId);
}

void JettyPool::Clear()
{
    // jetty handle destroy by tsdrv
    std::lock_guard<std::mutex> lock(poolLock_);
    h2dJettyPool_.clear();
    d2dJettyPool_.clear();
    largeJettyPool_.clear();
    RT_LOG(RT_LOG_INFO, "Jetty pool cleared, device_id=%u.", deviceId_);
}

bool JettyPool::FindJettyByState(JettyType type, JettyState state, JettyInfo *&jettyInfo)
{
    std::vector<JettyInfo> &pool = (type == JettyType::JETTY_TYPE_H2D) ? h2dJettyPool_ : d2dJettyPool_;
    for (auto &jetty : pool) {
        if (jetty.state == state) {
            jettyInfo = &jetty;
            return true;
        }
    }
    return false;
}

bool JettyPool::FindJettyByHandle(uint64_t handle, JettyInfo *&jettyInfo)
{
    for (auto &jetty : h2dJettyPool_) {
        if (jetty.handle == handle) {
            jettyInfo = &jetty;
            return true;
        }
    }
    for (auto &jetty : d2dJettyPool_) {
        if (jetty.handle == handle) {
            jettyInfo = &jetty;
            return true;
        }
    }
    for (auto &jetty : largeJettyPool_) {
        if (jetty.handle == handle) {
            jettyInfo = &jetty;
            return true;
        }
    }
    return false;
}

} // namespace runtime
} // namespace cce
