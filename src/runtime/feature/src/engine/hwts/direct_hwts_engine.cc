/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "direct_hwts_engine.hpp"
#include <ctime>
#include "engine.hpp"
#include "base.hpp"
#include "securec.h"
#include "runtime.hpp"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "profiler.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "npu_driver.hpp"
#include "notify.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "task_res.hpp"
#include "thread_local_container.hpp"
#include "atrace_log.hpp"
#include "task_fail_callback_manager.hpp"
#include "error_code.h"
#include "global_state_manager.hpp"

namespace {
constexpr uint16_t TASK_RECLAIM_MAX_NUM = 64U;     // Max reclaim num per query.
constexpr uint16_t TASK_QUERY_INTERVAL_NUM = 64U;     // Shared memory query interval.
constexpr uint16_t TASK_WAIT_EXECUTE_MAX_NUM = 512U;     // Max number of tasks waiting to be executed on device.
}

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(ObserverSubmitted);
TIMESTAMP_EXTERN(ReportReceive);
TIMESTAMP_EXTERN(ObserverFinished);

void ProIsSetNotified(const uint32_t sendTaskId, const uint32_t rcvTaskId, bool *notified)
{
    if ((rcvTaskId == 0) && (sendTaskId != rcvTaskId) && (*notified)) {
        (*notified) = false;
    }
}

DirectHwtsEngine::DirectHwtsEngine(Device * const dev)
    : HwtsEngine(dev),
      monitorThread_(static_cast<Thread *>(nullptr)),
      recycleThread_(static_cast<Thread *>(nullptr)),
      recycleThreadRunFlag_(false),
      monitorThreadRunFlag_(false)
{
    RT_LOG(RT_LOG_EVENT, "Constructor.");
}

DirectHwtsEngine::~DirectHwtsEngine()
{
    monitorThread_ = nullptr;
    recycleThread_ = nullptr;

    const std::unique_lock<std::mutex> statusLock(statusMutex_);
    auto iter = vecTaskStatus_.begin();
    while (iter != vecTaskStatus_.end()) {
        if (*iter != nullptr) {
            delete *iter;
        }
        (void)iter++;
    }
    RT_LOG(RT_LOG_EVENT, "Destructor.");
}

rtError_t DirectHwtsEngine::InitStreamRes(const uint32_t streamId)
{
    EraseTaskStatus(static_cast<size_t>(streamId));
    return shmCq_.InitCqShm(streamId);
}

rtError_t DirectHwtsEngine::QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId)
{
    return shmCq_.QueryLatestTaskId(streamId, taskId);
}

uint32_t DirectHwtsEngine::GetShareSqId() const
{
    return shmCq_.GetShareSqId();
}

rtError_t DirectHwtsEngine::Init()
{
    SetWaitTimeout(device_->GetDevProperties().reportWaitTimeout);
    Driver * const devDrv = device_->Driver_();
    bool isFastCq = false;
    COND_RETURN_ERROR_MSG_INNER((devDrv == nullptr), RT_ERROR_DRV_NULL, "Not found drv info.");
    rtError_t error = devDrv->LogicCqAllocate(device_->Id_(), device_->DevGetTsId(),
                                              MAX_UINT32_NUM, false, logicCqId_, isFastCq, false);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "LogicCqAllocate failed,retCode: %#x", static_cast<uint32_t>(error));
        return error;
    }
    error = shmCq_.Init(device_);
    if (error == RT_ERROR_DRV_INPUT) {
        return error;
    }
    ERROR_RETURN_MSG_INNER(error, "shmCq_ Init failed, device id: %u retCode: %#x",
        device_->Id_(), static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

void DirectHwtsEngine::Run(const void * const param)
{
    switch (static_cast<ThreadType>(RtPtrToValue(param))) {
        case THREAD_MONITOR: {
            MonitoringRun();
            break;
        }
        case THREAD_RECYCLE: {
            RecycleThreadRun();
            break;
        }
        case THREAD_PRINTF: {
            PrintfRun();
            break;
        }
        default: {
            RT_LOG(RT_LOG_ERROR, "Unknown thread type");
            break;
        }
    }
}

rtError_t DirectHwtsEngine::Start()
{
    // check if engine is started.
    COND_RETURN_ERROR_MSG_INNER((monitorThread_ != nullptr), RT_ERROR_ENGINE_THREAD,
                                "DirectHwtsEngine already start.");

    rtError_t error;
    int32_t err = EN_OK;
    void *monitor;
    const char_t *threadName;

    monitor = RtValueToPtr<void *>(THREAD_MONITOR);
    threadName = (device_->DevGetTsId() == static_cast<uint32_t>(RT_TSC_ID)) ?
                 "MONITOR_0" : "MONITOR_1";
    monitorThread_ = OsalFactory::CreateThread(threadName, this, monitor);
    NULL_PTR_GOTO_MSG_INNER(monitorThread_, ERROR_RETURN, error, RT_ERROR_MEMORY_ALLOCATION);
    monitorThreadRunFlag_ = true;
    err = monitorThread_->Start();
    COND_PROC_GOTO_MSG_INNER(err != EN_OK, ERROR_RETURN, error = RT_ERROR_MEMORY_ALLOCATION;,
        "monitor thread start failed");

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_RECYCLE_THREAD)) {
        if ((device_->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE)) {
            GetDevice()->SetIsChipSupportRecycleThread(true);
        }
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_RECYCLE_EVENT_THREAD)) {
            GetDevice()->SetIsChipSupportEventThread(true);
        }
        error = CreateRecycleThread();
        ERROR_GOTO_MSG_INNER(error, ERROR_RETURN, "create recycle thread failed");
    }

    return RT_ERROR_NONE;

ERROR_RETURN:
    monitorThreadRunFlag_ = false;
    if (monitorThread_ != nullptr) {
        monitorThread_->Join();
    }
    DELETE_O(monitorThread_);
    return error;
}

rtError_t DirectHwtsEngine::Stop()
{
    if (monitorThread_ != nullptr) {
        monitorThreadRunFlag_ = false;
        monitorThread_->Join();
        RT_LOG(RT_LOG_INFO, "engine joined monitor thread OK.");
        DELETE_O(monitorThread_);
    }
    DestroyRecycleThread();
    DestroyPrintfThread();

    if (logicCqId_ != MAX_UINT32_NUM) {
        (void)device_->Driver_()->LogicCqFree(device_->Id_(), device_->DevGetTsId(), logicCqId_);
    }

    return RT_ERROR_NONE;
}

