/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_COMMON_H
#define HWTS_KERNEL_COMMON_H

#include <cstdint>
#include "aicpusd_common.h"
#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_resource_manager.h"
#include "tsd.h"

namespace AicpuSchedule {
class HwTsKernelCommon {
public:
    /**
     * @ingroup EventHandlerCommon
     * @brief it use to set process end graph.
     * @param [in] modelId : the id of model.
     * @return none
     */
    static int32_t ProcessEndGraph(const uint32_t modelId);

private:
    HwTsKernelCommon() = default;
    ~HwTsKernelCommon() = default;

    HwTsKernelCommon(HwTsKernelCommon const&) = delete;
    HwTsKernelCommon& operator=(HwTsKernelCommon const&) = delete;
    HwTsKernelCommon(HwTsKernelCommon&&) = delete;
    HwTsKernelCommon& operator=(HwTsKernelCommon&&) = delete;
};
}  // namespace AicpuSchedule

#endif  // HWTS_KERNEL_COMMON_H