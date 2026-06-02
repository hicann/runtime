/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stats_analyzer.h"
#include "acl_prof.h"
#include "config/config.h"
#include "data_struct.h"
#include "errno/error_code.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
const std::string API_STATS_TOTAL_TIME_FILE = "acl_api_total_time.csv";
const std::string API_STATS_STATISTICS_FILE = "acl_api_statistics.csv";

StatsAnalyzer::StatsAnalyzer(const std::string &path): inited_(false), storePath_(path)
{
    MSVP_MAKE_SHARED0(statsAnalyzerApi_, StatsAnalyzerApi, return);
    statsAnalyzerApi_->InitFrequency();
    inited_ = true;
}

StatsAnalyzer::~StatsAnalyzer() {}

void StatsAnalyzer::OnApiData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (!inited_) {
        MSPROF_LOGE("StatsAnalyzer is not been inited!");
        return;
    }
    if (fileChunkReq == nullptr || fileChunkReq->fileName.empty()) {
        MSPROF_LOGW("StatsAnalyzer OnOptimizeData is not data for analyzing.");
        return;
    }
    if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_CTRL_DATA) {
        if (fileChunkReq->fileName == "end_info") {
            FlushApiData();
            statsAnalyzerApi_->ClearAllData();
            MSPROF_EVENT("StatsAnalyzer clear all data.");
        }
        return;
    }

    DispatchApiData(fileChunkReq);
}

void StatsAnalyzer::DispatchApiData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (statsAnalyzerApi_->IsApiOrEventData(fileChunkReq->fileName)) {
        statsAnalyzerApi_->Parse(fileChunkReq);
    } else {
        MSPROF_LOGD("StatsAnalyzer drop data, fileName: %s.", fileChunkReq->fileName.c_str());
        return;
    }
}

void StatsAnalyzer::FlushApiData()
{
    // flush acl_api_total_time.csv
    std::string totalTimeFile = CreateStatsFile(API_STATS_TOTAL_TIME_FILE);
    std::ofstream csvFile(totalTimeFile, std::ios::out | std::ios::app);
    if (csvFile.is_open()) {
        WriteTotalTimeTitle(csvFile);
        WriteTotalTimeData(csvFile);
    } else {
        MSPROF_LOGE("Failed to open total time file, path: %s, name: %s.", storePath_.c_str(),
            API_STATS_TOTAL_TIME_FILE.c_str());
        return;
    }

    csvFile.close();
    // flush acl_api_statistics.csv
    std::string statisticsFile = CreateStatsFile(API_STATS_STATISTICS_FILE);
    csvFile.open(statisticsFile, std::ios::out | std::ios::app);
    if (csvFile.is_open()) {
        WriteStatisticsTitle(csvFile);
        WriteStatisticsData(csvFile);
    } else {
        MSPROF_LOGE("Failed to open statistics file, path: %s, name: %s.", storePath_.c_str(),
            API_STATS_STATISTICS_FILE.c_str());
        return;
    }
    csvFile.close();
}

std::string StatsAnalyzer::CreateStatsFile(const std::string &name)
{
    MSPROF_LOGI("Create stats file, path: %s, name: %s.", storePath_.c_str(), name.c_str());
    std::string fileName = storePath_ + name;
    // create file and open ofstream
    int32_t fd = OsalOpen(fileName.c_str(), O_WRONLY | O_CREAT | O_APPEND, OSAL_IRUSR | OSAL_IWUSR);
    FUNRET_CHECK_EXPR_ACTION(fd < 0, return "", "Failed to create or open total time file: %s.", fileName.c_str());
    (void)OsalClose(fd);
    fileName = Utils::CanonicalizePath(fileName);
    FUNRET_CHECK_EXPR_ACTION(fileName.empty(), return "",
        "The fileName path: %s does not exist or permission denied.", fileName.c_str());
    return fileName;
}

void StatsAnalyzer::WriteTotalTimeTitle(std::ofstream& file)
{
    file << "thread,acl_api_total_time(ns)";
    file << std::endl;
}

void StatsAnalyzer::WriteStatisticsTitle(std::ofstream& file)
{
    file << "thread,api_name,api_type,api_average_time(ns),api_max_time(ns),api_min_time(ns),api_count";
    file << std::endl;
}

void StatsAnalyzer::WriteTotalTimeData(std::ofstream& file)
{
    statsAnalyzerApi_->GenerateTotalTimeData(file);
}

void StatsAnalyzer::WriteStatisticsData(std::ofstream& file)
{
    statsAnalyzerApi_->GenerateStatisticsData(file);
}
}
}
}
