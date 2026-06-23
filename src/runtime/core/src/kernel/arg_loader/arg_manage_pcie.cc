/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "task_res.hpp"
#include "error_message_manage.hpp"
#include "stars_arg_manager.hpp"
#include "kernel.hpp"
#include "kernel_utils.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {

rtError_t PcieArgManage::MallocArgMem(void *&devAddr, void *&hostAddr)
{
    UNUSED(hostAddr);
    Device * const dev = stream_->Device_();
    devAddr = stream_->taskResMang_->MallocPcieBarBuffer(argPoolSize_, dev, false);
    if (devAddr == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Alloc stream args pool pcie bar mem failed, size=%u, device_id=%u.",
            argPoolSize_, dev->Id_());
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    return RT_ERROR_NONE;
}

void PcieArgManage::FreeArgMem()
{
    Device * const dev = stream_->Device_();
    const uint32_t devId = dev->Id_();
    (void)dev->Driver_()->PcieHostUnRegister(devArgResBaseAddr_, devId);
    (void)dev->Driver_()->DevMemFree(devArgResBaseAddr_, devId);
}

bool PcieArgManage::AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result)
{
    uint32_t startPos = UINT32_MAX;
    uint32_t endPos = UINT32_MAX;
    if (!AllocStmArgPos(size, startPos, endPos)) {
        return false;
    }
    result->kerArgs = static_cast<void *>((RtPtrToPtr<uint8_t *, void *>(devArgResBaseAddr_) + startPos));
    result->stmArgPos = endPos;
    return true;
}

rtError_t PcieArgManage::AllocCopyPtr(
    const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result)
{
    // starsv2 FAST_LAUNCH pool 路径保持不变
    if (policy == LoadPolicy::LP_GENERIC && useArgPool && AllocStmPool(size, result)) {
        result->allocatedEntrySize = 0U;
        return RT_ERROR_NONE;
    }

    ArgLoaderResult res = {};
    rtError_t error = RT_ERROR_NONE;
    error = stream_->Device_()->ArgLoader_()->AllocCopyPtr(size, policy, &res);
    if (error == RT_ERROR_NONE) {
        result->kerArgs = res.kerArgs;
        result->handle = res.handle;
        result->allocatedEntrySize = res.allocatedEntrySize;
    }
    return error;
}

rtError_t PcieArgManage::AllocNoCopyPtr(StarsArgLoaderResult* const result)
{
    ArgLoaderResult res = {};
    rtError_t error = RT_ERROR_NONE;
    error = stream_->Device_()->ArgLoader_()->AllocNoCopyPtr(result->kerArgs, &res);
    if (error == RT_ERROR_NONE) {
        result->kerArgs = res.kerArgs;
        result->handle = res.handle;
        result->allocatedEntrySize = 0U;
    }
    return error;
}

rtError_t PcieArgManage::H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size)
{
    rtError_t error = RT_ERROR_NONE;
    Handle *handle = static_cast<Handle *>(result->handle);
    if (handle != nullptr) {
        // - stars:
        // 对齐现有行为需要，当allocator默认copy策略是COPY_POLICY_DEFAULT的，当不能走PCIe BAR时就可能走
        // COPY_POLICY_ASYNC_PCIE_DMA路径，此时H2DMemCopy的dst就必须是CpyHandle*，即需要使用handle->kerArgs。
        // - starsv2:
        // 由于starv2开启了RT_FEATURE_MEM_H2D_MANAGER_POLICY_SYNC_FORCE，所以不会使用COPY_POLICY_ASYNC_PCIE_DMA会被
        // 换成COPY_POLICY_SYNC，所以总是使用result->handle即可。
        void* dst = result->kerArgs;
        if (handle->argsAlloc->GetPolicy() == COPY_POLICY_ASYNC_PCIE_DMA) {
            dst = handle->kerArgs;
        }
        error = handle->argsAlloc->H2DMemCopy(dst, args, static_cast<uint64_t>(size));
        ERROR_RETURN(error, "H2DMemCopy failed, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), error);
    } else {
        const errno_t ret = memcpy_s(result->kerArgs, static_cast<uint64_t>(size), args, static_cast<uint64_t>(size));
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "Failed to call memcpy_s to copy args, dest=%p, dest_max=%lu, src=%p, count=%lu, retCode=%d.",
            result->kerArgs, static_cast<uint64_t>(size), args, static_cast<uint64_t>(size), ret);
    }
    return error;
}

void PcieArgManage::RecycleDevLoader(void * const handle)
{
    (void)stream_->Device_()->ArgLoader_()->Release(handle);
}

