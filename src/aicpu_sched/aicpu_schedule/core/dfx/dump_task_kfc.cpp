/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_task.h"
#include "aicpusd_status.h"

int32_t AicpuGetOpTaskInfo(const KfcDumpTask &taskKey, KfcDumpInfo **ptr)
{
    if (ptr == nullptr) {
        aicpusd_err("Get op task info ptr is null! streamId[%u], taskId[%u], index[%u].",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
    int32_t ret = opDumpTaskMgr.GetDumpOpTaskDataforKfc(taskKey, ptr);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        aicpusd_err("Get op task info failed! streamId[%u], taskId[%u], index[%u] ret[%d].",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_, ret);
        return ret;
    }
    aicpusd_info("Get op task info success, streamId[%u], taskId[%u], index[%u] ret[%d].",
                  taskKey.streamId_, taskKey.taskId_, taskKey.index_, ret);
    return ret;
}

int32_t AicpuDumpOpTaskData(const KfcDumpTask &taskKey, void *dumpPtr, uint32_t length)
{
    if (dumpPtr == nullptr) {
        aicpusd_err("Result ptr of op task info is null! streamId[%u], taskId[%u], index[%u].",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    if (length == 0U) {
        aicpusd_warn("Result len of op task info is zero! streamId[%u], taskId[%u], index[%u].",
                      taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AicpuSchedule::AICPU_SCHEDULE_OK;
    }
    AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
    int32_t ret = opDumpTaskMgr.DumpOpTaskDataforKfc(taskKey, dumpPtr, length);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        aicpusd_err("Dump op task data failed! streamId[%u], taskId[%u], index[%u], ret[%d].",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_, ret);
        return ret;
    }
    aicpusd_info("Dump op task data success, streamId[%u], taskId[%u], index[%u] length[%u].",
                  taskKey.streamId_, taskKey.taskId_, taskKey.index_, length);
    return ret;
}
