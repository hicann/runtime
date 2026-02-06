/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprofiler_acl_api.h"
#include "prof_acl_core.h"
#include "acl/acl_base.h"
#include "acl/acl_prof.h"
#include "op_desc_parser.h"
#include "prof_acl_mgr.h"
#include "prof_api_common.h"
#include "prof_params_adapter.h"
#include "config/config.h"
#include "utils/utils.h"
#include "transport/hash_data.h"
#include "transport/uploader.h"
#include "transport/parser_transport.h"
#include "msprofiler_acl_api.h"
#include "msprofiler_impl.h"
#include "platform/platform.h"
#include "ai_drv_dev_api.h"
#include "command_handle.h"
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "prof_reporter_mgr.h"
#include "config/feature_manager.h"

namespace Msprofiler {
namespace AclApi {
using namespace Analysis::Dvvp::Analyze;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Msprofiler::Api;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace Dvvp::Collect::Report;
using namespace Analysis::Dvvp::Host::Adapter;

using ProfSignalHandler = void (*)(int);

static ProfSignalHandler oldSigHandler = nullptr;

std::mutex g_profMutex;
std::map<uint32_t, std::string> g_subscribeTypeMap = {
    {ACL_API_TYPE, "acl"},
    {ACL_GRPH_API_TYPE, "aclgraph"},
    {OP_TYPE, "op"},
};

aclError ProfInit(ProfType type, CONST_CHAR_PTR profilerResultPath, size_t length)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofInit"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);

