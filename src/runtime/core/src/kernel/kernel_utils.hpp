/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_KERNEL_UTILS_HPP__
#define __CCE_RUNTIME_KERNEL_UTILS_HPP__
#include <string>
#include "runtime.hpp"
#include "rt_inner_task.h"
#include "kernel.h"
#include "stars_arg_manager.hpp"

namespace cce {
namespace runtime {
struct rtStreamLaunchKernelV2ExtendArgs_t;
void ComputeRatio(uint16_t ratio[2], uint32_t mixType, uint32_t taskRatio);
rtError_t GetLaunchBlockDim(const uint32_t blockDim, uint16_t& launchBlockDim);
rtError_t ConvertTaskType(const TaskInfo* const task, rtTaskType* type);
rtError_t GetKernelTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t GetSimtKernelTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params);
rtError_t CacheKernelTaskParams(TaskInfo* const taskInfo, const rtTaskParams* const params, Kernel* const kernel);
rtError_t CacheSimtKernelTaskParams(TaskInfo* const taskInfo, const rtTaskParams* const params, Kernel* const kernel);
// release the heap-owned buffers of a cached update info by its argsType form; the DEVICE_BUFFER
// device pointer is user-owned and never freed here
template <typename KernelUpdateInfoT>
void FreeKernelUpdateInfoBuffers(KernelUpdateInfoT& kernelUpdateInfo);
rtError_t UpdateKernelParams(TaskInfo* const taskInfo, KernelTaskUpdateInfo* const kernelUpdateInfo);
rtError_t GetKernelAttribute(
    const TaskInfo* const taskInfo, rtLaunchKernelAttrId attrId, rtLaunchKernelAttrVal_t* attrValue);
rtError_t GetOpExecuteMsTimeout(uint32_t* const timeout, uint64_t* customTimeout = nullptr);
rtError_t SetKernelLaunchParams(
    const Stream* const stm, const rtArgsEx_t* const argsInfo, TaskInfo& task,
    const rtStreamLaunchKernelV2ExtendArgs_t* extendArgs = nullptr);
rtError_t CopyKernelParamsToBuffer(const Kernel* kernel, void** argsArray, void* dest, void** outArgsArray = nullptr);
// aclGraph 模型更新专用：按与 launch 相同的方式把缓存参数加载到 device。argsType 选择形态；
// argsArray 仅 ARRAY 非空（只读）；ARRAY 形态下 argsInfo 只携带 argsSize 与 isNoNeedH2DCopy。
rtError_t LoadKernelArgs(
    Stream* stm, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& result, const Kernel* kernel,
    rtKernelArgsType argsType, void** argsArray);
rtError_t PostUpdateKernelParams(TaskInfo* taskInfo);
void SetAicoreArgsSuperKernel(TaskInfo* taskInfo, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& result);
void BackupTaskArgHandle(TaskInfo* taskInfo);
rtError_t CheckDynSizeValid(TaskInfo* const taskInfo, const Kernel* const kernel);
} // namespace runtime
} // namespace cce
#endif // __CCE_RUNTIME_KERNEL_UTILS_HPP__
