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

void AicTaskInitCommon(TaskInfo *taskInfo, const Kernel *kernel, const rtKernelAttrType kernelAttrType,
    const uint16_t dimNum, const uint32_t flag, const bool isNeedAllocSqeDevBuf)
{
    TaskCommonInfoInit(taskInfo);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    DavinciTaskInitCommon(&(aicTaskInfo->comm), dimNum, flag, taskInfo->isUpdateSinkSqe);

    if (kernelAttrType == RT_KERNEL_ATTR_TYPE_VECTOR) {
        taskInfo->type = TS_TASK_TYPE_KERNEL_AIVEC;
        taskInfo->typeName = const_cast<char_t*>("KERNEL_AIVEC");
    } else {
        taskInfo->type = TS_TASK_TYPE_KERNEL_AICORE;
        taskInfo->typeName = const_cast<char_t*>("KERNEL_AICORE");
    }

    aicTaskInfo->argsInfo = nullptr;
    aicTaskInfo->tilingKey = 0ULL;

    aicTaskInfo->kernelTaskMode = RT_DEFAULT_KERNEL_MODE;
    aicTaskInfo->qos = 0U;
    aicTaskInfo->partId = 0U;
    const uint32_t schedMode = (kernel == nullptr) ? static_cast<uint32_t>(RT_SCHEM_MODE_NORMAL) : kernel->GetSchedMode();
    aicTaskInfo->schemMode = static_cast<uint8_t>(schedMode);
    aicTaskInfo->infMode = 0U;

    aicTaskInfo->mixOpt = false;
    aicTaskInfo->dynamicShareMemSize = 0U;
    aicTaskInfo->simtDcuSmSize = RT_SIMT_UB_SIZE;
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
    aicpuTaskInfo->kernelInnerHandle = nullptr;
    aicpuTaskInfo->headParamOffset = 0U;
    aicpuTaskInfo->aicpuArgsInfo = nullptr;
    aicpuTaskInfo->aicpuKernelType = TS_AICPU_KERNEL_CCE;
    return;
}

