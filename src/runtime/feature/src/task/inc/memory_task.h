/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_MEMORY_TASK_H
#define RUNTIME_MEMORY_TASK_H

#include "driver.hpp"
#include "stars.hpp"
#include "event.hpp"
namespace cce {
namespace runtime {

constexpr uint32_t MEM_WAIT_WRITE_VALUE_ADDRESS_LEN = 64U;

rtError_t MemcpyAsyncTaskCommonInit(TaskInfo * const taskInfo);
rtError_t ConvertAsyncDma(TaskInfo * const taskInfo, TaskInfo * const updateTaskInfo, bool isUbMode);
void ToCommandBodyForMemcpyAsyncTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void ConstructSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command);
void ConstructPlaceHolderSqe(TaskInfo * const taskInfo, rtStarsSqe_t * const command);
void DoCompleteSuccessForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId);
void MemcpyAsyncTaskUnInit(TaskInfo * const taskInfo);
void SetStarsResultForMemcpyAsyncTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq);
void PrintErrorInfoForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId);
bool GetModuleIdByMemcpyAddr(Driver * const driver, void *memcpyAddr, uint32_t *moduleId);
void PrintModuleIdProc(Driver * const driver, char_t * const errStr, void *src, void *dst, int32_t *count);
void ReleaseCpyTmpMemFor3588(TaskInfo * const taskInfo);
rtError_t AllocCpyTmpMemFor3588(TaskInfo * const taskInfo, uint32_t &cpyType,
                                const void *&src, void *&des, uint64_t size);
rtError_t MixKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize);
rtError_t SqeUpdateH2DTaskInit(TaskInfo * const taskInfo, void *srcAddr, void *dstAddr, const uint64_t cpySize,
                               void *releaseArgHandle);
rtError_t NormalKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize);

/* D2H copy, src = sqeBaseAddr + sqeOffset, dst info = sqId + pos + sqeOffset, convert dst addr by ts-agent */
rtError_t UpdateD2HTaskInit(TaskInfo * const taskInfo, const void *sqeBaseAddr, const uint64_t cpySize,
                                        const uint32_t sqId, const uint32_t pos, const uint8_t sqeOffset);

rtError_t MemWriteValueTaskInit(TaskInfo *taskInfo, const void * const devAddr, const uint64_t value);
void ConstructSqeForMemWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
rtError_t MemWaitValueTaskInit(TaskInfo *taskInfo, const void * const devAddr,
                               const uint64_t value, const uint32_t flag);
void ConstructSqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void MemWaitTaskUnInit(TaskInfo *taskInfo);
uint32_t GetSendSqeNumForMemWaitTask(const TaskInfo * const taskInfo);
void ReleaseCpyTmpMemForStarsV2(TaskInfo * const taskInfo);
rtError_t AllocCpyTmpMemForStarsV2(TaskInfo * const taskInfo, uint32_t &cpyType,
    const void *&srcAddr, void *&desAddr, const uint64_t addrSize);
/* snapshot scene update task */
rtError_t MemcpyAsyncTaskPrepare(TaskInfo * const updateTask, void ** const hostAddr);
rtError_t UpdateTaskD2HSubmit(const TaskInfo * const updateTask, void *sqeAddr, Stream * const stm);
rtError_t UpdateTaskH2DSubmit(TaskInfo * const updateTask, Stream * const stm, void* sqeDeviceAddr);
rtError_t UpdateLabelSwitchTask(TaskInfo * const updateTask);

void ReleaseCpyTmpMem(TaskInfo * const taskInfo);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_MEMORY_TASK_H
