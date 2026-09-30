/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_capture.hpp"

#include <utility>
#include "cond_c.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "capture_model.hpp"
#include "capture_session.hpp"
#include "capture_func.hpp"
#include "error_message_manage.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "task_david.hpp"
#include "capture_adapt.hpp"

namespace cce {
namespace runtime {

void CacheCaptureTaskId(Stream* stm, uint16_t taskId)
{
    StreamCapture* const capture = StreamCapture::GetOrCreate(stm);
    if (capture != nullptr) {
        capture->CacheTaskId(taskId);
    }
}

uint32_t GetStreamCacheOpInfoSwitch(const Stream* stm)
{
    const StreamCapture* const capture = StreamCapture::Get(stm);
    return (capture == nullptr) ? 0U : capture->GetCacheOpInfoSwitch();
}

void SetStreamCacheOpInfoOriginSwitch(const Stream* stm, uint32_t status)
{
    StreamCapture* const capture = StreamCapture::GetOrCreate(stm);
    if (capture != nullptr) {
        capture->SetCacheOpInfoOriginSwitch(status);
    }
}

bool IsOriginalCaptureStream(const Stream* stm)
{
    const StreamCapture* const capture = StreamCapture::Get(stm);
    return (capture == nullptr) ? false : capture->IsOrigCaptureStream();
}

void ResetStreamTaskGroup(Stream* stm)
{
    StreamCapture* const capture = StreamCapture::Get(stm);
    if (capture != nullptr) {
        capture->ResetTaskGroup();
    }
}

rtError_t UpdateStreamTask(Stream* stm, TaskInfo** task)
{
    StreamCapture* const capture = StreamCapture::Get(stm);
    if (capture == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "The updateTaskGroup is a NULL pointer.");
        return RT_ERROR_INVALID_VALUE;
    }
    const std::lock_guard<std::mutex> tskGrpLock(capture->GetTaskGroupMutex());
    TaskGroup* const updateTaskGroup = capture->GetUpdateTaskGroup();
    if (updateTaskGroup == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "The updateTaskGroup is a NULL pointer.");
        return RT_ERROR_INVALID_VALUE;
    }

    const uint32_t taskIndex = updateTaskGroup->updateTaskIndex;
    if (taskIndex >= updateTaskGroup->taskIds.size()) {
        RT_LOG(
            RT_LOG_ERROR,
            "The number of tasks cannot exceed the size of the task group, current task index=%u, task group size=%zu.",
            taskIndex, updateTaskGroup->taskIds.size());
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1003, "Updating the task group", taskIndex + 1U,
            "number of kernel launch calls in the task update interval",
            RtFmtMsg(
                "no more than %zu, matching the number of tasks in the task group", updateTaskGroup->taskIds.size()));
        return RT_ERROR_STREAM_TASKGRP_UPDATE;
    }

    auto& taskIdPair = updateTaskGroup->taskIds[taskIndex];
    const uint16_t streamId = taskIdPair.first;
    const uint16_t taskId = taskIdPair.second;
    TaskInfo* taskInfo = GetStreamTaskInfo(stm->Device_(), streamId, taskId);
    if (unlikely(taskInfo == nullptr)) {
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "stream_id or task_id is invalid, stream_id=%hu, task_id=%hu.", streamId, taskId);
        return RT_ERROR_STREAM_TASKGRP_UPDATE;
    }

    taskInfo->isUpdateSinkSqe = 1U;
    *task = taskInfo;
    capture->UpdateTaskIndex(taskIndex + 1U);
    RT_LOG(
        RT_LOG_DEBUG, "stream_id=%hu, task_id=%hu, current task index=%u, task group size=%u", streamId, taskId,
        taskIndex, updateTaskGroup->taskIds.size());
    return RT_ERROR_NONE;
}

rtError_t PackStreamTaskGroup(Stream* stm, const TaskInfo* task, uint16_t streamId)
{
    StreamCapture* const capture = StreamCapture::Get(stm);
    return (capture == nullptr) ? RT_ERROR_NONE : capture->PackingTaskGroup(task, streamId);
}

StreamCapture::StreamCapture() = default;

StreamCapture::~StreamCapture() = default;

StreamCapture* StreamCapture::Create(const Stream* stm) { return GetOrCreate(stm); }

