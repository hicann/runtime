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
#include "task_info.h"
#include "task_recycle.hpp"
#include "engine.hpp"
#include "task_res_da.hpp"
#include "stream_sqcq_manage.hpp"
#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {

static const std::vector<std::string> DavidCqeErrorDesc_ = {
    "task exception",
    "bus error",
    "task timeout",
    "sqe error",
    "resource conflict error",
    "sq sw status error"
};

// =================================================== static 函数区 ======================================== //
static void PrintTaskErrorMsg(const uint16_t streamId, const uint16_t pos, rtLogicCqReport_t &logicCq,
    const TaskInfo * const reportTask, std::string &errMsg)
{
    uint32_t reportTaskSn = (static_cast<uint32_t>(logicCq.taskId) << UINT16_BIT_NUM) | logicCq.streamId;
    if ((IsDvppTask(static_cast<uint16_t>(logicCq.sqeType)) || (logicCq.sqeType == RT_DAVID_SQE_TYPE_PLACE_HOLDER) ||
        (logicCq.sqeType == RT_DAVID_SQE_TYPE_AICPU_D) || (logicCq.sqeType == RT_DAVID_SQE_TYPE_FUSION) ||
        (logicCq.sqeType == RT_DAVID_SQE_TYPE_CCU)) && (logicCq.errorCode == TS_ERROR_TASK_TIMEOUT) &&
        ((logicCq.errorType & static_cast<uint8_t>(RT_STARS_CQE_ERR_TYPE_SW_STATUS)) != 0U) && (reportTask != nullptr)) {
        logicCq.errorType = static_cast<uint8_t>(RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT);
        errMsg = DavidCqeErrorDesc_[static_cast<uint32_t>(CTZ(logicCq.errorType))];
        RT_LOG(RT_LOG_ERROR, "Task run timeout, stream_id=%hu, pos=%hu, task_sn=%u, task_type=%u(%s), "
            "errType=%#x(%s), sqSwStatus=%#x.", streamId, pos, reportTaskSn,
            static_cast<uint32_t>(reportTask->type), GetTaskDescByType(reportTask->type), logicCq.errorType,
            errMsg.c_str(), logicCq.errorCode);
    } else {
        RT_LOG(RT_LOG_ERROR, "Task run failed, stream_id=%hu, pos=%hu, task_sn=%u, sqe_type=%u(%s), "
            "errType=%#x(%s), sqSwStatus=%#x.", streamId, pos, reportTaskSn,
            static_cast<uint32_t>(logicCq.sqeType), GetDavidSqeDescByType(logicCq.sqeType), logicCq.errorType,
            errMsg.c_str(), logicCq.errorCode);
    }
}

static bool IsNeedMoveMultipleSteps(tsTaskType_t type)
{
    return (type == TS_TASK_TYPE_DIRECT_SEND) ||
            (type == TS_TASK_TYPE_MEMCPY) ||
            (type == TS_TASK_TYPE_CCU_LAUNCH) ||
            (type == TS_TASK_TYPE_FUSION_KERNEL);
}

