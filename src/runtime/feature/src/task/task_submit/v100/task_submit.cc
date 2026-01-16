/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_submit.hpp"
#include "task.hpp"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "engine.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "stars_engine.hpp"
#include "raw_device.hpp"
#include "arg_loader.hpp"
#include "task_res.hpp"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(AllocTaskAndSendDc);
TIMESTAMP_EXTERN(AllocTaskAndSendStars);
TIMESTAMP_EXTERN(TryRecycleTaskV1);
TIMESTAMP_EXTERN(TaskSendLimitedV1);
TIMESTAMP_EXTERN(TaskRes_AllocTaskNormal);
TIMESTAMP_EXTERN(TaskRes_AllocTask);

TIMESTAMP_EXTERN(TryTaskReclaimV1);
TIMESTAMP_EXTERN(SaveTaskInfo);
TIMESTAMP_EXTERN(ToCommandV1);
TIMESTAMP_EXTERN(HalfEventProcV1);
TIMESTAMP_EXTERN(CommandOccupyNormalV1);
TIMESTAMP_EXTERN(CommandOccupyV1);
TIMESTAMP_EXTERN(CommandSendV1);

TIMESTAMP_EXTERN(SqTaskSendNormalV1);
TIMESTAMP_EXTERN(SqTaskSendV1);
TIMESTAMP_EXTERN(AicpuLoad);
TIMESTAMP_EXTERN(AicoreLoad);

rtError_t AllocTaskAndSend(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId, int32_t timeout)
{
    if  ((!stm->IsCtrlStream()) && ((stm->Id_() == -1) || (stm->Id_() == MAX_INT32_NUM))) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "stream is invalid, stream_id=%d.", stm->Id_());
        submitTask->error = static_cast<uint32_t>(TASK_ERROR_SUBMIT_FAIL);
        return RT_ERROR_STREAM_INVALID;
    }

    bool isMilan = stm->Device_()->IsStarsPlatform();
    if (isMilan) {
        return SubmitTaskStars(submitTask, stm, flipTaskId, timeout);
    } else {
        return SubmitTaskDc(submitTask, stm, flipTaskId, timeout);
    }
}

rtError_t LoadArgsInfoForAicoreKernelTask(TaskInfo *submitTask, Stream *stm, uint16_t taskResId)
{
    ArgLoaderResult result = {};
    rtArgsEx_t *argsInfo = submitTask->u.aicTaskInfo.argsInfo;
    rtError_t error = RT_ERROR_NONE;
    if (argsInfo != nullptr) {
        error = stm->taskResMang_->Load(argsInfo, static_cast<uint32_t>(taskResId), stm, &result);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Failed to load args, stream_id=%d,"
            " retCode=%#x.", stm->Id_(), error);
        SetAicoreArgs(submitTask, result.kerArgs, argsInfo->argsSize, result.smArgs,
            submitTask->u.aicTaskInfo.smSize, result.handle);
    }
    return error;
}

static rtError_t LoadArgsInfoForAicpuKernelTask(TaskInfo * const submitTask, Stream * const stm,
    uint16_t taskResId)
{
    rtAicpuArgsEx_t *aicpuArgsInfo = submitTask->u.aicpuTaskInfo.aicpuArgsInfo;
    rtArgsEx_t *argsInfo = submitTask->u.aicpuTaskInfo.argsInfo;
    ArgLoaderResult result = {};
    rtError_t error = RT_ERROR_NONE;
    if (argsInfo != nullptr) {
        error = stm->taskResMang_->Load(argsInfo, static_cast<uint32_t>(taskResId), stm, &result);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Failed to load args, stream_id=%d,"
            " retCode=%#x.", stm->Id_(), error);
        SetAicpuArgs(submitTask, result.kerArgs, argsInfo->argsSize, result.handle);
    }
    if (aicpuArgsInfo != nullptr) {
        error = stm->taskResMang_->Load(aicpuArgsInfo, static_cast<uint32_t>(taskResId), stm, &result);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Failed to load args, stream_id=%d,"
            " retCode=%#x.", stm->Id_(), error);
        SetAicpuArgs(submitTask, result.kerArgs, aicpuArgsInfo->argsSize, result.handle);

        /* 如果aicpuArgsInfo->args中存在soName和kernnelName，则使用args中的devAddr；
         * 否则，使用kernel注册时的devAddr（见StoreKernelLiteralNameToDevice调用的地方）
         * 注：部分场景的cpuLaunch没有kernel注册过程 */
        if ((aicpuArgsInfo->soNameAddrOffset != 0) || (aicpuArgsInfo->kernelNameAddrOffset != 0)) {
             SetNameArgs(submitTask, (RtPtrToPtr<char_t *, void *>(result.kerArgs) + aicpuArgsInfo->soNameAddrOffset),
                         (RtPtrToPtr<char_t *, void *>(result.kerArgs) + aicpuArgsInfo->kernelNameAddrOffset));
        }
    }
    return error;
}

