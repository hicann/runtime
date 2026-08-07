/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_close_monitor.h"

#include "aicpusd_monitor.h"

namespace AicpuSchedule {
namespace {
const std::string CLOSE_AICPU_MONITOR = "CloseAicpuMonitor";
struct CloseAicpuMonitorArgs {
    uint8_t monitorEn; /* 1=close aicpu self monitor, 0=open */
    uint8_t retcode;   /* set to 0 on success; errors are returned by Compute */
    uint8_t rsv[2];
};
} // namespace

int32_t CloseAicpuMonitorTsKernel::Compute(const aicpu::HwtsTsKernel& tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel CloseAicpuMonitor event.");
    const auto args = PtrToPtr<void, CloseAicpuMonitorArgs>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (args == nullptr) {
        aicpusd_err("param base for CloseAicpuMonitor is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const bool closeFlag = (args->monitorEn == 1U);
    AicpuMonitor::GetInstance().SetCloseMonitorFlag(closeFlag);
    args->retcode = 0U;
    aicpusd_info(
        "Process CloseAicpuMonitor, monitorEn[%u], closeFlag[%d].", args->monitorEn, static_cast<int32_t>(closeFlag));
    return AICPU_SCHEDULE_OK;
}

REGISTER_HWTS_KERNEL(CLOSE_AICPU_MONITOR, CloseAicpuMonitorTsKernel);
} // namespace AicpuSchedule
