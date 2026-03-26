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
// aclnnadd计算：out = self + other * alpha
// aclnnmul计算: out = self * other
int main()
{
    int deviceId = 0;
    int blockDim = 1;
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
    uint32_t numInit = 0;
    CHECK_ERROR(aclrtMemcpy(numDevice, sizeof(uint32_t), &numInit, sizeof(uint32_t), ACL_MEMCPY_HOST_TO_DEVICE));
    // 通过 DeviceToDevice 异步拷贝将其置为 1，供 SwitchStream 分支验证。
    uint32_t val1 = 1;
    void *targetValDev_1 = nullptr;
    CHECK_ERROR(aclrtMalloc(&targetValDev_1, sizeof(uint32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(targetValDev_1, sizeof(uint32_t), &val1, sizeof(uint32_t), ACL_MEMCPY_HOST_TO_DEVICE));
    // 创建五个流：四个工作流 + 一个汇聚流endStream
    aclmdlRI modelRI;
    aclrtStream stream1;
    aclrtStream stream2;
    aclrtStream stream3;
    aclrtStream stream4;
    aclrtStream endStream;
    // 增加一个独立的 copyStream，专门用于独立内存操作，不和模型环境绑定，防止流状态异常。
    aclrtStream copyStream;
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream1, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream2, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream3, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&stream4, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&endStream, 0x00U, ACL_STREAM_PERSISTENT));
    CHECK_ERROR(aclrtCreateStream(&copyStream));
    // 绑定五个流，复制算子需要的数据
    CHECK_ERROR(aclmdlRIBuildBegin(&modelRI, 0x00U));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream1, ACL_MODEL_STREAM_FLAG_HEAD));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream2, ACL_MODEL_STREAM_FLAG_DEFAULT));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream3, ACL_MODEL_STREAM_FLAG_DEFAULT));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, stream4, ACL_MODEL_STREAM_FLAG_DEFAULT));
    CHECK_ERROR(aclmdlRIBindStream(modelRI, endStream, ACL_MODEL_STREAM_FLAG_DEFAULT));
    // 对于不绑定的流操作，使用独立的 copyStream 进行初始化数据的拷入
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice1, size, selfHostData1.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream1));
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice2, size, selfHostData2.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream2));
    CHECK_ERROR(aclrtMemcpyAsync(selfDevice3, size, selfHostData3.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream3));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice1, size, otherHostData1.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream1));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice2, size, otherHostData2.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream2));
    CHECK_ERROR(aclrtMemcpyAsync(otherDevice3, size, otherHostData3.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream3));
    aclnnAdd(addWorkspaceAddr1, addWorkspaceSize1, addExecutor1, stream1);
    CHECK_ERROR(aclrtMemcpyAsync(numDevice, sizeof(uint32_t), targetValDev_1, sizeof(uint32_t), ACL_MEMCPY_DEVICE_TO_DEVICE, stream1));
    // stream2的任务为下发一个aclnn算子，完成后激活endStream
    aclnnAdd(addWorkspaceAddr2, addWorkspaceSize2, addExecutor2, stream2);
    CHECK_ERROR(aclrtActiveStream(endStream, stream2));
    // stream3的任务为下发一个aclnn算子，完成后激活endStream
    aclnnAdd(addWorkspaceAddr3, addWorkspaceSize3, addExecutor3, stream3);
    CHECK_ERROR(aclrtActiveStream(endStream, stream3));
    // 根据安全且强制写入的 numdevice=1 状态，流能够安全跳转至stream3。仅保留一个Switch验证分支打通
    // 将两条 SwitchStream 全部加回（必须确保第一个分支哪怕未命中时，设备侧仍兼容执行第二个分支）
    CHECK_ERROR(aclrtSwitchStream(numDevice, condition, rightDevice1, dataType, stream3, nullptr, stream1));
    CHECK_ERROR(aclrtSwitchStream(numDevice, condition, rightDevice2, dataType, stream4, nullptr, stream1));
    // stream4的任务为激活stream2,他们会并行执行，要注意，使用该接口的两个流应该都已绑定了模型实例
    CHECK_ERROR(aclrtActiveStream(stream2, stream4));
    // 结束任务：仅在汇聚流endStream上调用EndTask（一个模型只能有一个EndGraph）
    // 路径1（numDevice==1）: stream1 → stream3 → ActiveStream(endStream) → EndTask
    CHECK_ERROR(aclmdlRIEndTask(modelRI, endStream));
    CHECK_ERROR(aclmdlRIBuildEnd(modelRI, NULL));
    aclrtStream executeStream;
    aclrtCreateStream(&executeStream);
    // 执行图任务：
    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, executeStream));
    CHECK_ERROR(aclrtSynchronizeStream(executeStream));
    // 使用刚才新建的独立的、完全未被绑定过的 copyStream 来做结果的拷回
    CHECK_ERROR(aclrtMemcpyAsync(outHostData1.data(), size, outDevice1, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream));
    CHECK_ERROR(aclrtMemcpyAsync(outHostData2.data(), size, outDevice2, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream));
    CHECK_ERROR(aclrtMemcpyAsync(outHostData3.data(), size, outDevice3, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream));
    CHECK_ERROR(aclrtSynchronizeStream(copyStream));
    INFO_LOG("After executing, print data1.");
    ModelUtils::PrintArray(outHostData1);
    INFO_LOG("After executing, print data2.");
    ModelUtils::PrintArray(outHostData2);
    INFO_LOG("After executing, print data3.");
    ModelUtils::PrintArray(outHostData3);
    // ================= 测试分支值为 2 的场景 =====================
    // 第二次执行模型前，我们要将 targetValDev_1 中的值修改为 2，
    // 以便让图里面录入的那句 DeviceToDevice 复制时把 2 写进 numDevice。
    uint32_t val2 = 2;
    // 使用独立的 copyStream 拷贝 2 到 targetValDev_1 中
    CHECK_ERROR(aclrtMemcpyAsync(targetValDev_1, sizeof(uint32_t), &val2, sizeof(uint32_t), ACL_MEMCPY_HOST_TO_DEVICE, copyStream));
    CHECK_ERROR(aclrtSynchronizeStream(copyStream));
    // 将上一次的主机结果清零，以免混淆
    outHostData1.assign(outHostData1.size(), 0);
    outHostData2.assign(outHostData2.size(), 0);
    outHostData3.assign(outHostData3.size(), 0);
    // 执行第二次图任务：
    CHECK_ERROR(aclmdlRIExecuteAsync(modelRI, executeStream));
    CHECK_ERROR(aclrtSynchronizeStream(executeStream));
    // 使用 copyStream 拷回结果
    CHECK_ERROR(aclrtMemcpyAsync(outHostData1.data(), size, outDevice1, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream));
    CHECK_ERROR(aclrtMemcpyAsync(outHostData2.data(), size, outDevice2, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream));
    CHECK_ERROR(aclrtMemcpyAsync(outHostData3.data(), size, outDevice3, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream));
    CHECK_ERROR(aclrtSynchronizeStream(copyStream));
    INFO_LOG("After second execution, print data1.");
    ModelUtils::PrintArray(outHostData1);
    INFO_LOG("After second execution, print data2.");
    ModelUtils::PrintArray(outHostData2);
    INFO_LOG("After second execution, print data3.");
    ModelUtils::PrintArray(outHostData3);
    // 解除模型实例与流的绑定
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream1));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream2));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream3));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, stream4));
    CHECK_ERROR(aclmdlRIUnbindStream(modelRI, endStream));
    CHECK_ERROR(aclmdlRIDestroy(modelRI));
    CHECK_ERROR(aclrtDestroyStream(copyStream));
    CHECK_ERROR(aclrtDestroyStream(executeStream));
    CHECK_ERROR(aclrtDestroyStream(stream1));
    CHECK_ERROR(aclrtDestroyStream(stream2));
    CHECK_ERROR(aclrtDestroyStream(stream3));
    CHECK_ERROR(aclrtDestroyStream(stream4));
    CHECK_ERROR(aclrtDestroyStream(endStream));
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
    CHECK_ERROR(aclrtFree(targetValDev_1));
    CHECK_ERROR(aclrtFree(rightDevice1));
    CHECK_ERROR(aclrtFree(rightDevice2));
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
    if (addWorkspaceAddr2 != nullptr) {
        CHECK_ERROR(aclrtFree(addWorkspaceAddr2));
    }
    if (addWorkspaceAddr3 != nullptr) {
        CHECK_ERROR(aclrtFree(addWorkspaceAddr3));
    }
    // 释放计算设备的资源
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    // 去初始化
    CHECK_ERROR(aclFinalize());
    return 0;
}