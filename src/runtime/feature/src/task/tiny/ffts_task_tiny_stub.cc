/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ffts_task.h"

namespace cce {
namespace runtime {

uint32_t GetSendSqeNumForFftsPlusTask(const TaskInfo * const taskInfo)
{
    UNUSED(taskInfo);
    return 1U;
}

void PushBackErrInfoForFftsPlusTask(TaskInfo* taskInfo, const void *errInfo, uint32_t len)
{
    UNUSED(taskInfo);
    UNUSED(errInfo);
    UNUSED(len);
}

void FftsPlusTaskUnInit(TaskInfo * const taskInfo)
{
    UNUSED(taskInfo);
}

void PrintErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(taskInfo);
    UNUSED(devId);
}

void SetStarsResultForFftsPlusTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    UNUSED(taskInfo);
    UNUSED(logicCq);
}

void ConstructSqeForFftsPlusTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
}

void DoCompleteSuccForFftsPlusTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(taskInfo);
    UNUSED(devId);
}

void SqeTaskUpdateForFftsPlus(TaskInfo* taskInfo, rtStarsSqe_t * const fftsplusSqe)
{
    UNUSED(taskInfo);
    UNUSED(fftsplusSqe);
}
}  // namespace runtime
}  // namespace cce