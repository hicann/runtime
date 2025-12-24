/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_SUBMIT_HPP__
#define __CCE_RUNTIME_TASK_SUBMIT_HPP__

#include "base.hpp"
#include "osal.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
rtError_t AllocTaskAndSendDc(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId);
rtError_t AllocTaskAndSendStars(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId);
rtError_t SubmitTaskDc(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId, int32_t timeout);
rtError_t SubmitTaskStars(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId, int32_t timeout);
rtError_t AllocTaskAndSend(TaskInfo *submitTask, Stream *stm, uint32_t * const flipTaskId, int32_t timeout);
rtError_t AllocAndSendFlipTask(uint16_t preTaskId, Stream *stm);
rtError_t LoadArgsInfo(TaskInfo *submitTask, Stream *stm, uint16_t taskResId);
rtError_t LoadArgsInfoForAicoreKernelTask(TaskInfo *submitTask, Stream *stm, uint16_t taskResId);

}
}
#endif  // __CCE_RUNTIME_TASK_SUBMIT_HPP__