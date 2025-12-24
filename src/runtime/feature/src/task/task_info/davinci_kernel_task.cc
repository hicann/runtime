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
#include "stream.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "stars_cond_isa_helper.hpp"
#include "rt_stars_define.h"
#include "context.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include "aicpu/common/aicpu_task_struct.h"
#include "context.hpp"
#include "tsch_defines.h"
#include "profiler.hpp"
#include "stars.hpp"
#include "stub_task.hpp"
#include "hwts.hpp"
#include "device.hpp"
#include "atrace_log.hpp"
#include "task_info.h"
#include "task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "ffts_task.h"

namespace cce {
namespace runtime {
#if F_DESC("DavinciKernelTask")

static void DavinciTaskInitCommon(DavinciTaskInfoCommon *comm, const uint16_t dimNum, const uint32_t flag,
                                 uint8_t isUpdateSinkSqe)
{
    if (isUpdateSinkSqe == 0U) {
        comm->argHandle = nullptr;
        comm->args = nullptr;
        comm->argsSize = 0U;
    }
    comm->dim = dimNum;
    comm->kernelFlag = static_cast<uint8_t>(flag & 0xFFU);
    return;
}

static void AicTaskInitCommon(TaskInfo *taskInfo, const uint32_t mach, const uint16_t dimNum, const uint32_t flag,
    const bool isNeedAllocSqeDevBuf)
{
    TaskCommonInfoInit(taskInfo);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    DavinciTaskInitCommon(&(aicTaskInfo->comm), dimNum, flag, taskInfo->isUpdateSinkSqe);

    if (mach == Program::MACH_AI_VECTOR) {
        taskInfo->type = TS_TASK_TYPE_KERNEL_AIVEC;
        taskInfo->typeName = const_cast<char_t*>("KERNEL_AIVEC");
    } else {
        taskInfo->type = TS_TASK_TYPE_KERNEL_AICORE;
        taskInfo->typeName = const_cast<char_t*>("KERNEL_AICORE");
    }

    aicTaskInfo->argsInfo = nullptr;
    aicTaskInfo->machine = static_cast<uint8_t>(mach);
    aicTaskInfo->tilingKey = 0ULL;

    aicTaskInfo->smDescData = 0U;
    aicTaskInfo->smSize = 0U;
    aicTaskInfo->kernelTaskMode = RT_DEFAULT_KERNEL_MODE;
    aicTaskInfo->qos = 0U;
    aicTaskInfo->partId = 0U;
    aicTaskInfo->schemMode = 0U;
    aicTaskInfo->infMode = 0U;
    aicTaskInfo->resv = 0U;

    aicTaskInfo->mixOpt = false;
    aicTaskInfo->dynamicShareMemSize = 0U;
    aicTaskInfo->groupDim = 0U;
    aicTaskInfo->groupBlockDim = 0U;

    aicTaskInfo->inputArgsSize.infoAddr = nullptr;
    aicTaskInfo->inputArgsSize.atomicIndex = 0U;
    aicTaskInfo->oldArgHandle = nullptr;
    if (taskInfo->isUpdateSinkSqe == 0U) {
        aicTaskInfo->descBuf = nullptr;
        aicTaskInfo->descAlignBuf = nullptr;
        aicTaskInfo->sqeDevBuf = nullptr;
    } else {
        if ((aicTaskInfo->sqeDevBuf == nullptr) && isNeedAllocSqeDevBuf) {
            Driver * const driver = taskInfo->stream->Device_()->Driver_();
            constexpr uint32_t allocSize = sizeof(rtStarsSqe_t);
            const uint32_t devId = static_cast<uint32_t>(taskInfo->stream->Device_()->Id_());
            void *devAddr = nullptr;
            const rtError_t error = driver->DevMemAlloc(&devAddr, allocSize, RT_MEMORY_HBM, devId);
            COND_RETURN_VOID((error != RT_ERROR_NONE), "alloc device memory failed, retCode=%#x.",
                static_cast<uint32_t>(error));
            aicTaskInfo->sqeDevBuf = devAddr;
        }
    }

    rtArgsSizeInfo_t &argsSize = ThreadLocalContainer::GetArgsSizeInfo();
    if (argsSize.infoAddr != nullptr) {
        aicTaskInfo->inputArgsSize.infoAddr = argsSize.infoAddr;
        aicTaskInfo->inputArgsSize.atomicIndex = argsSize.atomicIndex;
        argsSize.infoAddr = nullptr;
        argsSize.atomicIndex = 0U;
    }
}

void AicpuTaskInit(TaskInfo *taskInfo, const uint16_t dimNum, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    DavinciTaskInitCommon(&(aicpuTaskInfo->comm), dimNum, flag, 0U);

    taskInfo->type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo->typeName = const_cast<char_t*>("KERNEL_AICPU");

    aicpuTaskInfo->argsInfo = nullptr;
    aicpuTaskInfo->kernel = nullptr;
    aicpuTaskInfo->headParamOffset = 0U;
    aicpuTaskInfo->aicpuArgsInfo = nullptr;
    aicpuTaskInfo->aicpuKernelType = TS_AICPU_KERNEL_CCE;
    return;
}

void AicTaskInit(TaskInfo *taskInfo, const uint32_t mach, const uint16_t dimNum,
    const uint32_t flag, const TaskCfg * const taskcfg, const bool isNeedAllocSqeDevBuf)
{
    AicTaskInitCommon(taskInfo, mach, dimNum, flag, isNeedAllocSqeDevBuf);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    if (taskcfg == nullptr) {
        return;
    }

    if (taskcfg->isBaseValid == 1U) {
        aicTaskInfo->qos = taskcfg->base.qos;
        aicTaskInfo->partId = taskcfg->base.partId;
        aicTaskInfo->schemMode = taskcfg->base.schemMode;
        aicTaskInfo->blockDimOffset = taskcfg->base.blockDimOffset;
        aicTaskInfo->dynamicShareMemSize = taskcfg->base.localMemorySize;

        if ((taskcfg->base.dumpflag == RT_KERNEL_DUMPFLAG) || (taskcfg->base.dumpflag == RT_FUSION_KERNEL_DUMPFLAG)) {
            aicTaskInfo->comm.kernelFlag = static_cast<uint8_t>(taskcfg->base.dumpflag & 0xFFU);
            RT_LOG(RT_LOG_WARNING, "dumpflag set %u.", taskcfg->base.dumpflag);
        }

        if (taskcfg->base.neverTimeout == 1U) {
            RT_LOG(RT_LOG_INFO, "Set op never time out.");
            aicTaskInfo->timeout = std::numeric_limits<uint64_t>::max();
        }
    }

    if (taskcfg->isExtendValid == 1U) {
        aicTaskInfo->timeout = taskcfg->extend.timeout;
    }

    // never timeout need ts agent support
    const bool isSupportOpNeverTimeout = (taskInfo->stream != nullptr) &&
        (taskInfo->stream->Device_() != nullptr) &&
        (taskInfo->stream->Device_()->CheckFeatureSupport(TS_FEATURE_OP_EXEC_TIMEOUT_MS));
    COND_PROC(((aicTaskInfo->timeout == MAX_UINT64_NUM) && (!isSupportOpNeverTimeout)), aicTaskInfo->timeout -= 1UL);

    return;
}

void AicTaskInitV2(TaskInfo *taskInfo, const uint32_t mach, const uint16_t dimNum,
    const uint32_t flag, const LaunchTaskCfgInfo_t * const launchTaskCfg)
{
    AicTaskInitCommon(taskInfo, mach, dimNum, flag, false);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    if (launchTaskCfg != nullptr) {
        aicTaskInfo->qos = launchTaskCfg->qos;
        aicTaskInfo->partId = launchTaskCfg->partId;
        aicTaskInfo->schemMode = launchTaskCfg->schemMode;
        aicTaskInfo->blockDimOffset = launchTaskCfg->blockDimOffset;
        aicTaskInfo->dynamicShareMemSize = launchTaskCfg->dynamicShareMemSize;
        if ((launchTaskCfg->dumpflag == RT_KERNEL_DUMPFLAG) || (launchTaskCfg->dumpflag == RT_FUSION_KERNEL_DUMPFLAG)) {
            aicTaskInfo->comm.kernelFlag = static_cast<uint8_t>(launchTaskCfg->dumpflag & 0xFFU);
            RT_LOG(RT_LOG_WARNING, "dumpflag set %u.", launchTaskCfg->dumpflag);
        }
        aicTaskInfo->groupDim = launchTaskCfg->Group.groupDim;
        aicTaskInfo->groupBlockDim = launchTaskCfg->Group.groupBlockDim;
    }

    RT_LOG(RT_LOG_INFO, "kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, groupDim=%u, groupBlockDim=%u.",
           aicTaskInfo->comm.kernelFlag, aicTaskInfo->qos,
           aicTaskInfo->partId, aicTaskInfo->schemMode,
           aicTaskInfo->groupDim, aicTaskInfo->groupBlockDim);

    return;
}

rtError_t CheckMixKernelValid(const uint8_t mixType, const uint64_t func2)
{
    if (mixType != NO_MIX) {
        if (((mixType == MIX_AIC_AIV_MAIN_AIC) || (mixType == MIX_AIC_AIV_MAIN_AIV)) &&
            (func2 == 0ULL)) {
            return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}

void ToCommandBodyForAicAivTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    TIMESTAMP_NAME(__func__);

    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Stream * const stm = taskInfo->stream;

    command->u.kernelTask.isConvertAddr = 0U;
    bool needConvert = true;
    Runtime *const rtInstance = Runtime::Instance();
    uint8_t l2Size = 0U;
    needConvert = false;

    command->u.kernelTask.priority = stm->Priority();
    command->u.kernelTask.L2_size = l2Size;
    command->u.kernelTask.L2PreloadCtrl = aicTaskInfo->smDescData;
    command->u.kernelTask.funcPtr = aicTaskInfo->funcAddr;
    command->u.kernelTask.funcDesc = RtPtrToValue(aicTaskInfo->comm.args);
    command->u.kernelTask.literalSrcAddr =  static_cast<uint64_t>(aicTaskInfo->blockDimOffset);
    command->u.kernelTask.literalDstBase = 0U;
    command->u.kernelTask.literalSize = 0U;
    command->u.kernelTask.literalSize |= static_cast<uint32_t>(aicTaskInfo->infMode);
    command->u.kernelTask.blockDim = aicTaskInfo->comm.dim;
    command->u.kernelTask.l2PreloadVirAddr = MAX_UINT32_NUM >> 6U; // move right 6 bits
    command->u.kernelTask.isConvertAddr |= aicTaskInfo->comm.kernelFlag;
    if (!needConvert) {
        constexpr uint8_t flag = KERNEL_DUMPFLAG_FLAG | FUSION_KERNEL_DUMPFLAG;
        command->u.kernelTask.isConvertAddr &= flag;
    }

    command->taskInfoFlag = stm->GetTaskRevFlag(taskInfo->bindFlag);

    if (IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_DAVINCI_WITH_ARGS_SIZE)) {
        command->u.kernelTask.schemMode = aicTaskInfo->schemMode;
        RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, taskType=%u", command->u.kernelTask.schemMode,
            taskInfo->type);
    }

