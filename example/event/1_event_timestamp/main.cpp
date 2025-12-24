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

// 耗时较长的核函数，功能为x自增1
extern void LongOP(uint32_t coreDim, void *stream, uint32_t* x);
// 耗时较短的核函数，功能为x自乘2
extern void ShortOP(uint32_t coreDim, void *stream, uint32_t* x);

int main()
{
    // 初始化
    int32_t deviceId = 0;
    uint32_t blockDim = 1;
    uint32_t num = 0;
    uint32_t *numDevice = nullptr;
    size_t size = sizeof(uint32_t);
    uint64_t time = 0;
    float useTime = 0;
    aclrtStream stream = nullptr;
    aclrtStreamStatus streamStatus;
    aclrtContext context;
    aclrtEvent startEvent;
    aclrtEvent endEvent;
    CHECK_ERROR(aclInit(nullptr));

    // 申请设备
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE));
    CHECK_ERROR(aclrtCreateEvent(&startEvent));
    CHECK_ERROR(aclrtCreateEvent(&endEvent));

    // 先做一个短时任务查看耗时
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    INFO_LOG("Begin a short task.");
    // 做任务前记录一次，做任务后再记录一次，相差时间则为任务耗时。
    CHECK_ERROR(aclrtRecordEvent(startEvent, stream));
    ShortOP(blockDim, stream, numDevice);
    CHECK_ERROR(aclrtRecordEvent(endEvent, stream));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After completing the short task, the answer is %d.", num);
    INFO_LOG("After synchronize, check the time.");

    // 查找时间戳以及计算耗时
    CHECK_ERROR(aclrtEventGetTimestamp(startEvent, &time));
    INFO_LOG("Start event timestamp: %ld.", time);
    CHECK_ERROR(aclrtEventGetTimestamp(endEvent, &time));
    INFO_LOG("End event timestamp: %ld.", time);
    CHECK_ERROR(aclrtEventElapsedTime(&useTime, startEvent, endEvent));
    INFO_LOG("The short task consume time %f ms.", useTime);

    // 再做一个长耗时任务查看耗时
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    INFO_LOG("Begin a short task.");
    CHECK_ERROR(aclrtRecordEvent(startEvent, stream));
    LongOP(blockDim, stream, numDevice);
    CHECK_ERROR(aclrtRecordEvent(endEvent, stream));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After completing the long task, the answer is %d.", num);
    INFO_LOG("After synchronize, check the time.");

    // 查找时间戳以及计算耗时
    CHECK_ERROR(aclrtEventGetTimestamp(startEvent, &time));
    INFO_LOG("Start event timestamp: %ld.", time);
    CHECK_ERROR(aclrtEventGetTimestamp(endEvent, &time));
    INFO_LOG("End event timestamp: %ld.", time);
    CHECK_ERROR(aclrtEventElapsedTime(&useTime, startEvent, endEvent));
    INFO_LOG("The short task consume time %f ms.", useTime);

    // 释放资源
    CHECK_ERROR(aclrtFree(numDevice));
    CHECK_ERROR(aclrtDestroyEvent(startEvent));
    CHECK_ERROR(aclrtDestroyEvent(endEvent));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    aclFinalize();
    INFO_LOG("Resource cleanup completed.");
}