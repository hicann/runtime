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

void ModelExecuteTaskProcErrorForSoftwareSq(TaskInfo* const taskInfo, const uint32_t errCode)
{
    rtStarsCqeSwStatus_t swStatus = {};
    swStatus.value = errCode;
    ModelExecuteTaskInfo* modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);

    if (swStatus.modelExecEx.result == static_cast<uint16_t>(TS_STARS_MODEL_STREAM_EXE_FAILED)) {
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    } else if (swStatus.modelExecEx.result == static_cast<uint16_t>(TS_STARS_MODEL_END_OF_SEQ)) {
        taskInfo->errorCode = TS_ERROR_END_OF_SEQUENCE;
    } else if (swStatus.modelExecEx.result == static_cast<uint16_t>(TS_STARS_MODEL_EXE_ABORT)) {
        taskInfo->errorCode = TS_ERROR_MODEL_ABORTED;
    } else if (swStatus.modelExecEx.result == static_cast<uint16_t>(TS_STARS_MODEL_AICPU_TIMEOUT)) {
        taskInfo->errorCode = TS_ERROR_AICPU_TIMEOUT;
    } else {
        // others model exe rsult does not support, default stream exe failed
        taskInfo->errorCode = TS_MODEL_STREAM_EXE_FAILED;
    }

    modelExecuteTaskInfo->errorTaskId = swStatus.modelExecEx.taskId;
    modelExecuteTaskInfo->errorStreamId = modelExecuteTaskInfo->model->GetStreamIdBySqId(swStatus.modelExecEx.sqId);
    if ((modelExecuteTaskInfo->errorStreamId == UINT32_MAX) && (modelExecuteTaskInfo->model != nullptr) &&
        (modelExecuteTaskInfo->model->GetModelType() == RT_MODEL_CAPTURE_MODEL)) {
        CaptureModel* captureModel = dynamic_cast<CaptureModel*>(modelExecuteTaskInfo->model);
        modelExecuteTaskInfo->errorStreamId = FindStreamIdInSubModels(captureModel, swStatus.modelExecEx.sqId);
    }
    RT_LOG(
        RT_LOG_WARNING, "errorCode=0x%x, errorTaskId=%u, errorStreamId=%u, sqId=%hu.", taskInfo->errorCode,
        modelExecuteTaskInfo->errorTaskId, modelExecuteTaskInfo->errorStreamId, swStatus.modelExecEx.sqId);
}

void ReportErrorInfoForModelTask(TaskInfo* const faultTaskPtr)
{
    Stream* const stream = faultTaskPtr->stream;
    uint32_t errorCode = faultTaskPtr->errorCode;
    const uint32_t devId = stream->Device_()->Id_();

    if ((errorCode != TS_ERROR_END_OF_SEQUENCE) && (errorCode != TS_MODEL_ABORT_NORMAL) &&
        (errorCode != TS_ERROR_MODEL_ABORTED) && (errorCode != TS_ERROR_AICPU_TIMEOUT)) {
        errorCode = TS_MODEL_STREAM_EXE_FAILED;
    }

    if (IsMemErrorCode(static_cast<int32_t>(faultTaskPtr->mte_error))) {
        stream->SetErrCode(static_cast<uint32_t>(faultTaskPtr->mte_error));
        faultTaskPtr->mte_error = 0U;
    } else {
        stream->SetErrCode(errorCode);
    }

    if ((errorCode == TS_ERROR_END_OF_SEQUENCE) || (errorCode == TS_MODEL_ABORT_NORMAL) ||
        (errorCode == TS_ERROR_MODEL_ABORTED)) {
        return;
    }
    rtError_t rtErrCode = RT_ERROR_TSFW_RESERVED;
    RT_LOG(
        RT_LOG_ERROR, "model task execute failed, retCode=%#x, [%s].", errorCode,
        GetTsErrCodeMap(errorCode, &rtErrCode));

    bool isSubModel = false;
    uint32_t modelId = MAX_UINT32_NUM;
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(faultTaskPtr->stream->Model_());
    if (captureModel != nullptr) {
        modelId = captureModel->Id_();
        isSubModel = captureModel->IsSubCaptureModel();
        CaptureModel* rootModel = captureModel->GetRootModel();
        if (rootModel != nullptr) {
            rootModel->SetExecuteExceptionFlagForAllModels(true);
        }
    }
    RT_LOG(
        RT_LOG_ERROR,
        "Real fault task, device_id=%u, model_id=%u, is_sub_model=%d, "
        "stream_id=%d, task_id=%hu, type=%d[%s].",
        devId, modelId, isSubModel, faultTaskPtr->stream->Id_(), faultTaskPtr->id, faultTaskPtr->type,
        faultTaskPtr->typeName);

    if (unlikely(faultTaskPtr->type == TS_TASK_TYPE_FFTS_PLUS)) {
        PrintErrorInfo(faultTaskPtr, devId);
        return;
    }

    PrintErrorInfo(faultTaskPtr, devId);
    TaskFailCallBack(
        static_cast<uint32_t>(faultTaskPtr->stream->Id_()), faultTaskPtr->id, faultTaskPtr->tid, errorCode,
        stream->Device_(), true);
    return;
}

void ProcErrorInfoForModelTask(const rtCqReport_t& logicCq, const bool isExceptionFlag, TaskInfo* reportTask)
{
    Stream* const stm = reportTask->stream;
    Device* const dev = stm->Device_();

    // Set error device status
    if (dev->GetHasTaskError()) {
        dev->SetMonitorExitFlag(true);
        Runtime::Instance()->SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_ABNORMAL);
    }

    Runtime::Instance()->SetInternalThreadContext(stm->Context_());
    SetStarsResult(reportTask, logicCq);
    ReportErrorInfoForModelTask(reportTask);
    stm->SetNeedRecvCqeFlag(true);
    if (isExceptionFlag) {
        stm->EnterFailureAbort();
        stm->SetNeedRecvCqeFlag(false);
    }

    // Set monitor device status normal to get next error
    if (dev->GetHasTaskError()) {
        dev->SetHasTaskError(false);
        dev->SetMonitorExitFlag(false);
    }
    return;
}

} // namespace runtime
} // namespace cce