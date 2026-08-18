/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "model_serial_sched_task.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"
#include "task_david.hpp"
#include "stars_david.hpp"
#include "dqs_c.hpp"
#include "stream.hpp"
#include "model.hpp"
#include "notify.hpp"
#include "model_c.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t RT_MODEL_SERIAL_SCHED_PRE_PROC_MAGIC = 0x5A5AU;
constexpr uint32_t RT_MODEL_SERIAL_SCHED_POST_PROC_MAGIC = 0x6A6AU;

enum class ModelSerialSchedSubType : uint32_t {
    kPreProc = 1U,
    kPostProc = 2U,
};

enum class ModelSerialSchedError : uint32_t {
    kNone = 0U,
    kMagicError,
    kPriorityError,
    kGroupIdError,
    kSubtypeError,
    kDuplicateError,
    kMessageError,
    kExhaustedError,
    kRunawayError,
    kMismatchError,
    kInvalidParamError,
    kEmptyError,
    kInitError,
    kPopError,
    kSqidError,
    kNotifyIdError,
};

static const std::map<uint32_t, std::string> g_modelSerialSchedErrorMapInfo = {
    {static_cast<uint32_t>(ModelSerialSchedError::kNone), "success"},
    {static_cast<uint32_t>(ModelSerialSchedError::kMagicError), "magic number error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kPriorityError), "model priority error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kGroupIdError), "group id error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kSubtypeError), "subtype error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kDuplicateError), "duplicate error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kMessageError), "message error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kExhaustedError), "exhausted error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kRunawayError), "runaway error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kMismatchError), "mismatch error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kInvalidParamError), "invalid param error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kEmptyError), "empty error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kInitError), "init error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kPopError), "pop error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kSqidError), "sq_id error"},
    {static_cast<uint32_t>(ModelSerialSchedError::kNotifyIdError), "notify_id error"},
};

using ModelSerialSchedTaskInitFunc = rtError_t (*)(TaskInfo*, ModelSerialSchedTaskParam*);
struct ModelSerialSchedTaskInitInfo {
    const char_t* taskDesc;
    ModelSerialSchedTaskInitFunc taskInitFunc;
};

static rtError_t InitModelSerialSchedTaskCommon(
    TaskInfo* taskInfo, ModelSerialSchedTaskParam* param, tsTaskType_t taskType, const char* typeName)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = taskType;
    taskInfo->typeName = typeName;

    ModelSerialSchedTaskInfo* modelTask = &(taskInfo->u.modelSerialSchedTask);
    modelTask->exeSqId = param->stream->GetSqId();
    modelTask->groupId = param->stream->GetGroupId();
    modelTask->modelId = param->model->Id_();

    const auto& headStmList = param->model->GetHeadStreamList_();
    COND_RETURN_ERROR_MSG_INNER(
        headStmList.empty(), RT_ERROR_INVALID_VALUE, "Empty head stream list for model %u", modelTask->modelId);
    modelTask->modelPriority = headStmList.front()->GetPriority();
    modelTask->sqId = headStmList.front()->GetSqId();

    modelTask->notifyId = param->notify->GetNotifyId();
    rtError_t ret = param->stream->Device_()->Driver_()->DeviceGetBareTgid(&modelTask->pid);
    COND_RETURN_ERROR_MSG_INNER(
        ret != RT_ERROR_NONE, ret, "DeviceGetBareTgid failed, ret=%#x.", static_cast<uint32_t>(ret));
    return RT_ERROR_NONE;
}

static rtError_t ModelSerialSchedPreProcTaskInit(TaskInfo* taskInfo, ModelSerialSchedTaskParam* param)
{
    return InitModelSerialSchedTaskCommon(
        taskInfo, param, TS_TASK_TYPE_MODEL_SERIAL_SCHED_PREPROC, "MODEL_SERIAL_SCHED_PRE_PROC_TASK");
}

static rtError_t ModelSerialSchedPostProcTaskInit(TaskInfo* taskInfo, ModelSerialSchedTaskParam* param)
{
    return InitModelSerialSchedTaskCommon(
        taskInfo, param, TS_TASK_TYPE_MODEL_SERIAL_SCHED_POSTPROC, "MODEL_SERIAL_SCHED_POST_PROC_TASK");
}

static rtError_t ModelSerialSchedNotifyWaitTaskInit(TaskInfo* taskInfo, ModelSerialSchedTaskParam* param)
{
    return InitModelSerialSchedTaskCommon(
        taskInfo, param, TS_TASK_TYPE_MODEL_SERIAL_SCHED_NOTIFY_WAIT, "MODEL_SERIAL_SCHED_NOTIFY_WAIT_TASK");
}