    RT_LOG(RT_LOG_DEBUG, "funcAddr=%#" PRIx64 ", args=%#" PRIx64 ", smDescData=%#" PRIx64
        ", isConvertAddr=%u, kernelFlag=%u.",
        command->u.kernelTask.funcPtr, command->u.kernelTask.funcDesc, command->u.kernelTask.L2PreloadCtrl,
        static_cast<uint32_t>(command->u.kernelTask.isConvertAddr), static_cast<uint32_t>(aicTaskInfo->comm.kernelFlag));
}

void ToCommandBodyForAicpuTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    TIMESTAMP_NAME(__func__);

    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    Stream * const stm = taskInfo->stream;
    constexpr uint8_t flag = KERNEL_DUMPFLAG_FLAG | FUSION_KERNEL_DUMPFLAG;

    command->u.kernelTask.priority = stm->Priority();

    // 接口开放 args排布有调整，sqe中的param要基于args的起始地址做soName和funcName的偏移获取headParamAddr
    const uint8_t *tmpAddr = RtPtrToPtr<const uint8_t *, void *>(aicpuTaskInfo->comm.args);
    const void *paramAddr = tmpAddr + aicpuTaskInfo->headParamOffset;
    command->u.kernelTask.funcDesc = RtPtrToValue(paramAddr);
    command->u.kernelTask.blockDim = aicpuTaskInfo->comm.dim;
    command->u.kernelTask.l2PreloadVirAddr = MAX_UINT32_NUM >> 6U; // move right 6 bits
    command->u.kernelTask.isConvertAddr |= (aicpuTaskInfo->comm.kernelFlag & flag);
    command->taskInfoFlag = stm->GetTaskRevFlag(static_cast<uint8_t>(taskInfo->bindFlag));

    command->u.kernelTask.funcPtr = RtPtrToValue(aicpuTaskInfo->funcName);
    command->u.kernelTask.literalSrcAddr = RtPtrToValue(aicpuTaskInfo->soName);
    command->u.kernelTask.literalDstBase = aicpuTaskInfo->aicpuKernelType;
    command->u.kernelTask.literalSize = aicpuTaskInfo->comm.argsSize;

    RT_LOG(RT_LOG_DEBUG, "Set aicpu: kernel type[%u], so name[%" PRIu64 "], kernel name[%" PRIu64 "], "
        "args=%#" PRIx64 ", isConvertAddr=%u, kernelFlag=%u.",
        aicpuTaskInfo->aicpuKernelType, command->u.kernelTask.literalSrcAddr, command->u.kernelTask.funcPtr,
        command->u.kernelTask.funcDesc, static_cast<uint32_t>(command->u.kernelTask.isConvertAddr),
        static_cast<uint32_t>(aicpuTaskInfo->comm.kernelFlag));
}

void TransDavinciTaskToVectorCore(const uint32_t flags, uint64_t addr2, uint64_t &addr1,
    uint8_t &mixType, uint32_t &kernelType, const bool isLaunchVec)
{
    if (((flags & RT_STREAM_VECTOR_CORE_USE) == 0U) && (!isLaunchVec)) {
        return;
    }
    /* transform some part of mix op to vector core. Only 51DC support.
       vector core op pc_start store in addr2,but sqe use addr1 as pc_start.
    */
    addr1 = addr2;
    mixType = static_cast<uint8_t>(NO_MIX);
    kernelType = static_cast<uint32_t>(Program::MACH_AI_VECTOR);
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
        static_cast<uint32_t>(highTaskId << 10U); // get taskid
    const uint32_t streamId = (static_cast<uint32_t>(payLoad >> 12U) & 0x3FFU) |
        (streamIdEx << RT_STREAM_ID_OFFSET); // get streamid
    RT_LOG(RT_LOG_INFO, "Kernel payLoad=%u, highTaskId=%u, device_id=%u, rtCode=0x%x, "
           "errorTaskId=%u, errorStreamId=%u.",
           payLoad, highTaskId, deviceId, retCode, taskId, streamId);
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

void SetPcTrace(TaskInfo *taskInfo, std::shared_ptr<PCTrace> pcTracePtr)
{
    taskInfo->pcTrace = std::move(pcTracePtr);
}

static void SetFftsTypeByFuncType(const uint32_t funcType, RtFftsPlusKernelSqe * const sqe)
{
    switch (funcType) {
        case KERNEL_FUNCTION_TYPE_AIC:
        case KERNEL_FUNCTION_TYPE_AIC_ROLLBACK:
            sqe->fftsType = TS_FFTS_TYPE_AIC_ONLY;
            break;
        case KERNEL_FUNCTION_TYPE_AIV:
        case KERNEL_FUNCTION_TYPE_AIV_ROLLBACK:
            sqe->fftsType = TS_FFTS_TYPE_AIV_ONLY;
            break;
        default:
            sqe->fftsType = TS_FFTS_TYPE_AIC_ONLY;
            break;
    }
}

static void ConstructFFTSPlusFFTSType(const uint32_t machine, const uint32_t type, RtFftsPlusKernelSqe * const sqe)
{
    switch (machine) {
        case Program::MACH_AI_VECTOR:
            sqe->fftsType = TS_FFTS_TYPE_AIV_ONLY;
            break;
        case Program::MACH_AI_CVMIX:
            sqe->fftsType = TS_FFTS_TYPE_AIC_AIV_MIX;
            break;
        case Program::MACH_AI_MIX_KERNEL:
            SetFftsTypeByFuncType(type, sqe);
            break;
        default:
            sqe->fftsType = TS_FFTS_TYPE_AIC_ONLY;
            break;
    }
}

uint16_t GetAICpuQos(const TaskInfo * const taskInfo)
{
    return taskInfo->stream->Device_()->GetTsdQos();
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
        fftsCtx->schem = static_cast<uint16_t>(aicTaskInfo->schemMode);
        RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, taskType=%u", aicTaskInfo->schemMode, taskInfo->type);
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
    return;
}

rtError_t FillKernelLaunchPara(const rtKernelLaunchNames_t * const launchNames,
                               TaskInfo* taskInfo, ArgLoader * const devArgLdr)
{
    const char_t * const launchSoName = launchNames->soName;
    void *soNameAddr = nullptr;
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);

    // Set soName and kernelName for task
    if (launchSoName != nullptr) {
        const rtError_t retErr = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(launchSoName),
                                                                 KernelInfoType::SO_NAME, &soNameAddr);
        ERROR_RETURN(retErr, "Failed to get so address by name, retCode=%d.", retErr);
    }
    const char_t * const kernelName = launchNames->kernelName;
    void *kernelNameAddr = nullptr;
    if (kernelName != nullptr) {
        const rtError_t retErr = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(kernelName),
                                                                 KernelInfoType::KERNEL_NAME, &kernelNameAddr);
        ERROR_RETURN(retErr, "Failed to get kernel address by name, retCode=%d.", retErr);
    }
    aicpuTaskInfo->funcName = kernelNameAddr;
    aicpuTaskInfo->soName = soNameAddr;

    return RT_ERROR_NONE;
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
    sqe->kernel_credit = isNeedNoTimeout ? 0xFFU : static_cast<uint8_t>(GetAicpuKernelCredit(aicpuTaskInfo->timeout));

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

