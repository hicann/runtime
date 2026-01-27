/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stars_engine.hpp"
#include "securec.h"
#include "context.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "profiler.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "errcode_manage.hpp"
#include "npu_driver.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "task_res.hpp"
#include "atrace_log.hpp"
#include "task_submit.hpp"
#include "task.hpp"
#include "device/device_error_proc.hpp"
#include "task_manager.h"
#include "stub_task.hpp"
#include "global_state_manager.hpp"
#include "raw_device.hpp"

namespace {
constexpr uint16_t TASK_RECLAIM_MAX_NUM = 64U;     // Max reclaim num per query.
constexpr uint16_t TASK_QUERY_INTERVAL_NUM = 64U;     // Shared memory query interval.
constexpr uint16_t TASK_WAIT_EXECUTE_MAX_NUM = 512U;     // Max number of tasks waiting to be executed on device.
}

namespace cce {
namespace runtime {
StarsEngine::StarsEngine(Device * const dev,
                         Thread * const monitor,
                         Thread * const recycle)
    : Engine(dev),
      monitorThread_(monitor),
      recycleThread_(recycle)
{
    RT_LOG(RT_LOG_EVENT, "Constructor.");
}

StarsEngine::~StarsEngine() noexcept
{
    monitorThread_ = nullptr;
    recycleThread_ = nullptr;
    RT_LOG(RT_LOG_EVENT, "Destructor.");
}

rtError_t StarsEngine::Init()
{
    Device * const dev = GetDevice();
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    uint16_t cqeWaitTimeout = dev->GetDevProperties().cqeWaitTimeout;
    SetWaitTimeout(cqeWaitTimeout);
    return RT_ERROR_NONE;
}

void StarsEngine::Run(const void * const param)
{
    switch (static_cast<ThreadType>(RtPtrToValue(param))) {
        case THREAD_RECYCLE: {
            RecycleThreadRun();
            break;
        }
        case THREAD_MONITOR: {
            MonitoringRun();
            break;
        }
        case THREAD_PRINTF: {
            PrintfRun();
            break;
        }
        default: {
            RT_LOG(RT_LOG_ERROR, "Unknown thread type.");
            break;
        }
    }
}

rtError_t StarsEngine::CreateMonitorThread()
{
    // Transfer the subthread context to the main thread too report an exception.
#ifndef CFG_DEV_PLATFORM_PC
    errorContext_ = ErrorManager::GetInstance().GetErrorManagerContext();
#endif
    void * const monitor = RtValueToPtr<void *>(THREAD_MONITOR);
    const char_t * const threadName = (GetDevice()->DevGetTsId() == static_cast<uint32_t>(RT_TSC_ID)) ?
                                       "MONITOR_0" : "MONITOR_1";
    monitorThread_ = OsalFactory::CreateThread(threadName, this, monitor);
    if (monitorThread_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "create monitor thread failed");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    monitorThreadRunFlag_ = true;
    const int32_t error = monitorThread_->Start();
    if (error != EN_OK) {
        monitorThreadRunFlag_ = false;
        DELETE_O(monitorThread_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::Start()
{
    // check if engine is started.
    COND_RETURN_ERROR_MSG_INNER((monitorThread_ != nullptr), RT_ERROR_ENGINE_THREAD,
                                "StarsEngine had been started.");

    COND_RETURN_ERROR_MSG_INNER(CreateMonitorThread() != RT_ERROR_NONE, RT_ERROR_MEMORY_ALLOCATION,
                                "stars create monitor thread failed.");
#ifndef CFG_DEV_PLATFORM_PC
    COND_RETURN_ERROR_MSG_INNER(Runtime::Instance()->CreateReportRasThread() != RT_ERROR_NONE, RT_ERROR_MEMORY_ALLOCATION,
                                "stars create report ras thread failed.");
#endif

    Device * const dev = GetDevice();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_RECYCLE_THREAD)) {
        if ((GetDevice()->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE)) {
            GetDevice()->SetIsChipSupportRecycleThread(true);
            GetDevice()->SetIsChipSupportEventThread(true);
        }
        if (CreateRecycleThread() != RT_ERROR_NONE) {
            monitorThreadRunFlag_ = false;
            monitorThread_->Join();
            DELETE_O(monitorThread_);
            RT_LOG(RT_LOG_ERROR, "stars create sem failed");
            return RT_ERROR_MEMORY_ALLOCATION;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t StarsEngine::Stop()
{
    DestroyRecycleThread();

    if (monitorThread_ != nullptr) {
        monitorThreadRunFlag_ = false;
        monitorThread_->Join();
        RT_LOG(RT_LOG_INFO, "StarsEngine joined monitor thread OK.");
        DELETE_O(monitorThread_);
    }
    DestroyPrintfThread();
    return RT_ERROR_NONE;
}

rtError_t StarsEngine::CreateRecycleThread(void)
{
    void * const recycle = RtValueToPtr<void *>(THREAD_RECYCLE);
    recycleThread_ = OsalFactory::CreateThread("RT_RECYCLE", this, recycle);
    if (recycleThread_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Create recycle thread failed");
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const rtError_t error = mmSemInit(&recycleThreadSem_, 0U);
    if (error != RT_ERROR_NONE) {
        DELETE_O(recycleThread_);
        RT_LOG(RT_LOG_ERROR, "Create sem failed, retCode=%d", error);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    recycleThreadRunFlag_ = true;

    const int32_t err = recycleThread_->Start();
    if (err != EN_OK) {
        recycleThreadRunFlag_ = false;
        DELETE_O(recycleThread_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    return RT_ERROR_NONE;
}

void StarsEngine::DestroyRecycleThread(void)
{
    if (recycleThread_ != nullptr) {
        recycleThreadRunFlag_ = false;
        WakeUpRecycleThread();
        recycleThread_->Join();
        RT_LOG(RT_LOG_INFO, "Stars engine joined recycle thread OK.");
        DELETE_O(recycleThread_);
        (void)mmSemDestroy(&recycleThreadSem_);
    }

    return;
}

void StarsEngine::RecycleThreadRun(void)
{
    RT_LOG(RT_LOG_INFO, "RecycleThreadRun thread start.");
    while (recycleThreadRunFlag_) {
        (void)mmSemWait(&recycleThreadSem_);
        device_->SetIsDoingRecycling(true);
        if (device_->IsDavidPlatform()) {
            RecycleThreadDoForStarsV2(device_);
        } else {
            RecycleThreadDo();
        }
        device_->SetIsDoingRecycling(false);
    }
    RT_LOG(RT_LOG_INFO, "RecycleThreadRun thread leave.");
    return;
}

void StarsEngine::WakeUpRecycleThread(void)
{
    int32_t val = 0;
    (void)sem_getvalue(&recycleThreadSem_, &val);
    if (val < 2) {
        (void)mmSemPost(&recycleThreadSem_);
    }
}

bool StarsEngine::CheckMonitorThreadAlive()
{
    if (monitorThread_ != nullptr) {
        return monitorThread_->IsAlive();
    }
    return false;
}

void StarsEngine::StarsCqeReceive(const rtLogicCqReport_t &logicCq, TaskInfo * const runTask) const
{
    runTask->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage++;
    SetStarsResult(runTask, logicCq);
    ShowTaskResult(runTask, GetDevice()->Id_());

    if (runTask->isCqeNeedConcern != 0U) {
        runTask->isCqeNeedConcern = false;
        runTask->stream->SetNeedRecvCqeFlag(false);
    }

    const tsTaskType_t taskType = runTask->type;
    // process error
    if ((taskType != TS_TASK_TYPE_EVENT_RECORD) && (taskType != TS_TASK_TYPE_GET_STARS_VERSION) &&
        ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0)) {
        if (Runtime::Instance()->excptCallBack_ != nullptr) {
            Runtime::Instance()->excptCallBack_(RT_EXCEPTION_TASK_FAILURE);
        } else {
            RT_LOG(RT_LOG_INFO, "excptCallBack_ is null.");
        }
    }

    if (runTask->errorCode != 0U && runTask->type == TS_TASK_TYPE_FFTS_PLUS) {
        FftsPlusTaskInfo *fftsPlusTask = static_cast<FftsPlusTaskInfo *>(&runTask->u.fftsPlusTask);
        if ((fftsPlusTask->kernelFlag & RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG) != 0U) {
            runTask->stream->SetErrCode(runTask->errorCode);
        }
    }
}

rtError_t StarsEngine::AddTaskToStream(TaskInfo * const workTask, const uint32_t sendSqeNum)
{
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    uint64_t tryCnt = 0ULL;

    Stream * const stm = workTask->stream;
    rtError_t error = stm->StarsAddTaskToStream(workTask, sendSqeNum);
    COND_RETURN_WITH_NOLOG(stm->GetBindFlag(), error);

    while (unlikely(error != RT_ERROR_NONE)) {
        stm->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
        if (stm->GetBeingAbortedFlag()) {
            RT_LOG(RT_LOG_ERROR,
                "stream status is stream abort, device_id=%u, stream_id=%d.",
                stm->Device_()->Id_(),
                stm->Id_());
            return RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL;
        }
        error = stm->CheckContextTaskSend(workTask);
        COND_RETURN_ERROR((error == RT_ERROR_DEVICE_TASK_ABORT),
                          RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL,
                          "device task abort, device_id=%u, stream_id=%d",
                          stm->Device_()->Id_(),
                          stm->Id_());
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<int32_t>(error));
        SendingWaitProc(stm);
        error = stm->StarsAddTaskToStream(workTask, sendSqeNum);
        if ((!stm->GetBindFlag()) && (error == RT_ERROR_STREAM_FULL) && (tryCnt == 0U)) {
            RT_LOG(RT_LOG_WARNING, "single-operator flow stream task public buff full, "
                "device_id=%u, stream_id=%d, task_id=%u, sendSqeNum=%u",
                stm->Device_()->Id_(), stm->Id_(), workTask->id, sendSqeNum);
            tryCnt++;
        }
    }

    return RT_ERROR_NONE;
}

// In order not to affect the sending, at most 64 tasks can be reclaim once time
void StarsEngine::GetRecycleHead(const uint16_t taskHead, const uint16_t sqHead,
        uint32_t const rtsqDepth, uint16_t &recycleHead) const
{
    if (sqHead >= taskHead) {
        if ((TASK_ID_SUB(sqHead, taskHead)) > TASK_RECLAIM_MAX_NUM) {
            recycleHead = TASK_ID_ADD(taskHead, static_cast<uint16_t>(TASK_RECLAIM_MAX_NUM));
        }
    } else {
        // flip occurs
        const uint16_t needRecycleTask = (static_cast<uint16_t>(rtsqDepth) - taskHead) + sqHead;
        if (needRecycleTask > TASK_RECLAIM_MAX_NUM) {
            recycleHead = static_cast<uint16_t>(static_cast<uint32_t>(taskHead + TASK_RECLAIM_MAX_NUM) % rtsqDepth);
        }
    }
}

// recycle task and sleep when device execute slowly
void StarsEngine::SendingWaitProc(Stream * const stm)
{
    if (stm->IsBindDvppGrp()) {
        // dvpp task recycled by rtDvppWaitGroupReport
        if (stm->GetLimitFlag()) {
            stm->SetLimitFlag(false);
            (void)mmSleep(1U);
        }
        return;
    }
    if (stm->IsSeparateSendAndRecycle()) {
        if (!stm->Device_()->GetIsDoingRecycling()) {
            stm->Device_()->WakeUpRecycleThread();
        }
        return;
    }

    uint32_t taskId = 0U;
    uint16_t sqHead = 0U;

    stm->StreamSyncLock();
    stm->SetRecycleFlag(true);

    // get device rtsq head by drv interface
    Device *dev = GetDevice();
    const uint32_t devId = dev->Id_();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t tsId = dev->DevGetTsId();
    rtError_t error = dev->Driver_()->GetSqHead(devId, tsId, sqId, sqHead);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Query sq head failed, retCode=%#x", static_cast<uint32_t>(error));
    }
    error = SendingProcReport(stm, false, sqHead, taskId);
    RT_LOG(RT_LOG_DEBUG, "Process finish task resource, sqHead=%hu, taskId=%u, error=%#x.", sqHead, taskId, error);
    if (IsExeTaskSame(stm, taskId)) {
        AtraceParams param = { stm->Device_()->Id_(), static_cast<uint32_t>(stm->Id_()), 0, GetCurrentTid(),
            GetDevice()->GetAtraceHandle(), {}};
        param.u.taskRecycleParams = { stm->GetLastTaskId(), taskId, TYPE_SENDINGWAIT };
        AtraceSubmitLog(TYPE_TASK_RECYCLE, param);
    }
    stm->SetRecycleFlag(false);
    stm->StreamSyncUnLock();

    if (stm->GetLimitFlag()) {
        stm->SetLimitFlag(false);
    }
    return;
}

rtError_t StarsEngine::AdjustRecycleTaskID(Stream * const stm, uint32_t &endTaskId, uint16_t pos) const
{
    const uint32_t rtsqDepth = stm->GetSqDepth();
    uint32_t nextTaskId = UINT16_MAX;
    const uint16_t nextPos = ((pos + 1) % rtsqDepth);

    stm->GetTaskIdByPos(nextPos, nextTaskId);

    // last task or task finish)
    const bool taskIsFinished = ((stm->GetTaskPosTail() == nextPos) || (nextTaskId != endTaskId));
    COND_RETURN_INFO(taskIsFinished == false,
        RT_ERROR_INVALID_VALUE, "stream_id=%d, endTaskId=%u, pos=%u nextTaskId=%u",
        stm->Id_(), endTaskId, pos, nextTaskId);

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::FinishedTaskReclaim(Stream * const stm, const bool limited, uint16_t taskHead,
    uint16_t sqHead, uint32_t &taskId)
{
    uint16_t recycleHead = sqHead;
    if (limited) {
        GetRecycleHead(taskHead, sqHead, stm->GetSqDepth(), recycleHead);
    }

    // get taskId by postion, recycleHead is executing Currently, pos has been executed.
    uint16_t pos = 0;
    Device * const dev = GetDevice();
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    uint16_t rtsqPosition = dev->GetDevProperties().getRtsqPosition;
    if (rtsqPosition != UINT16_MAX) {
        pos = (recycleHead == 0U) ? rtsqPosition : (recycleHead - 1U);
    } else {
        if (recycleHead == 0U) {
            pos = static_cast<uint16_t>(stm->GetSqDepth() - 1U);
        } else {
            pos = recycleHead - 1U;
        }
    }

    uint32_t endTaskId = UINT16_MAX;
    const rtError_t error = stm->GetTaskIdByPos(pos, endTaskId);
    if (taskHead == recycleHead) {     // no new task.
        taskId = stm->GetRecycleEndTaskId();
        return RT_ERROR_NONE;
    }

    // Only record first error log when same pos
    bool errorLogFlag = true;
    if (error != RT_ERROR_NONE) {
        errorLogFlag = (pos == stm->GetLastRecyclePos()) ? false : true;
        stm->SetLastRecyclePos(pos);
    }

    // It is normal that the first task of each stream fails to get the task id by postion.
    if ((error != RT_ERROR_NONE) && (recycleHead == 0U)) {
        RT_LOG(RT_LOG_DEBUG, "GetTaskIdByPos fail, sqHead=%hu", recycleHead);
        return RT_ERROR_NONE;
    }

    if (error != RT_ERROR_NONE) {
        if (errorLogFlag) {
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get task id by postion failed, pos=%#x.", pos);
        } else {
            return error;
        }
    }

    COND_PROC((AdjustRecycleTaskID(stm, endTaskId, pos) != RT_ERROR_NONE), return RT_ERROR_NONE;);

    RecycleTask(static_cast<uint32_t>(stm->Id_()), endTaskId);

    /* update recycle taskId */
    if (stm->GetRecycleEndTaskId() != MAX_UINT16_NUM) {
        taskId = stm->GetRecycleEndTaskId();
    }

    RT_LOG(RT_LOG_INFO, "recycle task, stream_id=%d, limited=%d, taskHead=%hu, sqHead=%hu, endTaskId=%u, "
        "recycleTaskId=%u.", stm->Id_(), limited, taskHead, sqHead, endTaskId, taskId);

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::TaskReclaimByStm(Stream * const stm, const bool limited, uint32_t &taskId)
{
    if (stm->GetTsSqAllocType() != SQ_ALLOC_TYPE_RT_DEFAULT) {
        RT_LOG(RT_LOG_DEBUG, "ts sq no need to do task reclaim, streamId=%d", stm->Id_());
        return RT_ERROR_NONE;
    }

    Device * const dev = GetDevice();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();

    uint16_t sqHead = 0U;
    rtError_t error;
    if (unlikely(stm->GetFailureMode() == ABORT_ON_FAILURE) || stm->isForceRecycle_) {
        error = SendingProcReport(stm, false, static_cast<uint16_t>(stm->GetTaskPosTail()), taskId);
        RT_LOG(RT_LOG_INFO, "stream is in failure abort or isForceRecycle and need to reclaim all, streamId=%d,"
                             " posHead=%u, posTail=%u, taskId=%u, failuremode=%" PRIu64 ", isForceRecycle=%u",
                             stm->Id_(), stm->GetTaskPosHead(), stm->GetTaskPosTail(), taskId, stm->GetFailureMode(),
                             static_cast<uint32_t>(stm->isForceRecycle_));
        return error;
    }

    // get device rtsq head by drv interface
    error = dev->Driver_()->GetSqHead(devId, tsId, sqId, sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    error = SendingProcReport(stm, limited, sqHead, taskId);
    return error;
}

rtError_t StarsEngine::TaskReclaimByStreamId(const uint32_t streamId, const bool limited, uint32_t &taskId)
{
    Stream *stm = nullptr;
    Device *dev = GetDevice();

    const rtError_t error = dev->GetStreamSqCqManage()->GetStreamById(streamId, &stm);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
        "Query stream failed, streamId=%u, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    if (stm->IsSeparateSendAndRecycle()) {
        if (!stm->Device_()->GetIsDoingRecycling()) {
            WakeUpRecycleThread();
        }
        return RT_ERROR_NONE;
    }
    return TaskReclaimByStm(stm, limited, taskId);
}

rtError_t StarsEngine::TaskReclaimForSeparatedStm(Stream *const stm)
{
    rtError_t error = RT_ERROR_NONE;
    error = TaskReclaimByCqeForSeparatedStm(stm);
    COND_PROC((error != RT_ERROR_NONE), return error;);
    error = TaskReclaimBySqHeadForSeparatedStm(stm);
    COND_PROC((error != RT_ERROR_NONE), return error;);
    return error;
}

rtError_t StarsEngine::ProcessHeadTaskByStreamId(const uint16_t streamId)
{
    Stream *stm = nullptr;
    uint32_t taskId = 0U;
    rtError_t error = GetDevice()->GetStreamSqCqManage()->GetStreamById(streamId, &stm);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
        "Query stream failed, streamId=%hu, retCode=%#x.", streamId, static_cast<uint32_t>(error));

    const uint32_t taskHead = stm->GetTaskPosHead();
    error = stm->GetTaskIdByPos(static_cast<uint16_t>(taskHead), taskId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "Get task id by postion failed, pos=%#x.", taskHead);
        return error;
    }
    taskId = taskId & 0xFFFFU;
    TaskInfo * const reportTask =
        GetDevice()->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), static_cast<uint16_t>(taskId));
    if (unlikely(reportTask == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "task or task stream is null, stream_id=%hu, task_id=%u,", streamId, taskId);
        return RT_ERROR_TASK_NULL;
    }

    if (likely(CheckPackageState(reportTask))) {
        (void)ProcessTask(reportTask, GetDevice()->Id_());
    }

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId)
{
    if (streamId != UINT32_MAX) {
        return TaskReclaimByStreamId(streamId, limited, taskId);
    }

    std::vector<uint32_t> allStreams;
    const Device * const dev = GetDevice();
    dev->GetStreamSqCqManage()->GetAllStreamId(allStreams);
    RT_LOG(RT_LOG_INFO, "Travel all streams, num=%zu.", allStreams.size());
    for (const uint32_t streamLoop : allStreams) {
        const rtError_t error = TaskReclaimByStreamId(streamLoop, limited, taskId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId)
{
    std::vector<uint32_t> allStreams;
    const Device * const dev = GetDevice();
    dev->GetStreamSqCqManage()->GetAllStreamId(allStreams);
    RT_LOG(RT_LOG_INFO, "Travel all streams, num=%zu.", allStreams.size());
    rtError_t error = RT_ERROR_NONE;
    for (const auto streamLoop : allStreams) {
        std::shared_ptr<Stream> stm = nullptr;
        error = dev->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(streamLoop), stm);
        COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
            "Query stream failed, streamId=%u, retCode=%#x.", streamLoop, static_cast<uint32_t>(error));
        stm->StreamSyncLock();
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
            error = TaskReclaimByStream(stm.get(), limited);
            taskId = static_cast<uint32_t>(stm.get()->GetRecycleEndTaskId());
        } else {
            error = TaskReclaim(streamLoop, limited, taskId);
        }

        stm->StreamSyncUnLock();
        stm.reset();
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    return RT_ERROR_NONE;
}

// Monitor task reclaim & query stream failure abort to set error device status
rtError_t StarsEngine::MonitorTaskReclaim(uint16_t errorStreamId)
{
    uint32_t taskId = MAX_UINT16_NUM;
    Device * const dev = GetDevice();
    if (dev->GetMonitorExitFlag()) {
        return RT_ERROR_TASK_MONITOR;
    }
    std::shared_ptr<Stream> stm = nullptr;
    const rtError_t error = dev->GetStreamSqCqManage()->GetStreamSharedPtrById(errorStreamId, stm);
    if ((error != RT_ERROR_NONE) || (stm == nullptr)) {
        return RT_ERROR_NONE;
    }
    if (stm->Context_() != nullptr) {
        InnerThreadLocalContainer::SetCurCtx(stm->Context_());
    }
    if (stm->GetPendingNum() == 0U || stm->IsBindDvppGrp()) {
        // dvpp task recycled by rtDvppWaitGroupReport
        stm.reset();
        return RT_ERROR_NONE;
    }
    if (stm->StreamSyncTryLock(30U)) { // 30 wait for lock 300s
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
            if (stm->IsSeparateSendAndRecycle()) {
                stm->Device_()->WakeUpRecycleThread();
            } else {
                (void)TaskReclaimByStream(stm.get(), false);
            }
        } else {
            (void)TaskReclaimByStreamId(static_cast<uint32_t>(errorStreamId), false, taskId);
        }
        stm->StreamSyncUnLock();
        stm.reset();
    }
    return RT_ERROR_NONE;
}

rtError_t StarsEngine::ProcLogicCqUntilEmpty(const Stream * const stm, uint32_t &taskId)
{
    Device * const dev = GetDevice();
    Driver * const devDrv = dev->Driver_();
    constexpr bool isFastCq = false;
    constexpr uint32_t allocCnt = RT_MILAN_MAX_QUERY_CQE_NUM;     // want get cqe num
    const uint32_t logicCqId = stm->GetLogicalCqId();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    uint32_t times = 0U;

    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = dev->Id_();
    waitInfo.tsId = dev->DevGetTsId();
    waitInfo.cqId = logicCqId;
    waitInfo.isFastCq = isFastCq;
    waitInfo.timeout = RT_REPORT_WITHOUT_TIMEOUT;  // get logic report without timeout
    waitInfo.streamId = streamId;  // for v2
    waitInfo.taskId = MAX_UINT16_NUM;  // get any logic report without specifying the task

    while (true) {
        uint32_t cnt = 0U;
        rtLogicCqReport_t reportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};

        const rtError_t error = devDrv->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *>(reportInfo),
            allocCnt, cnt);
        const rtError_t ret = ReportHeartBreakProcV2();
        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, ret == RT_ERROR_LOST_HEARTBEAT, RT_ERROR_LOST_HEARTBEAT,
            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(dev->Id_())});,
            "Device[%u] lost heartbeat.", dev->Id_());
        if (unlikely(((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) || (cnt == 0U))) {
            RT_LOG(RT_LOG_INFO, "Task Wait: stream_id=%u, logicCqId=%u, retCode=%#x", streamId, logicCqId,
                static_cast<uint32_t>(error));

            if (times == 0U) {
                return RT_ERROR_STREAM_EMPTY;
            }
            break;
        }

        times++;

        for (uint32_t idx = 0U; idx < cnt; ++idx) {
            rtLogicCqReport_t &report = reportInfo[idx];
            taskId = report.taskId;
            const uint8_t sqeType = report.sqeType;
            AtraceParams param = { GetDevice()->Id_(), static_cast<uint32_t>(report.streamId), report.taskId,
                GetCurrentTid(), GetDevice()->GetAtraceHandle(), {}};
            param.u.cqReportParams = { logicCqId, report.errorCode, report.sqeType };
            AtraceSubmitLog(TYPE_CQ_REPORT, param);
            RT_LOG(RT_LOG_INFO,
                "Notify: cnt=%u, idx=%u, stream_id=%hu, task_id=%u, sqeType=%u, retCode=%#x, errType=%#x.",
                cnt, idx, report.streamId, taskId, static_cast<uint32_t>(sqeType), report.errorCode, report.errorType);
            TaskInfo * const reportTask =
                GetDevice()->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), static_cast<uint16_t>(taskId));
            if (reportTask == nullptr) {
                RT_LOG(RT_LOG_WARNING, "reportTask == nullptr");
                ProcLogicCqReport(report, false, nullptr);
                continue;
            }
            if ((reportTask->type == TS_TASK_TYPE_MULTIPLE_TASK) && (GetSendSqeNum(reportTask) > 1U)) {
                if (!ProcMultipleTaskLogicCqReport(reportTask, report, false)) {
                    taskId = MAX_UINT16_NUM;
                }
            } else {
                ProcLogicCqReport(report, false, reportTask);
            }
        }
    }

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::SendingProcReport(Stream * const stm, const bool limited, uint16_t sqHead, uint32_t &taskId)
{
    if (!stm->GetNeedRecvCqeFlag()) {
        if (!stm->IsExistCqe()) {
            const uint32_t taskHead = stm->GetTaskPosHead();   // head of not release task
            return FinishedTaskReclaim(stm, limited, static_cast<uint16_t>(taskHead), sqHead, taskId);
        }
    }

    if (ProcLogicCqUntilEmpty(stm, taskId) != RT_ERROR_NONE) {
        // process finish task by sqHead when can not get logic CQ report
        const uint32_t taskHead = stm->GetTaskPosHead();   // head of not release task
        return FinishedTaskReclaim(stm, limited, static_cast<uint16_t>(taskHead), sqHead, taskId);
    }

    return RT_ERROR_NONE;
}

