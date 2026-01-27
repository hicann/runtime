/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_xpu.hpp"
#include "stream_sqcq_manage.hpp"
#include "context.hpp"
#include "device.hpp"
#include "davinci_kernel_task.h"
#include "task_info.h"
#include "task_xpu_recycle.hpp"
#include "task_manager_xpu.hpp"
#include "task_res_da.hpp"
#include "xpu_driver.hpp"

namespace cce {
namespace runtime {

// =================================================== static 函数区 ======================================== //
static const std::vector<std::string> TprtCqeErrorDesc_ = {
    "task exception",
    "task timeout",
};

static rtError_t XpuGetDrvSqHead(const Stream * const stm, uint16_t &sqHead, bool needLog)
{
    Device * const dev = stm->Device_();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t tsId = dev->DevGetTsId();
    const rtError_t error = dev->Driver_()->GetSqHead(dev->Id_(), tsId, sqId, sqHead, needLog);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    if (needLog) {
        RT_LOG(RT_LOG_DEBUG, "deviceId=%u, sq_id=%u, sqHead=%hu.", dev->Id_(), sqId, sqHead);
    }
    TaskResManageDavid *taskManager = dynamic_cast<TaskResManageDavid *>(stm->taskResMang_);
    COND_RETURN_ERROR_MSG_INNER(taskManager == nullptr, RT_ERROR_STREAM_INVALID, 
        "stream_id=%d does not have task manager", stm->Id_());

    const bool valid = taskManager->IsRecyclePosValid(sqHead);
    if (!valid) {
        RT_LOG(RT_LOG_WARNING, "drv sqHead is invalid, device_id=%u, sq_id=%u, sqHead=%hu.",
            dev->Id_(), sqId, sqHead);
        return RT_ERROR_DRV_ERR;
    }
    return RT_ERROR_NONE;
}

static bool TprtGetPublicTask(Stream * const stm, const uint16_t endTaskSqPos, uint16_t &delPos,
    TaskInfo **workTask, bool &earlyBreakFlag)
{
    rtError_t err = RT_ERROR_NONE;
    const uint32_t streamId = stm->Id_();
    err = stm->StarsGetPublicTaskHead(nullptr, false, endTaskSqPos, &delPos);
    if (err != RT_ERROR_NONE) {
        // 当异常只有：1、空队列  2、已经取到最大值时，都是正常情况，不需要做异常处理
        RT_LOG(RT_LOG_INFO, "proc public task, stream_id=%u, endTaskSqPos=%hu, delPos=%hu, retCode=%#x.",
            streamId, endTaskSqPos, delPos, err);
        if (err == RT_ERROR_INVALID_VALUE) {
            earlyBreakFlag = true;
        }
        return true;
    }
    TaskInfo *delWorkTask =
        (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskInfo(static_cast<uint32_t>(delPos));
    if (unlikely(delWorkTask == nullptr)) {
        // maybe random order occurred
        RT_LOG(RT_LOG_ERROR, "workTask is not valid, stream_id=%u, isHasArgPool_=%d, delPos=%u, endTaskSqPos=%hu.",
            streamId, static_cast<XpuStream *>(stm)->GetIsHasArgPool(),  static_cast<uint32_t>(delPos), endTaskSqPos);
        // 先不更新public  break 之后，这个任务就再也无法回收，后面会卡住，便于定位
        earlyBreakFlag = true;
        return true;
    }

    err = stm->DavidUpdatePublicQueue();
    if (unlikely(err != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_WARNING, "Delete public member failed, stream_id=%u, endTaskSqPos=%hu, delPos=%hu, retCode=%#x.",
            streamId, endTaskSqPos, delPos, err);
        earlyBreakFlag = true;
        return true;
    }
    *workTask = delWorkTask;
    return false;
}

// only proc non model task
static void TprtTryReclaimToTask(TaskInfo *workTask)
{
    Stream * const stm = workTask->stream;
    const uint16_t endTaskSqPos = workTask->id;
    uint16_t delPos = 0U;
    TaskInfo *delWorkTask = nullptr;
    bool earlyBreakFlag = false;
    do {
        const bool breakFlag = TprtGetPublicTask(stm, endTaskSqPos, delPos, &delWorkTask, earlyBreakFlag);
        if (breakFlag) {
            break;
        }

        // docomplete + taskRes等资源的回收  非davinci的其他需要回收的任务，在此回收处理
        XpuTaskUnInitProc(delWorkTask);
    } while (delPos != endTaskSqPos);

    // batch recycle
    if (!earlyBreakFlag) {
        delWorkTask = workTask;
    }

    if (delWorkTask != nullptr) {
        RtPtrToPtr<XpuStream *>(stm)->SetRecycleFinishTaskId(delWorkTask->taskSn);
        XpuStream *xpuStm = static_cast<XpuStream *>(stm);
        if (xpuStm->GetIsHasArgPool()) {
            xpuStm->ArgReleaseStmPool(delWorkTask);
        }
        (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->RecycleTaskInfo(static_cast<uint32_t>(delWorkTask->id),
            delWorkTask->sqeNum);
    }
    RT_LOG(RT_LOG_DEBUG, "stream_id=%d, delPos=%hu.", stm->Id_(), delPos);
    return;
}

/**
 * curPos: Pos of the taskRes Head, which to be reclaimed.
 * tarPos: Pos of the rtsq Head, which to be reclaimed.
 * finishPos: return the pos of the taskRes actually reclaimed.
*/
static rtError_t XpuFinishedTaskReclaim(const Stream * const stm, const uint16_t curPos,
    const uint16_t tarPos)
{
    const rtError_t ret = RT_ERROR_NONE;
    if (curPos == tarPos) {     // no new task.
        return ret;
    }
    uint16_t recycleHead = tarPos;

    const uint32_t pos = (recycleHead == 0U) ? (stm->GetSqDepth() - 1U) : (recycleHead - 1U);
    TaskInfo * const workTask = (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskInfo(pos);
    if (workTask == nullptr) {  // Released already.
        RT_LOG(RT_LOG_WARNING, "Get null task from stream_id=%u, pos=%u.", stm->Id_(), pos);
        return ret;
    }

    if (stm->Id_() != workTask->stream->Id_()) {
        RT_LOG(RT_LOG_WARNING, "stream id:%d and task stream id: %d not equal.",
            stm->Id_(), workTask->stream->Id_());
    }
    const tsTaskType_t taskType = workTask->type;
    TprtTryReclaimToTask(workTask);

    RT_LOG(RT_LOG_INFO, "recycle task, stream_id=%d, curPos=%hu, tarPos=%hu, recycleHead=%hu,"
        " task_type=%u(%s), taskSn=%u.", stm->Id_(), curPos, tarPos, recycleHead,
        static_cast<uint32_t>(taskType), workTask->typeName, workTask->taskSn);
    return ret;
}

static void XpuProcCqReportException(const Device * const dev, const TprtLogicCqReport_t &logicCq,
    const TaskInfo * const reportTask, const uint16_t streamId)
{
    (void)dev;
    (void)reportTask;
    const uint16_t pos = logicCq.sqHead;
    const uint8_t errType = logicCq.errorType;
    const uint32_t errBit = (errType == 0U) ? UINT32_BIT_NUM : static_cast<uint32_t>(CTZ(errType));
    std::string errMsg = errBit < TprtCqeErrorDesc_.size() ? TprtCqeErrorDesc_[errBit] : "unknow";
    if (static_cast<uint8_t>(logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        return;
    }
    RT_LOG(RT_LOG_ERROR, "Task run failed, stream_id=%hu, pos=%hu, task_sn=%u, sqe_type=%u(%s), "
        "errType=%#x(%s), errorCode=%#x.", streamId, pos, logicCq.taskSn,
        static_cast<uint32_t>(logicCq.sqeType), GetXpuSqeDescByType(logicCq.sqeType),
        logicCq.errorType, errMsg.c_str(), logicCq.errorCode);
}

static void XpuStarsCqeReceive(const Device * const dev, const TprtLogicCqReport_t &logicCq, TaskInfo * const runTask)
{
    runTask->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage++;
    XpuSetStarsResult(runTask, logicCq);
    XpuComplete(runTask, dev->Id_());
}

static void XpuProcLogicCqReport(Device * const dev, const TprtLogicCqReport_t &logicCq, TaskInfo * reportTask)
{
    const uint16_t streamId = reportTask->stream->Id_();
    const uint16_t pos = logicCq.sqHead;
    const uint16_t sqId = logicCq.sqId;

    XpuProcCqReportException(dev, logicCq, reportTask, streamId);
    const tsTaskType_t taskType = reportTask->type;
    RT_LOG(RT_LOG_DEBUG, "xpu: report receive, stream_id=%hu, pos=%hu, sq_id=%hu, sq_head=%hu, "
        "task_type=%hu(%s).",
        streamId, pos, sqId, logicCq.sqHead, static_cast<uint16_t>(taskType), reportTask->typeName);

    reportTask->error = 0U;
    XpuStarsCqeReceive(dev, logicCq, reportTask);
    return;
}

static rtError_t XpuStarsResumeSq(const TprtLogicCqReport_t *logicCq, const TaskInfo * const taskInfo)
{
    // No error exists.
    if ((logicCq->errorType & RT_STARS_EXIST_ERROR) == 0U) {
        return RT_ERROR_NONE;
    }
    rtError_t error = RT_ERROR_NONE;
    Stream * const failStm = taskInfo->stream;
    uint32_t queryCnt = 0U;
    uint32_t cnt = 0U;
    uint32_t status;
    XpuDriver *devDrv = static_cast<XpuDriver *>(taskInfo->stream->Device_()->Driver_());
    failStm->EnterFailureAbort();
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
    const int32_t getSqTimeout = RT_GET_SQ_STATUS_TIMEOUT_TIME;
    while (true) {
        if ((cnt++ % RT_GET_HEAD_CYCLE_NUM) == 0U) {
            queryCnt++;
            error = devDrv->GetSqState(taskInfo->stream->Device_()->Id_(), taskInfo->stream->GetSqId(), status);
            ERROR_RETURN_MSG_INNER(error, "Failed to get sq status, stream_id=%d.", failStm->Id_());
            if ((cnt % RT_QUERY_CNT_NUM) == 0U) {
                RT_LOG(RT_LOG_EVENT, "dev_id=%u, stream_id=%d, status=%u",
                    taskInfo->stream->Device_()->Id_(), logicCq->sqId, status);
            }
            if (status != TPRT_SQ_STATE_IS_RUNNING) {
                RT_LOG(RT_LOG_WARNING, "sq is already not running, stream_id=%d, queryCnt=%u.", failStm->Id_(), queryCnt);
                break;
            }
            mmTimespec endTimeSpec = mmGetTickCount();
            const uint64_t endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * 1000UL +
                                    static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
            const uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
            const int32_t spendTime = static_cast<int32_t>(count);
            if (spendTime > getSqTimeout) {
                RT_LOG(RT_LOG_ERROR, "sq disable timeout, stream_id=%d.", failStm->Id_());
                return RT_ERROR_REPORT_TIMEOUT;
            }
        }
    }
    return RT_ERROR_NONE;
}

static rtError_t XpuProcReport(Device * const dev, uint32_t streamId, const uint32_t cnt,
    const TprtLogicCqReport_t * const logicReport)
{
    TaskInfo *reclaimTask = nullptr;
    TprtLogicCqReport_t reclaimCqReport = {};
    for (uint32_t idx = 0U; idx < cnt; ++idx) {
        const TprtLogicCqReport_t &report = logicReport[idx];
        uint32_t pos = static_cast<uint32_t>(report.sqHead);
        RT_LOG(RT_LOG_INFO, "Get logic report: cnt=%u, idx=%u, stream_id=%hu, report_pos=%u,"
            " sqe_type=%u, sq_head=%u, task_sn=%u, retCode=%#x, errType=%#x.",
            cnt, idx, streamId, pos, static_cast<uint32_t>(report.sqeType),
            report.sqHead, report.taskSn, report.errorCode, report.errorType);
        Stream *recycleStm = nullptr;
        TaskInfo *reportTask = nullptr;
        (void)dev->GetStreamSqCqManage()->GetStreamById(streamId, &recycleStm);
        if ((recycleStm != nullptr) && (recycleStm->taskResMang_ != nullptr)) {
            reportTask = (dynamic_cast<TaskResManageDavid *>(recycleStm->taskResMang_))->GetTaskInfo(pos);
        }
        /* 这里能判断pos和stream id的合法性，因此后续不需要再判断 */
        if (unlikely(reportTask == nullptr)) {
            RT_LOG(RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%hu, pos=%hu.",
                dev->Id_(), streamId, report.sqHead);
            XpuProcCqReportException(dev, report, nullptr, streamId);
            continue;
        }

        const tsTaskType_t taskType = reportTask->type;
        RT_LOG(RT_LOG_INFO, "taskType=%u.", taskType);
        XpuProcLogicCqReport(dev, report, reportTask);
        reclaimCqReport = report;
        reclaimTask = reportTask;
    }

    // must confirm that the cq reply is order-preserving. confirmed with ts-drv
    if (reclaimTask != nullptr) {
        (void)XpuStarsResumeSq(&reclaimCqReport, reclaimTask); // resume rtsq when error happens
    }
    return RT_ERROR_NONE;
}

static void XpuProcLogicCqUntilEmpty(const Stream * const stm)
{
    Device * const dev = stm->Device_();
    Driver * const devDrv = dev->Driver_();
    constexpr uint32_t allocCnt = RT_MILAN_MAX_QUERY_CQE_NUM;     // want get cqe num
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = dev->Id_();
    waitInfo.tsId = dev->DevGetTsId();
    waitInfo.cqId = stm->GetCqId();
    waitInfo.isFastCq = false;
    waitInfo.timeout = RT_REPORT_WITHOUT_TIMEOUT;  // get logic report without timeout
    waitInfo.streamId = streamId;
    waitInfo.taskId = MAX_UINT32_NUM;  // get any logic report without specifying the task

    uint32_t cnt = 0U;
    TprtLogicCqReport_t reportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
    rtError_t error = devDrv->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo), allocCnt, cnt);
    if (unlikely(((error != RT_ERROR_NONE)) || (cnt == 0U))) {
        RT_LOG(RT_LOG_INFO, "Task Wait: stream_id=%d, retCode=%#x.", streamId,
            static_cast<uint32_t>(error));
        return;
    }
    (void)XpuProcReport(dev, streamId, cnt, reportInfo);
    return;
}
// =================================================== static 函数区 ======================================== //

// ================================================== 对外出口区 ======================================== //

rtError_t XpuRecycleTaskBySqHead(const Stream * const stm)
{
    uint16_t sqHead = 0xFFFFU;
    const rtError_t error = XpuGetDrvSqHead(stm, sqHead, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "XpuGetDrvSqHead failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    TaskResManageDavid *taskManage = nullptr;
    if (stm->taskResMang_ == nullptr) {
        return RT_ERROR_STREAM_INVALID;
    }
    taskManage =  dynamic_cast<TaskResManageDavid *>(stm->taskResMang_);
    if (unlikely(stm->GetFailureMode() == ABORT_ON_FAILURE)) {
        sqHead = taskManage->GetTaskPosTail();
    }
    return XpuFinishedTaskReclaim(stm, taskManage->GetTaskPosHead(), sqHead);
}

void XpuRecycleTaskProcCqe(const Stream * const stm)
{
    if (stm->IsExistCqe()) {
        XpuProcLogicCqUntilEmpty(stm);
    }
}

void XpuTaskReclaimAllStream(const Device * const dev)
{
    std::vector<Stream *> allStreams;
    dev->GetStreamSqCqManage()->GetAllStream(allStreams);
    RT_LOG(RT_LOG_INFO, "Travel all streams, num=%zu.", allStreams.size());
    for (const auto streamLoop : allStreams) {
        streamLoop->StreamRecycleLock();
        XpuRecycleTaskProcCqe(streamLoop);
        (void)XpuRecycleTaskBySqHead(streamLoop);
        streamLoop->StreamRecycleUnlock();
    }
}
// ================================================== 对外出口区 ======================================== //
}  // namespace runtime
}  // namespace cce