rtError_t PcieArgManage::LoadArgsFromArray(const bool useArgPool,
    const Kernel *kernel, void **argsArray, StarsArgLoaderResult *result)
{
    uint64_t paramTotalSize = kernel->GetParamTotalSize();
    uint32_t argsSize = static_cast<uint32_t>(paramTotalSize);
    if (argsSize == 0U) {
        result->kerArgs = nullptr;
        return RT_ERROR_NONE;
    }

    rtError_t error = AllocCopyPtr(argsSize, useArgPool, LoadPolicy::LP_GENERIC, result);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Alloc args copy ptr failed, size=%u, device_id=%u, stream_id=%d.",
            argsSize, stream_->Device_()->Id_(), stream_->Id_());
        return error;
    }

    void *argsBuffer = ThreadLocalContainer::GetOrCreateArgsBuffer(static_cast<uint64_t>(argsSize));
    if (argsBuffer == nullptr) {
        FreeFail(result);
        RT_LOG(RT_LOG_ERROR, "GetOrCreateArgsBuffer failed, size=%u.", argsSize);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    error = CopyKernelParamsToBuffer(kernel, argsArray, argsBuffer);
    if (error != RT_ERROR_NONE) {
        FreeFail(result);
        return error;
    }

    return H2DArgCopy(result, argsBuffer, argsSize);
}

rtError_t PcieArgManage::PrepareSimtArgsBuffer(const uint32_t totalArgsSize, const bool useArgPool,
    const rtDim3& gridDim, const rtDim3& blockDim, StarsArgLoaderResult* result, void** argsBuffer)
{
    rtError_t error = AllocCopyPtr(totalArgsSize, useArgPool, LoadPolicy::LP_GENERIC, result);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    *argsBuffer = ThreadLocalContainer::GetOrCreateArgsBuffer(static_cast<uint64_t>(totalArgsSize));
    if (*argsBuffer == nullptr) {
        FreeFail(result);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    uint32_t implicitData[SIMT_IMPLICIT_PARAM_COUNT] = {blockDim.z, blockDim.y, blockDim.x,
                                                        gridDim.z,  gridDim.y,  gridDim.x};
    errno_t ret = memcpy_s(*argsBuffer, totalArgsSize, implicitData, SIMT_IMPLICIT_PARAM_SIZE);
    if (ret != EOK) {
        FreeFail(result);
        return RT_ERROR_SEC_HANDLE;
    }

    return RT_ERROR_NONE;
}

rtError_t PcieArgManage::LoadSimtArgsFromArray(const bool useArgPool,
    const Kernel *kernel, SimtArgsArray *simtArgsArray, StarsArgLoaderResult *result)
{
    uint64_t paramTotalSize = kernel->GetParamTotalSize();
    uint32_t totalArgsSize = static_cast<uint32_t>(paramTotalSize) + SIMT_IMPLICIT_PARAM_SIZE;

    void *argsBuffer = nullptr;
    rtError_t error = PrepareSimtArgsBuffer(totalArgsSize, useArgPool,
        simtArgsArray->gridDim, simtArgsArray->blockDim, result, &argsBuffer);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    void *kernelArgsStart = static_cast<char *>(argsBuffer) + SIMT_IMPLICIT_PARAM_SIZE;
    error = CopyKernelParamsToBuffer(kernel, simtArgsArray->argsArrayInfo, kernelArgsStart);
    if (error != RT_ERROR_NONE) {
        FreeFail(result);
        return error;
    }

    return H2DArgCopy(result, argsBuffer, totalArgsSize);
}

rtError_t PcieArgManage::LoadSimtHostArgs(const bool useArgPool,
    SimtArgsHost *simtArgsHost, StarsArgLoaderResult *result)
{
    uint32_t totalArgsSize = simtArgsHost->argsSize + SIMT_IMPLICIT_PARAM_SIZE;
    void *argsBuffer = nullptr;
    rtError_t error = PrepareSimtArgsBuffer(totalArgsSize, useArgPool,
        simtArgsHost->gridDim, simtArgsHost->blockDim, result, &argsBuffer);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    void *hostArgsStart = static_cast<char *>(argsBuffer) + SIMT_IMPLICIT_PARAM_SIZE;
    errno_t ret = memcpy_s(hostArgsStart, simtArgsHost->argsSize,
                           simtArgsHost->hostArgs, simtArgsHost->argsSize);
    if (ret != EOK) {
        FreeFail(result);
        return RT_ERROR_SEC_HANDLE;
    }

    if (simtArgsHost->placeHolderNum > 0) {
        const void *adjustedKerArgs = static_cast<const char *>(result->kerArgs) + SIMT_IMPLICIT_PARAM_SIZE;
        UpdateAddrField(adjustedKerArgs, hostArgsStart, static_cast<uint16_t>(simtArgsHost->placeHolderNum),
            RtPtrToPtr<rtHostInputInfo_t *>(simtArgsHost->placeHolderArray));
    }

    return H2DArgCopy(result, argsBuffer, totalArgsSize);
}

}
}