// Do task recycling every 64 tasks send
rtError_t StarsEngine::TryRecycleTask(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    const uint32_t taskTail = stm->GetTaskPosTail();   // tail sqe postion of not release task
    stm->SetLimitFlag(false);
    if (stm->IsSeparateSendAndRecycle()) {
        constexpr uint16_t ASNC_THREAD_TASK_RECLAIM_MAX_NUM = 64U;    // Task reclaim num in async reclaim thread.
        if ((stm->GetPendingNum() != 0U) && (taskTail % ASNC_THREAD_TASK_RECLAIM_MAX_NUM == 0U)) {
            WakeUpRecycleThread();
        }
        return RT_ERROR_NONE;
    }

    if (stm->GetBindFlag() || (stm->GetPendingNum() == 0U) || ((taskTail % TASK_QUERY_INTERVAL_NUM) != 0U)) {
        return RT_ERROR_NONE;
    }

    Device *dev = GetDevice();
    const uint32_t devId = dev->Id_();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t tsId = dev->DevGetTsId();
    uint32_t sqeNum = 0U;
    uint16_t sqHead = 0U;

    stm->StreamSyncLock();
    // 当进入这个流程之后，不应该让abort线程再进入到UpdateStreamSqCq流程了，否则获取sqHead会有问题
    const rtError_t status = stm->abortStatus_;
    if (status == RT_ERROR_STREAM_ABORT || status == RT_ERROR_DEVICE_TASK_ABORT) {
        stm->StreamSyncUnLock();
        RT_LOG(RT_LOG_ERROR,
            "stream is in abort status, try recycle task fail, device_id=%u, stream_id=%d, pendingNum=%hu, status=%u.",
            devId,
            stm->Id_(),
            stm->GetPendingNum(),
            status);
        return status;
    }
    // get device rtsq head by drv interface
    error = dev->Driver_()->GetSqHead(devId, tsId, sqId, sqHead);
    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, stm->StreamSyncUnLock();,
        "Query sq head failed, retCode=%#x.", static_cast<uint32_t>(error));

    const uint32_t rtsqDepth = stm->GetSqDepth();
    // pendingMax is rtsqDepth * 3U / 4U; recycle task if rtsq space used more than 3/4
    sqeNum = (((taskTail + rtsqDepth) - sqHead) % rtsqDepth);

    // device execute slowly
    if ((!stm->IsBindDvppGrp()) && ((sqeNum > TASK_WAIT_EXECUTE_MAX_NUM) ||
       (stm->GetPendingNum() >  Runtime::starsPendingMax_))) {
        uint32_t reclaimTaskId = 0U;
        (void) SendingProcReport(stm, true, sqHead, reclaimTaskId);
        if (IsExeTaskSame(stm, reclaimTaskId)) {
            AtraceParams param = { stm->Device_()->Id_(), static_cast<uint32_t>(stm->Id_()), 0, GetCurrentTid(),
                GetDevice()->GetAtraceHandle(), {}};
            param.u.taskRecycleParams = { stm->GetLastTaskId(), reclaimTaskId, TYPE_TRYRECYCLETASK };
            AtraceSubmitLog(TYPE_TASK_RECYCLE, param);
        }
        RT_LOG(RT_LOG_DEBUG, "streamId=%d, taskTail=%u, sqHead=%hu, taskId=%u, sqeNum=%u, pendingNum=%u",
            stm->Id_(), taskTail, sqHead, reclaimTaskId, sqeNum, stm->GetPendingNum());

        // more than 2K task need to execute, set flow control flag
        const uint32_t flowControlNum = rtsqDepth * 3U / 4U;
        if (sqeNum > flowControlNum) {
            stm->SetLimitFlag(true);
        }
    }
    stm->StreamSyncUnLock();
    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(SqTaskSend);
TIMESTAMP_EXTERN(TryRecycleTask);
TIMESTAMP_EXTERN(TaskSendLimited);
TIMESTAMP_EXTERN(ToCommand);
rtError_t StarsEngine::SendTask(TaskInfo * const workTask, uint16_t &taskId, uint32_t * const flipTaskId)
{
    Stream * const stm = workTask->stream;
    TIMESTAMP_BEGIN(TryRecycleTask);
    rtError_t error = TryRecycleTask(stm);
    if (error == RT_ERROR_STREAM_ABORT || error == RT_ERROR_DEVICE_TASK_ABORT) {
        error = (error == RT_ERROR_STREAM_ABORT) ? RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL :
            RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL;
    }
    TIMESTAMP_END(TryRecycleTask);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Try recycle task failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    constexpr uint16_t perDetectTimes = 1000U;
    uint32_t tryCount = 0U;
    while (stm->GetLimitFlag() && (!stm->GetRecycleFlag())) {
        TIMESTAMP_BEGIN(TaskSendLimited);
        SendingWaitProc(stm); // Send limited, need release complete task.
        TIMESTAMP_END(TaskSendLimited);
        if ((tryCount % perDetectTimes) == 0) {
            error = stm->CheckContextTaskSend(workTask);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x", static_cast<uint32_t>(error));
        }
        tryCount++;
    }
    tryCount = 0U;

    const uint32_t sendSqeNum = GetSendSqeNum(workTask);
    if (sendSqeNum > SQE_NUM_PER_STARS_TASK_MAX) {
        RT_LOG(RT_LOG_ERROR, "sendSqeNum %u more than max num %d. task_id=%hu, task_type=%d(%s).",
            sendSqeNum, SQE_NUM_PER_STARS_TASK_MAX, workTask->id, static_cast<int32_t>(workTask->type),
            workTask->typeName);
        return error;
    }
    Device *dev = GetDevice();
    Driver * const devDrv = dev->Driver_();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();
    COND_RETURN_ERROR_MSG_INNER(devDrv == nullptr, RT_ERROR_DRV_ERR, "Can't find device driver.");

    stm->StreamLock();
    const rtError_t status = stm->abortStatus_;
    if ((status == RT_ERROR_STREAM_ABORT) || (status == RT_ERROR_DEVICE_TASK_ABORT)) {
        stm->StreamUnLock();
        RT_LOG(RT_LOG_ERROR,
            "stream is in abort status, send task fail, device_id=%u, stream_id=%d, task_id=%hu, task_type=%d(%s), "
            "status=%u.",
            devId,
            stm->Id_(),
            workTask->id,
            static_cast<int32_t>(workTask->type),
            workTask->typeName,
            status);
        return (status == RT_ERROR_STREAM_ABORT) ? RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL
                                                 : RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL;
    }

    dev->GetTaskFactory()->SetSerialId(stm, workTask);
    taskId = workTask->id;
    COND_PROC(flipTaskId != nullptr,
        *flipTaskId = GetFlipTaskId(workTask->id, workTask->flipNum););
    if ((stm->Model_() != nullptr) && (workTask->type != TS_TASK_TYPE_MODEL_MAINTAINCE)) {
        stm->Model_()->SetKernelTaskId(static_cast<uint32_t>(workTask->id), static_cast<int32_t>(stm->Id_()));
    }

    ReportProfData(workTask);

    TIMESTAMP_BEGIN(ToCommand);
    rtTsCommand_t  cmdLocal = {};
    cmdLocal.cmdType = RT_TASK_COMMAND_TYPE_STARS_SQE;
    ToConstructSqe(workTask, cmdLocal.cmdBuf.u.starsSqe);
    TIMESTAMP_END(ToCommand);

    // Update the host-side head and tail
    error = AddTaskToStream(workTask, sendSqeNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Add task failed stream_id=%d, task_id=%u.", stm->Id_(), workTask->id);
        stm->StreamUnLock();
        return error;
    }

    workTask->profEn = Runtime::Instance()->GetProfileEnableFlag();
    ProcessObserver(devId, workTask, &cmdLocal);

    error = ProcessTaskWait(workTask);
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "Process task wait failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d."
            " task_id=%hu, task_type=%d(%s), retCode=%d.",
            devId, tsId, sqId, cqId, stm->Id_(), workTask->id, static_cast<int32_t>(workTask->type),
            workTask->typeName, error);
        stm->StreamUnLock();
        return error;
    }
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;

    do {
        if (!stm->IsSoftwareSqEnable()) {
            TIMESTAMP_BEGIN(SqTaskSend);
            error = devDrv->SqTaskSend(sqId, cmdLocal.cmdBuf.u.starsSqe, devId, tsId, sendSqeNum);
            TIMESTAMP_END(SqTaskSend);
        } else {
            const auto ret = memcpy_s(RtPtrToPtr<void *>(stm->GetSqeBuffer() + sizeof(rtStarsSqe_t) * workTask->pos),
                                      sendSqeNum * sizeof(rtStarsSqe_t),
                                      RtPtrToPtr<void *, rtStarsSqe_t *>(cmdLocal.cmdBuf.u.starsSqe), 
                                      sendSqeNum * sizeof(rtStarsSqe_t));
            if (ret != EOK) {
                RT_LOG(RT_LOG_ERROR, "memcpy_s failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
                    " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%d",
                    devId, tsId, sqId, cqId, stm->Id_(), workTask->id,
                    static_cast<uint32_t>(workTask->type), workTask->typeName, ret);
                error = RT_ERROR_TASK_BASE;
                break;
            }
        }

        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_WARNING, "device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
                " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%#x",
                devId, tsId, sqId, cqId, stm->Id_(), workTask->id,
                static_cast<uint32_t>(workTask->type), workTask->typeName, static_cast<uint32_t>(error));

            tryCount++;
            if (stm->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, tryCount) != RT_ERROR_NONE) {
                stm->StreamUnLock();
                RT_LOG(RT_LOG_ERROR, "device status error in sq task send, device_id=%u, stream_id=%d",
                    devId, stm->Id_());
                return error;
            }
        } else {
            break;
        }
    } while (true);

    stm->StreamUnLock();

    const uint32_t posTail = stm->GetBindFlag() ? stm->GetDelayRecycleTaskSqeNum() : stm->GetTaskPosTail();
    const uint32_t posHead = stm->GetBindFlag() ? stm->GetTaskPersistentHeadValue() : stm->GetTaskPosHead();
    RT_LOG(RT_LOG_INFO, "Sq task send finished, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d, "
        "task_id=%hu, task_type=%u(%s), isSupportASyncRecycle=%d, isNeedPostProc=%d, davincHead=%u, "
        "davincTail=%u, taskHead=%u, taskTail=%u, sendSqeNum=%u, tryCount=%u, "
        "bindFlag=%d, head=%u, tail=%u, delay recycle task num=%zu.",
        devId, tsId, sqId, cqId, stm->Id_(), workTask->id, workTask->type, workTask->typeName,
        stm->GetIsSupportASyncRecycle(), stm->IsNeedPostProc(workTask), stm->GetDavinciTaskHead(),
        stm->GetDavinciTaskTail(), stm->GetTaskHead(), stm->GetTaskTail(), sendSqeNum, tryCount,
        stm->GetBindFlag(), posHead, posTail, stm->GetDelayRecycleTaskSize());

    return error;
}

