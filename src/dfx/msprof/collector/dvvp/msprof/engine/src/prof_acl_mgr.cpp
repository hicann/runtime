/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_acl_mgr.h"
#include <iomanip>
#include <algorithm>
#include <thread>
#include <csignal>
#include <cstring>
#include <memory>
#include "osal.h"
#include "config/config.h"
#include "config_manager.h"
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "message/prof_params.h"
#include "msprofiler_impl.h"
#include "msprof_reporter.h"
#include "op_desc_parser.h"
#include "platform/platform.h"
#include "prof_manager.h"
#include "transport/file_transport.h"
#include "transport/pipe_transport.h"
#include "transport/stats_transport.h"
#include "transport/uploader.h"
#include "transport/uploader_mgr.h"
#include "transport/hash_data.h"
#include "transport/hdc/helper_transport.h"
#include "transport/ctrl_files_dumper.h"
#include "adx_prof_api.h"
#include "param_validation.h"
#include "command_handle.h"
#include "prof_channel_manager.h"
#include "prof_ge_core.h"
#include "msproftx_adaptor.h"
#include "mstx_data_handler.h"
#include "utils/utils.h"
#include "prof_reporter_mgr.h"
#include "prof_hal_plugin.h"
#include "prof_acl_intf.h"

using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::host;
using namespace Analysis::Dvvp::Host::Adapter;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::JobWrapper;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Analysis::Dvvp::ProfilerCommon;
using namespace Collector::Dvvp::Mstx;

namespace Msprofiler {
namespace Api {
// callback of Device
void DeviceResponse(int32_t devId)
{
    MSPROF_LOGI("DeviceResponse of device %d called", devId);
    Msprofiler::Api::ProfAclMgr::instance()->HandleResponse(static_cast<uint32_t>(devId));
}

// internal interface
uint64_t ProfGetOpExecutionTime(CONST_VOID_PTR data, uint32_t len, uint32_t index)
{
    if (data != nullptr) {
        return Analysis::Dvvp::Analyze::OpDescParser::GetOpExecutionTime(data, len, index);
    }
    return 0;
}

ProfAclMgr::ProfAclMgr() : isReady_(false), isProfWarmup_(false), mode_(WORK_MODE_OFF), curDevId_(-1), devSet_({}), aclApiDevSet_({}),
    statsDevSet_({}), params_(nullptr), dataTypeConfig_(0), startIndex_(0), subscribeType_(0) {}

ProfAclMgr::~ProfAclMgr()
{
    (void)UnInit();
}

ProfAclMgr::DeviceResponseHandler::DeviceResponseHandler(const uint32_t devId) : devId_(devId) {}

ProfAclMgr::DeviceResponseHandler::~DeviceResponseHandler() {}

void ProfAclMgr::DeviceResponseHandler::HandleResponse()
{
    MSPROF_EVENT("Device %u finished starting", devId_);
    StopNoWait();
    cv_.notify_one();
}

void ProfAclMgr::DeviceResponseHandler::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    static const int32_t RESPONSE_TIME_S = 30; // device response timeout: 30s
    std::unique_lock<std::mutex> lk(mtx_);
    MSPROF_EVENT("Device %u started to wait for response", devId_);
    cv_.wait_for(lk, std::chrono::seconds(RESPONSE_TIME_S), [this] { return this->IsQuit(); });
    MSPROF_EVENT("Device %u finished waiting for response", devId_);
}

void ProfAclMgr::PrintWorkMode(WorkMode mode)
{
    const auto iter = workModeStr.find(mode);
    if (iter != workModeStr.end()) {
        MSPROF_LOGW("%s, mode:%d", iter->second.c_str(), mode);
    } else {
        MSPROF_LOGE("Find WorkModeStr failed, mode:%d", mode);
    }
}

int32_t ProfAclMgr::CallbackInitPrecheck()
{
    if (mode_ == WORK_MODE_OFF) {
        return PROFILING_SUCCESS;
    }
    PrintWorkMode(mode_);
    return PROFILING_FAILED;
}

int32_t ProfAclMgr::MsprofTxSwitchPrecheck()
{
    if (mode_ == WORK_MODE_CMD) {
        PrintWorkMode(mode_);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::CallbackFinalizePrecheck()
{
    if (mode_ == WORK_MODE_CMD) {
        return PROFILING_SUCCESS;
    }
    PrintWorkMode(mode_);
    return PROFILING_FAILED;
}

int32_t ProfAclMgr::ProfInitPrecheck() const
{
    if (mode_ == WORK_MODE_OFF) {
        return ACL_SUCCESS;
    }
    if (mode_ == WORK_MODE_CMD) {
        MSPROF_LOGW("Acl profiling api mode is disabled because working on cmd mode");
        MSPROF_INPUT_ERROR("EK0007", std::vector<std::string>({"mode1", "mode2"}),
            std::vector<std::string>({"aclapi", "commandline, acljson or geoption"}));
        return ACL_ERROR_PROF_ALREADY_RUN;
    }
    if (mode_ == WORK_MODE_API_CTRL) {
        MSPROF_LOGE("Acl profiling is already inited");
        MSPROF_INPUT_ERROR("EK0002", std::vector<std::string>({"intf1", "intf2"}),
            std::vector<std::string>({"aclprofInit", "aclprofStart"}));
        return ACL_ERROR_REPEAT_INITIALIZE;
    }
    MSPROF_LOGE("Acl profiling api mode conflict with other api mode %d", mode_);
    return ACL_ERROR_PROF_API_CONFLICT;
}

int32_t ProfAclMgr::ProfStartPrecheck() const
{
    if (mode_ == WORK_MODE_API_CTRL) {
        return ACL_SUCCESS;
    }
    if (mode_ == WORK_MODE_CMD) {
        MSPROF_LOGW("Acl profiling api mode is disabled because working on cmd mode");
        MSPROF_INPUT_ERROR("EK0007", std::vector<std::string>({"mode1", "mode2"}),
            std::vector<std::string>({"aclapi", "commandline, acljson or geoption"}));
        return ACL_ERROR_PROF_ALREADY_RUN;
    }
    if (mode_ == WORK_MODE_OFF) {
        MSPROF_LOGE("Acl profiling api mode is not inited");
        return ACL_ERROR_PROF_NOT_RUN;
    }
    MSPROF_LOGE("Acl profiling api ctrl conflicts with other api mode %d", mode_);
    return ACL_ERROR_PROF_API_CONFLICT;
}

int32_t ProfAclMgr::ProfSetConfigPrecheck() const
{
    if (mode_ != WORK_MODE_OFF) {
        return ACL_SUCCESS;
    }
    return ACL_ERROR_PROF_NOT_RUN;
}

int32_t ProfAclMgr::ProfStopPrecheck() const
{
    return ProfStartPrecheck();
}

int32_t ProfAclMgr::ProfFinalizePrecheck() const
{
    return ProfStartPrecheck();
}

int32_t ProfAclMgr::ProfSubscribePrecheck() const
{
    if (mode_ == WORK_MODE_SUBSCRIBE || mode_ == WORK_MODE_OFF) {
        return ACL_SUCCESS;
    }
    if (mode_ == WORK_MODE_CMD) {
        MSPROF_LOGW("Acl profiling api mode is disabled because working on cmd mode");
        MSPROF_INPUT_ERROR("EK0007", std::vector<std::string>({"mode1", "mode2"}),
            std::vector<std::string>({"subscribe", "commandline, acljson or geoption"}));
        return ACL_ERROR_PROF_ALREADY_RUN;
    }
    MSPROF_LOGE("Acl profiling api subscribe conflicts with other api mode %d", mode_);
    MSPROF_INPUT_ERROR("EK0007", std::vector<std::string>({"mode1", "mode2"}),
        std::vector<std::string>({"subscribe", "aclapi"}));
    return ACL_ERROR_PROF_API_CONFLICT;
}

void ProfAclMgr::SetModeToCmd()
{
    mode_ = WORK_MODE_CMD;
}

void ProfAclMgr::SetModeToOff()
{
    mode_ = WORK_MODE_OFF;
}

bool ProfAclMgr::IsCmdMode() const
{
    if (mode_ == WORK_MODE_CMD) {
        return true;
    }
    return false;
}

bool ProfAclMgr::IsAclApiMode() const
{
    if (mode_ == WORK_MODE_API_CTRL) {
        return true;
    }
    return false;
}

bool ProfAclMgr::IsAclApiReady() const
{
    if(params_ == nullptr) {
        return false;
    }
    if (IsAclApiMode() && params_->profMode == MSVP_PROF_ACLAPI_MODE) {
        return true;
    }
    return false;
}

bool ProfAclMgr::IsSubscribeMode() const
{
    if (mode_ == WORK_MODE_SUBSCRIBE) {
        return true;
    }
    return false;
}

bool ProfAclMgr::IsModeOff() const
{
    if (mode_ == WORK_MODE_OFF) {
        return true;
    }
    return false;
}

bool ProfAclMgr::IsPureCpuMode()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if ((dataTypeConfig_ & PROF_PURE_CPU) != 0) {
        return true;
    }
    return false;
}

bool ProfAclMgr::IsAclApiStatsMode()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if ((dataTypeConfig_ & PROF_API_STATS) != 0) {
        return true;
    }
    return false;
}

static ProfAclMgr*           profAclMgrObjPtr      = NULL;
static std::mutex            g_sigHandlerMtx;
static bool                  g_sigHandlerRegistered = false;
static volatile sig_atomic_t g_sigintReceived       = 0;  // 信号处理使用，符合 POSIX async-signal-safe
static std::atomic<bool>     g_sigWatcherQuit{false};  // 改为 atomic 以符合 C++ 内存模型
static std::unique_ptr<std::thread> g_sigWatcherThread;
static struct sigaction oldSigAction;

bool ProfAclMgr::IsSigintShutdownInProgress() const
{
    return g_sigintReceived != 0;
}

// forward declaration: SigintWatcherThread references newSigHandler by address
static void newSigHandler(int signum);

static void SigintWatcherThread()
{
    MSPROF_LOGI("SigintWatcherThread started");
    while (g_sigintReceived == 0 && !g_sigWatcherQuit.load()) {
        OsalSleep(10);
    }
    if (g_sigWatcherQuit.load()) {
        MSPROF_LOGI("SigintWatcherThread: normal quit");
        return;
    }
    int signum = static_cast<int>(g_sigintReceived);
    MSPROF_LOGI("SigintWatcherThread: received signal %d, waiting for graceful shutdown", signum);
    // Give the host application a window to react to the signal (e.g. CPython
    // raising KeyboardInterrupt and unwinding) before we force-finalize.
    // Stop polling early once the application's own teardown has driven the
    // profiling state machine into MODE_OFF (g_sigWatcherQuit set by UnInit).
    constexpr int kGraceLoops = 200;  // 200 * 10ms = 2s ceiling
    for (int i = 0; i < kGraceLoops && !g_sigWatcherQuit.load(); ++i) {
        OsalSleep(10);
    }
    if (g_sigWatcherQuit.load()) {
        MSPROF_LOGI("SigintWatcherThread: app finished teardown, no force finalize");
        return;
    }
    MSPROF_LOGI("SigintWatcherThread: calling MsprofFinalizeHandle as fallback");
    if (profAclMgrObjPtr != NULL) {
        (void)profAclMgrObjPtr->MsprofFinalizeHandle();
    }
    if (oldSigAction.sa_handler == SIG_DFL) {
        struct sigaction defaultAction;
        (void)memset_s(&defaultAction, sizeof(defaultAction), 0, sizeof(defaultAction));
        defaultAction.sa_handler = SIG_DFL;
        sigemptyset(&defaultAction.sa_mask);
        if (sigaction(signum, &defaultAction, nullptr) != 0) {
            MSPROF_LOGE("Failed to restore SIG_DFL handler");
        }
        raise(signum);
    } else if (oldSigAction.sa_handler != nullptr && oldSigAction.sa_handler != SIG_IGN) {
        if (sigaction(signum, &oldSigAction, nullptr) != 0) {
            MSPROF_LOGE("Failed to restore custom SIGINT handler");
        }
        raise(signum);
    }
    MSPROF_LOGI("SigintWatcherThread exited");
}

static void UnregisterSigalHandler()
{
    std::lock_guard<std::mutex> lk(g_sigHandlerMtx);
    if (!g_sigHandlerRegistered) {
        return;
    }
    // 使用 sigaction 恢复原始信号处理器
    if (sigaction(SIGINT, &oldSigAction, nullptr) != 0) {
        MSPROF_LOGE("Failed to restore SIGINT handler");
    }

    g_sigWatcherQuit.store(true);
    if (g_sigWatcherThread != nullptr) {
        if (g_sigWatcherThread->joinable()) {
            g_sigWatcherThread->join();
        }
        g_sigWatcherThread.reset();
    }
    profAclMgrObjPtr       = NULL;
    g_sigHandlerRegistered = false;
    g_sigintReceived       = 0;
    g_sigWatcherQuit.store(false);
    MSPROF_LOGI("UnregisterSigalHandler done");
}

static void newSigHandler(int signum)
{
    // Only sig_atomic_t assignment: async-signal-safe per POSIX
    // Actual finalize is done by SigintWatcherThread in normal thread context
    g_sigintReceived = static_cast<sig_atomic_t>(signum);
    // Forward the signal to the previously installed handler (e.g. CPython's
    // default_int_handler) so the host application stops scheduling new ops.
    // Without this, the profiled process keeps issuing tasks while the
    // watcher thread is finalizing -- those new tasks are captured on the host
    // side but their PMU association data is dropped because the device-side
    // collection has already been stopped, producing
    // "contextPmu has no matched log" in the analysis stage.
    if (oldSigAction.sa_handler != nullptr
        && oldSigAction.sa_handler != SIG_IGN
        && oldSigAction.sa_handler != SIG_DFL
        && oldSigAction.sa_handler != newSigHandler) {
        oldSigAction.sa_handler(signum);
    }
}

static void RegisterSiganlHandler(ProfAclMgr* ptr)
{
    std::lock_guard<std::mutex> lk(g_sigHandlerMtx);
    if (g_sigHandlerRegistered) {
        MSPROF_LOGI("SIGINT handler already registered, skip");
        return;
    }

    // 步骤1: 先创建线程（可能失败）
    try {
        g_sigWatcherThread = std::make_unique<std::thread>(SigintWatcherThread);
    } catch (const std::system_error& e) {
        MSPROF_LOGE("Failed to create SigintWatcherThread: %s", e.what());
        return;
    } catch (...) {
        MSPROF_LOGE("Failed to create SigintWatcherThread: unknown error");
        return;
    }

    // 步骤2: 设置对象指针
    profAclMgrObjPtr = ptr;

    // 步骤3: 使用 sigaction 注册信号处理器
    struct sigaction newAction;
    (void)memset_s(&newAction, sizeof(newAction), 0, sizeof(newAction));
    newAction.sa_handler = newSigHandler;
    (void)sigemptyset(&newAction.sa_mask);

    if (sigaction(SIGINT, &newAction, &oldSigAction) != 0) {
        MSPROF_LOGE("Failed to register SIGINT handler");
        // 清理：停止线程并删除
        g_sigWatcherQuit.store(true);
        if (g_sigWatcherThread != nullptr && g_sigWatcherThread->joinable()) {
            g_sigWatcherThread->join();
        }
        g_sigWatcherThread.reset();
        profAclMgrObjPtr = nullptr;
        return;
    }

    // 步骤4: 标记已注册
    g_sigHandlerRegistered = true;
    MSPROF_LOGI("RegisterSiganlHandler done");
}

/**
 * Init resources for acl api call
 */
int32_t ProfAclMgr::Init()
{
    MSPROF_LOGI("ProfAclMgr Init");
    RegisterSiganlHandler(this);
    if (isReady_) {
        return PROFILING_SUCCESS;
    }

    if (ProfManager::instance()->AclInit() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init ProfManager");
        return PROFILING_FAILED;
    }

    isReady_ = true;
    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::UnInit()
{
    UnregisterSigalHandler();
    params_ = nullptr;
    devTasks_.clear();
    statsDevSet_.clear();
    isReady_ = false;
    return PROFILING_SUCCESS;
}

/**
 * Handle ProfInit
 */
int32_t ProfAclMgr::ProfAclInit(const std::string &profResultPath)
{
    MSPROF_EVENT("Received ProfAclInit request from acl");
    std::lock_guard<std::mutex> lk(mtx_);
    if (!isReady_) {
        MSPROF_LOGE("Profiling is not ready");
        return ACL_ERROR_PROFILING_FAILURE;
    }
    if (mode_ != WORK_MODE_OFF) {
        MSPROF_LOGE("Profiling already inited");
        return ACL_ERROR_REPEAT_INITIALIZE;
    }

    MSPROF_LOGI("Input profInitCfg: %s", Utils::BaseName(profResultPath).c_str());
    std::string path = Utils::RelativePathToAbsolutePath(profResultPath);
    if (path.empty()) {
        MSPROF_LOGE("Input profResultPath is empty");
        return ACL_ERROR_INVALID_FILE;
    }
    if (!Utils::CheckPathWithInvalidChar(path)) {
        return ACL_ERROR_INVALID_FILE;
    }
    if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create dir: %s", Utils::BaseName(path).c_str());
        char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
        int32_t errNo = OsalGetErrorCode();
        std::string reason = "The operation create dir on directory " + path + " is abnormal. [Error " +
            std::to_string(errNo) + "] " + std::string(OsalGetErrorFormatMessage(errNo, errBuf, MAX_ERR_STRING_LEN));
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({path, "path of aclprofInit", reason}));
        return ACL_ERROR_INVALID_FILE;
    }
    path = Utils::CanonicalizePath(path);
    FUNRET_CHECK_EXPR_ACTION(path.empty(), return ACL_ERROR_INVALID_FILE, "Invalid path for aclprofInit");

