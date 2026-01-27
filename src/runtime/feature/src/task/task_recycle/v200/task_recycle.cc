/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "rt_stars_define.h"
#include "context.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "device/device_error_proc.hpp"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "context.hpp"
#include "tsch_defines.h"
#include "profiler.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "hwts.hpp"
#include "raw_device.hpp"
#include "davinci_kernel_task.h"
#include "event_task.h"
#include "memory_task.h"
#include "task_info.h"
#include "engine.hpp"
#include "task_res_da.hpp"
#include "task_recycle.hpp"
#include "device.hpp"
#include "stream_david.hpp"

namespace cce {
namespace runtime {
constexpr uint16_t TASK_QUERY_INTERVAL_NUM = 64U;     // Shared memory query interval.

// =================================================== static 函数区 ======================================== //
void ProcLogicCqUntilEmpty(const Stream *const stm)
{
    Device *const dev = stm->Device_();
    Driver *const devDrv = dev->Driver_();
    constexpr uint32_t allocCnt = RT_MILAN_MAX_QUERY_CQE_NUM; // want get cqe num
    const uint32_t logicCqId = stm->GetLogicalCqId();
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());
    uint32_t times = 0U;

    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = dev->Id_();
    waitInfo.tsId = dev->DevGetTsId();
    waitInfo.cqId = logicCqId;
    waitInfo.isFastCq = false;
    waitInfo.timeout = RT_REPORT_WITHOUT_TIMEOUT;  // get logic report without timeout
    waitInfo.streamId = streamId;      // for camodel
    waitInfo.taskId = MAX_UINT32_NUM;  // get any logic report without specifying the task

    while (true) {
        uint32_t cnt = 0U;
        rtLogicCqReport_t reportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};

        rtError_t error = ((RawDevice*)(dev))->Engine_()->ReportHeartBreakProcV2();
        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error == RT_ERROR_LOST_HEARTBEAT,,
            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(dev->Id_())});,
            "Device[%u] lost heartbeart.", dev->Id_());

        error = devDrv->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *, rtLogicCqReport_t *>(reportInfo), allocCnt, cnt);
        if (unlikely(((error != RT_ERROR_NONE) && (error != RT_ERROR_SOCKET_CLOSE)) || (cnt == 0U))) {
            RT_LOG(RT_LOG_INFO, "Task Wait: stream_id=%d, logicCqId=%u, retCode=%#x.", streamId, logicCqId,
                static_cast<uint32_t>(error));
            if (times == 0U) {
                return;
            }
            break;
        }

        times++;
        bool isFinished = false;
        (void)ProcReport(dev, streamId, UINT32_MAX, cnt, reportInfo, isFinished);
    }

    return;
}

static rtError_t SendingProcReport(const Stream *const stm, const bool limited, uint16_t sqHead)
{
    if (!stm->GetNeedRecvCqeFlag()) {
        if (!stm->IsExistCqe()) {
            const uint32_t taskHead = ((dynamic_cast<TaskResManageDavid *>(stm->taskResMang_)))->GetTaskPosHead();
            return FinishedTaskReclaim(stm, limited, static_cast<uint16_t>(taskHead), sqHead);
        }
    }

    ProcLogicCqUntilEmpty(stm);
    // process finish task by sqHead
    const uint32_t taskHead = (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskPosHead();
    return FinishedTaskReclaim(stm, limited, static_cast<uint16_t>(taskHead), sqHead);
}

// =================================================== static 函数区 ======================================== //

// ================================================== 对外出口区 ======================================== //
// Do task recycling every 64 tasks send
rtError_t TryRecycleTask(Stream * const stm)
{
    TaskResManageDavid *taskResMang = dynamic_cast<TaskResManageDavid *>(stm->taskResMang_);
    const rtError_t deviceStatus = stm->Device_()->GetDeviceStatus();
    const rtError_t streamAbortStatus = stm->GetAbortStatus();
    COND_RETURN_ERROR((deviceStatus == RT_ERROR_DEVICE_TASK_ABORT),
        deviceStatus,
        "stream is in device task abort status, try recycle task fail, stream_id=%d, task_head=%u,"
        "task_tail=%u, pendingNum=%hu.", stm->Id_(), taskResMang->GetTaskPosHead(),
        taskResMang->GetTaskPosTail(), taskResMang->GetPendingNum());
    COND_RETURN_ERROR((streamAbortStatus == RT_ERROR_STREAM_ABORT),
        streamAbortStatus,
        "stream is in stream abort status, try recycle task fail, stream_id=%d, task_head=%u,"
        "task_tail=%u, pendingNum=%hu.", stm->Id_(), taskResMang->GetTaskPosHead(),
        taskResMang->GetTaskPosTail(), taskResMang->GetPendingNum());

    // recycle every 64 task
    if (stm->GetBindFlag() || stm->IsBindDvppGrp() ||
        ((!stm->GetRecycleFlag()) && (((taskResMang->GetAllocNum()) % TASK_QUERY_INTERVAL_NUM) != 0U))) {
        return RT_ERROR_NONE;
    }
    // get device rtsq head by drv interface
    uint16_t sqHead = 0U;
    uint16_t head = 0U;
    uint16_t tail = 0U;
    if (stm->StreamSyncTryLock(3U)) {   // 3ms
        const rtError_t error = GetDrvSqHead(stm, sqHead);
        COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, stm->StreamSyncUnLock();,
            "GetDrvSqHead failed, retCode=%#x.", static_cast<uint32_t>(error));
        // recycle per task, if recycleFlag is true
        if (stm->GetRecycleFlag()) {
            (void)SendingProcReport(stm, true, sqHead);
            RT_LOG(RT_LOG_INFO, "streamId=%d, sqHead=%hu.", stm->Id_(), sqHead);
            if (taskResMang->GetTaskPosHead() == sqHead) {
                stm->SetRecycleFlag(false);
            }
            stm->StreamSyncUnLock();
            return RT_ERROR_NONE;
        }
        taskResMang->GetHeadTail(head, tail);
        if (head != sqHead) {
            (void)SendingProcReport(stm, true, sqHead);
            RT_LOG(RT_LOG_INFO, "streamId=%d, tail=%hu, sqHead=%hu.", stm->Id_(), tail, sqHead);
            if (taskResMang->GetTaskPosHead() != sqHead) {
                stm->SetRecycleFlag(true);
            }
        }
        stm->StreamSyncUnLock();
    }
    return RT_ERROR_NONE;
}

