/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_ACP_ANALYZE_PMU_CALCULATOR_H
#define DVVP_ACP_ANALYZE_PMU_CALCULATOR_H

#include <cmath>
#include "utils/utils.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
using namespace analysis::dvvp::common::utils;

static const float FLOAT_BIT = 1.0;
static const float PIPE_TWO_THREE = 8.0;
static const float PIPE_TWO_SEVEN = 128.0;
static const float PIPE_TWO_EIGHT = 256.0;
static const float SCALAR_ONE = 1.0;
static const float SCALAR_TWO = 2.0;
static const float SCALAR_FOUR = 4.0;
static const float SCALAR_EIGHT = 8.0;
static const float SCALAR_SIXTEEN = 16.0;
static const float FREQ_CONVERT = 8589934592.0; // 8*2^30
static const float MHZ_CONVERT_HZ = 1000000.0;

struct CalculateAttr {
    float pipe;
    float scalar;
};

using CalculatePmuFunc = float (*)(const CalculateAttr &attr, uint64_t pmu, uint64_t cycle, double freq);
class PmuCalculator {
public:
    PmuCalculator() {}
    ~PmuCalculator() {}
    // calculate with freq: mhz
    static float CalculateTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum)
    {
        if (freq <= 0 || blockDim == 0 || coreNum <= 0) {
            return 0;
        }
        const int64_t coreRate = (blockDim + coreNum - 1) / coreNum;
        return static_cast<float>(FLOAT_BIT * cycle / freq / blockDim * coreRate);
    }
    // calculate with freq: mhz
    static float CalculateWithFreq(const CalculateAttr &attr, uint64_t pmu, uint64_t cycle, double freq)
    {
        if (cycle <= 0 || freq <= 0) {
            return 0;
        }
        return (FLOAT_BIT * attr.pipe * attr.scalar * pmu * MHZ_CONVERT_HZ) / (cycle / freq) / FREQ_CONVERT;
    }
    static float CalculateWithoutFreq(const CalculateAttr &attr, uint64_t pmu, uint64_t cycle,
        double freq)
    {
        UNUSED(attr);
        UNUSED(freq);
        if (cycle <= 0) {
            return 0;
        }
        return (FLOAT_BIT * pmu) / cycle;
    }
    static float CalculateSelf(const CalculateAttr &attr, uint64_t pmu, uint64_t cycle,
        double freq)
    {
        UNUSED(attr);
        UNUSED(freq);
        UNUSED(cycle);
        return (FLOAT_BIT * pmu);
    }
};
}
}
}

#endif
