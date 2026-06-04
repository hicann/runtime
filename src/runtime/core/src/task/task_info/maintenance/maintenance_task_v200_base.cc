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
static void ConstructDavidSqeForMaintenanceTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MaintenanceTaskInfo * const maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        sqe->u.maintainceInfo.subType = FORCE_RECYCLE_TASK_FLAG;
        sqe->u.maintainceInfo.targetId = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
        sqe->header.preP = 1U; // for force recycle
    } else {
        sqe->header.preP = 0U;
    }
    sqe->header.wrCqe = 1U;       // need write cqe for recycle task
    sqe->taskType = TS_TASK_TYPE_MAINTENANCE;

    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    PrintDavidSqe(davidSqe, "MaintenanceTask");
    RT_LOG(RT_LOG_INFO, "MaintenanceTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn);
}
#endif

#if F_DESC("GetDevMsgTask")
static void ConstructDavidSqeForGetDevMsgTask(
    TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    GetDevMsgTaskInfo * const getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    Stream * const stm = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_GET_DEVICE_MSG;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.getDevMsgInfo.len = getDevMsgTask->msgBufferLen;
    sqe->u.getDevMsgInfo.devAddr =
        RtPtrToValue(getDevMsgTask->devMem);
    sqe->u.getDevMsgInfo.offset = getDevMsgTask->offset;
    sqe->u.getDevMsgInfo.type = static_cast<uint16_t>(getDevMsgTask->msgType);

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

static void ConstructDavidSqeForAicpuMsgVersionTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    AicpuMsgVersionTaskInfo * const task = &(taskInfo->u.aicpuMsgVersionTask);
    Stream * const stm = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const sqe = &(davidSqe->aicpuControlSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;

    sqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batchMode = 0U;
    sqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(sqe);

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;

    sqe->usrData.pid = 0U;
    sqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_MSG_VERSION);
    sqe->usrData.vfId = 0U;
    sqe->usrData.tid = 0U;
    sqe->usrData.tsId = 0U;
    sqe->usrData.u.msgVersion.magicNum = task->magicNum;
    sqe->usrData.u.msgVersion.version = task->version;

    sqe->subTopicId = 0U;
    sqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    sqe->groupId = 0U;
    sqe->usrDataLen = 12U;         /* 8 + 4 */

    sqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "AicpuMsgVersionTask");
    RT_LOG(RT_LOG_INFO, "AicpuMsgVersionTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "topic_type=%u, cmd_type=%u", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        static_cast<uint32_t>(sqe->topicType), sqe->usrData.cmdType);
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
    TaskFuncSingle allocDsaAddrFuncs = {
        .toCommandFunc = nullptr,
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
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MAINTENANCE, maintenanceFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ALLOC_DSA_ADDR, allocDsaAddrFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_GET_DEVICE_MSG, getDeviceMsgFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_GET_STARS_VERSION, getStarsVersionFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION, aicpuMsgVersionFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MAINTENANCE, &ConstructDavidSqeForMaintenanceTask);
    RegDavidSqeFunc(TS_TASK_TYPE_ALLOC_DSA_ADDR, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_GET_DEVICE_MSG, &ConstructDavidSqeForGetDevMsgTask);
    RegDavidSqeFunc(TS_TASK_TYPE_GET_STARS_VERSION, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION, &ConstructDavidSqeForAicpuMsgVersionTask);

    return true;
}

static bool g_maintenanceTaskRegister = MaintenanceTaskRegister();
}  // namespace runtime
}  // namespace cce
