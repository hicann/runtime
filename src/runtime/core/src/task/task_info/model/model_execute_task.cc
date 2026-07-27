/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stream.hpp"
#include "context.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "stars_cond_isa_helper.hpp"
#include "device/device_error_proc.hpp"
#include "model.hpp"
#include "error_code.h"
#include "error_message_manage.hpp"
#include "task_info.hpp"
#include "model_execute_task.h"
#include "stub_task.hpp"
#include "capture_model_utils.hpp"
#include "capture_model.hpp"

namespace cce {
namespace runtime {

namespace {
const std::set<int32_t> MEM_ERROR_CODE = {TS_ERROR_AICORE_MTE_ERROR,  TS_ERROR_SDMA_LINK_ERROR,
                                          TS_ERROR_SDMA_POISON_ERROR, TS_ERROR_LINK_ERROR,
                                          TS_ERROR_LOCAL_MEM_ERROR,   TS_ERROR_REMOTE_MEM_ERROR};
} // namespace
// 针对model exe性能优化需求，host侧和device侧内存释放挪到model粒度释放
static rtError_t FreeFuncCallMemForModelExecuteTask(const TaskInfo* const taskInfo)
{
    UNUSED(taskInfo);
    return RT_ERROR_NONE;
}

void ModelExecuteTaskUnInit(TaskInfo* const taskInfo) { (void)FreeFuncCallMemForModelExecuteTask(taskInfo); }

rtError_t ModelExecuteTaskInit(
    TaskInfo* const taskInfo, Model* const modelPtr, const uint32_t modelIndex, const uint32_t firstTaskIndex)
{
    if (modelPtr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Failed to init ModelExecuteTask, modelPtr null.");
        return RT_ERROR_MODEL_NULL;
    }

    ModelExecuteTaskInfo* modelExecTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MODEL_EXECUTE;
    taskInfo->typeName = "MODEL_EXECUTE";
    modelExecTaskInfo->modelId = modelIndex;
    modelExecTaskInfo->firstTaskId = firstTaskIndex;
    modelExecTaskInfo->model = modelPtr;
    modelExecTaskInfo->errorTaskId = 0U;
    modelExecTaskInfo->errorStreamId = 0U;

    return PrepareSqeInfoForModelExecuteTask(taskInfo);
}

void SetStarsResultForModelExecuteTask(TaskInfo* const taskInfo, const rtLogicCqReport_t& logicCq)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if ((logicCq.errorType & static_cast<uint8_t>(RT_STARS_EXIST_ERROR)) != 0U) {
        const uint32_t starsDefineErrorCode = logicCq.errorCode;
        if ((starsDefineErrorCode & static_cast<uint32_t>(RT_STARS_CQE_ERR_TYPE_EXCEPTION)) != 0U) {
            taskInfo->errorCode = TS_ERROR_ILLEGAL_PARAM;
            RT_LOG(
                RT_LOG_ERROR, "model status is busy when execute, model_id=%u, stream_id=%hu, task_id=%hu",
                modelExecuteTaskInfo->modelId, taskInfo->stream->Id_(), taskInfo->id);
            return;
        }
        if (logicCq.errorType == 0x4U) {
            taskInfo->errorCode = TS_ERROR_TASK_TIMEOUT;
            RT_LOG(
                RT_LOG_ERROR, "ModelExecuteTask timeout, model_id=%u, stream_id=%hu, task_id=%hu",
                modelExecuteTaskInfo->modelId, taskInfo->stream->Id_(), taskInfo->id);
            return;
        }

        if (logicCq.errorCode == 0) {
            taskInfo->errorCode = TS_ERROR_ILLEGAL_PARAM;
            RT_LOG(
                RT_LOG_ERROR, "ModelExecuteTask goto error instr, model_id=%u, stream_id=%hu, task_id=%hu",
                modelExecuteTaskInfo->modelId, taskInfo->stream->Id_(), taskInfo->id);
        }
    }
    return;
}

void ToCommandBodyForModelExecuteTask(TaskInfo* const taskInfo, rtCommand_t* const command)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream* const stream = taskInfo->stream;

