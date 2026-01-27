/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CUST_AICPUSD_THREADS_PROCESS_H
#define CUST_AICPUSD_THREADS_PROCESS_H


#include <string>
#include <cstdint>
#include <sys/types.h>
#include "aicpusd_task_queue.h"
#include "aicpu_context.h"

namespace AicpuSchedule {
/**
 * compute process result code.
 */
enum class ComputProcessRetCode {
    CP_RET_SUCCESS = 0,     // success
    CP_RET_COMMON_ERROR,    // common error
};

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
     * @param  deviceId device id
     * @param  hostPid  host pid
     * @param  pidSign pid signature
     * @param  profilingMode profiling Mode
     * @param  aicpuPid aicpu-sd pid
     * @param  vfId vf id
     * @param  runMode pcie socket or thread run mode
     * @return 0:success, other:fail
     */
    int32_t Start(const uint32_t deviceId,
                  const pid_t hostPid,
                  const uint32_t profilingMode,
                  const pid_t aicpuPid,
                  const uint32_t vfId,
                  const aicpu::AicpuRunMode runMode);

    void UpdateProfilingSetting(uint32_t flag);

    bool DoSplitKernelTask(const AICPUSharderTaskInfo &taskInfo);
    bool DoRandomKernelTask();

    /**
     * stop compute process.
     */
    void Stop();
private:
    ComputeProcess();
    ~ComputeProcess() = default;

    // not allow copy constructor and assignment operators
    ComputeProcess(const ComputeProcess &) = delete;
    ComputeProcess &operator=(const ComputeProcess &) = delete;

    uint32_t RegisterScheduleTask();
    uint32_t SubmitRandomKernelTask(const aicpu::Closure &task);
    uint32_t SubmitSplitKernelTask(const AICPUSharderTaskInfo &taskInfo,
                                   const std::queue<aicpu::Closure> &taskQueue);
    uint32_t SubmitBatchSplitKernelEventOneByOne(const AICPUSharderTaskInfo &taskInfo) const;
    uint32_t SubmitBatchSplitKernelEventDc(const AICPUSharderTaskInfo &taskInfo);
    uint32_t SubmitOneSplitKernelEvent(const AICPUSharderTaskInfo &taskInfo) const;
    bool GetAndDoSplitKernelTask();

    // the device id
    uint32_t deviceId_;

    // the pid of host process
    pid_t hostPid_;

    // number of aicpu
    uint32_t aicpuNum_;

    // the Mode decide if profiling open
    ProfilingMode profilingMode_;

    // the pid of aicpu-sd process
    pid_t aicpuPid_;

    // vf id
    uint32_t vfId_;

    // sharder task for split kernel
    TaskMap splitKernelTask_;
 
    // sharder task for random kernel
    TaskQueue randomKernelTask_;

    // cust aicpusd run mode : thread pice socket
    aicpu::AicpuRunMode runMode_;
};
}
#endif