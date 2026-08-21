/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_COND_OP_STREAM_TASK_H
#define RUNTIME_COND_OP_STREAM_TASK_H

#include "hwts.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
rtError_t StreamSwitchTaskInitV1(
    TaskInfo* taskInfo, const void* const ptrAddr, const rtCondition_t condi, const int64_t valueNum,
    const Stream* const trueStream);
rtError_t StreamSwitchTaskInitV2(
    TaskInfo* taskInfo, const void* const ptrAddr, const rtCondition_t condi, const Stream* const trueStream,
    const void* const valPtr, const rtSwitchDataType_t taskDataType);
rtError_t StreamSwitchNTaskInit(
    TaskInfo* taskInfo, const void* const ptrAddr, const uint32_t ptrSize, const void* const valPtr,
    const void* const trueStream, const uint32_t eleSize, const rtSwitchDataType_t taskDataType);
rtError_t StreamLabelSwitchByIndexTaskInit(
    TaskInfo* taskInfo, void* const idPtr, const uint32_t maxIndex, void* const labelPtr);
rtError_t StreamLabelGotoTaskInit(TaskInfo* taskInfo, const uint16_t lblId);

void ToCmdBodyForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtCommand_t* const command);
void ToCmdBodyForStreamLabelGotoTask(TaskInfo* taskInfo, rtCommand_t* const command);
void ToCommandBodyForStreamSwitchTask(TaskInfo* taskInfo, rtCommand_t* const command);
void ToCommandBodyForStreamSwitchNTask(TaskInfo* taskInfo, rtCommand_t* const command);

void StreamSwitchTaskUnInit(TaskInfo* const taskInfo);
void StreamLabelSwitchByIndexTaskUnInit(TaskInfo* const taskInfo);

void PrintErrorInfoForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForStreamSwitchTask(TaskInfo* taskInfo, const uint32_t devId);
rtError_t InitFuncCallParaForStreamSwitchTaskV1(
    TaskInfo* taskInfo, rtStarsStreamSwitchFcPara_t& fcPara, const rtChipType_t chipType);
rtError_t InitFuncCallParaForStreamSwitchTaskV2(
    TaskInfo* taskInfo, rtStarsStreamSwitchExFcPara_t& fcPara, const rtChipType_t chipType);
rtError_t AllocFuncCallMemForStreamSwitchTask(TaskInfo* taskInfo);
rtError_t FreeFuncCallMemForStreamSwitchTask(TaskInfo* taskInfo);

} // namespace runtime
} // namespace cce
#endif // RUNTIME_COND_OP_STREAM_TASK_H
