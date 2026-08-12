/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_AICPU_TIMEOUT_MANAGER_H
#define CCE_RUNTIME_AICPU_TIMEOUT_MANAGER_H

#include "task_info.hpp"
#include "soc/soc_define.hpp"

namespace cce {
namespace runtime {

class Device;

// Device/TS raw timeout code; 0x21007 differs from decimal AICPU_TASK_EXECUTE_TIMEOUT (21007).
constexpr uint32_t AICPU_TIMEOUT_RAW_ERRCODE = 0x21007U;

class AicpuTimeoutManager {
public:
    static bool IsStarsMonitorAicpuTimeoutSupported(const Device* const dev);

    static bool IsTimeoutSupportedByKernelType(const Device* const dev, const uint32_t kernelType);

    static bool IsTimeoutSupportedByLaunchFlag(const Device* const dev, const uint32_t flag);

    static uint16_t GetAicpuDefaultKernelCredit(const Device* const dev);

    static void UpdateAicpuTimeoutStateOnCqeReport(
        Device* const dev, const rtLogicCqReport_t& logicCq, const TaskInfo* const reportTask,
        const TaskInfo* const faultTaskPtr);

    static void CheckAndStopAicpuProcess(Device* const dev);

    static rtError_t TryCloseAicpuMonitor(Device* const dev);

    static void ClearAicpuTimeoutState(Device* const dev);

private:
    static bool IsKfcType(const uint32_t kernelType);

    static void StopAicpuProcess(const Device* const dev);
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_AICPU_TIMEOUT_MANAGER_H