void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, rtStarsSqe_t *const command)
{
    RtFftsPlusKernelSqe *sqe = &(command->fftsPlusKernelSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Stream * const stm = taskInfo->stream;
    Device *dev = stm->Device_();
    uint64_t stackSize = KERNEL_STACK_SIZE_32K;
    constexpr uint32_t MAX_LEN_PER_LINE = 1024U;
    char programBuffStr[MAX_LEN_PER_LINE] = {0};
    const uint64_t funcAddr = aicTaskInfo->funcAddr;
    uint8_t funcType = 0U;
    uint32_t prefetchCnt1 = 0U;
    uint32_t minStackSize = 0U;
    if (aicTaskInfo->kernel != nullptr) {
        funcType = aicTaskInfo->kernel->GetFuncType();
        prefetchCnt1 = aicTaskInfo->kernel->PrefetchCnt1_();
        Program *programPtr = aicTaskInfo->kernel->Program_();
        if (programPtr != nullptr) {
            stackSize = programPtr->GetStackSize();
            (void)snprintf_s(programBuffStr, MAX_LEN_PER_LINE, MAX_LEN_PER_LINE - 1,
            "stackSize is [%lu], SoName is [%s], kernelName is [%s]",
            stackSize, programPtr->GetSoName().c_str(), programPtr->GetKernelNamesBuffer().c_str());
        }
        minStackSize = aicTaskInfo->kernel->GetMinStackSize1();
    }

    uint64_t stackPhyBase = 0UL;
    if (likely(minStackSize == 0)) {
        stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
        if (stackSize == KERNEL_STACK_SIZE_16K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase16k());
        }
        RT_LOG(RT_LOG_INFO, "stackSize=%u(bytes), stackPhyBase=%#llx", stackSize, stackPhyBase);
    } else {
        if (minStackSize <= KERNEL_STACK_SIZE_32K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
            stackSize = KERNEL_STACK_SIZE_32K;
        } else {
            stackPhyBase = RtPtrToValue(dev->GetCustomerStackPhyBase());
            stackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
        }
        RT_LOG(RT_LOG_INFO,
            "minStackSize=%u(bytes), stackSize=%u(bytes), stackPhyBase=%#llx",
            minStackSize, stackSize, stackPhyBase);
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
    ConstructFFTSPlusFFTSType(aicTaskInfo->machine, funcType, sqe);
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
        "schemMode=%u, taskType=%u, kernelFlag=%u, l2CacheProfFlag=%u, kernelCredit=%u, buff=%s, machine=%u.",
        stm->GetBindFlag(), Runtime::Instance()->GetBiuperfProfFlag(), sqe->fftsType, funcType, prefetchCnt1,
        Runtime::Instance()->GetChipType(), aicTaskInfo->schemMode, taskInfo->type, aicTaskInfo->comm.kernelFlag,
        Runtime::Instance()->GetL2CacheProfFlag(), sqe->kernel_credit, programBuffStr, aicTaskInfo->machine);
    if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) || (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
            sqe->schem = static_cast<uint16_t>(aicTaskInfo->schemMode);
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

static bool CheckArgsSize(TaskInfo* taskInfo, const uint32_t devId, const uint16_t taskId, const int32_t streamId)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const uint32_t argsSize = aicpuTaskInfo->comm.argsSize;
    const uint32_t aicpuKernelType = aicpuTaskInfo->aicpuKernelType;

    // check args
    if (aicpuTaskInfo->comm.args == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get extend info failed, device_id=%u, stream_id=%d, task_id=%u, task args is NULL!",
               devId, streamId, static_cast<uint32_t>(taskId));
        return false;
    }
    if (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_FMK) {
        // check argsSize (uint32_t fwkKernelType, uint64_t extInfoLen, uint64_t extInfoAddr)
        if (argsSize < (sizeof(uint32_t) + (sizeof(uint64_t) * 2U))) {
            RT_LOG(RT_LOG_ERROR, "Get extend info failed, device_id=%u, stream_id=%d, task_id=%u,"
                   " task args size %u is invalid, valid range is [%zu, %u].", devId, streamId,
                   static_cast<uint32_t>(taskId), argsSize,
                   (sizeof(uint32_t) + (sizeof(uint64_t) * 2U)), MAX_UINT32_NUM);
            return false;
        }
    } else if ((static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_AICPU) ||
        (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_CUSTOM_AICPU)) {
        // check argsSize (uint32_t length, uint32_t ioAddrNum, uint32_t extInfoLength, uint64_t extInfoAddr)
        if (argsSize < (sizeof(uint32_t) * 3U + sizeof(uint64_t))) {
            RT_LOG(RT_LOG_ERROR, "Get extend info failed, device_id=%u, stream_id=%d, task_id=%u,"
                   " task args size %u is invalid, valid range is [%zu, %u].", devId, streamId,
                   static_cast<uint32_t>(taskId), argsSize,
                   (sizeof(uint32_t) * 3U  + sizeof(uint64_t)), MAX_UINT32_NUM);
            return false;
        }
    } else {
        // no operation
    }
    return true;
}

