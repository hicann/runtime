/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "context.hpp"
#include "barrier_task.h"

namespace cce {
namespace runtime {

#if F_DESC("BarrierTask")

rtError_t BarrierTaskInit(TaskInfo *taskInfo, const rtBarrierTaskInfo_t *const barrierTaskInfo, const Stream *const stm,
                          const uint32_t flag)
{
    (void)flag;
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "BARRIER";
    taskInfo->type = TS_TASK_TYPE_BARRIER;

    Model *barrierModel = stm->Model_();
    rtError_t error;
    if (barrierModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Barrier task stream is not in model.");
        return RT_ERROR_MODEL_NULL;
    }

    // sqe info copy
    taskInfo->u.barrierTask.barrierMsg.cmoIdNum = 0U;
    uint16_t tmpCmoId = 0U;
    for (uint8_t i = 0U; i < barrierTaskInfo->logicIdNum; i++) {
        error = barrierModel->GetCmoId(barrierTaskInfo->cmoInfo[i].logicId, tmpCmoId);
        ERROR_RETURN_MSG_INNER(error, "Failed to get Barrier Task cmo id.");
        taskInfo->u.barrierTask.barrierMsg.cmoInfo[i].cmoId = tmpCmoId;
        taskInfo->u.barrierTask.barrierMsg.cmoInfo[i].cmoType = barrierTaskInfo->cmoInfo[i].cmoType;
        taskInfo->u.barrierTask.barrierMsg.cmoIdNum++;
    }

    RT_LOG(RT_LOG_DEBUG, "Barrier Task Info: IdNum=%hhu, logicId(%u,%u,%u,%u,%u,%u), cmotype(%hu,%hu,%hu,%hu,%hu,%hu).",
        barrierTaskInfo->logicIdNum, barrierTaskInfo->cmoInfo[0U].logicId, barrierTaskInfo->cmoInfo[1U].logicId,
        barrierTaskInfo->cmoInfo[2U].logicId, barrierTaskInfo->cmoInfo[3U].logicId, // 2U is index, 3U is index
        barrierTaskInfo->cmoInfo[4U].logicId, barrierTaskInfo->cmoInfo[5U].logicId, // 4U is index, 5U is index
        barrierTaskInfo->cmoInfo[0U].cmoType, barrierTaskInfo->cmoInfo[1U].cmoType,
        barrierTaskInfo->cmoInfo[2U].cmoType, barrierTaskInfo->cmoInfo[3U].cmoType, // 2U is index, 3U is index
        barrierTaskInfo->cmoInfo[4U].cmoType, barrierTaskInfo->cmoInfo[5U].cmoType); // 4U is index, 5U is index
    return RT_ERROR_NONE;
}

void ConstructSqeForBarrierTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    BarrierTaskInfo* barrierTsk = &taskInfo->u.barrierTask;
    RtBarrierKernelSqe *const sqe = &(command->barrierKernelSqe);
    sqe->header.ie = 0U;
    sqe->header.type = RT_STARS_SQE_TYPE_FFTS;
    sqe->header.post_p = 0U;
    sqe->header.pre_p = 0U;
    sqe->header.task_id = taskInfo->id;
    sqe->header.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->header.block_dim = 0U; // block_dim is not used by CMO
    sqe->header.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->fftsType = 0U;
    sqe->cmo = 1U; // enable cmo task
    sqe->res1 = 0U;
    sqe->wrr_ratio = 1U;
    sqe->res2 = 0U;
    sqe->sqe_index = 0U;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->schem = 0U;
    sqe->res3 = 0U;
    sqe->icache_prefetch_cnt = 0U;
    sqe->cmo_type = 0U; // 0U is barrier
    sqe->res4 = 0U;

    uint16_t bitmap = 0U;
    for (uint8_t i = 0U; (i < barrierTsk->barrierMsg.cmoIdNum) && (i < RT_CMO_MAX_BARRIER_NUM); i++) {
        bitmap += 1U << i;
        // 1U is invalid, FE is only use barrier invalid
        sqe->cmo_info[i].cmo_type = barrierTsk->barrierMsg.cmoInfo[i].cmoType;
        sqe->cmo_info[i].cmoId = barrierTsk->barrierMsg.cmoInfo[i].cmoId;
    }

    for (uint8_t i = barrierTsk->barrierMsg.cmoIdNum; i < RT_CMO_MAX_BARRIER_NUM; i++) {
        sqe->cmo_info[i].cmo_type = 0U;
        sqe->cmo_info[i].cmoId = 0U;
    }
    sqe->cmo_bitmap = bitmap;

    for (size_t i = 0UL; i < (sizeof(sqe->res5) / sizeof(sqe->res5[0U])); i++) {
        sqe->res5[i] = 0U;
    }
    PrintSqe(command, "BarrierTask");
    RT_LOG(RT_LOG_INFO, "BarrierTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}

#endif

}  // namespace runtime
}  // namespace cce