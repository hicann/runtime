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

namespace cce {
namespace runtime {

#if F_DESC("AddEndGraphTask")

void ConstructDavidSqeForAddEndGraphTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuKernelSqe * const sqe = &(davidSqe->aicpuSqe);
    Stream * const stm = taskInfo->stream;

    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;
    sqe->kernelType = (static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU));
    sqe->batchMode = 0U;
    sqe->topicType = 0U;
    UpdateDavidAICpuSqeForDavinciTask(sqe);

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;

    // soname aicpu no need
    uint64_t addr = 0ULL;
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    sqe->paramAddrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.argptr);
    sqe->paramAddrHigh = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.argptr >> UINT32_BIT_NUM);

    sqe->taskNameStrPtrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr);
    sqe->taskNameStrPtrHigh = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr >> UINT32_BIT_NUM);
    sqe->pL2ctrlLow = 0U;
    sqe->pL2ctrlHigh = 0U;
    sqe->overflowEn = 0U;
    sqe->extraFieldLow = taskInfo->taskSn; // send task id info to aicpu
    sqe->extraFieldHigh = 0U;

    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->groupId = 0U;
    sqe->usrDataLen = 40U; // size: word4-13
    sqe->destPid = 0U;

    sqe->res5 = 0xFFFFU;

    PrintDavidSqe(davidSqe, "AddEndGraphTask");
    RT_LOG(RT_LOG_INFO, "AddEndGraphTask, topicType=%u, device_id=%u, stream_id=%d,"
        "task_id=%hu, task_sn=%u.", static_cast<uint32_t>(sqe->topicType), taskInfo->stream->Device_()->Id_(),
        stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

#endif

}  // namespace runtime
}  // namespace cce