    // Check path is valid
    if (!Utils::IsDirAccessible(path)) {
        MSPROF_LOGE("Dir is not accessible: %s", Utils::BaseName(path).c_str());
        char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
        int32_t errNo = OsalGetErrorCode();
        std::string reason = "The operation access on directory " + path + " is abnormal. [Error " +
            std::to_string(errNo) + "] " + std::string(OsalGetErrorFormatMessage(errNo, errBuf, MAX_ERR_STRING_LEN));
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({path, "path of aclprofInit", reason}));
        return ACL_ERROR_INVALID_FILE;
    }

    // Gen sub dir by time and create it
    resultPath_ = path;
    MSPROF_LOGI("Base directory: %s", Utils::BaseName(resultPath_).c_str());

    // reset device index
    devUuid_.clear();

    FUNRET_CHECK_EXPR_ACTION(InitParams() != ACL_SUCCESS, return ACL_ERROR_PROFILING_FAILURE, "Failed to init params");

    mode_ = WORK_MODE_API_CTRL;
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::InitParams()
{
    if (params_ != nullptr) {
        return ACL_SUCCESS;
    }
    MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return ACL_ERROR_PROFILING_FAILURE);
    return ACL_SUCCESS;
}

bool ProfAclMgr::IsInited()
{
    return mode_ != WORK_MODE_OFF;
}

/**
 * Handle ProfFinalize
 */
int32_t ProfAclMgr::ProfAclFinalize()
{
    MSPROF_EVENT("Received ProfAclFinalize request from acl");
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (mode_ != WORK_MODE_API_CTRL) {
            MSPROF_LOGE("Profiling has not been inited");
            return ACL_ERROR_PROF_NOT_RUN;
        }
    }
    (void)ProfStopStatsCallback();
    UploaderMgr::instance()->SetAllUploaderTransportStopped();
    std::lock_guard<std::mutex> lk(mtx_);
    for (auto iter = devTasks_.begin(); iter != devTasks_.end(); iter++) {
        iter->second.params->isCancel = true;
        if (ProfManager::instance()->IdeCloudProfileProcess(iter->second.params) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to finalize profiling on device %u", iter->first);
        }
    }
    UploaderMgr::instance()->DelAllUploader();
    MsprofTxUnInit();
    devTasks_.clear();

    mode_ = WORK_MODE_OFF;
    return ACL_SUCCESS;
}

/**
 * Handle ProfAclGetDataTypeConfig
 */
int32_t ProfAclMgr::ProfAclGetDataTypeConfig(const uint32_t devId, uint64_t &dataTypeConfig)
{
    std::lock_guard<std::mutex> lk(mtx_);
    const auto iter = devTasks_.find(devId);
    if (iter == devTasks_.end()) {
        MSPROF_LOGW("Device %u has not been started", devId);
        return ACL_ERROR_PROF_NOT_RUN;
    }
    dataTypeConfig = iter->second.dataTypeConfig;
    MSPROF_LOGI("Get dataTypeConfig %" PRIu64 " of device %u", dataTypeConfig, devId);
    return ACL_SUCCESS;
}

/**
 * Handle response from device
 */
void ProfAclMgr::HandleResponse(const uint32_t devId)
{
    const auto iter = devResponses_.find(devId);
    if (iter != devResponses_.end()) {
        iter->second->HandleResponse();
    }
}

uint64_t ProfAclMgr::ProfAclGetDataTypeConfig(const MsprofConfig *config) const
{
    if (config == nullptr) {
        MSPROF_LOGE("SubscribeConfig is nullptr");
        return 0;
    }
    uint64_t dataTypeConfig = 0;
    if (static_cast<bool>(config->cacheFlag)) {
        dataTypeConfig |= PROF_TASK_TIME | PROF_TASK_TIME_L1;
    }
    if (config->metrics != static_cast<uint32_t>(PROF_AICORE_NONE)) {
        dataTypeConfig |= PROF_AICORE_METRICS;
    }
    return dataTypeConfig;
}

uint64_t ProfAclMgr::GetProfSwitchHi(const uint64_t &dataTypeConfig) const
{
    uint64_t profSwitchHi = 0ULL;
    if (Platform::instance()->CheckIfSupport(PLATFORM_MC2) && (dataTypeConfig & PROF_TASK_TIME_L1) != 0) {
        profSwitchHi |= PROF_HI_AICPU_CHANNEL;
    }

    if (Platform::instance()->CheckIfSupport(PLATFORM_AICPU_HCCL) && (dataTypeConfig & PROF_TASK_TIME) != 0) {
        profSwitchHi |= PROF_HI_AICPU_CHANNEL;
    }
    return profSwitchHi;
}

void ProfAclMgr::AddModelLoadConf(uint64_t &dataTypeConfig) const
{
    dataTypeConfig |= PROF_MODEL_LOAD;
}

void ProfAclMgr::AddAiCpuModelConf(uint64_t &dataTypeConfig) const
{
    dataTypeConfig |= PROF_AICPU_MODEL;
}

void ProfAclMgr::AddRuntimeTraceConf(uint64_t &dataTypeConfig) const
{
    if ((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) {
        dataTypeConfig |= PROF_RUNTIME_TRACE;
    }
}

void ProfAclMgr::AddProfLevelConf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
    const uint64_t dataTypeConfig) const
{
    if ((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) {
        params->prof_level = MSVP_LEVEL_L0;
    }
    if (((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) && ((dataTypeConfig & PROF_TASK_TIME_L1_MASK) != 0)) {
        params->prof_level = MSVP_LEVEL_L1;
    }
    if (((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) && ((dataTypeConfig & PROF_TASK_TIME_L1_MASK) != 0) &&
        ((dataTypeConfig & PROF_TASK_TIME_L2_MASK) != 0)) {
        params->prof_level = MSVP_LEVEL_L2;
    }
    if (((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) && ((dataTypeConfig & PROF_TASK_TIME_L1_MASK) != 0) &&
        ((dataTypeConfig & PROF_TASK_TIME_L2_MASK) != 0) && ((dataTypeConfig & PROF_TASK_TIME_L3_MASK) != 0)) {
        params->prof_level = MSVP_LEVEL_L3;
    }
}

void ProfAclMgr::ChangeLevelConf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    // change input config [on, l0, l1, l2, l3] to level0 level1 level2, level3
    if (params->prof_level == MSVP_PROF_L3) {
        params->prof_level = MSVP_LEVEL_L3;
    }
    if (params->prof_level == MSVP_PROF_L2) {
        params->prof_level = MSVP_LEVEL_L2;
    }
    if (params->prof_level == MSVP_PROF_ON || params->prof_level == MSVP_PROF_L1) {
        params->prof_level = MSVP_LEVEL_L1;
    }
    if (params->prof_level == MSVP_PROF_L0) {
        params->prof_level = MSVP_LEVEL_L0;
    }
}

void ProfAclMgr::AddCcuInstruction(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_CCU_INSTRUTION)) {
        return;
    }
    if (params->prof_level == MSVP_LEVEL_L1 || params->prof_level == MSVP_LEVEL_L2) {
        params->ccuInstr = MSVP_PROF_ON;
    }
}

void ProfAclMgr::AddSubscribeConf(uint64_t &dataTypeConfig) const
{
    ProfAclMgr::instance()->AddOpDetailConf(dataTypeConfig);
    ProfAclMgr::instance()->AddModelLoadConf(dataTypeConfig);
    ProfAclMgr::instance()->AddRuntimeTraceConf(dataTypeConfig);
}

void ProfAclMgr::AddLowPowerConf(NanoJson::Json &jsonCfg)
{
    if (jsonCfg.Contains("sys_lp_freq")) {
        params_->sysLp = MSVP_PROF_ON;
    }
    params_->sysLpFreq = HZ_CONVERT_US / GetJsonIntParam(jsonCfg, "sys_lp_freq", HZ_HUNDRED);
}

void ProfAclMgr::AddOpDetailConf(uint64_t &dataTypeConfig) const
{
    dataTypeConfig |= PROF_OP_DETAIL_MASK;
}

int32_t ProfAclMgr::CheckSubscribeConfig(const MsprofConfig *config) const
{
    if (reinterpret_cast<void*>(config->fd) == nullptr) {
        MSPROF_LOGE("SubscribeConfig is nullptr");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (!static_cast<bool>(config->cacheFlag) && config->metrics == PROF_AICORE_NONE) {
        MSPROF_LOGE("SubscribeConfig is invalid");
        std::string value = std::to_string(config->cacheFlag);
        std::string reason = "Set the timeInfo switch to 1 if you want to receive subscribe information";
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({value, "timeInfo of aclprofCreateSubscribeConfig", reason}));
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_SUCCESS;
}

void ProfAclMgr::CloseSubscribeFdIfHostId(uint32_t devId)
{
    if (devId == DEFAULT_HOST_ID) {
        for (auto &it : fdCloseInfos_) {
            CloseSubscribeFd(it);
        }
        fdCloseInfos_.clear();
    } else {
        fdCloseInfos_.emplace_back(devId);
    }
}

void ProfAclMgr::FlushAllData(const std::string &devId) const
{
    // flush ai stack data
    Msprof::Engine::FlushAllModule();
    ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().FlushAllReporter();
    // flush drv data
    ProfChannelManager::instance()->FlushChannel();
    // flush parserTransport
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(devId, uploader);
    if (uploader != nullptr) {
        uploader->Flush();
        auto transport = uploader->GetTransport();
        if (transport != nullptr) {
            transport->WriteDone();
        }
    }
}

bool ProfAclMgr::IsModelSubscribed(const std::string &key)
{
    std::lock_guard<std::mutex> lk(mtx_);
    const auto iter = subscribeInfos_.find(key);
    if (iter == subscribeInfos_.end()) {
        return false;
    }
    return iter->second.subscribed;
}

int32_t ProfAclMgr::GetSubscribeFdForModel(const ProfSubscribeKey &subscribeKey)
{
    std::lock_guard<std::mutex> lk(mtxSubscribe_);
    const auto iter = subscribeInfos_.find(subscribeKey.key);
    if (iter == subscribeInfos_.end()) {
        return -1;
    }
    return *(iter->second.fd);
}

void ProfAclMgr::GetRunningDevices(std::vector<uint32_t> &devIds)
{
    std::lock_guard<std::mutex> lk(mtx_);
    for (auto iter = devTasks_.cbegin(); iter != devTasks_.cend(); iter++) {
        devIds.push_back(iter->first);
    }
}

uint64_t ProfAclMgr::GetDeviceSubscribeCount(SHARED_PTR_ALIA<ProfSubscribeKey> subscribeKey, uint32_t &devId)
{
    std::lock_guard<std::mutex> lk(mtx_);
    const auto iterSub = subscribeInfos_.find(subscribeKey->key);
    if (iterSub == subscribeInfos_.end()) {
        return 0;
    }
    devId = iterSub->second.devId;
    auto iterDev = devTasks_.find(iterSub->second.devId);
    if (iterDev == devTasks_.end()) {
        return 0;
    }
    return (iterDev->second.count - 1);
}

uint64_t ProfAclMgr::GetCmdModeDataTypeConfig()
{
    std::lock_guard<std::mutex> lk(mtx_);
    return dataTypeConfig_;
}

std::string ProfAclMgr::GetOpTypeConfig()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (params_ == nullptr) {
        return "";
    }
    return params_->opType;
}

std::string ProfAclMgr::GetParamJsonStr()
{
    if (params_ == nullptr) {
        MSPROF_LOGW("ProfileParams is empty");
        return "{}";
    }
    NanoJson::Json object;
    params_->ToObject(object);
    object.RemoveByKey("memServiceflow");
    object.RemoveByKey("ubProfiling");
    object.RemoveByKey("ubInterval");
    object.RemoveByKey("opType");
    return object.ToString();
}

/**
 * @brief Generate name of directory for prof main
 * @return: absolute path to prof main
 */
std::string ProfAclMgr::GenerateProfMainName() const
{
    std::string resultDir = resultPath_ + MSVP_SLASH + baseDir_;
    return resultDir;
}

/**
 * @brief Generate name of directory for device and host
 * @param [in] devId: device id
 * @return: absolute path to host or device level
 */
std::string ProfAclMgr::GenerateProfDirName(const std::string& devId)
{
    std::string resultDir = GenerateProfMainName() + MSVP_SLASH + devUuid_[devId] + MSVP_SLASH;
    return resultDir;
}

uint64_t HashDataGenHashIdWrapper(const std::string &str) {
    return HashData::instance()->GenHashId(str);
}

/**
 * Create dir and uploader
 */
int32_t ProfAclMgr::InitUploader(const std::string& devIdStr)
{
    int32_t ret = 0;
    if ((dataTypeConfig_ & PROF_API_STATS) != 0) {
        ret = InitStatsUploader();
    } else if (mode_ == WORK_MODE_API_CTRL || mode_ == WORK_MODE_CMD) {
        ret = InitApiCtrlUploader(devIdStr);
    } else if (mode_ == WORK_MODE_SUBSCRIBE) {
        ret = InitSubscribeUploader(devIdStr);
    } else {
        MSPROF_LOGE("Profiling mode is off, no uploader can be inited");
        ret = ACL_ERROR_PROFILING_FAILURE;
    }
    UploaderMgr::instance()->RegisterAllUploaderTransportGenHashIdFuncPtr(HashDataGenHashIdWrapper);
    return ret;
}

int32_t ProfAclMgr::RecordOutPut(const std::string &data)
{
    std::string envValue;
    MSPROF_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, envValue);
    if (envValue.empty()) {
        MSPROF_LOGI("RecordOutPut, not acl env mode");
        return PROFILING_SUCCESS;
    }
    if (data.empty()) {
        MSPROF_LOGI("RecordOutPut, data is empty");
        return PROFILING_SUCCESS;
    }
    std::string pidStr = std::to_string(params_->msprofBinPid);
    std::string recordFile = pidStr + MSVP_UNDERLINE + OUTPUT_RECORD;
    std::string absolutePath = resultPath_ + MSVP_SLASH + recordFile;
    std::string profName = data + "\n";
    if (WriteFile(absolutePath, recordFile, profName) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

bool ProfAclMgr::EnableRpcHelperMode(std::string msprofPath)
{
    // Designed for 1971 helper, working path is not needed
    // masterPid_ is host running pid, curDevId_ is udf device id
    MSPROF_GET_ENV(MM_ENV_ASCEND_HOSTPID, masterPid_);
    MSPROF_LOGI("Get master pid: %s.", masterPid_.c_str());
    if (!Utils::IsAllDigit(masterPid_) || !Utils::IsAllDigit(msprofPath)) {
        masterPid_ = MSVP_PROF_EMPTY_STRING;
        MSPROF_LOGW("masterPid_:%s, msprofPath:%s, which is not meet the requirements of rpc udf.",
            masterPid_.c_str(), msprofPath.c_str());
        return false;
    }
    int32_t curDevId = 0;
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(curDevId, msprofPath), return false,
        "msprofPath %s is invalid", msprofPath.c_str());
    curDevId_ = curDevId;
    Platform::instance()->EnableRpcHelper();
    return true;
}

SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> ProfAclMgr::PackDataTrunk() const
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return nullptr);
    fileChunkReq->isLastChunk = true;
    fileChunkReq->chunkModule = 0;
    fileChunkReq->chunkSize = DEVICE_PID.size();
    fileChunkReq->offset = 0;
    fileChunkReq->chunk = DEVICE_PID;
    fileChunkReq->fileName = DEVICE_PID;
    fileChunkReq->extraInfo = MSVP_PROF_EMPTY_STRING;
    fileChunkReq->id = std::to_string(Utils::GetPid());
    return fileChunkReq;
}

