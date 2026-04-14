/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ccu_task.hpp"
#include "error_code.h"
#include "stars.hpp"
#include "task_scheduler_error.h"

namespace cce {
namespace runtime {
void CcuLaunchTaskInit(TaskInfo *taskInfo, rtCcuTaskInfo_t *const ccuInfo)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_CCU_LAUNCH;
    taskInfo->typeName = RtPtrToUnConstPtr<char_t*>("CCU");

    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);
    ccuLaunchTsk->errInfo.err = 0U;
    ccuLaunchTsk->dieId = ccuInfo->dieId;
    ccuLaunchTsk->missionId = ccuInfo->missionId;
    ccuLaunchTsk->ccu_size = (ccuInfo->argSize == RT_CCU_SQE_ARGS_LEN_128B) ? 0U : 1U;
    ccuLaunchTsk->instStartId = ccuInfo->instStartId;
    ccuLaunchTsk->instCnt = ccuInfo->instCnt;
    ccuLaunchTsk->timeout = ccuInfo->timeout;
    ccuLaunchTsk->key = ccuInfo->key;
    ccuLaunchTsk->args = RtPtrToPtr<uint32_t *, uint64_t*>(ccuInfo->args);
    return;
}

void PrintErrorInfoForCcuLaunchTask(TaskInfo *taskInfo, const uint32_t devId)
{
    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    if ((ccuLaunchTsk->errInfo.err & STARS_CCU_EXIST_ERROR) != 0U) {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
            "CCU Launch task error status [%#x], subStatus [%#x], device_id=%u, stream_id=%d, "
            "task_id=%hu, udie_id=%u, missionId=%hu, sq_id=%u.",
            ccuLaunchTsk->errInfo.info.status, ccuLaunchTsk->errInfo.info.subStatus,
            devId, reportStream->Id_(), taskInfo->id, ccuLaunchTsk->dieId,
            ccuLaunchTsk->missionId, reportStream->GetSqId());
    } else {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
            "CCU Launch task error device_id=%u, stream_id=%d, "
            "task_id=%hu, udie_id=%u, missionId=%hu, sq_id=%u.",
            devId, reportStream->Id_(), taskInfo->id, ccuLaunchTsk->dieId,
            ccuLaunchTsk->missionId, reportStream->GetSqId());
    }    
    return;
}

void DoCompleteSuccessForCcuLaunchTask(TaskInfo* taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    CcuLaunchTaskInfo *ccuLaunchTsk = &(taskInfo->u.ccuLaunchTask);
    if ((taskInfo->mte_error == TS_ERROR_LINK_ERROR) || (taskInfo->mte_error == TS_ERROR_LOCAL_MEM_ERROR) ||
        (taskInfo->mte_error == TS_ERROR_REMOTE_MEM_ERROR)) {
        taskInfo->errorCode = taskInfo->mte_error;
        taskInfo->mte_error = 0U;
    }
    if (unlikely((taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE)))) {
        RT_LOG(RT_LOG_ERROR, "CCU Launch task error, device_id=%u, retCode=%#x, [%s].",
            devId, taskInfo->errorCode, GetTsErrCodeDesc(taskInfo->errorCode));
        stream->SetErrCode(taskInfo->errorCode);
        PrintErrorInfoForCcuLaunchTask(taskInfo, devId);
        ccuLaunchTsk->errInfo.err = 0U;
        return;
    }
    RT_LOG(RT_LOG_INFO,
        "CCU Launch finished: device_id=%u, stream_id=%d, task_id=%hu, udie_id=%u, missionId=%hu, sq_id=%u",
        devId, stream->Id_(), taskInfo->id, ccuLaunchTsk->dieId, ccuLaunchTsk->missionId, stream->GetSqId());
}

void SetResultForCcuLaunchTask(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if ((logicCq.errorCode & STARS_CCU_EXIST_ERROR) != 0U) {
            taskInfo->u.ccuLaunchTask.errInfo.err = logicCq.errorCode;
        }
        uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_TASK_EXCEPTION,
            TS_ERROR_TASK_BUS_ERROR,
            TS_ERROR_TASK_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_TASK_RES_CONFLICT_ERROR,
            TS_ERROR_TASK_SW_STATUS_ERROR};
        const uint32_t index =
            static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType & RT_STARS_EXIST_ERROR)));
        taskInfo->errorCode = errMap[index];
    }
}
}  // namespace runtime
}  // namespace cce
