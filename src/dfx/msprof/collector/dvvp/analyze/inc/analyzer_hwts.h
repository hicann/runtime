/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_HWTS_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_HWTS_H

#include <map>

#include "analyzer_base.h"
#include "data_struct.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
class Analyzer;
class AnalyzerHwts : public AnalyzerBase {
    friend class Analyzer;

public:
    AnalyzerHwts() : opTimeCount_(0), opRepeatCount_(0), totalHwtsTimes_(0), totalHwtsMerges_(0) {}
    ~AnalyzerHwts() {}

public:
    bool IsHwtsData(const std::string &fileName);
    void HwtsParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);

private:
    void ParseOptimizeHwtsData(CONST_CHAR_PTR data, uint32_t len);
    uint8_t GetRptType(CONST_CHAR_PTR data, uint32_t len);
    void PrintStats();
    void HandleOptimizeStartEndData(CONST_CHAR_PTR data, uint8_t rptType);

private:
    uint64_t opTimeCount_;
    uint64_t opRepeatCount_;
    std::map<std::string, OpTime> opTimeDrafts_;  // stores incomplete data
    std::multimap<std::string, OpTime> opTimes_;  // key is taskId-streamId-contextId
    uint32_t totalHwtsTimes_;
    uint32_t totalHwtsMerges_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
