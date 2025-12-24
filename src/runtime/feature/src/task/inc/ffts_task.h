/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_FFTS_TASK_H
#define RUNTIME_FFTS_TASK_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
rtError_t FftsPlusTaskInit(TaskInfo* taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
                           const uint32_t flag);
rtError_t FillFftsPlusSqe(TaskInfo* taskInfo, const void * const devMem);
void DoCompleteSuccForFftsPlusTask(TaskInfo* taskInfo, const uint32_t devId);
void FftsPlusTaskUnInit(TaskInfo * const taskInfo);
void SqeTaskUpdateForFftsPlus(TaskInfo* taskInfo, rtStarsSqe_t * const fftsplusSqe);
uint32_t GetSendSqeNumForFftsPlusTask(const TaskInfo * const taskInfo);
void ConstructSqeForFftsPlusTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void PrintDsaErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const rtFftsPlusTaskErrInfo_t &info,
                                      const uint32_t devId);
void PrintAicAivErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const rtFftsPlusTaskErrInfo_t &info, uint32_t devId);
void GetExceptionArgsForFftsPlus(TaskInfo* taskInfo, const rtExceptionExpandInfo_t * const expandInfo,
                                 uint32_t errType, rtExceptionArgsInfo_t *argsInfo);
void PrintErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const uint32_t devId);
void PushBackErrInfoForFftsPlusTask(TaskInfo* taskInfo, const void *errInfo, uint32_t len);
void SetStarsResultForFftsPlusTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_FFTS_TASK_H
