/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <set>
#include <cctype>
#include <cstring>
#include <algorithm>
#include "log/adx_log.h"
#include "path.h"
#include "dump_manager.h"
#include "sys_utils.h"
#include "dump_args.h"
#include "dump_args_callback.h"
#include "dump_file.h"
#include "exception_info_common.h"
#include "kernel_info_collector.h"
#include "exception_dumper.h"

namespace Adx {
namespace {
constexpr char DEFAULT_DUMP_PATH[] = "./";
constexpr char EXTRA_DUMP_PATH[] = "/extra-info/data-dump/";
constexpr size_t MAX_DUMP_OP_NUM = (2048U * 2048U) / 20U;

static bool IsSafeKernelDisplayName(const char *name)
{
    for (size_t i = 0; i < MAX_KERNELNAME_LEN && name[i] != '\0'; ++i) {
        char c = name[i];
        if (c == '/' || c == '\\' || c < 0x20 || c == 0x7F) {
            return false;
        }
    }
    return std::string(name).find("..") == std::string::npos;
}

bool ValidateKernelName(const ExceptionDumpInfo &info)
{
    if (strnlen(info.kernelName, MAX_KERNELNAME_LEN) == MAX_KERNELNAME_LEN ||
        strnlen(info.kernelDisplayName, MAX_KERNELNAME_LEN) == MAX_KERNELNAME_LEN) {
        return false;
    }

    if (!IsSafeKernelDisplayName(info.kernelName) || !IsSafeKernelDisplayName(info.kernelDisplayName)) {
        return false;
    }
    return true;
}
}  // namespace

uint64_t *g_dynamicChunk = nullptr;
uint64_t *g_staticChunk = nullptr;

ExceptionDumper::~ExceptionDumper()
{
    if (g_dynamicChunk != nullptr) {
        delete[] g_dynamicChunk;
        g_dynamicChunk = nullptr;
    }

    if (g_staticChunk != nullptr) {
        delete[] g_staticChunk;
        g_staticChunk = nullptr;
    }
    destructionFlag_ = true;
}

bool ExceptionDumper::InitArgsExceptionMemory() const
{
    if (g_dynamicChunk == nullptr) {
        g_dynamicChunk = new (std::nothrow) uint64_t[DYNAMIC_RING_CHUNK_SIZE + DFX_MAX_TENSOR_NUM + RESERVE_SPACE]();
        if (g_dynamicChunk == nullptr) {
            return false;
        }
    }

    if (g_staticChunk == nullptr) {
        g_staticChunk = new (std::nothrow) uint64_t[STATIC_RING_CHUNK_SIZE + DFX_MAX_TENSOR_NUM + RESERVE_SPACE]();
        if (g_staticChunk == nullptr) {
            return false;
        }
    }
    return true;
}

bool ExceptionDumper::IsRepeatEnableException(DumpType type, const DumpConfig &dumpConfig)
{
    if (type == DumpType::ARGS_EXCEPTION || type == DumpType:: EXCEPTION ||
        type == DumpType::AIC_ERR_DETAIL_DUMP) {
        std::string dumpStatus = dumpConfig.dumpStatus;
        std::transform(dumpStatus.begin(), dumpStatus.end(), dumpStatus.begin(), ::tolower);
        if (dumpStatus != "on") {
            return false;
        }
        return GetCoredumpStatus() || GetExceptionStatus() || GetArgsExceptionStatus();
    }
    return false;
}

int32_t ExceptionDumper::ExceptionDumperInit(DumpType dumpType, const DumpConfig &dumpConfig)
{
    bool status = false;
    if (!setting_.InitDumpStatus(dumpConfig.dumpStatus, status)) {
        IDE_LOGE("The value of dumpStatus: %s is invalid.", dumpConfig.dumpStatus.c_str());
        return ADUMP_FAILED;
    }

    // status = false means turn off, flag = false means not start, print warning when not start but want to turn off
    if (dumpType == DumpType::EXCEPTION) {
        IDE_CTRL_VALUE_WARN(status || exceptionStatus_, return ADUMP_SUCCESS, "dump type %d not start.", dumpType);
        exceptionStatus_ = status;
    } else if (dumpType == DumpType::ARGS_EXCEPTION) {
        IDE_CTRL_VALUE_WARN(status || argsExceptionStatus_, return ADUMP_SUCCESS, "dump type %d not start.", dumpType);
        IDE_CTRL_VALUE_FAILED(InitArgsExceptionMemory(), return ADUMP_FAILED, "Init args exception memory failed.");
        if (status && !argsExceptionStatus_) {
            IDE_CTRL_VALUE_WARN(LoadTensorPluginLib() == ADUMP_SUCCESS, return ADUMP_FAILED,
                "Load tersor custom plugin failed.");
        }
        argsExceptionStatus_ = status;
    } else {
        // detail exception dump can not off
        if (status == false) {
            static bool havePrint = false;
            if (!havePrint) {
                IDE_RUN_LOGI("Can not turn off detail exception dump.");
                havePrint = true;
            }
            IDE_LOGW("Can not turn off detail exception dump.");
            return ADUMP_SUCCESS;
        }
        IDE_CTRL_VALUE_FAILED(InitArgsExceptionMemory(), return ADUMP_FAILED, "Init args exception memory failed.");
        coredumpStatus_ = true;
    }

    SetDumpPath(dumpConfig.dumpPath);
    return ADUMP_SUCCESS;
}

bool ExceptionDumper::NeedDumpException(const rtExceptionInfo &exception) const
{
    if (exception.retcode == ACL_ERROR_RT_AICORE_OVER_FLOW || exception.retcode == ACL_ERROR_RT_AIVEC_OVER_FLOW) {
        IDE_LOGW("Ignore exception dump request, retcode: %u.", exception.retcode);
        return false;
    }
    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    if (ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
        IDE_LOGW("Get exception args info failed.");
        return false;
    }
    return true;
}

int32_t ExceptionDumper::DumpException(const rtExceptionInfo &exception)
{
    IDE_CTRL_VALUE_FAILED(!destructionFlag_, return ADUMP_FAILED, "ExceptionDumper has been destructed.");
    std::string dumpPath = CreateDeviceDumpPath(exception.deviceid);
    if (dumpPath.empty()) {
        return ADUMP_FAILED;
    }

    if (coredumpStatus_) {
        return DumpDetailException(exception, dumpPath);
    } else if (exceptionStatus_) {
        return DumpNormalException(exception, dumpPath);
    } else if (argsExceptionStatus_) {
        return DumpArgsException(exception, dumpPath);
    } else {
        IDE_LOGW("Not enable exception dump.");
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

void ExceptionDumper::SetDumpPath(const std::string &dumpPath)
{
    dumpPath_ = dumpPath.empty() ? DEFAULT_DUMP_PATH : dumpPath;
    IDE_LOGI("Update exception dump path: %s", dumpPath_.c_str());
}

void ExceptionDumper::AddDumpOperator(const OperatorInfo &opInfo)
{
    OperatorInfoV2 dumpOperator = {};
    DumpManager::Instance().ConvertOperatorInfo(opInfo, dumpOperator);
    AddDumpOperatorV2(dumpOperator);
}

void ExceptionDumper::AddDumpOperatorV2(const OperatorInfoV2 &opInfo)
{
    const std::lock_guard<std::mutex> lock(mutex_);
    if (opInfo.agingFlag) {
        agingOperators_.emplace_back(opInfo);
        if (agingOperators_.size() > MAX_DUMP_OP_NUM) {
            agingOperators_.pop_front();
        }
    } else {
        uint32_t maxStreamCount = 0;
        uint32_t maxTaskCount = 0;
        rtGetMaxStreamAndTask(0, &maxStreamCount, &maxTaskCount);
        auto &taskDeque = residentOperators_[opInfo.deviceId][opInfo.streamId];
        taskDeque.emplace_back(opInfo);
        if (taskDeque.size() > maxTaskCount) {
            taskDeque.pop_front();
        }
    }
    IDE_LOGI("Dump operator size, aging: %zu, resident: %zu", agingOperators_.size(), residentOperators_.size());
}

int32_t ExceptionDumper::DelDumpOperator(uint32_t deviceId, uint32_t streamId)
{
    const std::lock_guard<std::mutex> lock(mutex_);
    auto it = residentOperators_.find(deviceId);
    if (it != residentOperators_.end()) {
        it->second.erase(streamId);
        if (it->second.empty()) {
            residentOperators_.erase(deviceId);
        }
    }
    return ADUMP_SUCCESS;
}

std::string ExceptionDumper::CreateDumpPath(Path &dumpPath) const
{
    IDE_CTRL_VALUE_FAILED(dumpPath.CreateDirectory(true), return "", "Create path[%s] failed",
        dumpPath.GetCString());
    IDE_CTRL_VALUE_FAILED(dumpPath.RealPath(), return "", "Get RealPath of [%s] failed, strerr=%s",
        dumpPath.GetCString(), strerror(errno));
    return dumpPath.GetString();
}

std::string ExceptionDumper::CreateDeviceDumpPath(uint32_t deviceId) const
{
    // Create device dump path when exception call-backed
    std::string dumpPath = dumpPath_.empty() ? DEFAULT_DUMP_PATH : dumpPath_;
    Path deviceDumpPath(dumpPath);
    deviceDumpPath.Append(EXTRA_DUMP_PATH).Append(std::to_string(deviceId));
    return CreateDumpPath(deviceDumpPath);
}

std::string ExceptionDumper::CreateExtraDumpPath()
{
    // Create extra dump path for tensor custom dump data
    std::string dumpPath = dumpPath_.empty() ? DEFAULT_DUMP_PATH : dumpPath_;
    Path extraDumpPath(dumpPath);
    extraDumpPath.Append(EXTRA_DUMP_PATH);
    extraDumpPath_ = CreateDumpPath(extraDumpPath);
    return extraDumpPath_;
}

const char* ExceptionDumper::GetExtraDumpCPath() const
{
    return extraDumpPath_.empty() ? nullptr : extraDumpPath_.c_str();
}

bool ExceptionDumper::FindExceptionOperator(const rtExceptionInfo &exception, DumpOperator &excOp)
{
    OpIdentity excOpIdentiy(exception.deviceid, exception.taskid, exception.streamid);
    if (exception.expandInfo.type == RT_EXCEPTION_FFTS_PLUS) {
        uint32_t contextId = static_cast<uint32_t>(exception.expandInfo.u.fftsPlusInfo.contextId);
        uint32_t threadId = static_cast<uint32_t>(exception.expandInfo.u.fftsPlusInfo.threadId);
        IDE_LOGI("ffts+ op context id: %u, thread id: %u.", contextId, threadId);
        excOpIdentiy.contextId = contextId;
    }

    const std::lock_guard<std::mutex> lock(mutex_);
    IDE_LOGI("Dump op size, aging:%zu, resident:%zu, target: %s", agingOperators_.size(), residentOperators_.size(),
             excOpIdentiy.GetString().c_str());
    for (const auto &op : agingOperators_) {
        if (op.IsBelongTo(excOpIdentiy)) {
            IDE_LOGI("Find exception op in aging list: %s", excOpIdentiy.GetString().c_str());
            excOp = op;
            return true;
        }
    }

    if (residentOperators_.find(excOpIdentiy.deviceId) != residentOperators_.end()) {
        auto &streamMap = residentOperators_[excOpIdentiy.deviceId];
        if (streamMap.find(excOpIdentiy.streamId) != streamMap.end()) {
            auto &taskDeque = streamMap[excOpIdentiy.streamId];
            for (const auto &op : taskDeque) {
                if (op.IsBelongTo(excOpIdentiy)) {
                    IDE_LOGI("Find exception op in resident list: %s", excOpIdentiy.GetString().c_str());
                    excOp = op;
                    return true;
                }
            }
        }
    }

    IDE_LOGW("Not find dump operator, target: %s", excOpIdentiy.GetString().c_str());
    return false;
}

int32_t ExceptionDumper::DumpNormalException(const rtExceptionInfo &exception, const std::string &dumpPath)
{
    IDE_CTRL_VALUE_WARN(NeedDumpException(exception), return ADUMP_FAILED, "Exception is not need to dump.");
    // L1 Exception Dump
    DumpOperator excOp;
    bool find = FindExceptionOperator(exception, excOp);
    if (!find) {
        return ADUMP_SUCCESS;
    }

    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    if (ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
        IDE_LOGE("Get exception args info failed.");
        return ADUMP_FAILED;
    }
    (void)excOp.RefreshAddrs(exceptionArgsInfo);
    (void)excOp.LogExceptionInfo(exceptionArgsInfo);
    KernelInfoCollector::DumpKernelErrorSymbols(exception);
    (void)excOp.CopyOpKernelFile();

    const int32_t ret = excOp.DumpException(exception.deviceid, dumpPath);
    if (ret != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpArgsExceptionDefault(const rtExceptionInfo &exception, const std::string &dumpPath)
{
    IDE_CTRL_VALUE_WARN(NeedDumpException(exception), return ADUMP_FAILED, "Exception is not need to dump.");
    DumpArgs args;
    if (args.LoadArgsExceptionInfo(exception) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }

    KernelInfoCollector::DumpKernelErrorSymbols(exception);
    if (args.DumpArgsExceptionInfo(exception.deviceid, dumpPath) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpArgsExceptionInner(const rtExceptionInfo &exception, const std::string &dumpPath)
{
    ExceptionDumpMode dumpMode = ExceptionDumpMode::DUMP_MODE_NONE;
    std::vector<ExceptionDumpInfo> dumpInfos;
    int32_t invokeRet = InvokeCallbacks(exception, dumpInfos, dumpMode);
    if (invokeRet != ADUMP_SUCCESS) {
        return invokeRet;
    }
    if (dumpMode == ExceptionDumpMode::DUMP_MODE_OVERWRITE) {
        if (dumpInfos.empty()) {
            IDE_LOGE("OVERWRITE mode with empty callback data after validation, reject.");
            return ADUMP_FAILED;
        }
        IDE_LOGI("DumpMode of callbacks is OVERWRITE, skip default dump, dump callback data only.");
        DumpCallbackData(exception, dumpInfos, dumpPath);
        return ADUMP_SUCCESS;
    }

    if (dumpMode == ExceptionDumpMode::DUMP_MODE_ADDITIONAL) {
        if (!dumpInfos.empty()) {
            IDE_LOGI("DumpMode of callbacks is ADDITIONAL, dump callback data and default.");
            DumpCallbackData(exception, dumpInfos, dumpPath);
        }
    }

    return DumpArgsExceptionDefault(exception, dumpPath);
}

int32_t ExceptionDumper::InvokeCallbacks(const rtExceptionInfo &exception,
                                         std::vector<ExceptionDumpInfo> &dumpInfos,
                                         ExceptionDumpMode &dumpMode)
{
    dumpMode = ExceptionDumpMode::DUMP_MODE_NONE;
    dumpInfos.clear();
    
    std::lock_guard<std::recursive_mutex> lock(callbackMutex_);
    if (callbacks_.empty()) {
        IDE_LOGI("No callbacks registered.");
        return ADUMP_SUCCESS;
    }

    uint32_t maxDumpSize = 0;
    rtExceptionErrRegInfo_t *errRegInfo = nullptr;
    rtError_t rtRet = rtGetExceptionRegInfo(&exception, &errRegInfo, &maxDumpSize);
    IDE_CTRL_VALUE_WARN(rtRet == RT_ERROR_NONE && maxDumpSize != 0, return ADUMP_FAILED,
        "rtGetExceptionRegInfo failed, ret=%d, coreNum=%u.", rtRet, maxDumpSize);
    
    IDE_LOGI("Callbacks size=%zu, maxDumpSize=%u.", callbacks_.size(), maxDumpSize);
    
    for (auto &callback : callbacks_) {       
        std::vector<ExceptionDumpInfo> cbDumpInfos(maxDumpSize);
        
        uint32_t cbDumpRealSize = 0;
        ExceptionDumpMode cbDumpMode = ExceptionDumpMode::DUMP_MODE_NONE;

        uint32_t ret = callback(reinterpret_cast<void*>(const_cast<rtExceptionInfo*>(&exception)), cbDumpInfos.data(),
                                maxDumpSize, &cbDumpRealSize, &cbDumpMode);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGW("Callback execute failed. ret=%u", ret);
            continue;
        }
        if (cbDumpRealSize == 0 || cbDumpRealSize > maxDumpSize) {
            IDE_LOGW("Callback dumpRealSize invalid. maxDumpSize=%u, dumpRealSize=%u", maxDumpSize, cbDumpRealSize);
            continue;
        }

        IDE_LOGI("Callback dumpRealSize=%u, dumpMode=%d.", cbDumpRealSize, cbDumpMode);
        for (uint32_t i = 0; i < cbDumpRealSize; ++i) {
            if (!ValidateKernelName(cbDumpInfos[i])) {
                IDE_LOGW("Invalid kernelName/kernelDisplayName in callback data, skip. index=%u", i);
                continue;
            }
            dumpInfos.push_back(cbDumpInfos[i]);
        }
        
        // 多回调聚合时取优先级最高者：ADDITIONAL > OVERWRITE > NONE
        if (static_cast<uint32_t>(cbDumpMode) > static_cast<uint32_t>(dumpMode)) {
            dumpMode = cbDumpMode;
        }
    }
    
    IDE_LOGI("Callback final dumpMode=%d, dumpInfo total size=%zu.", dumpMode, dumpInfos.size());
    return ADUMP_SUCCESS;
}

void ExceptionDumper::DumpCallbackData(const rtExceptionInfo &exception,
                                       const std::vector<ExceptionDumpInfo> &dumpInfos,
                                       const std::string &dumpPath)
{
    for (const auto &info : dumpInfos) {
        IDE_LOGE("Callback dump info. coreType=%u, coreId=%u, argAddr=%p, argSize=%u, bin=%p, extraTensorNum=%u.",
            info.coreType, info.coreId, info.argAddr, info.argSize, info.bin, info.extraTensorNum);
        IDE_LOGE("Callback kernelName=%s, kernelDisplayName=%s", info.kernelName, info.kernelDisplayName);
        DumpArgsCallback callbackProcessor(exception, info, dumpPath);
        int32_t ret = callbackProcessor.DumpDfxArgs();
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGW("Dump callback args failed.");
        }
        
        ret = callbackProcessor.DumpExtraTensors();
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGW("Dump callback extra tensor failed.");
        }

        ret = callbackProcessor.Dump();
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGW("Dump callback data to file failed.");
        }

        ret = callbackProcessor.DumpKernelBin();
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGW("Dump callback kernel bin failed.");
        }
        IDE_LOGI("Dump callback data finished, kernelName=%s.", info.kernelName);
    }
    IDE_LOGI("Dump all callback data success.");
}

void ExceptionDumper::ExceptionModeDowngrade()
{
    coredumpEnableComplete_ = false;
}

void ExceptionDumper::Exit() const
{
    IDE_LOGE("The process exits.");
    AdxLogFlush();
#ifndef __ADUMP_LLT
    _exit(EXIT_FAILURE);
#endif
}

#ifdef __ADUMP_LLT
void ExceptionDumper::Reset()
{
    const std::lock_guard<std::mutex> lock(mutex_);
    agingOperators_.clear();
    residentOperators_.clear();
    exceptionStatus_ = false;
    argsExceptionStatus_ = false;
    coredumpStatus_ = false;
    coredumpEnableComplete_ = true;
}
#endif

int32_t ExceptionDumper::RegisterExceptionDumpCallback(ExceptionDumpCallback callback)
{
    if (callback == nullptr) {
        IDE_LOGE("Register callback is nullptr.");
        return ADUMP_INPUT_FAILED;
    }
    
    const std::lock_guard<std::recursive_mutex> lock(callbackMutex_);
    for (auto &cb : callbacks_) {
        if (cb == callback) {
            IDE_LOGW("Callback already registered.");
            return ADUMP_SUCCESS;
        }
    }
    callbacks_.push_back(callback);
    IDE_LOGI("Callback registered, total=%zu.", callbacks_.size());
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::UnregisterExceptionDumpCallback(ExceptionDumpCallback callback)
{
    if (callback == nullptr) {
        IDE_LOGE("Unregister callback is nullptr.");
        return ADUMP_INPUT_FAILED;
    }
    
    const std::lock_guard<std::recursive_mutex> lock(callbackMutex_);
    for (auto it = callbacks_.begin(); it != callbacks_.end(); ++it) {
        if (*it == callback) {
            callbacks_.erase(it);
            IDE_LOGI("Callback unregistered, total=%zu.", callbacks_.size());
            return ADUMP_SUCCESS;
        }
    }
    IDE_LOGW("Callback not found.");
    return ADUMP_SUCCESS;
}

}  // namespace Adx
