/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dvpp_c.hpp"
#include "stream.hpp"
#include "stream_david.hpp"
#include "task_david.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "profiler_c.hpp"

namespace cce {
namespace runtime {

// for dvpp task, submit write value task, don't update last taskId
static rtError_t StarsLaunchDvppRRProcess(Stream * const stm)
{
    const int32_t streamId = stm->Id_();
    static uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {};
    TaskInfo *writeValueTask = nullptr;
    uint32_t pos = 0xFFFFU;
    const uint64_t addr = RtPtrToValue(stm->GetDvppRRTaskAddr());
    COND_RETURN_ERROR((addr == 0ULL), RT_ERROR_MEMORY_ALLOCATION,
        "Dvpp task alloc mem failed, stream_id=%d.", streamId);
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    for (uint32_t i = 0U; i < DVPP_RR_TASK_NUM; i++) {
        writeValueTask = nullptr;
        stm->StreamLock();
        error = AllocTaskInfo(&writeValueTask, stm, pos);
        ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
            streamId, static_cast<uint32_t>(error));
        SaveTaskCommonInfo(writeValueTask, stm, pos);
        (void)WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, &(value[0U]), TASK_WR_CQE_NEVER);
        writeValueTask->stmArgPos = static_cast<DavidStream *>(stm)->GetArgPos();
        error = DavidSendTask(writeValueTask, stm);
        ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(writeValueTask);
                                    TaskRollBack(stm, pos);
                                    stm->StreamUnLock();,
                                    "dvpp task submit failed, stream_id=%d, i=%u, retCode=%#x.",
                                    streamId, i, static_cast<uint32_t>(error));
        stm->StreamUnLock();
        error = SubmitTaskPostProc(stm, pos);
        ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
            streamId, static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t StarsLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm, const uint32_t flag)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(sqeLen != sizeof(rtStarsCommonSqe_t), RT_ERROR_INVALID_VALUE, 
        sqeLen, sizeof(rtStarsCommonSqe_t));

    const int32_t streamId = stm->Id_();
    TaskInfo *starsTask = nullptr;
    const rtDavidStarsCommonSqe_t * const commonSqe = RtPtrToPtr<const rtDavidStarsCommonSqe_t * const>(sqe);
    const uint16_t sqeType = commonSqe->sqeHeader.type;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId,
        static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    std::function<void()> const errRecycle = [&starsTask, &stm, &pos]() {
        starsTask->u.starsCommTask.cmdList = {nullptr};
        TaskUnInitProc(starsTask);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&starsTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(starsTask, stm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = StarsCommonTaskInit(starsTask, *commonSqe, flag);
    ERROR_RETURN_MSG_INNER(error, "Stars common task init fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    starsTask->stmArgPos = static_cast<DavidStream *>(stm)->GetArgPos();
    error = DavidSendTask(starsTask, stm);
    ERROR_RETURN_MSG_INNER(error, "Stars common task submit fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(stm->Id_(), starsTask->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", streamId,
        static_cast<uint32_t>(error));

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
}

rtError_t LaunchMultipleTaskInfo(const rtMultipleTaskInfo_t * const multipleTaskInfo, Stream * const stm,
                                 const uint32_t flag)
{
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo *multipleTask = nullptr;
    const uint32_t sqeNum = multipleTaskInfo->taskNum;
    std::function<void()> const errRecycle = [&multipleTask, &stm, &pos]() {
        TaskUnInitProc(multipleTask);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&multipleTask, stm, pos, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(multipleTask, stm, pos, sqeNum);
    ScopeGuard tskErrRecycle(errRecycle);
    error = DavinciMultipleTaskInit(multipleTask, multipleTaskInfo, flag);
    ERROR_RETURN_MSG_INNER(error, "task init fail, stream_id=%d, retCode=%x.", streamId,
        static_cast<uint32_t>(error));
    multipleTask->stmArgPos = static_cast<DavidStream *>(stm)->GetArgPos();
    error = DavidSendTask(multipleTask, stm);
    ERROR_RETURN_MSG_INNER(error, "task send fail, stream_id=%d, retCode=%x.", streamId,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(streamId, multipleTask->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    // dvpp rr, send 3 write value task
    for (size_t idx = 0U; idx < multipleTaskInfo->taskNum; idx++) {
        if ((multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_DVPP) &&
            (multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.reserved == 1U)) {
            error = StarsLaunchDvppRRProcess(stm);
            ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(multipleTask);,
                "submit dvpp task failed, stream_id=%d, sqeType=%hu", streamId,
                multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.type);
            break;
        }
    }
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
