/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "logic_sq.hpp"
#include "logic_sq_manage.hpp"
#include "sq_addr_memory_pool.hpp"
#include "task.hpp"
#include "device.hpp"
#include "securec.h"
#include "rt_log.h"
namespace cce {
namespace runtime {
LogicSq::~LogicSq() noexcept
{
    try {
        DELETE_A(hostSqeAddr_);

        if ((deviceSqeAddr_ != nullptr) && (device_ != nullptr) && (sqMemOrderType_ != UINT32_MAX)) {
            SqAddrMemoryOrder* sqAddrMemoryManage = device_->GetSqAddrMemoryManage();
            if (sqAddrMemoryManage != nullptr) {
                const rtError_t error =
                    sqAddrMemoryManage->FreeSqAddr(RtPtrToPtr<uint64_t*>(deviceSqeAddr_), sqMemOrderType_);
                COND_LOG_WARN(
                    error != RT_ERROR_NONE, "Free logic sq device sqe addr failed, device_id=%u, retCode=%#x.",
                    device_->Id_(), static_cast<uint32_t>(error));
            }
            deviceSqeAddr_ = nullptr;
            sqMemOrderType_ = UINT32_MAX;
        }

        if ((sqIdMemAddr_ != 0UL) && (device_ != nullptr)) {
            device_->FreeSqIdMemAddr(sqIdMemAddr_);
            sqIdMemAddr_ = 0UL;
        }
    } catch (...) {
        RT_LOG(RT_LOG_EVENT, "Unexpected exception in logic sq destructor.");
    }
}

rtError_t LogicSq::SetUp(const uint32_t logicSqId, const uint32_t reserveSqeNum)
{
    id_ = logicSqId;
    logicSqDepth_ = STREAM_SQ_MAX_DEPTH;
    reserveSqeNum_ = reserveSqeNum;
    rtsqId_ = UINT16_MAX; // 推迟到模型执行时（BindSqCq）填充
    hostSqeSize_ = logicSqDepth_ * static_cast<uint32_t>(sizeof(rtStarsSqe_t));
    auto* hostBuf = new (std::nothrow) uint8_t[hostSqeSize_];
    if (hostBuf == nullptr) {
        RT_LOG(RT_LOG_ERROR, "alloc hostSqeAddr failed, device_id=%u, size=%u.", device_->Id_(), hostSqeSize_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    (void)memset_s(hostBuf, hostSqeSize_, 0U, hostSqeSize_);
    hostSqeAddr_ = hostBuf;
    return RT_ERROR_NONE;
}

rtError_t LogicSq::AllocDeviceSqeAddr(const uint32_t additionalSqeNum)
{
    if (deviceSqeAddr_ != nullptr) {
        return RT_ERROR_NONE;
    }

    SqAddrMemoryOrder* sqAddrMemoryManage = device_->GetSqAddrMemoryManage();
    if (sqAddrMemoryManage == nullptr) {
        RT_LOG(RT_LOG_ERROR, "sqAddrMemoryManage is null, device_id=%u, logic_sq_id=%u.", device_->Id_(), Id_());
        return RT_ERROR_INVALID_VALUE;
    }

    const uint32_t allocSqeNum = GetSqeNum() + additionalSqeNum;
    const uint32_t allocMemSize = allocSqeNum * static_cast<uint32_t>(sizeof(rtStarsSqe_t));
    const uint32_t memOrderType = sqAddrMemoryManage->GetMemOrderTypeByMemSize(allocMemSize);
    const uint32_t memOrderSize = sqAddrMemoryManage->GetMemOrderSizeByMemOrderType(memOrderType);
    const uint32_t sqDepthAfterUpdate = memOrderSize / static_cast<uint32_t>(sizeof(rtStarsSqe_t));

    uint64_t* sqBaseAddr = nullptr;
    const rtError_t ret = sqAddrMemoryManage->AllocSqAddr(memOrderType, &sqBaseAddr);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "alloc sq addr failed, device_id=%u, logic_sq_id=%u, retCode=%#x.", device_->Id_(), Id_(),
            static_cast<uint32_t>(ret));
        return ret;
    }

    SetDeviceSqeAddr(RtPtrToPtr<void*>(sqBaseAddr));
    SetDeviceSqeSize(allocMemSize);
    SetSqMemOrderType(memOrderType);

    // stars v2要求sq深度必须是8的整数倍+1，调用者给additionalSqeNum加了8个，结合sq addr mem pool的各个内存梯度，
    // 可以保证这里再减7也能放的下全部的sqe，同时满足stars v2的要求。
    SetLogicSqDepth(sqDepthAfterUpdate - device_->GetDevProperties().expandStreamSqDepthAdapt);
    return RT_ERROR_NONE;
}

bool LogicSq::GetStreamIdAndPosByHwPos(const uint32_t hwPos, uint32_t& streamId, uint32_t& pos) const
{
    const auto it = hwPosToTask_.find(hwPos);
    COND_RETURN_ERROR(
        it == hwPosToTask_.end(), false, "Get task failed, device_id=%u, logic_sq_id=%u, hw_pos=%u.", device_->Id_(),
        Id_(), hwPos);

    streamId = it->second.first;
    pos = it->second.second;
    return true;
}

void LogicSq::SetHwPosMapping(const uint32_t hwPos, const uint32_t streamId, const uint32_t pos)
{
    hwPosToTask_[hwPos] = std::make_pair(streamId, pos);
}

} // namespace runtime
} // namespace cce
