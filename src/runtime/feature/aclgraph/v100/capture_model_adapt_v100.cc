/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_model.hpp"
#include "context.hpp"
#include "stars.hpp"
#include <securec.h>
#include <vector>

namespace cce {
namespace runtime {

rtError_t CaptureModel::BindSqCqAndSendSqe(void)
{
    rtError_t error = RebuildExternalTaskSqes();
    ERROR_RETURN_MSG_INNER(error, "Rebuild external task SQE failed, model_id=%u, retCode=%#x.", Id_(),
        static_cast<uint32_t>(error));

    error = SendSqe();
    ERROR_RETURN_MSG_INNER(error, "Send sqe failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindSqCq();
    ERROR_RETURN_MSG_INNER(error, "Bind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindStreamToModel();
    ERROR_RETURN_MSG_INNER(error, "Bind stream to model failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    
    error = ConfigSqTail();
    ERROR_RETURN_MSG_INNER(error, "Config sq tail failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t CaptureModel::BuildActualExternalTaskSqe(TaskInfo* const task)
{
    if ((task == nullptr) || (task->stream == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (task->stream->GetSqeBuffer() == nullptr) {
        return RT_ERROR_NONE;
    }
    const uint32_t sendSqeNum = GetSendSqeNum(task);
    const size_t sqeOffset = sizeof(rtStarsSqe_t) * static_cast<size_t>(task->pos);
    const size_t sqeSize = sizeof(rtStarsSqe_t) * static_cast<size_t>(sendSqeNum);
    if ((sqeOffset + sqeSize) > task->stream->GetSqeBufferSize()) {
        return RT_ERROR_INVALID_VALUE;
    }
    std::vector<rtStarsSqe_t> sqes(sendSqeNum);
    ToConstructSqe(task, sqes.data());
    const errno_t ret = memcpy_s(task->stream->GetSqeBuffer() + sqeOffset, sqeSize, sqes.data(), sqeSize);
    if (ret != EOK) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

size_t CaptureModel::GetExternalRecordRefreshSlotSize(void) const { return sizeof(RtStarsWriteValuePtrDst); }

rtError_t CaptureModel::FillExternalRecordRefreshSlot(void* const slot, uint64_t eventAddr) const
{
    if (slot == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    auto* const recordSlot = reinterpret_cast<RtStarsWriteValuePtrDst*>(slot);
    *recordSlot = {};
    recordSlot->snoop = 0U;
    recordSlot->awcache = 2U;
    recordSlot->awprot = 0U;
    recordSlot->va = 1U;
    recordSlot->write_addr_low = static_cast<uint32_t>(eventAddr & 0xFFFFFFFFU);
    recordSlot->write_addr_high = static_cast<uint32_t>((eventAddr >> 32U) & 0x1FFFFU);
    recordSlot->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    recordSlot->write_value_part[0] = 1U;
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BindJettyForUbdma()
{
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RecycleAllJetty(uint32_t &h2dCount, uint32_t &d2dCount)
{
    h2dCount = 0;
    d2dCount = 0;
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseAllJetty()
{
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
