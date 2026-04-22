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
#include "model_to_aicpu_task.h"

namespace cce {
namespace runtime {

void ConstructDavidSqeForModelToAicpuTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const sqe = &(davidSqe->aicpuControlSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;

    sqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batchMode = 0U;
    sqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(sqe);

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;

    sqe->usrData.pid = 0U;
    sqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_MODEL_OPERATE);
    sqe->usrData.vfId = 0U;
    sqe->usrData.tid = 0U;
    sqe->usrData.tsId = 0U;
    sqe->usrData.u.modelOperate.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->usrData.u.modelOperate.cmdType = static_cast<uint8_t>(taskInfo->u.modelToAicpuTask.cmdType);
    sqe->usrData.u.modelOperate.modelId = static_cast<uint16_t>(taskInfo->u.modelToAicpuTask.modelId);
    sqe->usrData.u.modelOperate.modelInfoAddrLow = static_cast<uint32_t>(taskInfo->u.modelToAicpuTask.modelArgPtr);
    sqe->usrData.u.modelOperate.modelInfoAddrHigh =
        static_cast<uint16_t>(taskInfo->u.modelToAicpuTask.modelArgPtr >> UINT32_BIT_NUM);

    sqe->subTopicId = 0U;
    sqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    sqe->groupId = 0U;
    sqe->usrDataLen = 24U;

    sqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "ModelToAicpuTask");
    RT_LOG(RT_LOG_INFO, "ModelToAicpuTask, topic_type=%u, cmd_type=%u, device_id=%u,"
        "stream_id=%d, task_id=%hu, task_sn=%u.", static_cast<uint32_t>(sqe->topicType), taskInfo->u.modelToAicpuTask.cmdType,
        taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

}  // namespace runtime
}  // namespace cce
