/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_david.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "rt_stars_define.h"
#include "context.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "device/device_error_proc.hpp"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "context.hpp"
#include "tsch_defines.h"
#include "profiler.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "hwts.hpp"
#include "device.hpp"
#include "davinci_kernel_task.h"
#include "task_recycle.hpp"
#include "engine.hpp"
#include "task_res_da.hpp"

namespace cce {
namespace runtime {

// =================================================== static 函数区 ======================================== //
static void ReportTimeoutProc(const rtError_t error, int32_t &timeoutCnt, Stream * const stm,
    const uint32_t taskResPos, bool &isFinished)
{
    if (error != RT_ERROR_REPORT_TIMEOUT) {
        timeoutCnt = 0;
        return;
    }

    if (error == RT_ERROR_REPORT_TIMEOUT) {
        (void)stm->JudgeTaskFinish(taskResPos, isFinished);
    }

    timeoutCnt++;
    if (timeoutCnt >= Runtime::macroValue_.maxReportTimeoutCnt) {
        timeoutCnt = 0;
        const mmTimespec curTimeSpec = mmGetTickCount();
        RT_LOG(RT_LOG_EVENT, "report timeout! streamId=%u, pos=%u, curSec=%llu.",
            stm->Id_(), taskResPos,
            ((static_cast<uint64_t>(curTimeSpec.tv_sec) * RT_MS_PER_S) +
             (static_cast<uint64_t>(curTimeSpec.tv_nsec) / RT_MS_TO_NS)));
        if (Runtime::Instance()->excptCallBack_ != nullptr) {
            Runtime::Instance()->excptCallBack_(RT_EXCEPTION_TASK_TIMEOUT);
        } else {
            RT_LOG(RT_LOG_INFO, "excptCallBack_ is null.");
        }
    }
}

static void StreamSyncTaskFinishReport(void)
{
    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        profilerPtr->ReportStreamSynctaskFinish(RT_PROF_API_STREAM_SYNC_TASK_FINISH);
    }
}

static void IsSyncTaskFinish(const Stream * const stm, const uint32_t cqePos)
{
    uint16_t sqHead = 0U;
    const rtError_t error = GetDrvSqHead(stm, sqHead);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetDrvSqHead failed, retCode=%#x.", error);
        return;
    }
    const uint16_t pos = (sqHead == 0U) ? (stm->GetSqDepth() - 1U) : (sqHead - 1U);
    if (cqePos == pos) {
        RT_LOG(RT_LOG_INFO, "Sync task finished, sqHead=%hu pos=%u cqePos=%u.", sqHead, pos, cqePos);
        StreamSyncTaskFinishReport();
    }
}

// =================================================== static 函数区 ======================================== //

// ================================================== 对外出口区 ======================================== //
static rtError_t SyncTaskEarlyBreak(const Stream * const stm, bool &breakFlag)
{
    rtError_t error = RT_ERROR_NONE;
    Device *dev = stm->Device_();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    COND_PROC_RETURN_ERROR(stm->GetFailureMode() == ABORT_ON_FAILURE, RT_ERROR_NONE,
        (void)FinishedTaskReclaim(stm, false, (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskPosHead(),
        (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskPosTail()),
        "stream is in failure abort and need to reclaim all, device_id=%u, stream_id=%u.", dev->Id_(), streamId);  
    error = stm->CheckContextStatus(false);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error));

    COND_RETURN_ERROR((stm->GetAbortStatus() == RT_ERROR_STREAM_ABORT),
                        RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL,
                        "stream is in stream abort status, sync task fail, device_id=%u, stream_id=%d",
                        dev->Id_(),
                        streamId);
    
    breakFlag = false;
    return RT_ERROR_NONE;
}

