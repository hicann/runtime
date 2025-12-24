/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "engine.hpp"
#include <thread>
#include "securec.h"
#include "runtime.hpp"
#include "task.hpp"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "profiler.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "task_fail_callback_manager.hpp"
#include "errcode_manage.hpp"
#include "runtime/config.h"
#include "npu_driver.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "base.hpp"
#include "task_info.hpp"
#include "task_res.hpp"
#include "thread_local_container.hpp"
#include "atrace_log.hpp"
#include "task_submit.hpp"
#include "ctrl_res_pool.hpp"
#include "task_recycle.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
EngineObserver::~EngineObserver()
{
}

void EngineObserver::TaskSubmited(Device * const dev, TaskInfo * const tsk)
{
    UNUSED(dev);
    UNUSED(tsk);
}

void EngineObserver::TaskLaunched(const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command)
{
    UNUSED(devId);
    UNUSED(tsk);
    UNUSED(command);
}

void EngineObserver::TaskFinished(const uint32_t devId, const TaskInfo * const tsk)
{
    UNUSED(devId);
    UNUSED(tsk);
}

void EngineObserver::DeviceIdle(Device * const dev)
{
    UNUSED(dev);
}

Engine::Engine(Device * const dev)
    : ThreadRunnable(),
      observerNum_(0U),
      pendingNum_(0U),
      device_(dev),
      reportCount_(0U),
      parseTaskCount_(0U),
      stmEmptyFlag_(false),
      isSubmitTaskFail_(false),
      runningState_(DEV_RUNNING_NORMAL)
{
    for (uint32_t i = 0U; i < EngineConstExpr::MAX_OBSERVER_NUM; i++) {
        observers_[i] = nullptr;
    }
    monitorIsRunning_ = true;
    RT_LOG(RT_LOG_EVENT, "Constructor.");
}

Engine::~Engine()
{
    device_        = nullptr;
    RT_LOG(RT_LOG_EVENT, "Destructor.");
}

void Engine::WaitCompletion()
{
    uint32_t taskId = 0U;
    uint32_t waitCnt = 0U;
    uint32_t idx = 0U;
    uint64_t timeout = device_->GetDevProperties().engineWaitCompletionTImeout;
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;

    while ((pendingNum_.Value() > 0U) && (device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
        const rtError_t devStatus = device_->GetDevStatus();
        COND_PROC((devStatus != RT_ERROR_NONE), break);
        if (Runtime::Instance()->GetDisableThread()) {
            if ((TaskReclaim(UINT32_MAX, false, taskId) != RT_ERROR_NONE) || stmEmptyFlag_) {
                break;
            }
        }
        if ((idx % 80000U) == 0U) { // 80000:print debug info per 80000 times
            RT_LOG(RT_LOG_DEBUG, "wait completion,taskId=%u,pendingNum=%u.", taskId, pendingNum_.Value());
            waitCnt++;
        }
        idx++;

        if (timeout > 0UL) {
            mmTimespec endTimeSpec = mmGetTickCount();
            const uint64_t endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * RT_MS_PER_S +
                                    static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
            const uint64_t count = endCnt > beginCnt ? (endCnt - beginCnt) : 0UL;
            if (count >= timeout) {
                break;
            }
        }

        constexpr uint32_t maxWaitCnt = 2U;
        if ((isSubmitTaskFail_) && (waitCnt >= maxWaitCnt)) {
            RT_LOG(RT_LOG_INFO, "WaitCompletion. task_id=%u, pendingNum=%u", taskId, pendingNum_.Value());
            break;
        }
    }
}

void Engine::SetDevRunningState(const DevRunningState state, const bool direct)
{
    if (direct || Runtime::Instance()->GetDisableThread()) {
        runningState_ = state;
    }
}

rtError_t Engine::SubmitTask(TaskInfo * const workTask, uint32_t * const flipTaskId, int32_t timeout)
{
    rtError_t ret = workTask->stream->CheckContextTaskSend(workTask);
    ERROR_RETURN(ret, "context is abort, status=%#x.", static_cast<uint32_t>(ret));
    if (workTask->stream->taskResMang_ == nullptr) {
        // for non-fast scenarios
        ret = SubmitTaskNormal(workTask, flipTaskId);
    } else {
        // for fastlaunch scenarios
        ret = AllocTaskAndSend(workTask, workTask->stream, flipTaskId, timeout);
    }

    if (ret != RT_ERROR_NONE) {
        if (Runtime::Instance()->GetDisableThread()) {
            workTask->stream->SetIsSubmitTaskFailFlag(true);
            SetIsSubmitTaskFailFlag(true);
        }

        RT_LOG(RT_LOG_WARNING, "SubmitTask stream_id=%d, task_id=%u, task_type=%u, result=%d",
            workTask->stream->Id_(), workTask->id, workTask->type, ret);
    }

    return ret;
}

TIMESTAMP_EXTERN(ObserverSubmitted);
rtError_t Engine::SubmitTaskNormal(TaskInfo * const workTask, uint32_t * const flipTaskId)
{
    if  ((!workTask->stream->IsCtrlStream()) &&
        ((workTask->stream->Id_() == -1) || (workTask->stream->Id_() == MAX_INT32_NUM))) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "stream is invalid, stream_id=%d.", workTask->stream->Id_());
        workTask->error = TASK_ERROR_SUBMIT_FAIL;
        return RT_ERROR_STREAM_INVALID;
    }

    /* save task to model for ACL */
    if ((workTask->stream->Flags() & RT_STREAM_AICPU) != 0U) {
        if (workTask->stream->NeedSaveTask(workTask)) {
            rtCommand_t command;
            (void)memset_s(&command, sizeof(rtCommand_t), 0U, sizeof(rtCommand_t));
            ToCommand(workTask, &command);
            COND_RETURN_ERROR_MSG_INNER((workTask->stream->Model_() == nullptr),
                RT_ERROR_MODEL_NULL,
                "SubmitTask fail for model null, stream_id=%d,pendingNum=%u",
                workTask->stream->Id_(),
                workTask->stream->GetPendingNum());
            (void)workTask->stream->Model_()->SaveAicpuStreamTask(workTask->stream, &command);
        }
        RT_LOG(RT_LOG_DEBUG, "aicpu stream,no need sent to ts,stream_id=%u,task_id=%u,task_type=%d (%s).",
               static_cast<uint32_t>(workTask->stream->Id_()), static_cast<uint32_t>(workTask->id),
               static_cast<int32_t>(workTask->type), workTask->typeName);
        Complete(workTask, RT_MAX_DEV_NUM);
        (void)device_->GetTaskFactory()->Recycle(workTask);
        return RT_ERROR_NONE;
    }

    TIMESTAMP_BEGIN(ObserverSubmitted);
    for (uint32_t i = 0U; i < observerNum_; i++) {
        observers_[i]->TaskSubmited(device_, workTask);
    }
    TIMESTAMP_END(ObserverSubmitted);

    return SubmitSend(workTask, flipTaskId);
}

