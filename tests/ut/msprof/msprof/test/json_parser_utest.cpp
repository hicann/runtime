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
#include <vector>
#include <map>
#include "json_parser.h"
#include "json_api.h"
#include "ai_drv_prof_api.h"
#include "slog.h"
#include "prof_api.h"
#include "config.h"

#define UT_PROF_JSON_PATH "llt/abl/msprof/ut/stub/prof.json"

using namespace Msprofiler::Parser;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::config;
class JSON_PARSER_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(JSON_PARSER_UTEST, JsonParserInit) {
    uint32_t moduleId = ASCENDCL;
    uint32_t reporterId1 = API_EVENT;
    uint32_t reporterId2 = COMPACT;
    uint32_t channelId = AI_DRV_CHANNEL::PROF_CHANNEL_DVPP;

    JsonParser::instance()->UnInit();
    JsonParser::instance()->Init(UT_PROF_JSON_PATH);
    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleReporterSwitch(reporterId1));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleReporterSwitch(reporterId2));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleProfSwitch(moduleId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonModuleReporterBufferLen(reporterId1));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonChannelProfSwitch(channelId));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonChannelReporterSwitch(channelId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelReportBufferLen(channelId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelDriverBufferLen(channelId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelPeroid(channelId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelThreshold(channelId));
    JsonParser::instance()->UnInit();
}

TEST_F(JSON_PARSER_UTEST, JsonParserInit2) {
    uint32_t moduleId = GE;
    uint32_t channelId = AI_DRV_CHANNEL::PROF_CHANNEL_DDR;

    JsonParser::instance()->Init(UT_PROF_JSON_PATH);
    EXPECT_EQ(0, JsonParser::instance()->GetJsonModuleReporterBufferLen(moduleId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelPeroid(channelId));
}

TEST_F(JSON_PARSER_UTEST, JsonParserInit3) {
    uint32_t moduleId = RUNTIME;
    uint32_t channelId = AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG;

    JsonParser::instance()->Init(UT_PROF_JSON_PATH);
    EXPECT_EQ(0, JsonParser::instance()->GetJsonModuleReporterBufferLen(moduleId));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelThreshold(channelId));
}

class JSON_PARSER_JSON_NANO_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        JsonParser::instance()->UnInit();
    }
    virtual void TearDown()
    {
        system("rm -rf llt/abl/msprof/ut/stub/prof_nano_test.json");
    }
    void JsonGenerate(std::string str)
    {
        std::ofstream jsonFile("llt/abl/msprof/ut/stub/prof_nano_test.json");
        if (jsonFile.is_open()) {
            jsonFile << str;
        }
        jsonFile.close();
    }
};

TEST_F(JSON_PARSER_JSON_NANO_UTEST, JsonParserInitWithEmptyJson) {
    std::string str = "{}";
    JsonGenerate(str); 
    JsonParser::instance()->Init("llt/abl/msprof/ut/stub/prof_nano_test.json");
    EXPECT_EQ(0, JsonParser::instance()->channelParams_.size());
    EXPECT_EQ(0, JsonParser::instance()->moduleParams_.size());
    EXPECT_EQ(0, JsonParser::instance()->reporterParams_.size());
}

const std::string JsonParserCannStr = "{\n\
    \"profiler\": \"off\",\n\
    \"cann\": {\n\
        \"modules\": [\n\
            {\n\
                \"module\": \"ACL\"\n\
            },\n\
            {\n\
                \"module\": \"FRAMEWORK\",\n\
                \"prof_switch\": \"off\"\n\
            },\n\
            {\n\
                \"module\": \"RUNTIME\",\n\
                \"prof_switch\": \"on\"\n\
            }\n\
        ],\n\
        \"reporters\": [\n\
            {\n\
                \"reporter\": \"API_EVENT\",\n\
                \"reporter_switch\": \"on\"\n\
                \"report_buffer_len\": 16384\n\
            },\n\
            {\n\
                \"reporter\": \"COMPACT\",\n\
                \"report_buffer_len\": 50000\n\
                \"reporter_switch\": \"off\"\n\
            },\n\
            {\n\
                \"reporter\": \"ADDITIONAL\",\n\
                \"reporter_switch\": \"on\"\n\
            },\n\
            {\n\
                \"reporter\": \"error\",\n\
                \"reporter_switch\": \"off\"\n\
            }\n\
        ]\n\
    }\n}";

TEST_F(JSON_PARSER_JSON_NANO_UTEST, DISABLED_JsonParserInitWithCann)
{
    JsonGenerate(JsonParserCannStr); 
    JsonParser::instance()->Init("llt/abl/msprof/ut/stub/prof_nano_test.json");
    EXPECT_EQ(0, JsonParser::instance()->channelParams_.size());
    EXPECT_EQ(3, JsonParser::instance()->moduleParams_.size());
    EXPECT_EQ(3, JsonParser::instance()->reporterParams_.size());

    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleProfSwitch((uint32_t)ASCENDCL));
    EXPECT_EQ(false, JsonParser::instance()->GetJsonModuleProfSwitch((uint32_t)GE));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleProfSwitch((uint32_t)RUNTIME));

    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleReporterSwitch((uint32_t)API_EVENT));
    EXPECT_EQ(16384, JsonParser::instance()->GetJsonModuleReporterBufferLen((uint32_t)API_EVENT));

    EXPECT_EQ(false, JsonParser::instance()->GetJsonModuleReporterSwitch((uint32_t)COMPACT));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonModuleReporterBufferLen((uint32_t)COMPACT));

    EXPECT_EQ(true, JsonParser::instance()->GetJsonModuleReporterSwitch((uint32_t)ADDITIONAL));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonModuleReporterBufferLen((uint32_t)ADDITIONAL));
}

const std::string JsonParserDeviceStr = "{\n\
    \"device\": {\n\
        \"poll_peroid\": 10000,\n\
        \"channels\": [\n\
            {\n\
                \"channel\": 6\n\
            },\n\
            {\n\
                \"channel\": 45,\n\
                \"peroid\": 10000,\n\
                \"threshold\": 100,\n\
                \"channel_buffer_size\": 10,\n\
                \"driver_buffer_size\": 10,\n\
                \"prof_switch\": \"off\",\n\
                \"reporter_switch\": \"off\"\n\
            },\n\
            {\n\
                \"channel\": 48,\n\
                \"peroid\": 20,\n\
                \"threshold\": 20,\n\
                \"channel_buffer_size\": 2097152,\n\
                \"driver_buffer_size\": 100,\n\
                \"prof_switch\": \"on\",\n\
                \"reporter_switch\": \"on\"\n\
            },\n\
            {\n\
                \"channel\": \"ERROR\",\n\
                \"peroid\": 0,\n\
                \"threshold\": 1,\n\
                \"channel_buffer_size\": 0,\n\
                \"driver_buffer_size\": 0,\n\
                \"prof_switch\": \"on\",\n\
                \"reporter_switch\": \"off\"\n\
            }\n\
        ]\n\
    }\n}";

TEST_F(JSON_PARSER_JSON_NANO_UTEST, DISABLED_JsonParserInitWithDevice)
{
    JsonGenerate(JsonParserDeviceStr); 
    JsonParser::instance()->Init("llt/abl/msprof/ut/stub/prof_nano_test.json");
    EXPECT_EQ(3, JsonParser::instance()->channelParams_.size());
    EXPECT_EQ(0, JsonParser::instance()->moduleParams_.size());
    EXPECT_EQ(0, JsonParser::instance()->reporterParams_.size());

    EXPECT_EQ(true, JsonParser::instance()->GetJsonChannelReporterSwitch((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_DVPP));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonChannelProfSwitch((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_DVPP));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelReportBufferLen((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_DVPP));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelDriverBufferLen((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_DVPP));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelPeroid((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_DVPP));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelThreshold((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_DVPP));

    EXPECT_EQ(false, JsonParser::instance()->GetJsonChannelReporterSwitch((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG));
    EXPECT_EQ(false, JsonParser::instance()->GetJsonChannelProfSwitch((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelReportBufferLen((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG));
    EXPECT_EQ(10, JsonParser::instance()->GetJsonChannelDriverBufferLen((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelPeroid((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG));
    EXPECT_EQ(0, JsonParser::instance()->GetJsonChannelThreshold((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG));

    EXPECT_EQ(true, JsonParser::instance()->GetJsonChannelReporterSwitch((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG));
    EXPECT_EQ(true, JsonParser::instance()->GetJsonChannelProfSwitch((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG));
    EXPECT_EQ(2097152, JsonParser::instance()->GetJsonChannelReportBufferLen((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG));
    EXPECT_EQ(100, JsonParser::instance()->GetJsonChannelDriverBufferLen((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG));
    EXPECT_EQ(20, JsonParser::instance()->GetJsonChannelPeroid((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG));
    EXPECT_EQ(20, JsonParser::instance()->GetJsonChannelThreshold((uint32_t)AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG));
}