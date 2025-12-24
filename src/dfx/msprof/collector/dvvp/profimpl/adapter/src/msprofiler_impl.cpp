/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprofiler_impl.h"
#include "sys/sysinfo.h"
#include "errno/error_code.h"
#include "msprof_reporter.h"
#include "command_handle.h"
#include "prof_acl_mgr.h"
#include "prof_manager.h"
#include "prof_acl_core.h"
#include "prof_ge_core.h"
#include "msprof_tx_manager.h"
#include "platform/platform.h"
#include "json_parser.h"
#include "dyn_prof_mgr.h"
#include "prof_dev_api.h"
#include "uploader_mgr.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Msprofiler::Parser;
using namespace Msprofiler::Api;
using namespace Collector::Dvvp::DynProf;
using namespace Msprofiler::Api;
using namespace analysis::dvvp::transport;

std::map<const uint32_t, const uint32_t> g_modelDeviceMap; // key: geModelId, value: deviceId;
std::mutex g_mapMutex;
std::mutex g_envMutex;

bool CheckMsprofBin(std::string &envValue)
{
    MSPROF_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, envValue);
    if (!envValue.empty()) {
        MSPROF_LOGI("Msprofbin sample config:%s", envValue.c_str());
        return true;
    }
    return false;
}

int32_t ProfInitProc(uint32_t type)
{
    if (ProfAclMgr::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init acl manager");
        MSPROF_INNER_ERROR("EK9999", "Failed to init acl manager");
        ProfAclMgr::instance()->SetModeToOff();
        return MSPROF_ERROR;
    }

    ProfAclMgr::instance()->MsprofTxHandle();
    if (Platform::instance()->PlatformIsHelperHostSide() || type == MSPROF_CTRL_INIT_PURE_CPU) {
        ProfAclMgr::instance()->MsprofHostHandle();
        if (Msprof::Engine::MsprofReporter::reporters_.empty()) {
            Msprof::Engine::MsprofReporter::InitReporters();
        }
        // Start upload dumper thread
        if (ProfAclMgr::instance()->StartUploaderDumper() != PROFILING_SUCCESS) {
            return MSPROF_ERROR;
        };
        if (Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit() != ACL_SUCCESS) {
            MSPROF_LOGE("CommandHandleProfInit failed.");
            MSPROF_INNER_ERROR("EK9999", "CommandHandleProfInit failed.");
            return MSPROF_ERROR;
        }
        uint64_t profConfigType = ProfAclMgr::instance()->GetCmdModeDataTypeConfig();
        ProfAclMgr::instance()->AddModelLoadConf(profConfigType);
        uint64_t profSwitchHi = ProfAclMgr::instance()->GetProfSwitchHi(profConfigType);
        int32_t ret = Analysis::Dvvp::ProfilerCommon::CommandHandleProfStart(nullptr, 0, profConfigType, profSwitchHi);
        if (ret != ACL_SUCCESS) {
            return MSPROF_ERROR;
        }
    }

    return MSPROF_ERROR_NONE;
}

