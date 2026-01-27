/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_monitor.h"

#include <new>
#include <mutex>
#include <string>
#include <unistd.h>
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "aicpusd_common.h"
#include "aicpusd_drv_manager.h"
#include "tsd.h"
#include "aicpu_context.h"
#include "aicpu_pulse.h"
#include "aicpusd_mpi_mgr.h"
#include "aicpusd_lastword.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_threads_process.h"

namespace {
// aicpu task timeout
const uint64_t AICPU_TASK_TIMEOUT = 28UL;
const uint64_t AICPU_TASK_TIMEOUT_LONG = 60UL;
const uint64_t AICPU_TASK_TIMEOUT_FPGA = 2800UL;
// delay to report kill message until TS timeout
const uint64_t AICPU_REPORT_DELAY = 5UL;
constexpr const uint32_t MONITOR_SLEEP_INTERVAL = 100000U; // 100ms
#ifndef aicpusd_UT
constexpr const uint32_t MONITOR_TIMEOUT_COUNT = 10U; // 1s
constexpr const uint32_t MONITOR_SUPPLYENQUE_COUNT = 20U; // 2s
#else
constexpr const uint32_t MONITOR_TIMEOUT_COUNT = 1U;
constexpr const uint32_t MONITOR_SUPPLYENQUE_COUNT = 1U;
#endif
}

namespace AicpuSchedule {
/**
 * @ingroup AicpuMonitor
 * @brief it is used to construct a object of AicpuMonitor.
 */
AicpuMonitor::AicpuMonitor()
    : deviceId_(0U),
      taskTimeoutFlag_(false),
      modelTimeoutFlag_(false),
      monitorTaskInfo_(nullptr),
      done_(false),
      tsTimeoutEnable_(false),
      tsOpTimeOut_(0U),
      taskTimeout_(UINT64_MAX),
      taskTimeoutTick_(UINT64_MAX),
      modelTimeoutTick_(UINT64_MAX),
      aicpuTaskTimer_(nullptr),
      modelTimer_(nullptr),
      running_(false),
      aicpuCoreNum_(0U),
      online_(false),
      opTimeoutFlag_(false)
{}

/**
 * @ingroup AicpuMonitor
 * @brief it is used to destructor a object of AicpuMonitor.
 */
AicpuMonitor::~AicpuMonitor()
{
    if (!done_) {
        StopMonitor();
    }
    aicpusd_info("AicpuMonitor join begin");
    for (auto &monitorThread : th_) {
        if (monitorThread.joinable()) {
            monitorThread.join();
        }
    }
    aicpusd_info("AicpuMonitor join end");
}

AicpuMonitor &AicpuMonitor::GetInstance()
{
    static AicpuMonitor instance;
    return instance;
}

int32_t AicpuMonitor::InitTimer()
{
    if (taskTimeoutFlag_ && (aicpuCoreNum_ != 0U)) {
        aicpuTaskTimer_.reset(new (std::nothrow) TaskTimer[aicpuCoreNum_]);
        if (aicpuTaskTimer_ == nullptr) {
            aicpusd_err("malloc memory for task timer failed");
            return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
        }
    }
    if (taskTimeoutFlag_) {
        aicpuStreamTaskTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
        if (aicpuStreamTaskTimer_ == nullptr) {
            aicpusd_err("malloc memory for aicpu stream task timer failed");
            return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
        }
    }
    if (modelTimeoutFlag_) {
        modelTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
        if (modelTimer_ == nullptr) {
            aicpusd_err("malloc memory for model timer failed");
            return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
        }
    }
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuMonitor::InitMonitor(const uint32_t devId, const bool isOnline)
{
    aicpusd_info("Begin to init aicpu monitor.");
    online_ = isOnline;
    if (!online_) {
        aicpusd_info("End to init aicpu monitor, offline mode");
        return AICPU_SCHEDULE_OK;
    }
    deviceId_ = devId;
    aicpuCoreNum_ = AicpuSchedule::AicpuDrvManager::GetInstance().GetAicpuNum();
    if (aicpuCoreNum_ != 0U) {
        monitorTaskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[aicpuCoreNum_]);
        if (monitorTaskInfo_ == nullptr) {
            aicpusd_err("Malloc task info memory for monitor failed");
            return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
        }
        for (uint32_t i = 0U; i < aicpuCoreNum_; i++) {
            monitorTaskInfo_[static_cast<uint64_t>(i)] = {UINT64_MAX, UINT64_MAX, UINT32_MAX, false};
        }
    }
    int32_t ret = SetTaskTimeoutFlag();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Set task timeout flag failed, ret[%d]", ret);
        return ret;
    }
    ret = SetModelTimeoutFlag();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Set model timeout flag failed, ret[%d]", ret);
        return ret;
    }

    ret = InitTimer();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init timer failed, ret[%d]", ret);
        return ret;
    }

    InitAsyncOpTimer();

    aicpusd_run_info("Init aicpu monitor successfully, taskTimeout=%lus, tickFreq=%lu.",
                     taskTimeout_, aicpu::GetSystemTickFreq());
    return AICPU_SCHEDULE_OK;
}

