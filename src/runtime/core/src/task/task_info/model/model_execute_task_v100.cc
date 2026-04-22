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
#include "context.hpp"
#include "model.hpp"
#include "stars_cond_isa_helper.hpp"
#include "task_info_v100.h"
#include "model_execute_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelExecuteTask")

void SetResultForModelExecuteTask(TaskInfo * const taskInfo, const void * const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    const uint32_t *const tsData = static_cast<const uint32_t *>(data);
    const uint32_t payLoad = *tsData;
    const uint32_t highTaskId = *(tsData + 1U);
    const uint32_t streamIdEx = *(tsData + 2U);
    taskInfo->errorCode = (payLoad & 0xFFFU);
    modelExecuteTaskInfo->errorTaskId = ((payLoad >> 22U) & 0x3FFU) | (highTaskId << 10U);
    modelExecuteTaskInfo->errorStreamId =
        ((payLoad >> 12U) & 0x3FFU) | (streamIdEx << (static_cast<uint32_t>(RT_STREAM_ID_OFFSET)));

    RT_LOG(RT_LOG_DEBUG, "Payload=%u, highTaskId=%u, errorCode=0x%x, errorTaskId=%u, errorStreamId=%u.",
        payLoad, highTaskId, taskInfo->errorCode, modelExecuteTaskInfo->errorTaskId,
        modelExecuteTaskInfo->errorStreamId);
}

void ConstructSqeForModelExecuteTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.sqeHeader.post_p = 1U;
    sqe.conds_sub_type = CONDS_SUB_TYPE_MODEL_EXEC;
    sqe.reserved1 = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);

    const uint64_t funcAddr = modelExecuteTaskInfo->model->GetFuncCallSvmMem();
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsModelExeFuncCall));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "ModelExecuteTask");
    RT_LOG(RT_LOG_INFO, "ModelExecuteTask stream_id=%d task_id=%hu, model_id=%hu.",
        stream->Id_(), taskInfo->id, sqe.reserved1);
}

#endif
}  // namespace runtime
}  // namespace cce
