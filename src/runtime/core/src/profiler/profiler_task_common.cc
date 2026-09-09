/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profiler_c.hpp"

#include "device.hpp"
#include "onlineprof.hpp"
#include "profiling_task.h"
#include "stream.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {

rtError_t StartOnlineProf(Stream* const stm, const uint32_t sampleNum)
{
    Device* const device = stm->Device_();
    rtError_t error;
    rtError_t freeErr;
    const void* deviceMem = nullptr;

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (sampleNum == 0U) || (sampleNum > MAX_ONLINEPROF_NUM), RT_ERROR_INVALID_VALUE, "Delivering a profiling request",
        sampleNum, RtFmtMsg("(0, %u]", MAX_ONLINEPROF_NUM));
    if (device->DevGetOnlineProfStart()) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1017, "Delivering a profiling request", "stream",
            RtFmtMsg("Stream %d online profiling has already been started on the device", stm->Id_()));
        return RT_ERROR_PROF_START;
    }

    (void)device->DevSetOnlineProfStart(true);

    error = OnlineProf::OnlineProfMalloc(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to allocate online profiling memory, retCode=%#x.", error);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtOlProfEnableTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_ONLINEPROF_START, errorReason);
    NULL_PTR_GOTO_MSG_INNER(rtOlProfEnableTask, ERROR_FREE, error, errorReason);

    deviceMem = stm->GetOnProfDeviceAddr();
    NULL_PTR_GOTO_MSG_INNER(deviceMem, ERROR_RECYCLE, error, RT_ERROR_PROF_DEVICE_MEM);

    error = OnlineProfEnableTaskInit(rtOlProfEnableTask, RtPtrToValue<const void*>(deviceMem));
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = device->SubmitTask(rtOlProfEnableTask);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtOlProfEnableTask);
ERROR_FREE:
    freeErr = OnlineProf::OnlineProfFree(stm);
    ERROR_RETURN_MSG_INNER(freeErr, "Failed to free online profiling memory, retCode=%#x.", freeErr);
    return error;
}

rtError_t StopOnlineProf(Stream* const stm)
{
    Device* const device = stm->Device_();
    const int32_t streamId = stm->Id_();
    rtError_t error;

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtOlProfDisableTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_ONLINEPROF_STOP, errorReason);
    NULL_PTR_GOTO_MSG_INNER(rtOlProfDisableTask, FREE_MEM, error, errorReason);

    error = OnlineProfDisableTaskInit(rtOlProfDisableTask, 0U);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init OnlineProfDisableTask, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtOlProfDisableTask->id, error);

    error = device->SubmitTask(rtOlProfDisableTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit OnlineProfDisableTask, retCode=%#x.", error);

    error = stm->Synchronize();
    ERROR_GOTO_MSG_INNER(error, FREE_MEM, "Failed to synchronize OnlineProfDisableTask, retCode=%#x.", error);

    goto FREE_MEM;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtOlProfDisableTask);

FREE_MEM:
    (void)device->DevSetOnlineProfStart(false);

    const rtError_t errorFree = OnlineProf::OnlineProfFree(stm);
    ERROR_RETURN_MSG_INNER(errorFree, "Failed to free online profiling memory, retCode=%#x.", errorFree);

    return error;
}

rtError_t AdcProfiler(Stream* const stm, const uint64_t addr, const uint32_t length)
{
    Device* const device = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtMdcProfTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_ADCPROF, errorReason);
    NULL_PTR_RETURN_MSG(rtMdcProfTask, errorReason);

    rtError_t error = AdcProfTaskInit(rtMdcProfTask, addr, length);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = device->SubmitTask(rtMdcProfTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to submit mdc profiling task, retCode=%#x.", error);
        goto ERROR_RECYCLE;
    }

    error = stm->Synchronize();
    return error;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtMdcProfTask);
    return error;
}

} // namespace runtime
} // namespace cce