void AicpuMonitor::InitAsyncOpTimer()
{
    aicpusd_info("Start init async op timer in monitor");

    const auto startTimerCbk = [this](const aicpu::TimerHandle timerHandle, const uint32_t timeInS) {
        return SetOpTimerStartTime(timerHandle, timeInS);
    };

    const auto stopTimerCbk = [this](const aicpu::TimerHandle timerHandle) {
        return SetOpTimerEndTime(timerHandle);
    };

    aicpu::AicpuTimer::GetInstance().RegistMonitorFunc(startTimerCbk, stopTimerCbk);
}

void AicpuMonitor::SendKillMsgToTsd()
{
    SendKillMsgToTsd(0);
}

void AicpuMonitor::SendKillMsgToTsd(uint64_t delayReportSecond)
{
    aicpusd_run_info("dev[%u] send msg to tsdaemon, tsdaemon will kill aicpu-sd process[%u]", deviceId_,
        static_cast<uint32_t>(getpid()));
    AicpusdLastword::GetInstance().LastwordCallback();
    // flush cache log to slogd
    DlogFlushAicpu();
    (void)AicpuSchedule::mpi::MpiDvppStatisticManager::Instance().PrintStatisticInfo();

    if (delayReportSecond != 0) {
        // delay report when using default timeout config
        (void)sleep(delayReportSecond);
    }
    // thread node ppid is not tsd, don't need to destroy
    if (!online_) {
        aicpusd_run_info("offline mode no need send msg to tsd");
        return;
    }
    const int32_t ret = TsdDestroy(deviceId_, TSD_COMPUTE,
        static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()), AicpuDrvManager::GetInstance().GetVfId());
    if (ret != 0) {
        aicpusd_err("dev[%u] send abnormal msg to tsdaemon failed, ret[%d]", deviceId_, ret);
    }
}

void AicpuMonitor::SetTaskInfo(const uint32_t threadIndex, const TaskInfoForMonitor &taskInfo) const
{
    if ((threadIndex < aicpuCoreNum_) && online_) {
        monitorTaskInfo_[static_cast<uint64_t>(threadIndex)] = taskInfo;
    }
}

int32_t AicpuMonitor::SetTaskTimeoutFlag()
{
    taskTimeout_ = FeatureCtrl::IsDoubleDieProduct() ?
                   AICPU_TASK_TIMEOUT_LONG : AICPU_TASK_TIMEOUT;
    taskTimeoutTick_ = taskTimeout_ * aicpu::GetSystemTickFreq();
    if (AicpuUtil::IsEnvValEqual(ENV_NAME_DATAMASTER_RUN_MODE, "1") ||
        AicpuUtil::IsEnvValEqual(ENV_NAME_DATAMASTER_RUN_MODE, "2")) {
        aicpusd_warn("Set task timeout to FPGA mode.");
        taskTimeout_ = AICPU_TASK_TIMEOUT_FPGA;
        taskTimeoutTick_ = AICPU_TASK_TIMEOUT_FPGA * aicpu::GetSystemTickFreq();
    }

    taskTimeoutFlag_ = true;
    SetOpTimeoutFlag(true);

    return AICPU_SCHEDULE_OK;
}

