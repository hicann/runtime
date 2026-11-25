/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "internal_error_define.hpp"
#include "api_impl.hpp"
#include "context.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "cond_handle/cond_handle.hpp"
#include "api_handle_guard.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "../capture_session.hpp"
#include "aclgraph_cond_task.h"
#include "cond_enum_desc.hpp"
#include "capture_model_enum_desc.hpp"
#include "kernel_utils.hpp"
#include "task_enum_desc.hpp"

#define RT_DRV_FAULT_CNT 25U
#define NULL_STREAM_PTR_RETURN_MSG(STREAM) NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)

namespace cce {
namespace runtime {

rtError_t ApiImpl::StreamBeginCapture(Stream* const stm, const rtStreamCaptureMode mode, Model* const mdl)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Starting capturing tasks delivered to a stream");
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, "Stream begin capture", "stream",
        "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_OUTER(
        (stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, "Stream begin capture",
        "stream", RtFmtMsg("The default stream (stream_id=%d) cannot be used in the ACL Graph", stm->Id_()));
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->StreamBeginCapture(stm, mode, mdl);
}

rtError_t ApiImpl::StreamEndCapture(Stream* const stm, Model** const captureMdl)
{
    Stream* captureStream = stm->GetCaptureStream();
    bool isSubCaptureModel = true; // 默认是子model，对入参captureMdl 不修改。
    if ((captureStream != nullptr) && (captureStream->Model_() != nullptr)) {
        CaptureModel* captureModel = RtPtrToPtr<CaptureModel*, Model*>(captureStream->Model_());
        if ((captureModel != nullptr) && (!captureModel->IsSubCaptureModel())) {
            isSubCaptureModel = false;
            NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
                captureMdl, RT_ERROR_INVALID_VALUE, "Ending the capture of a stream");
        }
    }
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Ending the capture of a stream");
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, "Stream end capture", "stream",
        "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_OUTER(
        (stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, "stream end capture",
        "stream", RtFmtMsg("The default stream (stream_id=%d) cannot be used in the ACL Graph", stm->Id_()));

    Model* mdl = nullptr;
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    rtError_t ret = captureSession->StreamEndCapture(stm, &mdl);
    if (ret != RT_ERROR_NONE) {
        if (!isSubCaptureModel) {
            *captureMdl = nullptr;
        }
    } else {
        if (captureMdl != nullptr) {
            *captureMdl = mdl;
        }
    }
    return ret;
}

rtError_t ApiImpl::StreamBeginTaskUpdate(Stream* const stm, TaskGroup* handle)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Marking the start of the task to be updated");
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiImpl::StreamEndTaskUpdate(Stream* const stm)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Marking the end of the task to be updated");
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->StreamEndTaskUpdate(stm);
}

rtError_t ApiImpl::StreamGetCaptureInfo(
    const Stream* const stm, rtStreamCaptureStatus* const status, Model** const captureMdl)
{
    Stream* captureStream = stm->GetCaptureStream();
    const rtStreamCaptureStatus statusTmp = stm->GetCaptureStatus();
    Model* mdlTmp = nullptr;

    if ((statusTmp != RT_STREAM_CAPTURE_STATUS_NONE) && (captureStream != nullptr)) {
        mdlTmp = captureStream->Model_();
        if (mdlTmp == nullptr) {
            RT_LOG(RT_LOG_WARNING, "stream is not in capture status, stream_id=%d.", stm->Id_());
        }
    }

    if (status != nullptr) {
        *status = statusTmp;
    }

    if (captureMdl != nullptr) {
        *captureMdl = mdlTmp;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelGetNodes(const Model* const mdl, uint32_t* const num)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL_WITH_FUNC_DESC(
        mdl, curCtx, RT_ERROR_MODEL_CONTEXT, "Obtaining model node information");

    return curCtx->ModelGetNodes(mdl, num);
}

rtError_t ApiImpl::ModelDebugDotPrint(const Model* const mdl)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL_WITH_FUNC_DESC(
        mdl, curCtx, RT_ERROR_MODEL_CONTEXT, "Exporting the model running instance information in DOT format");

    return curCtx->ModelDebugDotPrint(mdl);
}

