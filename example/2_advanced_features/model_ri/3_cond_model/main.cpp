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
#include "utils.h"
#include "acl/acl.h"
#include "model_utils.h"
#include "aclnnop/aclnn_add.h"

using namespace std;

namespace {
constexpr int32_t kDeviceId = 0;
constexpr int64_t kElementCount = 8;
const vector<int64_t> kShape = {4, 2};
const vector<float> kSrcAHost = {1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f};
const vector<float> kSrcBHost = {0.5f, 1.0f, 1.5f, 2.0f, 2.5f, 3.0f, 3.5f, 4.0f};
const int64_t kSize = kElementCount * sizeof(float);
} // namespace

int32_t TestCondIf()
{
    INFO_LOG("========== IF condition ==========");
    aclrtStream stream = nullptr;
    aclrtStream subStream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtCreateStream(&subStream));

    void* srcADev = nullptr;
    void* srcBDev = nullptr;
    void* dstDev = nullptr;
    aclTensor* srcA = nullptr;
    aclTensor* srcB = nullptr;
    aclTensor* dst = nullptr;
    ModelUtils::CreateAclTensor(kShape, &srcADev, aclDataType::ACL_FLOAT, &srcA);
    ModelUtils::CreateAclTensor(kShape, &srcBDev, aclDataType::ACL_FLOAT, &srcB);
    ModelUtils::CreateAclTensor(kShape, &dstDev, aclDataType::ACL_FLOAT, &dst);

    CHECK_ERROR(aclrtMemcpy(srcADev, kSize, kSrcAHost.data(), kSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(srcBDev, kSize, kSrcBHost.data(), kSize, ACL_MEMCPY_HOST_TO_DEVICE));

    float alphaTrue = 2.0f;
    float alphaFalse = 0.5f;
    aclScalar* scalarTrue = aclCreateScalar(&alphaTrue, aclDataType::ACL_FLOAT);
    aclScalar* scalarFalse = aclCreateScalar(&alphaFalse, aclDataType::ACL_FLOAT);

    uint64_t addWsSize0 = 0;
    uint64_t addWsSize1 = 0;
    aclOpExecutor* addExecutor0 = nullptr;
    aclOpExecutor* addExecutor1 = nullptr;
    aclnnAddGetWorkspaceSize(srcA, srcB, scalarTrue, dst, &addWsSize0, &addExecutor0);
    aclnnAddGetWorkspaceSize(srcA, srcB, scalarFalse, dst, &addWsSize1, &addExecutor1);
    void* wsAddr0 = nullptr;
    if (addWsSize0 > 0) {
        CHECK_ERROR(aclrtMalloc(&wsAddr0, addWsSize0, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    void* wsAddr1 = nullptr;
    if (addWsSize1 > 0) {
        CHECK_ERROR(aclrtMalloc(&wsAddr1, addWsSize1, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    CHECK_ERROR(aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
    aclmdlRICaptureStatus status = ACL_MODEL_RI_CAPTURE_STATUS_NONE;
    aclmdlRI parentModelRI = nullptr;
    CHECK_ERROR(aclmdlRICaptureGetInfo(stream, &status, &parentModelRI));

    aclmdlRICondHandle condHandle = nullptr;
    CHECK_ERROR(aclmdlRICondHandleCreate(parentModelRI, 0, ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT, &condHandle));
    uint64_t* condDevPtr = nullptr;
    CHECK_ERROR(aclmdlRICondHandleGetCondPtr(condHandle, &condDevPtr));

    aclmdlRI subModels[2] = {};
    aclmdlRICondTaskParams params;
    params.handle = condHandle;
    params.type = ACL_MODEL_RI_COND_TYPE_IF;
    params.size = 2;
    params.modelRIArray = subModels;
    CHECK_ERROR(aclmdlRIAddCondTask(params, stream, 0));

    CHECK_ERROR(aclmdlRICaptureToModelRIBegin(subStream, subModels[0], ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
    aclnnAdd(wsAddr0, addWsSize0, addExecutor0, subStream);
    CHECK_ERROR(aclmdlRICaptureEnd(subStream, &subModels[0]));

    CHECK_ERROR(aclmdlRICaptureToModelRIBegin(subStream, subModels[1], ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
    aclnnAdd(wsAddr1, addWsSize1, addExecutor1, subStream);
    CHECK_ERROR(aclmdlRICaptureEnd(subStream, &subModels[1]));

    CHECK_ERROR(aclmdlRICaptureEnd(stream, &parentModelRI));

    vector<float> outHost(kElementCount, 0.0f);
    aclrtStream execStream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&execStream));

    static const uint64_t kCondTrue = 1;
    CHECK_ERROR(aclrtMemcpy(condDevPtr, sizeof(uint64_t), &kCondTrue, sizeof(uint64_t), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclmdlRIExecuteAsync(parentModelRI, execStream));
    CHECK_ERROR(aclrtSynchronizeStream(execStream));
    CHECK_ERROR(aclrtMemcpy(outHost.data(), kSize, dstDev, kSize, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("IF true branch result:");
    ModelUtils::PrintArray(outHost);

    static const uint64_t kCondFalse = 0;
    CHECK_ERROR(aclrtMemcpy(condDevPtr, sizeof(uint64_t), &kCondFalse, sizeof(uint64_t), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclmdlRIExecuteAsync(parentModelRI, execStream));
    CHECK_ERROR(aclrtSynchronizeStream(execStream));
    CHECK_ERROR(aclrtMemcpy(outHost.data(), kSize, dstDev, kSize, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("IF false branch result:");
    ModelUtils::PrintArray(outHost);

    CHECK_ERROR(aclmdlRIDestroy(parentModelRI));
    CHECK_ERROR(aclrtDestroyStream(subStream));
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtDestroyStream(execStream));
    CHECK_ERROR(aclDestroyTensor(srcA));
    CHECK_ERROR(aclDestroyTensor(srcB));
    CHECK_ERROR(aclDestroyTensor(dst));
    CHECK_ERROR(aclDestroyScalar(scalarTrue));
    CHECK_ERROR(aclDestroyScalar(scalarFalse));
    CHECK_ERROR(aclrtFree(srcADev));
    CHECK_ERROR(aclrtFree(srcBDev));
    CHECK_ERROR(aclrtFree(dstDev));
    if (wsAddr0 != nullptr) {
        CHECK_ERROR(aclrtFree(wsAddr0));
    }
    if (wsAddr1 != nullptr) {
        CHECK_ERROR(aclrtFree(wsAddr1));
    }
    INFO_LOG("IF condition PASSED");
    return 0;
}

int32_t TestCondWhile()
{
    INFO_LOG("========== WHILE condition ==========");
    aclrtStream stream = nullptr;
    aclrtStream subStream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtCreateStream(&subStream));

    void* srcADev = nullptr;
    void* srcBDev = nullptr;
    void* dstDev = nullptr;
    aclTensor* srcA = nullptr;
    aclTensor* srcB = nullptr;
    aclTensor* dst = nullptr;
    ModelUtils::CreateAclTensor(kShape, &srcADev, aclDataType::ACL_FLOAT, &srcA);
    ModelUtils::CreateAclTensor(kShape, &srcBDev, aclDataType::ACL_FLOAT, &srcB);
    ModelUtils::CreateAclTensor(kShape, &dstDev, aclDataType::ACL_FLOAT, &dst);

    CHECK_ERROR(aclrtMemcpy(srcADev, kSize, kSrcAHost.data(), kSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(srcBDev, kSize, kSrcBHost.data(), kSize, ACL_MEMCPY_HOST_TO_DEVICE));

    float alpha = 1.0f;
    aclScalar* scalarAlpha = aclCreateScalar(&alpha, aclDataType::ACL_FLOAT);
    uint64_t addWsSize = 0;
    aclOpExecutor* addExecutor = nullptr;
    aclnnAddGetWorkspaceSize(srcA, srcB, scalarAlpha, dst, &addWsSize, &addExecutor);
    void* wsAddr = nullptr;
    if (addWsSize > 0) {
        CHECK_ERROR(aclrtMalloc(&wsAddr, addWsSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    static const uint64_t kCondZero = 0;
    void* condZeroDev = nullptr;
    CHECK_ERROR(aclrtMalloc(&condZeroDev, sizeof(uint64_t), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(condZeroDev, sizeof(uint64_t), &kCondZero, sizeof(uint64_t), ACL_MEMCPY_HOST_TO_DEVICE));

    CHECK_ERROR(aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
    aclmdlRICaptureStatus status = ACL_MODEL_RI_CAPTURE_STATUS_NONE;
    aclmdlRI parentModelRI = nullptr;
    CHECK_ERROR(aclmdlRICaptureGetInfo(stream, &status, &parentModelRI));

    aclmdlRICondHandle condHandle = nullptr;
    CHECK_ERROR(aclmdlRICondHandleCreate(parentModelRI, 0, ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT, &condHandle));
    uint64_t* condDevPtr = nullptr;
    CHECK_ERROR(aclmdlRICondHandleGetCondPtr(condHandle, &condDevPtr));

    aclmdlRI loopBodyModel[1] = {};
    aclmdlRICondTaskParams params;
    params.handle = condHandle;
    params.type = ACL_MODEL_RI_COND_TYPE_WHILE;
    params.size = 1;
    params.modelRIArray = loopBodyModel;
    CHECK_ERROR(aclmdlRIAddCondTask(params, stream, 0));

    CHECK_ERROR(aclmdlRICaptureToModelRIBegin(subStream, loopBodyModel[0], ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
    aclnnAdd(wsAddr, addWsSize, addExecutor, subStream);
    CHECK_ERROR(aclrtMemcpyAsync(
        condDevPtr, sizeof(uint64_t), condZeroDev, sizeof(uint64_t), ACL_MEMCPY_DEVICE_TO_DEVICE, subStream));
    CHECK_ERROR(aclmdlRICaptureEnd(subStream, &loopBodyModel[0]));

    CHECK_ERROR(aclmdlRICaptureEnd(stream, &parentModelRI));

    vector<float> outHost(kElementCount, 0.0f);
    aclrtStream execStream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&execStream));

    static const uint64_t kCondOne = 1;
    CHECK_ERROR(aclrtMemcpy(condDevPtr, sizeof(uint64_t), &kCondOne, sizeof(uint64_t), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclmdlRIExecuteAsync(parentModelRI, execStream));
    CHECK_ERROR(aclrtSynchronizeStream(execStream));
    CHECK_ERROR(aclrtMemcpy(outHost.data(), kSize, dstDev, kSize, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("WHILE single iteration result:");
    ModelUtils::PrintArray(outHost);

    CHECK_ERROR(aclmdlRIDestroy(parentModelRI));
    CHECK_ERROR(aclrtDestroyStream(subStream));
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtDestroyStream(execStream));
    CHECK_ERROR(aclDestroyTensor(srcA));
    CHECK_ERROR(aclDestroyTensor(srcB));
    CHECK_ERROR(aclDestroyTensor(dst));
    CHECK_ERROR(aclDestroyScalar(scalarAlpha));
    CHECK_ERROR(aclrtFree(srcADev));
    CHECK_ERROR(aclrtFree(srcBDev));
    CHECK_ERROR(aclrtFree(dstDev));
    CHECK_ERROR(aclrtFree(condZeroDev));
    if (wsAddr != nullptr) {
        CHECK_ERROR(aclrtFree(wsAddr));
    }
    INFO_LOG("WHILE condition PASSED");
    return 0;
}

int32_t TestCondSwitch()
{
    INFO_LOG("========== SWITCH condition ==========");
    aclrtStream stream = nullptr;
    aclrtStream subStream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtCreateStream(&subStream));

    void* srcADev = nullptr;
    void* srcBDev = nullptr;
    void* dstDev = nullptr;
    aclTensor* srcA = nullptr;
    aclTensor* srcB = nullptr;
    aclTensor* dst = nullptr;
    ModelUtils::CreateAclTensor(kShape, &srcADev, aclDataType::ACL_FLOAT, &srcA);
    ModelUtils::CreateAclTensor(kShape, &srcBDev, aclDataType::ACL_FLOAT, &srcB);
    ModelUtils::CreateAclTensor(kShape, &dstDev, aclDataType::ACL_FLOAT, &dst);

    CHECK_ERROR(aclrtMemcpy(srcADev, kSize, kSrcAHost.data(), kSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(srcBDev, kSize, kSrcBHost.data(), kSize, ACL_MEMCPY_HOST_TO_DEVICE));

    float alphaCase[3] = {1.0f, 2.0f, 0.5f};
    aclScalar* scalarCase0 = aclCreateScalar(&alphaCase[0], aclDataType::ACL_FLOAT);
    aclScalar* scalarCase1 = aclCreateScalar(&alphaCase[1], aclDataType::ACL_FLOAT);
    aclScalar* scalarCase2 = aclCreateScalar(&alphaCase[2], aclDataType::ACL_FLOAT);

    uint64_t wsSizes[3] = {};
    aclOpExecutor* executors[3] = {};
    void* wsAddrs[3] = {};
    aclnnAddGetWorkspaceSize(srcA, srcB, scalarCase0, dst, &wsSizes[0], &executors[0]);
    aclnnAddGetWorkspaceSize(srcA, srcB, scalarCase1, dst, &wsSizes[1], &executors[1]);
    aclnnAddGetWorkspaceSize(srcA, srcB, scalarCase2, dst, &wsSizes[2], &executors[2]);
    for (int i = 0; i < 3; ++i) {
        if (wsSizes[i] > 0) {
            CHECK_ERROR(aclrtMalloc(&wsAddrs[i], wsSizes[i], ACL_MEM_MALLOC_HUGE_FIRST));
        }
    }

    CHECK_ERROR(aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
    aclmdlRICaptureStatus status = ACL_MODEL_RI_CAPTURE_STATUS_NONE;
    aclmdlRI parentModelRI = nullptr;
    CHECK_ERROR(aclmdlRICaptureGetInfo(stream, &status, &parentModelRI));

    aclmdlRICondHandle condHandle = nullptr;
    CHECK_ERROR(aclmdlRICondHandleCreate(parentModelRI, 0, ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT, &condHandle));
    uint64_t* condDevPtr = nullptr;
    CHECK_ERROR(aclmdlRICondHandleGetCondPtr(condHandle, &condDevPtr));

    aclmdlRI caseModels[3] = {};
    aclmdlRICondTaskParams params;
    params.handle = condHandle;
    params.type = ACL_MODEL_RI_COND_TYPE_SWITCH;
    params.size = 3;
    params.modelRIArray = caseModels;
    CHECK_ERROR(aclmdlRIAddCondTask(params, stream, 0));

    for (int i = 0; i < 3; ++i) {
        CHECK_ERROR(aclmdlRICaptureToModelRIBegin(subStream, caseModels[i], ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL));
        aclnnAdd(wsAddrs[i], wsSizes[i], executors[i], subStream);
        CHECK_ERROR(aclmdlRICaptureEnd(subStream, &caseModels[i]));
    }

    CHECK_ERROR(aclmdlRICaptureEnd(stream, &parentModelRI));

    vector<float> outHost(kElementCount, 0.0f);
    aclrtStream execStream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&execStream));

    static const uint64_t kCondValues[3] = {0, 1, 2};
    for (int i = 0; i < 3; ++i) {
        CHECK_ERROR(
            aclrtMemcpy(condDevPtr, sizeof(uint64_t), &kCondValues[i], sizeof(uint64_t), ACL_MEMCPY_HOST_TO_DEVICE));
        CHECK_ERROR(aclmdlRIExecuteAsync(parentModelRI, execStream));
        CHECK_ERROR(aclrtSynchronizeStream(execStream));
        CHECK_ERROR(aclrtMemcpy(outHost.data(), kSize, dstDev, kSize, ACL_MEMCPY_DEVICE_TO_HOST));
        INFO_LOG("SWITCH case %d result:", i);
        ModelUtils::PrintArray(outHost);
    }

    CHECK_ERROR(aclmdlRIDestroy(parentModelRI));
    CHECK_ERROR(aclrtDestroyStream(subStream));
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtDestroyStream(execStream));
    CHECK_ERROR(aclDestroyTensor(srcA));
    CHECK_ERROR(aclDestroyTensor(srcB));
    CHECK_ERROR(aclDestroyTensor(dst));
    CHECK_ERROR(aclDestroyScalar(scalarCase0));
    CHECK_ERROR(aclDestroyScalar(scalarCase1));
    CHECK_ERROR(aclDestroyScalar(scalarCase2));
    CHECK_ERROR(aclrtFree(srcADev));
    CHECK_ERROR(aclrtFree(srcBDev));
    CHECK_ERROR(aclrtFree(dstDev));
    for (int i = 0; i < 3; ++i) {
        if (wsAddrs[i] != nullptr) {
            CHECK_ERROR(aclrtFree(wsAddrs[i]));
        }
    }
    INFO_LOG("SWITCH condition PASSED");
    return 0;
}

int32_t main()
{
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    aclrtContext context = nullptr;
    CHECK_ERROR(aclrtCreateContext(&context, kDeviceId));

    TestCondIf();
    TestCondWhile();
    TestCondSwitch();

    INFO_LOG("========== All tests PASSED ==========");
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(kDeviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