void ParseExtendInfo(TaskInfo* taskInfo, const char_t *const extInfos, const uint64_t extInfoLen,
    const uint64_t extInfoStructLen, std::string &extendInfo)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);

    // get extend info
    if (static_cast<tsAicpuKernelType>(aicpuTaskInfo->aicpuKernelType) == TS_AICPU_KERNEL_FMK) {
        const uint64_t extInfoBuf = RtPtrToValue(extInfos);
        const int32_t infoType = *(RtValueToPtr<int32_t *>(extInfoBuf));
        const uint32_t infoLen = *(RtValueToPtr<uint32_t *>(extInfoBuf + sizeof(int32_t)));
        (void)extendInfo.append("(info_type:").append(std::to_string(infoType))
                .append(", info_len:").append(std::to_string(infoLen));
        const uint64_t infoMsgAddr = extInfoBuf + extInfoStructLen;
        (void)extendInfo.append(", msg_info:").append(RtValueToPtr<const char_t *>(infoMsgAddr),
            static_cast<size_t>(infoLen)).append(")");
        return;
    }
    size_t offset = 0;
    while (offset < extInfoLen) {
        const uint64_t extInfoBuf = RtPtrToValue(extInfos + offset);
        COND_RETURN_VOID(offset > (SIZE_MAX - (sizeof(int32_t) + sizeof(uint32_t))),
            "Overflow occur when parse extend info");
        if ((offset + sizeof(int32_t) + sizeof(uint32_t)) > extInfoLen) {
            break;
        }
        offset += (sizeof(int32_t) + sizeof(uint32_t));
        const int32_t infoType = *(RtValueToPtr<int32_t *>(extInfoBuf));
        const size_t infoLen = static_cast<size_t>(*(RtValueToPtr<uint32_t *>(extInfoBuf + sizeof(int32_t))));
        COND_RETURN_VOID(offset > (SIZE_MAX - infoLen), "Overflow occur when parse extend info");
        if ((offset + infoLen) >  extInfoLen) {
            break;
        }
        offset += infoLen;
        if (static_cast<aicpu::FWKAdapter::FWKTaskExtInfoType>(infoType) ==
            aicpu::FWKAdapter::FWK_ADPT_EXT_SHAPE_TYPE) {
            if (infoLen < sizeof(int32_t)) {
                break;
            }
            (void)extendInfo.append("(info_type:").append("SHAPE_TYPE")
                .append(", info_len:").append(std::to_string(infoLen));
            const uint64_t infoMsgAddr = extInfoBuf + extInfoStructLen;
            (void)extendInfo.append(", msg_info:").append(std::to_string(
                *(RtValueToPtr<int32_t *>(infoMsgAddr)))).append(")");
            break;
        }
    }
}

void GetFirstExtendInfoForAicpuTask(TaskInfo* taskInfo, const uint32_t devId, std::string &extendInfo)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint16_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    if (!CheckArgsSize(taskInfo, devId, taskId, streamId)) {
        return;
    }

    // copy args from device, align to 64 avoid memcpy core dump
    constexpr uint64_t alignBytes = 64LU;
    const uint32_t argsSize = aicpuTaskInfo->comm.argsSize;
    const uint32_t aicpuKernelType = aicpuTaskInfo->aicpuKernelType;
    uint64_t buffBytes = argsSize + alignBytes;
    std::unique_ptr<char_t[]> tmpBuff(new (std::nothrow) char_t[buffBytes]);
    COND_RETURN_VOID(tmpBuff == nullptr, "args malloc failed, argsSize=%u.", argsSize);
    auto tmpArgsAddr = RtPtrToValue(tmpBuff.get());
    tmpArgsAddr = (tmpArgsAddr + alignBytes - 1UL) & (~(alignBytes - 1UL));
    char_t *const dataArgs = RtValueToPtr<char_t*>(tmpArgsAddr);
    rtError_t error;
    COND_RETURN_VOID(dataArgs == nullptr, "args malloc failed, argsSize=%u.", argsSize);
    if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = driver->MemCopySync(dataArgs, static_cast<uint64_t>(argsSize),
                                    aicpuTaskInfo->comm.args, static_cast<uint64_t>(argsSize),
                                    RT_MEMCPY_DEVICE_TO_HOST);
    } else {
        error = driver->MemCopySync(dataArgs, static_cast<uint64_t>(argsSize),
                                    aicpuTaskInfo->comm.args, static_cast<uint64_t>(argsSize),
                                    RT_MEMCPY_DEVICE_TO_DEVICE);
    }
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "MemCopySync for args failed, device_id=%u, stream_id=%d, task_id=%u, retCode=%#x.",
            devId, streamId, static_cast<uint32_t>(taskId), error);
        return;
    }

    if (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_FMK) {
        // get fwkKernelType(FMK_KERNEL_TYPE_TF = 0) only tf kernel need print op name
        const uint32_t fwkKernelType = *(RtPtrToPtr<uint32_t *>(dataArgs));
        if (fwkKernelType != 0U) {
            RT_LOG(RT_LOG_INFO, "fwkKernelType=%u return", fwkKernelType);
            return;
        }
    }
    // get extInfoLen and extInfoAddr
    const auto argsAddr = RtPtrToValue(dataArgs);
    uint64_t extInfoLen = 0;
    uint64_t extInfoAddr = 0;
    if (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_FMK) {
        extInfoLen = *(RtValueToPtr<uint64_t *>(argsAddr + argsSize - (sizeof(uint64_t) * 2U)));
        extInfoAddr = *(RtValueToPtr<uint64_t *>(argsAddr + argsSize - sizeof(uint64_t)));
    } else if ((static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_AICPU) ||
        (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_CUSTOM_AICPU)) {
        const auto aicpuAddr = RtValueToPtr<aicpu::AicpuParamHead *>(argsAddr);
        extInfoLen = aicpuAddr->extInfoLength;
        extInfoAddr = aicpuAddr->extInfoAddr;
    } else {
        // no operation
    }

    // check extInfoLen (struct extInfo: int32_t infoType; uint32_t infoLen; char_t infoMsg[0])
    constexpr uint64_t extInfoStructLen = sizeof(int32_t) + sizeof(uint32_t);
    if (extInfoLen < extInfoStructLen) {
        RT_LOG(RT_LOG_ERROR, "Get extend info for tf or aicpu kernel, device_id=%u, stream_id=%d, task_id=%u, "
            "extInfoLen=%" PRIu64 "(bytes), extInfoAddr=%" PRIu64 ". extInfoLen is invalid, valid range is "
            "[%" PRIu64 ", %" PRIu64 "]",
            devId, streamId, static_cast<uint32_t>(taskId), extInfoLen, extInfoAddr, extInfoStructLen,
            MAX_UINT64_NUM);
        return;
    }
    RT_LOG(RT_LOG_INFO, "Get extend info for tf or aicpu kernel, device_id=%u, stream_id=%d, task_id=%u,"
           " extInfoLen=%" PRIu64 ", extInfoAddr=%" PRIu64, devId, streamId, static_cast<uint32_t>(taskId),
           extInfoLen, extInfoAddr);

    // copy extInfos from device, buffer need align to 64
    COND_RETURN_VOID(extInfoLen > (UINT64_MAX - alignBytes),
        "Overflow occur when align to %" PRIu64 " for aicpu extend info, extend info bytes=%" PRIu64,
        alignBytes, extInfoLen);
    buffBytes = extInfoLen + alignBytes;
    tmpBuff.reset(new (std::nothrow) char_t[buffBytes]);
    COND_RETURN_VOID(tmpBuff == nullptr, "malloc extInfos failed, extInfoLen=%" PRIu64 "(bytes).", extInfoLen);
    auto tmpExtInfosAddr = RtPtrToValue(tmpBuff.get());
    tmpExtInfosAddr = (tmpExtInfosAddr + alignBytes - 1UL) & (~(alignBytes - 1UL));
    char_t *const extInfos = RtValueToPtr<char_t*>(tmpExtInfosAddr);
    COND_RETURN_VOID(extInfos == nullptr, "malloc extInfos failed, extInfoLen=%" PRIu64 "(bytes)", extInfoLen);
    if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = driver->MemCopySync(static_cast<void *>(extInfos), extInfoLen,
                                    RtValueToPtr<void *>(extInfoAddr), extInfoLen,
                                    RT_MEMCPY_DEVICE_TO_HOST);
    } else {
        error = driver->MemCopySync(static_cast<void *>(extInfos), extInfoLen,
                                    RtValueToPtr<void *>(extInfoAddr), extInfoLen,
                                    RT_MEMCPY_DEVICE_TO_DEVICE);
    }
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "MemCopySync for extInfos failed, device_id=%u, stream_id=%d, task_id=%u.",
                         devId, streamId, static_cast<uint32_t>(taskId));
        return;
    }

    ParseExtendInfo(taskInfo, extInfos, extInfoLen, extInfoStructLen, extendInfo);

    RT_LOG(RT_LOG_INFO, "Extend info=%s.", extendInfo.c_str());

    return;
}

