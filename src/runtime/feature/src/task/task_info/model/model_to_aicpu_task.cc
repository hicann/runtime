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
#include "stub_task.hpp"
#include "error_code.h"
#include "task_manager.h"
#include "model_to_aicpu_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelToAicpuTask")

rtError_t ModelToAicpuTaskInit(TaskInfo* taskInfo, const uint32_t modelIndex, const uint32_t controlType,
                               const uint32_t exeFlag, const uint64_t modelPtr)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "MODEL_TO_AICPU";
    taskInfo->type = TS_TASK_TYPE_MODEL_TO_AICPU;
    taskInfo->u.modelToAicpuTask.modelId = modelIndex;
    taskInfo->u.modelToAicpuTask.cmdType = controlType;
    taskInfo->u.modelToAicpuTask.executorFlag = exeFlag;
    taskInfo->u.modelToAicpuTask.modelArgPtr = modelPtr;
    RT_LOG(RT_LOG_DEBUG, "Create model to aicpu task,mode_id=%u,executor flag=%u,cmd_type=%u,stream_id=%d, "
           "task_id=%u, task_type=%d(%s).", taskInfo->u.modelToAicpuTask.modelId,
           taskInfo->u.modelToAicpuTask.executorFlag, taskInfo->u.modelToAicpuTask.cmdType, taskInfo->stream->Id_(),
           static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(taskInfo->type), taskInfo->typeName);
    return RT_ERROR_NONE;
}

void ToCmdBodyForModelToAicpuTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.modelToAicpuTask.modelId = taskInfo->u.modelToAicpuTask.modelId;
    command->u.modelToAicpuTask.cmdType = taskInfo->u.modelToAicpuTask.cmdType;
    command->u.modelToAicpuTask.executorFlag = taskInfo->u.modelToAicpuTask.executorFlag;
    command->u.modelToAicpuTask.modelArgPtr = taskInfo->u.modelToAicpuTask.modelArgPtr;
}

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

void PrintErrorInfoForModelToAicpuTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
        "Model to aicpu task execute failed, device_id=%u,stream_id=%d,%s=%u,flip_num=%hu, "
        "model_id=%u,cmd_type=%u,executor_flag=%u",
        devId, streamId, TaskIdDesc(), taskId, taskInfo->flipNum, taskInfo->u.modelToAicpuTask.modelId,
        taskInfo->u.modelToAicpuTask.cmdType, taskInfo->u.modelToAicpuTask.executorFlag);
}

void DoCompleteSuccForModelToAicpuTask(TaskInfo* taskInfo, const uint32_t devId)
{
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        RT_LOG(RT_LOG_ERROR, "Model to aicpu task process error,retCode=%#x, [%s].",
               taskInfo->errorCode, GetTsErrCodeDesc(taskInfo->errorCode));
        taskInfo->stream->SetErrCode(taskInfo->errorCode);
        PrintErrorInfoForModelToAicpuTask(taskInfo, devId);

        Stream * const stream = taskInfo->stream;
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, taskInfo->errorCode, stream->Device_());
    }
}

void SetStarsResultForModelToAicpuTask(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        uint32_t aicpuErrMap[] = {
            TS_ERROR_AICPU_MODEL_RSP_ERR,
            TS_ERROR_AICPU_MODEL_RSP_ERR,
            TS_ERROR_AICPU_TIMEOUT,
            TS_ERROR_AICPU_MODEL_RSP_ERR,
            TS_ERROR_AICPU_MODEL_RSP_ERR,
            logicCq.errorCode};
        const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
        const uint32_t cmdType = taskInfo->u.modelToAicpuTask.cmdType;
        if ((cmdType == TS_AICPU_MODEL_LOAD) || (cmdType == TS_AICPU_MODEL_EXECUTE) ||
            (cmdType == TS_AICPU_MODEL_DESTROY)) {
            taskInfo->errorCode = aicpuErrMap[errorIndex];
            RT_LOG(RT_LOG_ERROR, "aicpu model cmdType=%u,errorCode=%u,logicCq:err=%u,errCode=%u,model_id=%u,"
                " stream_id=%hu,task_id=%hu", cmdType, taskInfo->errorCode, logicCq.errorType, logicCq.errorCode,
                taskInfo->u.modelToAicpuTask.modelId, taskInfo->stream->Id_(), taskInfo->id);
        }
    }
}

#endif

}  // namespace runtime
}  // namespace cce