void Engine::ReportProfData(TaskInfo * const workTask) const
{
    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if ((profilerPtr != nullptr) && (!device_->IsDeviceRelease())) {
        profilerPtr->ReportTaskTrack(workTask, device_->Id_());
    }
}

void Engine::StreamSyncTaskFinishReport() const
{
    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        profilerPtr->ReportStreamSynctaskFinish(RT_PROF_API_STREAM_SYNC_TASK_FINISH);
    }
}

TIMESTAMP_EXTERN(ReportReceive);
TIMESTAMP_EXTERN(GetRecycleTask);
TIMESTAMP_EXTERN(ObserverFinished);
TIMESTAMP_EXTERN(TaskRecycle);
TIMESTAMP_EXTERN(ReportRelease);
bool Engine::TaskRecycleProcess(TaskInfo * const recycleTsk, const uint32_t devId)
{
    if ((recycleTsk == nullptr) || (recycleTsk->stream == nullptr)) {
        return false;
    }
    Stream *stm = recycleTsk->stream;
    uint32_t taskId = recycleTsk->id;
    TIMESTAMP_BEGIN(TaskRecycle);
    Complete(recycleTsk, devId);

    SendingNotify();

    const bool terminal = static_cast<bool>(recycleTsk->terminal);
    if (!stm->IsCtrlStream()) {
        pendingNum_.Sub(1U);
    }
    // don't recycle persisten task now, delete it after stream destroy
    if (recycleTsk->bindFlag == 0U) {
        (void)device_->GetTaskFactory()->Recycle(recycleTsk);
    }

    if (Runtime::Instance()->GetDisableThread()) {
        if (stm->taskResMang_ != nullptr) {
            (void)stm->taskResMang_->RecycleTaskInfoO1(taskId);
        }
    }

    TIMESTAMP_END(TaskRecycle);
    return terminal;
}

uint32_t Engine::GetRecycleDavinciTaskNum(const uint16_t lastRecycleEndTaskId,
    const uint16_t recycleEndTaskId, const uint16_t recyclePublicTaskCount)  const
{
    uint32_t davinciTaskNum = 0U;
    uint32_t maxTaskId = MAX_UINT16_NUM - 1U;
    uint32_t totalTaskNum = 0U;

    /* cur stm first recycle */
    if (lastRecycleEndTaskId == MAX_UINT16_NUM) {
        totalTaskNum = (recycleEndTaskId + 1U);
    } else {
        if (recycleEndTaskId >= lastRecycleEndTaskId) {
            totalTaskNum = recycleEndTaskId - lastRecycleEndTaskId;
        } else {
            /* task reverse */
            totalTaskNum = (maxTaskId + recycleEndTaskId + 1U) - lastRecycleEndTaskId;
        }
    }

    if (totalTaskNum < recyclePublicTaskCount) {
        RT_LOG(RT_LOG_ERROR, "get task num failed,lastRecycleEndTaskId=%hu,recycleEndTaskId=%hu,"
            "recyclePublicTaskCount=%hu", lastRecycleEndTaskId, recycleEndTaskId, recyclePublicTaskCount);
        return 0U;
    }

    davinciTaskNum = totalTaskNum - recyclePublicTaskCount;

    return davinciTaskNum;
}

TIMESTAMP_EXTERN(ProcessPublicTask);
bool Engine::ProcessTask(TaskInfo *workTask, const uint32_t deviceId)
{
    /* if (workTask == nullptr) { mustbe not nullptr
        return false;
    } */

    Stream * const stm = workTask->stream;
    const int32_t streamId = stm->Id_();
    uint16_t lastRecycleEndTaskId = stm->GetRecycleEndTaskId();
    uint16_t recyclePublicTaskCount = 0U;
    const bool isSupportASyncRecycle = stm->GetIsSupportASyncRecycle();

    // public Task all chip type need to recycle
    TIMESTAMP_BEGIN(ProcessPublicTask);
    const bool status = ProcessPublicTask(workTask, deviceId, &recyclePublicTaskCount);
    TIMESTAMP_END(ProcessPublicTask);

    /* not support async recycle */
    if (!isSupportASyncRecycle) {
        return status;
    }

    /* no task need recycle */
    uint16_t recycleEndTaskId = stm->GetRecycleEndTaskId();
    if ((recycleEndTaskId == MAX_UINT16_NUM) || (recycleEndTaskId == lastRecycleEndTaskId)) {
        return status;
    }

    Stream *recycleStm = nullptr;
    (void)device_->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(streamId), &recycleStm);
    if (recycleStm == nullptr) {
        recycleStm = stm;
    }

    if (recycleStm->isHasPcieBar_) {
        uint32_t davinciTaskNum = GetRecycleDavinciTaskNum(lastRecycleEndTaskId, recycleEndTaskId,
                                                           recyclePublicTaskCount);

        recycleStm->BatchDelDavinciRecordedTask(recycleEndTaskId, davinciTaskNum);

        // O(n)-->O(1)
        if (davinciTaskNum != 0U) {
            (void)recycleStm->taskResMang_->RecycleTaskInfoOn(recycleEndTaskId);
        }
        if (!recycleStm->IsCtrlStream()) {
            pendingNum_.Sub(davinciTaskNum);
        }
    } else {
        /* if error occured or not is streamSync process, process davinci task in main thread */
        if (!(recycleStm->GetStreamAsyncRecycleFlag())) {
            (void)ProcessTaskDavinciList(recycleStm, recycleEndTaskId, deviceId);
        }
    }

    return status;
}

void Engine::TrigerAsyncRecycle(Stream * const stm, const uint16_t lastRecycleTaskId,
                                const uint16_t endTaskId, bool isTaskDelayRecycle)
{
    bool isNeedAsyncRecycle = stm->GetIsSupportASyncRecycle() && stm->GetStreamAsyncRecycleFlag();

    if (isTaskDelayRecycle) {
        if (lastRecycleTaskId != MAX_UINT16_NUM) {
            stm->SetRecycleEndTaskId(lastRecycleTaskId);
        }
    } else {
        stm->SetRecycleEndTaskId(static_cast<uint16_t>(endTaskId));
    }

    /* not support async recycle or no task need recycle */
    if ((!isNeedAsyncRecycle) || (stm->GetRecycleEndTaskId() == MAX_UINT16_NUM)) {
        if (device_->IsNeedFreeEventId()) {
            device_->WakeUpRecycleThread();
        }
        return;
    }

    if (device_->AddStreamToMessageQueue(stm)) {
        device_->WakeUpRecycleThread();
    }

    return;
}

