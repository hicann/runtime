/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_error_proc.hpp"
#include "stream.hpp"
#include "context.hpp"
#include "runtime.hpp"
#include "task.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

static void UpdateHcclFftsPlusTimeoutErrorInfoStreamId(StarsDeviceErrorInfo* const errorInfo, const uint32_t streamId)
{
    if (errorInfo->u.hcclFftsplusTimeoutInfo.common.streamId == UINT16_MAX) {
        errorInfo->u.hcclFftsplusTimeoutInfo.common.streamId = static_cast<uint16_t>(streamId);
    }
}

void UpdateDeviceErrorInfoHookFunc(std::map<uint64_t, DeviceErrorProc::ErrorInfoUpdateProc>& funcMap)
{
    const std::map<uint64_t, DeviceErrorProc::ErrorInfoUpdateProc> starsHookMap = {
        {AICORE_ERROR, &UpdateCommErrorInfoStreamId},
        {AIVECTOR_ERROR, &UpdateCommErrorInfoStreamId},
        {FFTS_PLUS_AICORE_ERROR, &UpdateCommErrorInfoStreamId},
        {FFTS_PLUS_AIVECTOR_ERROR, &UpdateCommErrorInfoStreamId},
        {WAIT_TIMEOUT_ERROR, &UpdateWaitTimeoutErrorInfoStreamId},
        {SDMA_ERROR, &UpdateCommErrorInfoStreamId},
        {AICPU_ERROR, &UpdateAicpuErrorInfoStreamId},
        {FFTS_PLUS_SDMA_ERROR, &UpdateCommErrorInfoStreamId},
        {FFTS_PLUS_AICPU_ERROR, &UpdateAicpuErrorInfoStreamId},
        {DVPP_ERROR, &UpdateDvppErrorInfoStreamId},
        {SQE_ERROR, &UpdateSqeErrorInfoStreamId},
        {HCCL_FFTSPLUS_TIMEOUT_ERROR, &UpdateHcclFftsPlusTimeoutErrorInfoStreamId},
        {AICORE_TIMEOUT_DFX, &UpdateCommErrorInfoStreamId},
        {NOCORE_TIMEOUT_ERROR, &UpdateCommErrorInfoStreamId}};
    funcMap = starsHookMap;
    return;
}

} // namespace runtime
} // namespace cce