void GetKernelNameForAiCpu(TaskInfo* taskInfo, std::string &nameInfo)
{
    ArgLoader * const devArgLdr = taskInfo->stream->Device_()->ArgLoader_();
    devArgLdr->GetKernelInfoFromAddr(nameInfo, KernelInfoType::KERNEL_NAME, taskInfo->u.aicpuTaskInfo.funcName);
}

void GetSoNameForAiCpu(TaskInfo* taskInfo, std::string &nameInfo)
{
    ArgLoader * const devArgLdr = taskInfo->stream->Device_()->ArgLoader_();
    devArgLdr->GetKernelInfoFromAddr(nameInfo, KernelInfoType::SO_NAME, taskInfo->u.aicpuTaskInfo.soName);
}

static void PrintAicpuErrorInfo(TaskInfo* taskInfo, const uint32_t devId)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    const Kernel *kernel = aicpuTaskInfo->kernel;
    const std::string funcName = (kernel != nullptr) ? kernel->GetCpuFuncName() : "";
    std::string kernelName = (kernel != nullptr) ? kernel->GetCpuOpType() : "";
    std::string soName = (kernel != nullptr) ? kernel->GetCpuKernelSo() : "";

    if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) && (taskInfo->errorCode == TS_ERROR_AICPU_TIMEOUT)) {
        RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "Aicpu kernel execute failed, device_id=%u, stream_id=%d, "
            "%s=%u, soName=%s, funcName=%s, kernelName=%s.",
            devId, streamId, TaskIdDesc(), taskId, soName.c_str(), funcName.c_str(), kernelName.c_str());
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "Aicpu kernel execute failed, device_id=%u, stream_id=%d, "
            "%s=%u, soName=%s, funcName=%s, kernelName=%s, errorCode=%#x.",
            devId, streamId, TaskIdDesc(), taskId, soName.c_str(), funcName.c_str(), kernelName.c_str(), taskInfo->errorCode);
    }

    Stream *const reportStream = GetReportStream(taskInfo->stream);
    std::string extendInfo;
    const tsAicpuKernelType aicpuKernelType = static_cast<tsAicpuKernelType>(aicpuTaskInfo->aicpuKernelType);
    if ((aicpuKernelType == TS_AICPU_KERNEL_AICPU) ||
        (aicpuKernelType == TS_AICPU_KERNEL_CUSTOM_AICPU)) {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
            "Aicpu kernel execute failed, device_id=%u, stream_id=%d, %s=%u, fault op_name=%s.",
            devId, streamId, TaskIdDesc(), taskId, taskInfo->stream->GetTaskTag(taskInfo->id).c_str());
        return;
    }

    // get opName for tf task
    if (aicpuKernelType == TS_AICPU_KERNEL_FMK) {
        GetFirstExtendInfoForAicpuTask(taskInfo, devId, extendInfo);
    }
    (void)GetSoNameForAiCpu(taskInfo, soName);
    (void)GetKernelNameForAiCpu(taskInfo, kernelName);
    kernelName = (kernel != nullptr) ? kernel->GetCpuOpType() : kernelName;
    soName = (kernel != nullptr) ? kernel->GetCpuKernelSo() : soName;

    RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "Aicpu kernel execute failed, device_id=%u,stream_id=%d,"
        "%s=%u, soName=%s, funcName=%s, kernelName=%s",
        devId, streamId, TaskIdDesc(), taskId, soName.c_str(), funcName.c_str(), kernelName.c_str());

    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
        "Aicpu kernel execute failed, device_id=%u, stream_id=%d, %s=%u, flip_num=%hu, kernel_type=%u, "
        "fault op_name=%s, extend_info=%s.", devId, streamId, TaskIdDesc(), taskId,
        taskInfo->flipNum, aicpuKernelType,
        taskInfo->stream->GetTaskTag(taskInfo->id).c_str(), extendInfo.c_str());
}

