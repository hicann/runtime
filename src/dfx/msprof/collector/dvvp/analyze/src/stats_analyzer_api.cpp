/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stats_analyzer_api.h"
#include <algorithm>
#include <cctype>
#include <fstream>
#include <iterator>
#include "data_struct.h"
#include "errno/error_code.h"
#include "config_manager.h"
#include "prof_reporter_mgr.h"
#include "ai_drv_dev_api.h"
#include "json/json.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;
constexpr int32_t MSPROF_API_SIZE = sizeof(MsprofApi);
constexpr float MHZ_CONVERT_GHZ = 1000.0; // 1000: mhz to ghz
constexpr float DEFAULT_HOST_FREQ_MHZ = 1000.0; // 1000: default 1000MHz
constexpr float DEFAULT_HOST_FREQ_GHZ = DEFAULT_HOST_FREQ_MHZ / MHZ_CONVERT_GHZ;
const std::string API_SHIELDING_PATH = "/etc/prof_api_shielding.json";

const std::map<uint32_t, std::string> API_TAG_MAP = {
    {ACL_OP, "ACL_OP"},
    {ACL_MODEL, "ACL_MODEL"},
    {ACL_RTS, "ACL_RTS"},
    {ACL_OTHERS, "ACL_OTHERS"},
    {ACL_NN, "ACL_NN"},
    {ACL_ASCENDC, "ACL_ASCENDC"},
    {ACL_HCCL, "ACL_HCCL"},
    {ACL_DVPP, "ACL_DVPP"},
    {ACL_GRAPH, "ACL_GRAPH"},
    {ACL_ATB, "ACL_ATB"}
};

void StatsAnalyzerApi::InitFrequency()
{
    float mhzFreq = DEFAULT_HOST_FREQ_MHZ; // mhz
    if (!analysis::dvvp::driver::DrvGetHostFreq(mhzFreq)) {
        mhzFreq = DEFAULT_HOST_FREQ_MHZ;
        MSPROF_LOGW("Unable to get host cpu freq, use default value: %f.", mhzFreq);
    }
    if (mhzFreq <= 0) {
        MSPROF_LOGW("Invalid host cpu freq %f, use default value: %f.", mhzFreq, DEFAULT_HOST_FREQ_MHZ);
        mhzFreq = DEFAULT_HOST_FREQ_MHZ;
    }
    hostFreq_ = mhzFreq / MHZ_CONVERT_GHZ; // ghz
    InitApiShieldingConfig();
}

float StatsAnalyzerApi::GetSafeHostFreq() const
{
    if (hostFreq_ > 0) {
        return hostFreq_;
    }
    MSPROF_LOGW("Invalid host cpu freq %f, use default value: %f.", hostFreq_, DEFAULT_HOST_FREQ_GHZ);
    return DEFAULT_HOST_FREQ_GHZ;
}

bool StatsAnalyzerApi::IsValidStatsRecord(const ApiStatsInfo &info) const
{
    if (info.endTime <= info.beginTime) {
        MSPROF_LOGW("Skip invalid api stats record, begin: %llu, end: %llu, type: %u, hash name: %u.",
            info.beginTime, info.endTime, info.type, info.hashName);
        return false;
    }
    return true;
}

void StatsAnalyzerApi::InitApiShieldingConfig()
{
    shieldingApiNames_.clear();
    std::string content;
    if (!LoadApiShieldingConfig(content)) {
        return;
    }
    ParseApiShieldingConfig(content);
}

bool StatsAnalyzerApi::LoadApiShieldingConfig(std::string &content) const
{
    std::ifstream file(API_SHIELDING_PATH);
    if (!file.is_open()) {
        MSPROF_LOGD("Api shielding config file %s does not exist.", API_SHIELDING_PATH.c_str());
        return false;
    }

    content.assign((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    if (content.empty()) {
        MSPROF_LOGW("Api shielding config file %s is empty.", API_SHIELDING_PATH.c_str());
        return false;
    }
    return true;
}

void StatsAnalyzerApi::ParseApiShieldingConfig(const std::string &content)
{
    NanoJson::Json json;
    try {
        json.Parse(content);
    } catch (std::runtime_error &e) {
        MSPROF_LOGW("Failed to parse api shielding config %s, reason: %s.", API_SHIELDING_PATH.c_str(), e.what());
        return;
    }

    if (!json.Contains("api")) {
        MSPROF_LOGW("Api shielding config %s does not contain api field.", API_SHIELDING_PATH.c_str());
        return;
    }
    NanoJson::JsonValue apiList = json["api"];
    if (apiList.type != NanoJson::JsonValueType::ARRAY) {
        MSPROF_LOGW("Api shielding config %s api field is not array.", API_SHIELDING_PATH.c_str());
        return;
    }

    for (auto &api : apiList.GetValue<NanoJson::JsonArray>()) {
        if (api.type != NanoJson::JsonValueType::STRING) {
            MSPROF_LOGW("Api shielding config %s contains non-string api name.", API_SHIELDING_PATH.c_str());
            continue;
        }
        const std::string name = NormalizeApiName(api.GetValue<std::string>());
        if (!name.empty()) {
            shieldingApiNames_.insert(name);
        }
    }
}

std::string StatsAnalyzerApi::NormalizeApiName(const std::string &apiName) const
{
    std::string result = apiName;
    std::transform(result.begin(), result.end(), result.begin(),
        [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    return result;
}

bool StatsAnalyzerApi::ShouldSkipTotalTimeApi(const std::string &apiName) const
{
    const std::string lowerName = NormalizeApiName(apiName);
    if (lowerName.find("synchronize") != std::string::npos) {
        return true;
    }
    return shieldingApiNames_.find(lowerName) != shieldingApiNames_.end();
}

void StatsAnalyzerApi::HandleAppendingData(CONST_CHAR_PTR data, uint32_t len)
{
    if (analyzerBuf_.empty()) {
        dataPtr_ = data;
        dataLen_ = len;
    } else {
        (void)analyzerBuf_.append(data, len);
        dataPtr_ = analyzerBuf_.c_str();
        if (analyzerBuf_.size() > UINT_MAX) {
            dataLen_ = 0;
            dataPtr_ = nullptr;
            MSPROF_LOGE("size out of UINT_MAX");
            return;
        } else {
            dataLen_ = static_cast<uint32_t>(analyzerBuf_.size());
        }
    }
}

void StatsAnalyzerApi::HandleRemainingData(uint32_t offset)
{
    if (offset < dataLen_) {
        analyzerBuf_ = std::string(dataPtr_ + offset, dataLen_ - offset);
    } else {
        if (!analyzerBuf_.empty()) {
            analyzerBuf_.clear();
        }
    }
}

void StatsAnalyzerApi::PrintStats()
{
}

bool StatsAnalyzerApi::IsApiOrEventData(const std::string &fileName) const
{
    if (fileName.find("api_event") != std::string::npos) {
        return true;
    }
    return false;
}

void StatsAnalyzerApi::Parse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("Api and event parse chunk is null.");
        return;
    }


    MSPROF_LOGI("Start to analyze api_event file: %s", fileChunkReq->fileName.c_str());
    ParseApiAndEventInfo(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
}

void StatsAnalyzerApi::ParseApiAndEventInfo(CONST_CHAR_PTR data, uint32_t len)
{
    HandleAppendingData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        const uint32_t remainLen = dataLen_ - offset;
        if (remainLen < MSPROF_API_SIZE) {
            MSPROF_LOGW("ModelApiAndEventInfo remains %u bytes unparsed, which is incomplete data.", remainLen);
            break;
        }

        auto apiData = reinterpret_cast<const MsprofApi *>(dataPtr_ + offset);
        MSPROF_LOGD("Parse api level: %hu, type %u, eventFlag: %llu, threadId: %u, itemId: %llu.",
            apiData->level, apiData->type, apiData->endTime, apiData->threadId, apiData->itemId);
        if (apiData->endTime != MSPROF_EVENT_FLAG && apiData->level == MSPROF_REPORT_ACL_LEVEL) {
            HandleApiInfo(dataPtr_ + offset);
            totalApiTimes_++;
        } else if (apiData->endTime == MSPROF_EVENT_FLAG && apiData->level == MSPROF_REPORT_ACL_LEVEL) {
            HandleEventInfo(dataPtr_ + offset);
            totalEventTimes_++;
        }
        offset += MSPROF_API_SIZE;
    }
    HandleRemainingData(offset);
}

void StatsAnalyzerApi::HandleApiInfo(CONST_CHAR_PTR data)
{
    auto klData = reinterpret_cast<const MsprofApi *>(data);
    uint32_t key = klData->threadId;
    uint32_t type = 0; // api type
    uint32_t tag = (klData->type >> 16);
    uint32_t hashName = klData->type;
    statsMap_[key][klData->beginTime] = {type, tag, hashName, 0, klData->beginTime, klData->endTime};
    MSPROF_LOGI("Insert to api stats map, thread: %u, type: %u, tag: %u, hash name: %u, beginTime: %llu, "
        "endTime: %llu", key, type, tag, hashName, klData->beginTime, klData->endTime);
}

void StatsAnalyzerApi::HandleEventInfo(CONST_CHAR_PTR data)
{
    auto mlData = reinterpret_cast<const MsprofEvent *>(data);
    uint32_t key = mlData->threadId;
    uint32_t type = 1; // event type
    uint32_t tag = (mlData->type >> 16);
    uint32_t hashName = mlData->type;
    if (statsMap_.count(key) == 0) {
        statsMap_[key][mlData->timeStamp] = {type, tag, hashName, mlData->itemId, mlData->timeStamp, 0};
        MSPROF_LOGI("Insert to api event map, thread: %u, type: %u, tag: %u, hash name: %u, model id: %llu, "
            "beginTime: %llu", key, type, tag, hashName, mlData->itemId, mlData->timeStamp);
        return;
    }

    bool modelIdExist = false;
    for (auto iter = statsMap_[key].begin(); iter != statsMap_[key].end(); iter++) {
        if (iter->second.type == 0) { // expect event info
            continue;
        }
        if (iter->second.modelId != mlData->itemId) { // expect same modelId
            continue;
        }
        if (iter->second.endTime != 0) {
            iter->second.endTime = 0;
            iter->second.beginTime = mlData->timeStamp; // repeat modelId and threadId
            MSPROF_LOGD("Cover event start: %llu, modelId: %llu to stats map.", mlData->timeStamp, mlData->itemId);
            return;
        }
        if (iter->second.beginTime >= mlData->timeStamp) { // start end error
            MSPROF_LOGE("Invalid event time: api start latter than api end.");
            return;
        }
        iter->second.endTime = mlData->timeStamp;
        MSPROF_LOGI("Insert to api event map, thread: %u, type: %u, tag: %u, hash name: %u, model id: %llu, "
            "beginTime: %llu, endTime: %llu", key, type, tag, hashName, mlData->itemId,
            iter->second.beginTime, iter->second.endTime);
        modelIdExist = true;
    }

    if (!modelIdExist) { // same threadId different modelid
        statsMap_[key][mlData->timeStamp] = {type, tag, hashName, mlData->itemId, mlData->timeStamp, 0};
        MSPROF_LOGI("Insert to api event map, thread: %u, type: %u, tag: %u, hash name: %u, model id: %llu, "
            "beginTime: %llu", key, type, tag, hashName, mlData->itemId, mlData->timeStamp);
    }
}

void StatsAnalyzerApi::GenerateTotalTimeData(std::ofstream& file)
{
    if (statsMap_.empty()) {
        MSPROF_LOGW("Empty api stats map.");
        return;
    }

    std::map<uint32_t, ApiTotalTime> apiTimeMap = {};
    for (auto threadIt = statsMap_.begin(); threadIt != statsMap_.end(); threadIt++) {
        for (auto timeIt = threadIt->second.begin(); timeIt != threadIt->second.end(); timeIt++) {
            if (!IsValidStatsRecord(timeIt->second)) {
                continue;
            }
            std::string name = "NA";
            ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().GetReportTypeInfo(
                MSPROF_REPORT_ACL_LEVEL, timeIt->second.hashName, name);
            if (ShouldSkipTotalTimeApi(name)) {
                MSPROF_LOGD("Skip api %s when count api total time.", name.c_str());
                continue;
            }
            uint64_t curBegin = timeIt->second.beginTime;
            uint64_t curEnd = timeIt->second.endTime;
            uint64_t curCost = (curEnd - curBegin);
            auto iter = apiTimeMap.find(threadIt->first);
            if (iter == apiTimeMap.end()) {
                ApiTotalTime data = {curBegin, curEnd, curCost};
                apiTimeMap[threadIt->first] = data;
                MSPROF_LOGD("First api found, begin: %llu, end: %llu, cost: %llu.", curBegin, curEnd, curCost);
                continue;
            }
            if (curEnd <= iter->second.lastEnd &&
                curBegin >= iter->second.lastBegin) {
                MSPROF_LOGD("Sub api found, begin: %llu, end: %llu, cost: %llu.", curBegin, curEnd, curCost);
                continue;
            }
            iter->second.totalTime += curCost;
            iter->second.lastBegin = curBegin;
            iter->second.lastEnd = curEnd;
            MSPROF_LOGD("Main api found, begin: %llu, end: %llu, cost: %llu.", curBegin, curEnd, curCost);
        }
    }

    WriteTotalTimeData(file, apiTimeMap);
}

void StatsAnalyzerApi::WriteTotalTimeData(std::ofstream& file, const std::map<uint32_t, ApiTotalTime> &apiTimeMap)
{
    const float hostFreq = GetSafeHostFreq();
    if (hostFreq <= 0) {
        MSPROF_LOGE("Invalid host cpu freq %f, skip writing api total time.", hostFreq);
        return;
    }
    for (auto iter = apiTimeMap.begin(); iter != apiTimeMap.end(); iter++) {
        file << iter->first;
        file << ",";
        file << (static_cast<float>(iter->second.totalTime) / hostFreq); // syscnt * (1 / ghz) = ns
        file << std::endl;
        MSPROF_LOGI("Write thread: %u, total time: %llu, to acl_api_total_time.csv.",
            iter->first, iter->second.totalTime);
    }
}

void StatsAnalyzerApi::GenerateStatisticsData(std::ofstream& file)
{
    if (statsMap_.empty()) {
        MSPROF_LOGW("Empty api stats map.");
        return;
    }

    std::map<uint32_t, std::map<uint32_t, ApiStatistics>> apiStatsMap = {};
    for (auto threadIt = statsMap_.begin(); threadIt != statsMap_.end(); threadIt++) {
        for (auto timeIt = threadIt->second.begin(); timeIt != threadIt->second.end(); timeIt++) {
            if (!IsValidStatsRecord(timeIt->second)) {
                continue;
            }
            uint64_t curBegin = timeIt->second.beginTime;
            uint64_t curEnd = timeIt->second.endTime;
            uint64_t curCost = (curEnd - curBegin);
            auto statsIt = apiStatsMap.find(threadIt->first);
            if (statsIt == apiStatsMap.end()) {
                ApiStatistics data = {curCost, curCost, curCost, 1, timeIt->second.tag};
                apiStatsMap[threadIt->first][timeIt->second.hashName] = data;
                MSPROF_LOGD("First thread found, hash name: %u, main time: %llu, max time: %llu, total time: %llu,"
                    " count: %u, tag: %u.", timeIt->second.hashName, data.apiMaxTime, data.apiMinTime, data.apiTime,
                    data.apiCount, data.apiTag);
                continue;
            }
            auto hashIt = statsIt->second.find(timeIt->second.hashName);
            if (hashIt == statsIt->second.end()) {
                ApiStatistics data = {curCost, curCost, curCost, 1, timeIt->second.tag};
                apiStatsMap[threadIt->first][timeIt->second.hashName] = data;
                MSPROF_LOGD("First name found, hash name: %u, main time: %llu, max time: %llu, total time: %llu, "
                    "count: %u, tag: %u.", timeIt->second.hashName, data.apiMaxTime, data.apiMinTime, data.apiTime,
                    data.apiCount, data.apiTag);
                continue;
            }

            hashIt->second.apiMaxTime = (curCost > hashIt->second.apiMaxTime) ? curCost : hashIt->second.apiMaxTime;
            hashIt->second.apiMinTime = (curCost < hashIt->second.apiMinTime) ? curCost : hashIt->second.apiMinTime;
            hashIt->second.apiTime += curCost;
            hashIt->second.apiCount++;
            MSPROF_LOGD("Main api found, begin: %llu, end: %llu, cost: %llu.", curBegin, curEnd, curCost);
        }
    }

    WriteStatisticsData(file, apiStatsMap);
}

void StatsAnalyzerApi::WriteStatisticsData(std::ofstream& file,
    const std::map<uint32_t, std::map<uint32_t, ApiStatistics>> &apiStatsMap)
{
    const float hostFreq = GetSafeHostFreq();
    if (hostFreq <= 0) {
        MSPROF_LOGE("Invalid host cpu freq %f, skip writing api statistics.", hostFreq);
        return;
    }
    for (auto iter = apiStatsMap.begin(); iter != apiStatsMap.end(); iter++) {
        for (auto innerIt = iter->second.begin(); innerIt != iter->second.end(); innerIt++) {
            if (innerIt->second.apiCount == 0) {
                MSPROF_LOGW("Skip api statistics with zero count, thread: %u, hash name: %u.",
                    iter->first, innerIt->first);
                continue;
            }
            std::string name = "NA";
            ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().GetReportTypeInfo(
                MSPROF_REPORT_ACL_LEVEL, innerIt->first, name);
            std::string type = "NA";
            auto tagIt = API_TAG_MAP.find(innerIt->second.apiTag);
            if (tagIt != API_TAG_MAP.end()) {
                type = tagIt->second;
            }
            file << iter->first; // thread
            file << ",";
            file << name; // api name
            file << ",";
            file << type; // api type
            file << ",";
            file << (static_cast<float>(innerIt->second.apiTime) / innerIt->second.apiCount / hostFreq);
            file << ",";
            file << (static_cast<float>(innerIt->second.apiMaxTime) / hostFreq); // api max time
            file << ",";
            file << (static_cast<float>(innerIt->second.apiMinTime) / hostFreq); // api min time
            file << ",";
            file << innerIt->second.apiCount;
            file << std::endl;
            MSPROF_LOGI("Write thread: %u, name: %s, type: %s, max cnt: %llu, min cnt: %llu, all cnt: %llu, "
                "count: %u, cpu freq: %f to acl_api_statistics.csv.", iter->first, name.c_str(), type.c_str(),
                innerIt->second.apiMaxTime, innerIt->second.apiMinTime, innerIt->second.apiTime,
                innerIt->second.apiCount, hostFreq);
        }
    }
}

void StatsAnalyzerApi::ClearAllData()
{
    MSPROF_EVENT("total_size_stats, api time: %u, event time: %u.", totalApiTimes_, totalEventTimes_);
    statsMap_.clear();
    analyzerBuf_.clear();
    dataPtr_ = nullptr;
    dataLen_ = 0;
    totalApiTimes_ = 0;
    totalEventTimes_ = 0;
}
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
