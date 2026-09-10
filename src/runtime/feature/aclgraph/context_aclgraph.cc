/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include <cinttypes>
#include "runtime.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "npu_driver.hpp"
#include "error_message_manage.hpp"
#include "cond_enum_desc.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "task_info.hpp"
#include "capture_model.hpp"
#include "capture_model_enum_desc.hpp"
#include "capture_model_utils.hpp"
#include "capture_adapt.hpp"
#include "buffer_allocator.hpp"
#include "memcpy_c.hpp"
#include "stream_jetty_handler.h"
#include "stub_task.hpp"
#include "cond_handle.hpp"
#include "cond_op_stream_task.h"
#include "aclgraph_cond_task.h"
#include "task.hpp"

namespace cce {
namespace runtime {
namespace {
const char* StreamTaskGroupStatusName(const StreamTaskGroupStatus status)
{
    switch (status) {
        case StreamTaskGroupStatus::NONE:
            return "NONE";
        case StreamTaskGroupStatus::SAMPLE:
            return "SAMPLE";
        case StreamTaskGroupStatus::UPDATE:
            return "UPDATE";
        case StreamTaskGroupStatus::BUTT:
            return "BUTT";
        default:
            return "UNKNOWN";
    }
}
} // namespace

rtError_t Context::AllocCascadeCaptureStream(
    const Stream* const stm, Model* const captureModel, Stream** newCaptureStream)
{
    Stream* newCaptureStreamTmp = nullptr;

    if (captureModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Capture model is null, device_id=%u, original stream_id=%d.", device_->Id_(), stm->Id_());
        return RT_ERROR_MODEL_NULL;
    }

    CaptureModel* captureModelTmp = dynamic_cast<CaptureModel*>(captureModel);
    /* create capture stream */
    rtError_t error =
        StreamCreate(0U, RT_STREAM_PERSISTENT, &newCaptureStreamTmp, nullptr, captureModelTmp->IsSoftwareSqEnable());
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Capture stream create failed, device_id=%u, original stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), error);
        return error;
    }

    if (captureModelTmp->IsSoftwareSqEnable()) {
        /* add stream to model */
        error = ModelAddStream(captureModel, newCaptureStreamTmp, static_cast<uint32_t>(RT_INVALID_FLAG));
    } else {
        /* bind stream to model */
        error = ModelBindStream(captureModel, newCaptureStreamTmp, static_cast<uint32_t>(RT_INVALID_FLAG));
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Bind capture stream failed, device_id=%u, model_id=%u, stream_id=%d, "
            "original stream_id=%d, retCode=%#x.",
            device_->Id_(), captureModel->Id_(), newCaptureStreamTmp->Id_(), stm->Id_(), error);
        (void)StreamDestroy(newCaptureStreamTmp);
        return error;
    }

    *newCaptureStream = newCaptureStreamTmp;

    return RT_ERROR_NONE;
}

void Context::FreeCascadeCaptureStream(Stream* const cascadeCaptureStm)
{
    if (cascadeCaptureStm == nullptr) {
        RT_LOG(RT_LOG_ERROR, "cascade capture stream is null.");
        return;
    }

    if (cascadeCaptureStm->Model_() != nullptr) {
        CaptureModel* captureModelTmp = dynamic_cast<CaptureModel*>(cascadeCaptureStm->Model_());
        if (captureModelTmp->IsSoftwareSqEnable()) {
            /* steam is add to model, only need del from model */
            (void)ModelDelStream(cascadeCaptureStm->Model_(), cascadeCaptureStm);
        } else {
            /* steam is bind to model, only need unbind from model */
            (void)ModelUnbindStream(cascadeCaptureStm->Model_(), cascadeCaptureStm);
        }
    }

    (void)StreamDestroy(cascadeCaptureStm, true);

    return;
}

