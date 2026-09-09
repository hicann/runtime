/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profiler_c.hpp"

#include <cinttypes>

#include "context.hpp"
#include "device.hpp"
#include "inner_thread_local.hpp"
#include "profiling_task.h"
#include "stream.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {

rtError_t ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags, Stream* const stm)
{
    Device* const device = stm->Device_();
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtProfTraceTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_PROFILER_TRACE, errorReason);
    NULL_PTR_RETURN_MSG(rtProfTraceTask, errorReason);

    error = ProfilerTraceTaskInit(rtProfTraceTask, id, notifyFlag, flags);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE,
        "Failed to init profiler trace task, id=%" PRIu64 ", notifyFlag=%d, flags=%u, retCode=%#x.", id,
        static_cast<int32_t>(notifyFlag), flags, error);

    error = device->SubmitTask(rtProfTraceTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit profiler trace task, retCode=%#x.", error);

    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtProfTraceTask);
    return error;
}

rtError_t ProfTraceEx(
    const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream* stm, const Context* const ctx)
{
    RT_LOG(RT_LOG_INFO, "id=%" PRIu64 ", modelId=%" PRIu64 ", tagId=%hu, streamId=%d.", id, modelId, tagId, stm->Id_());

    if (stm->Id_() == MAX_INT32_NUM) {
        if (ctx->OnlineStream_() != nullptr) {
            stm = ctx->OnlineStream_();
            RT_LOG(RT_LOG_DEBUG, "use online stream for model execute, model_id=%" PRIu64, modelId);
        } else {
            stm = ctx->DefaultStream_();
            NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
            RT_LOG(RT_LOG_DEBUG, "use default stream for model execute, model_id=%" PRIu64, modelId);
        }
    }

    Device* const device = stm->Device_();
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtProfTraceExTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_PROFILER_TRACE_EX, errorReason);
    NULL_PTR_RETURN_MSG(rtProfTraceExTask, errorReason);

    error = ProfilerTraceExTaskInit(rtProfTraceExTask, id, modelId, tagId);
    ERROR_GOTO(
        error, ERROR_RECYCLE,
        "Failed to init ProfilerTraceExTask, id=%" PRIu64 ", model_id=%" PRIu64 ", tag_id=%hu, retCode=%#x.", id,
        modelId, tagId, error);

    error = device->SubmitTask(rtProfTraceExTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit ProfilerTraceExTask, retCode=%#x.", error);
    GET_THREAD_TASKID_AND_STREAMID(rtProfTraceExTask, stm->Id_());
    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtProfTraceExTask);
    return error;
}

} // namespace runtime
} // namespace cce
