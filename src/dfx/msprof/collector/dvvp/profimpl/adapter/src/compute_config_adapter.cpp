/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "compute_config_adapter.h"
#include <sstream>
#include <cstring>
#include "common/config/config.h"
#include "msprof_dlog.h"
#include "prof_acl_mgr.h"
#include "prof_params_adapter.h"
#include "platform/platform.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::message;
using namespace Msprofiler::Api;

namespace {
constexpr uint32_t COMPUTE_DEV_NUM = 1;
const char CUSTOM_METRIC_PREFIX[] = "Custom:";
const char METRIC_DELIMITER[] = ",";

struct ComputeConfigAttrs {
    std::vector<uint32_t> aicoreMetrics;
    uint32_t instrMode = 0;
    uint32_t taskBlockMode = 0;
    bool hasTaskBlock = false;
};

bool IsEnabled(uint64_t profSwitch, uint64_t mask) { return (profSwitch & mask) != 0; }

bool HasValidInstrMode(uint32_t instrMode)
{
    return (instrMode & (PROF_COMPUTE_BIU_PERF | PROF_COMPUTE_PC_SAMPLING)) != 0;
}

int32_t ParseConfigAttrs(const MsprofConfigInfo& configInfo, ComputeConfigAttrs& attrs)
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
                    if (attr.value.aicoreMetrics[index] != MSPROF_INVALID_AICORE_METRIC) {
                        attrs.aicoreMetrics.push_back(attr.value.aicoreMetrics[index]);
                    }
                }
                break;
            case PROF_CONFIG_ATTR_INSTR:
                attrs.instrMode = attr.value.instrMode;
                break;
            case PROF_CONFIG_ATTR_TASK_BLOCK:
                if (attr.value.taskBlockMode != PROF_COMPUTE_ALL_BLOCK &&
                    attr.value.taskBlockMode != PROF_COMPUTE_BLOCK_SHRINK) {
                    MSPROF_LOGE("Invalid compute task block mode:%u.", attr.value.taskBlockMode);
                    return PROFILING_FAILED;
                }
                attrs.hasTaskBlock = true;
                attrs.taskBlockMode = attr.value.taskBlockMode;
                break;
            default:
                MSPROF_LOGW("Ignore unknown compute config attr id:%u.", attr.id);
                break;
        }
    }
    return PROFILING_SUCCESS;
}

std::string BuildMetricsString(const std::vector<uint32_t>& metrics)
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

void InitProfileParams(SHARED_PTR_ALIA<ProfileParams>& params)
{
    params->result_dir = MSVP_PROF_EMPTY_STRING;
    params->resultPath = MSVP_PROF_EMPTY_STRING;
    params->profMode = MSVP_PROF_COMPUTE_MODE;
    params->profiling_mode = PROFILING_MODE_DEF;
    params->hostProfiling = false;
    params->acl = MSVP_PROF_OFF;
    params->runtimeApi = MSVP_PROF_OFF;
    params->geApi = MSVP_PROF_OFF;
    params->runtimeTrace = MSVP_PROF_OFF;
    params->taskTrace = MSVP_PROF_OFF;
    params->taskTime = MSVP_PROF_OFF;
    params->aicpuTrace = MSVP_PROF_OFF;
}

int32_t BuildProfileParams(
    const MsprofConfig& config, const ComputeConfigAttrs& attrs, SHARED_PTR_ALIA<ProfileParams>& params)
{
    MSVP_MAKE_SHARED0(params, ProfileParams, return PROFILING_FAILED);
    const std::string devIdStr = std::to_string(config.devIdList[0]);
    params->job_id = devIdStr;
    params->devices = devIdStr;
    InitProfileParams(params);

    Host::Adapter::ProfParamsAdapter::instance()->StartCfgTrfToInnerParam(config.profSwitch, params);
    if (IsEnabled(config.profSwitch, PROF_AICORE_METRICS_MASK)) {
        const std::string metricEvents = BuildMetricsString(attrs.aicoreMetrics);
        const std::string rawEvents = metricEvents.substr(strlen(CUSTOM_METRIC_PREFIX));
        params->ai_core_profiling = MSVP_PROF_ON;
        params->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
        params->ai_core_metrics = metricEvents;
        params->ai_core_profiling_events = rawEvents;
        params->aiv_profiling = MSVP_PROF_ON;
        params->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
        params->aiv_metrics = metricEvents;
        params->aiv_profiling_events = rawEvents;
    }
    if (IsEnabled(config.profSwitch, PROF_INSTR_MASK)) {
        params->instrProfiling = (attrs.instrMode & PROF_COMPUTE_BIU_PERF) != 0 ? MSVP_PROF_ON : MSVP_PROF_OFF;
        params->pcSampling = (attrs.instrMode & PROF_COMPUTE_PC_SAMPLING) != 0 ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
    if (attrs.hasTaskBlock) {
        params->taskBlock = MSVP_PROF_ON;
        params->taskBlockShink = attrs.taskBlockMode == PROF_COMPUTE_BLOCK_SHRINK ? MSVP_PROF_ON : MSVP_PROF_OFF;
    }
    return PROFILING_SUCCESS;
}
} // namespace

int32_t ComputeConfigAdapter::ToProfileParams(
    const MsprofConfig& config, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams>& params)
{
    params = nullptr;
    if (config.devNums != COMPUTE_DEV_NUM) {
        MSPROF_LOGE("Compute profiling only supports one device, devNums:%u.", config.devNums);
        return PROFILING_FAILED;
    }
    if (config.devIdList[0] == DEFAULT_HOST_ID) {
        MSPROF_LOGE("Compute profiling does not support host device, devId:%u.", config.devIdList[0]);
        return PROFILING_FAILED;
    }

    ComputeConfigAttrs attrs;
    if (ParseConfigAttrs(config.configInfo, attrs) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (IsEnabled(config.profSwitch, PROF_AICORE_METRICS_MASK) && attrs.aicoreMetrics.empty()) {
        MSPROF_LOGE("Aicore metrics is required when PROF_AICORE_METRICS_MASK is enabled.");
        return PROFILING_FAILED;
    }
    if (IsEnabled(config.profSwitch, PROF_INSTR_MASK) && !HasValidInstrMode(attrs.instrMode)) {
        MSPROF_LOGE("Instr mode is required when PROF_INSTR_MASK is enabled.");
        return PROFILING_FAILED;
    }
    if (!IsEnabled(config.profSwitch, PROF_TASK_TIME_MASK) && !IsEnabled(config.profSwitch, PROF_AICORE_METRICS_MASK) &&
        !IsEnabled(config.profSwitch, PROF_AICPU_TRACE_MASK) && !IsEnabled(config.profSwitch, PROF_INSTR_MASK) &&
        !attrs.hasTaskBlock) {
        MSPROF_LOGE("No compute profiling item is enabled.");
        return PROFILING_FAILED;
    }
    if (BuildProfileParams(config, attrs, params) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (Host::Adapter::ProfParamsAdapter::instance()->CheckDataTypeSupport(config.profSwitch) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to check the compute parameter settings.");
        params = nullptr;
        return PROFILING_FAILED;
    }

    ProfAclMgr::instance()->AddProfLevelConf(params, config.profSwitch);
    ProfAclMgr::instance()->AddCcuInstruction(params);
    return PROFILING_SUCCESS;
}

} // namespace ProfilerCommon
} // namespace Dvvp
} // namespace Analysis
