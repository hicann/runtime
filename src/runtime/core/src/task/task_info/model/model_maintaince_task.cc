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
#include "runtime_task_manager.h"
#include "task_info.hpp"
#include "model_maintaince_task.h"
#include "capture_model_enum_desc.hpp"
#include "securec.h"

namespace cce {
namespace runtime {

namespace {
const char_t* ModelMaintainceTypeToString(const MmtType type)
{
    switch (type) {
        case MMT_STREAM_ADD:
            return "MMT_STREAM_ADD(0)";
        case MMT_STREAM_DEL:
            return "MMT_STREAM_DEL(1)";
        case MMT_MODEL_LOAD_COMPLETE:
            return "MMT_MODEL_LOAD_COMPLETE(2)";
        case MMT_MODEL_DESTROY:
            return "MMT_MODEL_DESTROY(3)";
        case MMT_MODEL_PRE_PROC:
            return "MMT_MODEL_PRE_PROC(4)";
        case MMT_STREAM_LOAD_COMPLETE:
            return "MMT_STREAM_LOAD_COMPLETE(5)";
        case MMT_MODEL_ABORT:
            return "MMT_MODEL_ABORT(6)";
        case MMT_RESERVED:
            return "MMT_RESERVED(7)";
        default:
            break;
    }
    static thread_local char_t enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1U, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char_t* ModelStreamTypeToString(const uint32_t type)
{
    switch (type) {
        case static_cast<uint32_t>(RT_MODEL_HEAD_STREAM):
            return "MODEL_HEAD_STREAM(0)";
        case static_cast<uint32_t>(RT_MODEL_WAIT_ACTIVE_STREAM):
            return "MODEL_WAIT_ACTIVE_STREAM(1)";
        default:
            break;
    }
    static thread_local char_t enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1U, "UNKNOWN(%u)", type);
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}
} // namespace

#if F_DESC("ModelMaintainceTask")
uint16_t GetRootExeStreamId(const Model* const mdl)
{
    if ((mdl == nullptr) || (mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL)) {
        return UINT16_MAX;
    }

    auto* captureModel = dynamic_cast<const CaptureModel*>(mdl);
    if (captureModel == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "dynamic_cast to CaptureModel failed, model_type=%s, model_id=%u.",
            ModelTypeToString(mdl->GetModelType()).c_str(), mdl->Id_());
        return UINT16_MAX;
    }

    return captureModel->GetRootExeStreamId();
}

rtError_t ModelMaintainceTaskInit(
    TaskInfo* const taskInfo, const MmtType mType, Model* const modelPtr, Stream* const opStreamPtr,
    const rtModelStreamType_t modelStreamType, const uint32_t firstTaskIndex)
{
    ModelMaintainceTaskInfo* modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    TaskCommonInfoInit(taskInfo);
    Device* const dev = taskInfo->stream->Device_();
    Driver* const driver = dev->Driver_();

    taskInfo->type = TS_TASK_TYPE_MODEL_MAINTAINCE;
    taskInfo->typeName = "MODEL_MAINTAINCE";

    modelMaintainceTaskInfo->type = mType;
    modelMaintainceTaskInfo->opStream = opStreamPtr;
    modelMaintainceTaskInfo->model = modelPtr;
    modelMaintainceTaskInfo->streamType = modelStreamType;
    modelMaintainceTaskInfo->firstTaskId = firstTaskIndex;
    modelMaintainceTaskInfo->execTimesSvmOffset = 0x0U;

    if ((mType == MMT_STREAM_ADD) && (Runtime::Instance()->ChipIsHaveStars())) {
        uint16_t* const execTimesSvm = modelMaintainceTaskInfo->opStream->GetExecutedTimesSvm();
        rtError_t error = RT_ERROR_NONE;
        if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_MAINTAINCE_WITH_VA)) {
            modelMaintainceTaskInfo->execTimesSvmOffset = RtPtrToValue(execTimesSvm);
        } else {
            error = driver->MemAddressTranslate(
                static_cast<int32_t>(modelMaintainceTaskInfo->opStream->Device_()->Id_()), RtPtrToValue(execTimesSvm),
                &(modelMaintainceTaskInfo->execTimesSvmOffset));
        }
        return error;
    }
    return RT_ERROR_NONE;
}

