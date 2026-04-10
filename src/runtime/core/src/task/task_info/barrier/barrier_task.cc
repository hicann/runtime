/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "barrier_task.h"
#include "model.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

#if F_DESC("BarrierTask")

rtError_t BarrierTaskInit(TaskInfo *taskInfo, const rtBarrierTaskInfo_t *const barrierTaskInfo, const Stream *const stm,
                          const uint32_t flag)
{
    (void)flag;
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "BARRIER";
    taskInfo->type = TS_TASK_TYPE_BARRIER;

    Model *barrierModel = stm->Model_();
    rtError_t error;
    if (barrierModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Barrier task stream is not in model.");
        return RT_ERROR_MODEL_NULL;
    }

    // sqe info copy
    taskInfo->u.barrierTask.barrierMsg.cmoIdNum = 0U;
    uint16_t tmpCmoId = 0U;
    for (uint8_t i = 0U; i < barrierTaskInfo->logicIdNum; i++) {
        error = barrierModel->GetCmoId(barrierTaskInfo->cmoInfo[i].logicId, tmpCmoId);
        ERROR_RETURN_MSG_INNER(error, "Failed to get Barrier Task cmo id.");
        taskInfo->u.barrierTask.barrierMsg.cmoInfo[i].cmoId = tmpCmoId;
        taskInfo->u.barrierTask.barrierMsg.cmoInfo[i].cmoType = barrierTaskInfo->cmoInfo[i].cmoType;
        taskInfo->u.barrierTask.barrierMsg.cmoIdNum++;
    }

    RT_LOG(RT_LOG_DEBUG, "Barrier Task Info: IdNum=%hhu, logicId(%u,%u,%u,%u,%u,%u), cmotype(%hu,%hu,%hu,%hu,%hu,%hu).",
        barrierTaskInfo->logicIdNum, barrierTaskInfo->cmoInfo[0U].logicId, barrierTaskInfo->cmoInfo[1U].logicId,
        barrierTaskInfo->cmoInfo[2U].logicId, barrierTaskInfo->cmoInfo[3U].logicId, // 2U is index, 3U is index
        barrierTaskInfo->cmoInfo[4U].logicId, barrierTaskInfo->cmoInfo[5U].logicId, // 4U is index, 5U is index
        barrierTaskInfo->cmoInfo[0U].cmoType, barrierTaskInfo->cmoInfo[1U].cmoType,
        barrierTaskInfo->cmoInfo[2U].cmoType, barrierTaskInfo->cmoInfo[3U].cmoType, // 2U is index, 3U is index
        barrierTaskInfo->cmoInfo[4U].cmoType, barrierTaskInfo->cmoInfo[5U].cmoType); // 4U is index, 5U is index
    return RT_ERROR_NONE;
}

#endif

}  // namespace runtime
}  // namespace cce
