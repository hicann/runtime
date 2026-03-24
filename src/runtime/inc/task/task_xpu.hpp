/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_XPU_HPP__
#define __CCE_RUNTIME_TASK_XPU_HPP__

#include "task_info.hpp"
#include "tprt_sqe_cqe.h"
#include "tprt_type.h"
#include "arg_loader_ub.hpp"

namespace cce {
namespace runtime {
    rtError_t XpuAllocTaskInfo(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, uint32_t sqeNum = 1U);
    rtError_t XpuSendTask(TaskInfo *taskInfo, Stream * const stm);
    void XpuTaskRollBack(Stream * const stm, uint32_t pos);
    void XpuSaveTaskCommonInfo(TaskInfo *taskInfo, Stream * const stm, uint32_t pos, uint32_t sqeNum = 1U);
    rtError_t XpuCheckTaskCanSend(Stream * const stm);
    void XpuSetArgsAicpu(const rtAicpuArgsEx_t *const aicpuArgsInfo,
        TaskInfo *const taskInfo, DavidArgLoaderResult *const result);
}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_TASK_XPU_HPP__
