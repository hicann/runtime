/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "label_c.hpp"
#include "context/context.hpp"
#include "label.hpp"
#include "stream.hpp"
#include "error_message_manage.hpp"
#include "rt_log.h"

namespace cce {
namespace runtime {

rtError_t CondLabelCreate(Label** const result, Model* const mdl, Context* const ctx)
{
    rtError_t error = RT_ERROR_NONE;
    Label* newLabel = new (std::nothrow) Label(mdl);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER(
        newLabel == nullptr, ERROR_RETURN, error, RT_ERROR_LABEL_NEW, "Label create failed, failed to alloc label.");

    error = newLabel->Setup(ctx);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Setup label failed, retCode=%#x.", error);

    *result = newLabel;
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DELETE_O(newLabel);
ERROR_RETURN:
    *result = nullptr;
    return error;
}

rtError_t CondLabelDestroy(const Label* delLabel)
{
    DELETE_O(delLabel);
    return RT_ERROR_NONE;
}

rtError_t CondLabelListCpy(
    Label** const labelList, const uint32_t labelNumber, void* const dst, const uint32_t dstMax, Device* const device)
{
    UNUSED(dstMax);
    rtError_t error = RT_ERROR_NONE;
    rtLabelDevInfo tempLabelInfo;
    uint32_t labelStep;
    void* devAddr = dst;
    const Stream* labelStream = nullptr;
    Model* labelModel = nullptr;

    if (device->IsStarsPlatform()) {
        labelStep = RT_CHIP_CLOUD_V2_LABEL_INFO_SIZE;
    } else if (device->GetTschVersion() >= TS_VERSION_MORE_LABEL) {
        labelStep = sizeof(rtLabelDevInfo);
    } else {
        labelStep = sizeof(rtLabelDevInfoOld);
    }

    for (uint32_t idx = 0U; idx < labelNumber; idx++) {
        labelStream = labelList[idx]->Stream_();
        labelModel = labelStream->Model_();
        NULL_PTR_RETURN_MSG(labelModel, RT_ERROR_MODEL_NULL);
        tempLabelInfo.modelId = static_cast<uint16_t>(labelModel->Id_());
        tempLabelInfo.labelId = labelList[idx]->Id_();
        tempLabelInfo.streamId = static_cast<uint16_t>(labelStream->Id_());

        RT_LOG(
            RT_LOG_DEBUG, "copy label to device, label_id=%hu, model_id=%hu, stream_id=%hu, label_step=%u.",
            tempLabelInfo.labelId, tempLabelInfo.modelId, tempLabelInfo.streamId, labelStep);
        if ((device->GetTschVersion() >= TS_VERSION_MORE_LABEL) || (device->IsDavidPlatform())) {
            error = labelList[idx]->SetLabelDevAddr(devAddr);
            ERROR_RETURN_MSG_INNER(
                error,
                "Label list copy failed, have same labels in label list, label_id=%hu,"
                " model_id=%hu, label_step=%u, retCode=%#x",
                tempLabelInfo.labelId, tempLabelInfo.modelId, labelStep, error);
        } else if (device->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = device->Driver_()->MemCopySync(
                devAddr, static_cast<uint64_t>(labelStep), static_cast<void*>(&tempLabelInfo),
                static_cast<uint64_t>(labelStep), RT_MEMCPY_HOST_TO_DEVICE);
            ERROR_RETURN_MSG_INNER(
                error,
                "Label list copy failed, mem copy stream label info failed, label_id=%hu,"
                " model_id=%hu, label_step=%u, retCode=%#x",
                tempLabelInfo.labelId, tempLabelInfo.modelId, labelStep, error);
            (void)device->Driver_()->DevMemFlushCache(RtPtrToValue<void*>(devAddr), static_cast<size_t>(labelStep));
        } else {
            error = device->Driver_()->MemCopySync(
                devAddr, static_cast<uint64_t>(labelStep), static_cast<void*>(&tempLabelInfo),
                static_cast<uint64_t>(labelStep), RT_MEMCPY_DEVICE_TO_DEVICE);
            ERROR_RETURN_MSG_INNER(
                error,
                "Label list copy failed, mem copy stream label info failed, label_id=%u,"
                " model_id=%u, label_step=%u, retCode=%#x",
                tempLabelInfo.labelId, tempLabelInfo.modelId, labelStep, error);
        }
        devAddr = RtPtrToPtr<void*, uintptr_t>(RtPtrToPtr<uintptr_t, void*>(devAddr) + labelStep);
    }

    return error;
}

} // namespace runtime
} // namespace cce
