/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include "utils.h"
#include "acl/acl.h"

static bool CheckResult(const std::vector<int32_t>& actual, const std::vector<int32_t>& expected)
{
    for (size_t i = 0; i < actual.size(); ++i) {
        if (actual[i] != expected[i]) {
            ERROR_LOG("Check result failed at index %zu: actual=%d, expected=%d", i, actual[i], expected[i]);
            return false;
        }
    }
    INFO_LOG("Check result success.");
    return true;
}

static int Scenario1StreamRecordGraphWaitExternal()
{
    INFO_LOG("=== Scenario 1: Stream Record + Graph Wait External ===");

    const int64_t elementCount = 8;
    const int64_t size = elementCount * sizeof(int32_t);
    std::vector<int32_t> hostSrc = {1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<int32_t> hostDst(elementCount, 0);

    aclrtStream graphStream;
    aclrtStream externalStream;
    CHECK_ERROR(aclrtCreateStream(&graphStream));
    CHECK_ERROR(aclrtCreateStream(&externalStream));

    aclrtEvent event;
    CHECK_ERROR(aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC));

    void* srcDevice = nullptr;
    void* dstDevice = nullptr;
    CHECK_ERROR(aclrtMalloc(&srcDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&dstDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));

    aclmdlRI modelRI;

    CHECK_ERROR(aclmdlRICaptureBegin(graphStream, ACL_MODEL_RI_CAPTURE_MODE_RELAXED));
    CHECK_ERROR(aclrtStreamWaitEventWithFlag(graphStream, event, 0U, ACL_EVENT_WAIT_EXTERNAL));
    CHECK_ERROR(aclrtMemcpyAsync(dstDevice, size, srcDevice, size, ACL_MEMCPY_DEVICE_TO_DEVICE, graphStream));
    CHECK_ERROR(aclmdlRICaptureEnd(graphStream, &modelRI));

    CHECK_ERROR(aclrtMemcpy(srcDevice, size, hostSrc.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtRecordEvent(event, externalStream));

    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, graphStream));
    CHECK_ERROR(aclrtSynchronizeStream(graphStream));

    CHECK_ERROR(aclrtMemcpy(hostDst.data(), size, dstDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    if (!CheckResult(hostDst, hostSrc)) {
        return -1;
    }

    CHECK_ERROR(aclmdlRIDestroy(modelRI));
    CHECK_ERROR(aclrtDestroyEvent(event));
    CHECK_ERROR(aclrtFree(srcDevice));
    CHECK_ERROR(aclrtFree(dstDevice));
    CHECK_ERROR(aclrtDestroyStream(graphStream));
    CHECK_ERROR(aclrtDestroyStream(externalStream));
    return 0;
}

static int Scenario2GraphRecordExternalStreamWait()
{
    INFO_LOG("=== Scenario 2: Graph Record External + Stream Wait ===");

    const int64_t elementCount = 8;
    const int64_t size = elementCount * sizeof(int32_t);
    std::vector<int32_t> hostSrc = {1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<int32_t> hostDst(elementCount, 0);

    aclrtStream graphStream;
    aclrtStream externalStream;
    CHECK_ERROR(aclrtCreateStream(&graphStream));
    CHECK_ERROR(aclrtCreateStream(&externalStream));

    aclrtEvent event;
    CHECK_ERROR(aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC));

    void* srcDevice = nullptr;
    void* dstDevice = nullptr;
    CHECK_ERROR(aclrtMalloc(&srcDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&dstDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));

    aclmdlRI modelRI;

    CHECK_ERROR(aclrtMemcpy(srcDevice, size, hostSrc.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));

    CHECK_ERROR(aclmdlRICaptureBegin(graphStream, ACL_MODEL_RI_CAPTURE_MODE_RELAXED));
    CHECK_ERROR(aclrtMemcpyAsync(dstDevice, size, srcDevice, size, ACL_MEMCPY_DEVICE_TO_DEVICE, graphStream));
    CHECK_ERROR(aclrtRecordEventWithFlag(event, graphStream, ACL_EVENT_RECORD_EXTERNAL));
    CHECK_ERROR(aclmdlRICaptureEnd(graphStream, &modelRI));

    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, graphStream));

    CHECK_ERROR(aclrtStreamWaitEvent(externalStream, event));
    CHECK_ERROR(aclrtMemcpyAsync(hostDst.data(), size, dstDevice, size, ACL_MEMCPY_DEVICE_TO_HOST, externalStream));
    CHECK_ERROR(aclrtSynchronizeStream(externalStream));

    if (!CheckResult(hostDst, hostSrc)) {
        return -1;
    }

    CHECK_ERROR(aclmdlRIDestroy(modelRI));
    CHECK_ERROR(aclrtDestroyEvent(event));
    CHECK_ERROR(aclrtFree(srcDevice));
    CHECK_ERROR(aclrtFree(dstDevice));
    CHECK_ERROR(aclrtDestroyStream(graphStream));
    CHECK_ERROR(aclrtDestroyStream(externalStream));
    return 0;
}

