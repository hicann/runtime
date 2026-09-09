/*
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>
#include <thread>
#include <vector>

#include "acl/acl.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 1;
constexpr size_t kElementCount = 2048U;
constexpr size_t kDataSize = kElementCount * sizeof(uint16_t);
constexpr uint64_t kLoopSpin = 1ULL;
constexpr int32_t kSyncTimeoutMs = 60000;
constexpr int32_t kGateDelayMs = 1500;
constexpr uint16_t kInputX = 0x3c00U;   // half(1.0)
constexpr uint16_t kInputY = 0x4000U;   // half(2.0)
constexpr uint16_t kExpected = 0x4200U; // half(3.0)
constexpr char kKernelPath[] = "./out/fatbin/launch_blocking_kernel/launch_blocking_kernel.o";

struct KernelArgs {
    void* x;
    void* y;
    void* z;
    void* loop;
};

struct LaunchResult {
    aclError ret;
    int64_t elapsedMs;
};

int64_t NowMs()
{
    return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
        .count();
}

bool CheckAcl(aclError ret, const char* expression)
{
    if (ret == ACL_SUCCESS) {
        return true;
    }
    std::cerr << "[ERROR] " << expression << " failed, ret=" << ret << std::endl;
    return false;
}

bool IsLaunchBlockingEnabledByEnv()
{
    const char* value = std::getenv("ASCEND_RT_LAUNCH_BLOCKING");
    return value != nullptr && std::strcmp(value, "1") == 0;
}

class SampleContext {
public:
    ~SampleContext() { Cleanup(); }

    bool Init()
    {
        if (!CheckAcl(aclInit(nullptr), "aclInit")) {
            return false;
        }
        aclInitialized_ = true;
        if (!CheckAcl(aclrtSetDevice(kDeviceId), "aclrtSetDevice")) {
            return false;
        }
        deviceSet_ = true;
        if (!CheckAcl(aclrtCreateStream(&stream_), "aclrtCreateStream")) {
            return false;
        }
        if (!CheckAcl(aclrtCreateStream(&gateStream_), "aclrtCreateStream(gate)")) {
            return false;
        }
        if (!CheckAcl(aclrtGetCurrentContext(&context_), "aclrtGetCurrentContext")) {
            return false;
        }
        if (!CheckAcl(aclrtCreateNotify(&notify_, 0), "aclrtCreateNotify")) {
            return false;
        }
        if (!CheckAcl(aclrtBinaryLoadFromFile(kKernelPath, nullptr, &binary_), "aclrtBinaryLoadFromFile")) {
            return false;
        }
        if (!CheckAcl(
                aclrtBinaryGetFunction(binary_, "launch_blocking_kernel", &function_), "aclrtBinaryGetFunction")) {
            return false;
        }

        if (!Allocate(&xDevice_, kDataSize, "x") || !Allocate(&yDevice_, kDataSize, "y") ||
            !Allocate(&zDevice_, kDataSize, "z") || !Allocate(&loopDevice_, sizeof(kLoopSpin), "loop") ||
            !Allocate(&argsDevice_, sizeof(KernelArgs), "args")) {
            return false;
        }

        const std::vector<uint16_t> xHost(kElementCount, kInputX);
        const std::vector<uint16_t> yHost(kElementCount, kInputY);
        const KernelArgs args{xDevice_, yDevice_, zDevice_, loopDevice_};
        return CopyToDevice(xDevice_, kDataSize, xHost.data(), kDataSize, "x") &&
               CopyToDevice(yDevice_, kDataSize, yHost.data(), kDataSize, "y") &&
               CopyToDevice(loopDevice_, sizeof(kLoopSpin), &kLoopSpin, sizeof(kLoopSpin), "loop") &&
               CopyToDevice(argsDevice_, sizeof(args), &args, sizeof(args), "args");
    }

    aclrtStream Stream() const { return stream_; }

    bool ResetOutput() { return CheckAcl(aclrtMemset(zDevice_, kDataSize, 0, kDataSize), "aclrtMemset"); }

    LaunchResult Launch()
    {
        const int64_t begin = NowMs();
        const aclError ret = aclrtLaunchKernel(function_, kBlockDim, argsDevice_, sizeof(KernelArgs), stream_);
        return {ret, NowMs() - begin};
    }

    bool CheckStreamStatus(aclrtStreamStatus expected, const std::string& tag)
    {
        aclrtStreamStatus actual = ACL_STREAM_STATUS_RESERVED;
        if (!CheckAcl(aclrtStreamQuery(stream_, &actual), "aclrtStreamQuery")) {
            return false;
        }
        std::cout << "[STATUS] " << tag << ": " << (actual == ACL_STREAM_STATUS_COMPLETE ? "COMPLETE" : "NOT_READY")
                  << std::endl;
        if (actual != expected) {
            std::cerr << "[ERROR] " << tag << ": unexpected stream status, expected=" << expected
                      << ", actual=" << actual << std::endl;
            return false;
        }
        return true;
    }

    bool Synchronize()
    {
        return CheckAcl(
            aclrtSynchronizeStreamWithTimeout(stream_, kSyncTimeoutMs), "aclrtSynchronizeStreamWithTimeout");
    }

    bool QueueGateWait()
    {
        return CheckAcl(aclrtWaitAndResetNotify(notify_, stream_, kSyncTimeoutMs), "aclrtWaitAndResetNotify");
    }

    aclError ReleaseGate()
    {
        aclError ret = aclrtSetCurrentContext(context_);
        if (ret != ACL_SUCCESS) {
            return ret;
        }
        ret = aclrtRecordNotify(notify_, gateStream_);
        if (ret != ACL_SUCCESS) {
            return ret;
        }
        return aclrtSynchronizeStreamWithTimeout(gateStream_, kSyncTimeoutMs);
    }

    bool VerifyOutput()
    {
        std::vector<uint16_t> output(kElementCount);
        if (!CheckAcl(
                aclrtMemcpy(output.data(), kDataSize, zDevice_, kDataSize, ACL_MEMCPY_DEVICE_TO_HOST),
                "aclrtMemcpy(output)")) {
            return false;
        }
        for (size_t i = 0; i < output.size(); ++i) {
            if (output[i] != kExpected) {
                std::cerr << "[ERROR] output[" << i << "] expected=0x" << std::hex << kExpected << ", actual=0x"
                          << output[i] << std::dec << std::endl;
                return false;
            }
        }
        return true;
    }

private:
    bool Allocate(void** address, size_t size, const char* name)
    {
        const aclError ret = aclrtMalloc(address, size, ACL_MEM_MALLOC_HUGE_FIRST);
        if (ret != ACL_SUCCESS) {
            std::cerr << "[ERROR] aclrtMalloc(" << name << ") failed, ret=" << ret << std::endl;
            return false;
        }
        return true;
    }

    bool CopyToDevice(void* dst, size_t dstSize, const void* src, size_t size, const char* name)
    {
        const aclError ret = aclrtMemcpy(dst, dstSize, src, size, ACL_MEMCPY_HOST_TO_DEVICE);
        if (ret != ACL_SUCCESS) {
            std::cerr << "[ERROR] aclrtMemcpy(" << name << ") failed, ret=" << ret << std::endl;
            return false;
        }
        return true;
    }

    void Cleanup()
    {
        if (stream_ != nullptr) {
            (void)aclrtSynchronizeStreamWithTimeout(stream_, kSyncTimeoutMs);
        }
        if (gateStream_ != nullptr) {
            (void)aclrtSynchronizeStreamWithTimeout(gateStream_, kSyncTimeoutMs);
        }
        if (binary_ != nullptr) {
            (void)aclrtBinaryUnLoad(binary_);
        }
        Free(argsDevice_);
        Free(loopDevice_);
        Free(zDevice_);
        Free(yDevice_);
        Free(xDevice_);
        if (notify_ != nullptr) {
            (void)aclrtDestroyNotify(notify_);
            notify_ = nullptr;
        }
        if (gateStream_ != nullptr) {
            (void)aclrtDestroyStream(gateStream_);
            gateStream_ = nullptr;
        }
        if (stream_ != nullptr) {
            (void)aclrtDestroyStream(stream_);
            stream_ = nullptr;
        }
        if (deviceSet_) {
            (void)aclrtResetDevice(kDeviceId);
            deviceSet_ = false;
        }
        if (aclInitialized_) {
            (void)aclFinalize();
            aclInitialized_ = false;
        }
    }

    static void Free(void*& address)
    {
        if (address != nullptr) {
            (void)aclrtFree(address);
            address = nullptr;
        }
    }

    bool aclInitialized_ = false;
    bool deviceSet_ = false;
    aclrtContext context_ = nullptr;
    aclrtStream stream_ = nullptr;
    aclrtStream gateStream_ = nullptr;
    aclrtNotify notify_ = nullptr;
    aclrtBinHandle binary_ = nullptr;
    aclrtFuncHandle function_ = nullptr;
    void* xDevice_ = nullptr;
    void* yDevice_ = nullptr;
    void* zDevice_ = nullptr;
    void* loopDevice_ = nullptr;
    void* argsDevice_ = nullptr;
};

bool SetAndCheckLaunchBlockingMode(SampleContext& context, uint32_t mode, const std::string& name)
{
    aclrtStreamAttrValue value{};
    value.launchBlockingMode = mode;
    if (!CheckAcl(
            aclrtSetStreamAttribute(context.Stream(), ACL_STREAM_LAUNCH_BLOCKING_MODE, &value),
            "aclrtSetStreamAttribute")) {
        return false;
    }

    aclrtStreamAttrValue actual{};
    if (!CheckAcl(
            aclrtGetStreamAttribute(context.Stream(), ACL_STREAM_LAUNCH_BLOCKING_MODE, &actual),
            "aclrtGetStreamAttribute")) {
        return false;
    }
    std::cout << "[MODE] " << name << ": value=" << static_cast<uint32_t>(actual.launchBlockingMode) << std::endl;
    if (actual.launchBlockingMode != mode) {
        std::cerr << "[ERROR] stream launch blocking mode mismatch" << std::endl;
        return false;
    }
    return true;
}

bool LaunchAndCheck(SampleContext& context, const std::string& tag, bool expectBlocking)
{
    if (!context.ResetOutput() || !context.QueueGateWait()) {
        return false;
    }

    aclError gateRet = ACL_SUCCESS;
    std::thread gateThread([&context, &gateRet]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(kGateDelayMs));
        gateRet = context.ReleaseGate();
    });
    const LaunchResult result = context.Launch();
    std::cout << "[LAUNCH] " << tag << ": ret=" << result.ret << ", elapsed=" << result.elapsedMs << " ms" << std::endl;

    const aclrtStreamStatus expectedStatus = expectBlocking ? ACL_STREAM_STATUS_COMPLETE : ACL_STREAM_STATUS_NOT_READY;
    const bool statusOk = result.ret == ACL_SUCCESS && context.CheckStreamStatus(expectedStatus, tag);
    gateThread.join();
    const bool gateOk = CheckAcl(gateRet, "release gate notify");
    const bool syncOk = expectBlocking || context.Synchronize();
    const bool outputOk = syncOk && context.VerifyOutput();
    if (!statusOk || !gateOk || !syncOk || !outputOk) {
        return false;
    }
    std::cout << "[PASS] " << tag << std::endl;
    return true;
}

bool RunEnvControl(SampleContext& context)
{
    const bool envEnabled = IsLaunchBlockingEnabledByEnv();
    std::cout << "[ENV] ASCEND_RT_LAUNCH_BLOCKING=" << (envEnabled ? "1" : "0") << std::endl;
    return SetAndCheckLaunchBlockingMode(context, ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV, "CTRL_BY_ENV") &&
           LaunchAndCheck(context, "environment control", envEnabled);
}

bool RunStreamMode(SampleContext& context)
{
    const bool envEnabled = IsLaunchBlockingEnabledByEnv();
    std::cout << "[ENV] ASCEND_RT_LAUNCH_BLOCKING=" << (envEnabled ? "1" : "0") << std::endl;
    return SetAndCheckLaunchBlockingMode(context, ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV, "CTRL_BY_ENV") &&
           LaunchAndCheck(context, "CTRL_BY_ENV", envEnabled) &&
           SetAndCheckLaunchBlockingMode(context, ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING, "NON_BLOCKING") &&
           LaunchAndCheck(context, "NON_BLOCKING overrides environment", false) &&
           SetAndCheckLaunchBlockingMode(context, ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING, "BLOCKING") &&
           LaunchAndCheck(context, "BLOCKING overrides environment", true) &&
           SetAndCheckLaunchBlockingMode(context, ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV, "restore CTRL_BY_ENV") &&
           LaunchAndCheck(context, "restored environment control", envEnabled);
}

bool RunNonBlockingSection(SampleContext& context)
{
    if (!IsLaunchBlockingEnabledByEnv()) {
        std::cerr << "[ERROR] non-blocking-section must run with ASCEND_RT_LAUNCH_BLOCKING=1" << std::endl;
        return false;
    }
    if (!SetAndCheckLaunchBlockingMode(context, ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV, "CTRL_BY_ENV") ||
        !context.ResetOutput() ||
        !CheckAcl(aclrtNonBlockingLaunchBegin(context.Stream(), 0), "outer aclrtNonBlockingLaunchBegin") ||
        !CheckAcl(aclrtNonBlockingLaunchBegin(context.Stream(), 0), "inner aclrtNonBlockingLaunchBegin")) {
        return false;
    }

    if (!context.QueueGateWait()) {
        (void)aclrtNonBlockingLaunchEnd(context.Stream(), 0);
        (void)aclrtNonBlockingLaunchEnd(context.Stream(), 0);
        return false;
    }
    aclError gateRet = ACL_SUCCESS;
    std::thread gateThread([&context, &gateRet]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(kGateDelayMs));
        gateRet = context.ReleaseGate();
    });

    const LaunchResult first = context.Launch();
    const LaunchResult second = context.Launch();
    std::cout << "[LAUNCH] nested section: first=" << first.elapsedMs << " ms, second=" << second.elapsedMs << " ms"
              << std::endl;
    bool passed = first.ret == ACL_SUCCESS && second.ret == ACL_SUCCESS &&
                  context.CheckStreamStatus(ACL_STREAM_STATUS_NOT_READY, "inside nested section");
    passed = CheckAcl(aclrtNonBlockingLaunchEnd(context.Stream(), 0), "inner aclrtNonBlockingLaunchEnd") && passed;
    passed = context.CheckStreamStatus(ACL_STREAM_STATUS_NOT_READY, "after inner end") && passed;

    const int64_t begin = NowMs();
    const aclError endRet = aclrtNonBlockingLaunchEnd(context.Stream(), 0);
    const int64_t elapsed = NowMs() - begin;
    std::cout << "[END] outer section: ret=" << endRet << ", elapsed=" << elapsed << " ms" << std::endl;
    gateThread.join();
    passed = CheckAcl(gateRet, "release gate notify") && passed;
    passed = endRet == ACL_SUCCESS && passed;
    passed = context.CheckStreamStatus(ACL_STREAM_STATUS_COMPLETE, "after outer end") && passed;
    passed = context.VerifyOutput() && passed;
    if (!passed) {
        return false;
    }
    std::cout << "[PASS] nested non-blocking section" << std::endl;

    return LaunchAndCheck(context, "blocking restored after outer end", true);
}
} // namespace

int main(int argc, char** argv)
{
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <env-control|stream-mode|non-blocking-section>" << std::endl;
        return 1;
    }

    SampleContext context;
    if (!context.Init()) {
        return 1;
    }

    const std::string scenario = argv[1];
    bool passed = false;
    if (scenario == "env-control") {
        passed = RunEnvControl(context);
    } else if (scenario == "stream-mode") {
        passed = RunStreamMode(context);
    } else if (scenario == "non-blocking-section") {
        passed = RunNonBlockingSection(context);
    } else {
        std::cerr << "[ERROR] unknown scenario: " << scenario << std::endl;
        return 1;
    }

    std::cout << (passed ? "[SUCCESS] " : "[FAILED] ") << scenario << std::endl;
    return passed ? 0 : 1;
}
