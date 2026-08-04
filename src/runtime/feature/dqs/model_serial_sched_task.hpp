/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_MODEL_SERIAL_SCHED_TASK_HPP__
#define __CCE_RUNTIME_MODEL_SERIAL_SCHED_TASK_HPP__

#include "task_info.hpp"
#include "task_dqs.hpp"
#include "stars_david.hpp"

namespace cce {
namespace runtime {

struct ModelSerialSchedTaskParam {
    Stream* stream;
    Notify* notify;
    Model* model;
};

// Sqe Construct
void ConstructSqeForModelSerialSchedPreProcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForModelSerialSchedNotifyWaitTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructSqeForModelSerialSchedPostProcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);

// Error print
void PrintErrorInfoForModelSerialSchedPreProcTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForModelSerialSchedNotifyWaitTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForModelSerialSchedPostProcTask(TaskInfo* taskInfo, const uint32_t devId);

void StarsSetResultForModelSerialSchedTask(TaskInfo* taskInfo, const rtLogicCqReport_t& logicCq);
rtError_t LaunchModelSerialSchedTaskByType(
    Stream* const stm, const tsTaskType_t type, ModelSerialSchedTaskParam* param);
} // namespace runtime
} // namespace cce
#endif // __CCE_RUNTIME_MODEL_SERIAL_SCHED_TASK_HPP__