/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "pitched_image_shift.h"

#include <array>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kWidth = 8;
constexpr size_t kHeight = 8;
constexpr size_t kHostPitchElements = 12;
constexpr size_t kDevicePitchElements = 16;
constexpr size_t kHostPitchBytes = kHostPitchElements * sizeof(uint16_t);
constexpr size_t kDevicePitchBytes = kDevicePitchElements * sizeof(uint16_t);
constexpr size_t kRowBytes = kWidth * sizeof(uint16_t);
constexpr size_t kHostBytes = kHostPitchBytes * kHeight;
constexpr size_t kDeviceBytes = kDevicePitchBytes * kHeight;
constexpr uint16_t kPadding = 0xFFFF;
constexpr char kKernelPath[] = "./out/fatbin/pitched_shift_kernel/pitched_shift_kernel.o";

class PitchedShiftWorkflow {
public:
    int Run();

private:
    int InitializeRuntime();
    int AllocateBuffers();
    void PrepareImage();
    int BuildKernel();
    int ExecuteShift();
    bool VerifyShift() const;
    void RecordCleanupFailure(const char* operation, aclError error, int& result) const;
    void FinishDeviceWork(int& result);
    void ReleaseBuffers(int& result);
    void ShutdownRuntime(int& result);
    void Cleanup(int& result);

    aclrtStream stream_ = nullptr;
    aclrtBinHandle binary_ = nullptr;
    aclrtFuncHandle function_ = nullptr;
    aclrtArgsHandle arguments_ = nullptr;
    uint16_t* inputHost_ = nullptr;
    uint16_t* outputHost_ = nullptr;
    uint16_t* inputDevice_ = nullptr;
    uint16_t* outputDevice_ = nullptr;
    bool initialized_ = false;
    bool deviceSet_ = false;
};

void PitchedShiftWorkflow::RecordCleanupFailure(const char* operation, aclError error, int& result) const
{
    if (error == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
    result = -1;
}

int PitchedShiftWorkflow::InitializeRuntime()
{
    CHECK_ERROR(aclInit(nullptr));
    initialized_ = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    deviceSet_ = true;
    CHECK_ERROR(aclrtCreateStream(&stream_));
    return 0;
}

int PitchedShiftWorkflow::AllocateBuffers()
{
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&inputHost_), kHostBytes));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&outputHost_), kHostBytes));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&inputDevice_), kDeviceBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&outputDevice_), kDeviceBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

void PitchedShiftWorkflow::PrepareImage()
{
    for (size_t index = 0; index < kHostPitchElements * kHeight; ++index) {
        inputHost_[index] = kPadding;
        outputHost_[index] = kPadding;
    }
    for (size_t row = 0; row < kHeight; ++row) {
        for (size_t column = 0; column < kWidth; ++column) {
            inputHost_[row * kHostPitchElements + column] = static_cast<uint16_t>(row * kWidth + column);
        }
    }
}

int PitchedShiftWorkflow::BuildKernel()
{
    CHECK_ERROR(aclrtBinaryLoadFromFile(kKernelPath, nullptr, &binary_));
    CHECK_ERROR(aclrtBinaryGetFunction(binary_, "pitched_shift", &function_));
    CHECK_ERROR(aclrtKernelArgsInit(function_, &arguments_));
    const std::array<void*, 2> values = {inputDevice_, outputDevice_};
    for (void* value : values) {
        aclrtParamHandle parameter = nullptr;
        CHECK_ERROR(aclrtKernelArgsAppend(arguments_, &value, sizeof(uintptr_t), &parameter));
    }
    CHECK_ERROR(aclrtKernelArgsFinalize(arguments_));
    return 0;
}

