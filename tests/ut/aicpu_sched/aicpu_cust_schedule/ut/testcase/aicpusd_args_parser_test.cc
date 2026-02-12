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
#define private public
#include "aicpusd_args_parser.h"
#undef private

using namespace AicpuSchedule;

class AicpuSdArgsParserTest : public ::testing::Test {
public:
    virtual void SetUp() {}

    virtual void TearDown() {}
};

TEST_F(AicpuSdArgsParserTest, ParseArgsSuccess1)
{
    const pid_t hostPid = 15600;
    const pid_t aicpuPid = 456;
    const uint32_t vfId = 5U;
    const std::string pidSign = "00000000";
    const uint32_t expectedLogLevel = 2U;
    const uint32_t expectedEventLevel = 3U;
    const uint32_t expectedGrpNum = 3U;
    const std::string expectedSoPath = "/home/CustAicpu";
    const std::vector<std::string> expectedGrpName = {"GrpA", "GrpB", "Grp3"};

    const int32_t argc = 10;
    const char *argv[] = {
        "--deviceId=1",
        "--pid=15600",
        "--pidSign=00000000",
        "--profilingMode=1",
        "--custSoPath=/home/CustAicpu",
        "--aicpuPid=456",
        "--logLevelInPid=302",
        "--vfId=5",
        "--groupNameNum=3",
        "--groupNameList=GrpA,GrpB,Grp3",
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(argc, argv);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 1);
    EXPECT_EQ(argsParser.GetHostPid(), hostPid);
    EXPECT_STREQ(argsParser.GetPidSign().c_str(), pidSign.c_str());
    EXPECT_EQ(argsParser.GetProfilingMode(), 1);
    EXPECT_STREQ(argsParser.GetCustSoPath().c_str(), expectedSoPath.c_str());
    EXPECT_EQ(argsParser.GetAicpuPid(), aicpuPid);
    EXPECT_EQ(argsParser.GetLogLevel(), expectedLogLevel);
    EXPECT_EQ(argsParser.GetEventLevel(), expectedEventLevel);
    EXPECT_EQ(argsParser.GetVfId(), vfId);
    EXPECT_EQ(argsParser.GetGrpNameNum(), expectedGrpNum);
    const std::vector<std::string> grpName = argsParser.GetGrpNameList();
    for (uint32_t i = 0; i < grpName.size(); i++) {
        EXPECT_STREQ(grpName[i].c_str(), expectedGrpName[i].c_str());
    }
}

TEST_F(AicpuSdArgsParserTest, ParseArgsSuccess2)
{
    // with unknown input para
    const pid_t hostPid = 15600;
    const pid_t aicpuPid = 456;
    const uint32_t vfId = 5U;
    const std::string pidSign = "00000000";
    const uint32_t expectedLogLevel = 2U;
    const uint32_t expectedEventLevel = 3U;
    const uint32_t expectedGrpNum = 3U;
    const std::string expectedSoPath = "/home/CustAicpu";
    const std::vector<std::string> expectedGrpName = {"GrpA", "GrpB", "Grp3"};

    const int32_t argc = 11;
    const char *argv[] = {
        "--deviceId=1",
        "--pid=15600",
        "--pidSign=00000000",
        "--profilingMode=1",
        "--custSoPath=/home/CustAicpu",
        "--aicpuPid=456",
        "--logLevelInPid=302",
        "--vfId=5",
        "--groupNameNum=3",
        "--groupNameList=GrpA,GrpB,Grp3",
        "--unknownKey=0"
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(argc, argv);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 1);
    EXPECT_EQ(argsParser.GetHostPid(), hostPid);
    EXPECT_STREQ(argsParser.GetPidSign().c_str(), pidSign.c_str());
    EXPECT_EQ(argsParser.GetProfilingMode(), 1);
    EXPECT_STREQ(argsParser.GetCustSoPath().c_str(), expectedSoPath.c_str());
    EXPECT_EQ(argsParser.GetAicpuPid(), aicpuPid);
    EXPECT_EQ(argsParser.GetLogLevel(), expectedLogLevel);
    EXPECT_EQ(argsParser.GetEventLevel(), expectedEventLevel);
    EXPECT_EQ(argsParser.GetVfId(), vfId);
    EXPECT_EQ(argsParser.GetGrpNameNum(), expectedGrpNum);
    std::vector<std::string> grpName = argsParser.GetGrpNameList();
    for (uint32_t i = 0; i < grpName.size(); i++) {
        EXPECT_STREQ(grpName[i].c_str(), expectedGrpName[i].c_str());
    }
}

