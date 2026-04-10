/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "stars.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {

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

}  // namespace runtime
}  // namespace cce
