/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ARCH920X_SQE_UTILS_HPP
#define CCE_RUNTIME_ARCH920X_SQE_UTILS_HPP
#include "task_info.hpp"
#include "aic_aiv_sqe.h"

namespace cce {
namespace runtime {

class Kernel;

void GetDcachePrefetchCnt(const TaskInfo* taskInfo, RtArch920xStarsAicAivKernelSqe* const sqe);
void ConfigArch920xOstEnable(const Kernel* kernel, RtArch920xStarsAicAivKernelSqe* const sqe);
void ConfigArch920xSqeHeaderTaskProfiling(rtDavidStarsSqeHeader_t* const header);
} // namespace runtime
} // namespace cce
#endif // CCE_RUNTIME_ARCH920X_SQE_UTILS_HPP
