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
#include <thread>
#include "mmpa_api.h"
#include "log/adx_log.h"
#include "path.h"
#include "dump_manager.h"
#include "sys_utils.h"
#include "dump_args.h"
#include "exception_info_common.h"
#include "dump_tensor_plugin.h"
#include "dump_core.h"
#include "dump_memory.h"
#include "kernel_info_collector.h"
#include "exception_dumper.h"

namespace Adx {
namespace {
constexpr char DEFAULT_DUMP_PATH[] = "./";
constexpr char EXTRA_DUMP_PATH[] = "/extra-info/data-dump/";
constexpr size_t MAX_DUMP_OP_NUM = (2048U * 2048U) / 20U;
constexpr uint32_t TIMEOUT_THRESHOLD = 500U;
}  // namespace

// AdumpGetDFXInfoAddr chunk
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
            IDE_CTRL_VALUE_WARN(DumpTensorPlugin::Instance().InitPluginLib() == ADUMP_SUCCESS, return ADUMP_FAILED,
                "Unable to initialize plugin function.");
        }
        argsExceptionStatus_ = status;
    } else {
        if (status == false) {  // detail exception dump can not off
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

    dumpPath_ = dumpConfig.dumpPath.empty() ? DEFAULT_DUMP_PATH : dumpConfig.dumpPath;
    return ADUMP_SUCCESS;
}

void ExceptionDumper::SetDumpPath(const std::string &dumpPath)
{
    dumpPath_ = dumpPath;
    IDE_LOGI("Update exception dump path: %s", dumpPath_.c_str());
}

void ExceptionDumper::AddDumpOperator(const OperatorInfoV2 &opInfo)
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
    residentOperators_[deviceId].erase(streamId);
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpException(const rtExceptionInfo &exception)
{
    IDE_CTRL_VALUE_FAILED(!destructionFlag_, return ADUMP_FAILED, "ExceptionDumper has been destructed.");
    std::string dumpPath = CreateDeviceDumpPath(exception.deviceid);
    if (dumpPath.empty()) {
        return ADUMP_FAILED;
    }

    if (coredumpStatus_) {
        if (coredumpEnableComplete_) {
            std::lock_guard<std::mutex> lock(mutex_);
            DumpCore core(dumpPath, exception.deviceid);
            if (core.DumpCoreFile(exception) != ADUMP_SUCCESS) {
                return ADUMP_FAILED;
            }
            Exit();
        } else {
            IDE_CTRL_VALUE_WARN(DumpTensorPlugin::Instance().InitPluginLib() == ADUMP_SUCCESS, return ADUMP_FAILED,
                "Unable to initialize plugin function.");
            return DumpArgsException(exception, dumpPath);
        }
    } else if (exceptionStatus_) {
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
    } else if (argsExceptionStatus_) {
        return DumpArgsException(exception, dumpPath);
    } else {
        IDE_LOGW("Not enable exception dump.");
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpArgsExceptionFastRecovery(const rtExceptionInfo &exception) const
{
    void *exceptionCopy = DumpMemory::CopyHostToHost(&exception, sizeof(rtExceptionInfo));
    if (exceptionCopy == nullptr) {
        IDE_LOGE("Copy rtExceptionInfo failed.");
        return ADUMP_FAILED;
    }
    std::thread([this, exceptionCopy]()
    {
        DumpArgs args;
        rtExceptionInfo* exceptionPtr = static_cast<rtExceptionInfo*>(exceptionCopy);
        rtError_t ret = rtSetDevice(exceptionPtr->deviceid);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("Execute rtSetDevice on device %u failed with result %d", exceptionPtr->deviceid, ret);
        }
        if (args.LoadArgsExceptionInfo(*exceptionPtr) != ADUMP_SUCCESS) {
            IDE_LOGE("Fast recovery LoadArgsExceptionInfo failed.");
        }
        void* exceptionFree = static_cast<void*>(exceptionPtr);
        DumpMemory::FreeHost(exceptionFree);
    }).detach();
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpArgsException(const rtExceptionInfo &exception, const std::string &dumpPath) const
{
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

    KernelInfoCollector::DumpKernelErrorSymbols(exception);
    DumpArgs args;
    if (args.LoadArgsExceptionInfo(exception) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }
    if (args.DumpArgsExceptionInfo(exception.deviceid, dumpPath) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

std::string ExceptionDumper::CreateDeviceDumpPath(uint32_t deviceId) const
{
    if (dumpPath_.empty()) {
        return DEFAULT_DUMP_PATH;
    }

    Path userDefinedDumpPath(dumpPath_);
    userDefinedDumpPath.Append(EXTRA_DUMP_PATH).Append(std::to_string(deviceId));
    if (!userDefinedDumpPath.CreateDirectory(true)) {
        IDE_LOGE("Create directory for exception dump failed, dir: %s", userDefinedDumpPath.GetCString());
        return "";
    }
    IDE_CTRL_VALUE_FAILED(userDefinedDumpPath.RealPath(), return "", "Get path: %s realpath failed, strerr=%s",
        userDefinedDumpPath.GetCString(), strerror(errno));
    return userDefinedDumpPath.GetString();
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
}  // namespace Adx