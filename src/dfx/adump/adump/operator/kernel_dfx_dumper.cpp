/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cctype>
#include <cinttypes>
#include <thread>
#include <map>
#include <cerrno>
#include "str_utils.h"
#include "sys_utils.h"
#include "lib_path.h"
#include "file_utils.h"
#include "log/adx_log.h"
#include "dump_config_converter.h"
#include "kernel_dfx_dumper.h"

namespace Adx {
static const int32_t WAIT_TASK_INTERVAL_TIME = 500;
static const std::string KERNEL_DFX_TYPE_ALL = "all";
static const std::string KERNEL_DFX_TYPE_PRINTF = "printf";
static const std::string KERNEL_DFX_TYPE_TENSOR = "tensor";
static const std::string KERNEL_DFX_TYPE_ASSERT = "assert";
static const std::string KERNEL_DFX_TYPE_TIMESTAMP = "timestamp";
static const std::string KERNEL_DFX_TYPE_BLOCKINFO = "BlockInfo";
static const std::map<uint32_t, std::string> DFX_CORE_TYPE_MAP = {
    {0U, "aic"},
    {1U, "aiv"},
    {2U, "simt"}
};

static const std::map<rtKernelDfxInfoType, std::string> DFX_TYPE_STR_MAP = {
    {rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, KERNEL_DFX_TYPE_ALL},
    {rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF, KERNEL_DFX_TYPE_PRINTF},
    {rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_TENSOR, KERNEL_DFX_TYPE_TENSOR},
    {rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_ASSERT, KERNEL_DFX_TYPE_ASSERT},
    {rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_TIME_STAMP, KERNEL_DFX_TYPE_TIMESTAMP},
    {rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_BLOCK_INFO, KERNEL_DFX_TYPE_BLOCKINFO}
};

void DumpKernelDfxInfoCallback(rtKernelDfxInfoType dfxType, uint32_t coreType, uint32_t coreId,
                               const uint8_t *buffer, size_t length)
{
    (void)KernelDfxDumper::Instance().DumpKernelDfxInfo(dfxType, coreType, coreId, buffer, length);
}

int32_t KernelDfxDumper::PushDfxInfoToQueue(DumpDfxInfo &dfxInfo)
{
    if (dumpDfxInfoQueue_.IsFull()) {
        IDE_LOGE("Cannot push the dfx info into the queue. Memory usage exceeds 85% or queue size exceeds 60!");
        return ADUMP_FAILED;
    } else {
        if (dumpDfxInfoQueue_.Push(dfxInfo)) {
            IDE_LOGI("Push the dfx info into the queue success.");
            return ADUMP_SUCCESS;
        } else {
            IDE_LOGE("Failed to push the dfx info into the queue.");
            return ADUMP_FAILED;
        }
    }
}

void KernelDfxDumper::RecordDfxInfo()
{
    IDE_LOGI("The dump dfx info task is started.");
    while (taskInit_ || !dumpDfxInfoQueue_.IsEmpty()) {
        DumpDfxInfo dfxInfo{"", nullptr, 0UL};
        if (dumpDfxInfoQueue_.Pop(dfxInfo)) {
            RecordDfxInfoToDisk(dfxInfo);
        }
    }
    IDE_LOGI("The dump dfx info task is exit.");
}

void KernelDfxDumper::RecordDfxInfoToDisk(DumpDfxInfo &dfxInfo)
{
    if (dfxInfo.path.empty() || dfxInfo.data == nullptr || dfxInfo.length == 0UL) {
        IDE_LOGW("The dfx info item is invalid! path=%s, data=%p, length=%u",
            dfxInfo.path.c_str(), dfxInfo.data.get(), dfxInfo.length);
        return;
    }

    IDE_LOGI("Pop the dfx info item success. path=%s, length=%u", dfxInfo.path.c_str(), dfxInfo.length);
    Path path = Path(dfxInfo.path);
    std::string fileName = path.GetFileName();
    path = path.ParentPath();
    IDE_CTRL_VALUE_FAILED(path.CreateDirectory(true), return,
        "Cannot create the dfx info directory for path[%s]", path.GetCString());
    IDE_CTRL_VALUE_FAILED(path.RealPath(), return,
        "Cannot get the real path for path[%s]", path.GetCString());
    IDE_CTRL_VALUE_FAILED(!FileUtils::IsDiskFull(path.GetString(), static_cast<uint64_t>(dfxInfo.length)),
        return, "Don't have enough free disk for %u bytes", dfxInfo.length);
    path.Concat(fileName);
    IdeErrorT err = FileUtils::WriteFile(path.GetString(), dfxInfo.data.get(), dfxInfo.length, -1);
    if (err != IDE_DAEMON_NONE_ERROR) {
        IDE_LOGE("Cannot write the dfx info into path[%s]! err: %d", path.GetCString(), err);
        return;
    }
    IDE_LOGI("Record the dfx info into path[%s] success.", path.GetCString());
}

int32_t KernelDfxDumper::InitTask()
{
    IDE_LOGI("Begin to start the dump dfx info task.");
    if (taskInit_) {
        return IDE_DAEMON_OK;
    }
    // 没有注册使能，不开启任务。在下一次注册使能时再开启任务
    if (!IsEnabled()) {
        return IDE_DAEMON_OK;
    }

    dumpDfxInfoQueue_.Init();
    taskInit_ = true;

    auto taskBind = std::bind(&KernelDfxDumper::RecordDfxInfo, this);
    std::thread taskThread(taskBind);
    taskThread.detach();
    return IDE_DAEMON_OK;
}

int32_t KernelDfxDumper::UnInitTask()
{
    IDE_LOGI("Begin to stop the dump dfx info task.");
    taskInit_ = false;
    while (!dumpDfxInfoQueue_.IsEmpty()) {
        mmSleep(WAIT_TASK_INTERVAL_TIME);
    }
    dumpDfxInfoQueue_.Quit();
    return IDE_DAEMON_OK;
}

void KernelDfxDumper::UnInit()
{
    UnInitTask();
    dumpPath_.clear();
    enabledDfxTypes_.clear();
}

KernelDfxDumper::KernelDfxDumper()
{
    EnableDfxDumper();
}

KernelDfxDumper::~KernelDfxDumper()
{
    UnInit();
}

void KernelDfxDumper::EnableDfxDumper() {
    DumpDfxConfig dumpDfxConfig;
    if (DumpConfigConverter::EnableKernelDfxDumpWithEnv(dumpDfxConfig)) {
        if (EnableDfxDumper(dumpDfxConfig) != ADUMP_SUCCESS) {
            IDE_LOGW("Enable kernel dfx dump with env failed!");
        }
    }
}

bool KernelDfxDumper::InitDumpPath(const std::string &dumpPath)
{
    IDE_CTRL_VALUE_FAILED(!dumpPath.empty(), return false, "The dfx info dump path is empty!");
    IDE_CTRL_VALUE_WARN(dumpPath_.empty(), return true,
        "The dfx info dump path has been set with [%s]", dumpPath_.c_str());
    Path path = Path(dumpPath).Append(SysUtils::GetCurrentTime());
    IDE_CTRL_VALUE_FAILED(path.CreateDirectory(true), return false,
        "Cannot create the dfx info dump path[%s]", path.GetCString());
    IDE_CTRL_VALUE_FAILED(path.RealPath(), return false,
        "Cannot get the dfx info dump real path[%s]", path.GetCString());
    dumpPath_ = path.GetString();
    IDE_LOGI("Set the dfx info dump path with [%s]", dumpPath_.c_str());
    return true;
}

std::string KernelDfxDumper::GetDfxTypeStr(const rtKernelDfxInfoType rtDfxType)
{
    auto it = DFX_TYPE_STR_MAP.find(rtDfxType);
    return it != DFX_TYPE_STR_MAP.end() ? it->second : "";
}

std::string KernelDfxDumper::GetCoreTypeStr(const uint32_t coreType)
{
    auto it = DFX_CORE_TYPE_MAP.find(coreType);
    return it != DFX_CORE_TYPE_MAP.end() ? it->second : "";
}

int32_t KernelDfxDumper::EnableDfxDumper(const DumpDfxConfig config)
{
    if (config.dfxTypes.empty() || config.dumpPath.empty()) {
        return ADUMP_SUCCESS;
    }
    std::set<rtKernelDfxInfoType> rtDfxTypes;
    GetRegisterDfxTypes(config.dfxTypes, rtDfxTypes);
    for (auto& rtDfxType : rtDfxTypes) {
        if (!IsEnabled(rtDfxType)) {
            rtError_t ret = rtSetKernelDfxInfoCallback(rtDfxType, DumpKernelDfxInfoCallback);
            IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return ADUMP_FAILED,
                "Register the dfx info dump callback to RTS failed! dfxType=%d, ret=%d", rtDfxType, ret);
            enabledDfxTypes_.insert(rtDfxType);
            IDE_LOGI("Register the dfx info dump callback to RTS success. dfxType=%d", rtDfxType);
        } else {
            IDE_LOGI("The dfx info dump callback has been registered to RTS. dfxType=%d", rtDfxType);
        }
    }
    IDE_CTRL_VALUE_FAILED(InitDumpPath(config.dumpPath), return ADUMP_FAILED,
        "Set the dfx info dump path[%s] failed!", config.dumpPath.c_str());
    IDE_CTRL_VALUE_FAILED(InitTask() == IDE_DAEMON_OK, return ADUMP_FAILED,
        "Init the task of dump dfx info failed!");
    return ADUMP_SUCCESS;
}

