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
#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"
#include "memory_task.h"
#include "error_code.h"
#include "reduce_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ReduceAsyncV2Task")
rtError_t ReduceAsyncV2TaskInit(TaskInfo* const taskInfo, uint32_t cpyType, const void* srcAddr,
    void* desAddr, const uint64_t cpySize, void* const overflowAddr)
{
    ReduceAsyncV2TaskInfo *reduceAsyncV2TaskInfo = &(taskInfo->u.reduceAsyncV2TaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_REDUCE_ASYNC_V2;
    taskInfo->typeName = const_cast<char_t*>("REDUCE_ASYNC_V2");
    reduceAsyncV2TaskInfo->copyType = cpyType;
    reduceAsyncV2TaskInfo->copyKind = RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD;
    reduceAsyncV2TaskInfo->size = cpySize;
    reduceAsyncV2TaskInfo->src = const_cast<void*>(srcAddr);
    reduceAsyncV2TaskInfo->destPtr = desAddr;
    reduceAsyncV2TaskInfo->copyDataType = 0U;
    reduceAsyncV2TaskInfo->overflowAddr = overflowAddr;
    if (reduceAsyncV2TaskInfo->guardMemVec == nullptr) {
        reduceAsyncV2TaskInfo->guardMemVec = new (std::nothrow) std::vector<std::shared_ptr<void>>();
        COND_RETURN_ERROR_MSG_INNER(reduceAsyncV2TaskInfo->guardMemVec == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "reduceAsyncV2TaskInfo->guardMemVec new memory fail!");
    }
    return RT_ERROR_NONE;
}

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

void ToCommandBodyForReduceAsyncV2Task(TaskInfo * const taskInfo, rtCommand_t * const command)
{
    ReduceAsyncV2TaskInfo *reduceAsyncV2TaskInfo = &(taskInfo->u.reduceAsyncV2TaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    command->u.reduceAsyncV2Task.dir = static_cast<uint8_t>(reduceAsyncV2TaskInfo->copyType);
    uint64_t offset = 0UL;

    if (reduceAsyncV2TaskInfo->overflowAddrOffset != INVALID_CONTEXT_OVERFLOW_OFFSET) {
        offset = reduceAsyncV2TaskInfo->overflowAddrOffset;
    } else  {
        const rtError_t error = driver->MemAddressTranslate(static_cast<int32_t>(stream->Device_()->Id_()),
            RtPtrToValue<void *>(reduceAsyncV2TaskInfo->overflowAddr), &offset);
        COND_RETURN_VOID(error != RT_ERROR_NONE,
            "Failed to translate address to physic for reduce async v2 address, retCode=%#x.", error);
        RT_LOG(RT_LOG_INFO, "ReduceAsyncV2Task offset=%#" PRIx64 ", dir=%u, size_=%" PRIu64, offset,
            command->u.reduceAsyncV2Task.dir, reduceAsyncV2TaskInfo->size);
    }

    command->u.reduceAsyncV2Task.overflowAddr = offset;
    command->u.reduceAsyncV2Task.memcpyType = 0U;  // single copy
    command->u.reduceAsyncV2Task.length = reduceAsyncV2TaskInfo->size;
    command->u.reduceAsyncV2Task.srcBaseAddr =
        RtPtrToValue<void *>(reduceAsyncV2TaskInfo->src);
    command->u.reduceAsyncV2Task.dstBaseAddr =
        RtPtrToValue<void *>(reduceAsyncV2TaskInfo->destPtr);
    command->u.reduceAsyncV2Task.isAddrConvert = RT_NOT_NEED_CONVERT;
    command->u.reduceAsyncV2Task.copyDataType = reduceAsyncV2TaskInfo->copyDataType;
    command->taskInfoFlag = stream->GetTaskRevFlag(taskInfo->bindFlag);
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
    COND_RETURN_VOID((countNum < 0) || (countNum > MSG_LENGTH), "spirntf_s failed, count=%d", countNum)

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