/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "notify.hpp"
#include "notify_task.h"

namespace cce {
namespace runtime {

#if F_DESC("NotifyRecordTask")
void ConstructNotifySqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    Stream* const stream = taskInfo->stream;
    RtStarsNotifySqe *const sqe = &(command->notifySqe);
    sqe->header.type = RT_STARS_SQE_TYPE_NOTIFY_RECORD;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->notify_id = taskInfo->u.notifyrecordTask.notifyId;
    sqe->header.task_id = taskInfo->id;

    sqe->res2 = 0U;
    sqe->res3 = 0U;

    PrintSqe(command, "NotifyRecordTask");
}

void ConstructIpcSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    Stream* const stream = taskInfo->stream;
    RtStarsWriteValueSqe *const sqe = &(command->writeValueSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();

    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;
    sqe->va = 0U;

    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_32BIT;
    sqe->snoop = 0U;
    sqe->awcache = stream->Device_()->IsAddrFlatDev() ? 0xFU : 0U;
    sqe->awprot = 0U;

    sqe->res3 = notifyRecord->phyId;
    sqe->res4 = static_cast<uint32_t>(notifyRecord->uInfo.singleBitNtfyInfo.isPod);
    sqe->res5 = 0U;
    sqe->res6 = 0U;
    sqe->res7 = 0U;
    sqe->write_value_part0 = 1U;
    sqe->write_value_part1 = 0U;
    sqe->write_value_part2 = 0U;
    sqe->write_value_part3 = 0U;
    sqe->write_value_part4 = 0U;
    sqe->write_value_part5 = 0U;
    sqe->write_value_part6 = 0U;
    sqe->write_value_part7 = 0U;

    uint64_t addr = 0UL;
    const uint32_t devId = stream->Device_()->Id_();
    if (notifyRecord->uInfo.singleBitNtfyInfo.lastLocalId == devId) {
        addr = notifyRecord->uInfo.singleBitNtfyInfo.lastBaseAddr;
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = notifyRecord->uInfo.singleBitNtfyInfo.lastIsPcie;
    } else {
        const rtError_t error = GetIpcSqeWriteAddrForNotifyRecordTask(taskInfo, addr);
        if (error != RT_ERROR_NONE) {
            sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get address, retCode=%#x!", error);
            return;
        }
        notifyRecord->uInfo.singleBitNtfyInfo.lastBaseAddr = addr;
        notifyRecord->uInfo.singleBitNtfyInfo.lastLocalId = devId;
        notifyRecord->uInfo.singleBitNtfyInfo.lastIsPcie = notifyRecord->uInfo.singleBitNtfyInfo.isPcie;
        if (notifyRecord->uPtr.notify != nullptr) {
            notifyRecord->uPtr.notify->SetNotifylastBaseAddr(addr);
            notifyRecord->uPtr.notify->SetNotifylastLocalId(devId);
            notifyRecord->uPtr.notify->SetNotifylastIsPcie(notifyRecord->uInfo.singleBitNtfyInfo.isPcie);
        }
        RT_LOG(RT_LOG_INFO, "lastLocalId=%u lastBaseAddr=0x%llx", devId, addr);
    }

    if (notifyRecord->uInfo.singleBitNtfyInfo.isPcie) {
        sqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_NOTIFY_RECORD_IPC_PCIE;
    } else {
        sqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_NOTIFY_RECORD_IPC_NO_PCIE;
    }

    sqe->write_addr_low = static_cast<uint32_t>(addr & MASK_32_BIT);
    sqe->write_addr_high = static_cast<uint32_t>((addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintSqe(command, "NotifyRecordTask_Ipc");
}

void ConstructSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    if (notifyRecord->uInfo.singleBitNtfyInfo.isIpc == true) {
        ConstructIpcSqeForNotifyRecordTask(taskInfo, command);
    } else {
        ConstructNotifySqeForNotifyRecordTask(taskInfo, command);
    }

    Stream* const stream = taskInfo->stream;
    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    uintptr_t notifyLowEightAddr = 0;
    if (notifyRecord->uPtr.notify != nullptr) {
        notifyLowEightAddr = (RtPtrToPtr<uintptr_t, Notify *>(notifyRecord->uPtr.notify)) & 0xFFU;
    }
    param.u.notifyRecordParams = {notifyRecord->notifyId, notifyRecord->deviceId,
        static_cast<uint16_t>(notifyRecord->uInfo.singleBitNtfyInfo.isIpc), false, notifyLowEightAddr};
    AtraceSubmitLog(TYPE_NOTIFY_RECORD, param);
    RT_LOG(RT_LOG_INFO,
           "notify_record:notify_id=%u,stream_id=%d,task_id=%hu,sq_id=%u,"
           " device_id=%u,is_ipc=%u,logical remote_device=%u,phy remote_device=%u.",
           notifyRecord->notifyId, stream->Id_(), taskInfo->id, stream->GetSqId(),
           stream->Device_()->Id_(), static_cast<uint32_t>(notifyRecord->uInfo.singleBitNtfyInfo.isIpc),
           notifyRecord->deviceId, notifyRecord->phyId);
}

void SetResultForNotifyRecordTask(TaskInfo *const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(taskInfo);
    UNUSED(dataSize);
    UNUSED(data);
}
#endif

#if F_DESC("NotifyWaitTask")
void ConstructSqeForNotifyWaitTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    Stream* const stream = taskInfo->stream;
    RtStarsNotifySqe *const sqe = &(command->notifySqe);
    sqe->header.type = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->kernel_credit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->notify_id = notifyWaitTask->notifyId;
    sqe->header.task_id = taskInfo->id;

    sqe->res2 = 0U;
    sqe->res3 = 0U;
    sqe->timeout = notifyWaitTask->timeout;

    PrintSqe(command, "NotifyWaitTask");
    RT_LOG(RT_LOG_INFO, "notify_wait: notify_id=%u, stream_id=%d, task_id=%hu, sq_id=%u, device_id=%u, "
        "timeout=%us.", notifyWaitTask->notifyId, stream->Id_(), taskInfo->id, stream->GetSqId(),
        stream->Device_()->Id_(), notifyWaitTask->timeout);
}
#endif

}  // namespace runtime
}  // namespace cce
