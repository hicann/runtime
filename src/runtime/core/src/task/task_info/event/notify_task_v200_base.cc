/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
static std::vector<const char_t*> g_notifySubTypeStr = {
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
    "model serial sched notify wait",
};

const char_t* GetNotifySubType(const uint16_t subType)
{
    if (subType >= g_notifySubTypeStr.size()) {
        return "unknown";
    }
    return g_notifySubTypeStr[static_cast<size_t>(subType)];
}

void ConstructDavidSqeForNotifyWaitTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsNotifySqe* const notifySqe = &(davidSqe->notifySqe);
    notifySqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;
    notifySqe->notifyId = notifyWaitTask->notifyId;
    notifySqe->timeout = notifyWaitTask->timeout;
    notifySqe->cntFlag = false;
    notifySqe->clrFlag = true;
    notifySqe->waitModeBit = 0U;
    notifySqe->recordModeBit = 0U;
    notifySqe->cntValue = 0U;
    notifySqe->subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_WAIT;
    if (notifyWaitTask->isCountNotify) {
        notifySqe->cntFlag = true;
        notifySqe->cntValue = notifyWaitTask->cntNtfyInfo.value;
        notifySqe->clrFlag = notifyWaitTask->cntNtfyInfo.isClear;
        notifySqe->waitModeBit = notifyWaitTask->cntNtfyInfo.mode;
        notifySqe->subType = NOTIFY_SUB_TYPE_COUNT_NOTIFY_WAIT;
        if (notifyWaitTask->cntNtfyInfo.mode == WAIT_BITMAP_MODE) {
            notifySqe->waitModeBit = 0U;
            notifySqe->bitmap = 1U;
        }
    }
    PrintDavidSqe(davidSqe, "NotifyWaitTask");
    RT_LOG(
        RT_LOG_INFO,
        "notify_wait: device_id=%u, stream_id=%u, task_id=%u, task_sn=%u, sq_id=%u, notify_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), notifySqe->notifyId,
        notifySqe->cntFlag, notifySqe->clrFlag, notifySqe->waitModeBit, notifySqe->recordModeBit, notifySqe->bitmap,
        notifySqe->cntValue, GetNotifySubType(notifySqe->subType), notifySqe->timeout);
}

static void ConstructDavidSqeForNotifyResetTask(TaskInfo* const taskInfo, rtDavidSqe_t* const command)
{
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsNotifySqe* const sqe = &(command->notifySqe);
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    Stream* const stream = taskInfo->stream;

    sqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->notifyId = notifyRecord->notifyId;
    sqe->clrFlag = true;
    sqe->subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_RECORD;
    PrintDavidSqe(command, "NotifyResetTask");
    RT_LOG(
        RT_LOG_INFO,
        "notify_reset: device_id=%u, stream_id=%u, task_id=%u, task_sn=%u, sq_id=%u, notify_id=%u, "
        "clrFlag=%u, subType=%s.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), sqe->notifyId,
        sqe->clrFlag, GetNotifySubType(sqe->subType));
}

void ConstructDavidSqeForNotifyRecordTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    if ((notifyRecord->isCountNotify == false) && (notifyRecord->uInfo.singleBitNtfyInfo.isNotifyReset == true)) {
        ConstructDavidSqeForNotifyResetTask(taskInfo, davidSqe);
        return;
    }
    if ((notifyRecord->isCountNotify == false) && (notifyRecord->uInfo.singleBitNtfyInfo.isIpc == true)) {
        ConstructSqeForIpcNotifyRecordTask(taskInfo, davidSqe);
        return;
    }
    Stream* const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsNotifySqe* const notifySqe = &(davidSqe->notifySqe);

    notifySqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    notifySqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    notifySqe->notifyId = notifyRecord->notifyId;
    notifySqe->cntFlag = false;
    notifySqe->clrFlag = false;
    notifySqe->waitModeBit = 0U;
    notifySqe->recordModeBit = 0U;
    notifySqe->cntValue = 0U;
    notifySqe->subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_RECORD;
    if (notifyRecord->isCountNotify) {
        notifySqe->cntFlag = true;
        notifySqe->cntValue = notifyRecord->uInfo.countNtfyInfo.value;
        notifySqe->recordModeBit = notifyRecord->uInfo.countNtfyInfo.mode;
        notifySqe->subType = NOTIFY_SUB_TYPE_COUNT_NOTIFY_RECORD;
    }

    PrintDavidSqe(davidSqe, "NotifyRecordTask");
    RT_LOG(
        RT_LOG_INFO,
        "notify_record: device_id=%u, stream_id=%d, task_id=%u, task_sn=%u, sq_id=%u, notify_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), notifySqe->notifyId,
        notifySqe->cntFlag, notifySqe->clrFlag, notifySqe->waitModeBit, notifySqe->recordModeBit, notifySqe->bitmap,
        notifySqe->cntValue, GetNotifySubType(notifySqe->subType), notifySqe->timeout);
}

void ConstructStarsSqeForNotifyRecordTask(TaskInfo* taskInfo, uint8_t* const command)
{
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ConstructDavidSqeForNotifyRecordTask(taskInfo, static_cast<void* const>(command), sqeInfo);
}

void ConstructStarsSqeForConditionNotifyWait(TaskInfo* taskInfo, uint8_t* const command)
{
    Construct2ndDavidSqeForCaptureConditionTask(taskInfo, RtPtrToPtr<rtDavidSqe_t*>(command));
}

} // namespace runtime
} // namespace cce
