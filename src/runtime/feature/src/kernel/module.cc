/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device.hpp"
#include "kernel.hpp"
#include "program.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "memory_pool.hpp"
#include "module.hpp"

namespace cce {
namespace runtime {
Module::Module(Device * const dev)
    : NoCopy(),
      device_(dev),
      baseAddr_(nullptr),
      baseFMAddr_(nullptr),
      baseAddrAlign_(nullptr),
      kernelNamesBaseAddr_(nullptr),
      soNamesBaseAddr_(nullptr),
      progMemType_(0U),
      baseAddrSize_(0U),
      kernelNamesSize_(0U),
      soNamesSize_(0U)
{
}
TIMESTAMP_EXTERN(ModuleDevMemFree);
Module::~Module() noexcept
{
    TIMESTAMP_BEGIN(ModuleDevMemFree);
    if (baseAddr_ != nullptr) {
        if (device_->GetKernelMemoryPool() != nullptr && device_->GetKernelMemoryPool()->Contains(baseAddr_)) {
            const uint32_t alignSize = (baseAddrSize_ + POOL_ALIGN_SIZE) & (~POOL_ALIGN_SIZE);
            device_->GetKernelMemoryPool()->Release(baseAddr_, static_cast<size_t>(alignSize));
        } else {
            (void)device_->Driver_()->DevMemFree(baseAddr_, device_->Id_());
        }
    }
    TIMESTAMP_END(ModuleDevMemFree);

    if (kernelNamesBaseAddr_ != nullptr) {
        (void)device_->Driver_()->DevMemFree(kernelNamesBaseAddr_, device_->Id_());
    }

    if (soNamesBaseAddr_ != nullptr) {
        (void)device_->Driver_()->DevMemFree(soNamesBaseAddr_, device_->Id_());
    }

    soNamesBaseAddr_ = nullptr;
    kernelNamesBaseAddr_ = nullptr;
    baseAddrAlign_ = nullptr;
    baseFMAddr_ = nullptr;
    baseAddr_ = nullptr;
    device_ = nullptr;
    baseAddrSize_ = 0U;
    programId_ = UINT32_MAX;
}

TIMESTAMP_EXTERN(ModuleMemAlloc);
TIMESTAMP_EXTERN(ModuleMemCpy);
TIMESTAMP_EXTERN(ModuleLoadProgram);

rtError_t Module::Load(Program * const prog)
{
    void *devMem = nullptr;
    void *data = nullptr;
    bool readonly = true;
    uint32_t size = 0U;
    uint32_t alignSize = 0U;
    rtError_t error = RT_ERROR_NONE;
    Driver * const curDrv = device_->Driver_();
    const rtChipType_t chipType = device_->GetChipType();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);

    const uint32_t machineType = prog->Machine();
    if (machineType == Program::MACH_AI_CPU) {
        size = prog->GetBinarySize();
        data = prog->GetBinary();

        const auto &progKernelName = prog->GetKernelNamesBuffer();
        if (!progKernelName.empty()) {
            RT_LOG(RT_LOG_DEBUG, "load on host the kernel name, size=%zu(bytes).", progKernelName.size());
            error = curDrv->DevMemAlloc(&kernelNamesBaseAddr_, progKernelName.size() + 1U,
                RT_MEMORY_HBM, device_->Id_());
            ERROR_GOTO(error, FAIL_FREE, "Malloc kernel names buffer failed, type=%d(RT_MEMORY_HBM), "
                "size=%zu(bytes), retCode=%#x.", RT_MEMORY_HBM, progKernelName.size(), static_cast<uint32_t>(error));

            error = curDrv->MemCopySync(kernelNamesBaseAddr_, progKernelName.size(), progKernelName.c_str(),
                progKernelName.size(), RT_MEMCPY_HOST_TO_DEVICE);
            ERROR_GOTO_MSG_INNER(error, FAIL_FREE, "Memcpy failed, retCode=%#x.", static_cast<uint32_t>(error));

            error = curDrv->DevMemAlloc(&soNamesBaseAddr_, prog->GetSoName().size(), RT_MEMORY_HBM, device_->Id_());
            ERROR_GOTO(error, FAIL_FREE, "Malloc so names buffer failed, size=%zu(bytes), "
                "type=%d(RT_MEMORY_HBM), retCode=%#x.", prog->GetSoName().size(),
                static_cast<int32_t>(RT_MEMORY_HBM), static_cast<uint32_t>(error));

            error = curDrv->MemCopySync(soNamesBaseAddr_, prog->GetSoName().size(),
                prog->GetSoName().c_str(), prog->GetSoName().size(), RT_MEMCPY_HOST_TO_DEVICE);
            ERROR_GOTO_MSG_INNER(error, FAIL_FREE, "Memcpy so names failed, size=%zu(bytes), "
                "type=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x.", prog->GetSoName().size(),
                static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
            kernelNamesSize_ = progKernelName.size() + 1U;
            soNamesSize_  = prog->GetSoName().size();
        }
    } else {
        size = prog->LoadSize();
        data = prog->Data();
        readonly = prog->IsReadOnly();
    }

    error = prog->RefreshSymbolAddr();
    ERROR_GOTO(error, FAIL_FREE, "refresh symbol address failed!");

    COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER(size == 0U, FAIL_FREE, error, RT_ERROR_PROGRAM_SIZE,
        "Module load failed, prog size should be larger than 0, but current prog size is 0.");
    NULL_PTR_GOTO_MSG_INNER(data, FAIL_FREE, error, RT_ERROR_PROGRAM_DATA);

    {
        TIMESTAMP_BEGIN(ModuleMemAlloc);
        const uint32_t devSize = device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SIMT) ?
            (size + SIMT_PREFETCH_INCREASE_SIZE) : size;
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MEM_POOL_ALIGN)) {
            alignSize = (devSize + POOL_ALIGN_SIZE) & (~POOL_ALIGN_SIZE);
            devMem = device_->GetKernelMemoryPool()->Allocate(alignSize, readonly);
        }

