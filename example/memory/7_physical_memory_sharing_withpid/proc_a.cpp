/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample demonstrates inter-process memory sharing
 * using two independent processes (i.e., Process A and Process B) on a single device.
 */

#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"
#include <cstdio>

extern void WriteDo(uint32_t blockDim, void* stream, int* devPtrB, int value);

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    // Get memory allocation granularity
    const size_t dataSize = 1024 * sizeof(float);
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;
    prop.memAttr = ACL_HBM_MEM_NORMAL;

    size_t granularity = 0UL;
    CHECK_ERROR(aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity));
    INFO_LOG("Process A: get memory allocation granularity successfully, granularity = %d", static_cast<int32_t>(granularity));

    // Start allocating physical memory based on memory allocation granularity
    size_t alignedSize =  ((dataSize + granularity - 1U) / granularity) * granularity;
    INFO_LOG("Process A: aligned size = %zu", alignedSize);

    aclrtDrvMemHandle handle = nullptr;
    CHECK_ERROR(aclrtMallocPhysical(&handle, alignedSize, &prop, 0));
    INFO_LOG("Process A: allocate physical memory successfully");

    // Reserve virtual memory
    void *virPtr;
    CHECK_ERROR(aclrtReserveMemAddress(&virPtr, granularity, 0, nullptr, 0));
    INFO_LOG("Process A: reserve virtual memory successfully");

    // Map virtual memory to physical memory
    CHECK_ERROR(aclrtMapMem(virPtr, granularity, 0, handle, 0));
    INFO_LOG("Process A: map virtual memory address to physical memory handle");

    // Write the value to the virtual memory
    constexpr uint32_t blockDim = 1;
    int writeValue = 123;
    WriteDo(blockDim, stream, (int *)virPtr, writeValue);
    INFO_LOG("Write data %d to the virtual address %p", writeValue, virPtr);

    // Export a shareable handle
    uint64_t shareableHandle = 0ULL;
    CHECK_ERROR(aclrtMemExportToShareableHandle(handle, ACL_MEM_HANDLE_TYPE_NONE, 0, &shareableHandle));
    INFO_LOG("Process A: export a shareable handle successfully, shareable handle = %d", static_cast<int32_t>(shareableHandle));

    // Read Process B's pid from the file
    int32_t pid = 0;
    memory::ReadFile("file/pid.bin", "file/pid.bin.done", &pid);
    INFO_LOG("Process A: get Process B's pid successfully, Process B's pid = %d", pid);

    // Add Process B to the whitelist
    CHECK_ERROR(aclrtMemSetPidToShareableHandle(shareableHandle, &pid, 1));
    INFO_LOG("Process A: add Process B to the whitelist successfully");

    // Transfer the shareable handle to Process B by writing it to the file
    memory::WriteFile("file/handle.bin", "file/handle.bin.done", &shareableHandle, sizeof(shareableHandle));

    // Read the completion flag from the file
    int32_t flag = 0;
    memory::ReadFile("file/flag.bin", "file/flag.bin.done", &flag);
    INFO_LOG("Process A: receive the completion signal from Process B, completion signal = %d", flag);

    // Unmap virtual memory from physical memory
    CHECK_ERROR(aclrtUnmapMem(virPtr));
    INFO_LOG("Process A: unmap virtual memory from physical memory");

    // Release the virtual and physical memory
    CHECK_ERROR(aclrtReleaseMemAddress(virPtr));
    CHECK_ERROR(aclrtFreePhysical(handle));
    INFO_LOG("Process A: release the virtual and physical memory successfully");

    aclrtDestroyStreamForce(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}