bool Engine::ProcessPublicTask(TaskInfo *workTask, const uint32_t deviceId, uint16_t *recycleTaskCount)
{
    if (workTask == nullptr) {
        return false;
    }

    Stream * const stm = workTask->stream;
    const uint16_t endTaskId = static_cast<uint16_t>(workTask->id);
    const int32_t streamId = static_cast<int32_t>(stm->Id_());
    const bool bindFlag = workTask->bindFlag;
    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    bool resultFlag = false;
    bool isNeedAsyncRecycle = stm->GetIsSupportASyncRecycle() && stm->GetStreamAsyncRecycleFlag();
    bool isTaskDelayRecycle = false;
    bool streamFreeFlag = false;
    const uint32_t endTaskSqPos = workTask->pos;
    const uint32_t endTaskSqeNum = GetSendSqeNum(workTask);
    uint16_t count = 0U;
    uint16_t lastRecycleTaskId = MAX_UINT16_NUM;
    uint16_t delTaskId = 0U;
    rtError_t error = RT_ERROR_NONE;

    Stream *recycleStm = stm;
    if (isNeedAsyncRecycle) {
        (void)device_->GetStreamSqCqManage()->GetStreamById(static_cast<uint32_t>(streamId), &recycleStm);
        if (recycleStm == nullptr) {
            RT_LOG(RT_LOG_ERROR, "get stream info failed,stream_id=%d", streamId);
            return false;
        }
    }

    do {
        error = GetPublicRecycleTask(workTask, recycleStm, bindFlag, endTaskId, &delTaskId);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "Get delete task failed,stream_id=%d,tail_task_id=%hu,del_task_id=%hu,retCode=%#x.",
                streamId, endTaskId, delTaskId, static_cast<uint32_t>(error));
            break;
        }

        workTask = GetRecycleWorkTask(recycleStm, delTaskId);
        if (workTask == nullptr) {
            // maybe random order occurred
            RT_LOG(RT_LOG_EVENT, "workTask has been recycled,stream_id=%d,isHasPcieBar_=%d "
                "task_id=%u endTaskId=%hu", streamId, recycleStm->isHasPcieBar_,
                static_cast<uint32_t>(delTaskId), endTaskId);
            error = DelPublicRecycleTask(workTask, recycleStm, bindFlag, endTaskId);
            COND_LOG(error != RT_ERROR_NONE, "Delete task failed,stream_id=%d,tail_task_id=%hu,del_task_id=%hu,"
                "retCode=%#x.", streamId, endTaskId, delTaskId, static_cast<uint32_t>(error));

            break;
        }

        // check task is can be recycled
        if (workTask->isCqeNeedConcern &&
            unlikely((recycleStm->GetFailureMode() != ABORT_ON_FAILURE) && (!stm->isForceRecycle_))) {
            RT_LOG(RT_LOG_DEBUG, "Task delay recycle until CQE received, stream_id=%d, task_id=%hu", stm->Id_(),
                   workTask->id);
            isTaskDelayRecycle = true;
            stm->SetNeedRecvCqeFlag(true);
            break;
        }

        error = DelPublicRecycleTask(workTask, recycleStm, bindFlag, endTaskId);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "Delete task failed,stream_id=%d,tail_task_id=%hu,del_task_id=%hu,retCode=%#x.",
                streamId, endTaskId, delTaskId, static_cast<uint32_t>(error));
            break;
        }

        delTaskId = workTask->id;
        lastRecycleTaskId = static_cast<uint16_t>(workTask->id);
        streamFreeFlag = IsNeedFreeStreamRes(workTask);
        recycleStm->UpdateTaskPosHead(workTask->pos, GetSendSqeNum(workTask));

        if (isNeedAsyncRecycle && recycleStm->isHasPcieBar_ && recycleStm->IsDavinciTask(workTask)) {
            recycleStm->AddArgToRecycleList(workTask);
        }

        ProcessProfAndObserver(workTask, deviceId);
        if (TaskRecycleProcess(workTask, deviceId)) {
            resultFlag = true;
            break;
        }

        count++;

        if (isDisableThread && TaskIdIsGT(static_cast<uint32_t>(delTaskId), static_cast<uint32_t>(endTaskId))) {
            RT_LOG(RT_LOG_DEBUG, "DelTaskId is greater than endTaskId, delTaskId=%hu endTaskId=%hu.",
                   delTaskId, endTaskId);
            break;
        }
    } while (static_cast<uint32_t>(delTaskId) != static_cast<uint32_t>(endTaskId));

    *recycleTaskCount = count;

    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, delTaskId=%hu, bindFlag=%d, streamFreeFlag=%d, resultFlag=%d.",
        device_->Id_(), streamId, delTaskId, bindFlag, streamFreeFlag, resultFlag);
    if ((!bindFlag) && (!Runtime::Instance()->GetDisableThread()) && streamFreeFlag) {
        return resultFlag;
    }

    if (!isTaskDelayRecycle) {
        recycleStm->UpdateTaskPosHead(endTaskSqPos, endTaskSqeNum);
    }

    TrigerAsyncRecycle(recycleStm, lastRecycleTaskId, endTaskId, isTaskDelayRecycle);
    return resultFlag;
}

bool Engine::ProcessTaskDavinciList(Stream * const stm,  const uint16_t endTaskId, const uint32_t deviceId)
{
    if (endTaskId == MAX_UINT16_NUM) {
        RT_LOG(RT_LOG_DEBUG, "endTaskId is invalid, endTaskId=%hu.", endTaskId);
        return false;
    }

    const std::unique_lock<std::mutex> lk(davinciTaskListMutex_);
    if (stm == nullptr) {
        RT_LOG(RT_LOG_INFO, "stm is null, task is already delete, endTaskId=%hu.", endTaskId);
        return false;
    }
    const bool disableThreadFlag = Runtime::Instance()->GetDisableThread();
    const int32_t streamId = static_cast<int32_t>(stm->Id_());
    uint16_t delTaskId = 0U;
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *recycleTsk = nullptr;
    do {
        error = GetDavinciDelRecordedTask(stm, endTaskId, &delTaskId);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_DEBUG, "Delete task failed, stream_id=%d, tail_task_id=%hu, del_task_id=%hu, retCode=%#x.",
                streamId, endTaskId, delTaskId, static_cast<uint32_t>(error));
            break;
        }

        recycleTsk = GetRecycleWorkTask(stm, delTaskId);
        if (recycleTsk == nullptr) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can't find davinci from factory, device_id=%u, stream_id=%d, "
                "isHasPcieBar_=%d, hasTaskResMang_=%u, task_id=%u, endTaskId=%hu, pendingNum=%u, lastTaskId=%u",
                deviceId, streamId, stm->isHasPcieBar_, (stm->taskResMang_ == nullptr) ? 0 : 1,
                static_cast<uint32_t>(delTaskId), endTaskId, stm->pendingNum_.Value(), stm->GetLastTaskId());
            break;
        }

        delTaskId = recycleTsk->id;
        ProcessProfAndObserver(recycleTsk, deviceId);
        if (TaskRecycleProcess(recycleTsk, deviceId)) {
            RT_LOG(RT_LOG_INFO, "process terminal, stream_id=%d task_id=%hu.", streamId, delTaskId);
            return true;
        }

        if (disableThreadFlag && TaskIdIsGT(static_cast<uint32_t>(delTaskId), static_cast<uint32_t>(endTaskId))) {
            RT_LOG(RT_LOG_DEBUG, "DelTaskId is greater than endTaskId, delTaskId=%hu endTaskId=%hu.",
                   delTaskId, endTaskId);
            break;
        }
    } while (static_cast<uint32_t>(delTaskId) != static_cast<uint32_t>(endTaskId));

    RT_LOG(RT_LOG_DEBUG, "ProcessTask stream_id=%d, delTaskId=%hu.", streamId, delTaskId);
    return false;
}

void Engine::ProcessProfAndObserver(TaskInfo *workTask, const uint32_t deviceId)
{
    const Profiler * const profilerPtr = Runtime::Instance()->Profiler_();
    if (!(workTask->preRecycleFlag)) {
        workTask->error = 0U;
        if (profilerPtr != nullptr) {
            profilerPtr->ReportReceivingRun(workTask, deviceId);
        }

        TIMESTAMP_BEGIN(ObserverFinished);
        TaskFinished(deviceId, workTask);
        TIMESTAMP_END(ObserverFinished);
    }
    return;
}

rtError_t Engine::DelPublicRecycleTask(const TaskInfo * const workTask, Stream * const stm, const bool isTaskBind,
    const uint16_t endTaskId) const
{
    if (device_->IsStarsPlatform()) {
        return stm->StarsTryDelRecordedTask(workTask, isTaskBind, endTaskId);
    } else {
        return stm->TryDelRecordedTask(isTaskBind, endTaskId);
    }
}

rtError_t Engine::GetPublicRecycleTask(TaskInfo * const workTask, Stream * const stm, const bool isTaskBind,
    const uint16_t endTaskId, uint16_t * const delTaskId) const
{
    if (device_->IsStarsPlatform()) {
        return stm->StarsGetPublicTaskHead(workTask, isTaskBind, endTaskId, delTaskId);
    } else {
        return stm->GetPublicTaskHead(isTaskBind, endTaskId, delTaskId);
    }
}

rtError_t Engine::GetDavinciDelRecordedTask(Stream * const stm, const uint16_t endTaskId,
                                            uint16_t * const delTaskId) const
{
    return stm->TryDelDavinciRecordedTask(endTaskId, delTaskId);
}


TaskInfo* Engine::GetRecycleWorkTask(Stream * const stm, const uint16_t delTaskId) const
{
    TaskInfo* workTsk = nullptr;
    TIMESTAMP_BEGIN(GetRecycleTask);
    const int32_t streamId = static_cast<int32_t>(stm->Id_());
    workTsk = device_->GetTaskFactory()->GetTask(streamId, delTaskId);
    TIMESTAMP_END(GetRecycleTask);
    return workTsk;
}

void Engine::GetProfileEnableFlag(uint8_t * const profileEnabled) const
{
    static const Profiler * const profilerPtr = RtPtrToPtr<const Profiler *>(Runtime::Instance()->Profiler_());
    static const uint32_t deviceId = device_->Id_();
    if (profilerPtr != nullptr) {
        if (profilerPtr->IsEnabled(deviceId)) {
            *profileEnabled = 1U;
        } else {
            *profileEnabled = 0U;
        }
    } else {
        *profileEnabled = 0U;
    }
}

TIMESTAMP_EXTERN(ObserverLaunched);
void Engine::ProcessObserver(const uint32_t deviceId, TaskInfo * const task, rtTsCommand_t * const command) const
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }
    TIMESTAMP_BEGIN(ObserverLaunched);
    for (uint32_t i = 0U; i < observerNum_; ++i) {
        observers_[i]->TaskLaunched(deviceId, task, command);
    }
    TIMESTAMP_END(ObserverLaunched);
}

TIMESTAMP_EXTERN(Engine_ProcessTaskWait);
rtError_t Engine::ProcessTaskWait(TaskInfo * const task) const
{
    rtError_t error = RT_ERROR_NONE;

    TIMESTAMP_BEGIN(Engine_ProcessTaskWait);
    error = WaitAsyncCopyComplete(task);
    if (unlikely(error != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "WaitAsyncCopyComplete Failed. task_id=%hu, task_type=%d (%s), retCode=%d.",
            task->id, static_cast<int32_t>(task->type), task->typeName, error);
        TIMESTAMP_END(Engine_ProcessTaskWait);
        return error;
    }

    error = WaitExecFinish(task);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "WaitExecFinish Failed. task_id=%hu, taskType = %u, error = %#x, [%s].",
            task->id, static_cast<int32_t>(task->type), error, GetTsErrDescByRtErr(error));
        TIMESTAMP_END(Engine_ProcessTaskWait);
        return error;
    }
    TIMESTAMP_END(Engine_ProcessTaskWait);

    return error;
}

TIMESTAMP_EXTERN(CommandOccupy);
TIMESTAMP_EXTERN(ToCommand);
TIMESTAMP_EXTERN(CommandSend);
rtError_t Engine::TryAddTaskToStream(TaskInfo * const workTask)
{
    uint8_t failCount = 0U;
    Stream * const stm = workTask->stream;
    rtError_t error = RT_ERROR_NONE;
    do {
        error = stm->AddTaskToStream(workTask);
        RT_LOG(RT_LOG_INFO, "bindFlag=%u, stream_id=%d, task_id=%hu, task_type=%d(%s), head=%u, tail=%u, delay recycle task num=%zu"
            "isSupportASyncRecycle=%d, isNeedPostProc=%d, davincHead=%u, davincTail=%u, taskHead=%u, taskTail=%u",
            workTask->bindFlag, stm->Id_(), workTask->id, static_cast<int32_t>(workTask->type), workTask->typeName,
            stm->GetTaskPersistentHeadValue(), stm->GetDelayRecycleTaskSqeNum(), stm->GetDelayRecycleTaskSize(),
            stm->GetIsSupportASyncRecycle(), stm->IsNeedPostProc(workTask), stm->GetDavinciTaskHead(), stm->GetDavinciTaskTail(),
            stm->GetTaskHead(), stm->GetTaskTail());

        if (unlikely(error != RT_ERROR_NONE)) {
            stm->SetStreamAsyncRecycleFlag(true);
            SendingWait(stm, failCount);
            stm->SetStreamAsyncRecycleFlag(false);
            error = stm->CheckContextTaskSend(workTask);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        } else {
            break;
        }
    } while (true);
    return RT_ERROR_NONE;
}

void Engine::SetReportSimuFlag(const rtTsReport_t &taskReport) const
{
    rtStarsCqe_t * const cqe = taskReport.msgBuf.starsCqe;
    /*
     * Event flag and place_hold flag don't exist on a real cqe at the same time,
     * so it's used as a flag of Simulate report
     */
    cqe->evt = 1U;
    cqe->place_hold = 1U;
}

bool Engine::CheckReportSimuFlag(const rtTsReport_t &taskReport) const
{
    if (taskReport.msgType != TS_REPORT_MSG_TYPE_STARS_CQE) {
        return false;
    }
    rtStarsCqe_t * const cqe = taskReport.msgBuf.starsCqe;
    if ((cqe->evt == 1U) && (cqe->place_hold == 1U)) {
        return true;
    }
    return false;
}

rtError_t Engine::ReportHeartBreakProcV2(void)
{
    // TS Heartbeat Down
    rtError_t ret = RT_ERROR_NONE;
    drvStatus_t status = DRV_STATUS_INITING;
    Driver * const devDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    if (devDrv == nullptr) {
        RT_LOG(RT_LOG_ERROR, "devDrv is nullptr.");
        return RT_ERROR_LOST_HEARTBEAT;
    }
    ret = devDrv->GetDeviceStatus(GetDevice()->Id_(), &status);
    if ((ret == RT_ERROR_NONE) &&
        ((status == DRV_STATUS_EXCEPTION) || (status == DRV_STATUS_COMMUNICATION_LOST))) {
        RT_DEVICE_RUNNING_DOWN_LOG(status);
        GetDevice()->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
        Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);
        SetDevRunningState(DEV_RUNNING_DOWN, true);
        ret = RT_ERROR_LOST_HEARTBEAT;
        if (Runtime::Instance()->excptCallBack_ != nullptr) {
            Runtime::Instance()->excptCallBack_(RT_EXCEPTION_DEV_RUNNING_DOWN);
        }
    }
    return ret;
}

void Engine::ReportStatusFailProc(const rtError_t error, const uint32_t deviceId) const
{
    if ((error == RT_ERROR_SOCKET_CLOSE) || (error == RT_ERROR_LOST_HEARTBEAT)) {
        RT_LOG(RT_LOG_ERROR, "Device status failure, ret=%u, start exception CallBack.", error);
        rtExceptionInfo_t exceptionInfo;
        exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(error));
        exceptionInfo.taskid = UINT32_MAX;
        exceptionInfo.streamid = UINT32_MAX;
        exceptionInfo.tid = UINT32_MAX;
        exceptionInfo.deviceid = deviceId;
        (void)memset_s(&(exceptionInfo.expandInfo), sizeof(exceptionInfo.expandInfo),
                       0, sizeof(exceptionInfo.expandInfo));
        TaskFailCallBackNotify(&exceptionInfo);
    }
}

void Engine::ReportSocketCloseProcV2()
{
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CONNECT);
    const int32_t hdcStatus = Runtime::Instance()->GetHdcConctStatus(device_->Id_(), hdcStat);
    if (hdcStatus == RT_ERROR_NONE) {
        const rtError_t hdcErr = static_cast<rtError_t>((hdcStat == static_cast<int32_t>(HDC_SESSION_STATUS_CLOSE)) ?
            RT_ERROR_SOCKET_CLOSE : RT_ERROR_NONE);
        if (hdcErr == RT_ERROR_SOCKET_CLOSE) {
            ReportStatusFailProc(hdcErr, device_->Id_());
            RT_DEVICE_RUNNING_DOWN_LOG(hdcErr);
            GetDevice()->SetDevStatus(RT_ERROR_SOCKET_CLOSE);
            Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);
            SetDevRunningState(DEV_RUNNING_DOWN);
        }
    }
}

void Engine::ReportStatusOomProc(const rtError_t error, const uint32_t deviceId) const
{
    TrySaveAtraceLogs(device_->GetAtraceEventHandle());
    RT_LOG(RT_LOG_ERROR, "Device Aicpu oom, ret=%#x device_id=%u, start exception CallBack.", error, deviceId);
    rtExceptionInfo_t exceptionInfo;
    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(error));
    exceptionInfo.deviceid = deviceId;
    exceptionInfo.tid = UINT32_MAX;
    exceptionInfo.streamid = UINT32_MAX;
    exceptionInfo.taskid = UINT32_MAX;
    (void)memset_s(&(exceptionInfo.expandInfo), sizeof(exceptionInfo.expandInfo),
                   0, sizeof(exceptionInfo.expandInfo));
    TaskFailCallBackNotify(&exceptionInfo);
}

void Engine::ReportSocketCloseProc()
{
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CONNECT);
    int32_t hdcStatus = Runtime::Instance()->GetHdcConctStatus(device_->Id_(), hdcStat);
    if (hdcStatus == RT_ERROR_NONE) {
        const rtError_t hdcErr = static_cast<rtError_t>((hdcStat == static_cast<int32_t>(HDC_SESSION_STATUS_CLOSE)) ?
            RT_ERROR_SOCKET_CLOSE : RT_ERROR_NONE);
        if (hdcErr == RT_ERROR_SOCKET_CLOSE) {
            RT_DEVICE_RUNNING_DOWN_LOG(hdcErr);
            GetDevice()->SetDevStatus(RT_ERROR_SOCKET_CLOSE);
            Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);
            SetDevRunningState(DEV_RUNNING_DOWN);

            if (static_cast<rtRunMode>(NpuDriver::RtGetRunMode()) == RT_RUN_MODE_OFFLINE) {
                ReportStatusFailProc(hdcErr, device_->Id_());
            }
        }
    }
}

void Engine::ReportOomQueryProc() const
{
    const rtError_t error = NpuDriver::GetDeviceAicpuStat(device_->Id_());
    if (error == RT_ERROR_DEVICE_OOM) {
        ReportStatusOomProc(error, device_->Id_());
    }
}

