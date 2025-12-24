/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_COLLECT_PLATFORM_BASE_ANALYZER_H
#define DVVP_COLLECT_PLATFORM_BASE_ANALYZER_H
#include <vector>
#include <unordered_map>
#include "pmu_calculator.h"

namespace Dvvp {
namespace Collect {
namespace Platform {

enum class PmuCalculationType {
    WITH_FREQ,
    WITHOUT_FREQ,
    WITH_ITSELF
};

struct PmuCalculationAttr {
    std::string pmuName;
    CalculatePmuFunc fomula;
    PmuCalculationType type;
    CalculateAttr attr;
};

class BaseAnalyzer {
public:
    BaseAnalyzer()
    {
        UnInit();
        Init();
    }
    ~BaseAnalyzer() {}
    uint32_t GetMetricsPmuNum(const std::string &name) const;
    std::string GetMetricsTopName(const std::string &name) const;
    PmuCalculationAttr* GetMetricsFunc(const std::string &name, uint32_t index) const;
    float GetTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum);

protected:
    static uint32_t maxPmuNum_;
    static std::unordered_map<std::string, PmuCalculationAttr> pmuFuncMap_;
    static std::unordered_map<std::string, std::vector<std::string>> aicPmuMap_;
    static std::unordered_map<std::string, std::vector<std::string>> aivPmuMap_;
    SHARED_PTR_ALIA<PmuCalculator> pmuCalculator_;
    PmuCalculationAttr customAttr_;

private:
    void Init();
    void UnInit() const;
    void InitFuncMapWithoutFreqOne();
    void InitFuncMapWithoutFreqTwo();
    void InitFuncMapWithFreqOne();
    void InitFuncMapWithFreqTwo();
    void InitFuncMapWithItself();
    std::string GetMetricsPmuName(const std::string &name) const;
    PmuCalculationAttr* GetAicMetricsFunc(const std::string &name, uint32_t index) const;
    PmuCalculationAttr* GetAivMetricsFunc(const std::string &name, uint32_t index) const;
};
}
}
}
#endif