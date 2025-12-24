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
 * This sample demonstrates Inter-Process Communication (IPC) notify for 
 * task synchronization across multiple devices and processes.
 * This sample does not enable whitelist verification.
 */

#include <cstdio>
#include <cstring>
#include <unistd.h>
#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"


extern void WriteDo(uint32_t blockDim, void* stream, int* devPtr, int value);

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 3;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    int32_t canAccessPeer = 0;
    int32_t peerDeviceId = 2;
    // Check if data interaction is supported between the target devices
    CHECK_ERROR(aclrtDeviceCanAccessPeer(&canAccessPeer, deviceId, peerDeviceId));

    // canAccessPeer = 1 indicates data interaction is supported between the target devices.
    if (canAccessPeer == 1) {
        // Enable data interaction between the target devices
        CHECK_ERROR(aclrtDeviceEnablePeerAccess(peerDeviceId, 0));
        INFO_LOG("Process B: enable data interaction between device %d and device %d", deviceId, peerDeviceId);

        // Get the shareable identifier from the file
        char memName[256] = "name";
        memory::ReadFile("file/memName.bin", "file/memName.bin.done", memName);
        INFO_LOG("Process B: get the shareable identifier for IPC memory sharing successfully, shareable identifier = %s", memName);

        // Get identifier information and return a device memory pointer accessible to Process B
        void *devPtr = nullptr;
        uint64_t size = 1 * 1024 * 1024;
        CHECK_ERROR(aclrtIpcMemImportByKey(&devPtr, memName, 0));
      
        // Get the shareable identifier from the file
        char notifyName[256] = "name";
        memory::ReadFile("file/notifyName.bin", "file/notifyName.bin.done", notifyName);
        INFO_LOG("Process B: get the shareable identifier for IPC notify sharing successfully, shareable identifier = %s", notifyName);

        // Return the notify accessible to Process B
        aclrtNotify notify = nullptr;
        CHECK_ERROR(aclrtNotifyImportByKey(&notify, notifyName, 0));

        // Wait a moment to mimic a time-consuming task
        uint32_t waitTime = 5000000;
        (void)usleep(waitTime);

        // Launch a task using kernel
        uint32_t blockDim = 1;
        int32_t writeValue = 123;
        WriteDo(blockDim, stream, static_cast<int*>(devPtr), writeValue);
        INFO_LOG("Process B: write data %d to the device memory %p", writeValue, devPtr);

        // Record the notify on the stream
        CHECK_ERROR(aclrtRecordNotify(notify, stream));

        // Release notify and memory resources
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtIpcMemClose(memName));
        CHECK_ERROR(aclrtDestroyNotify(notify));     
    } else {
        ERROR_LOG("The target devices do not support data interaction");
    }
    aclrtDestroyStreamForce(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}
