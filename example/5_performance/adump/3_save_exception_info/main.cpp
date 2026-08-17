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
#include "securec.h"
#include "acl/acl.h"
#include "acl/acl_dump.h"
#include "aclnnop/aclnn_add.h"
#include "utils.h"
#include "../adump_tensor_utils.h"

using namespace std;

namespace {
// 将 shape 填充进 acldumpTensorInfo 的定长数组，并设置有效维度数
void FillTensorInfo(
    acldumpTensorInfo& info, acldumpTensorType type, void* deviceAddr, const std::vector<int64_t>& shape,
    int32_t dataType, size_t byteSize)
{
    (void)memset_s(&info, sizeof(info), 0, sizeof(info));
    info.type = type;
    info.tensorSize = byteSize;
    info.format = aclFormat::ACL_FORMAT_ND;
    info.dataType = dataType;
    info.tensorAddr = static_cast<int64_t*>(deviceAddr);
    // 本接口直接以 tensorAddr 作为 Device 上的数据地址读取数据，因此地址类型为裸地址、数据位于 Device
    info.addrType = ACL_DUMP_ADDR_RAW;
    info.placement = ACL_DUMP_PLACEMENT_DEVICE;
    info.argsOffset = 0;
    info.shapeNum = static_cast<uint32_t>(shape.size());
    info.originShapeNum = static_cast<uint32_t>(shape.size());
    for (size_t i = 0; i < shape.size() && i < ACL_DUMP_MAX_SHAPE_NUM; ++i) {
        info.shape[i] = static_cast<uint64_t>(shape[i]);
        info.originShape[i] = static_cast<uint64_t>(shape[i]);
    }
}
} // namespace

int main()
{
    // The device id
    int32_t deviceId = 0;
    // The dump configuration path (enables aic_err_brief_dump exception dump)
    const char* dumpCfgPath = "./acl.json";
    aclrtStream stream = nullptr;

    // 1. AscendCL Init（加载开启 Exception Dump 的配置）
    CHECK_ERROR(adump::InitRuntime(deviceId, &stream, dumpCfgPath));

    // 2. 查询 Exception Dump 落盘根路径（带 deviceId，自定义数据将落到此目录下）
    char excDumpPath[ACL_DUMP_MAX_FILE_PATH_LENGTH] = {0};
    if (acldumpGetExceptionInfoPath(excDumpPath, sizeof(excDumpPath)) == ACL_SUCCESS) {
        INFO_LOG("acldumpGetExceptionInfoPath success, exception dump path is: %s", excDumpPath);
    } else {
        ERROR_LOG("acldumpGetExceptionInfoPath failed, exception dump may not be enabled.");
        (void)aclrtDestroyStream(stream);
        (void)aclrtResetDeviceForce(deviceId);
        (void)aclFinalize();
        return -1;
    }

    // 3. Create input and output(Custom Construction)
    std::vector<int64_t> selfShape{4, 2};
    std::vector<int64_t> otherShape{4, 2};
    std::vector<int64_t> outShape{4, 2};
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

    float alphaValue = 1.0f;
    CHECK_ERROR(adump::CreateAclTensor(selfHostData, selfShape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    CHECK_ERROR(adump::CreateAclTensor(otherHostData, otherShape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    if (alpha == nullptr) {
        ERROR_LOG("Create alpha Scalar failed.");
        adump::DestroyTensorResources(self, other, alpha, out);
        (void)aclrtDestroyStream(stream);
        (void)aclrtResetDeviceForce(deviceId);
        (void)aclFinalize();
        return -1;
    }
    CHECK_ERROR(adump::CreateAclTensor(outHostData, outShape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    // 4. Call the CANN operator library API(Custom Implementation) —— 跑通一个正常算子
    uint64_t workspaceSize = 0;
    aclOpExecutor* executor;
    CHECK_ERROR(aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor));
    void* workspaceAddr = nullptr;
    if (workspaceSize > 0lu) {
        CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    CHECK_ERROR(aclnnAdd(workspaceAddr, workspaceSize, executor, stream));
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    // 5. 组合调用 acldumpSaveExceptionInfo，将算子的 tensor 主动落盘到 Exception Dump 路径下
    std::vector<acldumpTensorInfo> tensors(3);
    const size_t elemBytes = static_cast<size_t>(adump::GetShapeSize(selfShape)) * sizeof(float);
    FillTensorInfo(
        tensors[0], ACL_DUMP_TENSOR_INPUT, selfDeviceAddr, selfShape, static_cast<int32_t>(aclDataType::ACL_FLOAT),
        elemBytes);
    FillTensorInfo(
        tensors[1], ACL_DUMP_TENSOR_INPUT, otherDeviceAddr, otherShape, static_cast<int32_t>(aclDataType::ACL_FLOAT),
        elemBytes);
    FillTensorInfo(
        tensors[2], ACL_DUMP_TENSOR_OUTPUT, outDeviceAddr, outShape, static_cast<int32_t>(aclDataType::ACL_FLOAT),
        elemBytes);

    const char* userTag = "component=demo;stage=forward;note=save_exception_info_example";
    aclError saveRet = acldumpSaveExceptionInfo("save_exception_info", userTag, tensors.data(), tensors.size());
    if (saveRet == ACL_SUCCESS) {
        INFO_LOG("acldumpSaveExceptionInfo success, data has been saved under exception dump path: %s", excDumpPath);
    } else {
        WARN_LOG("acldumpSaveExceptionInfo failed, ret=%d. Make sure exception dump is enabled.", saveRet);
    }

    // 5. 校验算子结果
    auto size = adump::GetShapeSize(outShape);
    std::vector<float> resultData(size, 0);
    CHECK_ERROR(aclrtMemcpy(
        resultData.data(), resultData.size() * sizeof(resultData[0]), outDeviceAddr, size * sizeof(float),
        ACL_MEMCPY_DEVICE_TO_HOST));
    for (int64_t i = 0; i < size; i++) {
        INFO_LOG("result[%ld] is: %f", i, resultData[i]);
    }

    // 6. Release the resources(Custom Destruction)
    adump::DestroyTensorResources(self, other, alpha, out);
    CHECK_ERROR(aclrtFree(selfDeviceAddr));
    CHECK_ERROR(aclrtFree(otherDeviceAddr));
    CHECK_ERROR(aclrtFree(outDeviceAddr));
    if (workspaceSize > 0lu) {
        CHECK_ERROR(aclrtFree(workspaceAddr));
    }

    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the save_exception_info sample successfully.");
    return 0;
}
