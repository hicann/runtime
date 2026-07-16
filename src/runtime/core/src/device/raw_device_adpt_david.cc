/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "raw_device.hpp"

#include <chrono>
#include "uma_arg_loader.hpp"
#include "runtime.hpp"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api.hpp"
#include "task.hpp"
#include "device/device_error_proc.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "aicpu_err_msg.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "event.hpp"
#include "ctrl_res_pool.hpp"
#include "npu_driver_dcache_lock.hpp"
#include "stream_factory.hpp"
#include "arg_loader_ub.hpp"
#include "stream_c.hpp"
#include "count_notify.hpp"
#include "dev_simt_stack_checker.hpp"

namespace cce {
namespace runtime {
rtError_t RawDevice::AllocSimtStackPhyBase(const rtChipType_t chipType)
{
    UNUSED(chipType);
    if (!IsNeedAllocSimtStack(this)) {
        return RT_ERROR_NONE;
    }
    const uint64_t simtWarpStkSize = Runtime::Instance()->GetSimtWarpStkSize();
    const uint32_t simtDvgWarpStkSize = Runtime::Instance()->GetSimtDvgWarpStkSize();

    const uint64_t aivCoreNum = GetDavidDieNum() * GetDevProperties().aivNumPerDie;
    uint64_t stackPhySize = aivCoreNum * RT_MAX_WARP_NUM_PER_VECTOR_CORE * (simtWarpStkSize + static_cast<uint64_t>(simtDvgWarpStkSize));
    stackPhySize += static_cast<uint64_t>(STACK_PHY_BASE_ALIGN_LEN);   // 128B align

    const rtError_t error =  driver_->DevMemAlloc(&simtStackPhyBase_,
        stackPhySize, RT_MEMORY_DDR, deviceId_);
    RT_LOG(RT_LOG_DEBUG, "AllocStackPhyBase device_id=%u, simtStackPhyBase_=0x%llx, stackPhySize=%u.",
        deviceId_, RtPtrToValue(simtStackPhyBase_), stackPhySize);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (simtStackPhyBase_ == nullptr), error,
        "Alloc simt stack phy base failed, mem alloc failed, retCode=%#x.", static_cast<uint32_t>(error));

    const uint64_t devAlignAddr = ((RtPtrToValue(simtStackPhyBase_) & (STACK_PHY_BASE_ALIGN_LEN - 1U)) == 0U) ?
        RtPtrToValue(simtStackPhyBase_) :
        (((RtPtrToValue(simtStackPhyBase_) >> STACK_PHY_BASE_ALIGN_BIT) + 1U) << STACK_PHY_BASE_ALIGN_BIT);
    simtStackPhyBaseAlign_ = RtValueToPtr<void *>(devAlignAddr);
    simtWarpStkSize_ = static_cast<uint32_t>((simtWarpStkSize >= MAX_UINT32_NUM) ? MAX_UINT32_NUM : simtWarpStkSize);
    simtDvgWarpStkSize_ = simtDvgWarpStkSize;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::FreeSimtStackPhyBase()
{
    if (simtStackPhyBase_ == nullptr) {
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_DEBUG, "FreeStackPhyBase device_id=%u, simtStackPhyBase_=0x%llx.",
        deviceId_, RtPtrToValue(simtStackPhyBase_));
    const rtError_t error =  driver_->DevMemFree(simtStackPhyBase_, deviceId_);
    ERROR_RETURN(error, "Free stack phy base failed, mem free failed, retCode=%#x.", static_cast<uint32_t>(error));
    simtStackPhyBase_ = nullptr;
    simtStackPhyBaseAlign_ = nullptr;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::AllocStackPhyBaseDavid()
{
    const uint64_t scalerBufSize =
        32U * 1024U * GetDavidDieNum() * (RT_DAVID_AICORE_NUM_PER_DIE + GetDevProperties().aivNumPerDie);

    rtError_t error = AllocAddrForDcache(deviceId_, stackPhyBase32k_, scalerBufSize, drvMemCtrlHandle_);
    if (error == RT_ERROR_NONE) {
        stackAddrIsDcache_ = true;
        stackPhyBase32kAlign_ = stackPhyBase32k_;
        return RT_ERROR_NONE;
    }
    if (scalerBufSize > (MAX_UINT64_NUM - STACK_PHY_BASE_ALIGN_LEN)) {
        return RT_ERROR_INVALID_VALUE;
    }
    const uint64_t stackPhySize = scalerBufSize + STACK_PHY_BASE_ALIGN_LEN;
    error = driver_->DevMemAlloc(&stackPhyBase32k_,
        stackPhySize, RT_MEMORY_DDR, deviceId_);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (stackPhyBase32k_ == nullptr), error,
        "Alloc stack phy base failed, mem alloc failed, retCode=%#x.", static_cast<uint32_t>(error));
    const uint64_t devAlignAddr = (RtPtrToValue(stackPhyBase32k_) & (STACK_PHY_BASE_ALIGN_LEN - 1U)) == 0U ?
        RtPtrToValue(stackPhyBase32k_) :
        (((RtPtrToValue(stackPhyBase32k_) >> STACK_PHY_BASE_ALIGN_BIT) + 1U) << STACK_PHY_BASE_ALIGN_BIT);
    stackPhyBase32kAlign_ = RtValueToPtr<void *>(devAlignAddr);
    RT_LOG(RT_LOG_INFO, "device_id=%u, stackPhyBase32k_=0x%llx, stackPhyBase32kAlign_=0x%llx, "
        "stackPhySize=%u.", deviceId_, RtPtrToValue(stackPhyBase32k_),
        RtPtrToValue(stackPhyBase32kAlign_), stackPhySize);
    return RT_ERROR_NONE;
}

rtError_t RawDevice::UbArgLoaderInit(void)
{
    if (Runtime::Instance()->GetConnectUbFlag()) {
        ubArgLoader_ = new (std::nothrow) UbArgLoader(this);
        COND_RETURN_AND_MSG_OUTER(ubArgLoader_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
            sizeof(UbArgLoader), "new");
        RT_LOG(RT_LOG_INFO, "new UbArgLoader ok, Runtime_alloc_size %zu(bytes)", sizeof(UbArgLoader));

        const auto error = ubArgLoader_->Init();
        ERROR_RETURN(error, "ub argloader init fail, retCode=%#x.", error);
    }

    return RT_ERROR_NONE;
}

rtError_t RawDevice::SendTopicMsgVersionToAicpu(void)
{
    return SendTopicMsgVersionToAicpuDavid(primaryStream_);
}

rtError_t RawDevice::CntNotifiesReAllocId(void)
{
    std::unique_lock<std::mutex> l(cntNotifyLock_);
    for (CountNotify *nty : cntNotifies_) {
        const rtError_t error = nty->ReAllocId();
        ERROR_RETURN(error, "Realloc count notify id %u failed, retCode=%#x.", nty->GetCntNotifyId(), error);
    }
    return RT_ERROR_NONE;
}

void RawDevice::PushCntNotify(CountNotify * const nty)
{
    std::unique_lock<std::mutex> l(cntNotifyLock_);
    (void)cntNotifies_.insert(nty);
}

void RawDevice::RemoveCntNotify(CountNotify * const nty)
{
    std::unique_lock<std::mutex> l(cntNotifyLock_);
    (void)cntNotifies_.erase(nty);
}

}
}
