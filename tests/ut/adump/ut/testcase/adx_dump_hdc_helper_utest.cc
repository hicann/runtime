/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "config.h"
#include "adx_dump_hdc_helper.h"
#include "adx_comm_opt.h"
#include "ascend_hal.h"

class ADX_DUMP_HDC_HELPER_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_HDC_HELPER_TEST, ParseConnectInfo)
{
    const std::string privInfo = "127.0.0.1:22118;0;123";
    std::map<std::string, std::string> proto;
    int ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo, proto);
    EXPECT_EQ(0, ret);
    EXPECT_EQ(proto[Adx::OPT_DEVICE_KEY], "0");
    EXPECT_EQ(proto[Adx::OPT_PID_KEY], "123");
    const std::string privInfo1 = "127.0.0.1";
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo1, proto);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
    const std::string privInfo2 = "127.0.0.1:22118;a;abc";
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo2, proto);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
    const std::string privInfo3 = "127.0.0.1:22118;0;abc";
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo3, proto);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);

    // test environment variables for 1971 helper
    std::string hostPID = "456";
    ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo, proto);
    EXPECT_EQ(proto[Adx::OPT_PID_KEY], hostPID);
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());

    hostPID = "abc";
    ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo, proto);
    EXPECT_EQ(proto[Adx::OPT_PID_KEY], "123");
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpStart)
{
    const char* privInfo = "127.0.0.1:22118;0;123";
    IDE_SESSION session = IdeDumpStart(privInfo);
    EXPECT_EQ(0, session);
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpData_WriteError)
{
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk;
    unsigned char ch = 'a';
    dumpChunk.fileName = "/home/test.log";
    dumpChunk.dataBuf = &ch;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 0;
    dumpChunk.offset = 0;
    dumpChunk.flag = IDE_DUMP_NONE_FLAG ;
    const IdeDumpChunk constDumpChunk = dumpChunk;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(session, nullptr));
    int ret = IdeDumpData(session, &constDumpChunk);
    EXPECT_EQ(IDE_DAEMON_WRITE_ERROR, ret);
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpData_SessionError)
{
    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1));
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk;
    unsigned char ch = 'a';
    dumpChunk.fileName = "/home/test.log";
    dumpChunk.dataBuf = &ch;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 0;
    dumpChunk.offset = 0;
    dumpChunk.flag = IDE_DUMP_NONE_FLAG ;
    const IdeDumpChunk constDumpChunk = dumpChunk;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(session, nullptr));
    int ret = IdeDumpData(session, &constDumpChunk);
    EXPECT_EQ(IDE_DAEMON_HDC_CHANNEL_ERROR, ret);
}