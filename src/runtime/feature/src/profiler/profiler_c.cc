/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiler_c.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "toolchain/prof_acl_api.h"
#include "stream_david.hpp"

namespace cce {
namespace runtime {

rtError_t ProfTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream *stm,
    const Context *ctx)
{
    RT_LOG(RT_LOG_INFO, "id=%" PRIu64 ", modelId=%" PRIu64 ", tagId=%hu, stream_id=%d.",
        id, modelId, tagId, stm->Id_());

    // MAX_INT32_NUM means that stream is type of RT_STREAM_FORBIDDEN_DEFAULT
    if (stm->Id_() == MAX_INT32_NUM) {
        if (ctx->OnlineStream_() != nullptr) {
            stm = ctx->OnlineStream_();
            RT_LOG(RT_LOG_DEBUG, "use online stream for model execute, model_id=%" PRIu64, modelId);
        } else {
            stm = ctx->DefaultStream_();
            NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
            RT_LOG(RT_LOG_DEBUG, "use default stream for model execute, model_id=%" PRIu64, modelId);
        }
    }

    TaskInfo *rtProfTraceExTask = nullptr;
    rtError_t  error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtProfTraceExTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "stream_id=%d alloc task failed, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtProfTraceExTask, dstStm, pos);
    (void)ProfilerTraceExTaskInit(rtProfTraceExTask, id, modelId, tagId);
    rtProfTraceExTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtProfTraceExTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(rtProfTraceExTask);
                                       TaskRollBack(dstStm, pos);
                                       stm->StreamUnLock();,
                                       "stream_id=%d send task failed, retCode=%#x.",
                                       stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtProfTraceExTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

void ProfStart(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId, const Device * const dev)
{
    RT_LOG(RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u.", profConfig, devId);
    rtProfCfg_t *profCfg = profiler->ProfCfgPtr();
    profCfg->isRtsProfEn = ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) == 0U) ? 0U : 1U;
    profCfg->isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    profCfg->isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;
    profCfg->isHwtsLogEn = ((profConfig & static_cast<uint64_t>(PROF_TASK_TIME_MASK)) == 0ULL) ? 0U : 1U;
    std::function<void()> const retRecycle = [&profiler, &devId]() {
        Runtime::Instance()->SetProfileEnableFlag(profiler->IsEnabled(devId));
    };
    ScopeGuard returnProcess(retRecycle);
    if ((profCfg->isRtsProfEn != 0U) || (profCfg->isTaskBasedProfEn != 0U) || (profCfg->isProfLogEn != 0U)
        || (profCfg->isHwtsLogEn != 0U)) {
        uint32_t pid;
        (void)dev->Driver_()->DeviceGetBareTgid(&pid);
        Stream *stream = dev->PrimaryStream_();
        if (likely(stream != nullptr)) {
            TaskInfo *tsk = nullptr;
            rtError_t  error = CheckTaskCanSend(stream);
            COND_RETURN_VOID(error != RT_ERROR_NONE, "stream_id=%d check failed, retCode=%#x.",
                stream->Id_(), static_cast<uint32_t>(error));
            uint32_t pos = 0xFFFFU;
            stream->StreamLock();
            error = AllocTaskInfo(&tsk, stream, pos);
            if (error != RT_ERROR_NONE) {
                stream->StreamUnLock();
                RT_LOG(RT_LOG_ERROR, "stream_id=%d alloc task failed, retCode=%#x.",
                    stream->Id_(), static_cast<uint32_t>(error));
                return;
            }

            SaveTaskCommonInfo(tsk, stream, pos);
            (void)ProfilingEnableTaskInit(tsk, static_cast<uint64_t>(pid), profCfg);
            error = DavidSendTask(tsk, stream);
            if (error != RT_ERROR_NONE) {
                TaskUnInitProc(tsk);
                TaskRollBack(stream, pos);
                stream->StreamUnLock();
                RT_LOG(RT_LOG_ERROR, "stream_id=%d send task failed, retCode=%#x.",
                    stream->Id_(), static_cast<uint32_t>(error));
                return;
            }
            stream->StreamUnLock();
        }
    }
}

void ProfStop(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId, const Device * const dev)
{
    RT_LOG(RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u.", profConfig, devId);
    rtProfCfg_t *profCfg = profiler->ProfCfgPtr();
    profCfg->isRtsProfEn = ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) == 0U) ? 0U : 1U;
    profCfg->isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    profCfg->isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;
    profCfg->isHwtsLogEn = ((profConfig & static_cast<uint64_t>(PROF_TASK_TIME_MASK)) == 0ULL) ? 0U : 1U;
    std::function<void()> const retRecycle = [&profiler, &devId]() {
        Runtime::Instance()->SetProfileEnableFlag(profiler->IsEnabled(devId));
    };
    ScopeGuard returnProcess(retRecycle);
    if ((profCfg->isRtsProfEn != 0U) ||(profCfg->isTaskBasedProfEn != 0U) || (profCfg->isProfLogEn != 0U)
        || (profCfg->isHwtsLogEn != 0U)) {
        TaskInfo *tsk = nullptr;
        Stream *stream = dev->PrimaryStream_();
        uint32_t pid;
        (void)dev->Driver_()->DeviceGetBareTgid(&pid);
        if (likely(stream != nullptr)) {
            rtError_t  error = CheckTaskCanSend(stream);
            COND_RETURN_VOID(error != RT_ERROR_NONE, "stream_id=%d check failed, retCode=%#x.",
                stream->Id_(), static_cast<uint32_t>(error));
            uint32_t pos = 0xFFFFU;
            stream->StreamLock();
            error = AllocTaskInfo(&tsk, stream, pos);
            if (error != RT_ERROR_NONE) {
                stream->StreamUnLock();
                RT_LOG(RT_LOG_ERROR, "stream_id=%d alloc task failed, retCode=%#x.",
                    stream->Id_(), static_cast<uint32_t>(error));
                return;
            }
            SaveTaskCommonInfo(tsk, stream, pos);
            (void)ProfilingDisableTaskInit(tsk, static_cast<uint64_t>(pid), profCfg);
            error = DavidSendTask(tsk, stream);
            if (error != RT_ERROR_NONE) {
                TaskUnInitProc(tsk);
                TaskRollBack(stream, pos);
                stream->StreamUnLock();
                RT_LOG(RT_LOG_ERROR, "stream_id=%d send task failed, retCode=%#x.",
                    stream->Id_(), static_cast<uint32_t>(error));
                return;
            }
            stream->StreamUnLock();
            (void)stream->Synchronize();
        }
    }
}

rtError_t DavidAllocAndSendFlipTask(Stream *const stream, uint32_t prePos, uint32_t sqeNum)
{
    if ((!(Runtime::Instance()->GetTrackProfFlag())) || (stream->GetBindFlag())) {
        return RT_ERROR_NONE;
    }

    if ((prePos + sqeNum) < stream->GetSqDepth()) {
        return RT_ERROR_NONE;
    }

    // update flip num
    const uint16_t oriFlipNum = stream->GetTaskIdFlipNum();
    stream->SetTaskIdFlipNum(stream->GetTaskIdFlipNum() + 1U);

    uint32_t pos = 0xFFFFU;
    TaskInfo *tsk = nullptr;
    rtError_t error = AllocTaskInfo(&tsk, stream, pos);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "stream_id=%d alloc task failed, retCode=%#x.", stream->Id_(), error);
        return error;
    }
    SaveTaskCommonInfo(tsk, stream, pos);
    FlipTaskInit(tsk, stream->GetTaskIdFlipNum());
    tsk->stmArgPos = (static_cast<DavidStream *>(stream))->GetArgPos();
    error = DavidSendTask(tsk, stream);
    if (error != RT_ERROR_NONE) {
        TaskUnInitProc(tsk);
        TaskRollBack(stream, pos);
        stream->SetTaskIdFlipNum(oriFlipNum);
        RT_LOG(RT_LOG_ERROR, "stream_id=%d send task failed, retCode=%#x.",
            stream->Id_(), static_cast<uint32_t>(error));
        return error;
    }
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce