/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include "acl/acl.h"
#include "aclnnop/aclnn_add.h"

#define CHECK_ERROR(ret)                                       \
    if ((ret) != ACL_SUCCESS) {                                \
        printf("Error at line %d, ret = %d\n", __LINE__, ret); \
        return -1;                                             \
    }

// 计算张量的元素总数
int64_t GetShapeSize(const std::vector<int64_t>& shape)
{
    int64_t shape_size = 1;
    for (auto i : shape) {
        shape_size *= i;
    }
    return shape_size;
}

// 创建 ACL Tensor 并分配设备内存
template <typename T>
int CreateAclTensor(
    const std::vector<T>& hostData, const std::vector<int64_t>& shape, void** deviceAddr, aclDataType dataType,
    aclTensor** tensor)
{
    auto size = GetShapeSize(shape) * sizeof(T);

    // 在设备上分配内存
    CHECK_ERROR(aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST));

    // 将数据从主机同步复制到设备
    CHECK_ERROR(aclrtMemcpy(*deviceAddr, size, hostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));

    // 计算 strides
    std::vector<int64_t> strides(shape.size(), 1);
    for (int64_t i = shape.size() - 2; i >= 0; i--) {
        strides[i] = shape[i + 1] * strides[i + 1];
    }

    // 创建 tensor
    *tensor = aclCreateTensor(
        shape.data(), shape.size(), dataType, strides.data(), 0, aclFormat::ACL_FORMAT_ND, shape.data(), shape.size(),
        *deviceAddr);
    if (*tensor == nullptr) {
        printf("Create tensor failed\n");
        return -1;
    }

    return 0;
}

// 释放 Tensor 资源
void DestroyTensorResources(aclTensor* self, aclTensor* other, aclScalar* alpha, aclTensor* out)
{
    if (self != nullptr) {
        aclDestroyTensor(self);
    }
    if (other != nullptr) {
        aclDestroyTensor(other);
    }
    if (alpha != nullptr) {
        aclDestroyScalar(alpha);
    }
    if (out != nullptr) {
        aclDestroyTensor(out);
    }
}

int main()
{
    aclError ret;

    // 初始化 ACL
    CHECK_ERROR(aclInit(NULL));
    printf("ACL init successfully\n");

    // 设置设备
    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));
    printf("Set device %d successfully\n", deviceId);

    // 创建 Stream
    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));
    printf("Create stream successfully\n");

    // 准备输入数据 - 两个向量
    // self = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
    // other = [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
    // alpha = 1.0
    // 预期结果: out = self + alpha * other = [1.5, 3.0, 4.5, 6.0, 7.5, 9.0, 10.5, 12.0]
    std::vector<int64_t> shape{8}; // 向量长度为8
    void* selfDeviceAddr = nullptr;
    void* otherDeviceAddr = nullptr;
    void* outDeviceAddr = nullptr;
    aclDataBuffer* outDataBuffer = nullptr;
    aclTensor* self = nullptr;
    aclTensor* other = nullptr;
    aclTensor* out = nullptr;
    aclScalar* alpha = nullptr;

    std::vector<float> selfHostData = {1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f};
    std::vector<float> otherHostData = {0.5f, 1.0f, 1.5f, 2.0f, 2.5f, 3.0f, 3.5f, 4.0f};
    std::vector<float> outHostData(8, 0.0f);
    float alphaValue = 1.0f;

    printf("Input vectors:\n");
    printf(
        "  self:   [%.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f]\n", selfHostData[0], selfHostData[1],
        selfHostData[2], selfHostData[3], selfHostData[4], selfHostData[5], selfHostData[6], selfHostData[7]);
    printf(
        "  other:  [%.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f, %.1f]\n", otherHostData[0], otherHostData[1],
        otherHostData[2], otherHostData[3], otherHostData[4], otherHostData[5], otherHostData[6], otherHostData[7]);
    printf("  alpha:  %.1f\n", alphaValue);

    // 创建输入 Tensor
    CHECK_ERROR(CreateAclTensor(selfHostData, shape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    CHECK_ERROR(CreateAclTensor(otherHostData, shape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));

    // 创建 alpha Scalar
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    if (alpha == nullptr) {
        printf("Create alpha Scalar failed\n");
        return -1;
    }

    // 创建输出 Tensor
    CHECK_ERROR(CreateAclTensor(outHostData, shape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    // 使用 aclDataBuffer 包装输出 Device 内存，便于后续在更复杂场景中传递 Buffer 描述信息
    outDataBuffer = aclCreateDataBuffer(outDeviceAddr, outHostData.size() * sizeof(float));
    if (outDataBuffer == nullptr) {
        printf("Create output aclDataBuffer failed\n");
        return -1;
    }
    void* outBufferAddr = aclGetDataBufferAddr(outDataBuffer);
    if (outBufferAddr == nullptr) {
        printf("Get output aclDataBuffer address failed\n");
        return -1;
    }
    printf("Create output aclDataBuffer successfully, buffer addr = %p\n", outBufferAddr);

    // 调用 aclnnAdd GetWorkspaceSize 接口
    uint64_t workspaceSize = 0;
    aclOpExecutor* executor = nullptr;
    ret = aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor);
    CHECK_ERROR(ret);
    printf("Get workspace size successfully, workspace size = %lu\n", workspaceSize);

    // 根据 workspaceSize 分配设备内存
    void* workspaceAddr = nullptr;
    if (workspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
        printf("Allocate workspace successfully\n");
    }

    // 调用 aclnnAdd 接口执行向量加法
    ret = aclnnAdd(workspaceAddr, workspaceSize, executor, stream);
    CHECK_ERROR(ret);
    printf("Launch aclnnAdd successfully\n");

    // 同步等待任务完成
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    printf("Synchronize stream successfully\n");

    // 将结果从设备复制到主机
    auto size = GetShapeSize(shape);
    std::vector<float> resultData(size, 0.0f);
    CHECK_ERROR(aclrtMemcpy(
        resultData.data(), resultData.size() * sizeof(float), outBufferAddr, size * sizeof(float),
        ACL_MEMCPY_DEVICE_TO_HOST));

    printf("\nVector addition result:\n");
    for (int64_t i = 0; i < size; i++) {
        printf(
            "  result[%ld] = %.1f (expected: %.1f)\n", i, resultData[i],
            selfHostData[i] + alphaValue * otherHostData[i]);
    }

    // 释放 Tensor 资源
    DestroyTensorResources(self, other, alpha, out);

    if (outDataBuffer != nullptr) {
        aclDestroyDataBuffer(outDataBuffer);
    }

    // 释放设备内存
    if (selfDeviceAddr != nullptr) {
        aclrtFree(selfDeviceAddr);
    }
    if (otherDeviceAddr != nullptr) {
        aclrtFree(otherDeviceAddr);
    }
    if (outDeviceAddr != nullptr) {
        aclrtFree(outDeviceAddr);
    }
    if (workspaceAddr != nullptr) {
        aclrtFree(workspaceAddr);
    }
    printf("Free device memory successfully\n");

    // 销毁 Stream
    aclrtDestroyStream(stream);
    printf("Destroy stream successfully\n");

    // 复位设备
    aclrtResetDeviceForce(deviceId);
    printf("Reset device successfully\n");

    // 去初始化 ACL
    aclFinalize();
    printf("ACL finalize successfully\n");

    printf("\nSample run successfully!\n");
    return 0;
}
