/**
* Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// System header
#include <vector>
#include <thread>
#include <cstring>
#include <string>

// Acl header
#include "acl/acl.h"
#include "aclnnop/aclnn_add.h"
#include "common/util_acl.h"

// MSTX header
#include "mstx/ms_tools_ext.h"

namespace {
aclrtContext context;
aclrtStream stream;
mstxDomainHandle_t domainRange;
std::string g_domainRangeName = "DoAclAdd_Inner";
int64_t GetShapeSize(const std::vector<int64_t>& shape)
{
    int64_t shapeSize = 1;
    for (auto i : shape) {
        shapeSize *= i;
    }
    return shapeSize;
}

template <typename T>
int CreateAclTensor(const std::vector<T>& hostData, const std::vector<int64_t>& shape, void** deviceAddr,
                    aclDataType dataType, aclTensor** tensor)
{
    auto size = GetShapeSize(shape) * sizeof(T);
    ACL_CALL(aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST));
    ACL_CALL(aclrtMemcpy(*deviceAddr, size, hostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));

    std::vector<int64_t> strides(shape.size(), 1);
    for (int64_t i = shape.size() - 2; i >= 0; i--) {
        strides[i] = shape[i + 1] * strides[i + 1];
    }

    // 调用aclCreateTensor接口创建aclTensor
    *tensor = aclCreateTensor(shape.data(), shape.size(), dataType, strides.data(), 0, aclFormat::ACL_FORMAT_ND,
                              shape.data(), shape.size(), *deviceAddr);
    return 0;
}

int DoAclAdd(aclrtContext context, aclrtStream stream)
{
    auto ret = ACL_SUCCESS;
    std::vector<int64_t> selfShape = {4, 2};
    std::vector<int64_t> otherShape = {4, 2};
    std::vector<int64_t> outShape = {4, 2};
    void* selfDeviceAddr = nullptr;
    void* otherDeviceAddr = nullptr;
    void* outDeviceAddr = nullptr;
    aclTensor* self = nullptr;
    aclTensor* other = nullptr;
    aclScalar* alpha = nullptr;
    aclTensor* out = nullptr;
    std::vector<float> selfHostData = {0, 1, 2, 3, 4, 5, 6, 7};
    std::vector<float> otherHostData = {1, 1, 1, 2, 2, 2, 3, 3};
    std::vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    float alphaValue = 1.2f;
    ACL_CALL(CreateAclTensor(selfHostData, selfShape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    ACL_CALL(CreateAclTensor(otherHostData, otherShape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));

    // mark with "DoAclAdd_Inner" domain
    mstxDomainMarkA(domainRange, "Create alpha aclScalar", stream);

    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    CHECK_RET(alpha != nullptr, return ret);
    ACL_CALL(CreateAclTensor(outHostData, outShape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));
    uint64_t workspaceSize = 0;
    aclOpExecutor* executor;
    ACL_CALL(aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor));
    void* workspaceAddr = nullptr;
    if (workspaceSize > 0) {
        ACL_CALL(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    ACL_CALL(aclnnAdd(workspaceAddr, workspaceSize, executor, stream));

    // range with "DoAclAdd_Inner" domain start
    uint64_t id = mstxDomainRangeStartA(domainRange, "After aclnnAdd", stream);

    ACL_CALL(aclrtSynchronizeStream(stream));
    auto size = GetShapeSize(outShape);
    std::vector<float> resultData(size, 0);
    ACL_CALL(aclrtMemcpy(resultData.data(), resultData.size() * sizeof(resultData[0]), outDeviceAddr,
                         size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST));
    for (int64_t i = 0; i < size; i++) { LOG_PRINT("result[%ld] is: %f\n", i, resultData[i]); }
    aclDestroyTensor(self);
    aclDestroyTensor(other);
    aclDestroyScalar(alpha);
    aclDestroyTensor(out);
    aclrtFree(selfDeviceAddr);
    aclrtFree(otherDeviceAddr);
    aclrtFree(outDeviceAddr);
    if (workspaceSize > 0) {
        aclrtFree(workspaceAddr);
    }

    // range with "DoAclAdd_Inner" domain end
    mstxDomainRangeEnd(domainRange, id);

    return ret;
}

static int TestMstxWithDomain()
{
    // range with "default" domain start
    uint64_t id = mstxRangeStartA("TestMstxWithDomain", stream);
    ACL_CALL(aclrtSetCurrentContext(context));
    // mark with "default" domain end
    mstxMarkA("DoAclAdd Start", stream);
    ACL_CALL(DoAclAdd(context, stream));
    // range with "default" domain end
    mstxRangeEnd(id);
    return ACL_SUCCESS;
}

void MstxDomainInit()
{
    domainRange = mstxDomainCreateA(g_domainRangeName.c_str());
}

void MstxDomainDeInit()
{
    mstxDomainDestroy(domainRange);
}
}

int main(int argc, const char **argv)
{
    int32_t deviceId = 0;
    int ret = Init(deviceId, &context, &stream);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    MstxDomainInit();
    ret = TestMstxWithDomain();
    MstxDomainDeInit();

    auto deinitRet = DeInit(deviceId, &context, &stream);
    return ret != ACL_SUCCESS ? ret : deinitRet;
}
