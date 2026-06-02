/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_STATS_ANALYZER_API_H
#define ANALYSIS_DVVP_ANALYZE_STATS_ANALYZER_API_H

#include <map>
#include <set>
#include "utils/utils.h"
#include "prof_common.h"
#include "data_struct.h"
#include "prof_api.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;

struct ApiStatsInfo {
    uint32_t type; // 0: api; 1: event
    uint32_t tag;
    uint32_t hashName;
    uint64_t modelId;
    uint64_t beginTime;
    uint64_t endTime;
};

struct ApiTotalTime {
    uint64_t lastBegin;
    uint64_t lastEnd;
    uint64_t totalTime;
};

struct ApiStatistics {
    uint64_t apiMaxTime;
    uint64_t apiMinTime;
    uint64_t apiTime;
    uint32_t apiCount;
    uint32_t apiTag;
};

enum AclApiTag {
    ACL_OP = 1,
    ACL_MODEL = 2,
    ACL_RTS = 3,
    ACL_OTHERS = 4,
    ACL_NN = 5,
    ACL_ASCENDC = 6,
    ACL_HCCL = 7,
    ACL_DVPP = 8,
    ACL_GRAPH = 10,
    ACL_ATB = 11,
    ACL_MAX
};

class StatsAnalyzerApi {
public:
    StatsAnalyzerApi() : dataPtr_(nullptr), dataLen_(0), totalApiTimes_(0), totalEventTimes_(0), hostFreq_(1),
        statsMap_({})  {}
    ~StatsAnalyzerApi() {}

public:
    bool IsApiOrEventData(const std::string &fileName) const;
    void Parse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void GenerateTotalTimeData(std::ofstream& file);
    void GenerateStatisticsData(std::ofstream& file);
    void WriteTotalTimeData(std::ofstream& file, const std::map<uint32_t, ApiTotalTime> &apiTimeMap);
    void WriteStatisticsData(std::ofstream& file,
        const std::map<uint32_t, std::map<uint32_t, ApiStatistics>> &apiStatsMap);
    void InitFrequency();
    void ClearAllData();

private:
    void HandleAppendingData(CONST_CHAR_PTR data, uint32_t len);
    void HandleRemainingData(uint32_t offset);
    void PrintStats();
    void ParseApiAndEventInfo(CONST_CHAR_PTR data, uint32_t len);
    void HandleEventInfo(CONST_CHAR_PTR data);
    void HandleApiInfo(CONST_CHAR_PTR data);
    void InitApiShieldingConfig();
    bool LoadApiShieldingConfig(std::string &content) const;
    void ParseApiShieldingConfig(const std::string &content);
    bool ShouldSkipTotalTimeApi(const std::string &apiName) const;
    std::string NormalizeApiName(const std::string &apiName) const;
    bool IsValidStatsRecord(const ApiStatsInfo &info) const;
    float GetSafeHostFreq() const;

private:
    CONST_CHAR_PTR dataPtr_;
    uint32_t dataLen_;
    uint32_t totalApiTimes_;
    uint32_t totalEventTimes_;
    float hostFreq_;
    std::map<uint32_t, std::map<uint64_t, ApiStatsInfo>> statsMap_;
    std::string analyzerBuf_;
    std::set<std::string> shieldingApiNames_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
