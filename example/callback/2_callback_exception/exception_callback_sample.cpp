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
#include <sstream>
#include "utils.h"
#include "acl/acl.h"
#include "callback_utils.h"
#include "exception_callback_sample.h"

using namespace std;

// 核函数，让x自增1
extern void EasyOP(uint32_t coreDim, void *stream, uint32_t* x);
// 核函数，执行后出错
extern void ErrorOP(uint32_t blockDim, void *stream);
aclrtContext ExceptionCallBackSpace::ExceptionCallBackSample::context_ = nullptr;
aclrtStream ExceptionCallBackSpace::ExceptionCallBackSample::stream_ = nullptr;
int32_t ExceptionCallBackSpace::ExceptionCallBackSample::deviceId_ = 0;

ExceptionCallBackSpace::ExceptionCallBackSample::ExceptionCallBackSample() = default;

ExceptionCallBackSpace::ExceptionCallBackSample::~ExceptionCallBackSample()
{
    (void)Destroy();
}

int ExceptionCallBackSpace::ExceptionCallBackSample::Init()
{
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId_));
    CHECK_ERROR(aclrtCreateContext(&context_, deviceId_));
    CHECK_ERROR(aclrtCreateStream(&stream_));
    CHECK_ERROR(aclrtSetStreamFailureMode(stream_, ACL_STOP_ON_FAILURE));
}

void ExceptionCallBackSpace::ExceptionCallBackSample::ThreadFunc(void *arg)
{
    const int waitTime = 100;
    // 一定要设置用哪个上下文后再进行回调
    aclrtSetCurrentContext(context_);
    while (CallbackUtils::IsLoopFlag(arg)) {
        // 循环等待，等待回调请求然后进行回调函数。
        aclrtProcessReport(waitTime);
    }
    INFO_LOG("Thread exit");
}

void ExceptionCallBackSpace::ExceptionCallBackSample::CallBackFunc(void *arg)
{
    // 回调函数，输出入参,任务出错时，会先错误的回调，然后继续后调后续的函数。
    int *data = static_cast<int*>(arg);
    INFO_LOG("After error still callback , the userdata is: %d.", *data);
}

void ExceptionCallBackSpace::ExceptionCallBackSample::ExceptionCallBackFunc(aclrtExceptionInfo *exceptionInfo)
{
    // 错误回调函数，可以输出相关的错误信息，包括发生错误的任务，线程，设备等的id
    INFO_LOG("Exception occurred, callback function.");
    uint32_t errorMsg = 0;
    errorMsg = aclrtGetTaskIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error task id is %u.", errorMsg);
    errorMsg = aclrtGetStreamIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error stream id is %u.", errorMsg);
    errorMsg = aclrtGetThreadIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error thread id is %u.", errorMsg);
    errorMsg = aclrtGetDeviceIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error device id is %u.", errorMsg);
    errorMsg = aclrtGetErrorCodeFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error code id is %u.", errorMsg);
}
int ExceptionCallBackSpace::ExceptionCallBackSample::Callback()
{
    uint32_t num = 0;
    int blockDim = 1;
    bool isLoop = true;
    size_t size = sizeof(uint32_t);
    uint32_t *numDevice = nullptr;
    uint32_t taskId = 0;
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));
    // 创建线程进行循环等待
    thread td(ThreadFunc, &isLoop);
    thread::id tid = td.get_id();
    ostringstream oss;
    oss << tid;
    int *userData = new int(520);
    uint64_t tidInt = std::stoull(oss.str());
    CHECK_ERROR(aclrtSubscribeReport(static_cast<uint64_t>(tidInt), stream_));
    // 设置错误回调
    CHECK_ERROR(aclrtSetExceptionInfoCallback(ExceptionCallBackFunc));
    INFO_LOG("Begin a easy task and a error task, the erro task will callback exception.");
    EasyOP(blockDim, stream_, numDevice);
    // 调用错误的函数，错误导致错误回调
    ErrorOP(blockDim, stream_);
    CHECK_ERROR(aclrtGetThreadLastTaskId(&taskId));
    INFO_LOG("The last task id is: %u.", taskId);
    // 在错误任务后做一个正常回调
    CHECK_ERROR(aclrtLaunchCallback(CallBackFunc, userData, ACL_CALLBACK_BLOCK, stream_));
    // 该接口获取最后一个任务的id，也就是我们下发的错误任务，后续在错误回调的输出中可以进行对比认证。
    CHECK_ERROR_WITHOUT_RETURN(aclrtSynchronizeStream(stream_));
    CHECK_ERROR(aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("After assigning the task, the current num is: %d.", num);
    // 设置标志位结束循环等待，然后结束线程，解绑线程与stream
    isLoop = false;
    td.join();
    CHECK_ERROR(aclrtUnSubscribeReport(static_cast<uint64_t>(tidInt), stream_));
    CHECK_ERROR(aclrtFree(numDevice));
    delete userData;
}

int ExceptionCallBackSpace::ExceptionCallBackSample::Destroy()
{
    CHECK_ERROR(aclrtDestroyStreamForce(stream_));
    CHECK_ERROR(aclrtDestroyContext(context_));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId_));
    CHECK_ERROR(aclFinalize());
}