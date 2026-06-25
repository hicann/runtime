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
#include <cstdlib>
#include <cstddef>
#include <cmath>
#include <algorithm>
#include <random>
#include "acl/acl.h"
#include "acl/acl_rt_memory_soma.h"
#include "kernel_add.h"
#include "utils.h"

#define MAX_ITER 60

bool validateResults(const float* c, const float* a, const float* b,
                     size_t nelem, const char* testName) {
    printf("> Checking the results from %s ...\n", testName);
    float errorNorm = 0.f, refNorm = 0.f;
    for (size_t n = 0; n < nelem; ++n) {
        float ref = a[n] + b[n];
        float diff = c[n] - ref;
        errorNorm += diff * diff;
        refNorm += ref * ref;
    }
    errorNorm = sqrtf(errorNorm);
    refNorm = sqrtf(refNorm);
    bool passed;
    if (refNorm < 1.e-7f) {
        passed = (errorNorm < 1.e-7f);
    } else {
        passed = (errorNorm < refNorm * 1.e-6f);
    }
    if (passed)
        printf("%s PASSED\n", testName);
    else
        printf("%s FAILED\n", testName);
    return passed;
}

int createMemPool(uint32_t deviceId, uint64_t threshold, aclrtMemPool* memPool) {
    aclrtMemLocation loc = {deviceId, ACL_MEM_LOCATION_TYPE_DEVICE};
    aclrtMemPoolProps poolProps = {
        ACL_MEM_ALLOCATION_TYPE_PINNED,  // allocType
        ACL_MEM_HANDLE_TYPE_NONE,        // handleType
        loc,                             // location
        10UL << 30,                      // maxSize (10GB)
        {0}                              // reserved
    };
    CHECK_ERROR(aclrtMemPoolCreate(memPool, &poolProps));
    CHECK_ERROR(aclrtMemPoolSetAttr(*memPool, ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD, &threshold));
    return 0;
}

int basicStreamOrderedAllocation(uint32_t deviceId, size_t nelem,
                                 const float* a, const float* b, float* c) {
    size_t bytes = nelem * sizeof(float);
    float* devSrcA = nullptr;
    float* devSrcB = nullptr;
    float* devDst = nullptr;
    aclrtStream stream = nullptr;
    aclrtMemPool memPool = nullptr;
    float* hostDst = nullptr;

    printf("Starting basicStreamOrderedAllocation()\n");
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));

    uint64_t threshold = 0;
    CHECK_ERROR(createMemPool(deviceId, threshold, &memPool));

    CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devSrcA), bytes, memPool, stream));
    CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devSrcB), bytes, memPool, stream));
    CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devDst), bytes, memPool, stream));
    CHECK_ERROR(aclrtMemcpyAsync(devSrcA, bytes, a, bytes, ACL_MEMCPY_HOST_TO_DEVICE, stream));
    CHECK_ERROR(aclrtMemcpyAsync(devSrcB, bytes, b, bytes, ACL_MEMCPY_HOST_TO_DEVICE, stream));
    AddDo(8, stream, devSrcA, devSrcB, devDst, nelem);
    CHECK_ERROR(aclrtMemPoolFreeAsync(devSrcA, stream));
    CHECK_ERROR(aclrtMemPoolFreeAsync(devSrcB, stream));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&hostDst), bytes));
    CHECK_ERROR(aclrtMemcpyAsync(hostDst, bytes, devDst, bytes, ACL_MEMCPY_DEVICE_TO_HOST, stream));
    CHECK_ERROR(aclrtMemPoolFreeAsync(devDst, stream));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    std::copy_n(hostDst, nelem, c);

    bool passed = validateResults(c, a, b, nelem, "basicStreamOrderedAllocation");
    CHECK_ERROR(aclrtFreeHost(hostDst));
    CHECK_ERROR(aclrtMemPoolDestroy(memPool));
    CHECK_ERROR(aclrtDestroyStream(stream));
    return passed ? EXIT_SUCCESS : EXIT_FAILURE;
}

int runPoolAllocLoop(uint32_t deviceId, size_t nelem, const float* a, const float* b,
                     float* c, float* elapsedMs) {
    size_t bytes = nelem * sizeof(float);
    float *devSrcA = nullptr, *devSrcB = nullptr, *devDst = nullptr;
    aclrtStream stream = nullptr;
    aclrtMemPool memPool = nullptr;
    aclrtEvent start = nullptr, end = nullptr;
    float* hostDst = nullptr;

    printf("Starting pool-based async allocation loop (%d iterations)...\n", MAX_ITER);
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtCreateEvent(&start));
    CHECK_ERROR(aclrtCreateEvent(&end));

    uint64_t threshold = 10UL << 30;
    CHECK_ERROR(createMemPool(deviceId, threshold, &memPool));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&hostDst), bytes));
    CHECK_ERROR(aclrtRecordEvent(start, stream));

    for (int i = 0; i < MAX_ITER; ++i) {
        CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devSrcA), bytes, memPool, stream));
        CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devSrcB), bytes, memPool, stream));
        CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devDst), bytes, memPool, stream));
        CHECK_ERROR(aclrtMemcpyAsync(devSrcA, bytes, a, bytes, ACL_MEMCPY_HOST_TO_DEVICE, stream));
        CHECK_ERROR(aclrtMemcpyAsync(devSrcB, bytes, b, bytes, ACL_MEMCPY_HOST_TO_DEVICE, stream));
        AddDo(8, stream, devSrcA, devSrcB, devDst, nelem);
        CHECK_ERROR(aclrtMemPoolFreeAsync(devSrcA, stream));
        CHECK_ERROR(aclrtMemPoolFreeAsync(devSrcB, stream));
        CHECK_ERROR(aclrtMemcpyAsync(hostDst, bytes, devDst, bytes, ACL_MEMCPY_DEVICE_TO_HOST, stream));
        CHECK_ERROR(aclrtMemPoolFreeAsync(devDst, stream));
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        std::copy_n(hostDst, nelem, c);
    }

    CHECK_ERROR(aclrtRecordEvent(end, stream));
    CHECK_ERROR(aclrtSynchronizeEvent(end));
    CHECK_ERROR(aclrtEventElapsedTime(elapsedMs, start, end));

    CHECK_ERROR(aclrtFreeHost(hostDst));
    CHECK_ERROR(aclrtMemPoolDestroy(memPool));
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtDestroyEvent(start));
    CHECK_ERROR(aclrtDestroyEvent(end));
    return 0;
}