rtError_t DirectHwtsEngine::CreateRecycleThread(void)
{
    void * const recycle = RtValueToPtr<void *>(THREAD_RECYCLE);
    recycleThread_ = OsalFactory::CreateThread("RT_RECYCLE", this, recycle);
    if (recycleThread_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "create recycle thread failed");
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const rtError_t error = mmSemInit(&recycleThreadSem_, 0U);
    if (error != RT_ERROR_NONE) {
        DELETE_O(recycleThread_);
        RT_LOG(RT_LOG_ERROR, "create sem failed,retCode=%d", error);
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

void DirectHwtsEngine::DestroyRecycleThread(void)
{
    if (recycleThread_ != nullptr) {
        recycleThreadRunFlag_ = false;
        WakeUpRecycleThread();
        recycleThread_->Join();
        RT_LOG(RT_LOG_INFO, "engine joined recycle thread OK.");
        DELETE_O(recycleThread_);
        (void)mmSemDestroy(&recycleThreadSem_);
    }

    return;
}

void DirectHwtsEngine::RecycleThreadRun(void)
{
    RT_LOG(RT_LOG_INFO, "RecycleThreadRun thread enter.");
    while (recycleThreadRunFlag_) {
        (void)mmSemWait(&recycleThreadSem_);
        RecycleThreadDo();
    }
    RT_LOG(RT_LOG_INFO, "RecycleThreadRun thread leave.");
    return;
}

void DirectHwtsEngine::WakeUpRecycleThread(void)
{
    (void)mmSemPost(&recycleThreadSem_);
}

void DirectHwtsEngine::SendingWait(Stream * const stm, uint8_t &failCount)
{
    ++failCount;
    uint32_t taskId = 0U;
    stm->StreamSyncLock();
    stm->SetRecycleFlag(true);
    (void)TaskReclaim(static_cast<uint32_t>(stm->Id_()), true, taskId);
    if (IsExeTaskSame(stm, taskId)) {
        AtraceParams param = { stm->Device_()->Id_(), static_cast<uint32_t>(stm->Id_()), 0, GetCurrentTid(),
            GetDevice()->GetAtraceHandle(), {}};
        param.u.taskRecycleParams = { stm->GetLastTaskId(), taskId, TYPE_SENDINGWAIT };
        AtraceSubmitLog(TYPE_TASK_RECYCLE, param);
    }
    stm->SetRecycleFlag(false);
    stm->StreamSyncUnLock();
    return;
}

void DirectHwtsEngine::SyncTaskQueryShm(const uint32_t streamId,
                                        const uint32_t taskId, const uint32_t cqId)
{
    uint32_t execId = UINT32_MAX;
    const rtError_t error = QueryShmInfo(streamId, false, execId);
    if (error != RT_ERROR_NONE) {  // abnormal
        RT_LOG(RT_LOG_WARNING, "Get abnormal task from SHM, stream_id=%u, task_id=%u", streamId, execId);
    }
    if ((execId != UINT32_MAX) && TaskIdIsGEQ(execId, taskId)) {
        RT_LOG(RT_LOG_DEBUG, "Task finished. stream_id=%u, task_id=%u.", streamId, taskId);
    }
    RT_LOG(RT_LOG_INFO, "Task Wait: stream_id=%u, task_id=%u, cq_id=%u, exec_id=%u.", streamId,
        taskId, cqId, execId);
}

void DirectHwtsEngine::ProcessFastCqTask(const uint32_t streamId, const uint32_t taskId)
{
    uint32_t shmTaskId = UINT32_MAX;
    const rtError_t error = QueryShmInfo(streamId, true, shmTaskId);
    if ((error == RT_ERROR_NONE) && (shmTaskId != UINT32_MAX) && TASK_ID_GEQ(shmTaskId, taskId)) {
        // This task is recycled in query share memory process, no need to recycle.
        RT_LOG(RT_LOG_INFO, "Task finished. stream_id=%u, task_id=%u.", streamId, taskId);
        return;
    }
    // fast cq interrupt may be faster than share memory, so recycle this task.
    RecycleTask(streamId, taskId);

    const std::lock_guard<std::mutex> statusLock(statusMutex_);
    rtShmQuery_t *shmInfo = vecTaskStatus_[static_cast<size_t>(streamId)];
    if (shmInfo != nullptr) {
        const uint32_t lastTaskId = shmInfo->taskId;
        const uint32_t logicTaskId = taskId;
        if (TASK_ID_GEQ(lastTaskId, logicTaskId)) {
            return;
        }
        shmInfo->taskId = taskId;
    } else {
        shmInfo = TaskStatusAlloc(streamId);
        COND_RETURN_VOID(shmInfo == nullptr, "new shmInfo memory fail");
        shmInfo->taskId = taskId;
    }
}

void DirectHwtsEngine::IsSyncFinish(const uint32_t taskId, uint32_t cnt, const rtLogicReport_t *logicReport) const
{
    bool isFinished = false;
    for (uint32_t idx = 0U; idx < cnt; ++idx) {
        const rtLogicReport_t &report = logicReport[idx];
        const uint32_t taskIdVar = report.taskId;
        const uint8_t logicCqTypeVar = report.logicCqType;
        RT_LOG(RT_LOG_DEBUG, "Notify: count=%u, idx=%u, stream_id=%hu, task_id=%u, type=%u.",
            cnt, idx, report.streamId, taskIdVar, static_cast<uint32_t>(logicCqTypeVar));

        COND_PROC(TaskIdIsGEQ(taskIdVar, taskId), isFinished = true)
        ProIsSetNotified(taskId, taskIdVar, &isFinished); // rcv cq is not real cq
        if (isFinished) {
            StreamSyncTaskFinishReport();
            return;
        }
    }
}

rtError_t DirectHwtsEngine::SyncTask(Stream * const stm, const uint32_t taskId,
    const bool isStreamSync, int32_t timeout, bool isForce)
{
    uint32_t cqId = 0U;
    uint32_t execId = UINT32_MAX;
    bool isFastCq = false;
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    StreamSqCqManage * const stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());
    COND_RETURN_ERROR_MSG_INNER(stmSqCqManage == nullptr, RT_ERROR_INVALID_VALUE, "Get manage fail.");
    rtError_t error = stmSqCqManage->AllocLogicCq(streamId, stm->IsSteamNeedFastCq(), cqId, isFastCq);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Alloc logic cq failed.");
    COND_PROC((!isFastCq) && (!isStreamSync), SyncTaskQueryShm(streamId, taskId, cqId))

    bool isNotified = false;
    uint32_t abortTryCount = 0;
    int32_t rptTimeoutCnt = 0;
    Driver * const devDrv = device_->Driver_();
    rtLogicReport_t reportInfo = {};
    constexpr uint32_t allocCnt = 1U;
    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = device_->Id_();
    waitInfo.tsId = device_->DevGetTsId();
    waitInfo.cqId = cqId;
    waitInfo.isFastCq = isFastCq;
    waitInfo.timeout = waitTimeout_;
    waitInfo.streamId = streamId;
    waitInfo.taskId = taskId;

    COND_RETURN_INFO((isForce && (stm->GetPendingNum() == 0)), RT_ERROR_NONE,
        "finish: stream_id=%d, task_id=%u, cq_id=%u.", streamId, taskId, cqId);

    int32_t remainTime = timeout;
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
    rtError_t ctxStatus = RT_ERROR_NONE;
    while (!isNotified) {
        uint32_t cnt = 0U;
        rtLogicReport_t *logicReport = nullptr;
        int32_t irqWait = waitTimeout_;

        ctxStatus = stm->CheckContextStatus(false);
        Context * const ctx = stm->Context_();
        const bool isReturnNoError = (ctxStatus != RT_ERROR_NONE) && (ctx != nullptr) && (ctx->GetFailureError() != RT_ERROR_NONE);
        COND_RETURN_ERROR(isReturnNoError, RT_ERROR_NONE, "context is abort, status=%#x.", static_cast<uint32_t>(ctxStatus));
        COND_RETURN_ERROR(ctxStatus != RT_ERROR_NONE, ctxStatus, "context is abort, status=%#x.", static_cast<uint32_t>(ctxStatus));

        COND_PROC(remainTime > 0, (irqWait = (remainTime >= waitTimeout_) ?
            waitTimeout_ : remainTime));
        waitInfo.timeout = irqWait;

        logicReport = &reportInfo;
        error = devDrv->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *>(logicReport), allocCnt, cnt);
        if (isFastCq && (error == RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_INFO, "Task Wait: get fast cq interrupt, stream_id=%d, task_id=%u, cq_id=%u, retCode=%#x",
                streamId, taskId, cqId, error);
            ProcessFastCqTask(streamId, taskId);
            return error;
        }

        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV,
            error == RT_ERROR_DRV_IOCTRL, RT_ERROR_DRV_IOCTRL,
            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});,
            "Device[%u] Ioctrl fail.", device_->Id_());

        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV,
            error == RT_ERROR_LOST_HEARTBEAT, RT_ERROR_LOST_HEARTBEAT,
            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});,
            "Device[%u] lost heartbeat.", device_->Id_());

        if (unlikely((pendingNum_.Value() == 0U) && (error == RT_ERROR_REPORT_TIMEOUT) &&
            (stm->GetPendingNum() == 0))) {
            RT_LOG(RT_LOG_EVENT, "May recycle by other thread: stream_id=%u, task_id=%u, cqId=%u",
                streamId, taskId, cqId);
            return RT_ERROR_NONE;
        }
        if (timeout > 0) {
            mmTimespec endTimeSpec = mmGetTickCount();
            const uint64_t endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * RT_MS_PER_S +
                                    static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
            const uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
            const int32_t spendTime = static_cast<int32_t>(count);
            remainTime = timeout > spendTime ? (timeout - spendTime) : 0;
        }

        RT_LOG(RT_LOG_DEBUG, "Task Wait: sync task judge, timeout=%dms, remainTime=%dms, cnt=%u, irqWait=%dms.",
            timeout, remainTime, cnt, irqWait);

        if (stm->isDeviceSyncFlag && (stm->GetFailureMode() != ABORT_ON_FAILURE)) {
            COND_RETURN_WARN((timeout > 0) && (remainTime == 0) && (cnt == 0U), RT_ERROR_STREAM_SYNC_TIMEOUT,
                "Task Wait: sync task timeout! timeout=%dms, remainTime=%dms, cnt=%u.", timeout, remainTime, cnt);
        } else {
            COND_RETURN_ERROR((timeout > 0) && (remainTime == 0) && (cnt == 0U), RT_ERROR_STREAM_SYNC_TIMEOUT,
                "Task Wait: sync task timeout! timeout=%dms, remainTime=%dms, cnt=%u.", timeout, remainTime, cnt);
        }

        const bool abortFlag = (device_->GetIsRingbufferGetErr()) && (abortTryCount++ >= 3) && (ctx!=nullptr) && ctx->GetCtxMode() == STOP_ON_FAILURE && (stm != ctx->DefaultStream_());
        COND_RETURN_ERROR(abortFlag, RT_ERROR_NONE, "Task Wait:context is failure ABORT.");

        if (unlikely(((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) ||
                     (logicReport == nullptr) || (cnt == 0U))) {
            RT_LOG(RT_LOG_INFO, "Task Wait: stream_id=%d, task_id=%u, cqId=%u, retCode=%#x", streamId, taskId, cqId,
                   error);
            (void)QueryShmInfo(streamId, false, execId);
            ReportTimeoutProc(error, rptTimeoutCnt, streamId, taskId, execId, beginCnt);
            continue;
        }

        IsSyncFinish(taskId, cnt, logicReport);

        (void)QueryShmInfo(streamId, false, execId);

        for (uint32_t idx = 0U; idx < cnt; ++idx) {
            const rtLogicReport_t &report = logicReport[idx];
            const uint32_t taskIdVar = report.taskId;
            const uint8_t logicCqTypeVar = report.logicCqType;
            AtraceParams param = { GetDevice()->Id_(), static_cast<uint32_t>(report.streamId), report.taskId,
                GetCurrentTid(), GetDevice()->GetAtraceHandle(), {}};
            param.u.cqReportParams = { cqId, report.errorCode, report.logicCqType };
            AtraceSubmitLog(TYPE_CQ_REPORT, param);
            RT_LOG(RT_LOG_INFO, "Notify: count=%u, idx=%u, stream_id=%hu, task_id=%u, type=%u, retCode=%#x,"
                " payLoad=%#x, drvRetCode=%#x.",
                cnt, idx, report.streamId, taskIdVar, static_cast<uint32_t>(logicCqTypeVar),
                report.errorCode, report.payLoad, error);

            (void)ProcLogicReport(report, static_cast<uint32_t>(error), isStreamSync);
            COND_PROC((report.streamId != streamId),
                RT_LOG(RT_LOG_ERROR, "reportStmId=%hu waitStmId=%u, cqId=%u.",
                report.streamId, streamId, cqId); continue);
            COND_PROC(TaskIdIsGEQ(taskIdVar, taskId), isNotified = true)
            ProIsSetNotified(taskId, taskIdVar, &isNotified); // rcv cq is not real cq
        }
        COND_PROC(isFastCq, (void)devDrv->ReportRelease(device_->Id_(), device_->DevGetTsId(), cqId, DRV_LOGIC_TYPE))
    }

    return RT_ERROR_NONE;
}

