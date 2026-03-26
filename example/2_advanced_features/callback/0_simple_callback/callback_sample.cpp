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
#include "kernel_func/kernel_ops.h"
#include "callback_utils.h"
#include "callback_sample.h"

using namespace std;
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
    return 0;
}

void CallBackSpace::CallBackSample::ThreadFunc(void *arg)
{
    const int waitTime = 100;
    aclError ret = aclrtSetCurrentContext(context_);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("aclrtSetCurrentContext failed in report thread: %d", static_cast<int32_t>(ret));
        return;
    }
    while (CallbackUtils::IsLoopFlag(arg)) {
        aclrtProcessReport(waitTime);
    }
    INFO_LOG("Report callback thread exit");
}

void CallBackSpace::CallBackSample::HostFuncThreadFunc(void *arg)
{
    const int waitTime = 100;
    aclError ret = aclrtSetCurrentContext(context_);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("aclrtSetCurrentContext failed in hostfunc thread: %d", static_cast<int32_t>(ret));
        return;
    }
    while (CallbackUtils::IsLoopFlag(arg)) {
        aclrtProcessHostFunc(waitTime);
    }
    INFO_LOG("Hostfunc processing thread exit");
}

void CallBackSpace::CallBackSample::CallBackBeforeLaunchFunc(void *arg)
{
    thread::id tid = std::this_thread::get_id();
    string tidStr = CallbackUtils::GetThreadId(tid);
    INFO_LOG("Report callback thread id is %s", tidStr.c_str());
    int *data = static_cast<int*>(arg);
    INFO_LOG("This callback before task, result: user data is: %d.", *data);
}

void CallBackSpace::CallBackSample::CallBackFunc(void *arg)
{
    thread::id tid = std::this_thread::get_id();
    string tidStr = CallbackUtils::GetThreadId(tid);
    INFO_LOG("Report callback thread id is %s", tidStr.c_str());
    int *data = static_cast<int*>(arg);
    INFO_LOG("This callback after task and loop five times, result: user data is: %d.", *data);
}

void CallBackSpace::CallBackSample::HostFunc(void *arg)
{
    thread::id tid = std::this_thread::get_id();
    string tidStr = CallbackUtils::GetThreadId(tid);
    INFO_LOG("Hostfunc callback thread id is %s", tidStr.c_str());
    int *data = static_cast<int*>(arg);
    INFO_LOG("Hostfunc executed in subscribed thread, user data is: %d.", *data);
}

int CallBackSpace::CallBackSample::Callback()
{
    uint32_t num = 0;
    const int blockDim = 1;
    bool isReportLoop = true;
    bool isHostFuncLoop = true;
    const size_t size = sizeof(uint32_t);
    uint32_t *numDevice = nullptr;
    const int count = 5;
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));

    thread reportThread(ThreadFunc, &isReportLoop);
    thread hostFuncThread(HostFuncThreadFunc, &isHostFuncLoop);

    string mainThreadId = CallbackUtils::GetThreadId(std::this_thread::get_id());
    string reportThreadId = CallbackUtils::GetThreadId(reportThread.get_id());
    string hostFuncThreadId = CallbackUtils::GetThreadId(hostFuncThread.get_id());
    INFO_LOG("The main thread id is %s", mainThreadId.c_str());
    INFO_LOG("The created report thread id is %s", reportThreadId.c_str());
    INFO_LOG("The created hostfunc thread id is %s", hostFuncThreadId.c_str());

    int *userData = new int(520);
    uint64_t reportTidInt = std::stoull(reportThreadId);
    uint64_t hostFuncTidInt = std::stoull(hostFuncThreadId);
    CHECK_ERROR(aclrtSubscribeReport(reportTidInt, stream_));
    CHECK_ERROR(aclrtSubscribeHostFunc(hostFuncTidInt, stream_));

    CHECK_ERROR(aclrtLaunchCallback(CallBackBeforeLaunchFunc, userData, ACL_CALLBACK_BLOCK, stream_));
    LongOP(blockDim, stream_, numDevice);
    CHECK_ERROR(aclrtLaunchHostFunc(stream_, HostFunc, userData));
    INFO_LOG("After begin a task, launch one hostfunc and five callbacks.");
    for (int i = 0; i < count; i++) {
        CHECK_ERROR(aclrtLaunchCallback(CallBackFunc, userData, ACL_CALLBACK_BLOCK, stream_));
    }

    CHECK_ERROR(aclrtSynchronizeStream(stream_));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After assigning the task, the current int is: %d.", num);

    isReportLoop = false;
    isHostFuncLoop = false;
    reportThread.join();
    hostFuncThread.join();
    CHECK_ERROR(aclrtUnSubscribeReport(reportTidInt, stream_));
    CHECK_ERROR(aclrtUnSubscribeHostFunc(hostFuncTidInt, stream_));
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