static rtError_t SyncTaskProcCqReport(Stream * const stm, const uint32_t taskResPos, int32_t timeout, uint64_t beginCnt,
    int32_t &remainTime, int32_t &rptTimeoutCnt, bool &isFinished)
{
    Device *dev = stm->Device_();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    Driver * const devDrv = dev->Driver_();
    uint32_t cnt = 0U;
    rtLogicCqReport_t logicReport = {};
    int32_t irqWait = RT_REPORT_TIMEOUT_TIME; // default 5000ms
    if (unlikely(remainTime > 0)) {
        irqWait = remainTime >= RT_REPORT_TIMEOUT_TIME ? RT_REPORT_TIMEOUT_TIME : remainTime;
    }
    LogicCqWaitInfo cqWaitInfo = {};
    cqWaitInfo.isFastCq = false;
    cqWaitInfo.devId = dev->Id_();
    cqWaitInfo.tsId = dev->DevGetTsId();
    cqWaitInfo.cqId = stm->GetLogicalCqId();
    cqWaitInfo.streamId = streamId;         // for camodel
    cqWaitInfo.taskId = MAX_UINT32_NUM;
    cqWaitInfo.timeout = irqWait;
    const rtError_t error =
        devDrv->LogicCqReportV2(cqWaitInfo, reinterpret_cast<uint8_t *>(&logicReport), 1U, cnt);
    ReportTimeoutProc(error, rptTimeoutCnt, stm, taskResPos, isFinished);
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
    COND_RETURN_WARN((timeout > 0) && (remainTime == 0) && (cnt == 0U) && (!isFinished), RT_ERROR_STREAM_SYNC_TIMEOUT,
        "Task Wait: sync task timeout! timeout=%dms, remainTime=%dms, cnt=%u.", timeout, remainTime, cnt);

    if (((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) || (cnt == 0U)) {
        // get sqHead to process finish task when can not get logic CQ report
        (void)RecycleTaskBySqHead(stm);
        RT_LOG(RT_LOG_INFO, "No logic report: stream_id=%d, pos=%u, logicCqId=%u, ret=%#x.",
            streamId, taskResPos, stm->GetLogicalCqId(), static_cast<uint32_t>(error));
    }
    COND_RETURN_ERROR(
        ((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE) && (error != RT_ERROR_REPORT_TIMEOUT)),
        error, "Task Wait: error=%u.", error);

    IsSyncTaskFinish(stm, taskResPos);
    // proccess logic cq report
    isFinished = (stm->isForceRecycle_ && (error == RT_ERROR_REPORT_TIMEOUT)) ? true : isFinished;
    (void)ProcReport(dev, streamId, taskResPos, cnt, &logicReport, isFinished);
    (void)RecycleTaskBySqHead(stm);
    COND_RETURN_WARN((stm->isForceRecycle_) && (error == RT_ERROR_REPORT_TIMEOUT) && (isFinished), RT_ERROR_NONE,
        "The stream %d is forcibly reclaimed. Resources may not be completely reclaimed.", stm->Id_());
    return RT_ERROR_NONE;
}

rtError_t SyncTaskForSeparateSendAndRecycle(Stream * const stm, const uint32_t taskResPos, int32_t timeout)
{
    Device *dev = stm->Device_();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    Driver * const devDrv = dev->Driver_();
    COND_RETURN_ERROR((devDrv == nullptr), RT_ERROR_NONE,
        "dev drv is null, device_id=%u, stream_id=%u.", dev->Id_(), streamId);
    COND_RETURN_ERROR_MSG_INNER(
        (dev->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT), RT_ERROR_DEVICE_TASK_ABORT,
        "Device is in abort status.");
    RT_LOG(RT_LOG_INFO, "device_id=%d, stream_id=%d, taskResPos=%u timeout=%u.",
           stm->Device_()->Id_(), stm->Id_(), taskResPos, timeout);

    rtError_t error;
    error = stm->SynchronizeImpl(taskResPos, taskResPos, timeout);
    COND_PROC((error == RT_ERROR_STREAM_ABORT), return RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL);
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL);
    // ctx error, task already submit, return success.
    Context * const ctx = stm->Context_();
    const bool isReturnNoError = (error != RT_ERROR_NONE) && (ctx != nullptr) && (ctx->GetFailureError() != RT_ERROR_NONE); 
    return isReturnNoError ? RT_ERROR_NONE : error;
}

rtError_t SyncTask(Stream * const stm, const uint32_t taskResPos, int32_t timeout)
{
    if (stm->IsSeparateSendAndRecycle()) {
        return SyncTaskForSeparateSendAndRecycle(stm, taskResPos, timeout);
    }

    Device *dev = stm->Device_();
    const uint32_t logicCqId = stm->GetLogicalCqId();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    Driver * const devDrv = dev->Driver_();
    COND_RETURN_ERROR((devDrv == nullptr), RT_ERROR_NONE,
        "dev drv is null, device_id=%u, stream_id=%u.", dev->Id_(), streamId);
    COND_RETURN_ERROR_MSG_INNER(
        (dev->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT), RT_ERROR_DEVICE_TASK_ABORT,
        "stream is in device task abort status, sync task fail, device_id=%u, stream_id=%d",
        dev->Id_(), streamId);
    COND_RETURN_ERROR((stm->GetAbortStatus() == RT_ERROR_STREAM_ABORT), RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL,
        "stream is in stream abort status, sync task fail, device_id=%u, stream_id=%d",
        dev->Id_(), streamId);
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = ((static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S) +
                               (static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS));

    RT_LOG(RT_LOG_INFO, "Task Wait: device_id=%u, stream_id=%u, taskResPos=%u, logicCqId=%u.",
        dev->Id_(), streamId, taskResPos, logicCqId);

    rtError_t error = RT_ERROR_NONE;
    bool isFinished = false;
    int32_t rptTimeoutCnt = 0;
    int32_t remainTime = timeout;
    while (!isFinished) {
        bool breakFlag = true;
        error = SyncTaskEarlyBreak(stm, breakFlag);
        COND_RETURN_WITH_NOLOG(breakFlag, error);

        error = SyncTaskProcCqReport(stm, taskResPos, timeout, beginCnt, remainTime, rptTimeoutCnt, isFinished);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return RT_ERROR_NONE;
}
// ================================================== 对外出口区 ======================================== //

}  // namespace runtime
}  // namespace cce