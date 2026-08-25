/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample demonstrates how to use aclrtBinaryGetFunctionCount to query
 * the number of kernel functions in an operator binary, then retrieve function
 * handles by name, launch each kernel, and verify FP16 computation results.
 */

#include <cstddef>
#include <cstdint>
#include <cstring>
#include <string>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr uint32_t kExpectedFunctionCount = 3U;
constexpr uint32_t kFunctionNameLength = 128U;
constexpr uint32_t kBlockDim = 8U;
constexpr size_t kElementCount = 8U * 2048U;
constexpr uint16_t kFp16One = 0x3C00U;
constexpr uint16_t kFp16Two = 0x4000U;

struct ExpectedFunction {
    const char* name;
    float expectedValue;
    aclrtFuncHandle handle;
};

float Fp16ToFloat(uint16_t fp16)
{
    uint32_t sign = (fp16 >> 15) & 0x1U;
    uint32_t exponent = (fp16 >> 10) & 0x1FU;
    uint32_t mantissa = fp16 & 0x3FFU;
    uint32_t fp32Bits;
    if (exponent == 0U) {
        fp32Bits = (sign << 31) | mantissa;
    } else if (exponent == 31U) {
        fp32Bits = (sign << 31) | (0xFFU << 23) | (mantissa << 13);
    } else {
        fp32Bits = (sign << 31) | ((exponent - 15U + 127U) << 23) | (mantissa << 13);
    }
    union {
        uint32_t u;
        float f;
    } converter;
    converter.u = fp32Bits;
    return converter.f;
}

struct RuntimeResources {
    int32_t deviceId = 0;
    aclrtStream stream = nullptr;
    aclrtBinHandle binHandle = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
    bool binLoaded = false;
};

struct KernelBuffers {
    void* xHost = nullptr;
    void* yHost = nullptr;
    void* zHost = nullptr;
    void* xDevice = nullptr;
    void* yDevice = nullptr;
    void* zDevice = nullptr;
};

#define CHECK_ACL(api)                                                                                   \
    do {                                                                                                 \
        aclError __ret = (api);                                                                          \
        if (__ret != ACL_SUCCESS) {                                                                      \
            const char* errMsg = aclGetRecentErrMsg();                                                   \
            ERROR_LOG("Operation failed: %s returned error code %d", #api, static_cast<int32_t>(__ret)); \
            if (errMsg != nullptr) {                                                                     \
                ERROR_LOG("Detail: %s", errMsg);                                                         \
            }                                                                                            \
            return -1;                                                                                   \
        }                                                                                                \
    } while (0)

void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

int32_t InitializeRuntime(RuntimeResources* runtime)
{
    CHECK_ERROR(aclInit(nullptr));
    runtime->aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(runtime->deviceId));
    runtime->deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&runtime->stream));
    runtime->streamCreated = true;
    return 0;
}

int32_t LoadBinary(const char* binaryPath, RuntimeResources* runtime)
{
    CHECK_ERROR(aclrtBinaryLoadFromFile(binaryPath, nullptr, &runtime->binHandle));
    runtime->binLoaded = true;
    return 0;
}

int32_t QueryFunctionCount(const RuntimeResources& runtime, uint32_t& functionCount)
{
    CHECK_ACL(aclrtBinaryGetFunctionCount(runtime.binHandle, &functionCount));
    INFO_LOG("aclrtBinaryGetFunctionCount returned %u functions", functionCount);
    if (functionCount != kExpectedFunctionCount) {
        ERROR_LOG("Expected %u functions, but got %u", kExpectedFunctionCount, functionCount);
        return -1;
    }
    return 0;
}

int32_t GetFunctionHandlesByName(const RuntimeResources& runtime, ExpectedFunction* functions, uint32_t count)
{
    for (uint32_t i = 0U; i < count; ++i) {
        CHECK_ACL(aclrtBinaryGetFunction(runtime.binHandle, functions[i].name, &functions[i].handle));
    }
    return 0;
}

