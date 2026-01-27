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
#include <nlohmann/json.hpp>
#include <cstdlib>
#include <fstream>
#include "aicpu_context.h"
#include <core/aicpusd_meminfo_process.h>

using namespace nlohmann;
using namespace AicpuSchedule;
using namespace aicpu;

namespace aicpu {
    status_t GetAicpuRunModeStub(uint32_t &runMode)
    {
        std::cout << "GetAicpuRunMode at stub" << std::endl;
        runMode = AicpuRunMode::PROCESS_SOCKET_MODE; // MDC
        return AICPU_ERROR_NONE;
    }

    status_t GetAicpuRunModeStub1(uint32_t &runMode)
    {
        std::cout << "GetAicpuRunMode at stub" << std::endl;
        runMode = 3U; // Invalid Mode
        return AICPU_ERROR_FAILED;
    }

    status_t GetAicpuRunModeStub2(uint32_t &runMode)
    {
        std::cout << "GetAicpuRunMode at stub" << std::endl;
        runMode = 3U; // Invalid Mode
        return AICPU_ERROR_NONE;
    }
}

class AICPUJsonReadTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUJsonReadTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUJsonReadTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUJsonReadTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUJsonReadTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailZero1) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailZero2) {
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailOne) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailOne_1) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(21008));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailTwo) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    char buf[6] = {"test"};
    char *p = buf;
    MOCKER_CPP(realpath)
    .stubs()
    .will(returnValue(p));
    MOCKER_CPP(AicpuJsonRead::ReadJsonFile)
    .stubs()
    .will(returnValue(1));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailTree) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::CheckPathValid)
    .stubs()
    .will(returnValue(1));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailFour) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::CheckPathValid)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::ReadJsonFile)
    .stubs()
    .will(returnValue(1));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoFailFive) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::CheckPathValid)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::ReadJsonFile)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::ParseCfgData)
    .stubs()
    .will(returnValue(1));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, GetMemZoneInfoSuccess) {
    setenv("BLOCK_MODE_PATH", "./test", 1);
    MOCKER_CPP(AicpuJsonRead::CheckRunModeForMdc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::CheckPathValid)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::ReadJsonFile)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(AicpuJsonRead::ParseCfgData)
    .stubs()
    .will(returnValue(0));
    BuffCfg buffCfg;
    int32_t ret = AicpuJsonRead::GetMemZoneInfo(buffCfg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    unsetenv("BLOCK_MODE_PATH");
}

TEST_F(AICPUJsonReadTEST, ReadJsonFileFail) {
    const std::string filePath= "./test/aifmk/test.json";
    json jsonRead;
    int32_t ret = AicpuJsonRead::ReadJsonFile(filePath, jsonRead);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUJsonReadTEST, ReadJsonFileFailTwo) {

    const std::string filePath= "./test.json";
    std::ofstream file(filePath, std::ios::trunc | std::ios::out | std::ios::in);
    json input;
    input["0"]["cfg_id"] = 1;
    file << input;
    file.close();
    json jsonRead;
    int32_t ret = AicpuJsonRead::ReadJsonFile(filePath, jsonRead);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUJsonReadTEST, ReadJsonFileFailThree) {
    const std::string filePath= "./test.json";
    std::ofstream file(filePath, std::ios::trunc | std::ios::out | std::ios::in);
    std::string input("{test}");
    file << input;
    file.close();
    json jsonRead;
    int32_t ret = AicpuJsonRead::ReadJsonFile(filePath, jsonRead);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUJsonReadTEST, ParseCfgDataSuccess) {
    json input;
    std::string k = "0";
    input[k]["cfg_id"] = 0U;
    input[k]["total_size"] = 33554432U;
    input[k]["blk_size"] = 256U;
    input[k]["max_buf_size"] = 204800U;
    input[k]["page_type"] = 0U;
    BuffCfg output;
    int32_t ret = AicpuJsonRead::ParseCfgData(input, output);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUJsonReadTEST, ParseCfgDataFail) {
    json input;
    std::string k = "1";
    input[k]["cfg_id"] = 0U;
    input[k]["total_size"] = 33554432U;
    input[k]["blk_size"] = 256U;
    input[k]["max_buf_size"] = 204800U;
    input[k]["page_type"] = 0U;
    BuffCfg output;
    int32_t ret = AicpuJsonRead::ParseCfgData(input, output);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUJsonReadTEST, CheckPathValidFailed0) {
    std::string cfgFullPath = "/abc/";
    char *a = nullptr;
    MOCKER(realpath)
        .stubs()
        .will(returnValue(a));
    auto ret = AicpuJsonRead::CheckPathValid(cfgFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUJsonReadTEST, CheckPathValidFailed1) {
    std::string cfgFullPath = "/abc/";
    char buf[6] = {"/abc/"};
    char *p = buf;
    MOCKER(realpath)
        .stubs()
        .will(returnValue(p));
    auto ret = AicpuJsonRead::CheckPathValid(cfgFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUJsonReadTEST, GetRunModeInfoFail_1) {

    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeStub1));
    auto ret = AicpuJsonRead::CheckRunModeForMdc();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUJsonReadTEST, GetRunModeInfoSuccess_1) {

    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeStub2));
    auto ret = AicpuJsonRead::CheckRunModeForMdc();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUJsonReadTEST, GetRunModeInfoSuccess_2) {

    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeStub));
    auto ret = AicpuJsonRead::CheckRunModeForMdc();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}