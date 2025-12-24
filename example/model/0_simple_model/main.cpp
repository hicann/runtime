/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */


#include <vector>
#include <iostream>
#include "utils.h"
#include "model_utils.h"
#include "acl/acl.h"
#include "aclnnop/aclnn_add.h"
#include "aclnnop/aclnn_mul.h"
using namespace std;

// aclnnadd计算：out = self + other * alpha
// aclnnmul计算: out = self * other
// 做一个model来计算： out = (self + other * alpha) * other
int main()
{
    int deviceId = 0;
    void *selfDevice = nullptr;
    void *otherDevice = nullptr;
    void *outDevice = nullptr;
    void *outTmpDevice = nullptr;
    void *selfHost = nullptr;
    void *otherHost = nullptr;
    aclTensor *self = nullptr;
    aclTensor *other = nullptr;
    aclScalar *alpha = nullptr;
    aclTensor *out = nullptr;
    aclTensor *outTmp = nullptr;
    vector<float> selfHostData = {1, 2, 3, 4, 5, 6, 7, 8};
    vector<float> otherHostData = {2, 2, 2, 2, 2, 2, 2, 2};
    vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<float> outTempHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<int64_t> shape = {4, 2};
    float alphaValue = 1.1f;
    uint64_t addWorkspaceSize = 0;
    uint64_t mulWorkspaceSize = 0;
    aclOpExecutor *addExecutor;
    aclOpExecutor *mulExecutor;
    aclrtContext context;
    const int loopCount = 4;
    int64_t size =  ModelUtils::GetShapeSize(shape) * sizeof(float);

    CHECK_ERROR(aclInit(NULL));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    // 创建tensor来执行aclnn算子，tensor与数据的device地址是绑定的
    ModelUtils::CreateAclTensor(shape, &selfDevice, aclDataType::ACL_FLOAT, &self);
    ModelUtils::CreateAclTensor(shape, &otherDevice, aclDataType::ACL_FLOAT, &other);
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    ModelUtils::CreateAclTensor(shape, &outDevice, aclDataType::ACL_FLOAT, &out);
    ModelUtils::CreateAclTensor(shape, &outTmpDevice, aclDataType::ACL_FLOAT, &outTmp);
    
    // 创建workspace来执行算子，不同算子的workspace可能不同，该处计算outTmp = self + other * alpha
    aclnnAddGetWorkspaceSize(self, other, alpha, outTmp, &addWorkspaceSize, &addExecutor);
    void *addWorkspaceAddr = nullptr;
    if (addWorkspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&addWorkspaceAddr, addWorkspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    // 该算子计算out = outTmp * other，outTmp是上一个add算子的输出。
    aclnnMulGetWorkspaceSize(outTmp, other, out, &mulWorkspaceSize, &mulExecutor);
    void *mulWorkspaceAddr = nullptr;
    if (mulWorkspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&mulWorkspaceAddr, mulWorkspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    aclmdlRI modelRI;
    aclrtStream stream;
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtMallocHost(&selfHost, size));
    CHECK_ERROR(aclrtMemcpy(selfHost, size, selfHostData.data(), size, ACL_MEMCPY_HOST_TO_HOST));
    
    // 标志着model的开始直到end。此处设置的mode为ACL_MODEL_RI_CAPTURE_MODE_GLOBAL，禁止执行非安全的函数
    // 该model执行了将内存从host复制到device侧，然后调用了一个add算子和一个mul算子
    CHECK_ERROR(aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL));
    // 异步复制为安全函数，可以再GLOBAL的mode下调用，该函数会入图。
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice, size, selfHost, size, ACL_MEMCPY_HOST_TO_DEVICE, stream));
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;
    // 可以通过该函数设置mode，此处修改为ACL_MODEL_RI_CAPTURE_MODE_RELAXED，可以执行非安全的函数
    CHECK_ERROR(aclmdlRICaptureThreadExchangeMode(&mode));
    // 同步复制为非安全函数，要设置为RELAXED，该调用不会入图，会直接执行
    CHECK_ERROR(aclrtMemcpy(otherDevice, size, otherHostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE));
    // 再次调用会回到上次设置的Mode
    CHECK_ERROR(aclmdlRICaptureThreadExchangeMode(&mode));
    // 调用aclnn算子，会入图
    aclnnAdd(addWorkspaceAddr, addWorkspaceSize, addExecutor, stream);
    aclnnMul(mulWorkspaceAddr, mulWorkspaceSize, mulExecutor, stream);
    // 标志model创建结束，且保存为modelRI,后续调用可以通过modelRI进行
    CHECK_ERROR(aclmdlRICaptureEnd(stream, &modelRI));
    // 打印信息可以在日志中查找
    const char *jsonPath = "./modelRI.json";
    CHECK_ERROR(aclmdlRIDebugJsonPrint(modelRI, jsonPath, 0));
    
    // 循环执行刚才创建的modelRI
    for (int i = 0; i < loopCount; i++) {
        INFO_LOG("execute model, loop count: %d.", i + 1);
        CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, stream));
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtMemcpy(outHostData.data(), size, outDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
        ModelUtils::PrintArray(outHostData);
    }

    // 释放资源
    CHECK_ERROR(aclmdlRIDestroy(modelRI));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclDestroyTensor(self));
    CHECK_ERROR(aclDestroyTensor(other));
    CHECK_ERROR(aclDestroyTensor(out));
    CHECK_ERROR(aclDestroyTensor(outTmp));
    CHECK_ERROR(aclDestroyScalar(alpha));
    CHECK_ERROR(aclrtFree(selfDevice));
    CHECK_ERROR(aclrtFree(otherDevice));
    CHECK_ERROR(aclrtFree(outDevice));
    CHECK_ERROR(aclrtFree(outTmpDevice));
    if (addWorkspaceAddr != nullptr) {
        CHECK_ERROR(aclrtFree(addWorkspaceAddr));
    }
    if (mulWorkspaceAddr != nullptr) {
        CHECK_ERROR(aclrtFree(mulWorkspaceAddr));
    }
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
}