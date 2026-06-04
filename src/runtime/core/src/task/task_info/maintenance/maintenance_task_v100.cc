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
#include "task_info_v100.h"
#include "maintenance_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("MaintenanceTask")
static void ConstructSqeForMaintenanceTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    MaintenanceTaskInfo *maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        sqe->u.maintaince_info.sub_type = FORCE_RECYCLE_TASK_FLAG;
        sqe->u.maintaince_info.target_id = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
        sqe->pre_p = 1U; // for force recycle
    } else {
        sqe->pre_p = 0U;
    }

    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;       // need write cqe for recycle task
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_MAINTENANCE;

    uint16_t streamId = static_cast<uint16_t>(stream->Id_());
    if (!stream->IsSeparateSendAndRecycle()) {
        streamId |= RT_SYNC_TASK_FLAG;
    }
    sqe->rt_streamID = streamId;
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    PrintSqe(command, "MaintenanceTask");
    RT_LOG(RT_LOG_INFO, "MaintenanceTask stream_id:%d task_id:%u.", stream->Id_(), static_cast<uint32_t>(taskInfo->id));
}

static void DoCompleteSuccessForMaintenanceTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    MaintenanceTaskInfo *maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    const Device *const devicePtr = stream->Device_();

    if ((!Runtime::Instance()->GetDisableThread()) && (maintenanceTaskInfo->mtType == MT_EVENT_DESTROY)) {
        const rtError_t errorCode = driver->EventIdFree(static_cast<int32_t>(maintenanceTaskInfo->mtId),
            devicePtr->Id_(), devicePtr->DevGetTsId());
        COND_RETURN_VOID(errorCode != RT_ERROR_NONE, "event id free errorCode, id=%u, deviceId=%u, retCode=%#x",
            maintenanceTaskInfo->mtId, devicePtr->Id_(), errorCode);
    }
}
#endif

#if F_DESC("AllocDsaAddrTask")
static void ConstructSqeForAllocDsaAddrTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    AllocDsaAddrInfoTaskInfo *dsaTaskInfo = &(taskInfo->u.allocDsaAddrTask);
    Stream *const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_ALLOC_DSA_ADDR;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.allocDsaAddrInfo.sq_id = dsaTaskInfo->sqId;
    PrintSqe(command, "AllocDsaAddrTask");
    RT_LOG(RT_LOG_INFO, "Send AllocDsaAddrTask succ, "
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, dsa_sq_id=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, dsaTaskInfo->sqId);
}
#endif

#if F_DESC("GetDevMsgTask")
static void ConstructSqeForGetDevMsgTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    GetDevMsgTaskInfo *getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe * const sqe = &(command->phSqe);

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_GET_DEVICE_MSG;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.get_dev_msg_info.len = getDevMsgTask->msgBufferLen;
    sqe->u.get_dev_msg_info.devAddr =
        RtPtrToValue<void *>(getDevMsgTask->devMem);
    sqe->u.get_dev_msg_info.offset = getDevMsgTask->offset;
    sqe->u.get_dev_msg_info.type = static_cast<uint16_t>(getDevMsgTask->msgType);

    PrintSqe(command, "GetDevMsgTask");
    RT_LOG(RT_LOG_INFO, "stream_id:%d, task_id:%u.", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}
#endif

#if F_DESC("StarsVersionTask")
static void ConstructSqeForStarsVersionTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    Stream *const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;
    sqe->res0 = 0U;
    sqe->res1 = stm->Device_()->GetTsLogToHostFlag(); // runtime version
    uint16_t stream_id = static_cast<uint16_t>(stm->Id_());
    if (!stm->IsSeparateSendAndRecycle()) {
        stream_id |= RT_SYNC_TASK_FLAG;
    }
    sqe->rt_streamID = stream_id;
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_GET_STARS_VERSION;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.starsVersionInfo.buildVersion = RUNTIME_BUILD_VERSION;
    PrintSqe(command, "GetStarsVersionTask");
    RT_LOG(RT_LOG_INFO, "Send GetStarsVersionTask success, sqe_type=%u,pre_p=%u,sqe->rt_streamID=%u, stream_id=%d,"
        "task_id=%u,task_type=%u.", sqe->type, sqe->pre_p, sqe->rt_streamID, stm->Id_(), sqe->task_id, sqe->task_type);
}

void SetStarsResultForStarsVersionTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    taskInfo->errorCode = logicCq.errorCode;
    RT_LOG(RT_LOG_DEBUG, "StarsVersionTask errorCode=%u,logicCq:err=%u,errCode=%u, stream_id=%hu, task_id=%hu",
           taskInfo->errorCode, logicCq.errorType, logicCq.errorCode, logicCq.streamId, logicCq.taskId);
}

void DoCompleteSuccessForStarsVersionTask(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    Device *const dev = taskInfo->stream->Device_();
    COND_RETURN_VOID(dev == nullptr, "dev is NULL.");
    uint32_t tschVersion = taskInfo->errorCode == 0
        ? static_cast<uint32_t>(TS_VERSION_STARS_COMPATIBILITY) : taskInfo->errorCode;
    RT_LOG(RT_LOG_INFO, "Complete StarsVersionTask success, retCode=%u, tschVersion=%u.",
           taskInfo->errorCode, tschVersion);
    dev->SetTschVersion(tschVersion);
}
#endif

static bool MaintenanceTaskRegister()
{
    TaskFuncSingle maintenanceFuncs = {
        .toCommandFunc = &ToCommandBodyForMaintenanceTask,
        .toSqeFunc = &ConstructSqeForMaintenanceTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForMaintenanceTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle allocDsaAddrFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForAllocDsaAddrTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle getDeviceMsgFuncs = {
        .toCommandFunc = &ToCommandBodyForGetDevMsgTask,
        .toSqeFunc = &ConstructSqeForGetDevMsgTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle getStarsVersionFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForStarsVersionTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForStarsVersionTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultForStarsVersionTask,
    };

    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MAINTENANCE, maintenanceFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ALLOC_DSA_ADDR, allocDsaAddrFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_GET_DEVICE_MSG, getDeviceMsgFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_GET_STARS_VERSION, getStarsVersionFuncs);
    }

    return true;
}

static bool g_maintenanceTaskRegister = MaintenanceTaskRegister();

}  // namespace runtime
}  // namespace cce
