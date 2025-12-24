/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "param_validation.h"
#include <sstream>
#include <cctype>
#include <algorithm>
#include <map>
#include "platform/platform.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "message/prof_params.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace validation {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;

constexpr int32_t MIN_INTERVAL = 1;
constexpr int32_t MAX_INTERVAL = 15 * 24 * 3600 * 1000; // 15 * 24 * 3600 * 1000 = 15day's micro seconds
constexpr int32_t MAX_PERIOD = 30 * 24 * 3600; // 30 * 24 * 3600 = 30day's seconds
constexpr int32_t MAX_CORE_ID_SIZE = 80;  // ai core or aiv core id size
constexpr int32_t BASE_HEX = 16;  // hex to int
const std::string SOC_PMU_HA = "HA:";
const std::string SOC_PMU_MATA = "MATA:";
const std::string SOC_PMU_SMMU = "SMMU:";
const std::string SOC_PMU_NOC = "NOC:";
const std::string SCALE_OP_TYPE = "opType:";
const std::string SCALE_OP_NAME = "opName:";
const std::map<std::string, ProfSocPmuType> SOC_PMU_MAP = {
    {SOC_PMU_HA, ProfSocPmuType::PMU_TYPE_HA},
    {SOC_PMU_MATA, ProfSocPmuType::PMU_TYPE_MATA},
    {SOC_PMU_SMMU, ProfSocPmuType::PMU_TYPE_SMMU},
    {SOC_PMU_NOC, ProfSocPmuType::PMU_TYPE_NOC}
};

const std::map<std::string, ProfScaleType> SCALE_MAP = {
    {SCALE_OP_TYPE, ProfScaleType::SCALE_OP_TYPE},
    {SCALE_OP_NAME, ProfScaleType::SCALE_OP_NAME}
};

ParamValidation::ParamValidation()
{
}

ParamValidation::~ParamValidation()
{
}

int32_t ParamValidation::Init() const
{
    return PROFILING_SUCCESS;
}

int32_t ParamValidation::Uninit() const
{
    return PROFILING_SUCCESS;
}

bool ParamValidation::CheckTsCpuEventIsValid(const std::vector<std::string> &events) const
{
    return CheckCtrlCpuEventIsValid(events);
}

bool ParamValidation::CheckCtrlCpuEventIsValid(const std::vector<std::string> &events) const
{
    if (!CheckPmuEventSizeIsValid(events.size())) {
        return false;
    }
    for (uint32_t i = 0; i < events.size(); i++) {
        std::string eventStr = analysis::dvvp::common::utils::Utils::ToLower(events[i]);
        if (eventStr.find("0x") == std::string::npos) {
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckLlcEventsIsValid(const std::string &events)
{
    for (auto ch : events) {
        if (ch == '_' || ch == '/' || (ch == ',' || ch == ' ')) {
            continue;
        } else if ((ch <= 'z' && ch >= 'a') || (ch <= 'Z' && ch >= 'A')) {
            continue;
        } else if ((ch <= '9' && ch >= '0')) {
            continue;
        } else {
            MSPROF_LOGE("llc events is invalid.%s", events.c_str());
            return false;
        }
    }
    MSPROF_LOGD("llc events is %s", events.c_str());
    return true;
}

bool ParamValidation::CheckHexOrDec(std::string &events, const size_t mode) const
{
    if (events.empty()) {
        return false;
    }
    events = analysis::dvvp::common::utils::Utils::Trim(events);

    const std::string pattern = "0x";
    if (mode == HEX_MODE && events.length() > pattern.length()) {
        if (events[0] == '0' && events[1] == 'x') {
            events = events.substr(pattern.length());
        } else {
            return false;
        }
    } else if (mode == HEX_MODE) {
        return false;
    }

    for (auto ch : events) {
        if (mode == HEX_MODE && ch >= 'a' && ch <= 'f') {
            continue;
        } else if ((ch >= '0' && ch <= '9')) {
            continue;
        } else {
            return false;
        }
    }

    if (mode == DEC_MODE) {
        std::stringstream hexStream;
        try {
            hexStream << std::hex << stoi(events);
        } catch (...) {
            MSPROF_LOGE("Failed to transfer events(%s) to integer.", events.c_str());
            return false;
        }
        hexStream >> events;
    }
    events = pattern + events;
    return true;
}

int32_t ParamValidation::CustomHexCharConfig(std::string &aicoreEvents, const std::string &pattern) const
{
    if (aicoreEvents.empty()) {
        MSPROF_LOGE("Custom PMU event is empty.");
        return PROFILING_FAILED;
    }
    std::vector<std::string> eventsList =
        analysis::dvvp::common::utils::Utils::Split(aicoreEvents, false, "", pattern);
    aicoreEvents = "";
    if (!CheckPmuEventSizeIsValid(eventsList.size())) {
        MSPROF_LOGE("ai core events size(%zu) is invalid", eventsList.size());
        return PROFILING_FAILED;
    }
    for (size_t i = 0; i < eventsList.size(); ++i) {
        std::string event = eventsList[i];
        if (!CheckHexOrDec(event, HEX_MODE)) {
            if (!CheckHexOrDec(event, DEC_MODE)) {
                MSPROF_LOGE("0x%s is invalid, hexadecimal or decimal parameters are allowed.",
                    event.c_str());
                return PROFILING_FAILED;
            }
        }
        aicoreEvents += event + pattern;
    }
    aicoreEvents.pop_back();
    return PROFILING_SUCCESS;
}

bool ParamValidation::CheckAicoreMetricsIsValid(const std::string &aicoreMetrics) const
{
    if (aicoreMetrics.empty()) {
        MSPROF_LOGI("aicoreMetrics is empty");
        return true;
    }

    if (aicoreMetrics.length() > MAX_PARAMS_LEN) {
        MSPROF_LOGE("The parameter length exceeds the specified value of %d.", MAX_PARAMS_LEN);
        return false;
    }

    if (aicoreMetrics.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) == 0) {
        std::string aicoreEvent = aicoreMetrics.substr(CUSTOM_METRICS.length());
        std::transform(aicoreEvent.begin(), aicoreEvent.end(), aicoreEvent.begin(), ::tolower);
        int32_t sw = CustomHexCharConfig(aicoreEvent, ",");
        if (sw == PROFILING_FAILED) {
            MSPROF_LOGE("The aic_metrics[%s] of input config is invalid", aicoreMetrics.c_str());
            return false;
        }
        return true;
    }
    auto featureMetrics = Platform::instance()->PmuToFeature(aicoreMetrics);
    if (Platform::instance()->CheckIfSupport(featureMetrics)) {
        return true;
    }

    MSPROF_LOGE("The aic_metrics[%s] of input config is invalid", aicoreMetrics.c_str());
    return false;
}

bool ParamValidation::CheckDuplicateSocPmu(const std::string &oriStr) const
{
    if (!Utils::CheckDuplicateStrings(oriStr, SOC_PMU_HA) ||
        !Utils::CheckDuplicateStrings(oriStr, SOC_PMU_MATA) ||
        !Utils::CheckDuplicateStrings(oriStr, SOC_PMU_SMMU) ||
        !Utils::CheckDuplicateStrings(oriStr, SOC_PMU_NOC)) {
        return false;
    }

    return true;
}

bool ParamValidation::CheckDuplicateScale(const std::string &oriStr) const
{
    if (!Utils::CheckDuplicateStrings(oriStr, SCALE_OP_TYPE) ||
        !Utils::CheckDuplicateStrings(oriStr, SCALE_OP_NAME)) {
        return false;
    }

    return true;
}

ProfSocPmuType ParamValidation::GetSocPmuInfo(std::string &socPmuStr, std::string &eventStr) const
{
    for (auto iter = SOC_PMU_MAP.begin(); iter != SOC_PMU_MAP.end(); ++iter) {
        if (socPmuStr.compare(0, iter->first.size(), iter->first) == 0) {
            eventStr = socPmuStr.substr(iter->first.size());
            return iter->second;
        }
    }

    eventStr = socPmuStr;
    return ProfSocPmuType::PMU_TYPE_HA_NO_HEAD;
}

ProfScaleType ParamValidation::GetScaleInfo(std::string &scaleStr, std::string &scaleInfoStr) const
{
    for (auto iter = SCALE_MAP.begin(); iter != SCALE_MAP.end(); ++iter) {
        if (scaleStr.compare(0, iter->first.size(), iter->first) != 0) {
            continue;
        }
        std::string infoStr = scaleStr.substr(iter->first.size());
        if (infoStr.empty()) {
            return iter->second;
        }
        // unique scale info 
        std::vector<std::string> scaleList = Utils::Split(infoStr, false, "", ",");
        std::set<std::string> scaleSet(scaleList.begin(), scaleList.end());
        for (const auto& item : scaleSet) {
            if (item.empty()) {
                continue;
            }
            scaleInfoStr += item;
            scaleInfoStr += ",";
        }
        scaleInfoStr.pop_back();
        return iter->second;
    }

    scaleInfoStr = scaleStr;
    return ProfScaleType::SCALE_TYPE_UNKNOWN;
}

bool ParamValidation::CheckSocPmuEventsSizeValid(ProfSocPmuType type, uint32_t eventSize, int32_t &maxEvent) const
{
    static int32_t nocMaxEvent = 63; // noc max npu event is 0x3F
    static int32_t smmuMaxEvent = 2056; // smmu max npu event is 0x808
    if (type == ProfSocPmuType::PMU_TYPE_MATA ||
        type == ProfSocPmuType::PMU_TYPE_HA ||
        type == ProfSocPmuType::PMU_TYPE_SMMU ||
        type == ProfSocPmuType::PMU_TYPE_HA_NO_HEAD) {
        static uint32_t maxSocPmuEventSize = 8;
        if (eventSize > maxSocPmuEventSize) {
            MSPROF_LOGE("Input soc pmu events size(%zu) is invalid, which should be less than %u.", eventSize,
                maxSocPmuEventSize);
            return false;
        }
        if (type == ProfSocPmuType::PMU_TYPE_SMMU) {
            maxEvent = smmuMaxEvent;
        }
    } else if (type == ProfSocPmuType::PMU_TYPE_NOC) {
        if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_SOC_PMU_NOC)) {
            MSPROF_LOGE("Noc pmu is not supported on this platform.");
            return false;
        }
        static uint32_t maxNocEventSize = 4;
        if (eventSize > maxNocEventSize) {
            MSPROF_LOGE("Input noc pmu events size(%zu) is invalid, which should be less than %u.", eventSize,
                maxNocEventSize);
            return false;
        }
        maxEvent = nocMaxEvent;
    }
    return true;
}

