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
#include "aclnnop/aclnn_add.h"
#include "utils.h"

namespace {
    int Init(int32_t deviceId, aclrtStream* stream) 
    {
        CHECK_ERROR(aclInit(nullptr));
        CHECK_ERROR(aclrtSetDevice(deviceId));
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

        // Create the tensor
        *tensor = aclCreateTensor(shape.data(), shape.size(), dataType, strides.data(), 0, aclFormat::ACL_FORMAT_ND,
            shape.data(), shape.size(), *deviceAddr);
        return 0;
    }

    void DestroyTensorResources(aclTensor *self, aclTensor *other, aclScalar *alpha, aclTensor *out)
    {
        aclDestroyTensor(self);
        aclDestroyTensor(other);
        aclDestroyScalar(alpha);
        aclDestroyTensor(out);
    }
} // namespace

int32_t main(int argc, char const *argv[])
{
    INFO_LOG("Start to run device_normal sample.");
    int32_t deviceId = 0;
    aclrtStream stream = nullptr;
    Init(deviceId, &stream);

    std::vector<int64_t> selfShape{4, 2}, otherShape{4, 2}, outShape{4, 2};
    void *selfDeviceAddr = nullptr, *otherDeviceAddr = nullptr, *outDeviceAddr = nullptr;
    aclTensor *self = nullptr, *other = nullptr, *out = nullptr;
    aclScalar *alpha = nullptr;
    std::vector<float> selfHostData = {0, 1, 2, 3, 4, 5, 6, 7};
    std::vector<float> otherHostData = {1, 1, 1, 2, 2, 2, 3, 3};
    std::vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    float alphaValue = 1.2f;

    CHECK_ERROR(CreateAclTensor(selfHostData, selfShape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    CHECK_ERROR(CreateAclTensor(otherHostData, otherShape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));

    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    if (alpha == nullptr) {
      ERROR_LOG("Create alpha Scalar failed.");
    }

    CHECK_ERROR(CreateAclTensor(outHostData, outShape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    // Call the CANN operator library API
    uint64_t workspaceSize = 0;
    aclOpExecutor *executor;
    CHECK_ERROR(aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor));

    // Allocate device memory based on the calculation results
    void *workspaceAddr = nullptr;
    if (workspaceSize > 0lu) {
      CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    // Call the Add operator
    CHECK_ERROR(aclnnAdd(workspaceAddr, workspaceSize, executor, stream));

    // Wait syschronously for the task execution to complete
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    // Obtain the execution result of the operator and copy the result from the device memory to the host
    auto size = GetShapeSize(outShape);
    std::vector<float> resultData(size, 0);
    CHECK_ERROR(aclrtMemcpy(resultData.data(), resultData.size() * sizeof(resultData[0]), outDeviceAddr, 
        size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST));

    for (int64_t i = 0; i < size; i++) {
      INFO_LOG("result[%ld] is: %f", i, resultData[i]);
    }

    CHECK_ERROR(aclrtSynchronizeDevice());

    DestroyTensorResources(self, other, alpha, out);

    // Release the resources on the device
    CHECK_ERROR(aclrtFree(selfDeviceAddr));
    CHECK_ERROR(aclrtFree(otherDeviceAddr));
    CHECK_ERROR(aclrtFree(outDeviceAddr));
    if (workspaceSize > 0lu) {
      CHECK_ERROR(aclrtFree(workspaceAddr));
    }
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the device_normal sample successfully.");

    return 0;
}