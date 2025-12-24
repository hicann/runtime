/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stub_task.hpp"
#include "notify.hpp"
#include "task.hpp"
#include "profiler.hpp"
#include "stream_factory.hpp"

namespace cce {
namespace runtime {

TaskInfo* GetTaskInfo(const Device * const dev, uint32_t streamId, uint32_t id)
{
    return dev->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), static_cast<uint16_t>(id));
}

rtError_t TaskReclaimByStream(const Stream *const stm, const bool limited, const bool needLog)
{
    UNUSED(stm);
    UNUSED(limited);
    UNUSED(needLog);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t StreamLaunchCpuKernel(const rtKernelLaunchNames_t *const launchNames, const uint32_t coreDim,
    const rtArgsEx_t *const argsInfo, Stream *const stm, const uint32_t flag)
{
    UNUSED(launchNames);
    UNUSED(coreDim);
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void ProfStart(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId, const Device * const dev)
{
    profiler->TsProfilerStart(profConfig, devId, const_cast<Device*>(dev));
    return;
}

void ProfStop(Profiler * const profiler, const uint64_t profConfig, const uint32_t devId, const Device * const dev)
{
    profiler->TsProfilerStop(profConfig, devId, const_cast<Device*>(dev));
    return;
}

rtError_t SetTimeoutConfigTaskSubmitStarsV2(Stream * const stm, const rtTaskTimeoutType_t type, const uint32_t timeout)
{
    UNUSED(stm);
    UNUSED(type);
    UNUSED(timeout);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t AicpuMdlDestroy(Model * const mdl)
{
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ModelSubmitExecuteTask(Model * const mdl, Stream * const streamIn)
{
    UNUSED(streamIn);
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ModelLoadCompleteByStream(Model * const mdl)
{
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t MdlBindTaskSubmit(Model * const mdl, Stream * const streamIn,
    const uint32_t flag)
{
    UNUSED(flag);
    UNUSED(streamIn);
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t MdlUnBindTaskSubmit(Model * const mdl, Stream * const streamIn,
    const bool force)
{
    UNUSED(force);
    UNUSED(streamIn);
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NtyWait(Notify * const inNotify, Stream * const streamIn, const uint32_t timeOut)
{
    return inNotify->Wait(streamIn, timeOut);
}

rtError_t SyncGetDevMsg(Device * const dev, const void * const devMemAddr, const uint32_t devMemSize,
                                 const rtGetDevMsgType_t getDevMsgType)
{
    // new a stream for get exception info
    std::unique_ptr<Stream, void(*)(Stream*)> stm(StreamFactory::CreateStream(dev, 0U),
                                                  [](Stream* ptr) {ptr->Destructor();});
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, stm == nullptr, RT_ERROR_STREAM_NEW, "new Stream failed.");
    rtError_t error = stm->Setup();
    ERROR_RETURN_MSG_INNER(error, "stream setup failed, retCode=%#x.", static_cast<uint32_t>(error));
    const std::function<void()> streamTearDownFunc = [&stm]() {
        const auto ret = (stm->TearDown());
        // Disable thread stream destroy task will delete stream
        // other condition, we should delete stream here
        Runtime * const rtIntsance = Runtime::Instance();
        // Disable thread free in stream destroy task recycle, stream destroy task send in TearDown process.
        if ((ret == RT_ERROR_NONE) && (!rtIntsance->GetDisableThread())) {
            (void)stm.release();
        }
    };
    const ScopeGuard devErrMsgStreamRelease(streamTearDownFunc);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = stm.get()->AllocTask(&submitTask, TS_TASK_TYPE_GET_DEVICE_MSG, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    // init RT_GET_DEV_ERROR_MSG task
    error = GetDevMsgTaskInit(tsk, devMemAddr, devMemSize, getDevMsgType);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                ((void)dev->GetTaskFactory()->Recycle(tsk));,
                                "Failed to init task, stream_id=%d, task_id=%hu, retCode=%#x.",
                                stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    // submit task
    error = dev->SubmitTask(tsk);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                ((void)dev->GetTaskFactory()->Recycle(tsk));,
                                "Failed to submit task, retCode=%#x, device id=%u",
                                static_cast<uint32_t>(error), dev->Id_());
    // stream synchronize
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize stream, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t SyncGetDeviceMsg(Device * const dev, const void * const devMemAddr, const uint32_t devMemSize,
    const rtGetDevMsgType_t getDevMsgType)
{
    return SyncGetDevMsg(dev, devMemAddr, devMemSize, getDevMsgType);
}

rtError_t ProcRingBufferTaskStarsV2(const Device *const dev, const void * const devMem, const bool delFlag,
    const uint32_t len)
{
    UNUSED(dev);
    UNUSED(devMem);
    UNUSED(delFlag);
    UNUSED(len);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t TaskReclaimAllStream(const Device * const dev)
{
    UNUSED(dev);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateTimeoutConfigTaskSubmitStarsV2(Stream * const stm, const RtTimeoutConfig &timeoutConfig)
{
    UNUSED(stm);
    UNUSED(timeoutConfig);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void RegStarsV2TaskFunc(void)
{
    return;
}

int32_t GetTaskIdBitWidth()
{
    constexpr int32_t taskIdBitWidthForObp = 16;
    return taskIdBitWidthForObp;
}

const char_t* TaskIdDesc()
{
    return "task_id";
}

const char_t* TaskIdCamelbackNaming()
{
    return "taskId";
}

void PrintStarsCqeInfo(const rtLogicCqReport_t &cqe, const uint32_t devId, const uint32_t cqId)
{
    RT_LOG(RT_LOG_DEBUG, "device_id=%u,stream_id=%hu,task_id=%hu,cq_id=%u,sqe_type=%hhu",
        devId, cqe.streamId, cqe.taskId, cqId, cqe.sqeType);
    return;
}

uint32_t GetProfTaskId(const TaskInfo * const taskInfo)
{
    return GetFlipTaskId(static_cast<uint32_t>(taskInfo->id), taskInfo->flipNum);
}

}  // namespace runtime
}  // namespace cce