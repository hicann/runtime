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
 * This sample enables process whitelist verification.
 */

#include <cstdio>
#include <cstring>
#include "acl/acl.h"
#include "utils.h"
#include "mem_utils.h"


extern void ReadDo(uint32_t blockDim, void* stream, int* devPtr);

int32_t main()
{
    aclInit(nullptr);
    int32_t deviceId = 2;
    aclrtSetDevice(deviceId);
    aclrtStream stream = nullptr;
    aclrtCreateStream(&stream);

    int32_t canAccessPeer = 0;
    int32_t peerDeviceId = 3;
    // Check if data interaction is supported between the target devices
    CHECK_ERROR(aclrtDeviceCanAccessPeer(&canAccessPeer, deviceId, peerDeviceId));

    // canAccessPeer = 1 indicates data interaction is supported between the target devices.
    if (canAccessPeer == 1) {
        // Enable data interaction between the target devices
        CHECK_ERROR(aclrtDeviceEnablePeerAccess(peerDeviceId, 0));
        INFO_LOG("Process A: enable data interaction between device %d and device %d", deviceId, peerDeviceId);

        // Allocate memory on the device
        uint64_t size = 1 * 1024 * 1024;
        int *devPtr = nullptr;
        CHECK_ERROR(aclrtMalloc((void**)&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST));

        // Export a shareable identifier for IPC memory sharing
        char memName[256] = "name";
        size_t lenName = 65;
        CHECK_ERROR(aclrtIpcMemGetExportKey(devPtr, size, memName, lenName, 1));
        INFO_LOG("Process A: get a shareable identifier for IPC memory sharing successfully, shareable identifier = %s", memName);

        // Transfer the shareable identifier to Process B by writing it to the file
        memory::WriteFile("file/memName.bin", "file/memName.bin.done", memName, strlen(memName));

        // Create notify
        aclrtNotify notify = nullptr;
        CHECK_ERROR(aclrtCreateNotify(&notify, 0));

        // Export a shareable identifier for IPC notify sharing
        char notifyName[256] = "name";
        CHECK_ERROR(aclrtNotifyGetExportKey(notify, notifyName, lenName, 0));
        INFO_LOG("Process A: get a shareable identifier for IPC notify sharing successfully, shareable identifier = %s", notifyName);

        // Read Process B's pid from the file
        int32_t pid = 0;
        memory::ReadFile("file/pid.bin", "file/pid.bin.done", &pid);
        INFO_LOG("Process A: get Process B's pid successfully, Process B's pid = %d", pid);

        // Add Process B to the whitelist
        CHECK_ERROR(aclrtNotifySetImportPid(notify, &pid, 1));
        INFO_LOG("Process A: add Process B to the whitelist successfully");

        // Transfer the shareable identifier to Process B by writing it to the file
        memory::WriteFile("file/notifyName.bin", "file/notifyName.bin.done", notifyName, strlen(notifyName));

        // Dispatch the waiting task
        CHECK_ERROR(aclrtWaitAndResetNotify(notify, stream, 0));

        // Check whether Process A's waiting task is truly blocked before Process B's task ends
        // If the waiting task is blocked, it should read the value written by Process B
        uint32_t blockDim = 1;
        ReadDo(blockDim, stream, devPtr);

        // Release notify and memory resources
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtIpcMemClose(memName));
        CHECK_ERROR(aclrtFree(devPtr));
        CHECK_ERROR(aclrtDestroyNotify(notify));
    } else {
        ERROR_LOG("The target devices do not support data interaction");
    }
    aclrtDestroyStreamForce(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}
