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
#include "kernel_func/kernel_ops.h"
#include "callback_utils.h"
#include "exception_callback_sample.h"

using namespace std;
aclrtContext ExceptionCallBackSpace::ExceptionCallBackSample::context_ = nullptr;
aclrtStream ExceptionCallBackSpace::ExceptionCallBackSample::stream_ = nullptr;
int32_t ExceptionCallBackSpace::ExceptionCallBackSample::deviceId_ = 0;

namespace {
const char *SafeString(const char *message)
{
    return message != nullptr ? message : "<null>";
}

void LogRuntimeErrorState(int32_t deviceId, const char *stage)
{
    aclrtErrorInfo errorInfo = {};
    aclError verboseRet = aclrtGetErrorVerbose(deviceId, &errorInfo);
    if (verboseRet == ACL_SUCCESS) {
        INFO_LOG("%s verbose error info: errorType=%d, tryRepair=%u, hasDetail=%u",
            stage,
            static_cast<int32_t>(errorInfo.errorType),
            static_cast<uint32_t>(errorInfo.tryRepair),
            static_cast<uint32_t>(errorInfo.hasDetail));
    } else {
        WARN_LOG("%s aclrtGetErrorVerbose failed with error code %d", stage, static_cast<int32_t>(verboseRet));
    }

    aclError peekError = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
    aclError lastError = aclrtGetLastError(ACL_RT_THREAD_LEVEL);
    const char *recentErrMsg = aclGetRecentErrMsg();
    ERROR_LOG("%s runtime diagnostics: peekErr=%d, lastErr=%d, recentErrMsg=%s",
        stage,
        static_cast<int32_t>(peekError),
        static_cast<int32_t>(lastError),
        SafeString(recentErrMsg));
}
} // namespace

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
    return 0;
}

void ExceptionCallBackSpace::ExceptionCallBackSample::ThreadFunc(void *arg)
{
    const int waitTime = 100;
    aclrtSetCurrentContext(context_);
    while (CallbackUtils::IsLoopFlag(arg)) {
        aclrtProcessReport(waitTime);
    }
    INFO_LOG("Thread exit");
}

void ExceptionCallBackSpace::ExceptionCallBackSample::CallBackFunc(void *arg)
{
    int *data = static_cast<int*>(arg);
    INFO_LOG("After error still callback, the userdata is: %d.", *data);
}

void ExceptionCallBackSpace::ExceptionCallBackSample::ExceptionCallBackFunc(aclrtExceptionInfo *exceptionInfo)
{
    INFO_LOG("Exception occurred, callback function.");
    uint32_t errorMsg = aclrtGetTaskIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error task id is %u.", errorMsg);
    errorMsg = aclrtGetStreamIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error stream id is %u.", errorMsg);
    errorMsg = aclrtGetThreadIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error thread id is %u.", errorMsg);
    errorMsg = aclrtGetDeviceIdFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error device id is %u.", errorMsg);
    errorMsg = aclrtGetErrorCodeFromExceptionInfo(exceptionInfo);
    INFO_LOG("The error code id is %u.", errorMsg);

    void *devArgsPtr = nullptr;
    uint32_t devArgsLen = 0;
    aclError argsRet = aclrtGetArgsFromExceptionInfo(exceptionInfo, &devArgsPtr, &devArgsLen);
    INFO_LOG("Exception args query ret=%d, devArgsPtr=%p, devArgsLen=%u",
        static_cast<int32_t>(argsRet), devArgsPtr, devArgsLen);

    aclrtFuncHandle funcHandle = nullptr;
    aclError funcRet = aclrtGetFuncHandleFromExceptionInfo(exceptionInfo, &funcHandle);
    INFO_LOG("Exception func handle query ret=%d, funcHandle=%p",
        static_cast<int32_t>(funcRet), funcHandle);
}

int ExceptionCallBackSpace::ExceptionCallBackSample::Callback()
{
    uint32_t num = 0;
    const int blockDim = 1;
    bool isLoop = true;
    const size_t size = sizeof(uint32_t);
    uint32_t *numDevice = nullptr;
    uint32_t taskId = 0;
    CHECK_ERROR(aclrtMalloc((void **)&numDevice, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(numDevice, size, &num, size, ACL_MEMCPY_HOST_TO_DEVICE));

    thread td(ThreadFunc, &isLoop);
    thread::id tid = td.get_id();
    ostringstream oss;
    oss << tid;
    int *userData = new int(520);
    uint64_t tidInt = std::stoull(oss.str());
    CHECK_ERROR(aclrtSubscribeReport(tidInt, stream_));
    CHECK_ERROR(aclrtSetExceptionInfoCallback(ExceptionCallBackFunc));
    INFO_LOG("Begin a easy task and a error task, the error task will callback exception.");

    EasyOP(blockDim, stream_, numDevice);
    ErrorOP(blockDim, stream_);
    CHECK_ERROR(aclrtGetThreadLastTaskId(&taskId));
    INFO_LOG("The last task id is: %u.", taskId);
    CHECK_ERROR(aclrtLaunchCallback(CallBackFunc, userData, ACL_CALLBACK_BLOCK, stream_));

    aclError syncRet = aclrtSynchronizeStream(stream_);
    if (syncRet != ACL_SUCCESS) {
        ERROR_LOG("aclrtSynchronizeStream(stream_) returned error code %d", static_cast<int32_t>(syncRet));
        LogRuntimeErrorState(deviceId_, "Post synchronize diagnostics");
    }

    aclError memcpyRet = aclrtMemcpy(&num, size, numDevice, size, ACL_MEMCPY_DEVICE_TO_HOST);
    if (memcpyRet == ACL_SUCCESS) {
        INFO_LOG("After assigning the task, the current num is: %d.", num);
    } else {
        ERROR_LOG("aclrtMemcpy after error returned error code %d", static_cast<int32_t>(memcpyRet));
    }

    isLoop = false;
    td.join();
    CHECK_ERROR(aclrtUnSubscribeReport(tidInt, stream_));
    CHECK_ERROR(aclrtFree(numDevice));
    delete userData;
    return 0;
}

int ExceptionCallBackSpace::ExceptionCallBackSample::Destroy()
{
    CHECK_ERROR(aclrtDestroyStreamForce(stream_));
    CHECK_ERROR(aclrtDestroyContext(context_));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId_));
    CHECK_ERROR(aclFinalize());
    return 0;
}