/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aix_c.hpp"

#include <cinttypes>
#include <functional>
#include <new>

#include "capture_model_utils.hpp"
#include "context.hpp"
#include "davinci_kernel_task.h"
#include "inner_thread_local.hpp"
#include "task_info_v100.h"
#include "memory_task.h"
#include "stream_task.h"
#include "osal.hpp"
#include "profiler.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "kernel_utils.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtKernelLaunch_KernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_ALLKernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_GetModule);
TIMESTAMP_EXTERN(rtKernelLaunch_AllocTask);
TIMESTAMP_EXTERN(rtKernelLaunch_SubmitTask);
TIMESTAMP_EXTERN(rtKernelLaunch_PutProgram);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoad);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadForMix);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAll);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAllForMix);
TIMESTAMP_EXTERN(rtLaunchKernel_ArgLoadAll);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandle_SubMit);
TIMESTAMP_EXTERN(rtLaunchKernel_SubMit);

namespace {
rtError_t InternalLaunchKernelPrepare(Context * const ctx, Kernel *&registeredKernel, Program *&prog,
    rtKernelAttrType &kernelAttrType, Module *&mdl, const void * const stubFunc, uint64_t &addr1, uint64_t &addr2,
    void * const progHandle, const uint64_t tilingKey, uint32_t &prefetchCnt1, uint32_t &prefetchCnt2)
{
    Device * const device = ctx->Device_();
    rtError_t error = RT_ERROR_NONE;

    if (progHandle == nullptr) {
        Runtime * const rt = Runtime::Instance();
        TIMESTAMP_BEGIN(rtKernelLaunch_KernelLookup);
        registeredKernel = rt->kernelTable_.Lookup(stubFunc);
        RT_LOG(RT_LOG_DEBUG, "launch kernel, registeredKernel=%s",
            (registeredKernel != nullptr) ? registeredKernel->Name_().c_str() : "(none)");
        TIMESTAMP_END(rtKernelLaunch_KernelLookup);
    } else {
        TIMESTAMP_BEGIN(rtKernelLaunch_ALLKernelLookup);
        Program * const programHdl = (static_cast<Program *>(progHandle));
        registeredKernel = (tilingKey == DEFAULT_TILING_KEY) ? nullptr : programHdl->AllKernelLookup(tilingKey);
        RT_LOG(RT_LOG_DEBUG, "launch kernel handle, tilingKey=%" PRIu64 ", registeredKernel=%" PRIu64,
            tilingKey, (registeredKernel != nullptr) ? registeredKernel->TilingKey() : 0UL);
        TIMESTAMP_END(rtKernelLaunch_ALLKernelLookup);
    }
    // 如果tiling key为默认值，则依赖tilingKey的信息做默认值初始化
    if (tilingKey == DEFAULT_TILING_KEY) {
        prog = nullptr;
        kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE;
        if (device->GetDevProperties().enabledTSNum == ENABLED_TS_NUM_2) {
            const uint32_t tsId = device->DevGetTsId();
            COND_RETURN_ERROR_MSG_INNER((((kernelAttrType == RT_KERNEL_ATTR_TYPE_AICORE) ||
                (kernelAttrType == RT_KERNEL_ATTR_TYPE_CUBE)) && (tsId == 1U)) ||
                ((kernelAttrType == RT_KERNEL_ATTR_TYPE_VECTOR) && (tsId == 0U)), RT_ERROR_PROGRAM_MACHINE_TYPE,
                "Launch kernel failed, current ts doesn't support the task! type=%d, tsid=%u.", kernelAttrType, tsId);
        }
        addr1 = 0ULL;
        addr2 = 0ULL;
        prefetchCnt1 = 0U;
        prefetchCnt2 = 0U;

        return RT_ERROR_NONE;
    }

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_TBE, (registeredKernel == nullptr), RT_ERROR_KERNEL_NULL,
        "Can not find kernel by function[0x%" PRIx64"], tilingKey=%" PRIu64 ".",
        RtPtrToValue<const void *>(stubFunc), tilingKey);

