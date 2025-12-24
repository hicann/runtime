/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_GE_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_GE_H

#include <map>

#include "analyzer_base.h"
#include "utils/utils.h"
#include "prof_common.h"
#include "data_struct.h"
#include "prof_api.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
class Analyzer;
class AnalyzerGe : public AnalyzerBase {
    friend class Analyzer;

public:
    AnalyzerGe() : isAllStaticShape_(true), totalEventTimes_(0), totalApiTimes_(0), totalNodeTimes_(0),
        totalGeMerges_(0) {}
    ~AnalyzerGe() {}

public:
    bool IsGeData(const std::string &fileName);
    bool IsGeApiOrEventData(const std::string &fileName) const;
    bool IsGeCompactData(const std::string &tag) const;
    bool IsGeContextData(const std::string &tag) const;
    bool IsGeGraphIdMapData(const std::string &tag) const;
    bool GetStreamType(const int32_t &streamId, int32_t &streamType) const;
    void Parse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void GeCompactParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void GeApiAndEventParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void GeContextParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void GeGraphIdMapParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    bool IsOpInfoCompleted(const std::string &opId);
    uint32_t GetModelId(const std::string &opId) const;
    uint32_t GetModelId(uint32_t modelId) const;
    std::string GetOpName(const std::string &opId);
    std::string GetOpType(const std::string &opId);
    bool GetIsAllStaticShape() const;

private:
    struct GeOpInfo {
        std::string opId;  // taskId-streamId-contextId-iterId
        std::string opName;
        std::string opType;
        uint32_t modelId;
    };

private:
    void ParseIdMap(CONST_CHAR_PTR data, uint32_t len);
    void ParseTaskDesc(CONST_CHAR_PTR data, uint32_t len);
    int32_t ParseOpData(CONST_CHAR_PTR data);
    void ParseOpName(const MsprofGeProfTaskData &data, struct GeOpInfo &opInfo) const;
    void ParseOpType(const MsprofGeProfTaskData &data, struct GeOpInfo &opInfo) const;
    void PrintStats();

    void ParseContextIdInfo(CONST_CHAR_PTR data, uint32_t len);
    void HandleContextIdInfo(CONST_CHAR_PTR data) const;
    bool HandleContextWithNode(std::multimap<uint32_t, GeOpFlagInfo> &nodeInfo,
        std::multimap<uint32_t, GeOpFlagInfo> &contextInfo) const;
    void ParseNodeBasicInfo(CONST_CHAR_PTR data, uint32_t len, bool ageFlag);
    void HandleNodeBasicInfo(CONST_CHAR_PTR data, bool ageFlag) const;
    void ParseGraphIdMap(CONST_CHAR_PTR data, uint32_t len);
    void HandleModelInfo(CONST_CHAR_PTR data, bool ageFlag) const;
    void ParseApiAndEventInfo(CONST_CHAR_PTR data, uint32_t len, bool ageFlag);
    void HandleApiInfo(CONST_CHAR_PTR data, bool ageFlag) const;
    void MatchApiInfo(std::multimap<uint32_t, GeOpFlagInfo> &apiInfo,
        std::multimap<uint32_t, GeOpFlagInfo> &modelInfo,
        std::multimap<uint32_t, GeOpFlagInfo> &nodeInfo,
        std::multimap<uint32_t, GeOpFlagInfo> &contextInfo);
    void MatchModelInfo(std::multimap<uint32_t, GeOpFlagInfo> &modelInfo, uint32_t threadId,
        GeOpFlagInfo &apiInfo) const;
    void MatchNodeInfo(std::multimap<uint32_t, GeOpFlagInfo> &nodeInfo, uint32_t threadId,
        GeOpFlagInfo &apiInfo) const;
    void MatchDeviceOpInfo(std::vector<RtOpInfo> &devTmpOpInfo,
        std::multimap<uint32_t, GeOpFlagInfo> &geOpInfo) const;

private:
    std::map<std::string, GeOpInfo> opInfos_;    // <taskId-streamId, GeOpInfo>
    std::map<uint32_t, StreamInfo> steamState_;  // <streamid, StreamInfo>
    bool isAllStaticShape_;
    uint32_t totalEventTimes_;
    uint32_t totalApiTimes_;
    uint32_t totalNodeTimes_;
    uint32_t totalGeMerges_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
