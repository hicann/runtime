/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string>
#include <memory>
#include <climits>
#include <dlfcn.h>
#include "securec.h"
#include "bqs_log.h"
#include "bqs_feature_ctrl.h"
#include "bqs_util.h"

namespace bqs {
constexpr const char *NPU_LOG_SO_NAME = "/runtime/lib64/libunified_dlog.so";
constexpr const char *ALOG_SO_NAME = "/runtime/lib64/libascendalog.so";
constexpr const uint32_t LOG_BUFFER_MAX = 1024U;
void *hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_MAXID)];
using CheckLogLevelFunc = int32_t (int32_t, int32_t);
using DlogRecordFunc = void (int32_t, int32_t, const char *, ...);
using DlogSetLevelFunc = int32_t (int32_t, int32_t, int32_t);
using DlogSetAttrFunc = int32_t (LogAttr);

HostQsLog &HostQsLog::GetInstance()
{
    static HostQsLog instance;
    return instance;
}

void *HostQsLog::OpenLogSoOne(std::string ascendAicpuPath, const char *soName) const
{
    std::string hostLogSoPath = ascendAicpuPath.append(soName);
    std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        return nullptr;
    }

    auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        return nullptr;
    }
 
    if (realpath(hostLogSoPath.data(), path.get()) == nullptr) {
        return nullptr;
    }
    void *logSoHandle = dlopen(path.get(), static_cast<int32_t>(
                               static_cast<uint32_t>(RTLD_LAZY) | (static_cast<uint32_t>(RTLD_GLOBAL))));
    return logSoHandle;
}

void *HostQsLog::OpenLogSo() const
{
    if (!bqs::FeatureCtrl::IsHostQs()) {
        return nullptr;
    }
    std::string ascendAicpuPath;
    bqs::GetEnvVal("ASCEND_AICPU_PATH", ascendAicpuPath);
    if (ascendAicpuPath.empty()) {
        return nullptr;
    }
    void *logSoHandle = OpenLogSoOne(ascendAicpuPath, NPU_LOG_SO_NAME);
    if (logSoHandle == nullptr) {
        logSoHandle = OpenLogSoOne(ascendAicpuPath, ALOG_SO_NAME);
    }
    if (logSoHandle != nullptr) {
        std::string funcName = "CheckLogLevel";
        hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_CHECKLOGLEVEL)] = dlsym(logSoHandle, funcName.c_str());
        funcName = "DlogRecord";
        hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGRECORD)] = dlsym(logSoHandle, funcName.c_str());
        funcName = "dlog_setlevel";
        hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGSETLEVEL)] = dlsym(logSoHandle, funcName.c_str());
        funcName = "DlogSetAttr";
        hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGSETATTR)] = dlsym(logSoHandle, funcName.c_str());
    }
    return logSoHandle;
}

void HostQsLog::LogPrintNormal(const int32_t moduleId, const int32_t level, const char *fmt, ...) const
{
    if ((hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_CHECKLOGLEVEL)] != nullptr) &&
        (hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGRECORD)] != nullptr)) {
        CheckLogLevelFunc *checkLogLevel = PtrToPtr<void, CheckLogLevelFunc>(
            hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_CHECKLOGLEVEL)]);
        if (checkLogLevel(moduleId, level) != 1) {
            return;
        }
        char buffer[LOG_BUFFER_MAX];
        va_list args;
        va_start(args, fmt);
        vsnprintf_s(buffer, sizeof(buffer), LOG_BUFFER_MAX, fmt, args);
        va_end(args);
        DlogRecordFunc *dlogRecord = PtrToPtr<void, DlogRecordFunc>(
            hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGRECORD)]);
        dlogRecord(moduleId, level, buffer);
    }
}

void HostQsLog::LogPrintError(const int32_t moduleId, const char *fmt, ...) const
{
    if (hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGRECORD)] != nullptr) {
        char buffer[LOG_BUFFER_MAX];
        va_list args;
        va_start(args, fmt);
        vsnprintf_s(buffer, sizeof(buffer), LOG_BUFFER_MAX, fmt, args);
        va_end(args);
        DlogRecordFunc *dlogRecord = PtrToPtr<void, DlogRecordFunc>(
            hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGRECORD)]);        
        dlogRecord(moduleId, DLOG_ERROR, buffer);
    }
}

void HostQsLog::DlogSetLevel(const int32_t logLevel, const int32_t eventLevel) const
{
    if (hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGSETLEVEL)] != nullptr) {
        DlogSetLevelFunc *dlogSetLevel = PtrToPtr<void, DlogSetLevelFunc>(
            hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGSETLEVEL)]);
        if (dlogSetLevel(-1, logLevel, eventLevel) != 0) {
            BQS_LOG_WARN_HOST("Set log level failed");
        }
    }
}

void HostQsLog::DlogSetAttr(const LogAttr logAttrInfo) const
{
    if (hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGSETATTR)] != nullptr) {
        DlogSetAttrFunc *dlogSetAttr = PtrToPtr<void, DlogSetAttrFunc>(
            hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_DLOGSETATTR)]);
        if (dlogSetAttr(logAttrInfo) != 0) {
            BQS_LOG_WARN_HOST("Set log attr failed");
        }
    }
}

bool HostQsLog::CheckLogLevelHost(const int32_t moduleId, const int32_t logLevel) const
{
    if (hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_CHECKLOGLEVEL)] != nullptr) {
        CheckLogLevelFunc *checkLogLevel = PtrToPtr<void, CheckLogLevelFunc>(
            hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_CHECKLOGLEVEL)]);
        if (checkLogLevel(moduleId, logLevel) == 1) {
            return true;
        }
    }
    return false;
}

bool HostQsLog::CheckLogLevel(const int32_t moduleId, const int32_t logLevel) const
{
    if (bqs::FeatureCtrl::IsHostQs()) {
        if (bqs::HostQsLog::GetInstance().CheckLogLevelHost(moduleId, logLevel)) {
            return true;
        }
    } else {
        if (CheckLogLevelAicpu(moduleId, logLevel)) {
            return true;
        }   
    }
    return false;
}
}

namespace {
void *g_logSoHandle = nullptr;
}

static void __attribute__((constructor)) QsLogInit(void)
{
    if (bqs::FeatureCtrl::IsHostQs()) {
        g_logSoHandle = bqs::HostQsLog::GetInstance().OpenLogSo();
    }
}

static void __attribute__((destructor)) QsLogUnInit(void)
{
    if (g_logSoHandle != nullptr) {
        dlclose(g_logSoHandle);
    }
}