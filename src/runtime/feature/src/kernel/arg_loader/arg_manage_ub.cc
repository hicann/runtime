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
#include "arg_manage_david.hpp"

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

bool UbArgManage::AllocStmPool(const uint32_t size, DavidArgLoaderResult * const result)
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

rtError_t UbArgManage::AllocCopyPtr(const uint32_t size, const bool useArgPool,
                                    DavidArgLoaderResult * const result)
{
    if (useArgPool && AllocStmPool(size, result)) {
        return RT_ERROR_NONE;
    }
    return stream_->Device_()->UbArgLoaderPtr()->AllocCopyPtr(size, result);
}

rtError_t UbArgManage::ParseArgsCpyWqe(const DavidArgLoaderResult * const result, const uint32_t size) const
{
    Device * const dev = stream_->Device_();
    const uint32_t devId = dev->Id_();
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

rtError_t UbArgManage::H2DArgCopy(const DavidArgLoaderResult * const result, void * const args, const uint32_t size)
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
            RT_LOG(RT_LOG_ERROR, "Args host memcpy failed, size=%u, offset=%u, kind=%d, ret=%#x.", size, offset, RT_MEMCPY_HOST_TO_HOST, ret);
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

}
}