/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cinttypes>

#include "task_launch_c.hpp"
#include "common_task.h"
#include "device.hpp"
#include "inner_thread_local.hpp"
#include "memory_task.h"
#include "random_num_task.h"
#include "stream.hpp"
#include "stream_task.h"
#include "task.hpp"

namespace cce {
namespace runtime {

rtError_t LaunchRandomNumTask(const rtRandomNumTaskInfo_t* const taskInfo, Stream* const stm, const void* const reserve)
{
    UNUSED(reserve);
    rtError_t error = CheckRandomNumTaskInfo(taskInfo);
    ERROR_RETURN(error, "Failed to check random number task info, retCode=%#x.", static_cast<uint32_t>(error));

    const int32_t streamId = stm->Id_();
    uint32_t taskId;
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtStarsCommonTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STARS_COMMON, errorReason);
    NULL_PTR_RETURN_MSG(rtStarsCommonTask, errorReason);
    Device* const device = stm->Device_();

    rtStarsDsaSqe_t sqe = {};
    error = GetDsaSqeByRandomNumTask(taskInfo, rtStarsCommonTask, sqe);
    ERROR_RETURN_MSG_INNER(error, "Failed to get DSA SQE by random number task info, retCode=%#x.", error);

    error = StarsCommonTaskInit(rtStarsCommonTask, sqe, RT_KERNEL_DEFAULT);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init stars common task, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtStarsCommonTask->id, error);

    error = device->SubmitTask(rtStarsCommonTask, &taskId);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to submit stars common task, streamId=%d, taskId=%hu, retCode=%#x.", streamId,
        rtStarsCommonTask->id, error);

    if (rtStarsCommonTask->stream != nullptr) {
        SET_THREAD_TASKID_AND_STREAMID(rtStarsCommonTask->stream->Id_(), taskId);
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtStarsCommonTask);
    return error;
}

rtError_t LaunchSqeUpdateTask(
    const void* const src, const uint64_t cpySize, const uint32_t sqId, const uint32_t pos, Stream* const stm)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;

    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        stm, RT_ERROR_INVALID_VALUE, "Delivering the Submission Queue Entry (SQE) update task");

    TaskInfo* rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    Device* const device = stm->Device_();
    rtError_t error = MemcpyAsyncD2HTaskInit(rtMemcpyAsyncTask, src, cpySize, sqId, pos);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "MemcpyAsyncD2HTaskInit failed, device_id=%u, exe_stream_id=%d, dsa_sq_id=%u, dsa_pos=%u, "
            "cpySize=%#" PRIx64 " bytes, retCode=%#x.",
            device->Id_(), stm->Id_(), sqId, pos, cpySize, static_cast<uint32_t>(error));
        goto ERROR_RECYCLE;
    }

    error = device->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Submit memcpy async D2H task failed, device_id=%u, exe_stream_id=%d, dsa_sq_id=%u, dsa_pos=%u, "
            "cpySize=%#" PRIx64 " bytes, retCode=%#x.",
            device->Id_(), stm->Id_(), sqId, pos, cpySize, static_cast<uint32_t>(error));
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t SetStreamSqLockUnlock(Stream* const stm, const bool isLock)
{
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtSetSqLockUnlockTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, errorReason);
    NULL_PTR_RETURN(rtSetSqLockUnlockTask, errorReason);
    Device* const device = stm->Device_();

    rtError_t error = SqLockUnlockTaskInit(rtSetSqLockUnlockTask, isLock);
    const int32_t streamId = stm->Id_();
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Failed to init SQ lock/unlock task, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtSetSqLockUnlockTask->id, error);

    error = device->SubmitTask(rtSetSqLockUnlockTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit SQ lock/unlock task, retCode=%#x.", error);

    GET_THREAD_TASKID_AND_STREAMID(rtSetSqLockUnlockTask, streamId);

    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtSetSqLockUnlockTask);
    return error;
}

rtError_t SetUpdateAddrTask(const uint64_t devAddr, const uint64_t len, Stream* const stm)
{
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtUpdateAddressTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_UPDATE_ADDRESS, errorReason);
    NULL_PTR_RETURN(rtUpdateAddressTask, errorReason);
    Device* const device = stm->Device_();

    rtError_t error = UpdateAddressTaskInit(rtUpdateAddressTask, devAddr, len);
    const int32_t streamId = stm->Id_();
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Failed to init UpdateAddressTask, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtUpdateAddressTask->id, static_cast<uint32_t>(error));

    error = device->SubmitTask(rtUpdateAddressTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit UpdateAddressTask, retCode=%#x.", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtUpdateAddressTask, streamId);

    return error;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtUpdateAddressTask);
    return error;
}

} // namespace runtime
} // namespace cce
