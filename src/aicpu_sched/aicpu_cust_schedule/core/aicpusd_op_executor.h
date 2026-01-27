/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_OP_EXECUTOR_H
#define CORE_AICPUSD_OP_EXECUTOR_H

#include <string>
#include <sys/types.h>
#include "aicpu_event_struct.h"
#include "tsd.h"

namespace AicpuSchedule {
class CustomOpExecutor {
public:
    __attribute__((visibility("default"))) static CustomOpExecutor &GetInstance();

    __attribute__((visibility("default"))) void InitOpExecutor(const pid_t pid, const std::string &custSoPath);

    int32_t OpenKernelSo(const event_info_priv &privEventInfo) const;

    static int32_t OpenKernelSoByAicpuEvent(const struct TsdSubEventInfo * const msg);

    int32_t ExecuteKernel(aicpu::HwtsTsKernel &tsKernelInfo) const;

private:
    CustomOpExecutor() = default;
    ~CustomOpExecutor() = default;

    CustomOpExecutor(const CustomOpExecutor &) = delete;
    CustomOpExecutor &operator=(const CustomOpExecutor &) = delete;

    // pid of host process
    pid_t hostPid_ = -1;
};
}
#endif // CORE_AICPUSD_OP_EXECUTOR_H