/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_execute_time.h"
#include "stars_base.hpp"
#include "stars.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
uint16_t TransKernelCreditCreditByChip(const uint16_t kernelCredit)
{
    rtChipType_t chipType = Runtime::Instance()->GetChipType();
    static bool isGet = false;
    static uint16_t creditStartValue = UINT16_MAX;

    if (!isGet) {
        DevProperties devProperty {};
        rtError_t error = GET_DEV_PROPERTIES(chipType, devProperty);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, kernelCredit,
            "Failed to get dev properties, chipType = %u error = %u", chipType, error);

        creditStartValue = devProperty.creditStartValue;
        isGet = true;
    }
    if (creditStartValue != UINT16_MAX) {
        // To prevent errors caused by kernelCredit = 0 in sqe, hardware calculates timeout by kernelCredit + 1.
        return (kernelCredit == 0U) ? creditStartValue : (kernelCredit - 1U);
    }
    return kernelCredit;
}

void TransExeTimeoutCfgToKernelCredit(const uint64_t opExcTaskTimeout, uint16_t &kernelCredit)
{
    const float64_t kernelCreditScale = Runtime::Instance()->GetKernelCreditScaleUS();
    if ((opExcTaskTimeout != 0ULL) && (kernelCreditScale >= RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN)) {
        const float64_t trans = ceil(static_cast<float64_t>(opExcTaskTimeout) / kernelCreditScale);
        kernelCredit = (trans > static_cast<float64_t>(RT_STARS_MAX_KERNEL_CREDIT)) ?
            RT_STARS_MAX_KERNEL_CREDIT : static_cast<uint16_t>(trans);
    } else {
        kernelCredit = RT_STARS_MAX_KERNEL_CREDIT;
    }
}

uint16_t GetAicoreKernelCredit(const uint64_t customTimeoutUs)
{
    uint16_t kernelCredit = 0U;
    const RtTimeoutConfig &timeoutCfg = Runtime::Instance()->GetTimeoutConfig();
    if (customTimeoutUs == std::numeric_limits<uint64_t>::max()) {
        kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT; // never timeout
    } else if (customTimeoutUs != 0ULL) {
        TransExeTimeoutCfgToKernelCredit(customTimeoutUs, kernelCredit);
    } else if (timeoutCfg.isCfgOpExcTaskTimeout) {
        TransExeTimeoutCfgToKernelCredit(timeoutCfg.opExcTaskTimeout, kernelCredit);
    } else {
        kernelCredit = Runtime::Instance()->GetStarsFftsDefaultKernelCredit();
    }

    return TransKernelCreditCreditByChip(kernelCredit);
}

uint16_t GetSdmaKernelCredit()
{
    uint16_t kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    const RtTimeoutConfig &timeoutCfg = Runtime::Instance()->GetTimeoutConfig();
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const static bool timeoutFlag = IS_SUPPORT_CHIP_FEATURE(chipType,
 	         RtOptionalFeatureType::RT_FEATURE_KERNEL_CREDIT_CALC_FROM_EXE_TIMEOUT);
    if (timeoutFlag && timeoutCfg.isCfgOpExcTaskTimeout) {
        TransExeTimeoutCfgToKernelCredit(timeoutCfg.opExcTaskTimeout, kernelCredit);
    } else if (timeoutCfg.isCfgOpExcTaskTimeout && timeoutCfg.isOpTimeoutMs) {
        TransExeTimeoutCfgToKernelCredit(timeoutCfg.opExcTaskTimeout, kernelCredit);
    } else {
        // no op
    }
    return TransKernelCreditCreditByChip(kernelCredit);
}

uint16_t GetAicpuKernelCredit(uint64_t timeout)
{
    uint64_t tmpTimeout = 0UL;
    uint16_t kernelCredit = RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;
    const RtTimeoutConfig &timeoutCfg = Runtime::Instance()->GetTimeoutConfig();
    if (timeout != 0U) {
        tmpTimeout = timeout;
    } else if (timeoutCfg.isCfgOpExcTaskTimeout) {
        tmpTimeout = timeoutCfg.opExcTaskTimeout;
    } else {
        // no op
    }
    TransExeTimeoutCfgToKernelCredit(tmpTimeout, kernelCredit);
    RT_LOG(RT_LOG_DEBUG, "timeout=%" PRIu64 "us, isCfg=%u, cfgTime=%" PRIu64 "us, kernelCredit=%u.",
        timeout, timeoutCfg.isCfgOpExcTaskTimeout, timeoutCfg.opExcTaskTimeout, kernelCredit);
    if (kernelCredit < (RT_STARS_MAX_KERNEL_CREDIT - RT_STARS_TASK_KERNEL_CREDIT_SCALE_UINT8)) {
        kernelCredit += RT_STARS_TASK_KERNEL_CREDIT_SCALE_UINT8;
    }
    return TransKernelCreditCreditByChip(kernelCredit);
}
}  // namespace runtime
}  // namespace cce