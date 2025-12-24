/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task.hpp"
#include "osal.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "program.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "securec.h"
#include "profiler.hpp"
#include "notify.hpp"
#include "kernel.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "device/device_error_proc.hpp"
#include "stars_cond_isa_helper.hpp"
#include "task_res.hpp"
#include "ctrl_res_pool.hpp"

namespace cce {
namespace runtime {

TaskFactory::TaskFactory(Device * const dev)
    : NoCopy(),
      allocator_(nullptr),
      exitFlag_(false),
      retryCount_(0UL),
      device_(dev)
{
}

TaskFactory::~TaskFactory()
{
    {
        exitFlag_ = true;
        const std::unique_lock<std::mutex> lk(allocRetryMutex_);
        allocRetry_.notify_all();
    }

    while (retryCount_.load() != 0ULL) {
        std::chrono::milliseconds(1);
    }

    if (allocator_ != nullptr) {
        delete allocator_;
        allocator_ = nullptr;
    }
}

rtError_t TaskFactory::Init()
{
    allocator_ = new (std::nothrow) TaskAllocator(GetTaskMaxSize(), INIT_TASK_CAPACITY,
                                                  Runtime::macroValue_.maxSupportTaskNum);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, allocator_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Init task factory failed, new TaskAllocator failed.");
    RT_LOG(RT_LOG_DEBUG, "TaskFactory::Init ok, alloc size is %zu.", sizeof(TaskAllocator));
    return RT_ERROR_NONE;
}

uint32_t TaskFactory::GetTaskMaxSize()
{
    uint32_t size = static_cast<uint32_t>(sizeof(TaskInfo));

    if ((size & (RTS_BUFF_ASSING_NUM - 1U)) > 0U) {
        size += RTS_BUFF_ASSING_NUM;
        size &= (~(RTS_BUFF_ASSING_NUM - 1U));
    }

    return size;
}

int32_t TaskFactory::Recycle(TaskInfo *const taskPtr)
{
    int32_t id = static_cast<int32_t>(taskPtr->id);
    Stream *streamPtr = taskPtr->stream;

    if (streamPtr->IsCtrlStream()) {
        TaskUnInitProc(taskPtr);
        device_->GetCtrlResEntry()->RecycleTask(taskPtr->id);
        return 0;
    }

    const int32_t streamId = streamPtr->Id_();
    if (taskPtr->serial != 0U) {
        id = allocator_->GetTaskId(streamId, taskPtr->id);
        allocator_->DelSerialId(streamId, taskPtr->id);
    }

    const bool StreamFreeFlag = IsNeedFreeStreamRes(taskPtr);
    const bool isSinkFlag = taskPtr->bindFlag;
    TaskUnInitProc(taskPtr);

    /* Stars free taskid after ~task immediately without send STREAM_DESTROY task */
    if ((!isSinkFlag) || streamPtr->Device_()->IsStarsPlatform()) {
        if (streamPtr->taskResMang_ == nullptr) {
            allocator_->FreeById(streamPtr, id, isSinkFlag);
        }
    }

    if (StreamFreeFlag) {
        const rtError_t error = streamPtr->FreePersistentTaskID(allocator_);
        COND_LOG_ERROR(error != RT_ERROR_NONE, "FreePersistentTaskID failed, retCode=%#x.", error);

        if (!Runtime::Instance()->GetDisableThread()) {
            streamPtr->ReportDestroyFlipTask();
            DeleteStream(streamPtr);
        }
    }
    const std::unique_lock<std::mutex> allocRetryLock(allocRetryMutex_);
    allocRetry_.notify_all();
    return 0;
}

void TaskFactory::TryTaskReclaim(Stream *const streamPtr) const
{
    if (streamPtr->IsSeparateSendAndRecycle()) {
        if (!streamPtr->Device_()->GetIsDoingRecycling()) {
            streamPtr->Device_()->WakeUpRecycleThread();
        }
        return;
    }
    uint32_t reclaimTaskId = 0U;
    streamPtr->StreamSyncLock();
    (void)streamPtr->Device_()->TaskReclaim(static_cast<uint32_t>(streamPtr->Id_()), true, reclaimTaskId);
    streamPtr->StreamSyncUnLock();
}

int32_t TaskFactory::TryAgainAlloc(Stream *const streamPtr, rtError_t &errCode)
{
    int32_t id;
    constexpr uint32_t maxCount = 1000U;
    uint32_t countNum = 0U;

    retryCount_++;
    do {
        ++countNum;
        if (Runtime::Instance()->GetDisableThread()) {
            uint32_t reclaimTaskId = 0U;
            streamPtr->StreamSyncLock();
            (void)streamPtr->Device_()->TaskReclaim(static_cast<uint32_t>(streamPtr->Id_()), true, reclaimTaskId);
            streamPtr->StreamSyncUnLock();
        }

        id = allocator_->AllocId(streamPtr, errCode);
        if (id >= 0) {
            RT_LOG(RT_LOG_INFO, "Success to alloc taskId, stream_id=%d, count=%u.", streamPtr->Id_(), countNum);
            break;
        }

        std::unique_lock<std::mutex> allocRetryLock(allocRetryMutex_);
        (void)allocRetry_.wait_for(allocRetryLock, std::chrono::milliseconds(10)); // retry every 10ms
        if (exitFlag_.load()) {
            RT_LOG(RT_LOG_INFO, "It need to exit.");
            break;
        }
    } while (countNum < maxCount);
    retryCount_--;

    COND_LOG_ERROR(countNum >= maxCount, "Alloc task id failed, retry times=%u, stream_id=%d",
        countNum, streamPtr->Id_());
    return id;
}

TaskInfo *TaskFactory::GetTask(const int32_t streamId, const uint16_t id)
{
    Stream *recycleStm = nullptr;
    (void)device_->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(streamId), &recycleStm);
    if ((recycleStm != nullptr) && (recycleStm->taskResMang_ != nullptr)) {
        return recycleStm->taskResMang_->GetTaskInfo((id != MAX_UINT16_NUM) ? id : 0U);
    }
    RT_LOG(RT_LOG_DEBUG, "this stream no taskRes, stream_id=%d", streamId);

