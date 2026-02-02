/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUSD_CONTEXT_H
#define AICPUSD_CONTEXT_H

#include "aicpusd_status.h"

namespace AicpuSchedule {
enum class DeployContext {
    DEVICE = 0,
    HOST = 1,
};

/**
 * get aicpu deploy context(host or device).
 * @param [in]deployContext aicpu deploy context
 * @return status whether this operation success
 */
StatusCode GetAicpuDeployContext(DeployContext &deployCtx);

/**
 * set cpu mode(whether InitCpuScheduler is called or not).
 * @param [in]cpuMode cpu mode
 */
void SetCpuMode(const bool cpuMode);

/**
 * get cpu mode(whether InitCpuScheduler is called or not).
 * @return cpu mode
 */
bool GetCpuMode();
} // namespace AicpuSchedule
#endif