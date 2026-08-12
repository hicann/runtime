/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_PROFILING_TASK_H
#define RUNTIME_PROFILING_TASK_H

#include "task_info.hpp"

namespace cce {
namespace runtime {

rtError_t DynamicProfilingEnableTaskInit(
    TaskInfo* const taskInfo, const uint64_t processId, const rtProfCfg_t* const profCfg);
rtError_t DynamicProfilingDisableTaskInit(
    TaskInfo* const taskInfo, const uint64_t processId, const rtProfCfg_t* const profCfg);
rtError_t ProfilingEnableTaskInit(TaskInfo* const taskInfo, const uint64_t processId, const rtProfCfg_t* const profCfg);
rtError_t ProfilingDisableTaskInit(
    TaskInfo* const taskInfo, const uint64_t processId, const rtProfCfg_t* const profCfg);
rtError_t OnlineProfEnableTaskInit(TaskInfo* const taskInfo, const uint64_t onlineProfilingAddr);
rtError_t OnlineProfDisableTaskInit(TaskInfo* const taskInfo, const uint64_t onlineProfilingAddr);
rtError_t AdcProfTaskInit(TaskInfo* const taskInfo, const uint64_t address, const uint32_t len);
rtError_t ProfilerTraceTaskInit(TaskInfo* taskInfo, const uint64_t id, const bool notifyFlag, const uint32_t flags);
rtError_t ProfilerTraceExTaskInit(TaskInfo* taskInfo, const uint64_t id, const uint64_t mdlId, const uint16_t tag);
} // namespace runtime
} // namespace cce
#endif // RUNTIME_PROFILING_TASK_H