        if (devMem == nullptr) {
            error = curDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(devSize + INSTR_ALIGN_SIZE),
                RT_MEMORY_HBM, device_->Id_(), DEFAULT_MODULEID, true, readonly);
            ERROR_GOTO(error, FAIL_FREE, "Malloc device program failed, retCode=%#x.", static_cast<uint32_t>(error));
        }

        TIMESTAMP_END(ModuleMemAlloc);
        NULL_PTR_GOTO_MSG_INNER(devMem, FAIL_FREE, error, RT_ERROR_MEMORY_ALLOCATION);

        baseAddr_ = devMem;
        if (prog->GetBinBaseAddr(device_->Id_()) == nullptr) {
            prog->SetBinBaseAddr(devMem, device_->Id_());
        }
        // cce instr addr should align to 4K for ARM instr ADRP
        if ((RtPtrToPtr<uintptr_t>(devMem) & 0xFFFULL) != 0ULL) {
            // 2 ^ 12 is 4K align
            const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t>(devMem)) >> 12U) + 1UL) << 12U;
            devMem = RtPtrToPtr<void *>(devMemAlign);
        }
        baseAddrAlign_ = devMem;
        baseAddrSize_ = devSize;
        if (prog->GetBinAlignBaseAddr(device_->Id_()) == nullptr) {
            prog->SetBinAlignBaseAddr(devMem, device_->Id_());
        }

        TIMESTAMP_BEGIN(ModuleMemCpy);
        error = curDrv->MemCopySync(baseAddrAlign_, static_cast<uint64_t>(size), data,
            static_cast<uint64_t>(size), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_GOTO_MSG_INNER(error, FAIL_FREE, "Memcpy failed, size=%u(bytes),"
            "type=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x",
            size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
        TIMESTAMP_END(ModuleMemCpy);
    }
    RT_LOG(RT_LOG_DEBUG, "Load on device addr=%p, size=%u(bytes), program id=%u.", baseAddrAlign_, size, prog->Id_());
    programId_ = prog->Id_();
    return RT_ERROR_NONE;

FAIL_FREE:
    if (devMem != nullptr) {
        if (device_->GetKernelMemoryPool() != nullptr && device_->GetKernelMemoryPool()->Contains(baseAddr_)) {
            device_->GetKernelMemoryPool()->Release(baseAddr_, alignSize);
        } else {
            (void)device_->Driver_()->DevMemFree(baseAddr_, device_->Id_());
        }
    }
    baseAddr_ = nullptr;

    if (kernelNamesBaseAddr_ != nullptr) {
        (void)curDrv->DevMemFree(kernelNamesBaseAddr_, device_->Id_());
        kernelNamesBaseAddr_ = nullptr;
    }

    if (soNamesBaseAddr_ != nullptr) {
        (void)curDrv->DevMemFree(soNamesBaseAddr_, device_->Id_());
        soNamesBaseAddr_ = nullptr;
    }
    return error;
}

