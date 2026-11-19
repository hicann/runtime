/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "compute_profiling_manager.h"
#include "aprof_pub.h"
#include "command_handle.h"
#include "errno/error_code.h"
#include "json_parser.h"
#include "platform/platform.h"
#include "prof_acl_mgr.h"
#include "prof_manager.h"
#include "securec.h"
#include "uploader_mgr.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::host;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Msprofiler::Parser;
using namespace Msprofiler::Api;

namespace {
constexpr uint32_t COMPUTE_DEV_NUM = 1;
constexpr uint32_t CALLBACK_WAIT_TIMEOUT_SEC = 60;
constexpr uint32_t COMPUTE_UPLOADER_QUEUE_SIZE = 4096U * 4U;
constexpr int32_t COMPUTE_HOST_ID = DEFAULT_HOST_ID;
} // namespace

ComputeProfilingManager::ComputeProfilingManager() : computeCallback_(nullptr) {}

ComputeProfilingManager::~ComputeProfilingManager()
{
    // Singleton destruction happens during process exit or library unload. External profiling APIs
    // must no longer be called concurrently; the locks keep cleanup serialized with any in-flight call.
    {
        std::lock_guard<std::mutex> lock(mutex_);
        ClearContext();
    }
}

int32_t ComputeProfilingManager::RegisterDataCallback(uint32_t type, void* callback)
{
    if (type != PROF_DATA_CALLBACK_COMPUTE || callback == nullptr) {
        MSPROF_LOGE("Invalid compute data callback, type:%u.", type);
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    computeCallback_ = reinterpret_cast<MsprofRawDataCallback>(callback);
    if (hostTransport_ != nullptr) {
        hostTransport_->RegisterRawDataCallback(computeCallback_);
    }
    for (auto& status : statuses_) {
        status.second.transport->RegisterRawDataCallback(computeCallback_);
    }
    MSPROF_LOGI("Register compute data callback success.");
    return PROFILING_SUCCESS;
}

MsprofRawDataCallback ComputeProfilingManager::GetComputeRawDataCallback()
{
    std::lock_guard<std::mutex> lock(mutex_);
    return computeCallback_;
}

int32_t ComputeProfilingManager::InitRuntime()
{
    MSPROF_EVENT("[NPU_COMPUTE] Init runtime begin.");
    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init platform for compute profiling.");
        return PROFILING_FAILED;
    }
    if (ProfAclMgr::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init prof acl manager for compute profiling.");
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("[NPU_COMPUTE] Init runtime success.");
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::CloneBaselineParams(SHARED_PTR_ALIA<ProfileParams>& params) const
{
    if (baselineParams_ == nullptr) {
        MSPROF_LOGE("Compute profile baseline params is nullptr.");
        return PROFILING_FAILED;
    }
    MSVP_MAKE_SHARED0(params, ProfileParams, return PROFILING_FAILED);
    *params = *baselineParams_;
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::CreateComputeUploader(uint32_t devId, ComputeStatus& status)
{
    const std::string devIdStr = std::to_string(devId);
    MSPROF_EVENT("[NPU_COMPUTE] Create injection transport, devId:%s.", devIdStr.c_str());
    MSVP_MAKE_SHARED1(status.transport, InjectionTransport, computeCallback_, return PROFILING_FAILED);
    MSPROF_EVENT(
        "[NPU_COMPUTE] Create uploader begin, devId:%s, queueSize:%u.", devIdStr.c_str(), COMPUTE_UPLOADER_QUEUE_SIZE);
    if (UploaderMgr::instance()->CreateUploader(devIdStr, status.transport, COMPUTE_UPLOADER_QUEUE_SIZE) !=
        PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create compute uploader, devId:%s.", devIdStr.c_str());
        status.transport.reset();
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("[NPU_COMPUTE] Create uploader success, devId:%s.", devIdStr.c_str());
    return PROFILING_SUCCESS;
}

void ComputeProfilingManager::RegisterComputeUploaderMap(uint32_t devId, const std::string& jobId) const
{
    UploaderMgr::instance()->AddMapByDevIdMode(static_cast<int32_t>(devId), PROFILING_MODE_DEF, jobId);
}

int32_t ComputeProfilingManager::StartComputeJob(uint32_t devId, bool ifInitHost)
{
    MSPROF_EVENT("[NPU_COMPUTE] Start job begin, devId:%u, initHost:%d.", devId, ifInitHost ? 1 : 0);
    SHARED_PTR_ALIA<ProfileParams> params = nullptr;
    if (CloneBaselineParams(params) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (ifInitHost && ProfAclMgr::instance()->InitComputeProfileParams(baselineParams_, baselineConfig_.profSwitch) !=
                          PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init compute profile params, devId:%u.", devId);
        return PROFILING_FAILED;
    }
    RegisterComputeUploaderMap(devId, std::to_string(devId));
    return ProfAclMgr::instance()->ProfStartCommonDevice(devId, ifInitHost);
}

int32_t ComputeProfilingManager::StopComputeJob(uint32_t devId)
{
    MSPROF_EVENT("[NPU_COMPUTE] Stop job begin, devId:%u.", devId);
    return ProfAclMgr::instance()->ProfStopCommonDevice(devId, baselineConfig_.profSwitch);
}

void ComputeProfilingManager::RollbackComputeStatus(uint32_t devId)
{
    UploaderMgr::instance()->DelUploader(std::to_string(devId));
    statuses_.erase(devId);
}

void ComputeProfilingManager::RollbackComputeRuntime(uint32_t devId, bool rollbackHost)
{
    if (devId != static_cast<uint32_t>(COMPUTE_HOST_ID)) {
        (void)ProfAclMgr::instance()->ProfStopCommonDevice(devId, baselineConfig_.profSwitch);
    }
    if (rollbackHost) {
        (void)ProfAclMgr::instance()->ReleaseComputeHostContext();
    }
}

void ComputeProfilingManager::SaveBaselineConfig(const MsprofConfig& config)
{
    baselineConfig_ = config;
    baselineAttrs_.clear();
    if (config.configInfo.numAttrs == 0 || config.configInfo.attrs == nullptr) {
        baselineConfig_.configInfo.numAttrs = 0;
        baselineConfig_.configInfo.attrs = nullptr;
        return;
    }
    baselineAttrs_.assign(config.configInfo.attrs, config.configInfo.attrs + config.configInfo.numAttrs);
    baselineConfig_.configInfo.attrs = baselineAttrs_.data();
}

int32_t ComputeProfilingManager::Start(const void* data, uint32_t length)
{
    if (data == nullptr || length != sizeof(MsprofConfig)) {
        MSPROF_LOGE("Invalid compute start config, length:%u.", length);
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    if (computeCallback_ == nullptr) {
        MSPROF_LOGE("Compute data callback is not registered.");
        return PROFILING_FAILED;
    }
    const MsprofConfig& config = *static_cast<const MsprofConfig*>(data);
    const uint32_t startDevId = config.devIdList[0];
    MSPROF_EVENT(
        "[NPU_COMPUTE] Start begin, devId:%u, profSwitch:0x%llx, firstDevice:%d.", startDevId,
        static_cast<unsigned long long>(config.profSwitch), statuses_.empty() ? 1 : 0);
    if (config.devNums != COMPUTE_DEV_NUM) {
        MSPROF_LOGE("Compute profiling only supports one device, devNums:%u.", config.devNums);
        return PROFILING_FAILED;
    }
    if (baselineParams_ == nullptr && !ProfAclMgr::instance()->IsModeOff()) {
        MSPROF_LOGE(
            "Compute profiling conflicts with the current profiling mode, mode:%d.",
            ProfAclMgr::instance()->GetWorkMode());
        return PROFILING_FAILED;
    }
    if (statuses_.find(config.devIdList[0]) != statuses_.end()) {
        MSPROF_LOGE("Compute profiling is already started, devId:%u.", config.devIdList[0]);
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<ProfileParams> params = nullptr;
    if (ComputeConfigAdapter::ToProfileParams(config, params) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    CheckConfigConsistency(config);
    if (InitRuntime() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }

    ComputeStatus status;
    const uint32_t devId = config.devIdList[0];
    const bool ifInitHost = statuses_.empty();
    if (ifInitHost) {
        baselineParams_ = params;
    }
    if (CreateComputeUploader(devId, status) != PROFILING_SUCCESS) {
        if (ifInitHost) {
            ClearContext();
        }
        return PROFILING_FAILED;
    }
    statuses_[devId] = status;

    if (ifInitHost) {
        MSPROF_EVENT("[NPU_COMPUTE] Create host injection transport, jobId:%d.", COMPUTE_HOST_ID);
        MSVP_MAKE_SHARED1(hostTransport_, InjectionTransport, computeCallback_, ClearContext();
                          return PROFILING_FAILED);
        MSPROF_EVENT(
            "[NPU_COMPUTE] Create host uploader begin, jobId:%d, queueSize:%u.", COMPUTE_HOST_ID,
            COMPUTE_UPLOADER_QUEUE_SIZE);
        int32_t ret = UploaderMgr::instance()->CreateUploader(
            std::to_string(COMPUTE_HOST_ID), hostTransport_, COMPUTE_UPLOADER_QUEUE_SIZE);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to create compute host uploader.");
            ClearContext();
            return PROFILING_FAILED;
        }
        MSPROF_EVENT("[NPU_COMPUTE] Create host uploader success, jobId:%d.", COMPUTE_HOST_ID);
    }

    const int32_t startRet = StartComputeJob(devId, ifInitHost);
    if (startRet != MSPROF_ERROR_NONE && startRet != ACL_SUCCESS) {
        RollbackComputeRuntime(devId, ifInitHost);
        if (ifInitHost) {
            ClearContext();
        } else {
            RollbackComputeStatus(devId);
        }
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Start compute profiling success, devId:%u.", devId);
    MSPROF_EVENT("[NPU_COMPUTE] Start success, devId:%u.", devId);
    return PROFILING_SUCCESS;
}

void ComputeProfilingManager::PrintCallbackFailedStatistics(uint32_t devId) const
{
    const auto iter = statuses_.find(devId);
    if (iter == statuses_.end() || iter->second.transport == nullptr) {
        return;
    }
    const uint64_t failedCount = iter->second.transport->GetCallbackFailedCount();
    const uint64_t failedBytes = iter->second.transport->GetCallbackFailedBytes();
    if (failedCount != 0) {
        MSPROF_LOGE(
            "Compute profiling callback failed, count:%llu, bytes:%llu.", static_cast<unsigned long long>(failedCount),
            static_cast<unsigned long long>(failedBytes));
    }
}

void ComputeProfilingManager::FlushComputeUploader(uint32_t devId, uint32_t timeoutSec) const
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(devId), uploader);
    if (uploader == nullptr) {
        return;
    }
    if (uploader->Flush(timeoutSec) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Wait compute uploader empty timeout, timeoutSec:%u.", timeoutSec);
    }
}

void ComputeProfilingManager::WaitStatusCallbackDone(uint32_t devId, uint32_t timeoutSec) const
{
    const auto iter = statuses_.find(devId);
    if (iter == statuses_.end() || iter->second.transport == nullptr) {
        return;
    }
    if (iter->second.transport->WaitAllCallbackDone(timeoutSec) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Wait compute callbacks done failed, devId:%u.", devId);
    }
}

int32_t ComputeProfilingManager::ReleaseComputeHostContext()
{
    MSPROF_EVENT("[NPU_COMPUTE] Flush host uploader begin, jobId:%d.", COMPUTE_HOST_ID);
    int32_t ret = ProfAclMgr::instance()->ReleaseComputeHostContext();
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(COMPUTE_HOST_ID), uploader);
    if (uploader != nullptr && uploader->Flush(CALLBACK_WAIT_TIMEOUT_SEC) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Wait host compute uploader empty timeout, timeoutSec:%u.", CALLBACK_WAIT_TIMEOUT_SEC);
        ret = PROFILING_FAILED;
    }
    if (hostTransport_ != nullptr &&
        hostTransport_->WaitAllCallbackDone(CALLBACK_WAIT_TIMEOUT_SEC) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Wait host compute callbacks done timeout, timeoutSec:%u.", CALLBACK_WAIT_TIMEOUT_SEC);
        ret = PROFILING_FAILED;
    }
    MSPROF_EVENT("[NPU_COMPUTE] Wait host callbacks done, jobId:%d, ret:%d.", COMPUTE_HOST_ID, ret);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    UploaderMgr::instance()->DelUploader(std::to_string(COMPUTE_HOST_ID));
    hostTransport_.reset();
    baselineParams_.reset();
    baselineConfig_ = {};
    baselineAttrs_.clear();
    if (ret == PROFILING_SUCCESS) {
        ProfAclMgr::instance()->SetModeToOff();
        MSPROF_EVENT("[NPU_COMPUTE] Compute mode cleared.");
    }
    MSPROF_EVENT("[NPU_COMPUTE] Release host context success, jobId:%d.", COMPUTE_HOST_ID);
    return ret;
}

bool ComputeProfilingManager::IsSameComputeConfig(const MsprofConfig& config) const
{
    if (baselineConfig_.profSwitch != config.profSwitch ||
        baselineConfig_.configInfo.numAttrs != config.configInfo.numAttrs) {
        return false;
    }
    const MsprofConfigInfo& baselineInfo = baselineConfig_.configInfo;
    const MsprofConfigInfo& currentInfo = config.configInfo;
    if (baselineInfo.numAttrs == 0) {
        return true;
    }
    if (baselineInfo.attrs == nullptr || currentInfo.attrs == nullptr) {
        return false;
    }
    return memcmp(baselineInfo.attrs, currentInfo.attrs, baselineInfo.numAttrs * sizeof(MsprofConfigAttr)) == 0;
}

bool ComputeProfilingManager::CheckConfigConsistency(const MsprofConfig& config)
{
    if (statuses_.empty()) {
        SaveBaselineConfig(config);
        return true;
    }
    if (IsSameComputeConfig(config)) {
        return true;
    }
    MSPROF_LOGW(
        "Compute config differs from the first status, profSwitch:%llu, numAttrs:%llu.",
        static_cast<unsigned long long>(config.profSwitch),
        static_cast<unsigned long long>(config.configInfo.numAttrs));
    return true;
}

int32_t ComputeProfilingManager::Stop(const void* data, uint32_t length)
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (data == nullptr || length != sizeof(MsprofConfig)) {
        MSPROF_LOGE("Invalid compute stop config, length:%u.", length);
        return PROFILING_FAILED;
    }
    const MsprofConfig& config = *static_cast<const MsprofConfig*>(data);
    if (config.devNums != COMPUTE_DEV_NUM) {
        MSPROF_LOGE("Invalid compute stop device number, devNums:%u.", config.devNums);
        return PROFILING_FAILED;
    }
    const uint32_t devId = config.devIdList[0];
    MSPROF_EVENT("[NPU_COMPUTE] Stop begin, devId:%u.", devId);
    const auto statusIter = statuses_.find(devId);
    if (statusIter == statuses_.end()) {
        MSPROF_LOGI("Compute profiling has already stopped, devId:%u.", devId);
        return PROFILING_SUCCESS;
    }
    CheckConfigConsistency(config);
    int32_t ret = StopComputeJob(devId);
    FlushComputeUploader(devId, CALLBACK_WAIT_TIMEOUT_SEC);
    WaitStatusCallbackDone(devId, CALLBACK_WAIT_TIMEOUT_SEC);
    PrintCallbackFailedStatistics(devId);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    if (statuses_.size() == COMPUTE_DEV_NUM) {
        const int32_t hostRet = ReleaseComputeHostContext();
        if (hostRet != PROFILING_SUCCESS) {
            return hostRet;
        }
    }
    RollbackComputeStatus(devId);
    MSPROF_EVENT("[NPU_COMPUTE] Stop success, devId:%u, remainingDevices:%zu.", devId, statuses_.size());
    return PROFILING_SUCCESS;
}

void ComputeProfilingManager::ClearContext()
{
    for (auto& status : statuses_) {
        UploaderMgr::instance()->DelUploader(std::to_string(status.first));
        if (status.second.transport != nullptr) {
            (void)status.second.transport->WaitAllCallbackDone(CALLBACK_WAIT_TIMEOUT_SEC);
        }
        status.second.transport.reset();
    }
    statuses_.clear();
    UploaderMgr::instance()->DelUploader(std::to_string(COMPUTE_HOST_ID));
    hostTransport_.reset();
    baselineParams_.reset();
    baselineConfig_ = {};
    baselineAttrs_.clear();
}

} // namespace ProfilerCommon
} // namespace Dvvp
} // namespace Analysis
