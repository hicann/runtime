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
void PrintErrorInfoForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);

void FillFftsAicAivCtxForDavinciTask(
    TaskInfo *const taskInfo, rtFftsPlusMixAicAivCtx_t *fftsCtx, uint32_t& minStackSize);
void AicTaskInitCommon(TaskInfo *taskInfo, const rtKernelAttrType kernelAttrType, const uint16_t dimNum, const uint32_t flag,
    const bool isNeedAllocSqeDevBuf);
void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, rtStarsSqe_t *const command);

void ToCommandBodyForAicpuTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForAicAivTask(TaskInfo* taskInfo, rtCommand_t *const command);

void ShowDavinciTaskMixDebug(const rtFftsPlusMixAicAivCtx_t * const fftsCtx);
void GetKernelNameForAiCpu(TaskInfo* taskInfo, std::string &nameInfo);
void GetSoNameForAiCpu(TaskInfo* taskInfo, std::string &nameInfo);
void GetFirstExtendInfoForAicpuTask(TaskInfo* taskInfo, const uint32_t devId, std::string &extendInfo);
uint32_t GetSchemMode(AicTaskInfo* const taskInfo);

bool CheckErrPrint(const uint32_t errorCode);

void AicpuTaskInit(TaskInfo *taskInfo, const uint16_t dimNum, const uint32_t flag);
void AicTaskInit(TaskInfo *taskInfo, const rtKernelAttrType kernelAttrType,
    const uint16_t dimNum, const uint32_t flag, const TaskCfg * const taskcfg,
    const bool isNeedAllocSqeDevBuf = false);

void TransDavinciTaskToVectorCore(const uint32_t flags, uint64_t addr2, uint64_t &addr1,
    uint8_t &mixType, rtKernelAttrType &kernelAttrType, const bool isLaunchVec);
rtError_t CheckMixKernelValid(const uint8_t mixType, const uint64_t func2);
uint16_t GetAICpuQos(const TaskInfo * const taskInfo);
void SetPcTrace(TaskInfo *taskInfo, std::shared_ptr<PCTrace> pcTracePtr);
rtError_t FillKernelLaunchPara(const rtKernelLaunchNames_t * const launchNames,
    TaskInfo* taskInfo, ArgLoader * const devArgLdr);
void ParseExtendInfo(TaskInfo* taskInfo, const char_t *const extInfos, const uint64_t extInfoLen,
    const uint64_t extInfoStructLen, std::string &extendInfo);
rtError_t GetArgsInfo(TaskInfo* taskInfo);
rtError_t GetMixCtxInfo(TaskInfo* taskInfo);
void PreCheckTaskErr(TaskInfo* taskInfo, const uint32_t devId);
std::string GetTaskKernelName(const TaskInfo *task);
}
}
#endif