void setUploaderPipeTransport(const std::string devId) {
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(devId, uploader);
    if (uploader != nullptr) {
        SHARED_PTR_ALIA<ITransport> trans = MsptiPipeTransportFactory().CreateMsptiPipeTransport();
        uploader->SetPipeTransport(trans);
    }
}

int32_t ProfAclMgr::InitStatsUploader()
{
    std::lock_guard<std::mutex> lk(mtxUploader_);
    devUuid_[PROF_HOST_JOBID] = Utils::CreateResultPath(PROF_HOST_JOBID);
    std::string hostDir = GenerateProfDirName(PROF_HOST_JOBID);
    if (Utils::CreateDir(hostDir) != PROFILING_SUCCESS) {
        char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
        int32_t errNo = OsalGetErrorCode();
        MSPROF_LOGE("Failed to create host dir: %s. [Error %d] %s.", Utils::BaseName(hostDir).c_str(),
            errNo, OsalGetErrorFormatMessage(errNo, errBuf, MAX_ERR_STRING_LEN));
        std::string reason = "The operation create dir on directory " + baseDir_ + " is abnormal. [Error " +
            std::to_string(errNo) + "] " + std::string(OsalGetErrorFormatMessage(errNo, errBuf, MAX_ERR_STRING_LEN));
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({baseDir_, "output path", reason}));
        return ACL_ERROR_INVALID_FILE;
    }
    std::string recordOutPutStr = baseDir_;
    FUNRET_CHECK_EXPR_LOGW(RecordOutPut(recordOutPutStr) != PROFILING_SUCCESS,
        "Unable to record output dir:%s, devId:%s", Utils::BaseName(devUuid_[PROF_HOST_JOBID]).c_str(),
        PROF_HOST_JOBID.c_str());
    SHARED_PTR_ALIA<ITransport> transport = nullptr;
    transport = StatsTransportFactory().CreateStatsTransport(hostDir);
    if (transport == nullptr) {
        MSPROF_LOGE("Failed to create transport for device %s", PROF_HOST_JOBID.c_str());
        return ACL_ERROR_INVALID_FILE;
    }

    const size_t uploaderCapacity = 4096 * 4; // 16384 : need more uploader capacity
    int32_t ret = UploaderMgr::instance()->CreateUploader(PROF_HOST_JOBID, transport, uploaderCapacity);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create uploader for device %s", PROF_HOST_JOBID.c_str());
        return ACL_ERROR_PROFILING_FAILURE;
    }

    return ACL_SUCCESS;
}

bool ProfAclMgr::InitClientUploader(const std::string& devIdStr, SHARED_PTR_ALIA<ITransport> transport)
{
    MSPROF_LOGI("Create master transport pid: %s, currentId:%s.", masterPid_.c_str(), devIdStr.c_str());
    if (curDevId_ > MSVP_MAX_DEV_NUM || curDevId_ < 0) {
        MSPROF_LOGE("device id[%u] is out of range, which should be limited in %u.", curDevId_, MSVP_MAX_DEV_NUM);
        return false;
    }

    HDC_CLIENT client = Analysis::Dvvp::Adx::AdxHdcClientCreate(HDC_SERVICE_TYPE_IDE1);
    if (client == nullptr) {
        MSPROF_LOGE("HDC client is invalid");
        return false;
    }

    int32_t masterPid = 0;
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(masterPid, masterPid_), return false, 
        "masterPid_ %s is invalid", masterPid_.c_str());
    transport = analysis::dvvp::transport::HelperTransportFactory().CreateHdcClientTransport(masterPid,
        curDevId_, client);
    if (transport == nullptr) {
        Analysis::Dvvp::Adx::AdxHdcClientDestroy(client);
        MSPROF_LOGE("Create HdcClientTransport failed.");
        return false;
    }

    return true;
}

int32_t ProfAclMgr::InitApiCtrlUploader(const std::string& devIdStr)
{
    std::lock_guard<std::mutex> lk(mtxUploader_);
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(devIdStr, uploader);
    if (uploader != nullptr) {
        return ACL_SUCCESS;
    }
    SHARED_PTR_ALIA<ITransport> transport = nullptr;
    if (Platform::instance()->CheckIfRpcHelper()) {
#ifndef PROF_LITE
        if (!InitClientUploader(devIdStr, transport)) {
            return ACL_ERROR_PROFILING_FAILURE;
        }
        SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq = PackDataTrunk();
        transport->SendBuffer(fileChunkReq);
#endif
    } else {
        // first start
        MSPROF_LOGI("Create transport with pid: %s.", devIdStr.c_str());
        devUuid_[devIdStr] = Utils::CreateResultPath(devIdStr);
        std::string devDir = GenerateProfDirName(devIdStr);
        if (Utils::CreateDir(devDir) != PROFILING_SUCCESS) {
            char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
            int32_t errNo = OsalGetErrorCode();
            MSPROF_LOGE("Failed to create device dir: %s. [Error %d] %s.", Utils::BaseName(devDir).c_str(),
                errNo, OsalGetErrorFormatMessage(errNo, errBuf, MAX_ERR_STRING_LEN));
            std::string reason = "The operation create dir on directory " + baseDir_ +
                " is abnormal. [Error " + std::to_string(errNo) + "] " +
                std::string(OsalGetErrorFormatMessage(errNo, errBuf, MAX_ERR_STRING_LEN));
            MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
                std::vector<std::string>({baseDir_, "output path", reason}));
            return ACL_ERROR_INVALID_FILE;
        }
        std::string outPutStr = baseDir_;
        FUNRET_CHECK_EXPR_LOGW(RecordOutPut(outPutStr) != PROFILING_SUCCESS, "Unable to record output dir:%s, devId:%s",
                        Utils::BaseName(devUuid_[devIdStr]).c_str(), devIdStr.c_str());
        transport = FileTransportFactory().CreateFileTransport(devDir, storageLimit_, true);
        if (transport == nullptr) {
            MSPROF_LOGE("Failed to create transport for device %s", devIdStr.c_str());
            return ACL_ERROR_INVALID_FILE;
        }
    }
    const size_t uploaderCapacity = 4096 * 4; // 16384 : need more uploader capacity
    int32_t ret = UploaderMgr::instance()->CreateUploader(devIdStr, transport, uploaderCapacity);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create uploader for device %s", devIdStr.c_str());
        return ACL_ERROR_PROFILING_FAILURE;
    }
    setUploaderPipeTransport(devIdStr);
    return ACL_SUCCESS;
}

void ProfAclMgr::RegisterTransport(ProfImplRegisterTransport callback)
{
    createTransport_ = callback;
}

int32_t ProfAclMgr::InitSubscribeUploader(const std::string &devIdStr)
{
    std::lock_guard<std::mutex> lk(mtxUploader_);
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(devIdStr, uploader);
    if (uploader == nullptr) {
        // create transport1 and uploader1
        SHARED_PTR_ALIA<ITransport> parserTransport = nullptr;
        if (createTransport_ != nullptr) {
            parserTransport = createTransport_();
        }
        if (parserTransport == nullptr) {
            MSPROF_LOGE("Failed to create parsertransport for subscribe");
            return ACL_ERROR_PROFILING_FAILURE;
        }
        parserTransport->SetDevId(devIdStr);
        parserTransport->SetType(subscribeType_);
        const uint32_t capacity = 16384;
        int32_t ret = UploaderMgr::instance()->CreateUploader(devIdStr, parserTransport, capacity);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to create uploader for subscribe");
            return ACL_ERROR_PROFILING_FAILURE;
        }
    }

    return ACL_SUCCESS;
}

/**
 * Check if device is free and is online.
 */
int32_t ProfAclMgr::CheckDeviceTask(const MsprofConfig *config)
{
    std::vector<uint32_t> devIds;
    for (uint32_t i = 0; i < config->devNums; i++) {
        uint32_t devId = config->devIdList[i];
        auto iter = devTasks_.find(devId);
        if (iter != devTasks_.end()) {
            if (devId == DEFAULT_HOST_ID) { // mini 多device场景下不拉起多个HOST处理线程
                MSPROF_LOGI("The host process is already in use.");
                iter->second.count++;
                continue;
            }
            MSPROF_LOGE("Device %u already started", devId);
            std::string value = std::to_string(devId);
            std::string reason = "The profiling task on device " + value + " is already started";
            MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
                std::vector<std::string>({value, "device id", reason}));
            return ACL_ERROR_PROF_ALREADY_RUN;
        }
        devIds.push_back(devId);
    }

    return ACL_SUCCESS;
}

/**
 * @brief  : SampleBased transfer dataTypeConfig to ProfApiStartReq
 * @param  : [in] msprofStartCfg : msprof cfg
 * @param  : [out] ProfApiStartReq : acl api struct cfg
 */
void ProfAclMgr::SampleBasedCfgTrfToReq(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
    SHARED_PTR_ALIA<ProfApiStartReq> feature) const
{
    // sample-based StartCfg Transfer
    MSPROF_LOGI("Begin to transfer sample=based msprof StartCfg to api StartReq");
    bool systemTraceConf = false;
    SHARED_PTR_ALIA<ProfApiSysConf> conf = nullptr;
    MSVP_MAKE_SHARED0(conf, ProfApiSysConf, return);
    if ((dataTypeConfig & PROF_CPU_MASK) != 0) {
        systemTraceConf = true;
        conf->cpuSamplingInterval = DEFAULT_PROFILING_INTERVAL_20MS;
    }
    if ((dataTypeConfig & PROF_HARDWARE_MEMORY_MASK) != 0) {
        systemTraceConf = true;
        conf->hardwareMemSamplingInterval = analysis::dvvp::message::DEFAULT_PROFILING_INTERVAL_100MS;
    }
    if ((dataTypeConfig & PROF_IO_MASK) != 0) {
        systemTraceConf = true;
        conf->ioSamplingInterval = analysis::dvvp::message::DEFAULT_PROFILING_INTERVAL_100MS;
    }
    if ((dataTypeConfig & PROF_INTER_CONNECTION_MASK) != 0) {
        systemTraceConf = true;
        conf->interconnectionSamplingInterval = analysis::dvvp::message::DEFAULT_PROFILING_INTERVAL_100MS;
    }
    if ((dataTypeConfig & PROF_DVPP_MASK) != 0) {
        systemTraceConf = true;
        conf->dvppSamplingInterval = analysis::dvvp::message::DEFAULT_PROFILING_INTERVAL_100MS;
    }
    std::string metrics;
    AicoreMetricsEnumToName(aicMetrics, metrics);
    if ((dataTypeConfig & PROF_SYS_AICORE_SAMPLE_MASK) != 0 && (!metrics.empty())) {
        systemTraceConf = true;
        conf->aicoreSamplingInterval = DEFAULT_PROFILING_INTERVAL_10MS;
        conf->aicoreMetrics = metrics;
        conf->aivSamplingInterval = DEFAULT_PROFILING_INTERVAL_10MS;
        conf->aivMetrics = metrics;
    }
    if (systemTraceConf) {
        feature->systemTraceConf = ProfParamsAdapter::instance()->EncodeSysConfJson(conf);
    }
}

/**
 * Start device acl-api task
 */
int32_t ProfAclMgr::StartDeviceTask(const uint32_t devId,
                                    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    std::string devIdStr = std::to_string(devId);
    // init uploader
    const int32_t ret = InitUploader(devIdStr);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    // set devId as job_id, set devices, set result_dir
    params->job_id = devIdStr;
    params->devices = devIdStr;
    params->result_dir = GenerateProfDirName(devIdStr);

    // create params
    auto paramsHandled = ProfManager::instance()->HandleProfilingParams(devId, params->ToString());

    // add responseHandler
    SHARED_PTR_ALIA<DeviceResponseHandler> handler = nullptr;
    MSVP_MAKE_SHARED1(handler, DeviceResponseHandler, devId, return ACL_ERROR_PROFILING_FAILURE);
    devResponses_[devId] = handler;
    handler->Start();

    // start profiling process
    if (ProfManager::instance()->IdeCloudProfileProcess(paramsHandled) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start profiling on device %u", devId);
        HandleResponse(devId);
        return ACL_ERROR_PROFILING_FAILURE;
    }

    // add taskInfo
    ProfAclTaskInfo taskInfo = {1, 0, paramsHandled};
    devTasks_[devId] = taskInfo;

    return ACL_SUCCESS;
}

/**
 * All starting devices create a thread to wait for response
 */
void ProfAclMgr::WaitAllDeviceResponse()
{
    for (auto iter = devResponses_.cbegin(); iter != devResponses_.cend(); iter++) {
        iter->second->Join();
    }
    MSPROF_EVENT("All devices finished waiting");
    devResponses_.clear();
}

void ProfAclMgr::WaitDeviceResponse(const uint32_t devId)
{
    const auto iter = devResponses_.find(devId);
    if (iter != devResponses_.end()) {
        iter->second->Join();
        MSPROF_EVENT("Device:%u finished waiting", devId);
        devResponses_.erase(iter);
    }
}

int32_t ProfAclMgr::UpdateSubscribeInfo(const std::string &key, const uint32_t devId,
                                    const MsprofConfig *config)
{
    auto iterDev = devTasks_.find(devId);
    if (iterDev == devTasks_.end()) {
        return ACL_ERROR_PROFILING_FAILURE;
    }
    // check dataTypeConfig
    const auto dataTypeConfig = ProfAclGetDataTypeConfig(config);
    if (iterDev->second.dataTypeConfig != dataTypeConfig) {
        MSPROF_LOGE("Subscribe config %x is different from previous one: %x",
            dataTypeConfig, iterDev->second.dataTypeConfig);
        std::string value = std::to_string(dataTypeConfig);
        std::string reason = "Subscribe config " + value + " is different from previous one " +
            std::to_string(iterDev->second.dataTypeConfig);
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({value, "dataTypeConfig", reason}));
        return ACL_ERROR_INVALID_PROFILING_CONFIG;
    }
    // check aicore
    std::string aicoreMetrics;
    AicoreMetricsEnumToName(static_cast<ProfAicoreMetrics>(config->metrics), aicoreMetrics);
    if (iterDev->second.params->ai_core_metrics != aicoreMetrics) {
        MSPROF_LOGE("Subscribe aicore metrics %s is different from previous one: %s", aicoreMetrics.c_str(),
            iterDev->second.params->ai_core_metrics.c_str());
        return ACL_ERROR_INVALID_PROFILING_CONFIG;
    }
    if (iterDev->second.count + 1 == 0) {
        MSPROF_LOGE("Subscribe count is too large");
        std::string value = std::to_string(iterDev->second.count);
        std::string reason = "Subscribe count is too large, which should be less than UINT32_MAX";
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({value, "count", reason}));
        return ACL_ERROR_INVALID_PROFILING_CONFIG;
    }
    iterDev->second.count++;
    if (devId == DEFAULT_HOST_ID) {
        return ACL_SUCCESS;
    }
    std::lock_guard<std::mutex> lk(mtxSubscribe_);
    auto iter = subscribeInfos_.find(key);
    if (iter != subscribeInfos_.end()) {
        // re subscribe
        iter->second.subscribed = true;
        iter->second.devId = devId;
        iter->second.fd = reinterpret_cast<int32_t *>(config->fd);
    } else {
        // new subscribe
        ProfSubscribeInfo subscribeInfo = {true, devId, reinterpret_cast<int32_t *>(config->fd)};
        subscribeInfos_.insert(std::make_pair(key, subscribeInfo));
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::StartDeviceSubscribeTask(const std::string &key, const uint32_t devId,
                                         const MsprofConfig *config)
{
    auto dataTypeConfig = ProfAclGetDataTypeConfig(config);
    // generate params
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, return ACL_ERROR_PROFILING_FAILURE);
    params->profiling_mode = analysis::dvvp::message::PROFILING_MODE_DEF;
    SHARED_PTR_ALIA<ProfApiStartReq> feature = nullptr;
    MSVP_MAKE_SHARED0(feature, ProfApiStartReq, return ACL_ERROR_PROFILING_FAILURE);

    // Transfer dataTypeConfig to ProfApiStartReq
    TaskBasedCfgTrfToReq(dataTypeConfig, static_cast<ProfAicoreMetrics>(config->metrics), feature);
    // Transfer dataTypeConfig to inner params
    ProfParamsAdapter::instance()->StartCfgTrfToInnerParam(dataTypeConfig, params);
    // Transfer ProfApiStartReq to inner params
    int32_t ret = ProfParamsAdapter::instance()->StartReqTrfToInnerParam(feature, params);
    if (ret != PROFILING_SUCCESS) {
        return ACL_ERROR_PROFILING_FAILURE;
    }
    if (devId == DEFAULT_HOST_ID) {
        params->hostProfiling = true;
    }
    params->profMode = MSVP_PROF_SUBSCRIBE_MODE;
    params->ts_keypoint = MSVP_PROF_ON;
    std::string devIdStr = std::to_string(devId);
    params->job_id = devIdStr;
    params->devices = devIdStr;
    Platform::instance()->SetSubscribeFeature();

    ret = InitSubscribeUploader(devIdStr);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    // start responseHandler
    SHARED_PTR_ALIA<DeviceResponseHandler> handler = nullptr;
    MSVP_MAKE_SHARED1(handler, DeviceResponseHandler, devId, return ACL_ERROR_PROFILING_FAILURE);
    devResponses_[devId] = handler;
    (void)handler->Start();

    // start profiling process
    auto paramsHandled = ProfManager::instance()->HandleProfilingParams(devId, params->ToString());
    if (ProfManager::instance()->IdeCloudProfileProcess(paramsHandled) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start profiling on device %u", devId);
        HandleResponse(devId);
        return ACL_ERROR_PROFILING_FAILURE;
    }

    // add taskInfo
    ProfAclTaskInfo taskInfo = {1, dataTypeConfig, paramsHandled};
    devTasks_[devId] = taskInfo;
    if (devId != DEFAULT_HOST_ID) {
        mtxSubscribe_.lock();
        ProfSubscribeInfo subscribeInfo = {true, devId, reinterpret_cast<int32_t *>(config->fd)};
        subscribeInfos_.insert(std::make_pair(key, subscribeInfo));
        mtxSubscribe_.unlock();
    }

    WaitAllDeviceResponse();
    MSPROF_LOGI("Finished starting subscribe task on device %u", devId);
    if (mode_ == WORK_MODE_OFF) {
        mode_ = WORK_MODE_SUBSCRIBE;
    }
    if (devId == DEFAULT_HOST_ID) {
        params->hostProfiling = false;
    }
    return ACL_SUCCESS;
}