rtError_t DirectHwtsEngine::QueryShmInfo(const uint32_t streamId, const bool limited, uint32_t &taskId)
{
    rtShmQuery_t shareMemInfo;
    const rtError_t error = shmCq_.QueryCqShm(streamId, shareMemInfo);
    if (unlikely(error != RT_ERROR_NONE)) {
        return error;
    }

    if (shareMemInfo.valid != SQ_SHARE_MEMORY_VALID) {
        taskId = UINT32_MAX;
        return RT_ERROR_NONE;
    }

    if (!HandleShmTask(streamId, limited, shareMemInfo)) {
        taskId = shareMemInfo.taskId;
        return RT_ERROR_NONE;
    }

    taskId = shareMemInfo.taskId;
    RecycleTask(streamId, shareMemInfo.taskId);
    return error;
}

rtError_t DirectHwtsEngine::TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId)
{
    if ((streamId != UINT32_MAX) &&
        (streamId != static_cast<uint32_t>(MAX_INT32_NUM))) { // filter out the RT_STREAM_FORBIDDEN_DEFAULT stream
        return QueryShmInfo(streamId, limited, taskId);
    }

    std::vector<uint32_t> allStreams;
    device_->GetStreamSqCqManage()->GetAllStreamId(allStreams);
    COND_PROC(allStreams.size() == 0, stmEmptyFlag_ = true);
    RT_LOG(RT_LOG_INFO, "Stream id not provide, travel all streams, num=%zu.", allStreams.size());
    for (const uint32_t streamLoop : allStreams) {
        const rtError_t error = QueryShmInfo(streamLoop, limited, taskId);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    }

    return RT_ERROR_NONE;
}

rtError_t DirectHwtsEngine::TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId)
{
    rtError_t error = RT_ERROR_NONE;
    std::vector<uint32_t> allStreams;
    device_->GetStreamSqCqManage()->GetAllStreamId(allStreams);
    COND_PROC(allStreams.size() == 0, stmEmptyFlag_ = true);
    RT_LOG(RT_LOG_INFO, "Stream id not provide, travel all streams, num=%zu.", allStreams.size());
    for (const uint32_t streamLoop : allStreams) {
        std::shared_ptr<Stream> stm = nullptr;
        error = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(static_cast<uint32_t>(streamLoop), stm);
        COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
            "Query stream failed, stream_id=%u, retCode=%#x.", streamLoop, static_cast<uint32_t>(error));
        stm->StreamSyncLock();
        error = QueryShmInfo(streamLoop, limited, taskId);
        stm->StreamSyncUnLock();
        stm.reset();
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    }
    return RT_ERROR_NONE;
}

rtError_t DirectHwtsEngine::TryRecycleTask(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    if ((device_->GetTschVersion() < static_cast<uint32_t>(TS_VERSION_SUPPORT_STREAM_TASK_FULL)) ||
        (!stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_TRY_RECYCLE_DISABLE_HWTS))) {
        return error;
    }

    const uint32_t lastTaskId = stm->GetLastTaskId();
    if ((lastTaskId % TASK_QUERY_INTERVAL_NUM) == 0U) {
        rtShmQuery_t shareMemInfo;
        error = shmCq_.QueryCqShm(static_cast<uint32_t>(stm->Id_()), shareMemInfo);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query Task status failed, retCode=%#x",
                                    static_cast<uint32_t>(error));
        const uint32_t taskIdVar = shareMemInfo.taskId;
        // device execute slowly
        if ((shareMemInfo.valid == SQ_SHARE_MEMORY_VALID) &&
            (TaskIdIsLT(TaskIdAdd(taskIdVar, static_cast<uint32_t>(TASK_WAIT_EXECUTE_MAX_NUM)), lastTaskId))) {
            uint32_t reclaimTaskId = 0U;
            stm->StreamSyncLock();
            TaskReclaimEx(static_cast<uint32_t>(stm->Id_()), true, reclaimTaskId, shareMemInfo);
            if (IsExeTaskSame(stm, reclaimTaskId)) {
                AtraceParams param = { stm->Device_()->Id_(), static_cast<uint32_t>(stm->Id_()), 0, GetCurrentTid(),
                    GetDevice()->GetAtraceHandle(), {}};
                param.u.taskRecycleParams = { stm->GetLastTaskId(), reclaimTaskId, TYPE_TRYRECYCLETASK };
                AtraceSubmitLog(TYPE_TASK_RECYCLE, param);
            }
            stm->StreamSyncUnLock();
        }
    }
    return error;
}

bool DirectHwtsEngine::ProcLogicReport(const rtLogicReport_t &logic, const uint32_t drvErr, const bool isStreamSync)
{
    Driver * const devDrv = device_->Driver_();
    const uint32_t devId = static_cast<uint32_t>(device_->Id_());
    const uint32_t tsId = static_cast<uint32_t>(device_->DevGetTsId());
    const uint8_t logicCqTypeVal = logic.logicCqType;
    // Primary stream destroy, exit thread.
    if (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_TERMINAL)) {
        RT_LOG(RT_LOG_INFO, "terminal notify, cq_id=%hu, device_id=%u, ts_id=%u.", logic.logicCqId, devId, tsId);
        return true;
    } else if (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_TSCH_VERSION)) {
        RT_LOG(RT_LOG_INFO, "get tsch version, tschVersion=%u, device_id=%u, ts_id=%u", logic.payLoad, devId, tsId);
        device_->SetTschVersion(logic.payLoad);
        return false;
    } else if (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_EVENT_DESTROY)) {
        const uint32_t payLoad = logic.payLoad;
        TaskInfo *task = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(logic.streamId), logic.taskId);
        const uint32_t flag = (task == nullptr) ? UINT32_MAX : task->u.maintenanceTaskInfo.mtIdType;
        RT_LOG(RT_LOG_INFO, "destroy event_id=%u, device_id=%u, ts_id=%u, flag=%u", payLoad, devId, tsId, flag);
        (void)devDrv->EventIdFree(static_cast<int32_t>(payLoad), device_->Id_(), device_->DevGetTsId(), flag);
        device_->FindAndEraseSyncEventMap(static_cast<uint16_t>(payLoad));
        return false;
    } else if (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_AICPU_ERR_MSG_REPORT)) {
        ProcAicpuErrMsgReport(logic);
        return false;
    } else {
        // no operation
    }

    rtTaskReport_t report = {};
    report.SOP         = logic.SOP;
    report.MOP         = logic.MOP;
    report.EOP         = logic.EOP;
    report.packageType = static_cast<uint16_t>(RT_PACKAGE_TYPE_TASK_REPORT);
    report.streamID    = logic.streamId;
    report.taskID      = logic.taskId;
    report.phase       = logic.phase;
    const uint16_t streamIdVar = logic.streamId;
    report.streamIDEx  =
        static_cast<uint16_t>(static_cast<uint32_t>(streamIdVar) >> static_cast<uint32_t>(RT_STREAM_ID_OFFSET));
    if (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_OVERFLOW_ERROR)) {
        RT_LOG(RT_LOG_INFO, "Overflow message received, cq_id=%hu, device_id=%u, ts_id=%u", logic.logicCqId, devId,
               tsId);
        report.payLoad = logic.errorCode;
        ProcessOverFlowReport(&report, logic.errorCode);
        return false;
    }
    if (!isStreamSync) {
        if (!UpdateTaskIdForTaskStatus(static_cast<uint32_t>(logic.streamId), logic.taskId)) {
            return false;
        }
    }

    if (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_TASK_ERROR)) {          // Task error
        report.payLoad = logic.errorCode;
    } else if ((logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_MODEL_ERROR)) ||
        (logicCqTypeVal == static_cast<uint8_t>(LOGIC_RPT_BLOCKING_OPERATOR))) {
        // Model error or blocking operator error.
        const uint32_t streamId = (logic.payLoad & 0x0000FFFFU);        // stream Id for model execute failed
        const uint32_t taskId   = (logic.payLoad & 0xFFFF0000U) >> 16U;  // task id for model execute failed
        report.payLoad = ((taskId & 0x000003FFU) << 22U) | ((streamId & 0x000003FFU) << 12U) |
            (logic.errorCode & 0x0FFFU);  // construct payload
        report.reserved = static_cast<uint8_t>((taskId & 0xFFFFFC00U) >> 10U);  // construct reserved
        report.faultStreamIDEx = static_cast<uint16_t>(streamId >> static_cast<uint32_t>(RT_STREAM_ID_OFFSET));
    } else {
        // no operation
    }
    return ProcessReport(&report, drvErr, isStreamSync);
}