TIMESTAMP_EXTERN(DeviceIdle);
void Engine::ReportTimeoutProc(const rtError_t error, int32_t &timeoutCnt, const uint32_t streamId,
    const uint32_t taskId, const uint32_t execId, const uint64_t msec)
{
    const uint32_t pendingTaskNum = pendingNum_.Value();
    if (pendingTaskNum == 0U) {
        TIMESTAMP_BEGIN(DeviceIdle);
        for (uint32_t i = 0U; i < observerNum_; i++) {
            observers_[i]->DeviceIdle(device_);
        }
        TIMESTAMP_END(DeviceIdle);
        return;
    }

    if (error != RT_ERROR_REPORT_TIMEOUT) {
        timeoutCnt = 0;
        return;
    }
    timeoutCnt++;
    if (timeoutCnt >= Runtime::macroValue_.maxReportTimeoutCnt) {
        timeoutCnt = 0;
        const mmTimespec curTimeSpec = mmGetTickCount();
        const uint64_t curmsec = static_cast<uint64_t>(curTimeSpec.tv_sec) * RT_MS_PER_S +
            static_cast<uint64_t>(curTimeSpec.tv_nsec) / RT_MS_TO_NS;

        TaskInfo * const task = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId),
            static_cast<uint16_t>(taskId));
        const std::string mdlName = ((task != nullptr) && (task->stream != nullptr)) ? task->stream->SyncMdlName() : "";
        const int32_t mdlId = ((task != nullptr) && (task->stream != nullptr)) ? task->stream->SyncMdlId() : -1;
        RT_LOG(RT_LOG_EVENT, "report timeout!streamId=%u,taskId=%u,execId=%u,pendingNum=%u,reportCount=%" PRIu64
            ",parseTaskCount=%" PRIu64 ",msec=%" PRIu64 ",curSec=%" PRIu64 ",model=%s,modelId=%d", streamId, taskId,
            execId, pendingTaskNum, reportCount_, parseTaskCount_, msec, curmsec, mdlName.c_str(), mdlId);

        if (Runtime::Instance()->excptCallBack_ != nullptr) {
            Runtime::Instance()->excptCallBack_(RT_EXCEPTION_TASK_TIMEOUT);
        } else {
            RT_LOG(RT_LOG_INFO, "excptCallBack_ is null.");
        }
    }
}

bool Engine::IsExeTaskSame(Stream *const stm, uint32_t taskId) const
{
    if (taskId == stm->GetCheckTaskId()) {
        return false;
    }
    stm->SetCheckTaskId(taskId);
    return true;
}

void Engine::SendingWait(Stream * const stm, uint8_t &failCount)
{
    UNUSED(stm);
    UNUSED(failCount);
}

void Engine::RecycleTask(const uint32_t streamId, const uint32_t taskId)
{
    TaskInfo * const workTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId),
        static_cast<uint16_t>(taskId));
    if (workTask == nullptr) {  // Released already.
        RT_LOG(RT_LOG_WARNING, "Get null task from stream_id=%u, task_id=%u", streamId, taskId);
        return;
    }

    bool isRecvOk = CheckPackageState(workTask);
    tsTaskType_t taskType = workTask->type;
    if ((taskType == TS_TASK_TYPE_MULTIPLE_TASK) && (!isRecvOk)) {     // no new task.
        RT_LOG(RT_LOG_DEBUG, "multiple task recv pkg has not enough, cannot recycle");
        return;
    }

    reportCount_++;

    RT_LOG(RT_LOG_DEBUG, "Report receive, stream_id=%u, task_id=%u, task_type=%u(%s).",
        streamId, workTask->id, static_cast<uint32_t>(taskType), workTask->typeName);
    if (streamId != static_cast<uint32_t>(workTask->stream->Id_())) {
        RT_LOG(RT_LOG_WARNING, "stream id:%u and task stream id: %d not equal.", streamId, workTask->stream->Id_());
    }

    parseTaskCount_++;
    if (unlikely(reportCount_ != parseTaskCount_)) {
        RT_LOG(RT_LOG_WARNING, "stream_id=%u taskId =%hu task_type=%u(%s) report_count=%" PRIu64
               " parse_task_count=%" PRIu64 " not equal",
               streamId, workTask->id, static_cast<uint32_t>(taskType), workTask->typeName,
            reportCount_, parseTaskCount_);
    }

    workTask->error = 0U;
    bool ret = ProcessTask(workTask, device_->Id_());
    RT_LOG(RT_LOG_DEBUG, "Process report task, stream_id=%u, tail_task_id=%hu, ret=%u.", streamId, workTask->id, ret);
    return;
}

void Engine::RecycleCtrlTask(CtrlStream* const stm, const uint32_t sqPos)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t pos = sqPos;
    uint32_t taskId = UINT32_MAX;
    TaskInfo *workTask = nullptr;
    const uint32_t endPos = stm->GetSqTailPos();

    RT_LOG(RT_LOG_INFO, "[ctrlsq]recycle ctrl task, targetPos=%u, sqTailPos=%u.", sqPos, endPos);
    do {
        error = stm->GetTaskIdByPos(static_cast<uint16_t>(pos), taskId);
        if (error != RT_ERROR_NONE) {
            break;
        }

        workTask = device_->GetCtrlResEntry()->GetTask(taskId);
        if (workTask == nullptr) {
            stm->DelPosToCtrlTaskIdMap(static_cast<uint16_t>(pos));
            RT_LOG(RT_LOG_INFO, "[ctrlsq]Can't find ctrl task from res, pos=%u is deleted.", pos);
            pos = ((pos + stm->sqDepth) - 1U) % stm->sqDepth;
            continue;
        }

        stm->DelPosToCtrlTaskIdMap(static_cast<uint16_t>(pos));
        TIMESTAMP_BEGIN(ObserverFinished);
        TaskFinished(device_->Id_(), workTask);
        TIMESTAMP_END(ObserverFinished);
        RT_LOG(RT_LOG_INFO, "[ctrlsq]process task recycle,stream_id=%d, task_id=%u, task_type=%d (%s).",
            stm->Id_(), taskId, static_cast<int32_t>(workTask->type), workTask->typeName);
        (void)TaskRecycleProcess(workTask, device_->Id_());
        pos = ((pos + stm->sqDepth) - 1U) % stm->sqDepth;
    } while (pos != endPos);

    return;
}

rtError_t Engine::TaskReclaimByStm(Stream * const stm, const bool limited, uint32_t &taskId)
{
    return TaskReclaim(static_cast<uint32_t>(stm->Id_()), limited, taskId);
}

