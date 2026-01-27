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
#include "xpu_device.hpp"
#include "stream_xpu.hpp"
#include "arg_manage_xpu.hpp"
#include "error_message_manage.hpp"
#include "arg_manage_david.hpp"

namespace cce {
namespace runtime {

XpuArgManage::~XpuArgManage()
{
    RT_LOG(RT_LOG_INFO, "xpuArgsManager destruction.");
}


bool XpuArgManage::CreateArgRes()
{
    XpuDevice * const dev = dynamic_cast<XpuDevice *>(stream_->Device_());
    void *devAddr = nullptr;
    void* hostAddr = nullptr;
    argPoolSize_ = XPU_ARG_POOL_COPY_SIZE * (dev->GetXpuStreamDepth());

    const rtError_t ret = MallocArgMem(devAddr, hostAddr);
    if (ret != RT_ERROR_NONE) {
        return false;
    }
    devArgResBaseAddr_ = devAddr;
    RT_LOG(RT_LOG_DEBUG, "Malloc args stm pool mem success, size=%u, device_id=%u.", argPoolSize_, dev->Id_());
    return true;
}
void XpuArgManage::FreeArgMem()
{
    free(devArgResBaseAddr_);
}

void XpuArgManage::ReleaseArgRes()
{
    if (devArgResBaseAddr_ != nullptr) {
        FreeArgMem();
        RT_LOG(RT_LOG_DEBUG, "Release args stm pool mem, stream_id=%d.", stream_->Id_());
        devArgResBaseAddr_ = nullptr;
    }
}

rtError_t XpuArgManage::MallocArgMem(void *&devAddr, void *&hostAddr)
{
    UNUSED(hostAddr);
    devAddr = malloc(argPoolSize_);
    if (devAddr == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Alloc stream args pool host mem failed size=%u.", argPoolSize_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    return RT_ERROR_NONE;
}

rtError_t XpuArgManage::AllocCopyPtr(const uint32_t size, const bool useArgPool, DavidArgLoaderResult * const result)
{
    rtError_t error = RT_ERROR_NONE;
    if (useArgPool && AllocStmPool(size, result)) {
        return error;
    }
    ArgLoaderResult res = {nullptr, nullptr, nullptr};
    res.kerArgs = nullptr;
    res.handle = nullptr;
    error = static_cast<XpuDevice *>(stream_->Device_())->XpuArgLoader_()->AllocCopyPtr(size, &res);
    if (error == RT_ERROR_NONE) {
        result->kerArgs = res.kerArgs;
        result->handle = res.handle;
    }
    return error;
}

bool XpuArgManage::AllocStmPool(const uint32_t size, DavidArgLoaderResult * const result)
{
    uint32_t startPos = UINT32_MAX;
    uint32_t endPos = UINT32_MAX;
    if (!AllocStmArgPos(size, startPos, endPos)) {
        return false;
    }
    result->kerArgs = static_cast<void *>(RtPtrToPtr<uint8_t *, void *>(devArgResBaseAddr_) + startPos);
    result->stmArgPos = endPos;
    return true;
}

rtError_t XpuArgManage::H2DArgCopy(const DavidArgLoaderResult * const result, void * const args, const uint32_t size)
{
    rtError_t error = RT_ERROR_NONE;
    XpuHandle *handle = static_cast<XpuHandle *>(result->handle);
    if (handle != nullptr) {
        error = handle->argsAlloc->H2DMemCopy(result->kerArgs, args, size);
        ERROR_RETURN_MSG_INNER(error, "H2DMemCopy failed, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_HOST), static_cast<uint32_t>(error));
    } else {
        const errno_t ret = memcpy_s(result->kerArgs, static_cast<uint64_t>(size), args, static_cast<uint64_t>(size));
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "host memcpy failed, kind=%d, ret=%d.", RT_MEMCPY_HOST_TO_HOST, ret);
    }
    return error;
}

void XpuArgManage::RecycleDevLoader(void * const handle)
{
    (void)static_cast<XpuDevice *>(stream_->Device_())->XpuArgLoader_()->Release(handle);
}

}
}