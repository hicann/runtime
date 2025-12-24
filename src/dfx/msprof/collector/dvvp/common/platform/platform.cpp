/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "platform.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "platform/platform.h"
#include "logger/msprof_dlog.h"
#include "config_manager.h"

namespace Analysis {
namespace Dvvp {
namespace Common {
namespace Platform {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;

const std::string ASCEND_HAL_LIB = "libascend_hal.so";
constexpr uint32_t SUPPORT_OSC_FREQ_API_VERSION = 0x071905;

template <class T>
inline T LoadDlsymApi(VOID_PTR hanle, const std::string &name)
{
    return reinterpret_cast<T>(OsalDlsym(hanle, name.c_str()));
}

Platform::Platform()
    : platformType_(SysPlatformType::INVALID), runSide_(SysPlatformType::INVALID),
    enableHostOscFreq_(false), hostOscFreq_(""), platform_(nullptr),
    isHelperHostSide_(false), isRpcHelper_(false)
{
}

Platform::~Platform()
{
}

int32_t Platform::Init()
{
    MSPROF_EVENT("Profiling platform version: %s.", PROF_VERSION_INFO);
    std::unique_lock<std::mutex> lk(mtx_);
    if (platform_ != nullptr) {
        MSPROF_LOGI("Profiling platform has been inited.");
        return PROFILING_SUCCESS;
    }
    if (ascendHalAdaptor_.Init() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (DrvGetApiVersion() >= SUPPORT_OSC_FREQ_API_VERSION) {
#ifndef CPU_CYCLE_NO_SUPPORT
        enableHostOscFreq_ = analysis::dvvp::driver::DrvGetHostFreq(hostOscFreq_);
#else
        enableHostOscFreq_ = false;
#endif
    }
    PlatformTypeEnum type = GetPlatformType();
    MSPROF_LOGI("Profiling platform type: %u", type);
    platform_ = PlatformReflection::CreatePlatformClass(type);
    if (platform_ == nullptr) {
        MSPROF_LOGE("Profiling platform init failed");
    }
    return PROFILING_SUCCESS;
}

PlatformTypeEnum Platform::GetPlatformType() const
{
    return static_cast<PlatformTypeEnum>(ConfigManager::instance()->GetPlatformType());
}

int32_t Platform::Uninit()
{
    std::unique_lock<std::mutex> lk(mtx_);
    platform_.reset();
    return PROFILING_SUCCESS;
}

bool Platform::PlatformIsSocSide() const
{
    if (platformType_ == SysPlatformType::DEVICE) {
        return true;
    }
    return false;
}

bool Platform::PlatformIsRpcSide() const
{
    if (platformType_ == SysPlatformType::HOST) {
        return true;
    }
    return false;
}

void Platform::SetPlatformHelperHostSide()
{
    MSPROF_EVENT("Set platform helper host side");
    isHelperHostSide_ = true;
}

void Platform::EnableRpcHelper()
{
    MSPROF_EVENT("Running on rpc helper");
    isRpcHelper_ = true;
}

bool Platform::PlatformIsNeedHelperServer() const
{
    if (isHelperHostSide_) {
        return true;
    }
    return false;
}

bool Platform::CheckIfRpcHelper() const
{
    return isRpcHelper_;
}

bool Platform::PlatformIsHelperHostSide() const
{
    return analysis::dvvp::driver::DrvCheckIfHelperHost();
}

bool Platform::RunSocSide() const
{
    if (runSide_ == SysPlatformType::DEVICE) {
        return true;
    }
    return false;
}

void Platform::SetPlatformSoc()
{
    (void)PlatformInitByDriver();
    platformType_ = SysPlatformType::DEVICE;
}

uint32_t Platform::GetPlatform(void) const
{
    return platformType_;
}

int32_t Platform::PlatformInitByDriver()
{
    int32_t ret = analysis::dvvp::driver::DrvGetPlatformInfo(platformType_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("get platform info failed.");
        return PROFILING_FAILED;
    }
    runSide_ = platformType_;
    MSPROF_LOGI("Set runSide: %d", runSide_);
    return PROFILING_SUCCESS;
}

std::string Platform::PlatformGetHostOscFreq() const
{
    return hostOscFreq_;
}

bool Platform::PlatformHostFreqIsEnable() const
{
    return enableHostOscFreq_;
}

std::string Platform::PlatformGetDeviceOscFreq(uint32_t deviceId, const std::string &freq) const
{
    std::string deviceOscFreq;
    bool enableDeviceOscFreq = false;
    if (DrvGetApiVersion() >= SUPPORT_OSC_FREQ_API_VERSION) {
        enableDeviceOscFreq = analysis::dvvp::driver::DrvGetDeviceFreq(deviceId, deviceOscFreq);
    }

    return enableDeviceOscFreq ? deviceOscFreq : freq;
}

int32_t Platform::GetAicoreEvents(const std::string &aicoreMetricsType, std::string &aicoreEvents) const
{
    if (platform_ != nullptr) {
        return platform_->GetAiPmuMetrics(aicoreMetricsType, aicoreEvents);
    }
    MSPROF_LOGE("Get platform instances info failed.");
    return PROFILING_FAILED;
}

/**
* @brief Check whether feature/switch are supported. Currently other platform will return true.
* @param PlatformFeature or string , representing feature to be checked.
* @return true: feature is supported. false: feature is not supported.
*/
bool Platform::CheckIfSupport(const PlatformFeature feature) const
{
    if (platform_ == nullptr) {
        return true;
    }
    return platform_->FeatureIsSupport(feature);
}

bool Platform::CheckIfSupport(const std::string feature) const
{
    if (platform_ == nullptr) {
        return true;
    }

    auto it = PLATFORM_FEATURE_MAP.find(feature);
    if (it != PLATFORM_FEATURE_MAP.end()) {
        for (auto item : it->second) {
            if (platform_->FeatureIsSupport(item)) {
                return true;
            }
        }
    }
    return false;
}

void Platform::SetSubscribeFeature()
{
    if (platform_ == nullptr) {
        return;
    }
    platform_->SetSubscribeFeature();
}

bool Platform::CheckIfPlatformExist() const
{
    if (platform_ == nullptr) {
        return false;
    }
    return true;
}

uint64_t Platform::PlatformSysCycleTime() const
{
    if (enableHostOscFreq_) {
        return Utils::GetCPUCycleCounter();
    }

    return Utils::GetClockMonotonicRaw();
}

PlatformFeature Platform::PmuToFeature(const std::string &key) const
{
    if (platform_ == nullptr) {
        return PlatformFeature::PLATFORM_FEATURE_INVALID;
    }
    return platform_->PmuMetricsToFeature(key);
}

uint32_t Platform::DrvGetApiVersion() const
{
    int32_t version = 0;
    int32_t ret = ascendHalAdaptor_.HalGetAPIVersion(&version);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_EVENT("Succeeded to DrvGetApiVersion version: 0x%x", version);
        return static_cast<uint32_t>(version);
    }
    return 0;
}

int32_t Platform::HalGetDeviceInfoByBuff(uint32_t deviceId, int32_t moduleType,
    int32_t infoType, VOID_PTR data, int32_t* length) const
{
    return ascendHalAdaptor_.HalGetDeviceInfoByBuff(deviceId, moduleType, infoType, data, length);
}

int32_t Platform::HalGetDeviceQosInfo(uint32_t deviceId, QosProfileInfo &info, int32_t* length) const
{
    int32_t ret = HalGetDeviceInfoByBuff(deviceId, MODULE_TYPE_QOS, INFO_TYPE_CONFIG, &info, length);
    if (ret != DRV_ERROR_NONE || info.streamNum == 0 || info.streamNum > QOS_STREAM_MAX_NUM) {
        MSPROF_EVENT("Can't get qos info[%u] errno[%d].", info.streamNum, ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void Platform::GetQosProfileInfo(uint32_t deviceId, std::string &qosEventInfo, std::vector<uint8_t> &qosEventId)
{
    qosEventId.clear();
    if (platform_ == nullptr || !platform_->FeatureIsSupport(PLATFORM_SYS_DEVICE_QOS)) {
        return;
    }
    QosProfileInfo info = {0, 0, 0, {}, {}};
    int32_t infoLength = sizeof(QosProfileInfo);
    (void)memset_s(info.streamName, QOS_STREAM_NAME_MAX_LENGTH, '0', QOS_STREAM_NAME_MAX_LENGTH);
    info.devId = deviceId;
    if (qosEventInfo.empty()) {
        info.mode = 0; // get qos stream list
        FUNRET_CHECK_EXPR_ACTION(HalGetDeviceQosInfo(deviceId, info, &infoLength) != PROFILING_SUCCESS, return,
            "halGetDeviceInfoFunc failed.");
        uint16_t streamNum = std::min(platform_->GetQosMonitorNumber(), info.streamNum);
        QosProfileInfo infoName = {0, 0, 0, {}, {}};
        infoName.devId = deviceId;
        for (uint16_t i = 0; i < streamNum; i++) {
            (void)memset_s(infoName.streamName, QOS_STREAM_NAME_MAX_LENGTH, '0', QOS_STREAM_NAME_MAX_LENGTH);
            infoName.streamNum = 0;
            infoName.mpamId[0] = info.mpamId[i];
            infoName.mode = 1; // get stream name by mpamId
            int32_t ret = Platform::instance()->HalGetDeviceInfoByBuff(deviceId, MODULE_TYPE_QOS, INFO_TYPE_CONFIG,
                &infoName, &infoLength);
            if (ret != DRV_ERROR_NONE) {
                continue;
            }
            qosEventInfo += std::string(infoName.streamName) + ",";
            qosEventId.push_back(info.mpamId[i]);
        }
        if (!qosEventInfo.empty()) {
            qosEventInfo = qosEventInfo.substr(0, qosEventInfo.size() - 1);
        }
    } else {
        const uint16_t modeGetMpamIdByStreamName = 2;
        std::vector<std::string> qosEvents = Utils::Split(qosEventInfo, true, "", ",");
        if (qosEvents.empty()) {
            MSPROF_LOGE("Invalid qosEventInfo %s", qosEventInfo.c_str());
            return;
        }
        for (auto &qosEvent : qosEvents) {
            info.mode = modeGetMpamIdByStreamName;
            errno_t ret = strcpy_s(info.streamName, QOS_STREAM_NAME_MAX_LENGTH, qosEvent.c_str());
            FUNRET_CHECK_EXPR_ACTION(ret != EOK, return, "strcpy_s %s qosEventInfo failed.", qosEvent.c_str());
            FUNRET_CHECK_EXPR_ACTION(HalGetDeviceQosInfo(deviceId, info, &infoLength) != PROFILING_SUCCESS, return,
                "Failed to get mpamId by streamName from halGetDeviceInfoFunc.");
            qosEventId.push_back(info.mpamId[0]);
        }
        UtilsStringBuilder<std::string> builder;
        qosEventInfo = builder.Join(qosEvents, ",");
    }
}

uint16_t Platform::GetMaxMonitorNumber() const
{
    if (platform_ == nullptr) {
        return MAX_COLLECT_MONITOR_NUM;
    }
    return platform_->GetMaxMonitorNumber();
}

int32_t Platform::InitOnlineAnalyzer()
{
    if (platform_ == nullptr) {
        return PROFILING_FAILED;
    }
    return platform_->InitOnlineAnalyzer();
}

uint32_t Platform::GetMetricsPmuNum(const std::string &name) const
{
    if (platform_ == nullptr) {
        return 0;
    }
    return platform_->GetMetricsPmuNum(name);
}

std::string Platform::GetMetricsTopName(const std::string &name) const
{
    if (platform_ == nullptr) {
        return "";
    }
    return platform_->GetMetricsTopName(name);
}

PmuCalculationAttr* Platform::GetMetricsFunc(const std::string &name, uint32_t index) const
{
    if (platform_ == nullptr) {
        return nullptr;
    }
    return platform_->GetMetricsFunc(name, index);
}

float Platform::GetTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum) const
{
    if (platform_ == nullptr) {
        return 0;
    }
    return platform_->GetTotalTime(cycle, freq, blockDim, coreNum);
}

void Platform::L2CacheAdaptor(std::string &npuEvents, std::string &l2Switch, std::string &l2Events) const
{
    if (platform_ == nullptr) {
        return;
    }

    if (l2Switch == MSVP_PROF_ON && CheckIfSupport(PLATFORM_TASK_L2_CACHE_REG)) {
        l2Events = platform_->GetL2CacheEvents();
        if (CheckIfSupport(PLATFORM_TASK_SOC_PMU)) {
            npuEvents = "HA:" + GetL2CacheEvents() + ";SMMU:" + GetSmmuEventStr();
        }
        MSPROF_LOGI("Platform get l2 cache events: %s, soc pmu events: %s.", l2Events.c_str(), npuEvents.c_str());
        return;
    }

    if (!npuEvents.empty()) {
        l2Switch = MSVP_PROF_ON;
        l2Events = npuEvents;
        MSPROF_LOGI("Platform get soc pmu events: %s.", l2Events.c_str());
    }
}

std::string Platform::GetL2CacheEvents() const
{
    return platform_->GetL2CacheEvents();
}

std::string Platform::GetSmmuEventStr() const
{
    return platform_->GetSmmuEventStr();
}

int32_t Platform::HalEschedQueryInfo(uint32_t devId, ESCHED_QUERY_TYPE type,
    struct esched_input_info *inPut, struct esched_output_info *outPut) const
{
    return ascendHalAdaptor_.HalEschedQueryInfo(devId, type, inPut, outPut);
}

int32_t Platform::HalEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId) const
{
    return ascendHalAdaptor_.HalEschedCreateGrpEx(devId, grpPara, grpId);
}

AscendHalAdaptor::AscendHalAdaptor()
{
}
AscendHalAdaptor::~AscendHalAdaptor()
{
    if (ascendHalLibHandle_ != nullptr) {
        OsalDlclose(ascendHalLibHandle_);
    }
}

int32_t AscendHalAdaptor::Init()
{
    ascendHalLibHandle_ = OsalDlopen(ASCEND_HAL_LIB.c_str(), RTLD_LAZY | RTLD_NODELETE);
    if (ascendHalLibHandle_ == nullptr) {
        MSPROF_LOGE("Open ascend_hal api failed, dlopen error: %s", OsalDlerror());
        return PROFILING_FAILED;
    }
    LoadApi();
    return PROFILING_SUCCESS;
}

void AscendHalAdaptor::LoadApi()
{
    halGetAPIVersion_ = LoadDlsymApi<decltype(halGetAPIVersion_)>(ascendHalLibHandle_, "halGetAPIVersion");
    drvGetDeviceSplitMode_ = LoadDlsymApi<decltype(drvGetDeviceSplitMode_)>(ascendHalLibHandle_,
        "drvGetDeviceSplitMode");
    halGetDeviceInfoByBuff_ = LoadDlsymApi<decltype(halGetDeviceInfoByBuff_)>(ascendHalLibHandle_,
        "halGetDeviceInfoByBuff");
    halEschedQueryInfo_ = LoadDlsymApi<decltype(halEschedQueryInfo_)>(ascendHalLibHandle_, "halEschedQueryInfo");
    halEschedCreateGrpEx_ = LoadDlsymApi<decltype(halEschedCreateGrpEx_)>(ascendHalLibHandle_, "halEschedCreateGrpEx");
}

int32_t AscendHalAdaptor::HalGetAPIVersion(int32_t *version) const
{
    if (halGetAPIVersion_ != nullptr) {
        return halGetAPIVersion_(version);
    }
    return 0;
}

int32_t AscendHalAdaptor::DrvGetDeviceSplitMode(uint32_t deviceId, uint32_t *mode) const
{
    if (drvGetDeviceSplitMode_ != nullptr) {
        return drvGetDeviceSplitMode_(deviceId, mode);
    }
    return 0;
}

int32_t AscendHalAdaptor::HalGetDeviceInfoByBuff(uint32_t deviceId, int32_t moduleType,
    int32_t infoType, VOID_PTR data, int32_t* length) const
{
    if (halGetDeviceInfoByBuff_ != nullptr) {
        return halGetDeviceInfoByBuff_(deviceId, moduleType, infoType, data, length);
    }

    MSPROF_LOGI("Can't find halGetDeviceInfoByBuff from ascend_hal library.");
    return DRV_ERROR_NOT_SUPPORT;
}

int32_t AscendHalAdaptor::HalEschedQueryInfo(uint32_t devId, ESCHED_QUERY_TYPE type,
    struct esched_input_info *inPut, struct esched_output_info *outPut) const
{
    if (halEschedQueryInfo_ != nullptr) {
        return halEschedQueryInfo_(devId, type, inPut, outPut);
    }

    MSPROF_LOGI("Can't find halEschedQueryInfo from ascend_hal library.");
    return DRV_ERROR_NOT_SUPPORT;
}

int32_t AscendHalAdaptor::HalEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId) const
{
    if (halEschedCreateGrpEx_ != nullptr) {
        return halEschedCreateGrpEx_(devId, grpPara, grpId);
    }

    MSPROF_LOGI("Can't find halEschedCreateGrpEx from ascend_hal library.");
    return DRV_ERROR_NOT_SUPPORT;
}
}
}
}
}