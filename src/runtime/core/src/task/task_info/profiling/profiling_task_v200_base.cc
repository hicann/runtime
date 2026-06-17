/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "stream.hpp"
#include "profiling_task.h"
#include "task_manager.h"
#include "debug_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ProfilingEnableTask")
void ConstructDavidSqeForProfilingEnableTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ProfilingEnableTaskInfo * const profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.dynamicProfilingInfo.pid = profilingEnableTaskInfo->pid;
    phSqe->u.dynamicProfilingInfo.isTaskBasedProfEn = profilingEnableTaskInfo->isTaskBasedProfEn;
    phSqe->u.dynamicProfilingInfo.isSocLogEn = profilingEnableTaskInfo->isHwtsLogEn;
    PrintDavidSqe(davidSqe, "DynamicProfilingEnableTask");
    RT_LOG(RT_LOG_INFO, "ProfilingEnableTask, device_id=%u, stream_id=%d, task_id=%hu, pid=%llu."
        "isSocLogEn=%hhu, isTaskBasedProfEn=%hhu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, profilingEnableTaskInfo->pid,
        phSqe->u.dynamicProfilingInfo.isSocLogEn, phSqe->u.dynamicProfilingInfo.isTaskBasedProfEn);
}
#endif

#if F_DESC("ProfilingDisableTask")
void ConstructDavidSqeForProfilingDisableTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ProfilingDisableTaskInfo * const profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.dynamicProfilingInfo.pid = profilingDisableTaskInfo->pid;
    phSqe->u.dynamicProfilingInfo.isTaskBasedProfEn = profilingDisableTaskInfo->isTaskBasedProfEn;
    phSqe->u.dynamicProfilingInfo.isSocLogEn = profilingDisableTaskInfo->isHwtsLogEn;
    PrintDavidSqe(davidSqe, "DynamicProfilingDisableTask");
    RT_LOG(RT_LOG_INFO, "ProfilingDisableTask, device_id=%u, stream_id=%d, task_id=%hu, pid=%u, "
        "isSocLogEn=%hhu, isTaskBasedProfEn=%hhu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id,
        phSqe->u.dynamicProfilingInfo.pid, phSqe->u.dynamicProfilingInfo.isSocLogEn,
        phSqe->u.dynamicProfilingInfo.isTaskBasedProfEn);
}
#endif

#if F_DESC("ProfilerTraceExTask")
void ConstructDavidSqeForProfilerTraceExTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_PROFILER_TRACE_EX;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.profileTraceInfo.profilerTraceId = taskInfo->u.profilerTraceExTask.profilerTraceId;
    phSqe->u.profileTraceInfo.modelId = taskInfo->u.profilerTraceExTask.modelId;
    phSqe->u.profileTraceInfo.tagId = taskInfo->u.profilerTraceExTask.tagId;

    PrintDavidSqe(davidSqe, "ProfilerTraceExTask");
    RT_LOG(RT_LOG_INFO, "ProfilerTraceExTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
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
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE
    TaskFuncSingle profilerDynamicDisableFuncs = {
        .toCommandFunc = &ToCommandBodyForDynamicProfilingDisableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_PROFILING_ENABLE
    TaskFuncSingle profilingEnableFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilingEnableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_PROFILING_DISABLE
    TaskFuncSingle profilingDisableFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilingDisableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_ONLINEPROF_START
    TaskFuncSingle onlineProfStartFuncs = {
        .toCommandFunc = &ToCommandBodyForOnlineProfEnableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_ONLINEPROF_STOP
    TaskFuncSingle onlineProfStopFuncs = {
        .toCommandFunc = &ToCommandBodyForOnlineProfDisableTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_ADCPROF
    TaskFuncSingle adcProfFuncs = {
        .toCommandFunc = &ToCommandBodyForAdcProfTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_PROFILER_TRACE
    TaskFuncSingle profilerTraceFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilerTraceTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_PROFILER_TRACE_EX
    TaskFuncSingle profilerTraceExFuncs = {
        .toCommandFunc = &ToCommandBodyForProfilerTraceExTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    // TS_TASK_TYPE_PCTRACE_ENABLE
    TaskFuncSingle pcTraceFuncs = {
        .toCommandFunc = &ToCommandBodyForPCTraceTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    
    const auto& chips = GetDavidChips();
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
    
    // Register David SQE functions
    RegDavidSqeFunc(TS_TASK_TYPE_PROFILING_ENABLE, &ConstructDavidSqeForProfilingEnableTask);
    RegDavidSqeFunc(TS_TASK_TYPE_PROFILING_DISABLE, &ConstructDavidSqeForProfilingDisableTask);
    RegDavidSqeFunc(TS_TASK_TYPE_ONLINEPROF_START, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_ONLINEPROF_STOP, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_ADCPROF, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_PCTRACE_ENABLE, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_PROFILER_TRACE, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_PROFILER_TRACE_EX, &ConstructDavidSqeForProfilerTraceExTask);
    
    return true;
}

static bool g_profilingTaskRegister = ProfilingTaskRegister();
#endif
}  // namespace runtime
}  // namespace cce
