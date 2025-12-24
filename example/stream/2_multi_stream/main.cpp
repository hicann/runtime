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

namespace {
    // Event同步
    int EventSynchronization()
    {
        const int waitTime = 1000;
        int32_t deviceId = 0;
        uint32_t blockDim = 1;
        uint32_t num = 0;
        uint32_t *numDevice = nullptr;
        size_t size = sizeof(uint32_t);
        aclrtContext context;
        aclrtStream stream1 = nullptr;
        aclrtStream stream2 = nullptr;
        aclrtEvent event;
        aclInit(nullptr);

        // 申请设备
        CHECK_ERROR(aclrtSetDevice(deviceId));
        CHECK_ERROR(aclrtCreateContext(&context, deviceId));
        CHECK_ERROR(aclrtCreateStream(&stream1));
        CHECK_ERROR(aclrtCreateStream(&stream2));
        // 默认为遇错继续执行，调用该函数设置为遇错即停，当一个任务执行遇到错误，后续任务将不进行。
        CHECK_ERROR(aclrtSetStreamFailureMode(stream1, ACL_STOP_ON_FAILURE));
        CHECK_ERROR(aclrtSetStreamFailureMode(stream2, ACL_STOP_ON_FAILURE));
        CHECK_ERROR(aclrtCreateEvent(&event));
        INFO_LOG("Use event synchronize.");
        // 开始做长任务
        CHECK_ERROR(aclrtMalloc((void**)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
        INFO_LOG("Applied resource successfully, beging assigning task.");
        INFO_LOG("Begin a long task, num += 1.");
        LongOP(blockDim, stream1, numDevice);
        CHECK_ERROR(aclrtRecordEvent(event, stream1));
        INFO_LOG("Event synchronize.");
        CHECK_ERROR(aclrtStreamWaitEvent(stream2, event));

        // 复位event，确保在同步后再复位，可以重复使用event，节省资源。
        CHECK_ERROR(aclrtResetEvent(event, stream2));
        INFO_LOG("Begin a short task, num *= 2.");
        ShortOP(blockDim, stream2, numDevice);
        CHECK_ERROR(aclrtRecordEvent(event, stream2));
        CHECK_ERROR(aclrtSynchronizeEvent(event));
        CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
        // 按照顺序执行结果应该为2
        INFO_LOG("The answer is %d.", num);

        // event超时等待
        INFO_LOG("Simulate timeout, wait 1000ms, the task will fail.");
        LongOP(blockDim, stream1, numDevice);
        CHECK_ERROR(aclrtRecordEvent(event, stream1));
        // 流的超时等待，如果超时直接报函数错误，将时间变长则不会报错。
        CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeEventWithTimeout(event, waitTime));

        // 释放资源
        CHECK_ERROR(aclrtFree(numDevice));
        CHECK_ERROR(aclrtDestroyEvent(event));
        CHECK_ERROR(aclrtDestroyStreamForce(stream1));
        CHECK_ERROR(aclrtDestroyStreamForce(stream2));
        CHECK_ERROR(aclrtDestroyContext(context));
        CHECK_ERROR(aclrtResetDeviceForce(deviceId));
        aclFinalize();
        INFO_LOG("Resource cleanup completed.");
    }

    // Stream同步
    int StreamSynchronization()
    {
        const int waitTime = 1000;
        int32_t deviceId = 0;
        uint32_t blockDim = 1;
        uint32_t num = 0;
        uint32_t *numDevice = nullptr;
        size_t size = sizeof(uint32_t);
        aclrtContext context;
        aclrtStream stream1 = nullptr;
        aclrtStream stream2 = nullptr;
        aclInit(nullptr);

        // 申请设备
        CHECK_ERROR(aclrtSetDevice(deviceId));
        CHECK_ERROR(aclrtCreateContext(&context, deviceId));
        CHECK_ERROR(aclrtCreateStream(&stream1));
        CHECK_ERROR(aclrtCreateStream(&stream2));
        // 默认为遇错继续执行，调用该函数设置为遇错即停，当一个任务执行遇到错误，后续任务将不进行。
        CHECK_ERROR(aclrtSetStreamFailureMode(stream1, ACL_STOP_ON_FAILURE));
        CHECK_ERROR(aclrtSetStreamFailureMode(stream2, ACL_STOP_ON_FAILURE));
        INFO_LOG("Use stream synchronize.");
        // 开始做长任务
        CHECK_ERROR(aclrtMalloc((void**)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
        INFO_LOG("Applied resource successfully, beging assigning task.");
        INFO_LOG("Begin a long task, num += 1.");
        LongOP(blockDim, stream1, numDevice);
        INFO_LOG("Stream synchronize.");
        CHECK_ERROR(aclrtSynchronizeStream(stream1));

        // 复位event，确保在同步后再复位，可以重复使用event，节省资源。
        INFO_LOG("Begin a short task, num *= 2.");
        ShortOP(blockDim, stream2, numDevice);
        CHECK_ERROR(aclrtSynchronizeStream(stream2));
        CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
        // 按照顺序执行结果应该为2
        INFO_LOG("The answer is %d.", num);

        // event超时等待
        INFO_LOG("Simulate timeout, wait 1000ms, the task will fail.");
        LongOP(blockDim, stream1, numDevice);
        // 流的超时等待，如果超时直接报函数错误，将时间变长则不会报错。
        CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeStreamWithTimeout(stream1, waitTime));

        // 释放资源
        CHECK_ERROR(aclrtFree(numDevice));
        CHECK_ERROR(aclrtDestroyStreamForce(stream1));
        CHECK_ERROR(aclrtDestroyStreamForce(stream2));
        CHECK_ERROR(aclrtDestroyContext(context));
        CHECK_ERROR(aclrtResetDeviceForce(deviceId));
        aclFinalize();
        INFO_LOG("Resource cleanup completed.");
    }

    // Notify同步
    int NotifySynchronization()
    {
        int32_t deviceId = 0;
        uint32_t blockDim = 1;
        uint32_t num = 0;
        uint32_t *numDevice = nullptr;
        size_t size = sizeof(uint32_t);
        aclrtContext context;
        aclrtNotify notify;
        aclrtStream stream1 = nullptr;
        aclrtStream stream2 = nullptr;
        aclInit(nullptr);

        // 申请设备
        CHECK_ERROR(aclrtSetDevice(deviceId));
        CHECK_ERROR(aclrtCreateContext(&context, deviceId));
        CHECK_ERROR(aclrtCreateStream(&stream1));
        CHECK_ERROR(aclrtCreateStream(&stream2));
        CHECK_ERROR(aclrtCreateNotify(&notify, 0x00U));
        // 默认为遇错继续执行，调用该函数设置为遇错即停，当一个任务执行遇到错误，后续任务将不进行。
        CHECK_ERROR(aclrtSetStreamFailureMode(stream1, ACL_STOP_ON_FAILURE));
        CHECK_ERROR(aclrtSetStreamFailureMode(stream2, ACL_STOP_ON_FAILURE));
        INFO_LOG("Use notify synchronize.");
        // 开始做长任务
        CHECK_ERROR(aclrtMalloc((void**)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
        INFO_LOG("Applied resource successfully, beging assigning task.");
        INFO_LOG("Begin a long task, num += 1.");
        LongOP(blockDim, stream1, numDevice);
        INFO_LOG("Stream synchronize.");
        CHECK_ERROR(aclrtRecordNotify(notify, stream1));

        CHECK_ERROR(aclrtWaitAndResetNotify(notify, stream2, 0));
        INFO_LOG("Begin a short task, num *= 2.");
        ShortOP(blockDim, stream2, numDevice);
        CHECK_ERROR(aclrtSynchronizeStream(stream2));
        CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
        // 按照顺序执行结果应该为2
        INFO_LOG("The answer is %d.", num);
        // 释放资源
        CHECK_ERROR(aclrtFree(numDevice));
        CHECK_ERROR(aclrtDestroyNotify(notify));
        CHECK_ERROR(aclrtDestroyStreamForce(stream1));
        CHECK_ERROR(aclrtDestroyStreamForce(stream2));
        CHECK_ERROR(aclrtDestroyContext(context));
        CHECK_ERROR(aclrtResetDeviceForce(deviceId));
        aclFinalize();
        INFO_LOG("Resource cleanup completed.");
    }
} // namespace

int main()
{
    // 每个函数代表一种同步的方法
    
    (void)StreamSynchronization();
    (void)EventSynchronization();
    (void)NotifySynchronization();
    return 0;
}