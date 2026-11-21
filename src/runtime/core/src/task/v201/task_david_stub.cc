/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info.hpp"
#include "stream.hpp"
#include "stars_david.hpp"
#include "sq_exec_times_addr_task.h"

namespace cce {
namespace runtime {

void ConstructDavidAsyncUbDbSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
}

rtError_t SendTaskToSetSqExecTimesAddr(Device* const dev)
{
    UNUSED(dev);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SendTaskToUnsetSqExecTimesAddr(Device* const dev)
{
    UNUSED(dev);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
