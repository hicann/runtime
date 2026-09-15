/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_launch_c.hpp"
#include "device.hpp"
#include "inner_thread_local.hpp"
#include "rdma_task.h"
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t RT_STARS_MODEL_RDMADB_TASK_NUM = 2U;

static rtError_t RdmaDbSendToDev(
    const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm, const uint32_t taskSqe = 0U)
{
    rtError_t error;
    const int32_t streamId = stm->Id_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtRdmaDbSendTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_RDMA_DB_SEND, errorReason);
    NULL_PTR_RETURN_MSG(rtRdmaDbSendTask, errorReason);
    Device* const device = stm->Device_();

    error = RdmaDbSendTaskInit(rtRdmaDbSendTask, dbIndex, dbInfo, taskSqe);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init RDMA DB send task, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtRdmaDbSendTask->id, static_cast<uint32_t>(error));

    error = device->SubmitTask(rtRdmaDbSendTask);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to submit RDMA DB send task, retCode=%#x.", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtRdmaDbSendTask, streamId);

    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtRdmaDbSendTask);
    return error;
}

rtError_t RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream* const stm)
{
    rtError_t error;
    const int32_t streamId = stm->Id_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtRdmaSendTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_RDMA_SEND, errorReason);
    NULL_PTR_RETURN_MSG(rtRdmaSendTask, errorReason);
    Device* const device = stm->Device_();

    error = RdmaSendTaskInit(rtRdmaSendTask, sqIndex, wqeIndex);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init RDMA send task, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtRdmaSendTask->id, static_cast<uint32_t>(error));

    error = device->SubmitTask(rtRdmaSendTask);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to submit RDMA send task, retCode=%#x.", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtRdmaSendTask, stm->AllocTaskStreamId());

    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtRdmaSendTask);
    return error;
}

rtError_t RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm, std::mutex& contextCaptureLock)
{
    rtError_t error;
    if ((Runtime::Instance()->ChipIsHaveStars()) && (stm->IsCapturing())) {
        std::lock_guard<std::mutex> lock(contextCaptureLock);
        if (stm->IsCapturing()) {
            for (uint32_t taskSeq = 0U; taskSeq < RT_STARS_MODEL_RDMADB_TASK_NUM; taskSeq++) {
                error = RdmaDbSendToDev(dbIndex, dbInfo, stm, (taskSeq + 1U));
                ERROR_RETURN(
                    error, "Failed to send RDMA DB capture model task, seq=%u, retCode=%#x.", taskSeq,
                    static_cast<uint32_t>(error));
            }
            return RT_ERROR_NONE;
        }
    }
    if ((Runtime::Instance()->ChipIsHaveStars()) && (stm->GetBindFlag())) {
        for (uint32_t taskSeq = 0U; taskSeq < RT_STARS_MODEL_RDMADB_TASK_NUM; taskSeq++) {
            error = RdmaDbSendToDev(dbIndex, dbInfo, stm, (taskSeq + 1U));
            ERROR_RETURN(
                error, "Failed to send RDMA DB model task, seq=%u, retCode=%#x.", taskSeq,
                static_cast<uint32_t>(error));
        }
    } else {
        error = RdmaDbSendToDev(dbIndex, dbInfo, stm);
        ERROR_RETURN(error, "Failed to send RDMA DB task, retCode=%#x.", static_cast<uint32_t>(error));
    }

    return error;
}

} // namespace runtime
} // namespace cce
