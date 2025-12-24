/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_TS_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_TS_H

#include <map>
#include <unordered_map>
#include "analyzer_base.h"
#include "utils/utils.h"
#include "data_struct.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
class Analyzer;
class AnalyzerTs : public AnalyzerBase {
    friend class Analyzer;

public:
    AnalyzerTs() : opTimeCount_(0), totalTsMerges_(0)
    {}
    ~AnalyzerTs()
    {}

public:
    bool IsTsData(const std::string &fileName);
    void Parse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);

private:
    void ParseTsTrackData(CONST_CHAR_PTR data, uint32_t len);
    void ParseTsTimelineData(CONST_CHAR_PTR data, uint32_t len);
    void ParseTsKeypointData(CONST_CHAR_PTR data, uint32_t len);
    uint8_t GetRptType(CONST_CHAR_PTR data, uint32_t len);

    void PrintStats();

private:
    uint64_t opTimeCount_;
    uint32_t totalTsMerges_;
    std::map<std::string, OpTime> opTimeDrafts_;  // stores incomplete data
    std::multimap<std::string, OpTime> opTimes_;  // key is taskId-streamId-contextId
    std::unordered_map<std::string, KeypointOp> keypointOpInfo_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
