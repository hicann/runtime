/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "coprocessor_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
CoprocessorStream::CoprocessorStream(Device * const dev, const uint32_t prio, const uint32_t stmFlags)
    : Stream(dev, prio, stmFlags)
{
}

rtError_t CoprocessorStream::Setup()
{
    rtError_t error =
        device_->Driver_()->StreamIdAlloc(&streamId_, device_->Id_(), device_->DevGetTsId(), priority_, flags_);
    device_->GetStreamSqCqManage()->SetStreamIdToStream(static_cast<uint32_t>(streamId_), this);
    ERROR_RETURN(error, "Failed to alloc coprocessor stream id, retCode=%#x.", error);
    RT_LOG(RT_LOG_DEBUG, "Alloc coprocessor stream, stream_id=%d", streamId_);

    /**** alloc sq cq id *****/
    const auto stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());
    uint32_t tmpSqId = 0U;
    uint32_t tmpCqId = 0U;

    constexpr uint32_t drvFlag = static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID);
    error = stmSqCqManage->AllocStreamSqCq(this, priority_, drvFlag, tmpSqId, tmpCqId);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "[SqCqManage]Alloc coprocessor sq cq fail, stream_id=%d, retCode=%#x.",
            streamId_, static_cast<uint32_t>(error));
        device_->GetStreamSqCqManage()->DelStreamIdToStream(static_cast<uint32_t>(streamId_));
        (void)device_->Driver_()->StreamIdFree(streamId_, device_->Id_(), device_->DevGetTsId(), flags_);
        streamId_ = -1;
        return error;
    }
    // drv need support mc2 logic cq bind
    if (device_->IsStarsPlatform() &&
        device_->CheckFeatureSupport(TS_FEATURE_MC2_ENHANCE)) {
        error = AllocLogicCq(Runtime::Instance()->GetDisableThread(), device_->IsStarsPlatform(),
            stmSqCqManage, drvFlag);
        ERROR_RETURN(error, "Failed to alloc coprocessor stream logic cq, retCode=%#x.", error);
    }
    sqId_ = tmpSqId;
    cqId_ = tmpCqId;
    RT_LOG(RT_LOG_INFO, "Coprocessor stream setup end, stream_id=%d, sqId=%u, cqId=%u, deviceId=%u",
           streamId_, sqId_, cqId_, device_->Id_());
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
