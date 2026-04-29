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
#include "task_info.h"
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
    const Stream *dsaStm = stm->Device_()->TsFFtsDsaStream_();

    uint16_t dsaSqId = 0U;
    if (dsaStm != nullptr) {
        dsaSqId = static_cast<uint16_t>(dsaStm->GetSqId());
    }

    sqe->dsaSqId = dsaSqId;
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
    DELETE_O(aicpuTaskInfo->kernel);
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
                if (HasMteErr(taskInfo->stream->Device_())) {
                    taskInfo->errorCode = TS_ERROR_SDMA_POISON_ERROR;
                } else if (!HasMemUceErr(taskInfo->stream->Device_()->Id_())) {
                    taskInfo->errorCode = TS_ERROR_SDMA_LINK_ERROR;
                } else {
                    taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
                }
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
                "AIV Kernel happen error, retCode=%#x.", taskInfo->errorCode));
        } else if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
            taskInfo->errorCode = aicpuErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
                "AICPU Kernel task happen error, retCode=%#x.", taskInfo->errorCode));
        } else {
            taskInfo->errorCode = aicorerErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "AICORE Kernel task happen error, retCode=%#x.", taskInfo->errorCode));
        }
    }
}

#endif

}  // namespace runtime
}  // namespace cce
