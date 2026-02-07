/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_c.hpp"
#include "stream_c.hpp"
#include "task_david.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "task_submit.hpp"
#include "stream.hpp"
#include "profiler_c.hpp"
#include "para_convertor.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtKernelLaunch_CpuArgLoad);

static void SetArgsAicpu(const rtArgsEx_t * const argsInfo, const rtAicpuArgsEx_t * const aicpuArgsInfo,
                        TaskInfo * const taskInfo, DavidArgLoaderResult * const result)
{
    AicpuTaskInfo *aicpuTask = &(taskInfo->u.aicpuTaskInfo);
    aicpuTask->comm.args = result->kerArgs;

    if (argsInfo != nullptr) {
        aicpuTask->comm.argsSize = argsInfo->argsSize;
    } else if (aicpuArgsInfo != nullptr) {
        aicpuTask->comm.argsSize = aicpuArgsInfo->argsSize;
        if ((aicpuArgsInfo->soNameAddrOffset != 0U) || (aicpuArgsInfo->kernelNameAddrOffset != 0U)) {
            aicpuTask->soName = (aicpuArgsInfo->soNameAddrOffset == MAX_UINT32_NUM) ? nullptr :
                static_cast<void *>(RtPtrToPtr<char_t *>(aicpuTask->comm.args) + aicpuArgsInfo->soNameAddrOffset);
            aicpuTask->funcName = static_cast<void *>(RtPtrToPtr<char_t *>(aicpuTask->comm.args) +
                aicpuArgsInfo->kernelNameAddrOffset);
        }
    } else {
        // no operation
    }

    if (result->handle != nullptr) {
        aicpuTask->comm.argHandle = result->handle;
        taskInfo->needPostProc = true;
    }
    taskInfo->stmArgPos = static_cast<DavidStream *>(taskInfo->stream)->GetArgPos();
    result->stmArgPos = UINT32_MAX;
    result->handle = nullptr;
}

static rtError_t StreamLaunchKernelExForAicpuStream(const void * const args, const uint32_t argsSize, const uint32_t flags,
    Stream * const stm)
{
    TaskInfo submitTask = {};
    TaskInfo *kernelTask = &submitTask;
    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);
    kernelTask->stream = stm;
    AicpuTaskInit(kernelTask, 1U, flags);
    RT_LOG(RT_LOG_INFO, "kernelFlag=0x%x, blkdim=%u.", aicpuTask->comm.kernelFlag, aicpuTask->comm.dim);
    SetAicpuArgs(kernelTask, args, argsSize, nullptr);

    aicpuTask->aicpuKernelType = static_cast<uint8_t>(TS_AICPU_KERNEL_FMK);
    aicpuTask->aicpuFlags = flags;
    const rtError_t error = ProcAicpuTask(kernelTask);
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error, "stream_id=%d process aicpu task fail.", stm->Id_());
    return RT_ERROR_NONE;
}

rtError_t StreamLaunchKernelEx(const void * const args, const uint32_t argsSize, const uint32_t flags,
    Stream * const stm)
{
    const int32_t streamId = stm->Id_();
    TaskInfo *kernelTask = nullptr;
    if ((stm->Flags() & RT_STREAM_AICPU) != 0U) {
        return StreamLaunchKernelExForAicpuStream(args, argsSize, flags, stm);
    }
    rtError_t error = CheckTaskCanSend(stm);
    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error, "stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&kernelTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(kernelTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&kernelTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(kernelTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    AicpuTaskInit(kernelTask, 1U, flags);
    RT_LOG(RT_LOG_INFO, "flags=%u, kernelFlag=0x%x, blkdim=%u.",
        flags, kernelTask->u.aicpuTaskInfo.comm.kernelFlag, kernelTask->u.aicpuTaskInfo.comm.dim);
    SetAicpuArgs(kernelTask, args, argsSize, nullptr);
    kernelTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);
    aicpuTask->aicpuKernelType = static_cast<uint8_t>(TS_AICPU_KERNEL_FMK);
    aicpuTask->aicpuFlags = flags;
    error = DavidSendTask(kernelTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), kernelTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "kernel launch submit fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t StreamLaunchCpuKernelForAicpuStream(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, Stream * const stm, const uint32_t flag)
{
    ArgLoader * const devArgLdr = stm->Device_()->ArgLoader_();
    const char_t * const launchSoName = launchNames->soName;
    const char_t * const kernelName = launchNames->kernelName;
    const int32_t streamId = stm->Id_();
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    TaskInfo submitTask = {};
    TaskInfo *kernelTask = &submitTask;
    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);
    kernelTask->stream = stm;
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    rtError_t error = davidStm->LoadArgsInfo(argsInfo, false, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args without stm pool, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    SetArgsAicpu(argsInfo, nullptr, kernelTask, &result);
    // Set soName and kernelName for task, host aicpu task use GE svm addr directly
    if (((flag & 0x30U) >> 0x4U) == KERNEL_HOST_AICPU_FLAG) { // host aicpu
        SetNameArgs(kernelTask, static_cast<const void *>(launchSoName), static_cast<const void *>(kernelName));
    } else {
        void *soNameAddr = nullptr;
        void *kernelNameAddr = nullptr;
        if (launchSoName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(launchSoName),
                                                    KernelInfoType::SO_NAME, &soNameAddr);
            ERROR_PROC_RETURN_MSG_INNER(error, StreamLaunchKernelRecycle(result, kernelTask, nullptr, stm);,
                "stream_id=%d failed to get so address by name, retCode=%#x.", streamId, static_cast<uint32_t>(error));
        }
        if (kernelName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(kernelName),
                                                    KernelInfoType::KERNEL_NAME, &kernelNameAddr);
            ERROR_PROC_RETURN_MSG_INNER(error, StreamLaunchKernelRecycle(result, kernelTask, nullptr, stm);,
                "stream_id=%d failed to get kernel address by name, retCode=%#x.",
                streamId, static_cast<uint32_t>(error));
        }
        SetNameArgs(kernelTask, soNameAddr, kernelNameAddr);
    }

    RT_LOG(RT_LOG_INFO, "flag=%u, kernelFlag=0x%x, blkdim=%u, soName=%s, kernel_name=%s.",
        flag, aicpuTask->comm.kernelFlag, aicpuTask->comm.dim, launchSoName != nullptr ? launchSoName : "null",
        kernelName != nullptr ? kernelName : "null");
    const tsAicpuKernelType aicpuKernelType = ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ?
                                              TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;
    aicpuTask->aicpuKernelType = static_cast<uint8_t>(aicpuKernelType);
    error = ProcAicpuTask(kernelTask);
    COND_PROC_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error, StreamLaunchKernelRecycle(result, kernelTask, nullptr, stm);,
        "streamId=%d process aicpu task fail.", streamId);

    return RT_ERROR_NONE;
}

