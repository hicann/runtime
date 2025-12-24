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
 * This sample demonstrates asynchronous host-to-device memory copy from hostPtrA to devPtrB.
 */

#include "acl/acl.h"
#include "utils.h"
#include <cstdio>

extern int ReadDo(uint32_t blockDim, void* stream, int* devPtr);

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

    // Write the data to the virtual address hostPtrA
    int writeValue = 123;
    *hostPtrA = writeValue;
    INFO_LOG("Write the data %d to the virtual memory %p", writeValue, hostPtrA);
    INFO_LOG("Source data: %d", writeValue);

    // Copy memory from address hostPtrA to address devPtrB asynchronously
    CHECK_ERROR(aclrtMemcpyAsync(devPtrB, size, hostPtrA, size, ACL_MEMCPY_HOST_TO_DEVICE, stream));
    INFO_LOG("Copy memory from memory %p to memory %p", hostPtrA, devPtrB);

    // Read the value at address devPtrB
    aclrtSynchronizeStream(stream);
    constexpr uint32_t blockDim = 1;
    ReadDo(blockDim, stream, devPtrB);

    // Release resource of the host and device
    aclrtDestroyStreamForce(stream);
    aclrtFreeHost(hostPtrA);
    aclrtFree(devPtrB);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}