TEST_F(AicpuSdArgsParserTest, ParseArgsSuccess3)
{
    // with overflow profiling mode
    const pid_t hostPid = 369829;
    const pid_t aicpuPid = 7801;
    const uint32_t vfId = 0U;
    const std::string pidSign = "000000000000000000000000000000000000000000000000";
    const uint32_t expectedLogLevel = 3U;
    const uint32_t expectedEventLevel = 1U;
    const uint32_t expectedGrpNum = 0U;
    const std::string expectedSoPath = "";
    const std::vector<std::string> expectedGrpName = {};

    const int32_t argc = 10;
    const char *argv[] = {
        "--deviceId=0",
        "--pid=369829",
        "--pidSign=000000000000000000000000000000000000000000000000",
        "--profilingMode=2684354579",
        "--custSoPath=",
        "--aicpuPid=7801",
        "--logLevelInPid=103",
        "--vfId=0",
        "--groupNameNum=0",
        "--groupNameList="
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(argc, argv);

    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 0);
    EXPECT_EQ(argsParser.GetHostPid(), hostPid);
    EXPECT_STREQ(argsParser.GetPidSign().c_str(), pidSign.c_str());
    EXPECT_EQ(argsParser.GetProfilingMode(), 2684354579);
    EXPECT_STREQ(argsParser.GetCustSoPath().c_str(), expectedSoPath.c_str());
    EXPECT_EQ(argsParser.GetAicpuPid(), aicpuPid);
    EXPECT_EQ(argsParser.GetLogLevel(), expectedLogLevel);
    EXPECT_EQ(argsParser.GetEventLevel(), expectedEventLevel);
    EXPECT_EQ(argsParser.GetVfId(), vfId);
    EXPECT_EQ(argsParser.GetGrpNameNum(), expectedGrpNum);
    EXPECT_EQ(argsParser.GetGrpNameList().size(), expectedGrpNum);
    std::vector<std::string> grpName = argsParser.GetGrpNameList();
}

