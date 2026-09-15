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
#include <new>
#include <string>

#include "model_c.hpp"
#include "capture_model_utils.hpp"
#include "ctrl_sq.hpp"
#include "device.hpp"
#include "error_message_manage.hpp"
#include "heterogenous.h"
#include "inner_thread_local.hpp"
#include "model_graph_task.h"
#include "notify.hpp"
#include "runtime_dump_task.h"
#include "stream.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {

rtError_t ModelDebugRegister(
    Model* const mdl, const uint32_t flag, const void* const addr, uint32_t* const streamId, uint32_t* const taskId,
    Stream* const dftStm)
{
    rtError_t error;
    uint32_t flipTaskId = 0;
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    *streamId = static_cast<uint32_t>(dftStm->Id_());
    TaskInfo* rtDbgRegTask = nullptr;

    COND_RETURN_WARN(mdl->IsDebugRegister(), RT_ERROR_DEBUG_REGISTER_FAILED, "model already debug registered!");
    Device* const device = dftStm->Device_();
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtDebugRegisterParam param = {addr, mdl->Id_(), flag};
        error = device->GetCtrlSQ().SendDebugRegisterMsg(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_REGISTER, param, &flipTaskId);
        *taskId = flipTaskId;
        *streamId = static_cast<uint32_t>(device->GetCtrlSQ().GetStream()->Id_());
        ERROR_RETURN(error, "Failed to send debug register message, retCode=%#x.", error);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        rtDbgRegTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_REGISTER, errorReason);
        NULL_PTR_RETURN_MSG(rtDbgRegTask, errorReason);

        error = DebugRegisterTaskInit(rtDbgRegTask, mdl->Id_(), addr, flag);
        ERROR_GOTO_MSG_INNER(
            error, ERROR_RECYCLE, "Failed to init debug register task, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
            *streamId, rtDbgRegTask->id, error);

        error = device->SubmitTask(rtDbgRegTask, &flipTaskId);
        *taskId = flipTaskId;
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit debug register task, retCode=%#x.", error);

        error = dftStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize debug register task, retCode=%#x.", error);
    }
    mdl->SetDebugRegister(true);
    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtDbgRegTask);
    return RT_ERROR_DEBUG_REGISTER_FAILED;
}

rtError_t ModelDebugUnRegister(Model* const mdl, Stream* const dftStm)
{
    rtError_t error;
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    const int32_t streamId = dftStm->Id_();
    TaskInfo* rtDbgUnregTask = nullptr;

    COND_RETURN_WARN(!mdl->IsDebugRegister(), RT_ERROR_DEBUG_UNREGISTER_FAILED, "model is not debug registered!");

    Device* const device = dftStm->Device_();
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtDebugUnRegisterParam param = {mdl->Id_()};
        error = device->GetCtrlSQ().SendDebugUnRegisterMsg(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_UNREGISTER, param);
        ERROR_RETURN(error, "Failed to send debug unregister message, retCode=%#x.", error);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        rtDbgUnregTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_UNREGISTER, errorReason);
        NULL_PTR_RETURN_MSG(rtDbgUnregTask, errorReason);

        error = DebugUnRegisterTaskInit(rtDbgUnregTask, mdl->Id_());
        ERROR_GOTO_MSG_INNER(
            error, ERROR_RECYCLE, "Failed to init DebugUnRegisterTask, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
            streamId, rtDbgUnregTask->id, error);

        error = device->SubmitTask(rtDbgUnregTask);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit DebugUnRegisterTask, retCode=%#x.", error);

        error = dftStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DebugUnRegisterTask, retCode=%#x.", error);
    }

    mdl->SetDebugRegister(false);
    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtDbgUnregTask);
    return RT_ERROR_DEBUG_UNREGISTER_FAILED;
}

