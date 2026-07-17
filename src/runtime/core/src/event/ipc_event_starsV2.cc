/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ipc_event.hpp"
#include "task_david.hpp"
#include "common/internal_error_define.hpp"
#include "inner_thread_local.hpp"
#include "thread_local_container.hpp"
#include "common_task.h"
namespace cce {
namespace runtime {
rtError_t IpcEvent::IpcEventRecordStarsV2(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Event Record operation of cross-process IPC");
    Device * const dev = stm->Device_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to check stream, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));

    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();

    error = AllocTaskInfo(&tsk, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error,
        stm->StreamUnLock();,
        "Failed to allocate task when ipc record, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    uint16_t curIndex = 0U;
    error = GetIpcRecordIndex(&curIndex);
    ERROR_PROC_RETURN_MSG_INNER(error, 
        TaskRollBack(stm, pos);
        stm->StreamUnLock();,
        "Failed to get ipc record index. Reason: context is abort, status=%#x.", static_cast<uint32_t>(error));
    
    SaveTaskCommonInfo(tsk, stm, pos);

    uint8_t* addr = RtPtrToPtr<uint8_t*>(currentDeviceMem_) + curIndex;
    error = MemWriteValueTaskInit(tsk, RtPtrToPtr<void*>(addr), static_cast<uint64_t>(1U));
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
        IpcVaLock();
        ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]--;
        IpcEventCountSub();
        IpcVaUnLock();,
        "Failed to initialize mem write value task, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    tsk->typeName = "IPC_RECORD";
    tsk->type = TS_TASK_TYPE_IPC_RECORD;
    tsk->needPostProc = true;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->curIndex = curIndex;
    memWriteValueTask->event = this;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;

    error = DavidSendTask(tsk, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskUnInitProc(tsk);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();,
        "Failed to submit ipc record task, retCode=%#x.", static_cast<uint32_t>(error));

    stm->StreamUnLock();

    SET_THREAD_TASKID_AND_STREAMID(stm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.",
    stm->Id_(), static_cast<uint32_t>(error));

    eventStatus_ = INIT;
    RT_LOG(RT_LOG_INFO, "ipc event task submit success, device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        dev->Id_(), stm->Id_(), tsk->id, curIndex);
    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcEventWaitStarsV2(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Event Wait operation of cross-process IPC");
    Device * const dev = stm->Device_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to check stream, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));

    uint16_t curIndex;
    IpcVaLock();
    if (ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex] == 0U) {
        IpcVaUnLock();
        RT_LOG(RT_LOG_INFO, "currentIndex is zero, record finished or wait first, return success.");
        return RT_ERROR_NONE;
    }
    ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]++;
    curIndex = ipcHandleVa_->currentIndex;
    IpcEventCountAdd();
    IpcVaUnLock();

    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();

    error = AllocTaskInfo(&tsk, stm, pos, MEM_WAIT_V2_SQE_NUM);
    if (error != RT_ERROR_NONE) {
        stm->StreamUnLock();
        IpcVaLock();
        ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]--;
        IpcEventCountSub();
        IpcVaUnLock();    
        ERROR_RETURN_MSG_INNER(error, "Failed to allocate task when ipc wait, stream_id=%d, retCode=%#x.",
            stm->Id_(), static_cast<uint32_t>(error));
    }

    SaveTaskCommonInfo(tsk, stm, pos, MEM_WAIT_V2_SQE_NUM);

    uint8_t* addr = RtPtrToPtr<uint8_t*>(currentDeviceMem_) + curIndex;
    error = MemWaitValueTaskInit(tsk, RtPtrToPtr<void*>(addr), 1, 0x0);
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
        IpcVaLock();
        ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]--;
        IpcEventCountSub();
        IpcVaUnLock();,
        "Failed to initialize mem wait value task, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Id_(), tsk->id, static_cast<uint32_t>(error));

    tsk->typeName = "IPC_WAIT";
    tsk->type = TS_TASK_TYPE_IPC_WAIT;
    tsk->needPostProc = true;
    MemWaitValueTaskInfo *memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->curIndex = curIndex;
    memWaitValueTask->event = this;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;

    error = DavidSendTask(tsk, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskUnInitProc(tsk);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();,
        "Failed to submit ipc wait task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();

    SET_THREAD_TASKID_AND_STREAMID(stm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit task post proc, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "ipc wait task submit success, device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        dev->Id_(), stm->Id_(), tsk->id, curIndex);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