rtError_t StarsEngine::RecycleTaskBySqHead(Stream * const stm, uint32_t &finishTaskId)
{
    uint16_t sqHead = 0U;

    Device *dev = GetDevice();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t tsId = dev->DevGetTsId();
    const rtError_t error = dev->Driver_()->GetSqHead(dev->Id_(), tsId, sqId, sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    const uint32_t taskHead = stm->GetTaskPosHead();   // head of not release task
    return FinishedTaskReclaim(stm, false, static_cast<uint16_t>(taskHead), sqHead, finishTaskId);
}

// check if vpc error and retry
// if vpc cqe and need retry return true
bool StarsEngine::ProcReportIsVpcErrorAndRetry(const rtLogicCqReport_t& report)
{
    if (report.sqeType != static_cast<uint8_t>(RT_STARS_SQE_TYPE_VPC)) {
        return false;
    }

    const uint8_t errorCode = GetStarsDefinedErrCode(report.errorType);
    if (errorCode == 0U) {
        return false;
    }

    // sqe error
    if ((errorCode & static_cast<uint8_t>(RT_STARS_CQE_ERR_TYPE_SQE_ERROR)) != static_cast<uint8_t>(0U)) {
        return false;
    }

    auto reportTask = GetDevice()->GetTaskFactory()->GetTask(
        static_cast<int32_t>(report.streamId), report.taskId);
    if (unlikely(reportTask == nullptr)) {
        return false;
    }

    if (reportTask->u.starsCommTask.errorTimes != 0U) {  // vpc retry error, return false
        RT_LOG(RT_LOG_ERROR, "Vpc task error, streamId=%hu, taskId=%hu", report.streamId, report.taskId);
        return false;
    }

    reportTask->u.starsCommTask.errorTimes++;
    RT_LOG(RT_LOG_WARNING, "Vpc task retry, streamId=%hu, taskId=%hu.", report.streamId, report.taskId);
    return true;
}

void StarsEngine::ProcCommonLogicCqReport(const rtLogicCqReport_t &report, const uint32_t taskId,
                                          const bool isStreamSync, bool &isFinished)
{
    if (ProcReportIsVpcErrorAndRetry(report)) {
        return;
    }

    ProcLogicCqReport(report, isStreamSync, nullptr);
    if (unlikely(TaskIdIsGEQ(report.taskId, taskId))) {
        isFinished = true;
    }
    return;
}

bool StarsEngine::CompleteProcMultipleTaskReport(TaskInfo * const workTask, const rtLogicCqReport_t &report) const
{
    TaskInfo * const reportTask = workTask;
    const uint8_t mulTaskCqeNum = GetMultipleTaskCqeNum(reportTask);
    DecMultipleTaskCqeNum(reportTask);

    const uint8_t ret = GetStarsDefinedErrCode(report.errorType);
    RT_LOG(RT_LOG_DEBUG, "Get stars defined error code ret=%hhu, sqeType=%hhu, streamId=%d, taskId=%u.",
           ret, report.sqeType, static_cast<int32_t>(report.streamId), report.taskId);
    SetMultipleTaskCqeErrorInfo(reportTask, report.sqeType, report.errorType, report.errorCode);

    const uint8_t targetType = static_cast<uint8_t>(RT_STARS_SQE_TYPE_AICPU);
    /* Terminate the subsequent CQ execution when the aicpu task fails. */
    if ((GetMultipleTaskCqeNum(reportTask) > 0U) && (report.sqeType == targetType) && (ret != 0)) {
        RT_LOG(RT_LOG_WARNING, "RT_STARS_SQE_TYPE_AICPU ERROR DecMultipleTaskCqeNum = %u",
            GetMultipleTaskCqeNum(reportTask));
        ClearMulTaskCqeNum(mulTaskCqeNum, workTask);
    }

    if (GetMultipleTaskCqeNum(reportTask) > 0U) {
        RT_LOG(RT_LOG_WARNING, "GetMultipleTaskCqeNum = %u, then incRecvPkg",
            static_cast<uint32_t>(GetMultipleTaskCqeNum(reportTask)));
        reportTask->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage++;
        return false;
    }

    return true;
}

bool StarsEngine::ProcMultipleTaskLogicCqReport(TaskInfo * const workTask, const rtLogicCqReport_t &report,
                                                const bool isStreamSync)
{
    TaskInfo* const reportTask = workTask;
    if (!CompleteProcMultipleTaskReport(workTask, report)) {
        return false;
    }

    rtLogicCqReport_t cqReport = report;
    GetMultipleTaskCqeErrorInfo(reportTask, cqReport.sqeType, cqReport.errorType, cqReport.errorCode);
    ProcLogicCqReport(cqReport, isStreamSync, workTask);
    return true;
}

void StarsEngine::ProcReport(const uint32_t taskId, const bool isStreamSync, const uint32_t cnt,
    rtLogicCqReport_t * const logicReport, bool &isFinished, uint32_t cqId)
{
    for (uint32_t idx = 0U; idx < cnt; ++idx) {
        rtLogicCqReport_t &report = logicReport[idx];
        const uint32_t taskIdCur = report.taskId;
        const uint8_t sqeType = report.sqeType;
        AtraceParams param = { GetDevice()->Id_(), static_cast<uint32_t>(report.streamId), report.taskId,
            GetCurrentTid(), GetDevice()->GetAtraceHandle(), {}};
        param.u.cqReportParams = { cqId, report.errorCode, report.sqeType };
        AtraceSubmitLog(TYPE_CQ_REPORT, param);
        TaskInfo * const reportTask = GetDevice()->GetTaskFactory()->GetTask(
            static_cast<int32_t>(report.streamId), report.taskId);
        RT_LOG(RT_LOG_INFO, "Get logic report: cnt=%u, idx=%u, stream_id=%hu, report task_id=%u, sync task_id=%u,"
            " sqeType=%u, sqeHead=%u, retCode=%#x, errType=%#x, taskType=%d.",
            cnt, idx, report.streamId, taskIdCur, taskId, static_cast<uint32_t>(sqeType),
            report.sqHead, report.errorCode, report.errorType, (reportTask == nullptr) ? 0xFF:reportTask->type);
        if (unlikely(reportTask == nullptr)) {
            RT_LOG(RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%hu, task_id=%hu",
                GetDevice()->Id_(), report.streamId, report.taskId);
            ProcCommonLogicCqReport(report, taskId, isStreamSync, isFinished);
            continue;
        }
        const tsTaskType_t taskType = reportTask->type;
        if ((taskType == TS_TASK_TYPE_MULTIPLE_TASK) && (GetSendSqeNum(reportTask) > 1U)) {
            if (ProcMultipleTaskLogicCqReport(reportTask, report, isStreamSync)) {
                if (unlikely(TaskIdIsGEQ(static_cast<uint32_t>(report.taskId), taskId))) {
                    isFinished = true;
                }
            }
        } else {
            ProcCommonLogicCqReport(report, taskId, isStreamSync, isFinished);
        }
    }
}

void StarsEngine::IsSyncTaskFinish(Stream * const stm, const uint32_t taskId) const
{
    Device * const dev = GetDevice();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();

    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_DIRECTLY(curDrv);
    uint16_t sqHead = 0U;
    rtError_t error = curDrv->GetSqHead(devId, tsId, sqId, sqHead);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Query sq head failed, retCode=%#x", static_cast<uint32_t>(error));
        return;
    }

    const uint16_t recycleHead = sqHead;
    uint32_t finishedTaskId = 0U;
    // get taskId by postion, recycleHead is executing Currently, pos has been executed.
    uint16_t pos = 0U;
    if (dev->GetDevProperties().getRtsqPosition != UINT16_MAX) {
        pos = (recycleHead == 0U) ? RT_MILAN_POSITION_NUM_MAX_MINIV3 : (recycleHead - 1U);
    } else {
        pos = (recycleHead == 0U) ? (stm->GetSqDepth() - 1U) : (recycleHead - 1U);
    }

    error = stm->GetTaskIdByPos(pos, finishedTaskId);
    finishedTaskId = finishedTaskId & 0xFFFFU;

    if (taskId == finishedTaskId) {
        RT_LOG(RT_LOG_INFO, "Sync task finished, sqHead=%hu finishedTaskId=%u", sqHead, finishedTaskId);
        StreamSyncTaskFinishReport();
    }
}