static const std::map<tsTaskType_t, ModelSerialSchedTaskInitInfo> MODEL_SERIAL_SCHED_TASK_INIT_FUNC_MAP = {
    {TS_TASK_TYPE_MODEL_SERIAL_SCHED_PREPROC, {"model serial sched pre proc task", &ModelSerialSchedPreProcTaskInit}},
    {TS_TASK_TYPE_MODEL_SERIAL_SCHED_NOTIFY_WAIT,
     {"model serial sched notify wait task", &ModelSerialSchedNotifyWaitTaskInit}},
    {TS_TASK_TYPE_MODEL_SERIAL_SCHED_POSTPROC,
     {"model serial sched post proc task", &ModelSerialSchedPostProcTaskInit}},
};

rtError_t LaunchModelSerialSchedTaskByType(Stream* const stm, const tsTaskType_t type, ModelSerialSchedTaskParam* param)
{
    const auto iter = MODEL_SERIAL_SCHED_TASK_INIT_FUNC_MAP.find(type);
    COND_RETURN_ERROR_MSG_INNER(
        iter == MODEL_SERIAL_SCHED_TASK_INIT_FUNC_MAP.end(), RT_ERROR_INVALID_VALUE, "type[%d] is invalid",
        static_cast<int32_t>(type));

    const ModelSerialSchedTaskInitInfo* taskInitInfo = &(iter->second);
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "[%s], streamId=%d.", taskInitInfo->taskDesc, streamId);

    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check if task can be sent, streamId=%d, retCode=%#x.", streamId,
        static_cast<uint32_t>(error));

    uint32_t pos = RT_DEFAULT_POS;
    stm->StreamLock();
    TaskInfo* task = nullptr;
    error = AllocTaskInfo(&task, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "streamId=%d alloc [%s] failed, retCode=%#x.", streamId,
                                                           taskInitInfo->taskDesc, static_cast<uint32_t>(error));

    SaveTaskCommonInfo(task, stm, pos);
    error = taskInitInfo->taskInitFunc(task, param);
    ERROR_PROC_RETURN_MSG_INNER(
        error, RollbackAndRecycle(task, stm, pos), "[%s] init failed, streamId=%d, retCode=%#x.",
        taskInitInfo->taskDesc, streamId, static_cast<uint32_t>(error));

    error = DavidSendTask(task, stm);
    ERROR_PROC_RETURN_MSG_INNER(
        error, RollbackAndRecycle(task, stm, pos), "[%s] submit failed, streamId=%d, retCode=%#x.",
        taskInitInfo->taskDesc, streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();

    SET_THREAD_TASKID_AND_STREAMID(streamId, task->taskSn);

    return error;
}

void PrintErrorInfoForModelSerialSchedPreProcTask(TaskInfo* taskInfo, const uint32_t devId)
{
    PrintErrorInfoCommon(taskInfo, devId);

    ModelSerialSchedTaskInfo* modelTask = &(taskInfo->u.modelSerialSchedTask);
    RT_LOG(
        RT_LOG_ERROR,
        "Model execute failed, model serial sched preproc task error, modelId=%u, "
        "modelPriority=%u, notifyId=%u, sqId=%u, pid=%u, groupId=%u, exeSqId=%u",
        modelTask->modelId, modelTask->modelPriority, modelTask->notifyId, modelTask->sqId, modelTask->pid,
        modelTask->groupId, modelTask->exeSqId);
}

void PrintErrorInfoForModelSerialSchedNotifyWaitTask(TaskInfo* taskInfo, const uint32_t devId)
{
    PrintErrorInfoCommon(taskInfo, devId);

    ModelSerialSchedTaskInfo* modelTask = &(taskInfo->u.modelSerialSchedTask);
    RT_LOG(
        RT_LOG_ERROR,
        "Model execute failed, model serial sched notify_wait task error, modelId=%u, "
        "modelPriority=%u, notifyId=%u, sqId=%u, pid=%u, groupId=%u, exeSqId=%u",
        modelTask->modelId, modelTask->modelPriority, modelTask->notifyId, modelTask->sqId, modelTask->pid,
        modelTask->groupId, modelTask->exeSqId);
}

void PrintErrorInfoForModelSerialSchedPostProcTask(TaskInfo* taskInfo, const uint32_t devId)
{
    PrintErrorInfoCommon(taskInfo, devId);

    ModelSerialSchedTaskInfo* modelTask = &(taskInfo->u.modelSerialSchedTask);
    RT_LOG(
        RT_LOG_ERROR,
        "Model execute failed, model serial sched postproc task error, modelId=%u, "
        "modelPriority=%u, notifyId=%u, sqId=%u, pid=%u, groupId=%u, exeSqId=%u",
        modelTask->modelId, modelTask->modelPriority, modelTask->notifyId, modelTask->sqId, modelTask->pid,
        modelTask->groupId, modelTask->exeSqId);
}

