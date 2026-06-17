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
#include "task_manager.h"
#include "profiling_task.h"
#include "debug_task.h"
#include "task_info_v100.h"

namespace cce {
namespace runtime {

#if F_DESC("ProfilingEnableTask")
void ConstructSqeForProfilingEnableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    ProfilingEnableTaskInfo *profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.dynamic_profiling_info.pid = profilingEnableTaskInfo->pid;
    PrintSqe(command, "ProfilingEnableTask");
    RT_LOG(RT_LOG_INFO, "Launch ProfilingEnableTask succ, "
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, pid=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, profilingEnableTaskInfo->pid);
}
#endif

#if F_DESC("ProfilingDisableTask")
void ConstructSqeForProfilingDisableTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    ProfilingDisableTaskInfo *profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.dynamic_profiling_info.pid = profilingDisableTaskInfo->pid;
    PrintSqe(command, "ProfilingDisableTask");
    RT_LOG(RT_LOG_INFO, "Launch ProfilingDisableTask succ, "
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, pid=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, profilingDisableTaskInfo->pid);
}
#endif

#if F_DESC("ProfilerTraceExTask")
void ConstructSqeForProfilerTraceExTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_PROFILER_TRACE_EX;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.profile_trace_info.profilerTraceId = taskInfo->u.profilerTraceExTask.profilerTraceId;
    sqe->u.profile_trace_info.modelId = taskInfo->u.profilerTraceExTask.modelId;
    sqe->u.profile_trace_info.tagId = taskInfo->u.profilerTraceExTask.tagId;

    PrintSqe(command, "ProfilerTraceExTask");
    RT_LOG(RT_LOG_INFO, "ProfilerTraceExTask stream_id:%d task_id:%u", stm->Id_(), static_cast<uint32_t>(taskInfo->id));
}
#endif

#if F_DESC("PCTraceTask")
void PCTraceTaskUnInit(TaskInfo * const taskInfo)
{
    taskInfo->pcTrace.reset();
}
#endif

#if F_DESC("ProfilingTaskRegister")
static bool ProfilingTaskRegister()
{
    // TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE
    TaskFuncSingle profilerDynamicEnableFuncs = {
        .toCommandFunc = &ToCommandBodyForDynamicProfilingEnableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE
    TaskFuncSingle profilerDynamicDisableFuncs = {
        .toCommandFunc = &ToCommandBodyForDynamicProfilingDisableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_PROFILING_ENABLE
    TaskFuncSingle profilingEnableFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilingEnableTask,
        .toSqeFunc = &ConstructSqeForProfilingEnableTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_PROFILING_DISABLE
    TaskFuncSingle profilingDisableFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilingDisableTask,
        .toSqeFunc = &ConstructSqeForProfilingDisableTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_ONLINEPROF_START
    TaskFuncSingle onlineProfStartFuncs = {
        .toCommandFunc = &ToCommandBodyForOnlineProfEnableTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_ONLINEPROF_STOP
    TaskFuncSingle onlineProfStopFuncs = {
        .toCommandFunc = &ToCommandBodyForOnlineProfDisableTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_ADCPROF
    TaskFuncSingle adcProfFuncs = {
        .toCommandFunc = &ToCommandBodyForAdcProfTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_PROFILER_TRACE
    TaskFuncSingle profilerTraceFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilerTraceTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_PROFILER_TRACE_EX
    TaskFuncSingle profilerTraceExFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilerTraceExTask,
        .toSqeFunc = &ConstructSqeForProfilerTraceExTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    // TS_TASK_TYPE_PCTRACE_ENABLE
    TaskFuncSingle pcTraceFuncs = {
        .toCommandFunc = &ToCommandBodyForPCTraceTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &PCTraceTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    
    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE, profilerDynamicEnableFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE, profilerDynamicDisableFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_PROFILING_ENABLE, profilingEnableFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_PROFILING_DISABLE, profilingDisableFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ONLINEPROF_START, onlineProfStartFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ONLINEPROF_STOP, onlineProfStopFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ADCPROF, adcProfFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_PROFILER_TRACE, profilerTraceFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_PROFILER_TRACE_EX, profilerTraceExFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_PCTRACE_ENABLE, pcTraceFuncs);
    }
    
    return true;
}

static bool g_profilingTaskRegister = ProfilingTaskRegister();
#endif
}  // namespace runtime
}  // namespace cce
