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

#include "adx_log.h"
#include "config.h"
#include "runtime/dev.h"
#include "component/adx_server_manager.h"
#include "adx_datadump_server.h"
#include "adx_dump_record.h"
#include "ascend_hal.h"
#include "adx_hdc_device.h"

using namespace Adx;

class ADX_DATADUMP_SERVER_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DATADUMP_SERVER_UTEST, AdxDataDumpServerInit_And_Uninit)
{
    MOCKER(rtGetRunMode)
        .stubs()
        .will(returnValue(1));
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerInit());
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerUnInit());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, AdxDataDumpServerReInit_And_ReUninit)
{
    MOCKER(rtGetRunMode)
        .stubs()
        .will(returnValue(1));
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerInit());
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerUnInit());
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerInit());
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerUnInit());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, AdxDataDumpServerInit_AdxDumpRecord_InitFailed)
{
    MOCKER(rtGetRunMode)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&Adx::AdxDumpRecord::Init)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDataDumpServerInit());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, AdxDataDumpServerUnInit)
{
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerUnInit());

    while(Adx::AdxDumpRecord::Instance().GetDumpInitNum() > 0) {
        Adx::AdxDumpRecord::Instance().UpdateDumpInitNum(false);
    }

    MOCKER_CPP(&Adx::AdxServerManager::Exit)
    .stubs()
    .will(returnValue(IDE_DAEMON_ERROR))
    .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxDataDumpServerUnInit());
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerUnInit());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, HelperAdxDataDumpServerInit)
{
    MOCKER_CPP(&Adx::AdxDumpRecord::Init)
        .stubs()
        .will(returnValue(-1));

    std::string hostPID = "456";
    int ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerInit());
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, HelperAdxDataDumpServerUnInit)
{
    MOCKER_CPP(&Adx::AdxServerManager::Exit)
    .stubs()
    .will(returnValue(IDE_DAEMON_ERROR));
    std::string hostPID = "456";
    int ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    EXPECT_EQ(IDE_DAEMON_OK, AdxDataDumpServerUnInit());
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, TimeProcess_FaultDevice)
{
    SharedPtr<AdxDevice> device = std::make_shared<AdxHdcDevice>();
    MOCKER_CPP(&Adx::AdxCommOptManager::GetDevice)
    .stubs()
    .will(returnValue(device));
    AdxServerManager manager;
    manager.TimerProcess();
    EXPECT_EQ(1, manager.faultyDevices_.size());
    manager.TimerProcess();
    EXPECT_EQ(1, manager.faultyDevices_.size());
    manager.TimerProcess();
    EXPECT_EQ(0, manager.faultyDevices_.size());
}

TEST_F(ADX_DATADUMP_SERVER_UTEST, TimeProcess_FaultToNormalDevice)
{
    SharedPtr<AdxDevice> device = std::make_shared<AdxHdcDevice>();
    MOCKER_CPP(&Adx::AdxCommOptManager::GetDevice)
    .stubs()
    .will(returnValue(device));
    MOCKER_CPP(&Adx::AdxServerManager::ServerInit)
    .stubs()
    .will(returnValue(false)).then(returnValue(true));
    AdxServerManager manager;
    manager.TimerProcess();
    EXPECT_EQ(1, manager.faultyDevices_.size());
    manager.TimerProcess();
    EXPECT_EQ(0, manager.faultyDevices_.size());
}