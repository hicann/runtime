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

#include "common/inner_thread_local.hpp"
#include "enum_desc.hpp"
#include "context/context.hpp"
#include "device.hpp"
#include "memory_task.h"
#include "task.hpp"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtReduceAsync_part1);
TIMESTAMP_EXTERN(rtReduceAsync_part2);

namespace {
rtError_t CheckReduceCapability(Device * const dev, const rtRecudeKind_t kind, const rtDataType_t type)
{
    Driver * const devDrv = dev->Driver_();
    if (devDrv == nullptr) {
        return RT_ERROR_NONE;
    }

    rtDevCapabilityInfo capabilityInfo = {};
    rtError_t error = dev->GetDeviceCapabilities(capabilityInfo);
    ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
        dev->Id_(), error);

    const bool starsFlag = dev->IsStarsPlatform();
    if (starsFlag) {
        const uint32_t sdmaReduceKind = capabilityInfo.sdma_reduce_kind;
        RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_kind=0x%x.", sdmaReduceKind);
        const uint32_t shift = static_cast<uint32_t>(kind) - static_cast<uint32_t>(RT_MEMCPY_SDMA_AUTOMATIC_ADD);
        if (((sdmaReduceKind >> shift) & 0x1U) == 0U) {
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "Parameter kind value " + ReduceKindToString(kind),
                "The current SoC does not support this kind of reduction operation");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    if (((kind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL) && (!starsFlag))) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "Parameter kind value RT_MEMCPY_SDMA_AUTOMATIC_EQUAL(13)",
            "RT_MEMCPY_SDMA_AUTOMATIC_EQUAL(13) is only supported on STARS platform hardware");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint32_t kindShift = static_cast<uint32_t>(kind);
    if (((dev->GetDevProperties().sdmaReduceKind >> kindShift) & 0x1U) == 0U) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "Parameter kind value " + ReduceKindToString(kind),
            "The current SoC does not support this kind of reduction operation");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint32_t offset = static_cast<uint32_t>(type);
    RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_support=0x%x.", capabilityInfo.sdma_reduce_support);
    if (((capabilityInfo.sdma_reduce_support >> offset) & 0x1U) == 0U) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "Parameter type value " + DataTypeToString(type),
            "The current SoC does not support the reduction operation of this data type");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t InitReduceTask(TaskInfo * const task, const void * const src, void * const dst, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, const rtTaskCfgInfo_t * const cfgInfo)
{
    const rtError_t error = MemcpyAsyncTaskInitV3(task, kind, src, dst, cpySize, cfgInfo, nullptr);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    task->u.memcpyAsyncTaskInfo.copyDataType = static_cast<uint8_t>(type);
    return RT_ERROR_NONE;
}

rtError_t SubmitReduceTask(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    Device * const dev = stm->Device_();
    rtError_t error = InitReduceTask(rtMemcpyAsyncTask, src, dst, cpySize, kind, type, cfgInfo);
    ERROR_GOTO(error, ERROR_RECYCLE, "reduce task init failed, retCode=%#x.", static_cast<uint32_t>(error));
    error = stm->Context_()->CheckMemAlign(src, type);
    ERROR_GOTO(error, ERROR_RECYCLE, "invoke src CheckMemAlign error code:%#x", static_cast<uint32_t>(error));
    error = stm->Context_()->CheckMemAlign(dst, type);
    ERROR_GOTO(error, ERROR_RECYCLE, "invoke dst CheckMemAlign error code:%#x", static_cast<uint32_t>(error));
    error = dev->SubmitTask(rtMemcpyAsyncTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "reduce task submit failed, retCode=%#x.", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}
} // namespace

rtError_t MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    UNUSED(flag);
    const int32_t streamId = stm->Id_();
    rtError_t errorReason;

    TaskInfo taskSubmit = {};
    TaskInfo *rtMemWriteValueTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_MEM_WRITE_VALUE, errorReason);
    NULL_PTR_RETURN(rtMemWriteValueTask, errorReason);

    rtError_t error = MemWriteValueTaskInit(rtMemWriteValueTask, devAddr, value);
    MemWriteValueTaskInfo *memWriteValueTask = &rtMemWriteValueTask->u.memWriteValueTask;
    ERROR_GOTO(error, ERROR_RECYCLE, "mem write value task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtMemWriteValueTask->id, static_cast<uint32_t>(error));
    rtMemWriteValueTask->typeName = "MEM_WRITE_VALUE";
    rtMemWriteValueTask->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    error = stm->Device_()->SubmitTask(rtMemWriteValueTask, stm->Context_()->TaskGenCallback_());
    ERROR_GOTO(error, ERROR_RECYCLE, "mem write value task submit failed, retCode=%#x", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtMemWriteValueTask, stm->AllocTaskStreamId());
    return error;
ERROR_RECYCLE:
    (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemWriteValueTask);
    return error;
}

rtError_t MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    const int32_t streamId = stm->Id_();
    rtError_t errorReason;

    TaskInfo taskSubmit = {};
    TaskInfo *rtMemWaitValueTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_MEM_WAIT_VALUE, errorReason, MEM_WAIT_SQE_NUM);
    NULL_PTR_RETURN(rtMemWaitValueTask, errorReason);

    rtMemWaitValueTask->typeName = "MEM_WAIT_VALUE";
    rtMemWaitValueTask->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    rtError_t error = MemWaitValueTaskInit(rtMemWaitValueTask, devAddr, value, flag);
    MemWaitValueTaskInfo *memWaitValueTask = &rtMemWaitValueTask->u.memWaitValueTask;
    ERROR_GOTO(error, ERROR_RECYCLE, "mem wait value init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtMemWaitValueTask->id, static_cast<uint32_t>(error));
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    error = stm->Device_()->SubmitTask(rtMemWaitValueTask, stm->Context_()->TaskGenCallback_());
    ERROR_GOTO(error, ERROR_RECYCLE, "mem wait value task submit failed, retCode=%#x", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtMemWaitValueTask, stm->AllocTaskStreamId());
    return error;
ERROR_RECYCLE:
    (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemWaitValueTask);
    return error;
}

rtError_t ReduceAsync(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    TIMESTAMP_BEGIN(rtReduceAsync_part1);
    Device * const dev = stm->Device_();
    rtError_t error = CheckReduceCapability(dev, kind, type);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    TIMESTAMP_END(rtReduceAsync_part1);

    TIMESTAMP_BEGIN(rtReduceAsync_part2);
    error = SubmitReduceTask(dst, src, cpySize, kind, type, stm, cfgInfo);
    TIMESTAMP_END(rtReduceAsync_part2);
    return error;
}

} // namespace runtime
} // namespace cce