Program *Module::GetProgram() const
{
    if (programId_ < Runtime::maxProgramNum_) {
        RefObject<Program *> *const programItem = Runtime::Instance()->GetProgramAllocator()->GetDataToItem(programId_);
        if (programItem != nullptr) {
            Program *programInst = programItem->GetVal(false);
            return programInst;
        }
    }
    return nullptr;
}

rtError_t Module::CalModuleHash(std::size_t &hash) const
{
    void *hostMem = nullptr;
    COND_RETURN_ERROR_MSG_INNER((baseAddrAlign_ == nullptr) || (baseAddrSize_ == 0U), RT_ERROR_INVALID_VALUE,
        "Cal module hash failed, address size=%u(bytes)", baseAddrSize_);
    Driver * const deviceDrv = device_->Driver_();
    rtError_t error = deviceDrv->HostMemAlloc(&hostMem, static_cast<uint64_t>(baseAddrSize_) + 1UL, device_->Id_());

    ERROR_RETURN(error, "Malloc host memory for calculate module hash failed, retCode=%#x.",
                 static_cast<uint32_t>(error));
    error = deviceDrv->MemCopySync(hostMem, static_cast<uint64_t>(baseAddrSize_) + 1UL, baseAddrAlign_,
        static_cast<uint64_t>(baseAddrSize_), RT_MEMCPY_DEVICE_TO_HOST);

    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, (void)deviceDrv->HostMemFree(hostMem);,
        "Memcpy failed, size=%u(bytes), type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x.",
        baseAddrSize_, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
    // calculate hash
    const std::string hashStr(RtPtrToPtr<const char_t *>(hostMem), static_cast<uint64_t>(baseAddrSize_));
    hash = std::hash<std::string>{}(hashStr);
    (void)deviceDrv->HostMemFree(hostMem);
    return RT_ERROR_NONE;
}

rtError_t Module::GetFunction(const Kernel * const kernelIn, uint64_t * const function) const
{
    *function = RtPtrToPtr<uintptr_t, void *>(baseAddrAlign_) + kernelIn->Offset_();
    RT_LOG(RT_LOG_DEBUG, "device kernel func address is %#." PRIx64, *function);
    return RT_ERROR_NONE;
}

rtError_t Module::GetFunction(const Kernel * const kernelIn, uint64_t * const function1, uint64_t * const function2) const
{
    *function1 = RtPtrToPtr<uintptr_t, void *>(baseAddrAlign_) + kernelIn->Offset_();
    *function2 = 0UL;
    if (kernelIn->Offset2_() != 0UL) {
        *function2 = RtPtrToPtr<uintptr_t, void *>(baseAddrAlign_) + kernelIn->Offset2_();
    }

    RT_LOG(RT_LOG_DEBUG, "device kernel baseAddr is %#" PRIx64", func1 address is %#"
           PRIx64", func2 address is %#" PRIx64". ",
           RtPtrToValue(baseAddrAlign_), *function1, *function2);
    return RT_ERROR_NONE;
}

rtError_t Module::GetPrefetchCnt(const Kernel * const kernelIn, uint32_t &icachePrefetchCnt) const
{
    // 0KB, aicpu task not need prefetch
    constexpr uint32_t aicpuIcachePrefetchSizeMax = 0U;
    // 32KB, K=1024. aicore can prefetch 32KB at most.
    constexpr uint32_t aicoreIcachePrefetchSizeMax = 32768U;
    // 16KB, K=1024. aivector can prefetch 16KB at most.
    constexpr uint32_t aivectorIcachePrefetchSizeMax = 16384U;
    constexpr uint32_t prefetchUnits = 2048U;

    Program* program = GetProgram();
    NULL_PTR_RETURN(program, RT_ERROR_PROGRAM_NULL);
    uint32_t machine = program->Machine();
    uint32_t restSize = 0U;
    uint32_t prefetchMaxSize = 0U;

    restSize = baseAddrSize_ - kernelIn->Offset_();

    if (machine == Program::MACH_AI_MIX_KERNEL) {
        machine = kernelIn->KernelType_();
    }

    switch (machine) {
        case Program::MACH_AI_CPU :
            prefetchMaxSize = aicpuIcachePrefetchSizeMax;
            break;
        case Program::MACH_AI_CORE:
            prefetchMaxSize = aicoreIcachePrefetchSizeMax;
            break;
        case Program::MACH_AI_CVMIX:
            prefetchMaxSize = aicoreIcachePrefetchSizeMax;
            break;
        case Program::MACH_AI_VECTOR:
            prefetchMaxSize = aivectorIcachePrefetchSizeMax;
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "get prefetch cnt failed, machine=%u.", machine);
            return RT_ERROR_INVALID_VALUE;
    }

    // Icache_prefetch_cnt:aic aiv prefetch instruction length, the unit is 2KB, K=1024
    const uint32_t restSizeCnt = restSize / prefetchUnits;
    const uint32_t prefetchMaxSizeCnt = prefetchMaxSize / prefetchUnits;
    icachePrefetchCnt = (restSizeCnt > prefetchMaxSizeCnt) ? prefetchMaxSizeCnt : restSizeCnt;

    RT_LOG(RT_LOG_DEBUG, "get prefetch cnt success, kernel=%s, prefetchCnt=%u, restSize=%u.",
        kernelIn->KernelInfoExt_(), icachePrefetchCnt, restSize);

    return RT_ERROR_NONE;
}

