/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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

static constexpr uint16_t RT_STARS_MAX_TIMEOUT_KERNEL_CREDIT = 256U;

uint16_t TransKernelCreditCreditByChip(const uint16_t kernelCredit)
{
    rtChipType_t chipType = Runtime::Instance()->GetChipType();
    static bool isGet = false;
    static uint16_t creditStartValue = UINT16_MAX;

    if (!isGet) {
        DevProperties devProperty{};
        rtError_t error = GET_DEV_PROPERTIES(chipType, devProperty);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, kernelCredit, "Failed to get dev properties, chipType = %d error = %d", chipType,
            error);

        creditStartValue = devProperty.creditStartValue;
        isGet = true;
    }

    return (kernelCredit == 0U) ? creditStartValue : (kernelCredit - 1U);
}

void TransExeTimeoutCfgToKernelCredit(const uint64_t opExcTaskTimeout, uint16_t& kernelCredit)
{
    const float64_t kernelCreditScale = Runtime::Instance()->GetKernelCreditScaleUS();
    if ((opExcTaskTimeout != 0ULL) && (kernelCreditScale >= RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN)) {
        const float64_t trans = ceil(static_cast<float64_t>(opExcTaskTimeout) / kernelCreditScale);
        kernelCredit = (trans > static_cast<float64_t>(RT_STARS_MAX_TIMEOUT_KERNEL_CREDIT)) ?
                           RT_STARS_MAX_TIMEOUT_KERNEL_CREDIT :
                           static_cast<uint16_t>(trans);
    } else {
        kernelCredit = RT_STARS_MAX_TIMEOUT_KERNEL_CREDIT;
    }
}

uint16_t GetAicoreKernelCredit(const uint64_t customTimeoutUs)
{
    uint16_t kernelCredit = 0U;
    const RtTimeoutConfig& timeoutCfg = Runtime::Instance()->GetTimeoutConfig();
    if (customTimeoutUs == std::numeric_limits<uint64_t>::max()) {
        kernelCredit = RT_STARS_MAX_TIMEOUT_KERNEL_CREDIT; // max timeout, launch 时配置 timeout = 0
    } else if (customTimeoutUs != 0ULL) {                  // launch 时配置 timeout > 0
        TransExeTimeoutCfgToKernelCredit(customTimeoutUs, kernelCredit);
    } else if (timeoutCfg.isCfgOpExcTaskTimeout) {
        TransExeTimeoutCfgToKernelCredit(timeoutCfg.opExcTaskTimeout, kernelCredit);
    } else {
        kernelCredit = Runtime::Instance()->GetStarsFftsDefaultKernelCredit();
    }

    return TransKernelCreditCreditByChip(kernelCredit);
}
} // namespace runtime
} // namespace cce