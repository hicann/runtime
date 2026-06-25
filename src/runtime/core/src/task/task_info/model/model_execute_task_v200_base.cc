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
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelExecuteTask")

static void ConstructDavidSqeForModelExecuteTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ModelExecuteTaskInfo * const modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &fnCallSqe = davidSqe->fuctionCallSqe;
    fnCallSqe.header.type = RT_DAVID_SQE_TYPE_COND;
    fnCallSqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    fnCallSqe.header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    fnCallSqe.sqeLength = 0U;
    fnCallSqe.csc = 1U;

    fnCallSqe.condsSubType = CONDS_SUB_TYPE_MODEL_EXEC;
    fnCallSqe.reserved0 = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);

    const uint64_t funcAddr = modelExecuteTaskInfo->model->GetFuncCallSvmMem();
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsModelExeFuncCall));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), fnCallSqe);

    PrintDavidSqe(davidSqe, "ModelExecuteTask");
    RT_LOG(RT_LOG_INFO, "ModelExecuteTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, model_id=%hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, fnCallSqe.reserved0);
}

#endif

static bool ModelExecuteTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = &ToCommandBodyForModelExecuteTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForModelExecuteTask,
        .taskUnInitFunc = &ModelExecuteTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForModelExecuteTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForModelExecuteTask,
    };

    const auto &chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MODEL_EXECUTE, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MODEL_EXECUTE, &ConstructDavidSqeForModelExecuteTask);
    return true;
}

static bool g_modelExecuteTaskRegister = ModelExecuteTaskRegister();

}  // namespace runtime
}  // namespace cce
