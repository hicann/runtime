/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUSD_THREADS_PROCESS_H
#define AICPUSD_THREADS_PROCESS_H

#include <cstdint>
#include <sys/types.h>
#include <pthread.h>
#include "aicpu_sharder.h"
#include "aicpusd_task_queue.h"
#include "aicpu_context.h"
#include "aicpusd_interface.h"

namespace AicpuSchedule {
/**
 * compute process class.
 */
class ComputeProcess {
public:
    /**
     * Get instance.
     * @return instance.
     */
    static ComputeProcess &GetInstance();

    /**
     * start compute process.
     * @param  deviceId       device id
     * @param  hostPid        host pid
     * @param  profilingMode  profiling Mode
     * @param  pidSign        pid signature
     * @param  vfId           vfId
     * @param  runMode        aicpu run mode
     * @return 0:success, other:fail
     */
    int32_t Start(const std::vector<uint32_t> &deviceVec,
                  const pid_t hostPid, const std::string &pidSign,
                  const uint32_t profilMode, const uint32_t vfId, const aicpu::AicpuRunMode runMode,
                  const AicpuSchedMode schedMode);

    /**
     * stop compute process.
     */
    void Stop();

    /**
     * update profiling Mode.
     */
    void UpdateProfilingMode(const ProfilingMode mode) const;

    /**
     * update profiling Model Mode.
     */
    void UpdateProfilingModelMode(const bool mode) const;

    std::string DebugString();
    bool DoSplitKernelTask(const AICPUSharderTaskInfo &taskInfo);
    bool DoRandomKernelTask();

private:
    ComputeProcess();
    ~ComputeProcess() = default;

    // not allow copy constructor and assignment operators
    ComputeProcess(ComputeProcess &) = delete;
    ComputeProcess &operator = (ComputeProcess &) = delete;

    /**
     * start tdt server.
     */
    int32_t StartTdtServer();

    /**
     * stop tdt server.
     */
    void StopTdtServer() const;

    /**
     * register sharder task
     * @return 0:success, other:fail
     */
    int32_t RegisterScheduleTask();

    uint32_t SubmitRandomKernelTask(const aicpu::Closure &task);
    uint32_t SubmitSplitKernelTask(const AICPUSharderTaskInfo &taskInfo,
                                   const std::queue<aicpu::Closure> &taskQueue);
    uint32_t SubmitBatchSplitKernelEventOneByOne(const AICPUSharderTaskInfo &taskInfo) const;
    uint32_t SubmitBatchSplitKernelEventDc(const AICPUSharderTaskInfo &taskInfo);
    uint32_t SubmitOneSplitKernelEvent(const AICPUSharderTaskInfo &taskInfo) const;
    bool GetAndDoSplitKernelTask();

    int32_t MemorySvmDevice();
    void LoadKernelSo();

    void LoadExtendKernelSo();

private:
    // the device id
    std::vector<uint32_t> deviceVec_;

    // host device id
    uint32_t hostDeviceId_;

    // the pid of host process
    pid_t hostPid_;

    // the pid sign of host process
    std::string pidSign_;

    // aicpu num of all device
    uint32_t aicpuNum_;

    // the Mode decide if profiling open
    ProfilingMode profilingMode_;

    // sharder task for split kernel
    TaskMap splitKernelTask_;

    // sharder task for random kernel
    TaskQueue randomKernelTask_;

    // vf id
    uint32_t vfId_;

    // it is used to mark whether the tdt server is opened.
    bool isStartTdtFlag_;

    // aicpu run mode
    aicpu::AicpuRunMode runMode_;
};
}

#endif