int32_t ProfInit(uint32_t type, VOID_PTR data, uint32_t len)
{
    if (Utils::IsDynProfMode() && !DynProfMgr::instance()->IsDynStarted()) {
        return DynProfMgr::instance()->StartDynProf();
    }
    std::string sampleConfigEnv;
    MSPROF_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, sampleConfigEnv);
    if ((type == MSPROF_CTRL_INIT_DYNA) && (sampleConfigEnv.empty() || !ProfAclMgr::instance()->IsModeOff())) {
        MSPROF_LOGI("Dynamic profiling environment not really set, so do nothing.");
        return MSPROF_ERROR_NONE;
    }
    int32_t ret = MSPROF_ERROR;
    std::string envValue;
    if (CheckMsprofBin(envValue)) {
        ret = ProfAclMgr::instance()->MsprofInitAclEnv(envValue);
    } else {
        switch (type) {
            case MSPROF_CTRL_INIT_ACL_JSON:
                ret = ProfAclMgr::instance()->MsprofInitAclJson(data, len);
                break;
            case MSPROF_CTRL_INIT_GE_OPTIONS:
                ret = ProfAclMgr::instance()->MsprofInitGeOptions(data, len);
                break;
            case MSPROF_CTRL_INIT_HELPER:
                ret = ProfAclMgr::instance()->MsprofInitHelper(data, len);
                break;
            case MSPROF_CTRL_INIT_PURE_CPU:
                ret = ProfAclMgr::instance()->MsprofInitPureCpu(data, len);
                break;
            default:
                MSPROF_LOGE("Invalid MsprofCtrlCallback type: %u", type);
        }
    }

    if (ret == MSPROF_ERROR_ACL_JSON_OFF) {
        return MSPROF_ERROR_NONE;
    }
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("ProfInit Failed, ret is %d", ret);
        return ret;
    }
    return ProfInitProc(type);
}

int32_t ProfAdprofInit(VOID_PTR data, uint32_t len)
{
    if (len != sizeof(AicpuStartPara)) {
        MSPROF_LOGE("Failed to start adprof because of invalid length: %u.", len);
        return MSPROF_ERROR;
    }

    uint64_t startSwitch = 1U;
    static bool adprofStarted = false;
    AicpuStartPara *para = static_cast<AicpuStartPara *>(data);
    uint32_t devicePid = static_cast<uint32_t>(OsalGetPid());
    MSPROF_LOGI("ProfAdprofInit get prof config: 0x%x, host pid: %u, device pid: %u.", para->profConfig,
        para->hostPid, devicePid);
    if ((para->profConfig & startSwitch) != 0 && para->hostPid == devicePid) {
        if (ProfAclMgr::instance()->StartAdprofDumper() != PROFILING_SUCCESS) {
            return MSPROF_ERROR;
        };
        adprofStarted = true;
        AdprofSetProfConfig(static_cast<uint64_t>(para->profConfig));
        AdprofReportStart();
    }

    if ((para->profConfig & startSwitch) == 0 && adprofStarted) {
        adprofStarted = false;
        AdprofSetProfConfig(static_cast<uint64_t>(para->profConfig));
        AdprofReportStop();
    }

    return MSPROF_ERROR_NONE;
}

int32_t ProfAdprofRegisterCallback(uint32_t moduleId, ProfCommandHandle callback)
{
    return AdprofRegisterCallback(moduleId, callback);
}

int32_t ProfAdprofGetFeatureIsOn(uint64_t feature)
{
    uint64_t profConfig = AdprofGetProfConfig();
    uint32_t startSwitch = 1U;
    if (((profConfig & startSwitch) != 0) && ((feature & profConfig) != 0)) {
        return 1;
    } else {
        return 0;
    }
}

int32_t MsptiSubscribeRawData(MsprofRawDataCallback callback)
{
    int32_t ret = UploaderMgr::instance()->SetAllUploaderRegisterPipeTransportCallback(callback);
    return ret;
}

int32_t MsptiUnSubscribeRawData()
{
    int32_t ret = UploaderMgr::instance()->SetAllUploaderUnRegisterPipeTransportCallback();
    return ret;
}

