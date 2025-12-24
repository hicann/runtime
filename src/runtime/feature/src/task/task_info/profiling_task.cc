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
#include "debug_task.h"

namespace cce {
namespace runtime {

#if F_DESC("DynamicProfilingEnableTask")
rtError_t DynamicProfilingEnableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg)
{
    ProfilingEnableTaskInfo *profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE;
    taskInfo->typeName = "PROF_ENABLE";         // PROF_ENABLE: Enable dynamic or normal profiling capabilities

    for (uint8_t &item : profilingEnableTaskInfo->eventMuxConfig) {
        item = 0U;
    }

    profilingEnableTaskInfo->pid = processId;
    const errno_t ret = memcpy_s(profilingEnableTaskInfo->eventMuxConfig, static_cast<size_t>(M_PROF_EVEID_NUM),
                                 profCfg->eventId, static_cast<size_t>(M_PROF_EVEID_NUM));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy_s failed, max size=%d(bytes), src size=%d(bytes), retCode=%d.", M_PROF_EVEID_NUM, M_PROF_EVEID_NUM, ret);
    profilingEnableTaskInfo->startCycle = profCfg->profStartCyc;
    profilingEnableTaskInfo->stopCycle = profCfg->profStopCyc;
    profilingEnableTaskInfo->userDefinedEnable = profCfg->isUsrDefProfEn;
    profilingEnableTaskInfo->isRtsProfEn = profCfg->isRtsProfEn;
    profilingEnableTaskInfo->isTaskBasedProfEn = profCfg->isTaskBasedProfEn;
    profilingEnableTaskInfo->isProfLogEn = profCfg->isProfLogEn;
    profilingEnableTaskInfo->isHwtsLogEn = profCfg->isHwtsLogEn;
    profilingEnableTaskInfo->reserved = 0U;
    return RT_ERROR_NONE;
}

void ToCommandBodyForDynamicProfilingEnableTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    ProfilingEnableTaskInfo *profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);

    command->u.profilingEnable.pid = profilingEnableTaskInfo->pid;
    const errno_t ret = memcpy_s(command->u.profilingEnable.eventMuxConfig,
                                 static_cast<size_t>(M_PROF_EVEID_NUM),
                                 profilingEnableTaskInfo->eventMuxConfig, static_cast<size_t>(M_PROF_EVEID_NUM));
    COND_LOG_ERROR(ret != EOK, "Memcpy_s failed, retCode=%d, srcSize=%d(bytes), dstSize=%d(bytes).",
        ret, M_PROF_EVEID_NUM, M_PROF_EVEID_NUM);
    command->u.profilingEnable.startCycle = profilingEnableTaskInfo->startCycle;
    command->u.profilingEnable.stopCycle = profilingEnableTaskInfo->stopCycle;
    command->u.profilingEnable.userDefinedEnable = profilingEnableTaskInfo->userDefinedEnable;
    command->u.profilingEnable.isTimelineProfEn = profilingEnableTaskInfo->isRtsProfEn;
    command->u.profilingEnable.isTaskBasedProfEn = profilingEnableTaskInfo->isTaskBasedProfEn;
    command->u.profilingEnable.isProfLogEn = profilingEnableTaskInfo->isProfLogEn;
    command->u.profilingEnable.isHwtsLogEn = profilingEnableTaskInfo->isHwtsLogEn;
}
#endif

#if F_DESC("DynamicProfilingDisableTask")
rtError_t DynamicProfilingDisableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg)
{
    ProfilingDisableTaskInfo *profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE;
    taskInfo->typeName = "PROF_DISABLE";        // PROF_DISABLE: Disable dynamic or normal profiling capabilities

    profilingDisableTaskInfo->pid = processId;
    profilingDisableTaskInfo->isRtsProfEn = profCfg->isRtsProfEn;
    profilingDisableTaskInfo->isTaskBasedProfEn = profCfg->isTaskBasedProfEn;
    profilingDisableTaskInfo->isProfLogEn = profCfg->isProfLogEn;
    profilingDisableTaskInfo->isHwtsLogEn = profCfg->isHwtsLogEn;
    return RT_ERROR_NONE;
}

void ToCommandBodyForDynamicProfilingDisableTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    ProfilingDisableTaskInfo *profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);

    command->u.profilingDisable.pid = profilingDisableTaskInfo->pid;
    command->u.profilingDisable.isTimelineProfDis = profilingDisableTaskInfo->isRtsProfEn;
    command->u.profilingDisable.isTaskBasedProfDis = profilingDisableTaskInfo->isTaskBasedProfEn;
    command->u.profilingDisable.isProfLogDis = profilingDisableTaskInfo->isProfLogEn;
    command->u.profilingDisable.isHwtsLogDis = profilingDisableTaskInfo->isHwtsLogEn;
}
#endif

