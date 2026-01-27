/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_model_execute.h"

#include <algorithm>
#include <stack>
#include <cstring>

#include "aicpusd_resource_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_profiler.h"
#include "aicpusd_monitor.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_info.h"
#include "aicpu_event_struct.h"
#include "type_def.h"
#include "profiling_adp.h"
#include "aicpusd_event_process.h"
#include "aicpusd_context.h"
#include "dump_task.h"
#include "operator_kernel_register.h"
#include "aicpusd_model_err_process.h"

namespace {
    // model operate values
    const std::string OPERATE_VALUE[static_cast<int32_t>(AicpuSchedule::AicpuModelOperate::MODEL_OPERATE_MAX)] = {
        "LOAD",
        "EXECUTE",
        "ABORT",
        "TASK_REPORT",
        "END_GRAPH",
        "RUN_TASK",
        "DESTROY",
        "STOP",
        "RESTART",
        "CLEAR_INPUT"
    };

    // model status values
    const std::string STATUS_VALUE[static_cast<int32_t>(AicpuSchedule::AicpuModelStatus::MODEL_STATUS_MAX)] = {
        "UNINIT",
        "IDLE",
        "LOADING",
        "RUNNING",
        "ERROR",
        "ABORT",
        "STOPPED"
    };
    constexpr uint32_t HCCL_QUERY_PREPARE_INTERVAL = 20000U; // us
    constexpr uint32_t HCCL_QUERY_LOG_INTERVAL = 500U;
    constexpr char_t const *REPORT_STATUS_TASK_NAME = "modelReportStatus";
    constexpr int32_t TIMES_MS_TO_NS = 1000;
    constexpr uint32_t ASYNC_TASK_INTERVAL = 2000U; // us
    constexpr uint32_t AICPU_STREAM_TASK_DUMP_MASK = 0x01U;
}

namespace AicpuSchedule {
    constexpr int32_t INVALID_TASK_INDEX = -1;
    // attention: if change AicpuModelStatus or AicpuModelOperate define, pls update this table together.
    const bool AicpuModel::modelOperatePermission[static_cast<int32_t>(AicpuModelStatus::MODEL_STATUS_MAX)]
        [static_cast<int32_t>(AicpuModelOperate::MODEL_OPERATE_MAX)] = {
            // load, execute, abort, taskReport, endGraph, runTask, destroy, stop, restart, clearInput
            {true,  false, false, false, false, false, true, true, false, false},      // uninit
            {false, true,  false, false, true,  true,  true, true, false, false},      // idle
            {false, true,  false, false, false, false, true, true, false, false},      // loading
            {false, false, true,  true,  true,  true,  true, true, false, false},     // running
            {false, true, true,  false, false, false, true, true, false, false},      // error
            {false, true,  false, false, false, false, true, true, false, false},     // abort
            {false, false,  false, false, false, false, true, false, true, true}      // stopped
    };

    // attention: if change AicpuModelStatus or AicpuModelOperate define, pls update this table together.
    const AicpuModelStatus AicpuModel::operateNextStatus[static_cast<int32_t>(AicpuModelOperate::MODEL_OPERATE_MAX)]
        = {
            AicpuModelStatus::MODEL_STATUS_LOADING,  // load
            AicpuModelStatus::MODEL_STATUS_RUNNING,  // execute
            AicpuModelStatus::MODEL_STATUS_ABORT,    // abort
            AicpuModelStatus::MODEL_STATUS_ERROR,    // taskReport
            AicpuModelStatus::MODEL_STATUS_IDLE,     // endGraph
            AicpuModelStatus::MODEL_STATUS_MAX,      // runTask
            AicpuModelStatus::MODEL_STATUS_UNINIT,  // destroy
            AicpuModelStatus::MODEL_STATUS_STOPPED,  // stop
            AicpuModelStatus::MODEL_STATUS_IDLE,  // restart
            AicpuModelStatus::MODEL_STATUS_STOPPED,  // clearInput
    };

    void AicpuStream::InitAicpuStream(const uint32_t streamId, const std::vector<const AicpuTaskInfo *> &tasks)
    {
        const std::unique_lock<std::mutex> lockForStream(mutexForStream_);
        streamId_ = streamId;
        nextTaskIndex_ = 0LU;
        (void)std::transform(tasks.begin(), tasks.end(), std::back_inserter(tasks_),
                             [](const AicpuTaskInfo * const taskPtr) {return *taskPtr;});
    }

    void AicpuStream::ResetToStart()
    {
        const std::unique_lock<std::mutex> lockForStream(mutexForStream_);
        nextTaskIndex_ = 0LU;
    }

    void AicpuStream::ResetTasks()
    {
        aicpusd_info("Stream[%u] clear load info begin.", streamId_);
        const std::unique_lock<std::mutex> lockForStream(mutexForStream_);
        tasks_.clear();
    }

    void AicpuStream::ShowProgress()
    {
        if (nextTaskIndex_ >= tasks_.size()) {
            aicpusd_run_info("Stream[%u] is finished", streamId_);
            return;
        }
        const auto kernelName = PtrToPtr<void, char_t>(ValueToPtr(tasks_[nextTaskIndex_].kernelName));
        if (kernelName != nullptr) {
            aicpusd_run_info("Stream[%u] is at %zu task[%s] now.", streamId_, nextTaskIndex_, kernelName);
        } else {
            aicpusd_run_info("Stream[%u] is at %zu task[invalid] now.", streamId_, nextTaskIndex_);
        }
    }