void ToCommandBodyForModelMaintainceTask(TaskInfo* const taskInfo, rtCommand_t* const command)
{
    ModelMaintainceTaskInfo* modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);

    command->u.modelMaintainceTack.modelId = static_cast<uint16_t>(modelMaintainceTaskInfo->model->Id_());
    command->u.modelMaintainceTack.stream_id = static_cast<uint16_t>(modelMaintainceTaskInfo->opStream->Id_());
    command->u.modelMaintainceTack.operation = modelMaintainceTaskInfo->type;
    command->u.modelMaintainceTack.stream_type = static_cast<uint16_t>(modelMaintainceTaskInfo->streamType);
    command->u.modelMaintainceTack.first_task_id = static_cast<uint16_t>(modelMaintainceTaskInfo->firstTaskId);
    if (modelMaintainceTaskInfo->type == MMT_STREAM_ADD) {
        modelMaintainceTaskInfo->opStream->SetBindFlag(true);
        taskInfo->bindFlag = false; // set unbind flag for bind task in mini;
        RT_LOG(
            RT_LOG_INFO, "set bind flag true, model_id=%u, stream_id=%u.",
            static_cast<uint32_t>(command->u.modelMaintainceTack.modelId),
            static_cast<uint32_t>(command->u.modelMaintainceTack.stream_id));
    } else if (modelMaintainceTaskInfo->type == MMT_STREAM_DEL) {
        modelMaintainceTaskInfo->opStream->SetBindFlag(false);
        RT_LOG(
            RT_LOG_INFO, "set bind flag false, model_id=%u, stream_id=%u.",
            static_cast<uint32_t>(command->u.modelMaintainceTack.modelId),
            static_cast<uint32_t>(command->u.modelMaintainceTack.stream_id));
    } else {
        // no operation
    }
}

uint32_t GetEndGraphNotifyId(Model* mdl)
{
    if (mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        return mdl->GetEndGraphNotify()->GetNotifyId();
    }

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    if (captureModel->IsSubCaptureModel()) {
        return captureModel->GetLoadCompleteNotifyid();
    }

    return mdl->GetEndGraphNotify()->GetNotifyId();
}

void PrintErrorInfoForModelMaintainceTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    ModelMaintainceTaskInfo* modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    Stream* const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    RT_LOG(
        RT_LOG_ERROR, "model maintaince execute failed device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu.", devId,
        streamId, taskId, taskInfo->flipNum);
    const uint32_t modelId = (modelMaintainceTaskInfo->model != nullptr) ? modelMaintainceTaskInfo->model->Id_() :
                                                                           static_cast<uint32_t>(UINT16_MAX);
    RT_LOG(
        RT_LOG_ERROR, "model_id=%u, operation_type=%s, stream_type=%s, op_stream_id=%u.", modelId,
        ModelMaintainceTypeToString(modelMaintainceTaskInfo->type),
        ModelStreamTypeToString(modelMaintainceTaskInfo->streamType), modelMaintainceTaskInfo->opStream->Id_());
}

void DoCompleteSuccessForModelMaintainceTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    Stream* const stream = taskInfo->stream;
    const uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        RT_LOG(
            RT_LOG_ERROR, "Model maintaince process error, retCode=%#x, [%s].", errorCode, GetTsErrCodeDesc(errorCode));
        stream->SetErrCode(errorCode);
        PrintErrorInfoForModelMaintainceTask(taskInfo, devId);
        TaskFailCallBack(
            static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id), taskInfo->tid, errorCode,
            stream->Device_());
    }
}

uint32_t GetCaptureModelExecutorType(const ModelMaintainceTaskInfo* const maintainceTaskInfo)
{
    if (maintainceTaskInfo->model->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        return MODEL_EXECUTOR_RESERVED;
    }

    return MODEL_EXECUTOR_CAPTURE;
}

#endif

} // namespace runtime
} // namespace cce