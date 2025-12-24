/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <thread>
#include "acl/acl.h"
#include "utils.h"

using namespace std;

extern void AddDo(uint32_t blockDim, void *stream, float *srcA, float *srcB, float *dst, uint32_t totalSize);

namespace {
    int Init(aclrtStream* stream)
    {
        CHECK_ERROR(aclrtSetDevice(0));
        CHECK_ERROR(aclrtCreateStream(stream));
        return 0;
    }

    int DeviceInfoQuery()
    {
        aclrtRunMode runMode;
        int64_t vectorCoreNum = 0;
        uint32_t deviceCount = 0;
        aclrtDeviceStatus deviceStatus;

        string socName = aclrtGetSocName();
        INFO_LOG("Current Ascend chipset platform is: %s.", socName.c_str());

        CHECK_ERROR(aclrtGetDeviceCount(&deviceCount));
        INFO_LOG("Get device count success. deviceCount: %d.", deviceCount);

        CHECK_ERROR(aclrtQueryDeviceStatus(0, &deviceStatus));
        INFO_LOG("Query device status success. deviceStatus: %d.", deviceStatus);

        CHECK_ERROR(aclrtGetRunMode(&runMode));
        if (runMode == 0) {
            INFO_LOG("RunMode is ACL_DEVICE.");
        } else if (runMode == 1) {
            INFO_LOG("RunMode is ACL_HOST.");
        } else {
            INFO_LOG("RunMode is invalid.");
        }

        aclrtUtilizationInfo utilizationInfo;
        utilizationInfo.utilizationExtend = nullptr;
        CHECK_ERROR(aclrtGetDeviceUtilizationRate(0, &utilizationInfo));
        INFO_LOG("Get device utilizationRate success. cubeUtilization %d, vectorUtilization %d, aicpuUtilization %d,"
            "memoryUtilization %d.",
            utilizationInfo.cubeUtilization, utilizationInfo.vectorUtilization, utilizationInfo.aicpuUtilization,
            utilizationInfo.memoryUtilization);

        int32_t leastPriority;
        int32_t greatestPriority;
        CHECK_ERROR(aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority));
        INFO_LOG("Get stream priorityRange success. leastPriority %d, greatestPriority %d.", leastPriority,
            greatestPriority);
    
        CHECK_ERROR(aclrtGetDeviceInfo(0, ACL_DEV_ATTR_VECTOR_CORE_NUM, &vectorCoreNum));
        INFO_LOG("Get device info success. vectorCoreNum %ld.", vectorCoreNum);
        return 0;
    }

    void RunThread()
    {
        aclrtStream stream = nullptr;
        uint32_t resLimitValue = 0;

        auto ret = Init(&stream);
        if (ret != 0) {
            return;
        }

        ret = DeviceInfoQuery();
        if (ret != 0) {
            return;
        }

        // Define the parameters of the kernel function
        const uint32_t TOTAL_SIZE = 1024;
        const uint32_t DATA_SIZE = TOTAL_SIZE * static_cast<uint32_t>(sizeof(float));

        // Allocate memory on the host
        float *hostSrcA, *hostSrcB, *hostDst;
        aclrtMallocHost(reinterpret_cast<void **>(&hostSrcA), DATA_SIZE);
        aclrtMallocHost(reinterpret_cast<void **>(&hostSrcB), DATA_SIZE);
        aclrtMallocHost(reinterpret_cast<void **>(&hostDst), DATA_SIZE);

        // Allocate memory on the device
        float *devSrcA, *devSrcB, *devDst;
        aclrtMalloc(reinterpret_cast<void **>(&devSrcA), DATA_SIZE, ACL_MEM_MALLOC_HUGE_FIRST);
        aclrtMalloc(reinterpret_cast<void **>(&devSrcB), DATA_SIZE, ACL_MEM_MALLOC_HUGE_FIRST);
        aclrtMalloc(reinterpret_cast<void **>(&devDst), DATA_SIZE, ACL_MEM_MALLOC_HUGE_FIRST);

        // Initialize the test data
        for (uint32_t i = 0; i < TOTAL_SIZE; ++i) {
            hostSrcA[i] = static_cast<float>(i);
            hostSrcB[i] = static_cast<float>(i);
        }

        aclrtMemcpy(devSrcA, DATA_SIZE, hostSrcA, DATA_SIZE, ACL_MEMCPY_HOST_TO_DEVICE);
        aclrtMemcpy(devSrcB, DATA_SIZE, hostSrcB, DATA_SIZE, ACL_MEMCPY_HOST_TO_DEVICE);

        aclrtGetDeviceResLimit(0, ACL_RT_DEV_RES_VECTOR_CORE, &resLimitValue);
        INFO_LOG("Get device resLimit success. VECTOR_CORE %d.", resLimitValue);
        AddDo(resLimitValue, stream, devSrcA, devSrcB, devDst, TOTAL_SIZE);
        aclrtSynchronizeStream(stream);
        aclrtMemcpy(hostDst, DATA_SIZE, devDst, DATA_SIZE, ACL_MEMCPY_DEVICE_TO_HOST);

        INFO_LOG("Thr results (first 10 elements) of the kernel function:");
        for (int i = 0; i < 10; ++i) { // Display the first 10 elements
            INFO_LOG("Result: hostDst[%d]: %f Expected value: %f", i, hostDst[i], hostSrcA[i] + hostSrcB[i]);
        }

        aclrtResetDeviceResLimit(0);

        aclrtFree(devSrcA);
        aclrtFree(devSrcB);
        aclrtFree(devDst);
        aclrtFreeHost(hostSrcA);
        aclrtFreeHost(hostSrcB);

        aclrtDestroyStream(stream);
        aclrtResetDeviceForce(0);
    }
} // namespace

int32_t main(int argc, char const *argv[])
{
    INFO_LOG("Start to run device_multi_thread sample.");
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(0));
    CHECK_ERROR(aclrtSetDeviceResLimit(0, ACL_RT_DEV_RES_VECTOR_CORE, 1));

    std::thread t1(RunThread);
    t1.join();

    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the device_multi_thread sample successfully.");

    return 0;
}