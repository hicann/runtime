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
#include "task_info_v100.h"
#include "model_update_task.h"

namespace cce {
namespace runtime {

void ConstructSqeForModelUpdateTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    Stream * const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.mdTaskUpdateInfo.descBufOffset = mdlUpdateTaskInfo->descBufOffset;
    sqe->u.mdTaskUpdateInfo.blockDimOffset = mdlUpdateTaskInfo->blockDimOffset;
    sqe->u.mdTaskUpdateInfo.tilingTabLen = mdlUpdateTaskInfo->tilingTabLen;
    sqe->u.mdTaskUpdateInfo.tilingKeyOffset = mdlUpdateTaskInfo->tilingKeyOffset;
    sqe->u.mdTaskUpdateInfo.tilingTabOffset = mdlUpdateTaskInfo->tilingTabOffset;
    sqe->u.mdTaskUpdateInfo.destaskId = mdlUpdateTaskInfo->destaskId;
    sqe->u.mdTaskUpdateInfo.desStreamId = mdlUpdateTaskInfo->desStreamId;
    sqe->u.mdTaskUpdateInfo.exeStreamId = mdlUpdateTaskInfo->exeStreamId;

    RT_LOG(RT_LOG_INFO, "[Offset]descBuf=%llu,tilingKey=%llu,blockDim=%llu,tilingTab=%llu.",
        mdlUpdateTaskInfo->descBufOffset, mdlUpdateTaskInfo->tilingKeyOffset,
        mdlUpdateTaskInfo->blockDimOffset, mdlUpdateTaskInfo->tilingTabOffset);

    PrintSqe(command, "ModelUpdateTask");
    RT_LOG(RT_LOG_INFO, "Send TS_TASK_TYPE_MODEL_TASK_UPDATE succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type);

    return;
}

}  // namespace runtime
}  // namespace cce
