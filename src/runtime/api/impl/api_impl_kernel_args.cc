/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstring>
#include <iomanip>
#include <new>
#include <sstream>
#include <string>

#include "api_impl.hpp"
#include "args_handle_allocator.hpp"
#include "context.hpp"
#include "device.hpp"
#include "error_message_manage.hpp"
#include "program.hpp"
#include "runtime.hpp"
#include "runtime_handle_guard.h"

namespace {
void ResetKernelArgsParamHandles(RtArgsHandle* argsHandle, uint32_t paramCount)
{
    if (argsHandle == nullptr) {
        return;
    }
    for (uint32_t i = 0U; i < paramCount; ++i) {
        ResetEmbeddedInnerHandle<ParaDetail>(&(argsHandle->para[i]));
    }
}

void ReinitKernelArgsEmbeddedHandle(RtArgsHandle* argsHandle, uint32_t paramCount)
{
    if (argsHandle == nullptr) {
        return;
    }
    ResetKernelArgsParamHandles(argsHandle, paramCount);
    ResetEmbeddedInnerHandle<RtArgsHandle>(argsHandle);
    InitEmbeddedInnerHandle<RtArgsHandle>(argsHandle);
}
} // namespace

namespace cce {
namespace runtime {

uint16_t ApiImpl::GetToBeCalSystemParaNum(const Kernel* const kernel) const
{
    // 获取系统参数大小，如果有overflow需要特殊处理
    const uint16_t sysParaNum = kernel->GetSystemParaNum();
    // 如果没有系统参数直接返回0
    if (sysParaNum == 0U) {
        return 0U;
    }
    // 需要根据Kernel句柄获取到系统参数大小，如果有overflow需要特殊处理，不算在开头系统参数内
    // 如果有系统参数，需要计算是否有overflow
    uint16_t toBeCalSysParaNum = kernel->IsSupportOverFlow() ? (sysParaNum - 1U) : sysParaNum;
    Runtime* rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    toBeCalSysParaNum =
        (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_INTER_CORE_SYNC_ADDR)) &&
                (kernel->IsNeedSetFftsAddrInArg() && (toBeCalSysParaNum > 1U)) ?
            toBeCalSysParaNum - 1U :
            toBeCalSysParaNum; // 1代表系统参数个数

    RT_LOG(
        RT_LOG_DEBUG, "sysParaNum=%u,toBeCalSysParaNum=%u,isSupportOverFlow=%u,IsNeedSetFftsAddrInArg=%u,chipType=%u.",
        sysParaNum, toBeCalSysParaNum, static_cast<uint8_t>(kernel->IsSupportOverFlow()),
        static_cast<uint8_t>(kernel->IsNeedSetFftsAddrInArg()), chipType);

