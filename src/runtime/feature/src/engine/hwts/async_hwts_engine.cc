/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "async_hwts_engine.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "runtime.hpp"
#include "securec.h"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "task_res.hpp"
#include "profiler.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "npu_driver.hpp"
#include "notify.hpp"
#include "base.hpp"

#include "thread_local_container.hpp"
#include "atrace_log.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(CommandOccupy);
TIMESTAMP_EXTERN(ToCommand);
TIMESTAMP_EXTERN(ObserverLaunched);
TIMESTAMP_EXTERN(CommandSend);
TIMESTAMP_EXTERN(ReportReceive);

AsyncHwtsEngine::AsyncHwtsEngine(Device * const dev)
    : HwtsEngine(dev),
      wflag_(false),
      notifier_(static_cast<Notifier *>(nullptr)),
      scheduler_(nullptr),
      sendThread_(static_cast<Thread *>(nullptr)),
      receiveThread_(static_cast<Thread *>(nullptr)),
      sendRunFlag_(false),
      receiveRunFlag_(false)
{
    RT_LOG(RT_LOG_EVENT, "Constructor.");
}

AsyncHwtsEngine::~AsyncHwtsEngine()
{
    notifier_      = nullptr;
    receiveThread_ = nullptr;
    sendThread_    = nullptr;
    DELETE_O(scheduler_);
    RT_LOG(RT_LOG_EVENT, "Destructor.");
}

rtError_t AsyncHwtsEngine::Init()
{
    if (scheduler_ == nullptr) {
        scheduler_ = new (std::nothrow) FifoScheduler();
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, scheduler_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "Init engine failed, new FifoScheduler failed.");
        RT_LOG(RT_LOG_INFO, "new FifoScheduler ok,Runtime_alloc_size %zu.", sizeof(FifoScheduler));
    }
    return RT_ERROR_NONE;
}

rtError_t AsyncHwtsEngine::Start()
{
    // check if engine is started.
    COND_RETURN_ERROR_MSG_INNER((notifier_ != nullptr), RT_ERROR_ENGINE_THREAD,
                                "Engine start failed, notifier_ can not be nullptr.");

    rtError_t error;
    int32_t err = EN_OK;
    void *send = nullptr;
    void *recv = nullptr;
    notifier_ = OsalFactory::CreateNotifier();
    NULL_PTR_GOTO_MSG_INNER(notifier_, ERROR_RETURN, error, RT_ERROR_MEMORY_ALLOCATION);

    send = RtValueToPtr<void *>(THREAD_SENDING);
    sendThread_ = OsalFactory::CreateThread("RT_SEND", this, send);
    NULL_PTR_GOTO_MSG_INNER(sendThread_, ERROR_RETURN, error, RT_ERROR_MEMORY_ALLOCATION);

    recv = RtValueToPtr<void *>(THREAD_RECVING);
    receiveThread_ = OsalFactory::CreateThread("RT_RECV", this, recv);
    NULL_PTR_GOTO_MSG_INNER(receiveThread_, ERROR_RETURN, error, RT_ERROR_MEMORY_ALLOCATION);

    sendRunFlag_ = true;
    receiveRunFlag_ = true;
    err = sendThread_->Start();
    COND_PROC_GOTO_MSG_INNER(err != EN_OK, ERROR_RETURN, error = RT_ERROR_MEMORY_ALLOCATION;,
        "send thread start failed");

    err = receiveThread_->Start();
    COND_PROC_GOTO_MSG_INNER(err != EN_OK, ERROR_RETURN, error = RT_ERROR_MEMORY_ALLOCATION;,
        "receive thread start failed");

    return RT_ERROR_NONE;

ERROR_RETURN:
    receiveRunFlag_ = false;
    sendRunFlag_ = false;
    DELETE_O(sendThread_);
    DELETE_O(receiveThread_);
    DELETE_O(notifier_);
    return error;
}

rtError_t AsyncHwtsEngine::Stop()
{
    if (sendThread_ != nullptr) {
        DisableSendRunFlag();
        sendThread_->Join();
        RT_LOG(RT_LOG_INFO, "engine joined send thread OK.");
        DELETE_O(sendThread_);
    }

    if (receiveThread_ != nullptr) {
        DisableReceiveRunFlag();
        receiveThread_->Join();
        RT_LOG(RT_LOG_INFO, "engine joined receive thread OK.");
        DELETE_O(receiveThread_);
    }

    DELETE_O(notifier_);
    return RT_ERROR_NONE;
}

