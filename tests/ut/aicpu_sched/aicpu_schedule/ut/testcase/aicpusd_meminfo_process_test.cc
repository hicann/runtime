/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <climits>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <securec.h>
#include "aicpu_context.h"
#define private public
#include "core/aicpusd_meminfo_process.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

namespace {
const char_t* const TEST_JSON_PATH = "./aicpusd_meminfo_process_ut.json";

std::string BuildEntry(const uint32_t cfgId)
{
    std::ostringstream oss;
    oss << "\"cfg_id\":" << cfgId << ",\"total_size\":" << (1024U + cfgId) << ",\"blk_size\":256,"
        << "\"max_buf_size\":512,\"page_type\":0";
    return oss.str();
}

std::string BuildConfig(const size_t entryCount)
{
    std::ostringstream oss;
    oss << '{';
    for (size_t i = 0U; i < entryCount; ++i) {
        if (i != 0U) {
            oss << ',';
        }
        oss << '"' << i << '"' << ':' << '{' << BuildEntry(static_cast<uint32_t>(i)) << '}';
    }
    oss << '}';
    return oss.str();
}

char_t* RealpathSuccessStub(const char_t* path, char_t* resolvedPath)
{
    (void)strcpy_s(resolvedPath, PATH_MAX, path);
    return resolvedPath;
}

char_t* RealpathMismatchStub(const char_t*, char_t* resolvedPath)
{
    (void)strcpy_s(resolvedPath, PATH_MAX, "/canonical/path");
    return resolvedPath;
}
} // namespace

namespace aicpu {
status_t GetAicpuRunModeStub(uint32_t& runMode)
{
    runMode = AicpuRunMode::PROCESS_SOCKET_MODE;
    return AICPU_ERROR_NONE;
}

status_t GetAicpuRunModeStub1(uint32_t& runMode)
{
    runMode = 3U;
    return AICPU_ERROR_FAILED;
}

status_t GetAicpuRunModeStub2(uint32_t& runMode)
{
    runMode = 6U;
    return AICPU_ERROR_NONE;
}
} // namespace aicpu

