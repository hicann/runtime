/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
#include "end_graph_task.h"

namespace cce {
namespace runtime {

#if F_DESC("AddEndGraphTask")

rtError_t AddEndGraphTaskInit(TaskInfo* taskInfo, const uint32_t modelId, const uint32_t exeFlag,
                              const uint64_t argParam, const uint64_t endGraphName,
                              const uint8_t flags)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "MODEL_END_GRAPH";
    taskInfo->type = TS_TASK_TYPE_MODEL_END_GRAPH;
    taskInfo->u.addEndGraphTask.modelId = modelId;
    taskInfo->u.addEndGraphTask.executorFlag = exeFlag;
    taskInfo->u.addEndGraphTask.argptr = argParam;
    taskInfo->u.addEndGraphTask.endGraphNamePtr = endGraphName;
    taskInfo->u.addEndGraphTask.datadumpFlag = flags;
    RT_LOG(RT_LOG_DEBUG, "Create end graph task,mode_id=%u,executor flag=%u,task_id=%u,task_type=%d(%s),"
        "stream_id=%d,datadumpFlag=%u.",
        modelId, exeFlag, static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(taskInfo->type),
        taskInfo->typeName, taskInfo->stream->Id_(),
        static_cast<uint32_t>(taskInfo->u.addEndGraphTask.datadumpFlag));
    return RT_ERROR_NONE;
}

void ToCmdBodyForAddEndGraphTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    Stream *stm = taskInfo->stream;

    command->u.modelEndGraphTask.modelId = taskInfo->u.addEndGraphTask.modelId;
    command->u.modelEndGraphTask.executorFlag = taskInfo->u.addEndGraphTask.executorFlag;
    command->u.modelEndGraphTask.argptr = taskInfo->u.addEndGraphTask.argptr;
    command->u.modelEndGraphTask.endGraphNamePtr = taskInfo->u.addEndGraphTask.endGraphNamePtr;
    command->u.modelEndGraphTask.priority = static_cast<uint8_t>(stm->Priority());
    command->u.modelEndGraphTask.flag = taskInfo->u.addEndGraphTask.datadumpFlag;
    command->taskInfoFlag |= static_cast<uint8_t>(ENDGRAPH_INFO_FLAG);
}

void ConstructSqeForAddEndGraphTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsAicpuKernelSqe *const sqe = &(command->aicpuSqe);
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

    sqe->kernel_type = (static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU));
    sqe->batch_mode = 0U;
    sqe->topic_type = TOPIC_TYPE_DEVICE_AICPU_ONLY;

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res7 = 0U;
    sqe->sqe_index = 0U; // useless
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    // soname aicpu no need
    const uint64_t addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(nullptr));
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    sqe->paramAddrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.argptr);
    sqe->param_addr_high = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.argptr >> UINT32_BIT_NUM);

    sqe->task_name_str_ptr_low = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr);
    sqe->task_name_str_ptr_high = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr >> UINT32_BIT_NUM);
    sqe->pL2CtrlLow = 0U;
    sqe->p_l2ctrl_high = 0U;
    sqe->overflow_en = 0U;
    sqe->extraFieldLow = taskInfo->id; // send task id info to aicpu
    sqe->extra_field_high = 0U;

    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->group_id = 0U;
    sqe->usr_data_len = 40U; // size: word4-13
    sqe->dest_pid = 0U;

    PrintSqe(command, "AddEndGraphTask");
    RT_LOG(RT_LOG_INFO, "AddEndGraphTask::ConstructSqe finish,topic_type=%u sqe addr=%p",
           static_cast<uint32_t>(sqe->topic_type), command);
}

#endif

}  // namespace runtime
}  // namespace cce