#if F_DESC("ProfilingEnableTask")
rtError_t ProfilingEnableTaskInit(TaskInfo * const taskInfo, const uint64_t processId, const rtProfCfg_t *const profCfg)
{
    ProfilingEnableTaskInfo *profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_PROFILING_ENABLE;
    taskInfo->typeName = "PROFILING_ENABLE";

    for (uint8_t &item : profilingEnableTaskInfo->eventMuxConfig) {
        item = 0U;
    }

    profilingEnableTaskInfo->pid = processId;
    const errno_t ret = memcpy_s(profilingEnableTaskInfo->eventMuxConfig, static_cast<size_t>(M_PROF_EVEID_NUM),
                                 profCfg->eventId, static_cast<size_t>(M_PROF_EVEID_NUM));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy_s failed, max size=%d(bytes), src size=%d(bytes).", M_PROF_EVEID_NUM, M_PROF_EVEID_NUM);
    profilingEnableTaskInfo->startCycle = profCfg->profStartCyc;
    profilingEnableTaskInfo->stopCycle = profCfg->profStopCyc;
    profilingEnableTaskInfo->userDefinedEnable = profCfg->isUsrDefProfEn;
    profilingEnableTaskInfo->isRtsProfEn = profCfg->isRtsProfEn;
    profilingEnableTaskInfo->isTaskBasedProfEn = profCfg->isTaskBasedProfEn;
    profilingEnableTaskInfo->isProfLogEn = profCfg->isProfLogEn;
    profilingEnableTaskInfo->isHwtsLogEn = profCfg->isHwtsLogEn;
    profilingEnableTaskInfo->reserved = 0U;
    return RT_ERROR_NONE;
}

void ToCommandBodyForProfilingEnableTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    ProfilingEnableTaskInfo *profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);

    command->u.profilingEnable.pid = profilingEnableTaskInfo->pid;
    const errno_t ret = memcpy_s(command->u.profilingEnable.eventMuxConfig,
                                 static_cast<size_t>(M_PROF_EVEID_NUM),
                                 profilingEnableTaskInfo->eventMuxConfig, static_cast<size_t>(M_PROF_EVEID_NUM));
    COND_LOG_ERROR(ret != EOK, "Memcpy_s failed, retCode=%d, srcSize=%d(bytes), dstSize=%d(bytes).",
        ret, M_PROF_EVEID_NUM, M_PROF_EVEID_NUM);
    command->u.profilingEnable.startCycle = profilingEnableTaskInfo->startCycle;
    command->u.profilingEnable.stopCycle = profilingEnableTaskInfo->stopCycle;
    command->u.profilingEnable.userDefinedEnable = profilingEnableTaskInfo->userDefinedEnable;
    command->u.profilingEnable.isTimelineProfEn = profilingEnableTaskInfo->isRtsProfEn;
    command->u.profilingEnable.isTaskBasedProfEn = profilingEnableTaskInfo->isTaskBasedProfEn;
    command->u.profilingEnable.isProfLogEn = profilingEnableTaskInfo->isProfLogEn;
    command->u.profilingEnable.isHwtsLogEn = profilingEnableTaskInfo->isHwtsLogEn;
}

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
rtError_t ProfilingDisableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg)
{
    ProfilingDisableTaskInfo *profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_PROFILING_DISABLE;
    taskInfo->typeName = "PROFILING_DISABLE";

    profilingDisableTaskInfo->pid = processId;
    profilingDisableTaskInfo->isRtsProfEn = profCfg->isRtsProfEn;
    profilingDisableTaskInfo->isTaskBasedProfEn = profCfg->isTaskBasedProfEn;
    profilingDisableTaskInfo->isProfLogEn = profCfg->isProfLogEn;
    profilingDisableTaskInfo->isHwtsLogEn = profCfg->isHwtsLogEn;
    return RT_ERROR_NONE;
}

void ToCommandBodyForProfilingDisableTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    ProfilingDisableTaskInfo *profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);

    command->u.profilingDisable.pid = profilingDisableTaskInfo->pid;
    command->u.profilingDisable.isTimelineProfDis = profilingDisableTaskInfo->isRtsProfEn;
    command->u.profilingDisable.isTaskBasedProfDis = profilingDisableTaskInfo->isTaskBasedProfEn;
    command->u.profilingDisable.isProfLogDis = profilingDisableTaskInfo->isProfLogEn;
    command->u.profilingDisable.isHwtsLogDis = profilingDisableTaskInfo->isHwtsLogEn;
}

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

