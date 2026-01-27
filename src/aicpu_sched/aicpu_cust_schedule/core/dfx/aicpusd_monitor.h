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

#include <atomic>
#include <mutex>
#include <functional>
#include <memory>
#include <thread>
#include <sstream>
#include <string>
#include <semaphore.h>
#include "aicpusd_status.h"
#include "aicpusd_common.h"

namespace AicpuSchedule {
    class TaskTimer {
    public:
        TaskTimer() : startTick_(0ULL), runFlag_(false)
        {}
        TaskTimer(const uint64_t tick, const bool flag) : startTick_(tick), runFlag_(flag)
        {}
        ~TaskTimer() = default;

        inline uint64_t GetStartTick() const
        {
            return startTick_.load();
        }

        inline void SetStartTick(const uint64_t tick)
        {
            startTick_ = tick;
        }

        inline bool GetRunFlag() const
        {
            return runFlag_.load();
        }

        inline void SetRunFlag(const bool flag)
        {
            runFlag_ = flag;
        }

    private:
        std::atomic<uint64_t> startTick_;
        std::atomic<bool> runFlag_;
    };

    struct TaskInfoForMonitor {
        uint64_t serialNo;
        uint64_t taskId;
        uint32_t streamId;
        bool isHwts;
        std::string DebugString() const
        {
            std::ostringstream oss;
            oss << "serialNo=" << serialNo
                << ", stream_id=" << streamId
                << ", task_id=" << taskId;
            return oss.str();
        }
    };

    class AicpuMonitor {
    public:
        static AicpuMonitor &GetInstance();

        int32_t InitAicpuMonitor(const uint32_t deviceId, const bool online);

        void SetTaskInfo(const uint64_t taskIndex, const TaskInfoForMonitor &taskInfo);
        void SetTaskStartTime(const uint64_t taskIndex);
        void SetTaskEndTime(const uint64_t taskIndex);

        int32_t Run();

        void Stop();

        void SendAbnormalMsgToMain() const;

        ~AicpuMonitor();
    private:
        AicpuMonitor();

        AicpuMonitor(const AicpuMonitor &) = delete;

        AicpuMonitor &operator=(const AicpuMonitor &) = delete;

        int32_t SetTaskTimeoutFlag();

        static void Work(AicpuMonitor *const monitor);

        void HandleTaskTimeout();

        void SendKillMsgToTsd() const;

        uint32_t deviceId_;
        bool taskTimeoutFlag_;
        std::unique_ptr<TaskInfoForMonitor[]> taskInfo_;

        // aicpu-cust-sd need too
        std::mutex mutex_;
        std::atomic<bool> done_;

        uint64_t taskTimeout_;
        uint64_t taskTimeoutTick_;
        std::unique_ptr<TaskTimer[]> taskTimer_;
        sem_t sem_;
        bool running_;
        uint32_t aicpuCoreNum_;
        bool online_;  // true when exist in process mode; false when exist in thread mode
    };
}
#endif // CORE_AICPUSD_MONITOR_H
