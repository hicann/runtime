/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cond_c.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "profiler_c.hpp"
#include "memory_task.h"
#include "stream_david.hpp"

namespace cce {
namespace runtime {

static rtError_t CondStreamActiveForAicpuStream(const Stream * const activeStream, Stream * const stm)
{
    Model *mdl = stm->Model_();
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODEL_NULL);
    const void * const funcName = mdl->GetDevString(RT_DEV_STRING_ACTIVE_STREAM);
    const uint32_t activeStreamId = static_cast<uint32_t>(activeStream->Id_());
    void *args = nullptr;
    TaskInfo taskSubmit = {};
    TaskInfo *tsk = &taskSubmit;
    tsk->stream = stm;
    rtError_t error = mdl->MallocDevValue(&activeStreamId, static_cast<uint32_t>(sizeof(int32_t)), &args);
    ERROR_RETURN_MSG_INNER(error, "Active task malloc device value failed, retCode=%#x.", static_cast<uint32_t>(error));

    (void)ActiveAicpuStreamTaskInit(tsk, RtPtrToValue<void *>(args),
            static_cast<uint32_t>(sizeof(int32_t)), RtPtrToValue<const void *>(funcName), TS_AICPU_KERNEL_CCE);

    mdl->PushbackArgActiveStream(args);
    error = ProcAicpuTask(tsk);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk);,
        "Active task submit ActiveAicpuStreamTask failed, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CondStreamActive(const Stream * const activeStream, Stream * const stm, Context * const ctx)
{
    UNUSED(ctx);
    const uint32_t activeStreamId = static_cast<uint32_t>(activeStream->Id_());
    const uint32_t activeStrFlag = activeStream->Flags();
    const uint32_t strFlag = stm->Flags();
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "active_stream flags=%u, active_stream_id=%u, stream flags=%u, stream_id=%d.",
        activeStrFlag, activeStreamId, strFlag, streamId);
    if ((strFlag & RT_STREAM_AICPU) != 0U) {
        return CondStreamActiveForAicpuStream(activeStream, stm);
    }
    if ((activeStrFlag & RT_STREAM_AICPU) != 0U) {
        Model *mdl = stm->Model_();
        NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODEL_NULL);
        RT_LOG(RT_LOG_INFO, "no process flags=%u, active_stream_id=%u, stream flags=%u, stream_id=%d.",
        activeStrFlag, activeStreamId, strFlag, streamId);
        return RT_ERROR_NONE;
    }
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo *tsk = nullptr;
    std::function<void()> const errRecycle = [&tsk, &stm, &pos]() {
        TaskUnInitProc(tsk);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&tsk, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, stm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = StreamActiveTaskInit(tsk, activeStream);
    ERROR_RETURN_MSG_INNER(error, "Active task init failed, stream_id=%d, pos=%u, retCode=%#x",
        streamId, pos, static_cast<uint32_t>(error));
    error = DavidSendTask(tsk, stm);
    ERROR_RETURN_MSG_INNER(error, "Active task submit task failed, stream_id=%d, pos=%u, retCode=%#x.",
        streamId, pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(streamId, tsk->taskSn);
    return error;
}

rtError_t CondStreamSwitchEx(const void * const ptr, const rtCondition_t condition, const void * const valuePtr,
    const Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType,
    Context * const ctx)
{
    UNUSED(ctx);
    const int32_t streamId = stm->Id_();
    TaskInfo *rtStreamSwitchTask = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&rtStreamSwitchTask, &stm, &pos]() {
        TaskUnInitProc(rtStreamSwitchTask);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&rtStreamSwitchTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtStreamSwitchTask, stm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = StreamSwitchTaskInitV2(rtStreamSwitchTask, ptr, condition, trueStream, valuePtr, dataType);
    ERROR_RETURN_MSG_INNER(error, "Stream switch task init failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    error = DavidSendTask(rtStreamSwitchTask, stm);
    ERROR_RETURN_MSG_INNER(error, "Active task submit task failed, stream_id=%d, pos=%u, retCode=%#x.",
        streamId, pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(streamId, rtStreamSwitchTask->taskSn);
    return error;
}

rtError_t CondStreamSwitchN(const void * const ptr, const uint32_t size,
    const void * const valuePtr, Stream ** const trueStreamPtr, const uint32_t elementSize,
    Stream * const stm, const rtSwitchDataType_t dataType, Context * const ctx)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(valuePtr);
    UNUSED(trueStreamPtr);
    UNUSED(elementSize);
    UNUSED(stm);
    UNUSED(dataType);
    UNUSED(ctx);
    return RT_ERROR_NONE;
}

rtError_t CondMemWaitValue(const void * const devAddr, const uint64_t value,
    const uint32_t flag, Stream * const stm)
{
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    TaskInfo *rtMemWaitValueTask = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&rtMemWaitValueTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtMemWaitValueTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtMemWaitValueTask, stm, pos, dstStm, MEM_WAIT_V2_SQE_NUM);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtMemWaitValueTask, dstStm, pos, MEM_WAIT_V2_SQE_NUM);
    ScopeGuard tskErrRecycle(errRecycle);
    rtMemWaitValueTask->typeName = "MEM_WAIT_VALUE";
    rtMemWaitValueTask->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    error = MemWaitValueTaskInit(rtMemWaitValueTask, devAddr, value, flag);
    ERROR_RETURN_MSG_INNER(error, "Memory wait value task init failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    rtMemWaitValueTask->needPostProc = true;
    rtMemWaitValueTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtMemWaitValueTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "Memory wait value task submit task failed, stream_id=%d, pos=%u, retCode=%#x.",
        streamId, pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtMemWaitValueTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
