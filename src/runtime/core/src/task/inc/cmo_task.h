/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_CMO_TASK_H
#define RUNTIME_CMO_TASK_H

#include "stars.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {
rtError_t CmoTaskInit(TaskInfo *taskInfo, const rtCmoTaskInfo_t *const cmoTaskInfo, const Stream * const stm,
                      const uint32_t flag);
rtError_t CmoAddrTaskInit(TaskInfo *taskInfo, void *cmoAddrInfo, const rtCmoOpCode_t cmoOpCode);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_CMO_TASK_H
