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

namespace cce {
namespace runtime {
#if F_DESC("TaskTimeoutSetTask")
void ConstructDavidSqeForTimeoutSetTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    TimeoutSetTaskInfo * const timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    Stream * const stm = taskInfo->stream;
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const sqe = &(davidSqe->aicpuControlSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;

    sqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batchMode = 0U;
    sqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(sqe);

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;

    sqe->usrData.pid = 0U;
    sqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_TIMEOUT_CONFIG);
    sqe->usrData.vfId = 0U;
    sqe->usrData.tid = 0U;
    sqe->usrData.tsId = 0U;
    sqe->usrData.u.timeoutCfg.opWaitTimeoutEn = timeoutSetTask->opWaitTimeoutEn;
    sqe->usrData.u.timeoutCfg.opWaitTimeout = timeoutSetTask->opWaitTimeout;

    sqe->usrData.u.timeoutCfg.opExecuteTimeoutEn = timeoutSetTask->opExecuteTimeoutEn;
    if ((timeoutSetTask->opExecuteTimeoutEn) && (timeoutSetTask->opExecuteTimeout == 0U)) {
        sqe->usrData.u.timeoutCfg.opExecuteTimeout = RT_STARS_AICPU_DEFAULT_TIMEOUT;
    } else {
        sqe->usrData.u.timeoutCfg.opExecuteTimeout = timeoutSetTask->opExecuteTimeout;
    }

    sqe->subTopicId = 0U;
    sqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    sqe->groupId = 0U;
    sqe->usrDataLen = 20U;

    sqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "TaskTimeoutSetTask");
    RT_LOG(RT_LOG_INFO, "TaskTimeoutSetTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "topicType=%u, cmdType=%u.", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        static_cast<uint32_t>(sqe->topicType), sqe->usrData.cmdType);
}
#endif
}  // namespace runtime
}  // namespace cce
