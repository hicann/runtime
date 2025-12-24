/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "base_analyzer.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
using namespace analysis::dvvp::common::utils;
uint32_t BaseAnalyzer::maxPmuNum_;
std::unordered_map<std::string, PmuCalculationAttr> BaseAnalyzer::pmuFuncMap_;
std::unordered_map<std::string, std::vector<std::string>> BaseAnalyzer::aicPmuMap_;
std::unordered_map<std::string, std::vector<std::string>> BaseAnalyzer::aivPmuMap_;

static const uint32_t MAX_PMU_NUM = 8;
const std::string CUSTOM_METRICS = "Custom:";

void BaseAnalyzer::Init()
{
    MSVP_MAKE_SHARED0(pmuCalculator_, PmuCalculator, return);
    maxPmuNum_ = MAX_PMU_NUM;
    pmuFuncMap_ = {};
    aivPmuMap_ = {};
    aicPmuMap_ = {
        {"ArithmeticUtilization", {"0x49", "0x4a", "0x4b", "0x4c", "0x4d", "0x4e", "0x4f"}},
        {"PipeUtilization", {"0x8", "0xa", "0x9", "0xb", "0xc", "0xd", "0x54", "0x55"}},
        {"ResourceConflictRatio", {"0x64", "0x65", "0x66"}},
        {"Memory", {"0x15", "0x16", "0x31", "0x32", "0xf", "0x10", "0x12", "0x13"}},
        {"MemoryL0", {"0x1b", "0x1c", "0x21", "0x22", "0x27", "0x28", "0x29", "0x2a"}},
        {"MemoryUB", {"0x10", "0x13", "0x37", "0x38", "0x3d", "0x3e", "0x43", "0x44"}},
        {"L2Cache", {"0x500", "0x502", "0x504", "0x506", "0x508", "0x50a"}},
        {"MemoryAccess", {"0x32", "0x3d", "0x3e", "0x206", "0x20c", "0x50c", "0x50d", "0x50e"}}
    };
    InitFuncMapWithoutFreqOne();
    InitFuncMapWithoutFreqTwo();
    InitFuncMapWithFreqOne();
    InitFuncMapWithFreqTwo();
    InitFuncMapWithItself();
}

void BaseAnalyzer::UnInit() const
{
    maxPmuNum_ = 0;
    pmuFuncMap_.clear();
    aicPmuMap_.clear();
    aivPmuMap_.clear();
}