rtError_t Module::GetPrefetchCnt(const Kernel * const kernelIn, uint32_t &icachePrefetchCnt1,
                                 uint32_t &icachePrefetchCnt2) const
{
    // 0KB, aicpu task not need prefetch
    constexpr uint32_t aicpuIcachePrefetchSizeMax = 0U;
    // 32KB, K=1024. aicore can prefetch 32KB at most.
    constexpr uint32_t aicoreIcachePrefetchSizeMax = 32768U;
    // 16KB, K=1024. aivector can prefetch 16KB at most.
    constexpr uint32_t aivectorIcachePrefetchSizeMax = 16384U;
    constexpr uint32_t prefetchUnits = 2048U;
    icachePrefetchCnt2 = 0U;

    Program* program = GetProgram();
    NULL_PTR_RETURN(program, RT_ERROR_PROGRAM_NULL);
    uint32_t machine = program->Machine();
    uint32_t restSize1 = 0U;
    uint32_t restSize2 = 0U;
    uint32_t prefetchMaxSize1 = 0U;
    uint32_t prefetchMaxSize2 = 0U;

    restSize1 = baseAddrSize_ - kernelIn->Offset_();
    if (machine == Program::MACH_AI_MIX_KERNEL) {
        machine = kernelIn->KernelType_();
    }
    const uint8_t mixtype = kernelIn->GetMixType();
    if (mixtype == static_cast<uint8_t>(MIX_AIC)) {
        prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
    } else if (mixtype == static_cast<uint8_t>(MIX_AIV)) {
        prefetchMaxSize1 = aivectorIcachePrefetchSizeMax;
    } else if (mixtype == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC)) {
        restSize2 = static_cast<uint32_t>(static_cast<uint64_t>(baseAddrSize_) - kernelIn->Offset2_());
        prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
        prefetchMaxSize2 = aivectorIcachePrefetchSizeMax;
    } else {
        switch (machine) {
            case Program::MACH_AI_CPU :
                prefetchMaxSize1 = aicpuIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_CORE:
                prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_CVMIX:
                prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_VECTOR:
                prefetchMaxSize1 = aivectorIcachePrefetchSizeMax;
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "get prefetch cnt failed, machine=%u.", machine);
                return RT_ERROR_INVALID_VALUE;
        }
    }
    // Icache_prefetch_cnt:aic aiv prefetch instruction length, the unit is 2KB, K=1024
    const uint32_t restSizeCnt1 = restSize1 / prefetchUnits;
    const uint32_t prefetchMaxSizeCnt1 = prefetchMaxSize1 / prefetchUnits;
    icachePrefetchCnt1 = (restSizeCnt1 > prefetchMaxSizeCnt1) ? prefetchMaxSizeCnt1 : restSizeCnt1;
    if (mixtype == MIX_AIC_AIV_MAIN_AIC) {
        const uint32_t restSizeCnt2 = restSize2 / prefetchUnits;
        const uint32_t prefetchMaxSizeCnt2 = prefetchMaxSize2 / prefetchUnits;
        icachePrefetchCnt2 = (restSizeCnt2 > prefetchMaxSizeCnt2) ? prefetchMaxSizeCnt2 : restSizeCnt2;
    }

    RT_LOG(RT_LOG_DEBUG, "get prefetch cnt success, kernel=%s, prefetchCnt1=%u, prefetchCnt2=%u, mixtype=%hu, "
        "restSize1=%u, restSize2=%u.",
        kernelIn->KernelInfoExt_(), icachePrefetchCnt1, icachePrefetchCnt2, mixtype, restSize1, restSize2);

    return RT_ERROR_NONE;
}

rtError_t Module::GetTaskRation(const Kernel * const kernelIn,  uint32_t &taskRation) const
{
    taskRation = kernelIn->GetTaskRation();
    return RT_ERROR_NONE;
}
}
}
