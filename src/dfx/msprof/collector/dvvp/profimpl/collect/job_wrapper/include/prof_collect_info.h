/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_COLLECT_INFO_H
#define PROF_COLLECT_INFO_H

#include <cstdint>
#include <mutex>
#include <string>
#include <vector>
#include "singleton/singleton.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {

// One abnormal condition observed while collecting from a driver channel.
// Kept free of any channel-specific fields so other modules can report their own losses.
struct CollectAbnormalItem {
    std::string module;     // reporting module, e.g. "biu_perf", "soc_pmu"
    int32_t devId = -1;     // device id, -1 when not applicable
    int32_t channelId = -1; // driver channel id, -1 when not applicable
    int32_t retCode = 0;    // driver return code that triggered the record
    std::string reason;     // human readable description
    std::string detail;     // optional extra context, e.g. "groupId=0,coreType=aic"
};

// Collects abnormal conditions during profiling and writes them to <result dir>/data/prof_collect.info.
//
// Records are accumulated in memory and flushed once, so a run touching several channels produces a
// single file with one entry per occurrence instead of overwriting itself. Reporters only describe
// what happened; deciding where the file goes is left to Flush(), which the job layer calls with the
// result directory it already knows.
class ProfCollectInfo : public analysis::dvvp::common::singleton::Singleton<ProfCollectInfo> {
public:
    ProfCollectInfo() = default;
    ~ProfCollectInfo() override = default;

    // Record one data loss occurrence. Safe to call from any collection job.
    void RecordDataLoss(const CollectAbnormalItem& item);

    // Write the records accumulated so far to <resultDir>/data/prof_collect.info and drop them.
    //
    // Consuming the records is what keeps this singleton safe across devices and repeated runs: each
    // device has its own resultDir, so records left behind would be written again into the next
    // device's file and make the report untrustworthy. Records are only dropped once the file is
    // written successfully -- a failed write keeps them so the information is not lost silently.
    //
    // Does nothing when no abnormality was recorded, so a clean run leaves no file behind.
    // Returns PROFILING_SUCCESS also when there is nothing to write.
    int32_t Flush(const std::string& resultDir);

    // Drop accumulated records without writing them. For callers that need to discard state
    // explicitly, e.g. when a run is aborted before any flush point is reached.
    void Reset();

    // Whether anything was recorded, for callers that want to log a summary.
    bool HasAbnormal();

private:
    // Build the file body from the given records. Static so it cannot touch items_ without holding
    // the lock.
    static std::string BuildContent(const std::vector<CollectAbnormalItem>& items);

    std::mutex mutex_;
    std::vector<CollectAbnormalItem> items_;
};

} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis

#endif // PROF_COLLECT_INFO_H
