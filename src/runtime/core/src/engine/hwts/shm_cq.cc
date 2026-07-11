/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "shm_cq.hpp"
#include "task.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
ShmCq::ShmCq() : dev_{nullptr}, driver_{nullptr}, vSqReadonly_{false}, vSqId_{MAX_UINT32_NUM}, vCqId_{MAX_UINT32_NUM}, vSqBase_{nullptr},
    deviceId_{MAX_UINT32_NUM},  tsId_{MAX_UINT32_NUM}
{
    streamShmTaskId_ = new (std::nothrow) uint32_t[RT_MAX_STREAM_ID];
    if (streamShmTaskId_ != nullptr) {
        (void)memset_s(streamShmTaskId_, sizeof(uint32_t) * RT_MAX_STREAM_ID, 0xFF, sizeof(uint32_t) * RT_MAX_STREAM_ID);
    }
}

ShmCq::~ShmCq() noexcept
{
    if (vSqBase_ != nullptr) {
        (void)driver_->VirtualCqFree(dev_->Id_(), tsId_, vSqId_, vCqId_);
        vSqBase_ = nullptr;
    }
    DELETE_A(streamShmTaskId_);
}

rtError_t ShmCq::Init(Device * dev)
{
    if (dev_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "ShmCq is read only, no need init");
        return RT_ERROR_NONE;
    }

    NULL_PTR_RETURN(dev, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN(dev->Driver_(), RT_ERROR_INVALID_VALUE);
    driver_ = dev->Driver_();
    deviceId_ = dev->Id_();
    tsId_ = dev->DevGetTsId();

    const rtError_t error = driver_->VirtualCqAllocate(deviceId_, tsId_, vSqId_, vCqId_, vSqBase_, vSqReadonly_);
    if (error == RT_ERROR_DRV_INPUT) {
        RT_LOG(RT_LOG_INFO, "Does not support virtual cq, retCode=%#x, deviceId=%u.",
               static_cast<uint32_t>(error), deviceId_);
        return error;
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to allocate virtual cq, retCode=%#x, deviceId=%u.",
            static_cast<uint32_t>(error), deviceId_);
        if ((error == RT_ERROR_DRV_NO_RESOURCES) || (error == RT_ERROR_DEVICE_SQCQ_POOL_RESOURCE_FULL)) {
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1023, "Alloc Stream resource",
                "Too many streams are created");
        }
        return error;
    }
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (vSqBase_ == nullptr), RT_ERROR_INVALID_VALUE,
        "Failed to allocate virtual cq, deviceId=%u, vSqReadonly=%u.", dev->Id_(), vSqReadonly_);
    dev_ = dev;

    return RT_ERROR_NONE;
}

rtError_t ShmCq::InitCqShm(const uint32_t streamId)
{
    // if vsq is read only, no need init.
    if (vSqReadonly_) {
        RT_LOG(RT_LOG_INFO, "device_id=%u vsq is read only, no need init, stream_id=%u", dev_->Id_(), streamId);
        return RT_ERROR_NONE;
    }

    COND_RETURN_ERROR(streamShmTaskId_ == nullptr, RT_ERROR_DRV_MALLOC_FAIL, "Failed to allocate memory for stream task ID.");
    COND_RETURN_ERROR(vSqBase_ == nullptr, RT_ERROR_DRV_PTRNULL,
                                "Failed to initialize CQ shm. Reason: virtual SQ address is null.");
    COND_RETURN_ERROR_MSG_INNER(streamId >= RT_MAX_STREAM_ID, RT_ERROR_INVALID_VALUE,
                                "Failed to query CQ shm, Value %u for parameter streamId is invalid. Expected: [0, %u].", streamId, RT_MAX_STREAM_ID);

    uint8_t * const shmAddr = vSqBase_ + (streamId * sizeof(rtShmQuery_t));
    volatile rtShmQuery_t * const shareMemory = RtPtrToPtr<volatile rtShmQuery_t *>(shmAddr);
    shareMemory->taskId = 0U;
    shareMemory->firstErrorCode = 0U;
    shareMemory->taskId1 = 0U;
    shareMemory->lastErrorCode = 0U;
    shareMemory->taskId2 = 0U;
    shareMemory->payLoad = 0U;
    shareMemory->payLoad2 = 0U;
    shareMemory->valid = 0U;

    RT_LOG(RT_LOG_DEBUG, "Init cq shm success, device_id=%u, ts_id=%u, stream_id=%u, task_id=%u, first_error_code=%u, "
           "task_id1=%u, last_error_code=%u, task_id2=%u", dev_->Id_(), tsId_, streamId, shareMemory->taskId,
           shareMemory->firstErrorCode, shareMemory->taskId1, shareMemory->lastErrorCode, shareMemory->taskId2);

    streamShmTaskId_[streamId] = MAX_UINT32_NUM;       // Add for record repeats shareMemoryInfo
    return RT_ERROR_NONE;
}