rtError_t ModelAddEndGraph(Model* const mdl, Stream* const stm, const uint32_t flags)
{
    rtError_t error;
    Device* const device = stm->Device_();
    // rtSetSocVersion modifies ThreadLocalContainer::socType_, not Runtime::socType_.
    const uint32_t modelExecuteType = mdl->ModelExecuteType();
    if ((device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTOR_WITH_QUEUE)) &&
        (!RtIsHeterogenous())) {
        bool useAicpuExcutor = false;
#if (!defined(CFG_VECTOR_CAST))
        useAicpuExcutor = mdl->IsModelHeadStream(stm) && ((stm->Flags() & RT_STREAM_AICPU) != 0U);
#endif
        if (((flags & RT_KERNEL_DUMPFLAG) == 0U) && (modelExecuteType != EXECUTOR_AICPU) && !useAicpuExcutor) {
            RT_LOG(RT_LOG_INFO, "not submit endGraph.");
            return RT_ERROR_NONE;
        }
    }
    const uint32_t endGraphNum = mdl->EndGraphNum_();
    COND_RETURN_AND_MSG_OUTER(
        endGraphNum >= 1U, RT_ERROR_MODEL_ENDGRAPH, ErrorCode::EE1011,
        "Adding an EndGraph flag to the stream bound to the model", endGraphNum, "endGraphNum",
        "The model must have only one end graph");

    if (device->IsStarsPlatform() && (modelExecuteType != EXECUTOR_AICPU)) {
        const bool isBindThisModel = ((stm->Model_() != nullptr) && (stm->Model_()->Id_() == mdl->Id_()));
        COND_RETURN_AND_MSG_OUTER(
            !stm->IsModelStream() || (!isBindThisModel), RT_ERROR_STREAM_INVALID, ErrorCode::EE1017,
            "Adding an EndGraph flag to the stream bound to the model", "stream",
            RtFmtMsg("Stream %d must be bound to the model %u", stm->Id_(), mdl->Id_()));

        Notify* notify = nullptr;
        error = mdl->Context_()->GetCaptureModelEndGraphNotify(mdl, stm, notify);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "Failed to get capture model endgraph notify, model_id=%u, stream_id=%d",
            mdl->Id_(), stm->Id_());
        COND_RETURN_ERROR(
            notify == nullptr, RT_ERROR_NOTIFY_NEW, "Endgraph notify id is null, model_id=%u, stream_id=%d", mdl->Id_(),
            stm->Id_());

        error = notify->Record(stm);
        if (error != RT_ERROR_NONE) {
            (void)ReleaseNotify(mdl, notify);
            RT_LOG(RT_LOG_ERROR, "Notify record failed, retCode=%#x", error);
            return error;
        }

        notify->SetEndGraphModel(mdl);
        mdl->SetEndGraphNotify(notify);
        RT_LOG(RT_LOG_INFO, "notify record ok. stream_id=%d", stm->Id_());
        return RT_ERROR_NONE;
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtAddEndGraphTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_END_GRAPH, errorReason);
    NULL_PTR_RETURN_MSG(rtAddEndGraphTask, errorReason);

    (void)AddEndGraphTaskInit(
        rtAddEndGraphTask, mdl->Id_(), modelExecuteType, RtPtrToValue<const void*>(mdl->GetDevModelID()),
        RtPtrToValue<const void*>(mdl->GetDevString(RT_DEV_STRING_ENDGRAPH)), static_cast<uint8_t>(flags));

    error = device->SubmitTask(rtAddEndGraphTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AddEndGraphTask, retCode=%#x.", error);

    mdl->IncEndGraphNum();
    GET_THREAD_TASKID_AND_STREAMID(rtAddEndGraphTask, stm->Id_());
    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtAddEndGraphTask);
    return error;
}

rtError_t ModelExit(Model* const mdl, Stream* const stm)
{
    rtError_t error;
    const uint32_t modelExitNum = mdl->ModelExitNum_();
    COND_RETURN_AND_MSG_OUTER(
        modelExitNum >= 1U, RT_ERROR_MODEL_EXIT, ErrorCode::EE1011, "Model exiting", modelExitNum, "modelExitNum",
        "The model must exit only once");
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_() == nullptr, RT_ERROR_MODEL_EXIT_STREAM_UNBIND, ErrorCode::EE1017, "Model exiting", "stream",
        RtFmtMsg("Stream %d must be bound to a model", stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_()->Id_() != mdl->Id_(), RT_ERROR_MODEL_EXIT_ID, ErrorCode::EE1017, "Model exiting", "stream",
        RtFmtMsg("Stream %d must be bound to the model %u", stm->Id_(), mdl->Id_()));

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtAddModelExitTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_EXIT_GRAPH, errorReason);
    NULL_PTR_RETURN_MSG(rtAddModelExitTask, errorReason);

    (void)AddModelExitTaskInit(rtAddModelExitTask, mdl->Id_());

    Device* const device = stm->Device_();
    error = device->SubmitTask(rtAddModelExitTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AddModelExitTask, retCode=%#x.", error);

    mdl->IncModelExitNum();
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtAddModelExitTask);
    return error;
}

} // namespace runtime
} // namespace cce
