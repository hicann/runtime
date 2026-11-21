/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device/device_error_proc.hpp"
#include <memory>
#include <string>
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "task_submit.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "stream_sqcq_manage.hpp"
#include "stub_task.hpp"
#include "context_manage.hpp"
#include "davinci_kernel_task.h"
#include "npu_driver.hpp"
#include "ringbuffer_maintain_task.h"
#include "aicpu_timeout_manager.h"
#include "ffts_task.h"

namespace cce {
namespace runtime {

void UpdateDvppErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.dvppErrorInfo.streamId == UINT16_MAX) {
        errorInfo->u.dvppErrorInfo.streamId = static_cast<uint16_t>(streamId);
    }
}

void UpdateSqeErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.sqeErrorInfo.streamId == UINT16_MAX) {
        errorInfo->u.sqeErrorInfo.streamId = static_cast<uint16_t>(streamId);
    }
}

void UpdateWaitTimeoutErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.timeoutErrorInfo.streamId == UINT16_MAX) {
        errorInfo->u.timeoutErrorInfo.streamId = static_cast<uint16_t>(streamId);
    }
}

void UpdateAicpuErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.aicpuErrorInfo.comm.streamId == UINT16_MAX) {
        errorInfo->u.aicpuErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
    }

    const uint16_t type = errorInfo->u.aicpuErrorInfo.comm.type;
    /* aicpu error by topic scheduler */
    if (type == static_cast<uint16_t>(AICPU_ERROR)) {
        if (errorInfo->u.aicpuErrorInfo.aicpu.rspErrorInfo.streamId == UINT16_MAX) {
            errorInfo->u.aicpuErrorInfo.aicpu.rspErrorInfo.streamId = streamId;
        }
    }
}

void UpdateCommErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.coreErrorInfo.comm.streamId == UINT16_MAX) {
        errorInfo->u.coreErrorInfo.comm.streamId = static_cast<uint16_t>(streamId);
    }
}

void DeviceErrorProc::UpdateDeviceErrorInfo(
    const RingBufferElementInfo* const info, StarsDeviceErrorInfo* const errorInfo) const
{
    if ((info == nullptr) || (errorInfo == nullptr)) {
        return;
    }

    uint32_t streamId = 0U;
    const rtError_t error = device_->GetStreamSqCqManage()->GetStreamIdBySqId(info->sqId, streamId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_DEBUG, "Get streamId by sqId failed, sqId=%u, retCode=%#x.", info->sqId, error);
        return;
    }

    // 这个是异常流程，这里记录sqId和streamId，用于和后续日志对账
    RT_LOG(
        RT_LOG_ERROR, "Get streamId by sqId success, deviceId=%u, sqId=%u, streamId=%u.", device_->Id_(), info->sqId,
        streamId);

    std::map<uint64_t, ErrorInfoUpdateProc> hookMap;
    UpdateDeviceErrorInfoHookFunc(hookMap);
    const auto it = hookMap.find(info->errorType);
    if (it != hookMap.end()) {
        it->second(errorInfo, streamId);
    }
}

} // namespace runtime
} // namespace cce