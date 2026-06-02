/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdio>
#include <fstream>
#include <memory>
#include <string>
#include "gtest/gtest.h"
#include "aprof_pub.h"
#include "prof_reporter_mgr.h"
#include "stats_analyzer_api.h"

using namespace Analysis::Dvvp::Analyze;
using namespace Dvvp::Collect::Report;

namespace {
constexpr uint32_t TEST_THREAD_ID = 100;
constexpr uint32_t ACL_RTS_TAG = 3;
constexpr uint32_t NORMAL_API_HASH = (ACL_RTS_TAG << 16) + 1;
constexpr uint32_t SYNC_API_HASH = (ACL_RTS_TAG << 16) + 2;
constexpr uint32_t SHIELD_API_HASH = (ACL_RTS_TAG << 16) + 3;
static_assert(sizeof(MsprofApi) == sizeof(MsprofEvent), "MsprofApi and MsprofEvent size must match");

MsprofApi CreateApiData(uint32_t hashName, uint64_t beginTime, uint64_t endTime)
{
    MsprofApi api = {};
    api.level = MSPROF_REPORT_ACL_LEVEL;
    api.type = hashName;
    api.threadId = TEST_THREAD_ID;
    api.beginTime = beginTime;
    api.endTime = endTime;
    return api;
}

MsprofEvent CreateEventData(uint32_t hashName, uint64_t timeStamp, uint64_t itemId)
{
    MsprofEvent event = {};
    event.level = MSPROF_REPORT_ACL_LEVEL;
    event.type = hashName;
    event.threadId = TEST_THREAD_ID;
    event.timeStamp = timeStamp;
    event.itemId = itemId;
    return event;
}

void AppendApiData(std::string &buffer, const MsprofApi &api)
{
    buffer.append(reinterpret_cast<const char *>(&api), sizeof(MsprofApi));
}

void AppendEventData(std::string &buffer, const MsprofEvent &event)
{
    buffer.append(reinterpret_cast<const char *>(&event), sizeof(MsprofEvent));
}

SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> CreateApiEventChunk(const std::string &buffer)
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    return chunk;
}
}

class STATS_ANALYZER_API_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        ProfReporterMgr::GetInstance().RegReportTypeInfo(MSPROF_REPORT_ACL_LEVEL, NORMAL_API_HASH, "aclrtMemcpy");
        ProfReporterMgr::GetInstance().RegReportTypeInfo(MSPROF_REPORT_ACL_LEVEL, SYNC_API_HASH, "aclrtSYNCHRONIZE");
        ProfReporterMgr::GetInstance().RegReportTypeInfo(MSPROF_REPORT_ACL_LEVEL, SHIELD_API_HASH, "aclrtCreateStream");
    }
};

