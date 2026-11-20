/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_MAINTENANCE_TASK_H
#define RUNTIME_MAINTENANCE_TASK_H

#include <cstdint>
#include "driver.hpp"
#include "runtime/rt_external_device.h"
#include "task_base.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
rtError_t MaintenanceTaskInit(
    TaskInfo* const taskInfo, const MtType type, const uint32_t id, bool flag, const uint32_t idType = UINT32_MAX);
void ToCommandBodyForMaintenanceTask(TaskInfo* const taskInfo, rtCommand_t* const command);

rtError_t GetDevMsgTaskInit(
    TaskInfo* taskInfo, const void* const devMemAddr, const uint32_t devMemSize, const rtGetDevMsgType_t messageType);
void ToCommandBodyForGetDevMsgTask(TaskInfo* taskInfo, rtCommand_t* const command);

rtError_t StarsVersionTaskInit(TaskInfo* const taskInfo);

rtError_t NpuGetFloatStaTaskInit(
    TaskInfo* taskInfo, void* const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
    bool debugFlag = false);
rtError_t NpuClrFloatStaTaskInit(TaskInfo* taskInfo, const uint32_t checkMode, bool debugFlag = false);
} // namespace runtime
} // namespace cce
#endif // RUNTIME_MAINTENANCE_TASK_H
