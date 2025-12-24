/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_H

#include <map>

#include "data_struct.h"
#include "utils/utils.h"
#include "analyzer_base.h"
namespace analysis {
namespace dvvp {
namespace transport {
class Uploader;
}
}  // namespace dvvp
}  // namespace analysis
namespace Analysis {
namespace Dvvp {
namespace Analyze {
class AnalyzerGe;
class AnalyzerHwts;
class AnalyzerTs;
class AnalyzerRt;
class AnalyzerFfts;
using namespace analysis::dvvp::common::utils;
class Analyzer : public AnalyzerBase {
public:
    explicit Analyzer(SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> uploader);
    ~Analyzer();

public:
    void OnOptimizeData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void Flush();
    void SetDevId(const std::string &devIdStr);
    void SetGraphType(bool flag);
    void SetOpType(bool flag) const;
    void PrintDeviceStats();
    void PrintHostStats();

private:
    void DispatchOptimizeData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void ConstructAndUploadData(const std::string &opId, OpTime &opTime);
    void TsDataPostProc();
    void UploadAppOp(std::multimap<std::string, OpTime> &opTimes);
    void UploadAppOpModeStepTrace(std::multimap<std::string, OpTime> &opTimes);
    void UploadAppOpModeStaticShape(std::multimap<std::string, OpTime> &opTimes);
    void UploadAppOpModeSingleOp(std::multimap<std::string, OpTime> &opTimes);
    void UploadKeypointOp();
    bool IsNeedUpdateIndexId();
    void UpdateOpIndexId(std::multimap<std::string, OpTime> &opTimes);
    void UpdateHwtsLatestOpIndexId();
    uint64_t GetOpIndexId(uint64_t opTimeStamp);
    void UploadProfOpDescProc();

private:
    bool inited_;
    std::string devIdStr_;
    uint64_t resultCount_;
    uint32_t profileMode_;
    bool flushedChannel_;
    int64_t flushQueueLen_;
    bool graphTypeFlag_;
    SHARED_PTR_ALIA<AnalyzerGe> analyzerGe_;
    SHARED_PTR_ALIA<AnalyzerHwts> analyzerHwts_;
    SHARED_PTR_ALIA<AnalyzerTs> analyzerTs_;
    SHARED_PTR_ALIA<AnalyzerRt> analyzerRt_;
    SHARED_PTR_ALIA<AnalyzerFfts> analyzerFfts_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> uploader_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
