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
#include "stars_david.hpp"
#include "model_maintaince_task.h"
#include "capture_model.hpp"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelMaintainceTask")

rtError_t DavidModelMaintainceTaskInit(TaskInfo * const taskInfo, const MmtType mType,
    Model *const modelPtr, Stream *const opStreamPtr, const rtModelStreamType_t modelStreamType,
    const uint32_t firstTaskIndex)
{
    ModelMaintainceTaskInfo *modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MODEL_MAINTAINCE;
    taskInfo->typeName = "MODEL_MAINTAINCE";

    modelMaintainceTaskInfo->type = mType;
    modelMaintainceTaskInfo->opStream = opStreamPtr;
    modelMaintainceTaskInfo->model = modelPtr;
    modelMaintainceTaskInfo->streamType = modelStreamType;
    modelMaintainceTaskInfo->firstTaskId = firstTaskIndex;
    modelMaintainceTaskInfo->execTimesSvmOffset = 0x0U;

    if (mType == MMT_STREAM_ADD) {
        uint16_t * const execTimesSvm = modelMaintainceTaskInfo->opStream->GetExecutedTimesSvm();
        modelMaintainceTaskInfo->execTimesSvmOffset =
            RtPtrToValue<uint16_t *>(execTimesSvm);
    }
    return RT_ERROR_NONE;
}

static void ConstructSqeForModelMaintainceTaskCommon(TaskInfo * const taskInfo, RtDavidPlaceHolderSqe * const sqe)
{
    ModelMaintainceTaskInfo * const modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->taskType = TS_TASK_TYPE_MODEL_MAINTAINCE;

    sqe->u.modelMaintainceInfo.modelId = static_cast<uint16_t>(modelMaintainceTaskInfo->model->Id_());
    sqe->u.modelMaintainceInfo.streamId = static_cast<uint16_t>(modelMaintainceTaskInfo->opStream->Id_());
    sqe->u.modelMaintainceInfo.operation = static_cast<uint16_t>(modelMaintainceTaskInfo->type);
    sqe->u.modelMaintainceInfo.streamType = static_cast<uint16_t>(modelMaintainceTaskInfo->streamType);
    sqe->u.modelMaintainceInfo.firstTaskId = static_cast<uint16_t>(modelMaintainceTaskInfo->firstTaskId);
    sqe->u.modelMaintainceInfo.opSqId = modelMaintainceTaskInfo->opStream->GetSqId();
    sqe->u.modelMaintainceInfo.sqId = taskInfo->stream->GetSqId();
}

static void ConstructDavidSqeForModelMaintainceTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ModelMaintainceTaskInfo * const modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    ConstructSqeForModelMaintainceTaskCommon(taskInfo, phSqe);

    const int32_t type = static_cast<int32_t>(modelMaintainceTaskInfo->type);
    switch (type) {
        case MMT_STREAM_ADD:
            phSqe->header.preP = 1U;
            phSqe->u.modelMaintainceInfo.streamExecTimesAddr = modelMaintainceTaskInfo->execTimesSvmOffset;
            modelMaintainceTaskInfo->opStream->SetBindFlag(true);
            PrintDavidSqe(davidSqe, "ModelBindTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, device_id=%u, bind stream_id=%hu to modelId=%hu, task_id=%hu",
                type, taskInfo->stream->Device_()->Id_(), phSqe->u.modelMaintainceInfo.streamId,
                phSqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        case MMT_STREAM_DEL:
            phSqe->header.preP = 1U;
            modelMaintainceTaskInfo->opStream->SetBindFlag(false);
            PrintDavidSqe(davidSqe, "ModelUnbindTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, device_id=%u, unbind stream_id=%hu from modelId=%hu,"
                "task_id=%hu", type, taskInfo->stream->Device_()->Id_(), phSqe->u.modelMaintainceInfo.streamId,
                phSqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        case MMT_MODEL_PRE_PROC:
            phSqe->header.preP = 1U;
            phSqe->u.modelMaintainceInfo.executorFlag = MODEL_EXECUTOR_RESERVED;
            if (modelMaintainceTaskInfo->model->ModelExecuteType() == EXECUTOR_AICPU) {
                phSqe->u.modelMaintainceInfo.executorFlag = MODEL_EXECUTOR_AICPU;
            } else {
                phSqe->u.modelMaintainceInfo.executorFlag = GetCaptureModelExecutorType(modelMaintainceTaskInfo);
                phSqe->u.modelMaintainceInfo.endgraphNotifyId =
                    static_cast<uint16_t>(GetEndGraphNotifyId(modelMaintainceTaskInfo->model));
            }
            PrintDavidSqe(davidSqe, "ModelPreProcTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, device_id=%u, pre proc stream_id=%hu of modelId=%hu,"
                "endgraphNotifyId=%hu, taskId=%hu, executorFlag=%u.", type, taskInfo->stream->Device_()->Id_(),
                phSqe->u.modelMaintainceInfo.streamId, phSqe->u.modelMaintainceInfo.modelId,
                phSqe->u.modelMaintainceInfo.endgraphNotifyId, taskInfo->id, phSqe->u.modelMaintainceInfo.executorFlag);
            break;
        case MMT_MODEL_LOAD_COMPLETE:
            PrintDavidSqe(davidSqe, "ModelLoadCompleteTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, device_id=%u, load complete stream_id=%hu of modelId=%hu,"
                "task_id=%hu", type, taskInfo->stream->Device_()->Id_(), phSqe->u.modelMaintainceInfo.streamId,
                phSqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        case MMT_MODEL_ABORT:
            phSqe->header.preP = 1U;
            PrintDavidSqe(davidSqe, "ModelAbortTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, device_id=%u, abort stream_id=%hu of modelId=%hu, task_id=%hu",
                type, taskInfo->stream->Device_()->Id_(), phSqe->u.modelMaintainceInfo.streamId,
                phSqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        default:
            PrintDavidSqe(davidSqe, "ModelMaintainceTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, device_id=%u, stream_id=%hu, modelId=%hu, task_id=%hu",
                type, taskInfo->stream->Device_()->Id_(), phSqe->u.modelMaintainceInfo.streamId,
                phSqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
    }
    return;
}

#endif

static bool ModelMaintainceTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = &ToCommandBodyForModelMaintainceTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForModelMaintainceTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForModelMaintainceTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto &chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MODEL_MAINTAINCE, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MODEL_MAINTAINCE, &ConstructDavidSqeForModelMaintainceTask);
    return true;
}

static bool g_modelMaintainceTaskRegister = ModelMaintainceTaskRegister();

}  // namespace runtime
}  // namespace cce
