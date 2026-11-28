/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_log.hpp"
#include "stars/stars_base.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "stars_david.hpp"
#include "david_sqe_adapter.hpp"
#include "model_to_aicpu_task.h"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

static void FillModelOperateUserData(
    DavidStarsAicpuUserData* const usrData, const ModelToAicpuTaskInfo* const modelTask, const Stream* const stm)
{
    usrData->pid = 0U;
    usrData->cmdType = static_cast<uint8_t>(TS_AICPU_MODEL_OPERATE);
    usrData->vfId = 0U;
    usrData->tid = 0U;
    usrData->tsId = 0U;
    usrData->u.modelOperate.streamId = static_cast<uint16_t>(stm->Id_());
    usrData->u.modelOperate.cmdType = static_cast<uint8_t>(modelTask->cmdType);
    usrData->u.modelOperate.modelId = static_cast<uint16_t>(modelTask->modelId);
    usrData->u.modelOperate.modelInfoAddrLow = static_cast<uint32_t>(modelTask->modelArgPtr);
    usrData->u.modelOperate.modelInfoAddrHigh = static_cast<uint16_t>(modelTask->modelArgPtr >> UINT32_BIT_NUM);
}

static void ConstructDavidSqeForModelToAicpuTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe* const aicpuCtrlSqe = &(davidSqe->aicpuControlSqe);
    Stream* const stm = taskInfo->stream;
    aicpuCtrlSqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    aicpuCtrlSqe->header.blockDim = 1U;

    aicpuCtrlSqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    aicpuCtrlSqe->batchMode = 0U;
    aicpuCtrlSqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(aicpuCtrlSqe);

    aicpuCtrlSqe->qos = stm->Device_()->GetTsdQos();
    aicpuCtrlSqe->res2 = 0U;
    aicpuCtrlSqe->sqeIndex = 0U; // useless
    aicpuCtrlSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    aicpuCtrlSqe->sqeLength = 0U;

    FillModelOperateUserData(&(aicpuCtrlSqe->usrData), &(taskInfo->u.modelToAicpuTask), stm);

    aicpuCtrlSqe->subTopicId = 0U;
    aicpuCtrlSqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    aicpuCtrlSqe->groupId = 0U;
    aicpuCtrlSqe->usrDataLen = 24U;

    aicpuCtrlSqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "ModelToAicpuTask");
    RT_LOG(
        RT_LOG_INFO,
        "ModelToAicpuTask, topic_type=" RT_ENUM_LOG_FORMAT("%u") ", cmd_type=" RT_ENUM_LOG_FORMAT(
            "%u") ", device_id=%u,stream_id=%d, task_id=%hu, task_sn=%u.",
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(aicpuCtrlSqe->topicType), RtTopicTypeToString(aicpuCtrlSqe->topicType)),
        RT_ENUM_LOG_VALUE(
            taskInfo->u.modelToAicpuTask.cmdType, TsAicpuModelCmdToString(taskInfo->u.modelToAicpuTask.cmdType)),
        taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}

static bool ModelToAicpuTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = &ToCmdBodyForModelToAicpuTask,
        .toSqeFunc = &ConstructDavidSqeForModelToAicpuTask,
        .doCompleteSuccFunc = &DoCompleteSuccForModelToAicpuTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForModelToAicpuTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForModelToAicpuTask,
    };

    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MODEL_TO_AICPU, funcs);
    }
    return true;
}

static bool g_modelToAicpuTaskRegister = ModelToAicpuTaskRegister();

} // namespace runtime
} // namespace cce
