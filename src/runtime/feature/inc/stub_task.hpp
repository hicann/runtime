/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_STUB_TASK_HPP
#define RUNTIME_STUB_TASK_HPP
#include "base.hpp"
#include "runtime_intf.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
class Profiler;
class Device;
class Stream;
class Model;
class Notify;

void RecycleThreadDoForStarsV2(Device *deviceInfo);

TaskInfo* GetTaskInfo(const Device * const dev, uint32_t streamId, uint32_t id);

rtError_t TaskReclaimByStream(Stream * const stm, const bool limited, const bool needLog = true);

rtError_t StreamLaunchCpuKernel(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, Stream * const stm, const uint32_t flag);

void ProfStart(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId, const Device * const dev);

void ProfStop(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId, const Device * const dev);

rtError_t SetTimeoutConfigTaskSubmitDavid(Stream * const stm, const rtTaskTimeoutType_t type, const uint32_t timeout);

rtError_t AicpuMdlDestroy(Model * const mdl);

rtError_t ModelSubmitExecuteTask(Model * const mdl, Stream * const streamIn);

rtError_t ModelLoadCompleteByStream(Model * const mdl);

rtError_t MdlBindTaskSubmit(Model * const mdl, Stream * const streamIn,
    const uint32_t flag);

rtError_t MdlUnBindTaskSubmit(Model * const mdl, Stream * const streamIn,
    const bool force);

rtError_t NtyWait(Notify * const inNotify, Stream * const streamIn, const uint32_t timeOut);

rtError_t SyncGetDeviceMsg(Device * const dev, const void * const devMemAddr, const uint32_t devMemSize,
    const rtGetDevMsgType_t getDevMsgType);

rtError_t ProcRingBufferTaskDavid(const Device *const dev, const void * const devMem, const bool delFlag,
    const uint32_t len);

rtError_t TaskReclaimAllStream(const Device * const dev);

rtError_t UpdateTimeoutConfigTaskSubmitDavid(Stream * const stm, const RtTimeoutConfig &timeoutConfig);

}
}
#endif