void StarsEngine::SyncTaskCheckResult(const rtError_t error, const Stream * const stm, const uint16_t taskId) const
{
    if (error != RT_ERROR_STREAM_SYNC_TIMEOUT) {
        return;
    }

    TaskInfo * const procTask = GetDevice()->GetTaskFactory()->GetTask(stm->Id_(), taskId);
    if (procTask != nullptr) {
        if (procTask->isCqeNeedConcern != 0U) {
            procTask->isCqeNeedConcern = false;
        }
    }

    return;
}

rtError_t StarsEngine::SyncTask(Stream * const stm, const uint32_t taskId, const bool isStreamSync, int32_t timeout,
    bool isForce)
{
    if (stm->IsSeparateSendAndRecycle()) {
        rtError_t error = RT_ERROR_NONE;
        error = stm->SynchronizeImpl(taskId, static_cast<uint16_t>(taskId), timeout);
        COND_PROC((error == RT_ERROR_STREAM_ABORT), return RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL);
        COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL);
        // ctx error, task already submit, return success.
        Context * const ctx = stm->Context_();
        const bool isReturnNoError = (error != RT_ERROR_NONE) && (ctx != nullptr) && (ctx->GetFailureError() != RT_ERROR_NONE);
        return isReturnNoError ? RT_ERROR_NONE : error;
    }
    // isStreamSync check need or not
    UNUSED(isStreamSync);
    UNUSED(isForce);
    bool isFinished = false;
    int32_t rptTimeoutCnt = 0;
    uint32_t finishTaskId = 0U;
    const uint32_t logicCqId = stm->GetLogicalCqId();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    const int32_t waitTimeout = Runtime::Instance()->IsSupportOpTimeoutMs() ?
        RT_REPORT_STARS_TIMEOUT_TIME_OP_TIMEOUT_MS : GetWaitTimeout(); // 算子ms超时时，超时时间1ms，故障快速上报

    Device *dev = GetDevice();
    Driver * const devDrv = dev->Driver_();
    LogicCqWaitInfo cqWaitInfo = {};
    cqWaitInfo.isFastCq = false;
    cqWaitInfo.devId = dev->Id_();
    cqWaitInfo.tsId = dev->DevGetTsId();
    cqWaitInfo.cqId = logicCqId;
    cqWaitInfo.streamId = streamId;  // for v2
    cqWaitInfo.taskId = taskId;  // for v2
    cqWaitInfo.timeout = waitTimeout;

    int32_t remainTime = timeout;
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = ((static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S) +
                               (static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS));

    RT_LOG(RT_LOG_INFO, "Task Wait: device_id=%u, stream_id=%u, task_id=%u, logicCqId=%u.",
        dev->Id_(), streamId, taskId, logicCqId);

    COND_RETURN_ERROR((devDrv == nullptr), RT_ERROR_NONE,
        "dev drv is null, device_id=%u, stream_id=%u", dev->Id_(), streamId);

    rtError_t status = RT_ERROR_NONE;
    rtLogicCqReport_t reportInfo = {};
    while (!isFinished) {
        constexpr uint32_t allocCnt = 1U;
        uint32_t cnt = 0U;
        rtLogicCqReport_t *logicReport = &reportInfo;
        int32_t irqWait = waitTimeout; // default
        uint32_t loopCnt = 0;

        COND_PROC_RETURN_ERROR(stm->GetFailureMode() == ABORT_ON_FAILURE, RT_ERROR_NONE,
            FinishedTaskReclaim(stm, false, static_cast<uint16_t>(stm->GetTaskPosHead()),
            static_cast<uint16_t>(stm->GetTaskPosTail()), finishTaskId),
            "stream is in failure abort and need to reclaim all, device_id=%u, stream_id=%u.", dev->Id_(), streamId);
        status = stm->GetAbortStatus();
        COND_RETURN_ERROR((status == RT_ERROR_STREAM_ABORT),
                          RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL,
                          "stream status is stream abort, device_id=%u, stream_id=%d",
                          stm->Device_()->Id_(),
                          stm->Id_());
        status = stm->CheckContextStatus(false);
        COND_RETURN_ERROR((status == RT_ERROR_DEVICE_TASK_ABORT),
                          RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL,
                          "device task abort, device_id=%u, stream_id=%d",
                          stm->Device_()->Id_(),
                          stm->Id_()); 
        Context * const ctx = stm->Context_();
        const bool isReturnNoError = (status != RT_ERROR_NONE) && (ctx != nullptr) && (ctx->GetFailureError() != RT_ERROR_NONE);
        COND_RETURN_ERROR(isReturnNoError, RT_ERROR_NONE, "context is abort, status=%#x.", static_cast<int32_t>(status));  
        ERROR_RETURN(status, "context is abort, status=%#x.", static_cast<int32_t>(status));

        // default = RT_REPORT_STARS_TIMEOUT_TIME(ms)
        if (unlikely(remainTime > 0)) {
            irqWait = remainTime >= waitTimeout ? waitTimeout : remainTime;
        }
        cqWaitInfo.timeout = irqWait;

        const rtError_t error =
            devDrv->LogicCqReportV2(cqWaitInfo, RtPtrToPtr<uint8_t *>(logicReport), allocCnt, cnt);
        ReportTimeoutProc(error, rptTimeoutCnt, streamId, taskId);
        if (timeout > 0) {
            mmTimespec endTimeSpec = mmGetTickCount();
            const uint64_t endCnt = ((static_cast<uint64_t>(endTimeSpec.tv_sec) * RT_MS_PER_S) +
                                     (static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS));
            const uint64_t count = endCnt > beginCnt ? (endCnt - beginCnt) : 0UL;
            const int32_t spendTime = static_cast<int32_t>(count);
            remainTime = timeout > spendTime ? (timeout - spendTime) : 0;
        }
        RT_LOG(RT_LOG_DEBUG, "Task Wait: sync task judge, timeout=%dms, remainTime=%dms, cnt=%u, irqWait=%dms.", timeout,
            remainTime, cnt, irqWait);
        COND_RETURN_WARN((timeout > 0) && (remainTime == 0) && (cnt == 0U), RT_ERROR_STREAM_SYNC_TIMEOUT,
            "Task Wait: sync task timeout! timeout=%dms, remainTime=%dms, cnt=%u.", timeout, remainTime, cnt);

        if (((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) || (logicReport == nullptr) || (cnt == 0U)) {
            // get sqHead to process finish task when can not get logic CQ report
            (void)RecycleTaskBySqHead(stm, finishTaskId);
            RT_LOG(RT_LOG_INFO, "No logic report: stream_id=%u, task_id=%u, finished task_id=%u, logicCqId=%u, ret=%#x",
                streamId, taskId, finishTaskId, logicCqId, static_cast<uint32_t>(error));
        }

        COND_RETURN_ERROR(
            ((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE) && (error != RT_ERROR_REPORT_TIMEOUT)),
            error, "Task Wait: error=%u.", error);

        IsSyncTaskFinish(stm, taskId);
        // proccess logic cq report
        isFinished = (stm->isForceRecycle_ && (error == RT_ERROR_REPORT_TIMEOUT)) ? true : false;
        ProcReport(taskId, isStreamSync, cnt, logicReport, isFinished, logicCqId);
        COND_RETURN_WARN((stm->isForceRecycle_) && (error == RT_ERROR_REPORT_TIMEOUT) && (isFinished), RT_ERROR_NONE,
            "The stream %d is forcibly reclaimed. Resources may not be completely reclaimed.", stm->Id_());

        loopCnt++;
        bool enable = true;
        (void)devDrv->GetSqEnable(dev->Id_(), dev->DevGetTsId(), stm->GetSqId(), enable);
        COND_RETURN_ERROR((g_isAddrFlatDevice && enable != true && loopCnt > 50U), // sq is disable for 50 times
            RT_ERROR_STREAM_SYNC_TIMEOUT, "device_id=%u, stream_id=%u, sq_id=%u wait fail.",
            dev->Id_(), streamId, stm->GetSqId());
    }

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId)
{
    uint16_t taskId = 0U;
    bool isNeedStreamSync = false;
    int32_t timeout = -1; // -1:no limit
    COND_RETURN_ERROR(workTask == nullptr, RT_ERROR_INVALID_VALUE, "workTask is NULL.");
    Stream * const stm = workTask->stream;
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_INVALID_VALUE, "work stm is NULL.");
    Device* device = stm->Device_();

    COND_RETURN_ERROR(device == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    if (workTask->type == TS_TASK_TYPE_EVENT_RECORD) {
        if (workTask->u.eventRecordTaskInfo.waitCqflag) {
            isNeedStreamSync = true;
            timeout = workTask->u.eventRecordTaskInfo.timeout;
        }
    }

    if ((workTask->type == TS_TASK_TYPE_MAINTENANCE) ||
        (workTask->type == TS_TASK_TYPE_ALLOC_DSA_ADDR) ||
        (workTask->type == TS_TASK_TYPE_GET_STARS_VERSION)) {
        isNeedStreamSync = true;
    }

    const bool bindFlag = stm->GetBindFlag();
    rtError_t error = SendTask(workTask, taskId, flipTaskId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "SendTask fail, streamId=%d, taskId=%hu, taskType=%u, retCode=%#x",
               stm->Id_(), workTask->id, workTask->type, error);
        if (!(bindFlag && (error == RT_ERROR_STREAM_FULL))) {
            TaskFinished(device->Id_(), workTask);
        }
        return error;
    }

    AddPendingNum();

    // simu stars report
    if (bindFlag) {
        stm->StreamSyncLock();
        (void)ProcessTask(workTask, GetDevice()->Id_());
        stm->StreamSyncUnLock();
    }

    if (isNeedStreamSync) {
        stm->StreamSyncLock();
        // isStreamSync para set true if need wait cq in unsink stream
        error = SyncTask(stm, static_cast<uint32_t>(taskId), false, timeout);
        SyncTaskCheckResult(error, stm, taskId);
        stm->StreamSyncUnLock();

        COND_RETURN_INFO(error != RT_ERROR_NONE, error, "SyncTask stream_id=%u, task_id=%u, result=%u",
            stm->Id_(), taskId, error);
        error = SendFlipTask(taskId, stm);
        COND_RETURN_INFO(error != RT_ERROR_NONE, error, "SendFlipTask stream sync stream_id=%u, task_id=%u, result=%u",
            stm->Id_(), taskId, error);
        return error;
    }

    error = SendFlipTask(taskId, stm);
    COND_RETURN_INFO(error != RT_ERROR_NONE, error, "SendFlipTask stream_id=%u, task_id=%u, result=%u",
        stm->Id_(), taskId, error);

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::StarsResumeRtsq(const rtLogicCqReport_t &logicCq, const uint16_t taskType,
    const Stream * const failStm) const
{
    uint32_t offset = 1U;   // skip the error sqe
    uint32_t head = 0U;

    // No error exists.
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) == static_cast<uint8_t>(0U)) {
        return RT_ERROR_NONE;
    }

    // Resume scheduling
    if (taskType == static_cast<uint16_t>(TS_TASK_TYPE_MODEL_EXECUTE)) {
        offset = 2U;    // if model execute sqe, need skip model_execute and wait_end_graph sqe
    }

    rtError_t error = RT_ERROR_NONE;
    Device *dev = GetDevice();
    const uint32_t devId = dev->Id_();
    Driver * const devDrv = dev->Driver_();
    const uint32_t tsId = dev->DevGetTsId();
    bool enable = true;
    uint64_t cnt = 0U;
    uint32_t queryCnt = 0U;
    rtError_t abortStatus = RT_ERROR_NONE;
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
    RT_LOG(RT_LOG_WARNING, "Begin to query sq status, stream_id=%hu.", logicCq.streamId);
    int32_t getSqTimeout = (failStm->GetSyncRemainTime() == -1) ? RT_GET_SQ_STATUS_TIMEOUT_TIME :
        (failStm->GetSyncRemainTime() * 1000);
    getSqTimeout = (g_isAddrFlatDevice == true ? getSqTimeout * 2 : getSqTimeout); // 2 hccs设备用2倍时间
    while (true) {
        COND_RETURN_ERROR_MSG_INNER((Runtime::Instance()->IsSupportOpTimeoutMs() &&
            (failStm->GetFailureMode() == ABORT_ON_FAILURE)), RT_ERROR_NONE,
            "stop scheduling in abort failure mode: stream_id=%hu, sq_id=%hu, sq_head=%hu"
            ", task_id=%hu, taskType=%hu.", logicCq.streamId, logicCq.sqId, logicCq.sqHead,
            logicCq.taskId, taskType);
        if ((cnt++ % RT_GET_HEAD_CYCLE_NUM) == 0U) {
            queryCnt++;
            error = devDrv->GetSqEnable(devId, tsId, static_cast<uint32_t>(logicCq.sqId), enable);
            ERROR_RETURN_MSG_INNER(error, "Failed to get sq enable, stream_id=%d", logicCq.streamId);
            if ((cnt % RT_QUERY_CNT_NUM) == 0U) {
                RT_LOG(RT_LOG_EVENT, "dev_id=%u, ts_id=%u, stream_id=%d, enable=%u",
                    devId, tsId, logicCq.sqId, enable);
            }
            if (!enable) {
                RT_LOG(RT_LOG_WARNING, "sq already disable, stream_id=%hu, queryCnt=%u", logicCq.streamId, queryCnt);
                break;
            }
            abortStatus = failStm->GetAbortStatus();
            COND_RETURN_ERROR_MSG_INNER(
                ((abortStatus == RT_ERROR_STREAM_ABORT) || (abortStatus == RT_ERROR_DEVICE_TASK_ABORT)),
                abortStatus,
                "Stream is in abort status, status=%d.",
                abortStatus);
            mmTimespec endTimeSpec = mmGetTickCount();
            const uint64_t endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * RT_MS_PER_S +
                                    static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
            const uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
            const int32_t spendTime = static_cast<int32_t>(count);
            if (spendTime > getSqTimeout) {
                RT_LOG(RT_LOG_ERROR, "sq disable timeout, stream_id=%hu, sync remain time=%dms",
                    logicCq.streamId, failStm->GetSyncRemainTime());
                return RT_ERROR_NONE;
            }
        }
    }
    abortStatus = failStm->GetAbortStatus();
    COND_RETURN_ERROR_MSG_INNER(((abortStatus == RT_ERROR_STREAM_ABORT) || (abortStatus == RT_ERROR_DEVICE_TASK_ABORT)),
        abortStatus,
        "Stream is in abort status, status=%d.",
        abortStatus);
    if (taskType == static_cast<uint16_t>(TS_TASK_TYPE_MULTIPLE_TASK)) {
        head =  failStm->GetTaskPosHead();
    } else {
        head = ((static_cast<uint32_t>(logicCq.sqHead) + offset) % failStm->GetSqDepth());
    }

    uint16_t sqHead = 0U;
    uint16_t sqTail = 0U;

    error = devDrv->GetSqHead(devId, tsId, static_cast<uint32_t>(logicCq.sqId), sqHead);
    ERROR_RETURN_MSG_INNER(error, "get sq head failed, stream_id=%hu, sq_id=%hu, device_id=%u, retCode=%#x.",
        logicCq.streamId, logicCq.sqId, devId, static_cast<uint32_t>(error));

    error = devDrv->GetSqTail(devId, tsId, static_cast<uint32_t>(logicCq.sqId), sqTail);
    ERROR_RETURN_MSG_INNER(error, "get sq tail failed, stream_id=%hu, sq_id=%hu, device_id=%u, retCode=%#x.",
        logicCq.streamId, logicCq.sqId, devId, static_cast<uint32_t>(error));

    if (sqHead == sqTail) {
        RT_LOG(RT_LOG_ERROR, "stop scheduling due to sq is destroyed : stream_id=%hu, sq_id=%hu, logicCq sq_head=%hu"
            ", task_id=%hu, taskType=%hu, sq_head=%hu, sq_tail=%hu.",
            logicCq.streamId, logicCq.sqId, logicCq.sqHead, logicCq.taskId, taskType, sqHead, sqTail);
        return RT_ERROR_NONE;
    }

    error = devDrv->SetSqHead(devId, tsId, static_cast<uint32_t>(logicCq.sqId), head);
    ERROR_RETURN_MSG_INNER(error, "set sq head failed, stream_id=%hu, sq_id=%hu, device_id=%u, retCode=%#x.",
        logicCq.streamId, logicCq.sqId, devId, static_cast<uint32_t>(error));

    if (failStm->GetFailureMode() == ABORT_ON_FAILURE) {
        RT_LOG(RT_LOG_ERROR, "stop scheduling in abort failure mode: stream_id=%hu, sq_id=%hu, sq_head=%hu"
            ", task_id=%hu, taskType=%hu.", logicCq.streamId, logicCq.sqId, logicCq.sqHead, logicCq.taskId, taskType);
        return RT_ERROR_NONE;
    }

    error = devDrv->EnableSq(devId, tsId, static_cast<uint32_t>(logicCq.sqId));
    ERROR_RETURN_MSG_INNER(error, "Enable sq failed, stream_id=%hu, sq_id=%hu, device_id=%u, retCode=%#x.",
        logicCq.streamId, logicCq.sqId, devId, static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_WARNING, "Resume stream_id=%hu, sq_id=%hu, sq_head=%hu, task_id=%hu, taskType=%hu, head=%u.",
        logicCq.streamId, logicCq.sqId, logicCq.sqHead, logicCq.taskId, taskType, head);

    return RT_ERROR_NONE;
}

