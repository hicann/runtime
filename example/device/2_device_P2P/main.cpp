/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <random>
#include <vector>
#include <iostream>
#include "acl/acl.h"
#include "utils.h"

constexpr uint32_t UINT8_DATA_LEN = 256;

int32_t main(int argc, const char *argv[])
{
    INFO_LOG("Start to run device_P2P sample.");
    CHECK_ERROR(aclInit(NULL));
    CHECK_ERROR(aclrtSetDevice(0));

    int32_t canAccessPeer = 0;
    // Query whether data interaction is supported between device 0 and device 1
    CHECK_ERROR(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1));

    // 1 represents support for data interaction
    if (canAccessPeer == 1) {
        // Enable data interaction between the current Device and the specified Device
        CHECK_ERROR(aclrtDeviceEnablePeerAccess(1, 0));

        void *dev0, *dev1, *host;
        uint32_t memSize = 10;
        CHECK_ERROR(aclrtMalloc(&dev0, memSize, ACL_MEM_MALLOC_HUGE_FIRST_P2P));
        int randValue = rand() % UINT8_DATA_LEN;
        // Initialize the memory of device 0
        CHECK_ERROR(aclrtMemset(dev0, memSize, randValue, memSize));

        // Switch to device 1
        CHECK_ERROR(aclrtSetDevice(1));
        // Enable data interaction between the current Device and the specified Device
        CHECK_ERROR(aclrtDeviceEnablePeerAccess(0, 0));

        CHECK_ERROR(aclrtMalloc(&dev1, memSize, ACL_MEM_MALLOC_HUGE_FIRST_P2P));
        CHECK_ERROR(aclrtMemset(dev1, memSize, 0, memSize));

        // Start performing memory copying between devices
        CHECK_ERROR(aclrtMemcpy(dev1, memSize, dev0, memSize, ACL_MEMCPY_DEVICE_TO_DEVICE));
        INFO_LOG("Device 0 to device 1 memcpy success.");

        CHECK_ERROR(aclrtMallocHost(&host, memSize));
        CHECK_ERROR(aclrtMemset(host, memSize, 0, memSize));

        char *char_ptr = (char *)host;
        CHECK_ERROR(aclrtMemcpy(host, memSize, dev1, memSize, ACL_MEMCPY_DEVICE_TO_HOST));
        INFO_LOG("Device 1 to host memcpy success.");

        // Verify the memory copy result
        if (char_ptr[0] == randValue) {
            INFO_LOG("The data read from the memory is %d, verify success!", char_ptr[0]);
        }

        CHECK_ERROR(aclrtSynchronizeDevice());

        CHECK_ERROR(aclrtDeviceDisablePeerAccess(0));
        CHECK_ERROR(aclrtFreeHost(host));
        CHECK_ERROR(aclrtFree(dev1));
        CHECK_ERROR(aclrtResetDeviceForce(1));

        // Switch to device 0
        CHECK_ERROR(aclrtSetDevice(0));
        CHECK_ERROR(aclrtDeviceDisablePeerAccess(1));
        CHECK_ERROR(aclrtFree(dev0));
        CHECK_ERROR(aclrtResetDeviceForce(0));
    } else {
        ERROR_LOG("The device does not support peer access feature.");
    }

    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the device_P2P sample successfully.");
    return 0;
}