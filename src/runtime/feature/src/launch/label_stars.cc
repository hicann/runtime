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
#include "stream.hpp"
#include "task/task_info.hpp"
#include "error_message_manage.hpp"
#include "task/task.hpp"
#include "common/inner_thread_local.hpp"

namespace cce {
namespace runtime {

rtError_t CondLabelSwitchByIndex(void* const ptr, const uint32_t maxIndex, void* const labelInfoPtr, Stream* const stm)
{
    const int32_t streamId = stm->Id_();
    Context* ctx = stm->Context_();
    COND_RETURN_ERROR_MSG_INNER(ctx == nullptr, RT_ERROR_STREAM_CONTEXT, "Get stream context failed, stream_id=%d.",
        streamId);

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtStreamLabelSwitchIndexTask =
        stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, errorReason);
    NULL_PTR_RETURN_MSG(rtStreamLabelSwitchIndexTask, errorReason);

    rtError_t error = StreamLabelSwitchByIndexTaskInit(rtStreamLabelSwitchIndexTask, ptr, maxIndex, labelInfoPtr);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Stream label switch by index task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStreamLabelSwitchIndexTask->id, error);

    error = ctx->Device_()->SubmitTask(rtStreamLabelSwitchIndexTask, ctx->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream label switch by index task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtStreamLabelSwitchIndexTask, streamId);
    return error;

ERROR_RECYCLE:
    (void)ctx->Device_()->GetTaskFactory()->Recycle(rtStreamLabelSwitchIndexTask);
    return error;
}

} // namespace runtime
} // namespace cce
