/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_collect_info.h"

#include <ctime>
#include <fstream>
#include <sstream>
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
namespace {
using namespace analysis::dvvp::common::error;
using analysis::dvvp::common::utils::Utils;

const char* const COLLECT_INFO_FILE_NAME = "prof_collect.info";
const char* const COLLECT_INFO_DATA_DIR = "data";
// Same mode the *.data files in this directory are given (file_slice.cpp, prof_host_job.cpp).
constexpr int32_t COLLECT_INFO_FILE_MODE = 0640;
// "%Y-%m-%d %H:%M:%S" is 19 chars; 32 leaves headroom for a trailing '\0' and future format extensions.
constexpr size_t TIME_STRING_BUF_SIZE = 32;

// Escape the characters JSON forbids inside a string. Reasons and details come from callers and may
// embed quotes or backslashes, which would otherwise produce a file no parser can read.
std::string EscapeJsonString(const std::string& input)
{
    std::string out;
    out.reserve(input.size());
    for (const char c : input) {
        switch (c) {
            case '\"':
                out.append("\\\"");
                break;
            case '\\':
                out.append("\\\\");
                break;
            case '\n':
                out.append("\\n");
                break;
            case '\r':
                out.append("\\r");
                break;
            case '\t':
                out.append("\\t");
                break;
            default:
                out.push_back(c);
                break;
        }
    }
    return out;
}

std::string CurrentTimeString()
{
    const std::time_t now = std::time(nullptr);
    std::tm tmBuf{};
    // localtime_r keeps this usable from several collection jobs at once.
    if (localtime_r(&now, &tmBuf) == nullptr) {
        return "";
    }
    char buf[TIME_STRING_BUF_SIZE] = {0};
    if (std::strftime(buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", &tmBuf) == 0) {
        return "";
    }
    return std::string(buf);
}
} // namespace

void ProfCollectInfo::RecordDataLoss(const CollectAbnormalItem& item)
{
    std::lock_guard<std::mutex> lock(mutex_);
    items_.push_back(item);
    MSPROF_LOGW(
        "Data loss recorded, module: %s, devId: %d, channelId: %d, ret: 0x%x, reason: %s", item.module.c_str(),
        item.devId, item.channelId, static_cast<uint32_t>(item.retCode), item.reason.c_str());
}

bool ProfCollectInfo::HasAbnormal()
{
    std::lock_guard<std::mutex> lock(mutex_);
    return !items_.empty();
}

void ProfCollectInfo::Reset()
{
    std::lock_guard<std::mutex> lock(mutex_);
    items_.clear();
}

// Build the file body from the caller-provided snapshot.
std::string ProfCollectInfo::BuildContent(const std::vector<CollectAbnormalItem>& items)
{
    std::stringstream ss;
    ss << "{\n";
    ss << "    \"collect_status\": \"data_loss\",\n";
    ss << "    \"collect_time\": \"" << EscapeJsonString(CurrentTimeString()) << "\",\n";
    ss << "    \"data_loss\": [\n";
    for (size_t i = 0; i < items.size(); ++i) {
        const CollectAbnormalItem& item = items[i];
        ss << "        {\n";
        ss << "            \"module\": \"" << EscapeJsonString(item.module) << "\",\n";
        ss << "            \"device_id\": " << item.devId << ",\n";
        ss << "            \"channel_id\": " << item.channelId << ",\n";
        ss << "            \"ret_code\": \"0x" << std::hex << static_cast<uint32_t>(item.retCode) << std::dec
           << "\",\n";
        ss << "            \"reason\": \"" << EscapeJsonString(item.reason) << "\"";
        if (!item.detail.empty()) {
            ss << ",\n            \"detail\": \"" << EscapeJsonString(item.detail) << "\"";
        }
        ss << "\n        }";
        // No trailing comma after the last element, otherwise the JSON is invalid.
        if (i + 1 < items.size()) {
            ss << ",";
        }
        ss << "\n";
    }
    ss << "    ]\n";
    ss << "}\n";
    return ss.str();
}

int32_t ProfCollectInfo::Flush(const std::string& resultDir)
{
    std::lock_guard<std::mutex> lock(mutex_);
    // A clean run must not leave an empty file behind: downstream tools treat the presence of
    // prof_collect.info as "something went wrong".
    if (items_.empty()) {
        return PROFILING_SUCCESS;
    }
    // Snapshot first: the records belong to this flush target. They are dropped only after the file
    // is written, so a failure does not lose them, and a success does not leak them into the next
    // device's report.
    const std::vector<CollectAbnormalItem> pending = items_;
    if (resultDir.empty()) {
        MSPROF_LOGE("Result dir is empty, cannot write %s", COLLECT_INFO_FILE_NAME);
        return PROFILING_FAILED;
    }

    std::vector<std::string> dirVec;
    dirVec.push_back(resultDir);
    dirVec.push_back(COLLECT_INFO_DATA_DIR);
    const std::string dataDir = Utils::JoinPath(dirVec);
    if (Utils::CreateDir(dataDir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create dir for %s", COLLECT_INFO_FILE_NAME);
        return PROFILING_FAILED;
    }

    std::vector<std::string> fileVec;
    fileVec.push_back(dataDir);
    fileVec.push_back(COLLECT_INFO_FILE_NAME);
    const std::string filePath = Utils::JoinPath(fileVec);

    const std::string content = BuildContent(pending);
    std::ofstream out(filePath, std::ios::out | std::ios::trunc);
    if (!out.is_open()) {
        MSPROF_LOGE("Failed to open %s for writing", COLLECT_INFO_FILE_NAME);
        return PROFILING_FAILED;
    }
    if (OsalChmod(filePath.c_str(), COLLECT_INFO_FILE_MODE) != OSAL_EN_OK) {
        out.close();
        MSPROF_LOGE("Failed to change file mode for %s", COLLECT_INFO_FILE_NAME);
        return PROFILING_FAILED;
    }
    out << content;
    // Report a write failure instead of leaving a truncated file to be parsed as complete.
    if (out.fail()) {
        out.close();
        MSPROF_LOGE("Failed to write %s", COLLECT_INFO_FILE_NAME);
        return PROFILING_FAILED;
    }
    out.close();

    // Written out: consume the records so they cannot reappear in a later flush.
    items_.clear();
    MSPROF_EVENT("Wrote %s with %zu data loss record(s)", COLLECT_INFO_FILE_NAME, pending.size());
    return PROFILING_SUCCESS;
}

} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis
