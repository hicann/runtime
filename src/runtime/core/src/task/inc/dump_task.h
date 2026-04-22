/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_DUMP_TASK_H
#define RUNTIME_DUMP_TASK_H

#include "task_info.hpp"

namespace cce {
namespace runtime {
rtError_t FusionDumpAddrSetTaskInit(TaskInfo* taskInfo, const uint16_t modelIndex, const void *const address,
    const uint32_t dumpDataSize, const uint32_t fusionFlag);
rtError_t DataDumpLoadInfoTaskInit(TaskInfo* taskInfo, const void *const dumpInfoPtr,
    const uint32_t len, const uint16_t kernelType);
rtError_t DebugRegisterTaskInit(TaskInfo* taskInfo, const uint32_t mdlId,
    const void *const address, const uint32_t curFlag);
rtError_t DebugUnRegisterTaskInit(TaskInfo* taskInfo, const uint32_t mdlId);
rtError_t DebugRegisterForStreamTaskInit(TaskInfo* taskInfo, const uint32_t stmId,
    const void *const address, const uint32_t curFlag);
rtError_t DebugUnRegisterForStreamTaskInit(TaskInfo* taskInfo, const uint32_t stmId);

void ToCommandBodyForFusionDumpAddrSetTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDataDumpLoadInfoTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDebugRegisterTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDebugUnRegisterTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCommandBodyForDebugRegisterForStreamTask(TaskInfo* taskInfo, rtCommand_t *const command);
void ToCmdBodyForDebugUnRegisterForStreamTask(TaskInfo* taskInfo, rtCommand_t *const command);

void SetStarsResultForDataDumpLoadInfoTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);

rtError_t AicpuInfoLoadTaskInit(TaskInfo* taskInfo, const void *const aicpuInfo, const uint32_t len);
void ToCommandBodyForAicpuInfoLoadTask(TaskInfo* taskInfo, rtCommand_t *const command);
void SetStarsResultForAicpuInfoLoadTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);

rtError_t NopTaskInit(TaskInfo* taskInfo);
void ToCommandForNopTask(TaskInfo *const taskInfo, rtCommand_t *const command);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_DUMP_TASK_H