void AsyncHwtsEngine::Run(const void * const param)
{
    switch (static_cast<ThreadType>(RtPtrToValue(param))) {
        case THREAD_SENDING: {
            SendingRun();
            break;
        }
        case THREAD_RECVING: {
            ReceivingRun();
            break;
        }
        default: {
            RT_LOG(RT_LOG_ERROR, "Unknown thread type");
            break;
        }
    }
}

void AsyncHwtsEngine::SendingRun(void)
{
    rtTsCommand_t cmdLocal;
    bool terminal = false;
    uint8_t failCount = 0U;
    uint8_t profileEnable = 0U;
    uint32_t sqId;
    uint32_t cqId;
    uint32_t sendSqeNum;
    Stream *stm = nullptr;
    TaskInfo *runTask = nullptr;
    rtTsCmdSqBuf_t *command = nullptr;
    Driver * const devDrv = device_->Driver_();
    const uint32_t tsId = device_->DevGetTsId();
    const uint32_t devId = device_->Id_();

    const bool starsFlag = device_->IsStarsPlatform();
    cmdLocal.cmdType = (starsFlag) ?
                        RT_TASK_COMMAND_TYPE_STARS_SQE : RT_TASK_COMMAND_TYPE_TS_COMMAND;

    const Profiler * const profilerObj = Runtime::Instance()->Profiler_();

    while (sendRunFlag_) {
        runTask = scheduler_->PopTask();
        if (runTask == nullptr) {
            continue;
        }

        stm = runTask->stream;
        sendSqeNum = starsFlag ? GetSendSqeNum(runTask) : 1U;
        sqId = stm->GetSqId();
        cqId = stm->GetCqId();

        TIMESTAMP_BEGIN(CommandOccupy);
        failCount = 0U;
        do {
            command = nullptr;
            uint32_t pos = 0U;
            const rtError_t error = devDrv->CommandOccupy(sqId, &command, sendSqeNum, devId, tsId, &pos);
            RT_LOG(RT_LOG_INFO, "CommandOccupy. sqId=%u, cqId=%u, deviceId=%u, retCode=%#x.", sqId,
                cqId, devId, error);

            if (unlikely((error != RT_ERROR_NONE) || (command == nullptr))) {
                SendingWait(stm, failCount);
            } else {
                break;
            }
        } while (true);

        TIMESTAMP_END(CommandOccupy);

        TIMESTAMP_BEGIN(ToCommand);
        GetProfileEnableFlag(&profileEnable);
        runTask->profEn = profileEnable;
        terminal = runTask->terminal;

        if ((profilerObj != nullptr) && profilerObj->GetProfLogEnable()) {
            profilerObj->ReportSend(runTask->id, static_cast<uint16_t>(stm->Id_()));
        }

        /*
         * command is device shared memory.
         * Accessing stack memory is faster than accessing device shared memory
         */
        TaskToCommand(runTask, cmdLocal, command);
        TIMESTAMP_END(ToCommand);

        // try add task to stream task buffer
        (void)TryAddTaskToStream(runTask);

        TIMESTAMP_BEGIN(ObserverLaunched);
        for (uint32_t i = 0U; i < observerNum_; i++) {
            observers_[i]->TaskLaunched(devId, runTask, &cmdLocal);
        }
        TIMESTAMP_END(ObserverLaunched);

        TIMESTAMP_BEGIN(CommandSend);
        (void)devDrv->CommandSend(sqId, command, GetReportCount(runTask->pkgStat, profileEnable),
                                  devId, tsId, sendSqeNum);
        TIMESTAMP_END(CommandSend);

        if (unlikely(terminal)) {
            sendRunFlag_ = false;
        }
    }
}

