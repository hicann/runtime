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
#include <cstdlib>
#include <dlfcn.h>
#include <sstream>
#include "aprof_pub.h"
#include "command_handle.h"
#include "errno/error_code.h"
#include "job_factory.h"
#include "json_parser.h"
#include "platform/platform.h"
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
using namespace Analysis::Dvvp::JobWrapper;
using namespace Msprofiler::Parser;

namespace {
constexpr uint32_t COMPUTE_DEV_NUM = 1;
constexpr uint32_t CALLBACK_WAIT_TIMEOUT_SEC = 60;
constexpr uint32_t COMPUTE_UPLOADER_QUEUE_SIZE = 4096U * 4U;
const char CUSTOM_METRIC_PREFIX[] = "Custom:";
const char METRIC_DELIMITER[] = ",";
constexpr char ACL_API_INJECTION_ENV[] = "ACL_API_INJECTION";
constexpr char ACL_TOOL_INITIALIZE_FUNC[] = "acltoolInitialize";

bool IsEnabled(uint64_t profSwitch, uint64_t mask) { return (profSwitch & mask) != 0; }

bool HasAclToolInjectionPath(const char* injectionPath) { return injectionPath != nullptr && injectionPath[0] != '\0'; }
} // namespace

ComputeProfilingManager::ComputeProfilingManager()
    : computeCallback_(nullptr),
      running_(false),
      runningDevId_(""),
      runningProfSwitch_(0),
      runningParams_(nullptr),
      jobAdapter_(nullptr),
      injectionTransport_(nullptr),
      aclToolHandle_(nullptr),
      setInjectionFunc_(nullptr),
      getInjectionFunc_(nullptr),
      hookInitFunc_(nullptr),
      injectionEnabled_(false)
{}

ComputeProfilingManager::~ComputeProfilingManager()
{
    // Singleton destruction happens during process exit or library unload. External profiling APIs
    // must no longer be called concurrently; the locks keep cleanup serialized with any in-flight call.
    {
        std::lock_guard<std::mutex> lock(mutex_);
        ClearContext();
    }
    ClearInjectionContext();
}