void AicTaskInit(TaskInfo *taskInfo, const Kernel *kernel, const rtKernelAttrType kernelAttrType,
    const uint16_t dimNum, const TaskCfg * const taskcfg, const bool isNeedAllocSqeDevBuf)
{
    uint32_t flag = RT_KERNEL_DEFAULT;
    if ((taskcfg != nullptr) && (taskcfg->isBaseValid == 1U) &&
        ((taskcfg->base.dumpflag == RT_KERNEL_DUMPFLAG) || (taskcfg->base.dumpflag == RT_FUSION_KERNEL_DUMPFLAG))) {
        flag = static_cast<uint32_t>(taskcfg->base.dumpflag);
        RT_LOG(RT_LOG_WARNING, "dumpflag set %u.", taskcfg->base.dumpflag);
    }
    
    AicTaskInitCommon(taskInfo, kernel, kernelAttrType, dimNum, flag, isNeedAllocSqeDevBuf);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    if (taskcfg == nullptr) {
        return;
    }

    if (taskcfg->isBaseValid == 1U) {
        aicTaskInfo->qos = taskcfg->base.qos;
        aicTaskInfo->partId = taskcfg->base.partId;
        if (taskcfg->base.schemMode != RT_SCHEM_MODE_END) {
            aicTaskInfo->schemMode = taskcfg->base.schemMode;
        }
        aicTaskInfo->blockDimOffset = taskcfg->base.blockDimOffset;
        aicTaskInfo->dynamicShareMemSize = taskcfg->base.localMemorySize;

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
        (taskInfo->stream->Device_()->CheckFeatureSupport(TS_FEATURE_OP_EXEC_TIMEOUT_MS) ||
         taskInfo->stream->Device_()->CheckFeatureSupport(TS_FEATURE_AICORE_NEVER_TIMEOUT));
    COND_PROC(((aicTaskInfo->timeout == MAX_UINT64_NUM) && (!isSupportOpNeverTimeout)), aicTaskInfo->timeout -= 1UL);

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

static void CheckCoreLimit(TaskInfo* const taskInfo, const rtDevResLimitType_t resType, const uint16_t blockDim)
{
    const uint32_t coreNum = taskInfo->stream->Device_()->GetResInitValue(resType);
    COND_RETURN_VOID_WARN(blockDim > coreNum,
        "blockDim exceeds coreNum, drv devId=%u, resType=%d, blockDim=%hu, coreNum=%u",
        taskInfo->stream->Device_()->Id_(),
        resType,
        blockDim,
        coreNum);
}

static rtDevResLimitType_t GetCoreType(const TaskInfo* const taskInfo, const RtFftsPlusKernelSqe* const sqe,
    const rtFftsPlusMixAicAivCtx_t* const fftsCtx)
{
    if (fftsCtx != nullptr) {
        switch (fftsCtx->contextType) {
            case RT_CTX_TYPE_MIX_AIC:
                return RT_DEV_RES_CUBE_CORE;
            case RT_CTX_TYPE_MIX_AIV:
                return RT_DEV_RES_VECTOR_CORE;
            default:
                break;
        }
        return RT_DEV_RES_TYPE_MAX;
    }

    if (sqe != nullptr) {
        switch (sqe->fftsType) {
            case TS_FFTS_TYPE_AIC_ONLY:
                return RT_DEV_RES_CUBE_CORE;
            case TS_FFTS_TYPE_AIV_ONLY:
                return RT_DEV_RES_VECTOR_CORE;
            default:
                break;
        }
        return RT_DEV_RES_TYPE_MAX;
    }

    switch (taskInfo->type) {
        case TS_TASK_TYPE_KERNEL_AICORE:
            return RT_DEV_RES_CUBE_CORE;
        case TS_TASK_TYPE_KERNEL_AIVEC:
            return RT_DEV_RES_VECTOR_CORE;
        default:
            break;
    }

    return RT_DEV_RES_TYPE_MAX;
}

void CheckBlockDim(TaskInfo* const taskInfo, const RtFftsPlusKernelSqe* const sqe,
                        const rtFftsPlusMixAicAivCtx_t* const fftsCtx)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    if (aicTaskInfo->schemMode != RT_SCHEM_MODE_BATCH) {
        return;
    }

    const uint16_t blockDim = aicTaskInfo->comm.dim;
    const rtDevResLimitType_t coreType = GetCoreType(taskInfo, sqe, fftsCtx);
    if (coreType == RT_DEV_RES_TYPE_MAX) {
        return;
    }

    if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_DEVICE_EXTRA_VECTOR_CORE) &&
        coreType == RT_DEV_RES_VECTOR_CORE) {
        const uint32_t cubeCoreNum = taskInfo->stream->Device_()->GetResInitValue(RT_DEV_RES_CUBE_CORE);
        const uint32_t vectorCoreNum = taskInfo->stream->Device_()->GetResInitValue(RT_DEV_RES_VECTOR_CORE);
        const uint32_t totalCoreNum = cubeCoreNum + vectorCoreNum;

        COND_RETURN_VOID_WARN(blockDim > totalCoreNum,
            "blockDim exceeds total coreNum, drv devId=%u, blockDim=%hu, cubeCoreNum=%u, vectorCoreNum=%u, totalCoreNum=%u",
            taskInfo->stream->Device_()->Id_(),
            blockDim,
            cubeCoreNum,
            vectorCoreNum,
            totalCoreNum);
    } else {
        CheckCoreLimit(taskInfo, coreType, blockDim);
    }
}

void ToCommandBodyForAicAivTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Stream * const stm = taskInfo->stream;

    command->u.kernelTask.isConvertAddr = 0U;
    bool needConvert = true;
    const uint8_t l2Size = 0U;
    needConvert = false;

    command->u.kernelTask.priority = stm->Priority();
    command->u.kernelTask.L2_size = l2Size;
    command->u.kernelTask.L2PreloadCtrl = 0;
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

    CheckBlockDim(taskInfo, nullptr, nullptr);
    command->u.kernelTask.schemMode = aicTaskInfo->schemMode;

    RT_LOG(RT_LOG_DEBUG, "funcAddr=%#" PRIx64 ", args=%#" PRIx64 ", isConvertAddr=%u, kernelFlag=%u, schemMode=%u, taskType=%u.",
        command->u.kernelTask.funcPtr, command->u.kernelTask.funcDesc, 
        static_cast<uint32_t>(command->u.kernelTask.isConvertAddr), static_cast<uint32_t>(aicTaskInfo->comm.kernelFlag),
        command->u.kernelTask.schemMode, taskInfo->type);
}

void ToCommandBodyForAicpuTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
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
    uint8_t &mixType, rtKernelAttrType &kernelAttrType, const bool isLaunchVec)
{
    if (((flags & RT_STREAM_VECTOR_CORE_USE) == 0U) && (!isLaunchVec)) {
        return;
    }
    /* transform some part of mix op to vector core. Only 51DC support.
       vector core op pc_start store in addr2,but sqe use addr1 as pc_start.
    */
    addr1 = addr2;
    mixType = static_cast<uint8_t>(NO_MIX);
    kernelAttrType = RT_KERNEL_ATTR_TYPE_VECTOR;
}

void SetPcTrace(TaskInfo *taskInfo, std::shared_ptr<PCTrace> pcTracePtr)
{
    taskInfo->pcTrace = std::move(pcTracePtr);
}

uint16_t GetAICpuQos(const TaskInfo * const taskInfo)
{
    return taskInfo->stream->Device_()->GetTsdQos();
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

static bool CheckArgsSize(TaskInfo* taskInfo, const uint32_t devId, const uint16_t taskId, const int32_t streamId)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const uint32_t argsSize = aicpuTaskInfo->comm.argsSize;
    const uint32_t aicpuKernelType = aicpuTaskInfo->aicpuKernelType;

    // check args
    COND_RETURN_ERROR_MSG_INNER(aicpuTaskInfo->comm.args == nullptr, false,
        "CheckArgsSize failed because aicpuTaskInfo->comm.args cannot be a NULL pointer,"
        " device_id=%u, stream_id=%d, task_id=%u.", devId, streamId, static_cast<uint32_t>(taskId));
    if (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_FMK) {
        // check argsSize (uint32_t fwkKernelType, uint64_t extInfoLen, uint64_t extInfoAddr)
        COND_RETURN_ERROR_MSG_INNER(argsSize < (sizeof(uint32_t) + (sizeof(uint64_t) * 2U)), false,
            "CheckArgsSize failed because value %u for parameter argsSize is invalid. Expected value: [%zu, %u]."
            " device_id=%u, stream_id=%d, task_id=%u.", argsSize, (sizeof(uint32_t) + (sizeof(uint64_t) * 2U)),
            MAX_UINT32_NUM, devId, streamId, static_cast<uint32_t>(taskId));
    } else if ((static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_AICPU) ||
        (static_cast<tsAicpuKernelType>(aicpuKernelType) == TS_AICPU_KERNEL_CUSTOM_AICPU)) {
        // check argsSize (uint32_t length, uint32_t ioAddrNum, uint32_t extInfoLength, uint64_t extInfoAddr)
        COND_RETURN_ERROR_MSG_INNER(argsSize < (sizeof(uint32_t) * 3U + sizeof(uint64_t)), false,
            "CheckArgsSize failed because value %u for parameter argsSize is invalid. Expected value: [%zu, %u]."
            " device_id=%u, stream_id=%d, task_id=%u.", argsSize, (sizeof(uint32_t) * 3U  + sizeof(uint64_t)),
            MAX_UINT32_NUM, devId, streamId, static_cast<uint32_t>(taskId));
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
    if (tmpBuff == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, buffBytes * sizeof(char_t), "new");
        return;
    }
    auto tmpArgsAddr = RtPtrToValue(tmpBuff.get());
    tmpArgsAddr = (tmpArgsAddr + alignBytes - 1UL) & (~(alignBytes - 1UL));
    char_t *const dataArgs = RtValueToPtr<char_t*>(tmpArgsAddr);
    rtError_t error;
    if (dataArgs == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, buffBytes * sizeof(char_t) - alignBytes + 1UL, "new");
        return;
    }
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
        RT_LOG(RT_LOG_ERROR, "MemCopySync for args failed, device_id=%u, stream_id=%d, task_id=%u, retCode=%#x.",
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
        RT_LOG(RT_LOG_ERROR, "Get extend info about the tf or aicpu kernel, device_id=%u, stream_id=%d, task_id=%u, "
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
        "Overflow occur when align to %" PRIu64 " for aicpu extend info, extendInfo=%" PRIu64 ".",
        alignBytes, extInfoLen);
    buffBytes = extInfoLen + alignBytes;
    tmpBuff.reset(new (std::nothrow) char_t[buffBytes]);
    if (tmpBuff == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, buffBytes * sizeof(char_t), "new");
        return;
    }
    auto tmpExtInfosAddr = RtPtrToValue(tmpBuff.get());
    tmpExtInfosAddr = (tmpExtInfosAddr + alignBytes - 1UL) & (~(alignBytes - 1UL));
    char_t *const extInfos = RtValueToPtr<char_t*>(tmpExtInfosAddr);
    if (extInfos == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, buffBytes * sizeof(char_t), "new");
        return;
    }
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
        RT_LOG(RT_LOG_ERROR, "MemCopySync for extInfos failed, device_id=%u, stream_id=%d, task_id=%u.",
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
    bool isKernelValid = false;
    const auto * const innerObject = aicpuTaskInfo->kernelInnerHandle;
    if ((innerObject != nullptr) && (innerObject->magic.load() == RT_KERNEL_MAGIC)) {
        isKernelValid = true;
    }
    if (kernel != nullptr) {
        RT_LOG(RT_LOG_ERROR, "kernel is not null, device_id=%u, stream_id=%d, %s=%u, isKernelValid=%d.", 
            devId, streamId, TaskIdDesc(), taskId, isKernelValid);
    }
    const std::string funcName = (isKernelValid && kernel != nullptr) ? kernel->GetCpuFuncName() : "";
    std::string kernelName = (isKernelValid && kernel != nullptr) ? kernel->GetCpuOpType() : "";
    std::string soName = (isKernelValid && kernel != nullptr) ? kernel->GetCpuKernelSo() : "";

    if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) && (taskInfo->errorCode == TS_ERROR_AICPU_TIMEOUT)) {
        const std::string errMsg = "The AI CPU operator " + kernelName + " that times out is on device " +
            std::to_string(devId) + " stream " + std::to_string(streamId) + ". The task ID is " + std::to_string(taskId) +
            ", the so name is " + soName + ", and the entry function for executing this AI CPU operator is " + funcName + ".";
        RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "%s", errMsg.c_str());
    } else {
        RT_LOG_CALL_MSG_NO_RT_LOG(ERR_MODULE_AICPU, "AI CPU kernel execution failed, device_id=%u, stream_id=%d, "
            "%s=%u, soName=%s, funcName=%s, kernelName=%s, errorCode=%#x.",
            devId, streamId, TaskIdDesc(), taskId, soName.c_str(), funcName.c_str(), kernelName.c_str(), taskInfo->errorCode);
    }

    Stream *const reportStream = GetReportStream(taskInfo->stream);
    std::string extendInfo;
    const tsAicpuKernelType aicpuKernelType = static_cast<tsAicpuKernelType>(aicpuTaskInfo->aicpuKernelType);
    if ((aicpuKernelType == TS_AICPU_KERNEL_AICPU) || (aicpuKernelType == TS_AICPU_KERNEL_CUSTOM_AICPU)) {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
            "AI CPU kernel execution failed, device_id=%u, stream_id=%d, %s=%u, fault op_name=%s, soName=%s, funcName=%s, kernelName=%s.",
            devId, streamId, TaskIdDesc(), taskId, taskInfo->stream->GetTaskTag(taskInfo->id).c_str(),
            soName.c_str(), funcName.c_str(), kernelName.c_str());
        return;
    }

    // get opName for tf task
    if (aicpuKernelType == TS_AICPU_KERNEL_FMK) {
        GetFirstExtendInfoForAicpuTask(taskInfo, devId, extendInfo);
    }
    (void)GetSoNameForAiCpu(taskInfo, soName);
    (void)GetKernelNameForAiCpu(taskInfo, kernelName);
    kernelName = (isKernelValid && kernel != nullptr) ? kernel->GetCpuOpType() : kernelName;
    soName = (isKernelValid && kernel != nullptr) ? kernel->GetCpuKernelSo() : soName;

    RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "AI CPU kernel execution failed, device_id=%u, stream_id=%d,"
        "%s=%u, soName=%s, funcName=%s, kernelName=%s.",
        devId, streamId, TaskIdDesc(), taskId, soName.c_str(), funcName.c_str(), kernelName.c_str());
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
        "AI CPU kernel execution failed, device_id=%u, stream_id=%d, %s=%u, flip_num=%hu, kernel_type=%u, "
        "fault op_name=%s, extend_info=%s.", devId, streamId, TaskIdDesc(), taskId, taskInfo->flipNum, 
        aicpuKernelType, taskInfo->stream->GetTaskTag(taskInfo->id).c_str(), extendInfo.c_str());
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
        RT_ERROR_INVALID_VALUE, "GetArgsInfo failed, address size=%u.", aicTaskInfo->comm.argsSize);
    const auto dev = taskInfo->stream->Device_();
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostMem, static_cast<uint64_t>(aicTaskInfo->comm.argsSize) + 1U,
        dev->Id_());
    ERROR_RETURN(error, "Malloc host memory for args failed, retCode=%#x",
                 static_cast<uint32_t>(error));
    error = dev->Driver_()->MemCopySync(hostMem, static_cast<uint64_t>(aicTaskInfo->comm.argsSize + 1U),
        aicTaskInfo->comm.args, static_cast<uint64_t>(aicTaskInfo->comm.argsSize), RT_MEMCPY_DEVICE_TO_HOST);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, (void)dev->Driver_()->HostMemFree(hostMem),
        "Memcpy failed, size=%u, type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x.",
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
    RT_LOG(RT_LOG_ERROR, "tilingKey = %" PRIu64 ", print %u Times totalLen=(%u*8), argsSize=%u, schemMode=%u,"
        " blockDim=%hu", tilingKey, argsTimes, totalLen, aicTaskInfo->comm.argsSize, aicTaskInfo->schemMode,
        aicTaskInfo->comm.dim);
    (void)dev->Driver_()->HostMemFree(hostMem);
    return RT_ERROR_NONE;
}

