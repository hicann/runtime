/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_HOST_PARAMS_ADAPTER_H
#define ANALYSIS_DVVP_HOST_PARAMS_ADAPTER_H

#include <map>
#include <memory>
#include "singleton/singleton.h"
#include "message/prof_params.h"
#include "utils/utils.h"
#include "acl/acl_prof.h"

namespace Analysis {
namespace Dvvp {
namespace Host {
namespace Adapter {

struct ProfApiSysConf {
    uint32_t aicoreSamplingInterval;
    uint32_t cpuSamplingInterval;
    uint32_t sysSamplingInterval;
    uint32_t appSamplingInterval;
    uint32_t hardwareMemSamplingInterval;
    uint32_t ioSamplingInterval;
    uint32_t interconnectionSamplingInterval;
    uint32_t dvppSamplingInterval;
    uint32_t aivSamplingInterval;
    std::string aicoreMetrics;
    std::string aivMetrics;
    std::string l2;
};

struct ProfApiStartReq {
    std::string jobId; // trace id produced by libmsprof
    std::string tsFwTraining;
    std::string taskBase;
    std::string hwtsLog;
    std::string tsTimeline;
    std::string tsTaskTrack;
    std::string dockerId;
    std::string jobInfo; // job id send by GE
    std::string featureName;
    std::string aiCoreEvents;
    std::string l2CacheEvents;
    std::string traceId;
    std::string resultPath;
    std::string opTraceConf;
    std::string systemTraceConf;
    std::string taskTraceConf;
};

class ProfParamsAdapter : public analysis::dvvp::common::singleton::Singleton<ProfParamsAdapter> {
public:
    ProfParamsAdapter();
    ~ProfParamsAdapter() override;

    int32_t Init() const;
    int32_t StartReqTrfToInnerParam(SHARED_PTR_ALIA<ProfApiStartReq> feature,
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t CheckDataTypeSupport(const uint64_t dataTypeConfig) const;
    void StartCfgTrfToInnerParam(const uint64_t dataTypeConfig,
        SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t CheckApiConfigSupport(aclprofConfigType type) const;
    int32_t CheckApiConfigIsValid(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                                  aclprofConfigType type, const std::string &config);
    int32_t CheckApiConfigIsValidTwo(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                                     aclprofConfigType type, const std::string &config);
    int32_t CheckApiConfigIsValidThree(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                                     aclprofConfigType type, const std::string &config);
    bool CheckHostSysValid(const std::string &config) const;
    bool CheckHostSysUsageValid(const std::string &config) const;
    bool CheckJsonConfig(const std::string &switchName, const NanoJson::JsonValue &val) const;
    int32_t HandleJsonConf(const NanoJson::Json &jsonCfg,
                           SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t HandleSystemTraceConf(const std::string &conf,
                              SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t HandleTaskTraceConf(const std::string &conf,
                            SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    void SetSystemTraceParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> dstParams,
                              SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> srcParams) const;
    void GenerateLlcEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    std::string EncodeSysConfJson(SHARED_PTR_ALIA<ProfApiSysConf> sysConf) const;
    SHARED_PTR_ALIA<ProfApiSysConf> DecodeSysConfJson(std::string confStr) const;
    bool CheckAclApiSetDeviceEnable() const;
    bool CheckSetDeviceEnableIsValid(const std::string &config);

private:
    void UpdateHardwareMemParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> dstParams,
                                 SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> srcParams) const;
    void UpdateSysConf(SHARED_PTR_ALIA<ProfApiSysConf> sysConf,
                       SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    void UpdateCpuProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> dstParams,
                            SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> srcParams) const;
    std::string GenerateCapacityEvents();
    std::string GenerateBandwidthEvents();
    void GenerateLlcDefEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);

    void UpdateOpFeature(SHARED_PTR_ALIA<ProfApiStartReq> feature,
                         SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t CheckLlcConfigValid(const std::string &config) const;
    void SetHostSysParam(const std::string &config,
                         SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    void SetHostSysUsageParam(const std::string &config,
                              SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;

private:
    bool aclApiSetDeviceEnable_;
    std::map<std::string, std::string> aicoreEvents_;
};
}
}
}
}

#endif
