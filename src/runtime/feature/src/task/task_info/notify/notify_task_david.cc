/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "vector"
#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "notify.hpp"
#include "stars_david.hpp"

namespace cce {
namespace runtime {
static std::vector<const char_t *> g_notifySubTypeStr = {
    "single notify record",
    "single notify wait",
    "count notify record",
    "count notify wait",
    "event record use single notify",
    "event wait use single notify",
    "event record use count notify",
    "event wait use count notify",
    "event reset use single notify",
    "event reset use count notify",
};

const char_t* GetNotifySubType(const uint16_t subType)
{
    if (subType >= g_notifySubTypeStr.size()) {
        return "unknown";
    }
    return g_notifySubTypeStr[static_cast<size_t>(subType)];
}

void ConstructDavidSqeForNotifyWaitTask(TaskInfo *taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsNotifySqe *const sqe = &(command->notifySqe);
    sqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    sqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;
    sqe->notifyId = notifyWaitTask->notifyId;
    sqe->timeout = notifyWaitTask->timeout;
    sqe->cntFlag = false;
    sqe->clrFlag = true;
    sqe->waitModeBit = 0U;
    sqe->recordModeBit = 0U;
    sqe->cntValue = 0U;
    sqe->subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_WAIT;
    if (notifyWaitTask->isCountNotify) {
        sqe->cntFlag = true;
        sqe->cntValue = notifyWaitTask->cntNtfyInfo.value;
        sqe->clrFlag = notifyWaitTask->cntNtfyInfo.isClear;
        sqe->waitModeBit = notifyWaitTask->cntNtfyInfo.mode;
        sqe->subType = NOTIFY_SUB_TYPE_COUNT_NOTIFY_WAIT;
        if (notifyWaitTask->cntNtfyInfo.mode == WAIT_BITMAP_MODE) {
            sqe->waitModeBit = 0U;
            sqe->bitmap = 1U;
        }
    }
    PrintDavidSqe(command, "NotifyWaitTask");
    RT_LOG(RT_LOG_INFO, "notify_wait: device_id=%u, stream_id=%u, task_id=%u, task_sn=%u, sq_id=%u, notify_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(),
        sqe->notifyId, sqe->cntFlag, sqe->clrFlag, sqe->waitModeBit, sqe->recordModeBit, sqe->bitmap, sqe->cntValue,
        GetNotifySubType(sqe->subType), sqe->timeout);
}

static void ConstructDavidSqeForNotifyResetTask(TaskInfo* const taskInfo, rtDavidSqe_t* const command)
{
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsNotifySqe* const sqe = &(command->notifySqe);
    NotifyRecordTaskInfo *notifyRecord = &taskInfo->u.notifyrecordTask;
    Stream* const stream = taskInfo->stream;

    sqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->notifyId = notifyRecord->notifyId;
    sqe->clrFlag = true;
    sqe->subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_RECORD;
    PrintDavidSqe(command, "NotifyResetTask");
    RT_LOG(RT_LOG_INFO, "notify_reset: device_id=%u, stream_id=%u, task_id=%u, task_sn=%u, sq_id=%u, notify_id=%u, "
        "clrFlag=%u, subType=%s.", stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn,
        stream->GetSqId(), sqe->notifyId, sqe->clrFlag, GetNotifySubType(sqe->subType));
}

static void ConstructSqeForIpcNotifyRecordTask(TaskInfo *taskInfo, rtDavidSqe_t *const command)
{
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    RtDavidStarsWriteValueSqe *const sqe = &(command->writeValueSqe);
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
    RT_LOG(RT_LOG_INFO, "ipc_notify_record: device_id=%u, stream_id=%u, task_id=%u, task_sn=%u, sq_id=%u, "
        "writeAddrLow=0x%x, writeAddrHigh=0x%x, subType=%u.", devId, stream->Id_(), taskInfo->id,
        taskInfo->taskSn, stream->GetSqId(), sqe->writeAddrLow, sqe->writeAddrHigh, sqe->subType);
}

void ConstructDavidSqeForNotifyRecordTask(TaskInfo *taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    if ((notifyRecord->isCountNotify == false) && (notifyRecord->uInfo.singleBitNtfyInfo.isNotifyReset == true)) {
        ConstructDavidSqeForNotifyResetTask(taskInfo, command);
        return;
    }
    if ((notifyRecord->isCountNotify == false) && (notifyRecord->uInfo.singleBitNtfyInfo.isIpc == true)) {
        ConstructSqeForIpcNotifyRecordTask(taskInfo, command);
        return;
    }
    Stream* const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsNotifySqe *const sqe = &(command->notifySqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->notifyId = notifyRecord->notifyId;
    sqe->cntFlag = false;
    sqe->clrFlag = false;
    sqe->waitModeBit  = 0U;
    sqe->recordModeBit  = 0U;
    sqe->cntValue = 0U;
    sqe->subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_RECORD;
    if (notifyRecord->isCountNotify) {
        sqe->cntFlag = true;
        sqe->cntValue = notifyRecord->uInfo.countNtfyInfo.value;
        sqe->recordModeBit = notifyRecord->uInfo.countNtfyInfo.mode;
        sqe->subType = NOTIFY_SUB_TYPE_COUNT_NOTIFY_RECORD;
    }

    PrintDavidSqe(command, "NotifyRecordTask");
    RT_LOG(RT_LOG_INFO, "notify_record: device_id=%u, stream_id=%d, task_id=%u,  task_sn=%u, sq_id=%u, notify_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(),
        sqe->notifyId, sqe->cntFlag, sqe->clrFlag, sqe->waitModeBit, sqe->recordModeBit, sqe->bitmap, sqe->cntValue,
        GetNotifySubType(sqe->subType), sqe->timeout);
}

}  // namespace runtime
}  // namespace cce
