/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_model.hpp"
#include "context.hpp"
#include "task_info.hpp"
#include "arg_loader.hpp"
#include <memory>
#include <new>

namespace cce {
namespace runtime {
namespace {
rtError_t CopyLoadedArgs(const TaskInfo* taskInfo, Driver* driver, void* backup, const size_t argsSize)
{
    const TaskUpdateInfo* const updateInfo = taskInfo->updateInfo;
    if ((updateInfo == nullptr) || (updateInfo->loadedParams.placeHolderNum == 0U)) {
        return driver->MemCopySync(
            backup, argsSize, taskInfo->u.aicTaskInfo.comm.args, argsSize, RT_MEMCPY_DEVICE_TO_DEVICE);
    }
    const auto& loaded = updateInfo->loadedParams;
    COND_RETURN_ERROR(
        (loaded.placeHolderArray == nullptr) || (loaded.placeHolderNum > UINT16_MAX), RT_ERROR_INVALID_VALUE,
        "Invalid loaded args relocation table, stream_id=%d, task_id=%hu, size=%zu.", taskInfo->stream->Id_(),
        taskInfo->id, argsSize);
    std::unique_ptr<uint8_t[]> hostArgs(new (std::nothrow) uint8_t[argsSize]);
    COND_RETURN_AND_MSG_OUTER(hostArgs == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, argsSize, "new");
    rtError_t error = driver->MemCopySync(
        hostArgs.get(), argsSize, taskInfo->u.aicTaskInfo.comm.args, argsSize, RT_MEMCPY_DEVICE_TO_HOST);
    ERROR_RETURN(error, "Read loaded kernel args for relocation failed, retCode=%#x.", error);
    UpdateAddrField(
        backup, hostArgs.get(), static_cast<uint16_t>(loaded.placeHolderNum),
        RtPtrToPtr<const rtHostInputInfo_t*>(loaded.placeHolderArray));
    error = driver->MemCopySync(backup, argsSize, hostArgs.get(), argsSize, RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN(error, "Upload relocated kernel args failed, retCode=%#x.", error);
    return RT_ERROR_NONE;
}
} // namespace

rtError_t CaptureModel::CopyTaskArgsDeviceBuffer(const TaskInfo* taskInfo, void** devBufferAddr, size_t* size)
{
    const std::lock_guard<std::mutex> lock(updateInfo_.updateMutex);
    const auto& comm = taskInfo->u.aicTaskInfo.comm;
    COND_RETURN_ERROR(
        comm.args == nullptr || comm.argsSize == 0U, RT_ERROR_INVALID_VALUE,
        "Loaded arguments are empty, model_id=%u, stream_id=%d, task_id=%hu.", Id_(), taskInfo->stream->Id_(),
        taskInfo->id);
    Device* const dev = taskInfo->stream->Device_();
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    Driver* const driver = dev->Driver_();
    NULL_PTR_RETURN(driver, RT_ERROR_DRV_NULL);
    rtError_t error = dev->GetDeviceStatus();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    void* backup = nullptr;
    const size_t argsSize = comm.argsSize;
    error = driver->DevMemAllocWithBackupFlag(&backup, argsSize, RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Allocate argument backup failed, model_id=%u, device_id=%u, stream_id=%d, task_id=%hu, size=%zu, "
            "retCode=%#x.",
            Id_(), dev->Id_(), taskInfo->stream->Id_(), taskInfo->id, argsSize, error);
        // A failed driver allocation may already have freed its output address.
        return error;
    }
    error = CopyLoadedArgs(taskInfo, driver, backup, argsSize);
    if (error != RT_ERROR_NONE) {
        (void)driver->DevMemFree(backup, dev->Id_());
        return error;
    }
    argsDeviceBufferBackups_.push_back(backup);
    *devBufferAddr = backup;
    *size = argsSize;
    RT_LOG(
        RT_LOG_DEBUG, "Backed up loaded arguments, model_id=%u, stream_id=%d, task_id=%hu, size=%zu.", Id_(),
        taskInfo->stream->Id_(), taskInfo->id, argsSize);
    return RT_ERROR_NONE;
}

void CaptureModel::ReleaseArgsDeviceBufferBackups(bool releaseDeviceMemory)
{
    Device* const dev = releaseDeviceMemory && Context_() != nullptr ? Context_()->Device_() : nullptr;
    Driver* const driver = dev != nullptr ? dev->Driver_() : nullptr;
    for (void* const backup : argsDeviceBufferBackups_) {
        if (releaseDeviceMemory && driver != nullptr) {
            const rtError_t error = driver->DevMemFree(backup, dev->Id_());
            COND_LOG_ERROR(
                error != RT_ERROR_NONE, "Free argument backup failed, model_id=%u, device_id=%u, retCode=%#x.", Id_(),
                dev->Id_(), error);
        }
    }
    argsDeviceBufferBackups_.clear();
}
} // namespace runtime
} // namespace cce
