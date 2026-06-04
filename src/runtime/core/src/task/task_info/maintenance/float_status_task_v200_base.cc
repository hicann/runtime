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
#include "stars_cond_isa_helper.hpp"
#include "stream.hpp"
#include "task_manager.h"

namespace cce {
namespace runtime {

static void ConstructDavidSqeForNpuGetFloatStaTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsGetFloatStatusSqe &sqe = davidSqe->getFloatStatusSqe;
    NpuGetFloatStatusTaskInfo * const npuGetFltSta = &(taskInfo->u.npuGetFloatStatusTask);
    Stream * const stm = taskInfo->stream;
    sqe.debugFlag = npuGetFltSta->debugFlag ? 1U : 0U;
    ConstructGetFloatStatusInstr(
        RtPtrToValue(npuGetFltSta->outputAddrPtr),
        npuGetFltSta->outputSize, sqe);

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.header.preP = 1U;
    sqe.condsSubType = CONDS_SUB_TYPE_GET_FLOAT_STATUS;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    PrintDavidSqe(davidSqe, "NpuGetFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "NpuGetFloatStatusTask finish, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "debugFlag=%hhu.", taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        sqe.debugFlag);
}

static void ConstructDavidSqeForNpuClrFloatStaTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    NpuClearFloatStatusTaskInfo * const npuClrFltSta = &(taskInfo->u.npuClrFloatStatusTask);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.debugStatusInfo.debugFlag = npuClrFltSta->debugFlag ? 1U : 0U;

    PrintDavidSqe(davidSqe, "NpuClearFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "NpuClearFloatStatusTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, debugFlag=%d.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        npuClrFltSta->debugFlag);
}

static bool FloatStatusTaskRegister()
{
    TaskFuncSingle getFloatStatusFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle clearFloatStatusFuncs = {
        .toCommandFunc = nullptr,
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
        RegTaskFunc(chip, TS_TASK_TYPE_NPU_GET_FLOAT_STATUS, getFloatStatusFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS, clearFloatStatusFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_NPU_GET_FLOAT_STATUS, &ConstructDavidSqeForNpuGetFloatStaTask);
    RegDavidSqeFunc(TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS, &ConstructDavidSqeForNpuClrFloatStaTask);

    return true;
}

static bool g_floatStatusTaskRegister = FloatStatusTaskRegister();
} // namespace runtime
} // namespace cce
