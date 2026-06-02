/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_STATS_ANALYZER_H
#define ANALYSIS_DVVP_ANALYZE_STATS_ANALYZER_H

#include <map>
#include "data_struct.h"
#include "utils/utils.h"
#include "stats_analyzer_api.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
class StatsAnalyzer {
public:
    explicit StatsAnalyzer(const std::string &path);
    ~StatsAnalyzer();

public:
    void OnApiData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);

private:
    void DispatchApiData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void FlushApiData();
    std::string CreateStatsFile(const std::string &name);
    void WriteTotalTimeTitle(std::ofstream& file);
    void WriteStatisticsTitle(std::ofstream& file);
    void WriteTotalTimeData(std::ofstream& file);
    void WriteStatisticsData(std::ofstream& file);

private:
    bool inited_;
    std::string storePath_;
    SHARED_PTR_ALIA<StatsAnalyzerApi> statsAnalyzerApi_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
