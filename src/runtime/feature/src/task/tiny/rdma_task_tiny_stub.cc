/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "rdma_task.h"

namespace cce {
namespace runtime {

void PrintErrorInfoForRDMAPiValueModifyTask(TaskInfo *const taskInfo, const uint32_t devId)
{
    UNUSED(taskInfo);
    UNUSED(devId);
}

rtError_t SubmitRdmaPiValueModifyTask(
    Stream *const stm, const rtFftsPlusTaskInfo_t *const fftsPlusTaskInfo, const void *deviceDescAlignBuf)
{
    UNUSED(stm);
    UNUSED(fftsPlusTaskInfo);
    UNUSED(deviceDescAlignBuf);
    return RT_ERROR_NONE;
}

void ConstructSqeRdmaPiValueModifyTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
}

void RdmaPiValueModifyTaskUnInit(TaskInfo *taskInfo)
{
    UNUSED(taskInfo);
}

void PrintDfxInfoForRdmaPiValueModifyTask(const TaskInfo *taskInfo, const uint32_t devId)
{
    UNUSED(taskInfo);
    UNUSED(devId);
}

uint32_t GetSendSqeNumForRdmaDbSendTask(TaskInfo * const taskInfo)
{
    UNUSED(taskInfo);
    return 1U;
}

void ToCommandBodyForRdmaSendTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
}

void ToCommandBodyForRdmaDbSendTask(TaskInfo* taskInfo, rtCommand_t * const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
}

void ConstructSqeForRdmaDbSendTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
}

}  // namespace runtime
}  // namespace cce