    if (profilerResultPath == nullptr || strlen(profilerResultPath) != length) {
        MSPROF_LOGE("profilerResultPath is nullptr or its length does not equals given length");
        std::string errorReason = "profilerResultPath is nullptr or its length does not equals given length";
        std::string valueStr = (profilerResultPath == nullptr) ? "nullptr" : std::string(profilerResultPath);
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({valueStr, "profilerResultPath", errorReason}));
        return ACL_ERROR_INVALID_PARAM;
    }
    constexpr size_t aclProfPathMaxLen = 4096;   // path max length: 4096
    if (length > aclProfPathMaxLen || length == 0) {
        MSPROF_LOGE("length of profilerResultPath is illegal, the value is %zu, it should be in (0, %zu)",
                    length, aclProfPathMaxLen);
        std::string errorReason = "profilerResultPath length should be in [1, " + std::to_string(aclProfPathMaxLen) + ")";
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({std::to_string(length), "profilerResultPath length", errorReason}));
        return ACL_ERROR_INVALID_PARAM;
    }

    int32_t ret = ProfAclMgr::instance()->ProfInitPrecheck();
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    if (ProfAclMgr::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init acl manager");
        return ACL_ERROR_PROFILING_FAILURE;
    }
    MSPROF_LOGI("Initialize profiling by using ProfInit");
    std::string path(profilerResultPath, length);
    ret = ProfAclMgr::instance()->ProfAclInit(path);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("AclProfiling init fail, profiling result = %d", ret);
        return ret;
    }

    if (Msprof::Engine::MsprofReporter::reporters_.empty()) {
        MSPROF_LOGI("MsprofReporter InitReporters");
        Msprof::Engine::MsprofReporter::InitReporters();
    }

    // Start upload dumper thread
    if (ProfAclMgr::instance()->StartUploaderDumper() != PROFILING_SUCCESS) {
        return ACL_ERROR_PROFILING_FAILURE;
    };

    MSPROF_LOGI("Acl has been allocated config of profiling initialize, successfully execute %s%s",
                g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

aclError ProfFinalize(ProfType type)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofFinalize"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);
    int32_t ret = ProfAclMgr::instance()->ProfFinalizePrecheck();
    if (ret != ACL_SUCCESS) {
        if (ret == ACL_ERROR_PROF_NOT_RUN) {
            MSPROF_INPUT_ERROR("EK0002", std::vector<std::string>({"intf1", "intf2"}),
                std::vector<std::string>({"aclprofFinalize", "aclprofInit"}));
        }
        return ret;
    }

    MSPROF_LOGI("Allocate config of profiling finalize");
    ret = Analysis::Dvvp::ProfilerCommon::CommandHandleProfFinalize();
    RETURN_IF_NOT_SUCCESS(ret);

    Msprof::Engine::FlushAllModule();

    MSPROF_LOGI("Finalize profiling by using ProfFinalize");
    ret = ProfAclMgr::instance()->ProfAclFinalize();
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to finalize profiling, profiling result = %d", ret);
        MSPROF_INNER_ERROR("EK9999", "Failed to finalize profiling, profiling result = %d", ret);
        return ret;
    }

    MSPROF_LOGI("Successfully execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

static aclError preCheckProfConfig(PROF_CONFIG_CONST_PTR profilerConfig)
{
    if (profilerConfig == nullptr) {
        MSPROF_LOGE("Param profilerConfig is nullptr");
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({"nullptr", "profilerConfig", "profilerConfig can not be nullptr"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    if (profilerConfig->dataTypeConfig == 0) {
        MSPROF_LOGE("Param profilerConfig dataTypeConfig is zero");
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({"0", "dataTypeConfig", "dataTypeConfig can not be zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    // check switch
    if ((profilerConfig->dataTypeConfig & (~PROF_SWITCH_SUPPORT)) != 0) {
        MSPROF_LOGE("dataTypeConfig:0x%lx, supported switch is:0x%lx",
                    profilerConfig->dataTypeConfig, PROF_SWITCH_SUPPORT);
        std::string dataTypeConfigStr = "0x" + Utils::Int2HexStr<uint64_t>(profilerConfig->dataTypeConfig);
        std::string supportConfigStr = "0x" + Utils::Int2HexStr<uint64_t>(PROF_SWITCH_SUPPORT);
        std::string errorReason = "dataTypeConfig is not support, supported switch is:" + supportConfigStr;
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({dataTypeConfigStr, "dataTypeConfig", errorReason}));
        return ACL_ERROR_PROF_MODULES_UNSUPPORTED;
    }
    if (profilerConfig->devNums > MSVP_MAX_DEV_NUM + 1) {
        MSPROF_LOGE("Param prolilerConfig is invalid");
        std::string devNumsStr = std::to_string(profilerConfig->devNums);
        std::string errorReason = "The device number should be in range [1, " + std::to_string(MSVP_MAX_DEV_NUM) + "]";
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({devNumsStr, "deviceNums", errorReason}));
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_SUCCESS;
}

aclError ProfWarmup(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig)
{
    aclError aclRet = preCheckProfConfig(profilerConfig);
    if (aclRet != ACL_SUCCESS) {
        MSPROF_LOGE("PreCheck ProfConfig Failed.");
        MSPROF_INNER_ERROR("EK9999", "PreCheck ProfConfig Failed.");
        return aclRet;
    }
    struct MsprofConfig cfg;
    cfg.profSwitch = profilerConfig->dataTypeConfig;
    cfg.devNums = profilerConfig->devNums;
    cfg.metrics = static_cast<uint32_t>(profilerConfig->aicoreMetrics);
    for (uint32_t i = 0; i < cfg.devNums; ++i) {
        cfg.devIdList[i] = profilerConfig->devIdList[i];
    }

    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);
    int32_t ret = ProfAclMgr::instance()->ProfStartPrecheck();
    if (ret != ACL_SUCCESS) {
        if (ret == ACL_ERROR_PROF_NOT_RUN) {
            MSPROF_INPUT_ERROR("EK0002", std::vector<std::string>({"intf1", "intf2"}),
                std::vector<std::string>({"aclprofWarmup", "aclprofInit"}));
        }
        return ret;
    }
    // ProfWarmup will not work after ProfStart called
    if (ProfAclMgr::instance()->IsAclApiReady()) {
        MSPROF_LOGE("aclprofWarmup cannot be called after aclprofStart.");
        MSPROF_INNER_ERROR("EK9999", "aclprofWarmup cannot be called after aclprofStart.");
        return ACL_ERROR_PROF_API_CONFLICT;
    }
    ProfAclMgr::instance()->SetProfWarmup();
    ret = Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), static_cast<const void *>(&cfg),
        sizeof(cfg));
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Start profiling failed, ret: %d", ret);
        MSPROF_INNER_ERROR("EK9999", "Start profiling failed, ret: %d", ret);
        return ret;
    }
    MSPROF_LOGI("Acl has been allocated warmup profiling config, successfully execute %s%s",
                g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

static void newSigHandler(int signum) {
    MSPROF_LOGI("Msprof receive ctrl C signal. signum:%d, exiting now.", signum);
    MSPROF_LOGI("Msprof SignalHandler start");
    PROF_CONFIG_CONST_PTR config = ProfSetDefaultConfig();
    aclError aclRet = ProfStop(ACL_API_TYPE, config);
    if (aclRet == ACL_SUCCESS) {
        MSPROF_LOGI("Msprof SignalHandler ok");
    } else {
        MSPROF_LOGE("Msprof SignalHandler failed");
    }
    
    if(oldSigHandler && oldSigHandler != SIG_IGN) {
        MSPROF_LOGI("old SignalHandler start");
        oldSigHandler(signum);
        MSPROF_LOGI("old SignalHandler end");
    }
}

static void RegisterSiganlHandler(void ) {
    oldSigHandler = signal(SIGINT, newSigHandler);
    MSPROF_LOGI("RegisterSiganlHandler done");
    if(oldSigHandler && oldSigHandler != SIG_IGN) {
        MSPROF_LOGI("Store oldSigHandler");
    }
}

aclError ProfStart(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig)
{
    RegisterSiganlHandler();
    PROF_CONFIG_CONST_PTR config = profilerConfig;
    if (profilerConfig == nullptr) {
        config = ProfSetDefaultConfig();
    }
    aclError aclRet = preCheckProfConfig(config);
    if (aclRet != ACL_SUCCESS) {
        MSPROF_LOGE("PreCheck ProfConfig Failed.");
        MSPROF_INNER_ERROR("EK9999", "PreCheck ProfConfig Failed.");
        return aclRet;
    }
    std::vector<uint32_t> devIds;
    struct MsprofConfig cfg;
    cfg.profSwitch = config->dataTypeConfig;
    cfg.devNums = config->devNums;
    cfg.metrics = static_cast<uint32_t>(config->aicoreMetrics);
    for (uint32_t i = 0; i < cfg.devNums; ++i) {
        cfg.devIdList[i] = config->devIdList[i];
        devIds.push_back(config->devIdList[i]);
    }

    int32_t ret = ProfAclMgr::instance()->CheckConfigConsistency(static_cast<const MsprofConfig *>(&cfg), "start");
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);

    if (ProfAclMgr::instance()->IsProfWarmup()) {
        ProfAclMgr::instance()->ChangeProfWarmupToStart(devIds);
        ProfAclMgr::instance()->ResetProfWarmup();
    } else {
        int32_t ret = Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
            static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), static_cast<const void *>(&cfg),
            sizeof(cfg));
        if (ret != ACL_SUCCESS) {
            MSPROF_LOGE("Start profiling failed, ret: %d", ret);
            MSPROF_INNER_ERROR("EK9999", "Start profiling failed, ret: %d", ret);
            return ret;
        }
    }

    MSPROF_LOGI("Acl has been allocated start profiling config, successfully execute %s%s",
                g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

aclError ProfStop(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig)
{
    PROF_CONFIG_CONST_PTR config = profilerConfig;
    if (profilerConfig == nullptr) {
        config = ProfGetCurrentConfig();
        if (config->devNums == 0) {
            return ACL_SUCCESS;
        }
    }

    aclError aclRet = preCheckProfConfig(config);
    if (aclRet != ACL_SUCCESS) {
        MSPROF_LOGE("PreCheck ProfConfig Failed.");
        MSPROF_INNER_ERROR("EK9999", "PreCheck ProfConfig Failed.");
        return aclRet;
    }

    struct MsprofConfig cfg;
    cfg.profSwitch = config->dataTypeConfig;
    cfg.devNums = config->devNums;
    cfg.metrics = static_cast<uint32_t>(config->aicoreMetrics);
    for (uint32_t i = 0; i < cfg.devNums; ++i) {
        cfg.devIdList[i] = config->devIdList[i];
    }

    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);

    const int32_t ret = Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_API), static_cast<const void *>(&cfg),
        sizeof(cfg));
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Stop profiling failed, ret: %d", ret);
        MSPROF_INNER_ERROR("EK9999", "Stop profiling failed, ret: %d", ret);
        return ret;
    }
    FUNRET_CHECK_EXPR_ACTION(ProfReporterMgr::GetInstance().StopReporters() != PROFILING_SUCCESS,
        return ACL_ERROR_PROFILING_FAILURE, "Failed to stop reporters.");

    MSPROF_LOGI("Acl has been allocated stop config, successfully execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

PROF_CONFIG_CONST_PTR ProfSetDefaultConfig() 
{
    PROF_CONFIG_PTR profilerConfig = new (std::nothrow) ProfConfig();
    std::vector<uint32_t> activeList = {};
    ProfAicoreMetrics aicoreMetrics = Platform::instance()->GetDefaultAicoreMetrics();
    uint64_t dataTypeConfig = Platform::instance()->GetDefaultDataTypeConfig();
    if (ProfAclMgr::instance()->GetAllActiveDevices(activeList) != ACL_SUCCESS) {
        MSPROF_LOGE("[aclprofStart]Fail to get active device.");
        return nullptr;
    }
    profilerConfig->devNums = activeList.size();
    for (uint32_t i = 0; i < profilerConfig->devNums; ++i) {
        profilerConfig->devIdList[i] = activeList[i];
    }
    profilerConfig->aicoreMetrics = aicoreMetrics;
    profilerConfig->dataTypeConfig = dataTypeConfig;
    return profilerConfig;
}

PROF_CONFIG_CONST_PTR ProfGetCurrentConfig() 
{
    PROF_CONFIG_PTR profilerConfig = new (std::nothrow) ProfConfig();
    std::vector<uint32_t> devIds;
    Msprofiler::Api::ProfAclMgr::instance()->GetRunningDevices(devIds);
    if (devIds.size() == 0) {
        profilerConfig->devNums = 0;
        MSPROF_LOGW("[aclprofStop]No running devices left.");
        return profilerConfig;
    }
    uint64_t dataTypeConfig = 0;
    ProfAicoreMetrics aicoreMetrics = Platform::instance()->GetDefaultAicoreMetrics();
    int32_t ret = ProfAclMgr::instance()->ProfAclGetDataTypeConfig(devIds[0], dataTypeConfig);
    if (ret != ACL_SUCCESS) {
        return nullptr;
    }
    profilerConfig->devNums = devIds.size();
    for (uint32_t i = 0; i < profilerConfig->devNums; ++i) {
        profilerConfig->devIdList[i] = devIds[i];
    }
    profilerConfig->aicoreMetrics = aicoreMetrics;
    profilerConfig->dataTypeConfig = dataTypeConfig;
    return profilerConfig;
}

aclError ProfSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
{
    if (ProfAclMgr::instance()->ProfSetConfigPrecheck() != ACL_SUCCESS) {
        MSPROF_LOGE("[aclprofSetConfig]Fail to set profiling config as api has not initialized yet.");
        return ACL_ERROR_UNINITIALIZE;
    }
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofSetConfig"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    std::string configStr(config, configLength);
    int32_t ret = ProfAclMgr::instance()->MsprofSetConfig(configType, configStr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[aclprofSetConfig]Fail to set profiling config.");
        return ACL_ERROR_INVALID_PROFILING_CONFIG;
    }
    return ACL_SUCCESS;
}

SHARED_PTR_ALIA<ITransport> CreateParserTransport()
{
#ifndef PROF_LITE
    // create transport2 and uploader2
    SHARED_PTR_ALIA<PipeTransport> pipeTransport = nullptr;
    MSVP_MAKE_SHARED0(pipeTransport, PipeTransport, return nullptr);
    SHARED_PTR_ALIA<Uploader> pipeUploader = nullptr;
    MSVP_MAKE_SHARED1(pipeUploader, Uploader, pipeTransport, return nullptr);
    const size_t subscribeUploaderCapacity = 200000;  // subscribe need more capacity (200000 op data)
    int32_t ret = pipeUploader->Init(subscribeUploaderCapacity);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init uploader for subscribe");
        MSPROF_INNER_ERROR("EK9999", "Failed to init uploader for subscribe");
        return nullptr;
    }
    std::string uploaderName = analysis::dvvp::common::config::MSVP_UPLOADER_THREAD_NAME;
    uploaderName.append("_").append("Pipe");
    pipeUploader->SetThreadName(uploaderName);
    ret = pipeUploader->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start uploader thread");
        MSPROF_INNER_ERROR("EK9999", "Failed to start uploader thread");
        return nullptr;
    }
    // create transport1 and uploader1
    SHARED_PTR_ALIA<ParserTransport> parserTransport = nullptr;
    MSVP_MAKE_SHARED1(parserTransport, ParserTransport, pipeUploader, return nullptr);

    return parserTransport;