    TIMESTAMP_BEGIN(rtKernelLaunch_GetModule);
    prog = registeredKernel->Program_();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);
    COND_RETURN_ERROR_MSG_INNER((progHandle != nullptr) && (prog != RtPtrToPtr<Program *, void *>(progHandle)),
        RT_ERROR_PROGRAM_BASE, "Kernel prog is not belong to the launch prog.");

    kernelAttrType = registeredKernel->GetKernelAttrType();
    COND_RETURN_ERROR_MSG_INNER(static_cast<uint32_t>(kernelAttrType) == RT_KERNEL_ATTR_TYPE_INVALID,
        RT_ERROR_PROGRAM_MACHINE_TYPE,
        "Launch kernel failed, kernelAttrType failed! invalid type, current kernelAttrType=%d,"
        " valid kernelAttrType range is [%u, %u].",
        kernelAttrType, RT_KERNEL_ATTR_TYPE_AICORE, RT_KERNEL_ATTR_TYPE_MIX);
    COND_RETURN_ERROR_MSG_INNER(kernelAttrType == RT_KERNEL_ATTR_TYPE_AICPU,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "Launch kernel failed, not support CCE Aicpu kernel task, kernelAttrType=%d.", kernelAttrType);

    if (device->GetDevProperties().enabledTSNum == ENABLED_TS_NUM_2) {
        const uint32_t tsId = device->DevGetTsId();
        COND_RETURN_ERROR_MSG_INNER((((kernelAttrType == RT_KERNEL_ATTR_TYPE_AICORE) ||
            (kernelAttrType == RT_KERNEL_ATTR_TYPE_CUBE)) && (tsId == 1U)) ||
            ((kernelAttrType == RT_KERNEL_ATTR_TYPE_VECTOR) && (tsId == 0U)), RT_ERROR_PROGRAM_MACHINE_TYPE,
            "Launch kernel failed, current ts doesn't support the task! type=%d, tsid=%u.", kernelAttrType, tsId);
    }
    mdl = ctx->GetModule(prog);
    TIMESTAMP_END(rtKernelLaunch_GetModule);
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODULE_NEW);

    // Function always return RT_ERROR_NONE, modify for KernelLaunch performance optimization
    const Kernel *kernel = registeredKernel;
    (void)mdl->GetFunction(kernel, &addr1, &addr2);
    (void)mdl->GetPrefetchCnt(kernel, prefetchCnt1, prefetchCnt2);
    return error;
}

rtError_t InternalUpdateTaskPrepare(const Context * const ctx, TaskInfo * const updateTask,
    const Kernel * const kernel, const Stream * const stm)
{
    Device * const device = ctx->Device_();
    COND_RETURN_ERROR(stm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "The stream used for updating task cannot be in capture status, device_id=%u, stream_id=%d",
        device->Id_(), stm->Id_());

    if (updateTask->stream->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update task must be a sinked task, device_id=%u, stream_id=%d, task_id=%hu.",
            device->Id_(), updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_MODEL_NULL;
    }

    if (stm->Model_() != nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update stream must be a single operator stream, "
            "device_id=%u, stream_id=%d, task_id=%hu.",
            device->Id_(), updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_STREAM_MODEL;
    }

    if ((updateTask->u.aicTaskInfo.kernel->GetMixType() != kernel->GetMixType()) ||
        (updateTask->u.aicTaskInfo.kernel->GetFuncType() != kernel->GetFuncType()) ||
        (updateTask->u.aicTaskInfo.kernel->GetKernelAttrType() != kernel->GetKernelAttrType())) {
        RT_LOG(RT_LOG_ERROR, "check kernel type failed, device_id=%u, stream_id=%d, task_id=%hu, "
            "old mixType=%u, funcType=%u, kernelAttrType=%d, "
            "new mixType=%u, funcType=%u, kernelAttrType=%d.",
            device->Id_(), updateTask->stream->Id_(), updateTask->id, updateTask->u.aicTaskInfo.kernel->GetMixType(),
            updateTask->u.aicTaskInfo.kernel->GetFuncType(), updateTask->u.aicTaskInfo.kernel->GetKernelAttrType(),
            kernel->GetMixType(), kernel->GetFuncType(), kernel->GetKernelAttrType());
        return RT_ERROR_KERNEL_TYPE;
    }

    if (updateTask->u.aicTaskInfo.kernel->GetMixType() == NO_MIX) {
        if (!(device->CheckFeatureSupport(TS_FEATURE_CAPTURE_SQE_UPDATE))) {
            RT_LOG(RT_LOG_ERROR, "current ts version does not support update no mix op, kernel name=%s, "
                "drv devId=%u, stream_id=%d, task_id=%hu.",
                kernel->Name_().c_str(), device->Id_(), updateTask->stream->Id_(), updateTask->id);
            return RT_ERROR_DRV_NOT_SUPPORT_UPDATE_OP;
        }
        updateTask->u.aicTaskInfo.updateSqeOffset = 0U;
    }

    return RT_ERROR_NONE;
}