void Engine::CtrlTaskReclaim(CtrlStream*const stm)
{
    uint32_t currPosId = UINT32_MAX;

    const rtError_t error = stm->GetHeadPosFromCtrlSq(currPosId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetHeadPosFromCtrlSq fail, error=%d.", error);
        return;
    }
    RT_LOG(RT_LOG_INFO, "[ctrlsq]reclaim ctrl task sqHead=%u.", currPosId);
    (void)RecycleCtrlTask(stm, currPosId);
    return;
}

rtError_t Engine::SendFlipTask(uint16_t preTaskId, Stream *stm)
{
    if (!stm->IsNeedSendFlipTask(preTaskId)) {
        return RT_ERROR_NONE;
    }
    uint16_t taskId = 0U;
    TaskInfo newTask = {};
    TaskInfo *fliptask = &newTask;

    RT_LOG(RT_LOG_DEBUG, "SendFlipTask, dev_id=%u, stream_id=%d.", device_->Id_(), stm->Id_());
    rtError_t error = stm->ProcFlipTask(fliptask, stm->GetTaskIdFlipNum());
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    TIMESTAMP_BEGIN(ObserverSubmitted);
    for (uint32_t i = 0U; i < observerNum_; ++i) {
        observers_[i]->TaskSubmited(device_, fliptask);
    }
    TIMESTAMP_END(ObserverSubmitted);
    error = SendTask(fliptask, taskId);

    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "SendFlipTask failed, dev_id=%u, stream_id=%d, task_id=%hu, flipNumReport=%hu, retCode=%#x.",
        device_->Id_(), stm->Id_(), fliptask->id, fliptask->u.flipTask.flipNumReport, error);
    RT_LOG(RT_LOG_INFO, "SendFlipTask dev_id=%u, stream_id=%d, task_id=%hu, flipNum=%hu.",
        device_->Id_(), stm->Id_(), fliptask->id, fliptask->u.flipTask.flipNumReport);
    pendingNum_.Add(1U);
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    TaskFinished(device_->Id_(), fliptask);
    (void)device_->GetTaskFactory()->Recycle(fliptask);
    return error;
}
rtError_t Engine::SendCommand(TaskInfo * const workTask, rtTsCommand_t &cmdLocal, rtTsCmdSqBuf_t * const command,
                              const uint32_t sendSqeNum)
{
    uint8_t  profileEnable;
    Stream   * const stm = workTask->stream;
    const uint32_t deviceId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();
    Driver * const devDrv = device_->Driver_();
    rtError_t error = RT_ERROR_NONE;
    const bool starsFlag = device_->IsStarsPlatform();
    cmdLocal.cmdType = (starsFlag) ? RT_TASK_COMMAND_TYPE_STARS_SQE : RT_TASK_COMMAND_TYPE_TS_COMMAND;

    TIMESTAMP_BEGIN(ToCommand);
    GetProfileEnableFlag(&profileEnable);
    workTask->profEn = profileEnable;

    const Profiler * const profilerObj = Runtime::Instance()->Profiler_();
    if ((profilerObj != nullptr) && (profilerObj->GetProfLogEnable())) {
        profilerObj->ReportSend(workTask->id, static_cast<uint16_t>(stm->Id_()));
    }

    if (cmdLocal.cmdType == RT_TASK_COMMAND_TYPE_STARS_SQE) {
        // command is host memory, use itself directly
        ToConstructSqe(workTask, &(command->starsSqe));
    } else {
        command->cmd = cmdLocal.cmdBuf.cmd;
    }
    TIMESTAMP_END(ToCommand);

    TIMESTAMP_BEGIN(ObserverLaunched);
    for (uint32_t i = 0U; i < observerNum_; ++i) {
        observers_[i]->TaskLaunched(deviceId, workTask, &cmdLocal);
    }
    TIMESTAMP_END(ObserverLaunched);

    error = WaitAsyncCopyComplete(workTask);
    if (unlikely(error != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "copy error device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d,"
            " task_id=%hu, task_type=%d(%s), retCode=%d.",
            deviceId, tsId, sqId, cqId, stm->Id_(), workTask->id,
            static_cast<int32_t>(workTask->type), workTask->typeName, error);
        return error;
    }

    error = WaitExecFinish(workTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "WaitExecFinish Failed. taskType = %u, error = %#x, [%s].",
            static_cast<int32_t>(workTask->type), error, GetTsErrDescByRtErr(error));
        return error;
    }
    TIMESTAMP_BEGIN(CommandSend);
    error = devDrv->CommandSend(sqId, command, GetReportCount(workTask->pkgStat, profileEnable),
                                deviceId, tsId, sendSqeNum);
    TIMESTAMP_END(CommandSend);

    return error;
}