bool StarsEngine::ProcReportIsException(const rtLogicCqReport_t &logicCq, TaskInfo *reportTask) const
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        return false;
    }

    rtStarsCqeSwStatus_t swStatus;
    swStatus.value = logicCq.errorCode;

    if ((logicCq.sqeType == static_cast<uint8_t>(RT_STARS_SQE_TYPE_AICPU)) &&
        (swStatus.value == AE_STATUS_TASK_ABORT)) {
        return false;
    }
    /* when error is  NOTIFY_WAIT, need check model_exec result */
    if (logicCq.sqeType == static_cast<uint8_t>(RT_STARS_SQE_TYPE_NOTIFY_WAIT)) {
        if ((swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_END_OF_SEQ)) ||
            (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_EXE_ABORT)) ||
            (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_AICPU_TIMEOUT))) {
            return false;
        }
    }

    /* when error is EVENT_WAIT, need check exec result */
    if (logicCq.sqeType == static_cast<uint8_t>(RT_STARS_SQE_TYPE_EVENT_WAIT)) {
        if (swStatus.value == TS_ERROR_END_OF_SEQUENCE) {
            return false;
        }
    }

    /* TS_TASK_TYPE_GET_STARS_VERSION used for get stars version */
    if (logicCq.sqeType == static_cast<uint8_t>(RT_STARS_SQE_TYPE_PLACE_HOLDER)) {
        if ((reportTask != nullptr) && (reportTask->type == TS_TASK_TYPE_GET_STARS_VERSION)) {
            return false;
        }
    }

    if ((logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_AICORE_OVERFLOW))
        || (logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_AIVEC_OVERFLOW))
        || (logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_AICPU_OVERFLOW))
        || (logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_SDMA_OVERFLOW))) {
        return false;
    }

    return true;
}

const std::vector<std::string> StarsEngine::StarsCqeErrorDesc_ = {
    "task exception",
    "task trap",
    "task timeout",
    "sqe error",
    "resource conflict error",
    "sq sw status error",
    "warning"
};

void StarsEngine::ClearMulTaskCqeNum(const uint8_t mulTaskCqeNum, TaskInfo * const repTask) const
{
    TaskInfo* reportTask = repTask;
    if (mulTaskCqeNum == 0) {
        return;
    }
    for (uint8_t idx = 0; idx < (mulTaskCqeNum - static_cast<uint8_t>(1)); idx++) {
        reportTask->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage++;
    }

    const uint8_t cqeNum = GetMultipleTaskCqeNum(reportTask);
    for (uint8_t idx = 0; idx < cqeNum; idx++) {
        DecMultipleTaskCqeNum(reportTask);
    }
}

