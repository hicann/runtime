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

#define MAX_ITER 20
#define POOL_SIZE (64UL * 1024 * 1024)
#define BLOCK_SIZE (4UL * 1024 * 1024)

constexpr float kZeroThreshold = 1.e-7f;
constexpr float kErrTolerance = 1.e-6f;

struct SomaReuseContext {
    aclrtStream stream;
    aclrtMemPool memPool;
    aclrtEvent start;
    aclrtEvent end;
    float* hostDst;
};

bool validateResults(const float* c, const float* a, const float* b,
                     size_t nelem, const char* testName) {
    printf("> Checking the results from %s ...\n", testName);
    float errSq = 0.f, refSq = 0.f;
    for (size_t n = 0; n < nelem; ++n) {
        float ref = a[n] + b[n];
        float diff = c[n] - ref;
        errSq += diff * diff;
        refSq += ref * ref;
    }
    float errNorm = sqrtf(errSq);
    float normRef = sqrtf(refSq);
    bool passed;
    if (normRef < kZeroThreshold) {
        passed = (errNorm < kZeroThreshold);
    } else {
        passed = (errNorm < normRef * kErrTolerance);
    }
    if (passed)
        printf("%s PASSED\n", testName);
    else
        printf("%s FAILED\n", testName);
    return passed;
}

int setupSomaReuseEnv(uint32_t deviceId, size_t bytes, uint64_t poolSize, SomaReuseContext* ctx) {
    printf("Starting somaReuseInternalDependencies()\n");
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateStream(&ctx->stream));
    CHECK_ERROR(aclrtCreateEvent(&ctx->start));
    CHECK_ERROR(aclrtCreateEvent(&ctx->end));
    aclrtMemLocation loc = {deviceId, ACL_MEM_LOCATION_TYPE_DEVICE};
    aclrtMemPoolProps poolProps = {ACL_MEM_ALLOCATION_TYPE_PINNED, ACL_MEM_HANDLE_TYPE_NONE,
                                    loc, poolSize, {0}};
    CHECK_ERROR(aclrtMemPoolCreate(&ctx->memPool, &poolProps));
    uint64_t threshold = poolSize;
    CHECK_ERROR(aclrtMemPoolSetAttr(ctx->memPool, ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD, &threshold));
    printf("Release threshold set to %lu MB (memory retained after sync)\n", threshold / (1024 * 1024));
    uint64_t currentThreshold = 0;
    CHECK_ERROR(aclrtMemPoolGetAttr(ctx->memPool, ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD, &currentThreshold));
    printf("Verified release threshold = %lu MB\n", currentThreshold / (1024 * 1024));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&ctx->hostDst), bytes));
    CHECK_ERROR(aclrtRecordEvent(ctx->start, ctx->stream));
    return 0;
}

int cleanupSomaReuseEnv(SomaReuseContext* ctx) {
    CHECK_ERROR(aclrtFreeHost(ctx->hostDst));
    CHECK_ERROR(aclrtMemPoolDestroy(ctx->memPool));
    CHECK_ERROR(aclrtDestroyStream(ctx->stream));
    CHECK_ERROR(aclrtDestroyEvent(ctx->start));
    CHECK_ERROR(aclrtDestroyEvent(ctx->end));
    return 0;
}

int somaReuseInternalDependencies(uint32_t deviceId, size_t nelem,
                                   const float* a, const float* b, float* c) {
    size_t bytes = nelem * sizeof(float);
    SomaReuseContext ctx = {};
    int setupRet = setupSomaReuseEnv(deviceId, bytes, POOL_SIZE, &ctx);
    if (setupRet != 0) return setupRet;

    float* devSrcA = nullptr;
    float* devSrcB = nullptr;
    float* devDst = nullptr;
    void* prevSrcA = nullptr;
    void* prevSrcB = nullptr;
    void* prevDst = nullptr;
    int reuseCountSrcA = 0, reuseCountSrcB = 0, reuseCountDst = 0;
    for (int i = 0; i < MAX_ITER; ++i) {
        CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devSrcA), bytes, ctx.memPool, ctx.stream));
        CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devSrcB), bytes, ctx.memPool, ctx.stream));
        CHECK_ERROR(aclrtMemPoolMallocAsync(reinterpret_cast<void**>(&devDst), bytes, ctx.memPool, ctx.stream));
        CHECK_ERROR(aclrtMemcpyAsync(devSrcA, bytes, a, bytes, ACL_MEMCPY_HOST_TO_DEVICE, ctx.stream));
        CHECK_ERROR(aclrtMemcpyAsync(devSrcB, bytes, b, bytes, ACL_MEMCPY_HOST_TO_DEVICE, ctx.stream));
        AddDo(8, ctx.stream, devSrcA, devSrcB, devDst, nelem);
        CHECK_ERROR(aclrtMemPoolFreeAsync(devSrcA, ctx.stream));
        CHECK_ERROR(aclrtMemPoolFreeAsync(devSrcB, ctx.stream));
        CHECK_ERROR(aclrtMemcpyAsync(ctx.hostDst, bytes, devDst, bytes, ACL_MEMCPY_DEVICE_TO_HOST, ctx.stream));
        CHECK_ERROR(aclrtMemPoolFreeAsync(devDst, ctx.stream));
        CHECK_ERROR(aclrtSynchronizeStream(ctx.stream));
        if (prevSrcA != nullptr && devSrcA == prevSrcA) reuseCountSrcA++;
        if (prevSrcB != nullptr && devSrcB == prevSrcB) reuseCountSrcB++;
        if (prevDst != nullptr && devDst == prevDst) reuseCountDst++;
        printf("Iter %2d: devSrcA=%p devSrcB=%p devDst=%p\n", i, devSrcA, devSrcB, devDst);
        prevSrcA = devSrcA;
        prevSrcB = devSrcB;
        prevDst = devDst;
        std::copy_n(ctx.hostDst, nelem, c);
    }
    CHECK_ERROR(aclrtRecordEvent(ctx.end, ctx.stream));
    CHECK_ERROR(aclrtSynchronizeEvent(ctx.end));
    float elapsedMs = 0.0f;
    CHECK_ERROR(aclrtEventElapsedTime(&elapsedMs, ctx.start, ctx.end));
    printf("Total elapsed time = %f ms over %d iterations\n", elapsedMs, MAX_ITER);
    printf("Reuse counts: devSrcA=%d/%d  devSrcB=%d/%d  devDst=%d/%d\n",
           reuseCountSrcA, MAX_ITER - 1, reuseCountSrcB, MAX_ITER - 1, reuseCountDst, MAX_ITER - 1);
    bool passed = validateResults(c, a, b, nelem, "somaReuseInternalDependencies");
    int cleanupRet = cleanupSomaReuseEnv(&ctx);
    if (cleanupRet != 0) return cleanupRet;
    return passed ? EXIT_SUCCESS : EXIT_FAILURE;
}

int main(int argc, char** argv) {
    uint32_t deviceId = 0;
    size_t nelem = BLOCK_SIZE / sizeof(float);
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

    int ret = somaReuseInternalDependencies(deviceId, nelem, a, b, c);

    free(a);
    free(b);
    free(c);

    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDevice(deviceId));
    CHECK_ERROR(aclFinalize());

    return ret;
}