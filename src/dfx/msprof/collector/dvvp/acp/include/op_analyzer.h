/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_OP_ANALYZER_H
#define ANALYSIS_DVVP_ANALYZE_OP_ANALYZER_H

#include <map>
#include <vector>
#include <mutex>
#include <condition_variable>
#include <fstream>
#include <iostream>
#include <iomanip>
#include "data_struct.h"
#include "utils/utils.h"
#include "op_analyzer_pmu.h"
#include "op_analyzer_base.h"
#include "op_analyzer_pc_sampling.h"
#include "op_analyzer_biu.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
class OpAnalyzer : public OpAnalyzerBase {
public:
    explicit OpAnalyzer();
    ~OpAnalyzer();

public:
    void InitAnalyzerByDeviceId(const std::string &deviceId);
    void OnOpData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void PrintStats();
    void WaitOpDone();

private:
    void DispatchOpData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void FlushOpData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    std::string CreateOpFile(const std::string &path, const std::string &name) const;
    void WriteOpTitle(std::ofstream& file) const;
    void WriteOpData(std::ofstream& file);
    void WriteOpBaseData(std::ofstream& file, std::vector<std::vector<KernelDetail>> &dataVec);
    void HandleOpTotalTime(KernelDetail &data, float &aicTotalTimeAvg, float &aivTotalTimeAvg) const;
    void WriteOpPmuData(std::ofstream& file, std::vector<std::vector<KernelDetail>> &dataVec);
    void HandleOpPmuData(const std::string &name, KernelDetail &data, float* avg, uint32_t avgLen) const;
    void OpAssociation(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void PreAssociation(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void BlockAssociation();
    void BlockInfoMatch(std::string key, KernelDetail &value);
    void SubTaskAssociation();
    void SubTaskInfoMatch(KernelDetail &value);
    void StoreAssociation() const;
    float CeilPrecision(float value) const;
    void WriteFloatDataToFile(std::ofstream& file, float &data);

private:
    bool inited_;
    uint32_t metricsPmuNum_;
    int64_t aicCoreNum_;
    int64_t aivCoreNum_;
    double aicFreq_;
    uint16_t highBlockDim_;
    uint16_t lowBlockDim_;
    uint32_t replayTime_;
    std::mutex flushMtx_;
    std::condition_variable flushCv_;
    SHARED_PTR_ALIA<OpAnalyzerPmu> analyzerPmu_;
    SHARED_PTR_ALIA<OpAnalyzerBiu> analyzerBiu_;
    OpAnalyzerPcSampling pcSampling_;
};
}
}
}

#endif