int32_t AicpuMonitor::SetModelTimeoutFlag()
{
    std::string timeoutFlag;
    const bool ret = AicpuUtil::GetEnvVal(ENV_NAME_AICPU_MODEL_TIMEOUT, timeoutFlag);
    if (!ret) {
        aicpusd_run_info("Not set aicpu model timeout. Env is not set.");
        return AICPU_SCHEDULE_OK;
    }

    aicpusd_run_info("Get model timeout is %ss", timeoutFlag.c_str());
    try {
        const uint64_t modelTimeout = std::stoul(timeoutFlag);
        const uint64_t frep = aicpu::GetSystemTickFreq();
        if (AicpuUtil::IsUint64MulOverflow(modelTimeout, frep)) {
            aicpusd_err("Overflow occurred when set model timeout, timeout=%lus, freq=%lu.", modelTimeout, frep);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        modelTimeoutTick_ = modelTimeout * frep;
    } catch (std::exception &e) {
        aicpusd_err("Convert AICPU_MODEL_TIMEOUT[%s]s to number failed, %s", timeoutFlag.c_str(), e.what());
        return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    }

    modelTimeoutFlag_ = true;
    return AICPU_SCHEDULE_OK;
}

// index used inner, it is valid
void AicpuMonitor::SetTaskStartTime(const uint32_t taskId)
{
    if ((taskTimeoutFlag_) && (online_)) {
        aicpuTaskTimer_[static_cast<uint64_t>(taskId)].SetStartTick(aicpu::GetSystemTick());
        aicpuTaskTimer_[static_cast<uint64_t>(taskId)].SetRunFlag(true);
    }
}

void AicpuMonitor::SetTaskEndTime(const uint32_t taskId)
{
    if ((taskTimeoutFlag_) && (online_)) {
        aicpuTaskTimer_[static_cast<uint64_t>(taskId)].SetRunFlag(false);
        monitorTaskInfo_[static_cast<uint64_t>(taskId)].isHwts = false;
    }
}

void AicpuMonitor::SetAicpuStreamTaskStartTime(const uint32_t taskId)
{
    if ((taskTimeoutFlag_) && (taskId < MAX_MODEL_COUNT) && (online_)) {
        aicpuStreamTaskTimer_[static_cast<uint64_t>(taskId)].SetStartTick(aicpu::GetSystemTick());
        aicpuStreamTaskTimer_[static_cast<uint64_t>(taskId)].SetRunFlag(true);
    }
}

void AicpuMonitor::SetAicpuStreamTaskEndTime(const uint32_t taskId)
{
    if ((taskTimeoutFlag_) && (taskId < MAX_MODEL_COUNT) && (online_)) {
        aicpuStreamTaskTimer_[static_cast<uint64_t>(taskId)].SetRunFlag(false);
    }
}

void AicpuMonitor::SetModelStartTime(const uint32_t modelId)
{
    if ((modelTimeoutFlag_) && (modelId < MAX_MODEL_COUNT) && (online_)) {
        modelTimer_[static_cast<uint64_t>(modelId)].SetStartTick(aicpu::GetSystemTick());
        modelTimer_[static_cast<uint64_t>(modelId)].SetRunFlag(true);
    }
}

void AicpuMonitor::SetModelEndTime(const uint32_t modelId)
{
    if ((modelTimeoutFlag_) && (modelId < MAX_MODEL_COUNT) && (online_)) {
        modelTimer_[static_cast<uint64_t>(modelId)].SetRunFlag(false);
    }
}

void AicpuMonitor::SetOpTimerStartTime(const aicpu::TimerHandle timerId, const uint32_t timeInS)
{
    if ((opTimeoutFlag_) && (online_)) {
        std::shared_ptr<TaskTimer> taskTimerPtr = std::make_shared<TaskTimer>(aicpu::GetSystemTick(), true);
        if (taskTimerPtr == nullptr) {
            aicpusd_err("alloc taskTimerPtr fail");
            return;
        }
        taskTimerPtr->SetTimeTick(timeInS);
        {
            const std::lock_guard<std::mutex> lk(opTimerMapMutex_);
            (void)opTimer_.emplace(timerId, taskTimerPtr);
        }
    }
}

void AicpuMonitor::SetOpTimerEndTime(const aicpu::TimerHandle timerId)
{
    if ((opTimeoutFlag_ && online_) || (!opTimer_.empty())) {
        const std::lock_guard<std::mutex> lk(opTimerMapMutex_);
        (void)opTimer_.erase(timerId);
    }
}

void AicpuMonitor::Work(AicpuMonitor *const monitor)
{
    std::once_flag exeOnce;
    uint32_t count = 0;
    AICPUSubEventInfo subEventInfo = {};
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = getpid();
    eventInfoSummary.event_id = EVENT_AICPU_MSG;
    eventInfoSummary.subevent_id = AICPU_SUB_EVENT_SUPPLY_ENQUEUE;
    eventInfoSummary.msg = PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo);
    eventInfoSummary.msg_len = static_cast<uint32_t>(sizeof(AICPUSubEventInfo));
    eventInfoSummary.grp_id = CP_DEFAULT_GROUP_ID;
    std::vector<size_t> eventWaitIds;
    while ((monitor != nullptr) && (!monitor->done_)) {
        if (count % MONITOR_TIMEOUT_COUNT == 0) {
            if (monitor->online_) {
                // check and handle task timeout, for aicpu task of ts stream and aicpu stream
                monitor->HandleTaskTimeout();
                // check and handle model timeout
                monitor->HandleModelTimeout();
                monitor->HandleOpTimeout();
            }
            if (FeatureCtrl::ShouldMonitorWork() ) {
                AicpuPulseNotify();
            }
            std::call_once(exeOnce, [&]() {
                monitor->running_ = true;
                if (sem_post(&monitor->sem_) != 0) {
                    aicpusd_err("sem post failed, %s", strerror(errno));
                    return;
                }
            });
        }
        if ((count % MONITOR_SUPPLYENQUE_COUNT == 0) && (FeatureCtrl::ShouldMonitorWork()) &&
            (!FeatureCtrl::ShouldSkipSupplyEvent())) {
            EventWaitManager::AnyQueNotEmptyWaitManager().GetWaitingEvent(eventWaitIds);
            for (const auto waitId : eventWaitIds) {
                subEventInfo.modelId = waitId;
                const drvError_t ret = halEschedSubmitEvent(monitor->deviceId_, &eventInfoSummary);
                if (ret != DRV_ERROR_NONE) {
                    aicpusd_err("Failed to supply enque event for model[%u]. ret is %d.", waitId, ret);
                }
                aicpusd_info("supply enque event for model[%u].", waitId);
            }
            eventWaitIds.clear();           
        }
        count++;
        if (count == MONITOR_SUPPLYENQUE_COUNT) {
            count = 0;
        }
        (void)usleep(MONITOR_SLEEP_INTERVAL);
    }
}