rtError_t LoadArgsInfo(TaskInfo *submitTask, Stream *stm, uint16_t taskResId)
{
    if (!stm->isHasPcieBar_) {
        return RT_ERROR_NONE;
    }

    if (!(stm->IsDavinciTask(submitTask))) {
        return RT_ERROR_NONE;
    }

    const tsTaskType_t tskType = submitTask->type;
    rtError_t error = RT_ERROR_NONE;
    if ((tskType == TS_TASK_TYPE_KERNEL_AICORE) || (tskType == TS_TASK_TYPE_KERNEL_AIVEC)) {
        TIMESTAMP_BEGIN(AicoreLoad);
        error = LoadArgsInfoForAicoreKernelTask(submitTask, stm, taskResId);
        TIMESTAMP_END(AicoreLoad);
    } else if (tskType == TS_TASK_TYPE_KERNEL_AICPU) {
        TIMESTAMP_BEGIN(AicpuLoad);
        error = LoadArgsInfoForAicpuKernelTask(submitTask, stm, taskResId);
        TIMESTAMP_END(AicpuLoad);
    } else {
        // do nothing
    }
    RT_LOG(RT_LOG_INFO, "stream_id=%d, task_type=%u.", stm->Id_(),
        static_cast<uint32_t>(submitTask->type));
    return error;
}