int32_t QueryFunctionInfo(ExpectedFunction* functions, uint32_t count)
{
    for (uint32_t i = 0U; i < count; ++i) {
        char functionName[kFunctionNameLength] = {};
        void* aicAddress = nullptr;
        void* aivAddress = nullptr;
        CHECK_ACL(aclrtGetFunctionName(functions[i].handle, kFunctionNameLength, functionName));
        CHECK_ACL(aclrtGetFunctionAddr(functions[i].handle, &aicAddress, &aivAddress));
        INFO_LOG(
            "function[%u]: name=%s, handle=%p, aic=%p, aiv=%p", i, functionName, functions[i].handle, aicAddress,
            aivAddress);
    }
    return 0;
}

int32_t AllocateKernelBuffers(size_t dataSize, KernelBuffers* buffers)
{
    CHECK_ERROR(aclrtMallocHost(&buffers->xHost, dataSize));
    CHECK_ERROR(aclrtMallocHost(&buffers->yHost, dataSize));
    CHECK_ERROR(aclrtMallocHost(&buffers->zHost, dataSize));
    CHECK_ERROR(aclrtMalloc(&buffers->xDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&buffers->yDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&buffers->zDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

void PrepareInputData(size_t elementCount, const KernelBuffers& buffers)
{
    auto* xData = static_cast<uint16_t*>(buffers.xHost);
    auto* yData = static_cast<uint16_t*>(buffers.yHost);
    for (size_t i = 0U; i < elementCount; ++i) {
        xData[i] = kFp16One;
        yData[i] = kFp16Two;
    }
    auto* zData = static_cast<uint16_t*>(buffers.zHost);
    for (size_t i = 0U; i < elementCount; ++i) {
        zData[i] = 0U;
    }

    INFO_LOG("Input data prepared (showing first 5 elements):");
    INFO_LOG(
        "  x[0..4] = [%.1f, %.1f, %.1f, %.1f, %.1f]", Fp16ToFloat(xData[0]), Fp16ToFloat(xData[1]),
        Fp16ToFloat(xData[2]), Fp16ToFloat(xData[3]), Fp16ToFloat(xData[4]));
    INFO_LOG(
        "  y[0..4] = [%.1f, %.1f, %.1f, %.1f, %.1f]", Fp16ToFloat(yData[0]), Fp16ToFloat(yData[1]),
        Fp16ToFloat(yData[2]), Fp16ToFloat(yData[3]), Fp16ToFloat(yData[4]));
}

int32_t CopyInputToDevice(size_t dataSize, const KernelBuffers& buffers)
{
    CHECK_ERROR(aclrtMemcpy(buffers.xDevice, dataSize, buffers.xHost, dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(buffers.yDevice, dataSize, buffers.yHost, dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int32_t LaunchKernelAndVerify(
    aclrtFuncHandle handle, aclrtStream stream, size_t dataSize, size_t elementCount, float expectedValue,
    const char* kernelName, const KernelBuffers& buffers)
{
    void* args[] = {buffers.xDevice, buffers.yDevice, buffers.zDevice};
    CHECK_ACL(aclrtLaunchKernelWithHostArgs(handle, kBlockDim, stream, nullptr, args, sizeof(args), nullptr, 0U));
    CHECK_ACL(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(buffers.zHost, dataSize, buffers.zDevice, dataSize, ACL_MEMCPY_DEVICE_TO_HOST));

    auto* zData = static_cast<uint16_t*>(buffers.zHost);
    INFO_LOG("%s output (showing first 5 elements):", kernelName);
    INFO_LOG(
        "  z[0..4] = [%.1f, %.1f, %.1f, %.1f, %.1f]", Fp16ToFloat(zData[0]), Fp16ToFloat(zData[1]),
        Fp16ToFloat(zData[2]), Fp16ToFloat(zData[3]), Fp16ToFloat(zData[4]));

    for (size_t i = 0U; i < elementCount; ++i) {
        float actualValue = Fp16ToFloat(zData[i]);
        if (actualValue != expectedValue) {
            ERROR_LOG("%s output[%zu]=%.1f, expected=%.1f", kernelName, i, actualValue, expectedValue);
            return -1;
        }
    }
    INFO_LOG("%s result verified", kernelName);
    return 0;
}

void ReleaseKernelResources(KernelBuffers& buffers)
{
    CHECK_ERROR_WITHOUT_RETURN(aclrtFree(buffers.zDevice));
    CHECK_ERROR_WITHOUT_RETURN(aclrtFree(buffers.yDevice));
    CHECK_ERROR_WITHOUT_RETURN(aclrtFree(buffers.xDevice));
    CHECK_ERROR_WITHOUT_RETURN(aclrtFreeHost(buffers.zHost));
    CHECK_ERROR_WITHOUT_RETURN(aclrtFreeHost(buffers.yHost));
    CHECK_ERROR_WITHOUT_RETURN(aclrtFreeHost(buffers.xHost));
}

void ReleaseRuntimeResources(RuntimeResources& runtime, int32_t& finalResult)
{
    if (runtime.binLoaded) {
        UpdateFinalResultOnError("aclrtBinaryUnLoad", aclrtBinaryUnLoad(runtime.binHandle), finalResult);
    }
    if (runtime.streamCreated) {
        UpdateFinalResultOnError("aclrtDestroyStreamForce", aclrtDestroyStreamForce(runtime.stream), finalResult);
    }
    if (runtime.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce", aclrtResetDeviceForce(runtime.deviceId), finalResult);
    }
    if (runtime.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize", aclFinalize(), finalResult);
    }
}

int32_t ExecuteSample(
    const char* binaryPath, size_t dataSize, RuntimeResources& runtime, KernelBuffers& buffers,
    ExpectedFunction* expectedFunctions)
{
    if (InitializeRuntime(&runtime) != 0) {
        return -1;
    }
    if (LoadBinary(binaryPath, &runtime) != 0) {
        return -1;
    }
    INFO_LOG("Querying the number of kernel functions in the binary");
    uint32_t functionCount = 0U;
    if (QueryFunctionCount(runtime, functionCount) != 0) {
        return -1;
    }
    INFO_LOG("Getting function handles by name");
    if (GetFunctionHandlesByName(runtime, expectedFunctions, kExpectedFunctionCount) != 0) {
        return -1;
    }
    INFO_LOG("Querying function names and addresses");
    if (QueryFunctionInfo(expectedFunctions, kExpectedFunctionCount) != 0) {
        return -1;
    }
    INFO_LOG("Preparing input data");
    if (AllocateKernelBuffers(dataSize, &buffers) != 0) {
        return -1;
    }
    PrepareInputData(kElementCount, buffers);
    if (CopyInputToDevice(dataSize, buffers) != 0) {
        return -1;
    }
    INFO_LOG("Launching kernels and verifying results");
    for (uint32_t i = 0U; i < kExpectedFunctionCount; ++i) {
        if (LaunchKernelAndVerify(
                expectedFunctions[i].handle, runtime.stream, dataSize, kElementCount,
                expectedFunctions[i].expectedValue, expectedFunctions[i].name, buffers) != 0) {
            return -1;
        }
    }
    return 0;
}

int32_t RunBinaryGetFunctionCountSample(const std::string& binaryPath)
{
    const size_t dataSize = kElementCount * sizeof(uint16_t);
    int32_t finalResult = 0;
    RuntimeResources runtime;
    KernelBuffers buffers;
    ExpectedFunction expectedFunctions[kExpectedFunctionCount] = {
        {"add_custom", 3.0f, nullptr},
        {"sub_custom", -1.0f, nullptr},
        {"mul_custom", 2.0f, nullptr},
    };

    int32_t result = ExecuteSample(binaryPath.c_str(), dataSize, runtime, buffers, expectedFunctions);

    if (result == 0 && finalResult == 0) {
        INFO_LOG("aclrtBinaryGetFunctionCount sample PASSED");
    }

    ReleaseKernelResources(buffers);
    ReleaseRuntimeResources(runtime, finalResult);

    return (result != 0) ? result : finalResult;
}
} // namespace

int32_t main(int32_t argc, char* argv[])
{
    const std::string binaryPath = (argc > 1) ? argv[1] : "custom_kernels.o";
    return RunBinaryGetFunctionCountSample(binaryPath);
}
