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
 * This sample demonstrates multi-stream memory synchronization
 * using two independent streams (i.e., Stream A and Stream B).
 */


#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"
#include <thread>
#include <cstdint>
#include <cstdio>
#include <fcntl.h>
#include <unistd.h>

int ThreadWait(aclrtStream stream, int32_t deviceId, void* devPtr, uint64_t valueCompare, const char* filePath){
    // Wait for the data in the specified memory to meet the condition
    aclrtSetDevice(deviceId);

    CHECK_ERROR(aclrtValueWait(devPtr, valueCompare, ACL_STREAM_WAIT_VALUE_EQ, stream));
    INFO_LOG("Stream A: wait for data at virtual memory = %p to meet the condition", devPtr);

    // Block application execution until all tasks in the specified stream are completed
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    INFO_LOG("Stream A: the data in the specified memory has met the condition, all tasks are complete");

    // Check whether the waiting thread is truly blocked before the writing thread starts
    // If the waiting thread is blocked, it should read the flag written by the writing thread
    int32_t waitFlag = 0;
    memory::ReadFileEx(filePath, &waitFlag, sizeof(waitFlag));
    INFO_LOG("Flag value read by the waiting thread: %d", waitFlag);
}

int ThreadWrite(aclrtStream stream, int32_t deviceId, void* devPtr, uint64_t valueWrite, const char* filePath){
    // The writing thread writes a flag to check whether the waiting thread is blocked before the writing thread starts
    int32_t writeFlag = 123;
    memory::WriteFileEx(filePath, &writeFlag, sizeof(writeFlag));
    INFO_LOG("Flag value after the writing thread starts: %d", writeFlag);

    // Write data to the specified memory
    aclrtSetDevice(deviceId);
    CHECK_ERROR(aclrtValueWrite(devPtr, valueWrite, 0, stream));
    INFO_LOG("Stream B: write data at virtual memory = %p", devPtr);

    // Block application execution until all tasks in the specified stream are completed
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    INFO_LOG("Stream B: the data in the specified memory has met the condition, all tasks are complete");
}

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);

    // Allocate memory on the device
    uint64_t size = 1 * 1024 * 1024;
    void *devPtrA;
    CHECK_ERROR(aclrtMalloc(&devPtrA, size, ACL_MEM_MALLOC_HUGE_FIRST));
    INFO_LOG("Allocate memory on the device successfully");

    // Create two streams
    aclrtStream streamA = nullptr;
    CHECK_ERROR(aclrtCreateStream(&streamA));
    INFO_LOG("Create Stream A successfully");

    aclrtStream streamB = nullptr;
    CHECK_ERROR(aclrtCreateStream(&streamB));
    INFO_LOG("Create Stream B successfully");

    // Start the waiting thread to wait for the value at specific memory devPtrA to meet the requirement
    const char* filePath = "file/flag.txt";
    uint64_t valueCompare = 100;
    constexpr uint32_t waitTime = 1000000;
    std::thread threadA(ThreadWait, streamA, deviceId, devPtrA, valueCompare, filePath);
    (void)usleep(waitTime);

    // Start the writing thread to write a value at devPtrA
    uint64_t valueWrite = 100;
    std::thread threadB(ThreadWrite, streamB, deviceId, devPtrA, valueWrite, filePath);

    threadB.join();
    threadA.join();

    aclrtDestroyStreamForce(streamA);
    aclrtDestroyStreamForce(streamB);
    aclrtFree(devPtrA);

    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}