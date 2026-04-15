/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_STREAM_TASK_H
#define RUNTIME_STREAM_TASK_H

#include "driver.hpp"
#include "stars.hpp"
#include "task_info.hpp"
#include "hwts.hpp"

namespace cce {
namespace runtime {
rtError_t CreateStreamTaskInit(TaskInfo * const taskInfo, const uint32_t flag);
void ToCommandBodyForCreateStreamTask(TaskInfo * const taskInfo, rtCommand_t *const command);
rtError_t SqLockUnlockTaskInit(TaskInfo* taskInfo, const bool isLock);

rtError_t InitFuncCallParaForStreamActiveTask(TaskInfo* taskInfo, rtStarsStreamActiveFcPara_t &fcPara,
    const rtChipType_t chipType);
rtError_t StreamActiveTaskInit(TaskInfo* taskInfo, const Stream * const stm);
rtError_t ReConstructStreamActiveTaskFc(TaskInfo* taskInfo);
void ToCommandBodyForStreamActiveTask(TaskInfo* taskInfo, rtCommand_t * const command);
void StreamActiveTaskUnInit(TaskInfo * const taskInfo);
void PrintErrorInfoForStreamActiveTask(TaskInfo* taskInfo, const uint32_t devId);
rtError_t ActiveAicpuStreamTaskInit(TaskInfo* taskInfo, const uint64_t argsParam, const uint32_t argsSizeLen,
                                    const uint64_t func, const uint32_t kernelTypeId);
void ToCmdBodyForActiveAicpuStreamTask(TaskInfo* const taskInfo, rtCommand_t *const command);

rtError_t OverflowSwitchSetTaskInit(TaskInfo *taskInfo, Stream * const stm, const uint32_t flags);
rtError_t StreamTagSetTaskInit(TaskInfo *taskInfo, Stream * const stm, const uint32_t geOpTag);

rtError_t SetStreamModeTaskInit(TaskInfo *taskInfo, const uint64_t mode);
void ToCmdBodyForSetStreamModeTask(TaskInfo* taskInfo, rtCommand_t *const command);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_STREAM_TASK_H