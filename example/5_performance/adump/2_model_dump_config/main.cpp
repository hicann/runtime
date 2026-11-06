/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "../adump_tensor_utils.h"

using namespace std;

int main()
{
    const int32_t deviceId = 0;
    // Dump 配置文件，指定 dump_path、dump_op_switch 等
    const char* dumpCfgPath = "./acl.json";
    aclrtStream stream = nullptr;

    // 1. AscendCL 初始化
    CHECK_ERROR(adump::InitRuntime(deviceId, &stream));

    // 2. 加载 acl.json，使能单算子 Dump
    CHECK_ERROR(aclmdlInitDump());
    CHECK_ERROR(aclmdlSetDump(dumpCfgPath));

    // 3. 查询当前生效的 Dump 落盘路径
    const char* dumpPath = acldumpGetPath(DATA_DUMP);
    if (dumpPath != nullptr) {
        INFO_LOG("Configured model dump path is: %s", dumpPath);
    } else {
        WARN_LOG("acldumpGetPath(DATA_DUMP) returned null after aclmdlSetDump.");
    }

    // 4. 构造算子输入输出
    std::vector<int64_t> shape{4, 2};
    std::vector<float> selfHostData = {0, 1, 2, 3, 4, 5, 6, 7};
    std::vector<float> otherHostData = {1, 1, 1, 2, 2, 2, 3, 3};
    std::vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    float alphaValue = 1.0f;

    void* selfDeviceAddr = nullptr;
    void* otherDeviceAddr = nullptr;
    void* outDeviceAddr = nullptr;
    void* workspaceAddr = nullptr;
    aclTensor* self = nullptr;
    aclTensor* other = nullptr;
    aclTensor* out = nullptr;
    aclScalar* alpha = nullptr;

    CHECK_ERROR(adump::CreateAclTensor(selfHostData, shape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    CHECK_ERROR(adump::CreateAclTensor(otherHostData, shape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));
    CHECK_ERROR(adump::CreateAclTensor(outHostData, shape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    if (alpha == nullptr) {
        ERROR_LOG("Create alpha Scalar failed.");
        return -1;
    }

    // 5. 执行 Add 单算子，dump_op_switch 为 on 时 Dump 该算子的输入输出
    uint64_t workspaceSize = 0;
    aclOpExecutor* executor = nullptr;
    CHECK_ERROR(aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor));
    if (workspaceSize > 0UL) {
        CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    CHECK_ERROR(aclnnAdd(workspaceAddr, workspaceSize, executor, stream));

    // 6. 同步等待算子执行完成；Dump 文件收尾由后续 aclmdlFinalizeDump 保证
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    // 7. 拷贝回 Host 并打印执行结果
    std::vector<float> resultData(adump::GetShapeSize(shape), 0.0f);
    CHECK_ERROR(aclrtMemcpy(
        resultData.data(), resultData.size() * sizeof(float), outDeviceAddr, resultData.size() * sizeof(float),
        ACL_MEMCPY_DEVICE_TO_HOST));
    for (int64_t i = 0; i < static_cast<int64_t>(resultData.size()); ++i) {
        INFO_LOG("result[%ld] is: %f", i, resultData[i]);
    }

    // 8. 结束 Dump 配置，触发剩余数据落盘
    CHECK_ERROR(aclmdlFinalizeDump());

    // 9. 释放资源
    adump::DestroyTensorResources(self, other, alpha, out);

    if (workspaceAddr != nullptr) {
        CHECK_ERROR(aclrtFree(workspaceAddr));
    }
    CHECK_ERROR(aclrtFree(selfDeviceAddr));
    CHECK_ERROR(aclrtFree(otherDeviceAddr));
    CHECK_ERROR(aclrtFree(outDeviceAddr));

    // 10. AscendCL 去初始化
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the model dump config sample successfully.");
    return 0;
}
