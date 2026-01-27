/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_MONITOR_H
#define CORE_AICPUSD_MONITOR_H

#include <map>
#include <atomic>
#include <mutex>
#include <functional>
#include <string>
#include <memory>
#include <thread>
#include <sstream>
#include <semaphore.h>
#include <vector>
#include "aicpusd_status.h"
#include "aicpu_timer.h"
#include "profiling_adp.h"
#include "aicpusd_common.h"

namespace AicpuSchedule {
class TaskTimer {
public:
    TaskTimer() : startTick(0UL), runFlag(false), timeInTick(0UL) {}
    TaskTimer(const uint64_t tick, const bool isRun) : startTick(tick), runFlag(isRun), timeInTick(0UL) {}
    ~TaskTimer() = default;

    inline uint64_t GetStartTick() const
    {
        return startTick.load();
    };
    inline bool GetRunFlag() const
    {
        return runFlag.load();
    };
    inline void SetStartTick(const uint64_t tick)
    {
        startTick = tick;
    };
    inline void SetRunFlag(const bool isRun)
    {
        runFlag = isRun;
    };
    inline void SetTimeTick(const uint32_t timeS)
    {
        timeInTick = timeS * aicpu::GetSystemTickFreq();
    };
    inline uint64_t GetTimeTick() const
    {
        return timeInTick;
    };

private:
    std::atomic<uint64_t> startTick;
    std::atomic<bool> runFlag;
    std::atomic<uint64_t> timeInTick;
};

struct TaskInfoForMonitor {
    uint64_t serialNo;
    uint64_t taskId;
    uint32_t streamId;
    bool isHwts;
};

class MonitorDebug {
public:
    static std::string MonitorDebugString(const TaskInfoForMonitor &monitor)
    {
        std::ostringstream oss;
        oss << "serialNo=" << monitor.serialNo << ", stream_id=" << monitor.streamId << ", task_id=" << monitor.taskId;
        return oss.str();
    }
};

class AicpuMonitor {
public:
    static AicpuMonitor &GetInstance();

    int32_t InitMonitor(const uint32_t devId, const bool isOnline);

    void SetTaskInfo(const uint32_t threadIndex, const TaskInfoForMonitor &taskInfo) const;

    void SetTaskStartTime(const uint32_t taskId);
    void SetTaskEndTime(const uint32_t taskId);
    void SetAicpuStreamTaskStartTime(const uint32_t taskId);
    void SetAicpuStreamTaskEndTime(const uint32_t taskId);
    void SetModelStartTime(const uint32_t modelId);
    void SetModelEndTime(const uint32_t modelId);
    void SetOpTimerStartTime(const aicpu::TimerHandle timerId, const uint32_t timeInS);
    void SetOpTimerEndTime(const aicpu::TimerHandle timerId);
    uint32_t GetTaskDefaultTimeout() const;
    void SendKillMsgToTsd();

    void SetOpExecuteTimeOut(const uint32_t timeOutEn, const uint32_t opExecuteTimeOut);
    void SetOpTimeoutFlag(const bool flag);
    int32_t Run();
    void StopMonitor();
    ~AicpuMonitor();
    void DisableModelTimeout();

private:
    AicpuMonitor();

    AicpuMonitor(const AicpuMonitor &) = delete;

    AicpuMonitor &operator = (const AicpuMonitor &) = delete;

    int32_t InitTimer();
    int32_t SetTaskTimeoutFlag();
    int32_t SetModelTimeoutFlag();
    void InitAsyncOpTimer();
    static void Work(AicpuMonitor *const monitor);
    void HandleTaskTimeout();
    void HandleModelTimeout();
    void HandleOpTimeout();
    void SendKillMsgToTsd(uint64_t delayReportSecond);

    uint32_t deviceId_;
    std::atomic<bool> taskTimeoutFlag_;
    bool modelTimeoutFlag_;
    std::unique_ptr<TaskInfoForMonitor[]> monitorTaskInfo_;

    // aicpu-cust-sd need too
    std::mutex mutex_;
    std::atomic<bool> done_;
    // op execute time out set by ts enable flag
    std::mutex setTimeOutMut_;
    std::atomic<bool> tsTimeoutEnable_;
    // op execute time out value set by ts
    std::atomic<uint32_t> tsOpTimeOut_;

    uint64_t taskTimeout_;
    std::atomic<uint64_t> taskTimeoutTick_;
    uint64_t modelTimeoutTick_;
    std::unique_ptr<TaskTimer[]> aicpuTaskTimer_;
    std::unique_ptr<TaskTimer[]> aicpuStreamTaskTimer_;
    std::unique_ptr<TaskTimer[]> modelTimer_;
    std::map<aicpu::TimerHandle, std::shared_ptr<TaskTimer>> opTimer_;

    std::vector<std::thread> th_;
    sem_t sem_;
    bool running_;
    uint32_t aicpuCoreNum_;
    bool online_; // true when exist in process mode; false when exist in thread mode
    std::atomic<bool> opTimeoutFlag_;
    std::mutex opTimerMapMutex_;
};
}

#endif // CORE_AICPUSD_MONITOR_H