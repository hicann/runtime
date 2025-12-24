/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer_base.h"
#include "analyzer.h"
#include "config_manager.h"
#include "transport/hash_data.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
bool AnalyzerBase::isFftsPlus_ = false;
bool AnalyzerBase::opTypeFlag_ = false;
std::map<std::string, RtOpInfo> AnalyzerBase::rtOpInfo_;
std::map<std::string, RtOpInfo> AnalyzerBase::tsOpInfo_;
std::multimap<std::string, RtOpInfo> AnalyzerBase::tsTmpOpInfo_;
std::multimap<uint32_t, GeOpFlagInfo> AnalyzerBase::geContextInfo_;
std::multimap<uint32_t, GeOpFlagInfo> AnalyzerBase::geNodeInfo_;
std::multimap<uint32_t, GeOpFlagInfo> AnalyzerBase::geApiInfo_;
std::multimap<uint32_t, GeOpFlagInfo> AnalyzerBase::geModelInfo_;
std::multimap<uint32_t, GeOpFlagInfo> AnalyzerBase::geOpInfo_;
std::map<uint32_t, uint32_t> AnalyzerBase::graphIdMap_;
std::vector<ProfOpDesc> AnalyzerBase::opDescInfos_;
std::vector<RtOpInfo> AnalyzerBase::devTmpOpInfo_;
std::mutex AnalyzerBase::opDescInfoMtx_;
std::mutex AnalyzerBase::graphIdMtx_;
std::mutex AnalyzerBase::rtThreadMtx_;
std::mutex AnalyzerBase::geThreadMtx_;
std::mutex AnalyzerBase::tsThreadMtx_;

constexpr uint32_t CLOUD_V3_PMU_NUM = 10;

void AnalyzerBase::AppendToBufferedData(CONST_CHAR_PTR data, uint32_t len)
{
    if (buffer_.empty()) {
        // no buffered data, use data directorly
        dataPtr_ = data;
        dataLen_ = len;
    } else {
        // append, then update ptr and length
        (void)buffer_.append(data, len);
        dataPtr_ = buffer_.c_str();
        if (buffer_.size() > UINT_MAX) {
            dataLen_ = 0;
            dataPtr_ = nullptr;
            MSPROF_LOGE("size out of UINT_MAX");
            return;
        } else {
            dataLen_ = static_cast<uint32_t>(buffer_.size());
        }
    }
}

void AnalyzerBase::BufferRemainingData(uint32_t offset)
{
    if (offset < dataLen_) {
        buffer_ = std::string(dataPtr_ + offset, dataLen_ - offset);
    } else {
        // no data to buffer
        if (!buffer_.empty()) {
            buffer_.clear();
        }
    }
}

int32_t AnalyzerBase::InitFrequency()
{
    std::string freq = Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetFrequency();
    frequency_ = std::stod(freq) / 1000;  // 1000: mhz to ghz, syscnt * (1 / ghz) = ns
    if (frequency_ <= 0) {
        MSPROF_LOGE("init freqency failed. freq %s mhz, frequency_ %f ghz", freq.c_str(), frequency_);
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGD("InitFrequency success. frequency: %f ghz", frequency_);
        return PROFILING_SUCCESS;
    }
}

void AnalyzerBase::EraseRtMapByStreamId(uint16_t streamId, std::map<std::string, RtOpInfo> &rtOpInfo) const
{
    for (auto iter = rtOpInfo.begin(); iter != rtOpInfo.end();) {
        const auto pos = iter->first.find(KEY_SEPARATOR);
        int32_t iterStreamIdInt = 0;
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToInt32(iterStreamIdInt, iter->first.substr(pos + 1)), continue, 
            "iterStreamId %s is invalid", iter->first.substr(pos + 1).c_str());
        FUNRET_CHECK_EXPR_ACTION(
                iterStreamIdInt > std::numeric_limits<uint16_t>::max() ||
                iterStreamIdInt < std::numeric_limits<uint16_t>::min(),
                continue, "iterStreamId %d is out of range", iterStreamIdInt
            )
        if (static_cast<uint16_t>(iterStreamIdInt) != streamId) {
            iter++;
            continue;
        }
        rtOpInfo.erase(iter++);
    }
}

