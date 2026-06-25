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
#include "stars_david.hpp"
#include "task_manager.h"
#include "timeout_set_task.h"

namespace cce {
namespace runtime {
#if F_DESC("TaskTimeoutSetTask")
static void ConstructDavidSqeForTimeoutSetTask(TaskInfo *taskInfo, void *const sqe,
    const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    TimeoutSetTaskInfo * const timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const aicpuCtrlSqe = &(davidSqe->aicpuControlSqe);
    aicpuCtrlSqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    aicpuCtrlSqe->header.blockDim = 1U;

    aicpuCtrlSqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    aicpuCtrlSqe->batchMode = 0U;
    aicpuCtrlSqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(aicpuCtrlSqe);

    aicpuCtrlSqe->qos = stm->Device_()->GetTsdQos();
    aicpuCtrlSqe->res2 = 0U;
    aicpuCtrlSqe->sqeIndex = 0U; // useless
    aicpuCtrlSqe->kernelCredit = RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;

    aicpuCtrlSqe->usrData.pid = 0U;
    aicpuCtrlSqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_TIMEOUT_CONFIG);
    aicpuCtrlSqe->usrData.vfId = 0U;
    aicpuCtrlSqe->usrData.tid = 0U;
    aicpuCtrlSqe->usrData.tsId = 0U;
    aicpuCtrlSqe->usrData.u.timeoutCfg.opWaitTimeoutEn = timeoutSetTask->opWaitTimeoutEn;
    aicpuCtrlSqe->usrData.u.timeoutCfg.opWaitTimeout = timeoutSetTask->opWaitTimeout;

    aicpuCtrlSqe->usrData.u.timeoutCfg.opExecuteTimeoutEn = timeoutSetTask->opExecuteTimeoutEn;
    if ((timeoutSetTask->opExecuteTimeoutEn) && (timeoutSetTask->opExecuteTimeout == 0U)) {
        aicpuCtrlSqe->usrData.u.timeoutCfg.opExecuteTimeout = RT_STARS_AICPU_DEFAULT_TIMEOUT;
    } else {
        aicpuCtrlSqe->usrData.u.timeoutCfg.opExecuteTimeout = timeoutSetTask->opExecuteTimeout;
    }

    aicpuCtrlSqe->subTopicId = 0U;
    aicpuCtrlSqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    aicpuCtrlSqe->groupId = 0U;
    aicpuCtrlSqe->usrDataLen = 20U;

    aicpuCtrlSqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "TaskTimeoutSetTask");
    RT_LOG(RT_LOG_INFO, "TaskTimeoutSetTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "topicType=%u, cmdType=%u.", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        static_cast<uint32_t>(aicpuCtrlSqe->topicType), aicpuCtrlSqe->usrData.cmdType);
}
#endif

static bool TimeoutSetTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = &ToCommandBodyForTimeoutSetTask,
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
        RegTaskFunc(chip, TS_TASK_TYPE_TASK_TIMEOUT_SET, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_TASK_TIMEOUT_SET, &ConstructDavidSqeForTimeoutSetTask);
    return true;
}

static bool g_timeoutSetTaskRegister = TimeoutSetTaskRegister();

}  // namespace runtime
}  // namespace cce