rtError_t AllocTaskAndSendDc(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId)
{
    COND_RETURN_ERROR_MSG_INNER(((stm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U),
        RT_ERROR_STREAM_INVALID,
        "Kernel launch with args failed, the stm[%u] can not be coprocessor stream flag=%u.",
        stm->Id_(), stm->Flags());
    // 主动回收
    uint8_t failCount = 0U;
    Engine* engine = ((RawDevice*)(stm->Device_()))->Engine_();
    TIMESTAMP_BEGIN(TryRecycleTaskV1);
    rtError_t error = engine->TryRecycleTask(stm);
    TIMESTAMP_END(TryRecycleTaskV1);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Try recycle task failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    constexpr uint16_t perDetectTimes = 1000U;
    uint32_t tryCount = 0U;
    while (stm->IsTaskLimited(nullptr) && (!stm->GetRecycleFlag())) {
        TIMESTAMP_BEGIN(TaskSendLimitedV1);
        stm->SetStreamAsyncRecycleFlag(true);
        engine->SendingWait(stm, failCount);   // Send limited, need release complete task.
        stm->SetStreamAsyncRecycleFlag(false);
        TIMESTAMP_END(TaskSendLimitedV1);
        if ((tryCount % perDetectTimes) == 0) {
            error = stm->CheckContextTaskSend(submitTask);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
        }
        tryCount++;
    }

    Device * const dev = stm->Device_();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();

    // 调用driver接口，对RTSQ加锁
    constexpr uint32_t sendSqeNum = 1U;
    rtTsCmdSqBuf_t *command = nullptr;

    struct halSqMemGetInput sqMemGetInput = {DRV_NORMAL_TYPE, tsId, sqId, sendSqeNum, {0}};
    struct halSqMemGetOutput sqMemGetOutput = {0, nullptr, 0, {0}};

    StreamSqCqManage * const stmSqCqManage = const_cast<StreamSqCqManage *>(dev->GetStreamSqCqManage());
    std::mutex * const sqMutex = stmSqCqManage->GetSqMutex(sqId);
    if (sqMutex == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "GetSqMutex failed: sqId=%u", sqId);
        return RT_ERROR_INVALID_VALUE;
    }
    const std::lock_guard<std::mutex> lk(*sqMutex);

    TIMESTAMP_BEGIN(CommandOccupyNormalV1);
    error = halSqMemGet(devId, &sqMemGetInput, &sqMemGetOutput);
    command = RtPtrToPtr<rtTsCmdSqBuf_t *, void *>(const_cast<void *>(sqMemGetOutput.cmdPtr));
    TIMESTAMP_END(CommandOccupyNormalV1);
    RT_LOG(RT_LOG_DEBUG, "sqId=%u, deviceId=%u, tsId=%u, cmdCount=%u, pos=%u.",
           sqId, devId, tsId, sqMemGetOutput.cmdCount, sqMemGetOutput.pos);

    tryCount = 0U;
    while (command == nullptr) {
        RT_LOG(RT_LOG_WARNING, "device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
            " stream_id=%d, task_id=%hu, task_type=%u, error=%u.",
            devId, tsId, sqId, cqId, stm->Id_(), submitTask->id,
            static_cast<uint32_t>(submitTask->type),
            static_cast<uint32_t>(error));
        TIMESTAMP_BEGIN(CommandOccupyV1);
        error = halSqMemGet(devId, &sqMemGetInput, &sqMemGetOutput);
        command = RtPtrToPtr<rtTsCmdSqBuf_t *, void *>(const_cast<void *>(sqMemGetOutput.cmdPtr));
        TIMESTAMP_END(CommandOccupyV1);
        RT_LOG(RT_LOG_DEBUG, "sqId=%u, deviceId=%u, tsId=%u, cmdCount=%u, pos=%u.",
            sqId, devId, tsId, sqMemGetOutput.cmdCount, sqMemGetOutput.pos);
        stm->SetFlowCtrlFlag();
        tryCount++;
        if ((tryCount % perDetectTimes) == 0) {
            if (stm->Device_()->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
                RT_LOG(RT_LOG_ERROR, "device status error, drvError=%#x, device_id=%u, stream_id=%d",
                    static_cast<uint32_t>(error), devId, stm->Id_());
                stm->DcShowStmDfxInfo();
                return RT_ERROR_DRV_ERR;
            }
        }
    }

    // 调用driver接口，对RTSQ加锁
    uint16_t taskId = static_cast<uint16_t>(stm->GetLastTaskId()); // obp使用stream自己的taskid, 也要翻转
    taskId = (taskId != MAX_UINT16_NUM) ? ((taskId + 1U) % MAX_UINT16_NUM) : 0U;
    const uint16_t taskPool = stm->taskResMang_->GetTaskPoolNum();
    const uint16_t taskResId = taskId % taskPool;
    TaskInfo *taskInfo = nullptr;
    TaskFactory *taskFactory = dev->GetTaskFactory();

    RT_LOG(RT_LOG_INFO, "alloc taskinfo device_id=%u, stream_id=%d, taskResId=%u, taskResHead_=%u, "
        "taskResTail_=%u, taskPoolNum_=%u.", stm->taskResMang_->deviceId_, stm->taskResMang_->streamId_, taskResId,
        stm->taskResMang_->taskResHead_, stm->taskResMang_->taskResTail_, stm->taskResMang_->taskPoolNum_);
    TIMESTAMP_BEGIN(TaskRes_AllocTaskNormal);
    taskInfo = stm->taskResMang_->AllocTaskInfoByTaskResId(stm, taskResId, taskId, submitTask->type);
    TIMESTAMP_END(TaskRes_AllocTaskNormal);
    while (taskInfo == nullptr) {
        TIMESTAMP_BEGIN(TryTaskReclaimV1);
        taskFactory->TryTaskReclaim(stm);
        error = stm->CheckContextTaskSend(submitTask);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
        TIMESTAMP_END(TryTaskReclaimV1);
        TIMESTAMP_BEGIN(TaskRes_AllocTask);
        taskInfo = stm->taskResMang_->AllocTaskInfoByTaskResId(stm, taskResId, taskId, submitTask->type);
        TIMESTAMP_END(TaskRes_AllocTask);
    }

    error =  LoadArgsInfo(submitTask, stm, taskResId);
    COND_PROC_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE),
        error, (void)taskFactory->Recycle(taskInfo);, "LoadArgsInfo failed.");

    submitTask->id = taskId;
    submitTask->profEn = Runtime::Instance()->GetProfileEnableFlag();
    UpdateFlipNum(submitTask, true);

    TIMESTAMP_BEGIN(SaveTaskInfo);
    SaveTaskInfo(taskInfo, submitTask);
    TIMESTAMP_END(SaveTaskInfo);
    COND_PROC(flipTaskId != nullptr, *flipTaskId = GetFlipTaskId(taskInfo->id, taskInfo->flipNum););
    RT_LOG(RT_LOG_INFO, "ReportProfData, taskInfo->id=%hu, taskInfo->flipNum=%hu, flipTaskId=%u",
           taskInfo->id, taskInfo->flipNum, flipTaskId);
    engine->ReportProfData(taskInfo);

    const Profiler * const profilerObj = Runtime::Instance()->Profiler_();
    if ((profilerObj != nullptr) && (profilerObj->GetProfLogEnable())) {
        profilerObj->ReportSend(taskInfo->id, static_cast<uint16_t>(stm->Id_()));
    }

    stm->pendingNum_.Add(1U);

    /*
     * command is device shared memory.
     * Accessing stack memory is faster than accessing device shared memory
     */
    // step6 调用各类task的填写回调函数
    TIMESTAMP_BEGIN(ToCommandV1);
    rtTsCommand_t cmdLocal = {};
    ToCommand(taskInfo, &(cmdLocal.cmdBuf.cmd));
    command->cmd = cmdLocal.cmdBuf.cmd;
    TIMESTAMP_END(ToCommandV1);

    // list处理的taskId要保序
    // step8 需要进行后处理的task需要单独维护tasklist
    if (!stm->IsCtrlStream()) {
        error = engine->TryAddTaskToStream(taskInfo);
        if (error != RT_ERROR_NONE) {
            stm->pendingNum_.Sub(1U);
            (void)stm->Device_()->GetTaskFactory()->Recycle(taskInfo);
            return error;
        }
    }

    error = engine->ProcessTaskWait(taskInfo);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "ProcessTaskWait failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d."
            " task_id=%hu, task_type=%d(%s), retCode=%d.",
            devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, static_cast<int32_t>(taskInfo->type),
            taskInfo->typeName, error);
        stm->pendingNum_.Sub(1U);
        (void)stm->Device_()->GetTaskFactory()->Recycle(taskInfo);
        return error;
    }

    // step7 调用driver接口发送sqe
    TIMESTAMP_BEGIN(CommandSendV1);
    const uint32_t reportCount = GetReportCount(taskInfo->pkgStat, taskInfo->profEn);
    halSqMsgInfo sendInfo = {DRV_NORMAL_TYPE, tsId, sqId, sendSqeNum, reportCount, {}};
    const drvError_t drvRet = halSqMsgSend(devId, &sendInfo);
    TIMESTAMP_END(CommandSendV1);
    if (unlikely(drvRet != DRV_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "[drv api] halSqMsgSend failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d."
            " task_id=%hu, task_type=%d(%s), reportCount=%u, cmdCount=%u, drvRetCode=%d.",
            devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, taskInfo->type, taskInfo->typeName,
            reportCount, sendSqeNum, drvRet);
        stm->pendingNum_.Sub(1U);
        (void)stm->Device_()->GetTaskFactory()->Recycle(taskInfo);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "task send ok: device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d."
        " task_id=%hu, task_type=%d(%s), reportCount=%u, cmdCount=%u.",
        devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, taskInfo->type, taskInfo->typeName,
        reportCount, sendSqeNum);
    return error;
}