void AsyncHwtsEngine::ReceivingRun(void)
{
    void *reportAddr = nullptr;
    rtTsReport_t tsReport;
    Driver * const devDrv = device_->Driver_();
    const uint32_t deviceId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    uint32_t cqId = 0U;
    int32_t rptTimeoutCount = 0;
    int32_t cnt = 0;

    const bool starsFlag = device_->IsStarsPlatform();
    tsReport.msgType = (starsFlag) ?
                       TS_REPORT_MSG_TYPE_STARS_CQE : TS_REPORT_MSG_TYPE_TS_REPORT;
    device_->GetStreamSqCqManage()->GetDefaultCqId(&cqId);

    COND_RETURN_VOID(devDrv == nullptr, "Can't find device driver.");
    while (receiveRunFlag_) {
        rtError_t error;
        cnt = 0;
        error = devDrv->ReportWait(&reportAddr, &cnt, deviceId, tsId, cqId);
        ReportSocketCloseProcV2();
        const rtError_t ret = ReportHeartBreakProcV2();
        // return receiving thread
        LOST_HEARTBEAT_RETURN(ret, std::to_string(device_->Id_()));

        ReportTimeoutProc(error, rptTimeoutCount);

        if (unlikely(((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) ||
                    (reportAddr == nullptr) || (cnt == 0))) {
            continue;
        }

        RT_LOG(RT_LOG_DEBUG, "cnt=%d.", cnt);
        for (int32_t idx = 0; idx < cnt; idx++) {
            GetTsReportByIdx(reportAddr, idx, tsReport);
            const rtReportPackageType packageType = static_cast<rtReportPackageType>(GetPackageType(tsReport));
            RT_LOG(RT_LOG_DEBUG, "report[%d] packageType=%u.", idx, static_cast<uint32_t>(packageType));
            switch (packageType) {
                case RT_PACKAGE_TYPE_TASK_REPORT:
                    ProcessTaskReport(tsReport);
                    break;
                case RT_PACKAGE_TYPE_ERROR_REPORT:
                    ProcessErrorReport(tsReport);
                    break;
                default:
                    RT_LOG(RT_LOG_WARNING, "invalid package type, idx=%d, packageType=%d.",
                           idx, static_cast<int32_t>(packageType));
                    break;
            }
            // when receiveRunFlag_ is false cq is released, no need release report
            if (receiveRunFlag_) {
                (void)devDrv->ReportRelease(deviceId, tsId, cqId, DRV_NORMAL_TYPE);
            }
        }
    }
}

bool AsyncHwtsEngine::CheckSendThreadAlive()
{
    if (sendThread_ != nullptr) {
        return sendThread_->IsAlive();
    }
    return false;
}

bool AsyncHwtsEngine::CheckReceiveThreadAlive()
{
    if (receiveThread_ != nullptr) {
        return receiveThread_->IsAlive();
    }
    return false;
}

void AsyncHwtsEngine::ProcessTaskReport(const rtTsReport_t &taskReport)
{
    uint16_t taskId = 0U;
    uint16_t streamId = 0U;
    uint16_t sqHead = 0U;
    uint16_t sqId = 0U;
    uint16_t errorBit = 0U;

    GetReportCommonInfo(taskReport, streamId, taskId, sqId, sqHead, errorBit);
    TaskInfo * const reportTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), taskId);

    reportCount_++;
    if (unlikely(reportTask == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "task or task stream is null, stream_id=%hu, sq_id=%hu, task_id=%hu,"
               "report_count=%" PRIu64 ", parse_task_count=%" PRIu64,
               streamId, sqId, taskId, reportCount_, parseTaskCount_);
        return;
    }

    if (!CheckReportSimuFlag(taskReport)) {
        RT_LOG(RT_LOG_INFO, "RTS_DRIVER: report receive, stream_id=%hu, sq_id=%hu, task_id=%hu, sq_head=%hu, "
               "task_type=%d (%s), bind=%d.", streamId, sqId, taskId, sqHead,
               static_cast<int32_t>(reportTask->type), reportTask->typeName,
               static_cast<int32_t>(reportTask->bindFlag));
        /* Real CQE of Stars sink stream does't need to be processed again, which was processed in simulate CQE */
        if (reportTask->bindFlag && (taskReport.msgType == TS_REPORT_MSG_TYPE_STARS_CQE)) {
            reportCount_--;
            return;
        }
    }

    parseTaskCount_++;
    RT_LOG(RT_LOG_DEBUG, "RTS_DRIVER: report receive, sq_id=%hu, stream_id=%hu, task_id=%hu, "
        "task_type=%hu (%s), report_count=%" PRIu64 ", parse_task_count=%." PRIu64,
        sqId, streamId, taskId, static_cast<uint16_t>(reportTask->type),
        reportTask->typeName, reportCount_, parseTaskCount_);

    reportTask->error = 0U;
    TIMESTAMP_BEGIN(ReportReceive);
    ReportReceive(taskReport.msgBuf.tsReport, reportTask);
    TIMESTAMP_END(ReportReceive);

    if (likely(CheckPackageState(reportTask))) {
        if (reportTask->type == TS_TASK_TYPE_EVENT_RECORD) {
            StreamSyncTaskFinishReport();
        }

        if (ProcessTask(reportTask, device_->Id_())) {
            RT_LOG(RT_LOG_INFO, "ProcessTask return terminal.");
            receiveRunFlag_ = false;
            return;
        }
    }
}

