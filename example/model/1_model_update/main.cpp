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
#include "acl/acl.h"
#include "model_utils.h"
#include "aclnnop/aclnn_add.h"
using namespace std;

// aclnnadd计算：out = self + other * alpha
// 先构建一个model计算 out = (self + other * alpha) + other * alpha
// 随后更新该model为 out = (self + other * alpha) + other * updateAlpha
int main()
{
    int deviceId = 0;
    void *selfDevice = nullptr;
    void *otherDevice = nullptr;
    void *outDevice = nullptr;
    void *outTmpDevice = nullptr;
    aclTensor *self = nullptr;
    aclTensor *other = nullptr;
    aclScalar *alpha = nullptr;
    aclScalar *updateAlpha = nullptr;
    aclTensor *out = nullptr;
    aclTensor *outTmp = nullptr;
    vector<float> selfHostData = {1, 2, 3, 4, 5, 6, 7, 8};
    vector<float> otherHostData = {2, 2, 2, 2, 2, 2, 2, 2};
    vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<float> outTempHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<int64_t> shape = {4, 2};
    float alphaValue = 1.1f;
    float updateAlphaValue = 2.2f;
    uint64_t firstAddWorkspaceSize = 0;
    uint64_t secondAddWorkspaceSize = 0;
    uint64_t updateAddWorkspaceSize = 0;
    aclOpExecutor *firstAddExecutor;
    aclOpExecutor *secondAddExecutor;
    aclOpExecutor *updateAddExecutor;
    aclrtContext context;
    const int loopCount = 2;
    int64_t size = ModelUtils::GetShapeSize(shape) * sizeof(float);

    CHECK_ERROR(aclInit(NULL));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));

    ModelUtils::CreateAclTensor(shape, &selfDevice, aclDataType::ACL_FLOAT, &self);
    ModelUtils::CreateAclTensor(shape, &otherDevice, aclDataType::ACL_FLOAT, &other);
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    updateAlpha = aclCreateScalar(&updateAlphaValue, aclDataType::ACL_FLOAT);
    ModelUtils::CreateAclTensor(shape, &outDevice, aclDataType::ACL_FLOAT, &out);
    ModelUtils::CreateAclTensor(shape, &outTmpDevice, aclDataType::ACL_FLOAT, &outTmp);
    
    // 该算子计算outTmp = self + ohter * alpha
    aclnnAddGetWorkspaceSize(self, other, alpha, outTmp, &firstAddWorkspaceSize, &firstAddExecutor);
    void *firstAddWorkspaceAddr = nullptr;
    if (firstAddWorkspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&firstAddWorkspaceAddr, firstAddWorkspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    // 该算子计算outTmp = outTmp + ohter * alpha
    aclnnAddGetWorkspaceSize(outTmp, other, alpha, out, &secondAddWorkspaceSize, &secondAddExecutor);
    void *secondAddWorkspaceAddr = nullptr;
    if (secondAddWorkspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&secondAddWorkspaceAddr, secondAddWorkspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    // 该算子计算outTmp = outTmp + ohter * updateAlpha
    aclnnAddGetWorkspaceSize(outTmp, other, updateAlpha, out, &updateAddWorkspaceSize, &updateAddExecutor);
    void *updateAddWorkspaceAddr = nullptr;
    if (updateAddWorkspaceSize > 0) {
        CHECK_ERROR(aclrtMalloc(&updateAddWorkspaceAddr, updateAddWorkspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    aclmdlRI modelRI;
    aclrtStream stream;
    aclrtEvent event;
    CHECK_ERROR(aclrtCreateStream(&stream));
    // 通过event来同步，确保更新成功,该flag专门用于捕获场景下的任务更新
    CHECK_ERROR(aclrtCreateEventWithFlag(&event, ACL_EVENT_EXTERNAL));

    CHECK_ERROR(aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_RELAXED));
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice, size, selfHostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice, size, otherHostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream));
    aclnnAdd(firstAddWorkspaceAddr, firstAddWorkspaceSize, firstAddExecutor, stream);
    // 因为后续的任务为可更新的，所以在该处阻塞stream等待event，在后续更新任务中结束时记录event，可以确保后续执行的任务是更新后的
    CHECK_ERROR(aclrtStreamWaitEvent(stream, event));
    CHECK_ERROR(aclrtResetEvent(event, stream));
    aclrtTaskGrp handle;
    // 将该处的任务设置为可更新的，后续可以通过句柄handle进行更新
    CHECK_ERROR(aclmdlRICaptureTaskGrpBegin(stream));
    aclnnAdd(secondAddWorkspaceAddr, secondAddWorkspaceSize, secondAddExecutor, stream);
    CHECK_ERROR(aclmdlRICaptureTaskGrpEnd(stream, &handle));
    CHECK_ERROR(aclmdlRICaptureEnd(stream, &modelRI));

    aclrtStream updateStream;
    CHECK_ERROR(aclrtCreateStream(&updateStream));
    for (int i = 0; i < loopCount; i++) {
        INFO_LOG("Execute model, loop count: %d.", i + 1);
        CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, stream));
        if (i == 1) {
            // 通过handle对可更新区域进行更新，要注意，更新后的任务类型和数量应该与更新前保持一致
            CHECK_ERROR(aclmdlRICaptureTaskUpdateBegin(updateStream, handle));
            // 此处更换了一个算子
            aclnnAdd(updateAddWorkspaceAddr, updateAddWorkspaceSize, updateAddExecutor, updateStream);
            INFO_LOG("Update alpha value of aclnnAdd");
            CHECK_ERROR(aclmdlRICaptureTaskUpdateEnd(updateStream));
        }
        // 更新时使用event进行同步，确保在model执行任务中执行的任务是更新后的
        CHECK_ERROR(aclrtRecordEvent(event, updateStream));
        CHECK_ERROR(aclrtSynchronizeStream(updateStream));
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtMemcpy(outHostData.data(), size, outDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
        ModelUtils::PrintArray(outHostData);
    }
    // 释放计算设备的资源
    CHECK_ERROR(aclmdlRIDestroy(modelRI));
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtDestroyStream(updateStream));
    CHECK_ERROR(aclDestroyTensor(self));
    CHECK_ERROR(aclDestroyTensor(other));
    CHECK_ERROR(aclDestroyTensor(out));
    CHECK_ERROR(aclDestroyTensor(outTmp));
    CHECK_ERROR(aclDestroyScalar(alpha));
    CHECK_ERROR(aclDestroyScalar(updateAlpha));
    CHECK_ERROR(aclrtFree(selfDevice));
    CHECK_ERROR(aclrtFree(otherDevice));
    CHECK_ERROR(aclrtFree(outDevice));
    CHECK_ERROR(aclrtFree(outTmpDevice));
    if (firstAddWorkspaceAddr != nullptr) {
        CHECK_ERROR(aclrtFree(firstAddWorkspaceAddr));
    }
    if (secondAddWorkspaceAddr != nullptr) {
        CHECK_ERROR(aclrtFree(secondAddWorkspaceAddr));
    }
    if (updateAddWorkspaceAddr != nullptr) {
        CHECK_ERROR(aclrtFree(updateAddWorkspaceAddr));
    }
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
}