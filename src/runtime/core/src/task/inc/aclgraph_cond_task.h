/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ACLGRAPH_COND_TASK_H
#define ACLGRAPH_COND_TASK_H

#include "driver.hpp"
#include "stars.hpp"
#include "cond_handle/cond_handle.hpp"

namespace cce {
namespace runtime {

constexpr uint8_t COND_TASK_IF_SWITCH_TASK_NUM = 2U;
constexpr uint8_t COND_TASK_WHILE_TASK_NUM = 3U;
constexpr uint8_t COND_TASK_RESV_LEN_FOR_COND_EXECUTE = 32U; // 预留32字节长度，用于存放headSqArrAddr、headSqArrMax、streamSvmArrAddr
constexpr uint8_t COND_TASK_IF_SWITCH_SQE_NUM = 2U;
constexpr uint8_t COND_TASK_WHILE_SQE_NUM = 3U;

rtError_t CaptureConditionTaskInit(TaskInfo *taskInfo, CondHandle *condHandle);
void CaptureConditionTaskUnInit(TaskInfo * const taskInfo);
void ConstructSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *const command);
void Construct1stSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe);
void Construct2ndSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe);
void Construct3rdSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe);
void ConstructCaptureConditionJumpBackFc(TaskInfo * const taskInfo, RtStarsCaptureWhileCondJumpBackFc &fc);
rtError_t ReConstructCaptureConditionTaskFc(TaskInfo *taskInfo, CondHandle *condHandle);
rtError_t PostProcCaptureConditionTask(CondHandle *condHandle, Stream * const stm, const uint16_t taskId);
rtError_t CheckCondTaskParamsSize(rtCondTaskParams params);

}  // namespace runtime
}  // namespace cce
#endif  // ACLGRAPH_COND_TASK_H