class AicpuMemInfoProcessTEST : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    void SetUp() override
    {
        (void)unsetenv("BLOCK_CFG_PATH");
        (void)std::remove(TEST_JSON_PATH);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        (void)unsetenv("BLOCK_CFG_PATH");
        (void)std::remove(TEST_JSON_PATH);
    }

    void WriteJsonFile(const std::string& content)
    {
        std::ofstream file(TEST_JSON_PATH, std::ios::trunc);
        ASSERT_TRUE(file.is_open());
        file << content;
        ASSERT_TRUE(file.good());
    }
};

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoReturnsDefaultWhenEnvMissing)
{
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    BuffCfg buffCfg = {};
    buffCfg.cfg[0].cfg_id = 7U;

    const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffCfg);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(buffCfg.cfg[0].cfg_id, 0U);
}

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoPropagatesRunModeFailure)
{
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED));
    BuffCfg buffCfg = {};

    const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffCfg);

    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoReturnsPathFailure)
{
    (void)setenv("BLOCK_CFG_PATH", "./test", 1);
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::CheckPathValid).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_GET_PATH_FAILED));
    BuffCfg buffCfg = {};

    const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffCfg);

    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoMapsLoadFailure)
{
    (void)setenv("BLOCK_CFG_PATH", "./test/", 1);
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::CheckPathValid).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::LoadMemCfgFromFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_READ_JSON_FAILED));
    BuffCfg buffCfg = {};

    const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffCfg);

    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_READ_JSON_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoReturnsSuccess)
{
    (void)setenv("BLOCK_CFG_PATH", "./test", 1);
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::CheckPathValid).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::LoadMemCfgFromFile).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    BuffCfg buffCfg = {};

    const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffCfg);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileReturnsErrorForMissingFile)
{
    BuffCfg output = {};

    const auto ret = AicpuMemInfoProcess::LoadMemCfgFromFile("./missing_meminfo.json", output);

    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_READ_JSON_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileParsesEntriesAndSkipsUnknownValues)
{
    WriteJsonFile(R"json(
        {
            "0": {
                "cfg_id": 7,
                "total_size": 33554432,
                "blk_size": 256,
                "max_buf_size": 204800,
                "page_type": 1,
                "unknown_string": "quote:\" slash:\/ backslash:\\ controls:\b\f\n\r\t",
                "unknown_object": {"nested": {"text": "}"}},
                "unknown_array": [1, [2], "]"],
                "unknown_primitive": true
            },
            "1": {
                "page_type": +2,
                "max_buf_size": 4096,
                "blk_size": 128,
                "total_size": 8192,
                "cfg_id": -1
            }
        }
    )json");
    BuffCfg output = {};

    const auto ret = AicpuMemInfoProcess::LoadMemCfgFromFile(TEST_JSON_PATH, output);

    ASSERT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(output.cfg[0].cfg_id, 7U);
    EXPECT_EQ(output.cfg[0].total_size, 33554432ULL);
    EXPECT_EQ(output.cfg[0].blk_size, 256U);
    EXPECT_EQ(output.cfg[0].max_buf_size, 204800ULL);
    EXPECT_EQ(output.cfg[0].page_type, 1U);
    EXPECT_EQ(output.cfg[1].cfg_id, 0U);
    EXPECT_EQ(output.cfg[1].total_size, 8192ULL);
    EXPECT_EQ(output.cfg[1].page_type, 2U);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileAcceptsEmptyConfig)
{
    WriteJsonFile(" \t\n\r { } ");
    BuffCfg output = {};

    const auto ret = AicpuMemInfoProcess::LoadMemCfgFromFile(TEST_JSON_PATH, output);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileTruncatesAtMaximumEntryCount)
{
    WriteJsonFile(BuildConfig(static_cast<size_t>(BUFF_MAX_CFG_NUM) + 1U));
    BuffCfg output = {};

    const auto ret = AicpuMemInfoProcess::LoadMemCfgFromFile(TEST_JSON_PATH, output);

    ASSERT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(output.cfg[0].cfg_id, 0U);
    EXPECT_EQ(output.cfg[BUFF_MAX_CFG_NUM - 1].cfg_id, BUFF_MAX_CFG_NUM - 1U);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileRejectsMalformedContent)
{
    const std::string validEntry = BuildEntry(0U);
    const std::vector<std::string> invalidContents = {
        "",
        "[]",
        "{",
        "{0:{" + validEntry + "}}",
        "{\"1\":{" + validEntry + "}}",
        "{\"0\" {" + validEntry + "}}",
        "{\"0\":1}",
        "{\"0\":{cfg_id:0}}",
        "{\"0\":{\"cfg_id\" 0}}",
        "{\"0\":{\"cfg_id\":\"0\",\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,\"page_type\":0}}",
        "{\"0\":{\"cfg_id\":18446744073709551616,\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,"
        "\"page_type\":0}}",
        "{\"0\":{\"cfg_id\":1x,\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,\"page_type\":0}}",
        "{\"0\":{\"cfg_id\":-,\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,\"page_type\":0}}",
        "{\"0\":{\"cfg_id\":0,\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1}}",
        "{\"0\":{" + validEntry + ",}}",
        "{\"0\":{\"cfg_id\":0 \"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,\"page_type\":0}}",
        "{\"0\":{" + validEntry + "},}",
        "{\"0\":{" + validEntry + "} \"1\":{" + BuildEntry(1U) + "}}",
        "{\"0\":{" + validEntry + ",\"unknown\":\"bad\\q\"}}",
        "{\"0\":{" + validEntry + ",\"unknown\":[1,2}}",
    };

    for (const auto& content : invalidContents) {
        SCOPED_TRACE(content);
        WriteJsonFile(content);
        BuffCfg output = {};
        EXPECT_EQ(
            AicpuMemInfoProcess::LoadMemCfgFromFile(TEST_JSON_PATH, output), AICPU_SCHEDULE_ERROR_READ_JSON_FAILED);
    }
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidRejectsLongPath)
{
    const std::string cfgFullPath(PATH_MAX, 'a');

    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid(cfgFullPath), AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidReturnsErrorWhenRealpathFails)
{
    char_t* nullPath = nullptr;
    MOCKER(realpath).stubs().will(returnValue(nullPath));

    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid("/abc/"), AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidRejectsNonCanonicalPath)
{
    MOCKER(realpath).stubs().will(invoke(RealpathMismatchStub));

    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid("/abc/"), AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidReturnsErrorWhenMemsetFails)
{
    MOCKER(memset_s).stubs().will(returnValue(-1));

    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid("/abc/"), AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidAcceptsCanonicalPath)
{
    MOCKER(realpath).stubs().will(invoke(RealpathSuccessStub));

    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid("/abc/file.json"), AICPU_SCHEDULE_OK);
}

TEST_F(AicpuMemInfoProcessTEST, GetRunModeInfoFail)
{
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub1));

    EXPECT_EQ(AicpuMemInfoProcess::CheckRunMode(), AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, GetRunModeInfoSuccessForOtherMode)
{
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub2));

    EXPECT_EQ(AicpuMemInfoProcess::CheckRunMode(), AICPU_SCHEDULE_OK);
}

TEST_F(AicpuMemInfoProcessTEST, GetRunModeInfoSuccessForProcessSocketMode)
{
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub));

    EXPECT_EQ(AicpuMemInfoProcess::CheckRunMode(), AICPU_SCHEDULE_OK);
}
