/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_TASK_INFO_H
#define RUNTIME_TASK_INFO_H

#include "driver.hpp"
#include "stars.hpp"

namespace cce {
namespace runtime {
using PfnDoCompleteSucc = void (*)(TaskInfo *taskInfo, const uint32_t devId);
using PfnTaskUnInit = void (*)(TaskInfo *taskInfo);
using PfnPrintErrorInfo = void (*)(TaskInfo *taskInfo, const uint32_t devId);
using PfnTaskSetStarsResult = void (*)(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);
extern PfnDoCompleteSucc g_doCompleteSuccFunc[TS_TASK_TYPE_RESERVED];
extern PfnTaskUnInit g_taskUnInitFunc[TS_TASK_TYPE_RESERVED];
extern PfnPrintErrorInfo g_printErrorInfoFunc[TS_TASK_TYPE_RESERVED];
extern PfnTaskSetStarsResult g_setStarsResultFunc[TS_TASK_TYPE_RESERVED];
void ConstructSqeForModelExecuteTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForCallbackLaunchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForNpuGetFloatStaTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForNpuClrFloatStaTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForNotifyWaitTask(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForGetDevMsgTask(TaskInfo* taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForAllocDsaAddrTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForFlipTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForStarsVersionTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForUpdateAddressTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command);
void ConstructSqeForAicpuInfoLoadTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForNopTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForCommonCmdTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructSqeForWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void ToCommandBodyForCreateL2AddrTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForKernelFusionTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForPCTraceTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ToCommandBodyForModelExecuteTask(TaskInfo * const taskInfo, rtCommand_t * const command);
void ToCmdBodyForAddModelExitTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCmdBodyForCallbackLaunchTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForNotifyWaitTask(TaskInfo *taskInfo, rtCommand_t *const command);
void ToCommandBodyForGetDevMsgTask(TaskInfo* taskInfo, rtCommand_t * const command);
void ToCmdBodyForFlipTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void ToCommandBodyForModelUpdateTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForAicpuInfoLoadTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandForNopTask(TaskInfo *const taskInfo, rtCommand_t *const command);
void DoCompleteSuccessForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
void DoCompleteSuccessForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId);
void DoCompleteSuccessForAicpuInfoLoadTask(TaskInfo* taskInfo, const uint32_t devId);
void DoCompleteSuccessForIpcRecordTask(TaskInfo* taskInfo, const uint32_t devId);
void DoCompleteSuccessForIpcWaitTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
void PrintErrorModelExecuteTaskFuncCall(TaskInfo *const task);
void PrintErrorInfoForNotifyWaitTask(TaskInfo *const taskInfo, const uint32_t devId);
void SetStarsResultForModelExecuteTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq);
void SetStarsResultForAicpuInfoLoadTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
void PCTraceTaskUnInit(TaskInfo * const taskInfo);
void ModelExecuteTaskUnInit(TaskInfo * const taskInfo);
void SetResultForModelExecuteTask(TaskInfo * const taskInfo, const void * const data, const uint32_t dataSize);

void PrintErrorInfoCommon(TaskInfo *taskInfo, const uint32_t devId);
rtError_t AllocFuncCallMemForModelExecuteTask(TaskInfo * const taskInfo, rtStarsModelExeFuncCallPara_t &funcCallPara);
void RegTaskToCommandFunc(void);
rtError_t StarsV2ConstructFuncCallPara(TaskInfo * const taskInfo, rtStarsModelExeFuncCallPara_t &funcCallPara);
}
}
#endif

