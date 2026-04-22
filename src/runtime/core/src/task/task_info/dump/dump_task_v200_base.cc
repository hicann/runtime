/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stars_david.hpp"
#include "stream_david.hpp"
#include "dump_task.h"

namespace cce {
namespace runtime {
void ConstructDavidSqeForDebugUnRegisterForStreamTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.streamDebugRegisterInfo.streamId = taskInfo->u.debugUnRegisterForStreamTask.streamId;

    PrintDavidSqe(davidSqe, "DebugUnRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterForStreamTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

void ConstructDavidSqeForDebugRegisterTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_REGISTER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.modelDebugRegisterInfo.addr = taskInfo->u.debugRegisterTask.addr;
    sqe->u.modelDebugRegisterInfo.modelId = taskInfo->u.debugRegisterTask.modelId;
    sqe->u.modelDebugRegisterInfo.flag = taskInfo->u.debugRegisterTask.flag;

    PrintDavidSqe(davidSqe, "DebugRegister");
    RT_LOG(RT_LOG_INFO, "DebugRegisterTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

void ConstructDavidSqeForDebugUnRegisterTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_UNREGISTER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.modelDebugRegisterInfo.modelId = taskInfo->u.debugUnRegisterTask.modelId;

    PrintDavidSqe(davidSqe, "DebugUnRegister");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "model_id=%u.", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        taskInfo->u.debugUnRegisterTask.modelId);
}

void ConstructDavidSqeForDebugRegisterForStreamTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.streamDebugRegisterInfo.addr = taskInfo->u.debugRegisterForStreamTask.addr;
    sqe->u.streamDebugRegisterInfo.streamId = taskInfo->u.debugRegisterForStreamTask.streamId;
    sqe->u.streamDebugRegisterInfo.flag = taskInfo->u.debugRegisterForStreamTask.flag;

    PrintDavidSqe(davidSqe, "DebugRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugRegisterForStreamTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

void ConstructDavidSqeForDataDumpLoadInfoTask(TaskInfo *taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DATADUMP_LOADINFO;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.dataDumpLoadInfo.dumpinfoPtr = taskInfo->u.dataDumpLoadInfoTask.dumpInfo;
    sqe->u.dataDumpLoadInfo.length = taskInfo->u.dataDumpLoadInfoTask.length;
    sqe->u.dataDumpLoadInfo.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->u.dataDumpLoadInfo.taskId = taskInfo->id;
    sqe->u.dataDumpLoadInfo.kernelType = taskInfo->u.dataDumpLoadInfoTask.kernelType;
    sqe->u.dataDumpLoadInfo.reserved = 0U;

    PrintDavidSqe(davidSqe, "DataDumpLoadInfoTask");
    RT_LOG(RT_LOG_INFO, "DataDumpLoadInfoTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

void ConstructDavidSqeForAicpuInfoLoadTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;

    sqe->taskType = TS_TASK_TYPE_AICPU_INFO_LOAD;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.aiCpuLoadInfo.aicpufoPtr = taskInfo->u.aicpuInfoLoadTask.aicpuInfo;
    sqe->u.aiCpuLoadInfo.length = taskInfo->u.aicpuInfoLoadTask.length;
    sqe->u.aiCpuLoadInfo.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->u.aiCpuLoadInfo.taskId = taskInfo->id;
    sqe->u.aiCpuLoadInfo.reserved[0] = 0U;
    sqe->u.aiCpuLoadInfo.reserved[1] = 0U;

    PrintDavidSqe(davidSqe, "AicpuInfoLoadTask");
    RT_LOG(RT_LOG_INFO, "AicpuInfoLoadTask stream_id:%d task_id:%hu", stm->Id_(), taskInfo->id);
}

void ConstructDavidSqeForNopTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidPlaceHolderSqe *const sqe = &(command->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_NOP;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    PrintDavidSqe(command, "NoOperationTask");
}

}  // namespace runtime
}  // namespace cce