void HandleSimtPrintErrorInfo(Device * const dev) { 
    const uint32_t fifoSize = dev->GetSimtPrintLen(); 
    void* simtPrintfAddr = dev->GetSimtPrintfAddr(); 
    if (simtPrintfAddr == nullptr) { 
        RT_LOG(RT_LOG_WARNING, "Simt printf addr is nullptr, device_id=%u", dev->Id_()); 
        return; 
    } 
    void *hostBlockSrc = nullptr; 
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostBlockSrc, fifoSize, dev->Id_()); 
    if (error != RT_ERROR_NONE) { 
        RT_LOG(RT_LOG_ERROR, "Malloc host memory for fifo d2h failed, retCode=%#x, device_id=%u",  
            static_cast<uint32_t>(error), dev->Id_()); 
        return; 
    } 

    // D2H拷贝 
    error = dev->Driver_()->MemCopySync(hostBlockSrc, fifoSize, simtPrintfAddr, fifoSize,   
        RT_MEMCPY_DEVICE_TO_HOST, false); 
    if (error != RT_ERROR_NONE) { 
        (void)dev->Driver_()->HostMemFree(hostBlockSrc); 
        RT_LOG(RT_LOG_ERROR, "Memcpy failed, size=%lu(bytes), type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x," 
            " device_id=%u", fifoSize, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST),  
            static_cast<uint32_t>(error), dev->Id_()); 
        return; 
    } 

    // 解析头部信息 
    const uint8_t * const blockAddr = RtPtrToPtr<const uint8_t * const>(hostBlockSrc); 
    const BlockReadInfo *readInfo = RtPtrToPtr<const BlockReadInfo *>(blockAddr + sizeof(BlockInfo)); 
    const BlockWriteInfo *writeInfo = 
        RtPtrToPtr<const BlockWriteInfo *>(blockAddr + fifoSize - sizeof(BlockWriteInfo)); 

    RT_LOG(RT_LOG_ERROR, "simt fifo block info, device_id=%u, simt readIdx=%llu, simt writeIdx=%llu," 
        " write packIdx=%llu, simt print tlvCnt=%llu", dev->Id_(), readInfo->readIdx, writeInfo->writeIdx, 
        writeInfo->packIdx, dev->GetSimtPrintTlvCnt()); 
    (void)dev->Driver_()->HostMemFree(hostBlockSrc); 
    return; 
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
                "[DFX_INFO]AI Core kernel execution failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
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
                "[DFX_INFO]AI Core kernel execution failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
                " flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, ctx is NULL!", devId, streamId,
                reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
            return;
        }
        Module *const modulePtr = contextPtr->GetModule(programPtr);
        if (unlikely(modulePtr == nullptr)) {
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "[DFX_INFO]AI Core kernel execution failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
                " flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, module is nullptr!", devId, streamId,
                reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
            return;
        }
        const auto error = modulePtr->CalModuleHash(hashKeyNum);
        const std::string hashInfo = (error != RT_ERROR_NONE) ? "(no result)" : (std::to_string(hashKeyNum).c_str());
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
            "[DFX_INFO]AI Core kernel execution failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u, "
            "flip_num=%hu, fault kernel_name=%s, fault kernel info ext=%s, program id=%u, hash=%s.", devId, streamId,
            reportStream->Id_(), taskId, taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str(),
            programPtr->Id_(), hashInfo.c_str());
 
        Device * const dev = RtPtrToPtr<Device*>(taskInfo->stream->Device_()); 
        if (dev->GetPrintSimtEnable()) { 
            HandleSimtPrintErrorInfo(dev); 
        }
    }
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
    return ((errCode == TS_ERROR_AICORE_MTE_ERROR) || (errCode == TS_ERROR_SDMA_LINK_ERROR) ||
        (errCode == TS_ERROR_LINK_ERROR));
}

