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
#include "stars_arg_manager.hpp"
#include "kernel.hpp"
#include "kernel_utils.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {

rtError_t UbArgManage::MallocArgMem(void *&devAddr, void *&hostAddr)
{
    Device * const dev = stream_->Device_();
    const uint32_t devId = dev->Id_();

    rtError_t ret = dev->Driver_()->DevMemAlloc(&devAddr, static_cast<uint64_t>(argPoolSize_), RT_MEMORY_HBM, devId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "Alloc stream args pool dev mem failed, retCode=%#x, size=%u, device_id=%u.",
            ret, argPoolSize_, devId);
        return ret;
    }
    ret = dev->Driver_()->HostMemAlloc(&hostAddr, static_cast<uint64_t>(argPoolSize_), devId);
    if (ret != RT_ERROR_NONE) {
        (void)dev->Driver_()->DevMemFree(devAddr, devId);
        RT_LOG(RT_LOG_WARNING, "Alloc stream args pool host mem failed, retCode=%#x, size=%u, device_id=%u.",
            ret, argPoolSize_, devId);
        return ret;
    }

    ret = GetMemTsegInfo(dev, devAddr, hostAddr, static_cast<uint64_t>(argPoolSize_), &(memTsegInfo_.devTsegInfo),
        &(memTsegInfo_.hostTsegInfo));
    ERROR_RETURN(ret, "get tseg info failed, retCode=%#x, size=%u, device_id=%u.", ret, argPoolSize_, devId);
    return RT_ERROR_NONE;
}

void UbArgManage::FreeArgMem()
{
    Device * const dev = stream_->Device_();
    (void)dev->Driver_()->DevMemFree(devArgResBaseAddr_, dev->Id_());
    (void)dev->Driver_()->HostMemFree(hostArgResBaseAddr_);
    (void)dev->Driver_()->PutTsegInfo(dev->Id_(), &(memTsegInfo_.devTsegInfo));
    (void)dev->Driver_()->PutTsegInfo(dev->Id_(), &(memTsegInfo_.hostTsegInfo));
}

bool UbArgManage::AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result)
{
    uint32_t startPos = UINT32_MAX;
    uint32_t endPos = UINT32_MAX;
    if (!AllocStmArgPos(size, startPos, endPos)) {
        return false;
    }
    result->kerArgs = static_cast<void *>(RtPtrToPtr<uint8_t *, void *>(devArgResBaseAddr_) + startPos);
    result->hostAddr = static_cast<void *>(RtPtrToPtr<uint8_t *, void *>(hostArgResBaseAddr_) + startPos);
    result->devTsegInfo = static_cast<void *>(&(memTsegInfo_.devTsegInfo));
    result->hostTsegInfo = static_cast<void *>(&(memTsegInfo_.hostTsegInfo));
    result->stmArgPos = endPos;
    return true;
}

rtError_t UbArgManage::AllocCopyPtr(
    const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result)
{
    UNUSED(policy);
    if (useArgPool && AllocStmPool(size, result)) {
        return RT_ERROR_NONE;
    }
    return stream_->Device_()->UbArgLoaderPtr()->AllocCopyPtr(size, result);
}

rtError_t UbArgManage::ParseArgsCpyWqe(const StarsArgLoaderResult* const result, const uint32_t size) const
{
    Device * const dev = stream_->Device_();
    const uint32_t devId = dev->Id_();
    // aclgraph和自动切分下沉流走驱动halMemcpy做同步拷贝
    if (stream_->IsSoftwareSqEnable() || stream_->IsAutoSplitSq()) {
        return dev->Driver_()->MemCopySync(
            result->kerArgs, size, result->hostAddr, size,
            RT_MEMCPY_HOST_TO_DEVICE);
    }
    struct halSqTaskArgsInfo sqArgsInfo = {};
    sqArgsInfo.type = DRV_NORMAL_TYPE;
    sqArgsInfo.tsId = dev->DevGetTsId();
    sqArgsInfo.sqId = stream_->GetSqId();
    sqArgsInfo.size = size;
    sqArgsInfo.src = RtPtrToValue<const void *>(result->hostAddr);
    sqArgsInfo.dst = RtPtrToValue<const void *>(result->kerArgs);
    sqArgsInfo.dstTsegInfo = (struct halTsegInfo *)result->devTsegInfo;
    sqArgsInfo.srcTsegInfo = (struct halTsegInfo *)result->hostTsegInfo;
    return dev->Driver_()->SqArgsCopyWithUb(devId, &sqArgsInfo);
}

rtError_t UbArgManage::H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size)
{
    // h2h copy
    uint32_t offset = 0U;
    uint32_t remaining = 0U;
    uint32_t curSize = 0U;
    void *dest = result->hostAddr;
    void *src = args;

    while (offset < size) {
        remaining = size - offset;
        curSize = (remaining < SECUREC_MEM_MAX_LEN) ? remaining : SECUREC_MEM_MAX_LEN;
        const errno_t ret = memcpy_s(RtValueToPtr<void *>(RtPtrToValue<void *>(dest) + offset), static_cast<size_t>(curSize),
            RtValueToPtr<void *>(RtPtrToValue<void *>(src) + offset), static_cast<size_t>(curSize));
        if (ret != EOK) {
            const std::string retStr = std::to_string(ret);
            std::stringstream ss;
            ss << std::hex << "dest=0x" << RtPtrToValue(dest) + offset << ", src=0x" << RtPtrToValue(src) + offset
               << std::dec << ", destMax=" << curSize << ", count=" << curSize << ".";
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, __func__, "memcpy_s",
                retStr.c_str(), strerror(ret), ss.str().c_str());
            return RT_ERROR_DRV_ERR;
        }
        offset += curSize;
    }
    // construct args copy WQE
    return ParseArgsCpyWqe(result, size);
}