int runSyncAllocLoop(uint32_t deviceId, size_t nelem, const float* a, const float* b,
                     float* c, float* elapsedMs) {
    size_t bytes = nelem * sizeof(float);
    float *devSrcA = nullptr, *devSrcB = nullptr, *devDst = nullptr;
    aclrtStream stream = nullptr;
    aclrtEvent start = nullptr, end = nullptr;
    float* hostDst = nullptr;

    printf("Starting sync aclrtMalloc loop (%d iterations)...\n", MAX_ITER);
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtCreateEvent(&start));
    CHECK_ERROR(aclrtCreateEvent(&end));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&hostDst), bytes));
    CHECK_ERROR(aclrtRecordEvent(start, stream));

    for (int i = 0; i < MAX_ITER; ++i) {
        CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&devSrcA), bytes, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&devSrcB), bytes, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&devDst), bytes, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMemcpy(devSrcA, bytes, a, bytes, ACL_MEMCPY_HOST_TO_DEVICE));
        CHECK_ERROR(aclrtMemcpy(devSrcB, bytes, b, bytes, ACL_MEMCPY_HOST_TO_DEVICE));
        AddDo(8, stream, devSrcA, devSrcB, devDst, nelem);
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtMemcpy(hostDst, bytes, devDst, bytes, ACL_MEMCPY_DEVICE_TO_HOST));
        std::copy_n(hostDst, nelem, c);
        CHECK_ERROR(aclrtFree(devSrcA));
        CHECK_ERROR(aclrtFree(devSrcB));
        CHECK_ERROR(aclrtFree(devDst));
    }

    CHECK_ERROR(aclrtRecordEvent(end, stream));
    CHECK_ERROR(aclrtSynchronizeEvent(end));
    CHECK_ERROR(aclrtEventElapsedTime(elapsedMs, start, end));

    CHECK_ERROR(aclrtFreeHost(hostDst));
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtDestroyEvent(start));
    CHECK_ERROR(aclrtDestroyEvent(end));
    return 0;
}

int streamOrderedAllocationPostSync(uint32_t deviceId, size_t nelem,
                                    const float* a, const float* b, float* c) {
    printf("Starting streamOrderedAllocationPostSync()\n");
    printf("Comparing pool-based async alloc vs sync aclrtMalloc over %d iterations\n\n", MAX_ITER);

    float elapsedPool = 0.0f;
    float elapsedSync = 0.0f;

    int ret = runPoolAllocLoop(deviceId, nelem, a, b, c, &elapsedPool);
    if (ret != 0) return ret;
    bool poolPassed = validateResults(c, a, b, nelem, "Pool-based async allocation");

    ret = runSyncAllocLoop(deviceId, nelem, a, b, c, &elapsedSync);
    if (ret != 0) return ret;
    bool syncPassed = validateResults(c, a, b, nelem, "Sync aclrtMalloc allocation");

    printf("\n========== Timing Comparison (%d iterations) ==========\n", MAX_ITER);
    printf("  Memory pool (async alloc/free):  %f ms\n", elapsedPool);
    printf("  aclrtMalloc (sync alloc/free):   %f ms\n", elapsedSync);
    if (elapsedPool > 0.0f) {
        printf("  Speedup:                         %.2fx\n", elapsedSync / elapsedPool);
    }
    printf("========================================================\n");

    return (poolPassed && syncPassed) ? EXIT_SUCCESS : EXIT_FAILURE;
}

int main(int argc, char** argv) {
    uint32_t deviceId = 0;
    size_t nelem = 1048576;   // 1M elements
    size_t bytes = nelem * sizeof(float);

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    aclrtContext context = nullptr;
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));

    float* a = (float*)malloc(bytes);
    float* b = (float*)malloc(bytes);
    float* c = (float*)malloc(bytes);
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> dist(0.0f, 1.0f);
    for (size_t n = 0; n < nelem; ++n) {
        a[n] = dist(gen);
        b[n] = dist(gen);
    }

    int ret1 = basicStreamOrderedAllocation(deviceId, nelem, a, b, c);
    int ret2 = streamOrderedAllocationPostSync(deviceId, nelem, a, b, c);

    free(a);
    free(b);
    free(c);

    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDevice(deviceId));
    CHECK_ERROR(aclFinalize());

    return (ret1 == EXIT_SUCCESS && ret2 == EXIT_SUCCESS) ? EXIT_SUCCESS : EXIT_FAILURE;
}