rtError_t GetMixCtxInfo(TaskInfo* taskInfo)
{
    const auto dev = taskInfo->stream->Device_();
    rtFftsPlusMixAicAivCtx_t contextInfo = {};
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    if (aicTaskInfo->descAlignBuf == nullptr) {
        RT_LOG(RT_LOG_ERROR, "descAlignBuf is invalid, device_id=%u, stream_id=%d, task_id=%u.",
            dev->Id_(), taskInfo->stream->Id_(), taskInfo->id);
        return RTS_INNER_ERROR;
    }
    Driver * const devDrv = dev->Driver_();
    const rtError_t ret = devDrv->MemCopySync(&contextInfo, CONTEXT_ALIGN_LEN,
        aicTaskInfo->descAlignBuf, CONTEXT_ALIGN_LEN, RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync failed, retCode=%#x.", ret);
        return ret;
    }
    const uint32_t * const buf = RtPtrToPtr<uint32_t *>(&contextInfo);
    for (uint32_t j = 0U; j < 32U; j++) {
        RT_LOG(RT_LOG_ERROR, "The DavinciTask Mix context-buf[%u]=%#010x.", j, buf[j]);
    }

    return RT_ERROR_NONE;
}

rtError_t GetArgsInfo(TaskInfo* taskInfo)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t tilingKey = aicTaskInfo->tilingKey;
    void *hostMem = nullptr;
    COND_RETURN_ERROR_MSG_INNER((aicTaskInfo->comm.args == nullptr) || (aicTaskInfo->comm.argsSize == 0U),
        RT_ERROR_INVALID_VALUE, "Get args info failed, address size=%u", aicTaskInfo->comm.argsSize);
    const auto dev = taskInfo->stream->Device_();
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostMem, static_cast<uint64_t>(aicTaskInfo->comm.argsSize) + 1U,
        dev->Id_());
    ERROR_RETURN(error, "Malloc host memory for args failed, retCode=%#x",
                 static_cast<uint32_t>(error));
    error = dev->Driver_()->MemCopySync(hostMem, static_cast<uint64_t>(aicTaskInfo->comm.argsSize + 1U),
        aicTaskInfo->comm.args, static_cast<uint64_t>(aicTaskInfo->comm.argsSize), RT_MEMCPY_DEVICE_TO_HOST);
    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, (void)dev->Driver_()->HostMemFree(hostMem);,
        "Memcpy failed, size=%u, type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
        aicTaskInfo->comm.argsSize, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
    // args info
    const uint32_t totalLen = aicTaskInfo->comm.argsSize / static_cast<uint32_t>(sizeof(void *));
    const uint32_t argsTimes = (totalLen % ARGS_PER_STRING_MAX_LEN > 0) ? ((totalLen / ARGS_PER_STRING_MAX_LEN) + 1U) :
            (totalLen / ARGS_PER_STRING_MAX_LEN);
    for (uint32_t j = 1UL; j <= argsTimes; j++) {
        std::stringstream ss;
        uint32_t i = 0U;
        const uint32_t curLen = totalLen > (j * ARGS_PER_STRING_MAX_LEN) ? (j * ARGS_PER_STRING_MAX_LEN) : totalLen;
        for (i = (j - 1U) * ARGS_PER_STRING_MAX_LEN; i < curLen - 1; ++i) {
            ss << RtValueToPtr<uint64_t *>(*(RtPtrToPtr<uint64_t *>(hostMem) + i)) << ", ";
        }
        ss << RtValueToPtr<uint64_t *>(*(RtPtrToPtr<uint64_t *>(hostMem) + i));
        RT_LOG(RT_LOG_ERROR, "[AIC_INFO] args(%u to %u) after execute:%s.",
            (j - 1U) * ARGS_PER_STRING_MAX_LEN, curLen - 1U, ss.str().c_str());
    }
    RT_LOG(RT_LOG_ERROR, "tilingKey = %" PRIu64 ", print %u Times totalLen=(%u*8), argsSize=%u, blockDim=%hu",
        tilingKey, argsTimes, totalLen, aicTaskInfo->comm.argsSize, aicTaskInfo->comm.dim);
    (void)dev->Driver_()->HostMemFree(hostMem);
    return RT_ERROR_NONE;
}

void PrintErrorInfoForDavinciTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    const uint32_t tsId = taskInfo->stream->Device_()->DevGetTsId();

    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        if (taskInfo->errorCode != TS_ERROR_END_OF_SEQUENCE) {
            PrintAicpuErrorInfo(taskInfo, devId);
        }
    } else {
        AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        std::string kernelNameStr = "";
        std::string kernelInfoExt = "";
        std::size_t hashKeyNum = 0U;
        Program *programPtr = nullptr;

        if ((aicTaskInfo != nullptr) && (aicTaskInfo->kernel != nullptr)) {
            programPtr = aicTaskInfo->kernel->Program_();
            kernelNameStr = aicTaskInfo->kernel->Name_();
            kernelInfoExt = aicTaskInfo->kernel->KernelInfoExtString();
        }

        kernelNameStr = kernelNameStr.empty() ? ("none") : kernelNameStr;
        kernelInfoExt = kernelInfoExt.empty() ? ("none") : kernelInfoExt;
        if (unlikely(programPtr == nullptr)) {
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "[DFX_INFO]Aicore kernel execute failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
                " flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, program is NULL!", devId, streamId,
                reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
            return;
        }

        rtError_t ret = GetArgsInfo(taskInfo);
        const std::string argsInfo = (ret != RT_ERROR_NONE) ? "(no result)" : "args print end";
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE, "[AIC_INFO] after execute:%s", argsInfo.c_str());
        
        if (aicTaskInfo->kernel->GetMixType() != NO_MIX) {
            ret = GetMixCtxInfo(taskInfo);
            const std::string mixCtxInfo = (ret != RT_ERROR_NONE) ? "(no result)" : "mixCtx print end";
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE, "[AIC_INFO] after execute:%s", mixCtxInfo.c_str());
        }

        Context *const contextPtr = Runtime::Instance()->GetPriCtxByDeviceId(devId, tsId);
        if (unlikely(contextPtr == nullptr)) {
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "[DFX_INFO]Aicore kernel execute failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
                " flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, ctx is NULL!", devId, streamId,
                reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
            return;
        }
        Module *const modulePtr = contextPtr->GetModule(programPtr);
        if (unlikely(modulePtr == nullptr)) {
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "[DFX_INFO]Aicore kernel execute failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
                " flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, module is nullptr!", devId, streamId,
                reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
            return;
        }
        const auto error = modulePtr->CalModuleHash(hashKeyNum);
        const std::string hashInfo = (error != RT_ERROR_NONE) ? "(no result)" : (std::to_string(hashKeyNum).c_str());
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
            "[DFX_INFO]Aicore kernel execute failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u, "
            "flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, program id=%u, hash=%s.", devId, streamId,
            reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str(),
            programPtr->Id_(), hashInfo.c_str());
    }
}

void PrintErrorInfoForCmoTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const auto dev = taskInfo->stream->Device_();
    CmoAddrTaskInfo *cmoAddrTaskInfo = &(taskInfo->u.cmoAddrTaskInfo);
    Stream * const stream = taskInfo->stream;
    const int32_t streamId = stream->Id_();
    const uint32_t taskId = taskInfo->id;
    if (stream->Model_() == nullptr) {
        return;
    }

    void *hostMemSrc = nullptr;
    constexpr uint64_t rtCmoAddrInfoSize = sizeof(rtCmoAddrInfo);
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostMemSrc, rtCmoAddrInfoSize, dev->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
        return;
    }
    error = dev->Driver_()->MemCopySync(hostMemSrc, rtCmoAddrInfoSize,
        cmoAddrTaskInfo->cmoAddrInfo, rtCmoAddrInfoSize, RT_MEMCPY_DEVICE_TO_HOST);
    if (error != RT_ERROR_NONE) {
        (void)dev->Driver_()->HostMemFree(hostMemSrc);
        RT_LOG(RT_LOG_ERROR, "Memcpy failed, size=%lu(bytes), type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
            rtCmoAddrInfoSize, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
        return;
    }

    const uint32_t * const cmd = RtPtrToPtr<const uint32_t * const>(hostMemSrc);
    RT_LOG(RT_LOG_ERROR, "Sdma for CmoAddrTask in model stream execute failed, device_id=%u, stream_id=%d, task_id=%u",
        devId, streamId, taskId);
    for (size_t i = 0UL; i < (sizeof(rtCmoAddrInfo) / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_ERROR, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", "rtCmoAddrInfo",
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }
    (void)dev->Driver_()->HostMemFree(hostMemSrc);
}

bool CheckErrPrint(const uint32_t errorCode)
{
    if ((errorCode != TS_ERROR_END_OF_SEQUENCE)
        && (errorCode != TS_MODEL_ABORT_NORMAL)
        && (errorCode != TS_ERROR_AICORE_OVERFLOW)
        && (errorCode != TS_ERROR_AIVEC_OVERFLOW)
        && (errorCode != TS_ERROR_AICPU_OVERFLOW)) {
        return true;
    }
    return false;
}

static bool IsAiCoreMemErrorCode(const uint16_t errCode)
{
    return ((errCode == TS_ERROR_AICORE_MTE_ERROR) || (errCode == TS_ERROR_SDMA_LINK_ERROR));
}

void PreCheckTaskErr(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    const tsTaskType_t type = taskInfo->type;

    if ((type == TS_TASK_TYPE_KERNEL_AICPU) && (errorCode == AE_STATUS_TASK_ABORT)) {
        RT_LOG(RT_LOG_ERROR, "aicpu errcode=0x%x",  errorCode);
        return;
    }

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        rtError_t rtErrCode;
        const int32_t moduleType = (type == TS_TASK_TYPE_KERNEL_AICPU) ? ERR_MODULE_AICPU : ERR_MODULE_TBE;
        if ((type == TS_TASK_TYPE_KERNEL_AICPU) && (errorCode != TS_ERROR_AICPU_TIMEOUT) &&
            (errorCode != TS_ERROR_AICPU_EXCEPTION) && (errorCode != TS_ERROR_END_OF_SEQUENCE) &&
            (errorCode != TS_ERROR_AICPU_DATADUMP_RSP_ERR) && (errorCode != TS_ERROR_AICPU_MODEL_RSP_ERR) &&
            (errorCode != TS_ERROR_AICPU_OVERFLOW) && (errorCode != TS_ERROR_AICPU_INFO_LOAD_RSP_ERR)) {
            RT_LOG_CALL_MSG(moduleType, "Kernel task happen error, receive aicpu failed msg, aicpu"
                " error code=0x%x, [%s].", errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
        } else if (CheckErrPrint(errorCode)) {
            if ((type == TS_TASK_TYPE_KERNEL_AICPU) && (errorCode == TS_ERROR_AICPU_TIMEOUT)) {
                RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "Kernel task happen error, retCode=%#x, [%s].",
                    errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
            } else {
                RT_LOG_CALL_MSG(moduleType, "Kernel task happen error, retCode=%#x, [%s].",
                    errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
            }
        } else {
            // no operation
        }
        RT_LOG(RT_LOG_INFO, "report module_type=%d, mte_error=%u, errcode=0x%x",
            moduleType, taskInfo->mte_error, taskInfo->stream->GetErrCode());
        if (IsAiCoreMemErrorCode(taskInfo->mte_error)) {
            taskInfo->stream->SetErrCode(taskInfo->mte_error);
            taskInfo->errorCode =  static_cast<int32_t>(taskInfo->mte_error);
            taskInfo->mte_error = 0U;
        } else {
            taskInfo->stream->SetErrCode(errorCode);
        }

        if (CheckErrPrint(errorCode)) {
            PrintErrorInfo(taskInfo, devId);
        }
    }
}

std::string GetTaskKernelName(const TaskInfo *task)
{
    if ((task == nullptr) ||
        ((task->type != TS_TASK_TYPE_KERNEL_AICORE) && (task->type != TS_TASK_TYPE_KERNEL_AIVEC))) {
        return "none";
    }
    std::string kernelNameStr = "";
    const AicTaskInfo *aicTaskInfo = &task->u.aicTaskInfo;
    if ((aicTaskInfo != nullptr) && (aicTaskInfo->kernel != nullptr)) {
        kernelNameStr = aicTaskInfo->kernel->Name_();
    }
    return kernelNameStr.empty() ? ("none") : kernelNameStr;
}

#endif
}  // namespace runtime
}  // namespace cce