void AsyncHwtsEngine::ProcessErrorReport(const rtTsReport_t &errorReport) const
{
    if (errorReport.msgType == TS_REPORT_MSG_TYPE_STARS_CQE) {
        return;
    }

    // handle by error code.
    rtTaskReport_t * const report = errorReport.msgBuf.tsReport;
    const uint32_t retCode = static_cast<uint32_t>(report->payLoad & 0xFFFU);

    if ((retCode == static_cast<uint32_t>(TS_ERROR_AICORE_OVERFLOW)) ||
        (retCode == static_cast<uint32_t>(TS_ERROR_AIVEC_OVERFLOW))) {
        ProcessOverFlowReport(report, retCode);
    }
    return;
}

rtError_t AsyncHwtsEngine::SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId)
{
    const rtError_t error = SubmitPush(workTask, flipTaskId);
    const uint16_t taskId = workTask->id;
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    return PushFlipTask(taskId, workTask->stream);
}

TIMESTAMP_EXTERN(PushTask);
rtError_t AsyncHwtsEngine::SubmitPush(TaskInfo * const workTask, uint32_t * const flipTaskId)
{
    const uint32_t deviceId = device_->Id_();
    rtError_t error = RT_ERROR_NONE;
    ReportProfData(workTask);
    TIMESTAMP_BEGIN(PushTask);
    Stream * const stm = workTask->stream;
    if ((stm->Model_() != nullptr) && (workTask->type != TS_TASK_TYPE_MODEL_MAINTAINCE)) {
        stm->Model_()->SetKernelTaskId(static_cast<uint32_t>(workTask->id), static_cast<int32_t>(stm->Id_()));
    }
    COND_PROC(flipTaskId != nullptr, (*flipTaskId = static_cast<uint32_t>(workTask->id)));
    pendingNum_.Add(1U);
    if (unlikely((stm->AbortedStreamToFull() == TRUE) && (workTask->type != TS_TASK_TYPE_MAINTENANCE))) {
        error = RT_ERROR_STREAM_FULL;
        RT_LOG(RT_LOG_WARNING, "SubmitTask fail for stream full in failure abort,stream_id=%d,pendingNum=%u",
            stm->Id_(), stm->GetPendingNum());
    } else {
        error = scheduler_->PushTask(workTask);
    }

    TIMESTAMP_END(PushTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Push task failed, stream_id=%d,task_id=%hu,task type=%d,task_name=%s,retCode=%#x.",
            workTask->stream->Id_(), workTask->id, static_cast<int32_t>(workTask->type), workTask->typeName,
            static_cast<uint32_t>(error));
        workTask->error = TASK_ERROR_SUBMIT_FAIL;
        TaskFinished(deviceId, workTask);
        pendingNum_.Sub(1U);
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t AsyncHwtsEngine::PushFlipTask(const uint16_t preTaskId, Stream *stm)
{
    if (!stm->IsNeedSendFlipTask(preTaskId)) {
        return RT_ERROR_NONE;
    }

    TaskInfo newTask = {};
    TaskInfo *fliptask = &newTask;

    RT_LOG(RT_LOG_DEBUG, "PushFlipTask,dev_id=%u,stream_id=%d", device_->Id_(), stm->Id_());
    rtError_t error = stm->ProcFlipTask(fliptask, stm->GetTaskIdFlipNum());
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = SubmitPush(fliptask);
    RT_LOG(RT_LOG_INFO, "PushFlipTask dev_id=%u,stream_id=%d,task_id=%hu,flipNum=%hu",
        device_->Id_(), stm->Id_(), fliptask->id, fliptask->u.flipTask.flipNumReport);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "PushFlipTask failed, dev_id=%u,stream_id=%d,task_id=%hu,flipNumReport=%hu,retCode=%#x.",
        device_->Id_(), stm->Id_(), fliptask->id, fliptask->u.flipTask.flipNumReport, error);

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(fliptask);
    return error;
}

