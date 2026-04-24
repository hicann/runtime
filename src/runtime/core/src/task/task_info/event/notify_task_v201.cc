/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars.hpp"
#include "stars_david.hpp"
#include "task_info.h"
#include "error_code.h"
#include "device.hpp"
#include "task_manager.h"
#include "notify_task.h"

namespace cce {
namespace runtime {

void ConstructSqeForIpcNotifyRecordTask(TaskInfo* taskInfo, rtDavidSqe_t * const command)
{
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    RtDavidStarsWriteValueSqe * const sqe = &(command->writeValueSqe);
    Stream* const stream = taskInfo->stream;
    const uint32_t devId = stream->Device_()->Id_();
    uint64_t notifyAddr = 0ULL;

    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_32BIT;
    sqe->va = 0U;
    sqe->writeValuePart[0] = 1U;    // write 1

    const rtError_t error = GetIpcSqeWriteAddrForNotifyRecordTask(taskInfo, notifyAddr);
    if (error != RT_ERROR_NONE) {
        sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "failed to get write address for IPC notify record task, retCode=%#x!", error);
        return;
    }
    notifyRecord->uInfo.singleBitNtfyInfo.lastBaseAddr = notifyAddr;
    notifyRecord->uInfo.singleBitNtfyInfo.lastLocalId = devId;
    notifyRecord->uInfo.singleBitNtfyInfo.lastIsPcie = notifyRecord->uInfo.singleBitNtfyInfo.isPcie;
    RT_LOG(RT_LOG_INFO, "ipc notify record write address updated: lastLocalId=%u, lastBaseAddr=0x%llx, "
        "lastIsPcie=%u", devId, notifyAddr, notifyRecord->uInfo.singleBitNtfyInfo.isPcie);

    sqe->subType = RT_STARS_WRITE_VALUE_SUB_TYPE_NOTIFY_RECORD_IPC_NO_PCIE;
    sqe->writeAddrLow = static_cast<uint32_t>(notifyAddr & MASK_32_BIT);
    sqe->writeAddrHigh = static_cast<uint32_t>((notifyAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintDavidSqe(command, "IpcNotifyRecordTask");
    RT_LOG(RT_LOG_INFO, "ipc_notify_record: device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, sq_id=%u, "
        "writeAddrLow=0x%x, writeAddrHigh=0x%x, subType=%u.", devId, stream->Id_(), taskInfo->id,
        taskInfo->taskSn, stream->GetSqId(), sqe->writeAddrLow, sqe->writeAddrHigh, sqe->subType);
}

}  // namespace runtime
}  // namespace cce