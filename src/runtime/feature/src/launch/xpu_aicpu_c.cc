/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "xpu_aicpu_c.hpp"
#include "task_xpu.hpp"
#include "stream_xpu.hpp"
#include "error_message_manage.hpp"
#include "kernel.hpp"
#include "inner_thread_local.hpp"
#include "stream_xpu_c.hpp"

namespace cce {
namespace runtime {

static rtError_t XpuStreamLaunchCpuKernelExWithArgs(const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo,
    Stream * const stm, const Kernel * const kernel)
{
    constexpr uint32_t flag = RT_KERNEL_DEFAULT;
    const int32_t streamId = stm->Id_();
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    TaskInfo *kernelTask = nullptr;
    rtError_t error = XpuCheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    XpuStream *xpuStm = static_cast<XpuStream *>(stm);
    Kernel *newKernel =  new (std::nothrow) Kernel(kernel->GetCpuKernelSo(), kernel->GetCpuFuncName(), kernel->GetCpuOpType());
    NULL_PTR_RETURN_MSG(newKernel, RT_ERROR_KERNEL_NEW);
    newKernel->SetKernelLiteralNameDevAddr(nullptr, kernel->GetFuncNameDevAddr(stm->Device_()->Id_()), stm->Device_()->Id_());

    bool useArgPool = true;
    if ((!xpuStm->GetIsHasArgPool()) || (argsInfo->argsSize > XPU_ARG_POOL_COPY_SIZE)) {
        useArgPool = false;
    }
    uint32_t pos = 0xFFFFU;
    std::function<void()> const errRecycle = [&result, &kernelTask, &stm, &pos]() {
        XpuStreamLaunchKernelRecycleAicpu(result, kernelTask, stm);
        XpuTaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = XpuAllocTaskInfo(&kernelTask, stm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(newKernel);, "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    XpuSaveTaskCommonInfo(kernelTask, stm, pos);
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    error = xpuStm->LoadArgsInfo(argsInfo, useArgPool, &result);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(newKernel);, "Failed to load args, stream_id=%d, useArgPool=%u, retCode=%#x.",
        streamId, useArgPool, static_cast<uint32_t>(error));

    XpuSetArgsAicpu(argsInfo, kernelTask, &result);
    // new kernel need post proc
    kernelTask->needPostProc = true;
    AicpuTaskInfo *aicpuTask = &(kernelTask->u.aicpuTaskInfo);
    aicpuTask->kernel = newKernel;
    aicpuTask->aicpuFlags = flag;
    aicpuTask->aicpuKernelType = static_cast<uint8_t>(kernel->KernelType_());
    aicpuTask->timeout = argsInfo->timeout;
    RT_LOG(RT_LOG_INFO, "kernel type=%u, flag=0x%x, timeout=%hus, kernelFlag=0x%x, blkdim=%u, argsSize=%u.", kernel->KernelType_(),
           flag, aicpuTask->timeout, aicpuTask->comm.kernelFlag, aicpuTask->comm.dim, argsInfo->argsSize);
    error = XpuSendTask(kernelTask, stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(stm->Id_(), kernelTask->taskSn);
    return RT_ERROR_NONE;
}

rtError_t XpuLaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
    Stream * const stm, const TaskCfg &taskCfg)
{
    COND_RETURN_ERROR_MSG_INNER(kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU,
        RT_ERROR_INVALID_VALUE,
        "Xpu Kernel launch only supports AICPU operators, the kernel type is %d.",
        kernel->GetKernelRegisterType());
    COND_RETURN_ERROR_MSG_INNER(argsWithType->type != RT_ARGS_CPU_EX,
        RT_ERROR_INVALID_VALUE,
        "Xpu Kernel launch only supports AICPU operators, the args type is %d.",
        argsWithType->type);
    COND_RETURN_ERROR_MSG_INNER(taskCfg.base.dumpflag != 0,
        RT_ERROR_INVALID_VALUE,
        "Xpu Kernel launch does not support dump.");
    
    RT_LOG(RT_LOG_DEBUG,
        "launch kernel V2, device_id=%u, stream_id=%d, blockDim=%u, argsType=%u.",
        stm->Device_()->Id_(),
        stm->Id_(),
        blockDim,
        static_cast<uint32_t>(argsWithType->type));

    const rtError_t error = XpuStreamLaunchCpuKernelExWithArgs(blockDim,
        &argsWithType->args.cpuArgsInfo->baseArgs,
        stm,
        kernel);

    ERROR_RETURN_MSG_INNER(
        error, "Cpu kernel launch ex with args failed, error=%#x.", error);
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
