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

int main()
{
    int32_t deviceId = 0;
    uint32_t blockDim = 1;
    uint32_t num = 0;
    uint32_t *numDevice = nullptr;
    size_t size = sizeof(uint32_t);
    aclrtContext context;
    aclrtStream stream = nullptr;
    aclrtEvent event;
    aclrtEventRecordedStatus eventStatus;
    aclInit(nullptr);

    // 申请设备
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    CHECK_ERROR(aclrtCreateStream(&stream));
    
    // 默认为遇错继续执行，调用该函数设置为遇错即停，当一个任务执行遇到错误，后续任务将不进行。
    CHECK_ERROR(aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE));
    CHECK_ERROR(aclrtCreateEvent(&event));
    
    // 查询创建后的event状态
    CHECK_ERROR(aclrtQueryEventStatus(event, &eventStatus));
    INFO_LOG("After create event, current event status is %d.", eventStatus);
    
    // 开始做长任务
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    INFO_LOG("Applied resource successfully, beging assigning task.");
    INFO_LOG("Begin a long task.");
    LongOP(blockDim, stream, numDevice);
    CHECK_ERROR(aclrtRecordEvent(event, stream));

    // 查询同步后的event状态
    CHECK_ERROR(aclrtQueryEventStatus(event, &eventStatus));
    INFO_LOG("0 is incompleted, 1 is completed.");
    INFO_LOG("After record but before synchronize, current event status is %d.", eventStatus);
    
    // 查询同步后的event状态
    CHECK_ERROR(aclrtSynchronizeEvent(event));
    CHECK_ERROR(aclrtQueryEventStatus(event, &eventStatus));
    INFO_LOG("After synchronize, current event status is %d.", eventStatus);
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("The answer is %d.", num);

    // 释放资源
    CHECK_ERROR(aclrtFree(numDevice));
    CHECK_ERROR(aclrtDestroyEvent(event));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    aclFinalize();
    INFO_LOG("Resource cleanup completed.");
}