StreamCapture* StreamCapture::GetOrCreate(const Stream* stm)
{
    if (stm == nullptr) {
        return nullptr;
    }
    return dynamic_cast<StreamCapture*>(stm->EnsureExtension());
}

StreamCapture* StreamCapture::Get(const Stream* stm)
{
    return (stm == nullptr) ? nullptr : dynamic_cast<StreamCapture*>(stm->GetExtension());
}

void StreamCapture::CacheTaskId(uint16_t taskId) { cacheCaptureTaskIds_.push_back(taskId); }

const std::list<uint16_t>& StreamCapture::GetCachedTaskIds() const { return cacheCaptureTaskIds_; }

uint32_t StreamCapture::GetCacheOpInfoSwitch() const { return cacheOpInfoSwitch_; }

void StreamCapture::SetCacheOpInfoSwitch(uint32_t status) { cacheOpInfoSwitch_ = status; }

uint32_t StreamCapture::GetCacheOpInfoOriginSwitch() const { return cacheOpInfoOriginSwitch_; }

void StreamCapture::SetCacheOpInfoOriginSwitch(uint32_t status) { cacheOpInfoOriginSwitch_ = status; }

void StreamCapture::MarkOrigCaptureStream(bool flag) { isOrigCaptureStream_ = flag; }

bool StreamCapture::IsOrigCaptureStream() const { return isOrigCaptureStream_; }

void StreamCapture::CancelLastLevelCaptureStream() { isLastLevelCaptureStream_ = false; }

bool StreamCapture::IsLastLevelCaptureStream() const { return isLastLevelCaptureStream_; }

void StreamCapture::SetParentCaptureStream(Stream* parent) { parentCaptureStream_ = parent; }

Stream* StreamCapture::GetChildCaptureStream() const { return childCaptureStream_; }

void StreamCapture::SetChildCaptureStream(Stream* child) { childCaptureStream_ = child; }

rtStreamCaptureMode StreamCapture::GetCaptureMode() const { return captureMode_; }

void StreamCapture::SetCaptureMode(rtStreamCaptureMode mode) { captureMode_ = mode; }

void StreamCapture::ResetTaskGroup() { taskGroup_ = nullptr; }

void StreamCapture::UpdateCurrentTaskGroup(std::unique_ptr<TaskGroup>& taskGroup) { taskGroup_ = std::move(taskGroup); }

std::unique_ptr<TaskGroup>& StreamCapture::GetCurrentTaskGroup() { return taskGroup_; }

TaskGroup* StreamCapture::GetUpdateTaskGroup() const { return updateTaskGroup_; }

void StreamCapture::SetUpdateTaskGroup(TaskGroup* taskGroup)
{
    updateTaskGroup_ = taskGroup;
    updateTaskGroup_->isUpdate = true;
    updateTaskGroup_->updateTaskIndex = 0U;
}

void StreamCapture::UpdateTaskIndex(uint32_t index) const { updateTaskGroup_->updateTaskIndex = index; }

rtError_t StreamCapture::PackingTaskGroup(const TaskInfo* task, uint16_t streamId)
{
    std::unique_ptr<TaskGroup>& taskGroup = GetCurrentTaskGroup();
    NULL_PTR_RETURN_NOLOG(taskGroup, RT_ERROR_NONE);
    if (task->type == TS_TASK_TYPE_STREAM_ACTIVE) {
        /* 过滤掉capture model级联场景下隐式添加的StreamActive任务 */
        return RT_ERROR_NONE;
    }
    if (!TaskTypeIsSupportTaskGroup(task)) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1006, "Adding the task to the task group",
            RtFmtMsg("Task type %s(%u)", GetTaskDescByType(task->type), static_cast<uint32_t>(task->type)),
            "Only tasks running on Cube Core or Vector Core can be added to a task group");
        return RT_ERROR_TASK_NOT_SUPPORT;
    }
    (void)taskGroup->taskIds.emplace_back(streamId, task->id);
    return RT_ERROR_NONE;
}

void StreamCapture::ResetUpdateTaskGroup()
{
    updateTaskGroup_->isUpdate = false;
    updateTaskGroup_->updateTaskIndex = 0U;
    updateTaskGroup_ = nullptr;
}

std::mutex& StreamCapture::GetTaskGroupMutex() { return taskGroupMutex_; }

bool StreamCapture::IsSubCaptureModel() const { return isSubCaptureModel_; }