rtError_t SubmitTaskDc(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId, int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    uint16_t taskId = 0U;
    TIMESTAMP_BEGIN(AllocTaskAndSendDc);
    error = AllocTaskAndSendDc(submitTask, stm, flipTaskId);
    TIMESTAMP_END(AllocTaskAndSendDc);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "AllocTaskAndSendDc fail, streamId=%d, taskId=%hu,"
        "taskType=%u, retCode=%#x", stm->Id_(), submitTask->id, submitTask->type, error);
    taskId = submitTask->id;
    Engine* engine = ((RawDevice*)(stm->Device_()))->Engine_();
    if (!stm->IsCtrlStream()) {
        engine->AddPendingNum();
    }

    //  step7 调用driver接口发送sqe
    if (submitTask->isNeedStreamSync != 0U) {
        if (stm->IsCtrlStream()) {
            // No need to profile and HalfEventProc for ctrl stream
            return (dynamic_cast<CtrlStream*>(stm))->Synchronize();
        }
        stm->StreamSyncLock();
        // isStreamSync para set true if need wait cq in unsink stream
        stm->SetStreamStopSyncFlag(false);
        error = engine->SyncTask(stm, static_cast<uint32_t>(submitTask->id), false, timeout, submitTask->isForceCycle);
        stm->SetStreamStopSyncFlag(true);
        stm->StreamSyncUnLock();

        COND_RETURN_INFO(error != RT_ERROR_NONE, error, "SyncTask stream_id=%u, task_id=%u, taskType=%u, result=%u",
            stm->Id_(), submitTask->id, submitTask->type, error);
        error = AllocAndSendFlipTask(taskId, stm);
        COND_RETURN_INFO(error != RT_ERROR_NONE, error,
            "AllocAndSendFlipTask stream sync stream_id=%u, task_id=%u, taskType=%u, result=%u",
            stm->Id_(), submitTask->id, submitTask->type, error);

        return error;
    }

    error = AllocAndSendFlipTask(taskId, stm);
    COND_RETURN_INFO(error != RT_ERROR_NONE, error,
        "AllocAndSendFlipTask stream_id=%u, task_id=%u, taskType=%u, result=%u",
        stm->Id_(), submitTask->id, submitTask->type, error);

    COND_RETURN_INFO(stm->IsTaskSink(), RT_ERROR_NONE,
        "AllocAndSendFlipTask stream_id=%u, task_id=%u, taskType=%u, result=%u",
        stm->Id_(), submitTask->id, submitTask->type, error);
    const uint16_t postTaskId = submitTask->id + 1U;      // 保持原有逻辑，翻转就保留低16位
    if ((postTaskId % RT_HALF_SEND_TASK_NUM) != 0U) {    // Half Event.
        return RT_ERROR_NONE;
    }

    TIMESTAMP_BEGIN(HalfEventProcV1);
    TaskInfo submitTask1 = {};
    TaskInfo *halfRecordtask = &submitTask1;
    error = stm->ProcRecordTask(halfRecordtask);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = AllocTaskAndSendDc(halfRecordtask, stm, flipTaskId);
    if (error != RT_ERROR_NONE) {
        halfRecordtask->u.eventRecordTaskInfo.event->DeleteRecordResetFromMap(halfRecordtask);
        halfRecordtask->u.eventRecordTaskInfo.event->EventIdCountSub(halfRecordtask->u.eventRecordTaskInfo.eventid);
    }
    taskId = halfRecordtask->id;
    TIMESTAMP_END(HalfEventProcV1);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "SendTask fail, streamId=%d, taskId=%hu, retCode=%#x",
        stm->Id_(), halfRecordtask->id, error);

    if (!stm->IsCtrlStream()) {
        engine->AddPendingNum();
    }
    stm->SetStreamMark(halfRecordtask);

    error = AllocAndSendFlipTask(taskId, stm);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    return RT_ERROR_NONE;
}