int32_t AicpuMonitor::Run()
{
    if (done_) {
        aicpusd_err("Fail to run monitor for it has been stopped");
        return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    }
    int32_t semRet = sem_init(&sem_, 0, 0U);
    if (semRet == -1) {
        aicpusd_err("sem init failed, %s.", strerror(errno));
        return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    }

    try {
        std::thread monitorThread(&AicpuMonitor::Work, this);
        th_.emplace_back(std::move(monitorThread));
    } catch (std::exception &threadException) {
        (void)sem_destroy(&sem_);
        aicpusd_err("create aicpu monitor thread object failed, %s", threadException.what());
        return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    }

    semRet = sem_wait(&sem_);
    if (semRet == -1) {
        (void)sem_destroy(&sem_);
        aicpusd_err("sem wait failed, %s.", strerror(errno));
        return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    }
    (void)sem_destroy(&sem_);
    if (!running_) {
        aicpusd_err("create aicpu monitor thread failed");
        return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    }
    aicpusd_info("Aicpu monitor thread running");

    return AICPU_SCHEDULE_OK;
}

void AicpuMonitor::StopMonitor()
{
    aicpusd_info("Begin to stop aicpu monitor");
    const std::unique_lock<std::mutex> lk(mutex_);
    done_ = true;
    for (auto &thead : th_) {
        if (thead.joinable()) {
            thead.join();
        }
    }

    done_ = false;
    th_.clear();
}

void AicpuMonitor::SetOpExecuteTimeOut(const uint32_t timeOutEn, const uint32_t opExecuteTimeOut)
{
    const std::unique_lock<std::mutex> lk(setTimeOutMut_);
    if (timeOutEn == 1U) {
        tsTimeoutEnable_ = true;
        tsOpTimeOut_ = opExecuteTimeOut;
        taskTimeoutTick_ = opExecuteTimeOut * aicpu::GetSystemTickFreq();
        taskTimeoutFlag_ = true;
        aicpusd_run_info("Get enable op execute timeout config from ts. timeout[%u]s tickFrequency[%lu]",
                         tsOpTimeOut_.load(), taskTimeoutTick_.load());
    } else {
        tsTimeoutEnable_ = false;
        (void)SetTaskTimeoutFlag();
        aicpusd_run_info("Get disable op execute timeout config from ts. tickFrequency[%lu]", taskTimeoutTick_.load());
    }
}

void AicpuMonitor::SetOpTimeoutFlag(const bool flag)
{
    aicpusd_info("Set op timer flag to %d", flag);
    opTimeoutFlag_ = flag;
    aicpu::AicpuTimer::GetInstance().SetSupportTimer(flag);
}

