/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <cstdio>
#include <vector>

#include "acl/acl.h"
#include "vector_add_kernel.h"

#define CHECK_ERROR(ret)                                       \
    if ((ret) != ACL_SUCCESS) {                                \
        printf("Error at line %d, ret = %d\n", __LINE__, ret); \
        return -1;                                             \
    }

namespace {
constexpr uint32_t kElementCount = 8;
} // namespace

int main()
{
    const int32_t deviceId = 0;
    const uint32_t blockDim = kElementCount;
    const size_t bufferSize = kElementCount * sizeof(float);
    const float alpha = 1.0f;

    aclrtStream stream = nullptr;
    float* srcADevice = nullptr;
    float* srcBDevice = nullptr;
    float* dstDevice = nullptr;

    const std::vector<float> srcAHost = {1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f};
    const std::vector<float> srcBHost = {0.5f, 1.0f, 1.5f, 2.0f, 2.5f, 3.0f, 3.5f, 4.0f};
    std::vector<float> dstHost(kElementCount, 0.0f);

    CHECK_ERROR(aclInit(nullptr));
    printf("ACL init successfully\n");

    CHECK_ERROR(aclrtSetDevice(deviceId));
    printf("Set device %d successfully\n", deviceId);

    CHECK_ERROR(aclrtCreateStream(&stream));
    printf("Create stream successfully\n");

    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&srcADevice), bufferSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&srcBDevice), bufferSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&dstDevice), bufferSize, ACL_MEM_MALLOC_HUGE_FIRST));
    printf("Allocate device buffers successfully\n");

    CHECK_ERROR(aclrtMemcpy(srcADevice, bufferSize, srcAHost.data(), bufferSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(srcBDevice, bufferSize, srcBHost.data(), bufferSize, ACL_MEMCPY_HOST_TO_DEVICE));
    printf("Copy input vectors to device successfully\n");

    printf("Input vectors:\n");
    printf(
        "  self:   [%.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f]\n", srcAHost[0], srcAHost[1], srcAHost[2],
        srcAHost[3], srcAHost[4], srcAHost[5], srcAHost[6], srcAHost[7]);
    printf(
        "  other:  [%.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f]\n", srcBHost[0], srcBHost[1], srcBHost[2],
        srcBHost[3], srcBHost[4], srcBHost[5], srcBHost[6], srcBHost[7]);
    printf("  alpha:  %.1f\n", alpha);

    VectorAddDo(blockDim, stream, srcADevice, srcBDevice, dstDevice, alpha, kElementCount);
    printf("Custom AscendC kernel <<<>>> call successfully\n");

    CHECK_ERROR(aclrtSynchronizeStream(stream));
    printf("Synchronize stream successfully\n");

    CHECK_ERROR(aclrtMemcpy(dstHost.data(), bufferSize, dstDevice, bufferSize, ACL_MEMCPY_DEVICE_TO_HOST));

    printf("\nVector addition result:\n");
    for (uint32_t i = 0; i < kElementCount; ++i) {
        printf("  result[%u] = %.1f (expected: %.1f)\n", i, dstHost[i], srcAHost[i] + alpha * srcBHost[i]);
    }

    CHECK_ERROR(aclrtFree(srcADevice));
    CHECK_ERROR(aclrtFree(srcBDevice));
    CHECK_ERROR(aclrtFree(dstDevice));
    printf("Free device memory successfully\n");

    CHECK_ERROR(aclrtDestroyStream(stream));
    printf("Destroy stream successfully\n");

    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    printf("Reset device successfully\n");

    CHECK_ERROR(aclFinalize());
    printf("ACL finalize successfully\n");

    printf("\nSample run successfully with <<<>>> kernel call!\n");
    return 0;
}
