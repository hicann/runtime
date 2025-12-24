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
#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"


extern void ReadDo(uint32_t blockDim, void* stream, int* devPtr);

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    // Get Process B's pid
    int32_t pid = 0;
    CHECK_ERROR(aclrtDeviceGetBareTgid(&pid));
    INFO_LOG("Process B: get Process B's pid successfully");

    // Write Process B's pid to the file
    memory::WriteFile("file/pid.bin", "file/pid.bin.done", &pid, sizeof(pid));
    INFO_LOG("Process B: write Process B's pid to the file successfully, Process B's pid = %d", pid);

    // Get the shareable memory identifier from the file
    char memName[256] = "name";
    memory::ReadFile("file/memName.bin", "file/memName.bin.done", memName);
    INFO_LOG("Process B: get the shareable memory identifier successfully, shareable identifier = %s", memName);

    // Return a device memory pointer accessible to Process B
    void *devPtr = nullptr;
    uint64_t size = 1 * 1024 * 1024;
    CHECK_ERROR(aclrtIpcMemImportByKey(&devPtr, memName, 0));

    constexpr uint32_t blockDim = 1;
    ReadDo(blockDim, stream, static_cast<int*>(devPtr));

    // Write the completion flag to the file
    int32_t flag = 1;
    memory::WriteFile("file/flag.bin", "file/flag.bin.done", &flag, sizeof(flag));
    INFO_LOG("Process B: complete ipc memory sharing");

    // Release memory resources
    CHECK_ERROR(aclrtIpcMemClose(memName));

    aclrtDestroyStreamForce(stream);
    aclrtFree(devPtr);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}