TIMESTAMP_EXTERN(TaskSendLimited);
TIMESTAMP_EXTERN(TryRecycleTask);
TIMESTAMP_EXTERN(CommandOccupyNormal);
rtError_t Engine::SendTask(TaskInfo * const workTask, uint16_t &taskId, uint32_t * const flipTaskId)
{
    Stream * const stm = workTask->stream;
    COND_RETURN_ERROR_MSG_INNER(((stm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U), RT_ERROR_STREAM_INVALID,
    "Kernel launch with args failed, the stm[%u] can not be coprocessor stream flag=%u.",
            stm->Id_(), stm->Flags());

    TIMESTAMP_BEGIN(TryRecycleTask);
    rtError_t error = TryRecycleTask(stm);
    TIMESTAMP_END(TryRecycleTask);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Try recycle task failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    uint8_t failCount = 0U;
    constexpr uint16_t perDetectTimes = 1000U;
    uint32_t tryCount = 0U;

    while (stm->IsTaskLimited(workTask) && (!stm->GetRecycleFlag())) {
        TIMESTAMP_BEGIN(TaskSendLimited);
        stm->SetStreamAsyncRecycleFlag(true);
        SendingWait(stm, failCount);   // Send limited, need release complete task.
        stm->SetStreamAsyncRecycleFlag(false);
        TIMESTAMP_END(TaskSendLimited);
        if ((tryCount % perDetectTimes) == 0) {
            error = stm->CheckContextTaskSend(workTask);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x", static_cast<uint32_t>(error));
        }
        tryCount++;
    }
    Driver * const devDrv = device_->Driver_();
    const uint32_t devId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();
    const uint32_t sendSqeNum = GetSendSqeNum(workTask);
    uint32_t pos = 0U;
    COND_RETURN_ERROR_MSG_INNER(devDrv == nullptr, RT_ERROR_DRV_ERR, "Can't find device driver.");
    StreamSqCqManage * const stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());

    std::mutex * const sqMutex = stmSqCqManage->GetSqMutex(sqId);
    if (sqMutex == nullptr) {
        RT_LOG(RT_LOG_ERROR, "GetSqMutex failed: sqId=%u", sqId);
        return RT_ERROR_INVALID_VALUE;
    }

    stm->StreamLock();
    const rtError_t status = stm->abortStatus_;
    if (status != RT_ERROR_NONE) {
        stm->StreamUnLock();
        return status;
    }
    device_->GetTaskFactory()->SetSerialId(stm, workTask);
    taskId = workTask->id;
    COND_PROC(flipTaskId != nullptr,
        *flipTaskId = GetFlipTaskId(workTask->id, workTask->flipNum););
    if ((stm->Model_() != nullptr) && (workTask->type != TS_TASK_TYPE_MODEL_MAINTAINCE)) {
        stm->Model_()->SetKernelTaskId(static_cast<uint32_t>(workTask->id), static_cast<int32_t>(stm->Id_()));
    }

    ReportProfData(workTask);

    rtTsCommand_t  cmdLocal;
    rtTsCmdSqBuf_t *command = nullptr;
    /*
     * command is device shared memory.
     * Accessing stack memory is faster than accessing device shared memory
     */
    (void)memset_s(&(cmdLocal.cmdBuf.cmd), sizeof(rtCommand_t), 0U, sizeof(rtCommand_t));
    ToCommand(workTask, &(cmdLocal.cmdBuf.cmd));

    // try add task to stream task buffer
    if (!stm->IsCtrlStream()) {
        error = TryAddTaskToStream(workTask);
        if (error != RT_ERROR_NONE) {
            stm->StreamUnLock();
            return error;
        }
    }
    const std::lock_guard<std::mutex> lk(*sqMutex);
    stm->StreamUnLock();
    TIMESTAMP_BEGIN(CommandOccupyNormal);
    error = devDrv->CommandOccupy(sqId, &command, sendSqeNum, devId, tsId, &pos);
    TIMESTAMP_END(CommandOccupyNormal);
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    tryCount = 0U;
    while (command == nullptr) {
        RT_LOG(RT_LOG_WARNING, "device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
            " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%u.",
            devId, tsId, sqId, cqId, stm->Id_(), workTask->id,
            static_cast<uint32_t>(workTask->type), workTask->typeName,
            static_cast<uint32_t>(error));
        TIMESTAMP_BEGIN(CommandOccupy);
        error = devDrv->CommandOccupy(sqId, &command, sendSqeNum, devId, tsId, &pos);
        TIMESTAMP_END(CommandOccupy);
        tryCount++;
        stm->SetFlowCtrlFlag();
        COND_RETURN_ERROR((stm->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, tryCount) != RT_ERROR_NONE),
            error, "device status down when command occupy, device_id=%u, stream_id=%d", devId, stm->Id_());
    }

    if (stm->IsCtrlStream()) {
        stm->SetSqTailPos(pos);
        (void)(dynamic_cast<CtrlStream*>(stm))->AddTaskToStream(pos, workTask);
    }

    const uint32_t posTail = stm->GetBindFlag() ? stm->GetDelayRecycleTaskSqeNum() : stm->GetTaskPosTail();
    const uint32_t posHead = stm->GetBindFlag() ? stm->GetTaskPersistentHeadValue() : stm->GetTaskPosHead();
    const uint32_t rtsqDepth = (((stm->Flags() & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : stm->GetSqDepth();
    const uint32_t newPosTail = (posTail + sendSqeNum) % rtsqDepth;
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d, task_id=%hu, task_type=%u(%s), "
        "isSupportASyncRecycle=%d, isNeedPostProc=%d, davincHead=%u, davincTail=%u, taskHead=%u, taskTail=%u, "
        "bindFlag=%d, head=%u, tail=%u, lastTail=%u, delay recycle num=%zu.",
        devId, tsId, sqId, cqId, stm->Id_(), workTask->id, static_cast<uint32_t>(workTask->type), workTask->typeName,
        stm->GetIsSupportASyncRecycle(), stm->IsNeedPostProc(workTask), stm->GetDavinciTaskHead(),
        stm->GetDavinciTaskTail(), stm->GetTaskHead(), stm->GetTaskTail(),
        stm->GetBindFlag(), posHead, newPosTail, posTail, stm->GetDelayRecycleTaskSize());

    error = SendCommand(workTask, cmdLocal, command, sendSqeNum);
    return error;
}

TIMESTAMP_EXTERN(RecycleProcessDavinciList);
void Engine::RecycleThreadDo()
{
    if (!(device_->GetIsChipSupportRecycleThread())) {
        return;
    }
    Stream *recycleStream = device_->GetNextRecycleStream();
    while (recycleStream != nullptr) {
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
            recycleStream->ProcArgRecycleList();
        } else {
            if (recycleStream->isHasPcieBar_) {
                recycleStream->ProcArgRecycleList();
            } else {
                TIMESTAMP_BEGIN(RecycleProcessDavinciList);
                (void)ProcessTaskDavinciList(recycleStream, recycleStream->GetRecycleEndTaskId(), device_->Id_());
                TIMESTAMP_END(RecycleProcessDavinciList);
            }
        }
        recycleStream->SetThreadProcFlag(false);
        recycleStream = device_->GetNextRecycleStream();
    }
    if (device_->GetIsChipSupportEventThread()) {
        while (device_->PopNextPoolFreeEventId()) {}
    }
}

rtError_t Engine::TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId)
{
    UNUSED(limited);
    UNUSED(taskId);
    return RT_ERROR_NONE;
}
rtError_t Engine::RecycleSeparatedStmByFinishedId(Stream * const stm, const uint16_t endTaskId, bool isCqeProcess)
{
    UNUSED(stm);
    UNUSED(endTaskId);
    UNUSED(isCqeProcess);
    return RT_ERROR_NONE;
}

rtError_t Engine::TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId)
{
    UNUSED(streamId);
    UNUSED(limited);
    UNUSED(taskId);
    return RT_ERROR_NONE;
}

rtError_t Engine::SyncTask(Stream * const stm, const uint32_t taskId, const bool isStreamSync,
    int32_t timeout, bool isForce)
{
    UNUSED(stm);
    UNUSED(taskId);
    UNUSED(isStreamSync);
    UNUSED(timeout);
    UNUSED(isForce);
    return RT_ERROR_NONE;
}

rtError_t Engine::TryRecycleTask(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_NONE;
}

rtError_t Engine::InitStreamRes(const uint32_t streamId)
{
    UNUSED(streamId);
    return RT_ERROR_NONE;
}

rtError_t Engine::QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId)
{
    UNUSED(streamId);
    UNUSED(taskId);
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
