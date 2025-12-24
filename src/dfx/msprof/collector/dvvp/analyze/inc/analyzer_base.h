/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_ANALYZE_ANALYZER_BASE_H
#define ANALYSIS_DVVP_ANALYZE_ANALYZER_BASE_H

#include "utils/utils.h"
#include "data_struct.h"
#include "op_desc_parser.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
class AnalyzerBase {
public:
    AnalyzerBase() : dataPtr_(nullptr), dataLen_(0), analyzedBytes_(0), totalBytes_(0), pmuNum_(0), frequency_(1.0)
    {
        pmuNum_ = Analysis::Dvvp::Common::Platform::Platform::instance()->GetMaxMonitorNumber();
    }
    ~AnalyzerBase()
    {}

protected:
    /**
     * @brief append new data to buffer (if buffer not empty)
     * @param data ptr to data
     * @param len length of data
     */
    void AppendToBufferedData(CONST_CHAR_PTR data, uint32_t len);

    /**
     * @brief copy remaining data to buffer, or clear buffer if offset > buffer.size
     * @param offset offset of remaining data ptr
     */
    void BufferRemainingData(uint32_t offset);

    /**
     * @brief initialize frequency, op's time = (syscnt / frequency)
     */
    int32_t InitFrequency();

    void EraseRtMapByStreamId(uint16_t streamId, std::map<std::string, RtOpInfo> &rtOpInfo) const;
    void HandleDeviceData(const std::string &key, RtOpInfo &devData, uint32_t &time) const;
    void HandleUploadData(const std::string &key, const RtOpInfo &devData) const;
    void ConstructAndUploadOptimizeData(GeOpFlagInfo &opFlagData, const RtOpInfo &rtTsOpdata) const;
    uint32_t GetGraphModelId(uint32_t modelId) const;
    void SetGraphModelId(uint32_t modelId, uint32_t graphId) const;
    bool IsExtPmu() const;
    CONST_CHAR_PTR dataPtr_;
    uint32_t dataLen_;

    std::string buffer_;

    uint64_t analyzedBytes_;
    uint64_t totalBytes_;
    uint32_t pmuNum_;
    double frequency_;

    static bool isFftsPlus_;
    static bool opTypeFlag_;
    static std::map<std::string, RtOpInfo> rtOpInfo_;
    static std::map<std::string, RtOpInfo> tsOpInfo_;
    static std::multimap<std::string, RtOpInfo> tsTmpOpInfo_;
    static std::multimap<uint32_t, GeOpFlagInfo> geContextInfo_;
    static std::multimap<uint32_t, GeOpFlagInfo> geNodeInfo_;
    static std::multimap<uint32_t, GeOpFlagInfo> geApiInfo_;
    static std::multimap<uint32_t, GeOpFlagInfo> geModelInfo_;
    static std::multimap<uint32_t, GeOpFlagInfo> geOpInfo_;
    static std::map<uint32_t, uint32_t> graphIdMap_;    // <modeId, graphId>
    static std::vector<ProfOpDesc> opDescInfos_;
    static std::vector<RtOpInfo> devTmpOpInfo_;
    static std::mutex opDescInfoMtx_;
    static std::mutex graphIdMtx_;
    static std::mutex rtThreadMtx_;
    static std::mutex geThreadMtx_;
    static std::mutex tsThreadMtx_;
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