    rtError_t errCode = RT_ERROR_NONE;
    const bool serialId = Runtime::Instance()->GetDisableThread();
    return RtPtrToPtr<TaskInfo *, void *>(serialId ? allocator_->GetItemBySerial(streamId, static_cast<int32_t>(id)) :
        allocator_->GetItemById(streamId, static_cast<int32_t>(id), errCode));
}

void TaskFactory::SetSerialId(const Stream *const streamPtr, TaskInfo *const taskPtr)
{
    if (streamPtr->IsCtrlStream()) {
        return;
    }

    if (Runtime::Instance()->GetDisableThread()) {
        allocator_->SetSerialId(streamPtr->Id_(), taskPtr);
    }
}

void TaskFactory::ClearSerialVecId(const Stream *const streamPtr)
{
    if (streamPtr->IsCtrlStream()) {
        return;
    }

    if (Runtime::Instance()->GetDisableThread()) {
        allocator_->ClearSerialId(streamPtr->Id_());
    }
}

void TaskFactory::FreeStreamRes(const int32_t streamId)
{
    allocator_->FreeStreamRes(streamId);
}

TaskInfo* TaskFactory::Alloc(Stream *stream, tsTaskType_t taskType, rtError_t &errCode)
{
    NULL_PTR_RETURN(stream, nullptr);
    if (stream->IsCtrlStream()) {
        return device_->GetCtrlResEntry()->CreateTask(stream, taskType);
    }

    NULL_PTR_RETURN(allocator_, nullptr);
    int32_t id = allocator_->AllocId(stream, errCode);
    if (!(stream->IsTaskSink())) {
        if (unlikely(id < 0)) {
            id = TryAgainAlloc(stream, errCode);
            COND_RETURN_ERROR_MSG_INNER(exitFlag_ || (id < 0), nullptr, "Alloc task id failed, stream_id=%d.",
                stream->Id_());
        }
    } else {
        COND_RETURN_ERROR_MSG_INNER(id < 0, nullptr, "Alloc task id failed, stream_id=%d.", stream->Id_());
        stream->PushPersistentTaskID(static_cast<uint32_t>(id));
    }

    void *task_addr = allocator_->GetItemById(stream->Id_(), id, errCode);
    if (task_addr != nullptr) {
        TaskInfo *task = (TaskInfo*)task_addr;
        (void)memset_s(task, sizeof(TaskInfo), 0, sizeof(TaskInfo));
        task->type = taskType;
        InitByStream(task, stream);
        task->id = static_cast<uint16_t>(id);
        UpdateFlipNum(task, false);

        return task;
    }
    return nullptr;
}

}  // namespace runtime
}  // namespace cce
