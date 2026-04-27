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

#include "context.hpp"
#include "stream.hpp"
#include "device.hpp"
#include "kernel.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "runtime.hpp"
#include "uma_arg_loader.hpp"
#include "profiler.hpp"
#include "capture_model_utils.hpp"
#include "inner_thread_local.hpp"
#include "para_convertor.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtKernelLaunch_CpuArgLoad);

namespace {
rtError_t InternalLaunchWithKernelAndArgs(const Kernel* const kernel, const uint32_t coreDim,
    const rtCpuKernelArgs_t* const cpuKernelArgs, const TaskCfg& taskCfg, Stream* const stm, const uint32_t flag)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    Context* const curCtx = stm->Context_();
    TaskInfo* kernelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernelTask, errorReason);

    ArgLoader* const devArgLdr = curCtx->Device_()->ArgLoader_();
    const rtAicpuArgsEx_t* argsInfo = &cpuKernelArgs->baseArgs;
    const size_t cpuParamHeadOffset = cpuKernelArgs->cpuParamHeadOffset;
    const uint32_t kernelType = kernel->GetAicpuKernelType_();
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    kernelTask->u.aicpuTaskInfo.headParamOffset = static_cast<uint32_t>(cpuParamHeadOffset);
    Kernel* newKernel = new(std::nothrow) Kernel(kernel->GetCpuKernelSo(), kernel->GetCpuFuncName(),
        kernel->GetCpuOpType()); NULL_PTR_GOTO_MSG_INNER(newKernel, ERROR_FREE, error, RT_ERROR_KERNEL_NEW);
    // newKernel申请完毕需要立即绑定到kernelTask上，确保ERROR_FREE能在所有异常分支回收newKernel
    kernelTask->u.aicpuTaskInfo.kernel = newKernel;

    /* 默认使用kernel注册时的devAddr */
    SetNameArgs(kernelTask, kernel->GetSoNameDevAddr(curCtx->Device_()->Id_()),
        kernel->GetFuncNameDevAddr(curCtx->Device_()->Id_()));
    if (argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE || (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernelTask)) {
        ArgLoaderResult result = {};
        TIMESTAMP_BEGIN(rtKernelLaunch_CpuArgLoad);
        error = devArgLdr->LoadCpuKernelArgsEx(argsInfo, stm, &result);
        TIMESTAMP_END(rtKernelLaunch_CpuArgLoad);
        ERROR_GOTO(error, ERROR_FREE, "Failed to load cpu Kernel args, retCode=%#x", error);
        SetAicpuArgs(kernelTask, result.kerArgs, argsInfo->argsSize, result.handle);

        /* 如果aicpuArgsInfo->args中存在soName和kernnelName，则使用args中的devAddr；
         * 否则，使用kernel注册时的devAddr（见StoreKernelLiteralNameToDevice调用的地方）
         * 注：部分场景的cpuLaunch没有kernel注册过程 */
        if ((argsInfo->soNameAddrOffset != 0) || (argsInfo->kernelNameAddrOffset != 0)) {
            SetNameArgs(kernelTask, (RtPtrToPtr<char_t*, void*>(result.kerArgs) + argsInfo->soNameAddrOffset),
                (RtPtrToPtr<char_t*, void*>(result.kerArgs) + argsInfo->kernelNameAddrOffset));
        }
        RT_LOG(RT_LOG_INFO, "Force cpy args device_id=%u, stream_id=%d, task_id=%u.", curCtx->Device_()->Id_(), stm->Id_(),
            kernelTask->id);
    } else {
        kernelTask->u.aicpuTaskInfo.aicpuArgsInfo = const_cast<rtAicpuArgsEx_t*>(argsInfo);
    }

    kernelTask->u.aicpuTaskInfo.aicpuFlags = flag;
    kernelTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(kernelType);
    kernelTask->u.aicpuTaskInfo.timeout = ConvertAicpuTimeout(argsInfo, &taskCfg, flag);
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%u, model_num=%u, NonSupportModelCompile=%u, "
        "isNoNeedH2DCopy=%u, cpuParamHeadOffset=%zu, kernel_type=%u, flag=0x%x, timeout=%" PRIu64
        "us, blkdim=%u.", curCtx->Device_()->Id_(), stm->Id_(), kernelTask->id, stm->GetModelNum(),
        stm->NonSupportModelCompile(), argsInfo->isNoNeedH2DCopy, cpuParamHeadOffset, kernelType, flag,
        kernelTask->u.aicpuTaskInfo.timeout, kernelTask->u.aicpuTaskInfo.comm.dim);
    error = curCtx->Device_()->SubmitTask(kernelTask, curCtx->TaskGenCallback_());

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to submit kernel task, retCode=%#x", error);
    GET_THREAD_TASKID_AND_STREAMID(kernelTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
ERROR_FREE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(kernelTask);
    return error;
}

rtError_t InternalLaunchWithArgs(const uint32_t coreDim, const rtAicpuArgsEx_t* const argsInfo, Stream* const stm,
    const uint32_t flag, const uint32_t kernelType)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    Context* const curCtx = stm->Context_();
    TaskInfo* kernelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernelTask, errorReason);

    const int32_t streamId = stm->Id_();
    ArgLoader* const devArgLdr = curCtx->Device_()->ArgLoader_();
    // Init task
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    if ((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
        (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernelTask)) {
        ArgLoaderResult result{};
        TIMESTAMP_BEGIN(rtKernelLaunch_CpuArgLoad);
        error = devArgLdr->LoadCpuKernelArgsEx(argsInfo, stm, &result);
        TIMESTAMP_END(rtKernelLaunch_CpuArgLoad);
        // Set args for task
        ERROR_GOTO(error, ERROR_FREE, "Failed to load cpu Kernel args , retCode=%#x", error);
        SetAicpuArgs(kernelTask, result.kerArgs, argsInfo->argsSize, result.handle);
        // Set soName and kernelName for task
        const void* kernelSoName = argsInfo->soNameAddrOffset == MAX_UINT32_NUM ? nullptr :
                RtPtrToPtr<const void*>(RtPtrToPtr<char_t*>(result.kerArgs) + argsInfo->soNameAddrOffset);
        SetNameArgs(kernelTask, kernelSoName,
            (RtPtrToPtr<char_t*>(result.kerArgs) + argsInfo->kernelNameAddrOffset));
    } else {
        kernelTask->u.aicpuTaskInfo.aicpuArgsInfo = const_cast<rtAicpuArgsEx_t*>(argsInfo);
    }

    kernelTask->u.aicpuTaskInfo.aicpuFlags = flag;
    kernelTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(kernelType);
    kernelTask->u.aicpuTaskInfo.timeout = ConvertAicpuTimeout(argsInfo, nullptr, flag);
    RT_LOG(RT_LOG_INFO, "Force flag device_id=%u, stream_id=%d, task_id=%u, model_num=%u, NonSupportModelCompile=%u "
        "isNoNeedH2DCopy=%u, kernl_type=%u, flag=0x%x, timeout=%" PRIu64 "us, kernelFlag=0x%x, blkdim=%u",
        curCtx->Device_()->Id_(), streamId, kernelTask->id, stm->GetModelNum(), stm->NonSupportModelCompile(),
        argsInfo->isNoNeedH2DCopy, kernelType, flag, kernelTask->u.aicpuTaskInfo.timeout,
        kernelTask->u.aicpuTaskInfo.comm.kernelFlag, kernelTask->u.aicpuTaskInfo.comm.dim);

    error = curCtx->Device_()->SubmitTask(kernelTask, curCtx->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to submit kernel task, retCode=%#x", error);
    GET_THREAD_TASKID_AND_STREAMID(kernelTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
ERROR_FREE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(kernelTask);
    return error;
}
} // namespace

rtError_t StreamLaunchKernelEx(const void* const args, const uint32_t argsSize, const uint32_t flags, Stream* const stm)
{
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    Context* const curCtx = stm->Context_();
    TaskInfo* kernelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernelTask, errorReason);

    AicpuTaskInit(kernelTask, 1U, flags);
    RT_LOG(RT_LOG_INFO, "kernelFlag=0x%x, blkdim=%u.", kernelTask->u.aicpuTaskInfo.comm.kernelFlag,
        kernelTask->u.aicpuTaskInfo.comm.dim);

    SetAicpuArgs(kernelTask, args, argsSize, nullptr);
    kernelTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(TS_AICPU_KERNEL_FMK);
    kernelTask->u.aicpuTaskInfo.aicpuFlags = flags;

    error = curCtx->Device_()->SubmitTask(kernelTask, curCtx->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit DavinciKernelTask, retCode=%#x.", error);
    GET_THREAD_TASKID_AND_STREAMID(kernelTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(kernelTask);
    return error;
}

rtError_t StreamLaunchCpuKernel(const rtKernelLaunchNames_t* const launchNames, const uint32_t coreDim,
    const rtArgsEx_t* const argsInfo, Stream* const stm, const uint32_t flag, const uint64_t timeout)
{
    UNUSED(timeout);
    rtError_t error = RT_ERROR_NONE;
    Context* const curCtx = stm->Context_();
    ArgLoader* const devArgLdr = curCtx->Device_()->ArgLoader_();
    ArgLoaderResult result{};
    const char_t* const launchSoName = launchNames->soName;
    const char_t* const kernelName = launchNames->kernelName;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernTask, errorReason);
    tsAicpuKernelType aicpuKernelType;
    AicpuTaskInfo* aicpuTaskInfo = nullptr;

    // Init task
    AicpuTaskInit(kernTask, static_cast<uint16_t>(coreDim), flag);

    // Set args for task
    error = devArgLdr->LoadCpuKernelArgs(argsInfo, stm, &result);
    ERROR_GOTO(error, ERROR_FREE, "Failed to load cpu Kernel args , retCode=%#x", error);
    SetAicpuArgs(kernTask, result.kerArgs, argsInfo->argsSize, result.handle);
    // handle is owned by task.
    result.handle = nullptr;

    // Set soName and kernelName for task, host aicpu task use GE svm addr directly
    if (((flag & 0x30U) >> 0x4U) == KERNEL_HOST_AICPU_FLAG) {
        // host aicpu
        SetNameArgs(kernTask, static_cast<const void*>(launchSoName), static_cast<const void*>(kernelName));
    } else {
        void* soNameAddr = nullptr;
        void* kernelNameAddr = nullptr;
        if (launchSoName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(launchSoName, SO_NAME, &soNameAddr);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to get so address by name, retCode=%#x", error);
        }
        if (kernelName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(kernelName, KERNEL_NAME, &kernelNameAddr);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to get kernel address by name, retCode=%#x", error);
        }
        SetNameArgs(kernTask, soNameAddr, kernelNameAddr);
    }

    aicpuTaskInfo = &(kernTask->u.aicpuTaskInfo);
    RT_LOG( RT_LOG_INFO, "device_id=%lu, stream_id=%d, task_id=%hu, flag=%u, kernelFlag=0x%x, blkdim=%u, soName=%s, "
        "kernel_name=%s.", curCtx->Device_()->Id_(), stm->Id_(), kernTask->id, flag, aicpuTaskInfo->comm.kernelFlag,
        aicpuTaskInfo->comm.dim,  launchSoName != nullptr ? launchSoName : "null",
        kernelName != nullptr ? kernelName : "null");

    // Set kernel type and flags
    aicpuKernelType = ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ? TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;
    aicpuTaskInfo->aicpuKernelType = static_cast<uint8_t>(aicpuKernelType);

    // Submit task
    error = curCtx->Device_()->SubmitTask(kernTask, curCtx->TaskGenCallback_());

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to submit kernel task, retCode=%#x", error);
    GET_THREAD_TASKID_AND_STREAMID(kernTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_FREE:
    (void)curCtx->Device_()->GetTaskFactory()->Recycle(kernTask);
    return error;
}

rtError_t StreamLaunchCpuKernelExWithArgs(const uint32_t coreDim, const rtAicpuArgsEx_t* const argsInfo,
    const TaskCfg* const taskCfg, Stream* const stm, const uint32_t flag, const uint32_t kernelType,
    const Kernel* const kernel, const size_t cpuParamHeadOffset)
{
    if (kernel == nullptr) {
        return InternalLaunchWithArgs(coreDim, argsInfo, stm, flag, kernelType);
    }
    rtCpuKernelArgs_t rtCpuKernelArgs = {};
    rtCpuKernelArgs.baseArgs = *argsInfo;
    rtCpuKernelArgs.cpuParamHeadOffset = cpuParamHeadOffset;
    const TaskCfg defaultTaskCfg = {};
    const TaskCfg* cfg = (taskCfg == nullptr) ? &defaultTaskCfg : taskCfg;
    return InternalLaunchWithKernelAndArgs(kernel, coreDim, &rtCpuKernelArgs, *cfg, stm, flag);
}
} // namespace runtime
} // namespace cce