void DirectHwtsEngine::MonitoringRun()
{
    const uint32_t tsId = device_->DevGetTsId();
    Driver * const devDrv = device_->Driver_();

    RT_LOG(RT_LOG_INFO, "Monitor thread enter: ts_id=%u, logicCqId=%u.", tsId, logicCqId_);
    Runtime::Instance()->MonitorNumAdd(1U);
    bool terminal = false;
    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = device_->Id_();
    waitInfo.tsId = tsId;
    waitInfo.cqId = logicCqId_;
    waitInfo.isFastCq = false;
    waitInfo.timeout = waitTimeout_;

    GlobalStateManager::GetInstance().IncBackgroundThreadCount(__func__);
    while ((!terminal) && (GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL)) &&
           monitorThreadRunFlag_ && Runtime::Instance()->GetThreadGuard()->GetMonitorStatus()) {
        GlobalStateManager::GetInstance().BackgroundThreadWaitIfLocked(__func__);
        uint32_t cnt = 0U;
        rtLogicReport_t *logicReport = nullptr;
        rtError_t error = RT_ERROR_NONE;
        uint16_t errorStreamId = 0xFFFFU;

        error = devDrv->LogicCqReport(waitInfo, logicReport, cnt);
        ReportSocketCloseProc();
        ReportOomQueryProc();

        const rtError_t ret = ReportHeartBreakProcV2();
        // return thread
        LOST_HEARTBEAT_PROC_RETURN(ret,
            std::to_string(device_->Id_()),
            Runtime::Instance()->MonitorNumSub(1U),
            GlobalStateManager::GetInstance().DecBackgroundThreadCount(__func__));
        // Read ringbuffer to obtain the device status
        const rtError_t result = device_->ReportRingBuffer(&errorStreamId); // 80/51 can't get errorStreamId.
        if (result == RT_ERROR_TASK_MONITOR) {
            Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);
            device_->SetIsRingbufferGetErr(true);
        }

        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_EVENT_POOL)) {
            device_->TryFreeAllEventPoolId();
        }
        Runtime::Instance()->TryToRecyclePool();
        if (unlikely(((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) ||
                     (logicReport == nullptr) || (cnt == 0U))) {
            continue;
        }
        for (uint32_t idx = 0U; idx < cnt; ++idx) {
            const rtLogicReport_t &report = logicReport[idx];
            const uint8_t logicCqType = report.logicCqType;
            AtraceParams param = { GetDevice()->Id_(), static_cast<uint32_t>(report.streamId), report.taskId,
                GetCurrentTid(), GetDevice()->GetAtraceHandle(), {}};
            param.u.cqReportParams = { logicCqId_, report.errorCode, report.logicCqType };
            AtraceSubmitLog(TYPE_CQ_REPORT, param);
            RT_LOG(RT_LOG_INFO, "Notify: count=%u, idx=%u, stream_id=%hu, task_id=%hu, type=%u, retCode=%#x, "
                "payLoad=%#x, ts_id=%u, retCode=%#x.", cnt, idx, report.streamId, report.taskId,
                static_cast<uint32_t>(logicCqType), report.errorCode, report.payLoad,
                tsId, static_cast<uint32_t>(error));

            if (ProcLogicReport(report, static_cast<uint32_t>(error), false)) {
                terminal = true;
            }
        }
        (void)devDrv->ReportRelease(device_->Id_(), tsId, logicCqId_, DRV_LOGIC_TYPE);
    }

    Runtime::Instance()->MonitorNumSub(1U);
    GlobalStateManager::GetInstance().DecBackgroundThreadCount(__func__);
    RT_LOG(RT_LOG_INFO, "Monitor thread leave: ts_id=%u, logicCqId=%u.", tsId, logicCqId_);
}

uint32_t DirectHwtsEngine::GetTaskIdFromStreamShmTaskId(const uint32_t streamId)
{
    return shmCq_.GetTaskIdFromStreamShmTaskId(streamId);
}

bool DirectHwtsEngine::CheckMonitorThreadAlive()
{
    if (monitorThread_ != nullptr) {
        return monitorThread_->IsAlive();
    }
    return false;
}

TIMESTAMP_EXTERN(HalfEventProc);
rtError_t DirectHwtsEngine::SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId)
{
    uint16_t taskId = 0U;
    bool isNeedStreamSync = false;
    int32_t timeout = -1; // -1:no limit
    Stream * const stm = workTask->stream;
    bool isForceCycle = false;
    if (workTask->type == TS_TASK_TYPE_CREATE_STREAM) {
        EraseTaskStatus(static_cast<size_t>(stm->Id_()));
    } else if (workTask->type == TS_TASK_TYPE_EVENT_RECORD) {
        if (workTask->u.eventRecordTaskInfo.waitCqflag) {
            isNeedStreamSync = true;
            timeout = workTask->u.eventRecordTaskInfo.timeout;
        }
    } else if (workTask->type == TS_TASK_TYPE_MAINTENANCE) {
        if ((workTask->u.maintenanceTaskInfo.mtType == static_cast<uint8_t>(MT_STREAM_DESTROY)) ||
            (workTask->u.maintenanceTaskInfo.mtType == static_cast<uint8_t>(MT_STREAM_RECYCLE_TASK))) {
            isNeedStreamSync = true;
        }
        if ((workTask->u.maintenanceTaskInfo.mtType == static_cast<uint8_t>(MT_STREAM_RECYCLE_TASK)) &&
            workTask->u.maintenanceTaskInfo.flag) {
            isForceCycle = true;
        }
    } else {
        // no operation
    }

    rtError_t error = SendTask(workTask, taskId, flipTaskId);
    if (error != RT_ERROR_NONE) {
        TaskFinished(stm->Device_()->Id_(), workTask);
        RT_LOG(RT_LOG_ERROR, "SendTask fail, streamId=%d, taskId=%hu, taskType=%u, "
                             "retCode=%#x.", stm->Id_(), workTask->id, workTask->type, error);
        return error;
    };

    if (!stm->IsCtrlStream()) {
        pendingNum_.Add(1U);
    }

    if (isNeedStreamSync) {
        if (stm->IsCtrlStream()) {
            // No need to profile and HalfEventProc for ctrl stream
            return (dynamic_cast<CtrlStream*>(stm))->Synchronize();
        }
        stm->StreamSyncLock();
        // isStreamSync para set true if need wait cq in unsink stream
        stm->SetStreamStopSyncFlag(false);
        error = SyncTask(stm, static_cast<uint32_t>(taskId), false, timeout, isForceCycle);
        stm->SetStreamStopSyncFlag(true);
        stm->StreamSyncUnLock();

        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = SendFlipTask(taskId, stm);
        return error;
    }

    error = SendFlipTask(taskId, stm);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    COND_RETURN_WITH_NOLOG(stm->IsTaskSink(), RT_ERROR_NONE);

    const uint32_t postTaskId = TaskIdAdd(static_cast<uint32_t>(taskId), 1U);
    if ((postTaskId % RT_HALF_SEND_TASK_NUM) != 0U) {    // Half Event.
        return RT_ERROR_NONE;
    }
    TIMESTAMP_BEGIN(HalfEventProc);
    TaskInfo *halfRecordtask = nullptr;
    error = stm->ProcRecordTask(halfRecordtask);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    TIMESTAMP_BEGIN(ObserverSubmitted);
    for (uint32_t i = 0U; i < observerNum_; ++i) {
        observers_[i]->TaskSubmited(device_, halfRecordtask);
    }
    TIMESTAMP_END(ObserverSubmitted);

    error = SendTask(halfRecordtask, taskId);
    if (error != RT_ERROR_NONE) {
        TaskFinished(stm->Device_()->Id_(), halfRecordtask);
        halfRecordtask->u.eventRecordTaskInfo.event->DeleteRecordResetFromMap(halfRecordtask);
        halfRecordtask->u.eventRecordTaskInfo.event->EventIdCountSub(halfRecordtask->u.eventRecordTaskInfo.eventid);
        (void)device_->GetTaskFactory()->Recycle(halfRecordtask);
    }
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "SendTask fail, streamId=%d, taskId=%hu, retCode=%#x",
        stm->Id_(), workTask->id, error);

    TIMESTAMP_END(HalfEventProc);

    if (!stm->IsCtrlStream()) {
        pendingNum_.Add(1U);
    }
    stm->SetStreamMark(halfRecordtask);
    error = SendFlipTask(taskId, stm);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    return RT_ERROR_NONE;
}

rtShmQuery_t *DirectHwtsEngine::TaskStatusAlloc(const uint32_t streamId)
{
    rtShmQuery_t * const shmInfo = new (std::nothrow) rtShmQuery_t;
    if (shmInfo == nullptr) {
        return nullptr;
    }

    (void)memset_s(shmInfo, sizeof(rtShmQuery_t), 0, sizeof(rtShmQuery_t));
    vecTaskStatus_[streamId] = shmInfo;

    return shmInfo;
}

void DirectHwtsEngine::TaskReclaimEx(const uint32_t streamId, const bool limited, uint32_t &taskId, rtShmQuery_t &shareMemInfo)
{
    if (shareMemInfo.valid != SQ_SHARE_MEMORY_VALID) {
        taskId = UINT32_MAX;
        return;
    }

    if (!HandleShmTask(streamId, limited, shareMemInfo)) {
        taskId = shareMemInfo.taskId;
        return;
    }

    taskId = shareMemInfo.taskId;
    RecycleTask(streamId, shareMemInfo.taskId);
    return;
}

bool DirectHwtsEngine::HandleShmTask(const uint32_t streamId, const bool limited, rtShmQuery_t &shareMemInfo)
{
    bool taskSuccess = true;
    const std::lock_guard<std::mutex> statusLock(statusMutex_);
    rtShmQuery_t *lastInfo = vecTaskStatus_[streamId];
    bool reportError = false;
    bool isProcessTask = false;

    if (lastInfo != nullptr) {
        const uint32_t lastTaskId = lastInfo->taskId;
        uint32_t taskIdInMem = shareMemInfo.taskId;
        const uint32_t taskIdInMem1 = shareMemInfo.taskId1;
        const uint32_t taskIdInMem2 = shareMemInfo.taskId2;
        const bool newErrCode1 = TaskIdIsGT(taskIdInMem1, lastTaskId) && (lastInfo->taskId1 != shareMemInfo.taskId1);
        const bool isNeedHandleFirstError =
            (shareMemInfo.firstErrorCode != static_cast<uint32_t>(RT_ERROR_NONE)) && newErrCode1;
        if (isNeedHandleFirstError) {
            RT_LOG(RT_LOG_INFO, "First errCode detected: stream_id=%u, task_id=%u, retCode=%#x",
                streamId, shareMemInfo.taskId1, shareMemInfo.firstErrorCode);
            lastInfo->taskId1 = shareMemInfo.taskId1;
            lastInfo->firstErrorCode = shareMemInfo.firstErrorCode;
            ReportLastError(streamId, shareMemInfo.taskId1, shareMemInfo.firstErrorCode, shareMemInfo.payLoad);
            reportError = true;
            isProcessTask = true;
        }
        const bool newErrCode2 = TaskIdIsGT(taskIdInMem2, lastTaskId) && (lastInfo->taskId2 != shareMemInfo.taskId2);
        const bool isNeedHandleLastError =
            (shareMemInfo.lastErrorCode != static_cast<uint32_t>(RT_ERROR_NONE)) && newErrCode2;
        if (isNeedHandleLastError) {
            // Set to stream and return for last error.
            RT_LOG(RT_LOG_INFO, "Last errCode detected: stream_id=%u, task_id=%u, retCode=%#x",
                streamId, shareMemInfo.taskId2, shareMemInfo.lastErrorCode);
            lastInfo->taskId2 = shareMemInfo.taskId2;
            lastInfo->lastErrorCode = shareMemInfo.lastErrorCode;
            const bool isNeedReportLastError = (!reportError) || TaskIdIsGT(taskIdInMem2, taskIdInMem1);
            if (isNeedReportLastError) {
                ReportLastError(streamId, shareMemInfo.taskId2, shareMemInfo.lastErrorCode, shareMemInfo.payLoad2);
                isProcessTask = true;
            }
            taskSuccess = false;
            // tsfw taskId write slowly, maybe not right.
            //he subsequent course of action should be to implement a radical treatment.
            if(shareMemInfo.taskId1 != shareMemInfo.taskId2){
                taskIdInMem = shareMemInfo.taskId2;
                shareMemInfo.taskId = shareMemInfo.taskId2;
            } 
        }
        if (isNeedHandleFirstError && !isNeedHandleLastError) {
            taskIdInMem = shareMemInfo.taskId1;
            shareMemInfo.taskId = shareMemInfo.taskId1;
        }

        if (TaskIdIsGEQ(lastTaskId, taskIdInMem)) {     // no new task.
            RT_LOG(RT_LOG_DEBUG, "handle share memory task, no new task. lastInfo: task_id=%u, shmInfo: task_id=%u.",
                lastInfo->taskId, shareMemInfo.taskId);
            return false;
        }

        const bool limitedInner = (taskSuccess && limited &&
                                  (TASK_ID_SUB(taskIdInMem, lastTaskId) > static_cast<uint32_t>(TASK_RECLAIM_MAX_NUM)));
        if (limitedInner) {
            shareMemInfo.taskId = TaskIdAdd(lastTaskId, static_cast<uint32_t>(TASK_RECLAIM_MAX_NUM));
        }
        lastInfo->taskId = shareMemInfo.taskId;
    } else {
        if (shareMemInfo.firstErrorCode != static_cast<uint32_t>(RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_INFO, "First errCode detected: stream_id=%u, task_id=%u, retCode=%#x.",
                streamId, shareMemInfo.taskId1, shareMemInfo.firstErrorCode);
            ReportLastError(streamId, shareMemInfo.taskId1, shareMemInfo.firstErrorCode, shareMemInfo.payLoad);
            reportError = true;
            isProcessTask = true;
        }

        if (shareMemInfo.lastErrorCode != static_cast<uint32_t>(RT_ERROR_NONE)) {
            // Set to stream and return for last error.
            RT_LOG(RT_LOG_INFO, "Last errCode detected: stream_id=%u, task_id=%u, retCode=%#x.",
                streamId, shareMemInfo.taskId2, shareMemInfo.lastErrorCode);
            const bool isNeedReportLastError = (!reportError) || TaskIdIsGT(shareMemInfo.taskId2, shareMemInfo.taskId1);
            if (isNeedReportLastError) {
                ReportLastError(streamId, shareMemInfo.taskId2, shareMemInfo.lastErrorCode, shareMemInfo.payLoad2);
                isProcessTask = true;
            }
            taskSuccess = false;
        }

        const bool limitedInner = (taskSuccess && limited && (shareMemInfo.taskId > TASK_RECLAIM_MAX_NUM));
        if (limitedInner) {
            shareMemInfo.taskId = TASK_RECLAIM_MAX_NUM;
        }

        rtShmQuery_t * const shmInfo = new (std::nothrow) rtShmQuery_t;
        if (shmInfo == nullptr) {
            RT_LOG(RT_LOG_INFO, "struct ShmQuery <new> exception, stream_id=%u.", streamId);
            return false;
        }
        shmInfo->taskId = shareMemInfo.taskId;
        shmInfo->firstErrorCode = shareMemInfo.firstErrorCode;
        shmInfo->taskId1 = shareMemInfo.taskId1;
        shmInfo->lastErrorCode = shareMemInfo.lastErrorCode;
        shmInfo->taskId2 = shareMemInfo.taskId2;
        shmInfo->payLoad = shareMemInfo.payLoad;
        shmInfo->payLoad2 = shareMemInfo.payLoad2;
        shmInfo->valid = shareMemInfo.valid;

        vecTaskStatus_[streamId] = shmInfo;
    }
    const uint32_t taskIdVar = shareMemInfo.taskId;
    const uint32_t taskId2Var = shareMemInfo.taskId2;
    if (isProcessTask) {
        return true;
    }
    if ((!taskSuccess) && TaskIdIsLEQ(taskIdVar, taskId2Var)) {
        return false;
    }

    return true;
}

bool DirectHwtsEngine::UpdateTaskIdForTaskStatus(const uint32_t streamId, const uint16_t taskId)
{
    TaskFactory * const taskGenerator = device_->GetTaskFactory();
    if (taskGenerator == nullptr) {
        return false;
    }

    TaskInfo * const reportTask = taskGenerator->GetTask(static_cast<int32_t>(streamId), taskId);
    if (reportTask == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Get null task, is already recycle. device_id=%u, stream_id=%u, task_id=%hu",
            device_->Id_(), streamId, taskId);
        return false;
    }

    const std::lock_guard<std::mutex> statusLock(statusMutex_);
    rtShmQuery_t *shmInfo = vecTaskStatus_[static_cast<size_t>(streamId)];
    if (shmInfo != nullptr) {
        RT_LOG(RT_LOG_DEBUG, "UpdateTaskIdForTaskStatus, stream_id=%u, task_id=%hu, last_task_id=%u.",
            streamId, taskId, shmInfo->taskId);
        const uint32_t lastTaskId = shmInfo->taskId;
        const uint32_t logicTaskId = static_cast<uint32_t>(taskId);
        if (TaskIdIsGEQ(lastTaskId, logicTaskId)) {    // already finished.
            return false;
        }
    } else {
        shmInfo = TaskStatusAlloc(streamId);
        if (shmInfo == nullptr) {
            RT_LOG(RT_LOG_DEBUG, "new shmInfo memory fail, stream_id=%u", streamId);
            return false;
        }
    }
    shmInfo->taskId = static_cast<uint32_t>(taskId);

    return true;
}

void DirectHwtsEngine::EraseTaskStatus(const size_t streamId)
{
    const std::lock_guard<std::mutex> statusLock(statusMutex_);
    rtShmQuery_t *shmInfo = vecTaskStatus_[streamId];
    if (shmInfo != nullptr) {
        delete shmInfo;
        vecTaskStatus_[streamId] = nullptr;
    }
    return;
}

void DirectHwtsEngine::ProcAicpuErrMsgReport(const rtLogicReport_t &logic) const
{
    TrySaveAtraceLogs(device_->GetAtraceEventHandle());
    rtExceptionInfo exceptionInfo;
    rtError_t rtErrCode = RT_ERROR_NONE;
    const char_t * const retDes = GetTsErrCodeMap(static_cast<uint32_t>(TS_ERROR_AICPU_EXCEPTION), &rtErrCode);

    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(rtErrCode));
    exceptionInfo.streamid = logic.streamId;
    exceptionInfo.taskid = logic.taskId;
    exceptionInfo.tid = static_cast<uint32_t>(PidTidFetcher::GetCurrentUserTid());
    exceptionInfo.deviceid = device_->Id_();
    (void)memset_s(&(exceptionInfo.expandInfo), sizeof(exceptionInfo.expandInfo),
                   0, sizeof(exceptionInfo.expandInfo));
    // add for helper error aic or aiv
    const std::string kernelNameStr = GetKernelNameForAiCoreorAiv(exceptionInfo.streamid, exceptionInfo.taskid);
    RT_LOG_INNER_MSG(RT_LOG_ERROR, "aicpu model retCode=%#x,[%s], task_id=%u, stream_id=%u, kernel_name=%s.",
                     static_cast<uint32_t>(rtErrCode), retDes, exceptionInfo.taskid, exceptionInfo.streamid,
                     kernelNameStr.c_str());

    TaskFailCallBackNotify(&exceptionInfo);
    return;
}

