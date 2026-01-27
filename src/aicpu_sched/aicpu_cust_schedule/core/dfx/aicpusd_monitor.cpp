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

#include <mutex>
#include <cstdlib>
#include <string>
#include <unistd.h>
#include <cstring>
#include <cerrno>
#include "securec.h"
#include "aicpusd_common.h"
#include "profiling_adp.h"
#include "aicpusd_drv_manager.h"
#include "tsd.h"
#include "aicpu_context.h"
#include "aicpu_pulse.h"
#include "aicpusd_info.h"
#include "status.h"
#include "aicpu_error_log_api.h"
#include "feature_ctrl.h"

namespace {
    // aicpu task timeout
    const uint64_t AICPU_TASK_TIMEOUT = 28LU;
    const uint64_t AICPU_TASK_TIMEOUT_LONG = 60UL;
    // keep same with DEFAULT_GROUP_ID defined in tsd_event_interface.h
    const uint32_t DEFAULT_GROUP_ID_TO_TSD_CLIENT = 30U;
}

namespace AicpuSchedule {
    /**
     * @ingroup AicpuMonitor
     * @brief it is used to construct a object of AicpuMonitor.
     *        using default value to construct
     */
    AicpuMonitor::AicpuMonitor()
        : deviceId_(0U),
          taskTimeoutFlag_(false),
          taskInfo_(nullptr),
          done_(false),
          taskTimeout_(UINT64_MAX),
          taskTimeoutTick_(UINT64_MAX),
          taskTimer_(nullptr),
          running_(false),
          aicpuCoreNum_(0U),
          online_(false)
    {}

/**
     * @ingroup AicpuMonitor
     * @brief it is used to destructor a object of AicpuMonitor.
     *        it is neccessary to set flag false to make sure thread to be stopped
     */
    AicpuMonitor::~AicpuMonitor()
    {
        if (!done_) {
            Stop();
        }
    }

    AicpuMonitor &AicpuMonitor::GetInstance()
    {
        static AicpuMonitor instance;
        return instance;
    }

    int32_t AicpuMonitor::InitAicpuMonitor(const uint32_t deviceId, const bool online)
    {
        aicpusd_info("Begin to init aicpu monitor");
        online_ = online;
        if (!online_) {
            aicpusd_info("End to init aicpu monitor, offline mode");
            return AICPU_SCHEDULE_OK;
        }
        deviceId_ = deviceId;
        aicpuCoreNum_ = AicpuSchedule::AicpuDrvManager::GetInstance().GetAicpuNum();
        if (aicpuCoreNum_ != 0U) {
            taskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[aicpuCoreNum_]);
            if (taskInfo_ == nullptr) {
                aicpusd_err("malloc task info memory for monitor failed");
                return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
            }
            for (size_t i = 0UL; i < aicpuCoreNum_; i++) {
                taskInfo_[i] = {UINT64_MAX, UINT64_MAX, UINT32_MAX, false};
            }
        }

