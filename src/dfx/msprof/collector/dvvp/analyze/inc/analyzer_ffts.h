/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_FFTS_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_FFTS_H

#include <map>

#include "analyzer_base.h"
#include "data_struct.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
class Analyzer;
class AnalyzerFfts : public AnalyzerBase {
    friend class Analyzer;

public:
    AnalyzerFfts() : opTimeCount_(0), opRepeatCount_(0), totalFftsTimes_(0), totalFftsMerges_(0) {}
    ~AnalyzerFfts() {}

public:
    bool IsFftsData(const std::string &fileName) const;
    void FftsParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);

private:
    void PrintStats() const;
    void ParseOptimizeFftsData(CONST_CHAR_PTR data, uint32_t len);
    template<typename T>
    void HandleOptimizeAcsqTaskData(const T *acsqLog, uint32_t logType);
    void HandleOptimizeSubTaskThreadData(const StarsCxtLog *cxtLog, uint32_t logType);
    void StarsRollBackStreamTaskId(uint16_t *streamId, uint16_t *taskId) const;

private:
    uint64_t opTimeCount_;
    uint64_t opRepeatCount_;
    std::map<std::string, OpTime> opDrafts_;      // stores incomplete data
    std::multimap<std::string, OpTime> opTimes_;  // key is taskId-streamId-contextId
    uint32_t totalFftsTimes_;
    uint32_t totalFftsMerges_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