std::string DirectHwtsEngine::GetKernelNameForAiCoreorAiv(const uint32_t streamId, const uint32_t taskId) const
{
    TaskInfo * const workTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId),
                                                                   static_cast<uint16_t>(taskId));
    if (workTask == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can't find task from factory, stream_id=%u, task_id=%u.", streamId, taskId);
        return "unknown";
    }

    std::string kernelNameStr;
    AicTaskInfo * const kernelTask = &(workTask->u.aicTaskInfo);
    if ((kernelTask != nullptr) && (kernelTask->kernel != nullptr)) {
        kernelNameStr = kernelTask->kernel->Name_();
    }

    return kernelNameStr.empty() ? ("unknown") : kernelNameStr;
}

void DirectHwtsEngine::ReportLastError(const uint32_t streamId, const uint32_t taskId,
                             const uint32_t errorCode, const uint32_t errorDesc)
{
    TaskInfo * const reportTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId),
        static_cast<uint16_t>(taskId));
    if (unlikely(reportTask == nullptr)) {  // Released already.
        RT_LOG(RT_LOG_WARNING, "Get null task from stream_id=%d, task_id=%u", streamId, taskId);
        return;
    }

    reportTask->stream->SetStreamAsyncRecycleFlag(false);

    uint32_t faultStreamId = streamId;
    uint32_t faultTaskId = taskId;
    if (reportTask->type == TS_TASK_TYPE_MODEL_EXECUTE) {
        faultStreamId = (errorDesc & 0x0000FFFFU);     // stream Id for model execute failed
        faultTaskId = (errorDesc & 0xFFFF0000U) >> 16U; // task id for model execute failed
    }

    uint8_t package[M_PROF_PACKAGE_LEN] = {0U};
    uint32_t &payLoad = RtPtrToPtr<uint32_t *>(package)[0];
    uint32_t &faultTaskIdHigh = RtPtrToPtr<uint32_t *>(package)[1];
    uint32_t &faultStreamIdEx = RtPtrToPtr<uint32_t *>(package)[2];
    payLoad = ((faultTaskId & 0x000003FFU) << 22U) | ((faultStreamId & 0x000003FFU) << 12U) |
        (errorCode & 0x00000FFFU);  // construct payload
    faultTaskIdHigh = faultTaskId >> static_cast<uint32_t>(RT_TASK_ID_OFFSET);
    faultStreamIdEx = faultStreamId >> static_cast<uint32_t>(RT_STREAM_ID_OFFSET);
    reportTask->error = 0U;
    SetResult(reportTask, package, static_cast<uint32_t>(M_PROF_PACKAGE_LEN));
    ShowTaskResult(reportTask, device_->Id_());

    ReportExceptProc(reportTask, errorCode & RT_GET_ERR_CODE, errorDesc);
}

bool DirectHwtsEngine::ProcessReport(const rtTaskReport_t * const report,
    const uint32_t drvErr, const bool isStreamSync)
{
    const uint16_t streamId = static_cast<uint16_t>(static_cast<uint32_t>(report->streamID) |
                        (static_cast<uint32_t>(report->streamIDEx) << static_cast<uint32_t>(RT_STREAM_ID_OFFSET)));
    TaskFactory * const taskGenerator = device_->GetTaskFactory();
    if (taskGenerator == nullptr) {
        return false;
    }
    // from loop body of ReceivingRun.
    TaskInfo * const reportTask = taskGenerator->GetTask(static_cast<int32_t>(streamId), report->taskID);
    RT_LOG(RT_LOG_INFO, "report receive, stream_id=%hu, task_id=%hu, drvErr=%u.", streamId, report->taskID, drvErr);

    reportCount_++;
    if (likely(reportTask != nullptr)) {
        RT_LOG(RT_LOG_DEBUG, "RTS_DRIVER: report receive, device_id=%u, ts_id=%u, stream_id=%hu, task_id=%hu, "
            "task_type=%d(%s)", device_->Id_(), device_->DevGetTsId(), streamId, report->taskID,
            static_cast<int32_t>(reportTask->type), reportTask->typeName);
        parseTaskCount_++;
        if (unlikely(reportCount_ != parseTaskCount_)) {
            RT_LOG(RT_LOG_WARNING, "parse task from report stream_id=%hu task_id=%hu, "
                "task_type=%d(%s), report_count=%" PRIu64 " parse_task_count=%" PRIu64 " failed",
                streamId, reportTask->id, static_cast<int32_t>(reportTask->type), reportTask->typeName,
                reportCount_, parseTaskCount_);
        }

        reportTask->drvErr = drvErr;
        reportTask->error = 0U;
        TIMESTAMP_BEGIN(ReportReceive);
        ReportReceive(report, reportTask);
        TIMESTAMP_END(ReportReceive);

        if (likely(CheckPackageState(reportTask))) {
            if (isStreamSync) {
                return PreProcessTask(reportTask, device_->Id_());
            } else {
                return ProcessTask(reportTask, device_->Id_());
            }
        }
    } else {  // parse task NULL
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get null task from report stream_id=%hu, task_id=%hu",
                         streamId, report->taskID);
    }

    return false;
}

bool DirectHwtsEngine::PreProcessTask(TaskInfo *preTask, const uint32_t deviceId)
{
    const uint16_t endTaskId = static_cast<uint16_t>(preTask->id);
    uint16_t preRecycleTaskId = 0U;
    Stream * const stm = preTask->stream;
    const int32_t streamId = static_cast<int32_t>(stm->Id_());
    const auto threadDisableFlag = Runtime::Instance()->GetDisableThread();
    const Profiler * const preProfiler = Runtime::Instance()->Profiler_();
    if (preTask->bindFlag || (!threadDisableFlag)) {
        return false;
    }
    do {
        const rtError_t error = stm->GetRecycleTaskHeadId(endTaskId, preRecycleTaskId);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Delete task failed,stream_id=%d,tail_task_id=%hu,"
                "del_task_id=%hu,retCode=%#x.", streamId, endTaskId, preRecycleTaskId, error);
            return false;
        }

        preTask = device_->GetTaskFactory()->GetTask(streamId, preRecycleTaskId);
        if (preTask == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Can't find task from factory,stream_id=%d,task_id=%hu.",
                streamId, preRecycleTaskId);
            return false;
        }

        preTask->error = 0U;
        if (preProfiler != nullptr) {
            preProfiler->ReportReceivingRun(preTask, deviceId);
        }

        TIMESTAMP_BEGIN(ObserverFinished);
        TaskFinished(deviceId, preTask);
        TIMESTAMP_END(ObserverFinished);

        if (preTask->type == TS_TASK_TYPE_MEMCPY) {
            RecycleTaskResourceForMemcpyAsyncTask(preTask);
        }
        preTask->preRecycleFlag = true;
    } while (preRecycleTaskId != endTaskId);

    RT_LOG(RT_LOG_INFO, "PreProcessTask.");
    return true;
}
}  // namespace runtime
}  // namespace cce
