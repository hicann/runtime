/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "internal_error_define.hpp"
#include "context.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "cond_handle.hpp"
#include "capture_model.hpp"

#include "context.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "notify.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "error_message_manage.hpp"
#include "rt_log.h"

namespace cce {
namespace runtime {

CondHandle::CondHandle(Model *mdl, uint32_t defaultValue, rtCondHandleFlag_t flag)
    : NoCopy(), model_(mdl), defaultValue_(defaultValue), flag_(flag), condType_(static_cast<rtCondTaskType_t>(RT_COND_TASK_TYPE_MAX))
{
}

CondHandle::~CondHandle() noexcept
{
    DELETE_O(subModelNotify_);

    for (Model *mdl : subCaptureModels_) {
        CaptureModel *subModel = dynamic_cast<CaptureModel *>(mdl);
        if (subModel == nullptr) {
            continue;
        }

        subModel->SetEndGraphNotify(nullptr);
        context_->SubModelDestroy(mdl);
    }

    subCaptureModels_.clear();

    if (devAddr_ != nullptr && context_ != nullptr) {
        Device *dev = context_->Device_();
        if (dev != nullptr) {
            (void)dev->Driver_()->DevMemFree(devAddr_, dev->Id_());
        }
    }

    devAddr_ = nullptr;
    context_ = nullptr;
    model_ = nullptr;
}

rtError_t CondHandle::Setup(Context *ctx)
{
    if (ctx == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Context is null, failed to setup cond handle.");
        return RT_ERROR_CONTEXT_NULL;
    }

    context_ = ctx;
    Device *dev = ctx->Device_();
    if (dev == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Device is null, failed to setup cond handle.");
        return RT_ERROR_DEVICE_NULL;
    }

    Driver *driver = dev->Driver_();
    if (driver == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Driver is null, failed to setup cond handle.");
        return RT_ERROR_DRV_NULL;
    }

    rtError_t error = driver->DevMemAlloc((void **)(&devAddr_), sizeof(uint64_t), RT_MEMORY_DEFAULT, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "DevMemAlloc failed for cond handle, device_id=%u, size=%zu, retCode=%#x.",
            dev->Id_(), sizeof(uint64_t), static_cast<uint32_t>(error));
        return error;
    }

    error = driver->MemSetSync(devAddr_, sizeof(uint64_t), 0U, sizeof(uint64_t));
    ERROR_RETURN(error, "Failed to memset devAddr, retCode=%#x.", static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_DEBUG, "CondHandle setup success, model_id=%u, default_value=%u, flag=%d, dev_addr=%p.",
        model_ != nullptr ? model_->Id_() : 0U, defaultValue_, static_cast<int32_t>(flag_), devAddr_);

    InitEmbeddedInnerHandle(this);
    CaptureModel *captureModel = dynamic_cast<CaptureModel *>(model_);
    captureModel->ModelPushBackCondHandle(this);

    return RT_ERROR_NONE;
}

void CondHandle::SubModelDestroy()
{
    for (auto it = subCaptureModels_.begin(); it != subCaptureModels_.end(); ++it) {
        context_->SubModelDestroy(*it);
    }

    subCaptureModels_.clear();
    return;
}

rtError_t CondHandle::InitCondTaskByDefValue()
{
    if (flag_ != RT_COND_HANDLE_ASSIGN_DEFAULT) {
        return RT_ERROR_NONE;
    }

    Device *dev = context_->Device_();
    COND_RETURN_ERROR((dev == nullptr), RT_ERROR_DEVICE_NULL, "Device is null, failed to init cond value.");

    Driver *driver = dev->Driver_();
    COND_RETURN_ERROR((driver == nullptr), RT_ERROR_DRV_NULL, "Driver is null, failed to init cond value.");

    uint64_t defValue = static_cast<uint64_t>(defaultValue_);
    rtError_t error = driver->MemCopySync(devAddr_, sizeof(uint64_t), &defValue, sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN(error, "Failed to init cond default value, condFlag=%u, condType=%d, condSize=%u, defValue=%u retCode=%#x.",
        flag_, condType_, condSize_, defaultValue_, static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_DEBUG, "defValue=%u, condType=%d", defValue, condType_);

    return RT_ERROR_NONE;
}

rtError_t CondHandle::Destroy()
{
    if (devAddr_ != nullptr && context_ != nullptr) {
        Device *dev = context_->Device_();
        if (dev != nullptr) {
            rtError_t error = dev->Driver_()->DevMemFree(devAddr_, dev->Id_());
            if (error != RT_ERROR_NONE) {
                RT_LOG_INNER_MSG(RT_LOG_ERROR, "DevMemFree failed for cond handle, retCode=%#x.",
                    static_cast<uint32_t>(error));
                return error;
            }
        }
    }
    devAddr_ = nullptr;
    context_ = nullptr;
    model_ = nullptr;
    return RT_ERROR_NONE;
}

}
}