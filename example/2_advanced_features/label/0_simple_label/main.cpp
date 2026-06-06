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
#include "acl/acl.h"
#include "utils.h"

namespace {
void UpdateFinalResultOnError(const char *apiName, aclError ret, int32_t &finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}
} // namespace

int main()
{
    const int32_t deviceId = 0;
    const uint32_t branchIndex = 1;
    const uint32_t labelCount = 2;
    const uint32_t headStreamFlag = 0x00000000U;

    aclrtContext context = nullptr;
    aclrtStream labelStream = nullptr;
    aclrtStream executeStream = nullptr;
    aclrtLabel labels[labelCount] = {nullptr, nullptr};
    aclrtLabelList labelList = nullptr;
    uint32_t *branchIndexDevice = nullptr;
    aclmdlRI modelRI = nullptr;

    bool aclInitialized = false;
    bool deviceSet = false;
    bool contextCreated = false;
    bool labelStreamCreated = false;
    bool executeStreamCreated = false;
    bool branchIndexAllocated = false;
    bool labelCreated[labelCount] = {false, false};
    bool labelListCreated = false;
    bool modelRICreated = false;
    bool labelStreamBound = false;

    const int32_t result = [&]() -> int32_t {
        // Initialize ACL and bind runtime resources to device 0.
        CHECK_ERROR(aclInit(nullptr));
        aclInitialized = true;
        INFO_LOG("ACL initialized.");

        CHECK_ERROR(aclrtSetDevice(deviceId));
        deviceSet = true;
        INFO_LOG("Device %d selected.", deviceId);

        CHECK_ERROR(aclrtCreateContext(&context, deviceId));
        contextCreated = true;
        INFO_LOG("Context created on device %d.", deviceId);

        CHECK_ERROR(aclrtCreateStreamWithConfig(&labelStream, 0x00U, ACL_STREAM_PERSISTENT));
        labelStreamCreated = true;
        INFO_LOG("Persistent label stream created.");

        CHECK_ERROR(aclrtCreateStream(&executeStream));
        executeStreamCreated = true;
        INFO_LOG("Execute stream created.");

        // Build a model runtime instance and bind the persistent stream for label tasks.
        CHECK_ERROR(aclmdlRIBuildBegin(&modelRI, 0x00U));
        modelRICreated = true;
        INFO_LOG("Model runtime instance build started.");

        CHECK_ERROR(aclmdlRIBindStream(modelRI, labelStream, headStreamFlag));
        labelStreamBound = true;
        INFO_LOG("Persistent label stream bound to the model runtime instance.");

        // Prepare the branch index on device memory.
        CHECK_ERROR(
            aclrtMalloc(reinterpret_cast<void **>(&branchIndexDevice), sizeof(branchIndex), ACL_MEM_MALLOC_HUGE_FIRST));
        branchIndexAllocated = true;
        INFO_LOG("Allocated device memory for branch index.");

        CHECK_ERROR(aclrtMemcpy(
            branchIndexDevice,
            sizeof(branchIndex),
            &branchIndex,
            sizeof(branchIndex),
            ACL_MEMCPY_HOST_TO_DEVICE));
        INFO_LOG("Copied branch index %u from host to device.", branchIndex);

        // Create labels and organize them as a label list.
        for (uint32_t index = 0; index < labelCount; ++index) {
            CHECK_ERROR(aclrtCreateLabel(&labels[index]));
            labelCreated[index] = true;
            INFO_LOG("Created label %u.", index);
        }

        CHECK_ERROR(aclrtCreateLabelList(labels, labelCount, &labelList));
        labelListCreated = true;
        INFO_LOG("Created label list with %u labels.", labelCount);

        // Record the control-flow tasks on the modelRI-bound persistent stream.
        CHECK_ERROR(aclrtSwitchLabelByIndex(branchIndexDevice, labelCount, labelList, labelStream));
        INFO_LOG("Submitted switch-label task with branch index %u.", branchIndex);

        for (uint32_t index = 0; index < labelCount; ++index) {
            CHECK_ERROR(aclrtSetLabel(labels[index], labelStream));
            INFO_LOG("Set label %u on the persistent stream.", index);
        }

        CHECK_ERROR(aclmdlRIEndTask(modelRI, labelStream));
        CHECK_ERROR(aclmdlRIBuildEnd(modelRI, nullptr));
        INFO_LOG("Model runtime instance build finished.");

        // Execute the model runtime instance and wait for completion.
        CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, executeStream));
        CHECK_ERROR(aclrtSynchronizeStream(executeStream));
        INFO_LOG("Switch label executed successfully with branch index %u.", branchIndex);
        return 0;
    }();

    int32_t finalResult = result;
    if (labelStreamBound) {
        UpdateFinalResultOnError(
            "aclmdlRIUnbindStream(modelRI, labelStream)", aclmdlRIUnbindStream(modelRI, labelStream), finalResult);
    }
    if (modelRICreated) {
        UpdateFinalResultOnError("aclmdlRIDestroy(modelRI)", aclmdlRIDestroy(modelRI), finalResult);
    }
    if (labelListCreated) {
        UpdateFinalResultOnError("aclrtDestroyLabelList(labelList)", aclrtDestroyLabelList(labelList), finalResult);
    }
    if (labelCreated[1]) {
        UpdateFinalResultOnError("aclrtDestroyLabel(labels[1])", aclrtDestroyLabel(labels[1]), finalResult);
    }
    if (labelCreated[0]) {
        UpdateFinalResultOnError("aclrtDestroyLabel(labels[0])", aclrtDestroyLabel(labels[0]), finalResult);
    }
    if (branchIndexAllocated) {
        UpdateFinalResultOnError("aclrtFree(branchIndexDevice)", aclrtFree(branchIndexDevice), finalResult);
    }
    if (executeStreamCreated) {
        UpdateFinalResultOnError("aclrtDestroyStream(executeStream)", aclrtDestroyStream(executeStream), finalResult);
    }
    if (labelStreamCreated) {
        UpdateFinalResultOnError("aclrtDestroyStream(labelStream)", aclrtDestroyStream(labelStream), finalResult);
    }
    if (contextCreated) {
        UpdateFinalResultOnError("aclrtDestroyContext(context)", aclrtDestroyContext(context), finalResult);
    }
    if (deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce(deviceId)", aclrtResetDeviceForce(deviceId), finalResult);
    }
    if (aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
    if (finalResult == 0) {
        INFO_LOG("Run the simple_label sample successfully.");
    }
    return finalResult;
}