    command->u.modelExecuteTask.model_id = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);
    command->u.modelExecuteTask.first_task_id = static_cast<uint16_t>(modelExecuteTaskInfo->firstTaskId);
    command->u.modelExecuteTask.asid = static_cast<uint16_t>((stream->Device_()->GetTTBR_()) >> 48U); // shift 48 bit
    command->u.modelExecuteTask.asid_baddr =
        static_cast<uint64_t>((stream->Device_()->GetTTBR_()) & (0x0000FFFFFFFFFFFFU));
    command->u.modelExecuteTask.SMMU_subStreamID = static_cast<uint16_t>(stream->Device_()->GetSSID_());
    RT_LOG(
        RT_LOG_DEBUG, "ModelExecute SMMU_subStreamID=%u",
        static_cast<uint32_t>(command->u.modelExecuteTask.SMMU_subStreamID));
    command->u.modelExecuteTask.tcr = stream->Device_()->GetTCR_();
    command->u.modelExecuteTask.sch_group_id = modelExecuteTaskInfo->model->GetSchGroupId();
}

void PrintErrorInfoForModelExecuteTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream* const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    if (stream->Device_()->IsStarsPlatform()) {
        uint64_t dfx[8U];
        (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(
            dfx, sizeof(dfx), modelExecuteTaskInfo->model->GetDfxPtr(), sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
        RT_LOG(
            RT_LOG_ERROR, "stream_id=%u, task_id=%u, sqVirtualAddr=%" PRIu64 ", head equal tail flag=%" PRIu64 ".",
            streamId, taskId, dfx[0U], dfx[1U]);

        PrintErrorModelExecuteTaskFuncCall(taskInfo);
    }

    RT_LOG(
        RT_LOG_ERROR,
        "model execute task failed, device_id=%u, model stream_id=%d, model task_id=%u, flip_num=%hu, "
        "model_id=%u, first_task_id=%u",
        devId, streamId, taskId, taskInfo->flipNum, modelExecuteTaskInfo->modelId, modelExecuteTaskInfo->firstTaskId);
}

TaskInfo* GetRealReportFaultTaskForModelExecuteTask(TaskInfo* const taskInfo)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream* const stream = taskInfo->stream;

    Device* const dev = stream->Device_();

    TaskInfo* taskPtr = GetTaskInfo(dev, modelExecuteTaskInfo->errorStreamId, modelExecuteTaskInfo->errorTaskId, true);
    return taskPtr;
}

void ReportErrorInfoForModelExecuteTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream* const stream = taskInfo->stream;
    const uint32_t errorCode = taskInfo->errorCode;

    if ((errorCode == TS_ERROR_END_OF_SEQUENCE) || (errorCode == TS_MODEL_ABORT_NORMAL) ||
        (errorCode == TS_ERROR_MODEL_ABORTED)) {
        return;
    }
    rtError_t rtErrCode = RT_ERROR_TSFW_RESERVED;
    RT_LOG(RT_LOG_ERROR, "model execute error, retCode=%#x, [%s].", errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
    PrintErrorInfo(taskInfo, devId);

    TaskInfo* taskPtr = GetRealReportFaultTaskForModelExecuteTask(taskInfo);

    COND_RETURN_VOID(
        taskPtr == nullptr, "Can not find task_id=%u of stream_id=%u!", modelExecuteTaskInfo->errorTaskId,
        modelExecuteTaskInfo->errorStreamId);
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(taskPtr->stream->Model_());
    uint32_t subModelId = MAX_UINT32_NUM;
    if ((captureModel != nullptr) && captureModel->IsSubCaptureModel()) {
        subModelId = captureModel->Id_();
    }
    RT_LOG(
        RT_LOG_ERROR, "Real fault task, device_id=%u, sub_model_id=%u, stream_id=%d, task_id=%hu, type=%d[%s].",
        taskPtr->stream->Device_()->Id_(), subModelId, taskPtr->stream->Id_(), taskPtr->id, taskPtr->type,
        taskPtr->typeName);

    if (unlikely(taskPtr->type == TS_TASK_TYPE_FFTS_PLUS)) {
        taskPtr->errorCode = errorCode;
        PrintErrorInfo(taskPtr, devId);
        return;
    }

    taskPtr->errorCode = errorCode;
    PrintErrorInfo(taskPtr, devId);
    // if lost socket, set error code for GE handle this error
    if (unlikely((taskPtr->drvErr == static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE))) ||
        (taskInfo->drvErr == static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE))) {
        RT_LOG(
            RT_LOG_ERROR,
            "Set stream drv error, error stream_id=%u, task_id=%u, model stream_id=%d, task_id=%hu, "
            "task driver error=%#x, ModelExecuteTask driver error=%#x.",
            modelExecuteTaskInfo->errorStreamId, modelExecuteTaskInfo->errorTaskId,
            static_cast<uint32_t>(stream->Id_()), taskInfo->id, taskPtr->drvErr, taskInfo->drvErr);
        stream->SetDrvErr(static_cast<uint32_t>(RT_ERROR_SOCKET_CLOSE));
    }
    TaskFailCallBack(
        modelExecuteTaskInfo->errorStreamId, modelExecuteTaskInfo->errorTaskId, taskInfo->tid, errorCode,
        stream->Device_(), true);
}

void DoCompleteSuccessForModelExecuteTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream* const stream = taskInfo->stream;
    uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        TaskInfo* errTaskPtr = GetRealReportFaultTaskForModelExecuteTask(taskInfo);
        if (errTaskPtr != nullptr) {
            if (MEM_ERROR_CODE.find(errTaskPtr->mte_error) != MEM_ERROR_CODE.end()) {
                errorCode = static_cast<int32_t>(errTaskPtr->mte_error);
                errTaskPtr->mte_error = 0U;
            }
        }
        stream->SetErrCode(errorCode);
        ReportErrorInfoForModelExecuteTask(taskInfo, devId);
    }
    if ((!Runtime::Instance()->GetDisableThread()) && (modelExecuteTaskInfo->model != nullptr)) {
        modelExecuteTaskInfo->model->ExecuteComplete();
    }
}

void ModelExecuteTaskaProcError(TaskInfo* const taskInfo, const uint32_t errCode)
{
    rtStarsCqeSwStatus_t swStatus = {};
    swStatus.value = errCode;
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_STREAM_EXE_FAILED)) {
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    } else if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_END_OF_SEQ)) {
        taskInfo->errorCode = TS_ERROR_END_OF_SEQUENCE;
    } else if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_EXE_ABORT)) {
        taskInfo->errorCode = TS_ERROR_MODEL_ABORTED;
    } else if (swStatus.model_exec.result == static_cast<uint16_t>(TS_STARS_MODEL_AICPU_TIMEOUT)) {
        taskInfo->errorCode = TS_ERROR_AICPU_TIMEOUT;
    } else {
        // others model exe rsult does not support, default stream exe failed
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    }

    modelExecuteTaskInfo->errorTaskId = swStatus.model_exec.task_id;
    modelExecuteTaskInfo->errorStreamId = swStatus.model_exec.stream_id;
    RT_LOG(
        RT_LOG_WARNING, "errorCode=0x%x, errorTaskId=%u, errorStreamId=%u.", taskInfo->errorCode,
        modelExecuteTaskInfo->errorTaskId, modelExecuteTaskInfo->errorStreamId);
}