void AsyncHwtsEngine::GetReportCommonInfo(const rtTsReport_t &tsReport, uint16_t &streamId,
    uint16_t &taskId, uint16_t &sqId, uint16_t &sqHead, uint16_t &errorBit) const
{
    if (tsReport.msgType == TS_REPORT_MSG_TYPE_STARS_CQE) {
        streamId = tsReport.msgBuf.starsCqe->streamID;
        taskId = tsReport.msgBuf.starsCqe->taskID;
        sqId = tsReport.msgBuf.starsCqe->SQ_id;
        sqHead = tsReport.msgBuf.starsCqe->SQ_head;
        errorBit = tsReport.msgBuf.starsCqe->error_bit;

        RT_LOG(RT_LOG_INFO, "cqe stream_id=%u, taskId=%u, SQ_head=%u, sqId=%u, phase=%u, errorBit=%u, warn=%u, evt=%u",
            streamId, taskId, sqHead, sqId, tsReport.msgBuf.starsCqe->phase, errorBit,
            tsReport.msgBuf.starsCqe->warn, tsReport.msgBuf.starsCqe->evt);
    } else {
        streamId = static_cast<uint16_t>(static_cast<uint32_t>(tsReport.msgBuf.tsReport->streamID) |
                   (static_cast<uint32_t>(tsReport.msgBuf.tsReport->streamIDEx) <<
                       static_cast<uint32_t>(RT_STREAM_ID_OFFSET)));
        taskId = tsReport.msgBuf.tsReport->taskID;
        sqId = tsReport.msgBuf.tsReport->SQ_id;
        sqHead = tsReport.msgBuf.tsReport->SQ_head;
    }
}

void AsyncHwtsEngine::TaskToCommand(TaskInfo * const runTask, rtTsCommand_t &cmdLocal, rtTsCmdSqBuf_t * const command) const
{
    if (cmdLocal.cmdType == RT_TASK_COMMAND_TYPE_STARS_SQE) {
        const errno_t ret = memset_s(&cmdLocal.cmdBuf, sizeof(rtTsCommandBuf_t), 0, sizeof(rtTsCommandBuf_t));
        COND_RETURN_VOID(ret != EOK, "stars sqe memset_s failed, destMax=%zu, count=%zu, retCode=%d.",
                         sizeof(rtTsCommandBuf_t), sizeof(rtTsCommandBuf_t), ret);
        // command of hi1980C is host memory, use itself directly
        ToConstructSqe(runTask, &command->starsSqe);
    } else {
        const errno_t ret = memset_s(&cmdLocal.cmdBuf.cmd, sizeof(rtCommand_t), 0, sizeof(rtCommand_t));
        COND_RETURN_VOID(ret != EOK, "cmd memset_s failed, destMax=%zu, count=%zu, retCode=%d.",
                         sizeof(rtCommand_t), sizeof(rtCommand_t), ret);
        ToCommand(runTask, &cmdLocal.cmdBuf.cmd);
        command->cmd = cmdLocal.cmdBuf.cmd;
    }
    return;
}

void AsyncHwtsEngine::SendingWait(Stream * const stm, uint8_t &failCount)
{
    UNUSED(stm);
    ++failCount;
    if (failCount > 9U) { // > 9 consecutive failures
        wflag_ = true;
        if (notifier_ != nullptr) {
            (void)notifier_->Wait();
        }
    }
}

void AsyncHwtsEngine::SendingNotify()
{
    if (unlikely(wflag_)) {
        wflag_ = false;
        if (notifier_ != nullptr) {
            (void)notifier_->Triger();
        }
    }
}

uint16_t AsyncHwtsEngine::GetPackageType(const rtTsReport_t &report) const
{
    uint16_t pkgType = static_cast<uint16_t>(RT_PACKAGE_TYPE_TASK_REPORT);

    if (report.msgType != TS_REPORT_MSG_TYPE_STARS_CQE) {
        pkgType = static_cast<uint16_t>(report.msgBuf.tsReport->packageType);
    }

    return pkgType;
}

void AsyncHwtsEngine::GetTsReportByIdx(void * const reportAddr, int32_t const idx, rtTsReport_t &tsReport) const
{
    if (tsReport.msgType == TS_REPORT_MSG_TYPE_STARS_CQE) {
        tsReport.msgBuf.starsCqe = RtPtrToPtr<rtStarsCqe_t *>(reportAddr) + idx;
    } else {
        tsReport.msgBuf.tsReport = RtPtrToPtr<rtTaskReport_t *>(reportAddr) + idx;
    }
}
}  // namespace runtime
}  // namespace cce