rtError_t AllocTaskAndSendStars(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId)
{
    StarsEngine* engine = (StarsEngine*)(((RawDevice*)(stm->Device_()))->Engine_());
    rtError_t error = engine->TryRecycleTask(stm);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Try recycle task failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    while (stm->GetLimitFlag() && (!stm->GetRecycleFlag())) {
        TIMESTAMP_BEGIN(TaskSendLimitedV1);
        engine->SendingWaitProc(stm);   // Send limited, need release complete task.
        TIMESTAMP_END(TaskSendLimitedV1);
        error = stm->CheckContextTaskSend(submitTask);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
    }

    Device *dev = stm->Device_();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();

    // 分配TaskRes, 自增Taskid
    uint16_t taskId = 0U;
    uint16_t taskResId = 0U;
    TaskInfo *taskInfo = nullptr;
    TaskFactory *taskFactory = stm->Device_()->GetTaskFactory();
    uint16_t taskPool = stm->taskResMang_->GetTaskPoolNum();

    stm->StreamLock();
    const  rtError_t status = stm->abortStatus_;
    if (status != RT_ERROR_NONE) {
        stm->StreamUnLock();
        RT_LOG(RT_LOG_ERROR,
            "stream is in abort status, device_id=%u, stream_id=%u, abort status=%u",
            devId,
            stm->Id_(),
            status);
        return status;
    }

    taskId = static_cast<uint16_t>(stm->GetLastTaskId());
    taskId = (taskId != MAX_UINT16_NUM) ? ((taskId + 1U) % MAX_UINT16_NUM) : 0U;
    taskResId = taskId % taskPool;

    RT_LOG(RT_LOG_INFO, "alloc taskinfo device_id=%u, stream_id=%d, taskResId=%u, taskResHead_=%u, "
        "taskResTail_=%u, taskPoolNum_=%u.", stm->taskResMang_->deviceId_, stm->taskResMang_->streamId_, taskResId,
        stm->taskResMang_->taskResHead_, stm->taskResMang_->taskResTail_, stm->taskResMang_->taskPoolNum_);
    TIMESTAMP_BEGIN(TaskRes_AllocTaskNormal);
    taskInfo = stm->taskResMang_->AllocTaskInfoByTaskResId(stm, taskResId, taskId, submitTask->type);
    TIMESTAMP_END(TaskRes_AllocTaskNormal);

    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;

    while (taskInfo == nullptr) {
        if (stm->GetBindFlag()) {
            stm->StreamUnLock();
            return RT_ERROR_STREAM_FULL;
        }
        stm->StreamUnLock();
        stm->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
        taskFactory->TryTaskReclaim(stm);

        error = stm->CheckContextTaskSend(submitTask);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
        stm->StreamLock();

        error = stm->abortStatus_;
        if (error != RT_ERROR_NONE) {
            stm->StreamUnLock();
            return error;
        }
        // 分配TaskRes, 自增Taskid
        taskId = static_cast<uint16_t>(stm->GetLastTaskId());
        taskId = (taskId != MAX_UINT16_NUM) ? ((taskId + 1U) % MAX_UINT16_NUM) : 0U;
        taskResId = taskId % taskPool;

        TIMESTAMP_BEGIN(TaskRes_AllocTask);
        taskInfo = stm->taskResMang_->AllocTaskInfoByTaskResId(stm, taskResId, taskId, submitTask->type);
        TIMESTAMP_END(TaskRes_AllocTask);
    }

    error =  LoadArgsInfo(submitTask, stm, taskResId);
    COND_PROC_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE),
        error, stm->StreamUnLock(); (void)taskFactory->Recycle(taskInfo);,
        "LoadArgsInfo failed.");

    submitTask->id = taskId;
    submitTask->profEn = Runtime::Instance()->GetProfileEnableFlag();
    UpdateFlipNum(submitTask, true);

    TIMESTAMP_BEGIN(SaveTaskInfo);
    SaveTaskInfo(taskInfo, submitTask);
    TIMESTAMP_END(SaveTaskInfo);
    COND_PROC(flipTaskId != nullptr, *flipTaskId = GetFlipTaskId(taskInfo->id, taskInfo->flipNum););
    engine->ReportProfData(taskInfo);

    // set stream for task after task alloc
    const uint32_t sendSqeNum = GetSendSqeNum(taskInfo);
    if (sendSqeNum > SQE_NUM_PER_STARS_TASK_MAX) {
        stm->StreamUnLock();
        RT_LOG(RT_LOG_ERROR, "sendSqeNum %u more than max num %d. task_id=%hu, task_type=%d(%s).",
            sendSqeNum, SQE_NUM_PER_STARS_TASK_MAX, taskInfo->id, static_cast<int32_t>(taskInfo->type),
            taskInfo->typeName);
        (void)stm->Device_()->GetTaskFactory()->Recycle(taskInfo);
        return RT_ERROR_INVALID_VALUE;
    }

    stm->pendingNum_.Add(1U);
    if ((stm->Model_() != nullptr) && (taskInfo->type != TS_TASK_TYPE_MODEL_MAINTAINCE)) {
        stm->Model_()->SetKernelTaskId(static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(stm->Id_()));
    }

    // step6 obp使用stream自己的taskid, 也要翻转
    TIMESTAMP_BEGIN(ToCommandV1);
    rtTsCommand_t  cmdLocal = {};
    cmdLocal.cmdType = RT_TASK_COMMAND_TYPE_STARS_SQE;
    rtStarsSqe_t *starsSqe = nullptr;
    starsSqe = cmdLocal.cmdBuf.u.starsSqe;
    ToConstructSqe(taskInfo, starsSqe);
    TIMESTAMP_END(ToCommandV1);

    // update the host-side head and tail
    error = engine->AddTaskToStream(taskInfo, sendSqeNum);
    if (error != RT_ERROR_NONE) {
        stm->pendingNum_.Sub(1U);
        stm->StreamUnLock();
        RT_LOG(RT_LOG_ERROR, "Add task failed stream_id=%d, task_id=%u.", stm->Id_(), taskInfo->id);
        (void)stm->Device_()->GetTaskFactory()->Recycle(taskInfo);
        return error;
    }

    struct halTaskSendInfo sendInfo = {};
    sendInfo.type = DRV_NORMAL_TYPE;
    sendInfo.sqe_addr = RtPtrToPtr<uint8_t *, rtStarsSqe_t *>(starsSqe);
    sendInfo.sqe_num = sendSqeNum;
    sendInfo.tsId = tsId;
    sendInfo.sqId = sqId;
    drvError_t drvRet = DRV_ERROR_NONE;

    error = engine->ProcessTaskWait(taskInfo);
    if (error != RT_ERROR_NONE) {
        stm->pendingNum_.Sub(1U);
        stm->StreamUnLock();
        RT_LOG(RT_LOG_ERROR, "ProcessTaskWait failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d."
            " task_id=%hu, task_type=%d(%s), retCode=%d.",
            devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, static_cast<int32_t>(taskInfo->type),
            taskInfo->typeName, error);
        (void)stm->Device_()->GetTaskFactory()->Recycle(taskInfo);
        return error;
    }

    // 调用driver接口发送sqe
    TIMESTAMP_BEGIN(SqTaskSendNormalV1);
    if (!stm->IsSoftwareSqEnable()) {
        drvRet = halSqTaskSend(devId, &sendInfo);
    } else {
        auto ret = memcpy_s(RtPtrToPtr<void *>(stm->GetSqeBuffer() + sizeof(rtStarsSqe_t) * taskInfo->pos),
                            sendSqeNum * sizeof(rtStarsSqe_t),
                            RtPtrToPtr<void *, rtStarsSqe_t *>(starsSqe),
                            sendSqeNum * sizeof(rtStarsSqe_t));
        if (ret != EOK) {
            RT_LOG(RT_LOG_ERROR, "memcpy_s failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
                " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%d",
                devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id,
                static_cast<uint32_t>(taskInfo->type), taskInfo->typeName, ret);
            error = RT_ERROR_TASK_BASE;
        }
    }
    
    TIMESTAMP_END(SqTaskSendNormalV1);
    beginCnt = 0ULL;
    endCnt = 0ULL;
    checkCount = 0U;
    uint32_t tryCount = 0U;
    while (unlikely(drvRet != DRV_ERROR_NONE)) {
        RT_LOG(RT_LOG_WARNING, "halSqTaskSend fail. device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
            " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%#x, drvRetCode=%d, tryCount=%u",
            devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id,
            static_cast<uint32_t>(taskInfo->type), taskInfo->typeName, static_cast<uint32_t>(error),
            static_cast<int32_t>(drvRet), tryCount);
        tryCount++;
        if (stm->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, tryCount) != RT_ERROR_NONE) {
            stm->pendingNum_.Sub(1U);
            stm->StreamUnLock();
            RT_LOG(RT_LOG_ERROR, "device status error in sq task send, device_id=%u, stream_id=%d.", devId, stm->Id_());
            return RT_ERROR_DRV_ERR;
        }
        TIMESTAMP_BEGIN(SqTaskSendV1);
        drvRet = halSqTaskSend(devId, &sendInfo);
        TIMESTAMP_END(SqTaskSendV1);
    }
    stm->StreamUnLock();

    const uint32_t posTail = stm->GetBindFlag() ? stm->GetDelayRecycleTaskSqeNum() : stm->GetTaskPosTail();
    const uint32_t posHead = stm->GetBindFlag() ? stm->GetTaskPersistentHeadValue() : stm->GetTaskPosHead();
    const uint32_t rtsqDepth = (((stm->Flags() & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : stm->GetSqDepth();
    const uint32_t newPosTail = (posTail + sendSqeNum) % rtsqDepth;
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, stream_id=%d, task_id=%hu, task_type=%u(%s), "
        "sendSqeNum=%u, isSupportASyncRecycle=%d, isNeedPostProc=%d, davinciHead=%u, davinciTail=%u, taskHead=%u, "
        "taskTail=%u, bindFlag=%d, head=%u, tail=%u, lastTail=%u, delay recycle num=%zu.",
        devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, static_cast<uint32_t>(taskInfo->type),
        taskInfo->typeName, sendSqeNum, stm->GetIsSupportASyncRecycle(), stm->IsNeedPostProc(taskInfo), stm->GetDavinciTaskHead(),
        stm->GetDavinciTaskTail(), stm->GetTaskHead(), stm->GetTaskTail(), stm->GetBindFlag(), posHead, newPosTail, posTail,
        stm->GetDelayRecycleTaskSize());
    return error;
}

rtError_t SubmitTaskStars(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId, int32_t timeout)
{
    uint16_t taskId = 0U;
    TIMESTAMP_BEGIN(AllocTaskAndSendStars);
    rtError_t error = AllocTaskAndSendStars(submitTask, stm, flipTaskId);
    StarsEngine* engine = (StarsEngine*)(((RawDevice*)(stm->Device_()))->Engine_());
    TIMESTAMP_END(AllocTaskAndSendStars);
    taskId = submitTask->id;
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "AllocTaskAndSendStars fail, streamId=%d, taskId=%hu, taskType=%u,"
        " taskName=%s, retCode=%#x", stm->Id_(), submitTask->id, submitTask->type, submitTask->typeName, error);

    engine->AddPendingNum();
    // simu stars report
    if (stm->GetBindFlag()) {
        if (stm->IsSeparateSendAndRecycle()) {
            stm->StreamRecycleLock();
            (void)engine->RecycleSeparatedStmByFinishedId(stm, submitTask->id);
            stm->StreamRecycleUnlock();
        } else {
            stm->StreamSyncLock();
            (void)engine->ProcessTask(submitTask, stm->Device_()->Id_());
            stm->StreamSyncUnLock();
        }
    }

    if (submitTask->isNeedStreamSync != 0U) {
        stm->StreamSyncLock();
        error = engine->SyncTask(stm, static_cast<uint32_t>(submitTask->id), false, timeout);
        engine->SyncTaskCheckResult(error, stm, submitTask->id);
        stm->StreamSyncUnLock();

        COND_RETURN_INFO(error != RT_ERROR_NONE, error,
            "SyncTask stream_id=%u, task_id=%u, taskType=%u, result=%u",
            stm->Id_(), submitTask->id, submitTask->type, error);
        error = AllocAndSendFlipTask(taskId, stm);
        COND_RETURN_INFO(error != RT_ERROR_NONE, error,
            "AllocAndSendFlipTask stream sync stream_id=%u, task_id=%u, taskType=%u, result=%u",
            stm->Id_(), submitTask->id, submitTask->type, error);

        return error;
    }

    error = AllocAndSendFlipTask(taskId, stm);
    COND_RETURN_INFO(error != RT_ERROR_NONE, error,
        "AllocAndSendFlipTask stream_id=%u, task_id=%u, taskType=%u, result=%u",
        stm->Id_(), submitTask->id, submitTask->type, error);

    return RT_ERROR_NONE;
}