void PreCheckTaskErr(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    const tsTaskType_t type = taskInfo->type;

    if ((type == TS_TASK_TYPE_KERNEL_AICPU) && (errorCode == AE_STATUS_TASK_ABORT)) {
        RT_LOG(RT_LOG_ERROR, "aicpu errcode=0x%x", errorCode);
        return;
    }

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        rtError_t rtErrCode;
        const int32_t moduleType = (type == TS_TASK_TYPE_KERNEL_AICPU) ? ERR_MODULE_AICPU : ERR_MODULE_TBE;
        if ((type == TS_TASK_TYPE_KERNEL_AICPU) && (errorCode != TS_ERROR_AICPU_TIMEOUT) &&
            (errorCode != TS_ERROR_AICPU_EXCEPTION) && (errorCode != TS_ERROR_END_OF_SEQUENCE) &&
            (errorCode != TS_ERROR_AICPU_DATADUMP_RSP_ERR) && (errorCode != TS_ERROR_AICPU_MODEL_RSP_ERR) &&
            (errorCode != TS_ERROR_AICPU_OVERFLOW) && (errorCode != TS_ERROR_AICPU_INFO_LOAD_RSP_ERR)) {
            RT_LOG_CALL_MSG(moduleType, "An error occurred in the kernel task, and error message was received from AI CPU,"
                " AI CPU error code=0x%x, [%s].", errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
        } else if (CheckErrPrint(errorCode)) {
            if ((type == TS_TASK_TYPE_KERNEL_AICPU) && (errorCode == TS_ERROR_AICPU_TIMEOUT)) {
                RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "An error occurred in the AI CPU task, retCode=%#x, [%s].",
                    errorCode, GetTsErrCodeMap(errorCode, &rtErrCode));
            } else {
                RT_LOG_CALL_MSG(moduleType, "An error occurred in the kernel task, retCode=%#x, [%s].",
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

std::string GetTaskKernelName(const TaskInfo* task)
{
    if (task == nullptr) {
        RT_LOG(RT_LOG_DEBUG, "Task is null");
        return "none";
    }
    RT_LOG(RT_LOG_DEBUG, "Task type is [%d]", task->type);
    std::string kernelNameStr = "";
    if (task->type == TS_TASK_TYPE_KERNEL_AICORE || task->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        const AicTaskInfo* aicTaskInfo = &(task->u.aicTaskInfo);
        if ((aicTaskInfo != nullptr) && (aicTaskInfo->kernel != nullptr)) {
            kernelNameStr = aicTaskInfo->kernel->Name_();
        }
    }

    if (task->type == TS_TASK_TYPE_KERNEL_AICPU) {
        const AicpuTaskInfo* aicpuTaskInfo = &(task->u.aicpuTaskInfo);
        if ((aicpuTaskInfo != nullptr) && (aicpuTaskInfo->kernel != nullptr)) {
            kernelNameStr = aicpuTaskInfo->kernel->GetCpuOpType();
        }
    }

    if (task->type == TS_TASK_TYPE_FUSION_KERNEL) {
        const FusionTaskInfo* fusionKernelTask = &(task->u.fusionKernelTask);
        if ((fusionKernelTask != nullptr) && (fusionKernelTask->aicPart.kernel != nullptr)) {
            kernelNameStr = fusionKernelTask->aicPart.kernel->Name_();
        }
    }
    return kernelNameStr.empty() ? "none" : kernelNameStr.c_str();
}

#endif
}  // namespace runtime
}  // namespace cce
