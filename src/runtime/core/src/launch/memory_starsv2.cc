/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "memory_c.hpp"

#include "base.hpp"
#include "cond_c.hpp"
#include "common/enum_to_string_utils.hpp"
#include "inner_thread_local.hpp"
#include "memory_task.h"
#include "stream_c.hpp"
#include "stream_david.hpp"
#include "task_david.hpp"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtReduceAsync_part2);

namespace {
rtError_t CheckReduceCapability(Stream * const stm, const rtRecudeKind_t kind, const rtDataType_t type)
{
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    if (stm->Device_()->Driver_() == nullptr) {
        return RT_ERROR_NONE;
    }

    rtDevCapabilityInfo capabilityInfo = {};
    error = stm->Device_()->GetDeviceCapabilities(capabilityInfo);
    ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
        stm->Device_()->Id_(), static_cast<uint32_t>(error));
    const uint32_t sdmaReduceKind = capabilityInfo.sdma_reduce_kind;
    RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_kind=0x%x.", sdmaReduceKind);
    const uint32_t shift = static_cast<uint32_t>(kind) - static_cast<uint32_t>(RT_MEMCPY_SDMA_AUTOMATIC_ADD);
    COND_RETURN_AND_MSG_OUTER((((sdmaReduceKind >> shift) & 0x1U) == 0U), RT_ERROR_FEATURE_NOT_SUPPORT,
        ErrorCode::EE1006, __func__, "Parameter kind value " + ReduceKindToString(kind),
        "The current SoC does not support this kind of reduction operation");

    const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;
    const uint32_t offset = static_cast<uint32_t>(type);
    RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_support=0x%x.", sdmaReduceSupport);
    if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "Parameter type value " + DataTypeToString(type),
            "The current SoC does not support the reduction operation of this data type");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t CheckReduceAlign(Stream * const stm, const void * const src, const void * const dst, const rtDataType_t type)
{
    rtError_t error = stm->Context_()->CheckMemAlign(src, type);
    ERROR_RETURN_MSG_INNER(error, "invoke src CheckMemAlign error code:%#x", static_cast<uint32_t>(error));
    error = stm->Context_()->CheckMemAlign(dst, type);
    ERROR_RETURN_MSG_INNER(error, "invoke dst CheckMemAlign error code:%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t SendReduceTask(TaskInfo * const task, Stream * const dstStm)
{
    task->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    const rtError_t error = DavidSendTask(task, dstStm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d MemcpyAsyncTask submit error code:%#x",
        dstStm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t SubmitReduceTask(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    TaskInfo *rtMemcpyAsyncTask = nullptr;
    std::function<void()> const errRecycle = [&rtMemcpyAsyncTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtMemcpyAsyncTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    rtError_t error = AllocTaskInfoForCapture(&rtMemcpyAsyncTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtMemcpyAsyncTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, nullptr);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d MemcpyAsyncTask init error code:%#x", stm->Id_(),
        static_cast<uint32_t>(error));
    rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.copyDataType = static_cast<uint8_t>(type);
    error = SendReduceTask(rtMemcpyAsyncTask, dstStm);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), rtMemcpyAsyncTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}
} // namespace

rtError_t MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    UNUSED(flag);
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to check stream, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    TaskInfo *rtMemWriteValueTask = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&rtMemWriteValueTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtMemWriteValueTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtMemWriteValueTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to allocate task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtMemWriteValueTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    rtMemWriteValueTask->typeName = "MEM_WRITE_VALUE";
    rtMemWriteValueTask->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    error = MemWriteValueTaskInit(rtMemWriteValueTask, devAddr, value);
    ERROR_RETURN_MSG_INNER(error, "Failed to initialize memory wait value task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    MemWriteValueTaskInfo *memWriteValueTask = &rtMemWriteValueTask->u.memWriteValueTask;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    rtMemWriteValueTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtMemWriteValueTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit memory wait value task, stream_id=%d, pos=%u, retCode=%#x.",
        streamId, pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), rtMemWriteValueTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    return CondMemWaitValue(devAddr, value, flag, stm);
}

rtError_t ReduceAsync(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    rtError_t error = CheckReduceCapability(stm, kind, type);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    error = CheckReduceAlign(stm, src, dst, type);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    TIMESTAMP_BEGIN(rtReduceAsync_part2);
    error = SubmitReduceTask(dst, src, cpySize, kind, type, stm, cfgInfo);
    TIMESTAMP_END(rtReduceAsync_part2);
    return error;
}

} // namespace runtime
} // namespace cce
