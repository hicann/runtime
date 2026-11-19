/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_log.hpp"
#include "runtime/base.h"
#include <cinttypes>
#include "stream.hpp"
#include "debug_task.h"
#include "task_info_v100.h"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ProfilingEnableTask")
void ConstructSqeForProfilingEnableTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtStarsSqe_t* const command = static_cast<rtStarsSqe_t*>(sqeBuffer);

    ProfilingEnableTaskInfo* const profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_PROFILER_DYNAMIC_ENABLE;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    PrintSqe(command, "ProfilingEnableTask");
    RT_LOG(
        RT_LOG_INFO,
        "Launch ProfilingEnableTask succ, sqeType=" RT_ENUM_LOG_FORMAT("%u") ", wrCqe=%d, preP=" RT_ENUM_LOG_FORMAT(
            "%u") ", rtStreamId=%u, taskId=%u, sqeSubType=" RT_ENUM_LOG_FORMAT("%u") ", "
                                                                                     "pid=%" PRIu64 ".",
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(sqe->header.type), "STARS_SQE_TYPE_PLACE_HOLDER"), sqe->header.wrCqe,
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(sqe->header.preP), "STARS_SQE_INT_DIR_TO_TSCPU"),
        sqe->header.rtStreamId, sqe->header.taskId,
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(sqe->header.u.sqeSubType), "SQE_SUBTYPE_PROFILER_DYNAMIC_ENABLE"),
        profilingEnableTaskInfo->pid);
}
#endif

#if F_DESC("ProfilingDisableTask")
void ConstructSqeForProfilingDisableTask(TaskInfo* const taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtStarsSqe_t* const command = static_cast<rtStarsSqe_t*>(sqeBuffer);

    ProfilingDisableTaskInfo* const profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_PROFILER_DYNAMIC_DISABLE;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    PrintSqe(command, "ProfilingDisableTask");
    RT_LOG(
        RT_LOG_INFO,
        "Launch ProfilingDisableTask succ, sqeType=" RT_ENUM_LOG_FORMAT("%u") ", wrCqe=%d, preP=" RT_ENUM_LOG_FORMAT(
            "%u") ", rtStreamId=%u, taskId=%u, sqeSubType=" RT_ENUM_LOG_FORMAT("%u") ", "
                                                                                     "pid=%" PRIu64 ".",
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(sqe->header.type), "STARS_SQE_TYPE_PLACE_HOLDER"), sqe->header.wrCqe,
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(sqe->header.preP), "STARS_SQE_INT_DIR_TO_TSCPU"),
        sqe->header.rtStreamId, sqe->header.taskId,
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(sqe->header.u.sqeSubType), "SQE_SUBTYPE_PROFILER_DYNAMIC_DISABLE"),
        profilingDisableTaskInfo->pid);
}
#endif

#if F_DESC("ProfilerTraceExTask")
void ConstructSqeForProfilerTraceExTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtStarsSqe_t* const command = static_cast<rtStarsSqe_t*>(sqeBuffer);
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_PROFILER_TRACE_EX;
    sqe->u.profileTraceInfo.profilerTraceId = taskInfo->u.profilerTraceExTask.profilerTraceId;
    sqe->u.profileTraceInfo.modelId = taskInfo->u.profilerTraceExTask.modelId;
    sqe->u.profileTraceInfo.tagId = taskInfo->u.profilerTraceExTask.tagId;

    PrintSqe(command, "ProfilerTraceExTask");
    RT_LOG(
        RT_LOG_INFO, "ProfilerTraceExTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.", stm->Device_()->Id_(),
        stm->Id_(), taskInfo->id, taskInfo->taskSn);
}
#endif

#if F_DESC("ProfilingTaskRegister")
static bool ProfilingTaskRegister()
{
    TaskFuncSingle profilingEnableFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForProfilingEnableTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    TaskFuncSingle profilingDisableFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForProfilingDisableTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    // TS_TASK_TYPE_PROFILER_TRACE_EX
    TaskFuncSingle profilerTraceExFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForProfilerTraceExTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_PROFILING_ENABLE, profilingEnableFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_PROFILING_DISABLE, profilingDisableFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_PROFILER_TRACE_EX, profilerTraceExFuncs);

    return true;
}

static bool g_profilingTaskRegister = ProfilingTaskRegister();
#endif

} // namespace runtime
} // namespace cce
