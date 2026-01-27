/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_DAVID_HPP__
#define __CCE_RUNTIME_TASK_DAVID_HPP__

#include "task_info.hpp"

namespace cce {
namespace runtime {
    rtError_t SubmitTaskDavid(TaskInfo *submitTask, Stream * const stm, int32_t timeout = -1);
    // Invoke the flow lock at the layer.
    rtError_t AllocTaskInfoForCapture(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, Stream *&dstStm, uint32_t sqeNum = 1U, bool isKernelLaunch = false);
    rtError_t AllocTaskInfo(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, uint32_t sqeNum = 1U);
    rtError_t DavidSendTask(TaskInfo *taskInfo, Stream * const stm);
    void SaveTaskCommonInfo(TaskInfo *taskInfo, Stream * const stm, uint32_t pos, uint32_t sqeNum = 1U);
    void TaskRollBack(Stream * const stm, uint32_t pos);
    rtError_t ProcAicpuTask(TaskInfo *submitTask);
    rtError_t SubmitTaskPostProc(Stream * const stm, uint32_t pos, bool isNeedStreamSync = false,  int32_t timeout = -1);
    rtError_t CheckTaskCanSend(Stream * const stm);
}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_TASK_DAVID_HPP__