bool ParamValidation::CheckSocPmuEventsValid(ProfSocPmuType type, const std::vector<std::string> &events) const
{
    const int32_t minEvent = 0;  // min npu event is 0x0
    int32_t maxEvent = 255;  // max npu event is 0xFF
    if (!CheckSocPmuEventsSizeValid(type, static_cast<uint32_t>(events.size()), maxEvent)) {
        return false;
    }

    for (size_t i = 0; i < events.size(); ++i) {
        std::string eventStr = Utils::ToLower(events[i]);
        if (!CheckHexOrDec(eventStr, HEX_MODE)) {
            MSPROF_LOGE("[%s] is invalid, hexadecimal parameters are allowed.", events[i].c_str());
            return false;
        }
    }
    for (uint32_t i = 0; i < events.size(); ++i) {
        int32_t eventVal = strtol(events[i].c_str(), nullptr, BASE_HEX);
        if (eventVal < minEvent || eventVal > maxEvent) {
            MSPROF_LOGE("Npu event val: %d out of range, which should be in %d-%d(0x%x-0x%x)",
                eventVal, minEvent, maxEvent, minEvent, maxEvent);
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckScaleIsValid(const std::string &scaleInput, std::string &scaleType,
    std::string &scaleName, std::string &errInfo) const
{
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_SCALE)) {
        MSPROF_LOGE("Scale not support on this platform.");
        return false;
    }

    if (!CheckDuplicateScale(scaleInput)) {
        MSPROF_LOGE("Failed to check scale, please check if input duplicate type.");
        errInfo = "Failed to check scale, please check if input duplicate type.";
        return false;
    }

    std::vector<std::string> opList = Utils::Split(scaleInput, false, "", ";");
    for (size_t i = 0; i < opList.size(); ++i) {
        std::string scaleInfoStr = "";
        ProfScaleType type = GetScaleInfo(opList[i], scaleInfoStr);
        if (scaleInfoStr.empty()) {
            MSPROF_LOGE("Failed to check empty scale: %s.", opList[i].c_str());
            errInfo = "Failed to check empty scale: " + opList[i] + ".";
            return false;
        }
        static size_t maxScaleLen = 511;
        static size_t scalePrintLen = 128;
        if (scaleInfoStr.size() > maxScaleLen) {
            MSPROF_LOGE("Failed to check overflow scale: %s..., the max input size is %zu.",
                scaleInfoStr.substr(0, scalePrintLen).c_str(), maxScaleLen);
            errInfo = "Failed to check overflow scale: " + scaleInfoStr.substr(0, scalePrintLen) +
                "..., the max input size is 511.";
            return false;
        }

        if (type == ProfScaleType::SCALE_OP_TYPE) {
            scaleType = scaleInfoStr;
        } else if (type == ProfScaleType::SCALE_OP_NAME) {
            scaleName = scaleInfoStr;
        } else {
            MSPROF_LOGE("Failed to check unkown scale type, please use [opType:|opName:] before scale info.");
            errInfo = "Failed to check unkown scale type, please use [opType:|opName:] before scale info.";
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckProfilingIntervalIsValidTWO(
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (params == nullptr) {
        MSPROF_LOGE("[CheckProfilingIntervalIsValidTWO]params is null");
        return false;
    }
    if (!IsValidInterval(params->sys_sampling_interval, "sys_profiling")) {
        return false;
    }
    if (!IsValidInterval(params->pid_sampling_interval, "pid_profiling")) {
        return false;
    }
    if (!IsValidInterval(params->hardware_mem_sampling_interval, "hardware_mem")) {
        return false;
    }
    if (!IsValidInterval(params->io_sampling_interval, "io_profiling")) {
        return false;
    }
    if (!IsValidInterval(params->interconnection_sampling_interval, "interconnection_profiling")) {
        return false;
    }
    if (!IsValidInterval(params->dvpp_sampling_interval, "dvpp_profiling")) {
        return false;
    }
    if (!IsValidInterval(params->nicInterval, "nicProfiling")) {
        return false;
    }
    if (!IsValidInterval(params->roceInterval, "roceProfiling")) {
        return false;
    }
    if (!IsValidInterval(params->aicore_sampling_interval, "aicore_profiling")) {
        return false;
    }
    return true;
}

bool ParamValidation::CheckProfilingIntervalIsValid(
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (params == nullptr) {
        return false;
    }
    if (!IsValidInterval(params->aiv_sampling_interval, "aiv")) {
        return false;
    }
    if (!IsValidInterval(params->hccsInterval, "hccl")) {
        return false;
    }
    if (!IsValidInterval(params->pcieInterval, "pcie")) {
        return false;
    }
    if (!IsValidInterval(params->roceInterval, "roce")) {
        return false;
    }
    if (!IsValidInterval(params->llc_interval, "llc")) {
        return false;
    }
    if (!IsValidInterval(params->ddr_interval, "ddr")) {
        return false;
    }
    if (!IsValidInterval(params->hbmInterval, "hbm")) {
        return false;
    }
    if (!IsValidInterval(params->cpu_sampling_interval, "cpu_profiling")) {
        return false;
    }
    return CheckProfilingIntervalIsValidTWO(params);
}

bool ParamValidation::CheckSystemTraceSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params == nullptr) {
        MSPROF_LOGE("[CheckSystemTraceSwitchProfiling]params is null");
        return false;
    }
    if (!IsValidSwitch(params->cpu_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->tsCpuProfiling)) {
        return false;
    }
    if (!IsValidSwitch(params->aiCtrlCpuProfiling)) {
        return false;
    }
    if (!IsValidSwitch(params->sys_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->pid_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->hardware_mem)) {
        return false;
    }
    if (!IsValidSwitch(params->io_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->interconnection_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->dvpp_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->nicProfiling)) {
        return false;
    }
    if (!IsValidSwitch(params->roceProfiling)) {
        return false;
    }
    return true;
}

bool ParamValidation::CheckProfilingSwitchIsValid(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params == nullptr) {
        return false;
    }
    if (!CheckControlSwitchProfiling(params)) {
        return false;
    }
    if (!CheckTsSwitchProfiling(params)) {
        return false;
    }
    if (!CheckPmuSwitchProfiling(params)) {
        return false;
    }
    if (!CheckSystemTraceSwitchProfiling(params)) {
        return false;
    }
    return true;
}

bool ParamValidation::IsValidSwitch(const std::string &switchStr)
{
    if (switchStr.empty()) {
        return true;
    }
    return switchStr.compare(MSVP_PROF_ON) == 0 ||
        switchStr.compare(MSVP_PROF_OFF) == 0;
}

bool ParamValidation::CheckParamL0L1Invalid(const std::string &switchName, const std::string &switchStr)
{
    if (switchStr.empty()) {
        MSPROF_LOGI("Argument %s is empty.", switchName.c_str());
        return true;
    }
    if (!Platform::instance()->CheckIfSupport(switchName)) {
        MSPROF_LOGE("Argument [%s] is not supported.", switchName.c_str());
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({switchName, switchStr, "Argument is not supported."}));
        return false;
    }
    if (switchStr.compare(MSVP_PROF_L3) == 0 && !Platform::instance()->CheckIfSupport(PLATFORM_TASK_TRACE_L3)) {
        MSPROF_LOGE("l3 is not supported on this platform.");
        return false;
    }
    std::string errInfo = "Please input 'l0', 'l1' or 'off'.";
    if (switchName.compare("ge_api") == 0) {
        if (switchStr.compare(MSVP_PROF_L0) == 0 || switchStr.compare(MSVP_PROF_L1) == 0 ||
            switchStr.compare(MSVP_PROF_OFF) == 0) {
            return true;
        }
    } else if (switchName.compare("task_trace") == 0 || switchName.compare("task_time")) {
        if (switchStr.compare(MSVP_PROF_L0) == 0 || switchStr.compare(MSVP_PROF_L1) == 0 ||
            switchStr.compare(MSVP_PROF_L2) == 0 || switchStr.compare(MSVP_PROF_L3) == 0 ||
            IsValidSwitch(switchStr)) {
            return true;
        } else {
            std::string task_trace_ranges = Platform::instance()->CheckIfSupport(PLATFORM_TASK_TRACE_L3)
                        ? "'on', 'off', 'l0', 'l1', 'l2' or 'l3'." 
                        : "'on', 'off', 'l0', 'l1' or 'l2'.";
            errInfo = "Please input " + task_trace_ranges;
        }
    }
    MSPROF_LOGE("Argument %s: invalid value: %s. %s", switchName.c_str(), switchStr.c_str(), errInfo.c_str());
    return false;
}

