/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sq_exec_times_addr_task.h"
#include "task_info_base.hpp"

namespace cce {
namespace runtime {

#if F_DESC("SqExecTimesAddrTask")
rtError_t SqExecTimesAddrTaskInit(TaskInfo* taskInfo, const uint64_t sqExecTimesAddr, const bool freeFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "SEND_SQ_EXECUTE_TIMES_ADDR";
    taskInfo->type = TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR;

    SqExecTimesAddrTaskInfo* sqExecTimesAddrTaskInfo = &(taskInfo->u.sqExecTimesAddrTask);
    sqExecTimesAddrTaskInfo->execTimesAddr = sqExecTimesAddr;
    sqExecTimesAddrTaskInfo->freeFlag = freeFlag;

    RT_LOG(RT_LOG_DEBUG, "Success to create sq execute times addr task, freeFlag=%d", freeFlag);
    return RT_ERROR_NONE;
}
#endif
} // namespace runtime
} // namespace cce