void StarsEngine::ProcLogicCqReport(const rtLogicCqReport_t &logicCq, const bool isStreamSync, TaskInfo * reportTask)
{
    UNUSED(isStreamSync);
    const uint16_t streamId = (logicCq.streamId & 0x7FFFU);   // bit15 is the flag of sync task
    const uint16_t taskId = logicCq.taskId;
    const uint16_t sqId = logicCq.sqId;
    const uint16_t sqHead = logicCq.sqHead;
    const uint8_t errType = logicCq.errorType;
    const uint32_t errBit = (errType == 0U) ? UINT32_BIT_NUM : static_cast<uint32_t>(CTZ(errType));
    const char_t * const errMsg = static_cast<size_t>(errBit) < StarsCqeErrorDesc_.size() ?
                                  StarsCqeErrorDesc_[static_cast<size_t>(errBit)].c_str() : "unknow";
    bool isExceptionFlag = false;

    if (reportTask == nullptr) {
        reportTask = GetDevice()->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), taskId);
    }

    if (ProcReportIsException(logicCq, reportTask)) {
        RT_LOG(RT_LOG_ERROR, "Task run failed, device_id=%u, stream_id=%hu, task_id=%hu, sqe_type=%u(%s), "
            "errType=%#x(%s), sqSwStatus=%#x", GetDevice()->Id_(), streamId, taskId,
            static_cast<uint32_t>(logicCq.sqeType), GetSqeDescByType(logicCq.sqeType), errType,
            errMsg, logicCq.errorCode);
        const uint32_t swStatus = logicCq.errorCode;
        isExceptionFlag = true;
        (void)GetDevice()->PrintStreamTimeoutSnapshotInfo();
        if (reportTask != nullptr) {
            TaskInfo * const faultTaskPtr = GetRealReportFaultTask(reportTask, static_cast<const void *>(&swStatus));
            (void)GetDevice()->ProcDeviceErrorInfo(faultTaskPtr);
            if (faultTaskPtr != nullptr && !faultTaskPtr->isRingbufferGet && faultTaskPtr->type != TS_TASK_TYPE_KERNEL_AICPU) { // Try to get ringbuffer for N-seconds fast recovery.
                (void)GetDevice()->ProcDeviceErrorInfo(faultTaskPtr);
            }
            if (!reportTask->stream->IsSeparateSendAndRecycle()) {
                reportTask->stream->EnterFailureAbort();
            }
        } else {
            (void)GetDevice()->ProcDeviceErrorInfo();
        }
    } else if ((errType & (RT_STARS_EXIST_ERROR | RT_STARS_EXIST_WARNING)) != static_cast<uint8_t>(0U)) {
        // error bit indicates overflow of debug model or endofsquence here
        RT_LOG(RT_LOG_WARNING,
            "CQE warning, device_id=%u, stream_id=%hu, task_id=%hu, sqe_type=%u(%s), errType=%#x(%s), sqSwStatus=%#x",
            GetDevice()->Id_(), streamId, taskId, static_cast<uint32_t>(logicCq.sqeType),
            GetSqeDescByType(logicCq.sqeType), errType, errMsg, logicCq.errorCode);
    } else {
        // no operation
    }

    if (unlikely(reportTask == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "task or task stream is null, stream_id=%hu, task_id=%hu, sq_id=%hu, sqHead=%hu",
            streamId, taskId, sqId, sqHead);
        return;
    }

    Stream * const stm = reportTask->stream; // save ptr before task recycle instead of re-lookup stream map
    stm->SetStreamAsyncRecycleFlag(false);

    const tsTaskType_t taskType = reportTask->type;
    RT_LOG(RT_LOG_DEBUG, "RTS_DRIVER: report receive, stream_id=%hu, task_id=%hu, sq_id=%hu, sqHead=%hu, "
        "task_type=%hu(%s).",
        streamId, taskId, sqId, sqHead, static_cast<uint16_t>(taskType), reportTask->typeName);

    reportTask->error = 0U;
    StarsCqeReceive(logicCq, reportTask);

    // Set error device status
    if (GetDevice()->GetHasTaskError()) {
        GetDevice()->SetMonitorExitFlag(true);
        Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);
    }
    if (stm->IsSeparateSendAndRecycle()) {
        InnerThreadLocalContainer::SetCurCtx(stm->Context_());
        (void)RecycleSeparatedStmByFinishedId(stm, taskId, true);
        if (isExceptionFlag) {
            stm->EnterFailureAbort();
            stm->SetExecuteEndTaskId(taskId);
        }
    } else {
        if (stm->GetLimitFlag() && (!isExceptionFlag)) {
            (void)ProcessHeadTaskByStreamId(streamId);
        } else if (likely(CheckPackageState(reportTask))) {
            (void)ProcessTask(reportTask, GetDevice()->Id_());
        } else {
            RT_LOG(RT_LOG_WARNING, "No operation.");
        }
    }

    (void)StarsResumeRtsq(logicCq, static_cast<uint16_t>(taskType), stm);
    // Set monitor device status normal to get next error
    if (GetDevice()->GetHasTaskError()) {
        GetDevice()->SetHasTaskError(false);
        GetDevice()->SetMonitorExitFlag(false);
    }
    return;
}

void StarsEngine::StarsReportLogicCq(const rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc)
{
    Device *dev = GetDevice();
    uint32_t realDeviceId = 0U;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(dev->Id_(), &realDeviceId);
    COND_RETURN_VOID((error != RT_ERROR_NONE), "Convert drvDeviceId:%u is err:%#x",
        dev->Id_(), static_cast<uint32_t>(error));
    rtDvppGrpRptInfo_t dvppReport = {};
    dvppReport.deviceId = realDeviceId;
    dvppReport.streamId = report.streamId;
    dvppReport.taskId = CovertToFlipTaskId(report.streamId, report.taskId, dev);
    dvppReport.sqeType = report.sqeType;
    dvppReport.cqeErrorCode = GetStarsDefinedErrCode(report.errorType);
    dvppReport.accErrorCode = report.errorCode;

    callBackFunc(&dvppReport);
    ProcLogicCqReport(report, false, nullptr);
    RT_LOG(RT_LOG_DEBUG, "Report logic cq, streamId=%u, taskId=%u, sqeType=%hhu, cqeCode=%hhu.",
        dvppReport.streamId, dvppReport.taskId, dvppReport.sqeType, dvppReport.cqeErrorCode);

    return;
}

void StarsEngine::StarsReportLogicCq(const rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc,
                                            uint8_t sqeType, uint8_t cqeErrorCode)
{
    Device *dev = GetDevice();
    uint32_t realDeviceId = 0U;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(dev->Id_(), &realDeviceId);
    COND_RETURN_VOID((error != RT_ERROR_NONE), "Convert drvDeviceId:%u is err:%#x",
        dev->Id_(), static_cast<uint32_t>(error));
    rtDvppGrpRptInfo_t dvppReport = {};
    dvppReport.deviceId = realDeviceId;
    dvppReport.streamId = report.streamId;
    dvppReport.taskId = CovertToFlipTaskId(report.streamId, report.taskId, dev);
    dvppReport.sqeType = sqeType;
    dvppReport.cqeErrorCode = cqeErrorCode;
    dvppReport.accErrorCode = report.errorCode;

    callBackFunc(&dvppReport);
    ProcLogicCqReport(report, false, nullptr);

    RT_LOG(RT_LOG_DEBUG, "Report stars logic cq, streamId=%u, taskId=%u, sqeType=%hhu, cqeCode=%hhu.",
        dvppReport.streamId, dvppReport.taskId, dvppReport.sqeType, dvppReport.cqeErrorCode);

    return;
}

// waitgroup get result
rtError_t StarsEngine::MultipleTaskReportLogicCq(TaskInfo * const workTask, const rtLogicCqReport_t& report,
                                                 rtDvppGrpCallback callBackFunc)
{
    if (!CompleteProcMultipleTaskReport(workTask, report)) {
        RT_LOG(RT_LOG_INFO, "MultipleTask not CompleteProc sqeType = %u, streamId = %u, taskId = %u",
            report.sqeType, report.streamId, report.taskId);
        return RT_ERROR_STREAM_SYNC_TIMEOUT;
    }

    TaskInfo* reportTask = workTask;
    StarsReportLogicCq(report, callBackFunc, static_cast<uint8_t>(RT_STARS_SQE_TYPE_VIR_TYPE),
        GetStarsDefinedErrCode(reportTask->u.davinciMultiTaskInfo.errorType));

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::CommonTaskReportLogicCq(const rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc)
{
    // check if vpc error and retry
    if (ProcReportIsVpcErrorAndRetry(report)) {
        RT_LOG(RT_LOG_WARNING, "ProcReportIsVpcErrorAndRetry is true.");
        return RT_ERROR_STREAM_SYNC_TIMEOUT;
    }

    StarsReportLogicCq(report, callBackFunc);

    return RT_ERROR_NONE;
}

rtError_t StarsEngine::ReportLogicCq(const rtLogicCqReport_t& report, rtDvppGrpCallback callBackFunc)
{
    TaskInfo * const reportTask = GetDevice()->GetTaskFactory()->GetTask(
        static_cast<int32_t>(report.streamId), report.taskId);
    if (unlikely(reportTask == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%hu, task_id=%hu.",
            GetDevice()->Id_(), report.streamId, report.taskId);
        StarsReportLogicCq(report, callBackFunc);
        return RT_ERROR_NONE;
    }

    const tsTaskType_t taskType = reportTask->type;
    RT_LOG(RT_LOG_DEBUG, "ReportLogicCq get taskType=%u", taskType);
    if ((taskType == TS_TASK_TYPE_MULTIPLE_TASK) && (GetSendSqeNum(reportTask) > 1U)) {
        return MultipleTaskReportLogicCq(reportTask, report, callBackFunc);
    }

    return CommonTaskReportLogicCq(report, callBackFunc);
}

rtError_t StarsEngine::DvppWaitGroup(DvppGrp *grp, rtDvppGrpCallback callBackFunc, int32_t timeout)
{
    Device *dev = GetDevice();
    rtLogicCqReport_t report = {};
    Driver * const devDrv = dev->Driver_();
    uint32_t cnt = 0U;
    const uint32_t logicCqid = grp->getLogicCqId();

    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = dev->Id_();
    waitInfo.tsId = dev->DevGetTsId();
    waitInfo.cqId = logicCqid;
    waitInfo.isFastCq = false;
    waitInfo.timeout = timeout;
    waitInfo.streamId = UINT32_MAX;
    waitInfo.taskId = UINT32_MAX;

    const rtError_t error = devDrv->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *>(&report), 1U, cnt);
    RT_LOG(RT_LOG_DEBUG, "Logic cq=%u, timeout=%dms, ret=%#x, cnt=%u.", logicCqid, timeout, error, cnt);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if (cnt == 0U) {
        return RT_ERROR_STREAM_SYNC_TIMEOUT;
    }

    AtraceParams param = { GetDevice()->Id_(), static_cast<uint32_t>(report.streamId), report.taskId,
        GetCurrentTid(), GetDevice()->GetAtraceHandle(), {}};
    param.u.cqReportParams = { logicCqid, report.errorCode, report.sqeType };
    AtraceSubmitLog(TYPE_CQ_REPORT, param);
    RT_LOG(RT_LOG_DEBUG, "Get report: logicCq=%u, streamId=%hu, taskId=%u, code=%#x, "
        "type=%hhu, sqeType=%hhu.",
        logicCqid, report.streamId, report.taskId, report.errorCode, report.errorType, report.sqeType);
    return ReportLogicCq(report, callBackFunc);
}