std::string ProfAclMgr::MsprofResultDirAdapter(const std::string &dir) const
{
    std::string result;
    if (dir.empty()) {
        std::string ascendWorkPath;
        MSPROF_GET_ENV(MM_ENV_ASCEND_WORK_PATH, ascendWorkPath);
        if (!ascendWorkPath.empty()) {
            MSPROF_LOGI("No output set, use %s path", ASCEND_WORK_PATH_ENV.c_str());
            std::string path = Utils::RelativePathToAbsolutePath(ascendWorkPath) + MSVP_SLASH + PROFILING_RESULT_PATH;
            if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
                MSPROF_LOGW("Unable to create dir: %s", path.c_str());
            }
            result = Utils::CanonicalizePath(path);
        } else {
            MSPROF_LOGI("No output set, use default path");
        }
    } else {
        std::string path = Utils::RelativePathToAbsolutePath(dir);
        if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
            MSPROF_LOGW("Unable to create dir: %s", path.c_str());
        }
        result = analysis::dvvp::common::utils::Utils::CanonicalizePath(path);
    }
    if (result.empty() || !analysis::dvvp::common::utils::Utils::IsDirAccessible(result)) {
        MSPROF_LOGI("No output set or is not accessible, use app dir instead");
        result = analysis::dvvp::common::utils::Utils::GetSelfPath();
        size_t pos = result.rfind(analysis::dvvp::common::utils::MSVP_SLASH);
        if (pos != std::string::npos) {
            result = result.substr(0, pos + 1);
        }
    }
    MSPROF_LOGI("MsprofResultDirAdapter result path: %s", result.c_str());

    return result;
}

void ProfAclMgr::ProfDataTypeConfigHandle(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params == nullptr) {
        return;
    }
    dataTypeConfig_ = 0;
    AddAiCpuModelConf(dataTypeConfig_);

    UpdateDataTypeConfigByMetrics(params);
    UpdateDataTypeConfigByTimelineTrace(params);
    UpdateDataTypeConfigByProfLevel(params);
    UpdateDataTypeConfigByGeApi(params);
    UpdateDataTypeConfigBySwitches(params);

    MSPROF_EVENT("ProfDataTypeConfigHandle dataTypeConfig:0x%llx", dataTypeConfig_);
}

void ProfAclMgr::UpdateDataTypeConfigByMetrics(const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (!params->ai_core_metrics.empty()) {
        dataTypeConfig_ |= PROF_AICORE_METRICS;
    }
    if (!params->aiv_metrics.empty()) {
        dataTypeConfig_ |= PROF_AIVECTORCORE_METRICS;
    }
}

void ProfAclMgr::UpdateDataTypeConfigByTimelineTrace(const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params->ts_timeline == MSVP_PROF_ON) {
        dataTypeConfig_ |= PROF_SCHEDULE_TIMELINE | PROF_TASK_TIME;
    }
    if (params->ts_task_track == MSVP_PROF_ON || params->ts_task_time == MSVP_PROF_ON) {
        dataTypeConfig_ |= PROF_SCHEDULE_TRACE;
    }
}

void ProfAclMgr::UpdateDataTypeConfigByProfLevel(const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params->prof_level == MSVP_LEVEL_L3) {
        dataTypeConfig_ |= PROF_TASK_TIME_L3 | PROF_TASK_TIME_L2 | PROF_TASK_TIME_L1 | PROF_TASK_TIME;
    }
    if (params->prof_level == MSVP_LEVEL_L2) {
        dataTypeConfig_ |= PROF_TASK_TIME_L2 | PROF_TASK_TIME_L1 | PROF_TASK_TIME;
    }
    if (params->prof_level == MSVP_LEVEL_L1) {
        dataTypeConfig_ |= PROF_TASK_TIME_L1 | PROF_TASK_TIME;
    }
    if (params->prof_level == MSVP_LEVEL_L0) {
        dataTypeConfig_ |= PROF_TASK_TIME;
    }
}

void ProfAclMgr::UpdateDataTypeConfigByGeApi(const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params->geApi == MSVP_PROF_L0) {
        dataTypeConfig_ |= PROF_GE_API_L0;
    }
    if (params->geApi == MSVP_PROF_L1) {
        dataTypeConfig_ |= PROF_GE_API_L0 | PROF_GE_API_L1;
    }
    if (!params->opType.empty()) {
        dataTypeConfig_ |= PROF_OP_MASK;
    }
}

void ProfAclMgr::UpdateDataTypeConfigBySwitches(const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    UpdateDataTypeConfigBySwitch(params->taskMemory, PROF_TASK_MEMORY);
    UpdateDataTypeConfigBySwitch(params->acl, PROF_ACL_API);
    UpdateDataTypeConfigBySwitch(params->stars_acsq_task, PROF_TASK_TIME);
    UpdateDataTypeConfigBySwitch(params->hwts_log, PROF_TASK_TIME);
    UpdateDataTypeConfigBySwitch(params->aicpuTrace, PROF_AICPU_TRACE);
    UpdateDataTypeConfigBySwitch(params->runtimeApi, PROF_RUNTIME_API);
    UpdateDataTypeConfigBySwitch(params->taskTsfw, PROF_TASK_TSFW);
    UpdateDataTypeConfigBySwitch(params->runtimeTrace, PROF_RUNTIME_TRACE);
    UpdateDataTypeConfigBySwitch(params->ts_fw_training, PROF_TRAINING_TRACE);
    UpdateDataTypeConfigBySwitch(params->ts_keypoint, PROF_TRAINING_TRACE);
    UpdateDataTypeConfigBySwitch(params->hcclTrace, PROF_HCCL_TRACE);
    UpdateDataTypeConfigBySwitch(params->l2CacheTaskProfiling, PROF_L2CACHE);
    UpdateDataTypeConfigBySwitch(params->instrProfiling, PROF_INSTR);
    UpdateDataTypeConfigBySwitch(params->pureCpu, PROF_PURE_CPU);
}

void ProfAclMgr::UpdateDataTypeConfigBySwitch(const std::string &sw, const uint64_t dataTypeConfig)
{
    if (sw == MSVP_PROF_ON) {
        dataTypeConfig_ |= dataTypeConfig;
    }
}

std::string ProfAclMgr::MsprofCheckAndGetChar(CHAR_PTR data, uint32_t dataLen) const
{
    uint32_t i;
    for (i = 0; i < dataLen; i++) {
        if (data[i] != '\0') {
            continue;
        } else {
            break;
        }
    }
    if (i > 0 && i < dataLen) {
        return std::string(data, i);
    } else {
        return "";
    }
}

void ProfAclMgr::MsprofAclJsonParamAdaper(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params == nullptr) {
        return;
    }
    params->profiling_mode = analysis::dvvp::message::PROFILING_MODE_DEF;
    params->job_id = Utils::ProfCreateId(0);
    params->host_sys_pid = Utils::GetPid();
    params->ai_core_profiling = MSVP_PROF_ON;
    params->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
    params->aiv_profiling = MSVP_PROF_ON;
    params->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
    params->ts_memcpy = MSVP_PROF_ON;
    params_->ts_keypoint = MSVP_PROF_ON;
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_AICORE_LPM)) {
        params->ai_core_lpm = MSVP_PROF_ON;
    }
    if (params_->taskTrace != MSVP_PROF_OFF) {
        params->runtimeTrace = MSVP_PROF_ON;
        if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_STARS_ACSQ)) {
            params->stars_acsq_task = MSVP_PROF_ON;
        } else {
            params->hwts_log = MSVP_PROF_ON;
        }
    }
}

int32_t ProfAclMgr::MsprofAclJsonParamConstruct(NanoJson::Json &acljsonCfg)
{
    if (params_ != nullptr) {
        MSPROF_LOGW("MsprofInitAclJson params exist");
    } else {
        MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return MSPROF_ERROR_MEM_NOT_ENOUGH);
    }
    params_->taskMemory = GetJsonStringParam(acljsonCfg, "task_memory", MSVP_PROF_OFF);
    params_->geApi = GetJsonStringParam(acljsonCfg, "ge_api", MSVP_PROF_OFF);
    params_->acl = GetJsonStringParam(acljsonCfg, "ascendcl", MSVP_PROF_ON);
    params_->runtimeApi = GetJsonStringParam(acljsonCfg, "runtime_api", MSVP_PROF_ON);
    params_->taskTrace = GetJsonStringParam(acljsonCfg, "task_time", MSVP_PROF_ON);
    params_->prof_level = params_->taskTrace;
    if (GetJsonStringParam(acljsonCfg, "task_block", MSVP_PROF_OFF).compare(MSVP_PROF_ALL) == 0) {
        params_->taskBlock = MSVP_PROF_ON;
        params_->taskBlockShink = MSVP_PROF_OFF;
    } else {
        params_->taskBlock = GetJsonStringParam(acljsonCfg, "task_block", MSVP_PROF_OFF);
        params_->taskBlockShink = params_->taskBlock.compare(MSVP_PROF_ON) == 0 ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
    params_->taskTsfw = GetJsonStringParam(acljsonCfg, "task_tsfw", MSVP_PROF_OFF);
    params_->aicpuTrace = GetJsonStringParam(acljsonCfg, "aicpu", MSVP_PROF_OFF);
    params_->hcclTrace = GetJsonStringParam(acljsonCfg, "hccl", MSVP_PROF_OFF);
    params_->msproftx = GetJsonStringParam(acljsonCfg, "msproftx", MSVP_PROF_OFF);
    params_->l2CacheTaskProfiling = GetJsonStringParam(acljsonCfg, "l2", MSVP_PROF_OFF);
    Platform::instance()->L2CacheAdaptor(params_->npuEvents, params_->l2CacheTaskProfiling,
        params_->l2CacheTaskProfilingEvents);
    params_->memServiceflow = GetJsonStringParam(acljsonCfg, "sys_mem_serviceflow", MSVP_PROF_EMPTY_STRING);
    ChangeLevelConf(params_);
    AddCcuInstruction(params_);
    MsprofAclJsonParamAdaper(params_);
    params_->result_dir = acljsonCfg.Contains("output") ?
        MsprofResultDirAdapter(acljsonCfg["output"].GetValue<std::string>()) :
        MsprofResultDirAdapter(MSVP_PROF_EMPTY_STRING);
    if (!Utils::CheckPathWithInvalidChar(params_->result_dir)) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    resultPath_ = params_->result_dir;
    baseDir_ = Utils::CreateProfDir(0);
    int32_t ret = MsprofAclJsonParamConstructTwo(acljsonCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }

    ret = MsprofAclJsonMetricsConstruct(acljsonCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofAclJsonParamConstructTwo(NanoJson::Json &acljsonCfg)
{
    params_->storageLimit = GetJsonStringParam(acljsonCfg, "storage_limit", MSVP_PROF_EMPTY_STRING);
    if (!ParamValidation::instance()->CheckStorageLimit(params_)) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    storageLimit_ = params_->storageLimit;

    params_->instrProfiling = GetJsonStringParam(acljsonCfg, "instr_profiling", MSVP_PROF_OFF);
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING)) {
        MSPROF_LOGW("The argument: instr_profiling_freq is useless on the platform.");
    } else {
        params_->instrProfilingFreq = GetJsonIntParam(acljsonCfg, "instr_profiling_freq",
            DEFAULT_PROFILING_INTERVAL_1000MS);
        if ((params_->instrProfiling.compare(MSVP_PROF_ON) == 0) &&
            (!ParamValidation::instance()->CheckInstrProfilingFreqValid(params_->instrProfilingFreq))) {
            return MSPROF_ERROR_CONFIG_INVALID;
        }
    }

    AddLowPowerConf(acljsonCfg);
    if (ProfParamsAdapter::instance()->HandleJsonConf(acljsonCfg, params_) != PROFILING_SUCCESS) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    std::string errInfo = "";
    std::string opTypeInput = GetJsonStringParam(acljsonCfg, "optype", MSVP_PROF_EMPTY_STRING);
    if (!opTypeInput.empty() &&
        !ParamValidation::instance()->CheckOpTypeIsValid(opTypeInput, params_->opType, errInfo)) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::CheckAclJsonConfigInvalid(const NanoJson::Json &acljsonCfg) const
{
    bool aclJsonSwitch = false;
    for (auto iter = acljsonCfg.Begin(); iter != acljsonCfg.End(); ++iter) {
        auto exist = std::find(ACLJSON_CONFIG_VECTOR.begin(), ACLJSON_CONFIG_VECTOR.end(), iter->first);
        if (exist == ACLJSON_CONFIG_VECTOR.end()) {
            MSPROF_LOGE("Invalid acl json config: %s", iter->first.c_str());
            MSPROF_INPUT_ERROR("EK0005", std::vector<std::string>({"param"}),
                std::vector<std::string>({iter->first.c_str()}));
            return MSPROF_ERROR_CONFIG_INVALID;
        }
        if (iter->first == "hccl") {
            MSPROF_LOGW("[Note] [hccl] This option will be discarded in later versions.");
        }
        if (iter->first == "switch" && iter->second.GetValue<std::string>() == "on") {
            aclJsonSwitch = true;
        }
        if (iter->first == "output" || iter->first == "storage_limit" ||
            iter->first == "instr_profiling_freq" || iter->first == "optype") {
            continue;
        } else {
            if (!ProfParamsAdapter::instance()->CheckJsonConfig(iter->first, iter->second)) {
                return MSPROF_ERROR_CONFIG_INVALID;
            }
        }
    }
    if (!aclJsonSwitch) {
        MSPROF_LOGW("Profiling switch is off");
        return MSPROF_ERROR_ACL_JSON_OFF;
    }
    MSPROF_EVENT("Success to check all AclJsonConfigs.");
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofInitAclJson(VOID_PTR data, uint32_t len)
{
    MSPROF_EVENT("Init profiling for AclJson");
    static uint32_t ACL_CFG_LEN_MAX = 1024 * 1024;  // max input cfg len is 1024 * 1024
    if (data == nullptr || len > ACL_CFG_LEN_MAX) {
        MSPROF_LOGE("Length of acl json config is too large: %u", len);
        std::string value = std::to_string(len);
        std::string reason = "Length of acl json config should be less than " + std::to_string(ACL_CFG_LEN_MAX);
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"length of acl json config", value, reason}));
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = CallbackInitPrecheck();
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_NONE;
    }
    std::string aclCfg(reinterpret_cast<CHAR_PTR>(data), len);
    MSPROF_LOGI("Input aclJsonConfig: %s", aclCfg.c_str());
    if (aclCfg.empty()) {
        MSPROF_LOGE("Empty config of acljson.");
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    NanoJson::Json acljsonCfg;
    try {
        acljsonCfg.Parse(aclCfg);
    } catch (std::runtime_error& e) {
        MSPROF_LOGE("Failed to parse acljson configs. Error reason: %s", e.what());
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    ret = CheckAclJsonConfigInvalid(acljsonCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    ret = MsprofAclJsonParamConstruct(acljsonCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    ProfDataTypeConfigHandle(params_);
    SetModeToCmd();
    return MSPROF_ERROR_NONE;
}

void ProfAclMgr::MsprofInitGeOptionsParamAdaper(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
    const std::string &jobInfo, NanoJson::Json &geoptionCfg)
{
    if (params == nullptr) {
        return;
    }
    params->taskMemory = GetJsonStringParam(geoptionCfg, "task_memory", MSVP_PROF_OFF);
    params->geApi = GetJsonStringParam(geoptionCfg, "ge_api", MSVP_PROF_OFF);
    params->runtimeApi = GetJsonStringParam(geoptionCfg, "runtime_api", MSVP_PROF_OFF);
    params->taskTrace = GetJsonStringParam(geoptionCfg, "task_trace", MSVP_PROF_ON);
    params->taskTrace = GetJsonStringParam(geoptionCfg, "task_time", MSVP_PROF_ON);
    params->prof_level = params->taskTrace;
    if (GetJsonStringParam(geoptionCfg, "task_block", MSVP_PROF_OFF).compare(MSVP_PROF_ALL) == 0) {
        params->taskBlock = MSVP_PROF_ON;
        params->taskBlockShink = MSVP_PROF_OFF;
    } else {
        params->taskBlock = GetJsonStringParam(geoptionCfg, "task_block", MSVP_PROF_OFF);
        params->taskBlockShink = params->taskBlock.compare(MSVP_PROF_ON) == 0 ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
    params->taskTsfw = GetJsonStringParam(geoptionCfg, "task_tsfw", MSVP_PROF_OFF);
    params->aicpuTrace = GetJsonStringParam(geoptionCfg, "aicpu", MSVP_PROF_OFF);
    params->hcclTrace = GetJsonStringParam(geoptionCfg, "hccl", MSVP_PROF_OFF);
    params->ts_fw_training = GetJsonStringParam(geoptionCfg, "training_trace", MSVP_PROF_OFF);
    params->msproftx = GetJsonStringParam(geoptionCfg, "msproftx", MSVP_PROF_OFF);
    params->profiling_mode = analysis::dvvp::message::PROFILING_MODE_DEF;
    params->job_id = Utils::ProfCreateId(0);
    params->host_sys_pid = Utils::GetPid();
    params->jobInfo = jobInfo;
    params->acl = MSVP_PROF_ON;
    params->ts_memcpy = MSVP_PROF_ON;
    params->ts_keypoint = MSVP_PROF_ON;
    resultPath_ = params_->result_dir;
    baseDir_ = Utils::CreateProfDir(0);
    ChangeLevelConf(params);
    AddCcuInstruction(params);
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_AICORE_LPM)) {
        params->ai_core_lpm = MSVP_PROF_ON;
    }
    if (params->taskTrace != MSVP_PROF_OFF) {
        params->runtimeTrace = MSVP_PROF_ON;
        if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_STARS_ACSQ)) {
            params->stars_acsq_task = MSVP_PROF_ON;
        } else {
            params->hwts_log = MSVP_PROF_ON;
        }
    }

    ProfParamsAdapter::instance()->HandleJsonConf(geoptionCfg, params);
}

