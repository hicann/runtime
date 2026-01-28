/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aix_c.hpp"
#include "stream_c.hpp"
#include "task_david.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "task_submit.hpp"
#include "stream.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "profiler_c.hpp"
#include "stars_david.hpp"
#include "memory_task.h"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoad);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandle_SubMit);
TIMESTAMP_EXTERN(rtLaunchKernel_SubMit);

rtError_t CheckAndGetTotalShareMemorySize(const Kernel * const kernel, uint32_t dynamicShareMemSize, uint32_t &simtDcuSmSize)
{
    /*
        aic only - 1982:      校验dynamicSmSize必须是0, sqe中dcuSmSize=256K
        simd     - 1982&1952: 校验compilerAllocUbSize+dynamicSmSize<=256K, sqe中dcuSmSize=256K
        simt     - 1982&1952: 校验compilerAllocUbSize+dynamicSmSize+dcache(32K)<=256K, sqe中dcuSmSize=compilerAllocUbSize+dynamicSmSize
    */
    bool canUseSimt = (kernel->KernelVfType_() != 0);
    bool simtFlag = (kernel->KernelVfType_() == static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY)) ||
                    (kernel->KernelVfType_() == static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMD_SIMT_MIX_VF));
    uint32_t totalSmSize = kernel->ShareMemSize_() + dynamicShareMemSize;
    uint32_t maxSmSize = simtFlag ? RT_SIMT_REMAIN_UB_SIZE : RT_SIMT_UB_SIZE;
    maxSmSize = canUseSimt ? maxSmSize : 0U;
    /* simt dcu_size should 128 Byte align */
    totalSmSize = simtFlag ? ((totalSmSize + RT_SIMT_SHARE_MEM_ALIGN_LEN - 1)/ RT_SIMT_SHARE_MEM_ALIGN_LEN * RT_SIMT_SHARE_MEM_ALIGN_LEN)
                  : totalSmSize;
    // aic only operator not check now
    if (canUseSimt && (totalSmSize > maxSmSize)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "The size of the dynamic shared memory is %uB, and the size of the"
                         " shared memory required by the operator kernel is %uB. The sum of these two sizes must be less than %uB.",
                         dynamicShareMemSize, kernel->ShareMemSize_(), maxSmSize);
        return RT_ERROR_INVALID_VALUE;
    }

    simtDcuSmSize = simtFlag ? totalSmSize: RT_SIMT_UB_SIZE;
    return RT_ERROR_NONE;
}

static rtError_t CheckDynSizeValid(TaskInfo* taskInfo, const Kernel * const kernel)
{
    if ((taskInfo == nullptr) || (kernel == nullptr)) {
        return RT_ERROR_NONE;
    }

    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    return CheckAndGetTotalShareMemorySize(kernel, aicTaskInfo->dynamicShareMemSize, aicTaskInfo->simtDcuSmSize);
}

static void SetArgsAix(const rtArgsEx_t * const argsInfo, TaskInfo * const taskInfo, DavidArgLoaderResult * const result)
{
    AicTaskInfo *aicTask = &(taskInfo->u.aicTaskInfo);
    aicTask->comm.argsSize = argsInfo->argsSize;
    aicTask->comm.args = result->kerArgs;
    // only for aclgraph
    aicTask->oldArgHandle = aicTask->comm.argHandle;
    if (result->handle != nullptr) {
        aicTask->comm.argHandle = result->handle;
        taskInfo->needPostProc = true;
    }
    taskInfo->stmArgPos = static_cast<DavidStream *>(taskInfo->stream)->GetArgPos();
    result->stmArgPos = UINT32_MAX;
    result->handle = nullptr;
}

static rtError_t UpdateDavidKernelPrepare(TaskInfo * const updateTask, void ** const hostAddr, const uint64_t allocSize)
{
    Stream * const dstStream = updateTask->stream;
    const uint32_t devId = static_cast<uint32_t>(dstStream->Device_()->Id_());
    Driver * const driver = dstStream->Device_()->Driver_();
    rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX] = {};
    rtDavidSqe_t *sqe = davidSqe;
    /* alloc host memory */
    rtError_t error = driver->HostMemAlloc(hostAddr, allocSize, devId);
    ERROR_RETURN_MSG_INNER(error, "alloc host memory failed, retCode=%#x.", static_cast<uint32_t>(error));

    /* construct new sqe */
    RT_LOG(RT_LOG_INFO, "update normal kernel, device_id=%u, stream_id=%d, task_id=%hu",
        devId, dstStream->Id_(), updateTask->id);

    /* 同时适用于AIC、AIV、MIX(AIC + AIV) kernel */
    const uint64_t sqBaseAddr = dstStream->GetSqBaseAddr();
    ToConstructDavidSqe(updateTask, sqe, sqBaseAddr);
    error = driver->MemCopySync(*hostAddr, allocSize, static_cast<const void *>(sqe),
                                allocSize, RT_MEMCPY_HOST_TO_HOST);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        (void)driver->HostMemFree(*hostAddr),
        "MemCopySync failed, retCode=%#x.", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

void FreeTempHostAddr(const Stream * const stm, void * const hostAddr)
{
    if ((unlikely(stm == nullptr)) || (unlikely(hostAddr == nullptr))) {
        return;
    }

    stm->Device_()->Driver_()->HostMemFree(hostAddr);
}

rtError_t UpdateDavidKernelTaskSubmit(TaskInfo * const updateTask, Stream * const stm, uint32_t sqeLen)
{
    Driver * const curDrv = stm->Device_()->Driver_();
    void *srcHostAddr = nullptr;
    uint64_t allocSize = sizeof(rtDavidSqe_t) * sqeLen;

    // 将updateTask转成sqe，并拷贝放到host svm内存中
    rtError_t error = UpdateDavidKernelPrepare(updateTask, &srcHostAddr, allocSize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "prepare failed, device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            stm->Device_()->Id_(), stm->Id_(), allocSize, static_cast<uint32_t>(error));
        return error;
    }

    TaskInfo *rtMemcpyAsyncTask = nullptr;
    uint32_t pos = 0xFFFFU;
    std::function<void()> const errRecycle = [&rtMemcpyAsyncTask, &stm, &pos, &srcHostAddr]() {
        TaskUnInitProc(rtMemcpyAsyncTask);
        TaskRollBack(stm, pos);
        FreeTempHostAddr(stm, srcHostAddr);
    };

    // 申请memcpyAsync task
    const uint32_t sqeNum = GetSqeNumForMemcopyAsync(RT_MEMCPY_HOST_TO_DEVICE);
    error = AllocTaskInfo(&rtMemcpyAsyncTask, stm, pos, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, (void)curDrv->HostMemFree(srcHostAddr);,
                                "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));

    ScopeGuard tskErrRecycle(errRecycle);
    // 赋值memcpyAsync task
    SaveTaskCommonInfo(rtMemcpyAsyncTask, stm, pos, sqeNum);
    // 初始化memcpyAsyncTask
    (void)MemcpyAsyncTaskCommonInit(rtMemcpyAsyncTask);
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo);
    memcpyAsyncTaskInfo->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_H2D);
    memcpyAsyncTaskInfo->copyKind = static_cast<uint32_t>(RT_MEMCPY_HOST_TO_DEVICE);
    memcpyAsyncTaskInfo->size = allocSize;
    memcpyAsyncTaskInfo->src = srcHostAddr;
    memcpyAsyncTaskInfo->isSqeUpdateH2D = true;
    memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;

    // PCIE场景下通过驱动将目标更新的sqe addr转成dmaAddr，UB场景下通过驱动获取DWQE
    error = ConvertAsyncDma(rtMemcpyAsyncTask, updateTask, true);
    ERROR_RETURN_MSG_INNER(error, "ConvertAsyncDma failed, retCode=%#x.", static_cast<uint32_t>(error));
    rtMemcpyAsyncTask->needPostProc = true;

    if (updateTask->type == TS_TASK_TYPE_FUSION_KERNEL) {
       memcpyAsyncTaskInfo->releaseArgHandle = updateTask->u.fusionKernelTask.oldArgHandle;
        updateTask->u.fusionKernelTask.oldArgHandle = nullptr;
    } else {
       memcpyAsyncTaskInfo->releaseArgHandle = updateTask->u.aicTaskInfo.oldArgHandle;
        updateTask->u.aicTaskInfo.oldArgHandle = nullptr;
    }

    error = DavidSendTask(rtMemcpyAsyncTask, stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, pos=%u, retCode=%#x.",
        stm->Id_(), pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();

    return RT_ERROR_NONE;
}

static rtError_t CheckUpdateDavidTaskInfo(const TaskInfo * const updateTask, const Kernel * const kernel,
                                          const uint32_t kernelType, const Stream * const stm)
{
    if (updateTask->stream->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update task must be a sinked task, stream_id=%d, task_id=%hu.",
               updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_MODEL_NULL;
    }

    if (stm->Model_() != nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update stream must be a single operator stream, "
            "stream_id=%d, task_id=%hu.",
            updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_STREAM_MODEL;
    }

    if ((updateTask->u.aicTaskInfo.kernel->GetMixType() != kernel->GetMixType()) ||
        (updateTask->u.aicTaskInfo.kernel->GetFuncType() != kernel->GetFuncType()) ||
        (updateTask->u.aicTaskInfo.machine != static_cast<uint8_t>(kernelType))) {
        RT_LOG(RT_LOG_ERROR, "check kernel type failed, stream_id=%d, task_id=%hu, "
            "old mixType=%u, funcType=%u, machine=%u, "
            "new mixType=%u, funcType=%u, machine=%u.",
            updateTask->stream->Id_(), updateTask->id, updateTask->u.aicTaskInfo.kernel->GetMixType(),
            updateTask->u.aicTaskInfo.kernel->GetFuncType(), updateTask->u.aicTaskInfo.machine,
            kernel->GetMixType(), kernel->GetFuncType(), kernelType);
        return RT_ERROR_KERNEL_TYPE;
    }

    return RT_ERROR_NONE;
}

rtError_t StreamLaunchKernelV1(const void * const stubFunc, const uint32_t coreDim, const rtArgsEx_t *argsInfo,
    Stream *stm, const uint32_t flag, const rtTaskCfgInfo_t * const cfgInfo)
{
    uint32_t kernelType = 0U;
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    uint8_t mixType = NO_MIX;
    Program *prog = nullptr;
    Module *launchMdl = nullptr;
    Kernel *registeredKernel = nullptr;
    Runtime * const rt = Runtime::Instance();
    TaskInfo *kernelTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    TaskCfg taskCfg = {};
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    error = StreamLaunchKernelPrepare(stm, registeredKernel, prog, kernelType, launchMdl, stubFunc,
                                      addr1, addr2, nullptr, 0);
    COND_RETURN_ERROR_MSG_INNER((error == RT_ERROR_KERNEL_NULL) || (error == RT_ERROR_PROGRAM_NULL), error, "kernel launch kernel prepare failed.");
    ERROR_PROC_RETURN_MSG_INNER(error, rt->PutProgram(prog);, "launch kernel prepare failed.");
    mixType = registeredKernel->GetMixType();
    error = CheckMixKernelValid(mixType, addr2);
    ERROR_PROC_RETURN_MSG_INNER(error, rt->PutProgram(prog);,
        "Mix kernel check failed, stream_id=%d, kernelType=%u, retCode=%#x.", stm->Id_(), kernelType, static_cast<uint32_t>(error));

    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    bool useArgPool = UseArgsPool(davidStm, argsInfo, stm->IsTaskGroupUpdate());
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&result, &kernelTask, &prog, &stm, &pos, &dstStm]() {
        StreamLaunchKernelRecycle(result, kernelTask, prog, stm);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };

    stm->StreamLock();
    error = AllocTaskInfoForCapture(&kernelTask, stm, pos, dstStm, 1U, true);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));

    if (kernelTask->isUpdateSinkSqe == 1U) { // 此处失败，仅本次任务不更新，但继续保留老任务
        error = CheckUpdateDavidTaskInfo(kernelTask, registeredKernel, kernelType, stm);
        ERROR_RETURN_MSG_INNER(error, "stream_id=%d, kernelType=%u, retCode=%#x.", stm->Id_(), kernelType,
                               static_cast<uint32_t>(error));
    } else {
        SaveTaskCommonInfo(kernelTask, dstStm, pos);
    }

    if (cfgInfo != nullptr) {
        taskCfg.isBaseValid = 1U;
        taskCfg.base = *cfgInfo;
    }
    AicTaskInit(kernelTask, kernelType, static_cast<uint16_t>(coreDim), flag, &taskCfg, false);
    // for simt
    error = CheckDynSizeValid(kernelTask, registeredKernel);
    ERROR_RETURN_MSG_INNER(error, "Failed to check SimtSmSize, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    error = davidStm->LoadArgsInfo(argsInfo, useArgPool, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args, stream_id=%d, useArgPool=%u, retCode=%#x.",
        stm->Id_(), useArgPool, static_cast<uint32_t>(error));
    SetArgsAix(argsInfo, kernelTask, &result);
    AicTaskInfo *aicTask = &(kernelTask->u.aicTaskInfo);
    aicTask->kernel = const_cast<Kernel *>(registeredKernel);
    aicTask->funcAddr = addr1;
    aicTask->funcAddr1 = addr2;
    aicTask->progHandle = prog;
    RT_LOG(RT_LOG_INFO, "stream_id=%d, kernel_name=%s, kernelType=%u, funcType=%u, arg_size=%u, taskRation=%u, "
        "mixType=%hhu, kernelVfType=%u, dynamicSmSize=%u, addr1=0x%llx, addr2=0x%llx, "
        "flag=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%u.",
        stm->Id_(), registeredKernel->Name_().c_str(), kernelType, registeredKernel->GetFuncType(),
        argsInfo->argsSize, registeredKernel->GetTaskRation(), mixType,
        registeredKernel->KernelVfType_(), aicTask->dynamicShareMemSize, addr1, addr2,
        flag, aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
        aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex);

    if (kernelTask->isUpdateSinkSqe == 1U) {
        error = UpdateDavidKernelTaskSubmit(kernelTask, stm);
        if ((error != RT_ERROR_NONE) && (kernelTask->u.aicTaskInfo.oldArgHandle != nullptr)) {
            if (davidStm->ArgManagePtr() != nullptr) {
                davidStm->ArgManagePtr()->RecycleDevLoader(kernelTask->u.aicTaskInfo.oldArgHandle);
            }
        }
        kernelTask->u.aicTaskInfo.oldArgHandle = nullptr;
        kernelTask->isUpdateSinkSqe = 0U;
    } else {
        error = DavidSendTask(kernelTask, dstStm);
    }
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), kernelTask->taskSn);
    rt->PutProgram(prog);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "kernel launch submit fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t StreamLaunchKernelWithHandle(void * const progHandle, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t *argsInfo, Stream *stm, const uint32_t flag, const rtTaskCfgInfo_t * const cfgInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(progHandle, RT_ERROR_PROGRAM_NULL);

    uint32_t kernelType = 0U;
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    Program *prog = nullptr;
    Module *launchMdl = nullptr;
    uint32_t taskRation = 0U;
    uint32_t funcType = 0U;
    std::string name = "";
    uint32_t kernelVfType = 0U;
    Kernel *registeredKernel = nullptr;
    Runtime * const rt = Runtime::Instance();
    TaskInfo *kernelTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    TaskCfg taskCfg = {};
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    error = StreamLaunchKernelPrepare(stm, registeredKernel, prog, kernelType, launchMdl, nullptr,
                                    addr1, addr2, progHandle, tilingKey);
    COND_RETURN_ERROR_MSG_INNER((error == RT_ERROR_KERNEL_NULL) || (error == RT_ERROR_PROGRAM_NULL), error,
        "kernel launch kernel prepare failed.");
    ERROR_PROC_RETURN_MSG_INNER(error, rt->PutProgram(prog);, "launch kernel prepare failed.");
    if (tilingKey != DEFAULT_TILING_KEY) {
        mixType = registeredKernel->GetMixType();
        taskRation = registeredKernel->GetTaskRation();
        funcType = registeredKernel->GetFuncType();
        name = registeredKernel->Name_();
        kernelVfType = registeredKernel->KernelVfType_();
    }
    error = CheckMixKernelValid(mixType, addr2);
    ERROR_PROC_RETURN_MSG_INNER(error, rt->PutProgram(prog);,
        "Mix kernel check failed, stream_id=%d, kernelType=%u, retCode=%#x.", stm->Id_(),
        kernelType, static_cast<uint32_t>(error));
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    bool useArgPool = UseArgsPool(davidStm, argsInfo, stm->IsTaskGroupUpdate());
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&result, &kernelTask, &prog, &stm, &pos, &dstStm]() {
        StreamLaunchKernelRecycle(result, kernelTask, prog, stm);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&kernelTask, stm, pos, dstStm, 1U, true);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));

    if (kernelTask->isUpdateSinkSqe == 1U) {
        error = CheckUpdateDavidTaskInfo(kernelTask, registeredKernel, kernelType, stm);
        ERROR_RETURN_MSG_INNER(error, "stream_id=%d, kernelType=%u, retCode=%#x.", stm->Id_(), kernelType,
                               static_cast<uint32_t>(error));
    } else {
        SaveTaskCommonInfo(kernelTask, dstStm, pos);
    }

    if (cfgInfo != nullptr) {
        taskCfg.isBaseValid = 1U;
        taskCfg.base = *cfgInfo;
    }
    AicTaskInit(kernelTask, kernelType, static_cast<uint16_t>(coreDim), flag, &taskCfg, false);
    error = CheckDynSizeValid(kernelTask, registeredKernel);
    ERROR_RETURN_MSG_INNER(error, "Failed to check SimtSmSize, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    error = davidStm->LoadArgsInfo(argsInfo, useArgPool, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args, stream_id=%d, useArgPool=%u, retCode=%#x.",
        stm->Id_(), useArgPool, static_cast<uint32_t>(error));
    AicTaskInfo *aicTask = &(kernelTask->u.aicTaskInfo);
    aicTask->kernel = const_cast<Kernel *>(registeredKernel);
    aicTask->progHandle = (prog != nullptr) ? prog : RtPtrToPtr<Program *>(progHandle);
    aicTask->tilingKey = tilingKey;
    SetArgsAix(argsInfo, kernelTask, &result);
    aicTask->funcAddr = addr1;
    aicTask->funcAddr1 = addr2;
    RT_LOG(RT_LOG_INFO, "stream_id=%d, kernel_name=%s, kernelType=%u, funcType=%u, "
           "arg_size=%u, mixType=%u, taskRation=%u, kernelVfType=%u, dynamicSmSize=%u, addr1=0x%llx, addr2=0x%llx, "
           "flag=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%u.",
           stm->Id_(), name.c_str(), kernelType, funcType, argsInfo->argsSize, mixType, taskRation,
           kernelVfType, aicTask->dynamicShareMemSize, addr1, addr2, flag, aicTask->comm.kernelFlag, aicTask->qos,
           aicTask->partId, aicTask->schemMode, aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex);
    if (kernelTask->isUpdateSinkSqe == 1U) {
        error = UpdateDavidKernelTaskSubmit(kernelTask, stm);
        if ((error != RT_ERROR_NONE) && (kernelTask->u.aicTaskInfo.oldArgHandle != nullptr)) {
            if (davidStm->ArgManagePtr() != nullptr) {
                davidStm->ArgManagePtr()->RecycleDevLoader(kernelTask->u.aicTaskInfo.oldArgHandle);
            }
        }
        kernelTask->u.aicTaskInfo.oldArgHandle = nullptr;
    } else {
        error = DavidSendTask(kernelTask, dstStm);
    }
    ERROR_RETURN_MSG_INNER(error,  "stream_id=%d submit task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), kernelTask->taskSn);
    rt->PutProgram(prog);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "kernel launch submit fail, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static void AicTaskInitByExtendAgrs(TaskInfo *kernelTask, const uint32_t kernelType, const uint32_t coreDim,
    const rtStreamLaunchKernelV2ExtendArgs_t * const extendAgrs)
{
    if (extendAgrs->launchTaskCfg != nullptr) {
        AicTaskInitV2(kernelTask, kernelType, static_cast<uint16_t>(coreDim), 0, extendAgrs->launchTaskCfg);
        return;
    }
    if (extendAgrs->taskCfg != nullptr) {
        AicTaskInit(kernelTask, kernelType, static_cast<uint16_t>(coreDim), 0, extendAgrs->taskCfg, false);
        return;
    }
    TaskCfg taskCfg_ = {};
    if (extendAgrs->cfgInfo != nullptr) {
        taskCfg_.isBaseValid = 1U;
        taskCfg_.base = *(extendAgrs->cfgInfo);
    }
    AicTaskInit(kernelTask, kernelType, static_cast<uint16_t>(coreDim), 0, &taskCfg_, false);
}