#else
    return nullptr;
#endif
}

void ProfRegisterTransport(ProfCreateTransportFunc callback)
{
    ProfAclMgr::instance()->RegisterTransport(callback);
}

aclError ProfSubscribe(ProfType type, const uint32_t modelId, const uint32_t devId,
                       const aclprofSubscribeConfig *profSubscribeConfig)
{
    if (profSubscribeConfig == nullptr) {
        MSPROF_LOGE("Param profSubscribeConfig is nullptr");
        std::string errorReason = "Param profSubscribeConfig can not be nullptr";
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({"nullptr", "profSubscribeConfig", errorReason}));
        return ACL_ERROR_INVALID_PARAM;
    }

    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = devId;
    cfg.type = static_cast<uint32_t>(type);
    cfg.modelId = modelId;
    cfg.metrics = static_cast<uint32_t>(profSubscribeConfig->config.aicoreMetrics);
    cfg.fd = reinterpret_cast<uintptr_t>(profSubscribeConfig->config.fd);
    cfg.cacheFlag = static_cast<uint32_t>(profSubscribeConfig->config.timeInfo);

    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);

    int32_t ret = Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg));
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Subscribe model (Graph) info failed, ret: %d", ret);
        MSPROF_INNER_ERROR("EK9999", "Subscribe model (Graph) info failed, ret: %d", ret);
        return ret;
    }

    MSPROF_LOGI("Successfully execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

aclError ProfCheckModelLoaded(const uint32_t modelId, uint32_t &devId)
{
    aclError ret = Analysis::Dvvp::ProfilerCommon::ProfGetDeviceIdByGeModelIdx(modelId, &devId);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Model (Graph) id %u not exists", modelId);
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({std::to_string(modelId), "modelId", "The model ID does not exists"}));
        return ACL_ERROR_INVALID_MODEL_ID;
    }
    return ret;
}