TEST_F(AicpuSdArgsParserTest, ParseArgsFail1)
{
    const int32_t argc = 10;
    const char *argv[] = {
        "--deviceId=1",
        "--pid=15600",
        "--pidSign=00000000",
        "--profilingMode=1",
        "--custSoPath=/home/CustAicpu",
        "--aicpuPid=456",
        "--logLevelInPid=302",
        "--vfId=9999",
        "--groupNameNum=3",
        "--groupNameList=GrpA,GrpB,Grp3",
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(argc, argv);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseArgsFail2)
{
    const int32_t argc = 8;
    const char *argv[] = {
        "--deviceId=1",
        "--pid=15600",
        "--pidSign=00000000",
        "--profilingMode=1",
        "--custSoPath=/home/CustAicpu",
        "--logLevelInPid=302",
        "--groupNameNum=3",
        "--groupNameList=GrpA,GrpB,Grp3",
    };

    ArgsParser argsParser;
    const bool ret = argsParser.ParseArgs(argc, argv);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseSingleParaSuccess)
{
    const std::string singlePara = "--deviceId=1";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(argsParser.GetDeviceId(), 1);
}

TEST_F(AicpuSdArgsParserTest, ParseSingleParaFail1)
{
    // No "=" in input para
    const std::string singlePara = "--deviceId";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuSdArgsParserTest, ParseSingleParaFail2)
{
    // unknown key in para
    const std::string singlePara = "--fakeKey=1";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuSdArgsParserTest, ParseSingleParaFail3)
{
    // invalid value in para
    const std::string singlePara = "--deviceId=-156";
    ArgsParser argsParser;
    const bool ret = argsParser.ParseSinglePara(singlePara);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, GetParaParsedStrSuccess)
{
    pid_t expectedHostPid = 2;
    uint32_t expectedVfId = 3;
    uint32_t expectedLogLevel = 4;
    uint32_t expectedGrpNameNum = 3;

    ArgsParser argsParser;
    argsParser.deviceId_ = 1;
    argsParser.hostPid_ = expectedHostPid;
    argsParser.pidSign_ = "00000";
    argsParser.aicpuPid_ = 6;
    argsParser.custSoPath_ = "/home";
    argsParser.profilingMode_ = 1;
    argsParser.vfId_ = expectedVfId;
    argsParser.logLevel_ = expectedLogLevel;
    argsParser.ccecpulogLevel_ = -1;
    argsParser.aicpulogLevel_ = -1;
    argsParser.grpNameNum_ = expectedGrpNameNum;
    argsParser.grpNameList_ = {"GrpA", "_Grp_B", "__--*Grp_C"};
    std::string expectedParsedStr = "deviceId=1, hostPid=2, pidSign=00000, profilingMode=1, vfId=3, logLevel=4, ";
    expectedParsedStr.append("ccecpulogLevel=-1, aicpulogLevel=-1, ")
                     .append("aicpuPid=6, grpNameNum=3, grpNameList=[GrpA,_Grp_B,__--*Grp_C,], ")
                     .append("custSoPath=/home, ")
                     .append("ctrolCpuList=[], ")
                     .append("tsdPid=0");
    EXPECT_STREQ(argsParser.GetParaParsedStr().c_str(), expectedParsedStr.c_str());
}

TEST_F(AicpuSdArgsParserTest, ParseDeviceIdSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseDeviceId(para);
    EXPECT_EQ(ret, true);
    uint32_t deviceId = argsParser.GetDeviceId();
    EXPECT_EQ(deviceId, 1);
}

TEST_F(AicpuSdArgsParserTest, ParseDeviceIdFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseDeviceId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseDeviceIdFail2)
{
    ArgsParser argsParser;
    const std::string para = "99999";
    const bool ret = argsParser.ParseDeviceId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseVfIdSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseVfId(para);
    EXPECT_EQ(ret, true);
    uint32_t vfId = argsParser.GetVfId();
    EXPECT_EQ(vfId, 1);
}

TEST_F(AicpuSdArgsParserTest, ParseVfIdFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseVfId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseVfIdFail2)
{
    ArgsParser argsParser;
    const std::string para = "99999";
    const bool ret = argsParser.ParseVfId(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseCcecpuLogLevel001)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseCcecpuLogLevel(para);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuSdArgsParserTest, ParseCcecpuLogLevel002)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseCcecpuLogLevel(para);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuSdArgsParserTest, ParseAicpuLogLevel001)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseAicpuLogLevel(para);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuSdArgsParserTest, ParseAicpuLogLevel002)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseAicpuLogLevel(para);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuSdArgsParserTest, ParseAicpuPidSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseAicpuPid(para);
    EXPECT_EQ(ret, true);
    const pid_t pid = argsParser.GetAicpuPid();
    EXPECT_EQ(pid, 1);
}

