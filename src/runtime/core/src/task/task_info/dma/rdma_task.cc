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
#include "stars_cond_isa_helper.hpp"
#include "context.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "notify.hpp"

namespace cce {
namespace runtime {

#if F_DESC("RdmaSendTask")
rtError_t RdmaSendTaskInit(TaskInfo* taskInfo, const uint32_t sqId, const uint32_t wqeId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_RDMA_SEND;
    taskInfo->typeName = const_cast<char_t*>("RDMA_SEND");
    taskInfo->u.rdmaSendTask.sqIndex = sqId;
    taskInfo->u.rdmaSendTask.wqeIndex = wqeId;
    return RT_ERROR_NONE;
}

void ToCommandBodyForRdmaSendTask(TaskInfo* taskInfo, rtCommand_t* const command)
{
    RT_LOG(
        RT_LOG_INFO, "index=0x%x, wqe_index=%u.", taskInfo->u.rdmaSendTask.sqIndex, taskInfo->u.rdmaSendTask.wqeIndex);
    command->u.rdmaSendTask.sqIndex = taskInfo->u.rdmaSendTask.sqIndex;
    command->u.rdmaSendTask.wqeIndex = taskInfo->u.rdmaSendTask.wqeIndex;
}

#endif

#if F_DESC("RdmaDbSendTask")
rtError_t RdmaDbSendTaskInit(TaskInfo* taskInfo, const uint32_t dbIndex, const uint64_t dbInfo, const uint32_t taskSeq)
{
    RdmaDbSendTaskInfo* rdmaDbSend = &taskInfo->u.rdmaDbSendTask;

    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_RDMA_DB_SEND;
    taskInfo->typeName = const_cast<char_t*>("RDMA_DB_SEND");
    RT_LOG(RT_LOG_INFO, "dbIndex=%#x, dbInfo=%#" PRIx64, dbIndex, dbInfo);
    rdmaDbSend->taskDbIndex.value = dbIndex;
    rdmaDbSend->taskDbInfo.value = dbInfo;

    // check vfid and dieid
    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        if (taskInfo->stream->GetBindFlag()) {
            RT_LOG(RT_LOG_INFO, "taskSeq=%u", taskSeq);
            rdmaDbSend->taskSeq = taskSeq;
        }
        const uint32_t vfId = rdmaDbSend->taskDbIndex.dbIndexStars.vfId;
        const uint32_t dieId = rdmaDbSend->taskDbIndex.dbIndexStars.dieId;
        COND_RETURN_ERROR_MSG_CALL(
            ERR_MODULE_HCCL, vfId != 0U, RT_ERROR_INVALID_VALUE, "invalid vfId, vfId=%u, expect vfId=0", vfId);

        const int64_t phyDieId = taskInfo->stream->Device_()->GetPhyDieId();
        COND_RETURN_ERROR_MSG_CALL(
            ERR_MODULE_HCCL, static_cast<uint32_t>(phyDieId) != dieId, RT_ERROR_INVALID_VALUE,
            "invalid dieId, dieId=%u, phyDieId=%u", dieId, static_cast<uint32_t>(phyDieId));
    }

    return RT_ERROR_NONE;
}

void ToCommandBodyForRdmaDbSendTask(TaskInfo* taskInfo, rtCommand_t* const command)
{
    RdmaDbSendTaskInfo* rdmaDbSend = &taskInfo->u.rdmaDbSendTask;

    RT_LOG(RT_LOG_INFO, "dbIndex=%#x, dbInfo=%#" PRIx64, rdmaDbSend->taskDbIndex.value, rdmaDbSend->taskDbInfo.value);
    command->u.rdmaDbSendTask.dbIndex = rdmaDbSend->taskDbIndex.value;
    command->u.rdmaDbSendTask.dbInfo = rdmaDbSend->taskDbInfo.value;
}

uint32_t GetSendSqeNumForRdmaDbSendTask(TaskInfo* const taskInfo)
{
    if (taskInfo->stream->GetBindFlag()) {
        taskInfo->bindFlag = true;
    }

    constexpr uint32_t num = 1U;
    RT_LOG(
        RT_LOG_INFO, "ChipType=%u, BindFlag=%hhu, SqeNum=%u", Runtime::Instance()->GetChipType(), taskInfo->bindFlag,
        num);
    return num;
}

#endif

} // namespace runtime
} // namespace cce