void KernelDfxDumper::GetRegisterDfxTypes(const std::vector<std::string> &cfgDfxTypes,
    std::set<rtKernelDfxInfoType> &rtDfxTypes)
{
    for (auto& dfxType : cfgDfxTypes) {
        // 非default场景，都要再注册RT_KERNEL_DFX_INFO_BLOCK_INFO类型。
        // all/printf：不使用静态常量，解决so构造函数时通过环境变量使能而静态常量未初始化的问题。
        if (dfxType == "all") {
            rtDfxTypes.insert(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT);
        } else if (dfxType == "printf") {
            rtDfxTypes.insert({rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF,
                rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_BLOCK_INFO});
        } else if (dfxType == "tensor") {
            rtDfxTypes.insert({rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_TENSOR,
                rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_BLOCK_INFO});
        } else if (dfxType == "assert") {
            rtDfxTypes.insert({rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_ASSERT,
                rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_BLOCK_INFO});
        } else if (dfxType == "timestamp") {
            rtDfxTypes.insert({rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_TIME_STAMP,
                rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_BLOCK_INFO});
        }
    }
}

bool KernelDfxDumper::IsEnabled(const rtKernelDfxInfoType dfxType)
{
    return enabledDfxTypes_.find(dfxType) != enabledDfxTypes_.end();
}

