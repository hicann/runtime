/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include "utils.h"
#include "acl/acl.h"
#include "kernel_func/kernel_ops.h"

namespace {
void StreamStateCallback(aclrtStream stream, aclrtStreamState state, void* args)
{
    const char* sampleName = args == nullptr ? "stream_failure_mode" : static_cast<const char*>(args);
    INFO_LOG("Stream state callback from %s: stream=%p state=%d", sampleName, stream, static_cast<int32_t>(state));
}

void LogOptionalResult(const char* apiName, aclError ret)
{
    if (ret == ACL_SUCCESS) {
        INFO_LOG("%s returned %d.", apiName, static_cast<int32_t>(ret));
    } else {
        WARN_LOG("%s returned %d.", apiName, static_cast<int32_t>(ret));
    }
}

void LogAbortSyncResult(aclError ret)
{
    if (ret == ACL_SUCCESS) {
        INFO_LOG("aclrtSynchronizeStream(after abort) returned %d.", static_cast<int32_t>(ret));
    } else {
        INFO_LOG(
            "aclrtSynchronizeStream(after abort) returned %d after stream abort, which is expected.",
            static_cast<int32_t>(ret));
    }
}

void FreeOptionalBuffer(uint32_t* buffer, const char* name)
{
    if (buffer != nullptr) {
        LogOptionalResult(name, aclrtFree(buffer));
    }
}

void DestroyOptionalStream(aclrtStream stream, const char* name)
{
    if (stream != nullptr) {
        LogOptionalResult(name, aclrtDestroyStreamForce(stream));
    }
}

bool PrepareScratchBuffer(uint32_t** scratch, size_t size, const char* demoName)
{
    aclError ret = aclrtMalloc(reinterpret_cast<void**>(scratch), size, ACL_MEM_MALLOC_HUGE_FIRST);
    if (ret != ACL_SUCCESS) {
        WARN_LOG("Skip %s demo: aclrtMalloc returned %d.", demoName, static_cast<int32_t>(ret));
        return false;
    }

    uint32_t zero = 0;
    ret = aclrtMemcpy(*scratch, size, &zero, size, ACL_MEMCPY_HOST_TO_DEVICE);
    if (ret != ACL_SUCCESS) {
        WARN_LOG("Skip %s demo: aclrtMemcpy returned %d.", demoName, static_cast<int32_t>(ret));
        LogOptionalResult("aclrtFree(scratch)", aclrtFree(*scratch));
        *scratch = nullptr;
        return false;
    }
    return true;
}

void DemonstrateStreamStop()
{
    constexpr size_t kScratchSize = sizeof(uint32_t);
    constexpr uint32_t kBlockDim = 1;
    aclrtStream stopStream = nullptr;
    uint32_t* stopScratch = nullptr;

    aclError ret = aclrtCreateStreamWithConfig(&stopStream, 0, ACL_STREAM_DEVICE_USE_ONLY);
    if (ret != ACL_SUCCESS) {
        WARN_LOG("Skip aclrtStreamStop demo: aclrtCreateStreamWithConfig returned %d.", static_cast<int32_t>(ret));
        return;
    }
    if (!PrepareScratchBuffer(&stopScratch, kScratchSize, "aclrtStreamStop")) {
        DestroyOptionalStream(stopStream, "aclrtDestroyStreamForce(stopStream)");
        return;
    }

    INFO_LOG("Launching a long task on the device-use-only stream before aclrtStreamStop.");
    LongOP(kBlockDim, stopStream, stopScratch);
    LogOptionalResult("aclrtStreamStop", aclrtStreamStop(stopStream));
    LogOptionalResult("aclrtSynchronizeStream(after stop)", aclrtSynchronizeStream(stopStream));

    FreeOptionalBuffer(stopScratch, "aclrtFree(stopScratch)");
    DestroyOptionalStream(stopStream, "aclrtDestroyStreamForce(stopStream)");
}

void DemonstrateStreamAbort()
{
    constexpr size_t kScratchSize = sizeof(uint32_t);
    constexpr uint32_t kBlockDim = 1;
    aclrtStream abortStream = nullptr;
    uint32_t* abortScratch = nullptr;

    aclError ret = aclrtCreateStream(&abortStream);
    if (ret != ACL_SUCCESS) {
        WARN_LOG("Skip aclrtStreamAbort demo: aclrtCreateStream returned %d.", static_cast<int32_t>(ret));
        return;
    }
    if (!PrepareScratchBuffer(&abortScratch, kScratchSize, "aclrtStreamAbort")) {
        DestroyOptionalStream(abortStream, "aclrtDestroyStreamForce(abortStream)");
        return;
    }

    INFO_LOG("Launching a long task on the regular stream before aclrtStreamAbort.");
    LongOP(kBlockDim, abortStream, abortScratch);
    LogOptionalResult("aclrtStreamAbort", aclrtStreamAbort(abortStream));
    LogAbortSyncResult(aclrtSynchronizeStream(abortStream));

    FreeOptionalBuffer(abortScratch, "aclrtFree(abortScratch)");
    DestroyOptionalStream(abortStream, "aclrtDestroyStreamForce(abortStream)");
}

int DemonstrateStopAndAbort()
{
    DemonstrateStreamStop();
    DemonstrateStreamAbort();
    return 0;
}
} // namespace

int main()
{
    setvbuf(stdout, nullptr, _IOLBF, BUFSIZ);
    const int32_t deviceId = 0;
    const uint32_t blockDim = 1;
    uint32_t num = 0;
    uint32_t* numDevice = nullptr;
    const size_t size = sizeof(uint32_t);
    aclrtStream stream = nullptr;
    aclrtContext context = nullptr;
    char callbackTag[] = "stream_failure_mode_sample";

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtRegStreamStateCallback("stream_failure_mode_sample", StreamStateCallback, callbackTag));

    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&numDevice), size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));

    INFO_LOG("Assigning task without failure mode.");
    EasyOP(blockDim, stream, numDevice);
    ErrorOP(blockDim, stream);
    EasyOP(blockDim, stream, numDevice);
    CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("Without failure mode, the result is %d.", num);

    num = 0;
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE));
    INFO_LOG("Assigning task with failure mode.");
    EasyOP(blockDim, stream, numDevice);
    ErrorOP(blockDim, stream);
    EasyOP(blockDim, stream, numDevice);
    CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After set failure mode, the current result is: %d.", num);

    CHECK_ERROR(DemonstrateStopAndAbort());

    CHECK_ERROR(aclrtFree(numDevice));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtRegStreamStateCallback("stream_failure_mode_sample", nullptr, nullptr));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    aclFinalize();
    INFO_LOG("Resource cleanup completed.");
    INFO_LOG("Run the stream_with_failure_mode sample successfully.");
    return 0;
}
