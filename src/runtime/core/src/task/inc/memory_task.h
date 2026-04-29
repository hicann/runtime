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
#include "rt_inner_task.h"
namespace cce {
namespace runtime {

constexpr uint32_t MEM_WAIT_WRITE_VALUE_ADDRESS_LEN = 64U;

rtError_t MemcpyAsyncTaskCommonInit(TaskInfo * const taskInfo);
rtError_t ConvertAsyncDma(TaskInfo * const taskInfo, TaskInfo * const updateTaskInfo, bool isSqeUpdate = false);
rtError_t ConvertAsyncDma2D(TaskInfo * const taskInfo2D, void *const dst, const uint64_t dstPitch,
    const void *const src, const uint64_t srcPitch, const uint64_t width, const uint64_t height,
    const uint64_t fixedSize);
rtError_t ConvertAsyncDmaBatch(TaskInfo * const taskInfo, void** const dsts,
    void** const srcs, const uint64_t* const sizes, const uint64_t count, const uint64_t fixedSize);
void ToCommandBodyForMemcpyAsyncTask(TaskInfo * const taskInfo, rtCommand_t *const command);
void SetStarsResultForMemcpyAsyncTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq);
void PrintErrorInfoForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId);
bool GetModuleIdByMemcpyAddr(Driver * const driver, void *memcpyAddr, uint32_t *moduleId);
void PrintModuleIdProc(Driver * const driver, char_t * const errStr, void *src, void *dst, int32_t *count);
void ReleaseCpyTmpMemFor3588(TaskInfo * const taskInfo);
rtError_t AllocCpyTmpMemFor3588(TaskInfo * const taskInfo, uint32_t &cpyType,
                                const void *&src, void *&des, uint64_t size);
rtError_t MixKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize);
rtError_t SqeUpdateH2DTaskInit(TaskInfo * const taskInfo, void *srcAddr, void *dstAddr, const uint64_t cpySize,
                               void *releaseArgHandle, void *updateArgHandle);
rtError_t NormalKernelUpdatePrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize);
/* D2H copy, src = sqeBaseAddr + sqeOffset, dst info = sqId + pos + sqeOffset, convert dst addr by ts-agent */
rtError_t UpdateD2HTaskInit(TaskInfo * const taskInfo, const void *sqeBaseAddr, const uint64_t cpySize,
                                        const uint32_t sqId, const uint32_t pos, const uint8_t sqeOffset);
/* snapshot scene update task */
rtError_t MemcpyAsyncTaskPrepare(TaskInfo * const updateTask, void ** const hostAddr);
rtError_t UpdateTaskD2HSubmit(const TaskInfo * const updateTask, void *sqeAddr, Stream * const stm);
rtError_t UpdateTaskH2DSubmit(TaskInfo * const updateTask, Stream * const stm, void* sqeDeviceAddr);

rtError_t MemWriteValueTaskInit(TaskInfo *taskInfo, const void * const devAddr, const uint64_t value);
rtError_t GetWriteValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t UpdateWriteValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params);

rtError_t MemWaitValueTaskInit(TaskInfo *taskInfo, const void * const devAddr,
                               const uint64_t value, const uint32_t flag);
void MemWaitTaskUnInit(TaskInfo *taskInfo);
uint32_t GetSendSqeNumForMemWaitTask(const TaskInfo * const taskInfo);
rtError_t GetWaitValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t UpdateWaitValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params);

// common
rtError_t GetCaptureRecordTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t GetCaptureWaitTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t GetCaptureResetTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
void IpcEventDestroy(IpcEvent **eventPtr, int32_t freeId, bool isNeedDestroy);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_MEMORY_TASK_H