rtError_t AllocAndSendFlipTask(uint16_t preTaskId, Stream *stm)
{
    if (!stm->IsNeedSendFlipTask(preTaskId)) {
        return RT_ERROR_NONE;
    }

    TaskInfo submitTask = {};
    TaskInfo *fliptask = &submitTask;

    RT_LOG(RT_LOG_DEBUG, "AllocAndSendFlipTask, dev_id=%u, stream_id=%d", stm->Device_()->Id_(), stm->Id_());
    rtError_t error = stm->ProcFlipTask(fliptask, stm->GetTaskIdFlipNum());
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    const bool isMilan = stm->Device_()->IsStarsPlatform();
    if (isMilan) {
        error = AllocTaskAndSendStars(fliptask, stm, nullptr);
    } else {
        error = AllocTaskAndSendDc(fliptask, stm, nullptr);
    }
    
    Engine* engine = RtPtrToPtr<Engine*>((RtPtrToPtr<RawDevice*>(stm->Device_()))->Engine_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "SendFlipTask failed, dev_id=%u, stream_id=%d, task_id=%hu, flipNumReport=%hu, retCode=%#x.",
        stm->Device_()->Id_(), stm->Id_(), fliptask->id, fliptask->u.flipTask.flipNumReport, error);
    engine->AddPendingNum();
    RT_LOG(RT_LOG_INFO, "SendFlipTask dev_id=%u, stream_id=%d, task_id=%hu, flipNum=%hu",
        stm->Device_()->Id_(), stm->Id_(), fliptask->id, fliptask->u.flipTask.flipNumReport);

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)stm->Device_()->GetTaskFactory()->Recycle(fliptask);
    return error;
}

}  // namespace runtime
}  // namespace cce
