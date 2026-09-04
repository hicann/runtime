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
#include "capture_model_utils.hpp"
#include "internal_error_define.hpp"
#include "stars.hpp"
#include "logic_sq.hpp"
#include "logic_sq_manage.hpp"
#include <securec.h>
#include <vector>

namespace cce {
namespace runtime {

rtError_t CaptureModel::BindSqCqAndSendSqe(void)
{
    rtError_t error = RebuildAllExternalTaskSqes();
    ERROR_RETURN_MSG_INNER(
        error, "Rebuild external task SQE failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = SendSqe();
    ERROR_RETURN_MSG_INNER(error, "Send sqe failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindSqCq();
    ERROR_RETURN_MSG_INNER(error, "Bind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindStreamToModel();
    ERROR_RETURN_MSG_INNER(
        error, "Bind stream to model failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = ConfigLogicSqTail();
    ERROR_RETURN_MSG_INNER(
        error, "Config sq tail failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t UpdateHostSqeBufferByTask(TaskInfo* const task)
{
    if ((task == nullptr) || (task->stream == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    uint8_t* sqeAddr = task->stream->GetHostSqeAddrByPos(task->pos);
    if (sqeAddr == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "Get host sqe addr failed, stream_id=%d, task_id=%u, task_pos=%u", task->stream->Id_(),
            task->id, task->pos);
        return RT_ERROR_INVALID_VALUE;
    }
    const uint32_t sendSqeNum = GetSendSqeNum(task);
    const size_t sqeSize = sizeof(rtStarsSqe_t) * static_cast<size_t>(sendSqeNum);
    std::vector<rtStarsSqe_t> sqes(sendSqeNum);
    ToConstructSqe(task, sqes.data());
    const errno_t ret = memcpy_s(sqeAddr, sqeSize, sqes.data(), sqeSize);
    if (ret != EOK) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

size_t GetExternalRecordRefreshEntrySize(void) { return sizeof(RtStarsWriteValuePtrDst); }

rtError_t FillExternalRecordRefreshEntry(void* const entry, uint64_t eventAddr)
{
    if (entry == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    auto* const recordEntry = RtPtrToPtr<RtStarsWriteValuePtrDst*>(entry);
    *recordEntry = {};
    recordEntry->snoop = 0U;
    recordEntry->awcache = 2U;
    recordEntry->awprot = 0U;
    recordEntry->va = 1U;
    recordEntry->write_addr_low = static_cast<uint32_t>(eventAddr & MASK_32_BIT);
    recordEntry->write_addr_high = static_cast<uint32_t>((eventAddr >> UINT32_BIT_NUM) & MASK_17_BIT);
    recordEntry->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    recordEntry->write_value_part[0] = 1U;
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BindJettyForUbdma() { return RT_ERROR_NONE; }

rtError_t CaptureModel::RecycleAllJetty(uint32_t& h2dCount, uint32_t& d2dInBoardCount, uint32_t& d2dCrossBoardCount)
{
    h2dCount = 0;
    d2dInBoardCount = 0;
    d2dCrossBoardCount = 0;
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseAllJetty() { return RT_ERROR_NONE; }
} // namespace runtime
} // namespace cce
