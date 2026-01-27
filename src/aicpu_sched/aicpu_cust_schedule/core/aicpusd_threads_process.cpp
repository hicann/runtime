/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_threads_process.h"

#include "ascend_hal.h"
#include "profiling_adp.h"
#include "aicpusd_status.h"
#include "aicpusd_event_manager.h"
#include "aicpu_context.h"
#include "aicpusd_common.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_worker.h"
#include "aicpusd_monitor.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpu_prof.h"
#include "aicpu_cust_sd_dump_process.h"
#include "aicpusd_util.h"

namespace AicpuSchedule {
ComputeProcess::ComputeProcess()
    : deviceId_(0U),
      hostPid_(-1),
      aicpuNum_(0U),
      profilingMode_(PROFILING_CLOSE),
      aicpuPid_(-1),
      vfId_(0U),
      runMode_(aicpu::AicpuRunMode::THREAD_MODE) {}

ComputeProcess& ComputeProcess::GetInstance()
{
    static ComputeProcess instance;
    return instance;
}

void ComputeProcess::UpdateProfilingSetting(uint32_t flag)
{
    ProfilingMode profilingMode = PROFILING_CLOSE;
    bool kernelFlag = false;
    AicpuUtil::GetProfilingInfo(flag, profilingMode, kernelFlag);
    profilingMode_ = profilingMode;
    if (kernelFlag) {
        aicpu::UpdateMode(profilingMode == PROFILING_OPEN);
    }
    aicpusd_info("Update aicpu profiling mode success, flag[%u], profilingMode[%u], kernelFlag[%d],",
                 flag, profilingMode, kernelFlag);
}

int32_t ComputeProcess::Start(const uint32_t deviceId,
                              const pid_t hostPid,
                              const uint32_t profilingMode,
                              const pid_t aicpuPid,
                              const uint32_t vfId,
                              const aicpu::AicpuRunMode runMode)
{
    aicpusd_info("AicpuCustSd start, deviceId[%u] hostpid[%d] profilingMode[%u] aicpuPid[%d] runMode[%d] vfId[%u].",
        deviceId, hostPid, profilingMode, aicpuPid, static_cast<int32_t>(runMode), vfId);

    const AicpuSchedule::AicpuDrvManager &drvMgr = AicpuSchedule::AicpuDrvManager::GetInstance();
    aicpuNum_ = drvMgr.GetAicpuNum();

    deviceId_ = deviceId;
    hostPid_ = hostPid;
    runMode_ = runMode;
    aicpuPid_ = aicpuPid;
    vfId_ = vfId;
    aicpu::InitProfilingDataInfo(deviceId_, hostPid, CHANNEL_CUS_AICPU);
    UpdateProfilingSetting(profilingMode);
    if (profilingMode != 0U) {
        aicpu::LoadProfilingLib();
        aicpu::SetProfilingFlagForKFC(profilingMode);
        aicpu::UpdateMode((profilingMode & 1) == PROFILING_OPEN);
    }

    if ((aicpuNum_ > 0U) && (aicpu::InitTaskMonitorContext(aicpuNum_) != aicpu::AICPU_ERROR_NONE)) {
        aicpusd_err("Init task monitor context failed");
        return static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR);
    }
    if (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        if (&halMemBindSibling == nullptr) {
            aicpusd_err("Interface halMemBindSibling is not supported in current device");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        drvError_t drvRet = DRV_ERROR_NONE;
        if (AicpuSchedule::AicpuDrvManager::GetInstance().GetSafeVerifyFlag()) {
            drvRet = halMemBindSibling(hostPid, aicpuPid, vfId_, deviceId, SVM_MEM_BIND_SVM_GRP);
        } else {
            //new
            aicpusd_info("open prof so and bind sp group without alloc permission.");
            aicpu::LoadProfilingLib();
            drvRet = halMemBindSibling(hostPid, aicpuPid, vfId_, deviceId, SVM_MEM_BIND_SVM_GRP | SVM_MEM_BIND_SP_GRP_NO_ALLOC);
        }

        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to halMemBindSibling, hostpid[%d], aicpusd pid[%d], deviceId[%u], vfId[%u], ret[%d].",
                        hostPid, aicpuPid, deviceId, vfId, drvRet);
            return static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR);
        }
        aicpusd_info("Bind Sibling pid success, hostpid[%d] aicpusd pid[%d] deviceId[%u] vfId[%u].",
            hostPid, aicpuPid, deviceId, vfId);
    }

    (void)aicpu::SetAicpuRunMode(runMode_);
    aicpu::SetCustAicpuSdFlag(true);
    const uint32_t ret = RegisterScheduleTask();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Register aicpu split and random kernel scheduler failed.");
        return static_cast<int32_t>(ret);
    }

    const int32_t aicpuStartRet = AicpuSchedule::ThreadPool::Instance().CreateWorker();
    if (aicpuStartRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("Drv create aicpu work tasks failed, ret[%d].", aicpuStartRet);
        return static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR);
    }
    AicpuCustDumpProcess::GetInstance().InitDumpProcess(deviceId,
                                                        AicpuDrvManager::GetInstance().GetAicpuNum());
    aicpusd_info("Aicpu custom scheduler start succeed, deviceId[%u], hostpid[%d], profilingMode[%u], runMode[%d].",
        deviceId, hostPid, profilingMode, runMode_);
    return static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS);
}

