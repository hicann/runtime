/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <vector>
#include "acl/acl.h"
#include "acl/acl_dump.h"
#include "aclnnop/aclnn_add.h"
#include "utils.h"

using namespace std;

namespace {
    int Init(int32_t deviceId, aclrtStream* stream, const char* configPath)
    {
        // ACL Init
        CHECK_ERROR(aclInit(configPath));
        // Open the device
        CHECK_ERROR(aclrtSetDevice(deviceId));
        // Create stream
        CHECK_ERROR(aclrtCreateStream(stream));
        return 0;
    }

    int64_t GetShapeSize(const std::vector<int64_t> &shape)
    {
        int64_t shape_size = 1;
        for (auto i : shape) {
            shape_size *= i;
        }
        return shape_size;
    }

    template <typename T>
    int CreateAclTensor(const std::vector<T> &hostData, const std::vector<int64_t> &shape, void **deviceAddr,
        aclDataType dataType, aclTensor **tensor)
    {
        auto size = GetShapeSize(shape) * sizeof(T);

        // Allocate memory on the device
        CHECK_ERROR(aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST));
        // Copy memory from host to device synchronously
        CHECK_ERROR(aclrtMemcpy(*deviceAddr, size, hostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));
        // Calculate the strides
        std::vector<int64_t> strides(shape.size(), 1);
        for (int64_t i = shape.size() - 2; i >= 0; i--) {
            strides[i] = shape[i + 1] * strides[i + 1];
        }
        // Create aclTensor
        *tensor = aclCreateTensor(shape.data(), shape.size(), dataType, strides.data(), 0,
            aclFormat::ACL_FORMAT_ND, shape.data(), shape.size(), *deviceAddr);
        return 0;
    }

    void DestroyTensorResources(aclTensor *self, aclTensor *other, aclScalar *alpha, aclTensor *out)
    {
        aclDestroyTensor(self);
        aclDestroyTensor(other);
        aclDestroyScalar(alpha);
        aclDestroyTensor(out);
    }

    int32_t DumpTensorCallback(const acldumpChunk *data, int32_t len)
    {
        if (data == nullptr) {
            ERROR_LOG("Callback data is null!");
            return -1;
        }
        if ((sizeof(acldumpChunk) + data->bufLen) != len) {
            ERROR_LOG("Callback data is invalid. bufLen: %d, callback len: %d", data->bufLen, len);
            return -1;
        }
        INFO_LOG("Receive dump tensor data success. You can use it for other purposes. data len: %d", len);
        return 0;
    }
}

int main()
{
    // The device id
    int32_t deviceId = 0;
    // The dump configuration path
    const char* dumpCfgPath = "./acl.json";
    aclrtStream stream = nullptr;

    // 1. AscendCL Init
    CHECK_ERROR(Init(deviceId, &stream, dumpCfgPath));
    // Register callback for dump tensor data
    CHECK_ERROR(acldumpRegCallback(DumpTensorCallback, 0));

    // 2. Create input and output(Custom Construction)
    std::vector<int64_t> selfShape{4, 2};
    std::vector<int64_t> otherShape{4, 2};
    std::vector<int64_t> outShape{4, 2};
    void *selfDeviceAddr = nullptr;
    void *otherDeviceAddr = nullptr;
    void *outDeviceAddr = nullptr;
    aclTensor *self = nullptr;
    aclTensor *other = nullptr;
    aclScalar *alpha = nullptr;
    aclTensor *out = nullptr;
    std::vector<float> selfHostData = {0, 1, 2, 3, 4, 5, 6, 7};
    std::vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    std::vector<float> otherHostData = {1, 1, 1, 2, 2, 2, 3, 3};

    float alphaValue = 1.0f;
    // Create self aclTensor.
    CHECK_ERROR(CreateAclTensor(selfHostData, selfShape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    // Create other aclTensor.
    CHECK_ERROR(CreateAclTensor(otherHostData, otherShape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));
    // Create alpha aclScalar.
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    if (alpha == nullptr) {
        ERROR_LOG("Create alpha Scalar failed.");
    }
    // Create out aclTensor.
    CHECK_ERROR(CreateAclTensor(outHostData, outShape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    // 3. Call the CANN operator library API(Custom Implementation)
    uint64_t workspaceSize = 0;
    aclOpExecutor *executor;
    CHECK_ERROR(aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor));

    // Allocate device memory based on the calculation results.
    void *workspaceAddr = nullptr;
    if (workspaceSize > 0lu) {
        CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    // Call the Add operator
    CHECK_ERROR(aclnnAdd(workspaceAddr, workspaceSize, executor, stream));

    // 4. Wait syschronously for the task execution to complete.
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    // 5. Obtain the execution result of the operator and copy the result from the device memory to the host
    auto size = GetShapeSize(outShape);
    std::vector<float> resultData(size, 0);
    CHECK_ERROR(aclrtMemcpy(resultData.data(), resultData.size() * sizeof(resultData[0]), outDeviceAddr,
        size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST));

    for (int64_t i = 0; i < size; i++) {
      INFO_LOG("result[%ld] is: %f ", i, resultData[i]);
    }

    // 6. Release the resources(Custom Destruction)
    // Release aclTensor and aclScalar
    DestroyTensorResources(self, other, alpha, out);
    // Release the resources on the device
    CHECK_ERROR(aclrtFree(selfDeviceAddr));
    CHECK_ERROR(aclrtFree(outDeviceAddr));
    CHECK_ERROR(aclrtFree(otherDeviceAddr));
    if (workspaceSize > 0lu) {
      CHECK_ERROR(aclrtFree(workspaceAddr));
    }
    // 7. AsendCL Destroy.
    // Unregister callback for dump tensor data.
    acldumpUnregCallback();

    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the device_normal sample successfully.");
    return 0;
}