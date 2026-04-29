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
#include "task_david.hpp"
#include "stream_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "rt_log.h"
#include "cmo_task.h"

namespace cce {
namespace runtime {

rtError_t CmoTaskLaunch(const rtCmoTaskInfo_t* const taskInfo, Stream* const stm, const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_STREAM_NULL);
    if (stm->Model_() != nullptr) {
        RT_LOG(RT_LOG_WARNING, "CMO task stream does not support in model.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const int32_t streamId = stm->Id_();
    TaskInfo* rtCmoTask = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to check stream, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    Stream* dstStm = stm;
    std::function<void()> const errRecycle = [&rtCmoTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtCmoTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtCmoTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to allocate CMO task, stream_id=%d, retCode=%#x.",
                                                           streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtCmoTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    // must be original stream
    error = CmoTaskInit(rtCmoTask, taskInfo, stm, flag);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to initialize CMO task, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    rtCmoTask->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(rtCmoTask, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit CMO task, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), rtCmoTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
