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
#include "utils.h"
#include "acl/acl.h"

using namespace std;

// 核函数，让x自增1
extern void EasyOP(uint32_t coreDim, void *stream, uint32_t* x);

int main()
{
    // 初始化
    const int count = 3000;
    int32_t deviceId = 0;
    uint32_t blockDim = 1;
    uint32_t num = 0;
    uint32_t *numDevice = nullptr;
    size_t size = sizeof(uint32_t);
    aclrtStream stream = nullptr;
    aclrtStreamStatus streamStatus;
    aclrtContext context;
    CHECK_ERROR(aclInit(nullptr));
    // 申请设备
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    INFO_LOG("Use default stream assigning task.");

    // 默认流下发任务,默认流随着context创建而创建，给函数传入空即使用默认流
    CHECK_ERROR(aclrtMalloc((void**)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    INFO_LOG("Applied resource successfully, beging assigning task.");
    EasyOP(blockDim, nullptr, numDevice);
    CHECK_ERROR(aclrtSynchronizeStream(nullptr));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After assigning the task through the default stream, the current result is: %d.", num);

    // 创建流下发任务，可以显示地创建流进行下发任务
    INFO_LOG("Use created stream assigning task.");
    CHECK_ERROR(aclrtCreateStream(&stream));

    // 默认为遇错继续执行，调用该函数设置为遇错即停，当一个任务执行遇到错误，后续任务将不进行
    CHECK_ERROR(aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE));
    EasyOP(blockDim, stream, numDevice);
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After assigning the task through the created stream, the current result is: %d.", num);
    
    INFO_LOG("Begin 3000 task.");
    // 循环下发任务并检查下发状态
    for (int i = 0; i < count; i++) {
        // 同一个流中下发任务是顺序执行的，所以不需要没下发一个任务就同步
        EasyOP(blockDim, stream, numDevice);
    }

    // 查询stream任务下发是否完成
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtStreamQuery(stream, &streamStatus));
    INFO_LOG("After synchronize, stream status is: %d.", streamStatus);
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After loop, the current result is: %d.", num);

    // 释放资源
    CHECK_ERROR(aclrtFree(numDevice));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    aclFinalize();
    INFO_LOG("Resource cleanup completed.");
}