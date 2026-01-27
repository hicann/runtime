/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_COLLECT_PLATFORM_DAVID_ANALYZER_H
#define DVVP_COLLECT_PLATFORM_DAVID_ANALYZER_H
#include "base_analyzer.h"
#include "pmu_calculator.h"

namespace Dvvp {
namespace Collect {
namespace Platform {

static const uint32_t MAX_DAVID_PMU_NUM = 10;
class DavidAnalyzer : public BaseAnalyzer {
public:
    DavidAnalyzer()
    {
        BaseAnalyzer::maxPmuNum_ = MAX_DAVID_PMU_NUM;
        AdaptDavidPmuMap();
        AdaptDavidPmuFuncMap();
    }
    ~DavidAnalyzer() {}

private:
    void AdaptDavidPmuMap() const
    {
        BaseAnalyzer::aicPmuMap_["PipeUtilization"] = { "0x501", "0x301", "0x1",  "0x701", "0x202",
                                                        "0x203", "0x34",  "0x35", "0x714" };
        BaseAnalyzer::aicPmuMap_["Memory"] = { "0x400", "0x401", "0x56f", "0x571", "0x570", "0x572", "0x707", "0x709" };
        BaseAnalyzer::aicPmuMap_["MemoryL0"] = { "0x304", "0x703", "0x306", "0x705", "0x712", "0x30a", "0x308" };
        BaseAnalyzer::aicPmuMap_["MemoryUB"] = { "0x3", "0x5", "0x70c", "0x206", "0x204", "0x571", "0x572" };
        BaseAnalyzer::aicPmuMap_["ArithmeticUtilization"] = { "0x323", "0x324" };
        BaseAnalyzer::aicPmuMap_["ResourceConflictRatio"] = { "0x540", "0x556", "0x502", "0x528" };
        BaseAnalyzer::aicPmuMap_["L2Cache"] = { "0x424", "0x425", "0x426", "0x42a", "0x42b", "0x42c" };
    }
    void AdaptDavidPmuFuncMap()
    {
        AdaptDavidPipeFuncMap();
        AdaptDavidMemFuncMap();
        AdaptDavidMemL0FuncMap();
        AdaptDavidMemUBFuncMap();
        AdaptDavidArithFuncMap();
        AdaptDavidResFuncMap();
        AdaptDavidL2CacheFuncMap();
    }
    void AdaptDavidPipeFuncMap()
    {
        // PipeUtilization
        BaseAnalyzer::pmuFuncMap_["0x501"] = { "vec_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x301"] = { "mac_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x1"] = { "scalar_ratio",
                                             &pmuCalculator_->CalculateWithoutFreq,
                                             PmuCalculationType::WITHOUT_FREQ,
                                             { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x701"] = { "mte1_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x202"] = { "mte2_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x203"] = { "mte3_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x34"] = { "icache_req_ratio",
                                              &pmuCalculator_->CalculateWithoutFreq,
                                              PmuCalculationType::WITHOUT_FREQ,
                                              { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x35"] = { "icache_miss_rate",
                                              &pmuCalculator_->CalculateWithoutFreq,
                                              PmuCalculationType::WITHOUT_FREQ,
                                              { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x714"] = { "fixpipe_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
    }
    void AdaptDavidMemFuncMap()
    {
        BaseAnalyzer::pmuFuncMap_["0x400"] = { "main_mem_read_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_THREE, SCALAR_EIGHT } };
        BaseAnalyzer::pmuFuncMap_["0x401"] = { "main_mem_write_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_THREE, SCALAR_EIGHT } };
        BaseAnalyzer::pmuFuncMap_["0x56f"] = { "ub_read_bw_ext(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_FOUR } };
        BaseAnalyzer::pmuFuncMap_["0x571"] = { "ub_read_bw_vec(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_FOUR } };
        BaseAnalyzer::pmuFuncMap_["0x570"] = { "ub_write_bw_ext(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_FOUR } };
        BaseAnalyzer::pmuFuncMap_["0x572"] = { "ub_write_bw_vec(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_FOUR } };
        BaseAnalyzer::pmuFuncMap_["0x707"] = { "l1_read_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_SIXTEEN } };
        BaseAnalyzer::pmuFuncMap_["0x709"] = { "l1_write_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
    }
    void AdaptDavidMemL0FuncMap()
    {
        BaseAnalyzer::pmuFuncMap_["0x304"] = { "l0a_read_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_SIXTEEN } };
        BaseAnalyzer::pmuFuncMap_["0x703"] = { "l0a_write_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_SIXTEEN } };
        BaseAnalyzer::pmuFuncMap_["0x306"] = { "l0b_read_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
        BaseAnalyzer::pmuFuncMap_["0x705"] = { "l0b_write_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
        BaseAnalyzer::pmuFuncMap_["0x712"] = { "l0c_read_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
        BaseAnalyzer::pmuFuncMap_["0x30a"] = { "l0c_read_bw_cube(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
        BaseAnalyzer::pmuFuncMap_["0x308"] = { "l0c_write_bw_cube(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
    }
    void AdaptDavidMemUBFuncMap()
    {
        BaseAnalyzer::pmuFuncMap_["0x3"] = { "ub_read_bw_scalar(GB/s)",
                                             &pmuCalculator_->CalculateWithFreq,
                                             PmuCalculationType::WITH_FREQ,
                                             { PIPE_TWO_SEVEN, SCALAR_ONE } };
        BaseAnalyzer::pmuFuncMap_["0x5"] = { "ub_write_bw_scalar(GB/s)",
                                             &pmuCalculator_->CalculateWithFreq,
                                             PmuCalculationType::WITH_FREQ,
                                             { PIPE_TWO_SEVEN, SCALAR_ONE } };
        BaseAnalyzer::pmuFuncMap_["0x206"] = { "ub_write_bw_mte(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_SEVEN, SCALAR_ONE } };
        BaseAnalyzer::pmuFuncMap_["0x204"] = { "ub_read_bw_mte(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_SEVEN, SCALAR_ONE } };
        BaseAnalyzer::pmuFuncMap_["0x571"] = { "ub_read_bw_vector(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_SEVEN, SCALAR_TWO } };
        BaseAnalyzer::pmuFuncMap_["0x572"] = { "ub_write_bw_vector(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_SEVEN, SCALAR_TWO } };
        BaseAnalyzer::pmuFuncMap_["0x70c"] = { "fixp2ub_write_bw(GB/s)",
                                               &pmuCalculator_->CalculateWithFreq,
                                               PmuCalculationType::WITH_FREQ,
                                               { PIPE_TWO_EIGHT, SCALAR_EIGHT } };
    }
    void AdaptDavidArithFuncMap()
    {
        BaseAnalyzer::pmuFuncMap_["0x323"] = { "mac_fp16_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x324"] = { "mac_int8_ratio",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
    }
    void AdaptDavidResFuncMap()
    {
        BaseAnalyzer::pmuFuncMap_["0x556"] = { "stu_pmu_wctl_ub_cflt",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x540"] = { "ldu_pmu_ib_ub_cflt",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x502"] = { "pmu_idc_aic_vec_instr_vf_busy_o",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x528"] = { "idu_pmu_ins_iss_cnt",
                                               &pmuCalculator_->CalculateWithoutFreq,
                                               PmuCalculationType::WITHOUT_FREQ,
                                               { FLOAT_BIT, FLOAT_BIT } };
    }
    void AdaptDavidL2CacheFuncMap()
    {
        BaseAnalyzer::pmuFuncMap_["0x424"] = { "bif_sc_pmu_ar_close_l2_hit_core",
                                                &pmuCalculator_->CalculateSelf,
                                                PmuCalculationType::WITH_ITSELF,
                                                { FLOAT_BIT, FLOAT_BIT }};
        BaseAnalyzer::pmuFuncMap_["0x425"] = { "bif_sc_pmu_ar_close_l2_miss_core",
                                               &pmuCalculator_->CalculateSelf,
                                               PmuCalculationType::WITH_ITSELF,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x426"] = { "bif_sc_pmu_ar_close_l2_victim_core",
                                               &pmuCalculator_->CalculateSelf,
                                               PmuCalculationType::WITH_ITSELF,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x42a"] = { "bif_sc_pmu_aw_close_l2_hit_core",
                                               &pmuCalculator_->CalculateSelf,
                                               PmuCalculationType::WITH_ITSELF,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x42b"] = { "bif_sc_pmu_aw_close_l2_miss_core",
                                               &pmuCalculator_->CalculateSelf,
                                               PmuCalculationType::WITH_ITSELF,
                                               { FLOAT_BIT, FLOAT_BIT } };
        BaseAnalyzer::pmuFuncMap_["0x42c"] = { "bif_sc_pmu_aw_close_l2_victim_core",
                                               &pmuCalculator_->CalculateSelf,
                                               PmuCalculationType::WITH_ITSELF,
                                               { FLOAT_BIT, FLOAT_BIT } };
    }
};
}  // namespace Platform
}  // namespace Collect
}  // namespace Dvvp
#endif