rtError_t StreamLaunchKernelV2(Kernel * const kernel, const uint32_t coreDim, Stream *stm,
    const rtStreamLaunchKernelV2ExtendArgs_t * const extendAgrs)
{
    Program * const prog = kernel->Program_();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);

    uint64_t kernelPc1 = 0ULL;
    uint64_t kernelPc2 = 0ULL;
    const uint8_t mixType = kernel->GetMixType();
    const uint32_t kernelType = kernel->KernelType_();
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    TaskInfo *kernelTask = nullptr;

    COND_RETURN_ERROR((extendAgrs == nullptr), RT_ERROR_INVALID_VALUE, "Launch kernel failed, extendAgrs is nullptr.");
    const rtArgsEx_t *argsInfo = extendAgrs->argsInfo;
    COND_RETURN_ERROR((argsInfo == nullptr), RT_ERROR_INVALID_VALUE, "Launch kernel failed, argsInfo is nullptr.");

    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    error = kernel->GetFunctionDevAddr(kernelPc1, kernelPc2);
    ERROR_RETURN_MSG_INNER(error, "Launch kernel failed, get function address failed.");

    error = CheckMixKernelValid(mixType, kernelPc2);
    ERROR_RETURN_MSG_INNER(error, "Mix kernel check failed, stream_id=%d, kernelType=%u, retCode=%#x.",
        stm->Id_(), kernelType, static_cast<uint32_t>(error));
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    bool useArgPool = UseArgsPool(davidStm, argsInfo, stm->IsTaskGroupUpdate());

    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&result, &kernelTask, &stm, &pos, &dstStm]() {
        StreamLaunchKernelRecycle(result, kernelTask, nullptr, stm);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&kernelTask, stm, pos, dstStm, 1U, true);
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    if (kernelTask->isUpdateSinkSqe == 1U) {
        error = CheckUpdateDavidTaskInfo(kernelTask, kernel, kernelType, stm);
        ERROR_RETURN_MSG_INNER(error, "stream_id=%d, kernelType=%u, retCode=%#x.", stm->Id_(), kernelType,
                               static_cast<uint32_t>(error));
    } else {
        SaveTaskCommonInfo(kernelTask, dstStm, pos);
    }
    AicTaskInitByExtendAgrs(kernelTask, kernelType, coreDim, extendAgrs);

    error = CheckDynSizeValid(kernelTask, kernel);
    ERROR_RETURN_MSG_INNER(error, "Failed to SetSimtSmSize, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    error = davidStm->LoadArgsInfo(argsInfo, useArgPool, &result);
    ERROR_RETURN_MSG_INNER(error, "Failed to load args, stream_id=%d, useArgPool=%u, retCode=%#x.",
        stm->Id_(), useArgPool, static_cast<uint32_t>(error));
    AicTaskInfo *aicTask = &(kernelTask->u.aicTaskInfo);
    aicTask->kernel = const_cast<Kernel *>(kernel);
    aicTask->progHandle = prog;
    aicTask->funcAddr = kernelPc1;
    aicTask->funcAddr1 = kernelPc2;
    SetArgsAix(argsInfo, kernelTask, &result);

    RT_LOG(RT_LOG_INFO, "stream_id=%d, kernel_name=%s, kernelType=%u, funcType=%u, arg_size=%u, "
        "coreDim=%u, taskRation=%u, kernelVfType=%u, dynamicSmSize=%u, addr1=0x%llx, addr2=0x%llx, "
        "kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%u, "
        "groupDim=%u, groupBlockDim=%u.",
        stm->Id_(), kernel->Name_().c_str(), kernelType, kernel->GetFuncType(), argsInfo->argsSize,
        coreDim, kernel->GetTaskRation(), kernel->KernelVfType_(),
        aicTask->dynamicShareMemSize, kernelPc1, kernelPc2, aicTask->comm.kernelFlag, aicTask->qos,
        aicTask->partId, aicTask->schemMode, aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex,
        aicTask->groupDim, aicTask->groupBlockDim);

    if (kernelTask->isUpdateSinkSqe == 1U) {
        error = UpdateDavidKernelTaskSubmit(kernelTask, stm);
        if ((error != RT_ERROR_NONE) && (kernelTask->u.aicTaskInfo.oldArgHandle != nullptr)) {
            if (davidStm->ArgManagePtr() != nullptr) {
                davidStm->ArgManagePtr()->RecycleDevLoader(kernelTask->u.aicTaskInfo.oldArgHandle);
            }
        }
        kernelTask->u.aicTaskInfo.oldArgHandle = nullptr;
    } else {
        error = DavidSendTask(kernelTask, dstStm);
    }
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d submit task failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), kernelTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "kernel launch submit fail, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ConstructStreamLaunchKernelV2ExtendArgs(const rtArgsEx_t *argsInfo,
    const rtTaskCfgInfo_t * const cfgInfo, const LaunchTaskCfgInfo_t * const launchTaskCfg,
    const TaskCfg * const taskCfg, rtStreamLaunchKernelV2ExtendArgs_t *extendArgs)
{
    COND_RETURN_ERROR(extendArgs == nullptr, RT_ERROR_INVALID_VALUE, "extendArgs is nullptr.");
    extendArgs->argsInfo = argsInfo;
    extendArgs->cfgInfo = cfgInfo;
    extendArgs->launchTaskCfg = launchTaskCfg;
    extendArgs->taskCfg = taskCfg;
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
