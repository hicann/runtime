/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_MANAGER_XPU_HPP__
#define __CCE_RUNTIME_TASK_MANAGER_XPU_HPP__

#include "task_info.hpp"
#include "tprt_sqe_cqe.h"
#include "tprt_type.h"

namespace cce {
namespace runtime {
    using PfnTaskToTprtSqe = void (*)(TaskInfo *taskInfo, TprtSqe_t *const tprtSqe);
    using PfnTaskSetTprtResult = void (*)(TaskInfo *taskInfo, const TprtLogicCqReport_t &logicCq);
    void XpuSetStarsResult(TaskInfo *taskInfo, const TprtLogicCqReport_t &logicCq);
    void RegXpuTaskFunc(void);
    void XpuComplete(TaskInfo *const taskInfo, const uint32_t devId = RT_MAX_DEV_NUM);
    void ToConstructXpuSqe(TaskInfo *taskInfo, TprtSqe_t *const tprtSqe);
    void XpuTaskUnInitProc(TaskInfo *taskInfo);
    const char_t *GetXpuSqeDescByType(const uint8_t sqeType);
    void XpuPrintErrorInfo(TaskInfo *taskInfo, const uint32_t devId);
}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_TASK_MANAGER_XPU_HPP__
