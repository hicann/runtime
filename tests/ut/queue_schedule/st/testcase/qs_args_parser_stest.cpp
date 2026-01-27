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
#include "bqs_log.h"
#include "bqs_feature_ctrl.h"
#define private public
#include "qs_args_parser.h"
#undef private

using namespace bqs;

class QsArgsParserStest : public ::testing::Test {
public:
    virtual void SetUp() {}

    virtual void TearDown() {}
};

TEST_F(QsArgsParserStest, ParseArgsSuccess1)
{
    const pid_t hostPid = 15600;
    const uint32_t vfId = 5U;
    const std::string pidSign = "00000000";
    const uint32_t expectedLogLevel = 2U;
    const uint32_t expectedEventLevel = 3U;
    const std::vector<std::string> startParams = {
        PARAM_DEVICEID + "1",
        PARAM_HOST_PID + std::to_string(hostPid),
        PARAM_PIDSIGN + pidSign,
        PARAM_LOGLEVEL + "302",
        PARAM_VFID + std::to_string(vfId),
        PARAM_GRP_NAME + "grpa"
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(startParams);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 1);
    EXPECT_EQ(argsParser.GetHostPid(), hostPid);
    EXPECT_STREQ(argsParser.GetPidSign().c_str(), pidSign.c_str());
    EXPECT_EQ(argsParser.GetLogLevel(), expectedLogLevel);
    EXPECT_EQ(argsParser.GetEventLevel(), expectedEventLevel);
    EXPECT_EQ(argsParser.GetVfId(), vfId);
}

TEST_F(QsArgsParserStest, ParseArgsSuccess2)
{
    // with unknown input para
    const pid_t hostPid = 15600;
    const uint32_t vfId = 5U;
    const std::string pidSign = "00000000";
    const uint32_t expectedLogLevel = 2U;
    const uint32_t expectedEventLevel = 3U;
    const std::vector<std::string> startParams = {
        PARAM_DEVICEID + "1",
        PARAM_HOST_PID + std::to_string(hostPid),
        PARAM_PIDSIGN + pidSign,
        PARAM_LOGLEVEL + "302",
        PARAM_VFID + std::to_string(vfId),
        PARAM_GRP_NAME + "grpa",
        "--unknownKey=0"
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(startParams);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 1);
    EXPECT_EQ(argsParser.GetHostPid(), hostPid);
    EXPECT_STREQ(argsParser.GetPidSign().c_str(), pidSign.c_str());
    EXPECT_EQ(argsParser.GetLogLevel(), expectedLogLevel);
    EXPECT_EQ(argsParser.GetEventLevel(), expectedEventLevel);
    EXPECT_EQ(argsParser.GetVfId(), vfId);
}