    return toBeCalSysParaNum;
}

rtError_t ApiImpl::ProcessOverFlowArgs(RtArgsHandle* argsHandle)
{
    Kernel* kernel = RtPtrToPtr<Kernel*>(argsHandle->funcHandle);
    // cpu kernel无需处理直接返回
    COND_RETURN_WITH_NOLOG(kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU, RT_ERROR_NONE);
    // 需要判断是否做overflow隐藏参数处理
    COND_RETURN_WITH_NOLOG(argsHandle->isProcessedOverflow, RT_ERROR_NONE);
    COND_RETURN_WITH_NOLOG(kernel->GetSystemParaNum() == 0U, RT_ERROR_NONE);
    COND_RETURN_WITH_NOLOG(!kernel->IsSupportOverFlow(), RT_ERROR_NONE);

    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
                                 CPU_KERNEL_ARGS_ALIGN_SIZE :
                                 NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t padding =
        ((argsHandle->argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsHandle->argsSize % alignSize));
    const size_t realParaOffset = argsHandle->argsSize + padding;
    const size_t needOccupyOffset = realParaOffset + sizeof(uint64_t); // overflowAddr占8哥字节

    // 内存占用不能超过最大内存偏移
    COND_RETURN_ERROR_MSG_INNER(
        (needOccupyOffset > argsHandle->bufferSize), RT_ERROR_INVALID_VALUE,
        "process overflow args failed, para size overflow, needOccupyOffset=%zu,total=%zu", needOccupyOffset,
        argsHandle->bufferSize);

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint64_t overflowAddr = RtPtrToValue(curCtx->CtxGetOverflowAddr());
    uint64_t* overflowParaAddr = RtPtrToPtr<uint64_t*>(RtPtrToPtr<uint8_t*>(argsHandle->buffer) + realParaOffset);
    *overflowParaAddr = overflowAddr;
    argsHandle->argsSize = needOccupyOffset;
    argsHandle->isProcessedOverflow = true;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsGetHandleMemSize(Kernel* const funcHandle, size_t* memSize)
{
    const uint32_t maxUserParamNum = (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
                                         MAX_PARAM_CNT :
                                         static_cast<uint32_t>(funcHandle->GetUserParaNum());

    // 需要依赖kernel句柄信息获取用户参数和系统参数
    *memSize = sizeof(RtArgsHandle) + (maxUserParamNum * sizeof(ParaDetail));

    RT_LOG(
        RT_LOG_DEBUG, "memSize=%zu,maxUserParamNum=%u,RtArgsHandle=%zu,rtParaDetail=%zu", *memSize, maxUserParamNum,
        sizeof(RtArgsHandle), sizeof(ParaDetail));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsFinalize(RtArgsHandle* argsHandle)
{
    // 需要判断是否做overflow隐藏参数处理, 如果在GetPlaceHolderBuffer处理过，不再处理
    rtError_t error = ProcessOverFlowArgs(argsHandle);
    ERROR_RETURN(error, "process over flow args failed,retCode=%#x.", error);

    Kernel* kernel = RtPtrToPtr<Kernel*>(argsHandle->funcHandle);
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    Runtime* rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    // ffts plus inter core sync只支持CHIP_910_B_93和非CPU算子
    if ((regType == RT_KERNEL_REG_TYPE_CPU) ||
        (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_INTER_CORE_SYNC_ADDR)) ||
        !kernel->IsNeedSetFftsAddrInArg()) {
        argsHandle->isFinalized = 1U;
        argsHandle->isParamUpdating = 0U;
        return RT_ERROR_NONE;
    }

    // 暂时不考虑print, 获取ffts inter core addr 并写入
    uint64_t interCoreAddr = 0ULL;
    uint32_t len = 0U;
    error = GetC2cCtrlAddr(&interCoreAddr, &len);
    ERROR_RETURN(error, "get inter core addr failed, retCode=%#x", static_cast<uint32_t>(error));
    uint64_t* interCoreSyncAddr = RtPtrToPtr<uint64_t*>(argsHandle->buffer);
    *interCoreSyncAddr = interCoreAddr;
    argsHandle->isFinalized = 1U;
    argsHandle->isParamUpdating = 0U;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsInitByUserMem(
    Kernel* const funcHandle, RtArgsHandle* argsHandle, void* userHostMem, size_t actualArgsSize)
{
    const uint32_t maxUserParamNum = (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
                                         MAX_PARAM_CNT :
                                         static_cast<uint32_t>(funcHandle->GetUserParaNum());
    new (argsHandle) RtArgsHandle{};
    for (uint32_t i = 0U; i < maxUserParamNum; ++i) {
        new (&(argsHandle->para[i])) ParaDetail{};
    }
    ReinitKernelArgsEmbeddedHandle(argsHandle, maxUserParamNum);
    argsHandle->buffer = userHostMem;
    argsHandle->bufferSize = actualArgsSize;
    argsHandle->realUserParamNum = 0U;
    argsHandle->maxUserParamNum = static_cast<uint8_t>(maxUserParamNum);
    argsHandle->placeHolderNum = 0U;
    argsHandle->funcHandle = funcHandle;
    argsHandle->argsSize = 0U;
    argsHandle->isProcessedOverflow = false;
    argsHandle->isGotPhBuff = false;
    argsHandle->isFinalized = 0U;
    argsHandle->isParamUpdating = 0U;
    (void)memset_s(&argsHandle->cpuKernelSysArgsInfo, sizeof(CpuKernelSysArgsInfo), 0, sizeof(CpuKernelSysArgsInfo));

    if (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) { // 非cpu kernel
        // 需要根据Kernel句柄获取到系统参数大小，如果有overflow需要特殊处理，不算在开头系统参数内
        const uint16_t toBeCalSysParaNum = GetToBeCalSystemParaNum(funcHandle);
        argsHandle->sysParamSize = toBeCalSysParaNum * sizeof(uint64_t);
        argsHandle->argsSize += argsHandle->sysParamSize;
    } else { // Cpu kernel没有系统参数
        argsHandle->maxUserParamNum = MAX_PARAM_CNT;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsGetMemSize(Kernel* const funcHandle, size_t userArgsSize, size_t* actualArgsSize)
{
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    if (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) {
        const uint16_t userParaNum = funcHandle->GetUserParaNum();
        // 因有padding要预留，按照最大8字节
        *actualArgsSize = userArgsSize + (MAX_SYSTEM_PARAM_CNT * SINGLE_NON_CPU_SYS_PARAM_SIZE) +
                          (userParaNum * NON_CPU_KERNEL_ARGS_ALIGN_SIZE);

        RT_LOG(
            RT_LOG_DEBUG, "actualArgsSize=%zu,userArgsSize=%zu,userParaNum=%u", *actualArgsSize, userArgsSize,
            userParaNum);
        return RT_ERROR_NONE;
    }

    *actualArgsSize = userArgsSize; // CPU Kernel：soName和KernelName不需要排入Args，runtime已优化
    RT_LOG(RT_LOG_DEBUG, "actualArgsSize=%zu,userArgsSize=%zu", *actualArgsSize, userArgsSize);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsInit(Kernel* const funcHandle, RtArgsHandle** argsHandle)
{
    static thread_local ArgsHandleAllocator threadArgsHandle;
    NULL_PTR_RETURN_MSG(threadArgsHandle.localArgsHandle_, RT_ERROR_MEMORY_ALLOCATION);

    RtArgsHandle* localArgsHandle = threadArgsHandle.localArgsHandle_;
    ReinitKernelArgsEmbeddedHandle(localArgsHandle, MAX_PARAM_CNT);
    localArgsHandle->argsSize = 0U;
    localArgsHandle->realUserParamNum = 0U;
    localArgsHandle->placeHolderNum = 0U;
    localArgsHandle->sysParamSize = 0U;

    localArgsHandle->funcHandle = funcHandle;
    localArgsHandle->isProcessedOverflow = false;
    localArgsHandle->isGotPhBuff = false;
    localArgsHandle->bufferSize = MAX_ARGS_BUFF_SIZE;
    localArgsHandle->maxUserParamNum = MAX_PARAM_CNT;
    localArgsHandle->isFinalized = 0U;
    localArgsHandle->isParamUpdating = 0U;
    (void)memset_s(
        &localArgsHandle->cpuKernelSysArgsInfo, sizeof(CpuKernelSysArgsInfo), 0, sizeof(CpuKernelSysArgsInfo));

    if (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) {
        RT_LOG(RT_LOG_DEBUG, "non cpu kernel branch");
        const uint16_t toBeCalSysParaNum = GetToBeCalSystemParaNum(funcHandle);
        localArgsHandle->sysParamSize = toBeCalSysParaNum * sizeof(uint64_t);
        localArgsHandle->argsSize += localArgsHandle->sysParamSize;
    }

    *argsHandle = localArgsHandle;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsAppendPlaceHolder(RtArgsHandle* argsHandle, ParaDetail** paraHandle)
{
    RT_LOG(RT_LOG_DEBUG, "enter append place holder");
    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_AND_MSG_OUTER(
        argsHandle->isGotPhBuff, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Adding placeholder parameters to the kernel parameter handle",
        "Appending placeholder or common parameter after getting placeholder buffer is not supported");

    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_AND_MSG_OUTER(
        argsHandle->isFinalized == 1U, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Adding placeholder parameters to the kernel parameter handle",
        "Appending and getting placeholder buffer after finalization is not supported");

    // 用户参数数量不能超过最大参数数量
    COND_RETURN_ERROR_MSG_INNER(
        ((argsHandle->realUserParamNum + 1U) > argsHandle->maxUserParamNum), RT_ERROR_INVALID_VALUE,
        "para num exceed max num,current real user para num is %u,max user para num is %u",
        argsHandle->realUserParamNum, argsHandle->maxUserParamNum);

    const uint32_t idx = argsHandle->realUserParamNum;
    argsHandle->para[idx].type = 1U; // 0 is common param, 1 is place holder param

    const Kernel* const kernel = RtPtrToPtr<Kernel*>(argsHandle->funcHandle);
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
                                 CPU_KERNEL_ARGS_ALIGN_SIZE :
                                 NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t padding =
        ((argsHandle->argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsHandle->argsSize % alignSize));
    const size_t realParaOffset = argsHandle->argsSize + padding;
    constexpr size_t phParamSize = sizeof(uint64_t); // placeholder内部放的是指针为8字节
    const size_t needOccupyOffset = realParaOffset + phParamSize;
    COND_RETURN_ERROR_MSG_INNER(
        (needOccupyOffset > argsHandle->bufferSize), RT_ERROR_INVALID_VALUE,
        "args append failed,para size overflow,needOccupyOffset=%zu,total=%zu", needOccupyOffset,
        argsHandle->bufferSize);

    argsHandle->para[idx].paraOffset = realParaOffset;
    argsHandle->para[idx].paraSize = static_cast<uint32_t>(sizeof(uint64_t));
    argsHandle->para[idx].dataOffset = 0U;

    *paraHandle = ((argsHandle->para) + idx);
    InitEmbeddedInnerHandle<ParaDetail>(*paraHandle);
    argsHandle->argsSize = needOccupyOffset;
    argsHandle->realUserParamNum++;
    argsHandle->placeHolderNum++;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsGetPlaceHolderBuffer(
    RtArgsHandle* argsHandle, ParaDetail* paraHandle, size_t dataSize, void** bufferAddr)
{
    RT_LOG(RT_LOG_DEBUG, "get placeholder start, dataSize=%zu", dataSize);
    // 对非place holder的参数如果获取Buffer做拦截
    COND_RETURN_ERROR_MSG_INNER(
        paraHandle->type == 0U, RT_ERROR_INVALID_VALUE, "param type=0 does not support getting the placeholder buffer");

    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_AND_MSG_OUTER(
        argsHandle->isFinalized == 1U, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Obtaining the memory address pointed to by the paramHandle placeholder",
        "Appending and getting placeholder buffer after finalization is not supported");

    // 需要判断是否做overflow隐藏参数处理
    const rtError_t error = ProcessOverFlowArgs(argsHandle);
    ERROR_RETURN(error, "process over flow args failed,retCode=%#x.", error);

    const Kernel* const kernel = RtPtrToPtr<Kernel*>(argsHandle->funcHandle);
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
                                 CPU_KERNEL_ARGS_ALIGN_SIZE :
                                 NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t argsSize = argsHandle->argsSize;
    const size_t padding = ((argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsSize % alignSize));
    const size_t realParaOffset = argsSize + padding;

    // 内存占用不能超过最大内存偏移
    const size_t needOccupyOffset = realParaOffset + dataSize;
    COND_RETURN_ERROR_MSG_INNER(
        (needOccupyOffset > argsHandle->bufferSize), RT_ERROR_INVALID_VALUE,
        "get placeholder buffer failed, size overflow, needOccupyOffset=%zu, total=%zu", needOccupyOffset,
        argsHandle->bufferSize);
    argsHandle->isGotPhBuff = true;
    paraHandle->dataOffset = realParaOffset;
    *bufferAddr = RtPtrToPtr<void*>(RtPtrToPtr<uint8_t*>(argsHandle->buffer) + paraHandle->dataOffset);
    argsHandle->argsSize = needOccupyOffset;

    RT_LOG(
        RT_LOG_DEBUG, "get placeholder end, dataSize=%zu, dataOffset=%zu, needOccupyOffset=%zu", dataSize,
        realParaOffset, needOccupyOffset);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsAppend(RtArgsHandle* argsHandle, void* para, size_t paraSize, ParaDetail** paraHandle)
{
    RT_LOG(RT_LOG_DEBUG, "args append start, paraSize=%zu", paraSize);
    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_AND_MSG_OUTER(
        argsHandle->isFinalized == 1U, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Adding parameters to the kernel parameter handle",
        "Appending and getting placeholder buffer after finalization is not supported");

    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_AND_MSG_OUTER(
        argsHandle->isGotPhBuff, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Adding parameters to the kernel parameter handle",
        "Appending placeholder or common parameter after getting placeholder buffer is not supported");

    // 用户参数数量不能超过最大参数数量
    COND_RETURN_ERROR_MSG_INNER(
        ((argsHandle->realUserParamNum + 1U) > argsHandle->maxUserParamNum), RT_ERROR_INVALID_VALUE,
        "para num exceed max num,current real user para num is %u,max user para num is %u",
        argsHandle->realUserParamNum, argsHandle->maxUserParamNum);
    const Kernel* const kernel = RtPtrToPtr<Kernel*>(argsHandle->funcHandle);
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
                                 CPU_KERNEL_ARGS_ALIGN_SIZE :
                                 NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t padding =
        ((argsHandle->argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsHandle->argsSize % alignSize));
    const size_t realParaOffset = argsHandle->argsSize + padding;
    const size_t needOccupyOffset = realParaOffset + paraSize;

    // 内存占用不能超过最大内存偏移
    COND_RETURN_ERROR_MSG_INNER(
        (needOccupyOffset > argsHandle->bufferSize), RT_ERROR_INVALID_VALUE,
        "args append failed, para size overflow, needOccupyOffset=%zu,total=%zu", needOccupyOffset,
        argsHandle->bufferSize);

    const uint8_t index = argsHandle->realUserParamNum;
    *paraHandle = &(argsHandle->para[index]);
    argsHandle->para[index].type = 0U;                   // 0 is Common param, 1 is place holder param
    argsHandle->para[index].paraOffset = realParaOffset; // 参数在整个内存中的偏移
    argsHandle->para[index].paraSize = paraSize;
    argsHandle->para[index].dataOffset = 0U;
    const uintptr_t offset = RtPtrToValue(argsHandle->buffer) + static_cast<uint64_t>(realParaOffset);
    const errno_t ret = memcpy_s(RtPtrToPtr<void*>(offset), paraSize, para, paraSize);
    if (ret != EOK) {
        std::stringstream ss;
        ss << std::hex << "dest=0x" << offset << ", para=0x" << RtPtrToValue(para) << std::dec
           << ", destMax=" << paraSize << ", paraSize=" << paraSize << ".";
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1020, "Adding placeholder parameters to the kernel parameter handle", "memcpy_s",
            std::to_string(ret).c_str(), strerror(ret), ss.str().c_str());
        return RT_ERROR_INVALID_VALUE;
    }
    InitEmbeddedInnerHandle<ParaDetail>(*paraHandle);
    argsHandle->argsSize = needOccupyOffset; // 本地append参数后，内存偏移的变化
    argsHandle->realUserParamNum++;

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