rtError_t InternalUpdateMixKernelTask(const Context * const ctx, TaskInfo * const updateTask, Stream * const stm,
    void * const updateArgHandle)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    void *hostAddr = nullptr;
    constexpr uint64_t copySize = CONTEXT_LEN;
    Device * const device = ctx->Device_();
    Driver * const curDrv = stm->Device_()->Driver_();
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    void *dstContextAddr = aicTaskInfo->descAlignBuf;
    void *oldArgHandle = aicTaskInfo->oldArgHandle;

    TaskInfo *rtMemcpyAsyncTask =
        stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = MixKernelUpdatePrepare(updateTask, &hostAddr, copySize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device->Id_(), stm->Id_(), copySize, error);
        goto ERROR_RECYCLE;
    }

    error = SqeUpdateH2DTaskInit(rtMemcpyAsyncTask, hostAddr, dstContextAddr, copySize, oldArgHandle, updateArgHandle);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device->Id_(), stm->Id_(), copySize, error);
        (void)curDrv->HostMemFree(hostAddr);
        goto ERROR_RECYCLE;
    }

    // oldArgHandle will be released by releaseArgHandle of the H2D task
    aicTaskInfo->oldArgHandle = nullptr;

    error = device->SubmitTask(rtMemcpyAsyncTask, ctx->TaskGenCallback_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device->Id_(), stm->Id_(), copySize, error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t InternalUpdateNormalKernelTaskH2DSubmitComm(const Context * const ctx, TaskInfo * const updateTask,
    Stream * const stm, void * const targetAddrOfUpdatedSqe, void * const updateArgHandle)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    constexpr uint64_t allocSize = sizeof(rtStarsSqe_t);
    Device * const device = ctx->Device_();
    Driver * const curDrv = stm->Device_()->Driver_();
    void *hostAddr = nullptr;
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    void *oldArgHandle = aicTaskInfo->oldArgHandle;

    TaskInfo *rtMemcpyAsyncTask =
        stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = NormalKernelUpdatePrepare(updateTask, &hostAddr, allocSize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "prepare failed, device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    error = SqeUpdateH2DTaskInit(rtMemcpyAsyncTask, hostAddr, targetAddrOfUpdatedSqe, allocSize, oldArgHandle, updateArgHandle);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device->Id_(), stm->Id_(), allocSize, error);
        (void)curDrv->HostMemFree(hostAddr);
        goto ERROR_RECYCLE;
    }

    // oldArgHandle will be released by releaseArgHandle of the H2D task
    aicTaskInfo->oldArgHandle = nullptr;

    error = device->SubmitTask(rtMemcpyAsyncTask, ctx->TaskGenCallback_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t InternalUpdateNormalKernelTaskH2DSubmit(const Context * const ctx, TaskInfo * const updateTask,
    Stream * const stm, void * const updateArgHandle)
{
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    return InternalUpdateNormalKernelTaskH2DSubmitComm(
        ctx, updateTask, stm, aicTaskInfo->sqeDevBuf, updateArgHandle);
}

rtError_t InternalUpdateNormalKernelTaskD2HSubmit(const Context * const ctx, TaskInfo * const updateTask,
    Stream * const stm)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    constexpr size_t allocSize = sizeof(rtStarsSqe_t);
    const size_t copySize = allocSize - updateTask->u.aicTaskInfo.updateSqeOffset;
    void *sqeDevBuf = updateTask->u.aicTaskInfo.sqeDevBuf;
    const uint32_t sqId = updateTask->stream->GetSqId();
    const uint32_t pos = updateTask->pos;
    Device * const device = ctx->Device_();

    TaskInfo *rtMemcpyAsyncTask =
        stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = UpdateD2HTaskInit(rtMemcpyAsyncTask, sqeDevBuf, copySize, sqId, pos,
        updateTask->u.aicTaskInfo.updateSqeOffset);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    error = device->SubmitTask(rtMemcpyAsyncTask, ctx->TaskGenCallback_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t InternalUpdateNormalKernelTaskForSoftwareSq(const Context * const ctx, TaskInfo * const updateTask,
    Stream * const stm, void * const updateArgHandle)
{
    if (updateTask->stream->GetSqBaseAddr() == 0ULL) {
        /*
         * normal capture mode场景：SqBaseAddr在CaptureModel::SendSqe()函数中申请，即在CaptureModel执行前申请SqMem
         * 但存在update task在capture mode执行前下发的场景，需要提前申请SqMem
         * 预留的CAPTURE_TASK_RESERVED_NUM(32)个SQE用于CaptureModel执行时申请的LoadComplete等SQE
         */
        const rtError_t ret = updateTask->stream->AllocSoftwareSqAddr(
            CAPTURE_TASK_RESERVED_NUM + ctx->Device_()->GetDevProperties().expandStreamRsvTaskNum);
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "AllocSoftwareSqAddr failed. device_id=%u, stream_id=%d, "
            "retCode=%#x,", ctx->Device_()->Id_(), updateTask->stream->Id_(), ret);
    }

    void *targetAddrOfUpdatedSqe =
        RtValueToPtr<void *>(updateTask->stream->GetSqBaseAddr() + (updateTask->pos * sizeof(rtStarsSqe_t)));
    return InternalUpdateNormalKernelTaskH2DSubmitComm(
        ctx, updateTask, stm, targetAddrOfUpdatedSqe, updateArgHandle);
}

rtError_t InternalUpdateNormalKernelTaskByTS(const Context * const ctx, TaskInfo * const updateTask,
    Stream * const stm, void * const updateArgHandle)
{
    rtError_t errorReason;
    TaskInfo submitTask = {};
    TaskInfo *kernTask = nullptr;
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_TASK_SQE_UPDATE, errorReason, 1U,
        UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d,"
        " retCode=%#x.", stm->Id_(), errorReason);
    std::function<void()> const kernTaskRecycle = [ctx, kernTask]() {
        (void)ctx->Device_()->GetTaskFactory()->Recycle(kernTask);
    };
    ScopeGuard taskGuarder(kernTaskRecycle);

    errorReason = SqeUpdateTaskInit(kernTask, updateTask, updateArgHandle);
    COND_RETURN_WITH_NOLOG((errorReason != RT_ERROR_NONE), errorReason);
    errorReason = ctx->Device_()->SubmitTask(kernTask, ctx->TaskGenCallback_());
    COND_RETURN_WITH_NOLOG((errorReason != RT_ERROR_NONE), errorReason);

    GET_THREAD_TASKID_AND_STREAMID(kernTask, stm->AllocTaskStreamId());
    taskGuarder.ReleaseGuard();
    return RT_ERROR_NONE;
}

rtError_t InternalUpdateNormalKernelTask(const Context * const ctx, TaskInfo * const updateTask, Stream * const stm,
    void * const updateArgHandle)
{
    Device * const device = ctx->Device_();
    rtError_t error = RT_ERROR_NONE;
    if (!Runtime::Instance()->ChipIsHaveStars()) {
        error = InternalUpdateNormalKernelTaskByTS(ctx, updateTask, stm, updateArgHandle);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "submit SqeUpdate task failed, device_id=%u, stream_id=%d, retCode=%#x.",
                device->Id_(), stm->Id_(), error);
        }
        return error;
    }
    if (updateTask->stream->IsSoftwareSqEnable()) {
        error = InternalUpdateNormalKernelTaskForSoftwareSq(ctx, updateTask, stm, updateArgHandle);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "submit D2H task failed, device_id=%u, stream_id=%d, retCode=%#x.",
                device->Id_(), stm->Id_(), error);
        }
        return error;
    }

    error = InternalUpdateNormalKernelTaskH2DSubmit(ctx, updateTask, stm, updateArgHandle);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "submit H2D task failed, device_id=%u, stream_id=%d, retCode=%#x.",
            device->Id_(), stm->Id_(), error);
        return error;
    }

    error = InternalUpdateNormalKernelTaskD2HSubmit(ctx, updateTask, stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "submit D2H task failed, device_id=%u, stream_id=%d, retCode=%#x.",
            device->Id_(), stm->Id_(), error);
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t InternalLaunchUpdateKernelSubmit(const Context * const ctx, TaskInfo * const updateTask, Stream * const stm,
    const rtArgsEx_t * const argsInfo, StarsArgLoaderResult &result)
{
    Runtime * const rt = Runtime::Instance();
    const Program * const programPtr = updateTask->u.aicTaskInfo.kernel->Program_();
    ArgLoader * const argLoaderObj = ctx->Device_()->ArgLoader_();
    Model *model = updateTask->stream->Model_();
    void *updateArgHandle = result.handle;
    if (result.handle != nullptr) {
        /* get old argHandle */
        void *oldArgHandle = model->GetArgHandle(static_cast<uint16_t>(updateTask->stream->Id_()), updateTask->id);
        updateTask->u.aicTaskInfo.oldArgHandle = oldArgHandle;

        /* update argHandle */
        SetArgs(updateTask, result.kerArgs, argsInfo->argsSize, nullptr);
        model->ReplaceArgHandle(static_cast<uint32_t>(updateTask->stream->Id_()), updateTask->id, result.handle);
        result.handle = nullptr;
    }

    rtError_t error = RT_ERROR_NONE;
    if (updateTask->u.aicTaskInfo.kernel->GetMixType() != NO_MIX) {
        error = InternalUpdateMixKernelTask(ctx, updateTask, stm, updateArgHandle);
    } else {
        error = InternalUpdateNormalKernelTask(ctx, updateTask, stm, updateArgHandle);
    }

    if ((error != RT_ERROR_NONE) && (updateTask->u.aicTaskInfo.oldArgHandle != nullptr)) {
        (void)argLoaderObj->Release(updateTask->u.aicTaskInfo.oldArgHandle);
    }

    updateTask->u.aicTaskInfo.oldArgHandle = nullptr;

    ERROR_RETURN_MSG_INNER(error, "Failed to submit kernel update task, device_id=%u, stream_id=%d, task_id=%hu, "
        "retCode=%#x.", ctx->Device_()->Id_(), updateTask->stream->Id_(), updateTask->id, error);

    rt->PutProgram(programPtr);
    updateTask->isUpdateSinkSqe = 0U;
    return error;
}

rtError_t InternalLaunchKernelSubmit(const Context * const ctx, TaskInfo *&submitTask, Stream *&stm,
    const rtArgsEx_t *&argsInfo, StarsArgLoaderResult &result, const Program * const programPtr)
{
    SetKernelLaunchParams(stm, argsInfo, *submitTask);
    if (submitTask->isUpdateSinkSqe == 1U) {
        return InternalLaunchUpdateKernelSubmit(ctx, submitTask, stm, argsInfo, result);
    }

    Runtime * const rt = Runtime::Instance();
    const uint32_t realArgsSize = argsInfo->argsSize;

    // Function always return RT_ERROR_NONE, modify for KernelLaunch performance optimization
    if (result.handle != nullptr) {
        SetAicoreArgs(submitTask, result.kerArgs, realArgsSize, result.handle);
        result.handle = nullptr;
    }

    TIMESTAMP_BEGIN(rtKernelLaunch_SubmitTask);
    const rtError_t error = ctx->Device_()->SubmitTask(submitTask, ctx->TaskGenCallback_());
    TIMESTAMP_END(rtKernelLaunch_SubmitTask);

    ERROR_RETURN_MSG_INNER(error, "Failed to submit kernel task, retCode=%#x.", error);
    GET_THREAD_TASKID_AND_STREAMID(submitTask, stm->AllocTaskStreamId());
    TIMESTAMP_BEGIN(rtKernelLaunch_PutProgram);
    rt->PutProgram(programPtr);
    TIMESTAMP_END(rtKernelLaunch_PutProgram);

    return error;
}

void InternalLaunchKernelRecycle(const Context * const ctx, StarsArgLoaderResult &result, TaskInfo *&recycleTask,
    const Program * const prog)
{
    rtError_t error = RT_ERROR_NONE;
    Runtime * const rt = Runtime::Instance();

    if (result.handle != nullptr) {
        error = ctx->Device_()->ArgLoader_()->Release(result.handle);
        COND_LOG(error != RT_ERROR_NONE, "argloader release failed, retCode=%#x.", error);
        result.handle = nullptr;
    }

    if (recycleTask != nullptr) {
        if (recycleTask->isUpdateSinkSqe == 0U) {
            (void)ctx->Device_()->GetTaskFactory()->Recycle(recycleTask);
            recycleTask = nullptr;
        } else {
            recycleTask->isUpdateSinkSqe = 0U;
        }
    }

    rt->PutProgram(prog);
}

}  // namespace

rtError_t StreamLaunchKernelV2(Kernel *kernel, const uint32_t coreDim, Stream *stm,
    const rtStreamLaunchKernelV2ExtendArgs_t *extendAgrs, const bool isLaunchVec)
{
    Context * const ctx = stm->Context_();
    Device * const device = ctx->Device_();
    const rtArgsEx_t *argsInfo = extendAgrs->argsInfo;
    TaskInfo submitTask = {};
    uint64_t kernelPc1 = 0ULL;
    uint64_t kernelPc2 = 0ULL;
    uint8_t mixType = NO_MIX;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    TaskInfo *kernTask = nullptr;
    rtError_t error = RT_ERROR_NONE;
    StarsArgLoaderResult result = {};
    Program *refProg = nullptr;
    Program * const prog = kernel->Program_();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);

    error = kernel->GetFunctionDevAddr(kernelPc1, kernelPc2);
    ERROR_RETURN_MSG_INNER(error, "Launch kernel failed, get function address failed.");
    rtKernelAttrType kernelAttrType = kernel->GetKernelAttrType();
    AicTaskInfo *aicTask = nullptr;
    bool copyFlag = true;
    bool mixOpt = false;
    rtError_t errorReason;
    bool isNeedAllocSqeDevBuf = false;

    TIMESTAMP_BEGIN(rtKernelLaunch_AllocTask);
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason, 1U, UpdateTaskFlag::SUPPORT);
    TIMESTAMP_END(rtKernelLaunch_AllocTask);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d."
        " retCode=%#x.", stm->Id_(), errorReason);

    error = GetPrefetchCntAndMixTypeWithKernel(kernel, prefetchCnt1, prefetchCnt2, mixType);
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX)) {
        mixType = static_cast<uint8_t>(NO_MIX);
    }

    if (kernTask->isUpdateSinkSqe == 1U) {
        error = InternalUpdateTaskPrepare(ctx, kernTask, kernel, stm);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
            "Check kernel task failed, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Id_(), kernTask->id, error);
    }

    if ((mixType != NO_MIX) && (device->ArgLoader_()->CheckPcieBar()) &&
        (argsInfo->argsSize <= (PCIE_BAR_COPY_SIZE - CONTEXT_ALIGN_LEN)) && !stm->NonSupportModelCompile() &&
        !(stm->IsTaskGrouping()) && (kernTask->isUpdateSinkSqe == 0U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadAllForMix);
        error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_MIX);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadAllForMix);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Mix Failed to load args, stream_id=%d,"
            " retCode=%#x.", stm->Id_(), error);
        mixOpt = (stm->GetModelNum() == 0U);
        copyFlag = false;
    } else if (((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
               (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernTask)) ||
               (kernTask->isUpdateSinkSqe == 1U)) {
        TIMESTAMP_BEGIN(rtLaunchKernel_ArgLoadAll);
        error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_NO_MIX);
        TIMESTAMP_END(rtLaunchKernel_ArgLoadAll);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to load args, stream_id=%d, retCode=%#x.",
            stm->Id_(), error);
        copyFlag = false;
    } else {
        // do nothing
    }
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX)) {
        TransDavinciTaskToVectorCore(stm->Flags(), kernelPc2, kernelPc1, mixType, kernelAttrType, isLaunchVec);
    }
    error = CheckMixKernelValid(mixType, kernelPc2);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Mix kernel check failed, stream_id=%d, task_id=%hu, kernelAttrType=%d, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelAttrType, error);

    COND_PROC(((kernTask->isUpdateSinkSqe == 1U) && (!(kernTask->stream->IsSoftwareSqEnable()))),
        isNeedAllocSqeDevBuf = true);

    AicTaskInit(kernTask, kernel, kernelAttrType, static_cast<uint16_t>(coreDim), extendAgrs->taskCfg,
        isNeedAllocSqeDevBuf);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Init kernel task failed, stream_id=%d, task_id=%hu, kernelAttrType=%d, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelAttrType, error);

    aicTask = &kernTask->u.aicTaskInfo;
    if (copyFlag) {
        aicTask->argsInfo = const_cast<rtArgsEx_t *>(argsInfo);
    }

    aicTask->mixOpt = mixOpt;
    aicTask->funcAddr = kernelPc1;
    aicTask->kernel = kernel;
    aicTask->progHandle = prog;
    aicTask->funcAddr1 = kernelPc2;
    kernel->SetPrefetchCnt1_(prefetchCnt1);
    kernel->SetPrefetchCnt2_(prefetchCnt2);

    RT_LOG(RT_LOG_INFO, "kernel info : device_id=%u, stream_id=%d, task_id=%hu, kernelAttrType=%d, kernel_name=%s, "
        "arg_size=%u, coreDim=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
        "mixType=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%lu, "
        "prefetchCnt1=%u, prefetchCnt2=%u, isNoNeedH2DCopy=%u.",
        device->Id_(), stm->Id_(), kernTask->id, kernelAttrType, kernel->Name_().c_str(),
        argsInfo->argsSize, coreDim, kernel->GetTaskRation(), kernel->GetFuncType(), kernelPc1, kernelPc2,
        mixType, aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
        aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex,
        prefetchCnt1, prefetchCnt2, argsInfo->isNoNeedH2DCopy);

    TIMESTAMP_BEGIN(rtLaunchKernel_SubMit);
    error = InternalLaunchKernelSubmit(ctx, kernTask, stm, argsInfo, result, nullptr);
    TIMESTAMP_END(rtLaunchKernel_SubMit);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "kernel launch submit failed.");
    return RT_ERROR_NONE;

ERROR_FREE:
    InternalLaunchKernelRecycle(ctx, result, kernTask, refProg);
    return error;
}

rtError_t UpdateTaskPrepare(const Context *ctx, TaskInfo *updateTask, const Kernel *kernel, const Stream *stm)
{
    return InternalUpdateTaskPrepare(ctx, updateTask, kernel, stm);
}

rtError_t LaunchUpdateKernelSubmit(const Context *ctx, TaskInfo *updateTask, Stream *stm, const rtArgsEx_t *argsInfo,
    StarsArgLoaderResult &result)
{
    return InternalLaunchUpdateKernelSubmit(ctx, updateTask, stm, argsInfo, result);
}

rtError_t StreamLaunchKernelV1(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t *argsInfo, Stream *stm, const TaskCfg * const taskCfg, const bool isLaunchVec)
{
    Context * const ctx = stm->Context_();
    rtError_t error = RT_ERROR_NONE;
    rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE;
    StarsArgLoaderResult result = {};
    bool copyFlag = true;
    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    uint8_t mixType = NO_MIX;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernTask = nullptr;
    AicTaskInfo *aicTask = nullptr;
    Program *prog = nullptr;
    Module *launchMdl = nullptr;
    bool mixOpt = false;
    Kernel *registeredKernel = nullptr;
    bool isNeedAllocSqeDevBuf = false;
    Device * const device = ctx->Device_();
    const bool noMixFlag = device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX);

    TIMESTAMP_BEGIN(rtKernelLaunch_AllocTask);
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason, 1U, UpdateTaskFlag::SUPPORT);
    TIMESTAMP_END(rtKernelLaunch_AllocTask);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), errorReason);

    error = InternalLaunchKernelPrepare(ctx, registeredKernel, prog, kernelAttrType, launchMdl, stubFunc, addr1, addr2,
        nullptr, 0ULL, prefetchCnt1, prefetchCnt2);
    COND_PROC_RETURN_ERROR_MSG_INNER((error == RT_ERROR_MEMORY_ADDRESS_UNALIGNED) || (error == RT_ERROR_KERNEL_NULL),
        error, InternalLaunchKernelRecycle(ctx, result, kernTask, nullptr);, "kernel launch kernel prepare failed.");
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "launch kernel prepare failed.");

    mixType = registeredKernel->GetMixType();
    if (noMixFlag) {
        // both 51dc aic aiv not support mixtype
        mixType = static_cast<uint8_t>(NO_MIX);
    }

    if (kernTask->isUpdateSinkSqe == 1U) {
        error = InternalUpdateTaskPrepare(ctx, kernTask, registeredKernel, stm);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
            "Check kernel task failed, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Id_(), kernTask->id, error);
    }

    if ((mixType != static_cast<uint8_t>(NO_MIX)) && (device->ArgLoader_()->CheckPcieBar()) &&
        (argsInfo->argsSize <= (PCIE_BAR_COPY_SIZE - static_cast<uint32_t>(CONTEXT_ALIGN_LEN))) &&
        !stm->NonSupportModelCompile() && !(stm->IsTaskGrouping()) && (kernTask->isUpdateSinkSqe == 0U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadForMix);
        error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_MIX);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadForMix);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Mix Failed to load args , stream_id=%d, retCode=%#x.",
            stm->Id_(), error);
        mixOpt = (stm->GetModelNum() == 0U);
        copyFlag = false;
    } else if (((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) || (!stm->isHasPcieBar_) ||
               IsCapturedTask(stm, kernTask)) || (kernTask->isUpdateSinkSqe == 1U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoad);
        error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_NO_MIX);
        TIMESTAMP_END(rtKernelLaunch_ArgLoad);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to load args, stream_id=%d, retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else {
        // do nothing
    }

    if (noMixFlag) {
        TransDavinciTaskToVectorCore(stm->Flags(), addr2, addr1, mixType, kernelAttrType, isLaunchVec);
    }
    error = CheckMixKernelValid(mixType, addr2);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Mix kernel check failed, stream_id=%d, task_id=%hu, kernelAttrType=%d, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelAttrType, error);

    COND_PROC(((kernTask->isUpdateSinkSqe == 1U) && (!(kernTask->stream->IsSoftwareSqEnable()))),
        isNeedAllocSqeDevBuf = true);
    AicTaskInit(kernTask, registeredKernel, kernelAttrType, static_cast<uint16_t>(coreDim), taskCfg, isNeedAllocSqeDevBuf);

    aicTask = &kernTask->u.aicTaskInfo;
    if (copyFlag) {
        aicTask->argsInfo = const_cast<rtArgsEx_t *>(argsInfo);
    }
    aicTask->mixOpt = mixOpt;
    aicTask->funcAddr = addr1;
    aicTask->funcAddr1 = addr2;
    aicTask->kernel = registeredKernel;
    aicTask->progHandle = prog;
    if (noMixFlag && (kernTask->type == TS_TASK_TYPE_KERNEL_AICORE) && (!ctx->IsINFMode())) {
        aicTask->infMode = TASK_UN_SATURATION_MODE;
    }
    registeredKernel->SetPrefetchCnt1_(prefetchCnt1);
    registeredKernel->SetPrefetchCnt2_(prefetchCnt2);

    RT_LOG(RT_LOG_INFO, "device_id=%lu, stream_id=%d, task_id=%hu, kernelAttrType=%d, kernel_name=%s, arg_size=%u, "
        "taskRation=%u, funcType=%u, coreDim=%u, mixType=%hhu, addr1=0x%llx, addr2=0x%llx, stubFunc=%p, "
        "kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%lu, isNoNeedH2DCopy=%u, "
        "isUpdateSinkSqe=%u.",
        device->Id_(), stm->Id_(), kernTask->id, kernelAttrType, registeredKernel->Name_().c_str(), argsInfo->argsSize,
        registeredKernel->GetTaskRation(), registeredKernel->GetFuncType(), coreDim, mixType, addr1, addr2, stubFunc,
        aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
        aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex, argsInfo->isNoNeedH2DCopy,
        kernTask->isUpdateSinkSqe);

    error = InternalLaunchKernelSubmit(ctx, kernTask, stm, argsInfo, result, prog);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "kernel launch submit failed.");
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    InternalLaunchKernelRecycle(ctx, result, kernTask, prog);
    return error;
}

rtError_t StreamLaunchKernelWithHandle(void * const progHandle, const uint64_t tilingKey, const uint32_t coreDim,
    const rtArgsEx_t *argsInfo, Stream *stm, const TaskCfg * const taskCfg, const bool isLaunchVec)
{
    Context * const ctx = stm->Context_();
    Device * const device = ctx->Device_();
    rtError_t error;
    rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE;
    StarsArgLoaderResult result = {};
    bool copyFlag = true;
    uint8_t mixType = NO_MIX;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(progHandle, RT_ERROR_PROGRAM_NULL, "Delivering a kernel task based on BinHandle");

    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    TaskInfo submitTask = {};
    TaskInfo *kernTask = nullptr;
    AicTaskInfo *aicTask = nullptr;
    Program *prog = nullptr;
    Module *launchMdl = nullptr;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    Kernel *registeredKernel = nullptr;
    bool mixOpt = false;
    rtError_t errorReason;
    uint32_t taskRation = 0U;
    uint32_t funcType = 0U;
    bool isNeedAllocSqeDevBuf = false;
    const bool noMixFlag = device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX);

    TIMESTAMP_BEGIN(rtKernelLaunch_AllocTask);
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason, 1U, UpdateTaskFlag::SUPPORT);
    TIMESTAMP_END(rtKernelLaunch_AllocTask);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d."
        " retCode=%#x.", stm->Id_(), errorReason);

    error = InternalLaunchKernelPrepare(ctx, registeredKernel, prog, kernelAttrType, launchMdl, nullptr,
        addr1, addr2, progHandle, tilingKey, prefetchCnt1, prefetchCnt2);
    COND_PROC_RETURN_ERROR_MSG_INNER((error == RT_ERROR_MEMORY_ADDRESS_UNALIGNED) || (error == RT_ERROR_KERNEL_NULL),
        error, InternalLaunchKernelRecycle(ctx, result, kernTask, nullptr);, "kernel launch kernel prepare failed.");
    COND_PROC_RETURN_ERROR_MSG_INNER((error == RT_ERROR_PROGRAM_BASE) || (error == RT_ERROR_PROGRAM_NULL), error,
        InternalLaunchKernelRecycle(ctx, result, kernTask, nullptr);, "kernel launch prog prepare failed.");
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "kernel launch prepare failed.");

    mixType = (tilingKey == DEFAULT_TILING_KEY) ? static_cast<uint8_t>(NO_MIX) : registeredKernel->GetMixType();
    if (noMixFlag) {
        mixType = static_cast<uint8_t>(NO_MIX); // both 51dc aic aiv not support mixtype
    }

    if (kernTask->isUpdateSinkSqe == 1U) {
        error = InternalUpdateTaskPrepare(ctx, kernTask, registeredKernel, stm);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
            "Check kernel task failed, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Id_(), kernTask->id, error);
    }

    if ((mixType != NO_MIX) && (device->ArgLoader_()->CheckPcieBar()) &&
       (argsInfo->argsSize <= (PCIE_BAR_COPY_SIZE - CONTEXT_ALIGN_LEN)) && !stm->NonSupportModelCompile() &&
       !(stm->IsTaskGrouping()) && (kernTask->isUpdateSinkSqe == 0U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadAllForMix);
        error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_MIX);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadAllForMix);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Mix Failed to load args, stream_id=%d,"
                             " retCode=%#x.", stm->Id_(), error);
        mixOpt = (stm->GetModelNum() == 0U);
        copyFlag = false;
    } else if (((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
               (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernTask)) ||
               (kernTask->isUpdateSinkSqe == 1U)) {
        // 只要不预留pcie,都走公共load流程
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadAll);
        error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_NO_MIX);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadAll);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to load args, stream_id=%d,"
        " retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else {
        // do nothing
    }
    if (noMixFlag) {
        TransDavinciTaskToVectorCore(stm->Flags(), addr2, addr1, mixType, kernelAttrType, isLaunchVec);
    }

    error = CheckMixKernelValid(mixType, addr2);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Mix kernel check failed, stream_id=%d, task_id=%hu, kernelAttrType=%d, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelAttrType, error);

    COND_PROC(((kernTask->isUpdateSinkSqe == 1U) && (!(kernTask->stream->IsSoftwareSqEnable()))),
        isNeedAllocSqeDevBuf = true);

    AicTaskInit(kernTask, registeredKernel, kernelAttrType, static_cast<uint16_t>(coreDim), taskCfg, isNeedAllocSqeDevBuf);

    aicTask = &kernTask->u.aicTaskInfo;
    if (copyFlag) {
        aicTask->argsInfo = const_cast<rtArgsEx_t*>(argsInfo);
    }

    aicTask->mixOpt = mixOpt;
    aicTask->funcAddr = addr1;
    aicTask->funcAddr1 = addr2;
    aicTask->tilingKey = tilingKey;
    aicTask->kernel = registeredKernel;
    aicTask->progHandle = (prog != nullptr) ? prog : RtPtrToPtr<Program *>(progHandle);
    if (noMixFlag &&
        (kernTask->type == TS_TASK_TYPE_KERNEL_AICORE) && (!ctx->IsINFMode())) {
        aicTask->infMode = TASK_UN_SATURATION_MODE;
    }

    if (registeredKernel != nullptr) {
        taskRation = registeredKernel->GetTaskRation();
        funcType = registeredKernel->GetFuncType();
        registeredKernel->SetPrefetchCnt1_(prefetchCnt1);
        registeredKernel->SetPrefetchCnt2_(prefetchCnt2);
    }

    RT_LOG(RT_LOG_INFO, "kernel info : device_id=%lu, stream_id=%d, task_id=%hu, kernelAttrType=%d, kernel_name=%s, "
           "arg_size=%u, coreDim=%u, mixType=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
           "kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%u, "
           "isNoNeedH2DCopy=%u, isUpdateSinkSqe=%u.",
           device->Id_(), stm->Id_(), kernTask->id, kernelAttrType,
           (tilingKey == DEFAULT_TILING_KEY) ? "" : registeredKernel->Name_().c_str(),
           argsInfo->argsSize, coreDim, mixType, taskRation, funcType, addr1, addr2,
           aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
           aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex,
           argsInfo->isNoNeedH2DCopy, kernTask->isUpdateSinkSqe);

    TIMESTAMP_BEGIN(rtKernelLaunchWithHandle_SubMit);
    error = InternalLaunchKernelSubmit(ctx, kernTask, stm, argsInfo, result, prog);
    TIMESTAMP_END(rtKernelLaunchWithHandle_SubMit);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "kernel launch submit failed.");
    return RT_ERROR_NONE;

ERROR_FREE:
    InternalLaunchKernelRecycle(ctx, result, kernTask, prog);
    return error;
}
}  // namespace runtime
}  // namespace cce