TEST_F(QsArgsParserStest, ParseArgsFail1)
{
    // missed required para
    const pid_t hostPid = 15600;
    const uint32_t vfId = 5U;
    const std::string pidSign = "00000000";

    const std::vector<std::string> startParams = {
        PARAM_DEVICEID + "100",
        PARAM_HOST_PID + std::to_string(hostPid),
        PARAM_PIDSIGN + pidSign,
        PARAM_LOGLEVEL + "302",
        PARAM_VFID + std::to_string(vfId),
        PARAM_GRP_NAME + "grpa"
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(startParams);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseArgsFail2)
{
    // missed required para
    const uint32_t vfId = 5U;
    const std::string pidSign = "00000000";

    const std::vector<std::string> startParams = {
        PARAM_DEVICEID + "1",
        PARAM_PIDSIGN + pidSign,
        PARAM_LOGLEVEL + "302",
        PARAM_VFID + std::to_string(vfId),
        PARAM_GRP_NAME + "grpa"
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(startParams);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseArgsFail3)
{
    ArgsParser argsParser;
    int32_t argc = 0;
    const char *argv[] = {
        "--deviceId=1",
    };
    const bool ret = argsParser.ParseArgs(argc, argv);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseSingleParaSuccess)
{
    const std::string singlePara = "--deviceId=1";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 1);
}

TEST_F(QsArgsParserStest, ParseSingleParaFail1)
{
    // No "=" in input para
    const std::string singlePara = "--deviceId";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseSingleParaFail2)
{
    // unknown key in para
    const std::string singlePara = "--fakeKey=1";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseSingleParaFail3)
{
    // invalid value in para
    const std::string singlePara = "--deviceId=-156";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, GetParaParsedStrSuccess)
{
    pid_t expectedHostPid = 2;
    uint32_t expectedVfId = 3;
    uint32_t expectedLogLevel = 4;
    ArgsParser argsParser;
    argsParser.deviceId_ = 1;
    argsParser.hostPid_ = expectedHostPid;
    argsParser.pidSign_ = "00000";
    argsParser.vfId_ = expectedVfId;
    argsParser.logLevel_ = expectedLogLevel;
    argsParser.aicpulogLevel_ = -1;
    std::string expectedParsedStr = "deviceId=1, hostPid=2, pidSign=00000, vfId=3, logLevel=4, ";
    expectedParsedStr.append("eventLevel_=1, aicpulogLevel=-1, deployMode_=0, reschedInterval_=30, ");
    expectedParsedStr.append("groupName_=, schedPolicy_=0, starter_=0, profCfgData_=, profFlag_=0, ");
    expectedParsedStr.append("abnormalInterval_=10, withDeviceId_=0, withHostPid_=0, withPidSign_=0, ");
    expectedParsedStr.append("withVfId_=, withLogLevel_=0, withGroupName_=0, withStarter_=0");
    EXPECT_STREQ(argsParser.GetParaParsedStr().c_str(), expectedParsedStr.c_str());
}

TEST_F(QsArgsParserStest, ParseDeviceIdSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseDeviceId(para);
    EXPECT_EQ(ret, true);
    uint32_t deviceId = argsParser.GetDeviceId();
    EXPECT_EQ(deviceId, 1);
}

TEST_F(QsArgsParserStest, ParseDeviceIdFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseDeviceId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseDeviceIdFail2)
{
    ArgsParser argsParser;
    const std::string para = "99999";
    const bool ret = argsParser.ParseDeviceId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseVfIdSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseVfId(para);
    EXPECT_EQ(ret, true);
    uint32_t vfId = argsParser.GetVfId();
    EXPECT_EQ(vfId, 1);
}

TEST_F(QsArgsParserStest, ParseVfIdFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseVfId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseVfIdFail2)
{
    ArgsParser argsParser;
    const std::string para = "99999";
    const bool ret = argsParser.ParseVfId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseAicpuLogLevel001)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseAicpuLogLevel(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseAicpuLogLevel002)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseAicpuLogLevel(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseHostPidSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseHostPid(para);
    EXPECT_EQ(ret, true);
    const pid_t pid = argsParser.GetHostPid();
    EXPECT_EQ(pid, 1);
}

TEST_F(QsArgsParserStest, ParseHostPidFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseHostPid(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseHostPidFail2)
{
    ArgsParser argsParser;
    const std::string para = "-99999";
    const bool ret = argsParser.ParseHostPid(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseLogAndEventLevelSuccess)
{
    ArgsParser argsParser;
    const std::string para = "102";
    const bool ret = argsParser.ParseLogAndEventLevel(para);
    EXPECT_EQ(ret, true);
    const int32_t logLevel = argsParser.GetLogLevel();
    const int32_t expectedLogLevel = 2;
    EXPECT_EQ(logLevel, expectedLogLevel);
    const int32_t eventLevel = argsParser.GetEventLevel();
    EXPECT_EQ(eventLevel, 1);
    MOCKER(dlog_setlevel).stubs().will(returnValue(0));
    MOCKER(DlogSetAttr).stubs().will(returnValue(-1));
    argsParser.SetLogLevel(1, 1);
}

TEST_F(QsArgsParserStest, ParseLogAndEventLevelSuccessHost)
{
    ArgsParser argsParser;
    const std::string para = "102";
    const bool ret = argsParser.ParseLogAndEventLevel(para);
    EXPECT_EQ(ret, true);
    const int32_t logLevel = argsParser.GetLogLevel();
    const int32_t expectedLogLevel = 2;
    EXPECT_EQ(logLevel, expectedLogLevel);
    const int32_t eventLevel = argsParser.GetEventLevel();
    EXPECT_EQ(eventLevel, 1);
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs)
        .stubs()
        .will(returnValue(true));
    argsParser.SetLogLevel(1, 1);
}

TEST_F(QsArgsParserStest, ParseLogAndEventLevelFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseLogAndEventLevel(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseLogAndEventLevelFail2)
{
    ArgsParser argsParser;
    const std::string para = "-1";
    const bool ret = argsParser.ParseLogAndEventLevel(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseSignSuccess)
{
    ArgsParser argsParser;
    const std::string para = "000000000000000000000000000000000000000000000000";
    const bool ret = argsParser.ParsePidSign(para);
    EXPECT_EQ(ret, true);
    const std::string pidSign = argsParser.GetPidSign();
    EXPECT_STREQ(pidSign.c_str(), pidSign.c_str());
}

TEST_F(QsArgsParserStest, ParseSchedPolicy)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseSchedPolicy(para);
    EXPECT_EQ(ret, false);
}

TEST_F(QsArgsParserStest, ParseReschedInterval)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseReschedInterval(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseProfFlag_001)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseProfFlag(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseProfFlag_002)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseProfFlag(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseAbnormalInterval_001)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseAbnormalInterval(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseAbnormalInterval_002)
{
    ArgsParser argsParser;
    const std::string para = "-1";
    const bool ret = argsParser.ParseAbnormalInterval(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseResourceList_001)
{
    ArgsParser argsParser;
    const std::string para = "0,1";
    const bool ret = argsParser.ParseResourceList(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseResourceList_002)
{
    ArgsParser argsParser;
    const std::string para = "-1,1";
    const bool ret = argsParser.ParseResourceList(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseResourceList_003)
{
    ArgsParser argsParser;
    const std::string para = "0,-1";
    const bool ret = argsParser.ParseResourceList(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseStarter)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseStarter(para);
    EXPECT_EQ(ret, true);
}

TEST_F(QsArgsParserStest, ParseProfCfgData)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseProfCfgData(para);
    EXPECT_EQ(ret, true);
}