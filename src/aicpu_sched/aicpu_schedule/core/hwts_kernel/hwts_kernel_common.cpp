/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_common.h"

#include <cstring>
#include "aicpusd_msg_send.h"
#include "aicpusd_drv_manager.h"

namespace {
}

namespace AicpuSchedule {
int32_t HwTsKernelCommon::ProcessEndGraph(const uint32_t modelId)
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        aicpusd_err("Receive model[%u] EndGraph msg, but no model found.", modelId);
        return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
    }
 
    auto ret = model->EndGraph();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("model[%u] endGraph failed, ret[%d].", modelId, ret);
    }
 
    bool hasWait = false;
    uint32_t waitStreamId = 0U;
    EventWaitManager::EndGraphWaitManager().Event(static_cast<size_t>(modelId), hasWait, waitStreamId);
    if (hasWait) {
        // use event to avoid pending ts response
        AICPUSubEventInfo subEventInfo = {};
        subEventInfo.modelId = modelId;
        subEventInfo.para.streamInfo.streamId = waitStreamId;
        ret = AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
            static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
            AICPU_SUB_EVENT_RECOVERY_STREAM,
            CP_DEFAULT_GROUP_ID,
            false);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to process end graph, ret[%d].", ret);
        }
    }
    return AICPU_SCHEDULE_OK;
}

}  // namespace AicpuSchedule