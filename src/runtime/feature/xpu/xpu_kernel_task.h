/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_XPU_KERNEL_TASK_H
#define RUNTIME_XPU_KERNEL_TASK_H

#include "tprt_type.h"
#include "tprt_sqe_cqe.h"
#include "task_info.hpp"

namespace cce {
namespace runtime {

void XpuPrintAICpuErrorInfoForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
void TprtDavinciTaskUnInit(TaskInfo *taskInfo);
void DoCompleteSuccessForXpuDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
void SetTprtResultForDavinciTask(TaskInfo* taskInfo, const TprtLogicCqReport_t &logicCq);
void ConstructTprtAICpuSqeForDavinciTask(TaskInfo *taskInfo, TprtSqe_t * const command);

}
}
#endif