bool ParamValidation::CheckParamEmptyInvalid(const std::string &switchName, const std::string &switchStr) const
{
    if (switchStr.empty()) {
        MSPROF_LOGI("Argument %s is empty.", switchName.c_str());
        return true;
    }
    if (!Platform::instance()->CheckIfSupport(switchName)) {
        MSPROF_LOGE("Argument [%s] is not supported.", switchName.c_str());
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({switchName, switchStr, "Argument is not supported."}));
        return false;
    }
    if (switchStr.compare(MSVP_PROF_ON) == 0 ||
        switchStr.compare(MSVP_PROF_OFF) == 0) {
        return true;
    }
    MSPROF_LOGE("Argument %s: invalid value: %s. Please input 'on' or 'off'.", switchName.c_str(),
        switchStr.c_str());
    return false;
}

bool ParamValidation::CheckControlSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (!IsValidSwitch(params->taskTsfw)) {
        MSPROF_LOGE("Control switch taskTsfw is not valid.");
    }
    return true;
}

bool ParamValidation::CheckTsSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (!IsValidSwitch(params->ts_task_track)) {
        return false;
    }
    if (!IsValidSwitch(params->ts_cpu_usage)) {
        return false;
    }
    if (!IsValidSwitch(params->ai_core_status)) {
        return false;
    }
    if (!IsValidSwitch(params->ts_timeline)) {
        return false;
    }
    if (!IsValidSwitch(params->ts_keypoint)) {
        return false;
    }
    if (!IsValidSwitch(params->ai_vector_status)) {
        return false;
    }
    if (!IsValidSwitch(params->ts_fw_training)) {
        return false;
    }
    if (!IsValidSwitch(params->hwts_log)) {
        return false;
    }
    if (!IsValidSwitch(params->hwts_log1)) {
        return false;
    }
    if (!IsValidSwitch(params->ts_memcpy)) {
        return false;
    }
    return true;
}