rtError_t StreamLaunchCpuKernel(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, Stream * const stm, const uint32_t flag)
{
    ArgLoader * const devArgLdr = stm->Device_()->ArgLoader_();
    const char_t * const launchSoName = launchNames->soName;
    const char_t * const kernelName = launchNames->kernelName;
    const int32_t streamId = stm->Id_();
    if ((stm->Flags() & RT_STREAM_AICPU) != 0U) {
        return StreamLaunchCpuKernelForAicpuStream(launchNames, coreDim, argsInfo, stm, flag);
    }
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    TaskInfo *kernelTask = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&result, &kernelTask, &stm, &pos, &dstStm]() {
        StreamLaunchKernelRecycle(result, kernelTask, nullptr, stm);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    bool useArgPool = UseArgsPool(davidStm, argsInfo, false);

    stm->StreamLock();
    error = AllocTaskInfoForCapture(&kernelTask, stm, pos, dstStm);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d alloc task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(kernelTask, dstStm, pos);
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    
    error = static_cast<DavidStream *>(dstStm)->LoadArgsInfo(argsInfo, useArgPool, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args, stream_id=%d, useArgPool=%u, retCode=%#x.",
        streamId, useArgPool, static_cast<uint32_t>(error));

    SetArgsAicpu(argsInfo, nullptr, kernelTask, &result);
    // Set soName and kernelName for task, host aicpu task use GE svm addr directly
    if (((flag & 0x30U) >> 0x4U) == KERNEL_HOST_AICPU_FLAG) { // host aicpu
        SetNameArgs(kernelTask, static_cast<const void *>(launchSoName), static_cast<const void *>(kernelName));
    } else {
        void *soNameAddr = nullptr;
        void *kernelNameAddr = nullptr;
        if (launchSoName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(launchSoName),
                                                    KernelInfoType::SO_NAME, &soNameAddr);
            ERROR_RETURN_MSG_INNER(error, "Failed to get so address by name, retCode=%#x.",
                static_cast<uint32_t>(error));
        }
        if (kernelName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(kernelName),
                                                    KernelInfoType::KERNEL_NAME, &kernelNameAddr);
            ERROR_RETURN_MSG_INNER(error, "Failed to get kernel address by name, retCode=%#x.",
                static_cast<uint32_t>(error));
        }
        SetNameArgs(kernelTask, soNameAddr, kernelNameAddr);
    }

    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);
    RT_LOG(RT_LOG_INFO, "flag=%u, kernelFlag=0x%x, blkdim=%u, soName=%s, kernel_name=%s.",
        flag, aicpuTask->comm.kernelFlag, aicpuTask->comm.dim, launchSoName != nullptr ? launchSoName : "null",
        kernelName != nullptr ? kernelName : "null");

    const tsAicpuKernelType aicpuKernelType = ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ?
                                        TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;
    aicpuTask->aicpuKernelType = static_cast<uint8_t>(aicpuKernelType);

    error = DavidSendTask(kernelTask, dstStm);
    ERROR_RETURN_MSG_INNER(error,  "stream_id=%d submit task failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), kernelTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "kernel launch submit fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t StreamLaunchCpuKernelExWithArgsForAicpuStm(const uint32_t coreDim,
    const rtAicpuArgsEx_t * const argsInfo, const TaskCfg * const taskCfg,
    Stream * const stm, const uint32_t flag, const uint32_t kernelType)
{
    const int32_t streamId = stm->Id_();
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    TaskInfo submitTask = {};
    TaskInfo *kernelTask = &submitTask;
    kernelTask->stream = stm;
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    rtError_t error = davidStm->LoadArgsInfo(argsInfo, false, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args without stm pool, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    SetArgsAicpu(nullptr, argsInfo, kernelTask, &result);
    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);

    aicpuTask->aicpuFlags = flag;
    aicpuTask->aicpuKernelType = static_cast<uint8_t>(kernelType);
    aicpuTask->timeout = ConvertAicpuTimeout(argsInfo, taskCfg, flag);
    RT_LOG(RT_LOG_INFO, "kernel type=%u, flag=0x%x, timeout=%hus, kernelFlag=0x%x, blkdim=%u.",
        kernelType, flag, aicpuTask->timeout, aicpuTask->comm.kernelFlag, aicpuTask->comm.dim);
    error = ProcAicpuTask(kernelTask);
    ERROR_PROC_RETURN_MSG_INNER(error, StreamLaunchKernelRecycle(result, kernelTask, nullptr, stm);,
        "stream_id=%d process aicpu task fail.", streamId);
    return RT_ERROR_NONE;
}

static void SetTaskInfo(TaskInfo *kernelTask, const rtAicpuArgsEx_t * const argsInfo, Kernel *newKernel,
    const TaskCfg * const taskCfg, const AicpuTaskInfo &tmpTaskInfo)
{
    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);
    aicpuTask->kernel = newKernel;
    aicpuTask->aicpuFlags = tmpTaskInfo.aicpuFlags;
    aicpuTask->aicpuKernelType = tmpTaskInfo.aicpuKernelType;
    aicpuTask->timeout = ConvertAicpuTimeout(argsInfo, taskCfg, tmpTaskInfo.aicpuFlags);
    aicpuTask->headParamOffset = tmpTaskInfo.headParamOffset;
    RT_LOG(RT_LOG_INFO, "kernel type=%u, flag=0x%x, timeout=%hus, kernelFlag=0x%x, blkdim=%u, headParamOffset=%u.", 
        tmpTaskInfo.aicpuKernelType, tmpTaskInfo.aicpuFlags, aicpuTask->timeout, aicpuTask->comm.kernelFlag,  
        aicpuTask->comm.dim, aicpuTask->headParamOffset);
}

rtError_t StreamLaunchCpuKernelExWithArgs(const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo,
    const TaskCfg * const taskCfg, Stream * const stm, const uint32_t flag, const uint32_t kernelType,
    const Kernel * const kernel, const size_t cpuParamHeadOffset)
{
    if ((stm->Flags() & RT_STREAM_AICPU) != 0U) {
        return StreamLaunchCpuKernelExWithArgsForAicpuStm(coreDim, argsInfo, taskCfg, stm, flag, kernelType);
    }
    const int32_t streamId = stm->Id_();
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    TaskInfo *kernelTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    bool useArgPool = UseArgsPool(davidStm, argsInfo, false);
    Kernel *newKernel = nullptr;
    if (kernel != nullptr) {
        newKernel =  new (std::nothrow) Kernel(kernel->GetCpuKernelSo(), kernel->GetCpuFuncName(), kernel->GetCpuOpType());
        NULL_PTR_RETURN_MSG(newKernel, RT_ERROR_KERNEL_NEW);
    }

    Stream *dstStm = stm;
    uint32_t pos = 0xFFFFU;
    std::function<void()> const errRecycle = [&result, &kernelTask, &stm, &pos, &dstStm]() {
        StreamLaunchKernelRecycleAicpu(result, kernelTask, nullptr, stm);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&kernelTask, stm, pos, dstStm);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(newKernel);, "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    SaveTaskCommonInfo(kernelTask, dstStm, pos);
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    error = static_cast<DavidStream *>(dstStm)->LoadArgsInfo(argsInfo, useArgPool, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args, stream_id=%d, useArgPool=%u, retCode=%#x.",
        streamId, useArgPool, static_cast<uint32_t>(error));
    /* 默认使用kernel注册时的devAddr */
    if (kernel != nullptr) {
        SetNameArgs(kernelTask, kernel->GetSoNameDevAddr(stm->Device_()->Id_()), kernel->GetFuncNameDevAddr(stm->Device_()->Id_()));
    }

    SetArgsAicpu(nullptr, argsInfo, kernelTask, &result);
    AicpuTaskInfo tmpTaskInfo = {{}, nullptr, nullptr, nullptr, nullptr, nullptr, flag, 
        static_cast<uint32_t>(cpuParamHeadOffset), 0, static_cast<uint8_t>(kernelType), 0};
    SetTaskInfo(kernelTask, argsInfo, newKernel, taskCfg, tmpTaskInfo);
    error = DavidSendTask(kernelTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), kernelTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "kernel launch submit fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce