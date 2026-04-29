/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dvpp_c.hpp"
#include "davinci_kernel_task.h"
#include "stream.hpp"
#include "context/context.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "profiler_c.hpp"
namespace cce {
namespace runtime {
// for dvpp task, submit write value task
// don't update last taskId
rtError_t StarsLaunchDvppRRProcess(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    const int32_t streamId = stm->Id_();
    static uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {};
    TaskInfo *writeValueTask;
    Device* const dev = stm->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint64_t addr = RtPtrToValue<void *>(stm->GetDvppRRTaskAddr());
    COND_RETURN_ERROR((addr == 0ULL), RT_ERROR_MEMORY_ALLOCATION,
        "Dvpp task alloc mem failed, stream_id=%d.", streamId);
    for (uint32_t i = 0U; i < DVPP_RR_TASK_NUM; i++) {
        TaskInfo submitTask = {};
        rtError_t errorReason;

        writeValueTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_WRITE_VALUE, errorReason);
        NULL_PTR_RETURN_MSG(writeValueTask, errorReason);

        (void)WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, &(value[0U]), TASK_WR_CQE_NEVER);

        error = dev->SubmitTask(writeValueTask);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "dvpp task submit failed, stream_id=%d, i=%u", streamId, i);
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(writeValueTask);
    return error;
}

rtError_t StarsLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm, const uint32_t flag)
{
    const int32_t streamId = stm->Id_();
    uint32_t taskId;

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(sqeLen != sizeof(rtStarsCommonSqe_t), RT_ERROR_INVALID_VALUE, 
        sqeLen, sizeof(rtStarsCommonSqe_t));
    Device* const dev = stm->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtStarsCommonTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STARS_COMMON, errorReason);
    NULL_PTR_RETURN_MSG(rtStarsCommonTask, errorReason);

    auto commonSqe = RtPtrToPtr<rtStarsCommonSqe_t *>(RtPtrToUnConstPtr<void *>(sqe));
    const uint16_t sqeType = commonSqe->sqeHeader.type;

    rtError_t error = StarsCommonTaskInit(rtStarsCommonTask, *commonSqe, flag);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Stars common task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStarsCommonTask->id, error);

    error = dev->SubmitTask(rtStarsCommonTask, nullptr, &taskId);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "task submit failed, streamId=%d, taskId=%hu, sqeType=%hu, retCode=%#x",
        streamId, rtStarsCommonTask->id, sqeType, error);

    SET_THREAD_TASKID_AND_STREAMID(streamId, taskId);

    // reserved: this field is used only in the DVPP scenario.
    //           1: need to send three write-value tasks, 0: no need to send three write-value tasks.
    //           will be restored to 0 when construct sqe.
    if ((commonSqe->sqeHeader.reserved == 1U) && IsDvppTask(sqeType)) {
        error = StarsLaunchDvppRRProcess(stm);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "submit dvpp task failed, stream_id=%d, sqeType=%hu", streamId, sqeType);
        }
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    // When an error occurs, the dvpp releases the cmdlist memory.
    rtStarsCommonTask->u.starsCommTask.cmdList = {nullptr};
    (void)dev->GetTaskFactory()->Recycle(rtStarsCommonTask);
    return error;
}

rtError_t LaunchMultipleTaskInfo(const rtMultipleTaskInfo_t * const multipleTaskInfo, Stream * const stm,
    const uint32_t flag)
{
    uint32_t taskId = 0;
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *multipleTask = nullptr;
    const int32_t streamId = stm->Id_();
    Device* const dev = stm->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    multipleTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MULTIPLE_TASK,
                                  errorReason, multipleTaskInfo->taskNum);
    NULL_PTR_RETURN_MSG(multipleTask, errorReason);

    error = DavinciMultipleTaskInit(multipleTask, multipleTaskInfo, flag);
    ERROR_PROC_RETURN_MSG_INNER(error, (void)dev->GetTaskFactory()->Recycle(multipleTask);,
        "DavinciMultipleTaskInit fail, stream_id=%d, retCode=%x", streamId, error);

    error = dev->SubmitTask(multipleTask, nullptr, &taskId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to submit kernel task, stream_id=%d, retCode=%x", streamId, error);

        // When an error occurs, the dvpp releases the cmdlist memory.
        ResetCmdList(multipleTask);
        (void)dev->GetTaskFactory()->Recycle(multipleTask);
        return error;
    }
    SET_THREAD_TASKID_AND_STREAMID(streamId, taskId);

    // dvpp rr, send 3 write value task
    for (size_t idx = 0U; idx < multipleTaskInfo->taskNum; idx++) {
        if ((multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_DVPP) &&
            (multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.reserved == 1U)) {
            error = StarsLaunchDvppRRProcess(stm);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "submit dvpp task failed, stream_id=%d, sqeType=%hu", streamId,
                    multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.type);
                (void)dev->GetTaskFactory()->Recycle(multipleTask);
            }
            break;
        }
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce