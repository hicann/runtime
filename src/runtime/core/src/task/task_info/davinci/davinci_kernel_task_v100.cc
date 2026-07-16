/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "davinci_kernel_task.h"
#include "task_info_v100.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "rt_stars_define.h"
#include "context.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "tsch_defines.h"
#include "profiler.hpp"
#include "stars.hpp"
#include "device.hpp"
#include "raw_device.hpp"
#include "atrace_log.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "ffts_task.h"
#include "printf.hpp"

namespace cce {
namespace runtime {
#if F_DESC("DavinciKernelTask")

TIMESTAMP_EXTERN(ArgRelease);
TIMESTAMP_EXTERN(KernelTaskCompleteOther);

void DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    Stream * const stream = taskInfo->stream;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    PreCheckTaskErr(taskInfo, devId);

    if ((errorCode != TS_ERROR_AICORE_OVERFLOW) && (errorCode != TS_ERROR_AIVEC_OVERFLOW) &&
        (errorCode != TS_ERROR_AICPU_OVERFLOW) && (errorCode != TS_ERROR_SDMA_OVERFLOW)) {
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
    }

    TIMESTAMP_BEGIN(ArgRelease);

    Handle *argHdl = static_cast<Handle *>(aicTaskInfo->comm.argHandle);

     if (stream->Model_() != nullptr) {
        RT_LOG(RT_LOG_INFO, "Model Task no relase args, stream_id=%d ,task_id=%hu", stream->Id_(), taskInfo->id);
        (stream->Model_())->PushbackArgHandle(static_cast<uint16_t>(stream->Id_()), taskInfo->id, argHdl);
    } else if (stream->IsSeparateSendAndRecycle() && taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        stream->SetArgHandle(aicTaskInfo->comm.argHandle);
    } else {
        (void)stream->Device_()->ArgLoader_()->Release(argHdl);
    }

    if (aicTaskInfo->mixOpt == 1U) {
        aicTaskInfo->descBuf = nullptr;
    }
    aicTaskInfo->comm.argHandle = nullptr;
    TIMESTAMP_END(ArgRelease);

    TIMESTAMP_BEGIN(KernelTaskCompleteOther);
    if (unlikely(taskInfo->pcTrace != nullptr)) {
        RT_LOG(RT_LOG_INFO, "DoCompleteSuccess, davinci kernel task has been completed successfully!");
        (void)taskInfo->pcTrace->WritePCTraceFile();
    }
    TIMESTAMP_END(KernelTaskCompleteOther);
}

void SetResultForDavinciTask(TaskInfo* taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    const auto *const tsData = static_cast<const uint32_t *>(data);
    const uint32_t payLoad = *tsData;
    const uint32_t highTaskId = *(tsData + 1);
    const uint32_t streamIdEx = *(tsData + 2);

    const uint32_t deviceId = taskInfo->stream->Device_()->Id_();
    const uint32_t retCode = static_cast<uint32_t>(payLoad & 0xFFFU);
    taskInfo->errorCode = retCode;
    const uint32_t taskId = (static_cast<uint32_t>(payLoad >> 22U) & 0x3FFU) |
        static_cast<uint32_t>(highTaskId << 10U);
    const uint32_t streamId = (static_cast<uint32_t>(payLoad >> 12U) & 0x3FFU) |
        (streamIdEx << RT_STREAM_ID_OFFSET);
    RT_LOG(RT_LOG_INFO, "Kernel payLoad=%u, highTaskId=%u, device_id=%u, rtCode=0x%x, "
           "errorTaskId=%u, errorStreamId=%u.",
           payLoad, highTaskId, deviceId, retCode, taskId, streamId);
}

static rtError_t RuntimeDevMemAlloc(void ** const dptr, const uint64_t size, const rtMemType_t type, Device *dev)
{
    // when alloc small page HBM OOM, try Alloc huge page.
    rtError_t ret = (dev->Driver_())->DevMemAlloc(dptr, size, type, dev->Id_(), MODULEID_RUNTIME, false);
    if (ret == RT_ERROR_DRV_OUT_MEMORY) {
        RT_LOG(RT_LOG_WARNING, "device_id=%u alloc small page mem OOM, alloc huge page size=%u.", dev->Id_(), size);
        ret = (dev->Driver_())->DevMemAlloc(dptr, size, RT_MEMORY_POLICY_HUGE_PAGE_ONLY, dev->Id_());
    }
    return ret;
}

static rtError_t AllocFftsMixDescMemForDavinciTask(TaskInfo *taskInfo)
{
    constexpr uint32_t descBufLen = CONTEXT_ALIGN_LEN;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const rtError_t ret = RuntimeDevMemAlloc(&(aicTaskInfo->descBuf),
        static_cast<uint64_t>(descBufLen + CONTEXT_ALIGN_LEN),
        RT_MEMORY_HBM, taskInfo->stream->Device_());
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (aicTaskInfo->descBuf == nullptr), ret,
                      "alloc fftsPlusDescDev failed, retCode=%#x, descBufLen=%u(bytes), device_id=%u.",
                      ret, descBufLen, taskInfo->stream->Device_()->Id_());
    const uint64_t descAlign = (RtPtrToValue(aicTaskInfo->descBuf) & 0x7FU) == 0U ?
        RtPtrToValue(aicTaskInfo->descBuf) :
        (((RtPtrToValue(aicTaskInfo->descBuf) >> CONTEXT_ALIGN_BIT) + 1U) << CONTEXT_ALIGN_BIT);
    aicTaskInfo->descAlignBuf = RtValueToPtr<void *>(descAlign);
    return RT_ERROR_NONE;
}

static rtError_t DavinciFftsPlusTaskPoolH2D(TaskInfo* taskInfo, const void * const src)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Handle *handle = static_cast<Handle *>(aicTaskInfo->comm.argHandle);
    void *devAddr = handle->argsAlloc->GetDevAddr(handle->kerArgs);
    COND_RETURN_ERROR((devAddr == nullptr), RT_ERROR_INVALID_VALUE,
        "devAddr is null, device_id=%u, stream_id=%d, task_id=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);

    const rtError_t error = handle->argsAlloc->H2DMemCopy(devAddr, src, CONTEXT_ALIGN_LEN);
    aicTaskInfo->descBuf = devAddr;
    aicTaskInfo->descAlignBuf = devAddr;
    return error;
}

static rtError_t DavinciFftsPlusTaskNormalH2D(TaskInfo* taskInfo, const void *src)
{
    constexpr uint32_t descBufLen = static_cast<uint32_t>(CONTEXT_ALIGN_LEN);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const auto dev = taskInfo->stream->Device_();
    rtError_t ret = AllocFftsMixDescMemForDavinciTask(taskInfo);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (aicTaskInfo->descBuf == nullptr), ret,
                      "stream_id=%d, task_id=%u, device_id=%u, alloc fftsPlusDescDev failed, "
                      "descBufLen=%u(bytes), retCode=%#x.", taskInfo->stream->Id_(),
                      taskInfo->id, dev->Id_(), descBufLen, ret);
    ret = dev->Driver_()->MemCopySync(aicTaskInfo->descAlignBuf, descBufLen, src,
                                      descBufLen, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "stream_id=%d, task_id=%u, device_id=%u, MemCopySync args failed, retCode=%#x.",
                         taskInfo->stream->Id_(), taskInfo->id, dev->Id_(), ret);
    }
    return ret;
}

void ConstructAICpuSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsAicpuKernelSqe *const sqe = &(command->aicpuSqe);
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    Stream * const stm = taskInfo->stream;

    sqe->header.type = RT_STARS_SQE_TYPE_AICPU;
    sqe->header.l1_lock = 0U;
    sqe->header.l1_unlock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    if (stm->IsDebugRegister() && (!stm->GetBindFlag())) {
        sqe->header.post_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->header.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->header.reserved = 0U;
    sqe->header.block_dim = aicpuTaskInfo->comm.dim;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->kernel_type = static_cast<uint16_t>(aicpuTaskInfo->aicpuKernelType);
    sqe->batch_mode = 0U;

    if ((aicpuTaskInfo->comm.kernelFlag & RT_KERNEL_HOST_FIRST) == RT_KERNEL_HOST_FIRST) {
        sqe->topic_type = TOPIC_TYPE_HOST_AICPU_FIRST;
    } else if ((aicpuTaskInfo->comm.kernelFlag & RT_KERNEL_HOST_ONLY) == RT_KERNEL_HOST_ONLY) {
        sqe->topic_type = TOPIC_TYPE_HOST_AICPU_ONLY;
    } else if ((aicpuTaskInfo->comm.kernelFlag & RT_KERNEL_DEVICE_FIRST) == RT_KERNEL_DEVICE_FIRST) {
        sqe->topic_type = TOPIC_TYPE_DEVICE_AICPU_FIRST;
    } else {
        sqe->topic_type = TOPIC_TYPE_DEVICE_AICPU_ONLY;
    }

    sqe->qos = GetAICpuQos(taskInfo);
    sqe->res7 = 0U;
    sqe->sqe_index = 0U; // useless
    const uint32_t curVersion = stm->Device_()->GetTschVersion() & 0xFFFFU; // 取低16位作为版本号
    const bool isNewVersion = curVersion >= TS_VERSION_AICPU_SINGLE_TIMEOUT;
    const bool isSupportTimeout =
        ((sqe->kernel_type == KERNEL_TYPE_AICPU_KFC) || (sqe->kernel_type == KERNEL_TYPE_CUSTOM_KFC));
    const bool isNeedNoTimeout = ((aicpuTaskInfo->timeout > RUNTIME_DAVINCI_MAX_TIMEOUT) && isSupportTimeout) ||
        (aicpuTaskInfo->timeout == MAX_UINT64_NUM);
    sqe->kernel_credit = isNeedNoTimeout ? RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT : static_cast<uint8_t>(GetAicpuKernelCredit(aicpuTaskInfo->timeout));

    // old tsagent not suport config aicpu timeout  to  0xFF
    sqe->kernel_credit = (isNeedNoTimeout && (!isNewVersion)) ? RT_STARS_MAX_KERNEL_CREDIT : sqe->kernel_credit;

    uint64_t addr = RtPtrToValue(aicpuTaskInfo->soName);
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    // 接口开放 args排布有调整，sqe中的param要基于args的起始地址做soName和funcName的偏移获取headParamAddr
    const uint8_t *tmpAddr = RtPtrToPtr<const uint8_t *, void *>(aicpuTaskInfo->comm.args);
    const void *paramAddr = tmpAddr + aicpuTaskInfo->headParamOffset;
    addr = RtPtrToValue(paramAddr);
    sqe->paramAddrLow = static_cast<uint32_t>(addr);
    sqe->param_addr_high = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue(aicpuTaskInfo->funcName);
    sqe->task_name_str_ptr_low = static_cast<uint32_t>(addr);
    sqe->task_name_str_ptr_high = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    sqe->pL2CtrlLow = 0U;
    sqe->p_l2ctrl_high = 0U;
    sqe->overflow_en = stm->IsOverflowEnable();
    sqe->dump_en = 0U;
    if ((aicpuTaskInfo->comm.kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        sqe->dump_en = 1U; // 1: aicpu dump enable
        sqe->kernel_credit = RT_STARS_ADJUST_KERNEL_CREDIT;
    }
    sqe->debug_dump_en = 0U;
    if (stm->IsDebugRegister() && stm->GetBindFlag()) {
        sqe->debug_dump_en = 1U;
    }

    sqe->extraFieldLow = taskInfo->id;  // send task id info to aicpu
    sqe->extra_field_high = 0U;

    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->group_id = 0U;
    sqe->usr_data_len = 40U; /* size: word4-13 */
    sqe->dest_pid = 0U;

    PrintSqe(command, "AICpuTask");
    RT_LOG(RT_LOG_INFO, "taskType=%hu, topic_type=%hu, kernel_type=%hu, debug_dump_en=%u, curVersion=%u, "
        "isNeedNoTimeout=%u, timeout=%hus, kernel_credit=%hu",
        taskInfo->type, sqe->topic_type, sqe->kernel_type,  sqe->debug_dump_en, curVersion,
        isNeedNoTimeout, aicpuTaskInfo->timeout, sqe->kernel_credit);

    return;
}

void FillFftsPlusMixSqeSubtask(const AicTaskInfo *taskInfo, uint8_t *const subtype)
{
    *subtype = 0U;
    switch (taskInfo->kernel->GetMixType()) {
        case MIX_AIC:
            *subtype = RT_CTX_TYPE_MIX_AIC;
            break;
        case MIX_AIV:
            *subtype = RT_CTX_TYPE_MIX_AIV;
            break;
        case MIX_AIC_AIV_MAIN_AIC:
            *subtype = RT_CTX_TYPE_MIX_AIC;
            break;
        case MIX_AIC_AIV_MAIN_AIV:
            *subtype = RT_CTX_TYPE_MIX_AIV;
            break;
        default:
            break;
    }
    return;
}

void FillFftsMixSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command, uint32_t minStackSize, rtError_t copyRet)
{
    rtFftsPlusSqe_t *sqe = &(command->fftsPlusSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Stream * const stm = taskInfo->stream;
    Device *dev = stm->Device_();
    uint64_t stackSize = KERNEL_STACK_SIZE_32K;
    uint64_t stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
    Program *programPtr = nullptr;
    const Kernel *kernelPtr = aicTaskInfo->kernel;
    if (kernelPtr != nullptr) {
        programPtr = kernelPtr->Program_();
        if (programPtr != nullptr) {
            stackSize = programPtr->GetStackSize();
            RT_LOG(
                RT_LOG_INFO, "kernelNames_=%s, stackSize=%lu.", programPtr->GetKernelNamesBuffer().c_str(), stackSize);
        }
    }

    if (likely(minStackSize == 0)) {
        if (stackSize == KERNEL_STACK_SIZE_16K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase16k());
        }
        RT_LOG(RT_LOG_INFO, "stackSize=%uByte, stackPhyBase=%#llx", stackSize, stackPhyBase);
    } else {
        if (minStackSize <= KERNEL_STACK_SIZE_32K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
            stackSize = KERNEL_STACK_SIZE_32K;
        } else {
            stackPhyBase = RtPtrToValue(dev->GetCustomerStackPhyBase());
            stackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
        }
        RT_LOG(RT_LOG_INFO,
            "minStackSize=%uByte, stackSize=%uByte, stackPhyBase=%#llx",
            minStackSize,
            stackSize,
            stackPhyBase);
    }

    for (size_t i = 0LU; i < (sizeof(sqe->reserved16) / sizeof(sqe->reserved16[0])); i++) {
        sqe->reserved16[i] = 0U;
    }
    rtStarsFftsPlusHeader_t *sqeHeader = RtPtrToPtr<rtStarsFftsPlusHeader_t *>(&(sqe->sqeHeader));
    sqeHeader->type = 0U;
    // if h2d copy fail, change sqe type to 63 STARS_SQE_TYPE_INVALID
    if (copyRet != RT_ERROR_NONE) {
        sqeHeader->type = 63U;
    }
    sqeHeader->ie = 0U;
    sqeHeader->preP = 0U;
    sqeHeader->postP = 0U;
    if ((aicTaskInfo->comm.kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        if (stm->IsOverflowEnable()) {
            sqeHeader->preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        }
        sqeHeader->postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        sqe->reserved16[1U] = sqe->reserved16[1U] | SQE_BIZ_FLAG_DATADUMP;
    }
    if ((stm->IsDebugRegister() && (!stm->GetBindFlag()))) {
        sqeHeader->postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqeHeader->wrCqe = stm->GetStarsWrCqeFlag();

    sqeHeader->rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqeHeader->taskId = taskInfo->id;
    sqeHeader->overflowEn = stm->IsOverflowEnable();
    sqeHeader->blockDim = aicTaskInfo->comm.dim;
    sqe->fftsType = RT_FFTS_PLUS_TYPE;
    sqe->kernelCredit = static_cast<uint8_t>(GetAicoreKernelCredit(aicTaskInfo->timeout));
    FillFftsPlusMixSqeSubtask(aicTaskInfo, &sqe->subType);
    sqe->dsaSqId = 0U;
    sqe->totalContextNum = 1U;
    sqe->readyContextNum = 1U;
    sqe->preloadContextNum = 1U;
    sqe->stackPhyBaseL = static_cast<uint32_t>(stackPhyBase);
    sqe->stackPhyBaseH = static_cast<uint32_t>(stackPhyBase >> UINT32_BIT_NUM);
    const uint64_t devMemAddr = RtPtrToValue(aicTaskInfo->descAlignBuf);
    sqe->contextAddressBaseL = static_cast<uint32_t>(devMemAddr);
    sqe->contextAddressBaseH =
        (static_cast<uint32_t>(devMemAddr >> UINT32_BIT_NUM)) & MASK_17_BIT;

    if (Runtime::Instance()->GetL2CacheProfFlag()) {
        sqeHeader->postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        sqe->reserved16[1U] = sqe->reserved16[1U] | SQE_BIZ_FLAG_L2CACHE;
    }

    if ((!stm->GetBindFlag()) && (Runtime::Instance()->GetBiuperfProfFlag())) {
        if (sqeHeader->postP == RT_STARS_SQE_INT_DIR_TO_TSCPU) {
            RT_LOG(RT_LOG_WARNING, "post-p has already be set, service scenarios conflict.");
        } else {
            sqeHeader->preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqeHeader->postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->reserved16[1U] = sqe->reserved16[1U] | SQE_BIZ_FLAG_BIUPERF;
        }
    }

    if (programPtr != nullptr && programPtr->IsDcacheLockOp()) {
        sqeHeader->postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        sqe->subType = RT_STARS_DCACHE_LOCK_OP;
    }

    RT_LOG(RT_LOG_INFO, "kernelFlag=%d, l2CacheProfFlag=%d, bindFlag=%d, biuperfProfFlag=%d, postP=%u, subType=0x%x, "
        "kernelCredit=%u",
        aicTaskInfo->comm.kernelFlag, Runtime::Instance()->GetL2CacheProfFlag(), stm->GetBindFlag(),
        Runtime::Instance()->GetBiuperfProfFlag(), sqeHeader->postP, sqe->subType, sqe->kernelCredit);

    PrintSqe(command, "MixTask");
    return;
}

void ConstructFftsMixSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    rtFftsPlusMixAicAivCtx_t fftsCtx = {};
    uint32_t minStackSize = 0U;
    FillFftsAicAivCtxForDavinciTask(taskInfo, &fftsCtx, minStackSize);
    // The following code cannot be used in advance because the args address may be applied for later.
    rtError_t ret = RT_ERROR_NONE;
    const auto dev = taskInfo->stream->Device_();
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    if (aicTaskInfo->mixOpt == 1) {
        ret = DavinciFftsPlusTaskPoolH2D(taskInfo, static_cast<void *>(&fftsCtx));
    } else {
        ret = DavinciFftsPlusTaskNormalH2D(taskInfo, static_cast<void *>(&fftsCtx));
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%u, taskType=%u, mixOpt:%hhu, handle:%p, "
        "descBuf=%" PRIu64 ", descAlignBuf=%" PRIu64 ".",
        dev->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->type, aicTaskInfo->mixOpt,
        aicTaskInfo->comm.argHandle, aicTaskInfo->descBuf, aicTaskInfo->descAlignBuf);

    COND_LOG_ERROR(ret != RT_ERROR_NONE, "stream_id=%d, task_id=%u, mix h2d failed, retCode=%#x.",
                   taskInfo->stream->Id_(), taskInfo->id, ret);
    FillFftsMixSqeForDavinciTask(taskInfo, command, minStackSize, ret);
    SqeTaskUpdateForFftsPlus(taskInfo, command);
    ShowDavinciTaskMixDebug(&fftsCtx);
    return;
}

void ConstructAicAivSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint8_t mixType = (aicTaskInfo->kernel != nullptr) ? aicTaskInfo->kernel->GetMixType() : 0U;
    if (mixType != NO_MIX) {
        ConstructFftsMixSqeForDavinciTask(taskInfo, command);
    } else {
        ConstructAICoreSqeForDavinciTask(taskInfo, command);
    }

    return;
}

TIMESTAMP_EXTERN(rtKernelLaunch_WaitAsyncCopyComplete);
rtError_t WaitAsyncCopyCompleteForDavinciTask(TaskInfo* taskInfo)
{
    DavinciTaskInfoCommon *comm = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) ?
        &(taskInfo->u.aicpuTaskInfo.comm) : &(taskInfo->u.aicTaskInfo.comm);

    if (comm->argHandle == nullptr) {
        return RT_ERROR_NONE;
    }

    Handle *argHdl = static_cast<Handle *>(comm->argHandle);
    if (!(argHdl->freeArgs)) {
        return RT_ERROR_NONE;
    }
    TIMESTAMP_BEGIN(rtKernelLaunch_WaitAsyncCopyComplete);
    const rtError_t error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
    TIMESTAMP_END(rtKernelLaunch_WaitAsyncCopyComplete);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", static_cast<uint32_t>(error));
        return error;
    }

    return RT_ERROR_NONE;
}

static void ArgReleaseForAicTaskUnInit(TaskInfo *taskInfo)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const auto dev = taskInfo->stream->Device_();

    if (aicTaskInfo->comm.argHandle != nullptr) {
        (void)dev->ArgLoader_()->Release(aicTaskInfo->comm.argHandle);
        aicTaskInfo->comm.argHandle = nullptr;
        if (aicTaskInfo->mixOpt == 1) {
            aicTaskInfo->descBuf = nullptr;
        }
    }

    if (aicTaskInfo->descBuf != nullptr) {
        (void) (dev->Driver_())->DevMemFree(aicTaskInfo->descBuf, dev->Id_());
        aicTaskInfo->descBuf = nullptr;
    }
    aicTaskInfo->descAlignBuf = nullptr;
    aicTaskInfo->comm.args = nullptr;

    if (aicTaskInfo->sqeDevBuf != nullptr) {
        (void)(dev->Driver_())->DevMemFree(aicTaskInfo->sqeDevBuf, dev->Id_());
        aicTaskInfo->sqeDevBuf = nullptr;
    }

    if (aicTaskInfo->launchParam.placeHoderPtr != nullptr) {
        delete [](aicTaskInfo->launchParam.placeHoderPtr);
        aicTaskInfo->launchParam.placeHoderPtr = nullptr;
        aicTaskInfo->launchParam.placeHoderNum = 0U;
    }
}

static void ArgReleaseForAicpuTaskUnInit(TaskInfo *taskInfo)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const auto dev = taskInfo->stream->Device_();

    if (aicpuTaskInfo->comm.argHandle != nullptr) {
        if ((taskInfo->stream->IsSeparateSendAndRecycle()) && (!taskInfo->stream->GetBindFlag())) {
            taskInfo->stream->SetArgHandle(aicpuTaskInfo->comm.argHandle);
        } else {
            (void)dev->ArgLoader_()->Release(aicpuTaskInfo->comm.argHandle);
        }
        aicpuTaskInfo->comm.argHandle = nullptr;
    }
    aicpuTaskInfo->comm.args = nullptr;
    aicpuTaskInfo->funcName = nullptr;
    aicpuTaskInfo->soName = nullptr;
}

void DavinciTaskUnInit(TaskInfo *taskInfo)
{
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        ArgReleaseForAicpuTaskUnInit(taskInfo);
    } else {
        ArgReleaseForAicTaskUnInit(taskInfo);
    }
    taskInfo->pcTrace.reset();
}

void SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) && (logicCq.errorCode == AE_STATUS_TASK_ABORT)) {
        return;
    }

    // hccl aicpu返回的errorType为0x1
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        if ((logicCq.errorCode == AICPU_HCCL_OP_RETRY_FAILED) || (logicCq.errorCode == AICPU_HCCL_OP_SDMA_LINK_FAILED)) {
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error, stream_id=%d, task_id=%hu, logicCq.errorCode=%u, logicCq.errorType=%hhu",
                taskInfo->stream->Id_(),
                taskInfo->id,
                logicCq.errorCode,
                logicCq.errorType);
            if (logicCq.errorCode == AICPU_HCCL_OP_RETRY_FAILED) {
                taskInfo->errorCode = TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED;
            } else {
                ProcessSdmaError(taskInfo);
            }
            return;
        }
    }

    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        uint32_t vectorErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_VECTOR_CORE_EXCEPTION,
            TS_ERROR_VECTOR_CORE_TRAP_EXCEPTION,
            TS_ERROR_VECTOR_CORE_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_VECTOR_CORE_EXCEPTION,
            logicCq.errorCode};
        uint32_t aicpuErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICPU_EXCEPTION,
            TS_ERROR_TASK_TRAP,
            TS_ERROR_AICPU_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_AICPU_EXCEPTION,
            logicCq.errorCode};
        uint32_t aicorerErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICORE_EXCEPTION,
            TS_ERROR_AICORE_TRAP_EXCEPTION,
            TS_ERROR_AICORE_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_AICORE_EXCEPTION,
            logicCq.errorCode};

        const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC) {
            taskInfo->errorCode = vectorErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "Vector Core kernel execution failed, retCode=%#x.", taskInfo->errorCode));
        } else if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
            taskInfo->errorCode = aicpuErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
                "AI CPU kernel task execution failed, retCode=%#x.", taskInfo->errorCode));
        } else {
            taskInfo->errorCode = aicorerErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "AI Core kernel task execution failed, retCode=%#x.", taskInfo->errorCode));
        }
    }
}

static void ConstructFFTSPlusFFTSType(const rtKernelAttrType kernelAttrType, RtFftsPlusKernelSqe * const sqe)
{
    switch (kernelAttrType) {
        case RT_KERNEL_ATTR_TYPE_VECTOR:
            sqe->fftsType = TS_FFTS_TYPE_AIV_ONLY;
            break;
        case RT_KERNEL_ATTR_TYPE_AICORE:
            if ((IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(),
                                         RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_MACHINE_CVMIX))) {
                sqe->fftsType = TS_FFTS_TYPE_AIC_AIV_MIX;
            } else {
                sqe->fftsType = TS_FFTS_TYPE_AIC_ONLY;
            }
            break;
        default:
            sqe->fftsType = TS_FFTS_TYPE_AIC_ONLY;
            break;
    }
}

static QosMasterType GetQosMasterTypeForCtx(const rtFftsPlusMixAicAivCtx_t *fftsCtx)
{
    QosMasterType masterType = QosMasterType::MASTER_INVALID;
    switch (fftsCtx->contextType) {
        case RT_CTX_TYPE_MIX_AIC:
            masterType = QosMasterType::MASTER_AIC_INS;
            break;
        case RT_CTX_TYPE_MIX_AIV:
            masterType = QosMasterType::MASTER_AIV_INS;
            break;
        default:
            RT_LOG(RT_LOG_INFO, "fftsCtx->contextType is %u, there is no matching masterType.", fftsCtx->contextType);
            break;
    }
    return masterType;
}

static void UpdateQosCfgInFftsCtx(rtFftsPlusMixAicAivCtx_t *fftsCtx, TaskInfo* const taskInfo)
{
    RawDevice * const dev = RtPtrToPtr<RawDevice*>(taskInfo->stream->Device_());
    if (!dev->GetQosCfg().isAicoreQosConfiged) {
        return;
    }
    const QosMasterType masterType = GetQosMasterTypeForCtx(fftsCtx);
    RT_LOG(RT_LOG_INFO, "Begin to update fftsCtx qos info, masterType is %u.", static_cast<uint32_t>(masterType));
    if (masterType >= QosMasterType::MASTER_AIC_DAT && masterType <= QosMasterType::MASTER_AIV_INS) {
        const std::array<QosMasterConfigType, MAX_ACC_QOS_CFG_NUM> &aicoreQosCfg = dev->GetQosCfg().aicoreQosCfg;
        const uint32_t index = static_cast<uint32_t>(masterType) - static_cast<uint32_t>(QosMasterType::MASTER_AIC_DAT);
        if (aicoreQosCfg[index].mode == 0) {     // mode=0 对应 tsch 中 replace_en=1，表示要替换sqe中的qos配置
            fftsCtx->pmg = aicoreQosCfg[index].pmg;
            fftsCtx->partId = aicoreQosCfg[index].mpamId;
            fftsCtx->qos = aicoreQosCfg[index].qos;
        } else {
            RT_LOG(RT_LOG_INFO, "mode is not 0, no need to update ctx, mode=%u, index=%u.",
                aicoreQosCfg[index].mode, index);
        }
    } else {
        RT_LOG(RT_LOG_ERROR, "masterType (%u) is invalid, the QoS will not be updated.", static_cast<uint32_t>(masterType));
    }
    return;
}

void FillFftsAicAivCtxForDavinciTask(TaskInfo* const taskInfo, rtFftsPlusMixAicAivCtx_t *fftsCtx, uint32_t& minStackSize)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t argsAddr = RtPtrToValue(aicTaskInfo->comm.args);
    const uint64_t funcAddr = aicTaskInfo->funcAddr;
    const uint64_t funcAddr2 = aicTaskInfo->funcAddr1;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint32_t taskRation = 0U;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    const Kernel *kernelPtr = aicTaskInfo->kernel;
    if (kernelPtr != nullptr) {
        mixType = kernelPtr->GetMixType();
        taskRation = kernelPtr->GetTaskRation();
        prefetchCnt1 = kernelPtr->PrefetchCnt1_();
        prefetchCnt2 = kernelPtr->PrefetchCnt2_();
        minStackSize = kernelPtr->GetMinStackSize1() > kernelPtr->GetMinStackSize2() ? kernelPtr->GetMinStackSize1()
                                                                                     : kernelPtr->GetMinStackSize2();
    }
    fftsCtx->nonTailAicTaskStartPcL = 0U;
    fftsCtx->nonTailAicTaskStartPcH = 0U;
    fftsCtx->tailAicTaskStartPcL = 0U;
    fftsCtx->tailAicTaskStartPcH = 0U;
    fftsCtx->nonTailAivTaskStartPcL = 0U;
    fftsCtx->nonTailAivTaskStartPcH = 0U;
    fftsCtx->tailAivTaskStartPcL = 0U;
    fftsCtx->tailAivTaskStartPcH = 0U;
    fftsCtx->aicIcachePrefetchCnt = 0U;
    fftsCtx->aivIcachePrefetchCnt = 0U;

    switch (mixType) {
        case MIX_AIC:
            fftsCtx->contextType = RT_CTX_TYPE_MIX_AIC;
            fftsCtx->nonTailBlockRatioN = 0U;   // mix no aiv
            fftsCtx->tailBlockRatioN = 0U;     //  mix no aiv
            fftsCtx->nonTailAicTaskStartPcL = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            fftsCtx->nonTailAicTaskStartPcH =
                static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->tailAicTaskStartPcL = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            fftsCtx->tailAicTaskStartPcH =
                static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            break;
        case MIX_AIV:
            fftsCtx->contextType = RT_CTX_TYPE_MIX_AIV;
            fftsCtx->nonTailBlockRatioN = 0U;   // mix no aic
            fftsCtx->tailBlockRatioN = 0U;     //  mix no aic
            fftsCtx->nonTailAivTaskStartPcL = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            fftsCtx->nonTailAivTaskStartPcH =
                static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->tailAivTaskStartPcL = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            fftsCtx->tailAivTaskStartPcH =
                static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt2);
            break;
        case MIX_AIC_AIV_MAIN_AIC:
        case MIX_AIC_AIV_MAIN_AIV:
            if (mixType == MIX_AIC_AIV_MAIN_AIC) {
                fftsCtx->contextType = RT_CTX_TYPE_MIX_AIC;
            } else {
                fftsCtx->contextType = RT_CTX_TYPE_MIX_AIV;
            }
            fftsCtx->nonTailBlockRatioN = static_cast<uint8_t>(taskRation);
            fftsCtx->tailBlockRatioN = static_cast<uint8_t>(taskRation);
            fftsCtx->nonTailAicTaskStartPcL = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            fftsCtx->nonTailAicTaskStartPcH =
                static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->tailAicTaskStartPcL = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            fftsCtx->tailAicTaskStartPcH =
                static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->nonTailAivTaskStartPcL = static_cast<uint32_t>(funcAddr2 & MASK_32_BIT);
            fftsCtx->nonTailAivTaskStartPcH =
                static_cast<uint16_t>((funcAddr2 >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->tailAivTaskStartPcL = static_cast<uint32_t>(funcAddr2 & MASK_32_BIT);
            fftsCtx->tailAivTaskStartPcH =
                static_cast<uint16_t>((funcAddr2 >> UINT32_BIT_NUM) & MASK_32_BIT);
            fftsCtx->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            fftsCtx->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt2);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "DavinciKernelTask mix error. ");
            return;
    }

    fftsCtx->successorNum = 0U;
    fftsCtx->successorList[0] = 0U;
    fftsCtx->dumpSwitch = 0U;
    fftsCtx->aten = 0U;
    fftsCtx->predCnt = 0U;
    fftsCtx->predCntInit = 0U;
    fftsCtx->schem = 0U;
    if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        CheckBlockDim(taskInfo, nullptr, fftsCtx);
        fftsCtx->schem = aicTaskInfo->schemMode;
        RT_LOG(RT_LOG_INFO, "set schemMode=%u, taskType=%u", fftsCtx->schem, taskInfo->type);
    }
    fftsCtx->atm = 0U;
    fftsCtx->prefetchEnableBitmap = 0U;
    fftsCtx->prefetchOnceBitmap = 0U;
    fftsCtx->threadId = 0U;
    if (unlikely(minStackSize > KERNEL_STACK_SIZE_32K)) {
        // 对于mix算子来说，threadId目前并没有使用，所以这里借用threadId来表征stack size大小
        const uint32_t stackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
        // stack_size = (stack_level + 2) * 16K. stackLevel用来指示算子真实的stack size, o0的编译选项的算子才会用到
        const uint32_t stackLevel = stackSize / KERNEL_STACK_SIZE_16K - 2U;
        fftsCtx->threadId = static_cast<uint16_t>(stackLevel);
        RT_LOG(
            RT_LOG_DEBUG, "minStackSize=%uByte, stackSize=%uByte, stackLevel=%u", minStackSize, stackSize, stackLevel);
    }
    fftsCtx->threadDim = 1U;
    fftsCtx->nonTailBlockdim = aicTaskInfo->comm.dim;
    fftsCtx->tailBlockdim = aicTaskInfo->comm.dim;
    fftsCtx->aicTaskParamPtrL = static_cast<uint32_t>(argsAddr & MASK_32_BIT);
    fftsCtx->aicTaskParamPtrH = static_cast<uint16_t>((argsAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
    fftsCtx->aicTaskParamPtrOffset = static_cast<uint16_t>(aicTaskInfo->comm.argsSize);
    fftsCtx->aivTaskParamPtrL = static_cast<uint32_t>(argsAddr & MASK_32_BIT);
    fftsCtx->aivTaskParamPtrH = static_cast<uint16_t>((argsAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
    fftsCtx->aivTaskParamPtrOffset = static_cast<uint16_t>(aicTaskInfo->comm.argsSize);
    fftsCtx->pmg = 0U;
    fftsCtx->ns = 1U;
    fftsCtx->partId = 0U;
    fftsCtx->qos = 0U;
    fftsCtx->srcSlot[0] = 0U;
    fftsCtx->srcSlot[1] = 0U;

    UpdateQosCfgInFftsCtx(fftsCtx, taskInfo);
    return;
}

static QosMasterType GetQosMasterTypeForSqe(const RtFftsPlusKernelSqe *sqe)
{
    QosMasterType masterType = QosMasterType::MASTER_INVALID;
    switch (sqe->fftsType) {
        case TS_FFTS_TYPE_AIC_ONLY:
            masterType = QosMasterType::MASTER_AIC_INS;
            break;
        case TS_FFTS_TYPE_AIV_ONLY:
            masterType = QosMasterType::MASTER_AIV_INS;
            break;
        default:
            RT_LOG(RT_LOG_INFO, "sqe->fftsType is %u, there is no matching masterType.", sqe->fftsType);
            break;
    }
    return masterType;
}

static void UpdateQosCfgInAicoreSqe(RtFftsPlusKernelSqe *sqe, TaskInfo* const taskInfo)
{
    RawDevice * const dev = RtPtrToPtr<RawDevice*>(taskInfo->stream->Device_());
    if (!dev->GetQosCfg().isAicoreQosConfiged) {
        return;
    }
    QosMasterType masterType = GetQosMasterTypeForSqe(sqe);
    RT_LOG(RT_LOG_INFO, "Begin to update sqe qos info, masterType is %u.", static_cast<uint32_t>(masterType));
    if (masterType >= QosMasterType::MASTER_AIC_DAT && masterType <= QosMasterType::MASTER_AIV_INS) {
        const std::array<QosMasterConfigType, MAX_ACC_QOS_CFG_NUM> &aicoreQosCfg = dev->GetQosCfg().aicoreQosCfg;
        const auto index = static_cast<uint32_t>(masterType) - static_cast<uint32_t>(QosMasterType::MASTER_AIC_DAT);
        if (aicoreQosCfg[index].mode == 0) {    // mode=0 对应 tsch 中 replace_en=1，表示要替换sqe中的qos配置
            sqe->pmg = aicoreQosCfg[index].pmg;
            sqe->part_id = aicoreQosCfg[index].mpamId;
            sqe->qos = aicoreQosCfg[index].qos;
        } else {
            RT_LOG(RT_LOG_INFO, "mode is not 0, no need to update sqe, mode=%u, index=%u.",
                aicoreQosCfg[index].mode, index);
        }
    } else {
        RT_LOG(RT_LOG_ERROR, "masterType (%u) is invalid, the QoS will not be updated.", static_cast<uint32_t>(masterType));
    }
    return;
}

void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, rtStarsSqe_t *const command)
{
    RtFftsPlusKernelSqe *sqe = &(command->fftsPlusKernelSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Stream * const stm = taskInfo->stream;
    Device *dev = stm->Device_();
    uint64_t stackSize = KERNEL_STACK_SIZE_32K;
    const uint64_t funcAddr = aicTaskInfo->funcAddr;
    uint8_t funcType = 0U;
    uint32_t prefetchCnt1 = 0U;
    uint32_t minStackSize = 0U;
    rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE;
    if (aicTaskInfo->kernel != nullptr) {
        funcType = aicTaskInfo->kernel->GetFuncType();
        prefetchCnt1 = aicTaskInfo->kernel->PrefetchCnt1_();
        minStackSize = aicTaskInfo->kernel->GetMinStackSize1();
        kernelAttrType = aicTaskInfo->kernel->GetKernelAttrType();
    }

    uint64_t stackPhyBase = 0UL;
    if (likely(minStackSize == 0)) {
        stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
        if (stackSize == KERNEL_STACK_SIZE_16K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase16k());
        }
    } else {
        if (minStackSize <= KERNEL_STACK_SIZE_32K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
            stackSize = KERNEL_STACK_SIZE_32K;
        } else {
            stackPhyBase = RtPtrToValue(dev->GetCustomerStackPhyBase());
            stackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
        }
    }

    for (size_t i = 0LU; i < (sizeof(sqe->res8) / sizeof(sqe->res8[0])); i++) {
        sqe->res8[i] = 0U;
    }
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.type = RT_STARS_SQE_TYPE_FFTS;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    if (((aicTaskInfo->comm.kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) ||
        (stm->IsDebugRegister() && (!stm->GetBindFlag()))) {
        sqe->header.post_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }

    if ((!stm->GetBindFlag()) && (Runtime::Instance()->GetBiuperfProfFlag())) {
        if (sqe->header.post_p == RT_STARS_SQE_INT_DIR_TO_TSCPU) {
            RT_LOG(RT_LOG_WARNING, "post-p has already be set, service scenarios conflict.");
        } else {
            sqe->header.pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->header.post_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->res8[1U] = sqe->res8[1U] | SQE_BIZ_FLAG_BIUPERF;
        }
    }
    sqe->header.task_id = taskInfo->id;
    ConstructFFTSPlusFFTSType(kernelAttrType, sqe);
    sqe->header.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe->header.block_dim = aicTaskInfo->comm.dim;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe->wrr_ratio = 1U;
    sqe->res1 = 0U;
    sqe->res2 = 0U;
    sqe->schem = 0U;
    sqe->sqe_index = 0U;
    sqe->kernel_credit = GetAicoreKernelCredit(aicTaskInfo->timeout);
    
    RT_LOG(RT_LOG_INFO, "bindFlag=%d, biuperfProfFla=%d, fftsType=%u, funcType=%u, prefetchCnt1=%u, chipType=%u, "
        "cfgInfo schemMode=%u, taskType=%u, kernelFlag=%u, l2CacheProfFlag=%u, kernelCredit=%u, kernelAttrType=%d, "
        "minStackSize=%u(bytes), stackSize=%u(bytes), stackPhyBase=%#llx.",
        stm->GetBindFlag(), Runtime::Instance()->GetBiuperfProfFlag(), sqe->fftsType, funcType, prefetchCnt1,
        Runtime::Instance()->GetChipType(), aicTaskInfo->schemMode, taskInfo->type, aicTaskInfo->comm.kernelFlag,
        Runtime::Instance()->GetL2CacheProfFlag(), sqe->kernel_credit, kernelAttrType,
        minStackSize, stackSize, stackPhyBase);
    if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) || (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
            CheckBlockDim(taskInfo, sqe, nullptr);
            sqe->schem = aicTaskInfo->schemMode;
  	        RT_LOG(RT_LOG_INFO, "set schemMode=%u, taskType=%u", sqe->schem, taskInfo->type);
        }
    }
    sqe->res3 = 0U;
    sqe->icache_prefetch_cnt = 0U;
    sqe->stackPhyBaseLow = static_cast<uint32_t>(stackPhyBase);
    sqe->stackPhyBaseHigh = static_cast<uint32_t>(stackPhyBase >> UINT32_BIT_NUM);
    sqe->res4 = 0U;
    sqe->pmg = 0U;
    sqe->ns = 1U;
    sqe->part_id = aicTaskInfo->partId;
    sqe->res5 = 0U;
    sqe->qos = aicTaskInfo->qos;
    sqe->res6 = 0U;
    sqe->pc_addr_low = static_cast<uint32_t>(funcAddr);
    sqe->pcAddrHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
    sqe->res7 = 0U;

    UpdateQosCfgInAicoreSqe(sqe, taskInfo);

    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    sqe->paramAddrLow = static_cast<uint32_t>(addr);
    sqe->param_addr_high = static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
    if (unlikely(minStackSize > 0)) {
        sqe->param_addr_high &= 0x000FFFFFU;
        // stack_size = (stack_level + 2) * 16K. stackLevel用来指示算子真实的stack size, o0的编译选项的算子才会用到
        const uint32_t stackLevel = static_cast<uint32_t>(stackSize / KERNEL_STACK_SIZE_16K - 2U);
        // 左移20位之后，高12位用来存放stackLevel
        sqe->param_addr_high |= stackLevel << 20U;
    }
    if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_DAVINCI_WITH_SCHEM_MODE)) {
        /* reserved 0 used only in 1910b tiny send to drv */
        sqe->res8[0U] = aicTaskInfo->comm.argsSize;
    }

    if ((aicTaskInfo->comm.kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        if (stm->IsOverflowEnable()) {
            sqe->header.pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        }
        sqe->res8[1U] = sqe->res8[1U] | SQE_BIZ_FLAG_DATADUMP;
    }

    if (Runtime::Instance()->GetL2CacheProfFlag()) {
        sqe->header.post_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        sqe->res8[1U] = sqe->res8[1U] | SQE_BIZ_FLAG_L2CACHE;
    }

    PrintSqe(command, "FFTSPlusAICore");

    return;
}