void StreamCapture::SetSubCaptureModel() { isSubCaptureModel_ = true; }

void StreamCapture::SetBeginCaptureThreadId(uint32_t threadId) { beginCaptureThreadId_ = threadId; }

uint32_t StreamCapture::GetBeginCaptureThreadId() const { return beginCaptureThreadId_; }

bool StreamCapture::IsTaskGroupBreak(const Stream* stm, const Stream* captureStream)
{
    if (captureStream == nullptr) {
        return false;
    }
    StreamCapture* const capture = Get(captureStream);
    if ((capture != nullptr) && (capture->GetCurrentTaskGroup() != nullptr)) {
        return false;
    }
    CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(captureStream->Model_());
    if (captureModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "capture model is NULL, stream_id=%d.", stm->Id_());
        return true;
    }
    std::set<uint16_t>& streamIds = captureModel->GetTaskGroupStreamIds();
    return (!streamIds.empty());
}

void StreamCapture::Terminate(Stream* stm)
{
    stm->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_INVALIDATED);
    Stream* const curCaptureStream = stm->GetCaptureStream();
    if (curCaptureStream != nullptr) {
        CaptureModel* const captureModel = static_cast<CaptureModel*>(curCaptureStream->Model_());
        if (captureModel != nullptr) {
            captureModel->TerminateCapture();
        }
    }
}

rtError_t StreamCapture::AllocCascadeStream(Stream* stm, Stream*& newCaptureStream, const Stream* curCaptureStream)
{
    Context* const ctx = stm->Context_();
    CaptureSession* const captureSession = GetCaptureSession(ctx);
    NULL_PTR_RETURN_MSG(captureSession, RT_ERROR_CONTEXT_BASE);
    const rtError_t error =
        captureSession->AllocCascadeCaptureStream(stm, curCaptureStream->Model_(), &newCaptureStream);
    if ((error != RT_ERROR_NONE) || (newCaptureStream == nullptr)) {
        Terminate(stm);
        RT_LOG(
            RT_LOG_ERROR, "alloc capture stream failed, device_id=%u, original stream_id=%d.", stm->Device_()->Id_(),
            stm->Id_());
        return error;
    }
    if (curCaptureStream->Model_() != nullptr) {
        CaptureModel* const captureModel = static_cast<CaptureModel*>(curCaptureStream->Model_());
        auto& addStreamMap = captureModel->GetAddStreamMap();
        auto it = addStreamMap.find(stm);
        if (it != addStreamMap.end()) {
            captureModel->SetAddStreamMap(stm, newCaptureStream);
        }
    }
    return RT_ERROR_NONE;
}

void StreamCapture::UpdateCascadeStreamInfo(Stream* stm, Stream* newCaptureStream, Stream* curCaptureStream)
{
    StreamCapture* const currentCapture = Get(curCaptureStream);
    StreamCapture* const newCapture = Get(newCaptureStream);
    currentCapture->CancelLastLevelCaptureStream();
    newCapture->MarkOrigCaptureStream(currentCapture->IsOrigCaptureStream());
    std::unique_ptr<TaskGroup>& taskGroup = currentCapture->GetCurrentTaskGroup();
    newCapture->UpdateCurrentTaskGroup(taskGroup);
    newCapture->SetParentCaptureStream(curCaptureStream);
    currentCapture->SetChildCaptureStream(newCaptureStream);
    currentCapture->ResetTaskGroup();
    CaptureModel* const captureModel = static_cast<CaptureModel*>(curCaptureStream->Model_());
    if (captureModel != nullptr) {
        captureModel->ReplaceTaskGroupStreamId(
            static_cast<uint16_t>(curCaptureStream->Id_()), static_cast<uint16_t>(newCaptureStream->Id_()));
        captureModel->InsertSingleOperStmIdAndCaptureStmId(stm->Id_(), newCaptureStream->Id_());
    }
    stm->UpdateCaptureStream(newCaptureStream);
}

