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
#include "log/adx_log.h"
#include "dump_manager.h"
#include "sys_utils.h"
#include "dump_args.h"
#include "dump_tensor_plugin.h"
#include "dump_core.h"
#include "dump_memory.h"
#include "exception_dumper.h"

namespace Adx {
namespace {
// Timeout Threshod For Fast Recovery
constexpr uint32_t TIMEOUT_THRESHOLD = 500U;
}  // namespace

int32_t ExceptionDumper::LoadTensorPluginLib()
{
    // no tensor use the plugin feature
    return DumpTensorPlugin::Instance().InitPluginLib();
}

int32_t ExceptionDumper::DumpArgsException(const rtExceptionInfo &exception, const std::string &dumpPath) const
{
    // L0 exception dump: support fast recovery
    uint32_t timeout = 0;
    rtError_t ret = rtGetOpExecuteTimeoutV2(&timeout);
    if (ret != ACL_RT_SUCCESS) {
        IDE_LOGE("Get operator timeout failed, ret: %d", ret);
    } else {
        IDE_LOGI("Get operator timeout %ums", timeout);
        if (timeout < TIMEOUT_THRESHOLD) {
            IDE_LOGE("Operator timeout %ums, enable fast recovery, not dump data to file.", timeout);
            ret = DumpArgsExceptionFastRecovery(exception);
            return ADUMP_SUCCESS;
        }
    }

    return DumpArgsExceptionInner(exception, dumpPath);
}

int32_t ExceptionDumper::DumpArgsExceptionFastRecovery(const rtExceptionInfo &exception) const
{
    // copy exception and other data for thread because of RTS free item after exception callback
    void *exceptionCopy = DumpMemory::CopyHostToHost(&exception, sizeof(rtExceptionInfo));
    if (exceptionCopy == nullptr) {
        IDE_LOGE("Copy rtExceptionInfo failed.");
        return ADUMP_FAILED;
    }
    std::thread([exceptionCopy]()
    {
        DumpArgs args;
        rtExceptionInfo* exceptionPtr = static_cast<rtExceptionInfo*>(exceptionCopy);
        rtError_t ret = rtSetDevice(exceptionPtr->deviceid);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("Execute rtSetDevice on device %u failed with result %d", exceptionPtr->deviceid, ret);
        }
        // only print args information but not dump to file
        if (args.LoadArgsExceptionInfo(*exceptionPtr) != ADUMP_SUCCESS) {
            IDE_LOGE("Fast recovery LoadArgsExceptionInfo failed.");
        }
        void* exceptionFree = static_cast<void*>(exceptionPtr);
        DumpMemory::FreeHost(exceptionFree);
    }).detach();
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpDetailException(const rtExceptionInfo &exception, const std::string &dumpPath)
{
    if (coredumpEnableComplete_) {
        std::lock_guard<std::mutex> lock(mutex_);
        DumpCore core(dumpPath, exception.deviceid);
        if (core.DumpCoreFile(exception) != ADUMP_SUCCESS) {
            return ADUMP_FAILED;
        }
        // exit the process after detail exception dump
        Exit();
    } else {
        IDE_CTRL_VALUE_WARN(LoadTensorPluginLib() == ADUMP_SUCCESS, return ADUMP_FAILED,
            "Load tersor custom plugin failed.");
        // detail exception dump downgrade to L0 exception dump
        return DumpArgsException(exception, dumpPath);
    }
    return ADUMP_SUCCESS;
}
}