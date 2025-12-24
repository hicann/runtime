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

#include "ascend_hal.h"
#include "adx_dump_receive.h"
#include "adx_server_manager.h"
#include "server_register.h"

using namespace Adx;
class ADX_SERVER_REGISTER_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

int32_t CreateDetachTaskWithDefaultAttrStub(mmThread &tid, mmUserBlock_t &funcBlock)
{
    funcBlock.procFunc(funcBlock.pulArg);
    return 0;
}

TEST_F(ADX_SERVER_REGISTER_TEST, RegisterComponent)
{
    MOCKER_CPP(&AdxServerManager::ComponentAdd)
        .stubs()
    .will(returnValue(true))
    .then(returnValue(false));
    ServerRegister serviceManager;
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)AdxDumpReceive);
    EXPECT_EQ(IDE_DAEMON_OK, serviceManager.RegisterComponent(HDC_SERVICE_TYPE_DUMP, cpn));
    EXPECT_EQ(IDE_DAEMON_ERROR, serviceManager.RegisterComponent(HDC_SERVICE_TYPE_DUMP, cpn));
}

TEST_F(ADX_SERVER_REGISTER_TEST, ComponentServerStartup)
{
    MOCKER_CPP(&ServerRegister::ServerManagerInit)
    .stubs()
    .will(returnValue(true))
    .then(returnValue(false));
    ServerRegister serviceManager;
    ServerInitInfo info = { (int32_t)HDC_SERVICE_TYPE_DUMP, 0, -1 };
    EXPECT_EQ(IDE_DAEMON_OK, serviceManager.ComponentServerStartup(info));
    EXPECT_EQ(IDE_DAEMON_ERROR, serviceManager.ComponentServerStartup(info));
}

TEST_F(ADX_SERVER_REGISTER_TEST, ComponentServerCleanup)
{
    MOCKER_CPP(&AdxServerManager::Exit)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));
    ServerRegister serviceManager;
    EXPECT_EQ(IDE_DAEMON_OK, serviceManager.ComponentServerCleanup(HDC_SERVICE_TYPE_DUMP));
}

TEST_F(ADX_SERVER_REGISTER_TEST, AdxRegisterComponentFunc)
{
    MOCKER_CPP(&ServerRegister::RegisterComponent)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK))
        .then(returnValue(IDE_DAEMON_ERROR));

    drvHdcServiceType serverType = HDC_SERVICE_TYPE_DUMP;
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)AdxDumpReceive);
    EXPECT_EQ(IDE_DAEMON_OK, AdxRegisterComponentFunc(serverType, cpn));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxRegisterComponentFunc(serverType, cpn));
}

TEST_F(ADX_SERVER_REGISTER_TEST, AdxComponentServerStartup)
{
    int mode = 0;
    int devId = -1;
    ServerInitInfo info = { (int32_t)HDC_SERVICE_TYPE_DUMP, mode, devId };
    MOCKER_CPP(&Thread::CreateDetachTaskWithDefaultAttr)
        .stubs()
        .will(returnValue(EN_OK))
        .then(returnValue(EN_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, AdxComponentServerStartup(info));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxComponentServerStartup(info));
}

TEST_F(ADX_SERVER_REGISTER_TEST, AdxServerProcess)
{
    int mode = 0;
    int devId = -1;
    ServerInitInfo info = { (int32_t)HDC_SERVICE_TYPE_DUMP, mode, devId };
    MOCKER_CPP(&Thread::CreateDetachTaskWithDefaultAttr)
        .stubs()
        .will(invoke(CreateDetachTaskWithDefaultAttrStub));

    EXPECT_EQ(IDE_DAEMON_OK, AdxComponentServerStartup(info));
}

TEST_F(ADX_SERVER_REGISTER_TEST, AdxComponentServerCleanup)
{
    MOCKER_CPP(&ServerRegister::ComponentServerCleanup)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxComponentServerCleanup(HDC_SERVICE_TYPE_DUMP));
    EXPECT_EQ(IDE_DAEMON_OK, AdxComponentServerCleanup(HDC_SERVICE_TYPE_DUMP));
}

TEST_F(ADX_SERVER_REGISTER_TEST, ServerManagerInit)
{
    ServerRegister serviceManager;
    ServerInitInfo info = { (int32_t)HDC_SERVICE_TYPE_DUMP, 0, -1 };
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)AdxDumpReceive);
    EXPECT_EQ(false, serviceManager.ServerManagerInit(info));
    serviceManager.RegisterComponent(HDC_SERVICE_TYPE_DUMP, cpn);

    MOCKER_CPP(&AdxServerManager::RegisterEpoll)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&AdxServerManager::RegisterCommOpt)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&AdxServerManager::ComponentInit)
        .stubs()
        .will(returnValue(true));

    EXPECT_EQ(false, serviceManager.ServerManagerInit(info));
    EXPECT_EQ(true, serviceManager.ServerManagerInit(info));
}