TEST_F(AicpuSdArgsParserTest, ParseAicpuPidFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseAicpuPid(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseAicpuPidFail2)
{
    ArgsParser argsParser;
    const std::string para = "-99999";
    const bool ret = argsParser.ParseAicpuPid(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseHostPidSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseHostPid(para);
    EXPECT_EQ(ret, true);
    const pid_t pid = argsParser.GetHostPid();
    EXPECT_EQ(pid, 1);
}

TEST_F(AicpuSdArgsParserTest, ParseHostPidFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseHostPid(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseHostPidFail2)
{
    ArgsParser argsParser;
    const std::string para = "-99999";
    const bool ret = argsParser.ParseHostPid(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseProfilingModeSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseProfilingMode(para);
    EXPECT_EQ(ret, true);
    const uint32_t profilingMode = static_cast<uint32_t>(argsParser.GetProfilingMode());
    EXPECT_EQ(profilingMode, 1);
}

TEST_F(AicpuSdArgsParserTest, ParseProfilingModeFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseProfilingMode(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseGrpNameNumSuccess)
{
    ArgsParser argsParser;
    const std::string para = "1";
    const bool ret = argsParser.ParseGrpNameNum(para);
    EXPECT_EQ(ret, true);
    const uint32_t grpNameNum = argsParser.GetGrpNameNum();
    EXPECT_EQ(grpNameNum, 1);
}

TEST_F(AicpuSdArgsParserTest, ParseGrpNameNumFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseGrpNameNum(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseGrpNameNumFail2)
{
    ArgsParser argsParser;
    const std::string para = "-1";
    const bool ret = argsParser.ParseGrpNameNum(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseLogAndEventLevelSuccess)
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
}

TEST_F(AicpuSdArgsParserTest, ParseLogAndEventLevelFail1)
{
    ArgsParser argsParser;
    const std::string para = "asd";
    const bool ret = argsParser.ParseLogAndEventLevel(para);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuSdArgsParserTest, ParseLogAndEventLevelFail2)
{
    ArgsParser argsParser;
    const std::string para = "-1";
    const bool ret = argsParser.ParseLogAndEventLevel(para);
    EXPECT_EQ(ret, false);
}


TEST_F(AicpuSdArgsParserTest, ParseSignSuccess)
{
    ArgsParser argsParser;
    const std::string para = "000000000000000000000000000000000000000000000000";
    const bool ret = argsParser.ParseSign(para);
    EXPECT_EQ(ret, true);
    const std::string pidSign = argsParser.GetPidSign();
    EXPECT_STREQ(pidSign.c_str(), pidSign.c_str());
}

TEST_F(AicpuSdArgsParserTest, ParseGrpNameListSuccess)
{
    ArgsParser argsParser;
    const std::string para = "GroupA,Group_B,Group_C";
    const bool ret = argsParser.ParseGrpNameList(para);
    EXPECT_EQ(ret, true);
    const std::vector<std::string> grpName = argsParser.GetGrpNameList();
    const std::vector<std::string> expectedGrpName = {"GroupA", "Group_B", "Group_C"};

    EXPECT_EQ(expectedGrpName.size(), grpName.size());
    for (uint32_t i = 0; i < grpName.size(); i++) {
        EXPECT_STREQ(grpName[i].c_str(), expectedGrpName[i].c_str());
    }
}

TEST_F(AicpuSdArgsParserTest, SplitGrpNameList)
{
    const std::string para = "GroupA,Group_B,Group_C";
    std::vector<std::string> splitedName;
    ArgsParser::SplitGrpNameList(para, splitedName);
    const std::vector<std::string> expectedGrpName = {"GroupA", "Group_B", "Group_C"};

    EXPECT_EQ(expectedGrpName.size(), splitedName.size());
    for (uint32_t i = 0; i < splitedName.size(); i++) {
        EXPECT_STREQ(splitedName[i].c_str(), expectedGrpName[i].c_str());
    }
}

TEST_F(AicpuSdArgsParserTest, GetControlCpuListSuccess)
{
    ArgsParser argsParser;
    const std::string para = "0,1";
    const bool ret = argsParser.ParseCtrolCpuList(para);
    EXPECT_EQ(ret, true);
    std::vector<uint32_t> cpulist = argsParser.GetControlCpuList();
    EXPECT_EQ(cpulist[0], 0U);
    EXPECT_EQ(cpulist[1], 1U);
    auto strRet = argsParser.GetParaParsedStr();
    EXPECT_EQ(argsParser.HasControlCpuList(), true);
}

TEST_F(AicpuSdArgsParserTest, GetControlCpuListFail)
{
    ArgsParser argsParser;
    const std::string para = "abc";
    const bool ret = argsParser.ParseCtrolCpuList(para);
    EXPECT_EQ(ret, true);
    std::vector<uint32_t> cpulist = argsParser.GetControlCpuList();
    EXPECT_EQ(cpulist.empty(), true);
}

TEST_F(AicpuSdArgsParserTest, GetTsdPidSucc)
{
    ArgsParser argsParser;
    const std::string para = "123";
    const bool ret = argsParser.ParseTsdPid(para);
    EXPECT_EQ(ret, true);
    auto tsdPid = argsParser.GetTsdPid();
    EXPECT_EQ(tsdPid, 123U);
    EXPECT_EQ(argsParser.HasTsdPid(), true);
}

TEST_F(AicpuSdArgsParserTest, GetTsdPidFail)
{
    ArgsParser argsParser;
    const std::string para = "abc";
    const bool ret = argsParser.ParseTsdPid(para);
    EXPECT_EQ(ret, true);
    auto tsdPid = argsParser.GetTsdPid();
    EXPECT_EQ(tsdPid, 0U);
    EXPECT_EQ(argsParser.HasTsdPid(), false);
}