/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_memory.h"
#include "runtime/mem.h"
#include "log/hdc_log.h"
#include "adump_pub.h"

namespace Adx {
namespace {
constexpr uint16_t ADUMP_MODULE_NAME_U16 = static_cast<uint16_t>(IDEDD);
} // namespace

int32_t DumpMemory::CheckDeviceMemory(int32_t deviceId, const void *addr)
{
    uint64_t *deviceAddr[1] = {static_cast<uint64_t *>(const_cast<void *>(addr))};
    rtMemInfo_t memInfo{};
    memInfo.addrInfo.addr = static_cast<uint64_t **>(deviceAddr);
    memInfo.addrInfo.cnt = 1;
    memInfo.addrInfo.memType = RT_MEM_MASK_DEV_TYPE | RT_MEM_MASK_RSVD_TYPE;
    memInfo.addrInfo.flag = true;
    rtError_t ret = rtMemGetInfoByType(deviceId, RT_MEM_INFO_TYPE_ADDR_CHECK, &memInfo);
    if ((ret != RT_ERROR_NONE) || (memInfo.addrInfo.flag == false)) {
        IDE_LOGE("Address[%p] is the valid address of device: %d, ret: %d, check flag: %u",
            addr, deviceId, ret, memInfo.addrInfo.flag);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

void *DumpMemory::CopyHostToHost(const void *hostMem, uint64_t memSize)
{
    if (hostMem == nullptr || memSize == 0UL) {
        IDE_LOGW("Input host mem is nullptr or size equal 0, ptr: %p, size: %lu", hostMem, memSize);
        return nullptr;
    }

    void *dstMem = nullptr;
    rtError_t rtRet = rtMallocHost(&dstMem, memSize, ADUMP_MODULE_NAME_U16);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtMallocHost failed, ret: 0x%X", rtRet);
        return nullptr;
    }

    rtRet = rtMemcpy(dstMem, memSize, hostMem, memSize, RT_MEMCPY_HOST_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtMemcpy failed, ret: 0x%X", rtRet);
        FreeHost(dstMem);
        return nullptr;
    }
    return dstMem;
}

void *DumpMemory::CopyHostToDevice(const void *hostMem, uint64_t memSize)
{
    if (hostMem == nullptr || memSize == 0) {
        IDE_LOGW("Input host mem is nullptr or size equal 0, ptr: %p, size: %lu", hostMem, memSize);
        return nullptr;
    }

    void *devMem = nullptr;
    rtError_t rtRet = rtMalloc(&devMem, memSize, RT_MEMORY_HBM, ADUMP_MODULE_NAME_U16);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtMalloc failed, ret: 0x%X", rtRet);
        return nullptr;
    }

    rtRet = rtMemcpy(devMem, memSize, hostMem, memSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtMemcpy failed, ret: 0x%X", rtRet);
        FreeHost(devMem);
        return nullptr;
    }
    return devMem;
}

void *DumpMemory::CopyDeviceToHost(const void *devMem, uint64_t memSize)
{
    if (devMem == nullptr || memSize == 0) {
        IDE_LOGW("Input device mem is nullptr or size equal 0, ptr: %p, size: %lu", devMem, memSize);
        return nullptr;
    }

    void *hostMem = nullptr;
    rtError_t rtRet = rtMallocHost(&hostMem, memSize, ADUMP_MODULE_NAME_U16);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMallocHost failed, size: %lu, ret: 0x%X", memSize, rtRet);
        return nullptr;
    }

    rtRet = rtMemcpy(hostMem, memSize, devMem, memSize, RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpy failed, ret: 0x%X", rtRet);
        FreeHost(hostMem);
        return nullptr;
    }
    return hostMem;
}

void *DumpMemory::CopyDeviceToHostEx(const void *devMem, uint64_t memSize)
{
    if (devMem == nullptr || memSize == 0UL) {
        IDE_LOGW("Input device mem is nullptr or size equal 0, ptr: %p, size: %lu", devMem, memSize);
        return nullptr;
    }

    void *hostMem = nullptr;
    rtError_t rtRet = rtMallocHost(&hostMem, memSize, ADUMP_MODULE_NAME_U16);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("rtMallocHost failed, size: %lu, ret: 0x%X", memSize, rtRet);
        return nullptr;
    }

    rtRet = rtMemcpyEx(hostMem, memSize, devMem, memSize, RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpyEx failed, ret: 0x%X", rtRet);
        FreeHost(hostMem);
        return nullptr;
    }
    return hostMem;
}

void DumpMemory::FreeHost(void *&hostMem)
{
    (void)rtFreeHost(hostMem);
    hostMem = nullptr;
}

void DumpMemory::FreeDevice(void *&devMem)
{
    (void)rtFree(devMem);
    devMem = nullptr;
}
} // namespace Adx