void BaseAnalyzer::InitFuncMapWithoutFreqOne()
{
    pmuFuncMap_.insert({
        {"0x8", {"vec_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0xa", {"mac_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x9", {"scalar_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0xb", {"mte1_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0xc", {"mte2_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0xd", {"mte3_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x3a", {"scalar_ld_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x3b", {"scalar_st_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x49", {"mac_fp16_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x4a", {"mac_int8_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x4b", {"vec_fp32_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x4c", {"vec_fp16_128lane_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x4d", {"vec_fp16_64lane_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x4e", {"vec_int32_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x4f", {"vec_misc_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
    });
}

void BaseAnalyzer::InitFuncMapWithoutFreqTwo()
{
    pmuFuncMap_.insert({
        {"0x54", {"icache_req_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x55", {"icache_miss_rate", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x57", {"scalar_waitflag_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x58", {"cube_waitflag_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x59", {"vector_waitflag_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x5a", {"mte1_waitflag_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x5b", {"mte2_waitflag_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x5c", {"mte3_waitflag_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x64", {"vec_bankgroup_cflt_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x65", {"vec_bank_cflt_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x66", {"vec_resc_cflt_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x6b", {"mte1_iq_full_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x6c", {"mte2_iq_full_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x6d", {"mte3_iq_full_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x6e", {"cube_iq_full_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x6f", {"vec_iq_full_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x12c", {"vec_exe_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x302", {"mte1_ratio_extra", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x303", {"fixpipe_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x416", {"mac_fp_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x417", {"mac_int_ratio", &pmuCalculator_->CalculateWithoutFreq, PmuCalculationType::WITHOUT_FREQ,
            {FLOAT_BIT, FLOAT_BIT}}},
    });
}

void BaseAnalyzer::InitFuncMapWithFreqOne()
{
    pmuFuncMap_.insert({
        {"0xf", {"l2_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x10", {"l2_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x12", {"main_mem_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_THREE, SCALAR_EIGHT}}},
        {"0x13", {"main_mem_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_THREE, SCALAR_EIGHT}}},
        {"0x15", {"ub_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_FOUR}}},
        {"0x16", {"ub_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_FOUR}}},
        {"0x1b", {"l0a_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_SIXTEEN}}},
        {"0x1c", {"l0a_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_SIXTEEN}}},
        {"0x21", {"l0b_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x22", {"l0b_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x27", {"l0c_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x28", {"l0c_read_bw_cube(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x29", {"l0c_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x2a", {"l0c_write_bw_cube(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
    });
}

void BaseAnalyzer::InitFuncMapWithFreqTwo()
{
    pmuFuncMap_.insert({
        {"0x31", {"l1_read_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_SIXTEEN}}},
        {"0x32", {"l1_write_bw(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_EIGHT, SCALAR_EIGHT}}},
        {"0x37", {"ub_read_bw_scalar(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_ONE}}},
        {"0x38", {"ub_write_bw_scalar(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_ONE}}},
        {"0x3d", {"ub_read_bw_mte(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_ONE}}},
        {"0x3e", {"ub_write_bw_mte(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_ONE}}},
        {"0x43", {"ub_read_bw_vector(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_TWO}}},
        {"0x44", {"ub_write_bw_vector(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_TWO}}},
        {"0x17f", {"ub_read_bw_vector(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_TWO}}},
        {"0x180", {"ub_read_bw_vector(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_TWO}}},
        {"0x191", {"ub_write_bw_vector(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_TWO}}},
        {"0x1a5", {"ub_read_bw_mte(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_ONE}}},
        {"0x1a6", {"ub_write_bw_mte(GB/s)", &pmuCalculator_->CalculateWithFreq, PmuCalculationType::WITH_FREQ,
            {PIPE_TWO_SEVEN, SCALAR_ONE}}},
    });
}

void BaseAnalyzer::InitFuncMapWithItself()
{
    pmuFuncMap_.insert({
        {"0x500", {"write_cache_hit", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x502", {"write_cache_miss_allocate", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x504", {"r0_read_cache_hit", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x506", {"r0_read_cache_miss_allocate", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x508", {"r1_read_cache_hit", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"0x50a", {"r1_read_cache_miss_allocate", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
        {"Custom:", {"Custom:", &pmuCalculator_->CalculateSelf, PmuCalculationType::WITH_ITSELF,
            {FLOAT_BIT, FLOAT_BIT}}},
    });
}

uint32_t BaseAnalyzer::GetMetricsPmuNum(const std::string &name) const
{
    if (aicPmuMap_.empty()) {
        return 0;
    }

    if (name.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) == 0) {
        uint32_t count = 0;
        for (auto x : name) {
            if (x == ',') {
                count++;
            }
        }
        return count + 1;
    }

    auto citer = aicPmuMap_.find(name);
    if (citer == aicPmuMap_.end()) {
        return 0;
    }

    return aicPmuMap_[name].size();
}

std::string BaseAnalyzer::GetMetricsTopName(const std::string &name) const
{
    if (aicPmuMap_.empty()) {
        return "";
    }
    // get aic and aiv event vector
    bool customType = false;
    std::vector<std::string> aicEventVec = {};
    std::vector<std::string> aivEventVec = {};
    if (name.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) == 0) {
        std::string eventStr = name.substr(CUSTOM_METRICS.length());
        aicEventVec = Utils::Split(eventStr, false, "", ",");
        aivEventVec = aicEventVec;
        customType = true;
    } else {
        auto citer = aicPmuMap_.find(name);
        if (citer == aicPmuMap_.end()) {
            MSPROF_LOGE("Failed to find metrics name for %s", name.c_str());
            return "";
        }
        auto viter = aivPmuMap_.find(name);
        if (viter == aivPmuMap_.end()) { // aic equal to aiv
            viter = aicPmuMap_.find(name);
        }
        aicEventVec = citer->second;
        aivEventVec = viter->second;
    }
    // cat aic top name
    std::string res = "";
    std::string tmp = "";
    for (auto &item : aicEventVec) {
        tmp = (customType) ? item : GetMetricsPmuName(item);
        if (tmp.empty()) {
            MSPROF_LOGE("Failed to find pmu name for %s", item.c_str());
            return "";
        }
        res += ",aic_" + tmp;
    }
    // cat aiv top name
    for (auto &item : aivEventVec) {
        tmp = (customType) ? item : GetMetricsPmuName(item);
        if (tmp.empty()) {
            MSPROF_LOGE("Failed to find pmu name for %s", item.c_str());
            return "";
        }
        res += ",aiv_" + tmp;
    }
    MSPROF_LOGI("Get metrics top name: %s.", res.c_str());
    return res;
}

std::string BaseAnalyzer::GetMetricsPmuName(const std::string &name) const
{
    auto iter = pmuFuncMap_.find(name);
    if (iter == pmuFuncMap_.end()) {
        return "";
    }
    return iter->second.pmuName;
}

PmuCalculationAttr* BaseAnalyzer::GetMetricsFunc(const std::string &name, uint32_t index) const
{
    if (name.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) == 0) {
        auto funcIter = pmuFuncMap_.find(CUSTOM_METRICS);
        if (funcIter == pmuFuncMap_.end()) {
            MSPROF_LOGE("Failed to find custom func for %s", name.c_str());
            return nullptr;
        }
        return &funcIter->second;
    }

    if (aicPmuMap_.empty()) {
        return nullptr;
    }

    if (index < maxPmuNum_) {
        return GetAicMetricsFunc(name, index);
    } else {
        return GetAivMetricsFunc(name, index);
    }
}

PmuCalculationAttr* BaseAnalyzer::GetAicMetricsFunc(const std::string &name, uint32_t index) const
{
    // find pmu
    auto iter = aicPmuMap_.find(name);
    if (iter == aicPmuMap_.end()) {
        MSPROF_LOGE("Failed to find metrics pmu for %s", name.c_str());
        return nullptr;
    }
    // filter useless index
    if (index > iter->second.size() - 1) {
        return nullptr;
    }
    // find function
    auto funcIter = pmuFuncMap_.find(iter->second[index]);
    if (funcIter == pmuFuncMap_.end()) {
        MSPROF_LOGE("Failed to find metrics func for %s", iter->second[index].c_str());
        return nullptr;
    }

    return &funcIter->second;
}

PmuCalculationAttr* BaseAnalyzer::GetAivMetricsFunc(const std::string &name, uint32_t index) const
{
    uint32_t order = index;
    order -= maxPmuNum_;
    // find pmu
    auto iter = aivPmuMap_.find(name);
    if (iter == aivPmuMap_.end()) {
        return GetAicMetricsFunc(name, order);
    }
    // filter useless index
    if (order > iter->second.size() - 1) {
        return nullptr;
    }
    // find function
    auto funcIter = pmuFuncMap_.find(iter->second[order]);
    if (funcIter == pmuFuncMap_.end()) {
        MSPROF_LOGE("Failed to find metrics func for %s", iter->second[order].c_str());
        return nullptr;
    }

    return &funcIter->second;
}

float BaseAnalyzer::GetTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum)
{
    if (pmuCalculator_ == nullptr) {
        return 0;
    }

    return pmuCalculator_->CalculateTotalTime(cycle, freq, blockDim, coreNum);
}
}
}
}