uint32_t ComputeProcess::RegisterScheduleTask()
{
    const auto randomKernelScheduler = [this] (const aicpu::Closure &task) {
        return SubmitRandomKernelTask(task);
    };
    const auto splitKernelScheduler = [this] (const uint32_t parallelId, const int64_t shardNum,
                                              const std::queue<aicpu::Closure> &taskQueue) {
        const AICPUSharderTaskInfo taskInfo = {.parallelId=parallelId, .shardNum=shardNum};
        return SubmitSplitKernelTask(taskInfo, taskQueue);
    };
    const auto splitKernelGetProcesser = [this] () {
        return GetAndDoSplitKernelTask();
    };

    aicpu::SharderNonBlock::GetInstance().Register(aicpuNum_, randomKernelScheduler, splitKernelScheduler,
                                                   splitKernelGetProcesser);

    return AICPU_SCHEDULE_OK;
}

uint32_t ComputeProcess::SubmitRandomKernelTask(const aicpu::Closure &task)
{
    if (!randomKernelTask_.Enqueue(task)) {
        aicpusd_err("Add random kernel task failed.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    AICPUSubEventInfo aicpuEventInfo = {};
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = getpid();
    eventInfoSummary.event_id = EVENT_RANDOM_KERNEL;
    eventInfoSummary.msg = PtrToPtr<AICPUSubEventInfo, char_t>(&aicpuEventInfo);
    eventInfoSummary.msg_len = static_cast<uint32_t>(sizeof(AICPUSubEventInfo));

    const int32_t drvRet = halEschedSubmitEvent(deviceId_, &eventInfoSummary);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Submit random kernel event failed. ret=%d", drvRet);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    return AICPU_SCHEDULE_OK;
}

uint32_t ComputeProcess::SubmitSplitKernelTask(const AICPUSharderTaskInfo &taskInfo,
                                               const std::queue<aicpu::Closure> &taskQueue)
{
    if (!splitKernelTask_.BatchAddTask(taskInfo, taskQueue)) {
        aicpusd_err("Add split kernel task to map failed, parallelId=%u", taskInfo.parallelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    uint32_t ret = AICPU_SCHEDULE_OK;
    if (FeatureCtrl::ShouldSubmitTaskOneByOne()) {
        ret = SubmitBatchSplitKernelEventOneByOne(taskInfo);
    } else {
        ret = SubmitBatchSplitKernelEventDc(taskInfo);
    }
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Submit batch split kernel event failed. parallelId=%u, submitNum=%ld",
                    taskInfo.parallelId, taskInfo.shardNum);
        return ret;
    }

    aicpusd_info("Submit split kernel event success. parallelId=%u, submitNum=%ld",
                 taskInfo.parallelId, taskInfo.shardNum);

    return AICPU_SCHEDULE_OK;
}

uint32_t ComputeProcess::SubmitBatchSplitKernelEventOneByOne(const AICPUSharderTaskInfo &taskInfo) const
{
    const uint32_t submitNum = static_cast<uint32_t>(taskInfo.shardNum);
    for (uint32_t i = 0U; i < submitNum; ++i) {
        const uint32_t ret = SubmitOneSplitKernelEvent(taskInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Submit single split kernel event failed. parallelId=%u, i=%u",
                        taskInfo.parallelId, i);
            return ret;
        }
    }

    return AICPU_SCHEDULE_OK;
}

uint32_t ComputeProcess::SubmitBatchSplitKernelEventDc(const AICPUSharderTaskInfo &taskInfo)
{
    AICPUSubEventInfo aicpuEventInfo = {};
    aicpuEventInfo.para.sharderTaskInfo = taskInfo;
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = getpid();
    eventInfoSummary.event_id = EVENT_SPLIT_KERNEL;
    eventInfoSummary.msg = PtrToPtr<AICPUSubEventInfo, char_t>(&aicpuEventInfo);
    eventInfoSummary.msg_len = static_cast<uint32_t>(sizeof(AICPUSubEventInfo));
    uint32_t submitSuccessNum = 0U;
    const uint32_t submitNum = static_cast<uint32_t>(taskInfo.shardNum);
    const int32_t drvRet = halEschedSubmitEventBatch(deviceId_, SHARED_EVENT_ENTRY,
                                                     &eventInfoSummary, submitNum, &submitSuccessNum);
    if ((drvRet == DRV_ERROR_NONE) && (submitSuccessNum == submitNum)) {
        aicpusd_info("Batch submit split kernel event success, parallelId=%u, submitNum=%u",
                     taskInfo.parallelId, submitNum);
        return AICPU_SCHEDULE_OK;
    }

    /*
     * The queue depth of event schedule is only dozens. If too many split kernel event are submited,
     * the queue will be full. Therefore, the main thread needs to process the task sending failure. 
     */
    aicpusd_warn("Batch submit some of split kernel event success, ret=%d, parallelId=%u, submitNum=%u, "
                 "submitSuccessNum=%u", drvRet, taskInfo.parallelId, submitNum, submitSuccessNum);

    const uint32_t remainNum = (drvRet == DRV_ERROR_NONE) ? submitNum - submitSuccessNum : submitNum;
    for (uint32_t i = 0U; i < remainNum; ++i) {
        if (!DoSplitKernelTask(taskInfo)) {
            aicpusd_err("Run single task failed after batch submit fail, parallelId=%u, submitNum=%u, "
                        "remainNum=%u, i=%u", taskInfo.parallelId, submitNum, remainNum, i);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
    }

    return AICPU_SCHEDULE_OK;
}

uint32_t ComputeProcess::SubmitOneSplitKernelEvent(const AICPUSharderTaskInfo &taskInfo) const
{
    AICPUSubEventInfo aicpuEventInfo = {};
    aicpuEventInfo.para.sharderTaskInfo = taskInfo;
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = getpid();
    eventInfoSummary.event_id = EVENT_SPLIT_KERNEL;
    eventInfoSummary.msg = PtrToPtr<AICPUSubEventInfo, char_t>(&aicpuEventInfo);
    eventInfoSummary.msg_len = static_cast<uint32_t>(sizeof(AICPUSubEventInfo));

    const int32_t drvRet = halEschedSubmitEvent(deviceId_, &eventInfoSummary);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Submit split kernel event failed. ret=%d, parallelId=%u",
                    drvRet, taskInfo.parallelId);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    return AICPU_SCHEDULE_OK;
}

bool ComputeProcess::GetAndDoSplitKernelTask()
{
    event_info eventInfo = {};
    const uint32_t threadIndex = aicpu::GetAicpuThreadIndex();
    const int32_t retVal = halEschedGetEvent(deviceId_, AicpuSchedule::DEFAULT_GROUP_ID, threadIndex,
                                             EVENT_SPLIT_KERNEL, &eventInfo);
    if (retVal == DRV_ERROR_NO_EVENT) {
        return true;
    }
    if (retVal != DRV_ERROR_NONE) {
        aicpusd_err("Can not get event, threadIndex=%u, ret=%d", threadIndex, retVal);
        return false;
    }

    const AICPUSubEventInfo * const subEventInfo = PtrToPtr<const char_t, const AICPUSubEventInfo>(eventInfo.priv.msg);
    aicpusd_info("Begin to process split kernel event. parallelId=%u, threadIdx=%u, type=get",
                 subEventInfo->para.sharderTaskInfo.parallelId, threadIndex);

    return DoSplitKernelTask(subEventInfo->para.sharderTaskInfo);
}

bool ComputeProcess::DoSplitKernelTask(const AICPUSharderTaskInfo &taskInfo)
{
    aicpu::Closure task;
    if (!splitKernelTask_.PopTask(taskInfo, task)) {
        aicpusd_run_warn("Get split kernel task from map failed, parallelId=%u, %s",
                         taskInfo.parallelId, splitKernelTask_.DebugString().c_str());
        return true;
    }

    try {
        task();
    } catch (std::exception &e) {
        aicpusd_err("Run split kernel task failed. parallelId=%u, exception=%s",
                    taskInfo.parallelId, e.what());
        return false;
    }

    return true;
}

bool ComputeProcess::DoRandomKernelTask()
{
    aicpu::Closure task;
    if (!randomKernelTask_.Dequeue(task)) {
        aicpusd_err("Get random kernel task from map failed, %s",
                    randomKernelTask_.DebugString().c_str());
        return false;
    }

    try {
        task();
    } catch (std::exception &e) {
        aicpusd_err("Run random kernel task failed. exception=%s", e.what());
        return false;
    }

    return true;
}

void ComputeProcess::Stop()
{
    splitKernelTask_.Clear();
    randomKernelTask_.Clear();
    if (profilingMode_ == PROFILING_OPEN) {
        aicpu::ReleaseProfiling();
    }
}
}