int32_t ProfConfigStart(uint32_t dataType, const void *data, uint32_t length)
{
    if (data == nullptr || length != sizeof(MsprofConfig)) {
        MSPROF_LOGE("Invalid prof start config, length: %u.", length);
        return MSPROF_ERROR;
    }
    // Init
    int32_t ret = MSPROF_ERROR_NONE;
    auto config = static_cast<const MsprofConfig *>(data);
    ProfConfigType type = static_cast<ProfConfigType>(dataType);
    // start
    (void)ProfAclMgr::instance()->Init();
    switch (type) {
        case ProfConfigType::PROF_CONFIG_PURE_CPU:
            ret = ProfAclMgr::instance()->ProfStartPureCpu(config);
            FUNRET_CHECK_EXPR_ACTION(ret != MSPROF_ERROR_NONE, return MSPROF_ERROR,
                "Failed to start pure cpu prof tasks.");
            break;
        case ProfConfigType::PROF_CONFIG_COMMAND_LINE:
        case ProfConfigType::PROF_CONFIG_ACL_JSON:
        case ProfConfigType::PROF_CONFIG_GE_OPTION:
            ret = ProfAclMgr::instance()->ProfStartCommon(config->devIdList, config->devNums);
            FUNRET_CHECK_EXPR_ACTION(ret != MSPROF_ERROR_NONE && ret != MSPROF_ERROR_UNINITIALIZE, return MSPROF_ERROR,
                "Failed to start common prof tasks.");
            break;
        case ProfConfigType::PROF_CONFIG_ACL_API:
            ret = ProfAclMgr::instance()->PrepareStartAclApi(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to prepare acl api prof tasks.");
            ret = ProfAclMgr::instance()->ProfStartCommon(config->devIdList, config->devNums);
            FUNRET_CHECK_EXPR_ACTION(ret != MSPROF_ERROR_NONE && ret != MSPROF_ERROR_UNINITIALIZE, return MSPROF_ERROR,
                "Failed to start acl api prof tasks.");
            break;
        case ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE:
            ret = ProfAclMgr::instance()->PrepareStartAclSubscribe(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to prepare acl subscribe prof tasks.");
            ret = ProfAclMgr::instance()->ProfStartAclSubscribe(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to start acl subscribe prof tasks.");
            break;
        default:
            MSPROF_LOGE("Invalid data type: %u for prof start.", dataType);
            return MSPROF_ERROR;
    }
    if (ret == MSPROF_ERROR_NONE) {
        InstanceFinalizeGuard();
    }
    return MSPROF_ERROR_NONE;
}

int32_t ProfConfigStop(uint32_t dataType, const void *data, uint32_t length)
{
    if (data == nullptr || length != sizeof(MsprofConfig)) {
        MSPROF_LOGE("Invalid prof stop config, length: %u.", length);
        return MSPROF_ERROR;
    }
    int32_t ret = MSPROF_ERROR_NONE;
    auto config = static_cast<const MsprofConfig *>(data);
    ProfConfigType type = static_cast<ProfConfigType>(dataType);
    switch (type) {
        case ProfConfigType::PROF_CONFIG_PURE_CPU:
            ret = ProfAclMgr::instance()->ProfStopPureCpu();
            FUNRET_CHECK_EXPR_ACTION(ret != MSPROF_ERROR_NONE, return MSPROF_ERROR,
                "Failed to stop pure cpu prof tasks.");
            break;
        case ProfConfigType::PROF_CONFIG_COMMAND_LINE:
        case ProfConfigType::PROF_CONFIG_ACL_JSON:
        case ProfConfigType::PROF_CONFIG_GE_OPTION:
            ret = ProfAclMgr::instance()->ProfStopCommon(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to stop common prof tasks.");
            break;
        case ProfConfigType::PROF_CONFIG_ACL_API:
            ret = ProfAclMgr::instance()->PrepareStopAclApi(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to prepare acl api prof tasks.");
            ret = ProfAclMgr::instance()->ProfStopCommon(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to stop acl api prof tasks.");
            break;
        case ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE:
            ret = ProfAclMgr::instance()->PrepareStopAclSubscribe(config);
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to prepare acl subscribe prof tasks.");
            ret = ProfAclMgr::instance()->ProfStopAclSubscribe(config); 
            FUNRET_CHECK_EXPR_ACTION(ret != ACL_SUCCESS, return ret,
                "Failed to stop acl subscribe prof tasks.");
            break;
        default:
            MSPROF_LOGE("Invalid data type: %u for prof start.", dataType);
            return MSPROF_ERROR;
    }
    return MSPROF_ERROR_NONE;
}

int32_t ProfSetConfig(uint32_t configType, const char *config, size_t configLength)
{
    if (configType == MSPROF_CONFIG_HELPER_HOST) {
        Platform::instance()->SetPlatformHelperHostSide();
        return ProfAclMgr::instance()->ProcessHelperHostConfig(config, configLength);
    }

    return MSPROF_ERROR_NONE;
}

int32_t ProfNotifySetDeviceForDynProf(uint32_t chipId, uint32_t devId, bool isOpenDevice)
{
    DynProfMgr::instance()->SaveDevicesInfoSecurity(chipId, devId, isOpenDevice);

    if (Msprof::Engine::MsprofReporter::reporters_.empty()) {
        MSPROF_LOGI("dynamic profiling notify set device init reporters");
        Msprof::Engine::MsprofReporter::InitReporters();
    }
    if (Analysis::Dvvp::ProfilerCommon::CommandHandleProfInit() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Dynamic profiling CommandHandleProfInit failed");
        return MSPROF_ERROR;
    }
    return MSPROF_ERROR_NONE;
}

int32_t ProfInitIfCommandLine()
{
    if (ProfAclMgr::instance()->IsCmdMode()) {
        return PROFILING_SUCCESS;
    }

    std::unique_lock<std::mutex> envLock(g_envMutex);
    static std::string envValue;
    static bool envCheck = CheckMsprofBin(envValue);
    if (!envCheck) {
        return PROFILING_SUCCESS;
    }

    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (ProfInit(MSPROF_CTRL_INIT_ACL_ENV, nullptr, 0) != MSPROF_ERROR_NONE) {
        return PROFILING_FAILED;
    }
    envCheck = false;
    envValue.clear();

    return PROFILING_SUCCESS;
}

int32_t ProfNotifySetDevice(uint32_t chipId, uint32_t devId, bool isOpenDevice)
{
    if (Utils::IsDynProfMode()) {
        DynProfMgr::instance()->SaveDevicesInfo(chipId, devId, isOpenDevice);
    } else {
        if (isOpenDevice && ProfInitIfCommandLine() != PROFILING_SUCCESS) {
            return MSPROF_ERROR;
        }
    }
    ProfAclMgr::instance()->SetDeviceNotify(devId, isOpenDevice);
    if (!ProfAclMgr::instance()->IsCmdMode() && !ProfAclMgr::instance()->IsAclApiReady()) {
        MSPROF_LOGI("ProfNotifySetDevice, not on cmd mode or acl api not ready.");
        return MSPROF_ERROR_NONE;
    }
    if (ProfAclMgr::instance()->IsPureCpuMode()) {
        MSPROF_LOGI("ProfNotifySetDevice, the PURE CPU mode is being executed.");
        return MSPROF_ERROR_NONE;
    }
    if (Platform::instance()->PlatformIsNeedHelperServer()) {
        MSPROF_LOGI("ProfNotifySetDevice, the helper server no need to set device.");
        return MSPROF_ERROR_NONE;
    }
    MSPROF_LOGI("ProfNotifySetDevice called, is open: %d, devId: %u", isOpenDevice, devId);
    if (isOpenDevice) {
        struct MsprofConfig cfg;
        cfg.devNums = 1;
        cfg.devIdList[0] = {devId};
        return ProfConfigStart(static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_COMMAND_LINE), &cfg,
            sizeof(MsprofConfig));
    } else {
        return ProfAclMgr::instance()->MsprofResetDeviceHandle(devId);
    }
}

inline int32_t InternalErrorCodeToExternal(int32_t internalErrorCode)
{
    return (internalErrorCode == PROFILING_SUCCESS ? MSPROF_ERROR_NONE : MSPROF_ERROR);
}

int32_t ProfReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len)
{
    switch (moduleId) {
        case MSPROF_MODULE_FRAMEWORK:
        case MSPROF_MODULE_ACL:
        case MSPROF_MODULE_RUNTIME:
        case MSPROF_MODULE_HCCL:
            MSPROF_LOGW("Module id %d will no longer be used.", moduleId);
            return PROFILING_SUCCESS;
        case MSPROF_MODULE_DATA_PREPROCESS:
        case MSPROF_MODULE_MSPROF:
            return InternalErrorCodeToExternal(
                Msprof::Engine::MsprofReporter::reporters_[moduleId].HandleReportRequest(type, data, len));
        default:
            MSPROF_LOGE("Invalid reporter callback moduleId: %u", moduleId);
            MSPROF_INNER_ERROR("EK9999", "Invalid reporter callback moduleId: %u", moduleId);
    }
    return ACL_ERROR_PROFILING_FAILURE;
}

int32_t ProfFinalize()
{
    DynProfMgr::instance()->StopDynProf();
    return ProfAclMgr::instance()->MsprofFinalizeHandle();
}

int32_t ProfSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    MSPROF_LOGD("Set deviceId:%u by geModelIdx:%u", deviceId, geModelIdx);
    const std::unique_lock<std::mutex> lock(g_mapMutex);
    (void)g_modelDeviceMap.insert(std::pair<uint32_t, uint32_t>(geModelIdx, deviceId));
    return MSPROF_ERROR_NONE;
}

int32_t ProfUnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    MSPROF_LOGD("Unset deviceId:%u by geModelIdx:%u", deviceId, geModelIdx);
    const std::unique_lock<std::mutex> lock(g_mapMutex);
    (void)g_modelDeviceMap.erase(geModelIdx);
    return MSPROF_ERROR_NONE;
}

int32_t ProfGetDeviceIdByGeModelIdx(const uint32_t geModelIdx, uint32_t* deviceId)
{
    const std::unique_lock<std::mutex> lock(g_mapMutex);
    const auto iter = g_modelDeviceMap.find(geModelIdx);
    if (iter != g_modelDeviceMap.end()) {
        *deviceId = iter->second;
        MSPROF_LOGD("Get deviceId by geModelIdx:%u, deviceId:%u", geModelIdx, *deviceId);
        return MSPROF_ERROR_NONE;
    }
    return MSPROF_ERROR;
}

/**
 * @name  ProfGetImplInfo
 * @brief using ProfImplInfo to get impl information
 */
void ProfGetImplInfo(ProfImplInfo& info)
{
    std::string envStr;
    MSPROF_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, envStr);
    if ((info.profType == MSPROF_CTRL_INIT_DYNA) && (envStr.empty() ||
        !ProfAclMgr::instance()->IsModeOff()) && !Utils::IsDynProfMode()) {
        info.profInitFlag = false;
        MSPROF_LOGI("Profiling Init useless");
        return;
    }

    info.profInitFlag = true;
    try {
        struct sysinfo linuxInfo;
        sysinfo(&linuxInfo);
        info.sysFreeRam = static_cast<size_t>(linuxInfo.freeram);
    } catch (const std::runtime_error &e) {
        MSPROF_LOGW("Failed to get system free ram, reason: %s", e.what());
        info.sysFreeRam = 0;
    }
    MSPROF_EVENT("Get system free ram: %zu", info.sysFreeRam);
}

FinalizeGuard::~FinalizeGuard()
{
    MSPROF_EVENT("Start to execute FinalizeGuard.");
    Analysis::Dvvp::ProfilerCommon::CommandHandleFinalizeGuard();
    FUNRET_CHECK_EXPR_PRINT(ProfAclMgr::instance()->MsprofFinalizeHandle() != MSPROF_ERROR_NONE,
        "Failed to execute Finalize in the destructor phase.");
}

/**
 * @name  InstanceFinalizeGuard
 * @brief Ensure that the collection exits completely.
 */
void InstanceFinalizeGuard()
{
    static FinalizeGuard guard;
}
}
}
}
