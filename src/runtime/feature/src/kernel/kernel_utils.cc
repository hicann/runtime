/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "kernel_utils.hpp"

namespace cce {
namespace runtime {
void ComputeRatio(uint16_t ratio[2], uint32_t mixType, uint32_t taskRatio) 
{
    ratio[0] = 0U;
    ratio[1] = 0U;
    switch (mixType) {
        case NO_MIX:
            break;
        case MIX_AIC:
            ratio[0] = 1U;
            ratio[1] = 0U;
            break;
        case MIX_AIV:
            ratio[0] = 0U;
            ratio[1] = 1U;
            break;
        case MIX_AIC_AIV_MAIN_AIC:
            if (taskRatio == 1U) {
                ratio[0] = 1U;
                ratio[1] = 1U;
            } else if (taskRatio == 2U) {
                ratio[0] = 1U;
                ratio[1] = 2U;
            } else {
                RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            }
            break;
        case MIX_AIC_AIV_MAIN_AIV:
            if (taskRatio == 1U) {
                ratio[0] = 1U;
                ratio[1] = 1U;
            } else if (taskRatio == 2U) {
                ratio[0] = 2U;
                ratio[1] = 1U;
            } else {
                RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            }
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            break;
    }
}

}
}