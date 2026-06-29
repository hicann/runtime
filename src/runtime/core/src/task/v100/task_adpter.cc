/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task.hpp"
#include "task_info_v100.h"
#include "memory_task.h"
#include "rdma_task.h"
#include "ffts_task.h"
#include "davinci_multiple_task.h"

namespace cce {
namespace runtime {

uint32_t GetSendSqeNum(TaskInfo * const taskInfo)
{
    const tsTaskType_t type = taskInfo->type;
    if (type == TS_TASK_TYPE_MULTIPLE_TASK) {
        return GetSendSqeNumForDavinciMultipleTask(taskInfo);
    } else if (type == TS_TASK_TYPE_RDMA_DB_SEND) {
        return GetSendSqeNumForRdmaDbSendTask(taskInfo);
    } else if (type == TS_TASK_TYPE_FFTS_PLUS) {
        return GetSendSqeNumForFftsPlusTask(taskInfo);
    } else if ((type == TS_TASK_TYPE_MEM_WAIT_VALUE) || (type == TS_TASK_TYPE_CAPTURE_WAIT) ||
        (type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL) || (type == TS_TASK_TYPE_IPC_WAIT)) {
        return GetSendSqeNumForMemWaitTask(taskInfo);
    } else if (type == TS_TASK_TYPE_CAPTURE_CONDITION) {
        return taskInfo->sqeNum; // 使用sqeNum必须在对应taskini中初始化
    } else {
        return 1U;
    }
}

}  // namespace runtime
}  // namespace cce