bool KernelDfxDumper::IsEnabled()
{
    return !enabledDfxTypes_.empty();
}

std::string KernelDfxDumper::GetDfxInfoFilePath(uint32_t coreId, std::string &coreType)
{
    std::string fileName = "asc_kernel_data_" + coreType + "_" + std::to_string(coreId) + ".bin";
    return Path(dumpPath_).Concat(fileName).GetString();
}

int32_t KernelDfxDumper::DumpKernelDfxInfo(rtKernelDfxInfoType dfxType, uint32_t coreType, uint32_t coreId,
    const uint8_t *buffer, size_t length)
{
    std::string dfxTypeStr = GetDfxTypeStr(dfxType);
    std::string coreTypeStr = GetCoreTypeStr(coreType);
    IDE_CTRL_VALUE_WARN(IsEnabled(dfxType), return ADUMP_FAILED,
        "dfxType=%d[%s] is not enabled, do not record the dfx info.", dfxType, dfxTypeStr.c_str());
    if (buffer == nullptr || length == 0UL || length > std::numeric_limits<uint32_t>::max()
        || dfxTypeStr.empty() || coreTypeStr.empty()) {
        IDE_LOGW("The dfx info is invalid! dfxType=%d[%s], coreType=%u[%s], coreId=%u, buffer=%p, length=%zu",
            dfxType, dfxTypeStr.c_str(), coreType, coreTypeStr.c_str(), coreId, buffer, length);
        return ADUMP_FAILED;
    }
    IDE_LOGI("Receive kernel dfx info. dfxType=%d[%s], coreType=%u[%s], coreId=%u, buffer=%p, length=%zu",
        dfxType, dfxTypeStr.c_str(), coreType, coreTypeStr.c_str(), coreId, buffer, length);

    std::shared_ptr<uint8_t> data(new(std::nothrow) uint8_t[length], [](uint8_t* ptr) { delete[] ptr; });
    IDE_CTRL_VALUE_FAILED(data.get() != nullptr, return ADUMP_FAILED, "Cannot create the new dfx info buffer!");
    auto err = memcpy_s(data.get(), length, buffer, length);
    if (err != EOK) {
        IDE_LOGE("Cannot copy the dfx info to the new buffer! err: %d", err);
        return ADUMP_FAILED;
    }
    DumpDfxInfo dfxInfo{GetDfxInfoFilePath(coreId, coreTypeStr), data, static_cast<uint32_t>(length)};
    return PushDfxInfoToQueue(dfxInfo);
}
}