void ShowDavinciTaskMixDebug(const rtFftsPlusMixAicAivCtx_t * const fftsCtx)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_INFO) == 0) {
        return;
    }

    const uint32_t * const buf = RtPtrToPtr<const uint32_t *>(fftsCtx);
    RT_LOG(RT_LOG_INFO, "The DavinciTask Mix context-buf:"
        "%#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, "
        "%#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, "
        "%#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, "
        "%#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, %#010x, ",
        buf[0], buf[1], buf[2], buf[3], buf[4], buf[5], buf[6], buf[7],
        buf[8], buf[9], buf[10], buf[11], buf[12], buf[13], buf[14], buf[15],
        buf[16], buf[17], buf[18], buf[19], buf[20], buf[21], buf[22], buf[23],
        buf[24], buf[25], buf[26], buf[27], buf[28], buf[29], buf[30], buf[31]);

    return;
}

#endif

static bool DavinciKernelTaskRegister()
{
    TaskFuncSingle aicAivFuncs = {
        .toCommandFunc = &ToCommandBodyForAicAivTask,
        .toSqeFunc = &ConstructAicAivSqeForDavinciTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavinciTask,
        .taskUnInitFunc = &DavinciTaskUnInit,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForDavinciTask,
        .printErrorInfoFunc = &PrintErrorInfoForDavinciTask,
        .setResultFunc = &SetResultForDavinciTask,
        .setStarsResultFunc = &SetStarsResultForDavinciTask,
    };

    TaskFuncSingle aicpuFuncs = {
        .toCommandFunc = &ToCommandBodyForAicpuTask,
        .toSqeFunc = &ConstructAICpuSqeForDavinciTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavinciTask,
        .taskUnInitFunc = &DavinciTaskUnInit,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForDavinciTask,
        .printErrorInfoFunc = &PrintErrorInfoForDavinciTask,
        .setResultFunc = &SetResultForDavinciTask,
        .setStarsResultFunc = &SetStarsResultForDavinciTask,
    };

    const auto& chips = GetV100Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICPU, aicpuFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICORE, aicAivFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AIVEC, aicAivFuncs);
    }

    return true;
}

static bool g_davinciKernelTaskRegister = DavinciKernelTaskRegister();

}  // namespace runtime
}  // namespace cce
