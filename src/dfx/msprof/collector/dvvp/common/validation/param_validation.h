/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_PARAM_VALIDATION_H
#define ANALYSIS_DVVP_COMMON_PARAM_VALIDATION_H

#include <string>
#include "message/prof_params.h"
#include "singleton/singleton.h"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "osal.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace validation {
enum class ProfSocPmuType {
    PMU_TYPE_MATA = 0,
    PMU_TYPE_HA = 1,
    PMU_TYPE_SMMU = 2,
    PMU_TYPE_NOC = 3,
    PMU_TYPE_HA_NO_HEAD = 4,
    PMU_TYPE_UNKNOWN
};

enum class ProfScaleType {
    SCALE_OP_TYPE = 0,
    SCALE_OP_NAME = 1,
    SCALE_TYPE_UNKNOWN
};

class ParamValidation : public analysis::dvvp::common::singleton::Singleton<ParamValidation> {
public:
    ParamValidation();
    ~ParamValidation() override;

    int32_t Init() const;
    int32_t Uninit() const;
    bool CheckProfilingParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    bool CheckParamsDevices(const std::string &app, const std::string &paramsDevices,
        const std::string &paramsHostSys);
    bool CheckParamsJobIdRegexMatch(const std::string &paramsJobId);
    bool CheckParamsModeRegexMatch(const std::string &paramsMode);
    bool CheckLlcEventsIsValid(const std::string &events);
    bool CheckProfilingSwitchIsValid(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    bool CheckAiCoreEventsIsValid(const std::vector<std::string> &events) const;
    bool CheckAiCoreEventCoresIsValid(const std::vector<int32_t> &coreId) const;
    bool CheckDdrEventsIsValid(const std::vector<std::string> &events) const;
    bool CheckHbmEventsIsValid(const std::vector<std::string> &events) const;
    bool CheckAivEventsIsValid(const std::vector<std::string> &events) const;
    bool CheckAivEventCoresIsValid(const std::vector<int32_t> &coreId) const;
    bool CheckAppNameIsValid(const std::string &appName);
    bool CheckDataTagIsValid(const std::string &tag) const;
    bool CheckTsCpuEventIsValid(const std::vector<std::string> &events) const;
    bool CheckCtrlCpuEventIsValid(const std::vector<std::string> &events) const;
    bool CheckPmuEventSizeIsValid(const size_t eventSize) const;
    bool CheckCoreIdSizeIsValid(const int32_t eventSize) const;
    bool CheckDeviceIdIsValid(const std::string &devId);
    bool CheckAicoreMetricsIsValid(const std::string &aicoreMetrics) const;
    int32_t CheckEventsSize(const std::string &events) const;
    bool CheckHexOrDec(std::string &events, const size_t mode) const;
    int32_t CustomHexCharConfig(std::string &aicoreEvents, const std::string &pattern) const;
    bool IsValidSleepPeriod(const int32_t period) const;
    bool CheckHostSysOptionsIsValid(const std::string &hostSysOptions);
    bool CheckHostSysPidIsValid(const int32_t hostSysPid) const;
    bool CheckHostSysUsageOptionsIsValid(const std::string &hostSysUsageOptions) const;
    bool ProfStarsAcsqParamIsValid(const std::string &param);
    bool IsValidSwitch(const std::string &switchStr);
    bool CheckParamL0L1Invalid(const std::string &switchName, const std::string &switchStr);
    bool CheckParamEmptyInvalid(const std::string &switchName, const std::string &switchStr) const;
    bool CheckStorageLimit(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    bool CheckInstrProfilingFreqValid(const uint32_t instrFreq) const;
    bool CheckArgRange(const std::string &switchName, const std::string &value, uint32_t min, uint32_t max) const;
    bool CheckLlcConfigValid(const std::string &config) const;
    bool CheckFreqIsValid(const std::string &switchName, uint32_t freq) const;
    bool CheckMemServiceflowValid(const std::string &switchName, const std::string &config) const;
    bool CheckDuplicateSocPmu(const std::string &oriStr) const;
    bool CheckDuplicateScale(const std::string &oriStr) const;
    ProfSocPmuType GetSocPmuInfo(std::string &socPmuStr, std::string &eventStr) const;
    ProfScaleType GetScaleInfo(std::string &scaleStr, std::string &scaleInfoStr) const;
    bool CheckSocPmuEventsValid(ProfSocPmuType type, const std::vector<std::string> &events) const;
    bool CheckSocPmuEventsSizeValid(ProfSocPmuType type, uint32_t eventSize, int32_t &maxEvent) const;
    bool CheckScaleIsValid(const std::string &scaleInput, std::string &scaleType, std::string &scaleName,
        std::string &errInfo) const;
    bool CheckTaskBlockValid(const std::string &switchName, const std::string &config) const;

private:
    bool CheckControlSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    bool CheckTsSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    bool CheckPmuSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    bool IsValidInterval(const int32_t interval, const std::string &logKey) const;
    bool CheckProfilingIntervalIsValid(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    bool CheckProfilingIntervalIsValidTWO(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    bool CheckSystemTraceSwitchProfiling(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
};
}
}
}
}
#endif

