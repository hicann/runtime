/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_DAVINCI_KERNEL_TASK_H
#define RUNTIME_DAVINCI_KERNEL_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
constexpr const uint32_t ARGS_PER_STRING_MAX_LEN = 20U;
void SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
void SetResultForDavinciTask(TaskInfo* taskInfo, const void *const data, const uint32_t dataSize);
void DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForCmoTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
rtError_t WaitAsyncCopyCompleteForDavinciTask(TaskInfo* taskInfo);

void DavinciTaskUnInit(TaskInfo *taskInfo);
void FillFftsAicAivCtxForDavinciTask(
    TaskInfo *const taskInfo, rtFftsPlusMixAicAivCtx_t *fftsCtx, uint32_t& minStackSize);
void FillFftsPlusMixSqeSubtask(const AicTaskInfo *taskInfo, uint8_t *const subtype);
void FillFftsMixSqeForDavinciTask(
    TaskInfo *taskInfo, rtStarsSqe_t *const command, uint32_t minStackSize, rtError_t copyRet);
void ConstructFftsMixSqeForDavinciTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, rtStarsSqe_t *const command);

void ConstructAICpuSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructAicAivSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ToCommandBodyForAicpuTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForAicAivTask(TaskInfo* taskInfo, rtCommand_t *const command);

void ShowDavinciTaskMixDebug(const rtFftsPlusMixAicAivCtx_t * const fftsCtx);
void GetKernelNameForAiCpu(TaskInfo* taskInfo, std::string &nameInfo);
void GetSoNameForAiCpu(TaskInfo* taskInfo, std::string &nameInfo);
void GetFirstExtendInfoForAicpuTask(TaskInfo* taskInfo, const uint32_t devId, std::string &extendInfo);

bool CheckErrPrint(const uint32_t errorCode);
}
}
#endif
