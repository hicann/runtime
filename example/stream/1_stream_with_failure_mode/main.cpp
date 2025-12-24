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
// 核函数，执行后出错
extern void ErrorOP(uint32_t blockDim, void *stream);

int main()
{
    int32_t deviceId = 0;
    uint32_t blockDim = 1;
    uint32_t num = 0;
    uint32_t *numDevice = nullptr;
    size_t size = sizeof(uint32_t);
    aclrtStream stream = nullptr;
    aclrtContext context;
    CHECK_ERROR(aclInit(nullptr));
    
    // 申请设备
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtMalloc((void**)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    // 不设置failureMode时下发任务，遇到错误继续执行
    INFO_LOG("Assigning task without failure mode.");
    EasyOP(blockDim, stream, numDevice);
    ErrorOP(blockDim, stream);
    EasyOP(blockDim, stream, numDevice);
    CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 第二次异常任务后，第三次任务继续执行，所以结果为2
    INFO_LOG("Without failure mode, the result is %d.", num);
    num = 0;
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    // 默认为遇错继续执行，调用该函数设置为遇错即停，当一个任务执行遇到错误，后续任务将不进行
    CHECK_ERROR(aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE));
    INFO_LOG("Assigning task with failure mode.");
    EasyOP(blockDim, stream, numDevice);
    ErrorOP(blockDim, stream);
    EasyOP(blockDim, stream, numDevice);
    CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeStream(stream)); // 同步会出错
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 第二次异常任务后，第三次任务被丢弃，所以结果为1
    INFO_LOG("After set failure mode, the current result is: %d.", num);

    // 释放资源
    CHECK_ERROR(aclrtFree(numDevice));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    aclFinalize();
    INFO_LOG("Resource cleanup completed.");
}