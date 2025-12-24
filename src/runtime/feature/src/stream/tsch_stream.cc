/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tsch_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
TschStream::TschStream(Device * const dev, const uint32_t prio, const RtSqAllocType type) : Stream(dev, prio, 0U),
    type_(type)
{
}

rtError_t TschStream::Setup()
{
    rtError_t error = device_->Driver_()->StreamIdAlloc(&streamId_, device_->Id_(), device_->DevGetTsId(), priority_);
    device_->GetStreamSqCqManage()->SetStreamIdToStream(static_cast<uint32_t>(streamId_), this);
    ERROR_RETURN(error, "Failed to alloc stream id, retCode=%#x.", error);

    RT_LOG(RT_LOG_DEBUG, "Alloc stream, stream_id=%d", streamId_);

    /**** alloc sq cq id *****/
    const auto stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());

    uint32_t tmpSqId = 0U;
    uint32_t tmpCqId = 0U;
    error = stmSqCqManage->AllocStreamSqCq(this, priority_, static_cast<uint32_t>(TSDRV_FLAG_ONLY_SQCQ_ID),
                                           tmpSqId, tmpCqId);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "[SqCqManage]Alloc sq cq fail, stream_id=%d, retCode=%#x.",
            streamId_, static_cast<uint32_t>(error));
        device_->GetStreamSqCqManage()->DelStreamIdToStream(static_cast<uint32_t>(streamId_));
        (void)device_->Driver_()->StreamIdFree(streamId_, device_->Id_(), device_->DevGetTsId());
        streamId_ = -1;
        return error;
    }
    sqId_ = tmpSqId;
    cqId_ = tmpCqId;
    RT_LOG(RT_LOG_INFO, "stream setup end, stream_id=%d, type=%d, IsTaskSink=%d, sqId=%u, cqId=%u, deviceId=%u "
           "streamResId=%u", streamId_, type_, static_cast<int32_t>(IsTaskSink()), sqId_, cqId_, device_->Id_(),
           streamResId);
    return RT_ERROR_NONE;
}

rtError_t TschStream::AllocDsaSqAddr() const
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    auto * const factory = device_->GetTaskFactory();

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    Stream* stm = device_->GetCtrlStream(device_->PrimaryStream_());
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    TaskInfo *tsk = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_ALLOC_DSA_ADDR, errorReason);
    NULL_PTR_RETURN(tsk, errorReason);

    rtError_t error = AllocDsaAddrTaskInit(tsk, static_cast<uint16_t>(sqId_));
    ERROR_GOTO(error, ERROR_TASK, "Failed to init create ringbuffer task.");

    error = device_->SubmitTask(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to SubmitTask task.");
    error = stm->GetError();
    return error;
ERROR_TASK:
    (void)factory->Recycle(tsk);
    return error;
}

}  // namespace runtime
}  // namespace cce
