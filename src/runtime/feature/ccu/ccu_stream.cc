/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ccu_stream.hpp"
#include "ccu_task.hpp"
#include "task_david.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {
rtError_t StreamCCULaunch(Stream *stm, rtCcuTaskInfo_t *taskInfo)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *ccuLaunchTask = nullptr;
    uint32_t pos = 0xFFFFU;
    constexpr uint32_t sqeNum = 2U;
    const int32_t streamId = stm->Id_();
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));

    const uint8_t devDieNum = stm->Device_()->GetDevProperties().ioDieNum;
    const uint8_t dieNum = (devDieNum != 0) ? devDieNum : 2U;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((taskInfo->dieId >= dieNum), RT_ERROR_INVALID_VALUE, 
        taskInfo->dieId, "[0, " + std::to_string(dieNum) + ")");

    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&ccuLaunchTask, stm, pos, dstStm, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(ccuLaunchTask, dstStm, pos, sqeNum);
    CcuLaunchTaskInit(ccuLaunchTask, taskInfo);
    ccuLaunchTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(ccuLaunchTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, 
                                TaskUnInitProc(ccuLaunchTask); TaskRollBack(dstStm, pos); stm->StreamUnLock();,
                                "ccuLaunchTask submit failed, stream_id=%d, retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), ccuLaunchTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
