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
#include "model.hpp"
#include "notify.hpp"
#include "task_info_v100.h"
#include "model_maintaince_task.h"

namespace cce {
namespace runtime {

void ConstructSqeForModelMaintainceTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    ModelMaintainceTaskInfo *modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    RtStarsPhSqe * const sqe = &(command->phSqe);
    Stream * const stream = taskInfo->stream;
    const uint8_t type = modelMaintainceTaskInfo->type;

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->task_type = TS_TASK_TYPE_MODEL_MAINTAINCE;

    sqe->u.model_maintaince_info.model_id = static_cast<uint16_t>(modelMaintainceTaskInfo->model->Id_());
    sqe->u.model_maintaince_info.stream_id = static_cast<uint16_t>(modelMaintainceTaskInfo->opStream->Id_());
    sqe->u.model_maintaince_info.operation = type;
    sqe->u.model_maintaince_info.stream_type = static_cast<uint16_t>(modelMaintainceTaskInfo->streamType);
    sqe->u.model_maintaince_info.first_task_id = static_cast<uint16_t>(modelMaintainceTaskInfo->firstTaskId);

    switch (type) {
        case MMT_STREAM_ADD:
            sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->u.model_maintaince_info.streamExecTimesAddr = modelMaintainceTaskInfo->execTimesSvmOffset;
            PrintSqe(command, "ModelBindTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%u, bind stream_id=%hu to model_id=%hu",
                type, sqe->u.model_maintaince_info.stream_id, sqe->u.model_maintaince_info.model_id);
            break;
        case MMT_STREAM_DEL:
            sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            PrintSqe(command, "ModelUnbindTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%u, unbind stream_id=%hu from model_id=%hu",
                type, sqe->u.model_maintaince_info.stream_id, sqe->u.model_maintaince_info.model_id);
            break;
        case MMT_MODEL_PRE_PROC:
            sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->u.model_maintaince_info.executor_flag = MODEL_EXECUTOR_RESERVED;
            if (modelMaintainceTaskInfo->model->ModelExecuteType() == EXECUTOR_AICPU) {
                sqe->u.model_maintaince_info.executor_flag = MODEL_EXECUTOR_AICPU;
            } else {
                sqe->u.model_maintaince_info.endgraph_notify_id =
                    static_cast<uint16_t>(modelMaintainceTaskInfo->model->GetEndGraphNotify()->GetNotifyId());
            }
            PrintSqe(command, "ModelPreProcTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%u, pre proc stream_id=%hu of model_id=%hu, endgraph_notify_id"
                "=%hu", type, sqe->u.model_maintaince_info.stream_id, sqe->u.model_maintaince_info.model_id,
                sqe->u.model_maintaince_info.endgraph_notify_id);
            break;
        case MMT_MODEL_LOAD_COMPLETE:
            PrintSqe(command, "ModelLoadCompleteTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%u, load complete stream_id=%hu of model_id=%hu",
                type, sqe->u.model_maintaince_info.stream_id, sqe->u.model_maintaince_info.model_id);
            break;
        case MMT_MODEL_ABORT:
            sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            PrintSqe(command, "ModelAbortTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%u, abort stream_id=%hu of model_id=%hu",
                type, sqe->u.model_maintaince_info.stream_id, sqe->u.model_maintaince_info.model_id);
            break;
        default:
            PrintSqe(command, "ModelMaintainceTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%u, stream_id=%hu, model_id=%hu",
                type, sqe->u.model_maintaince_info.stream_id, sqe->u.model_maintaince_info.model_id);
            break;
    }
    return;
}

}  // namespace runtime
}  // namespace cce