aclError ProfModelSubscribe(ProfType type, const uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
{
    uint32_t devId = 0;
    const auto ret = ProfCheckModelLoaded(modelId, devId);
    if (ret != ACL_ERROR_NONE) {
        return ret;
    }
    return ProfSubscribe(type, modelId, devId, profSubscribeConfig);
}

aclError ProfOpSubscribe(uint32_t devId, const aclprofSubscribeConfig *profSubscribeConfig)
{
    return ProfSubscribe(OP_TYPE, 0, devId, profSubscribeConfig);
}

aclError ProfUnSubscribe(ProfType type, const uint32_t modelId, const uint32_t devId)
{
    struct MsprofConfig cfg;
    cfg.devNums = 1;
    cfg.devIdList[0] = devId;
    cfg.type = static_cast<uint32_t>(type);
    cfg.modelId = modelId;

    MSPROF_LOGI("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    std::lock_guard<std::mutex> lock(g_profMutex);

    int32_t ret = Analysis::Dvvp::ProfilerCommon::ProfConfigStop(
        static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), static_cast<const void *>(&cfg),
        sizeof(cfg));
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Unsubscribe model (Graph) info failed, ret: %d", ret);
        MSPROF_INNER_ERROR("EK9999", "Unsubscribe model (Graph) info failed, ret: %d", ret);
        return ret;
    }

    MSPROF_LOGI("Successfully execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    return ACL_SUCCESS;
}

aclError ProfOpUnSubscribe(uint32_t devId)
{
    return ProfUnSubscribe(OP_TYPE, 0, devId);
}

aclError ProfModelUnSubscribe(ProfType type, const uint32_t modelId)
{
    uint32_t devId = 0;
    const auto ret = ProfCheckModelLoaded(modelId, devId);
    if (ret != ACL_ERROR_NONE) {
        return ret;
    }

    return ProfUnSubscribe(type, modelId, devId);
}

int32_t ProfAclDrvGetDevNum(void)
{
    return analysis::dvvp::driver::DrvGetDevNum();
}

size_t ProfGetModelId(ProfType type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofGetModelId"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    MSPROF_LOGD("Start to execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    uint32_t result;
    int32_t ret = OpDescParser::GetModelId(opInfo, opInfoLen, index, &result);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
        MSPROF_INNER_ERROR("EK9999", "Failed execute aclprofGetModelId");
        return static_cast<size_t>(ret);
    }
    MSPROF_LOGD("Successfully execute %s%s", g_subscribeTypeMap[type].c_str(), __func__);
    return static_cast<size_t>(result);
}