int32_t ComputeProfilingManager::RegisterDataCallback(uint32_t type, void* callback)
{
    if (type != PROF_DATA_CALLBACK_COMPUTE || callback == nullptr) {
        MSPROF_LOGE("Invalid compute data callback, type:%u.", type);
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    computeCallback_ = reinterpret_cast<MsprofRawDataCallback>(callback);
    if (injectionTransport_ != nullptr) {
        injectionTransport_->RegisterRawDataCallback(computeCallback_);
    }
    MSPROF_LOGI("Register compute data callback success.");
    return PROFILING_SUCCESS;
}

MsprofRawDataCallback ComputeProfilingManager::GetComputeRawDataCallback()
{
    std::lock_guard<std::mutex> lock(mutex_);
    return computeCallback_;
}

int32_t ComputeProfilingManager::RegisterInjectionFunc(uint32_t type, void* func)
{
    if (func == nullptr) {
        MSPROF_LOGE("Invalid injection func, type:%u.", type);
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(injectionMutex_);
    if (type == PROF_HOOK_SET) {
        setInjectionFunc_ = func;
    } else if (type == PROF_HOOK_GET) {
        getInjectionFunc_ = func;
    } else if (type == PROF_HOOK_INIT) {
        hookInitFunc_ = reinterpret_cast<AclToolInitializeFunc>(func);
    } else {
        MSPROF_LOGE("Invalid injection func type:%u.", type);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::CheckInjectionFuncRegistered() const
{
    if (setInjectionFunc_ != nullptr && getInjectionFunc_ != nullptr) {
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGE("Runtime injection funcs are not registered.");
    return PROFILING_FAILED;
}

int32_t ComputeProfilingManager::LoadAclToolLibrary(const char* injectionPath, void*& aclToolHandle) const
{
    aclToolHandle = dlopen(injectionPath, RTLD_LAZY | RTLD_LOCAL);
    if (aclToolHandle == nullptr) {
        MSPROF_LOGE("Failed to dlopen acl tool injection:%s.", dlerror());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::GetAclToolInitialize(void* aclToolHandle, AclToolInitializeFunc& initializeFunc) const
{
    initializeFunc = reinterpret_cast<AclToolInitializeFunc>(dlsym(aclToolHandle, ACL_TOOL_INITIALIZE_FUNC));
    if (initializeFunc == nullptr) {
        MSPROF_LOGE("Failed to find acltoolInitialize:%s.", dlerror());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::CallAclToolInitialize(AclToolInitializeFunc initializeFunc)
{
    if (initializeFunc() != PROFILING_SUCCESS) {
        MSPROF_LOGE("acltoolInitialize failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void ComputeProfilingManager::CloseAclToolLibrary(void* aclToolHandle) const
{
    if (aclToolHandle != nullptr) {
        dlclose(aclToolHandle);
    }
}

int32_t ComputeProfilingManager::InitializeInjection()
{
    const char* injectionPath = std::getenv(ACL_API_INJECTION_ENV);
    AclToolInitializeFunc initializeFunc = nullptr;
    void* newAclToolHandle = nullptr;
    if (HasAclToolInjectionPath(injectionPath) &&
        (LoadAclToolLibrary(injectionPath, newAclToolHandle) != PROFILING_SUCCESS ||
         GetAclToolInitialize(newAclToolHandle, initializeFunc) != PROFILING_SUCCESS)) {
        CloseAclToolLibrary(newAclToolHandle);
        ClearInjectionContext();
        return PROFILING_FAILED;
    }

    void* oldAclToolHandle = nullptr;
    bool injectionFuncMissed = false;
    {
        std::lock_guard<std::mutex> lock(injectionMutex_);
        if (!HasAclToolInjectionPath(injectionPath)) {
            initializeFunc = hookInitFunc_;
        }
        if (initializeFunc == nullptr) {
            ClearInjectionState(oldAclToolHandle);
            MSPROF_LOGI("ACL_API_INJECTION and PROF_HOOK_INIT are not configured.");
        } else if (CheckInjectionFuncRegistered() != PROFILING_SUCCESS) {
            ClearInjectionState(oldAclToolHandle);
            injectionFuncMissed = true;
        } else {
            oldAclToolHandle = aclToolHandle_;
            aclToolHandle_ = newAclToolHandle;
            newAclToolHandle = nullptr;
            injectionEnabled_ = true;
        }
    }
    if (injectionFuncMissed) {
        CloseAclToolLibrary(newAclToolHandle);
        CloseAclToolLibrary(oldAclToolHandle);
        return PROFILING_FAILED;
    }
    CloseAclToolLibrary(oldAclToolHandle);
    if (initializeFunc == nullptr) {
        return PROFILING_SUCCESS;
    }
    if (CallAclToolInitialize(initializeFunc) != PROFILING_SUCCESS) {
        ClearInjectionContext();
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Initialize acl tool injection success.");
    return PROFILING_SUCCESS;
}

void* ComputeProfilingManager::GetInjectionFunc(uint32_t type)
{
    std::lock_guard<std::mutex> lock(injectionMutex_);
    if (!injectionEnabled_) {
        MSPROF_LOGW("Acl tool injection is not enabled.");
        return nullptr;
    }
    if (type == PROF_HOOK_SET) {
        return setInjectionFunc_;
    }
    if (type == PROF_HOOK_GET) {
        return getInjectionFunc_;
    }
    MSPROF_LOGE("Invalid injection func type:%u.", type);
    return nullptr;
}

int32_t ComputeProfilingManager::ParseInstrMode(uint32_t instrMode, ComputeProfileConfig& outConfig) const
{
    outConfig.enableBiuPerf = (instrMode & PROF_COMPUTE_BIU_PERF) != 0;
    outConfig.enablePcSampling = (instrMode & PROF_COMPUTE_PC_SAMPLING) != 0;
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::ParseBlockMode(uint32_t blockMode, ComputeProfileConfig& outConfig) const
{
    if (blockMode != PROF_COMPUTE_ALL_BLOCK && blockMode != PROF_COMPUTE_BLOCK_SHRINK) {
        MSPROF_LOGE("Invalid compute task block mode:%u.", blockMode);
        return PROFILING_FAILED;
    }
    outConfig.enableBlock = true;
    outConfig.blockMode = blockMode;
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::ParseConfigAttrs(
    const MsprofConfigInfo& configInfo, ComputeProfileConfig& outConfig) const
{
    if (configInfo.numAttrs == 0) {
        return PROFILING_SUCCESS;
    }
    if (configInfo.attrs == nullptr || configInfo.numAttrs > MSPROF_CONFIG_ATTR_MAX_NUM) {
        MSPROF_LOGE("Invalid compute config attrs, numAttrs:%zu.", configInfo.numAttrs);
        return PROFILING_FAILED;
    }
    for (size_t i = 0; i < configInfo.numAttrs; ++i) {
        const MsprofConfigAttr& attr = configInfo.attrs[i];
        switch (attr.id) {
            case PROF_CONFIG_ATTR_AICORE_METRICS:
                for (size_t index = 0; index < COMPUTE_AICORE_METRICS_NUM; ++index) {
                    const uint32_t metric = attr.value.aicoreMetrics[index];
                    if (metric != MSPROF_INVALID_AICORE_METRIC) {
                        outConfig.aicoreMetrics.emplace_back(metric);
                    }
                }
                break;
            case PROF_CONFIG_ATTR_INSTR:
                (void)ParseInstrMode(attr.value.instrMode, outConfig);
                break;
            case PROF_CONFIG_ATTR_TASK_BLOCK:
                if (ParseBlockMode(attr.value.taskBlockMode, outConfig) != PROFILING_SUCCESS) {
                    return PROFILING_FAILED;
                }
                break;
            default:
                MSPROF_LOGW("Ignore unknown compute config attr id:%u.", attr.id);
                break;
        }
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::ParseConfig(const MsprofConfig& config, ComputeProfileConfig& outConfig) const
{
    if (config.devNums != COMPUTE_DEV_NUM) {
        MSPROF_LOGE("Compute profiling only supports one device, devNums:%u.", config.devNums);
        return PROFILING_FAILED;
    }
    outConfig.devId = config.devIdList[0];
    outConfig.profSwitch = config.profSwitch;
    outConfig.dumpPath = config.dumpPath;
    outConfig.enableLog = IsEnabled(config.profSwitch, PROF_TASK_TIME_MASK);
    outConfig.enablePmu = IsEnabled(config.profSwitch, PROF_AICORE_METRICS_MASK);
    outConfig.enableInstr = IsEnabled(config.profSwitch, PROF_INSTR_MASK);
    if (ParseConfigAttrs(config.configInfo, outConfig) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (outConfig.enablePmu && outConfig.aicoreMetrics.empty()) {
        MSPROF_LOGE("Aicore metrics is required when PROF_AICORE_METRICS_MASK is enabled.");
        return PROFILING_FAILED;
    }
    if (outConfig.enableInstr && !outConfig.enableBiuPerf && !outConfig.enablePcSampling) {
        MSPROF_LOGE("Instr mode is required when PROF_INSTR_MASK is enabled.");
        return PROFILING_FAILED;
    }
    if (!outConfig.enableLog && !outConfig.enablePmu && !outConfig.enableInstr && !outConfig.enableBlock) {
        MSPROF_LOGE("No compute profiling item is enabled.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::InitRuntime()
{
    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init platform for compute profiling.");
        return PROFILING_FAILED;
    }
    if (ProfManager::instance()->AclInit() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init prof manager for compute profiling.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

std::string ComputeProfilingManager::BuildMetricEvents(const std::vector<uint32_t>& metrics) const
{
    std::stringstream ss;
    ss << CUSTOM_METRIC_PREFIX;
    for (size_t i = 0; i < metrics.size(); ++i) {
        if (i != 0) {
            ss << METRIC_DELIMITER;
        }
        ss << "0x" << std::hex << std::nouppercase << metrics[i];
    }
    return ss.str();
}

SHARED_PTR_ALIA<ProfileParams> ComputeProfilingManager::BuildProfileParams(
    const ComputeProfileConfig& config, const std::string& devIdStr) const
{
    SHARED_PTR_ALIA<ProfileParams> params = nullptr;
    MSVP_MAKE_SHARED0(params, ProfileParams, return nullptr);
    params->job_id = devIdStr;
    params->devices = devIdStr;
    params->result_dir = MSVP_PROF_EMPTY_STRING;
    params->resultPath = MSVP_PROF_EMPTY_STRING;
    params->profMode = MSVP_PROF_COMPUTE_MODE;
    params->profiling_mode = PROFILING_MODE_DEF;
    params->hostProfiling = false;
    params->acl = MSVP_PROF_OFF;
    params->runtimeApi = MSVP_PROF_OFF;
    params->geApi = MSVP_PROF_OFF;
    params->aicpuTrace = MSVP_PROF_OFF;
    params->runtimeTrace = MSVP_PROF_OFF;
    params->taskTrace = MSVP_PROF_OFF;
    params->taskTime = MSVP_PROF_OFF;
    if (config.enableLog) {
        params->stars_acsq_task = MSVP_PROF_ON;
        params->ts_memcpy = MSVP_PROF_ON;
    }
    if (config.enablePmu) {
        const std::string metricEvents = BuildMetricEvents(config.aicoreMetrics);
        params->ai_core_profiling = MSVP_PROF_ON;
        params->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
        params->ai_core_metrics = metricEvents;
        params->ai_core_profiling_events = metricEvents;
        params->aiv_profiling = MSVP_PROF_ON;
        params->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
        params->aiv_metrics = metricEvents;
        params->aiv_profiling_events = metricEvents;
    }
    if (config.enableInstr) {
        params->instrProfiling = config.enableBiuPerf ? MSVP_PROF_ON : MSVP_PROF_OFF;
        params->pcSampling = config.enablePcSampling ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
    if (config.enableBlock) {
        params->taskBlock = MSVP_PROF_ON;
        params->taskBlockShink = config.blockMode == PROF_COMPUTE_BLOCK_SHRINK ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
    return params;
}

void ComputeProfilingManager::RollbackComputeUploader(const std::string& devIdStr)
{
    UploaderMgr::instance()->DelUploader(devIdStr);
    injectionTransport_.reset();
}

int32_t ComputeProfilingManager::CreateComputeUploader(const std::string& devIdStr)
{
    MSVP_MAKE_SHARED1(injectionTransport_, InjectionTransport, computeCallback_, return PROFILING_FAILED);
    if (UploaderMgr::instance()->CreateUploader(devIdStr, injectionTransport_, COMPUTE_UPLOADER_QUEUE_SIZE) !=
        PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create compute uploader, devId:%s.", devIdStr.c_str());
        injectionTransport_.reset();
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void ComputeProfilingManager::RegisterComputeUploaderMap(uint32_t devId, const std::string& jobId) const
{
    UploaderMgr::instance()->AddMapByDevIdMode(static_cast<int32_t>(devId), PROFILING_MODE_DEF, jobId);
}

int32_t ComputeProfilingManager::CreateComputeJobAdapter(uint32_t devId)
{
    jobAdapter_ = JobSocFactory().CreateJobAdapter(static_cast<int32_t>(devId));
    if (jobAdapter_ == nullptr) {
        MSPROF_LOGE("Failed to create compute job adapter, devId:%u.", devId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::StartComputeJob(SHARED_PTR_ALIA<ProfileParams> params, uint32_t devId)
{
    if (params == nullptr) {
        MSPROF_LOGE("Compute profile params is nullptr.");
        return PROFILING_FAILED;
    }
    RegisterComputeUploaderMap(devId, params->job_id);
    if (CreateComputeJobAdapter(devId) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (jobAdapter_->StartProf(params) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start compute profiling job, devId:%u.", devId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::StopComputeJob()
{
    if (jobAdapter_ == nullptr) {
        MSPROF_LOGW("Compute profiling job adapter is nullptr.");
        return PROFILING_SUCCESS;
    }
    if (jobAdapter_->StopProf() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop compute profiling job, devId:%s.", runningDevId_.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::StartComponentCallback(uint32_t devId, uint64_t profSwitch) const
{
    uint32_t devIdList[COMPUTE_DEV_NUM] = {devId};
    if (CommandHandleProfStart(devIdList, COMPUTE_DEV_NUM, profSwitch, 0) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to callback compute profiling start, devId:%u.", devId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::StopComponentCallback() const
{
    if (!Utils::CheckStringIsNonNegativeIntNum(runningDevId_)) {
        MSPROF_LOGE("Invalid running compute profiling device id:%s.", runningDevId_.c_str());
        return PROFILING_FAILED;
    }
    uint32_t devId = static_cast<uint32_t>(std::stoul(runningDevId_));
    uint32_t devIdList[COMPUTE_DEV_NUM] = {devId};
    if (CommandHandleProfStop(devIdList, COMPUTE_DEV_NUM, runningProfSwitch_, 0) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to callback compute profiling stop, devId:%u.", devId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::StartComputeJobAndCallback(
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, const ComputeProfileConfig& config)
{
    if (StartComputeJob(params, config.devId) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    runningProfSwitch_ = config.profSwitch;
    if (StartComponentCallback(config.devId, config.profSwitch) != PROFILING_SUCCESS) {
        (void)StopComputeJob();
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ComputeProfilingManager::Start(const void* data, uint32_t length)
{
    if (data == nullptr || length != sizeof(MsprofConfig)) {
        MSPROF_LOGE("Invalid compute start config, length:%u.", length);
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(mutex_);
    if (running_) {
        MSPROF_LOGE("Compute profiling is already started.");
        return PROFILING_FAILED;
    }
    if (computeCallback_ == nullptr) {
        MSPROF_LOGE("Compute data callback is not registered.");
        return PROFILING_FAILED;
    }
    ComputeProfileConfig config;
    if (ParseConfig(*static_cast<const MsprofConfig*>(data), config) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (InitRuntime() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    const std::string devIdStr = std::to_string(config.devId);
    if (CreateComputeUploader(devIdStr) != PROFILING_SUCCESS) {
        ClearContext();
        return PROFILING_FAILED;
    }
    runningDevId_ = devIdStr;
    SHARED_PTR_ALIA<ProfileParams> params = BuildProfileParams(config, devIdStr);
    if (params == nullptr) {
        ClearContext();
        return PROFILING_FAILED;
    }
    if (StartComputeJobAndCallback(params, config) != PROFILING_SUCCESS) {
        ClearContext();
        return PROFILING_FAILED;
    }
    running_ = true;
    runningParams_ = params;
    MSPROF_LOGI("Start compute profiling success, devId:%s.", devIdStr.c_str());
    return PROFILING_SUCCESS;
}

void ComputeProfilingManager::PrintCallbackFailedStatistics() const
{
    if (injectionTransport_ == nullptr) {
        return;
    }
    const uint64_t failedCount = injectionTransport_->GetCallbackFailedCount();
    const uint64_t failedBytes = injectionTransport_->GetCallbackFailedBytes();
    if (failedCount != 0) {
        MSPROF_LOGE(
            "Compute profiling callback failed, count:%llu, bytes:%llu.", static_cast<unsigned long long>(failedCount),
            static_cast<unsigned long long>(failedBytes));
    }
}

void ComputeProfilingManager::FlushComputeUploader(uint32_t timeoutSec) const
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(runningDevId_, uploader);
    if (uploader == nullptr) {
        return;
    }
    if (uploader->Flush(timeoutSec) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Wait compute uploader empty timeout, timeoutSec:%u.", timeoutSec);
    }
}

int32_t ComputeProfilingManager::Stop(const void* data, uint32_t length)
{
    std::lock_guard<std::mutex> lock(mutex_);
    if (!running_) {
        MSPROF_LOGI("Compute profiling has already stopped.");
        return PROFILING_SUCCESS;
    }
    if (data == nullptr || length != sizeof(MsprofConfig)) {
        MSPROF_LOGE("Invalid compute stop config, length:%u.", length);
        return PROFILING_FAILED;
    }
    int32_t ret = StopComponentCallback();
    if (StopComputeJob() != PROFILING_SUCCESS) {
        ret = PROFILING_FAILED;
    }
    FlushComputeUploader(CALLBACK_WAIT_TIMEOUT_SEC);
    if (injectionTransport_ != nullptr) {
        (void)injectionTransport_->WaitAllCallbackDone(CALLBACK_WAIT_TIMEOUT_SEC);
    }
    PrintCallbackFailedStatistics();
    ClearContext();
    return ret;
}

void ComputeProfilingManager::ClearContext()
{
    if (!runningDevId_.empty()) {
        UploaderMgr::instance()->DelUploader(runningDevId_);
    }
    running_ = false;
    runningDevId_.clear();
    runningProfSwitch_ = 0;
    runningParams_.reset();
    jobAdapter_.reset();
    injectionTransport_.reset();
}

void ComputeProfilingManager::ClearInjectionState(void*& aclToolHandle)
{
    aclToolHandle = aclToolHandle_;
    aclToolHandle_ = nullptr;
    setInjectionFunc_ = nullptr;
    getInjectionFunc_ = nullptr;
    hookInitFunc_ = nullptr;
    injectionEnabled_ = false;
}

void ComputeProfilingManager::ClearInjectionContext()
{
    void* aclToolHandle = nullptr;
    {
        std::lock_guard<std::mutex> lock(injectionMutex_);
        ClearInjectionState(aclToolHandle);
    }
    CloseAclToolLibrary(aclToolHandle);
}

} // namespace ProfilerCommon
} // namespace Dvvp
} // namespace Analysis
