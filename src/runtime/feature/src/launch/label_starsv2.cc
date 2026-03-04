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

namespace cce {
namespace runtime {

rtError_t CondLabelSwitchByIndex(void* const ptr, const uint32_t maxIndex, void* const labelInfoPtr, Stream* const stm)
{
    const int32_t streamId = stm->Id_();
    TaskInfo* rtStreamLabelSwitchIndexTask = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&rtStreamLabelSwitchIndexTask, &stm, &pos]() {
        TaskUnInitProc(rtStreamLabelSwitchIndexTask);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&rtStreamLabelSwitchIndexTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                                           streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtStreamLabelSwitchIndexTask, stm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = StreamLabelSwitchByIndexTaskInit(
        rtStreamLabelSwitchIndexTask, RtPtrToUnConstPtr<void* const>(ptr), maxIndex, labelInfoPtr);
    ERROR_RETURN_MSG_INNER(
        error,
        "Stream label switch by index task init failed, stream_id=%d, task_id=%u, "
        "retCode=%#x.",
        streamId, pos, static_cast<uint32_t>(error));

    error = DavidSendTask(rtStreamLabelSwitchIndexTask, stm);
    ERROR_RETURN_MSG_INNER(
        error, "Stream label switch submit failed, stream_id=%d, pos=%u, retCode=%#x.", stm->Id_(), pos,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();

    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(streamId, rtStreamLabelSwitchIndexTask->taskSn);
    return error;
}

rtError_t CondLabelSet(Label* const lbl, Stream* const stm)
{
    NULL_PTR_RETURN_MSG(stm->Model_(), RT_ERROR_STREAM_MODEL);
    COND_RETURN_ERROR_MSG_INNER(
        (lbl->MgrType_() == Label::LABEL_MGR_TYPE_MODEL) && (stm->Model_() != lbl->Model_()), RT_ERROR_LABEL_MODEL,
        "Set label failed, stream don't bind to label mdl!");
    COND_RETURN_ERROR_MSG_INNER(
        (lbl->Stream_() != nullptr) && (lbl->Stream_() != stm), RT_ERROR_LABEL_STREAM,
        "Set label failed, label stream not same with create stream!");
    COND_RETURN_ERROR_MSG_INNER(lbl->SetFlag_(), RT_ERROR_LABEL_SET, "Set label failed, label already set!");
    COND_RETURN_ERROR_MSG_INNER(
        (lbl->DevDstAddr_() == nullptr), RT_ERROR_LABEL_PHY_ADDR_NULL,
        "Need call rtLabelListCpy api before set label task.");

    TaskInfo* labelTask = nullptr;
    uint32_t pos = 0xFFFFU;
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    stm->StreamLock();
    error = AllocTaskInfo(&labelTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                                           streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(labelTask, stm, pos);
    (void)LabelSetTaskInit(labelTask, lbl->Id_(), lbl->DevDstAddr_());
    SetSqPos(labelTask, pos);
    error = DavidSendTask(labelTask, stm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(labelTask); TaskRollBack(stm, pos); stm->StreamUnLock();
                                , "label task submit failed, stream_id=%d, pos=%u, retCode=%#x.", stm->Id_(), pos,
                                static_cast<uint32_t>(error));

    stm->StreamUnLock();
    lbl->SetSetFlag(true);
    lbl->ForceSetStream(stm);
    stm->InsertLabelList(lbl);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