rtError_t Context::StreamBeginTaskGrp(Stream* const stm)
{
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    const StreamTaskGroupStatus status = stm->GetTaskGroupStatus();
    COND_RETURN_ERROR_MSG_INNER(
        status != StreamTaskGroupStatus::NONE, RT_ERROR_STREAM_TASKGRP_STATUS,
        "Task group is repeatedly started, or a task group is being updated.");

    Stream* captureStream = stm->GetCaptureStream();
    NULL_PTR_RETURN_MSG(captureStream, RT_ERROR_STREAM_NOT_CAPTURED);

    CaptureModel* mdl = dynamic_cast<CaptureModel*>(captureStream->Model_());
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);

    std::unique_ptr<TaskGroup> taskGrp(new (std::nothrow) TaskGroup);
    COND_RETURN_AND_MSG_OUTER(
        taskGrp == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(TaskGroup), "new");

    const uint8_t prefetchCnt = stm->Device_()->GetDevProperties().taskPrefetchCount;
    for (uint8_t idx = 0; idx < prefetchCnt; idx++) {
        const rtError_t ret = SendNopTask(this, stm);
        ERROR_RETURN_MSG_INNER(ret, "Launch Nop task %u error %#x.", idx, static_cast<uint32_t>(ret));
    }

    captureStream = stm->GetCaptureStream();
    NULL_PTR_RETURN_MSG(captureStream, RT_ERROR_STREAM_NOT_CAPTURED);
    COND_RETURN_ERROR(
        (mdl != dynamic_cast<CaptureModel*>(captureStream->Model_())), RT_ERROR_STREAM_CAPTURE_CONFLICT,
        "Capture model conflict.");
    (void)stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::SAMPLE);
    captureStream->UpdateCurrentTaskGroup(taskGrp);
    mdl->InsertTaskGroupStreamId(static_cast<uint16_t>(captureStream->Id_()));
    return RT_ERROR_NONE;
}

rtError_t Context::StreamEndTaskGrp(Stream* const stm, TaskGroup** const handle) const
{
    *handle = nullptr;
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());

    const StreamTaskGroupStatus status = stm->GetTaskGroupStatus();
    COND_RETURN_ERROR_MSG_INNER(
        status != StreamTaskGroupStatus::SAMPLE, RT_ERROR_STREAM_TASKGRP_STATUS,
        "The end operation cannot be performed on a stream that has not started a task group.");

    Stream* const captureStream = stm->GetCaptureStream();
    NULL_PTR_RETURN(captureStream, RT_ERROR_STREAM_NOT_CAPTURED);

    CaptureModel* mdl = dynamic_cast<CaptureModel*>(captureStream->Model_());
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);

    std::unique_ptr<TaskGroup>& taskGrp = captureStream->GetCurrentTaskGroup();
    NULL_PTR_RETURN(taskGrp, RT_ERROR_STREAM_TASKGRP_NULL);

    rtError_t errorCode = mdl->GetTaskGroupErrCode();
    if ((errorCode != RT_ERROR_NONE) || (mdl->IsCaptureInvalid()) ||
        (stm->GetCaptureStatus() == RT_STREAM_CAPTURE_STATUS_INVALIDATED)) {
        taskGrp.reset();
        *handle = nullptr;
        if (errorCode != RT_ERROR_NONE) {
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1017, "Marks the end of the task group", RtFmtMsg("stream (stream_id=%d)", stm->Id_()),
                "The ACL Graph associated with the stream has errors. The previous API may report an error. "
                "Handle the error reported by the previous API first");
        } else {
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1017, "Marks the end of the task group", RtFmtMsg("stream (stream_id=%d)", stm->Id_()),
                "The ACL Graph capture associated with the stream has been invalidated");
            errorCode = RT_ERROR_STREAM_CAPTURE_INVALIDATED;
        }
    } else {
        *handle = taskGrp.get();
        mdl->AddTaskGroupList(taskGrp);
    }
    captureStream->ResetTaskGroup();
    mdl->DeleteTaskGroupStreamId(static_cast<uint16_t>(captureStream->Id_()));
    (void)stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);
    return errorCode;
}

rtError_t Context::StreamBeginTaskUpdate(Stream* const stm, TaskGroup* handle) const
{
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    COND_RETURN_AND_MSG_OUTER(
        stm->GetTaskGroupStatus() != StreamTaskGroupStatus::NONE, RT_ERROR_STREAM_TASKGRP_STATUS, ErrorCode::EE1016,
        "Marking the start of the task to be updated", "The stream is already in task update or sample mode");

    COND_RETURN_ERROR_MSG_INNER(
        handle->isUpdate, RT_ERROR_STREAM_TASKGRP_STATUS, "The handle can only be updated by one stream.");

    const rtError_t ret = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::UPDATE);
    ERROR_RETURN(
        ret, "update stream task group status failed, ret:%#x, status:%s(%u).", static_cast<uint32_t>(ret),
        StreamTaskGroupStatusName(stm->GetTaskGroupStatus()), static_cast<uint32_t>(stm->GetTaskGroupStatus()));

    stm->SetUpdateTaskGroup(handle);
    RT_LOG(RT_LOG_INFO, "Success to begin update tasks, stream_id=%d.", stm->Id_());
    return RT_ERROR_NONE;
}

rtError_t Context::StreamEndTaskUpdate(Stream* const stm) const
{
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    COND_RETURN_AND_MSG_OUTER(
        stm->GetTaskGroupStatus() != StreamTaskGroupStatus::UPDATE, RT_ERROR_STREAM_TASKGRP_STATUS, ErrorCode::EE1016,
        "Marking the end of the task to be updated", "The stream is not in task update mode");

    TaskGroup* updateTaskGroup = stm->GetUpdateTaskGroup();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        updateTaskGroup, RT_ERROR_INVALID_VALUE, "Marking the end of the task to be updated");
    (void)stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);

    const size_t taskIndex = updateTaskGroup->updateTaskIndex;
    COND_PROC_RETURN_AND_MSG_OUTER(taskIndex != updateTaskGroup->taskIds.size(), RT_ERROR_STREAM_TASKGRP_UPDATE,
                                   ErrorCode::EE1017, stm->ResetUpdateTaskGroup();
                                   , "Marking the end of the task to be updated",
                                   RtFmtMsg("stream (stream_id=%d)", stm->Id_()),
                                   RtFmtMsg(
                                       "The task group under this stream contains unupdated tasks. "
                                       "total_num=%zu, matched_num=%zu",
                                       updateTaskGroup->taskIds.size(), taskIndex));

    stm->ResetUpdateTaskGroup();
    RT_LOG(
        RT_LOG_INFO, "stream_id=%d update tasks result: total=%zu, success=%zu, remain=%zu", stm->Id_(),
        updateTaskGroup->taskIds.size(), taskIndex, (updateTaskGroup->taskIds.size() - taskIndex));
    return RT_ERROR_NONE;
}

rtError_t Context::CreateSubCaptureModels(CondHandle* condHandle, rtCondTaskParams params, Stream* const stm)
{
    for (uint32_t loop = 0; loop < params.size; loop++) {
        Model* subModel = nullptr;
        const rtError_t ret = ModelCreate(&subModel, RT_MODEL_CAPTURE_MODEL);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "Capture model create failed, device_id=%u, original stream_id=%d, size=%u, retCode=%#x.",
                stm->Device_()->Id_(), stm->Id_(), params.size, ret);
            condHandle->SubModelDestroy();
            (void)memset_s(params.modelRIArray, params.size * sizeof(rtModel_t), 0x0U, params.size * sizeof(rtModel_t));
            return ret;
        }

        modelLock_.Lock();
        models_.remove(subModel); // capture model资源回收不遍历子模型，context析构也不遍历子图，都靠父模型递归完成。
        modelLock_.Unlock();
        CaptureModel* subCaptureModel = dynamic_cast<CaptureModel*>(subModel);
        subCaptureModel->SetSubCaptureModelEnable();
        subCaptureModel->SetCondHandle(params.handle);
        condHandle->PushBackSubModel(subModel);
        params.modelRIArray[loop] = static_cast<rtModel_t>(subModel);

        RT_LOG(
            RT_LOG_DEBUG,
            "Sub capture model create success, device_id=%u, parent model_id=%u, sub model_id=%u"
            " original stream_id=%d, capture stream_id=%d, isSubmodel=%d, condition type=%u, condition size=%u.",
            device_->Id_(), condHandle->GetParentModel()->Id_(), subModel->Id_(), stm->Id_(),
            stm->GetCaptureStream()->Id_(),
            (dynamic_cast<CaptureModel*>(condHandle->GetParentModel()))->IsSubCaptureModel(), condHandle->GetCondType(),
            condHandle->GetCondSize());
    }

    return RT_ERROR_NONE;
}

rtError_t Context::SubmitCaptureConditionTask(CondHandle* condHandle, Stream* const stm)
{
    rtError_t error = RT_ERROR_NONE;
    Device* const dev = stm->Device_();
    TaskInfo* tsk = nullptr;
    TaskInfo submitTask = {};
    const uint32_t sqeNum =
        (condHandle->GetCondType() == RT_COND_TASK_TYPE_WHILE) ? COND_TASK_WHILE_SQE_NUM : COND_TASK_IF_SWITCH_SQE_NUM;
    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_CAPTURE_CONDITION, error, sqeNum);
    NULL_PTR_RETURN_MSG(tsk, error);

    std::function<void()> const errRecycle = [&dev, &tsk]() { (void)dev->GetTaskFactory()->Recycle(tsk); };
    ScopeGuard tskErrRecycle(errRecycle);

    error = cce::runtime::CaptureConditionTaskInit(tsk, condHandle);
    ERROR_RETURN(
        error,
        "Capture condition task init failed, model_id=%u, stream_id=%d, task_id=%u, condtype=%s, condsize=%u, "
        "retCode=%#x.",
        stm->Model_()->Id_(), stm->Id_(), tsk->id, CondTaskTypeToString(condHandle->GetCondType()).c_str(),
        condHandle->GetCondSize(), error);
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit capture model condition task, retCode=%#x.", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();

    error = PostProcCaptureConditionTask(condHandle, stm, tsk->id);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to post proc capture condition task, stream_id=%d, task_id=%u, retCode=%#x.", stm->Id_(),
        tsk->id, static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    condHandle->SetSubModelExeStream(tsk->stream);
    return RT_ERROR_NONE;
}

rtError_t Context::StreamAddCondTask(CondHandle* condHandle, rtCondTaskParams params, Stream* const stm, uint32_t flags)
{
    UNUSED(flags);
    std::function<void()> const errSubModelRecycle = [&condHandle, &params]() {
        condHandle->SubModelDestroy();
        (void)memset_s(params.modelRIArray, params.size * sizeof(rtModel_t), 0x0U, params.size * sizeof(rtModel_t));
    };
    ScopeGuard subModelErrRecycle(errSubModelRecycle);

    rtError_t error;
    Notify* notify = condHandle->GetSubModelNotify();
    if (notify == nullptr) {
        notify = new (std::nothrow) Notify(device_->Id_(), device_->DevGetTsId());
        COND_RETURN_AND_MSG_OUTER(notify == nullptr, RT_ERROR_NOTIFY_NEW, ErrorCode::EE1013, sizeof(Notify), "new");
        error = notify->SetupWithoutAllocNtyId();
        COND_PROC_RETURN_WARN(error != RT_ERROR_NONE, error, DELETE_O(notify), "Notify setup, retCode=%#x", error);
    }
    condHandle->SetSubModelNotify(notify);

    auto& subModels = condHandle->GetSubCaptureModels();
    Model* firstSubModel = subModels.empty() ? nullptr : subModels[0];
    notify->SetEndGraphModel(firstSubModel);

    error = SubmitCaptureConditionTask(condHandle, stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit capture condition task, retCode=%#x.", static_cast<uint32_t>(error));

    subModelErrRecycle.ReleaseGuard();
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