void ModelExecuteTaskProcErrorForSoftwareSq(TaskInfo* const taskInfo, const uint32_t errCode)
{
    rtStarsCqeSwStatus_t swStatus = {};
    swStatus.value = errCode;
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_STREAM_EXE_FAILED)) {
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    } else if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_END_OF_SEQ)) {
        taskInfo->errorCode = TS_ERROR_END_OF_SEQUENCE;
    } else if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_EXE_ABORT)) {
        taskInfo->errorCode = TS_ERROR_MODEL_ABORTED;
    } else if (swStatus.model_exec_ex.result == static_cast<uint16_t>(TS_STARS_MODEL_AICPU_TIMEOUT)) {
        taskInfo->errorCode = TS_ERROR_AICPU_TIMEOUT;
    } else {
        // others model exe rsult does not support, default stream exe failed
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    }

    modelExecuteTaskInfo->errorTaskId = swStatus.model_exec_ex.task_id;
    modelExecuteTaskInfo->errorStreamId = modelExecuteTaskInfo->model->GetStreamIdBySqId(swStatus.model_exec_ex.sq_id);
    if ((modelExecuteTaskInfo->errorStreamId == UINT32_MAX) && (modelExecuteTaskInfo->model != nullptr) &&
        (modelExecuteTaskInfo->model->GetModelType() == RT_MODEL_CAPTURE_MODEL)) {
        CaptureModel* captureModel = dynamic_cast<CaptureModel*>(modelExecuteTaskInfo->model);
        modelExecuteTaskInfo->errorStreamId = FindStreamIdInSubModels(captureModel, swStatus.model_exec_ex.sq_id);
    }
    RT_LOG(
        RT_LOG_WARNING, "errorCode=0x%x, errorTaskId=%u, errorStreamId=%u, sqId=%hu.", taskInfo->errorCode,
        modelExecuteTaskInfo->errorTaskId, modelExecuteTaskInfo->errorStreamId, swStatus.model_exec_ex.sq_id);
}

void DoCompleteStarsErrorForModelExecuteTask(TaskInfo* const taskInfo, const uint32_t devId, const uint32_t errCode)
{
    /* 71 and 81 support */
    Device* const dev = taskInfo->stream->Device_();
    if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE)) &&
        (dev->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE))) {
        ModelExecuteTaskProcErrorForSoftwareSq(taskInfo, errCode);
    } else {
        ModelExecuteTaskaProcError(taskInfo, errCode);
    }
    DoCompleteSuccessForModelExecuteTask(taskInfo, devId);
}

rtError_t WaitExecFinishForModelExecuteTask(const TaskInfo* const taskInfo)
{
    Stream* const stream = taskInfo->stream;
    rtError_t error = RT_ERROR_NONE;
    if (!(stream->IsPendingListEmpty(RT_HOST_TASK_TYPE_MEMCPY))) {
        error = stream->ExecPendingList(RT_HOST_TASK_TYPE_MEMCPY);
    }
    return error;
}

bool ModelIsExistInContext(const Model* mdl, const Stream* stream)
{
    if (stream != nullptr && stream->Context_() != nullptr) {
        Context* context = stream->Context_();
        return context->ModelIsExistInContext(mdl);
    }
    return false;
}

void ReportModelEndGraphErrorForNotifyWaitTask(TaskInfo* taskInfo, const uint32_t devId)
{
    if (!Runtime::Instance()->ChipIsHaveStars()) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "Report model endGraph errcode=0x%x.", taskInfo->errorCode);
    Model* mdl = taskInfo->u.notifywaitTask.u.notify->GetEndGraphModel();
    if (!ModelIsExistInContext(mdl, taskInfo->stream)) {
        RT_LOG(RT_LOG_ERROR, "this model is not in current context.");
        return;
    }

    TaskInfo mdlExecTsk = {};
    InitByStream(&mdlExecTsk, taskInfo->stream);
    /* In stars, modelExecute task is always followed by an endgraph task, modelExecuteTaskId = endgraphTaskId - 1 */
    mdlExecTsk.id = taskInfo->id - 1U;
    mdlExecTsk.tid = taskInfo->tid;
    RT_LOG(
        RT_LOG_INFO, "stream_id=%d, task_id=%hu, model_id=%u, tid=%u", mdlExecTsk.stream->Id_(), mdlExecTsk.id,
        mdl->Id_(), mdlExecTsk.tid);

    (void)ModelExecuteTaskInit(&mdlExecTsk, mdl, mdl->Id_(), 0U);
    (void)DoCompleteStarsErrorForModelExecuteTask(&mdlExecTsk, devId, taskInfo->errorCode);
    ModelExecuteTaskUnInit(&mdlExecTsk);
}

} // namespace runtime
} // namespace cce