aclError ProfGetOpDescSize(SIZE_T_PTR opDescSize)
{
    MSPROF_LOGI("start to execute aclprofGetOpDescSize");
    if (opDescSize == nullptr) {
        MSPROF_LOGE("Invalid param of ProfGetOpDescSize");
        return ACL_ERROR_INVALID_PARAM;
    }
    *opDescSize = OpDescParser::GetOpDescSize();
    return ACL_SUCCESS;
}

aclError ProfGetOpNum(CONST_VOID_PTR opInfo, size_t opInfoLen, UINT32_T_PTR opNumber)
{
    const int32_t ret = OpDescParser::GetOpNum(opInfo, opInfoLen, opNumber);
    RETURN_IF_NOT_SUCCESS(ret);
    return ACL_SUCCESS;
}

aclError ProfGetOpTypeLen(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, SIZE_T_PTR opTypeLen)
{
    const int32_t ret = OpDescParser::instance()->GetOpTypeLen(opInfo, opInfoLen, opTypeLen, index);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Get op type len failed, prof result = %d", ret);
        return ret;
    }
    return ACL_SUCCESS;
}

aclError ProfGetOpType(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, CHAR_PTR opType, size_t opTypeLen)
{
    int32_t ret = OpDescParser::instance()->GetOpType(opInfo, opInfoLen, opType, opTypeLen, index);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Get op type failed, prof result = %d", ret);
        return ret;
    }
    return ACL_SUCCESS;
}

