/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "model_update_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelTaskUpdate")

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

#endif

}  // namespace runtime
}  // namespace cce
