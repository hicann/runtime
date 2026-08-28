/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "logic_sq_manage.hpp"
#include "logic_sq.hpp"
#include "base.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "rt_log.h"
#include <atomic>

namespace cce {
namespace runtime {

static uint32_t AllocLogicSqId()
{
    static std::atomic<uint32_t> logicSqIdCounter{0U};
    return logicSqIdCounter.fetch_add(1U);
}

LogicSqManage::~LogicSqManage()
{
    for (auto& it : logicSqIdToLogicSqMap_) {
        DELETE_O(it.second);
    }
    rtsqIdToLogicSqIdMap_.clear();
    logicSqIdToLogicSqMap_.clear();
}

rtError_t LogicSqManage::CreateLogicSq(LogicSq*& logicSq)
{
    logicSq = new (std::nothrow) LogicSq(device_);
    if (logicSq == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new logic sq failed, device_id=%u.", device_->Id_());
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const uint32_t logicSqId = AllocLogicSqId();
    const uint32_t reserveSqeNum = CAPTURE_TASK_RESERVED_NUM + device_->GetDevProperties().expandStreamRsvTaskNum;
    const rtError_t error = logicSq->SetUp(logicSqId, reserveSqeNum);
    if (error != RT_ERROR_NONE) {
        DELETE_O(logicSq);
        return error;
    }

    const std::lock_guard<std::mutex> lk(lock_);
    logicSqIdToLogicSqMap_[logicSqId] = logicSq;
    RT_LOG(RT_LOG_INFO, "logic sq created, device_id=%u, logicSqId=%u.", logicSq->Device_()->Id_(), logicSqId);
    return RT_ERROR_NONE;
}

void LogicSqManage::FreeLogicSq(const uint32_t logicSqId)
{
    const std::lock_guard<std::mutex> lk(lock_);
    for (auto it = rtsqIdToLogicSqIdMap_.begin(); it != rtsqIdToLogicSqIdMap_.end();) {
        if (it->second == logicSqId) {
            it = rtsqIdToLogicSqIdMap_.erase(it);
        } else {
            ++it;
        }
    }

    const auto it = logicSqIdToLogicSqMap_.find(logicSqId);
    if (it != logicSqIdToLogicSqMap_.end()) {
        DELETE_O(it->second);
        logicSqIdToLogicSqMap_.erase(it);
        RT_LOG(RT_LOG_INFO, "logic sq freed, device_id=%u, logicSqId=%u.", device_->Id_(), logicSqId);
    }
}

rtError_t LogicSqManage::BindRtsqToLogicSq(const uint32_t rtsqId, const uint32_t logicSqId)
{
    const std::lock_guard<std::mutex> lk(lock_);
    if (logicSqIdToLogicSqMap_.find(logicSqId) == logicSqIdToLogicSqMap_.end()) {
        return RT_ERROR_INVALID_VALUE;
    }
    rtsqIdToLogicSqIdMap_[rtsqId] = logicSqId;
    RT_LOG(
        RT_LOG_INFO, "rtsq bound to logic sq, device_id=%u, rtsqId=%u, logicSqId=%u.", device_->Id_(), rtsqId,
        logicSqId);
    return RT_ERROR_NONE;
}

void LogicSqManage::UnbindRtsqFromLogicSq(const uint32_t rtsqId)
{
    const std::lock_guard<std::mutex> lk(lock_);
    const auto it = rtsqIdToLogicSqIdMap_.find(rtsqId);
    if (it == rtsqIdToLogicSqIdMap_.end()) {
        RT_LOG(RT_LOG_ERROR, "RtsqId not found, device_id=%u, rtsqId=%u.", device_->Id_(), rtsqId);
        return;
    }

    RT_LOG(
        RT_LOG_INFO, "rtsq unbound from logic sq, device_id=%u, rtsqId=%u, logicSqId=%u.", device_->Id_(), rtsqId,
        it->second);
    rtsqIdToLogicSqIdMap_.erase(it);
}

rtError_t LogicSqManage::GetLogicSqIdByRtsqId(const uint32_t rtsqId, uint32_t& logicSqId) const
{
    const std::lock_guard<std::mutex> lk(lock_);
    const auto it = rtsqIdToLogicSqIdMap_.find(rtsqId);
    if (it == rtsqIdToLogicSqIdMap_.end()) {
        return RT_ERROR_INVALID_VALUE;
    }
    logicSqId = it->second;
    return RT_ERROR_NONE;
}

rtError_t LogicSqManage::GetLogicSqById(const uint32_t logicSqId, LogicSq*& logicSq) const
{
    const std::lock_guard<std::mutex> lk(lock_);
    const auto it = logicSqIdToLogicSqMap_.find(logicSqId);
    if (it == logicSqIdToLogicSqMap_.end()) {
        return RT_ERROR_INVALID_VALUE;
    }
    logicSq = it->second;
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
