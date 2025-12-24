/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "platform_interface.h"
#include <algorithm>
#include "msprof_dlog.h"
#include "validation/param_validation.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::config;

std::map<PlatformTypeEnum, std::function<std::shared_ptr<PlatformInterface>()>> PlatformReflection::platformMap_;
std::string PlatformInterface::GetDeviceOscDefaultFreq()
{
    return EMPTY_FREQUENCY;
}

std::string PlatformInterface::GetAicDefaultFreq()
{
    return EMPTY_FREQUENCY;
}

std::string PlatformInterface::GetAivDefaultFreq()
{
    return EMPTY_FREQUENCY;
}

int32_t PlatformInterface::GetAiPmuMetrics(const std::string &key, std::string &vaule)
{
    if (key.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) == 0) {
        std::string aicoreEvent = key.substr(CUSTOM_METRICS.length());
        std::transform(aicoreEvent.begin(), aicoreEvent.end(), aicoreEvent.begin(), ::tolower);
        int32_t sw = ParamValidation::instance()->CustomHexCharConfig(aicoreEvent, ",");
        if (sw == PROFILING_FAILED) {
            MSPROF_LOGE("The aic_metrics[%s] of input config is invalid", key.c_str());
            return PROFILING_FAILED;
        }
        vaule = aicoreEvent;
        return PROFILING_SUCCESS;
    }

    const PlatformFeature feature = PmuMetricsToFeature(key);
    if (!FeatureIsSupport(feature)) {
        return PROFILING_FAILED;
    }

    vaule = GetMetricsValue(feature);
    return PROFILING_SUCCESS;
}

std::string PlatformInterface::GetMetricsValue(const PlatformFeature feature)
{
    std::map<PlatformFeature, MetricsFunc> metrics = {
        {PLATFORM_TASK_AU_PMU,            &PlatformInterface::GetArithmeticUtilizationMetrics},
        {PLATFORM_TASK_PU_PMU,            &PlatformInterface::GetPipeUtilizationMetrics},
        {PLATFORM_TASK_PUEXCT_PMU,        &PlatformInterface::GetPipeUtilizationExctMetrics},
        {PLATFORM_TASK_PEU_PMU,           &PlatformInterface::GetPipelineExecuteUtilizationMetrics},
        {PLATFORM_TASK_PSC_PMU,           &PlatformInterface::GetPipeStallCycleMetrics},
        {PLATFORM_TASK_RCR_PMU,           &PlatformInterface::GetResourceConflictRatioMetrics},
        {PLATFORM_TASK_MEMORY_PMU,        &PlatformInterface::GetMemoryMetrics},
        {PLATFORM_TASK_MEMORYL0_PMU,      &PlatformInterface::GetMemoryL0Metrics},
        {PLATFORM_TASK_MEMORYUB_PMU,      &PlatformInterface::GetMemoryUBMetrics},
        {PLATFORM_TASK_L2_CACHE_PMU,      &PlatformInterface::GetL2CacheMetrics},
        {PLATFORM_TASK_SCALAR_RATIO_PMU,  &PlatformInterface::GetScalarMetrics},
        {PLATFORM_TASK_MEMORY_ACCESS_PMU, &PlatformInterface::GetMemoryAccessMetrics}
    };

    auto it = metrics.find(feature);
    if (it != metrics.end()) {
        return (this->*(it->second))();
    }

    MSPROF_LOGE("Failed to find [%d] metrics function", feature);
    return EMPTY_FREQUENCY;
}

std::string PlatformInterface::GetSmmuEventStr()
{
    return INTERFACE_SMMU_EVENT;
};

std::string PlatformInterface::GetL2CacheEvents()
{
    return INTERFACE_L2CACHEEVENT;
};

std::string PlatformInterface::GetArithmeticUtilizationMetrics()
{
    return INTERFACE_AIRTHMETICUTILIZATION;
};

std::string PlatformInterface::GetPipeUtilizationMetrics()
{
    return INTERFACE_PIPEUTILIZATION;
};

std::string PlatformInterface::GetPipeUtilizationExctMetrics()
{
    return INTERFACE_PIPEUTILIZATIONEXCT;
}

std::string PlatformInterface::GetPipelineExecuteUtilizationMetrics()
{
    return INTERFACE_PIPELINEEXECUTEUTILIZATION;
};

std::string PlatformInterface::GetPipeStallCycleMetrics()
{
    return INTERFACE_PIPELINEEXECUTEUTILIZATION;
};

std::string PlatformInterface::GetResourceConflictRatioMetrics()
{
    return INTERFACE_RESOURCECONFLICTRATIO;
};

std::string PlatformInterface::GetMemoryMetrics()
{
    return INTERFACE_MEMORY;
}

std::string PlatformInterface::GetMemoryL0Metrics()
{
    return INTERFACE_MEMORYL0;
}

std::string PlatformInterface::GetMemoryUBMetrics()
{
    return INTERFACE_MEMORYUB;
}

std::string PlatformInterface::GetL2CacheMetrics()
{
    return INTERFACE_L2CACHE;
}

std::string PlatformInterface::GetScalarMetrics()
{
    return EMPTY_FREQUENCY;
}

std::string PlatformInterface::GetMemoryAccessMetrics()
{
    return INTERFACE_MEMORYACCESS;
}

PlatformFeature PlatformInterface::PmuMetricsToFeature(const std::string &key) const
{
    const auto it = METRIC_FEATURE_MAP.find(key);
    if (it != METRIC_FEATURE_MAP.cend()) {
        return it->second;
    }

    return PlatformFeature::PLATFORM_FEATURE_INVALID;
}

bool PlatformInterface::FeatureIsSupport(const PlatformFeature feature) const
{
    return (supportedFeature_.count(feature) > 0);
}

uint16_t PlatformInterface::GetMaxMonitorNumber() const
{
    return MAX_COLLECT_MONITOR_NUM;
}

uint16_t PlatformInterface::GetQosMonitorNumber() const
{
    return MAX_COLLECT_MONITOR_NUM;
}

int32_t PlatformInterface::InitOnlineAnalyzer()
{
    MSVP_MAKE_SHARED0(analyzer_, BaseAnalyzer, return PROFILING_FAILED);
    return PROFILING_SUCCESS;
}

uint32_t PlatformInterface::GetMetricsPmuNum(const std::string &name) const
{
    if (analyzer_ == nullptr) {
        return 0;
    }
    return analyzer_->GetMetricsPmuNum(name);
}

std::string PlatformInterface::GetMetricsTopName(const std::string &name) const
{
    if (analyzer_ == nullptr) {
        return "";
    }
    return analyzer_->GetMetricsTopName(name);
}

PmuCalculationAttr* PlatformInterface::GetMetricsFunc(const std::string &name, uint32_t index) const
{
    if (analyzer_ == nullptr) {
        return nullptr;
    }
    return analyzer_->GetMetricsFunc(name, index);
}

float PlatformInterface::GetTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum) const
{
    if (analyzer_ == nullptr) {
        return 0;
    }
    return analyzer_->GetTotalTime(cycle, freq, blockDim, coreNum);
}

void PlatformInterface::SetSubscribeFeature()
{
    std::vector<PlatformFeature> unsupportFeature = {
        PLATFORM_DIAGNOSTIC_COLLECTION
    };
    for (const PlatformFeature feature : unsupportFeature) {
        supportedFeature_.erase(feature);
    }
    supportedFeature_.insert(PLATFORM_AOE_SUPPORT_FUNC);
}
}
}
}