int PitchedShiftWorkflow::ExecuteShift()
{
    CHECK_ERROR(aclrtMemcpy2d(
        inputDevice_, kDevicePitchBytes, inputHost_, kHostPitchBytes, kRowBytes, kHeight, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtLaunchKernelWithConfig(function_, 1, stream_, nullptr, arguments_, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(stream_));
    CHECK_ERROR(aclrtMemcpy2d(
        outputHost_, kHostPitchBytes, outputDevice_, kDevicePitchBytes, kRowBytes, kHeight, ACL_MEMCPY_DEVICE_TO_HOST));
    return 0;
}

bool PitchedShiftWorkflow::VerifyShift() const
{
    for (size_t row = 0; row < kHeight; ++row) {
        for (size_t column = 0; column < kWidth; ++column) {
            const size_t sourceRow = (row + 1) % kHeight;
            const size_t sourceColumn = (column + 2) % kWidth;
            const uint16_t expected = static_cast<uint16_t>(sourceRow * kWidth + sourceColumn);
            if (outputHost_[row * kHostPitchElements + column] != expected) {
                ERROR_LOG(
                    "Shift mismatch at (%zu,%zu): actual=%u, expected=%u", row, column,
                    outputHost_[row * kHostPitchElements + column], expected);
                return false;
            }
        }
        for (size_t column = kWidth; column < kHostPitchElements; ++column) {
            if (outputHost_[row * kHostPitchElements + column] != kPadding) {
                ERROR_LOG("Host padding was overwritten at (%zu,%zu)", row, column);
                return false;
            }
        }
    }
    INFO_LOG(
        "Pitched shift verified: 64 pixels, Host pitch=%zu bytes, Device pitch=%zu bytes.", kHostPitchBytes,
        kDevicePitchBytes);
    return true;
}

void PitchedShiftWorkflow::FinishDeviceWork(int& result)
{
    if (stream_ != nullptr) {
        RecordCleanupFailure("aclrtSynchronizeStream", aclrtSynchronizeStream(stream_), result);
    }
    if (binary_ != nullptr) {
        RecordCleanupFailure("aclrtBinaryUnLoad", aclrtBinaryUnLoad(binary_), result);
    }
}

void PitchedShiftWorkflow::ReleaseBuffers(int& result)
{
    if (outputDevice_ != nullptr) {
        RecordCleanupFailure("aclrtFree(outputDevice)", aclrtFree(outputDevice_), result);
    }
    if (inputDevice_ != nullptr) {
        RecordCleanupFailure("aclrtFree(inputDevice)", aclrtFree(inputDevice_), result);
    }
    if (outputHost_ != nullptr) {
        RecordCleanupFailure("aclrtFreeHost(outputHost)", aclrtFreeHost(outputHost_), result);
    }
    if (inputHost_ != nullptr) {
        RecordCleanupFailure("aclrtFreeHost(inputHost)", aclrtFreeHost(inputHost_), result);
    }
}

void PitchedShiftWorkflow::ShutdownRuntime(int& result)
{
    if (stream_ != nullptr) {
        RecordCleanupFailure("aclrtDestroyStream", aclrtDestroyStream(stream_), result);
    }
    if (deviceSet_) {
        RecordCleanupFailure("aclrtResetDevice", aclrtResetDevice(kDeviceId), result);
    }
    if (initialized_) {
        RecordCleanupFailure("aclFinalize", aclFinalize(), result);
    }
}

void PitchedShiftWorkflow::Cleanup(int& result)
{
    FinishDeviceWork(result);
    ReleaseBuffers(result);
    ShutdownRuntime(result);
}

int PitchedShiftWorkflow::Run()
{
    int result = InitializeRuntime();
    if (result == 0) {
        result = AllocateBuffers();
    }
    if (result == 0) {
        PrepareImage();
        result = BuildKernel();
    }
    if (result == 0) {
        result = ExecuteShift();
    }
    if (result == 0 && !VerifyShift()) {
        result = -1;
    }
    Cleanup(result);
    return result;
}
} // namespace

int RunPitchedShiftSample()
{
    PitchedShiftWorkflow workflow;
    return workflow.Run();
}
