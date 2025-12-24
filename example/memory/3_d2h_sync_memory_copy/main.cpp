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
 * This sample demonstrates synchronous device-to-host memory copy from devPtrB to hostPtrA.
 */

#include "acl/acl.h"
#include "utils.h"
#include <cstdio>

extern void WriteDo(uint32_t blockDim, void* stream, int* devPtr, int value);

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    // Allocate memory on the host and device
    uint64_t size = 1 * 1024 * 1024;
    int *hostPtrA;
    int *devPtrB;
    CHECK_ERROR(aclrtMallocHost((void**)&hostPtrA, size));
    INFO_LOG("Allocate memory on the host memory %p successfully", hostPtrA);

    CHECK_ERROR(aclrtMalloc((void**)&devPtrB, size, ACL_MEM_MALLOC_HUGE_FIRST));
    INFO_LOG("Allocate memory on the device memory %p successfully", devPtrB);

    // Write the data to the virtual address devPtrB
    constexpr uint32_t blockDim = 1;
    int writeValue = 123;
    WriteDo(blockDim, stream, devPtrB, writeValue);
    INFO_LOG("Write the data %d to the virtual memory %p", writeValue, devPtrB);

    // Copy memory from address devPtrB to address hostPtrA synchronously
    CHECK_ERROR(aclrtMemcpy(hostPtrA, size, devPtrB, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("Copy memory from memory %p to memory %p", devPtrB, hostPtrA);

    // Read the value at address hostPtrA
    int readValue = *hostPtrA;
    INFO_LOG("Destination data: %d", readValue);

    // Release resource of the host and device
    aclrtDestroyStreamForce(stream);
    aclrtFreeHost(hostPtrA);
    aclrtFree(devPtrB);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}