        const int32_t ret = SetTaskTimeoutFlag();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("set task timeout flag failed, ret[%d]", ret);
            return ret;
        }

        if (taskTimeoutFlag_ && (aicpuCoreNum_ != 0U)) {
            taskTimer_.reset(new (std::nothrow) TaskTimer[aicpuCoreNum_]);
            if (taskTimer_ == nullptr) {
                aicpusd_err("malloc memory for task timer failed");
                return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
            }
        }

        aicpusd_run_info("Init aicpu monitor success, taskTimeout=%lus, tickFreq=%lu",
                         taskTimeout_, aicpu::GetSystemTickFreq());
        return AICPU_SCHEDULE_OK;
    }

    void AicpuMonitor::SendKillMsgToTsd() const
    {
        SendAbnormalMsgToMain();
        aicpusd_run_info("dev[%u] send msg to tsdaemon, tsdaemon will kill aicpu-custom-sd process[%u]",
                         deviceId_, static_cast<uint32_t>(getpid()));
        const int32_t ret = TsdDestroy(deviceId_, TSD_CUSTOM_COMPUTE,
                                       static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()),
                                       AicpuDrvManager::GetInstance().GetVfId());
        if (ret != static_cast<int32_t>(tsd::TSD_OK)) {
            aicpusd_err("dev[%u] send abnormal msg to tsdaemon failed, ret[%d]", deviceId_, ret);
        }
    }

    void AicpuMonitor::SetTaskInfo(const uint64_t taskIndex, const TaskInfoForMonitor &taskInfo)
    {
        if ((taskIndex < aicpuCoreNum_) && online_) {
            taskInfo_[taskIndex] = taskInfo;
        }
    }

    int32_t AicpuMonitor::SetTaskTimeoutFlag()
    {
        taskTimeout_ = FeatureCtrl::IsDoubleDieProduct() ?
                       AICPU_TASK_TIMEOUT_LONG : AICPU_TASK_TIMEOUT;
        taskTimeoutTick_ = taskTimeout_ * aicpu::GetSystemTickFreq();
        taskTimeoutFlag_ = true;
        return AICPU_SCHEDULE_OK;
    }

    void AicpuMonitor::SetTaskStartTime(const uint64_t taskIndex)
    {
        if ((taskTimeoutFlag_) && (online_)) {
            taskTimer_[taskIndex].SetStartTick(aicpu::GetSystemTick());
            taskTimer_[taskIndex].SetRunFlag(true);
        }
    }

    void AicpuMonitor::SetTaskEndTime(const uint64_t taskIndex)
    {
        if ((taskTimeoutFlag_) && (online_)) {
            taskTimer_[taskIndex].SetRunFlag(false);
            taskInfo_[taskIndex].isHwts = false;
        }
    }

    void AicpuMonitor::Work(AicpuMonitor *const monitor)
    {
        std::once_flag flag;
        while ((monitor != nullptr) && (!(monitor->done_))) {
            if (monitor->online_) {
                // check and handle task timeout, for aicpu task of ts stream and aicpu stream
                monitor->HandleTaskTimeout();
            }
            // call pulseNotifyFuncMap
            AicpuPulseNotify();
            std::call_once(flag, [&]() {
                monitor->running_ = true;
                if (sem_post(&monitor->sem_) != 0) {
                    aicpusd_err("sem post failed, %s", strerror(errno));
                    return;
                }
            });
            (void)sleep(1U);
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
            std::thread th(&AicpuMonitor::Work, this);
            th.detach();
        } catch(std::exception &e) {
            (void)sem_destroy(&sem_);
            aicpusd_err("create aicpu monitor thread object failed, %s", e.what());
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
        aicpusd_info("aicpu monitor thread running");

        return AICPU_SCHEDULE_OK;
    }

    void AicpuMonitor::Stop()
    {
        const std::unique_lock<std::mutex> stopLock(mutex_);
        done_ = true;
    }

    void AicpuMonitor::HandleTaskTimeout()
    {
        if (!taskTimeoutFlag_) {
            return;
        }

        const uint64_t nowTick = aicpu::GetSystemTick();
        for (size_t coreIndex = 0UL; coreIndex < aicpuCoreNum_; ++coreIndex) {
            TaskTimer taskTimer;
            taskTimer.SetRunFlag(taskTimer_[coreIndex].GetRunFlag());
            taskTimer.SetStartTick(taskTimer_[coreIndex].GetStartTick());
            if (taskTimer.GetRunFlag() && (nowTick > taskTimer.GetStartTick()) &&
                ((nowTick - taskTimer.GetStartTick()) >= taskTimeoutTick_)) {
                // handle task timeout
                std::string opname;
                (void)aicpu::GetOpname(static_cast<uint32_t>(coreIndex), opname);
                std::ostringstream oss;
                oss << "Send timeout to tsdaemon, tsdaemon will kill aicpu-custom-sd process, thread index["
                    << coreIndex << "], op name[" << opname << "]";
                if (taskInfo_[coreIndex].isHwts) {
                    oss << ", " << taskInfo_[coreIndex].DebugString();
                }
                aicpusd_err("%s.", oss.str().c_str());
                SendKillMsgToTsd();
                break;
            }
        }
    }

    void AicpuMonitor::SendAbnormalMsgToMain() const
    {
        if ((aicpu::HasErrorLog != nullptr) && (!aicpu::HasErrorLog())) {
            return;
        }

        event_summary eventInfo = {};
        eventInfo.pid = static_cast<pid_t>(getpid());
        eventInfo.grp_id = DEFAULT_GROUP_ID_TO_TSD_CLIENT;
        eventInfo.dst_engine = CCPU_DEVICE;
        eventInfo.event_id = EVENT_CCPU_CTRL_MSG;
        eventInfo.subevent_id = AICPU_SUB_EVENT_ABNORMAL_LOG;
        eventInfo.msg_len = 0U;

        const drvError_t ret = halEschedSubmitEvent(deviceId_, &eventInfo);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to submit, eventId: [%d], ret: [%d].", AICPU_SUB_EVENT_ABNORMAL_LOG, ret);
        }

        return;
    }
}  // namespace AicpuSchedule
