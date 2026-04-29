/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "label_c.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "cond_op_label_task.h"
#include "cond_op_stream_task.h"

namespace cce {
namespace runtime {

rtError_t CondLabelSwitchByIndex(void* const ptr, const uint32_t maxIndex, void* const labelInfoPtr, Stream* const stm)
{
    const int32_t streamId = stm->Id_();
    TaskInfo* rtStreamLabelSwitchIndexTask = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&rtStreamLabelSwitchIndexTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtStreamLabelSwitchIndexTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtStreamLabelSwitchIndexTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                                           streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtStreamLabelSwitchIndexTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = StreamLabelSwitchByIndexTaskInit(
        rtStreamLabelSwitchIndexTask, RtPtrToUnConstPtr<void* const>(ptr), maxIndex, labelInfoPtr);
    ERROR_RETURN_MSG_INNER(
        error,
        "Stream label switch by index task init failed, stream_id=%d, task_id=%u, "
        "retCode=%#x.",
        streamId, pos, static_cast<uint32_t>(error));

    error = DavidSendTask(rtStreamLabelSwitchIndexTask, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Stream label switch submit failed, stream_id=%d, pos=%u, retCode=%#x.", dstStm->Id_(), pos,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();

    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), rtStreamLabelSwitchIndexTask->taskSn);
    return error;
}

rtError_t CondLabelSet(Label* const lbl, Stream* const stm)
{
    COND_RETURN_AND_MSG_OUTER(stm->Model_() == nullptr, RT_ERROR_STREAM_MODEL,
        ErrorCode::EE1017, __func__, "stream",
        "The stream must be bound to a model for label set operation");
    COND_RETURN_AND_MSG_OUTER(
        (lbl->MgrType_() == Label::LABEL_MGR_TYPE_MODEL) && (stm->Model_() != lbl->Model_()), RT_ERROR_LABEL_MODEL,
        ErrorCode::EE1017, __func__, "label",
        "Label and stream must be bound to the same model");
    COND_RETURN_AND_MSG_OUTER(
        (lbl->Stream_() != nullptr) && (lbl->Stream_() != stm), RT_ERROR_LABEL_STREAM,
        ErrorCode::EE1017, __func__, "label",
        "Label is already bound to another stream");
    COND_RETURN_AND_MSG_OUTER(lbl->SetFlag_(), RT_ERROR_LABEL_SET,
        ErrorCode::EE1017, __func__, "label",
        "Label has already been set, cannot set again");
    COND_RETURN_AND_MSG_OUTER(
        (lbl->DevDstAddr_() == nullptr), RT_ERROR_LABEL_PHY_ADDR_NULL,
        ErrorCode::EE1017, __func__, "label",
        "Call rtLabelListCpy before setting label task");

    TaskInfo* labelTask = nullptr;
    uint32_t pos = 0xFFFFU;
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));

    Stream *dstStm = stm;

    stm->StreamLock();
    error = AllocTaskInfoForCapture(&labelTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                                           streamId, static_cast<uint32_t>(error));

    SaveTaskCommonInfo(labelTask, dstStm, pos);
    (void)LabelSetTaskInit(labelTask, lbl->Id_(), lbl->DevDstAddr_());

    uint32_t realPos = pos;
    if (dstStm->IsAutoSplitSq()) {
        realPos = dstStm->GetCurSqPos();
    }
    SetSqPos(labelTask, realPos);

    error = DavidSendTask(labelTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(labelTask); TaskRollBack(dstStm, pos); stm->StreamUnLock();,
                                "label task submit failed, stream_id=%d, pos=%u, retCode=%#x.", dstStm->Id_(), pos,
                                static_cast<uint32_t>(error));

    stm->StreamUnLock();

    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), labelTask->taskSn);

    // Label 绑定到 master stream (原始 stm)，而非 dstStm
    // 生命周期由 master stream 管理
    lbl->SetSetFlag(true);
    lbl->ForceSetStream(stm);
    stm->InsertLabelList(lbl);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