bool ParamValidation::CheckPmuSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (!IsValidSwitch(params->ai_core_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->aiv_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->ddr_profiling)) {
        return false;
    }
    if (!IsValidSwitch(params->hccsProfiling)) {
        return false;
    }
    if (!IsValidSwitch(params->pcieProfiling)) {
        return false;
    }
    if (!IsValidSwitch(params->hbmProfiling)) {
        return false;
    }
    return true;
}

bool ParamValidation::CheckDeviceIdIsValid(const std::string &devId)
{
    if (!analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum(devId)) {
        MSPROF_LOGE("devId(%s) is not valid.", devId.c_str());
        return false;
    }
    int32_t devIdInt = 0;
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(devIdInt, devId), return false, 
        "devId %s is invalid", devId.c_str());
    if (devIdInt >= 64) { // 64 : devIdMaxNum
        MSPROF_LOGW("devId(%s) is over limited.", devId.c_str());
        return false;
    }
    return true;
}

bool ParamValidation::CheckPmuEventSizeIsValid(const size_t eventSize) const
{
    if (eventSize > Platform::instance()->GetMaxMonitorNumber()) {
        MSPROF_LOGE("check event monitor size(%zu) is bigger than %hu", eventSize,
            Platform::instance()->GetMaxMonitorNumber());
        return false;
    }

    MSPROF_LOGD("eventSize: %zu", eventSize);
    return true;
}

bool ParamValidation::CheckCoreIdSizeIsValid(const int32_t eventSize) const
{
    return eventSize <= MAX_CORE_ID_SIZE;
}