void AnalyzerBase::HandleDeviceData(const std::string &key, RtOpInfo &devData, uint32_t &time) const
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::rtThreadMtx_);
    if (devData.start >= devData.end) {
        MSPROF_LOGD("Device start end error, start: %" PRIu64 "ns, end: %" PRIu64"ns", devData.start, devData.end);
        AnalyzerBase::tsOpInfo_.erase(key);
        return;
    }

    if (AnalyzerBase::rtOpInfo_.empty()) {
        AnalyzerBase::tsTmpOpInfo_.insert(std::pair<std::string, RtOpInfo>(key, devData));
        AnalyzerBase::tsOpInfo_.erase(key);
        return;
    }

    auto hostIter = AnalyzerBase::rtOpInfo_.find(key);
    if (hostIter == AnalyzerBase::rtOpInfo_.end()) {
        MSPROF_LOGD("Device data not match runtime track, key: %s, start: %" PRIu64 "ns, end: %" PRIu64 "ns",
            key.c_str(), devData.start, devData.end);
        AnalyzerBase::tsTmpOpInfo_.insert(std::pair<std::string, RtOpInfo>(key, devData));
        AnalyzerBase::tsOpInfo_.erase(key);
        return;
    }

    devData.threadId = hostIter->second.threadId;
    devData.tsTrackTimeStamp = hostIter->second.tsTrackTimeStamp;
    time++;
    MSPROF_LOGD("Success to merge runtime track and Hwts|Ffts data. timestamp: %" PRIu64 ", threadId: %u, "
        "taskId+streamId: %s, start: %" PRIu64 "ns, end: %" PRIu64 "ns, startAicore: %" PRIu64 ", endAicore: %" PRIu64
        ", contextId: %u, age: %d", hostIter->second.tsTrackTimeStamp, devData.threadId, key.c_str(), devData.start,
         devData.end, devData.startAicore, devData.endAicore, devData.contextId, hostIter->second.ageFlag);
    HandleUploadData(key, devData);
}

void AnalyzerBase::HandleUploadData(const std::string &key, const RtOpInfo &devData) const
{
    std::unique_lock<std::mutex> lk(AnalyzerBase::geThreadMtx_);

    AnalyzerBase::devTmpOpInfo_.emplace_back(std::move(devData));
    if (AnalyzerBase::geOpInfo_.empty()) {
        MSPROF_LOGD("Ge opInfo is empty, drop data key: %s, threadId: %u, tsTrackTimeStamp: %" PRIu64, key.c_str(),
            devData.threadId, devData.tsTrackTimeStamp);
        AnalyzerBase::tsOpInfo_.erase(key);
        return;
    }

    auto threadGroup = AnalyzerBase::geOpInfo_.equal_range(devData.threadId);
    if (threadGroup.first != AnalyzerBase::geOpInfo_.end()) {
        for (auto geIter = threadGroup.first; geIter != threadGroup.second; ++geIter) {
            if (devData.tsTrackTimeStamp > geIter->second.end ||
                devData.tsTrackTimeStamp <= geIter->second.start) { // time include
                continue;
            }
            ConstructAndUploadOptimizeData(geIter->second, devData);
            AnalyzerBase::devTmpOpInfo_.pop_back();
            break;
        }
    }
    AnalyzerBase::tsOpInfo_.erase(key);
}

void AnalyzerBase::ConstructAndUploadOptimizeData(GeOpFlagInfo &opFlagData, const RtOpInfo &rtTsOpdata) const
{
    ProfOpDesc opDesc;
    const auto ret = memset_s(&opDesc, sizeof(ProfOpDesc), 0, sizeof(ProfOpDesc));
    if (ret != EOK) {
        MSPROF_LOGE("memset failed ret:%d", ret);
        return;
    }
    std::string opName;
    std::string opType;
    opDesc.modelId = opFlagData.modelId;
    opName = HashData::instance()->GetHashInfo(opFlagData.opNameHash);
    opType = HashData::instance()->GetHashInfo(opFlagData.opTypeHash);
    const uint64_t opIndex = OpDescParser::instance()->SetOpTypeAndOpName(opType, opName);
    if (opIndex == 0) {
        return;
    }
    opDesc.threadId = rtTsOpdata.threadId;
    opDesc.opIndex = opIndex;
    opDesc.duration = rtTsOpdata.end - rtTsOpdata.start;
    opDesc.start = rtTsOpdata.start;
    opDesc.end = rtTsOpdata.end;
    opDesc.flag = rtTsOpdata.flag;
    opDesc.devId = rtTsOpdata.devId;
    if (opType == "FFTS_PLUS") {
        opDesc.flag = ACL_SUBSCRIBE_SUBGRAPH;
    }
    opDesc.executionTime = rtTsOpdata.endAicore - rtTsOpdata.startAicore;
    MSPROF_LOGD("Upload opt data push to vector. modelId: %u ,threadId: %u, duration: %" PRIu64 ", executionTime: %"
        PRIu64 ", opName: %s, opType: %s", opDesc.modelId, opDesc.threadId, opDesc.duration, opDesc.executionTime,
        opName.c_str(), opType.c_str());
    std::unique_lock<std::mutex> lk(opDescInfoMtx_);
    AnalyzerBase::opDescInfos_.emplace_back(std::move(opDesc));
}

uint32_t AnalyzerBase::GetGraphModelId(uint32_t modelId) const
{
    std::unique_lock<std::mutex> lk(graphIdMtx_);
    if (graphIdMap_.find(modelId) == graphIdMap_.end()) {
        return modelId;
    } else {
        return graphIdMap_[modelId];
    }
}

void AnalyzerBase::SetGraphModelId(uint32_t modelId, uint32_t graphId) const
{
    std::unique_lock<std::mutex> lk(graphIdMtx_);
    graphIdMap_[modelId] = graphId;
}

bool AnalyzerBase::IsExtPmu() const
{
    if (pmuNum_ == CLOUD_V3_PMU_NUM) {
        return true;
    }
    return false;
}
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
