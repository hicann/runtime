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
 * This sample enables process whitelist verification.
 */

#include <cstdio>
#include <cstring>
#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"

extern void WriteDo(uint32_t blockDim, void* stream, int* devPtr, int value);

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    // Allocate memory on the device
    uint64_t size = 1 * 1024 * 1024;
    int *devPtr;
    CHECK_ERROR(aclrtMalloc((void**)&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST));
    INFO_LOG("Allocate memory on the device %p successfully", devPtr);

    constexpr uint32_t blockDim = 1;
    int writeValue = 123;
    WriteDo(blockDim, stream, devPtr, writeValue);
    INFO_LOG("Write data %d to the device address %p", writeValue, devPtr);

    // Export the shareable memory identifier
    char memName[256] = "name";
    size_t lenName = 65;
    CHECK_ERROR(aclrtIpcMemGetExportKey(devPtr, size, memName, lenName, 0));
    INFO_LOG("Process A: get the shareable memory identifier %s successfully", memName);

    // Read Process B's pid from the file
    int32_t pid = 0;
    memory::ReadFile("file/pid.bin", "file/pid.bin.done", &pid);
    INFO_LOG("Process A: get Process B's pid successfully, Process B's pid = %d", pid);

    // Add Process B to the whitelist
    CHECK_ERROR(aclrtIpcMemSetImportPid(memName, &pid, 1));
    INFO_LOG("Process A: add Process B to the whitelist successfully");

    // Transfer the shareable memory identifier to Process B by writing it to the file
    memory::WriteFile("file/memName.bin", "file/memName.bin.done", memName, strlen(memName));

    // Read the completion flag from the file
    int32_t flag = 0;
    memory::ReadFile("file/flag.bin", "file/flag.bin.done", &flag);
    INFO_LOG("Process A: receive the completion signal from Process B, completion signal = %d", flag);

    // Release memory resources
    CHECK_ERROR(aclrtIpcMemClose(memName));

    aclrtDestroyStreamForce(stream);
    aclrtFree(devPtr);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}