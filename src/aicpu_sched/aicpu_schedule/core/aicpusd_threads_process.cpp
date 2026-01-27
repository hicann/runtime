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
#include <cstring>
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include "ascend_hal.h"
#include "tdt_server.h"
#include "task_queue.h"
#include "profiling_adp.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_worker.h"
#include "aicpu_context.h"
#include "aicpusd_monitor.h"
#include "aicpusd_msg_send.h"
#include "aicpu_async_event.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpu_prof.h"
#include "aicpu_engine.h"
#include "aicpusd_message_queue.h"
namespace {
constexpr size_t FIRST_INDEX = 0UL;
}

namespace AicpuSchedule {
ComputeProcess::ComputeProcess()
    : deviceVec_({}),
      hostDeviceId_(0U),
      hostPid_(-1),
      pidSign_(""),
      aicpuNum_(0U),
      profilingMode_(PROFILING_CLOSE),
      vfId_(0U),
      isStartTdtFlag_(false),
      runMode_(aicpu::AicpuRunMode::THREAD_MODE) {}

ComputeProcess& ComputeProcess::GetInstance()
{
    static ComputeProcess instance;
    return instance;
}

void ComputeProcess::LoadKernelSo()
{
    if (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        try {
            aicpusd_run_info("Start to preload aicpu so.");
            const uint32_t loadSoCnt = 3U;
            const char_t *soNames[loadSoCnt] = {"libtf_kernels.so", "libaicpu_kernels.so", "libcpu_kernels.so"};
            (void)aeBatchLoadKernelSo(static_cast<uint32_t>(aicpu::KERNEL_TYPE_AICPU), loadSoCnt, &(soNames[0]));
            aicpusd_run_info("End to preload aicpu so.");
        } catch (...) {
            // do nothing
        }
    }
}

void ComputeProcess::LoadExtendKernelSo()
{
    if (!FeatureCtrl::ShouldLoadExtendKernelSo()) {
        aicpusd_info("no need load extend kernels so");
        return;
    }

    // extend kernel so 走mc2流程，如果有就必须加载
    try {
        aicpusd_run_info("Start to preload extend kernel so.");
        const uint32_t loadSoCnt = 1U;
        const char_t *soNames[loadSoCnt] = {"libaicpu_extend_kernels.so"};
        (void)aeBatchLoadKernelSo(static_cast<uint32_t>(aicpu::KERNEL_TYPE_AICPU), loadSoCnt, &(soNames[0]));
        aicpusd_run_info("End to preload extend kernel so.");
    } catch (...) {
        // do nothing
    }
}

int32_t ComputeProcess::Start(const std::vector<uint32_t> &deviceVec,
                              const pid_t hostPid,
                              const std::string &pidSign,
                              const uint32_t profilMode,
                              const uint32_t vfId,
                              const aicpu::AicpuRunMode runMode,
                              const AicpuSchedMode schedMode)
{
    aicpusd_info("Aicpu scheduler start, hostpid[%d], profilingMode[%u], runMode[%u], vfId[%u], schedMode[%u]",
                 hostPid, profilMode, runMode, vfId, schedMode);
    if (deviceVec.empty()) {
        aicpusd_err("device vector is empty.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const AicpuSchedule::AicpuDrvManager &drvMgr = AicpuSchedule::AicpuDrvManager::GetInstance();
    deviceVec_ = deviceVec;
    aicpuNum_ = drvMgr.GetAicpuNum();
    hostPid_ = hostPid;
    pidSign_ = pidSign;
    runMode_ = runMode;
    vfId_ = vfId;
    aicpu::InitProfilingDataInfo(deviceVec_[FIRST_INDEX], hostPid, static_cast<uint32_t>(CHANNEL_AICPU));
    aicpu::LoadProfilingLib();
    if (profilMode != 0U) {
        aicpu::SetProfilingFlagForKFC(profilMode);
        aicpu::UpdateMode((profilMode & 1U) == PROFILING_OPEN);
    }

    int32_t ret = AICPU_SCHEDULE_OK;
    if (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        ret = MemorySvmDevice();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Memory svm device failed.");
            return ret;
        }
    }
    // set aicpu runmode
    (void)aicpu::SetAicpuRunMode(runMode_);
    // set cust aicpu sd flag
    aicpu::SetCustAicpuSdFlag(false);

    if (schedMode == SCHED_MODE_MSGQ) {
        const uint32_t deviceId = deviceVec[0];
        ret = MessageQueue::GetInstance().InitMessageQueue(deviceId,
                                                           AicpuDrvManager::GetInstance().GetAicpuPhysIndexs(deviceId));
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Init aicpu message queue failed, ret=%d", ret);
            return ret;
        }
    }

    ret = RegisterScheduleTask();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Register aicpu nonblock task and async event manager task failed.");
        return ret;
    }

    ret = AicpuSchedule::ThreadPool::Instance().CreateWorker(schedMode);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Drv create aicpu work tasks failed, ret[%d].", ret);
        return ret;
    }
    if (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        AicpuSchedule::ThreadPool::Instance().SetThreadSchedModeByTsd();
    }

    if (vfId > 0) {
        // start TDT Server thread
        ret = StartTdtServer();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Start tdt server failed ret[%d].", ret);
            return ret;
        }
    }

    if (FeatureCtrl::LoadKernelSo()) {
        LoadKernelSo();
    }

    LoadExtendKernelSo();
    aicpusd_info("Aicpu scheduler start successfully, deviceId[%u], hostpid[%d], profilingMode[%u], runMode[%u]",
                 deviceVec_[FIRST_INDEX], hostPid, profilMode, runMode_);
    return AICPU_SCHEDULE_OK;
}

