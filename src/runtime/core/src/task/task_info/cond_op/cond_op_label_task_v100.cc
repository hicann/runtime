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
#include "kernel.hpp"
#include "model.hpp"
#include "task_info_v100.h"
#include "cond_op_label_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("LabelSetTask")
void ConstructSqeForLabelSetTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    Stream * const stm = taskInfo->stream;
    command->phSqe.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    command->phSqe.l2_lock = 0U;
    command->phSqe.ie = 0U;
    command->phSqe.pre_p = 0U;
    command->phSqe.post_p = 0U;
    command->phSqe.wr_cqe = stm->GetStarsWrCqeFlag();
    command->phSqe.res0 = 0U;

    command->phSqe.task_type = TS_TASK_TYPE_LABEL_SET;
    command->phSqe.task_id = taskInfo->id;
    command->phSqe.rt_streamID = static_cast<uint16_t>(stm->Id_());
    command->phSqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    Model *mdl = stm->Model_();
    if (mdl != nullptr) {
        mdl->LabelCountInc();
    }
    PrintSqe(command, "LabelSet");
    RT_LOG(RT_LOG_INFO, "LabelSetTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}
#endif

static bool CondOpLabelTaskRegister()
{
    TaskFuncSingle labelSetFuncs = {
        .toCommandFunc = &ToCommandBodyForLabelSetTask,
        .toSqeFunc = &ConstructSqeForLabelSetTask,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle labelSwitchFuncs = {
        .toCommandFunc = &ToCommandBodyForLabelSwitchTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle labelGotoFuncs = {
        .toCommandFunc = &ToCommandBodyForLabelGotoTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_LABEL_SET, labelSetFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_LABEL_SWITCH, labelSwitchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_LABEL_GOTO, labelGotoFuncs);
    }

    return true;
}

static bool g_condOpLabelTaskRegister = CondOpLabelTaskRegister();

}  // namespace runtime
}  // namespace cce