    int32_t AicpuStream::ExecuteNextTask(const RunContext &runContext, bool &streamEnd)
    {
        // need lock all execute period
        const std::unique_lock<std::mutex> lockForSteam(mutexForStream_);
        if (nextTaskIndex_ >= tasks_.size()) {
            aicpusd_err("Model[%u] stream[%u] has reach task end, total taskNum[%zu], nextTaskIndex[%zu].",
                        runContext.modelId, streamId_, tasks_.size(), nextTaskIndex_);
            streamEnd = true;
            return AICPU_SCHEDULE_OK;
        }
        const auto &taskInfo = tasks_[nextTaskIndex_];
        aicpusd_info("Model[%u] stream[%u] begin to execute %zuth task, taskId[%u], kernelType[%u].",
                     runContext.modelId, streamId_, nextTaskIndex_, taskInfo.taskID, taskInfo.kernelType);
        *(const_cast<int32_t *>(&runContext.gotoTaskIndex)) = INVALID_TASK_INDEX;
        const int32_t ret = ExecuteTask(taskInfo, runContext);
        if (ret != AICPU_SCHEDULE_OK) {
            const auto model = AicpuModelManager::GetInstance().GetModel(runContext.modelId);
            uint64_t transId = UINT64_MAX;
            if (model != nullptr) {
                transId = model->GetModelTransId();
            }
            aicpusd_err("Model[%u] stream[%u] execute %zuth task failed, taskId[%u], ret[%d], transId[%lu].",
                        runContext.modelId, streamId_, nextTaskIndex_, taskInfo.taskID, ret, transId);
            nextTaskIndex_++;
            return ret;
        }
        if (runContext.pending) {
            aicpusd_info("Model[%u] stream[%u] pending on %zuth task, taskId[%u].",
                         runContext.modelId, streamId_, nextTaskIndex_, taskInfo.taskID);
        } else if (runContext.gotoTaskIndex != INVALID_TASK_INDEX) {
            nextTaskIndex_ = static_cast<size_t>(runContext.gotoTaskIndex);
            aicpusd_info("Model[%u] stream[%u] goto %zuth task, taskId[%u].",
                         runContext.modelId, streamId_, nextTaskIndex_, taskInfo.taskID);
        } else {
            aicpusd_info("Model[%u] stream[%u] execute %zuth task success, taskId[%u].",
                         runContext.modelId, streamId_, nextTaskIndex_, taskInfo.taskID);
            nextTaskIndex_++;
        }
        streamEnd = nextTaskIndex_ >= tasks_.size();
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuStream::ExecuteTask(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
    {
        if (((kernelTaskInfo.kernelType == static_cast<uint32_t>(AicpuKernelType::CCE_KERNEL)) ||
            (kernelTaskInfo.kernelType == static_cast<uint32_t>(AicpuKernelType::CCE_KERNEL_HWTS))) &&
            (kernelTaskInfo.kernelSo == 0UL)) {
            const int32_t ret = OperatorKernelRegister::Instance().RunOperatorKernel(kernelTaskInfo, taskContext);
            if (ret != AICPU_SCHEDULE_OK) {
                AicpuModelErrProc::GetInstance().RecordAicpuOpErrLog(taskContext, kernelTaskInfo, ret);
            }

            return ret;
        }

        aicpu::HwtsTsKernel aicpufwKernelInfo = {};
        const int32_t ret = ConvertToTsKernel(kernelTaskInfo, aicpufwKernelInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        AicpuMonitor::GetInstance().SetAicpuStreamTaskStartTime(taskContext.modelId);
        const int32_t retAicpu = aeCallInterface(&aicpufwKernelInfo);
        AicpuMonitor::GetInstance().SetAicpuStreamTaskEndTime(taskContext.modelId);
        if (retAicpu != AE_STATUS_SUCCESS) {
            aicpusd_err("Aicpu engine process failed, result[%d].", retAicpu);
            return retAicpu;
        }
        aicpusd_info("Aicpu engine process success.");
        // dump mask.
        if ((kernelTaskInfo.taskFlag & AICPU_STREAM_TASK_DUMP_MASK) != 0U) {
            OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
            TaskInfoExt dumpTaskInfo(taskContext.streamId, kernelTaskInfo.taskID);
            DumpFileName dumpFileName(taskContext.streamId, kernelTaskInfo.taskID);
            if (opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName) != AICPU_SCHEDULE_OK) {
                aicpusd_warn("dump op info failed, modelId[%u], streamId[%u], taskID[%u].", taskContext.modelId,
                    taskContext.streamId, kernelTaskInfo.taskID);
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuStream::ConvertToTsKernel(const AicpuTaskInfo &kernelTaskInfo,
                                           aicpu::HwtsTsKernel &aicpufwKernelInfo)
    {
        aicpufwKernelInfo.kernelType = kernelTaskInfo.kernelType;
        if (kernelTaskInfo.kernelType == static_cast<uint32_t>(AicpuKernelType::FWK_KERNEL)) {
            aicpufwKernelInfo.kernelBase.fwkKernel.kernel = kernelTaskInfo.paraBase;
        } else if ((kernelTaskInfo.kernelType == static_cast<uint32_t>(AicpuKernelType::CCE_KERNEL)) ||
                (kernelTaskInfo.kernelType == static_cast<uint32_t>(AicpuKernelType::CCE_KERNEL_HWTS))) {
            aicpufwKernelInfo.kernelBase.cceKernel.kernelName = kernelTaskInfo.kernelName;
            aicpufwKernelInfo.kernelBase.cceKernel.kernelSo = kernelTaskInfo.kernelSo;
            aicpufwKernelInfo.kernelBase.cceKernel.paramBase = kernelTaskInfo.paraBase;
        } else {
            aicpusd_err("task[%u] kernelType[%u] is invalid.", kernelTaskInfo.taskID, kernelTaskInfo.kernelType);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuStream::AttachReportStatusQueue()
    {
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        for (auto &taskInfo : tasks_) {
            const auto kernelName = PtrToPtr<const void, const char_t>(ValueToPtr(taskInfo.kernelName));
            if (kernelName == nullptr) {
                aicpusd_err("the name of kernel is nullptr.");
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
            if (std::string(kernelName) == REPORT_STATUS_TASK_NAME) {
                const ReportStatusInfo * const bufInfo =
                    PtrToPtr<void, ReportStatusInfo>(ValueToPtr(static_cast<uintptr_t>(taskInfo.paraBase)));
                if (bufInfo == nullptr) {
                    aicpusd_err("ModelReportStatus kernelTaskInfo paramBase is null, streamId[%u], taskId[%u]",
                        taskInfo.streamID, taskInfo.taskID);
                    return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
                }
                const uint32_t queueId = bufInfo->statusOutputQueue.queueId;
                const auto drvRet = halQueueAttach(deviceId, queueId, 0);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("Aicpusd attach report status queue[%u] failed, ret[%d]",
                        queueId, drvRet);
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
                aicpusd_info("Attach report status queue[%u] success.", queueId);
            }
        }
        return AICPU_SCHEDULE_OK;
    }


    int32_t AicpuModel::ModelLoad(const AicpuModelInfo * const modelInfo, const ModelCfgInfo * const cfgInfo)
    {
        if (modelInfo == nullptr) {
            aicpusd_err("Model load failed, as param is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const auto modelId = modelInfo->moduleID;
        // need lock all load period
        std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
        if (!lockForModel.owns_lock()) {
            aicpusd_err("Model[%u] load failed, as get lock failed.", modelId);
            return AICPU_SCHEDULE_ERROR_IN_WORKING;
        }

        modelId_ = modelId;
        modelTsId_ = modelInfo->tsId;
        int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_LOAD);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] checkOperateAndUpdateStatus failed, ret[%d].", modelId, ret);
            return ret;
        }
        aicpusd_info("Model[%u] load begin.", modelId);
        ret = LoadStreamAndTask(modelInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            lockForModel.unlock();
            aicpusd_err("Model[%u] load stream and task failed , ret[%d].", modelId, ret);
            const int32_t destroyRet = ModelDestroy();
            if (destroyRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] load stream and task failed and rollback failed, rollback ret[%d].",
                            modelId, destroyRet);
            }
            return ret;
        }

        // load queue info
        ret = LoadQueueInfo(modelInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            lockForModel.unlock();
            aicpusd_err("Model[%u] load queue info failed, ret[%d].", modelId, ret);
            const int32_t destroyRet = ModelDestroy();
            if (destroyRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] load queue info failed and rollback failed, rollback ret[%d].",
                            modelId, destroyRet);
            }
            aicpusd_info("Model[%u] rollback end.", modelId);
            return ret;
        }

        // attach report status queue
        ret = AttachReportStatusQueue();
        if (ret != AICPU_SCHEDULE_OK) {
            lockForModel.unlock();
            aicpusd_err("Model[%u] attach report status queue failed, ret[%d].", modelId, ret);
            const int32_t destroyRet = ModelDestroy();
            if (destroyRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] attach report status queue failed and rollback failed, rollback ret[%d].",
                            modelId, destroyRet);
            }
            aicpusd_info("Model[%u] rollback end.", modelId);
            return ret;
        }

        // load info from cfg
        ret = static_cast<int32_t>(LoadCfg(cfgInfo));
        if (ret != AICPU_SCHEDULE_OK) {
            lockForModel.unlock();
            aicpusd_err("Model[%u] load cfg failed, ret[%d].", modelId, ret);
            const int32_t destroyRet = ModelDestroy();
            if (destroyRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] load cfg failed and rollback failed, rollback ret[%d].",
                            modelId, destroyRet);
            }
            aicpusd_info("Model[%u] rollback end.", modelId);
            return ret;
        }
        // load success set isValid true;
        SetExtModelId(AicpuModelManager::GetInstance().GetExtModelId(modelId));
        isValid = true;
        endOfSequence_ = false;
        abnormalBreak_ = AicpuModelManager::GetInstance().AbnormalBreak(modelId);
        abnormalEnqueue_ = AicpuModelManager::GetInstance().AbnormalEnqueue(modelId);
        abnormalEnabled_ = AicpuModelManager::GetInstance().AbnormalEnabled(modelId);
        aicpusd_info("Model[%u] load success, abnormal break[%d], abnormal enqueue[%d], abnormal enabled[%d].",
                     modelId, static_cast<int32_t>(abnormalBreak_), static_cast<int32_t>(abnormalEnqueue_),
                     static_cast<int32_t>(abnormalEnabled_));
        int32_t msgQId = 0;
        if (AicpuModelManager::GetInstance().GetModelMsgQueues(modelId, true, msgQId) == AICPU_SCHEDULE_OK) {
            aicpusd_info("Model[%u]'s input msg queue is %d", modelId, msgQId);
            inputMsgQueueIds_.insert(static_cast<size_t>(msgQId));
        }
        if (AicpuModelManager::GetInstance().GetModelMsgQueues(modelId, false, msgQId) == AICPU_SCHEDULE_OK) {
            aicpusd_info("Model[%u]'s output msg queue is %d", modelId, msgQId);
            outputMsgQueueIds_.insert(static_cast<size_t>(msgQId));
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelExecute()
    {
        {
            const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
            if (!lockForModel.owns_lock()) {
                aicpusd_err("Model[%u] execute failed, as get lock failed.", modelId_);
                return AICPU_SCHEDULE_ERROR_IN_WORKING;
            }
            const int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_EXECUTE);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] checkOperateAndUpdateStatus failed, ret[%d].", modelId_, ret);
                return ret;
            }
        }

        const int32_t ret = ResetModelForExecute();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("model[%u] ResetModelForExecute fail", modelId_);
            return ret;
        }
        const bool isProfOpen = (&(aicpu::IsModelProfOpen) == nullptr) ? false : aicpu::IsModelProfOpen();
        aicpusd_info("Model[%u] execute begin, prof model[%d].", modelId_, isProfOpen);
        const bool hasThread = AicpuDrvManager::GetInstance().HasThread();
        // if model id is invalid, do not report profiling
        if ((!isProfOpen) || (extModelId_ == INVALID_NUMBER)) {
            ActiveOtherAicpuStreams();
            return ExecuteStream(modelS0Stream_, !hasThread);
        }
        // report start tag
        aicpu::ProfModelMessage profModelMessage("AICPU_MODEL");
        (void)profModelMessage.SetAicpuModelId(extModelId_)
            ->SetDataTagId(MSPROF_AICPU_MODEL_TAG)
            ->SetAicpuModelIterId(static_cast<uint16_t>(iteratorCount_))
            ->SetAicpuModelTimeStamp(aicpu::GetSystemTick())
            ->SetAicpuTagId(aicpu::MODEL_EXECUTE_START)
            ->SetEventId(static_cast<uint16_t>(0U))
            ->SetDeviceId(AicpuDrvManager::GetInstance().GetDeviceId());
        (void)profModelMessage.ReportProfModelMessage();
        // has thread means no need execute inline
        ActiveOtherAicpuStreams();
        return ExecuteStream(modelS0Stream_, !hasThread);
    }

    void AicpuModel::ActiveOtherAicpuStreams()
    {
        const bool syncSendFlag = GetCpuMode();
        for (const auto aicpustreamId: otherAicpuStreams_) {
            AICPUSubEventInfo subEventInfo = {};
            subEventInfo.modelId = modelId_;
            subEventInfo.para.streamInfo.streamId = aicpustreamId;

            const int32_t ret = AicpuMsgSend::SendAICPUSubEvent(
                PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
                static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
                AICPU_SUB_EVENT_ACTIVE_STREAM,
                CP_DEFAULT_GROUP_ID,
                syncSendFlag);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Send aicpu subevent failed. Event modelId is %d, streamId: %u", modelId_, aicpustreamId);
            };
        }
    }

    int32_t AicpuModel::TaskReport()
    {
        const int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_TASK_REPORT);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] taskReport failed, as CheckOperateAndUpdateStatus failed ret[%d].", modelId_, ret);
            return ret;
        }

        aicpusd_info("Model[%u] task report success", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelAbort()
    {
        // need lock all abort period
        const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
        if (!lockForModel.owns_lock()) {
            aicpusd_err("Model[%u] abort failed, as get lock failed.", modelId_);
            return AICPU_SCHEDULE_ERROR_IN_WORKING;
        }
        int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_ABORT);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] abort failed, as CheckOperateAndUpdateStatus failed ret[%d].", modelId_, ret);
            return ret;
        }

        aicpusd_info("Model[%u] abort begin.", modelId_);
        ret = ReleaseModelResource();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] abort failed, as ReleaseModelResource failed ret[%d].", modelId_, ret);
            return ret;
        }
        {
            // use write lock to wait stream execute end, don't remove it.
            (void)pthread_rwlock_wrlock(&rwlockForStream_);
            (void)pthread_rwlock_unlock(&rwlockForStream_);
        }

        aicpusd_info("Model[%u] abort success.", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelDestroy()
    {
        // need lock all destroy period
        const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
        if (!lockForModel.owns_lock()) {
            aicpusd_err("Model[%u] destroy failed, as get lock failed.", modelId_);
            return AICPU_SCHEDULE_ERROR_IN_WORKING;
        }
        int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_DESTROY);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] destroy failed, as CheckOperateAndUpdateStatus failed ret[%d].", modelId_, ret);
            return ret;
        }

        aicpusd_info("Model[%u] destroy begin, isValid=%d", modelId_, isValid);
        isValid = false;
        // destroy all resource.
        ret = ReleaseModelResource();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] destroy failed, as ReleaseModelResource failed ret[%d].", modelId_, ret);
            return ret;
        }
        DestroyModelGroups();
        ClearLoadInfo();
        aicpusd_info("Model[%u] destroy success", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelStop()
    {
        aicpusd_info("Model[%u] Begin to stop", modelId_);
        // need lock all destroy period
        const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
        if (!lockForModel.owns_lock()) {
            aicpusd_err("Model[%u] destroy failed, as get lock failed.", modelId_);
            return AICPU_SCHEDULE_ERROR_IN_WORKING;
        }
        // update status to stop
        int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_STOP);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] stop failed, as CheckOperateAndUpdateStatus failed, ret[%d].", modelId_, ret);
            return ret;
        }

        aicpusd_info("Model[%u] destroy begin, isValid=%d", modelId_, isValid);
        // destroy all resource.
        ret = ReleaseModelResource();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] stop failed, as ReleaseModelResource failed, ret[%d].", modelId_, ret);
            return ret;
        }

        // if getlock, then all streams in model is not running, so we can ensure model is stopped
        aicpusd_run_info("Model[%u] try to get stream lock", modelId_);
        (void)pthread_rwlock_wrlock(&rwlockForStream_);
        (void)pthread_rwlock_unlock(&rwlockForStream_);
        aicpusd_run_info("Model[%u] stop success", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelRestart()
    {
        aicpusd_info("Model[%u] begin to restart", modelId_);
        {
            // need lock
            const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
            if (!lockForModel.owns_lock()) {
                aicpusd_err("Model[%u] restart failed, as get lock failed.", modelId_);
                return AICPU_SCHEDULE_ERROR_IN_WORKING;
            }
            // update status to recover
            const int32_t updateRet = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_RESTART);
            if (updateRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] restart failed, as CheckOperateAndUpdateStatus failed, ret[%d].",
                    modelId_, updateRet);
                return updateRet;
            }
            aicpusd_info("Model[%u] change status success", modelId_);
        }

        AICPUSubEventInfo subEventInfo = {};
        subEventInfo.modelId = modelId_;
        const auto ret = AicpuMsgSend::SendAICPUSubEvent(
            PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
            static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
            AICPU_SUB_EVENT_REPEAT_MODEL, CP_DEFAULT_GROUP_ID, true);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Send aicpu subevent failed. Event modelId is %d", modelId_);
            return ret;
        }
        aicpusd_info("Model[%u] restart success", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelClearInput()
    {
        aicpusd_info("Model[%u] begin to clearInput", modelId_);
        // need lock
        const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
        if (!lockForModel.owns_lock()) {
            aicpusd_err("Model[%u] clear input failed, as get lock failed.", modelId_);
            return AICPU_SCHEDULE_ERROR_IN_WORKING;
        }
        // update status to recover
        const int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_CLEAR_INPUT);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] clear input failed, as CheckOperateAndUpdateStatus failed, ret[%d].", modelId_, ret);
            return ret;
        }

        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        auto clearRet = ModelClearInputQueues(inputQueueIds_, deviceId);
        if (clearRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to clear input queues");
            return clearRet;
        }

        clearRet = ModelClearInputQueues(inputMsgQueueIds_, deviceId);
        if (clearRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to clear input msg queues");
            return clearRet;
        }

        aicpusd_info("Model[%u] clearInput success", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ModelClearInputQueues(const std::unordered_set<size_t> &queueIds, const uint32_t deviceId) const
    {
        for (const auto queueId : queueIds) {
            do {
                void *mbuf = nullptr;
                const auto ret = halQueueDeQueue(deviceId, queueId, &mbuf);
                if (ret == DRV_ERROR_QUEUE_EMPTY) {
                    break;
                }
                if ((ret != DRV_ERROR_NONE) || (mbuf == nullptr)) {
                    aicpusd_err("Dequeue from queueId[%u], deviceId[%u] fail, ret is %d", queueId, deviceId,
                        static_cast<int32_t>(ret));
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
                (void) halMbufFree(PtrToPtr<void, Mbuf>(mbuf));
            } while (true);
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::Exit()
    {
        if (IsValid()) {
            isValid = false;
            const std::unique_lock<std::mutex> lockForModel(mutexForModel_);
            // destroy all resource.
            const int32_t ret = ReleaseModelResource();
            DestroyModelGroups();
            ClearLoadInfo();
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Model[%u] Exit failed, as ReleaseModelResource failed ret[%d].", modelId_, ret);
                return ret;
            }
            aicpusd_info("Model[%u] exit", modelId_);
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::EndGraph()
    {
        const std::unique_lock<std::mutex> lockForModel(mutexForModel_, std::try_to_lock);
        if (!lockForModel.owns_lock()) {
            aicpusd_err("Model[%u] end graph failed, as get lock failed.", modelId_);
            return AICPU_SCHEDULE_ERROR_IN_WORKING;
        }
        const int32_t ret = CheckOperateAndUpdateStatus(AicpuModelOperate::MODEL_OPERATE_END_GRAPH);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] end graph failed, as CheckOperateAndUpdateStatus failed ret[%d].", modelId_, ret);
            return ret;
        }
        aicpusd_info("Model[%u] end graph.", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::ActiveStream(const uint32_t streamId)
    {
        aicpusd_info("Model[%u] active stream[%u].", modelId_, streamId);
        return ExecuteStream(streamId, false);
    }

    int32_t AicpuModel::RecoverStream(const uint32_t streamId)
    {
        aicpusd_info("Model[%u] recover stream[%u].", modelId_, streamId);
        return ExecuteStream(streamId, false);
    }

    int32_t AicpuModel::ExecuteStream(const uint32_t streamId, const bool executeInline)
    {
        aicpusd_info("Model[%u] execute stream[%u] begin.", modelId_, streamId);
        uint32_t currentStreamId = streamId;
        (void)pthread_rwlock_rdlock(&rwlockForStream_);
        AicpuStream *stream = GetStreamByStreamId(currentStreamId);
        if (stream == nullptr) {
            (void)pthread_rwlock_unlock(&rwlockForStream_);
            aicpusd_err("Model[%u] execute stream[%u] failed, stream not found.", modelId_, currentStreamId);
            return AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
        }
        RunContext runContext = {.modelId = modelId_,
                                 .modelTsId = modelTsId_,
                                 .streamId = currentStreamId,
                                 .pending = false,
                                 .executeInline = executeInline,
                                 .gotoTaskIndex = 0};
        g_aicpuProfiler.SetModelId(modelId_);
        g_aicpuProfiler.SetStreamId(streamId);
        bool streamEnd = false;
        std::stack<uint32_t> streamStack;
        int32_t ret = AICPU_SCHEDULE_OK;
        while (true) {
            ret = CheckOperate(AicpuModelOperate::MODEL_OPERATE_RUN_TASK);
            if (ret != AICPU_SCHEDULE_OK) {
                break;
            }
            ret = stream->ExecuteNextTask(runContext, streamEnd);
            // check if pending or if error
            if (((ret != AICPU_SCHEDULE_OK) && (!abnormalEnabled_.load())) ||
                (ret == AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED)) {
                break;
            }

            // update model ret code
            UpdateModelRetCode(ret);
            if (executeInline) {
                uint32_t switchStreamId = INVALID_NUMBER;
                if (currentStreamId != runContext.streamId) {
                    streamStack.emplace(currentStreamId);
                    switchStreamId = runContext.streamId;
                } else if (streamEnd) {
                    if (!streamStack.empty()) {
                        switchStreamId = streamStack.top();
                        streamStack.pop();
                    }
                } else {
                    // do nothing
                }
                if (switchStreamId != INVALID_NUMBER) {
                    currentStreamId = switchStreamId;
                    runContext.streamId = currentStreamId;
                    stream = GetStreamByStreamId(currentStreamId);
                    if (stream == nullptr) {
                        aicpusd_err("Model[%u] execute stream[%u] failed as stream[%u] not found.",
                                    modelId_, streamId, currentStreamId);
                        ret = AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
                        break;
                    }
                    continue;
                }
            }
            // not inline, when pending or stream end, exit.
            if (runContext.pending || streamEnd) {
                break;
            }
        }
        (void)pthread_rwlock_unlock(&rwlockForStream_);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] execute stream[%u] failed currentStreamId[%u], ret[%d].",
                        modelId_, streamId, currentStreamId, ret);
            // execute failed, need taskReport.
            (void)TaskReport();
            ProcessModelException(modelId_);
            return ret;
        }
        aicpusd_info("Model[%u] execute stream[%u] success.", modelId_, streamId);
        return AICPU_SCHEDULE_OK;
    }

    void AicpuModel::UpdateModelRetCode(const int32_t retCode)
    {
        if ((retCode != 0) && (abnormalEnabled_.load()) && (retCode_.load() == 0)) {
            retCode_ = retCode + INNER_ERROR_BASE;
            aicpusd_run_info("Update Model[%u] retCode to %d", modelId_, retCode_.load());
        }
    }

    int32_t AicpuModel::AttachReportStatusQueue()
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        (void)pthread_rwlock_wrlock(&rwlockForStream_);
        for (auto &it : aicpuStreams_) {
            ret = it.second.AttachReportStatusQueue();
            if (ret != AICPU_SCHEDULE_OK) {
                break;
            }
        }
        (void)pthread_rwlock_unlock(&rwlockForStream_);
        return ret;
    }


    // attention: must get rwlockForStream_ lock out side.
    AicpuStream *AicpuModel::GetStreamByStreamId(const uint32_t streamId)
    {
        const auto iter = aicpuStreams_.find(streamId);
        if (iter != aicpuStreams_.end()) {
            return &(iter->second);
        }
        return nullptr;
    }

    int32_t AicpuModel::ModelRepeat()
    {
        aicpusd_info("Model[%u] ExtModel[%u] repeat begin.", modelId_, extModelId_);
        const bool isProfOpen = (&(aicpu::IsModelProfOpen) == nullptr) ? false : aicpu::IsModelProfOpen();
        if (isProfOpen && (extModelId_ != INVALID_NUMBER)) {
            // report end tag
            aicpu::ProfModelMessage profModelMessage("AICPU_MODEL");
            (void)profModelMessage.SetAicpuModelId(extModelId_)
                ->SetDataTagId(MSPROF_AICPU_MODEL_TAG)
                ->SetAicpuModelIterId(static_cast<uint16_t>(iteratorCount_))
                ->SetAicpuModelTimeStamp(aicpu::GetSystemTick())
                ->SetAicpuTagId(aicpu::MODEL_EXECUTE_END)
                ->SetEventId(static_cast<uint16_t>(0U))
                ->SetDeviceId(AicpuDrvManager::GetInstance().GetDeviceId());
            (void)profModelMessage.ReportProfModelMessage();
            aicpusd_info("ReportProfModelMessage done, iterateId=%llu", iteratorCount_);
        }
        iteratorCount_++;
        return ModelExecute();
    }

    void AicpuModel::ProcessModelException(const uint32_t modelId) const
    {
        if (AbnormalNeedBreak()) {
            return;
        }
        uint32_t runMode;
        const aicpu::status_t ret = aicpu::GetAicpuRunMode(runMode);
        if (ret != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("GetAicpuRunMode returned [%u]", ret);
            return;
        }
        // continue to execute the model.
        if (runMode == aicpu::AicpuRunMode::PROCESS_SOCKET_MODE) {
            AICPUSubEventInfo subEventInfo = {};
            subEventInfo.modelId = modelId;
            const int32_t result = AicpuMsgSend::SendAICPUSubEvent(
                PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
                static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
                AICPU_SUB_EVENT_REPEAT_MODEL, CP_DEFAULT_GROUP_ID, false);
            if (result != AICPU_SCHEDULE_OK) {
                aicpusd_err("Send aicpu subevent failed. Event modelId is %d", modelId);
            }
        }
    }

    int32_t AicpuModel::ResetModelForExecute()
    {
        const int32_t ret = ReleaseModelResource();
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        SetModelRetCode(0);
        SetModelTransId(UINT64_MAX);

        (void)pthread_rwlock_wrlock(&rwlockForStream_);
        for (auto &it : aicpuStreams_) {
            it.second.ResetToStart();
        }
        (void)pthread_rwlock_unlock(&rwlockForStream_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::CheckOperateAndUpdateStatus(const AicpuModelOperate operate)
    {
        const std::unique_lock<std::mutex> lockForModelStatus(mutexForModelStatus_);
        const int32_t operateIndex = static_cast<int32_t>(operate);
        if (!modelOperatePermission[static_cast<int32_t>(modelStatus_)][operateIndex]) {
            aicpusd_err("Model[%u] status[%s] is not allow operate[%s].",
                        modelId_,
                        STATUS_VALUE[static_cast<int32_t>(modelStatus_)].c_str(),
                        OPERATE_VALUE[operateIndex].c_str());
            return AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE;
        }
        const AicpuModelStatus dstStatus = operateNextStatus[operateIndex];
        if ((dstStatus < AicpuModelStatus::MODEL_STATUS_MAX) && (dstStatus != modelStatus_)) {
            aicpusd_info("Model[%u] status change from [%s] to [%s] as operate[%s].",
                         modelId_,
                         STATUS_VALUE[static_cast<int32_t>(modelStatus_)].c_str(),
                         STATUS_VALUE[static_cast<int32_t>(dstStatus)].c_str(),
                         OPERATE_VALUE[operateIndex].c_str());
            modelStatus_ = dstStatus;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::CheckOperate(const AicpuSchedule::AicpuModelOperate operate)
    {
        const std::unique_lock<std::mutex> lockForModelStatus(mutexForModelStatus_);
        if (modelOperatePermission[static_cast<size_t>(modelStatus_)][static_cast<size_t>(operate)]) {
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_err("Model[%u] status[%s] is not allow operate[%s].",
                    modelId_,
                    STATUS_VALUE[static_cast<size_t>(modelStatus_)].c_str(),
                    OPERATE_VALUE[static_cast<size_t>(operate)].c_str());
        return AICPU_SCHEDULE_ERROR_MODEL_STATUS_NOT_ALLOW_OPERATE;
    }

    int32_t AicpuModel::UnGardModelBuf(Mbuf *const mbuf)
    {
        const std::unique_lock<std::mutex> lockForBufFree(mutexForMbuffList_);
        return BufManager::GetInstance().UnGuardBuf(modelId_, mbuf);
    }

    int32_t AicpuModel::ReleaseModelResource()
    {
        prepareData_.dequeueIndex = 0U;
        prepareData_.lastInputMbuflistPtr = nullptr;
        inputDataPtrs_.clear();
        postpareData_.enqueueIndex = 0U;
        endOfSequence_ = false;
        retCode_ = 0;
        nullDataFlag_ = false;
        {
            const std::unique_lock<std::mutex> lockForBufFree(mutexForMbuffList_);
            BufManager::GetInstance().FreeBuf(modelId_);
        }
        (void)EventWaitManager::EndGraphWaitManager().ClearBatch({modelId_});
        (void)EventWaitManager::PrepareMemWaitManager().ClearBatch({modelId_});
        (void)EventWaitManager::AnyQueNotEmptyWaitManager().ClearBatch({modelId_});
        (void)EventWaitManager::TableUnlockWaitManager().ClearBatch({modelId_});
        {
            const std::unique_lock<std::mutex> lockForModelNotifyId(mutexForModelNotifyId_);
            (void)EventWaitManager::NotifyWaitManager().ClearBatch(modelNotifyId_);
        }
        {
            const std::unique_lock<std::mutex> lockForQueue(mutexForQueueEventSubscribed_);
            int32_t ret = EventWaitManager::QueueNotEmptyWaitManager().ClearBatch(inputQueueIds_);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
            ret = EventWaitManager::QueueNotFullWaitManager().ClearBatch(outputQueueIds_);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
        }

        int32_t msgRet = EventWaitManager::QueueNotEmptyWaitManager().ClearBatch(inputMsgQueueIds_);
        if (msgRet != AICPU_SCHEDULE_OK) {
            return msgRet;
        }
        msgRet = EventWaitManager::QueueNotFullWaitManager().ClearBatch(outputMsgQueueIds_);
        if (msgRet != AICPU_SCHEDULE_OK) {
            return msgRet;
        }
        if (hcclInitType_ == HcclInitType::INIT_TYPE_FOR_EMBEDDING) {
            HcclComm *commHandle = AicpuModelManager::GetInstance().GetHcclComm();
            if (commHandle != nullptr) {
                aicpusd_info("abort hccl for tag:%d", hcclTag_);
                StubHcclAbortSelf(*commHandle, hcclTag_);
            }
        }

        StopAsyncThread();
        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        if (deployCtx != DeployContext::DEVICE) {
            for (auto &item : inputBufPools_) {
                (void)item.second.FreeAll();
            }
            for (auto &item : outputBufPools_) {
                (void)item.second.FreeAll();
            }
        }

        ClearAllLockedTable();
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::LoadStreamAndTask(const AicpuModelInfo * const modelInfo)
    {
        if (static_cast<int32_t>(modelInfo->streamInfoNum) == 0) {
            aicpusd_err("Load model[%u] failed as stream num is 0.", modelId_);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const auto infoPtr = reinterpret_cast<const StreamInfo *>(static_cast<uintptr_t>(modelInfo->streamInfoPtr));
        if (infoPtr == nullptr) {
            aicpusd_err("Load model[%u] failed as streamInfoPtr is null.", modelId_);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        (void)pthread_rwlock_wrlock(&rwlockForStream_);
        modelS0Stream_ = INVALID_NUMBER;
        // collect all stream information in the model.
        for (uint32_t i = 0U; i < static_cast<uint32_t>(modelInfo->streamInfoNum); i++) {
            auto &streamInfo = infoPtr[i];
            allStreams_.emplace_back(streamInfo);
            aicpusd_info("Load model[%u] stream[%u]", modelId_, streamInfo.streamID);
            if ((streamInfo.streamFlag & AICPU_STREAM_INDEX) != 0U) {
                if ((streamInfo.streamFlag & HEAD_STREAM_INDEX) == 0U) {
                    otherAicpuStreams_.emplace_back(streamInfo.streamID);
                    continue;
                }
                if (modelS0Stream_ != INVALID_NUMBER) {
                    (void)pthread_rwlock_unlock(&rwlockForStream_);
                    aicpusd_err("load model[%u] failed as stream[%u] and stream[%u] are both s0 stream.",
                                modelId_, modelS0Stream_, streamInfo.streamID);
                    return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
                }
                aicpusd_info("Load model[%u] modelS0Stream[%u]", modelId_, streamInfo.streamID);
                modelS0Stream_ = streamInfo.streamID;
            } else {
                if (reportStream_ == INVALID_NUMBER) {
                    aicpusd_info("Load model[%u] reportStream[%u].", modelId_, streamInfo.streamID);
                    reportStream_ = streamInfo.streamID;
                }
            }
        }
        if (modelS0Stream_ == INVALID_NUMBER) {
            (void)pthread_rwlock_unlock(&rwlockForStream_);
            aicpusd_err("load model[%u] failed as no s0 stream found.", modelId_);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        ModelStreamManager::GetInstance().Reg(modelId_, allStreams_);
        const auto aicpuTaskNum = modelInfo->aicpuTaskNum;
        if (static_cast<int32_t>(aicpuTaskNum) == 0) {
            (void)pthread_rwlock_unlock(&rwlockForStream_);
            aicpusd_err("load model[%u] failed as aicpuTaskNum is 0.", modelId_);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const auto taskPtr = PtrToPtr<void, AicpuTaskInfo>(ValueToPtr(modelInfo->aicpuTaskPtr));
        if (taskPtr == nullptr) {
            (void)pthread_rwlock_unlock(&rwlockForStream_);
            aicpusd_err("Load model[%u] failed as aicpuTaskPtr is null.", modelId_);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        std::unordered_map<uint32_t, std::vector<const AicpuTaskInfo *>> streamTasks;
        for (size_t i = 0U; i < aicpuTaskNum; i++) {
            const uint32_t streamId = taskPtr[i].streamID;
            LoadWaitNotifyId(taskPtr[i], modelNotifyId_);
            streamTasks[streamId].emplace_back(&taskPtr[i]);
            aicpusd_info("Task: taskID[%u], streamId[%u], kernelType[%u], "
                         "kernelName[%lu], kernelSo[%lu], taskFlag[%u].",
                         taskPtr[i].taskID, taskPtr[i].streamID, taskPtr[i].kernelType,
                         taskPtr[i].kernelName, taskPtr[i].kernelSo, taskPtr[i].taskFlag);
        }

        for (auto &streamTask : streamTasks) {
            aicpuStreams_[streamTask.first].InitAicpuStream(streamTask.first, streamTask.second);
            aicpusd_info("Model[%u] aicpu stream[%u] has %zu tasks.",
                         modelId_, streamTask.first, streamTask.second.size());
        }
        (void)pthread_rwlock_unlock(&rwlockForStream_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::LoadQueueInfo(const AicpuModelInfo * const modelInfo)
    {
        aicpusd_info("LoadQueueInfo for model[%u] begin.", modelId_);
        if (static_cast<int32_t>(modelInfo->queueSize) == 0) {
            aicpusd_info("Model[%u] queueSize is 0, no need load queue info.", modelId_);
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_info("Task queue size[%u].", modelInfo->queueSize);
        const auto infoPtr = PtrToPtr<void, QueInfo>(ValueToPtr(modelInfo->queueInfoPtr));
        if (infoPtr == nullptr) {
            aicpusd_info("Model[%u] load not success, as queueSize[%u] but queueInfoPtr is null.",
                         modelId_, modelInfo->queueSize);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const std::unique_lock<std::mutex> lockForQueue(mutexForQueueEventSubscribed_);
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        auto drvRet = halQueueInit(deviceId);
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
            aicpusd_err("halQueueInit error, deviceId[%u], ret[%d]", deviceId, drvRet);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        int32_t ret = AICPU_SCHEDULE_OK;
        for (int32_t i = 0; i < static_cast<int32_t>(modelInfo->queueSize); i++) {
            if (infoPtr[i].flag == static_cast<uint32_t>(QueueDirectionFlag::QUEUE_CLIENT_INPUT_FLAG) ||
                infoPtr[i].flag == static_cast<uint32_t>(QueueDirectionFlag::QUEUE_CLIENT_OUTPUT_FLAG)) {
                aicpusd_info("it is qlient qs flag[%d] = [%u]", i, infoPtr[i].flag);
                continue;
            }
            if (infoPtr[i].flag == static_cast<uint32_t>(QueueDirectionFlag::QUEUE_INPUT_FLAG)) {
                QueueSetInputPara inPutParam = {};
                QueueSetInput inPut = {};
                inPut.queSetWorkMode.qid = infoPtr[i].queueID;
                inPut.queSetWorkMode.workMode = QUEUE_MODE_PULL;
                inPutParam.inBuff = static_cast<void *>(&inPut);
                inPutParam.inLen = static_cast<uint32_t>(sizeof(QueueSetInput));
                drvRet = halQueueAttach(deviceId, infoPtr[i].queueID, 0);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("Aicpusd attached queue[%u] failed ret[%d]", infoPtr[i].queueID, drvRet);
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
                drvRet = halQueueSet(0U, QUEUE_SET_WORK_MODE, &inPutParam);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("Aicpusd set work mode for queue[%u] failed ret[%d]", infoPtr[i].queueID,
                        static_cast<int32_t>(drvRet));
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
                ret = AicpuDrvManager::GetInstance().SubscribeQueueNotEmptyEvent(infoPtr[i].queueID);
                (void) inputQueueIds_.insert(infoPtr[i].queueID);
                aicpusd_run_info("Load model, model[%u], input queue[%u].", modelId_, infoPtr[i].queueID);
            } else if (infoPtr[i].flag == static_cast<uint32_t>(QueueDirectionFlag::QUEUE_OUTPUT_FLAG)) {
                drvRet = halQueueAttach(deviceId, infoPtr[i].queueID, 0);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("Aicpusd attached queue[%u] failed ret[%d]", infoPtr[i].queueID, drvRet);
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
                ret = AicpuDrvManager::GetInstance().SubscribeQueueNotFullEvent(infoPtr[i].queueID);
                (void) outputQueueIds_.insert(infoPtr[i].queueID);
                aicpusd_run_info("Load model, model[%u], output queue[%u].", modelId_, infoPtr[i].queueID);
            } else {
                aicpusd_err("queue[%u] flag[%u] is unknown.", infoPtr[i].queueID, infoPtr[i].flag);
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }

            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to subscribe the event of queue, ret[%d].", ret);
                AicpuMonitor::GetInstance().SendKillMsgToTsd();
                return ret;
            }
            queueEventSubscribedInfo_.emplace_back(infoPtr[i]);
        }
        inputsIsDequeue_.resize(inputQueueIds_.size(), false);
        aicpusd_info("LoadQueueInfo for model[%u] end.", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuModel::InitBufPool(const ModelCfgInfo * const cfgInfo)
    {
        if (((cfgInfo->inputNum > 0U) && ((cfgInfo->inBuffPoolSizeAddr == 0U) || (cfgInfo->inBuffSizeAddr == 0U))) ||
            ((cfgInfo->outputNum > 0U) && ((cfgInfo->outBuffPoolSizeAddr == 0U) || (cfgInfo->outBuffSizeAddr == 0U)))) {
            aicpusd_err("Invalid bufferPool config for inputNum[%u], outputNum[%u].",
                cfgInfo->inputNum, cfgInfo->outputNum);
            return RET_FAILED;
        }

        int32_t ret = RET_SUCCESS;
        std::vector<MBufferPool *> poolsToRecover;
        const ScopeGuard mbufGuard([&poolsToRecover, this]() {
            if (poolsToRecover.empty()) {
                return;
            }
            for (auto pool : poolsToRecover) {
                pool->UnInit();
            }
            inputBufPools_.clear();
            outputBufPools_.clear();
        });

        uint16_t *const inputBlockNum = PtrToPtr<void, uint16_t>(ValueToPtr(cfgInfo->inBuffPoolSizeAddr));
        uint64_t *const inputBlockSize = PtrToPtr<void, uint64_t>(ValueToPtr(cfgInfo->inBuffSizeAddr));
        for (uint32_t inputIndex = 0U; inputIndex < cfgInfo->inputNum; inputIndex++) {
            ret = inputBufPools_[inputIndex].Init(inputBlockNum[inputIndex], inputBlockSize[inputIndex],
                cfgInfo->memoryRegister);
            if (ret != RET_SUCCESS) {
                aicpusd_err("Fail to init inputBufPool[%u:%lu], ret is %d",
                    inputBlockNum[inputIndex], inputBlockSize[inputIndex], ret);
                return ret;
            }
            poolsToRecover.emplace_back(&inputBufPools_[inputIndex]);
        }

        uint16_t *const outputBlockNum = PtrToPtr<void, uint16_t>(ValueToPtr(cfgInfo->outBuffPoolSizeAddr));
        uint64_t *const outputBlockSize = PtrToPtr<void, uint64_t>(ValueToPtr(cfgInfo->outBuffSizeAddr));
        for (uint32_t outputIndex = 0U; outputIndex < cfgInfo->outputNum; outputIndex++) {
            ret = outputBufPools_[outputIndex].Init(outputBlockNum[outputIndex], outputBlockSize[outputIndex],
                cfgInfo->memoryRegister);
            if (ret != RET_SUCCESS) {
                aicpusd_err("Fail to init outputBufPool[%u:%lu], ret is %d",
                    outputBlockNum[outputIndex], outputBlockSize[outputIndex], ret);
                return ret;
            }
            poolsToRecover.emplace_back(&outputBufPools_[outputIndex]);
        }

        poolsToRecover.clear();
        return ret;
    }

    StatusCode AicpuModel::LoadCfgForEmbedding(const ModelCfgInfo * const cfgInfo)
    {
        hcclInitType_ = HcclInitType::INIT_TYPE_FOR_EMBEDDING;
        // register memory in initbufpool, this action should be done before AssociateWorkers
        const auto ret = InitBufPool(cfgInfo);
        if (ret != RET_SUCCESS) {
            aicpusd_err("InitBufPoll fail for model[%u], ret is %d", modelId_, ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        HcclComm *commHandle = AicpuModelManager::GetInstance().GetHcclComm();
        if (commHandle == nullptr) {
            aicpusd_err("Hcom has not been initialized.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        uint32_t *clientRanks = PtrToPtr<void, uint32_t>(ValueToPtr(cfgInfo->clientRankAddr));
        if ((cfgInfo->clientRankNum > 0U) && (clientRanks == nullptr)) {
            aicpusd_err("Invalid clientRanks");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // memoryRegister:true means lookup, then need associate
        if (cfgInfo->memoryRegister) {
            const auto hcclRet = StubHcclPsAssociateWorkers(*commHandle, cfgInfo->tagId,
                clientRanks, cfgInfo->clientRankNum);
            if (hcclRet != HCCL_SUCCESS) {
                aicpusd_err("Create resource for tag[%d] fail, ret is %d.",
                    cfgInfo->tagId, static_cast<int32_t>(hcclRet));
                return AICPU_SCHEDULE_ERROR_CALL_HCCL;
            }
            aicpusd_info("Success to create resource for tag[%d] of model[%u].", cfgInfo->tagId, modelId_);
        }

        isSupportCounterFilter_ = cfgInfo->supportCounterFilter;
        aicpusd_info("kModelWithEmbedding isSupportCounterFilter[%d].", static_cast<int32_t>(isSupportCounterFilter_));
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModel::LoadCfgForSyncEvent(const ModelCfgInfo * const cfgInfo)
    {
        hcclInitType_ = HcclInitType::INIT_TYPE_FOR_SYNC_EVENT;
        const auto groupRet = InitModelGroups(cfgInfo);
        if (groupRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("InitModelGroups fail for model[%u].", modelId_);
            return groupRet;
        }
        const auto ret = PrepareHcclLink(cfgInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("PrepareHcclLink fail for model[%u].", modelId_);
            return ret;
        }
        const auto bufRet = InitBufPool(cfgInfo);
        if (bufRet != RET_SUCCESS) {
            aicpusd_err("InitBufPoll fail for model[%u], ret is %d", modelId_, bufRet);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        isSupportCounterFilter_ = cfgInfo->supportCounterFilter;
        aicpusd_info("kModelWithSyncEvent isSupportCounterFilter[%d].", static_cast<int32_t>(isSupportCounterFilter_));
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModel::LoadCfg(const ModelCfgInfo * const cfgInfo)
    {
        if (cfgInfo == nullptr) {
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_info("LoadCfg for model[%u].", modelId_);

        if (cfgInfo->modelType == static_cast<uint32_t>(kModelWithEmbedding)) {
            const auto ret = LoadCfgForEmbedding(cfgInfo);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
        } else if (cfgInfo->modelType == static_cast<uint32_t>(kModelWithSyncEvent)) {
            const auto ret = LoadCfgForSyncEvent(cfgInfo);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
        } else {
            aicpusd_err("Invalid model type: %u", cfgInfo->modelType);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        hcclTag_ = cfgInfo->tagId;
        psId_ = cfgInfo->psId;
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModel::PrepareHcclLink(const ModelCfgInfo * const cfgInfo)
    {
        const ModelCommOpList *const commOps =
            PtrToPtr<void, ModelCommOpList>(ValueToPtr(cfgInfo->modelCommOpListAddr));
        if (commOps == nullptr) {
            aicpusd_err("Null commops");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const uint32_t opNum = commOps->opNum;
        const HcomOpDesc * const opList = PtrToPtr<void, HcomOpDesc>(ValueToPtr(commOps->commOpDescsListAddr));
        if ((opNum == 0U) || (opList == nullptr)) {
            aicpusd_err("Empty opList");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        std::vector<HcomRequest> requests;
        for (size_t i = 0U; i < static_cast<size_t>(opNum); ++i) {
            HcomRequest req = {};
            const auto ret = StubHcomPrepareStart(&opList[i], &req);
            if (ret != HCCL_SUCCESS) {
                aicpusd_err("StubHcomPrepareStart fail, ret is %d", static_cast<int32_t>(ret));
                return AICPU_SCHEDULE_ERROR_CALL_HCCL;
            }
            requests.emplace_back(req);
        }

        aicpusd_run_info("Begin to test whether prepareStart is finished");
        for (auto req: requests) {
            HcomStatus status = {};
            uint32_t tries = 0U;
            while (true) {
                const auto ret = StubHcomPrepareQuery(req, &status);
                if ((ret != HCCL_SUCCESS) || (status.status == STATUS_FAILED)) {
                    aicpusd_err("StubHcomPrepareQuery fail");
                    return AICPU_SCHEDULE_ERROR_CALL_HCCL;
                }
                if (status.status == STATUS_SUCCESS) {
                    break;
                }
                (void)usleep(HCCL_QUERY_PREPARE_INTERVAL);
                if ((++tries % HCCL_QUERY_LOG_INTERVAL) == 0U) {
                    aicpusd_run_info("[%u]th test prepareStart", tries);
                }
            }
        }
        aicpusd_run_info("PrepareStart finished");
        return AICPU_SCHEDULE_OK;
    }

    void AicpuModel::LoadWaitNotifyId(const AicpuTaskInfo &aicpuTaskInfo,
                                      std::unordered_set<size_t> &waitNotifyIdSet) const
    {
        // waitNotify task so is null and type is cce or aicpu
        if ((aicpuTaskInfo.kernelSo != 0U) || ((aicpuTaskInfo.kernelType != aicpu::KERNEL_TYPE_CCE) &&
                                              (aicpuTaskInfo.kernelType != aicpu::KERNEL_TYPE_AICPU))) {
            return;
        }
        const auto kernelName = PtrToPtr<void, char_t>(ValueToPtr(aicpuTaskInfo.kernelName));
        if ((kernelName == nullptr) || (std::string(kernelName) != "waitNotify")) {
            return;
        }
        const auto notifyId = PtrToPtr<void, uint32_t>(ValueToPtr(aicpuTaskInfo.paraBase));
        if (notifyId == nullptr) {
            aicpusd_warn("Stream[%u] taskId[%u] is waitNotify, but paraBase is null.",
                         aicpuTaskInfo.streamID, aicpuTaskInfo.taskID);
            return;
        }
        (void)waitNotifyIdSet.emplace(*notifyId);
        aicpusd_info("Model[%u] stream[%u] taskId[%u] use notifyId[%u]",
                     modelId_, aicpuTaskInfo.streamID, aicpuTaskInfo.taskID, *notifyId);
    }

    void AicpuModel::ClearLoadInfo()
    {
        aicpusd_info("Model[%u] clear load info begin.", modelId_);
        isDestroyModel_ = true;
        (void)pthread_rwlock_wrlock(&rwlockForStream_);
        ModelStreamManager::GetInstance().UnReg(modelId_, allStreams_);
        allStreams_.clear();
        for (auto &it: aicpuStreams_) {
            it.second.ShowProgress();
            it.second.ResetTasks();
        }
        aicpuStreams_.clear();
        otherAicpuStreams_.clear();

        (void)pthread_rwlock_unlock(&rwlockForStream_);
        {
            const std::unique_lock<std::mutex> lockForQueue(mutexForQueueEventSubscribed_);
            for (QueInfo &itQueueInfo : queueEventSubscribedInfo_) {
                if (itQueueInfo.flag == static_cast<uint32_t>(QueueDirectionFlag::QUEUE_INPUT_FLAG)) {
                    (void) AicpuDrvManager::GetInstance().UnSubscribeQueueNotEmptyEvent(itQueueInfo.queueID);
                    QueueSetInputPara inPutParam;
                    QueueSetInput inPut;
                    inPut.queSetWorkMode.qid = itQueueInfo.queueID;
                    inPut.queSetWorkMode.workMode = QUEUE_MODE_PUSH;
                    inPutParam.inBuff = static_cast<void *>(&inPut);
                    inPutParam.inLen = static_cast<uint32_t>(sizeof(QueueSetInput));
                    (void)halQueueSet(0U, QUEUE_SET_WORK_MODE, &inPutParam);
                } else if (itQueueInfo.flag == static_cast<uint32_t>(QueueDirectionFlag::QUEUE_OUTPUT_FLAG)) {
                    (void) AicpuDrvManager::GetInstance().UnSubscribeQueueNotFullEvent(itQueueInfo.queueID);
                } else {
                    // ignore unknown flag
                    aicpusd_err("queue[%u] flag[%u] is unknown.", itQueueInfo.queueID, itQueueInfo.flag);
                }
            }
            queueEventSubscribedInfo_.clear();
            inputQueueIds_.clear();
            outputQueueIds_.clear();
        }
        {
            const std::unique_lock<std::mutex> lockForModelNotifyId(mutexForModelNotifyId_);
            modelNotifyId_.clear();
        }

        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        if (deployCtx != DeployContext::DEVICE) {
            for (auto &item : inputBufPools_) {
                item.second.UnInit();
            }
            inputBufPools_.clear();

            for (auto &item : outputBufPools_) {
                item.second.UnInit();
            }
            outputBufPools_.clear();
        }

        ClearGatheredMbuf();
        if (hcclInitType_ == HcclInitType::INIT_TYPE_FOR_EMBEDDING) {
            HcclComm *commHandle = AicpuModelManager::GetInstance().GetHcclComm();
            if (commHandle != nullptr) {
                aicpusd_info("destroy resource for tag:%d", hcclTag_);
                (void)StubHcclDestroyResouce(*commHandle, hcclTag_);
            }
        }

        for (const auto inputMsgQ : inputMsgQueueIds_) {
            (void) AicpuDrvManager::GetInstance().UnSubscribeQueueNotEmptyEvent(static_cast<uint32_t>(inputMsgQ));
        }
        inputMsgQueueIds_.clear();
        for (const auto outputMsgQ : outputMsgQueueIds_) {
            (void) AicpuDrvManager::GetInstance().UnSubscribeQueueNotFullEvent(static_cast<uint32_t>(outputMsgQ));
        }
        outputMsgQueueIds_.clear();
        // clear model id
        iteratorCount_ = 0UL;
        aicpusd_info("Model[%u] clear load info end.", modelId_);
    }

    StatusCode AicpuModel::InitModelGroups(const ModelCfgInfo * const cfgInfo)
    {
        if (cfgInfo->commGroupsAddr == 0UL) {
            return AICPU_SCHEDULE_OK;
        }
        const CommGroups *const commGrups = PtrToPtr<void, CommGroups>(ValueToPtr(cfgInfo->commGroupsAddr));
        uint32_t index = 0;
        for (index = 0; index < commGrups->groupNum; index++) {
            const auto ret = StubHcomCreateGroup(commGrups->groups[index].groupName, commGrups->groups[index].rankNum,
                                                 commGrups->groups[index].rankIds);
            if (ret != HCCL_SUCCESS) {
                aicpusd_err("StubHcomCreateGroup fail, ret is %d", static_cast<int32_t>(ret));
                return AICPU_SCHEDULE_ERROR_CALL_HCCL;
            }
            // 将group存储下来在model destroy的时候要destroy对应的group
            if (commGrups->groups[index].groupName != nullptr) {
                groupList_.push_back(commGrups->groups[index].groupName);
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    void AicpuModel::DestroyModelGroups()
    {
        for (auto &group : groupList_) {
            const auto ret = StubHcomDestroyGroup(group.c_str());
            if (ret != HCCL_SUCCESS) {
                aicpusd_err("StubHcomDestroyGroup fail, ret is %d, name:%s", static_cast<int32_t>(ret), group.c_str());
            } else {
                aicpusd_info("StubHcomDestroyGroup success name:%s", group.c_str());
            }
        }
        groupList_.clear();
    }

    StoreResult AicpuModel::StoreDequedMbuf(const uint64_t transId, const uint32_t routeLabel,
        const size_t qIndex, Mbuf *const mbuf, const uint32_t queueCount)
    {
        // first get exception transids, then discard mbuf which belong to exption transid
        // if mbuf is not belong to exption transid, then store
        if (IsTransIdException(transId)) {
            aicpusd_info("Discard mbuf[%u:%u] in model[%u] for it was exception.", transId, routeLabel, modelId_);
            halMbufFree(mbuf);
            return StoreResult::ABORT_STORE;
        }
        if (gatheredMbuf_[transId][routeLabel].Init(queueCount) &&
            gatheredMbuf_[transId][routeLabel].Store(qIndex, mbuf, gatheredMbufCntList_)) {
            aicpusd_info("Model[%u] Store mbuf[%u:%u] into [%u]th queue, queuesize[%llu].", modelId_, transId,
                         routeLabel, qIndex, gatheredMbufCntList_[qIndex]);
            return StoreResult::SUCCESS_STORE;
        }

        aicpusd_err("Failed to store mbuf in Model[%u] transId:%llu, routeLabel:%u", modelId_, transId, routeLabel);
        return StoreResult::FAIL_STORE;
    }

    void AicpuModel::ClearExceptionStore()
    {
        std::vector<int64_t> transIdsToClear;
        GetExcptionTransIdsToClear(transIdsToClear);
        for (const auto transId : transIdsToClear) {
            auto transIdIter = gatheredMbuf_.find(transId);
            if (transIdIter == gatheredMbuf_.end()) {
                continue;
            }
            for (auto &routeLabelIter : transIdIter->second) {
                auto &mbufStore = routeLabelIter.second;
                aicpusd_info("clear exception for transid[%lu], routelabel[%u]", transIdIter->first,
                    routeLabelIter.first);
                mbufStore.Free(&gatheredMbufCntList_);
            }
            gatheredMbuf_.erase(transId);
        }
        UpdateExcptionTransIdsStatus(transIdsToClear);
    }

    GatherResult AicpuModel::SelectGatheredMbuf(Mbuf ***const mbufPptr, const int32_t timeOut, const uint32_t cacheNum)
    {
        std::pair<uint64_t, uint32_t> mbufKey = {UINT64_MAX, UINT32_MAX};
        // first get transids which need to clear, clear them, then mark transid to cleared
        ClearExceptionStore();
        const auto ret = GatherDequedMbuf(mbufPptr, mbufKey, timeOut, cacheNum);
        if (ret != GatherResult::UN_SELECTED) {
            aicpusd_info("[%u:%u] is selected in Model[%u], ret is %d", mbufKey.first, mbufKey.second,
                         modelId_, static_cast<int32_t>(ret));
            ClearDequedMbuf(mbufKey.first, mbufKey.second);
        }
        return ret;
    }

    GatherResult AicpuModel::GatherDequedMbuf(Mbuf ***const mbufPptr, std::pair<uint64_t, uint32_t> &mbufKey,
        const int32_t timeOutMs, const uint32_t cacheNum)
    {
        const uint32_t timeOutNs = static_cast<uint32_t>(timeOutMs * TIMES_MS_TO_NS);
        AICPUSD_CHECK(timeOutNs < UINT_MAX, GatherResult::UN_SELECTED, "Invalid timeout value %ld ms.", timeOutMs);
        const uint64_t minBirthDay = GetCurrentTime() - timeOutNs;
        uint64_t count = 0U;
        bool timeoutCandidate = false;
        bool countoutCandidate = false;
        std::pair<uint64_t, uint32_t> timeOutKey = {UINT64_MAX, UINT32_MAX};
        std::pair<uint64_t, uint32_t> countOutKey = {UINT64_MAX, UINT32_MAX};
        for (auto &transIdIter: gatheredMbuf_) {
            auto &routeLabelMap = transIdIter.second;
            for (auto &routeLabelIter: routeLabelMap) {
                count++;
                auto &mbufStore = routeLabelIter.second;
                if (!mbufStore.IsReady()) {
                    if ((timeOutMs > 0) && (mbufStore.BirthDay() < minBirthDay)) {
                        timeOutKey.first = transIdIter.first;
                        timeOutKey.second = routeLabelIter.first;
                        timeoutCandidate = true;
                    }

                    if ((cacheNum > 0U) &&
                        ((transIdIter.first <= countOutKey.first) && (routeLabelIter.first < countOutKey.second))) {
                        countOutKey.first = transIdIter.first;
                        countOutKey.second = routeLabelIter.first;
                        countoutCandidate = true;
                    }
                    continue;
                }

                mbufKey.first = transIdIter.first;
                mbufKey.second = routeLabelIter.first;
                if (mbufStore.Consume(mbufPptr, gatheredMbufCntList_)) {
                    return GatherResult::SELECTED;
                }
            }
        }

        if ((countoutCandidate && (count > cacheNum))) {
            mbufKey.first = countOutKey.first;
            mbufKey.second = countOutKey.second;
            if (gatheredMbuf_[mbufKey.first][mbufKey.second].Consume(mbufPptr, gatheredMbufCntList_)) {
                aicpusd_info("pass [%u:%u] for count[%u] > cache[%u]", mbufKey.first, mbufKey.second, count, cacheNum);
                return GatherResult::FAKE_SELECTED;
            }
        }
        if (timeoutCandidate) {
            mbufKey.first = timeOutKey.first;
            mbufKey.second = timeOutKey.second;
            if (gatheredMbuf_[mbufKey.first][mbufKey.second].Consume(mbufPptr, gatheredMbufCntList_)) {
                aicpusd_info("pass [%u:%u] for timeout[%d] ms", mbufKey.first, mbufKey.second, timeOutMs);
                return GatherResult::FAKE_SELECTED;
            }
        }

        return GatherResult::UN_SELECTED;
    }

    void AicpuModel::ClearDequedMbuf(const uint64_t transId, const uint32_t routeLabel)
    {
        if (gatheredMbuf_[transId][routeLabel].IsEmpty()) {
            (void)gatheredMbuf_[transId].erase(routeLabel);
        }
        if (gatheredMbuf_[transId].empty()) {
            (void)gatheredMbuf_.erase(transId);
        }
    }

    void AicpuModel::ClearGatheredMbuf()
    {
        for (auto &transIdIter : gatheredMbuf_) {
            for (auto &routeLabelIter : transIdIter.second) {
                routeLabelIter.second.Free(&gatheredMbufCntList_);
            }
        }
        gatheredMbuf_.clear();
        gatheredMbufCntList_.clear();
    }

    void AicpuModel::RecordLockedTable(const uint32_t tableId)
    {
        if (tableLocked_.find(tableId) == tableLocked_.end()) {
            tableLocked_[tableId] = 1U;
        } else {
            tableLocked_[tableId]++;
        }
    }

    void AicpuModel::ClearLockedTable(const uint32_t tableId)
    {
        if ((tableLocked_.find(tableId) == tableLocked_.end()) || (tableLocked_[tableId] == 0U)) {
            return;
        }

        if (--tableLocked_[tableId] == 0U) {
            (void)tableLocked_.erase(tableId);
        }
    }

    bool AicpuModel::IsTableLocked(const uint32_t tableId)
    {
        return tableLocked_.find(tableId) != tableLocked_.end();
    }

    void AicpuModel::ClearAllLockedTable()
    {
        for (auto iter = tableLocked_.begin(); iter != tableLocked_.end(); iter++) {
            aicpusd_run_info("Model[%u] has locked table[%u] %u times.", modelId_, iter->first, iter->second);
            for (uint32_t i = 0U; i < iter->second; i++) {
                TableLockManager::GetInstance().UnLockTable(iter->first);
            }
        }
        tableLocked_.clear();
        if (tableTryLock_ != INVALID_TABLE_ID) {
            aicpusd_run_info("Model[%u] was trying to lock table[%d]", modelId_, tableTryLock_);
            tableTryLock_ = INVALID_TABLE_ID;
        }
    }

    uint32_t &AicpuModel::GetInputConsumeNumRef()
    {
        return inputConsumeNum_;
    }

    int32_t AicpuModel::AddAsyncTask(const AsyncTaskInfo &task)
    {
        aicpusd_info("model[%u] lock for adding async task.", modelId_);
        const std::unique_lock<std::mutex> lockForAsyncTask(mutexForAsyncTask_);
        aicpusd_info("model[%u] add async task.", modelId_);
        asyncTasks_.push_back(task);
        if (asyncTaskThreads_.empty()) {
            asyncTaskRunning_ = true;
            AICPUSD_EXCEPTION_CATCH(asyncTaskThreads_.emplace_back(&AicpuModel::ReleaseMem, this), return AICPU_SCHEDULE_ERROR_INNER_ERROR);
            aicpusd_run_info("model[%u] start thread for async task success.", modelId_);
        }
        aicpusd_info("model[%u] add async task finish.", modelId_);
        return AICPU_SCHEDULE_OK;
    }

    void AicpuModel::ReleaseMem()
    {
        AsyncTaskInfo task = {};
        while(asyncTaskRunning_) {
            {
                std::unique_lock<std::mutex> lockForAsyncTask(mutexForAsyncTask_);
                if (asyncTasks_.empty()) {
                    lockForAsyncTask.unlock();
                    (void) usleep(ASYNC_TASK_INTERVAL);
                    continue;
                }
                task = asyncTasks_.front();
                asyncTasks_.pop_front();
            }
            DoReleaseMem(task);
        }
    }

    void AicpuModel::DoReleaseMem(AsyncTaskInfo &task) {
        aicpusd_info("model[%u] send lookup response with async thread.", modelId_);
        const auto ret = SingleHcclWait(task.request);
        if (ret != RET_SUCCESS) {
            aicpusd_err("model[%u] HcclWait fail when release mem", modelId_);
        }

        aicpusd_info("model[%u] after send lookup response, release outputMbuf.", modelId_);
        // getoutputBufPool by 0 because there is only one output
        GetOutputBufPool(0U).Free(task.outputMbuf);
        if (isValid) {
            AICPUSubEventInfo subEventInfo = {};
            subEventInfo.modelId = modelId_;
            const auto result = AicpuMsgSend::SendAICPUSubEvent(
                PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
                static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_PREPARE_MEM,
                CP_DEFAULT_GROUP_ID, true);
            if (result != AICPU_SCHEDULE_OK) {
                aicpusd_err("Send aicpu subevent failed. Event modelId is %u.", modelId_);
            };
        }
    }

    void AicpuModel::StopAsyncThread() {
        aicpusd_run_info("model[%u] begin to StopAsyncThread.", modelId_);
        asyncTaskRunning_ = false;
        for (auto &thread : asyncTaskThreads_) {
            if (thread.joinable()) {
                thread.join();
            }
        }
        const std::unique_lock<std::mutex> lockForAsyncTask(mutexForAsyncTask_);
        asyncTasks_.clear();
        asyncTaskThreads_.clear();
        aicpusd_run_info("model[%u] end to StopAsyncThread.", modelId_);
    }

    size_t AicpuModel::GetCurDequeIndex(const size_t qCnt)
    {
        if (gatheredMbufCntList_.empty()) {
            aicpusd_info("store list empty use 0th index");
            return 0UL;
        }
        size_t qIndex = gatheredMbufCntList_.begin()->first;
        size_t minCnt = gatheredMbufCntList_.begin()->second;
        for (size_t index = 0UL; index < qCnt; index++) {
            size_t curCnt = 0UL;
            auto iter = gatheredMbufCntList_.find(index);
            if (iter != gatheredMbufCntList_.end()) {
                curCnt = iter->second;
            }
            if (curCnt < minCnt) {
                qIndex = index;
                minCnt = curCnt;
            } else if ((curCnt == minCnt) && (index < qIndex)) {
                qIndex = index;
                minCnt = curCnt;
            }
            aicpusd_info("update modelId:%u, qIndex:%zu, cnt:%llu, index:%zu, curCnt:%zu",
                         modelId_, qIndex, minCnt, index, curCnt);
        }
        return qIndex;
    }

    int32_t AicpuModel::ProcessDataException(const uint64_t transId, const uint32_t type) {
        std::unique_lock<std::mutex> lockForAsyncTask(mutexForExceptionTrans_);
        // exception occur
        if (type == static_cast<uint32_t>(ExceptionAction::ADD)) {
            if (exceptionTranses_.find(transId) != exceptionTranses_.end()) {
                aicpusd_warn("Transid[%lu] is already in exception list.", transId);
                return AICPU_SCHEDULE_OK;
            }
            aicpusd_info("Add new exception transid[%lu] for Model[%u].", transId, modelId_);
            exceptionTranses_[transId] = false;
            AICPUSubEventInfo subEventInfo = {};
            subEventInfo.modelId = modelId_;
            const auto ret = AicpuMsgSend::SendAICPUSubEvent(
                PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
                static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_SUPPLY_ENQUEUE,
                CP_DEFAULT_GROUP_ID, true);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_warn("Send aicpu subevent failed. Event modelId is %d.", modelId_);
            };
            return AICPU_SCHEDULE_OK;
        }

        if (type == static_cast<uint32_t>(ExceptionAction::EXPIRE)) {
            if (exceptionTranses_.find(transId) == exceptionTranses_.end()) {
                aicpusd_warn("Transid[%lu] is not in exception list in model[%u], no need to expire.",
                    transId, modelId_);
            } else {
                aicpusd_info("Transid[%lu] is expired in model[%u]", transId, modelId_);
                exceptionTranses_.erase(transId);
            }
            return AICPU_SCHEDULE_OK;
        }

        aicpusd_err("Model[%u] failed to process data exception of transid[%lu] for type[%u] is invalid.",
            modelId_, transId, type);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    bool AicpuModel::IsTransIdException(const uint64_t transId)
    {
        std::unique_lock<std::mutex> lockForAsyncTask(mutexForExceptionTrans_);
        return (exceptionTranses_.find(transId) != exceptionTranses_.end());
    }

    void AicpuModel::GetExcptionTransIdsToClear(std::vector<int64_t> &excptionTransIdsToClear)
    {
        std::unique_lock<std::mutex> lockForAsyncTask(mutexForExceptionTrans_);
        for (const auto &elem : exceptionTranses_) {
            if (!elem.second) {
                excptionTransIdsToClear.emplace_back(elem.first);
            }
        }
    }

    void AicpuModel::UpdateExcptionTransIdsStatus(const std::vector<int64_t> excptionTransIdsCleared) {
        std::unique_lock<std::mutex> lockForAsyncTask(mutexForExceptionTrans_);
        for (const auto transId : excptionTransIdsCleared) {
            auto iter = exceptionTranses_.find(transId);
            if (iter != exceptionTranses_.end()) {
                aicpusd_info("update transId[%lu] to cleared in model[%u]", transId, modelId_);
                iter->second = true;
            }
        }
    }

    bool QueueMbufStore::Init(const size_t queueNum)
    {
        if (!queuesLists_.empty()) {
            return true;
        }
        AICPUSD_EXCEPTION_CATCH(queuesLists_.resize(queueNum), return false);  
        birthTimeStamp_ = GetCurrentTime();
        return true;
    }

    bool QueueMbufStore::Store(const size_t qIndex, Mbuf *const mbuf, std::map<size_t, uint64_t> &gCntList)
    {
        if (queuesLists_.empty()) {
            aicpusd_err("QueueMbufStore has not been inited");
            return false;
        }
        if (qIndex >= queuesLists_.size()) {
            aicpusd_err("qIndex [%zu] invalid", qIndex);
            return false;
        }
        queuesLists_[qIndex].push_back(mbuf);
        gCntList[qIndex]++;
        aicpusd_info("store mbuf index:%zu, queue list size:%zu, buf cnt map cnt:%llu", qIndex,
                     queuesLists_[qIndex].size(), gCntList[qIndex]);
        return true;
    }

    bool QueueMbufStore::Consume(Mbuf ***mbufPptr, std::map<size_t, uint64_t> &gCntList)
    {
        if (queuesLists_.empty()) {
            aicpusd_err("QueueMbufStore has not been inited");
            return false;
        }
        for (size_t arrIndex = 0U; arrIndex < queuesLists_.size(); ++arrIndex) {
            if (!queuesLists_[arrIndex].empty()) {
                *mbufPptr[arrIndex] = queuesLists_[arrIndex].front();
                queuesLists_[arrIndex].pop_front();
                if (gCntList[arrIndex] > 0) {
                    gCntList[arrIndex]--;
                }
                aicpusd_info("consume mbuf index:%zu, queue list size:%zu, buf cnt map cnt:%llu", arrIndex,
                             queuesLists_[arrIndex].size(), gCntList[arrIndex]);
            } else {
                *mbufPptr[arrIndex] = nullptr;
            }
        }
        return true;
    }

    void QueueMbufStore::Free(std::map<size_t, uint64_t> *const gCntList)
    {
        for (size_t i = 0UL; i < queuesLists_.size(); i++) {
            while (!queuesLists_[i].empty()) {
                Mbuf *tmpBuf = queuesLists_[i].front();
                if (tmpBuf != nullptr) {
                    (void)halMbufFree(tmpBuf);
                }
                queuesLists_[i].pop_front();
                if ((gCntList != nullptr) && ((*gCntList)[i] > 0)) {
                    (*gCntList)[i]--;
                }
            }
            if (gCntList != nullptr) {
                aicpusd_info("free store buffer index:%zu, buffer map count:%llu", i, (*gCntList)[i]);
            }
        }
    }

    bool QueueMbufStore::IsReady() const
    {
        if (queuesLists_.empty()) {
            return false;
        }
        for (size_t index = 0UL; index < queuesLists_.size(); index++) {
            if (queuesLists_[index].empty()) {
                return false;
            }
        }
        return true;
    }
    QueueMbufStore::~QueueMbufStore()
    {
        Free();
    }

    bool QueueMbufStore::IsEmpty() const
    {
        if (queuesLists_.empty()) {
            return true;
        }
        for (size_t index = 0UL; index < queuesLists_.size(); index++) {
            if (!queuesLists_[index].empty()) {
                return false;
            }
        }
        return true;
    }
}
