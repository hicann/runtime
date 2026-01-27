/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "stars_david.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
void ConstructDavidSqeForAicpuInfoLoadTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;

    sqe->taskType = TS_TASK_TYPE_AICPU_INFO_LOAD;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.aiCpuLoadInfo.aicpufoPtr = taskInfo->u.aicpuInfoLoadTask.aicpuInfo;
    sqe->u.aiCpuLoadInfo.length = taskInfo->u.aicpuInfoLoadTask.length;
    sqe->u.aiCpuLoadInfo.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->u.aiCpuLoadInfo.taskId = taskInfo->id;
    sqe->u.aiCpuLoadInfo.reserved[0] = 0U;
    sqe->u.aiCpuLoadInfo.reserved[1] = 0U;

    PrintDavidSqe(davidSqe, "AicpuInfoLoadTask");
    RT_LOG(RT_LOG_INFO, "AicpuInfoLoadTask stream_id:%d task_id:%hu", stm->Id_(), taskInfo->id);
}

void ConstructDavidSqeForNopTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidPlaceHolderSqe *const sqe = &(command->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_NOP;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    PrintDavidSqe(command, "NoOperationTask");
}

void ConstructDavidSqeForModelUpdateTask(TaskInfo * const taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidPlaceHolderSqe * const sqe = &(command->phSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.mdlTaskUpdateInfo.tilingKeyOffset = mdlUpdateTaskInfo->tilingKeyOffset;
    sqe->u.mdlTaskUpdateInfo.blockDimOffset = mdlUpdateTaskInfo->blockDimOffset;
    sqe->u.mdlTaskUpdateInfo.tilingTabOffset = mdlUpdateTaskInfo->tilingTabOffset;
    sqe->u.mdlTaskUpdateInfo.tilingTabLen = mdlUpdateTaskInfo->tilingTabLen;
    sqe->u.mdlTaskUpdateInfo.desStreamId = mdlUpdateTaskInfo->desStreamId;
    sqe->u.mdlTaskUpdateInfo.destaskId = mdlUpdateTaskInfo->destaskId;
    sqe->u.mdlTaskUpdateInfo.exeStreamId = mdlUpdateTaskInfo->exeStreamId;

    RT_LOG(RT_LOG_INFO, "[tilingKey=%llu,blockDim=%llu,tilingTab=%llu,tilingTabLen=%u.",
        mdlUpdateTaskInfo->tilingKeyOffset,
        mdlUpdateTaskInfo->blockDimOffset,
        mdlUpdateTaskInfo->tilingTabOffset, mdlUpdateTaskInfo->tilingTabLen);

    PrintDavidSqe(command, "ModelUpdateTask");
    RT_LOG(RT_LOG_INFO, "Send TS_TASK_TYPE_MODEL_TASK_UPDATE succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_sn=%u, task_type=%u",
        sqe->header.type, sqe->header.preP, stm->Id_(), taskInfo->id, taskInfo->taskSn, sqe->taskType);
}
}  // namespace runtime
}  // namespace cce