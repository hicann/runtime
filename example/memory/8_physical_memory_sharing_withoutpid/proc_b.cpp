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

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    // Get the shareable handle from the file
    uint64_t shareableHandle = 0ULL;
    aclrtDrvMemHandle handle = nullptr;
    memory::ReadFile("file/handle.bin", "file/handle.bin.done", &shareableHandle);
    INFO_LOG("Process B: get a shareable handle successfully, shareable handle = %d", static_cast<int32_t>(shareableHandle));

    CHECK_ERROR(aclrtMemImportFromShareableHandle(shareableHandle, deviceId, &handle));

    // Get memory allocation granularity
    const size_t data_size = 1024 * sizeof(float);
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;
    prop.memAttr = ACL_HBM_MEM_NORMAL;

    size_t granularity = 0UL;
    CHECK_ERROR(aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity));
    INFO_LOG("Process B: get memory allocation granularity successfully, granularity = %d", static_cast<int32_t>(granularity));

    // Reserve virtual memory
    void *virPtr = nullptr;
    CHECK_ERROR(aclrtReserveMemAddress(&virPtr, granularity, 0, nullptr, 0));
    INFO_LOG("Process B: reserve virtual memory successfully");

    // Map virtual memory to physical memory
    CHECK_ERROR(aclrtMapMem(virPtr, granularity, 0, handle, 0));
    INFO_LOG("Process B: map virtual memory address to physical memory handle");

    // Copy memory from device to host
    int *hostPtrA;
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&hostPtrA), granularity));
    CHECK_ERROR(aclrtMemcpy(hostPtrA, granularity, virPtr, granularity, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("Process B: copy memory from device address %p to host address %p", virPtr, hostPtrA);

    // Read the value at address hostPtrA
    int readValue = *hostPtrA;
    INFO_LOG("Destination data: %d", readValue);

    // Unmap virtual memory from physical memory
    CHECK_ERROR(aclrtUnmapMem(virPtr));
    INFO_LOG("Process B: unmap virtual memory from physical memory");

    // Write the completion flag to the file
    int32_t flag = 1;
    memory::WriteFile("file/flag.bin", "file/flag.bin.done", &flag, sizeof(flag));
    INFO_LOG("Process B: complete the physical memory sharing");

    // Release the virtual and physical memory
    CHECK_ERROR(aclrtReleaseMemAddress(virPtr));
    CHECK_ERROR(aclrtFreePhysical(handle));
    INFO_LOG("Process B: release the virtual and physical memory successfully");

    aclrtDestroyStreamForce(stream);
    aclrtFreeHost(hostPtrA);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}