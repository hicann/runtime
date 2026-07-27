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
#include "device.hpp"
#include "driver.hpp"
#include "notify.hpp"
#include "device/device_error_proc.hpp"
#include "model.hpp"
#include "error_code.h"
#include "error_message_manage.hpp"
#include "task_info.hpp"
#include "model_execute_task.h"
#include "model_maintaince_task.h"
#include "stub_task.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelExecuteTask")

static void ConstructSqeForModelExecuteTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);

    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.l1Lock = 0U;
    sqe->header.l1UnLock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_CONDS_MODEL_EXEC;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    sqe->u.modelExecuteInfo.modelId = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);
    PrintSqe(command, "ModelExecuteTask");
}

static void SetResultForModelExecuteTask(TaskInfo* const taskInfo, const void* const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    const uint32_t* const tsData = static_cast<const uint32_t*>(data);
    const uint32_t payLoad = *tsData;
    const uint32_t highTaskId = *(tsData + 1U);
    const uint32_t streamIdEx = *(tsData + 2U);
    taskInfo->errorCode = (payLoad & 0xFFFU);
    modelExecuteTaskInfo->errorTaskId = ((payLoad >> 22U) & 0x3FFU) | (highTaskId << 10U);
    modelExecuteTaskInfo->errorStreamId =
        ((payLoad >> 12U) & 0x3FFU) | (streamIdEx << (static_cast<uint32_t>(RT_STREAM_ID_OFFSET)));

    RT_LOG(
        RT_LOG_DEBUG, "Payload=%u, highTaskId=%u, errorCode=0x%x, errorTaskId=%u, errorStreamId=%u.", payLoad,
        highTaskId, taskInfo->errorCode, modelExecuteTaskInfo->errorTaskId, modelExecuteTaskInfo->errorStreamId);
}

#endif

#if F_DESC("ModelMaintainceTask")

static void ConstructSqeForModelMaintainceTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    ModelMaintainceTaskInfo* modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* const sqe = &(command->phSqe);
    Stream* const stream = taskInfo->stream;
    const uint8_t type = modelMaintainceTaskInfo->type;

    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stream->GetStarsWrCqeFlag();
    sqe->header.rtStreamId = static_cast<uint16_t>(stream->Id_());
    sqe->header.taskId = taskInfo->id;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_MODEL_MAINTAINCE;

    sqe->u.modelMaintainceInfo.modelId = static_cast<uint16_t>(modelMaintainceTaskInfo->model->Id_());
    sqe->u.modelMaintainceInfo.streamId = static_cast<uint16_t>(modelMaintainceTaskInfo->opStream->Id_());
    sqe->u.modelMaintainceInfo.operation = type;
    sqe->u.modelMaintainceInfo.streamType = static_cast<uint16_t>(modelMaintainceTaskInfo->streamType);
    sqe->u.modelMaintainceInfo.firstTaskId = static_cast<uint16_t>(modelMaintainceTaskInfo->firstTaskId);

    switch (type) {
        case MMT_STREAM_ADD:
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->u.modelMaintainceInfo.streamExecTimesAddr = modelMaintainceTaskInfo->execTimesSvmOffset;
            PrintSqe(command, "ModelBindTask");
            RT_LOG(
                RT_LOG_INFO, "model maintaince type=%u, bind stream_id=%hu to model_id=%hu", type,
                sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId);
            break;
        case MMT_STREAM_DEL:
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            PrintSqe(command, "ModelUnbindTask");
            RT_LOG(
                RT_LOG_INFO, "model maintaince type=%u, unbind stream_id=%hu from model_id=%hu", type,
                sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId);
            break;
        case MMT_MODEL_LOAD_COMPLETE:
            PrintSqe(command, "ModelLoadCompleteTask");
            RT_LOG(
                RT_LOG_INFO, "model maintaince type=%u, load complete stream_id=%hu of model_id=%hu", type,
                sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId);
            break;
        case MMT_MODEL_PRE_PROC:
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->u.modelMaintainceInfo.executorFlag = MODEL_EXECUTOR_RESERVED;
            if (modelMaintainceTaskInfo->model->ModelExecuteType() == EXECUTOR_AICPU) {
                sqe->u.modelMaintainceInfo.executorFlag = MODEL_EXECUTOR_AICPU;
            } else {
                sqe->u.modelMaintainceInfo.endgraphNotifyId =
                    static_cast<uint16_t>(modelMaintainceTaskInfo->model->GetEndGraphNotify()->GetNotifyId());
            }
            PrintSqe(command, "ModelPreProcTask");
            RT_LOG(
                RT_LOG_INFO,
                "model maintaince type=%u, pre proc stream_id=%hu of model_id=%hu, endgraphNotifyId"
                "=%hu",
                type, sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId,
                sqe->u.modelMaintainceInfo.endgraphNotifyId);
            break;
        case MMT_MODEL_ABORT:
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            PrintSqe(command, "ModelAbortTask");
            RT_LOG(
                RT_LOG_INFO, "model maintaince type=%u, abort stream_id=%hu of model_id=%hu", type,
                sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId);
            break;
        default:
            PrintSqe(command, "ModelMaintainceTask");
            RT_LOG(
                RT_LOG_INFO, "model maintaince type=%u, stream_id=%hu, model_id=%hu", type,
                sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId);
            break;
    }
}

#endif

rtError_t PrepareSqeInfoForModelExecuteTask(TaskInfo* const taskInfo)
{
    UNUSED(taskInfo);
    return RT_ERROR_NONE;
}

void PrintErrorModelExecuteTaskFuncCall(TaskInfo* const task) { UNUSED(task); }

static bool ModelExecuteTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForModelExecuteTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForModelExecuteTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForModelExecuteTask,
        .setResultFunc = &SetResultForModelExecuteTask,
        .setStarsResultFunc = &SetStarsResultForModelExecuteTask,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_MODEL_EXECUTE, funcs);
    return true;
}

static bool g_modelExecuteTaskRegister = ModelExecuteTaskRegister();

static bool ModelMaintainceTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForModelMaintainceTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForModelMaintainceTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForModelMaintainceTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_MODEL_MAINTAINCE, funcs);
    return true;
}

static bool g_modelMaintainceTaskRegister = ModelMaintainceTaskRegister();

} // namespace runtime
} // namespace cce
