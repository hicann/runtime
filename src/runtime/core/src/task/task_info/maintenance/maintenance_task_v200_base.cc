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
#include "stars_david.hpp"
#include "maintenance_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("MaintenanceTask")
static void ConstructDavidSqeForMaintenanceTask(TaskInfo * const taskInfo, void *const sqe,
    const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    MaintenanceTaskInfo * const maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);

    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        phSqe->u.maintainceInfo.subType = FORCE_RECYCLE_TASK_FLAG;
        phSqe->u.maintainceInfo.targetId = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
        phSqe->header.preP = 1U; // for force recycle
    } else {
        phSqe->header.preP = 0U;
    }
    phSqe->header.wrCqe = 1U;  // need write cqe for recycle task
    phSqe->taskType = TS_TASK_TYPE_MAINTENANCE;

    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    PrintDavidSqe(davidSqe, "MaintenanceTask");
    RT_LOG(RT_LOG_INFO, "MaintenanceTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn);
}
#endif

#if F_DESC("GetDevMsgTask")
static void ConstructDavidSqeForGetDevMsgTask(
    TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    GetDevMsgTaskInfo * const getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    Stream * const stm = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);

    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_GET_DEVICE_MSG;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.getDevMsgInfo.len = getDevMsgTask->msgBufferLen;
    phSqe->u.getDevMsgInfo.devAddr =
        RtPtrToValue(getDevMsgTask->devMem);
    phSqe->u.getDevMsgInfo.offset = getDevMsgTask->offset;
    phSqe->u.getDevMsgInfo.type = static_cast<uint16_t>(getDevMsgTask->msgType);

    PrintDavidSqe(davidSqe, "GetDevMsgTask");
    RT_LOG(RT_LOG_INFO, "GetDevMsgTask, device_id=%u, stream_id=%d, task_id=%hu.", stm->Device_()->Id_(),
        stm->Id_(), taskInfo->id);
}
#endif

#if F_DESC("AicpuMsgVersionTask")
void AicpuMsgVersionTaskInit(TaskInfo *taskInfo)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION;
    taskInfo->typeName = "TSFW_AICPU_MSG_VERSION";

    AicpuMsgVersionTaskInfo *task = &(taskInfo->u.aicpuMsgVersionTask);
    task->magicNum = MAGIC_NUMBER_FOR_AICPU_MSG_VERSION;
    task->version = AICPU_MSG_VERSION_FOR_DAVID;
    return;
}

static void ConstructDavidSqeForAicpuMsgVersionTask(TaskInfo * const taskInfo, void *const sqe,
    const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    AicpuMsgVersionTaskInfo * const task = &(taskInfo->u.aicpuMsgVersionTask);
    Stream * const stm = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const aicpuCtrlSqe = &(davidSqe->aicpuControlSqe);
    aicpuCtrlSqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    aicpuCtrlSqe->header.blockDim = 1U;

    aicpuCtrlSqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    aicpuCtrlSqe->batchMode = 0U;
    aicpuCtrlSqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(aicpuCtrlSqe);

    aicpuCtrlSqe->qos = stm->Device_()->GetTsdQos();
    aicpuCtrlSqe->res2 = 0U;
    aicpuCtrlSqe->sqeIndex = 0U; // useless
    aicpuCtrlSqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;

    aicpuCtrlSqe->usrData.pid = 0U;
    aicpuCtrlSqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_MSG_VERSION);
    aicpuCtrlSqe->usrData.vfId = 0U;
    aicpuCtrlSqe->usrData.tid = 0U;
    aicpuCtrlSqe->usrData.tsId = 0U;
    aicpuCtrlSqe->usrData.u.msgVersion.magicNum = task->magicNum;
    aicpuCtrlSqe->usrData.u.msgVersion.version = task->version;

    aicpuCtrlSqe->subTopicId = 0U;
    aicpuCtrlSqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    aicpuCtrlSqe->groupId = 0U;
    aicpuCtrlSqe->usrDataLen = 12U;         /* 8 + 4 */

    aicpuCtrlSqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "AicpuMsgVersionTask");
    RT_LOG(RT_LOG_INFO, "AicpuMsgVersionTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "topic_type=%u, cmd_type=%u", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        static_cast<uint32_t>(aicpuCtrlSqe->topicType), aicpuCtrlSqe->usrData.cmdType);
}
#endif

static bool MaintenanceTaskRegister()
{
    TaskFuncSingle maintenanceFuncs = {
        .toCommandFunc = &ToCommandBodyForMaintenanceTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle getDeviceMsgFuncs = {
        .toCommandFunc = &ToCommandBodyForGetDevMsgTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle getStarsVersionFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle aicpuMsgVersionFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        (void)RegTaskFunc(chip, TS_TASK_TYPE_MAINTENANCE, maintenanceFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_GET_DEVICE_MSG, getDeviceMsgFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_GET_STARS_VERSION, getStarsVersionFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION, aicpuMsgVersionFuncs);
    }

    (void)RegDavidSqeFunc(TS_TASK_TYPE_MAINTENANCE, &ConstructDavidSqeForMaintenanceTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_GET_DEVICE_MSG, &ConstructDavidSqeForGetDevMsgTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_GET_STARS_VERSION, &ConstructDavidSqeBase);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION, &ConstructDavidSqeForAicpuMsgVersionTask);

    return true;
}

static bool g_maintenanceTaskRegister = MaintenanceTaskRegister();
}  // namespace runtime
}  // namespace cce
