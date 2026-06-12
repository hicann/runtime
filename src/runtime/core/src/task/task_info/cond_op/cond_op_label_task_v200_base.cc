/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "kernel.hpp"
#include "model.hpp"
#include "cond_op_label_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

void ConstructDavidSqeForLabelSetTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_LABEL_SET;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    Model *mdl = stm->Model_();
    if (mdl != nullptr) {
        mdl->LabelCountInc();
    }
    PrintDavidSqe(davidSqe, "LabelSet");
    RT_LOG(RT_LOG_INFO, "LabelSetTask, deviceId=%u, streamId=%d taskId=%hu", stm->Device_()->Id_(), stm->Id_(),
        taskInfo->id);
}

static bool CondOpLabelTaskRegister()
{
    TaskFuncSingle labelSetFuncs = {
        .toCommandFunc = &ToCommandBodyForLabelSetTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle labelSwitchFuncs = {
        .toCommandFunc = &ToCommandBodyForLabelSwitchTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle labelGotoFuncs = {
        .toCommandFunc = &ToCommandBodyForLabelGotoTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_LABEL_SET, labelSetFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_LABEL_SWITCH, labelSwitchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_LABEL_GOTO, labelGotoFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_LABEL_SET, &ConstructDavidSqeForLabelSetTask);
    RegDavidSqeFunc(TS_TASK_TYPE_LABEL_SWITCH, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_LABEL_GOTO, &ConstructDavidSqeBase);
    return true;
}

static bool g_condOpLabelTaskRegister = CondOpLabelTaskRegister();

}  // namespace runtime
}  // namespace cce
