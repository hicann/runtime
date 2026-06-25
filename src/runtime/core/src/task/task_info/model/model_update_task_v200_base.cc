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
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelTaskUpdate")

static void ConstructDavidSqeForModelUpdateTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    Stream * const stm = taskInfo->stream;
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.mdlTaskUpdateInfo.tilingKeyOffset = mdlUpdateTaskInfo->tilingKeyOffset;
    phSqe->u.mdlTaskUpdateInfo.blockDimOffset = mdlUpdateTaskInfo->blockDimOffset;
    phSqe->u.mdlTaskUpdateInfo.tilingTabOffset = mdlUpdateTaskInfo->tilingTabOffset;
    phSqe->u.mdlTaskUpdateInfo.tilingTabLen = mdlUpdateTaskInfo->tilingTabLen;
    phSqe->u.mdlTaskUpdateInfo.desStreamId = mdlUpdateTaskInfo->desStreamId;
    phSqe->u.mdlTaskUpdateInfo.destaskId = mdlUpdateTaskInfo->destaskId;
    phSqe->u.mdlTaskUpdateInfo.exeStreamId = mdlUpdateTaskInfo->exeStreamId;

    RT_LOG(RT_LOG_INFO, "[tilingKey=%llu,blockDim=%llu,tilingTab=%llu,tilingTabLen=%u.",
        mdlUpdateTaskInfo->tilingKeyOffset,
        mdlUpdateTaskInfo->blockDimOffset,
        mdlUpdateTaskInfo->tilingTabOffset, mdlUpdateTaskInfo->tilingTabLen);

    PrintDavidSqe(davidSqe, "ModelUpdateTask");
    RT_LOG(RT_LOG_INFO, "Send TS_TASK_TYPE_MODEL_TASK_UPDATE succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_sn=%u, task_type=%u",
        phSqe->header.type, phSqe->header.preP, stm->Id_(), taskInfo->id, taskInfo->taskSn, phSqe->taskType);
}

#endif

static bool ModelUpdateTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = &ToCommandBodyForModelUpdateTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto &chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MODEL_TASK_UPDATE, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MODEL_TASK_UPDATE, &ConstructDavidSqeForModelUpdateTask);
    return true;
}

static bool g_modelUpdateTaskRegister = ModelUpdateTaskRegister();

}  // namespace runtime
}  // namespace cce