rtError_t ApiImpl::ModelDebugJsonPrint(const Model* const mdl, const char* path, const uint32_t flags)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL_WITH_FUNC_DESC(
        mdl, curCtx, RT_ERROR_MODEL_CONTEXT, "Exporting the model running instance information in JSON format");

    return curCtx->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiImpl::StreamAddToModel(Stream* const stm, Model* const captureMdl)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Binding a model running instance to a stream");
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL, ErrorCode::EE1017, "rtStreamAddToModel", "stream",
        "Stream " + std::to_string(stm->Id_()) + " is already bound to model " + std::to_string(stm->Model_()->Id_()));
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL_WITH_FUNC_DESC(
        captureMdl, curCtx, RT_ERROR_MODEL_CONTEXT, "Binding a model running instance to a stream");
    COND_RETURN_AND_MSG_OUTER(
        (stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1017, "rtStreamAddToModel",
        "stream", RtFmtMsg("The default stream (stream_id=%d) cannot be used in the ACL Graph", stm->Id_()));

    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiImpl::ThreadExchangeCaptureMode(rtStreamCaptureMode* const mode)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiImpl::StreamBeginTaskGrp(Stream* const stm)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Marking the start of a task group");
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->StreamBeginTaskGrp(stm);
}

rtError_t ApiImpl::StreamEndTaskGrp(Stream* const stm, TaskGroup** const handle)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Marking the end of a task group");
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    return captureSession->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiImpl::TaskGetSeqId(rtTask_t task, uint32_t* id)
{
    const TaskInfo* const taskInfo = static_cast<const TaskInfo*>(task);
    const Stream* stm = taskInfo->stream;
    NULL_PTR_RETURN(stm, RT_ERROR_STREAM_NULL);
    const Model* mdl = stm->Model_();
    COND_RETURN_AND_MSG_OUTER(
        mdl == nullptr, RT_ERROR_MODEL_NULL, ErrorCode::EE1017,
        "Obtaining the Submission Queue Entry (SQE) ID of a task", "task",
        RtFmtMsg("The stream (stream_id=%d) to which the task belongs is not bound to a model", stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(
        mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Obtaining the Submission Queue Entry (SQE) ID of a task", "Non ACL Graph mode is not supported");
    *id = taskInfo->modelSeqId;
    RT_LOG(RT_LOG_INFO, "Get task sequence id=%u, streamId=%d, taskId=%u.", *id, stm->Id_(), taskInfo->id);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelTaskDisable(rtTask_t task)
{
    TaskInfo* const taskInfo = static_cast<TaskInfo*>(task);
    rtError_t error = CheckCaptureModelForUpdate(taskInfo->stream);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(taskInfo->stream->Model_());
    NULL_PTR_RETURN(captureModel, RT_ERROR_MODEL_NULL);

    const std::lock_guard<std::mutex> graphUpdateLock(captureModel->GetGraphUpdateInfo().updateMutex);
    if (!captureModel->CanUpdate()) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "Checking whether the capture model is updatable", "modelRI",
            RtFmtMsg(
                "ModelRI (model_id=%u) is in capture state, status=%s", captureModel->Id_(),
                CaptureModelStatusToString(captureModel->GetCaptureModelStatus()).c_str()));
        return RT_ERROR_MODEL_UPDATE_FAILED;
    }
    captureModel->SetCaptureModelStatus(RtCaptureModelStatus::UPDATING);

    rtTaskType taskType = RT_TASK_DEFAULT;
    error = ConvertTaskType(taskInfo, &taskType);
    ERROR_PROC_RETURN_MSG_INNER(error, captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
                                , "get task type failed, retCode=%#x.", error);
    const bool isSupportedTaskType = (taskType == RT_TASK_KERNEL) || (taskType == RT_TASK_SIMT_KERNEL) ||
                                     (taskType == RT_TASK_EVENT_RECORD) || (taskType == RT_TASK_EVENT_WAIT) ||
                                     (taskType == RT_TASK_EVENT_RESET) || (taskType == RT_TASK_VALUE_WRITE) ||
                                     (taskType == RT_TASK_VALUE_WAIT);
    const bool isExternalEventRecord = (taskInfo->type == TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL);
    const bool cannotDisable = !isSupportedTaskType || isExternalEventRecord;
    COND_PROC(cannotDisable, captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT));
    COND_RETURN_AND_MSG_OUTER(
        cannotDisable, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Setting the status of a specified task to disabled",
        "taskType",
        RtFmtMsg(
            "Current task type is %s%s and cannot be disabled. Supported task types are "
            "TASK_KERNEL(1), TASK_SIMT_KERNEL(15), TASK_EVENT_RECORD(2) (excluding external event record), "
            "TASK_EVENT_WAIT(3), TASK_EVENT_RESET(4), TASK_VALUE_WRITE(5), and TASK_VALUE_WAIT(6)",
            TaskTypeToString(taskType).c_str(), isExternalEventRecord ? " for external event record" : ""));

    captureModel->InsertGraphUpdateTask(taskInfo);
    captureModel->ClearShapeInfo(taskInfo->stream->Id_(), GetTaskId(taskInfo));
    captureModel->ClearTaskExtendInfo(taskInfo->stream->Id_(), GetTaskId(taskInfo));
    taskInfo->updateFlag = static_cast<uint8_t>(TaskUpdateFlag::RT_TASK_DISABLE);
    RT_LOG(
        RT_LOG_INFO, "stream_id=%d, task_id=%hu, task type=" RT_ENUM_LOG_FORMAT("%d"), taskInfo->stream->Id_(),
        GetTaskId(taskInfo),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(taskInfo->type), RT_ENUM_LOG_NAME(taskInfo->typeName)));
    return RT_ERROR_NONE;
}