static int Scenario3Graph1RecordGraph2WaitExternal()
{
    INFO_LOG("=== Scenario 3: Graph1 Record External + Graph2 Wait External ===");

    const int64_t elementCount = 8;
    const int64_t size = elementCount * sizeof(int32_t);
    std::vector<int32_t> hostSrc = {1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<int32_t> hostDst(elementCount, 0);

    aclrtStream graphStream1;
    aclrtStream graphStream2;
    CHECK_ERROR(aclrtCreateStream(&graphStream1));
    CHECK_ERROR(aclrtCreateStream(&graphStream2));

    aclrtEvent event;
    CHECK_ERROR(aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC));

    void* srcDevice = nullptr;
    void* midDevice = nullptr;
    void* dstDevice = nullptr;
    CHECK_ERROR(aclrtMalloc(&srcDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&midDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&dstDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));

    aclmdlRI modelRI1;
    aclmdlRI modelRI2;

    CHECK_ERROR(aclrtMemcpy(srcDevice, size, hostSrc.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));

    CHECK_ERROR(aclmdlRICaptureBegin(graphStream1, ACL_MODEL_RI_CAPTURE_MODE_RELAXED));
    CHECK_ERROR(aclrtMemcpyAsync(midDevice, size, srcDevice, size, ACL_MEMCPY_DEVICE_TO_DEVICE, graphStream1));
    CHECK_ERROR(aclrtRecordEventWithFlag(event, graphStream1, ACL_EVENT_RECORD_EXTERNAL));
    CHECK_ERROR(aclmdlRICaptureEnd(graphStream1, &modelRI1));

    CHECK_ERROR(aclmdlRICaptureBegin(graphStream2, ACL_MODEL_RI_CAPTURE_MODE_RELAXED));
    CHECK_ERROR(aclrtStreamWaitEventWithFlag(graphStream2, event, 0U, ACL_EVENT_WAIT_EXTERNAL));
    CHECK_ERROR(aclrtMemcpyAsync(dstDevice, size, midDevice, size, ACL_MEMCPY_DEVICE_TO_DEVICE, graphStream2));
    CHECK_ERROR(aclmdlRICaptureEnd(graphStream2, &modelRI2));

    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI1, graphStream1));
    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI2, graphStream2));
    CHECK_ERROR(aclrtSynchronizeStream(graphStream2));

    CHECK_ERROR(aclrtMemcpy(hostDst.data(), size, dstDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    if (!CheckResult(hostDst, hostSrc)) {
        return -1;
    }

    CHECK_ERROR(aclmdlRIDestroy(modelRI1));
    CHECK_ERROR(aclmdlRIDestroy(modelRI2));
    CHECK_ERROR(aclrtDestroyEvent(event));
    CHECK_ERROR(aclrtFree(srcDevice));
    CHECK_ERROR(aclrtFree(midDevice));
    CHECK_ERROR(aclrtFree(dstDevice));
    CHECK_ERROR(aclrtDestroyStream(graphStream1));
    CHECK_ERROR(aclrtDestroyStream(graphStream2));
    return 0;
}

int main()
{
    CHECK_ERROR(aclInit(NULL));
    CHECK_ERROR(aclrtSetDevice(0));
    aclrtContext context;
    CHECK_ERROR(aclrtCreateContext(&context, 0));

    CHECK_ERROR(Scenario1StreamRecordGraphWaitExternal());
    CHECK_ERROR(Scenario2GraphRecordExternalStreamWait());
    CHECK_ERROR(Scenario3Graph1RecordGraph2WaitExternal());

    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(0));
    CHECK_ERROR(aclFinalize());
    return 0;
}