bool ParamValidation::CheckAiCoreEventCoresIsValid(const std::vector<int32_t> &coreId) const
{
    if (!CheckCoreIdSizeIsValid(coreId.size())) {
        MSPROF_LOGE("ai core events cores size(%zu) is bigger than %d", coreId.size(), MAX_CORE_ID_SIZE);
        return false;
    }
    for (uint32_t i = 0; i < coreId.size(); ++i) {
        if (coreId[i] < 0) {
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckAivEventCoresIsValid(const std::vector<int32_t> &coreId) const
{
    return CheckAiCoreEventCoresIsValid(coreId);
}

bool ParamValidation::CheckDdrEventsIsValid(const std::vector<std::string> &events) const
{
    if (!CheckPmuEventSizeIsValid(events.size())) {
        MSPROF_LOGE("ddr events size(%zu) is invalid.", events.size());
        return false;
    }
    for (uint32_t i = 0; i < events.size(); ++i) {
        if (events[i].compare("master_id") == 0) {
            return true;
        }
    }
    return CheckHbmEventsIsValid(events);  // same with hbm event
}

bool ParamValidation::CheckHbmEventsIsValid(const std::vector<std::string> &events) const
{
    if (!CheckPmuEventSizeIsValid(events.size())) {
        MSPROF_LOGE("hbm events size(%zu) is invalid.", events.size());
        return false;
    }
    for (uint32_t i = 0; i < events.size(); ++i) {
        if (events[i].compare("read") != 0 && events[i].compare("write") != 0) {
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckAivEventsIsValid(const std::vector<std::string> &events) const
{
    return CheckAiCoreEventsIsValid(events);  // same with ai core events
}

bool ParamValidation::CheckAppNameIsValid(const std::string &appName)
{
    if (appName.empty()) {
        MSPROF_LOGE("appName is empty");
        return false;
    }
    for (auto ch : appName) {
        if (ch == '_' || ch == '-' || ch == '.') {
            continue;
        } else if ((ch <= 'z' && ch >= 'a') || (ch <= 'Z' && ch >= 'A')) {
            continue;
        } else if ((ch <= '9' && ch >= '0')) {
            continue;
        } else {
            MSPROF_LOGE("App name [%s] is invalid.", appName.c_str());
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckDataTagIsValid(const std::string &tag) const
{
    if (tag.empty()) {
        MSPROF_LOGE("tag is empty");
        return false;
    }
    for (const auto ch : tag) {
        if (ch == '_') {
            continue;
        } else if ((ch <= 'z' && ch >= 'a') || (ch <= 'Z' && ch >= 'A')) {
            continue;
        } else if ((ch <= '9' && ch >= '0')) {
            continue;
        } else {
            MSPROF_LOGE("tag is invalid.%s", tag.c_str());
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckParamsDevices(const std::string &app, const std::string &paramsDevices,
                                         const std::string &paramsHostSys)
{
    if (paramsDevices.empty() && app.empty()) {
        // If only host data is collected, the device parameter is not required.
        if (!paramsHostSys.empty()) {
            return true;
        } else {
            return false;
        }
    }

    if (paramsDevices == "all") {
        return true;
    }

    bool result = true;
    std::vector<std::string> devices =
        analysis::dvvp::common::utils::Utils::Split(paramsDevices, false, "", ",");
    for (size_t i = 0; i < devices.size(); ++i) {
        if (!ParamValidation::instance()->CheckDeviceIdIsValid(devices[i])) {
            MSPROF_LOGE("device:%s is not valid!", devices[i].c_str());
            result = false;
            continue; // find all invalid values for device id
        }
    }
    return result;
}

bool ParamValidation::CheckParamsJobIdRegexMatch(const std::string &paramsJobId)
{
    size_t jobIdStrMaxLength = 512; // 512 : max length of joid
    if (paramsJobId.empty() || paramsJobId.length() > jobIdStrMaxLength) {
        return false;
    }
    for (size_t i = 0; i < paramsJobId.length(); i++) {
        if (paramsJobId[i] >= '0' && paramsJobId[i] <= '9') {
            continue;
        } else if (paramsJobId[i] >= 'a' && paramsJobId[i] <= 'z') {
            continue;
        } else if (paramsJobId[i] >= 'A' && paramsJobId[i] <= 'Z') {
            continue;
        } else if (paramsJobId[i] == '-') {
            continue;
        } else {
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckParamsModeRegexMatch(const std::string &paramsMode)
{
    if (paramsMode.empty()) {
        return true;
    }
    std::vector<std::string> profilingModeWhiteList;
    profilingModeWhiteList.push_back(analysis::dvvp::message::PROFILING_MODE_DEF);
    profilingModeWhiteList.push_back(analysis::dvvp::message::PROFILING_MODE_SYSTEM_WIDE);

    for (size_t i = 0; i < profilingModeWhiteList.size(); i++) {
        if (paramsMode.compare(profilingModeWhiteList[i]) == 0) {
            return true;
        } else {
            continue;
        }
    }
    return false;
}

bool ParamValidation::CheckProfilingParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    if (params == nullptr) {
        MSPROF_LOGE("[CheckProfilingParams]params is nullptr.");
        return false;
    }
    if (!(params->hostProfiling) && !(CheckParamsDevices(params->app, params->devices, params->host_sys))) {
        MSPROF_LOGE("[CheckProfilingParams]devices:%s is illegal", params->devices.c_str());
        return false;
    }
    if (!CheckLlcEventsIsValid(params->llc_profiling_events)) {
        MSPROF_LOGE("[CheckProfilingParams]llc_profiling_events is illegal");
        return false;
    }
    if (!CheckProfilingIntervalIsValid(params)) {
        MSPROF_LOGE("[CheckProfilingParams]profiling interval is illegal");
        return false;
    }
    if (!CheckProfilingSwitchIsValid(params)) {
        MSPROF_LOGE("[CheckProfilingParams]profiling switch is illegal");
        return false;
    }
    if (!CheckAicoreMetricsIsValid(params->ai_core_metrics)) {
        MSPROF_LOGE("[CheckProfilingParams]profiling ai_core_metrics is illegal");
        return false;
    }
    return true;
}

int32_t ParamValidation::CheckEventsSize(const std::string &events) const
{
    if (events.empty()) {
        MSPROF_LOGI("events is empty");
        return PROFILING_SUCCESS;
    }
    const std::vector<std::string> eventsList =
        analysis::dvvp::common::utils::Utils::Split(events, false, "", ",");
    const int32_t eventsListMaxSize = 8;  // 8 is max event list len
    if (eventsList.size() > eventsListMaxSize) {
        MSPROF_LOGE("events Size is incorrect. %s", events.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

bool ParamValidation::IsValidInterval(const int32_t interval, const std::string &logKey) const
{
    if (interval < MIN_INTERVAL || interval > MAX_INTERVAL) {
        MSPROF_LOGE("invalid %s interval: %d", logKey.c_str(), interval);
        return false;
    }
    return true;
}

bool ParamValidation::IsValidSleepPeriod(const int32_t period) const
{
    if (period < MIN_INTERVAL || period > MAX_PERIOD) {
        MSPROF_LOGE("Invalid --sys-period: %d s", period);
        return false;
    }
    return true;
}

bool ParamValidation::CheckHostSysOptionsIsValid(const std::string &hostSysOptions)
{
    if (hostSysOptions.empty()) {
        MSPROF_LOGI("hostSysOptions is empty");
        return false;
    }

    const std::vector<std::string> hostSysWhiteList = {
        HOST_SYS_CPU,
        HOST_SYS_MEM,
        HOST_SYS_DISK,
        HOST_SYS_NETWORK,
        HOST_SYS_OSRT
    };

    for (size_t j = 0; j < hostSysWhiteList.size(); j++) {
        if (hostSysOptions.compare(hostSysWhiteList[j]) == 0) {
            MSPROF_LOGD("hostSysOptions is %s", hostSysOptions.c_str());
            return true;
        }
    }

    MSPROF_LOGE("hostSysOptions[%s] is invalid", hostSysOptions.c_str());
    return false;
}

bool ParamValidation::CheckHostSysPidIsValid(const int32_t hostSysPid) const
{
    if (hostSysPid < 0) {
        MSPROF_LOGE("Invalid --host-sys-pid: %d", hostSysPid);
        return false;
    }

    std::string hostPidPath = "/proc/" + std::to_string(hostSysPid) + "/status";
    OsalStat statBuf;
    int32_t ret = OsalStatGet(hostPidPath.c_str(), &statBuf);
    if (ret < 0) {
        MSPROF_LOGE("Invalid --host-sys-pid: %d", hostSysPid);
        return false;
    }
    return true;
}

/**
 * @brief  : Check host-sys-usage config is valid
 * @param  : [in] hostSysUsageOptions : host-sys-usage config string
 */
bool ParamValidation::CheckHostSysUsageOptionsIsValid(const std::string &hostSysUsageOptions) const
{
    if (hostSysUsageOptions.empty()) {
        MSPROF_LOGI("hostSysUsageOptions is empty.");
        return false;
    }
    const std::vector<std::string> hostSysUsageWhiteList = {HOST_SYS_CPU, HOST_SYS_MEM};
    for (size_t i = 0; i < hostSysUsageWhiteList.size(); i++) {
        if (hostSysUsageOptions.compare(hostSysUsageWhiteList[i]) == 0) {
            MSPROF_LOGD("hostSysUsageOptions is %s.", hostSysUsageOptions.c_str());
            return true;
        }
    }
    MSPROF_LOGE("hostSysUsageOptions[%s] is invalid.", hostSysUsageOptions.c_str());
    return false;
}

bool ParamValidation::ProfStarsAcsqParamIsValid(const std::string &param)
{
    if (param.empty()) {
        return true;
    }

    std::vector<std::string> starsAcsqParamVec = {
        "dsa", "vdec", "jpegd", "jpege", "vpc", "topic", "pcie", "rocee", "sdma", "ctrl_task"
    };

    auto paramVec = analysis::dvvp::common::utils::Utils::Split(param, false, "", ",");
    for (size_t i = 0; i < paramVec.size(); i++) {
        auto iter = find(starsAcsqParamVec.begin(), starsAcsqParamVec.end(), paramVec.at(i));
        if (iter == starsAcsqParamVec.end()) {
            MSPROF_LOGE("Invalid stars acsq params.");
            return false;
        }
    }
    return true;
}

bool ParamValidation::CheckStorageLimit(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    const std::string &storageLimit = params->storageLimit;
    if (storageLimit.empty()) {
        MSPROF_LOGI("storage_limit is empty");
        return true;
    }
    std::string errReason = "storage-limit should be in range [" + std::to_string(STORAGE_LIMIT_DOWN_THD) +
        "," + std::to_string(UINT32_MAX) + "], end with MB";

    const uint32_t unitLen = strlen(STORAGE_LIMIT_UNIT);
    if (storageLimit.size() <= unitLen) {
        MSPROF_LOGE("storage_limit:%s, length is less than %u", storageLimit.c_str(), unitLen + 1);
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"storage_limit", storageLimit, errReason}));
        return false;
    }

    std::string unitStr = storageLimit.substr(storageLimit.size() - unitLen);
    if (unitStr != STORAGE_LIMIT_UNIT) {
        MSPROF_LOGE("storage_limit:%s, not end with MB", storageLimit.c_str());
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"storage_limit", storageLimit, errReason}));
        return false;
    }

    std::string digitStr = storageLimit.substr(0, storageLimit.size() - unitLen);
    if (!Utils::IsAllDigit(digitStr)) {
        MSPROF_LOGE("storage_limit:%s, invalid numbers", storageLimit.c_str());
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"storage_limit", storageLimit, errReason}));
        return false;
    } else if (digitStr.size() > 10) { // digitStr range is 0 ~ 4294967296, max length is 10
        MSPROF_LOGE("storage_limit:%s, valid range is 200~4294967296", storageLimit.c_str());
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"storage_limit", storageLimit, errReason}));
        return false;
    }

    uint64_t limit = stoull(digitStr);
    if (limit < STORAGE_LIMIT_DOWN_THD) {
        MSPROF_LOGE("storage_limit:%s, min value is %uMB", storageLimit.c_str(), STORAGE_LIMIT_DOWN_THD);
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"storage_limit", storageLimit, errReason}));
        params->storageLimit = std::to_string(STORAGE_LIMIT_DOWN_THD) + "MB";
        const std::string &storageLimitCur = params->storageLimit;
        MSPROF_LOGW("auto adjust storage_limit to:%s", storageLimitCur.c_str());
        return false;
    } else if (limit > UINT32_MAX) {
        MSPROF_LOGE("storage_limit:%s, max value is %uMB", storageLimit.c_str(), UINT32_MAX);
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"storage_limit", storageLimit, errReason}));
        return false;
    }
    return true;
}