rtError_t ShmCq::QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId) const
{
    COND_RETURN_ERROR(vSqBase_ == nullptr, RT_ERROR_DRV_PTRNULL,
                                "Failed to query CQ shm. Reason: virtual SQ address is null.");

    COND_RETURN_ERROR_MSG_INNER(streamId >= RT_MAX_STREAM_ID, RT_ERROR_INVALID_VALUE,
                                "Failed to query CQ shm, Value %u for parameter streamId is invalid. Expected: [0, %u].", streamId, RT_MAX_STREAM_ID);

    uint8_t * const shmAddr = vSqBase_ + (streamId * sizeof(rtShmQuery_t));
    volatile rtShmQuery_t * const shmQuery = RtPtrToPtr<volatile rtShmQuery_t *>(shmAddr);
    taskId = shmQuery->taskId;
    if (shmQuery->valid != SQ_SHARE_MEMORY_VALID) {
        taskId = UINT32_MAX;
    } else {
        taskId = shmQuery->taskId;
    }

    RT_LOG(RT_LOG_DEBUG, "Query cq shm success, task_id=%u", taskId);
    return RT_ERROR_NONE;
}

uint32_t ShmCq::GetTaskIdFromStreamShmTaskId(const uint32_t streamId) const
{
    if (streamId >= RT_MAX_STREAM_ID) {
        return MAX_UINT32_NUM;
    } else {
        return streamShmTaskId_[streamId];
    }
}

TIMESTAMP_EXTERN(QueryCqShmData);
rtError_t ShmCq::QueryCqShm(const uint32_t streamId, rtShmQuery_t &shareMemInfo)
{
    TIMESTAMP_BEGIN(QueryCqShmData);
    COND_RETURN_ERROR(vSqBase_ == nullptr, RT_ERROR_DRV_PTRNULL,
                                "Failed to query cq shm. Reason: virtual SQ address is null.");
    COND_RETURN_ERROR_MSG_INNER(streamId >= RT_MAX_STREAM_ID, RT_ERROR_INVALID_VALUE,
                                "Query cq shm failed. Value %u for parameter streamId is invalid. Expected: [0, %u]", streamId, RT_MAX_STREAM_ID);

    uint8_t * const shmAddr = vSqBase_ + (streamId * sizeof(rtShmQuery_t));
    rtShmQuery_t * const shmQuery = RtPtrToPtr<rtShmQuery_t *>(shmAddr);
    (void)memcpy_s(&shareMemInfo, sizeof(rtShmQuery_t), shmQuery, sizeof(rtShmQuery_t));

    if (streamShmTaskId_[streamId] != shareMemInfo.taskId) {
        streamShmTaskId_[streamId] = shareMemInfo.taskId;
        RT_LOG(RT_LOG_DEBUG, "Query cq shm success, device_id=%u, ts_id=%u, stream_id=%u, task_id=%u, "
            "first_error_code=%u, task_id1=%u, last_error_code=%u, task_id2=%u, pay_load=%u,pay_load2=%u, valid=%#x",
            deviceId_, tsId_, streamId, shareMemInfo.taskId, shareMemInfo.firstErrorCode, shareMemInfo.taskId1,
            shareMemInfo.lastErrorCode, shareMemInfo.taskId2, shareMemInfo.payLoad, shareMemInfo.payLoad2,
            shareMemInfo.valid);
    }
    TIMESTAMP_END(QueryCqShmData);
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce