/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cmo_barrier_c.hpp"
#include "context/context.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "rt_log.h"
#include "cmo_task.h"

namespace cce {
namespace runtime {

rtError_t CmoTaskLaunch(const rtCmoTaskInfo_t* const taskInfo, Stream* const stm, const uint32_t flag)
{
    if (stm == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO task launch failed, stream is nullptr.");
        return RT_ERROR_STREAM_NULL;
    }

    Device* const dev = stm->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    Context* const curCtx = stm->Context_();

    const int32_t streamId = stm->Id_();
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtCmoTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_CMO, errorReason);
    NULL_PTR_RETURN(rtCmoTask, errorReason);

    rtError_t error = CmoTaskInit(rtCmoTask, taskInfo, stm, flag);
    ERROR_GOTO(
        error, ERROR_RECYCLE, "CMO task init failed, stream_id=%d, task_id=%hu, retCode=%#x.", streamId, rtCmoTask->id,
        error);

    error = dev->SubmitTask(rtCmoTask, (curCtx != nullptr) ? curCtx->TaskGenCallback_() : nullptr);
    ERROR_GOTO(error, ERROR_RECYCLE, "CMO task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtCmoTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(rtCmoTask);
    return error;
}

} // namespace runtime
} // namespace cce
