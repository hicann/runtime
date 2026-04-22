/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_MODEL_GRAPH_TASK_H
#define RUNTIME_MODEL_GRAPH_TASK_H

#include "task_info.hpp"

namespace cce {
namespace runtime {

rtError_t AddEndGraphTaskInit(TaskInfo* taskInfo, const uint32_t modelId, const uint32_t exeFlag,
                              const uint64_t argParam, const uint64_t endGraphName,
                              const uint8_t flags);
void ToCmdBodyForAddEndGraphTask(TaskInfo* taskInfo, rtCommand_t *const command);

rtError_t AddModelExitTaskInit(TaskInfo* taskInfo, const uint32_t modelId);
void ToCmdBodyForAddModelExitTask(TaskInfo* taskInfo, rtCommand_t *const command);

}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_MODEL_GRAPH_TASK_H