aclError ProfGetOpNameLen(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, SIZE_T_PTR opNameLen)
{
    int32_t ret = OpDescParser::instance()->GetOpNameLen(opInfo, opInfoLen, opNameLen, index);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Get op name len failed, prof result = %d", ret);
        return ret;
    }
    return ACL_SUCCESS;
}

aclError ProfGetOpName(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, CHAR_PTR opName, size_t opNameLen)
{
    int32_t ret = OpDescParser::instance()->GetOpName(opInfo, opInfoLen, opName, opNameLen, index);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Get op name failed, prof result = %d", ret);
        return ret;
    }
    return ACL_SUCCESS;
}


int32_t ProfAclGetOpVal(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index,
                        VOID_PTR data, size_t len)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofAclGetOpVal"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    switch (type) {
        case ACL_OP_DESC_SIZE:
            return ProfGetOpDescSize(reinterpret_cast<SIZE_T_PTR>(data));
        case ACL_OP_NUM:
            return ProfGetOpNum(opInfo, opInfoLen, reinterpret_cast<UINT32_T_PTR>(data));
        case ACL_OP_TYPE_LEN:
            return ProfGetOpTypeLen(opInfo, opInfoLen, index, reinterpret_cast<SIZE_T_PTR>(data));
        case ACL_OP_TYPE:
            return ProfGetOpType(opInfo, opInfoLen, index, reinterpret_cast<CHAR_PTR>(data), len);
        case ACL_OP_NAME_LEN:
            return ProfGetOpNameLen(opInfo, opInfoLen, index, reinterpret_cast<SIZE_T_PTR>(data));
        case ACL_OP_NAME:
            return ProfGetOpName(opInfo, opInfoLen, index, reinterpret_cast<CHAR_PTR>(data), len);
        case ACL_OP_GET_FLAG:
            return OpDescParser::instance()->GetOpFlag(opInfo, opInfoLen, index);
        default:
            MSPROF_LOGE("Invalid aclprof Get Op value type: %d", type);
    }
    return PROFILING_FAILED;
}

