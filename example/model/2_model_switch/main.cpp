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
#include "aclnnop/aclnn_mul.h"
using namespace std;

// 核函数，让x自增1
extern void EasyOP(uint32_t coreDim, void *stream, uint32_t* x);
// aclnnadd计算：out = self + other * alpha
// aclnnmul计算: out = self * other
int main()
{
    int deviceId = 0;
    int blockDim = 1;
    int num = 0;
    // 初始化数据，包括三个算子任务所需要的输入输出
    uint32_t *numDevice = nullptr;
    void *selfDevice1 = nullptr;
    void *otherDevice1 = nullptr;
    void *outDevice1 = nullptr;
    void *selfDevice2 = nullptr;
    void *otherDevice2 = nullptr;
    void *outDevice2 = nullptr;
    void *selfDevice3 = nullptr;
    void *otherDevice3 = nullptr;
    void *outDevice3 = nullptr;
    aclTensor *self1 = nullptr;
    aclTensor *other1 = nullptr;
    aclScalar *alpha = nullptr;
    aclTensor *out1 = nullptr;
    aclTensor *self2 = nullptr;
    aclTensor *other2 = nullptr;
    aclTensor *out2 = nullptr;
    aclTensor *self3 = nullptr;
    aclTensor *other3 = nullptr;
    aclTensor *out3 = nullptr;
    vector<float> selfHostData1 = {1, 1, 1, 1, 1, 1, 1, 1};
    vector<float> otherHostData1 = {2, 2, 2, 2, 2, 2, 2, 2};
    vector<float> outHostData1 = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<float> selfHostData2 = {2, 2, 2, 2, 2, 2, 2, 2};
    vector<float> otherHostData2 = {2, 2, 2, 2, 2, 2, 2, 2};
    vector<float> outHostData2 = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<float> selfHostData3 = {3, 3, 3, 3, 3, 3, 3, 3};
    vector<float> otherHostData3 = {2, 2, 2, 2, 2, 2, 2, 2};
    vector<float> outHostData3 = {0, 0, 0, 0, 0, 0, 0, 0};
    vector<int64_t> shape = {4, 2};
    float alphaValue = 1.2f;
    uint64_t addWorkspaceSize1 = 0;
    uint64_t addWorkspaceSize2 = 0;
    uint64_t addWorkspaceSize3 = 0;
    aclOpExecutor *addExecutor1;
    aclOpExecutor *addExecutor2;
    aclOpExecutor *addExecutor3;
    aclrtContext context;
    int64_t size = ModelUtils::GetShapeSize(shape) * sizeof(float);
    CHECK_ERROR(aclInit(NULL));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));

    // 创建三个算子任务，后续分发给每个流
    // stream1: out1 = self1 + other1 * alpha
    // stream2: out2 = self2 + other2 * alpha
    // stream3: out3 = self3 + other3 * alpha
    ModelUtils::CreateAclTensor(shape, &selfDevice1, aclDataType::ACL_FLOAT, &self1);
    ModelUtils::CreateAclTensor(shape, &otherDevice1, aclDataType::ACL_FLOAT, &other1);
    ModelUtils::CreateAclTensor(shape, &selfDevice2, aclDataType::ACL_FLOAT, &self2);
    ModelUtils::CreateAclTensor(shape, &otherDevice2, aclDataType::ACL_FLOAT, &other2);
    ModelUtils::CreateAclTensor(shape, &selfDevice3, aclDataType::ACL_FLOAT, &self3);
    ModelUtils::CreateAclTensor(shape, &otherDevice3, aclDataType::ACL_FLOAT, &other3);
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    ModelUtils::CreateAclTensor(shape, &outDevice1, aclDataType::ACL_FLOAT, &out1);
    ModelUtils::CreateAclTensor(shape, &outDevice2, aclDataType::ACL_FLOAT, &out2);
    ModelUtils::CreateAclTensor(shape, &outDevice3, aclDataType::ACL_FLOAT, &out3);
    aclnnAddGetWorkspaceSize(self1, other1, alpha, out1, &addWorkspaceSize1, &addExecutor1);
    void *addWorkspaceAddr1 = nullptr;
    if (addWorkspaceSize1 > 0) {
        CHECK_ERROR(aclrtMalloc(&addWorkspaceAddr1, addWorkspaceSize1, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    aclnnAddGetWorkspaceSize(self2, other2, alpha, out2, &addWorkspaceSize2, &addExecutor2);
    void *addWorkspaceAddr2 = nullptr;
    if (addWorkspaceSize2 > 0) {
        CHECK_ERROR(aclrtMalloc(&addWorkspaceAddr2, addWorkspaceSize2, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    aclnnAddGetWorkspaceSize(self3, other3, alpha, out3, &addWorkspaceSize3, &addExecutor3);
    void *addWorkspaceAddr3 = nullptr;
    if (addWorkspaceSize3 > 0) {
        CHECK_ERROR(aclrtMalloc(&addWorkspaceAddr3, addWorkspaceSize3, ACL_MEM_MALLOC_HUGE_FIRST));
    }

    // switchstream函数需要的参数为device侧数据的地址，这里创建两个device侧的地址用于比较，一个为1，一个为2
    int32_t rightValue1 = 1;
    int32_t rightValue2 = 2;
    void *rightDevice1 = nullptr;
    void *rightDevice2 = nullptr;
    aclrtCondition condition = ACL_RT_EQUAL;
    aclrtCompareDataType dataType = ACL_RT_SWITCH_INT32;
    CHECK_ERROR(aclrtMalloc(&rightDevice1, sizeof(int32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(rightDevice1, sizeof(int32_t), &rightValue1, sizeof(int32_t), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMalloc(&rightDevice2, sizeof(int32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(rightDevice2, sizeof(int32_t), &rightValue2, sizeof(int32_t), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, sizeof(uint32_t), ACL_MEM_MALLOC_HUGE_FIRST));

    // 创建四个流
    aclmdlRI modelRI;
    aclrtStream stream1;
    aclrtStream stream2;
    aclrtStream stream3;
    aclrtStream stream4;
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream1, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream2, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream3, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream4, 0x00U, ACL_STREAM_PERSISTENT));

    // 绑定四个流，复制算子需要的数据
    CHECK_ERROR(aclmdlRIBuildBegin(&modelRI, 0x00U));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream1, ACL_MODEL_STREAM_FLAG_HEAD));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream2, ACL_MODEL_STREAM_FLAG_DEFAULT));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream3, ACL_MODEL_STREAM_FLAG_DEFAULT));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream4, ACL_MODEL_STREAM_FLAG_DEFAULT));
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice1, size, selfHostData1.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream1));
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice2, size, selfHostData2.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream2));
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice3, size, selfHostData3.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream3));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice1, size, otherHostData1.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream1));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice2, size, otherHostData2.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream2));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice3, size, otherHostData3.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream3));
    // stream1的任务为下发一个aclnn算子以及一个核函数，核函数使numDevice自增
    aclnnAdd(addWorkspaceAddr1, addWorkspaceSize1, addExecutor1, stream1);
    EasyOP(blockDim, stream1, numDevice);
    // stream2的任务为下发一个aclnn算子
    aclnnAdd(addWorkspaceAddr2, addWorkspaceSize2, addExecutor2, stream2);
    // stream3的任务为下发一个aclnn算子
    aclnnAdd(addWorkspaceAddr3, addWorkspaceSize3, addExecutor3, stream3);
    // 当计算核函数后得到的numdevice为1时，跳转至stream3,stream1暂停。
    CHECK_ERROR(aclrtSwitchStream(numDevice, condition, rightDevice1, dataType, stream3, nullptr, stream1));
    // 当计算核函数后得到的numdevice为2时，跳转至stream4,stream1暂停。
    CHECK_ERROR(aclrtSwitchStream(numDevice, condition, rightDevice2, dataType, stream4, nullptr, stream1));
    // stream4的任务为激活stream2,他们会并行执行，要注意，使用该接口的两个流应该都已绑定了模型实例
    CHECK_ERROR(aclrtActiveStream(stream2, stream4));
    // 结束任务，stream1在跳转后会结束，所以该处只需要结束stream2,3,4
    CHECK_ERROR(aclmdlRIEndTask(modelRI, stream2));
    CHECK_ERROR(aclmdlRIEndTask(modelRI, stream4));
    CHECK_ERROR(aclmdlRIEndTask(modelRI, stream3));
    CHECK_ERROR(aclmdlRIBuildEnd(modelRI, NULL));

    aclrtStream executeStream;
    aclrtCreateStream(&executeStream);
    
    // num = 0,第一次执行时，num自增为1，会跳转至stream3
    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, executeStream));
    CHECK_ERROR(aclrtSynchronizeStream(executeStream));
    CHECK_ERROR(aclrtMemcpy(outHostData1.data(), size, outDevice1, size, ACL_MEMCPY_DEVICE_TO_HOST));
    CHECK_ERROR(aclrtMemcpy(outHostData2.data(), size, outDevice2, size, ACL_MEMCPY_DEVICE_TO_HOST));
    CHECK_ERROR(aclrtMemcpy(outHostData3.data(), size, outDevice3, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 该输出中，data1对应为stream1的算子计算结果，如果某个stream没有执行算子，此处输出结果为全0
    INFO_LOG("After executing, print data1.");
    ModelUtils::PrintArray(outHostData1);
    INFO_LOG("After executing, print data2.");
    ModelUtils::PrintArray(outHostData2);
    INFO_LOG("After executing, print data3.");
    ModelUtils::PrintArray(outHostData3);

    // 将上一次执行后的结果清零，随后再执行
    outHostData1.assign(outHostData1.size(), 0);
    outHostData2.assign(outHostData2.size(), 0);
    outHostData3.assign(outHostData3.size(), 0);
    CHECK_ERROR(aclrtMemcpyAsync(outDevice1, size, outHostData1.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream1));
    CHECK_ERROR(aclrtMemcpyAsync(outDevice2, size, outHostData2.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream2));
    CHECK_ERROR(aclrtMemcpyAsync(outDevice3, size, outHostData3.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream3));
    // 此时由于上一次numdevice已经自增为1，此时再次自增，结果为2，会跳转至stream4，随后stream4激活stream2
    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, executeStream));
    CHECK_ERROR(aclrtSynchronizeStream(executeStream));
    CHECK_ERROR(aclrtMemcpy(outHostData1.data(), size, outDevice1, size, ACL_MEMCPY_DEVICE_TO_HOST));
    CHECK_ERROR(aclrtMemcpy(outHostData2.data(), size, outDevice2, size, ACL_MEMCPY_DEVICE_TO_HOST));
    CHECK_ERROR(aclrtMemcpy(outHostData3.data(), size, outDevice3, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After activing stream2 and executing, print data1.");
    ModelUtils::PrintArray(outHostData1);
    INFO_LOG("After activing stream2 and executing, print data2.");
    ModelUtils::PrintArray(outHostData2);
    INFO_LOG("After activing stream2 and executing, print data3.");
    ModelUtils::PrintArray(outHostData3);

    // 解除模型实例与流的绑定
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream1));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream2));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream3));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream4));
    CHECK_ERROR(aclmdlRIDestroy(modelRI));
    CHECK_ERROR(aclrtDestroyStream(stream1));
    CHECK_ERROR(aclrtDestroyStream(stream2));
    CHECK_ERROR(aclrtDestroyStream(stream3));
    CHECK_ERROR(aclrtDestroyStream(stream4));
    CHECK_ERROR(aclDestroyTensor(self1));
    CHECK_ERROR(aclDestroyTensor(other1));
    CHECK_ERROR(aclDestroyTensor(out1));
    CHECK_ERROR(aclDestroyTensor(self2));
    CHECK_ERROR(aclDestroyTensor(other2));
    CHECK_ERROR(aclDestroyTensor(out2));
    CHECK_ERROR(aclDestroyTensor(self3));
    CHECK_ERROR(aclDestroyTensor(other3));
    CHECK_ERROR(aclDestroyTensor(out3));
    CHECK_ERROR(aclDestroyScalar(alpha));
    CHECK_ERROR(aclrtFree(numDevice));
    CHECK_ERROR(aclrtFree(selfDevice1));
    CHECK_ERROR(aclrtFree(otherDevice1));
    CHECK_ERROR(aclrtFree(outDevice1));
    CHECK_ERROR(aclrtFree(selfDevice2));
    CHECK_ERROR(aclrtFree(otherDevice2));
    CHECK_ERROR(aclrtFree(outDevice2));
    CHECK_ERROR(aclrtFree(selfDevice3));
    CHECK_ERROR(aclrtFree(otherDevice3));
    CHECK_ERROR(aclrtFree(outDevice3));

    if (addWorkspaceAddr1 != nullptr) {
        CHECK_ERROR(aclrtFree(addWorkspaceAddr1));
    }
    if (addWorkspaceAddr1 != nullptr) {
        CHECK_ERROR(aclrtFree(addWorkspaceAddr1));
    }
    if (addWorkspaceAddr1 != nullptr) {
        CHECK_ERROR(aclrtFree(addWorkspaceAddr1));
    }
    // 释放计算设备的资源
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    // 去初始化
    CHECK_ERROR(aclFinalize());
}