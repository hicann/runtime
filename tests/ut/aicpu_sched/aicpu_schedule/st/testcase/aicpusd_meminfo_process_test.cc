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
#include <fstream>
#include <string>
#include <vector>
#include "aicpu_context.h"
#define private public
#include "core/aicpusd_meminfo_process.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

namespace {
const char_t* const TEST_JSON_PATH = "./aicpusd_meminfo_process_st.json";
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
    buffCfg.cfg[0].cfg_id = 1U;

    const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffCfg);

    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(buffCfg.cfg[0].cfg_id, 0U);
}

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoMapsPathAndLoadFailures)
{
    (void)setenv("BLOCK_CFG_PATH", "./test", 1);
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::CheckPathValid).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_GET_PATH_FAILED));
    BuffCfg buffCfg = {};
    EXPECT_EQ(AicpuMemInfoProcess::GetMemZoneInfo(buffCfg), AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
    GlobalMockObject::verify();

    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::CheckPathValid).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::LoadMemCfgFromFile)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_READ_JSON_FAILED));
    EXPECT_EQ(AicpuMemInfoProcess::GetMemZoneInfo(buffCfg), AICPU_SCHEDULE_ERROR_READ_JSON_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, GetMemZoneInfoReturnsSuccessWhenLoadSucceeds)
{
    (void)setenv("BLOCK_CFG_PATH", "./test/", 1);
    MOCKER_CPP(AicpuMemInfoProcess::CheckRunMode).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::CheckPathValid).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER_CPP(AicpuMemInfoProcess::LoadMemCfgFromFile).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    BuffCfg buffCfg = {};

    EXPECT_EQ(AicpuMemInfoProcess::GetMemZoneInfo(buffCfg), AICPU_SCHEDULE_OK);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileParsesRealFile)
{
    WriteJsonFile(R"json(
        {
            "0": {
                "cfg_id": 0,
                "total_size": 33554432,
                "blk_size": 256,
                "max_buf_size": 204800,
                "page_type": 0,
                "metadata": {"labels": ["a", "b"]}
            },
            "1": {
                "cfg_id": 1,
                "total_size": 1048576,
                "blk_size": 128,
                "max_buf_size": 4096,
                "page_type": 1
            }
        }
    )json");
    BuffCfg output = {};

    const auto ret = AicpuMemInfoProcess::LoadMemCfgFromFile(TEST_JSON_PATH, output);

    ASSERT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(output.cfg[0].cfg_id, 0U);
    EXPECT_EQ(output.cfg[0].total_size, 33554432ULL);
    EXPECT_EQ(output.cfg[0].blk_size, 256U);
    EXPECT_EQ(output.cfg[0].max_buf_size, 204800ULL);
    EXPECT_EQ(output.cfg[0].page_type, 0U);
    EXPECT_EQ(output.cfg[1].cfg_id, 1U);
    EXPECT_EQ(output.cfg[1].total_size, 1048576ULL);
    EXPECT_EQ(output.cfg[1].page_type, 1U);
}

TEST_F(AicpuMemInfoProcessTEST, LoadMemCfgFromFileRejectsInvalidFiles)
{
    const std::vector<std::string> invalidContents = {
        "not-json",
        "{\"1\":{\"cfg_id\":0,\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,\"page_type\":0}}",
        "{\"0\":{\"cfg_id\":0}}",
        "{\"0\":{\"cfg_id\":\"zero\",\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,"
        "\"page_type\":0}}",
        "{\"0\":{\"cfg_id\":0,\"total_size\":1,\"blk_size\":1,\"max_buf_size\":1,\"page_type\":0},}",
    };

    for (const auto& content : invalidContents) {
        SCOPED_TRACE(content);
        WriteJsonFile(content);
        BuffCfg output = {};
        EXPECT_EQ(
            AicpuMemInfoProcess::LoadMemCfgFromFile(TEST_JSON_PATH, output), AICPU_SCHEDULE_ERROR_READ_JSON_FAILED);
    }
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidAcceptsRealCanonicalPath)
{
    WriteJsonFile("{}");
    char_t canonicalPath[PATH_MAX] = {};
    ASSERT_NE(realpath(TEST_JSON_PATH, canonicalPath), nullptr);

    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid(canonicalPath), AICPU_SCHEDULE_OK);
}

TEST_F(AicpuMemInfoProcessTEST, CheckPathValidRejectsMissingPath)
{
    EXPECT_EQ(AicpuMemInfoProcess::CheckPathValid("/missing/aicpu_meminfo.json"), AICPU_SCHEDULE_ERROR_GET_PATH_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, CheckRunModeReturnsErrorWhenQueryFails)
{
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub1));

    EXPECT_EQ(AicpuMemInfoProcess::CheckRunMode(), AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED);
}

TEST_F(AicpuMemInfoProcessTEST, CheckRunModeAcceptsSupportedAndOtherModes)
{
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub2));
    EXPECT_EQ(AicpuMemInfoProcess::CheckRunMode(), AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();

    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub));
    EXPECT_EQ(AicpuMemInfoProcess::CheckRunMode(), AICPU_SCHEDULE_OK);
}