void StarsSetResultForModelSerialSchedTask(TaskInfo* taskInfo, const rtCqReport_t& logicCq)
{
    if ((taskInfo->type != TS_TASK_TYPE_MODEL_SERIAL_SCHED_PREPROC) &&
        (taskInfo->type != TS_TASK_TYPE_MODEL_SERIAL_SCHED_POSTPROC)) {
        return;
    }

    if (logicCq.errorCode == TS_ERROR_TASK_TIMEOUT) {
        taskInfo->errorCode = logicCq.errorCode;
        return;
    }

    const uint32_t aicpuErrorCode = logicCq.errorCode >> RT_AICPU_ERROR_CODE_BIT_MOVE;
    if (aicpuErrorCode == static_cast<uint32_t>(ModelSerialSchedError::kNone)) {
        taskInfo->errorCode = TS_SUCCESS;
        return;
    }

    std::string errorStr = "unknown error";
    const auto it = g_modelSerialSchedErrorMapInfo.find(aicpuErrorCode);
    if (it != g_modelSerialSchedErrorMapInfo.end()) {
        errorStr = it->second;
    }
    RT_LOG(
        RT_LOG_ERROR, "Model serial sched task happen error, aicpuErrorCode=%#x, errorStr=%s.", aicpuErrorCode,
        errorStr.c_str());
    taskInfo->errorCode = TS_ERROR_TASK_EXCEPTION;
}

static void FillModelSerialSchedSqeCommon(
    RtDavidStarsAicpuDqsSqe* aicpuDqsSqe, const ModelSerialSchedTaskInfo* modelTask)
{
    aicpuDqsSqe->header.type = RT_DAVID_SQE_TYPE_AICPU_H;
    aicpuDqsSqe->header.blockDim = 1U;
    aicpuDqsSqe->kernelCredit = 254U;
    aicpuDqsSqe->sqId = modelTask->sqId;
    aicpuDqsSqe->exeSqId = modelTask->exeSqId;
    aicpuDqsSqe->modelId = modelTask->modelId;
    aicpuDqsSqe->modelPriority = modelTask->modelPriority;
    aicpuDqsSqe->notifyId = modelTask->notifyId;
    aicpuDqsSqe->pid = modelTask->pid;
    aicpuDqsSqe->userGroupId = modelTask->groupId;
}

void ConstructSqeForModelSerialSchedPreProcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuDqsSqe* const aicpuDqsSqe = &(davidSqe->aicpuDqsSqe);

    FillModelSerialSchedSqeCommon(aicpuDqsSqe, &(taskInfo->u.modelSerialSchedTask));
    aicpuDqsSqe->subType = static_cast<uint32_t>(ModelSerialSchedSubType::kPreProc);
    aicpuDqsSqe->magic = RT_MODEL_SERIAL_SCHED_PRE_PROC_MAGIC;
    PrintDavidSqe(davidSqe, "ModelSerialSchedPreProcTask");
}

void ConstructSqeForModelSerialSchedPostProcTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuDqsSqe* const aicpuDqsSqe = &(davidSqe->aicpuDqsSqe);

    FillModelSerialSchedSqeCommon(aicpuDqsSqe, &(taskInfo->u.modelSerialSchedTask));
    aicpuDqsSqe->subType = static_cast<uint32_t>(ModelSerialSchedSubType::kPostProc);
    aicpuDqsSqe->magic = RT_MODEL_SERIAL_SCHED_POST_PROC_MAGIC;
    PrintDavidSqe(davidSqe, "ModelSerialSchedPostProcTask");
}

void ConstructSqeForModelSerialSchedNotifyWaitTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    ModelSerialSchedTaskInfo* modelTask = &(taskInfo->u.modelSerialSchedTask);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsNotifySqe* const notifySqe = &(davidSqe->notifySqe);
    notifySqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;
    notifySqe->notifyId = modelTask->notifyId;
    notifySqe->timeout = MAX_UINT32_NUM;
    notifySqe->cntFlag = false;
    notifySqe->clrFlag = true;
    notifySqe->waitModeBit = 0U;
    notifySqe->recordModeBit = 0U;
    notifySqe->cntValue = 0U;
    notifySqe->subType = NOTIFY_SUB_TYPE_MODEL_SERIAL_SCHED_NOTIFY_WAIT;
    PrintDavidSqe(davidSqe, "ModelSerialSchedNotifyWaitTask");
    RT_LOG(
        RT_LOG_INFO,
        "Model serial sched notify wait: device_id=%u, stream_id=%u, task_id=%u, task_sn=%u, sq_id=%u, notify_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), notifySqe->notifyId,
        notifySqe->cntFlag, notifySqe->clrFlag, notifySqe->waitModeBit, notifySqe->recordModeBit, notifySqe->bitmap,
        notifySqe->cntValue, GetNotifySubType(notifySqe->subType), notifySqe->timeout);
}

} // namespace runtime
} // namespace cce
