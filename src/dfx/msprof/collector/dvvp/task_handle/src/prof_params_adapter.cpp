/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_params_adapter.h"
#include <algorithm>
#include "json/json.h"
#include "acl/acl_prof.h"
#include "errno/error_code.h"
#include "message/prof_params.h"
#include "config/config.h"
#include "config_manager.h"
#include "validation/param_validation.h"
#include "prof_acl_api.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace Host {
namespace Adapter {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::validation;
ProfParamsAdapter::ProfParamsAdapter(): aclApiSetDeviceEnable_(false) {}

ProfParamsAdapter::~ProfParamsAdapter() {}

int32_t ProfParamsAdapter::Init() const
{
    return PROFILING_SUCCESS;
}

/**
 * @brief  : Transfer ProfApiStartReq to inner params
 * @param  : [in] ProfApiStartReq : acl api struct cfg
 * @param  : [out] ProfileParams : inner params
 */
int32_t ProfParamsAdapter::StartReqTrfToInnerParam(SHARED_PTR_ALIA<ProfApiStartReq> feature,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (params == nullptr || feature == nullptr) {
        MSPROF_LOGE("ProfileParams or ProfApiStartReq is nullptr");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Begin to transfer api StartReq to inner params");
    params->job_id = feature->jobId;
    if (!feature->tsFwTraining.empty()) {
        params->ts_fw_training = feature->tsFwTraining;
    }
    if (!feature->hwtsLog.empty()) {
        params->hwts_log = feature->hwtsLog;
    }
    if (!feature->tsTimeline.empty()) {
        params->ts_timeline = feature->tsTimeline;
    }
    if (!feature->tsTaskTrack.empty() && params->taskTsfw == "on") {
        params->ts_task_track = feature->tsTaskTrack;
    }
    if (!feature->systemTraceConf.empty()) {
        HandleSystemTraceConf(feature->systemTraceConf, params);
    }
    if (!feature->taskTraceConf.empty()) {
        HandleTaskTraceConf(feature->taskTraceConf, params);
    }
    if (feature->featureName.find("op_trace") != std::string::npos) {
        UpdateOpFeature(feature, params);
    }
    if (feature->featureName.compare("system_trace") == 0) { // mdc scene only use system_trace
        params->hwts_log1 = "off";
    }
    params->profiling_options = feature->featureName;
    return PROFILING_SUCCESS;
}

/**
 * @brief  : Transfer dataTypeConfig to inner params
 * @param  : [in] msprofStartCfg : msprof config
 * @param  : [out] ProfileParams : inner params
 */
void ProfParamsAdapter::StartCfgTrfToInnerParam(const uint64_t dataTypeConfig,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    MSPROF_LOGI("Begin to transfer msprof StartCfg to inner params");
    if ((dataTypeConfig & PROF_TASK_TSFW_MASK) != 0) {
        params->taskTsfw = "on";
    }
    if ((dataTypeConfig & PROF_TASK_TIME_MASK) != 0) {
        // ts_memcpy
        params->ts_memcpy = MSVP_PROF_ON;
        // stars task
        params->stars_acsq_task = MSVP_PROF_ON;
    }
    if ((dataTypeConfig & PROF_AICPU_TRACE_MASK) != 0) {
        params->aicpuTrace = MSVP_PROF_ON;
    }
}

int32_t ProfParamsAdapter::CheckDataTypeSupport(const uint64_t dataTypeConfig) const
{
    auto iter = PLATFORM_BITE_MAP.cbegin();
    while (iter != PLATFORM_BITE_MAP.cend()) {
        if (((dataTypeConfig & iter->first) != 0) && !Platform::instance()->CheckIfSupport(iter->second)) {
            MSPROF_LOGE("The type of config [0x%llx] is not support.", iter->first);
            return PROFILING_FAILED;
        }
        iter++;
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief  : Check json config is valid
 * @param  : [in] switchName : switch name
 * @param  : [in] val : switch name Corresponding JsonValue
 */
bool ProfParamsAdapter::CheckJsonConfig(const std::string &switchName, const NanoJson::JsonValue &val) const
{
    if (switchName == "aic_metrics") {
        return ParamValidation::instance()->CheckAicoreMetricsIsValid(val.GetValue<std::string>());
    } else if (switchName == "ge_api" || switchName == "task_trace") {
        return ParamValidation::instance()->CheckParamL0L1Invalid(switchName, val.GetValue<std::string>());
    } else if (switchName == "sys_hardware_mem_freq" ||
               switchName == "sys_io_sampling_freq" ||
               switchName == "sys_interconnection_freq" ||
               switchName == "sys_cpu_freq" ||
               switchName == "dvpp_freq" ||
               switchName == "host_sys_usage_freq" ||
               switchName == "sys_lp_freq") {
        return ParamValidation::instance()->CheckFreqIsValid(switchName, val.GetValue<uint32_t>());
    } else if (switchName == "llc_profiling") {
        return ParamValidation::instance()->CheckLlcConfigValid(val.GetValue<std::string>());
    } else if (switchName == "host_sys") {
        return CheckHostSysValid(val.GetValue<std::string>());
    } else if (switchName == "host_sys_usage") {
        return CheckHostSysUsageValid(val.GetValue<std::string>());
    } else if (switchName == "sys_mem_serviceflow") {
        return ParamValidation::instance()->CheckMemServiceflowValid(switchName, val.GetValue<std::string>());
    } else {
        return ParamValidation::instance()->CheckParamEmptyInvalid(switchName, val.GetValue<std::string>());
    }
}

/**
 * @brief  : Transfer json to inner params
 * @param  : [in] jsonCfg : msprof json config
 * @param  : [out] params : inner ProfileParams
 */
int32_t ProfParamsAdapter::HandleJsonConf(const NanoJson::Json &jsonCfg,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    for (auto iter = jsonCfg.Begin(); iter != jsonCfg.End();  ++iter) {
        if (iter->first == "sys_hardware_mem_freq") {
            params->hardware_mem_sampling_interval = HZ_CONVERT_US / iter->second.GetValue<uint32_t>();
            params->hardware_mem = "on";
            params->ddr_profiling_events = "read,write";
            params->hbm_profiling_events = "read,write";
        } else if (iter->first == "llc_profiling") {
            params->llc_profiling = iter->second.GetValue<std::string>();
        } else if (iter->first == "sys_io_sampling_freq") {
            params->io_sampling_interval = HZ_CONVERT_MS / iter->second.GetValue<uint32_t>();
            params->io_profiling = "on";
        } else if (iter->first == "sys_interconnection_freq") {
            params->interconnection_sampling_interval = HZ_CONVERT_MS / iter->second.GetValue<uint32_t>();
            params->interconnection_profiling = "on";
        } else if (iter->first == "sys_cpu_freq") {
            params->cpu_sampling_interval = HZ_CONVERT_MS / iter->second.GetValue<uint32_t>();
            params->cpu_profiling = "on";
        } else if (iter->first == "dvpp_freq") {
            params->dvpp_sampling_interval = HZ_CONVERT_MS / iter->second.GetValue<uint32_t>();
            params->dvpp_profiling = "on";
        } else if (iter->first == "host_sys") {
            SetHostSysParam(iter->second.GetValue<std::string>(), params);
        } else if (iter->first == "host_sys_usage") {
            SetHostSysUsageParam(iter->second.GetValue<std::string>(), params);
        } else if (iter->first == "host_sys_usage_freq") {
            params->hostProfilingSamplingInterval = HZ_CONVERT_MS / iter->second.GetValue<uint32_t>();
        }
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief  : Check platform is support input acl api config
 * @param  : [in] type : aclprofConfigType type
 */
int32_t ProfParamsAdapter::CheckApiConfigSupport(aclprofConfigType type) const
{
    const std::map<aclprofConfigType, std::vector<PlatformFeature>> platformAclApiMap = {
        {ACL_PROF_SYS_HARDWARE_MEM_FREQ,    {PLATFORM_SYS_DEVICE_NPU_MODULE_MEM, PLATFORM_SYS_DEVICE_LLC,
                                             PLATFORM_SYS_DEVICE_DDR, PLATFORM_SYS_DEVICE_HBM}},
        {ACL_PROF_LLC_MODE,                 {PLATFORM_SYS_DEVICE_LLC}},
        {ACL_PROF_SYS_IO_FREQ,              {PLATFORM_SYS_DEVICE_NIC, PLATFORM_SYS_DEVICE_ROCE}},
        {ACL_PROF_SYS_INTERCONNECTION_FREQ, {PLATFORM_SYS_DEVICE_PCIE, PLATFORM_SYS_DEVICE_HCCS}},
        {ACL_PROF_SYS_CPU_FREQ,             {PLATFORM_SYS_DEVICE_AICPU_HSCB}},
        {ACL_PROF_DVPP_FREQ,                {PLATFORM_SYS_DEVICE_DVPP, PLATFORM_SYS_DEVICE_DVPP_EX}},
        {ACL_PROF_HOST_SYS,                 {PLATFORM_SYS_HOST_SYS_CPU, PLATFORM_SYS_HOST_SYS_MEM}},
        {ACL_PROF_HOST_SYS_USAGE,           {PLATFORM_SYS_HOST_ALL_PID_CPU, PLATFORM_SYS_HOST_ALL_PID_MEM}},
        {ACL_PROF_HOST_SYS_USAGE_FREQ,      {PLATFORM_SYS_HOST_ALL_PID_CPU, PLATFORM_SYS_HOST_ALL_PID_MEM}},
        {ACL_PROF_LOW_POWER_FREQ,           {PLATFORM_SYS_DEVICE_LOW_POWER}},
        {ACL_PROF_SYS_MEM_SERVICEFLOW,      {PLATFORM_SYS_MEM_SERVICEFLOW}},
        {ACL_PROF_SCALE,                    {PLATFORM_TASK_SCALE}}
    };
    if (type == ACL_PROF_STORAGE_LIMIT) {
        return PROFILING_SUCCESS;
    }
    if (platformAclApiMap.find(type) != platformAclApiMap.end()) {
        for (const auto& feature : platformAclApiMap.at(type)) {
            if (Platform::instance()->CheckIfSupport(feature)) {
                return PROFILING_SUCCESS;
            }
        }
    }
    MSPROF_LOGE("The api config of type [%d] is not support.", static_cast<int32_t>(type));
    return PROFILING_FAILED;
}

/**
 * @brief  : Check host sys config is valid
 * @param  : [in] config : host sys config string
 */
bool ProfParamsAdapter::CheckHostSysValid(const std::string &config) const
{
    std::vector<std::string> hostSysArray = Utils::Split(config, false, "", ",");
    for (size_t i = 0; i < hostSysArray.size(); ++i) {
        if (!ParamValidation::instance()->CheckHostSysOptionsIsValid(hostSysArray[i])) {
            MSPROF_LOGE("Argument --host-sys: invalid value:%s. Please input in the range of "
                "'cpu|mem'", hostSysArray[i].c_str());
            return false;
        }
    }
    return true;
}

/**
 * @brief  : Check host sys usage config is valid
 * @param  : [in] config : host sys usage config string
 */
bool ProfParamsAdapter::CheckHostSysUsageValid(const std::string &config) const
{
    std::vector<std::string> hostSysUsageArray = Utils::Split(config, false, "", ",");
    for (size_t i = 0; i < hostSysUsageArray.size(); ++i) {
        if (!ParamValidation::instance()->CheckHostSysUsageOptionsIsValid(hostSysUsageArray[i])) {
            MSPROF_LOGE("Argument --host-sys: invalid value:%s. Please input in the range of "
                "'cpu|mem'", hostSysUsageArray[i].c_str());
            return false;
        }
    }
    return true;
}

/**
 * @brief  : Transfer json to inner params
 * @param  : [in] jsonCfg : msprof json config
 * @param  : [out] params : inner ProfileParams
 */
int32_t ProfParamsAdapter::CheckApiConfigIsValid(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
    aclprofConfigType type, const std::string &config)
{
    FUNRET_CHECK_EXPR_ACTION(params == nullptr, return PROFILING_FAILED, "Check config failed, the params is nullptr.");
    switch (type) {
        case ACL_PROF_STORAGE_LIMIT:
            params->storageLimit = config;
            if (ParamValidation::instance()->CheckStorageLimit(params)) {
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_SYS_MEM_SERVICEFLOW:
            if (ParamValidation::instance()->CheckMemServiceflowValid("ACL_PROF_SYS_MEM_SERVICEFLOW", config)) {
                params->memServiceflow = config;
                return PROFILING_SUCCESS;
            }    
            break;
        case ACL_PROF_LLC_MODE:
            if (ParamValidation::instance()->CheckLlcConfigValid(config)) {
                params->llc_profiling = config;
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_SYS_IO_FREQ:
            // [1, 100]
            if (ParamValidation::instance()->CheckArgRange("ACL_PROF_SYS_IO_FREQ", config, 1, 100)) {
                params->io_profiling = "on";
                params->io_sampling_interval = HZ_CONVERT_MS / std::stoul(config.c_str());
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_SYS_INTERCONNECTION_FREQ:
            // [1, 50]
            if (ParamValidation::instance()->CheckArgRange("ACL_PROF_SYS_INTERCONNECTION_FREQ", config, 1, 50)) {
                params->interconnection_profiling = "on";
                params->interconnection_sampling_interval = HZ_CONVERT_MS / std::stoul(config.c_str());
                return PROFILING_SUCCESS;
            }
            break;
        default:
            return CheckApiConfigIsValidTwo(params, type, config);
    }
    return PROFILING_FAILED;
}

int32_t ProfParamsAdapter::CheckApiConfigIsValidTwo(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
    aclprofConfigType type, const std::string &config)
{
    switch (type) {
        case ACL_PROF_DVPP_FREQ:
            // [1, 100]
            if (ParamValidation::instance()->CheckArgRange("ACL_PROF_DVPP_FREQ", config, 1, 100)) {
                params->dvpp_profiling = "on";
                params->dvpp_sampling_interval = HZ_CONVERT_MS / std::stoul(config.c_str());
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_HOST_SYS:
            if (CheckHostSysValid(config)) {
                SetHostSysParam(config, params);
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_HOST_SYS_USAGE:
            if (CheckHostSysUsageValid(config)) {
                SetHostSysUsageParam(config, params);
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_HOST_SYS_USAGE_FREQ:
            // [1, 50]
            if (ParamValidation::instance()->CheckArgRange("ACL_PROF_HOST_SYS_USAGE_FREQ", config, 1, 50)) {
                params->hostProfilingSamplingInterval = HZ_CONVERT_MS / std::stoul(config);
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_LOW_POWER_FREQ:
            if (ParamValidation::instance()->CheckArgRange("ACL_PROF_LOW_POWER_FREQ", config, 1, HZ_HUNDRED)) {
                params->sysLp = "on";
                uint32_t lpFreq = 0;
                if (!Utils::StrToUint32(lpFreq, config) || lpFreq == 0) {
                    MSPROF_LOGE("Convert string %s to uint32_t failed.", config.c_str());
                    break;
                }
                params->sysLpFreq = HZ_CONVERT_US / lpFreq;
                return PROFILING_SUCCESS;
            }
            break;
        default:
            return CheckApiConfigIsValidThree(params, type, config);
    }
    return PROFILING_FAILED;
}

int32_t ProfParamsAdapter::CheckApiConfigIsValidThree(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
    aclprofConfigType type, const std::string &config)
{
    switch (type) {
        case ACL_PROF_SYS_HARDWARE_MEM_FREQ:
            static bool hardwareMemFlag = false;
            if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_US)) {
                hardwareMemFlag = ParamValidation::instance()->CheckArgRange("ACL_PROF_SYS_HARDWARE_MEM_FREQ", config,
                    1, HZ_TEN_THOUSAND);
            } else {
                hardwareMemFlag = ParamValidation::instance()->CheckArgRange("ACL_PROF_SYS_HARDWARE_MEM_FREQ", config,
                    1, HZ_HUNDRED);
            }
            if (hardwareMemFlag) {
                params->hardware_mem = "on";
                params->hardware_mem_sampling_interval = HZ_CONVERT_US / std::stoul(config.c_str());
                params->ddr_profiling_events = "read,write";
                params->hbm_profiling_events = "read,write";
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_SYS_CPU_FREQ:
            static uint32_t maxCpuFreqHz = 50;
            if (ParamValidation::instance()->CheckArgRange("ACL_PROF_SYS_CPU_FREQ", config, 1, maxCpuFreqHz)) {
                params->cpu_profiling = "on";
                params->cpu_sampling_interval = HZ_CONVERT_MS / std::stoul(config.c_str());
                return PROFILING_SUCCESS;
            }
            break;
        case ACL_PROF_SCALE:
            static std::string errInfo = "";
            if (ParamValidation::instance()->CheckScaleIsValid(config, params->scaleType, params->scaleName,
                errInfo)) {
                return PROFILING_SUCCESS;
            }
            break;
        default:
            MSPROF_LOGE("Not support type: %d", static_cast<int32_t>(type));
    }
    return PROFILING_FAILED;
}

/**
 * @brief  : Transfer host sys config to inner params
 * @param  : [in] config : host sys config string
 */
void ProfParamsAdapter::SetHostSysParam(const std::string &config,
                                        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    std::vector<std::string> hostSysArray = Utils::Split(config, false, "", ",");
    for (auto sysSwitch : hostSysArray) {
        if (sysSwitch == HOST_SYS_CPU) {
            params->host_cpu_profiling = "on";
        } else if (sysSwitch == HOST_SYS_MEM) {
            params->host_mem_profiling = "on";
        } else if (sysSwitch == HOST_SYS_NETWORK) {
            params->host_network_profiling = "on";
        } else if (sysSwitch == HOST_SYS_DISK) {
            params->host_disk_profiling = "on";
        } else if (sysSwitch == HOST_SYS_OSRT) {
            params->host_osrt_profiling = "on";
        }
    }
}

/**
 * @brief  : Transfer host sys usage config to inner params
 * @param  : [in] config : host sys usage config string
 */
void ProfParamsAdapter::SetHostSysUsageParam(const std::string &config,
                                             SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    std::vector<std::string> hostSysUsageArray = Utils::Split(config, false, "", ",");
    for (auto sysSwitch : hostSysUsageArray) {
        if (sysSwitch == HOST_SYS_CPU) {
            params->hostAllPidCpuProfiling = "on";
        } else if (sysSwitch == HOST_SYS_MEM) {
            params->hostAllPidMemProfiling = "on";
        }
    }
}

int32_t ProfParamsAdapter::HandleTaskTraceConf(const std::string &conf,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    const int32_t cfgBufferMaxLen = 1024 * 1024;  // 1024 *1024 means 1mb
    if (params == nullptr || conf.size() > cfgBufferMaxLen) {  // job context size bigger than 1mb
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<ProfApiSysConf> taskConf = DecodeSysConfJson(conf);
    FUNRET_CHECK_EXPR_ACTION(taskConf == nullptr, return PROFILING_FAILED, "Failed to decode sys conf json");
    params->l2CacheTaskProfiling = taskConf->l2;
    Platform::instance()->L2CacheAdaptor(params->npuEvents, params->l2CacheTaskProfiling,
        params->l2CacheTaskProfilingEvents);
    if (taskConf->aicoreMetrics.empty()) {
        params->ai_core_profiling = "off";
        params->aiv_profiling = "off";
        MSPROF_LOGI("Ai core profiling turns off");
        return PROFILING_SUCCESS;
    }
    std::string aiCoreMetrics = taskConf->aicoreMetrics;
    std::string aiVectMetrics = taskConf->aicoreMetrics;
    ConfigManager::instance()->GetVersionSpecificMetrics(aiCoreMetrics);
    Platform::instance()->GetAicoreEvents(aiCoreMetrics, params->ai_core_profiling_events);
    Platform::instance()->GetAicoreEvents(aiVectMetrics, params->aiv_profiling_events);
    if (!params->ai_core_profiling_events.empty()) {
        params->ai_core_profiling = "on";
        params->ai_core_metrics = aiCoreMetrics;
        params->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
        params->aiv_profiling = "on";
        params->aiv_metrics = aiVectMetrics;
        params->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
        params->ai_core_lpm = "on";
    } else {
        MSPROF_LOGW("Invalid aicore metrics, aicore data will not be collected");
        params->ai_core_profiling = "off";
        params->aiv_profiling = "off";
        params->ai_core_lpm = "off";
    }
    if (!Platform::instance()->CheckIfSupport(PLATFORM_TASK_AICORE_LPM)) {
        params->ai_core_lpm = "off";
    }
    return PROFILING_SUCCESS;
}

int32_t ProfParamsAdapter::HandleSystemTraceConf(const std::string &conf,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    const int32_t cfgBufferMaxLen = 1024 * 1024;  // 1024 *1024 means 1mb
    if (params == nullptr || conf.size() > cfgBufferMaxLen) {  // job context size bigger than 1mb
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<ProfApiSysConf> sysConf = DecodeSysConfJson(conf);
    UpdateSysConf(sysConf, params);
    return PROFILING_SUCCESS;
}

void ProfParamsAdapter::UpdateSysConf(SHARED_PTR_ALIA<ProfApiSysConf> sysConf,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (sysConf == nullptr || params == nullptr) {
        return;
    }
    if (sysConf->cpuSamplingInterval > 0) {
        params->cpu_profiling = "on";
        params->cpu_sampling_interval = sysConf->cpuSamplingInterval;
        params->ai_ctrl_cpu_profiling_events = "0x11,0x8";
        params->ts_cpu_profiling_events = "0x11,0x8";
    }
    if (sysConf->sysSamplingInterval > 0) {
        params->sys_profiling = "on";
        params->sys_sampling_interval = sysConf->sysSamplingInterval;
    }
    if (sysConf->appSamplingInterval > 0) {
        params->pid_profiling = "on";
        params->pid_sampling_interval = sysConf->appSamplingInterval;
    }
    if (sysConf->hardwareMemSamplingInterval > 0) {
        params->hardware_mem = "on";
        params->hardware_mem_sampling_interval = sysConf->hardwareMemSamplingInterval;
        params->ddr_profiling_events = "read,write";
        params->hbm_profiling_events = "read,write";
    }
    if (sysConf->ioSamplingInterval > 0) {
        params->io_profiling = "on";
        params->io_sampling_interval = sysConf->ioSamplingInterval;
    }
    if (sysConf->interconnectionSamplingInterval > 0) {
        params->interconnection_profiling = "on";
        params->interconnection_sampling_interval = sysConf->interconnectionSamplingInterval;
    }
    if (sysConf->dvppSamplingInterval > 0) {
        params->dvpp_profiling = "on";
        params->dvpp_sampling_interval = sysConf->dvppSamplingInterval;
    }
    if (sysConf->aicoreSamplingInterval > 0 && !sysConf->aicoreMetrics.empty()) {
        params->ai_core_profiling = "on";
        params->aicore_sampling_interval = sysConf->aicoreSamplingInterval;
        params->ai_core_metrics = sysConf->aicoreMetrics;
        params->aiv_profiling = "on";
        params->aiv_sampling_interval = sysConf->aivSamplingInterval;
        params->aiv_metrics = sysConf->aivMetrics;
    }
}

void ProfParamsAdapter::SetSystemTraceParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> dstParams,
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> srcParams) const
{
    if (dstParams == nullptr || srcParams == nullptr) {
        MSPROF_LOGE("params check failed, is nullptr!");
        return;
    }
    MSPROF_LOGI("SetSystemTraceParams, profiling_options: %s", srcParams->profiling_options.c_str());
    UpdateCpuProfiling(dstParams, srcParams);
    if (dstParams->io_profiling.compare("on") == 0) {
        dstParams->nicProfiling = "on";
        dstParams->nicInterval = dstParams->io_sampling_interval;
        dstParams->roceProfiling = "on";
        dstParams->roceInterval = dstParams->io_sampling_interval;
        dstParams->ubProfiling = "on";
        dstParams->ubInterval = dstParams->io_sampling_interval;
    }
    if (dstParams->interconnection_profiling.compare("on") == 0) {
        dstParams->pcieProfiling = "on";
        dstParams->pcieInterval = dstParams->interconnection_sampling_interval;
        dstParams->hccsProfiling = "on";
        dstParams->hccsInterval = dstParams->interconnection_sampling_interval;
        dstParams->ubProfiling = "on";
        dstParams->ubInterval = dstParams->interconnection_sampling_interval;
    }
    dstParams->msprof = srcParams->msprof;
    dstParams->app = srcParams->app;
    UpdateHardwareMemParams(dstParams, srcParams);
    MSPROF_LOGI("SetSystemTraceParams, print updated dstParams");
    // check if job cancel and clear repeat print of host device 64
    if (!dstParams->isCancel && dstParams->job_id != PROF_HOST_JOBID) {
        dstParams->PrintAllFields();
    }
}

void ProfParamsAdapter::UpdateCpuProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> dstParams,
                                           SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> srcParams) const
{
    if (dstParams == nullptr || srcParams == nullptr) {
        return;
    }
    if (dstParams->cpu_profiling.compare("on") == 0) {
        dstParams->tsCpuProfiling = "on";
        dstParams->ts_cpu_profiling_events = srcParams->ts_cpu_profiling_events;
        dstParams->aiCtrlCpuProfiling = "on";
        dstParams->ai_ctrl_cpu_profiling_events = srcParams->ai_ctrl_cpu_profiling_events;
        if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_AICPU_HSCB)) {
            dstParams->hscb = "on";
        }
    }
}

std::string ProfParamsAdapter::GenerateCapacityEvents()
{
    const int32_t maxLlcEvents = 8; // llc events list size
    std::vector<std::string> llcProfilingEvents;
    for (int32_t i = 0; i < maxLlcEvents; i++) {
        std::string tempEvents;
        tempEvents.append("hisi_l3c0_1/dsid");
        tempEvents.append(std::to_string(i));
        tempEvents.append("/");
        llcProfilingEvents.push_back(tempEvents);
    }
    UtilsStringBuilder<std::string> builder;
    return builder.Join(llcProfilingEvents, ",");
}

std::string ProfParamsAdapter::GenerateBandwidthEvents()
{
    MSPROF_LOGI("Begin to GenerateBandwidthEvents");
    std::vector<std::string> llcProfilingEvents;
    llcProfilingEvents.push_back("hisi_l3c0_1/read_allocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/read_hit/");
    llcProfilingEvents.push_back("hisi_l3c0_1/read_noallocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_allocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_hit/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_noallocate/");

    UtilsStringBuilder<std::string> builder;
    return builder.Join(llcProfilingEvents, ",");
}

void ProfParamsAdapter::UpdateOpFeature(SHARED_PTR_ALIA<ProfApiStartReq> feature,
                                        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    using namespace analysis::dvvp::common::validation;
    std::string aiCoreMetrics = feature->aiCoreEvents;
    std::string aiVectMetrics = feature->aiCoreEvents;
    ConfigManager::instance()->GetVersionSpecificMetrics(aiCoreMetrics);
    Platform::instance()->GetAicoreEvents(aiCoreMetrics, params->ai_core_profiling_events);
    Platform::instance()->GetAicoreEvents(aiVectMetrics, params->aiv_profiling_events);
    MSPROF_LOGI("op_trace profiling ai_core_events: %s , feature ai_core_events: %s",
        params->ai_core_profiling_events.c_str(), feature->aiCoreEvents.c_str());
    const std::string l2CacheEvents = feature->l2CacheEvents;
    if (ParamValidation::instance()->CheckEventsSize(params->ai_core_profiling_events) != PROFILING_SUCCESS ||
        ParamValidation::instance()->CheckEventsSize(l2CacheEvents) != PROFILING_SUCCESS) {
        return;
    }
    if (!params->ai_core_profiling_events.empty()) {
        params->ai_core_profiling = "on";
        params->ai_core_profiling_mode = "task-based";
        params->aiv_profiling = "on";
        params->aiv_profiling_mode = "task-based";
    }
    if (!l2CacheEvents.empty()) {
        params->l2CacheTaskProfilingEvents = l2CacheEvents;
        params->l2CacheTaskProfiling = "on";
    }

    MSPROF_LOGI("start op_trace job.ai_core_events: %s , l2_cache_events: %s",
                params->ai_core_profiling_events.c_str(),
                params->l2CacheTaskProfilingEvents.c_str());
}

std::string ProfParamsAdapter::EncodeSysConfJson(SHARED_PTR_ALIA<ProfApiSysConf> sysConf) const
{
    std::string out = "";
    if (sysConf == nullptr) {
        return out;
    }

    NanoJson::Json sysConfObject;
    sysConfObject["aicoreSamplingInterval"] = sysConf->aicoreSamplingInterval;
    sysConfObject["cpuSamplingInterval"] = sysConf->cpuSamplingInterval;
    sysConfObject["sysSamplingInterval"] = sysConf->sysSamplingInterval;
    sysConfObject["appSamplingInterval"] = sysConf->appSamplingInterval;
    sysConfObject["hardwareMemSamplingInterval"] = sysConf->hardwareMemSamplingInterval;
    sysConfObject["ioSamplingInterval"] = sysConf->ioSamplingInterval;
    sysConfObject["interconnectionSamplingInterval"] = sysConf->interconnectionSamplingInterval;
    sysConfObject["dvppSamplingInterval"] = sysConf->dvppSamplingInterval;
    sysConfObject["aivSamplingInterval"] = sysConf->aivSamplingInterval;
    sysConfObject["aicoreMetrics"] = sysConf->aicoreMetrics;
    sysConfObject["aivMetrics"] = sysConf->aivMetrics;
    sysConfObject["l2"] = sysConf->l2;
    out = sysConfObject.ToString();
    return out;
}

SHARED_PTR_ALIA<ProfApiSysConf> ProfParamsAdapter::DecodeSysConfJson(std::string confStr) const
{
    if (confStr.empty()) {
        return nullptr;
    }

    SHARED_PTR_ALIA<ProfApiSysConf> sysConf = nullptr;
    MSVP_MAKE_SHARED0(sysConf, ProfApiSysConf, return nullptr);

    NanoJson::Json jsonCfg;
    try {
        jsonCfg.Parse(confStr);
    } catch (std::runtime_error& e) {
        MSPROF_LOGE("Failed to parse SysConf configs. Error reason: %s", e.what());
        return nullptr;
    }

    sysConf->aicoreSamplingInterval = jsonCfg["aicoreSamplingInterval"].GetValue<uint32_t>();
    sysConf->cpuSamplingInterval = jsonCfg["cpuSamplingInterval"].GetValue<uint32_t>();
    sysConf->sysSamplingInterval = jsonCfg["sysSamplingInterval"].GetValue<uint32_t>();
    sysConf->appSamplingInterval = jsonCfg["appSamplingInterval"].GetValue<uint32_t>();
    sysConf->hardwareMemSamplingInterval = jsonCfg["hardwareMemSamplingInterval"].GetValue<uint32_t>();
    sysConf->ioSamplingInterval = jsonCfg["ioSamplingInterval"].GetValue<uint32_t>();
    sysConf->interconnectionSamplingInterval = jsonCfg["interconnectionSamplingInterval"].GetValue<uint32_t>();
    sysConf->dvppSamplingInterval = jsonCfg["dvppSamplingInterval"].GetValue<uint32_t>();
    sysConf->aivSamplingInterval = jsonCfg["aivSamplingInterval"].GetValue<uint32_t>();
    sysConf->aicoreMetrics = jsonCfg["aicoreMetrics"].GetValue<std::string>();
    sysConf->aivMetrics = jsonCfg["aivMetrics"].GetValue<std::string>();
    sysConf->l2 = jsonCfg["l2"].GetValue<std::string>();

    return sysConf;
}

bool ProfParamsAdapter::CheckSetDeviceEnableIsValid(const std::string &config)
{
    if (config.compare(MSVP_PROF_ON) == 0) {
        aclApiSetDeviceEnable_ = true;
        MSPROF_LOGI("Profiling enable device notify capabiligy on acl api mode.");
        return true;
    } else if (config.compare(MSVP_PROF_OFF) == 0) {
        aclApiSetDeviceEnable_ = false;
        MSPROF_LOGI("Profiling disable device notify capability on acl api mode.");
        return true;
    }

    MSPROF_LOGE("Argument ACL_PROF_SETDEVICE_ENABLE invalid value:%s. Please input [on|off] if you want"
        "to enable or disable device notify capability.", config.c_str());
    return false;
}

bool ProfParamsAdapter::CheckAclApiSetDeviceEnable() const
{
   return aclApiSetDeviceEnable_;
}
}   // Adaptor
}   // Host
}   // Dvvp
}   // Analysis
