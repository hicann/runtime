/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "model.hpp"
#include "error_code.h"
#include "error_message_manage.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {

void ModelExecuteTaskProcErrorForSoftwareSq(TaskInfo* const taskInfo, const uint32_t errCode)
{
    UNUSED(taskInfo);
    UNUSED(errCode);
    return;
}

void ReportErrorInfoForModelTask(TaskInfo* const faultTaskPtr)
{
    UNUSED(faultTaskPtr);
    return;
}

void ProcErrorInfoForModelTask(const rtCqReport_t& logicCq, const bool isExceptionFlag, TaskInfo* reportTask)
{
    UNUSED(logicCq);
    UNUSED(isExceptionFlag);
    UNUSED(reportTask);
    return;
}

} // namespace runtime
} // namespace cce