/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>

#include "mergeslog.h"

extern "C" {
void MergeSlogStubReset(void);
uint32_t MergeSlogStubGetLastCmd(void);
}

namespace {
constexpr char kMergeRoot[] = "/tmp/mergeslog_coverage_utest";
constexpr char kMergeOutput[] = "/tmp/mergeslog_coverage_utest/ascendmerge.log.gz";
}

class MergeSlogCoverageUtest : public testing::Test {
protected:
    void SetUp() override
    {
        MergeSlogStubReset();
        std::filesystem::create_directories(kMergeRoot);
        std::ofstream iamService(std::string(kMergeRoot) + "/iam");
        ASSERT_TRUE(iamService.is_open());
        (void)std::remove(kMergeOutput);
    }

    void TearDown() override
    {
        std::filesystem::remove_all(kMergeRoot);
    }
};

TEST_F(MergeSlogCoverageUtest, RejectsInvalidArguments)
{
    EXPECT_EQ(MERGE_INVALID_ARGV, DlogCollectLog(nullptr, 0));
    EXPECT_EQ(MERGE_INVALID_ARGV, DlogCheckCollectStatus(nullptr, 0));
    EXPECT_EQ(MERGE_INVALID_ARGV, DlogGetLogPatterns(nullptr));
}

TEST_F(MergeSlogCoverageUtest, CollectsAndChecksMergedLog)
{
    char dir[] = "/tmp/mergeslog_coverage_utest";
    EXPECT_EQ(MERGE_SUCCESS, DlogCollectLog(dir, sizeof(dir)));
    EXPECT_NE(0U, MergeSlogStubGetLastCmd());

    EXPECT_EQ(MERGE_NOT_FOUND, DlogCheckCollectStatus(dir, sizeof(dir)));
    {
        std::ofstream mergedLog(kMergeOutput);
        ASSERT_TRUE(mergedLog.is_open());
        mergedLog << "merged";
    }
    EXPECT_EQ(MERGE_SUCCESS, DlogCheckCollectStatus(dir, sizeof(dir)));
}

TEST_F(MergeSlogCoverageUtest, BuildsPatternsFromIamConfiguration)
{
    DlogNamePatterns logs = {};
    ASSERT_EQ(MERGE_SUCCESS, DlogGetLogPatterns(&logs));
    ASSERT_NE(nullptr, logs.patterns);
    EXPECT_EQ(13U, logs.logNum);
    EXPECT_STREQ("/tmp/debug/device-0/", logs.patterns[0].path);
    EXPECT_STREQ("device-0.*_act.log.gz", logs.patterns[0].active);
    EXPECT_STREQ("/tmp/debug/", logs.patterns[1].path);
    EXPECT_STREQ("group-test.*_act.log.gz", logs.patterns[1].active);
    std::free(logs.patterns);
}