void StarsEngine::MonitorForWatchDog(Device * const dev)
{
    // 1. read ringbuffer
    uint16_t errorStreamId = 0xFFFFU;
    rtError_t ret = dev->ReportRingBuffer(&errorStreamId);
    if (ret != RT_ERROR_TASK_MONITOR) {
        return;
    }

    COND_RETURN_NORMAL((dev->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT),
        "Device task abort, do not reclaim task.");
    if (!(device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_WATCH_DOG))) {
        Runtime::Instance()->SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_ABNORMAL);
        return;
    }
    // 2. 1971 Monitor taskReclaim
    uint32_t cycleTimes = 10000U;    // Number of cyclic waiting for recycle cqe
    while ((cycleTimes != 0U) && Runtime::Instance()->GetThreadGuard()->GetMonitorStatus()) {
        ret = MonitorTaskReclaim(errorStreamId);
        if (ret == RT_ERROR_TASK_MONITOR) {
            break;
        }
        cycleTimes--;
    }
}

void StarsEngine::MonitorEndGraphNotify(Device * const dev) const
{
    RawDevice* const rawDev = dynamic_cast<RawDevice *>(dev);
    rawDev->PollEndGraphNotifyInfo();
}

void StarsEngine::MonitoringRun()
{
    Device * const dev = GetDevice();
    NULL_PTR_RETURN_DIRECTLY(dev);
    const uint32_t tsId = dev->DevGetTsId();
#ifndef CFG_DEV_PLATFORM_PC
    ErrorManager::GetInstance().SetErrorContext(errorContext_);
#endif
    RT_LOG(RT_LOG_INFO, "Stars Monitor thread has entered, ts_id=%u", tsId);
    rtError_t ret = RT_ERROR_NONE;
    constexpr uint32_t sliceNum = 50U;
    Runtime::Instance()->MonitorNumAdd(1U);
    GlobalStateManager::GetInstance().IncBackgroundThreadCount(__func__);
    while (monitorThreadRunFlag_ && !(Runtime::Instance()->IsExiting()) &&
           Runtime::Instance()->GetThreadGuard()->GetMonitorStatus()) {
        GlobalStateManager::GetInstance().BackgroundThreadWaitIfLocked(__func__);
        // HDC Down
        ReportSocketCloseProc();
        // OOM
        ReportOomQueryProc();
        // TS Heartbeat Down
        ret = ReportHeartBreakProcV2();
        LOST_HEARTBEAT_PROC_RETURN(ret,
            std::to_string(GetDevice()->Id_()),
            Runtime::Instance()->MonitorNumSub(1U),
            GlobalStateManager::GetInstance().DecBackgroundThreadCount(__func__));
        if (GetDevRunningState() != static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
            (void)MonitorForWatchDog(dev);
            MonitorEndGraphNotify(dev);
        }

        // sleep 1s
        for (uint32_t i = 0U; i < sliceNum; i++) {
            if (!monitorThreadRunFlag_) {
                break;
            }
            (void)mmSleep(20U);
        }
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_EVENT_POOL)) {
            dev->TryFreeAllEventPoolId();
        }
        Runtime::Instance()->TryToRecyclePool();
    }

    // HDC Down
    ReportSocketCloseProc();
    // OOM
    ReportOomQueryProc();
    // TS HeartBeat Down
    (void)ReportHeartBreakProcV2();
    monitorIsRunning_ = false;
    Runtime::Instance()->MonitorNumSub(1U);
    GlobalStateManager::GetInstance().DecBackgroundThreadCount(__func__);
    RT_LOG(RT_LOG_INFO, "Stars Monitor thread has finished, ts_id=%u.", tsId);
}

void StarsEngine::RecycleThreadDo()
{
    rtError_t ret = RT_ERROR_NONE;
    std::vector<uint32_t> streamIdList;
    std::shared_ptr<Stream> stream = nullptr;
    (void) device_->GetStreamSqCqManage()->GetAllStreamId(streamIdList);
    for (const auto &id: streamIdList) {
        ret = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(id, stream);
        COND_PROC(((ret != RT_ERROR_NONE) || (stream == nullptr)), continue);
        stream.get()->StreamRecycleLock();
        COND_PROC(((stream->GetPendingNum() == 0U) || (stream->GetBindFlag()) || (stream->IsBindDvppGrp()) || (!stream->IsSeparateSendAndRecycle())),
            stream.get()->StreamRecycleUnlock(); stream.reset(); continue);
        ret = TaskReclaimForSeparatedStm(stream.get());
        stream.get()->StreamRecycleUnlock();
        stream.reset();
        COND_PROC((ret != RT_ERROR_NONE), return ;);
    }
}
void StarsEngine::RecycleTaskProcessForSeparatedStm(TaskInfo * const recycleTask, const uint32_t devId)
{
    COND_PROC(((recycleTask == nullptr)), return;);
    Engine::ProcessProfAndObserver(recycleTask, devId);
    Stream *stm = recycleTask->stream;
    if (stm->GetArgHandle() != nullptr) {
        (void)device_->ArgLoader_()->Release(stm->GetArgHandle());
        stm->SetArgHandle(nullptr);
    }
    Complete(recycleTask, devId);
    pendingNum_.Sub(1U);
    if (recycleTask->bindFlag != 0U) {
        return;
    }
    const uint32_t recycleTaskSqeNum = GetSendSqeNum(recycleTask);
    const uint32_t recycleTaskPos = recycleTask->pos;
    uint16_t recycleTaskId = recycleTask->id;
    uint16_t excepted = recycleTaskId;
    (void)device_->GetTaskFactory()->Recycle(recycleTask);
    stm->UpdateTaskPosHead(recycleTaskPos, recycleTaskSqeNum);
    stm->taskResMang_->RecycleResHead();
    (void)stm->latestConcernedTaskId.CompareExchange(excepted, MAX_UINT16_NUM);
    stm->SetRecycleEndTaskId(recycleTaskId);
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, recycle task_id=%hu, sqHead=%u, sqTail=%u, sqeNum=%u, resHead=%hu, resTail=%hu.",
           stm->Device_()->Id_(), stm->Id_(), recycleTaskId, stm->GetTaskPosHead(), stm->GetTaskPosTail(), recycleTaskSqeNum,
           stm->taskResMang_->taskResHead_, stm->taskResMang_->taskResTail_);
    return;
}

rtError_t StarsEngine::RecycleSeparatedStmByFinishedId(Stream * const stm, const uint16_t endTaskId, bool isCqeProcess)
{
    const uint16_t taskResDepth = stm->taskResMang_->GetTaskPoolNum();
    TaskInfo *recycleTask = nullptr;
    uint32_t recycleTaskId = 0U;
    const uint16_t endTaskPos = endTaskId % taskResDepth;
    const uint16_t recycleEndPos = (endTaskPos + 1) % taskResDepth;
    if (stm->GetBindFlag()) {
        recycleTask = stm->Device_()->GetTaskFactory()->GetTask(stm->Id_(), endTaskId);
        RecycleTaskProcessForSeparatedStm(recycleTask, stm->Device_()->Id_());
        return RT_ERROR_NONE;
    }
    if (!isCqeProcess) {
        stm->SetExecuteEndTaskId(endTaskId);
    }
    while (stm->taskResMang_->GetResHead() != recycleEndPos) {
        recycleTask = stm->taskResMang_->GetHeadTaskInfo();
        recycleTaskId = recycleTask->id;
        if (recycleTaskId == MAX_UINT16_NUM) {
            if (stm->taskResMang_->GetResHead() != 2047U) {
                RT_LOG(RT_LOG_ERROR, "stream_id=%u, major error, pos=%u, tail=%u," ,
                       stm->Id_(), stm->taskResMang_->GetResHead(), stm->taskResMang_->taskResTail_);
            }
            stm->taskResMang_->RecycleResHead();
            continue;
        }
        if ((recycleTask->isCqeNeedConcern != 0U) &&
            unlikely((stm->GetFailureMode() != ABORT_ON_FAILURE) && (!stm->isForceRecycle_))) {
            RT_LOG(RT_LOG_DEBUG, "Task delay recycle until CQE received, stream_id=%d, task_id=%hu", stm->Id_(), recycleTaskId);
            stm->SetNeedRecvCqeFlag(true);
            break;
        }
        RecycleTaskProcessForSeparatedStm(recycleTask, stm->Device_()->Id_());
    }
    return RT_ERROR_NONE;
}

rtError_t StarsEngine::TaskReclaimBySqHeadForSeparatedStm(Stream * const stm)
{
    uint16_t sqHead = 0U;
    uint32_t endTaskId = MAX_UINT16_NUM;
    rtError_t error = device_->Driver_()->GetSqHead(device_->Id_(), device_->DevGetTsId(), stm->GetSqId(), sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
                                static_cast<uint32_t>(error));

    if (unlikely(stm->GetFailureMode() == ABORT_ON_FAILURE)) {
        endTaskId = stm->GetLastTaskId();
        RT_LOG(RT_LOG_INFO, "stream is in failure abort and need to reclaim all, stream_id=%d, lastTaskId=%u, "
                            "failuremode=%" PRIu64, stm->Id_(), stm->GetLastTaskId(), stm->GetFailureMode());
        return RecycleSeparatedStmByFinishedId(stm, endTaskId);
    }

    error = stm->GetFinishedTaskIdBySqHead(sqHead, endTaskId);
    COND_PROC(((error != RT_ERROR_NONE) || (endTaskId == MAX_UINT16_NUM)), return RT_ERROR_NONE);
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, sqHead=%d, posHead=%u, posTail=%u, finishedTaskId=%d",
           stm->Device_()->Id_(), stm->Id_(), sqHead, stm->GetTaskPosHead(), stm->GetTaskPosTail(), endTaskId);
    (void)RecycleSeparatedStmByFinishedId(stm, endTaskId);
    return RT_ERROR_NONE;
}

rtError_t StarsEngine::TaskReclaimByCqeForSeparatedStm(Stream * const stm)
{
    if (stm->IsExistCqe() || stm->GetNeedRecvCqeFlag()) {
        uint32_t finishTaskId = 0U;
        return ProcLogicCqUntilEmpty(stm, finishTaskId);
    }
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