int32_t ProfAclMgr::MsprofResultPathAdapter(const std::string &dir, std::string &resultPath) const
{
    std::string result;
    if (dir.empty()) {
        std::string ascendWorkPath;
        MSPROF_GET_ENV(MM_ENV_ASCEND_WORK_PATH, ascendWorkPath);
        if (!ascendWorkPath.empty()) {
            MSPROF_LOGI("No result path set, use %s path", ASCEND_WORK_PATH_ENV.c_str());
            std::string path = Utils::RelativePathToAbsolutePath(ascendWorkPath) + MSVP_SLASH + PROFILING_RESULT_PATH;
            if (!Utils::CheckPathWithInvalidChar(path)) {
                return PROFILING_FAILED;
            }
            if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
                MSPROF_LOGW("Unable to create dir: %s", path.c_str());
            }
            result = Utils::CanonicalizePath(path);
        } else {
            MSPROF_LOGE("Result path and %s env is empty", ASCEND_WORK_PATH_ENV.c_str());
            return PROFILING_FAILED;
        }
    } else {
        std::string path = Utils::RelativePathToAbsolutePath(dir);
        if (!Utils::CheckPathWithInvalidChar(path)) {
            return PROFILING_FAILED;
        }
        if (Utils::CreateDir(path) != PROFILING_SUCCESS) {
            MSPROF_LOGW("Unable to create dir: %s", path.c_str());
        }
        result = analysis::dvvp::common::utils::Utils::CanonicalizePath(path);
    }
    if (result.empty() || !analysis::dvvp::common::utils::Utils::IsDirAccessible(result)) {
        MSPROF_LOGE("Result path is empty or not accessible, result path: %s", result.c_str());
        std::string errReason = "Result path is empty or not accessible";
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"output", result, errReason}));
        return PROFILING_FAILED;
    }
    resultPath = result;
    MSPROF_LOGI("MsprofResultPathAdapter canonicalized path: %s", result.c_str());

    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::MsprofGeOptionsParamConstruct(const std::string &jobInfo,
    NanoJson::Json &geoptionCfg)
{
    if (params_ != nullptr) {
        MSPROF_LOGW("MsprofInitGeOptions params exist");
    } else {
        MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return MSPROF_ERROR_MEM_NOT_ENOUGH);
    }
    int32_t ret = PROFILING_SUCCESS;
    ret = MsprofResultPathAdapter(geoptionCfg["output"].GetValue<std::string>(), params_->result_dir);
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    MsprofInitGeOptionsParamAdaper(params_, jobInfo, geoptionCfg);
    MSPROF_LOGI("MsprofInitGeOptions, stars_acsq_task Param:%s, taskBlock:%s, sysLpFreq:%d, hcclTrace:%s",
        params_->stars_acsq_task.c_str(),
        params_->taskBlock.c_str(), params_->sysLpFreq, params_->hcclTrace.c_str());

    params_->l2CacheTaskProfiling = GetJsonStringParam(geoptionCfg, "l2", MSVP_PROF_OFF);
    Platform::instance()->L2CacheAdaptor(params_->npuEvents, params_->l2CacheTaskProfiling,
        params_->l2CacheTaskProfilingEvents);

    params_->storageLimit = GetJsonStringParam(geoptionCfg, "storage_limit", MSVP_PROF_EMPTY_STRING);
    if (!ParamValidation::instance()->CheckStorageLimit(params_)) {
        MSPROF_LOGW("storage_limit para is invalid");
    }
    storageLimit_ = params_->storageLimit;
    params_->memServiceflow = GetJsonStringParam(geoptionCfg, "sys_mem_serviceflow", MSVP_PROF_EMPTY_STRING);

    params_->instrProfiling = GetJsonStringParam(geoptionCfg, "instr_profiling", MSVP_PROF_OFF);
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING)) {
        MSPROF_LOGW("The argument: instr_profiling_freq is useless on the platform.");
    } else {
        params_->instrProfilingFreq = GetJsonIntParam(geoptionCfg, "instr_profiling_freq",
            DEFAULT_PROFILING_INTERVAL_1000MS);
        if ((params_->instrProfiling.compare(MSVP_PROF_ON) == 0) &&
            (!ParamValidation::instance()->CheckInstrProfilingFreqValid(params_->instrProfilingFreq))) {
            return MSPROF_ERROR_CONFIG_INVALID;
        }
    }

    AddLowPowerConf(geoptionCfg);
    std::string errInfo = "";
    std::string opTypeInput = GetJsonStringParam(geoptionCfg, "optype", MSVP_PROF_EMPTY_STRING);
    if (!opTypeInput.empty() &&
        !ParamValidation::instance()->CheckOpTypeIsValid(opTypeInput, params_->opType, errInfo)) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    ret = MsprofGeOptionMetricsConstruct(geoptionCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofGeOptionMetricsConstruct(NanoJson::Json &geoptionCfg)
{
    std::string aiCoreMetrics = GetJsonMetricsParam(geoptionCfg, "aic_metrics", PIPE_UTILIZATION,
        MSVP_PROF_EMPTY_STRING);
    std::string aiVectMetrics = aiCoreMetrics;
    ConfigManager::instance()->GetVersionSpecificMetrics(aiCoreMetrics);
    if (!aiCoreMetrics.empty()) {
        int32_t ret = Platform::instance()->GetAicoreEvents(aiCoreMetrics, params_->ai_core_profiling_events);
        ret = Platform::instance()->GetAicoreEvents(aiVectMetrics, params_->aiv_profiling_events);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("The aic_metrics[%s] of input geconfig is invalid", aiCoreMetrics.c_str());
            std::string reason = "Aicore metrics is not supported on current platform";
            MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
                std::vector<std::string>({aiCoreMetrics, "aic_metrics", reason}));
            return MSPROF_ERROR_CONFIG_INVALID;
        }
        params_->ai_core_profiling = MSVP_PROF_ON;
        params_->ai_core_metrics = aiCoreMetrics;
        params_->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
        params_->aiv_profiling = MSVP_PROF_ON;
        params_->aiv_metrics = aiVectMetrics;
        params_->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
    }
    MSPROF_LOGI("MsprofInitGeOptions, aicoreMetricsType:%s, aicoreEvents:%s, aivectorMetricsType:%s, aivectorEvents:%s",
        params_->ai_core_metrics.c_str(), params_->ai_core_profiling_events.c_str(), params_->aiv_metrics.c_str(),
        params_->aiv_profiling_events.c_str());
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::CheckGeOptionConfigInvalid(const NanoJson::Json &geoptionCfg) const
{
    for (auto iter = geoptionCfg.Begin(); iter != geoptionCfg.End(); ++iter) {
        auto exist = std::find(GEOPTION_CONFIG_VECTOR.begin(), GEOPTION_CONFIG_VECTOR.end(), iter->first);
        if (exist == GEOPTION_CONFIG_VECTOR.end()) {
            MSPROF_LOGE("Invalid geoption config: %s", iter->first.c_str());
            return MSPROF_ERROR_CONFIG_INVALID;
        }
        if (iter->first == "hccl") {
            MSPROF_LOGW("[Note] [hccl] This option will be discarded in later versions.");
        }
        if (iter->first == "task_trace") {
            MSPROF_LOGW("[Note] [task_trace] This option will be discarded in later versions.Use task_time instead");
        }
        if (iter->first == "output" || iter->first == "storage_limit" ||
            iter->first == "fp_point" || iter->first == "bp_point" ||
            iter->first == "instr_profiling_freq" || iter->first == "optype") {
            continue;
        } else {
            if (!ProfParamsAdapter::instance()->CheckJsonConfig(iter->first, iter->second)) {
                return MSPROF_ERROR_CONFIG_INVALID;
            }
        }
    }
    MSPROF_EVENT("Success to check all GeOptionConfigs.");
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofInitGeOptions(VOID_PTR data, uint32_t len)
{
    MSPROF_EVENT("Init profiling for GeOptions");
    uint32_t structLen = sizeof(struct MsprofGeOptions);
    if (data == nullptr || len != structLen) {
        MSPROF_LOGE("MsprofInitGeOptions input arguments is invalid, len:%u bytes, structLen:%u bytes", len, structLen);
        MSPROF_INNER_ERROR("EK9999", "Params created by ge can not be analyzed by "
            "prof shared library in runtime.");
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = CallbackInitPrecheck();
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_NONE;
    }
    MsprofGeOptions *optionCfg = (struct MsprofGeOptions *)data;
    std::string jobInfo = MsprofCheckAndGetChar(optionCfg->jobId, MSPROF_OPTIONS_DEF_LEN_MAX);
    std::string options = MsprofCheckAndGetChar(optionCfg->options, MSPROF_OPTIONS_DEF_LEN_MAX);
    MSPROF_LOGI("MsprofInitGeOptions, jobInfo:%s, options:%s", jobInfo.c_str(), options.c_str());
    if (options.empty()) {
        MSPROF_LOGE("Empty config of geoption.");
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    NanoJson::Json geoptionCfg;
    try {
        geoptionCfg.Parse(options);
    } catch (std::runtime_error& e) {
        MSPROF_LOGE("Failed to parse geoption configs. Error reason: %s", e.what());
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    ret = CheckGeOptionConfigInvalid(geoptionCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    ret = MsprofGeOptionsParamConstruct(jobInfo, geoptionCfg);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    ProfDataTypeConfigHandle(params_);
    SetModeToCmd();
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofInitAclEnv(const std::string &envValue)
{
    MSPROF_EVENT("Init profiling for CommandLine");
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = CallbackInitPrecheck();
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_NONE;
    }
    if (params_ != nullptr) {
        MSPROF_LOGW("MsprofInitAclEnv params exist");
    } else {
        MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return MSPROF_ERROR_MEM_NOT_ENOUGH);
    }
    if (!params_->FromString(envValue)) {
        MSPROF_LOGE("ProfileParams Parse Failed %s", envValue.c_str());
        MSPROF_INNER_ERROR("EK9999", "Params created by msprof in oam-tools can not be analyzed by "
            "prof shared library in runtime.");
        return MSPROF_ERROR;
    }
    params_->host_sys_pid = Utils::GetPid();
    params_->result_dir = params_->result_dir.empty() ?
        MsprofResultDirAdapter(params_->result_dir) : params_->result_dir;
    if (!Utils::CheckPathWithInvalidChar(params_->result_dir)) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    if (params_->prof_level == MSVP_PROF_OFF && params_->taskTime == MSVP_PROF_ON &&
        params_->taskTrace == MSVP_PROF_ON) {
        params_->prof_level = MSVP_PROF_ON; // taskTime, taskTrace默认值的赋值
    }
    if (params_->prof_level != MSVP_PROF_OFF) {
        params_->runtimeTrace = MSVP_PROF_ON;
    }
    ChangeLevelConf(params_);
    AddCcuInstruction(params_);
    resultPath_ = params_->result_dir;
    baseDir_ = Utils::CreateProfDir(0);
    if (!ParamValidation::instance()->CheckStorageLimit(params_)) {
        MSPROF_LOGE("storage_limit para is invalid");
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    storageLimit_ = params_->storageLimit;
    ProfDataTypeConfigHandle(params_);
    SetModeToCmd();
    MSPROF_LOGI("MsprofInitAclEnv, mode:%d, dataTypeConfig:0x%llx, baseDir:%s",
                mode_, dataTypeConfig_, Utils::BaseName(baseDir_).c_str());
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofHelperParamConstruct(const std::string &msprofPath, const std::string &paramsJson)
{
    if (params_ != nullptr) {
        MSPROF_LOGW("MsprofHelper params exist");
    } else {
        MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return MSPROF_ERROR_MEM_NOT_ENOUGH);
    }
    params_->FromString(paramsJson);
    if (MsprofResultPathAdapter(msprofPath, params_->result_dir) != PROFILING_SUCCESS) {
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    resultPath_ = params_->result_dir;
    baseDir_ = Utils::CreateProfDir(0);
    if (!ParamValidation::instance()->CheckStorageLimit(params_)) {
        MSPROF_LOGE("storage_limit para is invalid");
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    storageLimit_ = params_->storageLimit;
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofInitHelper(VOID_PTR data, uint32_t len)
{
    MSPROF_EVENT("Init profiling for Helper");
    uint32_t structLen = sizeof(struct MsprofCommandHandleParams);
    if (data == nullptr || len != structLen) {
        MSPROF_LOGE("MsprofInitHelper input arguments is invalid, len:%u bytes, structLen:%u bytes", len, structLen);
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = CallbackInitPrecheck();
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_NONE;
    }
    MsprofCommandHandleParams *commandHandleParams = static_cast<struct MsprofCommandHandleParams *>(data);
    std::string msprofPath = MsprofCheckAndGetChar(commandHandleParams->path, PATH_LEN_MAX);
    std::string msprofParams = MsprofCheckAndGetChar(commandHandleParams->profData, PARAM_LEN_MAX);
    MSPROF_LOGI("MsprofInitHelper, path:%s, params:%s", msprofPath.c_str(), msprofParams.c_str());
    ret = MsprofHelperParamConstruct(msprofPath, msprofParams);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    ProfDataTypeConfigHandle(params_);
    SetModeToCmd();
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofPureCpuParamConstruct(std::string &msprofPath, const std::string &paramsJson)
{
    if (params_ != nullptr) {
        MSPROF_LOGW("MsprofHelper params exist");
    } else {
        MSVP_MAKE_SHARED0(params_, analysis::dvvp::message::ProfileParams, return MSPROF_ERROR_MEM_NOT_ENOUGH);
    }
    params_->FromString(paramsJson);
    if (!EnableRpcHelperMode(msprofPath)) {
        if (Platform::instance()->PlatformIsHelperHostSide() || msprofPath.compare(HELPER_HOST_CPU_MODE) == 0) {
            msprofPath = params_->result_dir.empty() ?
                MsprofResultDirAdapter(params_->result_dir) : params_->result_dir;
            size_t pos = params_->result_dir.rfind("PROF_");
            if (pos != std::string::npos) {
                msprofPath = msprofPath.substr(0, pos);
            }
        }
        if (MsprofResultPathAdapter(msprofPath, params_->result_dir) != PROFILING_SUCCESS) {
            return MSPROF_ERROR_CONFIG_INVALID;
        }
    }
    resultPath_ = params_->result_dir;
    baseDir_ = Utils::CreateProfDir(0);
    if (!ParamValidation::instance()->CheckStorageLimit(params_)) {
        MSPROF_LOGE("storage_limit para is invalid");
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    storageLimit_ = params_->storageLimit;
    params_->host_sys_pid = Utils::GetPid();
    params_->pureCpu = MSVP_PROF_ON; // the pureCpu mode is on
    params_->ai_core_profiling = MSVP_PROF_OFF;
    params_->aiv_profiling = MSVP_PROF_OFF;
    params_->ai_core_lpm = MSVP_PROF_OFF;
    params_->stars_acsq_task = MSVP_PROF_OFF;
    params_->hwts_log = MSVP_PROF_OFF;
    params_->l2CacheTaskProfiling = MSVP_PROF_OFF;
    params_->instrProfiling = MSVP_PROF_OFF;
    params_->ts_fw_training = MSVP_PROF_OFF;
    params_->ts_keypoint = MSVP_PROF_OFF;
    params_->aicpuTrace = MSVP_PROF_OFF;
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofInitPureCpu(VOID_PTR data, uint32_t len)
{
    MSPROF_EVENT("Init profiling for Pure CPU");
    uint32_t structLen = sizeof(struct MsprofCommandHandleParams);
    if (data == nullptr || len != structLen) {
        MSPROF_LOGE("MsprofInitPureCpu input arguments is invalid, len:%u bytes, structLen:%u bytes", len, structLen);
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = CallbackInitPrecheck();
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_NONE;
    }
    MsprofCommandHandleParams *commandHandleParams = static_cast<struct MsprofCommandHandleParams *>(data);
    std::string msprofPath = MsprofCheckAndGetChar(commandHandleParams->path, PATH_LEN_MAX);
    std::string msprofParams = MsprofCheckAndGetChar(commandHandleParams->profData, PARAM_LEN_MAX);
    MSPROF_LOGI("MsprofInitPureCpu, path:%s, params:%s", msprofPath.c_str(), msprofParams.c_str());
    ret = MsprofPureCpuParamConstruct(msprofPath, msprofParams);
    if (ret != MSPROF_ERROR_NONE) {
        return ret;
    }
    ProfDataTypeConfigHandle(params_);
    SetModeToCmd();
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::DoHostHandle()
{
    params_->hostProfiling = true;
    int32_t ret = PROFILING_SUCCESS;
    if (params_->IsMsprofTx()) {
        MsprofTxInit();
        MstxDataHandler::instance()->Start(params_->mstxDomainInclude, params_->mstxDomainExclude);
    }
    ret = MsprofSetDeviceImpl(DEFAULT_HOST_ID);
    if (params_->host_osrt_profiling.compare("on") == 0) {
        OsalSleep(1000); // sleep 1000ms, wait for perf start
    }
    params_->hostProfiling = false;
    return ret;
}

int32_t ProfAclMgr::MsprofTxApiHandle(uint64_t dataTypeConfig)
{
    MSPROF_EVENT("Init profiling for msproftx");
    const int32_t ret = MsprofTxSwitchPrecheck();
    if (ret != PROFILING_SUCCESS) {
        return MSPROF_ERROR_NONE;
    }
    if ((dataTypeConfig & PROF_MSPROFTX_MASK) != 0) {
        params_->msproftx = "on";
    }
    return DoHostHandle();
}

void ProfAclMgr::MsprofTxHandle(void)
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (!IsCmdMode()) {
        MSPROF_LOGI("MsprofTxHandle, not on cmd mode");
        return;
    }

    params_->hostProfiling = true;
    if (params_->IsMsprofTx()) {
        MsprofTxInit();
        MstxDataHandler::instance()->Start(params_->mstxDomainInclude, params_->mstxDomainExclude);
        int32_t ret = InitUploader(std::to_string(DEFAULT_HOST_ID));
        FUNRET_CHECK_EXPR_LOGW(ret != ACL_SUCCESS, "Host uploader for msproftx init unsuccessfully.");
    }
    params_->hostProfiling = false;
}

void ProfAclMgr::MsprofHostHandle(void)
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (!IsCmdMode()) {
        MSPROF_LOGI("MsprofHostHandle, not on cmd mode");
        return;
    }

    auto ret = DoHostHandle();
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("[MsprofHostHandle] host profiling handle failed, ret is %d", ret);
    }
}

int32_t ProfAclMgr::MsprofDeviceHandle(uint32_t devId)
{
    std::lock_guard<std::mutex> lk(mtx_);
    return MsprofSetDeviceImpl(devId);
}

int32_t ProfAclMgr::MsprofResetDeviceHandle(uint32_t devId)
{
    std::lock_guard<std::mutex> lk(mtx_);
    auto devTask = devTasks_.find(devId);
    if (devTask == devTasks_.end()) {
        MSPROF_LOGI("Device %u task not find", devId);
        return MSPROF_ERROR_NONE;
    }

    if (devTask->second.params->isCancel) {
        return MSPROF_ERROR_NONE;
    }
    devTask->second.params->isCancel = true;
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(devId), uploader);
    if (uploader != nullptr) {
        uploader->SetTransportStopped();
        MSPROF_LOGI("Device %u set uploader stopped", devId);
    }

    if (ProfManager::instance()->IdeCloudProfileProcess(devTask->second.params) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop profiling on device %u", devId);
        return MSPROF_ERROR;
    }
    return MSPROF_ERROR_NONE;
}

void ProfAclMgr::DoFinalizeHandle(void)
{
    std::vector<uint32_t> devIds;
    Msprofiler::Api::ProfAclMgr::instance()->GetRunningDevices(devIds);
    int32_t geRet;
    for (const uint32_t devId : devIds) {
        uint64_t dataTypeConfig = 0;
        int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->ProfAclGetDataTypeConfig(devId, dataTypeConfig);
        if (ret != ACL_SUCCESS) {
            continue;
        }
        uint32_t devIdList[1] = {devId};
        ProfAclMgr::instance()->AddModelLoadConf(dataTypeConfig);
        ProfAclMgr::instance()->AddRuntimeTraceConf(dataTypeConfig);
        const uint64_t profSwitchHi = ProfAclMgr::instance()->GetProfSwitchHi(dataTypeConfig);
        geRet = CommandHandleProfStop(devIdList, 1, dataTypeConfig, profSwitchHi);
        if (geRet != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to CommandHandleProfStop on device:%u", devId);
            MSPROF_INNER_ERROR("EK9999", "Failed to callback stop on device %u.", devId);
        }
    }

    (void)ProfStopStatsCallback();
    geRet = CommandHandleProfFinalize();
    if (geRet != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to CommandHandleProfFinalize");
        MSPROF_INNER_ERROR("EK9999", "Failed to callback finalize.");
    }

    Msprof::Engine::FlushAllModule();
}

int32_t ProfAclMgr::MsprofFinalizeHandle(void)
{
    if (ProfAclMgr::instance()->IsModeOff() || ProfAclMgr::instance()->IsSubscribeMode()) {
        MSPROF_LOGW("Finalize profiling not common or aclapi task.");
        return MSPROF_ERROR_NONE;
    }
    DoFinalizeHandle();
    MSPROF_EVENT("Finalize profiling");
    // SIGINT graceful exit: device may still have in-flight PMU/task frames in
    // transit. Drain them before marking transports stopped, otherwise task data
    // can outrun PMU association data and trigger
    // "contextPmu has no matched log" in the analysis stage.
    if (IsSigintShutdownInProgress()) {
        constexpr uint32_t SIGINT_DRAIN_WAIT_MS = 1000;
        OsalSleep(SIGINT_DRAIN_WAIT_MS);
        Msprof::Engine::FlushAllModule();
    }
    UploaderMgr::instance()->SetAllUploaderTransportStopped();
    std::lock_guard<std::mutex> lk(mtx_);
    for (auto iter = devTasks_.begin(); iter != devTasks_.end(); iter++) {
        if (iter->second.params->isCancel) {
            continue;
        }
        iter->second.params->isCancel = true;
        if (ProfManager::instance()->IdeCloudProfileProcess(iter->second.params) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to finalize profiling on device %u", iter->first);
        }
        MSPROF_LOGI("save hash data in MsprofFinalizeHandle");
        // save hash data after IdeCloudProfileProcess
        HashData::instance()->SaveHashData(iter->first);
    }
    MsprofTxUnInit();
    UploaderMgr::instance()->DelAllUploader();
    devTasks_.clear();
    SetModeToOff();
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::MsprofSetDeviceImpl(uint32_t devId)
{
    if (devId != DEFAULT_HOST_ID && params_->pureCpu == MSVP_PROF_ON) {
        MSPROF_EVENT("The PURE CPU mode is being executed.");
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("MsprofSetDeviceImpl, devId:%u", devId);
    const auto iterDev = devTasks_.find(devId);
    if (iterDev != devTasks_.end() && !iterDev->second.params->isCancel) {
        if (devId == DEFAULT_HOST_ID) {
            MSPROF_LOGI("MsprofSetDeviceImpl, the host process is already in use.");
            return PROFILING_SUCCESS;
        }
        MSPROF_LOGI("MsprofSetDeviceImpl, device:%u is running", devId);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("MsprofSetDeviceImpl, Process ProfStart of device:%u", devId);
    int32_t ret = StartDeviceTask(devId, params_);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("MsprofSetDeviceImpl, StartDeviceTask failed, devId:%u, mode:%d", devId, mode_);
        return PROFILING_FAILED;
    }
    // dump start info file in no acl prof warmup scene
    if (!IsProfWarmup()) {
        DumpStartInfoFile(devId);
    }
    devTasks_[devId].dataTypeConfig = dataTypeConfig_;
    WaitDeviceResponse(devId);
    return ret;
}

void ProfAclMgr::CloseSubscribeFd(const uint32_t devId)
{
    std::lock_guard<std::mutex> lk(mtxSubscribe_);
    std::set<int32_t *> closedFds;
    std::set<int32_t> usedFds;
    for (auto iter = subscribeInfos_.begin(); iter != subscribeInfos_.end();) {
        if (iter->second.devId == devId) {
            // fd on same device, should close
            closedFds.insert(iter->second.fd);
            iter = subscribeInfos_.erase(iter);
        } else {
            // fd on different device, should not close
            usedFds.insert(*(iter->second.fd));
            iter++;
        }
    }
    for (int32_t *fd : closedFds) {
        if (usedFds.find(*fd) == usedFds.end()) {
            MSPROF_EVENT("Close subscribe fd %d", *fd);
            if (OsalClose(*fd) != EOK) {
                MSPROF_LOGE("Failed to close subscribe fd %d", *fd);
                MSPROF_INNER_ERROR("EK9999", "Failed to close subscribe fd %d", *fd);
                Utils::PrintSysErrorMsg();
            }
            *fd = -1;
        }
    }
}

void ProfAclMgr::CloseSubscribeFd(const uint32_t devId, SHARED_PTR_ALIA<ProfSubscribeKey> subscribeKey)
{
    if (devId == DEFAULT_HOST_ID) {
        return;
    }
    std::lock_guard<std::mutex> lk(mtxSubscribe_);
    int32_t *fd = nullptr;
    auto iter = subscribeInfos_.find(subscribeKey->key);
    if ((iter != subscribeInfos_.end()) && (iter->second.devId == devId)) {
        fd = iter->second.fd;
        subscribeInfos_.erase(iter);
    } else {
        MSPROF_LOGE("%s has not been subscribed.", subscribeKey->keyInfo.c_str());
        MSPROF_INNER_ERROR("EK9999", "%s has not been subscribed.", subscribeKey->keyInfo.c_str());
        return;
    }
    for (iter = subscribeInfos_.begin(); iter != subscribeInfos_.end(); iter++) {
        if (*fd == *iter->second.fd) {
            MSPROF_LOGI("Fd %d is still used by the %s.Can't close it now.", *fd, subscribeKey->keyInfo.c_str());
            return;
        }
    }
    MSPROF_EVENT("Close subscribe fd %d", *fd);
    if (OsalClose(*fd) != EOK) {
        MSPROF_LOGE("Failed to close subscribe fd: %d, %s, devId: %u", *fd, subscribeKey->keyInfo.c_str(), devId);
        MSPROF_INNER_ERROR("EK9999", "Failed to close subscribe fd: %d, %s, devId: %u",
            *fd, subscribeKey->keyInfo.c_str(), devId);
        Utils::PrintSysErrorMsg();
    }
    *fd = -1;
}

void ProfAclMgr::ProfAclSetModelSubscribeType(uint32_t type)
{
    subscribeType_ = type;
    MSPROF_LOGI("Set model subscribe type: %u", type);
}

std::string ProfAclMgr::GetJsonMetricsParam(NanoJson::Json &jsonCfg, std::string jsonOpt, std::string emptyVal,
    std::string defaultVal) const
{
    if (jsonCfg.Contains(jsonOpt)) {
        std::string metrics = jsonCfg[jsonOpt].GetValue<std::string>();
        if (!metrics.empty()) {
            return metrics;
        } else {
            return emptyVal;
        }
    }
    return defaultVal;
}

std::string ProfAclMgr::GetJsonStringParam(NanoJson::Json &jsonCfg, std::string jsonOpt, std::string defaultVal) const
{
    if (jsonCfg.Contains(jsonOpt)) {
        return jsonCfg[jsonOpt].GetValue<std::string>();
    }
    return defaultVal;
}

int32_t ProfAclMgr::GetJsonIntParam(NanoJson::Json &jsonCfg, std::string jsonOpt, int32_t defaultVal) const
{
    if (jsonCfg.Contains(jsonOpt)) {
        return jsonCfg[jsonOpt].GetValue<int32_t>();
    }
    return defaultVal;
}

int32_t ProfAclMgr::MsprofSetConfig(aclprofConfigType cfgType, const std::string &config)
{
    // Check whether the acl api is supported.
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = ProfParamsAdapter::instance()->CheckApiConfigSupport(cfgType);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to check the API config settings, config not support in this platform.");
        return PROFILING_FAILED;
    }

    ret = ProfParamsAdapter::instance()->CheckApiConfigIsValid(params_, cfgType, config);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to check the API config settings, config is invalid.");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/**
 * @name  StartUploaderDumper
 * @brief start uploader dumper thread to pop data from repot buffer
 */
int32_t ProfAclMgr::StartUploaderDumper() const
{
    int32_t ret = ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StartReporters();
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::ProfStartCommon(const uint32_t *devIdList, uint32_t devNums)
{
    MSPROF_LOGI("Start profiling for common task.");
    // check device notified
    std::vector<uint32_t> notifyList = {};
    if (!GetDevicesNotify(devIdList, devNums, notifyList)) {
        return MSPROF_ERROR_UNINITIALIZE;
    }
    // check device online
    std::string info;
    for (uint32_t devId : notifyList) {
        if (!(ProfManager::instance()->CheckIfDevicesOnline(std::to_string(devId), info))) {
            MSPROF_LOGE("DevId:%u is not online, error info:%s", devId, info.c_str());
            return MSPROF_ERROR;
        }
    }

    // start traditional reporters
    if (Msprof::Engine::MsprofReporter::reporters_.empty()) {
        Msprof::Engine::MsprofReporter::InitReporters();
    }
    // start report thread
    if (StartUploaderDumper() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start uploader dumper.");
        return MSPROF_ERROR;
    }
    // start host tasks
    MsprofHostHandle();

    // start device tasks
    for (uint32_t devId : notifyList) {
        if (devId == DEFAULT_HOST_ID) {
            continue;
        }
        const bool isApiStatsMode = IsAclApiStatsMode();
        if (isApiStatsMode) {
            MSPROF_LOGD("Start profiling by api stats mode, skip device task: %u.", devId);
        } else {
            if (MsprofDeviceHandle(devId) != PROFILING_SUCCESS) {
                continue;
            }
        }
        if (ProfStartCallback(devId) != PROFILING_SUCCESS) {
            return MSPROF_ERROR;
        }
        if (isApiStatsMode) {
            ProfStartStatsCallback(devId);
        }
    }

    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::ProfStartCallback(uint32_t devId)
{
    // callback init handle
    int32_t ret = CommandHandleProfInit();
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to execute CommandHandleProfInit.");
        MSPROF_INNER_ERROR("EK9999", "Failed to callback init.");
        return PROFILING_FAILED;
    }
    // callback start handle
    uint32_t startDevIdList[1] = {devId};
    uint64_t profSwitch = GetCmdModeDataTypeConfig();
    const uint64_t profSwitchHi = GetProfSwitchHi(profSwitch);
    AddModelLoadConf(profSwitch);
    AddOpDetailConf(profSwitch);
    AddRuntimeTraceConf(profSwitch);
    ret = CommandHandleProfStart(startDevIdList, 1, profSwitch, profSwitchHi);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to execute CommandHandleProfStart.");
        MSPROF_INNER_ERROR("EK9999", "Failed to callback start on device %u.", devId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::StopCommonCallback(const std::vector<uint32_t> &devIds, uint64_t profSwitch)
{
    const uint64_t profSwitchHi = GetProfSwitchHi(profSwitch);
    AddModelLoadConf(profSwitch);
    AddRuntimeTraceConf(profSwitch);
    AddOpDetailConf(profSwitch);
    uint32_t devIdList[PROF_MAX_DEV_NUM] = {0};
    std::copy(devIds.begin(), devIds.end(), devIdList);
    MSPROF_LOGI("[ProfStopCommon] get running device task success, devTask size: %zu", devIds.size());
    int32_t ret = CommandHandleProfStop(devIdList, devIds.size(), profSwitch, profSwitchHi);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to execute CommandHandleProfStop.");
        return ret;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::StopCommonDeviceTasks(const std::vector<uint32_t> &devIds)
{
    std::lock_guard<std::mutex> lk(mtx_);
    for (size_t i = 0; i < devIds.size(); i++) {
        uint32_t devId = devIds[i];
        auto iter = devTasks_.find(devId);
        if (iter != devTasks_.end()) {
            MSPROF_LOGI("Processing ProfAclStop of device %u", devId);
            HashData::instance()->SaveNewHashData(true);
            iter->second.params->isCancel = true;
            if (ProfManager::instance()->IdeCloudProfileProcess(iter->second.params) != PROFILING_SUCCESS) {
                MSPROF_LOGE("Failed to stop profiling on device %u", devId);
                return ACL_ERROR_PROFILING_FAILURE;
            }
            MSPROF_LOGI("save hash data in ProfStopCommon");
            // save hash data after IdeCloudProfileProcess
            HashData::instance()->SaveHashData(devId);
            if (devId == DEFAULT_HOST_ID && iter->second.count > 1) {
                iter->second.count--;
                continue;
            }
            devTasks_.erase(iter);
        } else {
            MSPROF_LOGW("Device %u has not been started", devId);
        }
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::ProfStopCommon(const MsprofConfig *config)
{
    if (IsModeOff()) {
        MSPROF_LOGI("Profiling is already stopped, stop common task useless.");
        return ACL_SUCCESS;
    }
    MSPROF_LOGI("Stop profiling for common task.");
    std::vector<uint32_t> devIds;
    GetRunningDevices(devIds);
    int32_t ret = StopCommonCallback(devIds, config->profSwitch);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    (void)ProfStopStatsCallback();
    MSPROF_EVENT("Received ProfAclStop request from acl");
    UploaderMgr::instance()->SetAllUploaderTransportStopped();
    return StopCommonDeviceTasks(devIds);
}

int32_t ProfAclMgr::ProfStopCallback(uint32_t devId, uint64_t dataTypeConfig) const
{
    // callback start handle
    uint32_t stopDevIdList[1] = {devId};
    uint64_t profSwitch = dataTypeConfig;
    const uint64_t profSwitchHi = GetProfSwitchHi(profSwitch);
    AddModelLoadConf(profSwitch);
    AddOpDetailConf(profSwitch);
    AddRuntimeTraceConf(profSwitch);
    const int32_t ret = CommandHandleProfStop(stopDevIdList, 1, profSwitch, profSwitchHi);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to CommandHandleProfStop on device:%u", devId);
        MSPROF_INNER_ERROR("EK9999", "Failed to callback stop on device %u.", devId);
        return ret;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAclMgr::ProfStartPureCpu(const MsprofConfig *config)
{
    if (!IsModeOff()) {
        MSPROF_LOGI("Profiling is already inited, start pure cpu useless.");
        return MSPROF_ERROR_NONE;
    }
    MSPROF_EVENT("Start profiling for pure cpu.");
    MsprofCommandHandleParams pureCpuData;
    errno_t retv = strcpy_s(pureCpuData.path, PATH_LEN_MAX + 1, config->dumpPath);
    FUNRET_CHECK_EXPR_ACTION(retv != EOK, return MSPROF_ERROR,
        "Failed to copy dump path %s to pure cpu data, ret: %d.", config->dumpPath, retv);
    retv = strcpy_s(pureCpuData.profData, PARAM_LEN_MAX + 1, config->sampleConfig);
    FUNRET_CHECK_EXPR_ACTION(retv != EOK, return MSPROF_ERROR,
        "Failed to copy sample config %s to pure cpu data, ret: %d.", config->sampleConfig, retv);
    // init profiling for pure cpu
    int32_t ret = MsprofInitPureCpu(static_cast<void *>(&pureCpuData), sizeof(MsprofCommandHandleParams));
    FUNRET_CHECK_EXPR_ACTION(ret != MSPROF_ERROR_NONE, return MSPROF_ERROR,
        "Failed to init profiling for pure cpu.");
    // start report thread
    ret = StartUploaderDumper();
    FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return MSPROF_ERROR,
        "Failed to start uploader dumper.");
    // start host tasks
    MsprofTxHandle();
    MsprofHostHandle();
    // callback init handle
    ret = CommandHandleProfInit();
    FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return MSPROF_ERROR,
        "Failed to execute CommandHandleProfInit.");
    // callback start handle
    uint64_t profSwitch = GetCmdModeDataTypeConfig();
    const uint64_t profSwitchHi = GetProfSwitchHi(profSwitch);
    AddModelLoadConf(profSwitch);
    ret = CommandHandleProfStart(nullptr, 0, profSwitch, profSwitchHi);
    FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return MSPROF_ERROR,
        "Failed to execute CommandHandleProfStart.");
    return MSPROF_ERROR_NONE;
}
 
int32_t ProfAclMgr::ProfStopPureCpu()
{
    if (IsModeOff() || !IsCmdMode()) {
        MSPROF_LOGI("Profiling is already finalize or not on cmd mode, stop pure cpu useless.");
        return MSPROF_ERROR_NONE;
    }
    MSPROF_EVENT("Stop profiling for pure cpu.");
    uint64_t profSwitch = GetCmdModeDataTypeConfig();
    const uint64_t profSwitchHi = GetProfSwitchHi(profSwitch);
    AddModelLoadConf(profSwitch);
    int32_t ret = CommandHandleProfStop(nullptr, 0, profSwitch, profSwitchHi);
    FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return MSPROF_ERROR,
        "Failed to execute CommandHandleProfStop.");
    ret = CommandHandleProfFinalize();
    FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return MSPROF_ERROR,
        "Failed to execute CommandHandleProfFinalize.");
 
    UploaderMgr::instance()->SetAllUploaderTransportStopped();
    std::lock_guard<std::mutex> lk(mtx_);
    auto iter = devTasks_.find(DEFAULT_HOST_ID);
    if (iter != devTasks_.end() && !(iter->second.params->isCancel)) {
        iter->second.params->isCancel = true;
        ret = ProfManager::instance()->IdeCloudProfileProcess(iter->second.params);
        MSPROF_LOGI("save hash data in ProfStopPureCpu");
        HashData::instance()->SaveHashData(iter->first);
        FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return MSPROF_ERROR,
            "Failed to stop pure cpu task.");
    }
 
    MsprofTxUnInit();
    UploaderMgr::instance()->DelAllUploader();
    devTasks_.clear();
    SetModeToOff();
    return MSPROF_ERROR_NONE;
}

int32_t ProfAclMgr::PrepareStartAclApi(const MsprofConfig *config)
{
    // check if 51 helper scene
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("Acl api not support in helper");
        MSPROF_INPUT_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofStart"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    // check if acl api mode
    int32_t ret = ProfStartPrecheck();
    if (ret != ACL_SUCCESS) {
        if (ret == ACL_ERROR_PROF_NOT_RUN) {
            MSPROF_INPUT_ERROR("EK0002", std::vector<std::string>({"intf1", "intf2"}),
                std::vector<std::string>({"aclprofInit", "aclprofStart"}));
        }
        return ret;
    }
    // Check whether the parameter is supported.
    ret = ProfParamsAdapter::instance()->CheckDataTypeSupport(config->profSwitch);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to check the API parameter settings.");
        return ACL_ERROR_PROFILING_FAILURE;
    }
    // mark device id list by aclprofCreateConfig
    SetDeviceNotifyAclApi(config->devIdList, config->devNums);
    // check devices
    std::lock_guard<std::mutex> lk(mtx_);
    ret = CheckDeviceTask(config);
    if (ret != ACL_SUCCESS) {
        return ret;
    }
    baseDir_ = Utils::CreateProfDir(startIndex_);
    startIndex_++;
    params_->profiling_mode = analysis::dvvp::message::PROFILING_MODE_DEF;
    // prepare all acl api params
    ret = PrepareStartAclApiParam(config);
    if (ret != ACL_SUCCESS) {
        return ret;
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::PrepareStartAclApiParam(const MsprofConfig *config)
{
    MSPROF_EVENT("Received ProfAclStart request from acl");
    MSPROF_LOGI("Received dataTypeConfig 0x%llx by Profiling AscendCL API", config->profSwitch);
    SHARED_PTR_ALIA<ProfApiStartReq> feature = nullptr;
    MSVP_MAKE_SHARED0(feature, ProfApiStartReq, return ACL_ERROR_PROFILING_FAILURE);
    // Transfer task-based dataTypeConfig to ProfApiStartReq
    TaskBasedCfgTrfToReq(config->profSwitch, static_cast<ProfAicoreMetrics>(config->metrics), feature);
    // Transfer sample-based dataTypeConfig to ProfApiStartReq
    SampleBasedCfgTrfToReq(config->profSwitch, static_cast<ProfAicoreMetrics>(config->metrics), feature);
    // Transfer dataTypeConfig to inner params
    ProfParamsAdapter::instance()->StartCfgTrfToInnerParam(config->profSwitch, params_);
    // Transfer ProfApiStartReq to inner params
    if (ProfParamsAdapter::instance()->StartReqTrfToInnerParam(feature, params_) != PROFILING_SUCCESS) {
        return ACL_ERROR_PROFILING_FAILURE;
    }
    params_->ts_keypoint = MSVP_PROF_ON;
    params_->host_sys_pid = Utils::GetPid();
    AddProfLevelConf(params_, config->profSwitch);
    AddCcuInstruction(params_);
    dataTypeConfig_ = config->profSwitch;
    (void)MsprofTxApiHandle(dataTypeConfig_);
    params_->profMode = MSVP_PROF_ACLAPI_MODE;
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::PrepareStopAclApi(const MsprofConfig *config)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("Acl api not support in helper");
        MSPROF_INPUT_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofStop"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    int32_t ret = ProfStopPrecheck();
    if (ret != ACL_SUCCESS) {
        if (ret == ACL_ERROR_PROF_NOT_RUN) {
            MSPROF_INPUT_ERROR("EK0002", std::vector<std::string>({"intf1", "intf2"}),
                std::vector<std::string>({"aclprofStart", "aclprofStop"}));
        }
        return ret;
    }

    ret = CheckConfigConsistency(config, "stop");
    if (ret != ACL_SUCCESS) {
        return ret;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    params_->profMode = "";
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::CheckConfigConsistency(const MsprofConfig *config, const std::string action)
{
    uint64_t dataTypeConfig = 0;
    int32_t ret;
    for (uint32_t i = 0; i < config->devNums; i++) {
        ret = ProfAclGetDataTypeConfig(config->devIdList[i], dataTypeConfig);
        if (ret != ACL_SUCCESS) {
            continue;
        }
        if (dataTypeConfig != config->profSwitch) {
            MSPROF_LOGE("DataTypeConfig %s: 0x%" PRIx64 " different from start: 0x%" PRIx64,
                action.c_str(), config->profSwitch, dataTypeConfig);
            const int32_t bufLength = 64;
            char profSwitchbuf[bufLength] = {0};
            char dataTypeConfigbuf[bufLength] = {0};
            ret = snprintf_s(profSwitchbuf, bufLength, bufLength - 1, "0x%" PRIx64, config->profSwitch);
            if (ret == OSAL_EN_ERROR) {
                MSPROF_LOGE("Unable to format config->profSwitch.");
            }
            ret = snprintf_s(dataTypeConfigbuf, bufLength, bufLength - 1, "0x%" PRIx64, dataTypeConfig);
            if (ret == OSAL_EN_ERROR) {
                MSPROF_LOGE("Unable to format dataTypeConfigbuf.");
            }
            std::string errorReason = std::string("DataTypeConfig ") + action.c_str() + ":" + profSwitchbuf + 
                                      " different from start:" + dataTypeConfigbuf;
            MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
                std::vector<std::string>({profSwitchbuf, "dataTypeConfig", errorReason}));
            return ACL_ERROR_INVALID_PROFILING_CONFIG;
        }
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::PrepareStartAclSubscribe(const MsprofConfig *config)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("Acl api not support in helper");
        MSPROF_INPUT_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofModelSubscribe"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    int32_t ret = ProfSubscribePrecheck();
    FUNRET_CHECK_RET_VALUE(ret != ACL_SUCCESS, return ret);

    ret = CheckSubscribeConfig(config);
    FUNRET_CHECK_RET_VALUE(ret != ACL_SUCCESS, return ret);

    ProfAclSetModelSubscribeType(config->type);
    ret = HashData::instance()->Init();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("HashData init failed in aclprofModelSubscribe");
        return ACL_ERROR_PROFILING_FAILURE;
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::ProfStartAclSubscribe(const MsprofConfig *config)
{
    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = GenerateSubscribeKey(config);
    FUNRET_CHECK_EXPR_ACTION(subscribePtr == nullptr, return ACL_ERROR_PROFILING_FAILURE,
        "Failed to generate subscribe key.");

    MSPROF_EVENT("Received ProfAclModelSubscribe request from acl: %s, fd: %u",
        subscribePtr->keyInfo.c_str(), *reinterpret_cast<uint32_t*>(config->fd));
    std::lock_guard<std::mutex> lk(mtx_);
    auto iter = subscribeInfos_.find(subscribePtr->key);
    if (iter != subscribeInfos_.end() && iter->second.subscribed) {
        MSPROF_LOGE("%s has been subscribed", subscribePtr->keyInfo.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to pass subscribe check, key %s has been subscribed",
            subscribePtr->keyInfo.c_str());
        return ACL_ERROR_PROF_REPEAT_SUBSCRIBE;
    }

    std::vector<uint32_t> devIdList = {config->devIdList[0], DEFAULT_HOST_ID};
    for (const auto id : devIdList) {
        MSPROF_LOGI("Start device subscribe task model:%u, %s", subscribePtr->modelId, subscribePtr->keyInfo.c_str());
        const auto iterDev = devTasks_.find(id);
        if (iterDev != devTasks_.end()) {
            // device already started, check cfg and add fd to subscribe list
            MSPROF_LOGI("Update subscription config %s", subscribePtr->keyInfo.c_str());
            int32_t retval = UpdateSubscribeInfo(subscribePtr->key, id, config);
            if (id == DEFAULT_HOST_ID) {
                return retval;
            }
            continue;
        }
        // start subscribe device
        if (StartDeviceSubscribeTask(subscribePtr->key, id, config) != ACL_SUCCESS) {
            MSPROF_LOGE("StartDeviceSubscribeTask failed, %s", subscribePtr->keyInfo.c_str());
            return ACL_ERROR_PROFILING_FAILURE;
        }
    }
    // aoe model will not start thread report
    ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().SetSyncReporter();
    // Start upload dumper thread
    if (ProfAclMgr::instance()->StartUploaderDumper() != PROFILING_SUCCESS) {
        return ACL_ERROR_PROFILING_FAILURE;
    }
    uint64_t profSwitch = ProfAclGetDataTypeConfig(config);
    AddSubscribeConf(profSwitch);
    if (CommandHandleProfStart(config->devIdList, 1, profSwitch, 0) != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to execute CommandHandleProfStart.");
        return ACL_ERROR_PROFILING_FAILURE;
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::PrepareStopAclSubscribe(const MsprofConfig *config) const
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_INPUT_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofModelUnSubscribe"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    const int32_t ret = ProfSubscribePrecheck();
    FUNRET_CHECK_RET_VALUE(ret != ACL_SUCCESS, return ret);

    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = GenerateSubscribeKey(config);
    FUNRET_CHECK_EXPR_ACTION(subscribePtr == nullptr, return ACL_ERROR_PROFILING_FAILURE,
        "Failed to generate subscribe key.");

    if (!isReady_) {
        MSPROF_LOGE("ProfAclMgr has not been inited.");
        return ACL_ERROR_INVALID_MODEL_ID;
    }
    uint32_t devId = 0;
    if (ProfAclMgr::instance()->GetDeviceSubscribeCount(subscribePtr, devId) == 0) {
        Msprof::Engine::FlushAllModule();
        ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().FlushAllReporter();
    }
    if (!ProfAclMgr::instance()->IsModelSubscribed(subscribePtr->key)) {
        MSPROF_LOGE("%s is not subscribed when unsubcribed", subscribePtr->keyInfo.c_str());
        if (subscribePtr->modelId != std::numeric_limits<uint32_t>::max()) {
            MSPROF_INPUT_ERROR("EK0002", std::vector<std::string>({"intf1", "intf2"}),
                std::vector<std::string>({"aclprofModelSubscribe", "aclprofModelUnSubscribe"}));
            return ACL_ERROR_INVALID_MODEL_ID;
        } else {
            return ACL_ERROR_PROFILING_FAILURE;
        }
    }
    return ACL_SUCCESS;
}

int32_t ProfAclMgr::ProfStopAclSubscribe(const MsprofConfig *config)
{
    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = GenerateSubscribeKey(config);
    FUNRET_CHECK_EXPR_ACTION(subscribePtr == nullptr, return ACL_ERROR_PROFILING_FAILURE,
        "Failed to generate subscribe key.");
    auto iter = subscribeInfos_.find(subscribePtr->key);
    MSPROF_EVENT("Received ProfAclModelUnSubscribe request from acl: %s", subscribePtr->keyInfo.c_str());
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = ACL_SUCCESS;
    std::vector<uint32_t> collectIdList = {config->devIdList[0], DEFAULT_HOST_ID};
    for (auto id : collectIdList) {
        auto iterDev = devTasks_.find(id);
        if (iterDev != devTasks_.end()) {
            if (id != DEFAULT_HOST_ID) {
                iter->second.subscribed = false;
            }
            iterDev->second.count--;
            MSPROF_LOGI("%s unsubscribed, devId :%u count: %u",
                subscribePtr->keyInfo.c_str(), id, iterDev->second.count);
            if (iterDev->second.count == 0) {
                uint32_t devIdList[1] = {id};
                uint64_t dataTypeConfig = iterDev->second.dataTypeConfig;
                AddSubscribeConf(dataTypeConfig);
                ret = CommandHandleProfStop(devIdList, 1, dataTypeConfig, 0);
                FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret, "Failed to execute CommandHandleProfStop.");
                ret = ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StopReporters();
                FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return ACL_ERROR_PROFILING_FAILURE,
                    "Failed to stop reporters.");
                iterDev->second.params->isCancel = true;
                ret = ProfManager::instance()->IdeCloudProfileProcess(iterDev->second.params);
                FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return ACL_ERROR_PROFILING_FAILURE,
                    "Failed to stop profiling on device %u", iterDev->first);
                CloseSubscribeFdIfHostId(id);
                devTasks_.erase(iterDev);
            } else {
#if (defined(linux) || defined(__linux__))
                FlushAllData(std::to_string(id));
                CloseSubscribeFd(iterDev->first, subscribePtr);
#endif
            }
        }
    }
    if (devTasks_.empty()) {
        UploaderMgr::instance()->DelAllUploader();
        mode_ = WORK_MODE_OFF;
    }
    return ACL_SUCCESS;
}

SHARED_PTR_ALIA<ProfSubscribeKey> ProfAclMgr::GenerateSubscribeKey(const MsprofConfig *config) const
{
    SHARED_PTR_ALIA<ProfSubscribeKey> subscribePtr = nullptr;
    if (config->type == static_cast<uint32_t>(Msprof::Engine::Intf::OP_TYPE)) {
        int32_t threadId = OsalGetTid();
        FUNRET_CHECK_EXPR_ACTION(threadId == OSAL_EN_ERROR, return nullptr,
            "Failed to get tid in subscribe process.");
        MSVP_MAKE_SHARED2(subscribePtr, ProfSubscribeKey, config->devIdList[0], static_cast<uint32_t>(OsalGetTid()),
            return nullptr);
    } else {
        MSVP_MAKE_SHARED1(subscribePtr, ProfSubscribeKey, config->modelId, return nullptr);
    }

    return subscribePtr;
}

void ProfAclMgr::ProfStartStatsCallback(uint32_t deviceId)
{
    std::lock_guard<std::mutex> lk(mtx_);
    statsDevSet_.emplace(deviceId);
}

int32_t ProfAclMgr::ProfStopStatsCallback()
{
    std::set<uint32_t> statsDevSet;
    uint64_t dataTypeConfig = 0;
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (statsDevSet_.empty()) {
            return PROFILING_SUCCESS;
        }
        statsDevSet = statsDevSet_;
        dataTypeConfig = dataTypeConfig_;
    }

    int32_t finalRet = PROFILING_SUCCESS;
    std::set<uint32_t> stoppedDevSet;
    for (auto devId : statsDevSet) {
        const int32_t ret = ProfStopCallback(devId, dataTypeConfig);
        if (ret == PROFILING_SUCCESS) {
            stoppedDevSet.emplace(devId);
            continue;
        }
        finalRet = ret;
    }

    if (!stoppedDevSet.empty()) {
        std::lock_guard<std::mutex> lk(mtx_);
        for (auto devId : stoppedDevSet) {
            statsDevSet_.erase(devId);
        }
    }
    return finalRet;
}

void ProfAclMgr::SetDeviceNotifyAclApi(const uint32_t *deviceId, uint32_t devNums)
{
    std::lock_guard<std::mutex> lk(mtx_);
    for (uint32_t i = 0; i < devNums; ++i) {
        aclApiDevSet_.emplace(deviceId[i]);
    }
}

void ProfAclMgr::SetDeviceNotify(uint32_t deviceId, bool isOpenDevice)
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (isOpenDevice) {
        devSet_.emplace(deviceId);
    } else {
        devSet_.erase(deviceId);
    }
}

int32_t ProfAclMgr::GetAllActiveDevices(std::vector<uint32_t> &activeList)
{
    std::lock_guard<std::mutex> lk(mtx_);
    for (auto id : devSet_) {
        if (id == DEFAULT_HOST_ID) {
            continue;
        }
        activeList.emplace_back(id);
        MSPROF_LOGI("Get active device %u.", id);
    }

    if (!activeList.empty()) {
        return ACL_SUCCESS;
    }
    return ACL_ERROR_PROFILING_FAILURE;
}

bool ProfAclMgr::GetDevicesNotify(const uint32_t *deviceId, uint32_t devNums, std::vector<uint32_t> &notifyList)
{
    std::lock_guard<std::mutex> lk(mtx_);
    for (uint32_t i = 0; i < devNums; i++) {
        if (deviceId[i] == DEFAULT_HOST_ID) {
            continue;
        }
        // profiling need to start after set device
        if (devSet_.find(deviceId[i]) == devSet_.end()) {
            MSPROF_LOGW("Unable to get device %u notified.", deviceId[i]);
            continue;
        }
        // profiling device list need to be included in aclprofCreateConfig devIdList on acl api mode
        if (IsAclApiReady() &&
            aclApiDevSet_.find(deviceId[i]) == aclApiDevSet_.end() &&
            !ProfParamsAdapter::instance()->CheckAclApiSetDeviceEnable()) {
                MSPROF_LOGW("Unable to get device %u in api config list.", deviceId[i]);
                continue;
        }
        notifyList.emplace_back(deviceId[i]);
        MSPROF_LOGI("Get device %u notified.", deviceId[i]);
    }

    if (!notifyList.empty()) {
        return true;
    }
    return false;
}

int32_t ProfAclMgr::StartAdprofDumper() const
{
    int32_t ret = ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StartAdprofReporters();
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void ProfAclMgr::DumpStartInfoFile(uint32_t device)
{
    // don't dump start info file in subscribe mode
    if (ProfAclMgr::instance()->IsSubscribeMode()) {
        return;
    }

    MSPROF_LOGI("Dump start info file for device %u", device);
    CtrlFilesDumper::instance()->DumpCollectionTimeInfo(device, (device == DEFAULT_HOST_ID), true);
}

void ProfAclMgr::SetProfWarmup()
{
    isProfWarmup_.store(true);
    UploaderMgr::instance()->SetUploadDataIfStart(false);
}

void ProfAclMgr::ResetProfWarmup()
{
    isProfWarmup_.store(false);
}

bool ProfAclMgr::IsProfWarmup() const
{
    return isProfWarmup_.load();
}

void ProfAclMgr::ChangeProfWarmupToStart(const std::vector<uint32_t> &devIds) const
{
    for (auto &devId : devIds) {
        ProfAclMgr::instance()->DumpStartInfoFile(devId);
    }
    UploaderMgr::instance()->SetUploadDataIfStart(true);
}

std::string ProfAclMgr::GetOutputPath() const
{
    if (baseDir_.empty()) {
        return "";
    }
    return GenerateProfMainName();
}

void ProfAclMgr::TaskBasedCfgTrfToReq(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
    SHARED_PTR_ALIA<ProfApiStartReq> feature) const
{
    MSPROF_LOGI("Begin to transfer task-based msprof StartCfg to api StartReq");
    feature->featureName = PROF_FEATURE_TASK;
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        if ((dataTypeConfig & PROF_SCHEDULE_TIMELINE_MASK) != 0 ||
            (dataTypeConfig & PROF_TASK_TIME_MASK) != 0) {
            feature->tsTimeline = "on";
        }
    } else
#endif // BUILD_OPEN_PROJECT
    if ((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) {
        feature->hwtsLog = "on";
    }
    if ((dataTypeConfig & PROF_SCHEDULE_TRACE_MASK) != 0) {
        feature->tsTaskTrack = "on";
    }
    if ((dataTypeConfig & PROF_TRAINING_TRACE_MASK) != 0) {
        feature->tsFwTraining = "on";
    }
    SHARED_PTR_ALIA<ProfApiSysConf> conf = nullptr;
    MSVP_MAKE_SHARED0(conf, ProfApiSysConf, return);
    std::string metrics;
    AicoreMetricsEnumToName(aicMetrics, metrics);
    if ((dataTypeConfig & PROF_AICORE_METRICS_MASK) != 0 && !metrics.empty()) {
        conf->aicoreMetrics = metrics;
        conf->aivMetrics = metrics;
    }
    if ((dataTypeConfig & PROF_L2CACHE_MASK) != 0) {
        conf->l2 = MSVP_PROF_ON;
    }
    if (!conf->aicoreMetrics.empty() || !conf->aivMetrics.empty() || !conf->l2.empty()) {
        feature->taskTraceConf = ProfParamsAdapter::instance()->EncodeSysConfJson(conf);
    }
}

void ProfAclMgr::AicoreMetricsEnumToName(ProfAicoreMetrics aicMetrics, std::string &name) const
{
    switch (aicMetrics) {
        case PROF_AICORE_ARITHMETIC_UTILIZATION:
            name = ARITHMETIC_UTILIZATION;
            break;
        case PROF_AICORE_PIPE_UTILIZATION:
            name = PIPE_UTILIZATION;
            break;
        case PROF_AICORE_PIPE_EXECUTE_UTILIZATION:
            name = PIPE_EXECUTION_UTILIZATION;
            break;
        case PROF_AICORE_MEMORY_BANDWIDTH:
            name = MEMORY_BANDWIDTH;
            break;
        case PROF_AICORE_L0B_AND_WIDTH:
            name = L0B_AND_WIDTH;
            break;
        case PROF_AICORE_RESOURCE_CONFLICT_RATIO:
            name = RESOURCE_CONFLICT_RATIO;
            break;
        case PROF_AICORE_MEMORY_UB:
            name = MEMORY_UB;
            break;
        default:
            AicoreMetricsEnumToNameTwo(aicMetrics, name);
    }
}

void ProfAclMgr::AicoreMetricsEnumToNameTwo(ProfAicoreMetrics aicMetrics, std::string &name) const
{
    std::string value = "";
    std::string reason = "The aicore metrics enum is not supported on the current platform";
    switch (aicMetrics) {
        case PROF_AICORE_L2_CACHE:
            if (
#ifndef BUILD_OPEN_PROJECT
                ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE ||
                ConfigManager::instance()->GetPlatformType() == PlatformType::MDC_TYPE ||
#endif // BUILD_OPEN_PROJECT
                ConfigManager::instance()->GetPlatformType() == PlatformType::CLOUD_TYPE ||
                ConfigManager::instance()->GetPlatformType() == PlatformType::DC_TYPE) {
                value = L2_CACHE_ENUM;
                break;
            }
            name = L2_CACHE;
            break;
        case PROF_AICORE_MEMORY_ACCESS:
            if (ConfigManager::instance()->GetPlatformType() != PlatformType::CHIP_V4_1_0) {
                value = MEMORY_ACCESS_ENUM;
                break;
            }
            name = MEMORY_ACCESS;
            break;
        case PROF_AICORE_NONE:
            break;
        default:
            value = std::to_string(static_cast<uint32_t>(aicMetrics));
    }

    if (!value.empty()) {
        MSPROF_LOGE("Invalid aicore metrics enum: %s", value.c_str());
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({value, "aicoreMetrics", reason}));
    }
}

int32_t ProfAclMgr::MsprofAclJsonMetricsConstruct(NanoJson::Json &acljsonCfg)
{
    std::string aiCoreMetrics;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_V3_TYPE
#ifndef BUILD_OPEN_PROJECT
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_MINI_V3
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_TINY_V1
        || ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_MDC_LITE
#endif // BUILD_OPEN_PROJECT
        ) {
        aiCoreMetrics = GetJsonMetricsParam(acljsonCfg, "aic_metrics", PIPE_EXECUTION_UTILIZATION,
            PIPE_EXECUTION_UTILIZATION);
    } else {
        aiCoreMetrics = GetJsonMetricsParam(acljsonCfg, "aic_metrics", PIPE_UTILIZATION, PIPE_UTILIZATION);
    }
    std::string aiVectMetrics = aiCoreMetrics;
    ConfigManager::instance()->GetVersionSpecificMetrics(aiCoreMetrics);
    auto ret = Platform::instance()->GetAicoreEvents(aiCoreMetrics, params_->ai_core_profiling_events);
    ret = Platform::instance()->GetAicoreEvents(aiVectMetrics, params_->aiv_profiling_events);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("The parameter of aic_metrics in aclJsonConfig is invalid");
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({
                "aic_metrics", aiCoreMetrics, "The parameter of aic_metrics in aclJsonConfig is invalid"
            }));
        return MSPROF_ERROR_CONFIG_INVALID;
    }
    params_->ai_core_metrics = aiCoreMetrics;
    params_->aiv_metrics = aiVectMetrics;
    MSPROF_LOGI("MsprofInitAclJson, aicoreMetricsType:%s, aicoreEvents:%s, hcclTrace: %s",
        params_->ai_core_metrics.c_str(), params_->ai_core_profiling_events.c_str(), params_->hcclTrace.c_str());
    return MSPROF_ERROR_NONE;
}

}   // namespace Api
}   // namespace Msprofiler
