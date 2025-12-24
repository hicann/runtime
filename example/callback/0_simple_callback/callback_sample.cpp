/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <thread>
#include <iostream>
#include "utils.h"
#include "acl/acl.h"
#include "callback_utils.h"
#include "callback_sample.h"

using namespace std;

// 核函数，让x自增1
extern void LongOP(uint32_t coreDim, void *stream, uint32_t* x);
aclrtContext CallBackSpace::CallBackSample::context_ = nullptr;
aclrtStream CallBackSpace::CallBackSample::stream_ = nullptr;
int32_t CallBackSpace::CallBackSample::deviceId_ = 0;

CallBackSpace::CallBackSample::CallBackSample() = default;

CallBackSpace::CallBackSample::~CallBackSample()
{
    (void)Destroy();
}

int CallBackSpace::CallBackSample::Init()
{
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId_));
    CHECK_ERROR(aclrtCreateContext(&context_, deviceId_));
    CHECK_ERROR(aclrtCreateStream(&stream_));
    CHECK_ERROR(aclrtSetStreamFailureMode(stream_, ACL_STOP_ON_FAILURE));
}

void CallBackSpace::CallBackSample::ThreadFunc(void *arg)
{
    const int waitTime = 100;
    // 一定要设置用哪个上下文后再进行回调
    aclrtSetCurrentContext(context_);
    // 必须在创建的线程内通过循环调用等待函数，该等待函数在收到回调时回去执行。
    while (CallbackUtils::IsLoopFlag(arg)) {
        aclrtProcessReport(waitTime);
    }
    INFO_LOG("Thread exit");
}

void CallBackSpace::CallBackSample::CallBackBeforeLaunchFunc(void *arg)
{
    // 下发任务前回调函数，输出以下当前函数所使用的线程id，可以对比发现为之前创建的线程而非主线程。
    thread::id tid = std::this_thread::
    get_id();
    string tidStr = CallbackUtils::GetThreadId(tid);
    INFO_LOG("Callback thread id is %s", tidStr.c_str());
    int *data = static_cast<int*>(arg);
    INFO_LOG("This callback before task, result: user data is: %d.", *data);
}

void CallBackSpace::CallBackSample::CallBackFunc(void *arg)
{
    // 回调函数，输出以下当前函数所使用的线程id，可以对比发现为之前创建的线程而非主线程。
    thread::id tid = std::this_thread::get_id();
    string tidStr = CallbackUtils::GetThreadId(tid);
    INFO_LOG("Callback thread id is %s", tidStr.c_str());
    int *data = static_cast<int*>(arg);
    INFO_LOG("This callback after task and loop five times, result: user data is: %d.", *data);
}

int CallBackSpace::CallBackSample::Callback()
{
    uint32_t num = 0;
    int blockDim = 1;
    bool isLoop = true;
    size_t size = sizeof(uint32_t);
    uint32_t *numDevice = nullptr;
    const int count = 5;
    thread::id tid;
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    // 创建线程并获取线程Id
    thread td(ThreadFunc, &isLoop);
    tid = std::this_thread::get_id();
    string mainThreadId = CallbackUtils::GetThreadId(tid);
    // 打印主线程id以及创建线程的id
    INFO_LOG("The main thread id is %s", mainThreadId.c_str());
    tid = td.get_id();
    string createdThreadId = CallbackUtils::GetThreadId(tid);
    INFO_LOG("The created thread id is %s", createdThreadId.c_str());
    int *userData = new int(520);
    uint64_t tidInt = std::stoull(createdThreadId);
    // 绑定stream和创建的线程，后续回调函数会在该线程上执行
    CHECK_ERROR(aclrtSubscribeReport(static_cast<uint64_t>(tidInt), stream_));
    CHECK_ERROR(aclrtLaunchCallback(CallBackBeforeLaunchFunc, userData, ACL_CALLBACK_BLOCK, stream_));
    LongOP(blockDim, stream_, numDevice);
    INFO_LOG("After begin a task, launch five callback.");
    // 下发多少次回调就会执行多少次，这里循环下发就循环执行
    for (int i = 0; i < count; i++) {
        CHECK_ERROR(aclrtLaunchCallback(CallBackFunc, userData, ACL_CALLBACK_BLOCK, stream_));
    }
    CHECK_ERROR(aclrtSynchronizeStream(stream_));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After assigning the task, the current int is: %d.", num);
    // 设置标志位结束循环等待，然后结束线程，解绑线程与stream
    isLoop = false;
    td.join();
    CHECK_ERROR(aclrtUnSubscribeReport(static_cast<uint64_t>(tidInt), stream_));
    CHECK_ERROR(aclrtFree(numDevice));
    delete userData;
}

int CallBackSpace::CallBackSample::Destroy()
{
    CHECK_ERROR(aclrtDestroyStreamForce(stream_));
    CHECK_ERROR(aclrtDestroyContext(context_));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId_));
    CHECK_ERROR(aclFinalize());
}