bool ParamValidation::CheckInstrProfilingFreqValid(const uint32_t instrFreq) const
{
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_INSTR_PROFILING)) {
        MSPROF_LOGW("The argument: instr_profiling_freq is useless on the platform.");
        return true;
    }
    if ((instrFreq < INSTR_PROFILING_SAMPLE_FREQ_MIN) || (instrFreq > INSTR_PROFILING_SAMPLE_FREQ_MAX)) {
        MSPROF_LOGE("instr_profiling_freq %u cycle is invalid (%u~%u).", instrFreq, INSTR_PROFILING_SAMPLE_FREQ_MIN,
            INSTR_PROFILING_SAMPLE_FREQ_MAX);
        std::string errReason = "instr_profiling_freq should be in range [" +
            std::to_string(INSTR_PROFILING_SAMPLE_FREQ_MIN) +
            "," + std::to_string(INSTR_PROFILING_SAMPLE_FREQ_MAX) + "] cycle";
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({"instr_profiling_freq", std::to_string(instrFreq), errReason}));
        return false;
    }
    return true;
}

/**
 * @brief  : Check value is in range [min,max]
 * @param  : [in] switchName : the switch corresponding to the value
 * @param  : [in] value : value string
 * @param  : [in] min : minimum value
 * @param  : [in] max : maximum value
 */
