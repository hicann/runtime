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
#include "kernel_func/kernel_ops.h"
#include "callback_sample.h"

using namespace std;
aclrtContext CallBackSpace::CallBackSample::context_ = nullptr;
aclrtStream CallBackSpace::CallBackSample::stream_ = nullptr;
int32_t CallBackSpace::CallBackSample::deviceId_ = 0;

CallBackSpace::CallBackSample::CallBackSample() = default;

CallBackSpace::CallBackSample::~CallBackSample() { (void)Destroy(); }

int CallBackSpace::CallBackSample::Init()
{
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId_));
    CHECK_ERROR(aclrtCreateContext(&context_, deviceId_));
    CHECK_ERROR(aclrtCreateStream(&stream_));
    CHECK_ERROR(aclrtSetStreamFailureMode(stream_, ACL_STOP_ON_FAILURE));
    return 0;
}

void CallBackSpace::CallBackSample::CallBackBeforeLaunchFunc(void* arg)
{
    int* data = static_cast<int*>(arg);
    INFO_LOG("This callback before task, result: user data is: %d.", *data);
}

void CallBackSpace::CallBackSample::CallBackFunc(void* arg)
{
    int* data = static_cast<int*>(arg);
    INFO_LOG("This callback after task, result: user data is: %d.", *data);
}

int CallBackSpace::CallBackSample::Callback()
{
    uint32_t num = 0;
    const int blockDim = 1;
    const size_t size = sizeof(uint32_t);
    uint32_t* numDevice = nullptr;
    CHECK_ERROR(aclrtMalloc((void**)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));

    int* userData = new int(520);
    CHECK_ERROR(aclrtLaunchHostFunc(stream_, CallBackBeforeLaunchFunc, userData));
    LongOP(blockDim, stream_, numDevice);
    INFO_LOG("After begin a task, launch one hostfunc.");
    CHECK_ERROR(aclrtLaunchHostFunc(stream_, CallBackFunc, userData));

    CHECK_ERROR(aclrtSynchronizeStream(stream_));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After assigning the task, the current int is: %d.", num);

    CHECK_ERROR(aclrtFree(numDevice));
    delete userData;
    return 0;
}

int CallBackSpace::CallBackSample::Destroy()
{
    CHECK_ERROR(aclrtDestroyStreamForce(stream_));
    CHECK_ERROR(aclrtDestroyContext(context_));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId_));
    CHECK_ERROR(aclFinalize());
    return 0;
}