rtError_t StreamCapture::AllocTask(Stream* stm, tsTaskType_t taskType, uint32_t sqeNum, TaskInfo** task)
{
    std::unique_lock<std::mutex> lock(stm->GetCaptureLock());
    Stream* curCaptureStream = stm->GetCaptureStream();
    if (curCaptureStream == nullptr) {
        return RT_ERROR_STREAM_CAPTURE_EXIT;
    }

    COND_PROC_RETURN_AND_MSG_OUTER(
        IsTaskGroupBreak(stm, curCaptureStream), RT_ERROR_STREAM_TASKGRP_INTR, ErrorCode::EE1016,
        stm->SetTaskGroupErrCode(RT_ERROR_STREAM_TASKGRP_INTR), "Adding a task to the task group",
        "The task group has been interrupted and does not support further task delivery");

    if (NeedCascadeExpandStream(curCaptureStream)) {
        Stream* newCaptureStream = nullptr;
        Context* const ctx = stm->Context_();
        if (ctx == nullptr) {
            RT_LOG(
                RT_LOG_ERROR, "context is null, device_id=%u, original stream_id=%d.", stm->Device_()->Id_(),
                stm->Id_());
            Terminate(stm);
            return RT_ERROR_CONTEXT_NULL;
        }
        rtError_t error = AllocCascadeStream(stm, newCaptureStream, curCaptureStream);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        error = CondStreamActive(newCaptureStream, curCaptureStream);
        if (error != RT_ERROR_NONE) {
            CaptureSession* const captureSession = GetCaptureSession(ctx);
            if (captureSession != nullptr) {
                captureSession->FreeCascadeCaptureStream(newCaptureStream);
            }
            Terminate(stm);
            RT_LOG(
                RT_LOG_ERROR, "stream active failed, device_id=%u, original stream_id=%d.", stm->Device_()->Id_(),
                stm->Id_());
            return error;
        }
        UpdateCascadeStreamInfo(stm, newCaptureStream, curCaptureStream);
        curCaptureStream = newCaptureStream;
    }

    if (curCaptureStream->taskResMang_ == nullptr) {
        rtError_t errCode = RT_ERROR_TASK_NEW;
        *task = stm->Device_()->GetTaskFactory()->Alloc(curCaptureStream, taskType, errCode);
        if (*task == nullptr) {
            Terminate(stm);
            return errCode;
        }
        curCaptureStream->AddCaptureSqeNum(sqeNum);
        Runtime::Instance()->AllocTaskSn((*task)->taskSn);
        SaveTaskCommonInfo(*task, curCaptureStream, sqeNum);
        RT_LOG(
            RT_LOG_INFO,
            "Alloc task in capture stream successfully, device id=%u, origin stream_id=%d, capture stream_id=%d, "
            "task sequence id=%u.",
            stm->Device_()->Id_(), stm->Id_(), curCaptureStream->Id_(), (*task)->modelSeqId);
        return RT_ERROR_NONE;
    }

    const rtError_t ret = AllocCaptureTaskByTaskRes(curCaptureStream, sqeNum, task);
    if (ret != RT_ERROR_NONE) {
        Terminate(stm);
    }
    return ret;
}

void StreamCapture::EnterCapture(Stream* stm, const Stream* captureStream)
{
    CaptureModel* const captureModel = RtPtrToPtr<CaptureModel*>(captureStream->Model_());
    if (captureModel != nullptr) {
        captureModel->EnterCaptureNotify(stm->Id_(), captureStream->Id_());
    }

    std::unique_lock<std::mutex> lock(stm->GetCaptureLock());
    stm->UpdateCaptureStream(captureStream);
    stm->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);

    const StreamCapture* const capture = Get(captureStream);
    if ((capture != nullptr) && capture->IsOrigCaptureStream()) {
        const StreamCapture* const streamCapture = Get(stm);
        const uint32_t cacheOpInfoOriginSwitch =
            (streamCapture == nullptr) ? 0U : streamCapture->GetCacheOpInfoOriginSwitch();
        captureModel->SetModelCacheOpInfoSwitch(cacheOpInfoOriginSwitch);
    } else {
        StreamCapture* const streamCapture = GetOrCreate(stm);
        if (streamCapture != nullptr) {
            streamCapture->SetCacheOpInfoSwitch(captureModel->GetModelCacheOpInfoSwitch());
        }
    }
}

void StreamCapture::ExitCapture(Stream* stm)
{
    Stream* const captureStream = stm->GetCaptureStream();
    if (captureStream != nullptr) {
        CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(captureStream->Model_());
        if (captureModel != nullptr) {
            captureModel->ExitCaptureNotify();
            captureModel->SetModelCacheOpInfoSwitch(0U);
        }
    }

    stm->ResetCaptureInfo();
}

} // namespace runtime
} // namespace cce