void UbArgManage::RecycleDevLoader(void * const handle)
{
    (void)stream_->Device_()->UbArgLoaderPtr()->Release(handle);
}

rtError_t UbArgManage::LoadArgsFromArray(const bool useArgPool,
    const Kernel *kernel, void **argsArray, StarsArgLoaderResult *result)
{
    uint64_t paramTotalSize = kernel->GetParamTotalSize();
    uint32_t argsSize = static_cast<uint32_t>(paramTotalSize);
    if (argsSize == 0U) {
        result->kerArgs = nullptr;
        result->hostAddr = nullptr;
        return RT_ERROR_NONE;
    }

    rtError_t error = AllocCopyPtr(argsSize, useArgPool, LoadPolicy::LP_GENERIC, result);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Alloc args copy ptr failed, size=%u, device_id=%u, stream_id=%d.",
            argsSize, stream_->Device_()->Id_(), stream_->Id_());
        return error;
    }

    error = CopyKernelParamsToBuffer(kernel, argsArray, result->hostAddr);
    if (error != RT_ERROR_NONE) {
        FreeFail(result);
        return error;
    }

    return ParseArgsCpyWqe(result, argsSize);
}

rtError_t UbArgManage::LoadSimtArgsFromArray(const bool useArgPool,
    const Kernel *kernel, SimtArgsArray *simtArgsArray, StarsArgLoaderResult *result)
{
    uint64_t paramTotalSize = kernel->GetParamTotalSize();
    uint32_t totalArgsSize = static_cast<uint32_t>(paramTotalSize) + SIMT_IMPLICIT_PARAM_SIZE;
    rtError_t error = AllocCopyPtr(totalArgsSize, useArgPool, LoadPolicy::LP_GENERIC, result);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Alloc args copy ptr failed, size=%u, device_id=%u, stream_id=%d.",
            totalArgsSize, stream_->Device_()->Id_(), stream_->Id_());
        return error;
    }

    void *argsBuffer = result->hostAddr;
    uint32_t implicitData[SIMT_IMPLICIT_PARAM_COUNT] = {
        simtArgsArray->blockDim.z, simtArgsArray->blockDim.y, simtArgsArray->blockDim.x,
        simtArgsArray->gridDim.z,  simtArgsArray->gridDim.y,  simtArgsArray->gridDim.x};
    errno_t ret = memcpy_s(argsBuffer, totalArgsSize, implicitData, SIMT_IMPLICIT_PARAM_SIZE);
    if (ret != EOK) {
        FreeFail(result);
        RT_LOG(RT_LOG_ERROR, "memcpy implicit data failed, size=%u, ret=%d.", SIMT_IMPLICIT_PARAM_SIZE, ret);
        return RT_ERROR_SEC_HANDLE;
    }

    void *kernelArgsStart = static_cast<char *>(argsBuffer) + SIMT_IMPLICIT_PARAM_SIZE;
    error = CopyKernelParamsToBuffer(kernel, simtArgsArray->argsArrayInfo, kernelArgsStart);
    if (error != RT_ERROR_NONE) {
        FreeFail(result);
        return error;
    }

    return ParseArgsCpyWqe(result, totalArgsSize);
}

rtError_t UbArgManage::LoadSimtHostArgs(const bool useArgPool,
    SimtArgsHost *simtArgsHost, StarsArgLoaderResult *result)
{
    uint32_t totalArgsSize = simtArgsHost->argsSize + SIMT_IMPLICIT_PARAM_SIZE;
    rtError_t error = AllocCopyPtr(totalArgsSize, useArgPool, LoadPolicy::LP_GENERIC, result);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Alloc args copy ptr failed, size=%u, device_id=%u, stream_id=%d.",
            totalArgsSize, stream_->Device_()->Id_(), stream_->Id_());
        return error;
    }

    void *argsBuffer = result->hostAddr;
    uint32_t implicitData[SIMT_IMPLICIT_PARAM_COUNT] = {
        simtArgsHost->blockDim.z, simtArgsHost->blockDim.y, simtArgsHost->blockDim.x,
        simtArgsHost->gridDim.z,  simtArgsHost->gridDim.y,  simtArgsHost->gridDim.x};
    errno_t ret = memcpy_s(argsBuffer, totalArgsSize, implicitData, SIMT_IMPLICIT_PARAM_SIZE);
    if (ret != EOK) {
        FreeFail(result);
        RT_LOG(RT_LOG_ERROR, "memcpy implicit data failed, size=%u, ret=%d.", SIMT_IMPLICIT_PARAM_SIZE, ret);
        return RT_ERROR_SEC_HANDLE;
    }

    void *hostArgsStart = static_cast<char *>(argsBuffer) + SIMT_IMPLICIT_PARAM_SIZE;
    ret = memcpy_s(hostArgsStart, simtArgsHost->argsSize,
                   simtArgsHost->hostArgs, simtArgsHost->argsSize);
    if (ret != EOK) {
        FreeFail(result);
        RT_LOG(RT_LOG_ERROR, "memcpy host args failed, size=%u, ret=%d.", simtArgsHost->argsSize, ret);
        return RT_ERROR_SEC_HANDLE;
    }

    if (simtArgsHost->placeHolderNum > 0) {
        const void *adjustedKerArgs = static_cast<const char *>(result->kerArgs) + SIMT_IMPLICIT_PARAM_SIZE;
        UpdateAddrField(adjustedKerArgs, hostArgsStart,
            static_cast<uint16_t>(simtArgsHost->placeHolderNum),
            RtPtrToPtr<rtHostInputInfo_t *>(simtArgsHost->placeHolderArray));
    }

    return ParseArgsCpyWqe(result, totalArgsSize);
}

}
}