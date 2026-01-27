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
#include "arg_manage_david.hpp"

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

bool PcieArgManage::AllocStmPool(const uint32_t size, DavidArgLoaderResult * const result)
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

rtError_t PcieArgManage::AllocCopyPtr(const uint32_t size, const bool useArgPool, DavidArgLoaderResult * const result)
{
    rtError_t error = RT_ERROR_NONE;
    if (useArgPool && AllocStmPool(size, result)) {
        return error;
    }

    ArgLoaderResult res = {nullptr, nullptr, nullptr};
    res.kerArgs = nullptr;
    res.handle = nullptr;
    error = stream_->Device_()->ArgLoader_()->AllocCopyPtr(size, &res);
    if (error == RT_ERROR_NONE) {
        result->kerArgs = res.kerArgs;
        result->handle = res.handle;
    }
    return error;
}

rtError_t PcieArgManage::H2DArgCopy(const DavidArgLoaderResult * const result, void * const args, const uint32_t size)
{
    rtError_t error = RT_ERROR_NONE;
    Handle *handle = static_cast<Handle *>(result->handle);
    if (handle != nullptr) {
        error = handle->argsAlloc->H2DMemCopy(result->kerArgs, args, static_cast<uint64_t>(size));
        ERROR_RETURN_MSG_INNER(error, "H2DMemCopy failed, kind=%d, retCode=%#x.",
            static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    } else {
        const errno_t ret = memcpy_s(result->kerArgs, static_cast<uint64_t>(size), args, static_cast<uint64_t>(size));
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "Pcie bar memcpy failed, kind=%d, ret=%d.", RT_MEMCPY_HOST_TO_DEVICE, ret);
    }
    return error;
}

void PcieArgManage::RecycleDevLoader(void * const handle)
{
    (void)stream_->Device_()->ArgLoader_()->Release(handle);
}

}
}