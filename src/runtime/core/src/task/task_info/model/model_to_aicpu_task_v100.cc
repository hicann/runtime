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
#include "task_info_v100.h"
#include "model_to_aicpu_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelToAicpuTask")

void ConstructSqeForModelToAicpuTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsAicpuControlSqe *const sqe = &(command->aicpuControlSqe);
    Stream *stm = taskInfo->stream;

    sqe->header.type = RT_STARS_SQE_TYPE_AICPU;
    sqe->header.l1_lock = 0U;
    sqe->header.l1_unlock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;

    sqe->header.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->header.reserved = 0U;
    sqe->header.block_dim = 1U;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->kernel_type = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batch_mode = 0U;
    sqe->topic_type = TOPIC_TYPE_DEVICE_AICPU_ONLY;

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res7 = 0U;
    sqe->sqe_index = 0U; // useless
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->usr_data.pid = 0U;
    sqe->usr_data.cmd_type = static_cast<uint8_t>(AICPU_MODEL_OPERATE);
    sqe->usr_data.vf_id = 0U;
    sqe->usr_data.tid = 0U;
    sqe->usr_data.ts_id = 0U;
    sqe->usr_data.u.model_operate.sq_id = static_cast<uint16_t>(stm->Id_());
    sqe->usr_data.u.model_operate.task_id = taskInfo->id;
    sqe->usr_data.u.model_operate.cmd_type = static_cast<uint8_t>(taskInfo->u.modelToAicpuTask.cmdType);
    sqe->usr_data.u.model_operate.model_id = static_cast<uint16_t>(taskInfo->u.modelToAicpuTask.modelId);
    sqe->usr_data.u.model_operate.model_info_addr_low = static_cast<uint32_t>(taskInfo->u.modelToAicpuTask.modelArgPtr);
    sqe->usr_data.u.model_operate.model_info_addr_high =
        static_cast<uint16_t>(taskInfo->u.modelToAicpuTask.modelArgPtr >> UINT32_BIT_NUM);

    sqe->sub_topic_id = 0U;
    sqe->topic_id = 5U; // EVENT_TS_CTRL_MSG
    sqe->group_id = 0U;
    sqe->usr_data_len = 24U;

    sqe->dest_pid = 0U;
    PrintSqe(command, "ModelToAicpuTask");
    RT_LOG(RT_LOG_INFO, "ModelToAicpuTask::ConstructSqe finish,topic_type=%u sqe addr=%p cmdType_=%u",
           static_cast<uint32_t>(sqe->topic_type), command, taskInfo->u.modelToAicpuTask.cmdType);
}

#endif

}  // namespace runtime
}  // namespace cce
