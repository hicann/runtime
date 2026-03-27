/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "stars.hpp"
#include "device.hpp"
#include "task_info.h"
#include "task_manager.h"
#include "error_code.h"
namespace cce {
namespace runtime {

void ConstructSqeForIpcNotifyRecordTask(TaskInfo* taskInfo, rtDavidSqe_t * const command)
{
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    Stream* const stream = taskInfo->stream;
    const uint32_t devId = stream->Device_()->Id_();
    RtDavidStarsWriteValueSqe * const sqe = &(command->writeValueSqe);

    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_32BIT;
    sqe->va = 1U;
    sqe->writeValuePart[0] = 1U;    // write 1

    uint64_t notifyAddr = notifyRecord->uInfo.singleBitNtfyInfo.lastBaseAddr;   // ipc notify用这个参数保存notify va地址
    sqe->writeAddrLow = static_cast<uint32_t>(notifyAddr & MASK_32_BIT);
    sqe->writeAddrHigh = static_cast<uint32_t>((notifyAddr >> UINT32_BIT_NUM) & MASK_17_BIT);
    sqe->subType = RT_STARS_WRITE_VALUE_SUB_TYPE_NOTIFY_RECORD_IPC_PCIE;
    sqe->notifyId = notifyRecord->notifyId;
    PrintDavidSqe(command, "IpcNotifyRecordTask");
    RT_LOG(RT_LOG_INFO, "ipc_notify_record: device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, sq_id=%u, "
        "writeAddrLow=0x%x, writeAddrHigh=0x%x, subType=%u.", devId, stream->Id_(), taskInfo->id,
        taskInfo->taskSn, stream->GetSqId(), sqe->writeAddrLow, sqe->writeAddrHigh, sqe->subType);
}

}  // namespace runtime
}  // namespace cce