static rtError_t PollingSqDisable(const rtLogicCqReport_t *logicCq, const Stream * const failStm)
{
    rtError_t error = RT_ERROR_NONE;
    Device * const dev = failStm->Device_();
    const uint32_t devId = dev->Id_();
    Driver * const devDrv = dev->Driver_();
    const uint32_t tsId = dev->DevGetTsId();
    mmTimespec beginTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
    const int32_t getSqTimeout = (failStm->GetSyncRemainTime() == -1) ? RT_GET_SQ_STATUS_TIMEOUT_TIME :
        (failStm->GetSyncRemainTime() * 1000);
    uint64_t cnt = 0U;
    uint32_t queryCnt = 0U;
    bool enable = true;
    while (true) {
        if ((cnt++ % RT_GET_HEAD_CYCLE_NUM) == 0U) {
            queryCnt++;
            error = devDrv->GetSqEnable(devId, tsId, logicCq->sqId, enable);
            ERROR_RETURN_MSG_INNER(error, "Failed to get sq enable, stream_id=%d.", failStm->Id_());
            if ((cnt % RT_QUERY_CNT_NUM) == 0U) {
                RT_LOG(RT_LOG_EVENT, "dev_id=%u, ts_id=%u, stream_id=%d, enable=%u",
                    devId, tsId, logicCq->sqId, enable);
            }
            if (!enable) {
                RT_LOG(RT_LOG_WARNING, "sq already disable, stream_id=%d, queryCnt=%u.", failStm->Id_(), queryCnt);
                break;
            }
            COND_RETURN_ERROR((dev->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT),
                RT_ERROR_DEVICE_TASK_ABORT,
                "stream is in device task abort status, device_id=%u, stream_id=%d",
                devId, failStm->Id_());
            COND_RETURN_ERROR((failStm->GetAbortStatus() == RT_ERROR_STREAM_ABORT), 
                RT_ERROR_STREAM_ABORT,
                "stream is in stream abort status, device_id=%u, stream_id=%d",
                devId, failStm->Id_());
            mmTimespec endTimeSpec = mmGetTickCount();
            const uint64_t endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * 1000UL +
                                    static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
            const uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
            const int32_t spendTime = static_cast<int32_t>(count);
            if (spendTime > getSqTimeout) {
                RT_LOG(RT_LOG_ERROR, "sq disable timeout, stream_id=%d, sync reamintime=%d.",
                    failStm->Id_(), failStm->GetSyncRemainTime());
                return RT_ERROR_REPORT_TIMEOUT;
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t StarsResumeRtsq(const rtLogicCqReport_t *logicCq, const TaskInfo * const taskInfo)
{
    uint32_t offset = 1U;   // skip the error sqe
    uint32_t head = 0U;

    // No error exists.
    if ((logicCq->errorType & RT_STARS_EXIST_ERROR) == 0U) {
        return RT_ERROR_NONE;
    }

    // Resume scheduling
    if (taskInfo->type == static_cast<uint16_t>(TS_TASK_TYPE_MODEL_EXECUTE)) {
        offset = 2U;    // if model execute sqe, need skip model_execute and wait_end_graph sqe
    } else if (IsNeedMoveMultipleSteps(taskInfo->type)) {
        offset = GetSendDavidSqeNum(taskInfo);
    } else {
        // no operation
    }

    rtError_t error = RT_ERROR_NONE;
    const Stream * const failStm = taskInfo->stream;
    Device * const dev = failStm->Device_();
    const uint32_t devId = dev->Id_();
    Driver * const devDrv = dev->Driver_();
    const uint32_t tsId = dev->DevGetTsId();

    RT_LOG(RT_LOG_WARNING, "Begin to query sq status, stream_id=%d.", failStm->Id_());
    error = PollingSqDisable(logicCq, failStm);
    ERROR_RETURN_MSG_INNER(error, "polling sq disable failed, retCode=%#x.", static_cast<uint32_t>(error));

    if (taskInfo->type == static_cast<uint16_t>(TS_TASK_TYPE_MULTIPLE_TASK)) {
        head = (dynamic_cast<TaskResManageDavid *>(failStm->taskResMang_))->GetTaskPosHead() +
            GetSendDavidSqeNum(taskInfo);
    } else {
        head = ((static_cast<uint32_t>(logicCq->sqHead) + offset) % failStm->GetSqDepth());
    }
    COND_RETURN_ERROR((dev->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT),
        RT_ERROR_DEVICE_TASK_ABORT,
        "stream is in device task abort status, device_id=%u, stream_id=%d",
        devId, failStm->Id_());
    COND_RETURN_ERROR((failStm->GetAbortStatus() == RT_ERROR_STREAM_ABORT), 
        RT_ERROR_STREAM_ABORT,
        "stream is in stream abort status, device_id=%u, stream_id=%d",
        devId, failStm->Id_());
    error = devDrv->SetSqHead(devId, tsId, static_cast<uint32_t>(logicCq->sqId), head);
    ERROR_RETURN_MSG_INNER(error, "set sq head failed, stream_id=%d, sq_id=%hu, device_id=%u, retCode=%#x.",
        failStm->Id_(), logicCq->sqId, devId, static_cast<uint32_t>(error));

    if (failStm->GetFailureMode() == ABORT_ON_FAILURE) {
        RT_LOG(RT_LOG_ERROR, "stop scheduling in abort failure mode: stream_id=%d, sq_id=%hu, sq_head=%hu"
            ", task_id=%hu, taskType=%hu.", failStm->Id_(), logicCq->sqId, logicCq->sqHead, logicCq->sqHead, taskInfo->type);
        return RT_ERROR_NONE;
    }

    error = devDrv->EnableSq(devId, tsId, static_cast<uint32_t>(logicCq->sqId));
    ERROR_RETURN_MSG_INNER(error, "Enable sq failed, stream_id=%d, sq_id=%hu, device_id=%u, retCode=%#x.",
        failStm->Id_(), logicCq->sqId, devId, static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_WARNING, "Resume stream_id=%d, sq_id=%hu, sq_head=%hu, task_id=%hu, taskType=%hu, head=%u.",
        failStm->Id_(), logicCq->sqId, logicCq->sqHead, logicCq->sqHead, taskInfo->type, head);

    return RT_ERROR_NONE;
}

static bool ProcReportIsException(const rtLogicCqReport_t &logicCq)
{
    if (static_cast<uint8_t>(logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        return false;
    }

    rtStarsCqeSwStatus_t swStatus;
    swStatus.value = logicCq.errorCode;

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

    if ((logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_AICORE_OVERFLOW))
        || (logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_AIVEC_OVERFLOW))
        || (logicCq.errorCode == static_cast<uint32_t>(TS_ERROR_SDMA_OVERFLOW))) {
        return false;
    }

    return true;
}

static void ClearcMulTaskCqeNum(const uint8_t mulTaskCqeNum, TaskInfo * const repTask)
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

void ProcCqReportException(Device * const dev, rtLogicCqReport_t &logicCq,
    TaskInfo * reportTask, uint16_t streamId)
{
    const uint16_t pos = logicCq.sqHead;
    const uint8_t errType = logicCq.errorType;
    const uint32_t errBit = (errType == 0U) ? UINT32_BIT_NUM : static_cast<uint32_t>(CTZ(errType));
    std::string errMsg = errBit < DavidCqeErrorDesc_.size() ? DavidCqeErrorDesc_[errBit] : "unknow";
    if (ProcReportIsException(logicCq)) {
        const uint32_t swStatus = logicCq.errorCode;
        PrintTaskErrorMsg(streamId, pos, logicCq, reportTask, errMsg);
        (void)dev->PrintStreamTimeoutSnapshotInfo();
        if (reportTask != nullptr) {
            TaskInfo * const faultTaskPtr = GetRealReportFaultTask(reportTask, static_cast<const void *>(&swStatus));
            (void)dev->ProcDeviceErrorInfo(faultTaskPtr);
            if (!reportTask->stream->IsSeparateSendAndRecycle()) {
                reportTask->stream->EnterFailureAbort();
            }
        } else {
            (void)dev->ProcDeviceErrorInfo();
        }
    } else if ((errType & (RT_STARS_EXIST_ERROR | RT_STARS_EXIST_WARNING)) != static_cast<uint8_t>(0U)) {
        // error bit indicates overflow of debug model or endofsquence here
        RT_LOG(RT_LOG_WARNING,
            "CQE warning, device_id=%u, stream_id=%u, pos=%hu, sqe_type=%u(%s), errType=%#x(%s), sqSwStatus=%#x.",
            dev->Id_(), streamId, pos, static_cast<uint32_t>(logicCq.sqeType),
            GetSqeDescByType(logicCq.sqeType), errType, errMsg.c_str(), logicCq.errorCode);
    } else {
        // no operation
    }
}

static void SaveCurrCtxForRecyleThread(Device * const dev, uint32_t streamId)
{
    Stream *stm = nullptr;
    (void)dev->GetStreamSqCqManage()->GetStreamById(streamId, &stm);
    if ((stm != nullptr) && (stm->IsSeparateSendAndRecycle())) {
        InnerThreadLocalContainer::SetCurCtx(stm->Context_());
    }

    return;
}
// =================================================== static 函数区 ======================================== //

// ================================================== 对外出口区 ======================================== //
rtError_t ProcReport(Device * const dev, uint32_t streamId, const uint32_t syncPos, const uint32_t cnt,
    rtLogicCqReport_t * const logicReport, bool &isFinished)
{
    TaskInfo *reclaimTask = nullptr;
    rtLogicCqReport_t reclaimCqReport = {};
    uint32_t targetTaskSn = 0xFFFFFFFFU;     /* invalid value */
    for (uint32_t idx = 0U; idx < cnt; ++idx) {
        rtLogicCqReport_t &report = logicReport[idx];
        if (syncPos != UINT32_MAX) {
            TaskInfo *targetTask = GetTaskInfo(dev, streamId, syncPos);
            if (targetTask != nullptr) {
                targetTaskSn = targetTask->taskSn;
            }
        }
        uint32_t pos = static_cast<uint32_t>(report.sqHead);
        uint32_t reportTaskSn = (static_cast<uint32_t>(report.taskId) << UINT16_BIT_NUM) | report.streamId;
        RT_LOG(RT_LOG_INFO, "Get logic report: cnt=%u, idx=%u, stream_id=%hu, report_pos=%u, sync_pos=%u,"
            " sqe_type=%u, sq_head=%u, target_task_sn=%u, report_task_sn=%u, retCode=%#x, errType=%#x.",
            cnt, idx, streamId, pos, syncPos, static_cast<uint32_t>(report.sqeType),
            report.sqHead, targetTaskSn, reportTaskSn, report.errorCode, report.errorType);

        SaveCurrCtxForRecyleThread(dev, streamId);

        /* 这里能判断pos和stream id的合法性，因此后续不需要再判断 */
        TaskInfo *reportTask = GetTaskInfo(dev, streamId, pos);
        if (unlikely(reportTask == nullptr)) {
            RT_LOG(RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%hu, pos=%hu.",
                dev->Id_(), streamId, report.sqHead);
            ProcCqReportException(dev, report, nullptr, streamId);
            isFinished = ((report.sqHead == syncPos) && (targetTaskSn == reportTaskSn)) ? true : isFinished;
            continue;
        }

        RT_LOG(RT_LOG_INFO, "taskType=%u.", reportTask->type);
        if ((reportTask->type == TS_TASK_TYPE_MULTIPLE_TASK) && (GetSendDavidSqeNum(reportTask) > 1U)) {
            if (CompleteProcMultipleTaskReport(reportTask, report)) {
                rtLogicCqReport_t cqReport = report;
                GetMultipleTaskCqeErrorInfo(reportTask, cqReport.sqeType, cqReport.errorType, cqReport.errorCode);
                ProcLogicCqReport(dev, cqReport, reportTask);
                reclaimCqReport = cqReport;
                reclaimTask = reportTask;
                isFinished = ((report.sqHead == syncPos) && (targetTaskSn == reportTaskSn)) ? true : isFinished;
            }
        } else {
            if (!ProcReportIsDvppErrorAndRetry(report, reportTask)) {
                ProcLogicCqReport(dev, report, reportTask);
                reclaimCqReport = report;
                reclaimTask = reportTask;
                isFinished = ((report.sqHead == syncPos) && (targetTaskSn == reportTaskSn)) ? true : isFinished;
            }
        }
    }
    
    // must confirm that the cq reply is order-preserving. confirmed with ts-drv
    if (reclaimTask != nullptr) {
        (void)StarsResumeRtsq(&reclaimCqReport, reclaimTask); // resume rtsq when error happens
    }
    if (dev->GetHasTaskError()) {
        dev->SetHasTaskError(false);
        dev->SetMonitorExitFlag(false);
    }
    return RT_ERROR_NONE;
}

static void StarsCqeReceive(const Device * const dev, const rtLogicCqReport_t &logicCq, TaskInfo * const runTask)
{
    runTask->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage++;
    SetStarsResult(runTask, logicCq);
    Complete(runTask, dev->Id_());

    if ((ProcReportIsException(logicCq)) && (runTask->stream->IsSeparateSendAndRecycle())) {
        runTask->stream->EnterFailureAbort();
    }

    runTask->isCqeNeedConcern = false;
    runTask->stream->SetNeedRecvCqeFlag(false);
}

void ProcLogicCqReport(Device * const dev, rtLogicCqReport_t &logicCq, TaskInfo * reportTask)
{
    if (unlikely(reportTask == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "task is null, sq_id=%hu, sq_head=%hu.",
            logicCq.sqId, logicCq.sqHead);
        return;
    }
    const uint16_t streamId = reportTask->stream->Id_();
    const uint16_t pos = logicCq.sqHead;
    const uint16_t sqId = logicCq.sqId;
    
    ProcCqReportException(dev, logicCq, reportTask, streamId);
    const tsTaskType_t taskType = reportTask->type;
    RT_LOG(RT_LOG_DEBUG, "RTS_DRIVER: report receive, stream_id=%hu, pos=%hu, sq_id=%hu, sq_head=%hu, "
        "task_type=%hu(%s).",
        streamId, pos, sqId, logicCq.sqHead, static_cast<uint16_t>(taskType), reportTask->typeName);

    reportTask->error = 0U;
    StarsCqeReceive(dev, logicCq, reportTask);

    // Set error device status
    if (dev->GetHasTaskError()) {
        dev->SetMonitorExitFlag(true);
        (void) Runtime::Instance()->SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_ABNORMAL);
    }

    return;
}

bool CompleteProcMultipleTaskReport(TaskInfo * const workTask, const rtLogicCqReport_t &report)
{
    TaskInfo * const reportTask = workTask;
    const uint8_t mulTaskCqeNum = GetMultipleTaskCqeNum(reportTask);
    DecMultipleTaskCqeNum(reportTask);

    const uint8_t ret = GetStarsDefinedErrCode(report.errorType);
    RT_LOG(RT_LOG_DEBUG, "Get stars defined retCode=%hhu, sqe_type=%hhu, stream_id=%d, task_id=%u.",
        ret, report.sqeType, workTask->stream->Id_(), report.sqHead);
    SetMultipleTaskCqeErrorInfo(reportTask, report.sqeType, report.errorType, report.errorCode);

    constexpr uint8_t targetType = RT_DAVID_SQE_TYPE_AICPU_D;
    /* Terminate the subsequent CQ execution when the aicpu task fails. */
    if ((GetMultipleTaskCqeNum(reportTask) > 0U) && (report.sqeType == targetType) && (ret != 0)) {
        RT_LOG(RT_LOG_WARNING, "RT_STARS_SQE_TYPE_AICPU ERROR DecMultipleTaskCqeNum = %u.",
            GetMultipleTaskCqeNum(reportTask));
        ClearcMulTaskCqeNum(mulTaskCqeNum, workTask);
    }

    if (GetMultipleTaskCqeNum(reportTask) > 0U) {
        RT_LOG(RT_LOG_WARNING, "GetMultipleTaskCqeNum = %u, then incRecvPkg.",
            static_cast<uint32_t>(GetMultipleTaskCqeNum(reportTask)));
        reportTask->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage++;
        return false;
    }

    return true;
}

// ================================================== 对外出口区 ======================================== //
}  // namespace runtime
}  // namespace cce