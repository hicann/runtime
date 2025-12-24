/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_RT_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_RT_H

#include <map>
#include "analyzer_base.h"
#include "utils/utils.h"
#include "data_struct.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
class Analyzer;
class AnalyzerRt : public AnalyzerBase {
    friend class Analyzer;

public:
    AnalyzerRt() : totalRtTimes_(0), totalRtMerges_(0) {}
    ~AnalyzerRt() {}

public:
    bool IsRtCompactData(const std::string &tag) const;

private:
    void ParseRuntimeTrackData(CONST_CHAR_PTR data, uint32_t len, bool ageFlag);
    void HandleRuntimeTrackData(CONST_CHAR_PTR data, bool ageFlag) const;
    void RtCompactParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void PrintStats() const;
    void MatchDeviceOpInfo(std::map<std::string, RtOpInfo> &rtOpInfo,
        std::multimap<std::string, RtOpInfo> &tsTmpOpInfo,
        std::multimap<uint32_t, GeOpFlagInfo> &geOpInfo) const;

private:
    uint32_t totalRtTimes_;
    uint32_t totalRtMerges_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
