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
#include "stars_david.hpp"
#include "stars_cond_isa_helper.hpp"
#include "model_execute_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelExecuteTask")

void ConstructDavidSqeForModelExecuteTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ModelExecuteTaskInfo * const modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    sqe.condsSubType = CONDS_SUB_TYPE_MODEL_EXEC;
    sqe.reserved0 = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);

    const uint64_t funcAddr = modelExecuteTaskInfo->model->GetFuncCallSvmMem();
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsModelExeFuncCall));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "ModelExecuteTask");
    RT_LOG(RT_LOG_INFO, "ModelExecuteTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, model_id=%hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, sqe.reserved0);
}

#endif
}  // namespace runtime
}  // namespace cce