bool ParamValidation::CheckArgRange(const std::string &switchName, const std::string &value,
                                    uint32_t min, uint32_t max) const
{
    if (Utils::IsAllDigit(value) && value.size() <= std::to_string(max).size()) {
        uint32_t arg = std::stoul(value.c_str());
        if (arg >= min && arg <= max) {
            return true;
        }
    }
    MSPROF_LOGE("Argument %s: invalid value: %s. Please input an integer value in %u-%u.",
        switchName.c_str(), value.c_str(), min, max);
    return false;
}

/**
 * @brief  : Check frequence is in valid range
 * @param  : [in] switchName : the switch name
 * @param  : [in] freq : frequence
 */
bool ParamValidation::CheckFreqIsValid(const std::string &switchName, uint32_t freq) const
{
    std::map<std::string, std::vector<uint32_t>> freqRange = {
        {"sys_hardware_mem_freq", {1, 100}},
        {"sys_io_sampling_freq", {1, 100}},
        {"sys_interconnection_freq", {1, 50}},
        {"sys_cpu_freq", {1, 50}},
        {"dvpp_freq", {1, 100}},
        {"host_sys_usage_freq", {1, 50}},
        {"sys_lp_freq", {1, HZ_HUNDRED}}
    };
    if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) {
        freqRange["sys_hardware_mem_freq"] = {1, HZ_TEN_THOUSAND};
    }
    if (!Platform::instance()->CheckIfSupport(switchName)) {
        MSPROF_LOGE("Argument [%s] is not supported.", switchName.c_str());
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"config", "value", "reason"}),
            std::vector<std::string>({switchName, std::to_string(freq), "Argument is not supported."}));
        return false;
    }
    auto it = freqRange.find(switchName);
    if (it != freqRange.end()) {
        return CheckArgRange(switchName, std::to_string(freq), it->second[0], it->second[1]);
    }
    return false;
}

/**
 * @brief  : Check mem serviceflow is valid
 * @param  : [in] switchName : the switch name
 * @param  : [in] config : sys mem serviceflow config
 * @return : true
 *           false
 */
bool ParamValidation::CheckMemServiceflowValid(const std::string &switchName, const std::string &config) const
{
    FUNRET_CHECK_EXPR_ACTION(!Platform::instance()->CheckIfSupport(PLATFORM_SYS_MEM_SERVICEFLOW), return false,
        "Argument %s is not supported", switchName.c_str());
    FUNRET_CHECK_EXPR_ACTION(config.empty(), return false, "Argument %s is empty.", switchName.c_str());
    return true;
}
}
}
}
}
