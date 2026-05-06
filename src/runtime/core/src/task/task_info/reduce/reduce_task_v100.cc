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
#include "context.hpp"
#include "reduce_task.h"
#include "memory_task.h"
#include "error_code.h"
#include "task_info_v100.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ReduceAsyncV2Task")
void ReduceAsyncV2TaskUnInit(TaskInfo * const taskInfo)
{
    ReduceAsyncV2TaskInfo *reduceAsyncV2TaskInfo = &(taskInfo->u.reduceAsyncV2TaskInfo);

    reduceAsyncV2TaskInfo->src = nullptr;
    reduceAsyncV2TaskInfo->destPtr = nullptr;
    reduceAsyncV2TaskInfo->overflowAddr = nullptr;
    if (reduceAsyncV2TaskInfo->guardMemVec != nullptr) {
        reduceAsyncV2TaskInfo->guardMemVec->clear();
        delete reduceAsyncV2TaskInfo->guardMemVec;
        reduceAsyncV2TaskInfo->guardMemVec = nullptr;
    }

    return;
}

void PrintErrorInfoForReduceAsyncV2Task(TaskInfo * const taskInfo, const uint32_t devId)
{
    ReduceAsyncV2TaskInfo *reduceAsyncV2TaskInfo = &(taskInfo->u.reduceAsyncV2TaskInfo);
    Stream * const stream = taskInfo->stream;

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stream->Id_();
    char_t errMsg[MSG_LENGTH] = {};
    char_t * const errStr = errMsg;
    int32_t countNum = sprintf_s(errStr, static_cast<size_t>(MSG_LENGTH),
        "Reduce async v2 failed, device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu, ",
        devId, streamId, taskId, taskInfo->flipNum);
    if ((countNum < 0) || (countNum > MSG_LENGTH)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call sprintf_s, count=%d.", countNum);
        return;
    }

    Stream * const reportStream = GetReportStream(stream);
    countNum += sprintf_s(errStr + countNum, (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
        "copy_type=%u, memcpy_type=%u, copy_data_type=%u, length=%" PRIu64, reduceAsyncV2TaskInfo->copyType, 0,
        static_cast<uint32_t>(reduceAsyncV2TaskInfo->copyDataType), reduceAsyncV2TaskInfo->size);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL, "%s", errStr);
    countNum += snprintf_truncated_s(errStr + countNum,
        (static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum)),
        ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64,
        RtPtrToValue<void *>(reduceAsyncV2TaskInfo->src),
        RtPtrToValue<void *>(reduceAsyncV2TaskInfo->destPtr));
    PrintModuleIdProc(taskInfo->stream->Device_()->Driver_(), errStr, reduceAsyncV2TaskInfo->src,
        reduceAsyncV2TaskInfo->destPtr, &countNum);
    RT_LOG(RT_LOG_ERROR, "%s.", errStr);
}

void DoCompleteSuccessForReduceAsyncV2Task(TaskInfo * const taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    Stream * const stream = taskInfo->stream;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        RT_LOG(RT_LOG_ERROR, "mem async copy v2 error, retCode=%#x, [%s].", errorCode, GetTsErrCodeDesc(errorCode));
        stream->SetErrCode(errorCode);
        PrintErrorInfo(taskInfo, devId);
    }

    TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        taskInfo->tid, errorCode, stream->Device_());
}

#endif

}  // namespace runtime
}  // namespace cce
