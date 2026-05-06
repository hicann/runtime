/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"
#include "task_info_v100.h"

namespace cce {
namespace runtime {
#if F_DESC("TaskTimeoutSetTask")
void ConstructSqeForTimeoutSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    TimeoutSetTaskInfo * const timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    Stream * const stm = taskInfo->stream;
    RtStarsAicpuControlSqe *const sqe = &(command->aicpuControlSqe);
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
    sqe->kernel_credit = RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;

    sqe->usr_data.pid = 0U;
    sqe->usr_data.cmd_type = static_cast<uint8_t>(AICPU_TIMEOUT_CONFIG);
    sqe->usr_data.vf_id = 0U;
    sqe->usr_data.tid = 0U;
    sqe->usr_data.u.timeout_cfg.op_wait_timeout_en = timeoutSetTask->opWaitTimeoutEn;
    sqe->usr_data.u.timeout_cfg.op_wait_timeout = timeoutSetTask->opWaitTimeout;

    sqe->usr_data.u.timeout_cfg.op_execute_timeout_en = timeoutSetTask->opExecuteTimeoutEn;
    if ((timeoutSetTask->opExecuteTimeoutEn) && (timeoutSetTask->opExecuteTimeout == 0U)) {
        sqe->usr_data.u.timeout_cfg.op_execute_timeout = RT_STARS_AICPU_DEFAULT_TIMEOUT;
    } else {
        sqe->usr_data.u.timeout_cfg.op_execute_timeout = timeoutSetTask->opExecuteTimeout;
    }

    sqe->sub_topic_id = 0U;
    sqe->topic_id = 5U; // EVENT_TS_CTRL_MSG
    sqe->group_id = 0U;
    sqe->usr_data_len = 20U;

    sqe->dest_pid = 0U;
    PrintSqe(command, "TaskTimeoutSetTask");
    RT_LOG(RT_LOG_INFO, "TaskTimeoutSetTask ConstructSqe finish, topic_type=%u, cmd_type=%u",
           static_cast<uint32_t>(sqe->topic_type), sqe->usr_data.cmd_type);
}
#endif
}  // namespace runtime
}  // namespace cce