void ComputeProcess::UpdateProfilingMode(const ProfilingMode mode) const
{
    aicpu::UpdateMode(mode == PROFILING_OPEN);
}

void ComputeProcess::UpdateProfilingModelMode(const bool mode) const
{
    aicpu::UpdateModelMode(mode);
}

void ComputeProcess::Stop()
{
    splitKernelTask_.Clear();
    randomKernelTask_.Clear();
    StopTdtServer();
    aicpu::ReleaseProfiling();
}
#ifndef _AOSCORE_
int32_t ComputeProcess::StartTdtServer()
{
    if (runMode_ != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        return AICPU_SCHEDULE_OK;
    }
    aicpusd_info("Start tdt server, deviceId=%u.", deviceVec_[0]);
    uint32_t dcpuBase = 0U;
    uint32_t dcpuNumber = 0U;
    AicpuSchedule::AicpuDrvManager::GetInstance().GetDcpuRange(dcpuBase, dcpuNumber);

    const uint32_t aicpuNumber = AicpuSchedule::AicpuDrvManager::GetInstance().GetAicpuNumPerDevice();

    // Set TDT thread binding list
    std::list<uint32_t> tdtBindCoreList;
    if (dcpuNumber != 0U) {
        isStartTdtFlag_ = true;
        for (uint32_t i = 0U; i < dcpuNumber; ++i) {
            tdtBindCoreList.push_back(dcpuBase + i);
        }
    } else {
        const bool isFPGA = AicpuUtil::IsEnvValEqual(ENV_NAME_DATAMASTER_RUN_MODE, "1");
        aicpusd_info("Start tdt in mode %d", isFPGA);

        if ((isFPGA) && (aicpuNumber != 0U)) {
            isStartTdtFlag_ = true;
            for (uint32_t i = 0U; i < aicpuNumber; ++i) {
                tdtBindCoreList.push_back(AicpuSchedule::AicpuDrvManager::GetInstance().GetAicpuPhysIndex(i, 0U));
            }
        } else {
            isStartTdtFlag_ = false;
            aicpusd_info("Not need to start tdt server.");
            return AICPU_SCHEDULE_OK;
        }
    }

    // Start the TDT thread that binds the core
    const int32_t tdtInitRet = tdt::TDTServerInit(deviceVec_[FIRST_INDEX], tdtBindCoreList);
    if (tdtInitRet != 0) {
        aicpusd_err("TDT server init failed, deviceId[%u], dcpuBase[%u], dcpuNum[%u], ret[%d].",
                    deviceVec_[FIRST_INDEX], dcpuBase, dcpuNumber, tdtInitRet);
        return tdtInitRet;
    }
    aicpusd_info("TDT Server init success.");
    return AICPU_SCHEDULE_OK;
}

void ComputeProcess::StopTdtServer() const
{
    if (runMode_ != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        return;
    }
    if (!isStartTdtFlag_) {
        aicpusd_info("It don`t need to stop tdt server.");
        return;
    }
    aicpusd_info("Stop tdt server, deviceId=%u.", deviceVec_[0]);

    const int32_t tdtStopRet = tdt::TDTServerStop();
    if (tdtStopRet != 0) {
        aicpusd_err("TDT server stop failed, ret[%d].", tdtStopRet);
        return;
    }
    aicpusd_info("TDT Server stop success.");
}
#else
int32_t ComputeProcess::StartTdtServer()
{
    return AICPU_SCHEDULE_OK;
}

void ComputeProcess::StopTdtServer() const
{
    return;
}
#endif

int32_t ComputeProcess::RegisterScheduleTask()
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
    if ((aicpuNum_ > 0U) && (aicpu::InitTaskMonitorContext(aicpuNum_) != aicpu::AICPU_ERROR_NONE)) {
        aicpusd_err("Init task monitor context failed");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    const auto notifyWaitFunc = [](const void *const notifyParam, const uint32_t paramLen) {
        return AicpuSchedule::AicpuMsgSend::SendAicpuRecordMsg(notifyParam, paramLen);
    };
    aicpu::AsyncEventManager::GetInstance().Register(notifyWaitFunc);
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

    const int32_t drvRet = halEschedSubmitEvent(deviceVec_[FIRST_INDEX], &eventInfoSummary);
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
    const int32_t drvRet = halEschedSubmitEventBatch(deviceVec_[FIRST_INDEX], SHARED_EVENT_ENTRY,
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

    const int32_t drvRet = halEschedSubmitEvent(deviceVec_[FIRST_INDEX], &eventInfoSummary);
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
    const int32_t retVal = halEschedGetEvent(deviceVec_[FIRST_INDEX], CP_DEFAULT_GROUP_ID, threadIndex,
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

int32_t ComputeProcess::MemorySvmDevice()
{
    for (size_t i = 0UL; i < deviceVec_.size(); i++) {
        if (&halMemInitSvmDevice == nullptr) {
            aicpusd_err("Interface halMemInitSvmDevice is not supported in current device");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        const drvError_t drvRet = halMemInitSvmDevice(hostPid_, vfId_, deviceVec_[i]);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Drv mem init svm device[%u] failed ret[%d].", deviceVec_[i], drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
    }
    aicpusd_info("Drv mem init svm device success.");
    return AICPU_SCHEDULE_OK;
}

std::string ComputeProcess::DebugString()
{
    return splitKernelTask_.DebugString();
}
}
