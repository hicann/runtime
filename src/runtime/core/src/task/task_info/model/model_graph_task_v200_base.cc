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
#include "model_graph_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("AddEndGraphTask")

static void ConstructDavidSqeForAddEndGraphTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuKernelSqe * const aicpuKernelSqe = &(davidSqe->aicpuSqe);
    Stream * const stm = taskInfo->stream;

    aicpuKernelSqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    aicpuKernelSqe->header.blockDim = 1U;
    aicpuKernelSqe->kernelType = (static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU));
    aicpuKernelSqe->batchMode = 0U;
    aicpuKernelSqe->topicType = 0U;
    UpdateDavidAICpuKernelSqeForDavinciTask(aicpuKernelSqe);

    aicpuKernelSqe->qos = stm->Device_()->GetTsdQos();
    aicpuKernelSqe->res2 = 0U;
    aicpuKernelSqe->sqeIndex = 0U; // useless
    aicpuKernelSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    aicpuKernelSqe->sqeLength = 0U;

    // soname aicpu no need
    aicpuKernelSqe->taskSoAddrLow = 0U;
    aicpuKernelSqe->taskSoAddrHigh = 0U;

    aicpuKernelSqe->paramAddrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.argptr);
    aicpuKernelSqe->paramAddrHigh = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.argptr >> UINT32_BIT_NUM);

    aicpuKernelSqe->taskNameStrPtrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr);
    aicpuKernelSqe->taskNameStrPtrHigh = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr >> UINT32_BIT_NUM);
    aicpuKernelSqe->pL2ctrlLow = 0U;
    aicpuKernelSqe->pL2ctrlHigh = 0U;
    aicpuKernelSqe->overflowEn = 0U;
    aicpuKernelSqe->extraFieldLow = taskInfo->taskSn; // send task id info to aicpu
    aicpuKernelSqe->extraFieldHigh = 0U;

    aicpuKernelSqe->subTopicId = 0U;
    aicpuKernelSqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    aicpuKernelSqe->groupId = 0U;
    aicpuKernelSqe->usrDataLen = 40U; // size: word4-13
    aicpuKernelSqe->destPid = 0U;

    aicpuKernelSqe->res5 = 0xFFFFU;

    PrintDavidSqe(davidSqe, "AddEndGraphTask");
    RT_LOG(RT_LOG_INFO, "AddEndGraphTask, topicType=%u, device_id=%u, stream_id=%d,"
        "task_id=%hu, task_sn=%u.", static_cast<uint32_t>(aicpuKernelSqe->topicType), taskInfo->stream->Device_()->Id_(),
        stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

#endif

static bool ModelGraphTaskRegister()
{
    TaskFuncSingle endGraphFuncs = {
        .toCommandFunc = &ToCmdBodyForAddEndGraphTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle exitGraphFuncs = {
        .toCommandFunc = &ToCmdBodyForAddModelExitTask,
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
        RegTaskFunc(chip, TS_TASK_TYPE_MODEL_END_GRAPH, endGraphFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MODEL_EXIT_GRAPH, exitGraphFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MODEL_END_GRAPH, &ConstructDavidSqeForAddEndGraphTask);
    RegDavidSqeFunc(TS_TASK_TYPE_MODEL_EXIT_GRAPH, &ConstructDavidSqeBase);
    return true;
}

static bool g_modelGraphTaskRegister = ModelGraphTaskRegister();

}  // namespace runtime
}  // namespace cce
