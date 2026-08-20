/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "simple_zero_copy.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 8;
constexpr size_t kElementCount = 8 * 2048;
constexpr size_t kBufferSize = kElementCount * sizeof(uint16_t);
constexpr uint16_t kHalfOne = 0x3C00;
constexpr uint16_t kHalfTwo = 0x4000;
constexpr uint16_t kHalfThree = 0x4200;
constexpr const char* kKernelPath = "./out/fatbin/simple_zero_copy_kernel/simple_zero_copy_kernel.o";

struct MappedBuffer {
    uint16_t* host = nullptr;
    void* device = nullptr;
    bool registered = false;
};

struct RuntimeSession {
    aclrtStream stream = nullptr;
    aclrtBinHandle binary = nullptr;
    bool initialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
    bool binaryLoaded = false;
    MappedBuffer inputA;
    MappedBuffer inputB;
    MappedBuffer output;
};

void RecordCleanupError(const char* operation, aclError error, int& result)
{
    if (error == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
    result = -1;
}

int InitializeRuntime(RuntimeSession& session)
{
    CHECK_ERROR(aclInit(nullptr));
    session.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    session.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&session.stream));
    session.streamCreated = true;
    return 0;
}

int AllocateMappedBuffer(MappedBuffer& buffer)
{
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&buffer.host), kBufferSize));
    CHECK_ERROR(aclrtHostRegisterV2(buffer.host, kBufferSize, ACL_HOST_REG_MAPPED));
    buffer.registered = true;
    CHECK_ERROR(aclrtHostGetDevicePointer(buffer.host, &buffer.device, 0));
    if (buffer.device == nullptr) {
        ERROR_LOG("Mapped Device address is null.");
        return -1;
    }
    return 0;
}

int PrepareMappedBuffers(RuntimeSession& session)
{
    if (AllocateMappedBuffer(session.inputA) != 0 || AllocateMappedBuffer(session.inputB) != 0 ||
        AllocateMappedBuffer(session.output) != 0) {
        return -1;
    }
    std::fill_n(session.inputA.host, kElementCount, kHalfOne);
    std::fill_n(session.inputB.host, kElementCount, kHalfTwo);
    std::fill_n(session.output.host, kElementCount, 0);
    INFO_LOG("Registered three Host buffers and obtained their Device mapping addresses.");
    return 0;
}

int AppendKernelPointer(aclrtArgsHandle argsHandle, void* devicePointer)
{
    aclrtParamHandle paramHandle = nullptr;
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, &devicePointer, sizeof(uintptr_t), &paramHandle));
    return 0;
}

int LoadKernel(RuntimeSession& session, aclrtFuncHandle& function, aclrtArgsHandle& args)
{
    CHECK_ERROR(aclrtBinaryLoadFromFile(kKernelPath, nullptr, &session.binary));
    session.binaryLoaded = true;
    CHECK_ERROR(aclrtBinaryGetFunction(session.binary, "add_custom", &function));
    CHECK_ERROR(aclrtKernelArgsInit(function, &args));
    if (AppendKernelPointer(args, session.inputA.device) != 0 ||
        AppendKernelPointer(args, session.inputB.device) != 0 ||
        AppendKernelPointer(args, session.output.device) != 0) {
        return -1;
    }
    CHECK_ERROR(aclrtKernelArgsFinalize(args));
    return 0;
}

int ExecuteAndVerify(RuntimeSession& session, aclrtFuncHandle function, aclrtArgsHandle args)
{
    CHECK_ERROR(aclrtLaunchKernelWithConfig(function, kBlockDim, session.stream, nullptr, args, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(session.stream));
    for (size_t index = 0; index < kElementCount; ++index) {
        if (session.output.host[index] != kHalfThree) {
            ERROR_LOG(
                "Result mismatch at index %zu: actual=0x%04x, expected=0x%04x", index, session.output.host[index],
                kHalfThree);
            return -1;
        }
    }
    INFO_LOG("Verified %zu FP16 additions through mapped Host memory.", kElementCount);
    return 0;
}

void ReleaseMappedBuffer(const char* name, MappedBuffer& buffer, int& result)
{
    if (buffer.registered) {
        RecordCleanupError(name, aclrtHostUnregister(buffer.host), result);
        buffer.registered = false;
    }
    if (buffer.host != nullptr) {
        RecordCleanupError("aclrtFreeHost", aclrtFreeHost(buffer.host), result);
        buffer.host = nullptr;
    }
    buffer.device = nullptr;
}

void ReleaseSession(RuntimeSession& session, int& result)
{
    if (session.binaryLoaded) {
        RecordCleanupError("aclrtBinaryUnLoad", aclrtBinaryUnLoad(session.binary), result);
        session.binaryLoaded = false;
    }
    ReleaseMappedBuffer("aclrtHostUnregister(output)", session.output, result);
    ReleaseMappedBuffer("aclrtHostUnregister(inputB)", session.inputB, result);
    ReleaseMappedBuffer("aclrtHostUnregister(inputA)", session.inputA, result);
    if (session.streamCreated) {
        RecordCleanupError("aclrtDestroyStream", aclrtDestroyStream(session.stream), result);
        session.streamCreated = false;
    }
    if (session.deviceSet) {
        RecordCleanupError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
        session.deviceSet = false;
    }
    if (session.initialized) {
        RecordCleanupError("aclFinalize", aclFinalize(), result);
        session.initialized = false;
    }
}
} // namespace

int RunSimpleZeroCopy()
{
    RuntimeSession session;
    aclrtFuncHandle function = nullptr;
    aclrtArgsHandle args = nullptr;
    int result = 0;

    if (InitializeRuntime(session) != 0 || PrepareMappedBuffers(session) != 0 ||
        LoadKernel(session, function, args) != 0 || ExecuteAndVerify(session, function, args) != 0) {
        result = -1;
    }
    ReleaseSession(session, result);
    return result;
}