TEST_F(STATS_ANALYZER_API_UTEST, GenerateTotalTimeDataSkipSynchronizeIgnoreCase)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 30));
    AppendApiData(buffer, CreateApiData(SYNC_API_HASH, 40, 70));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    analyzer.Parse(chunk);

    std::string outputFile = "./stats_analyzer_total_time_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line1;
    ASSERT_TRUE(std::getline(result, line1));
    EXPECT_EQ("100,20", line1);
    EXPECT_FALSE(std::getline(result, line1));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateTotalTimeDataSkipShieldingApi)
{
    StatsAnalyzerApi analyzer;
    analyzer.ParseApiShieldingConfig("{\"api\":[\"ACLRTCREATESTREAM\"]}");

    std::string buffer;
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 30));
    AppendApiData(buffer, CreateApiData(SHIELD_API_HASH, 40, 70));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    analyzer.Parse(chunk);

    std::string outputFile = "./stats_analyzer_shielding_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line2;
    ASSERT_TRUE(std::getline(result, line2));
    EXPECT_EQ("100,20", line2);
    EXPECT_FALSE(std::getline(result, line2));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateTotalTimeDataCalculateThreadTotalTime)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 30));
    AppendApiData(buffer, CreateApiData(SHIELD_API_HASH, 40, 70));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    analyzer.Parse(chunk);

    std::string outputFile = "./stats_analyzer_total_time_normal_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,50", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateStatisticsDataCalculateApiMaxMinAverage)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 30));
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 40, 90));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    analyzer.Parse(chunk);

    std::string outputFile = "./stats_analyzer_statistics_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateStatisticsData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,aclrtMemcpy,ACL_RTS,35,50,20,2", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, ParseSplitApiDataKeepsRemainingBytes)
{
    StatsAnalyzerApi analyzer;
    MsprofApi api = CreateApiData(NORMAL_API_HASH, 10, 25);
    std::string apiBytes(reinterpret_cast<const char *>(&api), sizeof(MsprofApi));

    const size_t splitPos = sizeof(MsprofApi) / 2;
    analyzer.Parse(CreateApiEventChunk(apiBytes.substr(0, splitPos)));
    EXPECT_EQ(splitPos, analyzer.analyzerBuf_.size());
    EXPECT_TRUE(analyzer.statsMap_.empty());

    analyzer.Parse(CreateApiEventChunk(apiBytes.substr(splitPos)));
    EXPECT_TRUE(analyzer.analyzerBuf_.empty());

    std::string outputFile = "./stats_analyzer_split_total_time_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,15", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateDataFromPairedEvent)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 10, 1));
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 40, 1));

    analyzer.Parse(CreateApiEventChunk(buffer));

    std::string outputFile = "./stats_analyzer_event_statistics_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateStatisticsData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,aclrtMemcpy,ACL_RTS,30,30,30,1", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, HandleEventBranchesForRepeatDifferentAndInvalidModel)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 10, 1));
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 40, 1));
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 100, 1));
    AppendEventData(buffer, CreateEventData(SHIELD_API_HASH, 110, 2));
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 90, 1));
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 130, 1));

    analyzer.Parse(CreateApiEventChunk(buffer));

    ASSERT_EQ(1U, analyzer.statsMap_.size());
    EXPECT_EQ(2U, analyzer.statsMap_[TEST_THREAD_ID].size());

    std::string outputFile = "./stats_analyzer_event_repeat_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,30", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateTotalTimeDataSkipNestedApi)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 100));
    AppendApiData(buffer, CreateApiData(SHIELD_API_HASH, 20, 30));

    analyzer.Parse(CreateApiEventChunk(buffer));

    std::string outputFile = "./stats_analyzer_total_time_nested_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,90", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, WriteStatisticsDataHandlesUnknownTagAndZeroCount)
{
    StatsAnalyzerApi analyzer;
    ProfReporterMgr::GetInstance().RegReportTypeInfo(MSPROF_REPORT_ACL_LEVEL, 0xabcdef, "aclUnknownTag");
    std::map<uint32_t, std::map<uint32_t, ApiStatistics>> apiStatsMap;
    apiStatsMap[TEST_THREAD_ID][0xabcdef] = {10, 10, 10, 1, ACL_MAX};
    apiStatsMap[TEST_THREAD_ID][0xabcdf0] = {0, 0, 0, 0, ACL_RTS};

    std::string outputFile = "./stats_analyzer_statistics_unknown_tag_utest.csv";
    std::ofstream file(outputFile);
    analyzer.WriteStatisticsData(file, apiStatsMap);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,aclUnknownTag,NA,10,10,10,1", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GuardBranches)
{
    StatsAnalyzerApi analyzer;

    EXPECT_TRUE(analyzer.IsApiOrEventData("host.api_event.0"));
    EXPECT_FALSE(analyzer.IsApiOrEventData("host.api.0"));

    analyzer.Parse(nullptr);
    std::ofstream totalFile("./stats_analyzer_empty_total_utest.csv");
    analyzer.GenerateTotalTimeData(totalFile);
    totalFile.close();
    std::ofstream statFile("./stats_analyzer_empty_statistics_utest.csv");
    analyzer.GenerateStatisticsData(statFile);
    statFile.close();
    std::remove("./stats_analyzer_empty_total_utest.csv");
    std::remove("./stats_analyzer_empty_statistics_utest.csv");
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateTotalTimeDataSkipUnclosedEvent)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 100, 1));
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 30));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    analyzer.Parse(chunk);

    std::string outputFile = "./stats_analyzer_total_time_unclosed_event_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateTotalTimeData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,20", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, GenerateStatisticsDataSkipUnclosedEvent)
{
    StatsAnalyzerApi analyzer;
    std::string buffer;
    AppendEventData(buffer, CreateEventData(NORMAL_API_HASH, 100, 1));
    AppendApiData(buffer, CreateApiData(NORMAL_API_HASH, 10, 30));

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    chunk->fileName = "unaging.api_event.data";
    chunk->chunk = buffer;
    chunk->chunkSize = buffer.size();
    analyzer.Parse(chunk);

    std::string outputFile = "./stats_analyzer_statistics_unclosed_event_utest.csv";
    std::ofstream file(outputFile);
    analyzer.GenerateStatisticsData(file);
    file.close();

    std::ifstream result(outputFile);
    std::string line;
    ASSERT_TRUE(std::getline(result, line));
    EXPECT_EQ("100,aclrtMemcpy,ACL_RTS,20,20,20,1", line);
    EXPECT_FALSE(std::getline(result, line));
    result.close();
    std::remove(outputFile.c_str());
}

TEST_F(STATS_ANALYZER_API_UTEST, ClearAllDataResetSessionState)
{
    StatsAnalyzerApi analyzer;
    analyzer.statsMap_[TEST_THREAD_ID];
    analyzer.analyzerBuf_ = "remaining";
    analyzer.dataPtr_ = analyzer.analyzerBuf_.c_str();
    analyzer.dataLen_ = static_cast<uint32_t>(analyzer.analyzerBuf_.size());
    analyzer.totalApiTimes_ = 1;
    analyzer.totalEventTimes_ = 1;
    analyzer.shieldingApiNames_.insert("aclrtcreatestream");

    analyzer.ClearAllData();

    EXPECT_TRUE(analyzer.statsMap_.empty());
    EXPECT_TRUE(analyzer.analyzerBuf_.empty());
    EXPECT_EQ(nullptr, analyzer.dataPtr_);
    EXPECT_EQ(0U, analyzer.dataLen_);
    EXPECT_EQ(0U, analyzer.totalApiTimes_);
    EXPECT_EQ(0U, analyzer.totalEventTimes_);
    EXPECT_EQ(1U, analyzer.shieldingApiNames_.count("aclrtcreatestream"));
}
