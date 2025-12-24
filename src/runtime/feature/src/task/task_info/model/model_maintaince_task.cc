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
#include "notify.hpp"
#include "error_code.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelMaintainceTask")
rtError_t ModelMaintainceTaskInit(TaskInfo * const taskInfo, const MmtType mType,
                                  Model *const modelPtr, Stream *const opStreamPtr,
                                  const rtModelStreamType_t modelStreamType,
                                  const uint32_t firstTaskIndex)
{
    ModelMaintainceTaskInfo *modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    TaskCommonInfoInit(taskInfo);
    Device * const dev = taskInfo->stream->Device_();
    Driver * const driver = dev->Driver_();

    taskInfo->type = TS_TASK_TYPE_MODEL_MAINTAINCE;
    taskInfo->typeName = "MODEL_MAINTAINCE";

    modelMaintainceTaskInfo->type = mType;
    modelMaintainceTaskInfo->opStream = opStreamPtr;
    modelMaintainceTaskInfo->model = modelPtr;
    modelMaintainceTaskInfo->streamType = modelStreamType;
    modelMaintainceTaskInfo->firstTaskId = firstTaskIndex;
    modelMaintainceTaskInfo->execTimesSvmOffset = 0x0U;

    if ((mType == MMT_STREAM_ADD) && (Runtime::Instance()->ChipIsHaveStars())) {
        uint16_t * const execTimesSvm = modelMaintainceTaskInfo->opStream->GetExecutedTimesSvm();
        rtError_t error = RT_ERROR_NONE;
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_MAINTAINCE_WITH_VA)) {
            modelMaintainceTaskInfo->execTimesSvmOffset =
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(execTimesSvm));
        } else {
            error = driver->MemAddressTranslate(
                static_cast<int32_t>(modelMaintainceTaskInfo->opStream->Device_()->Id_()),
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(execTimesSvm)),
                &(modelMaintainceTaskInfo->execTimesSvmOffset));
        }
        return error;
    }
    return RT_ERROR_NONE;
}

void ToCommandBodyForModelMaintainceTask(TaskInfo * const taskInfo, rtCommand_t * const command)
{
    ModelMaintainceTaskInfo *modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);

    command->u.modelMaintainceTack.modelId = static_cast<uint16_t>(modelMaintainceTaskInfo->model->Id_());
    command->u.modelMaintainceTack.stream_id = static_cast<uint16_t>(modelMaintainceTaskInfo->opStream->Id_());
    command->u.modelMaintainceTack.operation = modelMaintainceTaskInfo->type;
    command->u.modelMaintainceTack.stream_type = static_cast<uint16_t>(modelMaintainceTaskInfo->streamType);
    command->u.modelMaintainceTack.first_task_id = static_cast<uint16_t>(modelMaintainceTaskInfo->firstTaskId);
    if (modelMaintainceTaskInfo->type == MMT_STREAM_ADD) {
        modelMaintainceTaskInfo->opStream->SetBindFlag(true);
        taskInfo->bindFlag = false; // set unbind flag for bind task in mini;
        RT_LOG(RT_LOG_INFO, "set bind flag true, model_id=%u, stream_id=%u.",
               static_cast<uint32_t>(command->u.modelMaintainceTack.modelId),
               static_cast<uint32_t>(command->u.modelMaintainceTack.stream_id));
    } else if (modelMaintainceTaskInfo->type == MMT_STREAM_DEL) {
        modelMaintainceTaskInfo->opStream->SetBindFlag(false);
        RT_LOG(RT_LOG_INFO, "set bind flag false, model_id=%u, stream_id=%u.",
               static_cast<uint32_t>(command->u.modelMaintainceTack.modelId),
               static_cast<uint32_t>(command->u.modelMaintainceTack.stream_id));
    } else {
        // no operation
    }
}

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

void PrintErrorInfoForModelMaintainceTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    ModelMaintainceTaskInfo *modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    RT_LOG(RT_LOG_ERROR, "model maintaince execute failed device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu.",
        devId, streamId, taskId, taskInfo->flipNum);
    const uint32_t modelId = (modelMaintainceTaskInfo->model != nullptr) ?
        modelMaintainceTaskInfo->model->Id_() : static_cast<uint32_t>(UINT16_MAX);
    RT_LOG(RT_LOG_ERROR, "model_id=%u, operation_type=%u, stream_type=%d, op_stream_id=%u.",
        modelId, modelMaintainceTaskInfo->type, modelMaintainceTaskInfo->streamType,
        modelMaintainceTaskInfo->opStream->Id_());
}

void DoCompleteSuccessForModelMaintainceTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    const uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        RT_LOG(RT_LOG_ERROR, "Model maintaince process error, retCode=%#x, [%s].",
            errorCode, GetTsErrCodeDesc(errorCode));
        stream->SetErrCode(errorCode);
        PrintErrorInfoForModelMaintainceTask(taskInfo, devId);
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
    }
}

#endif

}  // namespace runtime
}  // namespace cce