static rtError_t UpdateCachedParamsToTask(const std::set<TaskInfo*>& updateTasks)
{
    for (TaskInfo* const taskInfo : updateTasks) {
        if (taskInfo->updateFlag == static_cast<uint8_t>(TaskUpdateFlag::RT_TASK_DISABLE)) {
            continue;
        }
        TaskUpdateParams& latestParams = taskInfo->updateInfo->latestParams;
        rtError_t error = RT_ERROR_NONE;
        switch (latestParams.type) {
            case RT_TASK_SIMT_KERNEL:
                // SIMT task params are not applied by model update yet: skip the task so it keeps its loaded
                // parameters (mirroring the RT_TASK_DISABLE skip); the SIMT header rebuild is not wired up yet
                RT_LOG(
                    RT_LOG_INFO,
                    "skip updating the simt task, stream_id=%d, task_id=%hu, the task keeps its "
                    "loaded parameters.",
                    taskInfo->stream->Id_(), taskInfo->id);
                continue;
            case RT_TASK_KERNEL:
                error = UpdateKernelParams(taskInfo, &(latestParams.u.kernelUpdateParams));
                break;
            case RT_TASK_VALUE_WRITE:
                error = UpdateWriteValueTaskParams(taskInfo, &latestParams);
                break;
            case RT_TASK_VALUE_WAIT:
                error = UpdateWaitValueTaskParams(taskInfo, &latestParams);
                break;
            default:
                RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                    ErrorCode::EE1003, "Updating the capture model", TaskTypeToString(latestParams.type), "task type",
                    "TASK_KERNEL(1), TASK_VALUE_WRITE(5), or TASK_VALUE_WAIT(6)");
                RT_LOG(
                    RT_LOG_ERROR, "unsupported cached task type, stream_id=%d, task_id=%hu, type=%d.",
                    taskInfo->stream->Id_(), taskInfo->id, static_cast<int32_t>(latestParams.type));
                error = RT_ERROR_MODEL_UPDATE_FAILED;
                break;
        }
        ERROR_RETURN(
            error, "apply cached task params failed, stream_id=%d, task_id=%hu, retCode=%#x.", taskInfo->stream->Id_(),
            taskInfo->id, error);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelUpdate(Model* mdl)
{
    const Stream* const stm = mdl->StreamList_().back();
    NULL_PTR_RETURN(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = CheckCaptureModelSupportSoftwareSq(stm->Device_());
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(mdl);
    GraphUpdateInfo& graphUpdateInfo = captureModel->GetGraphUpdateInfo();

    const std::lock_guard<std::mutex> executeLock(captureModel->GetExecutionOrderMutex());
    const std::lock_guard<std::mutex> graphUpdateLock(graphUpdateInfo.updateMutex);
    if (captureModel->GetCaptureModelStatus() == RtCaptureModelStatus::READY) {
        return RT_ERROR_NONE;
    }

    if (captureModel->GetCaptureModelStatus() != RtCaptureModelStatus::UPDATING) {
        captureModel->ClearGraphUpdateTask();
        captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1016, "Model update",
            RtFmtMsg(
                "The model (model_id=%u) is not in the updating state. "
                "Ensure the model has successfully finished capturing and has tasks to update",
                captureModel->Id_()));
        return RT_ERROR_MODEL_UPDATE_FAILED;
    }

    if (captureModel->IsExecuteException()) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "Checking whether the capture model is ready", "modelRI",
            RtFmtMsg("ModelRI (model_id=%u) is not ready, status=EXECUTION_FAILED", captureModel->Id_()));
        captureModel->ClearGraphUpdateTask();
        captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
        return RT_ERROR_MODEL_UPDATE_FAILED;
    }

    // 只支持静态更新（模型未执行），模型正在执行报错。
    const bool isRunning = captureModel->IsCaptureModelRunningAfterPoll();
    if (isRunning) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "Checking whether the capture model is updatable", "modelRI",
            RtFmtMsg("ModelRI (model_id=%u) is in running", captureModel->Id_()));
        captureModel->ClearGraphUpdateTask();
        captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
        return RT_ERROR_MODEL_UPDATE_FAILED;
    }

    error = UpdateCachedParamsToTask(graphUpdateInfo.updateTask);
    captureModel->ClearGraphUpdateTask();
    if (error != RT_ERROR_NONE) {
        captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
        return error;
    }

    error = captureModel->Update();
    if (error != RT_ERROR_NONE) {
        captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
    } else {
        captureModel->SetCaptureModelStatus(RtCaptureModelStatus::READY);
    }
    return error;
}

rtError_t ApiImpl::ModelCondHandleCreate(
    Model* const mdl, uint32_t defaultValue, rtCondHandleFlag_t flag, CondHandle** const handle)
{
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(captureModel, RT_ERROR_INVALID_VALUE, "Conditional handle creation");
    COND_RETURN_AND_MSG_OUTER(
        !(captureModel->IsCaptureActive()), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Conditional handle creation",
        "modelRI", RtFmtMsg("ModelRI (model_id=%d) is not in the capture stage", mdl->Id_()));
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_MODEL_WITH_FUNC_DESC(
        mdl, curCtx, RT_ERROR_MODEL_CONTEXT, "Conditional handle creation");
    rtError_t error = CheckCaptureModelSupportCondOp(curCtx->Device_());
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    CondHandle* condHandle = new (std::nothrow) CondHandle(mdl, flag);
    COND_RETURN_AND_MSG_OUTER(
        (condHandle == nullptr), RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(CondHandle), "new");

    error = condHandle->Setup(curCtx, defaultValue);
    if (error != RT_ERROR_NONE) {
        DELETE_O(condHandle);
        return error;
    }

    *handle = condHandle;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelCondHandleGetCondPtr(CondHandle* const handle, uint64_t** const devPtr)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const rtError_t error = CheckCaptureModelSupportCondOp(curCtx->Device_());
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    *devPtr = handle->GetDevAddr();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamAddCondTaskParasCheck(rtCondTaskParams params, Stream* const stm, CondHandle** handle)
{
    const auto* inner = static_cast<const rtInnerObject*>(params.handle);
    CondHandle* realHandle = static_cast<CondHandle*>(inner->object);
    COND_RETURN_AND_MSG_OUTER(
        (realHandle->GetSubCaptureModels().size() != 0), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Verifying the parameters required by a conditional task", "params.handle",
        "The handle has been launched with condition task, "
        "create a new handle before adding another condition task");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Verifying the parameters required by a conditional task");
    COND_RETURN_AND_MSG_OUTER(
        !stm->IsCapturing(), RT_ERROR_STREAM_NOT_CAPTURED, ErrorCode::EE1018,
        "Verifying the parameters required by a conditional task",
        RtFmtMsg("Stream (stream_id=%d) must be in the capture stage before adding a condition task", stm->Id_()));
    NULL_PTR_RETURN(stm->GetCaptureStream(), RT_ERROR_STREAM_NOT_CAPTURED);
    rtError_t error = CheckCaptureModelSupportCondOp(curCtx->Device_());
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    COND_PROC_RETURN_AND_MSG_OUTER(
        (stm->GetCaptureStream()->Model_() != realHandle->GetParentModel()), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        RT_LOG(
            RT_LOG_ERROR,
            "The model associated with the condition handle is inconsistent with that associated with the stream, "
            "condhandle model=%p, capture stream model=%p.",
            realHandle->GetParentModel(), stm->GetCaptureStream()->Model_()),
        "Verifying the parameters required by a conditional task", "params.handle or stream",
        RtFmtMsg(
            "The model (model_id=%u) associated with the condition handle is inconsistent with the model (model_id=%u) "
            "bound to the stream (stream_id=%d)",
            realHandle->GetParentModel()->Id_(), stm->GetCaptureStream()->Model_()->Id_(), stm->Id_()));

    auto& addStreamMap = (dynamic_cast<CaptureModel*>(stm->GetCaptureStream()->Model_()))->GetAddStreamMap();
    auto it = addStreamMap.find(stm);
    COND_RETURN_AND_MSG_OUTER(
        (it != addStreamMap.end()), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Verifying the parameters required by a conditional task",
        "The ACL Graph add stream does not support add condition task");

    error = CheckCondTaskParamsSize(params);
    ERROR_RETURN(
        error, "Failed to check condition task params, condition type=%s, condition size=%u, retCode=%#x.",
        CondTaskTypeToString(params.type).c_str(), params.size, static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER(
        !realHandle->GetSubCaptureModels().empty(), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Verifying the parameters required by a conditional task", "params.handle",
        "The condHandle has already been used by rtStreamAddCondTask");

    realHandle->SetCondType(params.type);
    realHandle->SetCondSize(params.size);

    *handle = realHandle;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamAddCondTask(rtCondTaskParams params, Stream* const stm, uint32_t flags)
{
    CondHandle* realHandle = nullptr;
    rtError_t error = StreamAddCondTaskParasCheck(params, stm, &realHandle);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "condition task parameters check failed.");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    CaptureSession* const captureSession = GetCaptureSession(curCtx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    error = captureSession->CreateSubCaptureModels(realHandle, params, stm);
    ERROR_RETURN_MSG_INNER(
        error, "Create sub capture model failed, condition type=%s, condition size=%u, retCode=%#x.",
        CondTaskTypeToString(params.type).c_str(), params.size, static_cast<uint32_t>(error));

    return captureSession->StreamAddCondTask(realHandle, params, stm, flags);
}

rtError_t ApiImpl::ModelTaskGetEnabled(rtTask_t task, uint32_t* isEnabled)
{
    UNUSED(task);
    // Disabled tasks are currently destroyed, so all valid tasks are enabled. Disabled state support will be added
    // later.
    *isEnabled = 1U;
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
