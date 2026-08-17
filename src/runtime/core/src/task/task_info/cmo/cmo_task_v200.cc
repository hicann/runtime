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
#include "model.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

void ConstructDavidSqeForCmoTaskCommon(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo, CmoSqeConstructor cmoSqeConstructor)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    Stream* const stm = taskInfo->stream;
    Model* cmoModel = stm->Model_();
    CmoTaskInfo* const cmoTsk = &(taskInfo->u.cmoTask);
    if ((cmoModel != nullptr) && (cmoModel->GetModelType() == RT_MODEL_NORMAL)) {
        // CmoTask for model stream.
        ConstructDavidCmoAddrSqe(taskInfo, davidSqe, sqBaseAddr);
    } else {
        if ((cmoTsk->cmoSqeInfo.opCode == RT_CMO_PREFETCH) || (cmoTsk->cmoSqeInfo.opCode == RT_CMO_WRITEBACK)) {
            cmoSqeConstructor(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidCmoSdmaSqe(taskInfo, davidSqe, sqBaseAddr);
        }
    }
}

void ConstructDavidSqeForCmoTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    ConstructDavidSqeForCmoTaskCommon(taskInfo, sqe, sqeInfo, &ConstructDavidCmoSqe);
}

static bool CmoTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForDavidCmoTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const std::vector<rtChipType_t> chips = {CHIP_DAVID, CHIP_ASCEND_350};
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_CMO, funcs);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_CMO, &ConstructDavidSqeForCmoTask);
    }

    return true;
}

static bool g_cmoTaskRegister = CmoTaskRegister();

} // namespace runtime
} // namespace cce
