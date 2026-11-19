/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_stream_res_manage.h"

#include "cc_task_queue.h"
#include "common/error_message_manage.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "type_def.h"
#include "crypto/cc_crypto.h"

namespace cce {
namespace runtime {

CCStreamResManage::~CCStreamResManage() { Destroy(); }

rtError_t CCStreamResManage::Init(Device* device, uint32_t taskDescSize)
{
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC stream resource device is null.");
    device_ = device;

    rtError_t ret = CreateBarTaskQueue(&barQueue_, device_, CC_SLICE_DESC_SLOT_NUM, taskDescSize);
    COND_RETURN_ERROR_MSG_INNER(
        ret != RT_ERROR_NONE, ret, "CC stream resource create bar task queue failed, ret=%#x.", ret);

    ret = GetBarTaskQueueDevAddr(barQueue_, &queueDevAddr_);
    if (ret != RT_ERROR_NONE) {
        (void)FreeBarTaskQueue(barQueue_);
        barQueue_ = nullptr;
        return ret;
    }
    return RT_ERROR_NONE;
}

void CCStreamResManage::Destroy()
{
    if (barQueue_ != nullptr) {
        (void)FreeBarTaskQueue(barQueue_);
        barQueue_ = nullptr;
    }
    queueDevAddr_ = 0U;
    const std::lock_guard<std::mutex> smallLock(smallD2H_.mutex);
    if (device_ == nullptr) {
        return;
    }
    Driver* const driver = device_->Driver_();
    if (driver != nullptr) {
        ReleaseSmallD2HBuffers();
    }
    device_ = nullptr;
}

rtError_t CCStreamResManage::PrepareSmallD2HBuffers(Device* device)
{
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC small D2H device is null.");
    COND_RETURN_ERROR(
        (device_ != nullptr) && (device_ != device), RT_ERROR_DEVICE_ID,
        "CC small D2H resource belongs to another device.");
    Driver* const driver = device->Driver_();
    COND_RETURN_ERROR(driver == nullptr, RT_ERROR_DRV_NULL, "CC small D2H driver is null.");
    device_ = device;
    if (smallD2H_.hostDmaMapped) {
        return RT_ERROR_NONE;
    }
    ScopeGuard rollback([this]() { ReleaseSmallD2HBuffers(); });
    rtError_t ret = driver->DevMemAllocWithBackupFlag(
        &smallD2H_.deviceBuffer, CC_SMALL_CIPHER_CAPACITY, RT_MEMORY_HBM, device->Id_(),
        DevMemBackupType::SNAPSHOT_NO_BACKUP);
    if ((ret != RT_ERROR_NONE) || (smallD2H_.deviceBuffer == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "CC small D2H Device allocation failed, ret=%#x; use legacy path.", ret);
        return RT_ERROR_CONTINUE_EXECUTE;
    }
    ret = driver->HostMemAlloc(&smallD2H_.hostBuffer, CC_SMALL_CIPHER_CAPACITY, device->Id_());
    if ((ret != RT_ERROR_NONE) || (smallD2H_.hostBuffer == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "CC small D2H Host allocation failed, ret=%#x; use legacy path.", ret);
        return RT_ERROR_CONTINUE_EXECUTE;
    }
    ret = driver->HostDmaMap(smallD2H_.hostBuffer, CC_SMALL_CIPHER_CAPACITY, device->Id_());
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "CC small D2H Host DMA mapping failed, ret=%#x; use legacy path.", ret);
        return RT_ERROR_CONTINUE_EXECUTE;
    }
    smallD2H_.hostDmaMapped = true;
    rollback.ReleaseGuard();
    return RT_ERROR_NONE;
}

void CCStreamResManage::ReleaseSmallD2HBuffers()
{
    Driver* const driver = device_->Driver_();
    if (smallD2H_.hostDmaMapped) {
        const rtError_t ret = driver->HostDmaUnmap(smallD2H_.hostBuffer, device_->Id_());
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "CC small D2H HostDmaUnmap failed, device_id=%u, hostBuffer=%p, ret=%#x.", device_->Id_(),
                smallD2H_.hostBuffer, ret);
        }
    }
    if (smallD2H_.hostBuffer != nullptr) {
        const rtError_t ret = driver->HostMemFree(smallD2H_.hostBuffer);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "CC small D2H HostMemFree failed, device_id=%u, hostBuffer=%p, ret=%#x.", device_->Id_(),
                smallD2H_.hostBuffer, ret);
        }
    }
    if (smallD2H_.deviceBuffer != nullptr) {
        const rtError_t ret = driver->DevMemFree(smallD2H_.deviceBuffer, device_->Id_());
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "CC small D2H DevMemFree failed, device_id=%u, deviceBuffer=%p, ret=%#x.", device_->Id_(),
                smallD2H_.deviceBuffer, ret);
        }
    }
    smallD2H_.hostDmaMapped = false;
    smallD2H_.hostBuffer = nullptr;
    smallD2H_.deviceBuffer = nullptr;
    smallD2H_.pending = false;
    smallD2H_.copyError = RT_ERROR_NONE;
}

void CCStreamResManage::Reset() const
{
    if (barQueue_ != nullptr) {
        (void)ResetBarTaskQueue(barQueue_);
    }
}

BarTaskQueue* CCStreamResManage::BarQueue() const { return barQueue_; }

uint64_t CCStreamResManage::DeviceQueueAddr() const { return queueDevAddr_; }

std::mutex& CCStreamResManage::ProcessMutex() { return processMutex_; }

std::mutex& CCStreamResManage::MemSubmitMutex() { return memSubmitMutex_; }

} // namespace runtime
} // namespace cce