rtError_t TaskReclaimByStream(Stream *const stm, const bool limited, const bool needLog)
{
    if ((stm->Flags() & RT_STREAM_PERSISTENT) != 0U) {
        RT_LOG(RT_LOG_ERROR, "persistent stream can not call this func!");
        return RT_ERROR_STREAM_INVALID;
    }

    if (stm->IsSeparateSendAndRecycle()) {
        if (!stm->Device_()->GetIsDoingRecycling()) {
            stm->Device_()->WakeUpRecycleThread();
        }
        return RT_ERROR_NONE;
    }

    uint16_t head = 0U;
    uint16_t tail = 0U;
    (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetHeadTail(head, tail);

    rtError_t error;
    if (unlikely(stm->GetFailureMode() == ABORT_ON_FAILURE) || stm->isForceRecycle_) {
        error = SendingProcReport(stm, false, tail);
        RT_LOG(RT_LOG_INFO, "stream is in failure abort or isForceRecycle and need to reclaim all, streamId=%d,"
            " posHead=%u, posTail=%u, failuremode=%" PRIu64 ", isForceRecycle=%s.",
            stm->Id_(), head, tail, stm->GetFailureMode(), stm->isForceRecycle_ ? "true" : "false");
        return error;
    }

    // get device rtsq head by drv interface
    uint16_t sqHead = 0U;
    error = GetDrvSqHead(stm, sqHead, needLog);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "GetDrvSqHead failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    error = SendingProcReport(stm, limited, sqHead);
    return error;
}

rtError_t TaskReclaimAllStream(const Device *const dev)
{
    rtError_t error = RT_ERROR_NONE;
    std::vector<Stream *> allStreams;
    dev->GetStreamSqCqManage()->GetAllStream(allStreams);
    RT_LOG(RT_LOG_INFO, "Travel all streams, num=%zu.", allStreams.size());
    for (const auto streamLoop : allStreams) {
        error = TaskReclaimByStream(streamLoop, false);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    }

    return RT_ERROR_NONE;
}

static void RecycleLabelInfoWithModel(TaskInfo* labeltask)
{
    Stream *stm = labeltask->stream;
    COND_RETURN_NORMAL((stm == nullptr), "Stream is null");
    COND_RETURN_NORMAL((stm->labels_.empty() == true), "Labels is empty");
    Label *targetLabel = nullptr;
    for (Label *label : stm->labels_) {
        COND_RETURN_NORMAL((label == nullptr), "Label clean done");
        if (labeltask->u.labelSetTask.labelId == label->Id_()) {
            targetLabel = label;
            break;
        }
    }

    if (targetLabel != nullptr) {
        targetLabel->ResetLabelDevAddr();
        targetLabel->SetSetFlag(false);
        stm->labels_.remove(targetLabel);
    } else {
        RT_LOG(RT_LOG_WARNING, "Label with id %d is not found.", labeltask->u.labelSetTask.labelId);
    }
}

void RecycleModelBindStreamAllTask(Stream *const stm, const bool cleanFlag)
{
    uint16_t head = 0U;
    uint16_t tail = 0U;
    stm->StreamSyncLock();
    (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetHeadTail(head, tail);
    RT_LOG(RT_LOG_INFO, "stream_id=%d, head=%hu, tail=%hu.", stm->Id_(), head, tail);
    TaskInfo *nextTask = nullptr;
    for (uint32_t i = head; i < tail;) {
        nextTask = (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskInfo(i);
        if (unlikely(nextTask == nullptr)) {
            i++;
            continue;
        }
        TaskUnInitProc(nextTask);
        if (cleanFlag && (nextTask->type == TS_TASK_TYPE_LABEL_SET)) {
            RecycleLabelInfoWithModel(nextTask);
        }
        i = static_cast<uint32_t>(nextTask->id) + nextTask->sqeNum;
    }

    (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->ResetTaskRes();
    stm->StreamSyncUnLock();
}

rtError_t RecycleTaskBySqHead(Stream * const stm)
{
    uint16_t sqHead = 0U;
    rtError_t error = GetDrvSqHead(stm, sqHead);
    COND_RETURN_INFO(error != RT_ERROR_NONE, error, "stream_id=%d, retCode=%#x",
        stm->Id_(), static_cast<uint32_t>(error));

    uint32_t endTaskId = MAX_UINT32_NUM;
    error = stm->GetFinishedTaskIdBySqHead(sqHead, endTaskId);
    COND_PROC(((error != RT_ERROR_NONE) || (endTaskId == MAX_UINT32_NUM)), return RT_ERROR_NONE);
    stm->SetExecuteEndTaskId(endTaskId);
    return FinishedTaskReclaim(stm, false, (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskPosHead(), sqHead);
}

rtError_t RecycleTaskBySqHeadForRecyleThread(Stream * const stm)
{
    if (unlikely(stm->GetFailureMode() == ABORT_ON_FAILURE) || stm->isForceRecycle_) {
        RT_LOG(RT_LOG_INFO, "stream is in failure abort and need to reclaim all, device_id=%u, stream_id=%d, lastTaskId=%u, "
                            "failuremode=%" PRIu64, stm->Device_()->Id_(), stm->Id_(), stm->GetLastTaskId(), stm->GetFailureMode());
        uint32_t lastTaskId = stm->GetLastTaskId();
        stm->SetExecuteEndTaskId(lastTaskId);
        return FinishedTaskReclaim(stm, false, (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskPosHead(),
            (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskPosTail());
    }

    return RecycleTaskBySqHead(stm);
}

rtError_t TaskReclaimForSeparatedStm(Stream *const stm)
{
    bool isExistCqe = stm->IsExistCqe();
    bool isNeedRecvCqe = stm->GetNeedRecvCqeFlag();

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, IsExistCqe=%u, needRecvCqeFlag=%u",
        stm->Device_()->Id_(), stm->Id_(), isExistCqe, isNeedRecvCqe);
    // 先收一把cqe，再根据drv head回收一把。
    if ((isExistCqe) || (isNeedRecvCqe)) {
        ProcLogicCqUntilEmpty(stm);
    }

    rtError_t error = RecycleTaskBySqHeadForRecyleThread(stm);
    COND_LOG_DEBUG((error != RT_ERROR_NONE), "recyle task stream_id=%d, ret=%u", stm->Id_(), error);
    return error;
}

void RecycleThreadDoForStarsV2(Device *deviceInfo)
{
    rtError_t ret = RT_ERROR_NONE;
    std::vector<uint32_t> streamIdList;
    std::shared_ptr<Stream> stream = nullptr;
    (void)deviceInfo->GetStreamSqCqManage()->GetAllStreamId(streamIdList);
   
    for (const auto &id : streamIdList) {
        ret = deviceInfo->GetStreamSqCqManage()->GetStreamSharedPtrById(id, stream);
        COND_PROC(((ret != RT_ERROR_NONE) || (stream == nullptr)), continue);
        stream.get()->StreamRecycleLock();
        stream.get()->SetThreadProcFlag(true);
        stream.get()->ProcArgRecycleList();

        COND_PROC((stream.get()->Flags() & (RT_STREAM_AICPU | RT_STREAM_CP_PROCESS_USE | RT_STREAM_PERSISTENT)) != 0,
            stream.get()->SetThreadProcFlag(false); stream.get()->StreamRecycleUnlock(); stream.reset(); continue);

        COND_PROC((((dynamic_cast<TaskResManageDavid *>(stream.get()->taskResMang_))->IsEmpty()) ||
            (stream.get()->IsBindDvppGrp()) || (!stream.get()->IsSeparateSendAndRecycle())),
            stream.get()->SetThreadProcFlag(false); stream.get()->StreamRecycleUnlock(); stream.reset(); continue);
        ret = TaskReclaimForSeparatedStm(stream.get());
        stream.get()->SetThreadProcFlag(false);
        stream.get()->StreamRecycleUnlock();
        stream.reset();
        COND_LOG_DEBUG((ret != RT_ERROR_NONE), "task reclaim fail ret=%u", ret);
    };

    if (deviceInfo->GetIsChipSupportEventThread()) {
        while (deviceInfo->PopNextPoolFreeEventId()) {
        }
    }
}

// ================================================== 对外出口区 ======================================== //
}  // namespace runtime
}  // namespace cce