#if F_DESC("OnlineProfEnableTask")
rtError_t OnlineProfEnableTaskInit(TaskInfo * const taskInfo, const uint64_t onlineProfilingAddr)
{
    OnlineProfEnableTaskInfo *onlineProfEnableTaskInfo = &(taskInfo->u.onlineProfEnableTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_ONLINEPROF_START;
    taskInfo->typeName = "ONLINE_PROF_ENABLE";
    onlineProfEnableTaskInfo->onlineProfAddr = onlineProfilingAddr;
    return RT_ERROR_NONE;
}

void ToCommandBodyForOnlineProfEnableTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    OnlineProfEnableTaskInfo *onlineProfEnableTaskInfo = &(taskInfo->u.onlineProfEnableTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    uint64_t onlineProfPhyAddr;
    RT_LOG(RT_LOG_DEBUG, "Online profiling address=%#" PRIx64, onlineProfEnableTaskInfo->onlineProfAddr);
    const rtError_t error = driver->MemAddressTranslate(static_cast<int32_t>(stream->Device_()->Id_()),
        onlineProfEnableTaskInfo->onlineProfAddr, &onlineProfPhyAddr);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "translate virtual address to physic failed! retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "Online profiling address=%#" PRIx64 ", physical address=%#" PRIx64,
        onlineProfEnableTaskInfo->onlineProfAddr, onlineProfPhyAddr);

    command->u.onlineProfStartTask.onlineProfAddr = onlineProfPhyAddr;
    command->u.onlineProfStartTask.virAddr = MAX_UINT32_NUM;
}

#endif

#if F_DESC("OnlineProfDisableTask")
rtError_t OnlineProfDisableTaskInit(TaskInfo * const taskInfo, const uint64_t onlineProfilingAddr)
{
    OnlineProfDisableTaskInfo *onlineProfDisableTaskInfo = &(taskInfo->u.onlineProfDisableTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_ONLINEPROF_STOP;
    taskInfo->typeName = "ONLINE_PROF_DISABLE";

    onlineProfDisableTaskInfo->onlineProfAddr = onlineProfilingAddr;
    return RT_ERROR_NONE;
}

void ToCommandBodyForOnlineProfDisableTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    OnlineProfDisableTaskInfo *onlineProfDisableTaskInfo = &(taskInfo->u.onlineProfDisableTaskInfo);

    command->u.onlineProfStopTask.onlineProfAddr = onlineProfDisableTaskInfo->onlineProfAddr;
}

#endif

#if F_DESC("ProfTask")
rtError_t ProfTaskInit(TaskInfo * const taskInfo, const uint64_t address, const uint32_t len)
{
    ProfTaskInfo *profTaskInfo = &(taskInfo->u.profTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_ADCPROF;
    taskInfo->typeName = "ADC_PROF";
    profTaskInfo->addr = address;
    profTaskInfo->length = len;

    return RT_ERROR_NONE;
}

void ToCommandBodyForProfTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    rtError_t error;
    uint64_t offset = 0UL;
    ProfTaskInfo *profTaskInfo = &(taskInfo->u.profTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint64_t addr = profTaskInfo->addr;

    error = driver->MemAddressTranslate(static_cast<int32_t>(stream->Device_()->Id_()), addr, &offset);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "profTask address retCode=%#x, addr=%#" PRIx64 "", error, addr);

    RT_LOG(RT_LOG_INFO, "profTask offset=%#" PRIx64 ", virtual addr=%#" PRIx64 "", offset, addr);

    command->u.profTask.profAddr = offset;
    command->u.profTask.length = profTaskInfo->length;
}

#endif

#if F_DESC("ProfilerTraceTask")
rtError_t ProfilerTraceTaskInit(TaskInfo* taskInfo, const uint64_t id, const bool notifyFlag, const uint32_t flags)
{
    UNUSED(flags);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_PROFILER_TRACE;
    taskInfo->typeName = "PROFILER_TRACE";
    taskInfo->u.profilertraceTask.profilerTraceId = id;
    taskInfo->u.profilertraceTask.notify = (notifyFlag) ? 1U : 0U;

    return RT_ERROR_NONE;
}

void ToCommandBodyForProfilerTraceTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.profilertraceTask.profilerTraceId = static_cast<uint64_t>(taskInfo->u.profilertraceTask.profilerTraceId);
    command->u.profilertraceTask.notify = static_cast<uint8_t>(taskInfo->u.profilertraceTask.notify);
}

#endif

#if F_DESC("ProfilerTraceExTask")
rtError_t ProfilerTraceExTaskInit(TaskInfo* taskInfo, const uint64_t id,
                                  const uint64_t mdlId,
                                  const uint16_t tag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_PROFILER_TRACE_EX;
    taskInfo->typeName = "PROFILER_TRACE_EX";
    taskInfo->u.profilerTraceExTask.profilerTraceId = id;
    taskInfo->u.profilerTraceExTask.modelId = mdlId;
    taskInfo->u.profilerTraceExTask.tagId = tag;

    return RT_ERROR_NONE;
}

void ToCommandBodyForProfilerTraceExTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.profilerTraceExTask.profilerTraceId = taskInfo->u.profilerTraceExTask.profilerTraceId;
    command->u.profilerTraceExTask.modelId = taskInfo->u.profilerTraceExTask.modelId;
    command->u.profilerTraceExTask.tagId = taskInfo->u.profilerTraceExTask.tagId;
}

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

}  // namespace runtime
}  // namespace cce