uint64_t ProfAclGetOpTime(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofAclGetOpTime"}));
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    switch (type) {
        case ACL_OP_START:
            return OpDescParser::GetOpStart(opInfo, opInfoLen, index);
        case ACL_OP_END:
            return OpDescParser::GetOpEnd(opInfo, opInfoLen, index);
        case ACL_OP_DURATION:
            return OpDescParser::GetOpDuration(opInfo, opInfoLen, index);
        default:
            MSPROF_LOGE("Invalid aclprof Get Op time type: %d", type);
    }
    return PROFILING_FAILED;
}

const char *ProfAclGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index, uint32_t attri)
{
    if (Platform::instance()->PlatformIsHelperHostSide()) {
        MSPROF_LOGE("acl api not support in helper");
        MSPROF_ENV_ERROR("EK0004", std::vector<std::string>({"intf"}),
            std::vector<std::string>({"aclprofAclGetOpAttriVal"}));
        return nullptr;
    }
    if (type == ACL_OP_GET_ATTR) {
        const char *result = OpDescParser::GetOpAttriValue(opInfo, opInfoLen, index,
                                 static_cast<aclprofSubscribeOpAttri>(attri));
        return result;
    } else {
        MSPROF_LOGE("Invalid aclprof Get OpAttriVal type: %d", type);
        return nullptr;
    }
}

aclError ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData)
{
    FUNRET_CHECK_EXPR_ACTION(FeatureManager::instance()->Init() != PROFILING_SUCCESS, return ACL_ERROR_UNINITIALIZE,
        "Failed to init features function in FeatureManager.");

    *featuresData = static_cast<void*>(FeatureManager::instance()->GetIncompatibleFeatures(featuresSize, false));
    return ACL_SUCCESS;
}

aclError ProfAclGetCompatibleFeaturesV2(size_t *featuresSize, void **featuresData)
{
    FUNRET_CHECK_EXPR_ACTION(FeatureManager::instance()->Init() != PROFILING_SUCCESS, return ACL_ERROR_UNINITIALIZE,
        "Failed to init features function in FeatureManager.");

    *featuresData = static_cast<void*>(FeatureManager::instance()->GetIncompatibleFeatures(featuresSize));
    return ACL_SUCCESS;
}

aclError ProfAclRegisterDeviceCallback()
{
    static const std::string ON = "on";
    if (ProfParamsAdapter::instance()->CheckSetDeviceEnableIsValid(ON)) {
        return ACL_SUCCESS;
    }
    return ACL_ERROR_PROFILING_FAILURE;
}
} // namespace AclApi
} // namespace Msprofiler
