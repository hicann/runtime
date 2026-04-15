/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cond_c.hpp"
#include "context/context.hpp"
#include "stream.hpp"
#include "task/task_info.hpp"
#include "stream_task.h"
#include "error_message_manage.hpp"
#include "rt_log.h"
#include "task/task.hpp"
#include "common/inner_thread_local.hpp"

namespace cce {
namespace runtime {

rtError_t CondStreamSwitchEx(
    const void* const ptr, const rtCondition_t condition, const void* const valuePtr, const Stream* const trueStream,
    Stream* const stm, const rtSwitchDataType_t dataType, Context* const ctx)
{
    Context* curCtx = ctx;
    if (curCtx == nullptr) {
        curCtx = stm->Context_();
    }
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_STREAM_CONTEXT);

    rtError_t error;
    const int32_t streamId = stm->Id_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtStreamSwitchTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_SWITCH, errorReason);
    NULL_PTR_RETURN_MSG(rtStreamSwitchTask, errorReason);

    error = StreamSwitchTaskInitV2(rtStreamSwitchTask, ptr, condition, trueStream, valuePtr, dataType);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Stream switch task init failed, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtStreamSwitchTask->id, error);

    error = curCtx->Device_()->SubmitTask(rtStreamSwitchTask, curCtx->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream switch task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtStreamSwitchTask, streamId);

    return error;

ERROR_RECYCLE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(rtStreamSwitchTask);
    return error;
}

rtError_t CondStreamSwitchN(
    const void* const ptr, const uint32_t size, const void* const valuePtr, Stream** const trueStreamPtr,
    const uint32_t elementSize, Stream* const stm, const rtSwitchDataType_t dataType, Context* const ctx)
{
    Context* curCtx = ctx;
    if (curCtx == nullptr) {
        curCtx = stm->Context_();
    }
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_STREAM_CONTEXT);

    NULL_PTR_RETURN_MSG_OUTER(trueStreamPtr, RT_ERROR_STREAM_NULL);

    rtError_t error;
    StreamSwitchNLoadResult result;
    ArgLoader* const devArgLdr = curCtx->Device_()->ArgLoader_();
    const int32_t streamId = stm->Id_();

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtStreamSwitchNTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_SWITCH_N, errorReason);
    NULL_PTR_RETURN_MSG(rtStreamSwitchNTask, errorReason);

    error = devArgLdr->LoadStreamSwitchNArgs(
        stm, valuePtr, size * elementSize, trueStreamPtr, elementSize, dataType, &result);

    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream switchN args load failed, retCode=%#x", error);

    error = StreamSwitchNTaskInit(
        rtStreamSwitchNTask, ptr, size, result.valuePtr, result.trueStreamPtr, elementSize, dataType);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Stream switchN task init failed, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtStreamSwitchNTask->id, error);

    error = curCtx->Device_()->SubmitTask(rtStreamSwitchNTask, curCtx->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream switchN task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtStreamSwitchNTask, streamId);

    return error;

ERROR_RECYCLE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(rtStreamSwitchNTask);
    return error;
}

rtError_t CondStreamActive(const Stream* const activeStream, Stream* const stm, Context* const ctx, const bool alreadyCascaded)
{
    UNUSED(alreadyCascaded);
    Context* curCtx = ctx;
    if (curCtx == nullptr) {
        curCtx = stm->Context_();
    }
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_STREAM_CONTEXT);

    rtError_t error;
    TaskInfo* tsk = nullptr;
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    const uint32_t activeStreamId = static_cast<uint32_t>(activeStream->Id_());
    const uint32_t activeStrFlag = activeStream->Flags();
    const uint32_t strFlag = stm->Flags();
    const int32_t streamId = stm->Id_();

    RT_LOG(
        RT_LOG_INFO, "active_stream flags=%u, active_stream_id=%u, stream flags=%u, stream_id=%d.", activeStrFlag,
        activeStreamId, strFlag, streamId);
    if ((((strFlag & RT_STREAM_AICPU) == 0U) && ((activeStrFlag & RT_STREAM_AICPU) != 0U)) ||
        ((strFlag & RT_STREAM_AICPU) != 0U)) {
        Model* mdl = stm->Model_();
        NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODEL_NULL);
        const void* const funcName = mdl->GetDevString(RT_DEV_STRING_ACTIVE_STREAM);
        void* args = nullptr;

        tsk = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_ACTIVE_AICPU_STREAM, errorReason);
        NULL_PTR_RETURN_MSG(tsk, errorReason);

        error = mdl->MallocDevValue(&activeStreamId, static_cast<uint32_t>(sizeof(int32_t)), &args);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Active task malloc device value failed, retCode=%#x.", error);

        (void)ActiveAicpuStreamTaskInit(
            tsk, RtPtrToValue<void*>(args), static_cast<uint32_t>(sizeof(int32_t)), RtPtrToValue<const void*>(funcName),
            TS_AICPU_KERNEL_CCE);

        mdl->PushbackArgActiveStream(args);
    } else {
        tsk = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STREAM_ACTIVE, errorReason);
        NULL_PTR_RETURN_MSG(tsk, errorReason);

        error = StreamActiveTaskInit(tsk, activeStream);
        ERROR_GOTO_MSG_INNER(
            error, ERROR_RECYCLE, "Active task init failed, stream_id=%d, task_id=%hu, retCode=%#x", streamId, tsk->id,
            error);
    }

    error = curCtx->Device_()->SubmitTask(tsk, curCtx->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Active task submit ActiveAicpuStreamTask or StreamActiveTask failed, retCode=%#x.",
        error);

    GET_THREAD_TASKID_AND_STREAMID(tsk, streamId);
    return error;

ERROR_RECYCLE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(tsk);
    return error;
}

} // namespace runtime
} // namespace cce