void AicpuMonitor::HandleTaskTimeout()
{
    if (!taskTimeoutFlag_) {
        return;
    }

    const uint64_t nowTick = aicpu::GetSystemTick();
    for (uint32_t i = 0U; i < aicpuCoreNum_; ++i) {
        const auto runFlag = aicpuTaskTimer_[static_cast<uint64_t>(i)].GetRunFlag();
        const auto startTick = aicpuTaskTimer_[static_cast<uint64_t>(i)].GetStartTick();
        if (runFlag && (nowTick > startTick) && ((nowTick - startTick) >= taskTimeoutTick_.load())) {
            // handle task timeout
            std::string opname;
            (void)aicpu::GetOpname(i, opname);
            std::ostringstream oss;
            oss << "Send timeout to tsdaemon, tsdaemon will kill aicpu-sd process, thread index[" << i <<
                "], op name[" << opname << "]";
            if (monitorTaskInfo_[static_cast<uint64_t>(i)].isHwts) {
                oss << ", " << MonitorDebug::MonitorDebugString(monitorTaskInfo_[static_cast<uint64_t>(i)]);
            }
            aicpusd_err("%s, nowTick:%llu, startTick:%llu, timeOut:%llu, tickFreq:%llu.", oss.str().c_str(),
                        nowTick, startTick, taskTimeoutTick_.load(), aicpu::GetSystemTickFreq());
            aicpusd_run_info("%s", ComputeProcess::GetInstance().DebugString().c_str());
            SendKillMsgToTsd(!tsTimeoutEnable_ ? AICPU_REPORT_DELAY : 0);
            return;
        }
    }
    for (uint32_t modelId = 0U; modelId < MAX_MODEL_COUNT; ++modelId) {
        const auto runFlag = aicpuStreamTaskTimer_[static_cast<uint64_t>(modelId)].GetRunFlag();
        const auto startTick = aicpuStreamTaskTimer_[static_cast<uint64_t>(modelId)].GetStartTick();
        if (runFlag && (nowTick > startTick) && ((nowTick - startTick) >= taskTimeoutTick_.load())) {
            // handle aicpu stream task timeout
            aicpusd_err("Send stream task timeout, tsdaemon will kill aicpu-sd process, model id[%u].", modelId);
            SendKillMsgToTsd(AICPU_REPORT_DELAY);
            break;
        }
    }
}

void AicpuMonitor::HandleOpTimeout()
{
    if ((!opTimeoutFlag_) && (opTimer_.empty())) {
        return;
    }

    aicpu::TimerHandle timerId = 0;
    bool isTimeout = false;
    {
        const std::lock_guard<std::mutex> lk(opTimerMapMutex_);
        const uint64_t nowTick = aicpu::GetSystemTick();
        for (auto &timer : opTimer_) {
            const auto runFlag = timer.second->GetRunFlag();
            const auto startTick = timer.second->GetStartTick();
            const auto timeoutTick = timer.second->GetTimeTick() == 0 ? taskTimeoutTick_.load() :
                                     timer.second->GetTimeTick();
            if (runFlag && (nowTick > startTick) && ((nowTick - startTick) >= timeoutTick)) {
                timerId = timer.first;
                isTimeout = true;
                std::ostringstream oss;
                oss << "Op timeout occurred, timer id[" << timerId << "]";
                aicpusd_err("%s, nowTick:%llu, startTick:%llu, timeOut:%llu, tickFreq:%llu.", oss.str().c_str(),
                            nowTick, startTick, taskTimeoutTick_.load(), aicpu::GetSystemTickFreq());
                aicpu::AicpuTimer::GetInstance().CallTimeoutCallback(timerId);
            }
        }
    }

    if (isTimeout) {
        aicpusd_err("Timeout occurred, start to stop timer. TimerId=%lu", timerId);
        SetOpTimerEndTime(timerId);
        DlogFlushAicpu();
    }
}

void AicpuMonitor::HandleModelTimeout()
{
    if (modelTimeoutFlag_) {
        const uint64_t nowTick = aicpu::GetSystemTick();
        for (uint32_t modelId = 0U; modelId < MAX_MODEL_COUNT; ++modelId) {
            const TaskTimer timer(modelTimer_[static_cast<uint64_t>(modelId)].GetStartTick(),
                modelTimer_[static_cast<uint64_t>(modelId)].GetRunFlag());
            if (timer.GetRunFlag() && (nowTick > timer.GetStartTick()) &&
                ((nowTick - timer.GetStartTick()) >= modelTimeoutTick_)) {
                // handle model timeout
                aicpusd_err("Send model timeout, tsdaemon will kill aicpu-sd process, model id[%u].", modelId);
                SendKillMsgToTsd(AICPU_REPORT_DELAY);
                break;
            }
        }
    }
}

void AicpuMonitor::DisableModelTimeout()
{
    modelTimeoutFlag_ = false;
}

uint32_t AicpuMonitor::GetTaskDefaultTimeout() const
{
    return tsTimeoutEnable_ ? tsOpTimeOut_.load() : taskTimeout_;
}
} // namespace AicpuSchedule
