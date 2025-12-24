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

#include "server_register.h"
#include "memory_utils.h"
#include "common_utils.h"
#include "adx_component_api_c.h"
using namespace Adx;
class ADX_SERVER_MANGER_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_SERVER_MANGER_TEST, AdxRegisterService)
{
    MOCKER(AdxRegisterComponentFunc)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK))
        .then(returnValue(IDE_DAEMON_ERROR));
    drvHdcServiceType serviceType;
    ComponentType componentType;
    AdxComponentInit init;
    AdxComponentProcess process;
    AdxComponentUnInit uninit;
    EXPECT_EQ(IDE_DAEMON_OK, AdxRegisterService(serviceType, componentType, init, process, uninit));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxRegisterService(serviceType, componentType, init, process, uninit));
}

TEST_F(ADX_SERVER_MANGER_TEST, AdxUnRegisterService)
{
    drvHdcServiceType serviceType = HDC_SERVICE_TYPE_IDE1;
    ComponentType componentType = COMPONENT_GETD_FILE;
    AdxComponentInit init;
    AdxComponentProcess process;
    AdxComponentUnInit uninit;
    EXPECT_EQ(IDE_DAEMON_OK, AdxRegisterService(serviceType, componentType, init, process, uninit));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxRegisterService(serviceType, componentType, init, process, uninit));
    EXPECT_EQ(IDE_DAEMON_OK, AdxUnRegisterService(serviceType, componentType));
    EXPECT_EQ(IDE_DAEMON_OK, AdxRegisterService(serviceType, componentType, init, process, uninit));
    componentType = COMPONENT_LOG_BACKHAUL;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxUnRegisterService(serviceType, componentType));
    componentType = COMPONENT_GETD_FILE;
    EXPECT_EQ(IDE_DAEMON_OK, AdxUnRegisterService(serviceType, componentType));
}

TEST_F(ADX_SERVER_MANGER_TEST, AdxServiceStartupSucc)
{
    ServerInitInfo *info = (ServerInitInfo *)malloc(sizeof(ServerInitInfo));
    info->serverType = HDC_SERVICE_TYPE_LOG;
    info->mode = 0;
    info->deviceId = -1;
    MOCKER(IdeXmalloc)
    .stubs()
    .will(returnValue((void*)info));

    MOCKER(memcpy_s)
    .stubs()
    .will(returnValue(EOK));

    EXPECT_EQ(IDE_DAEMON_OK, AdxServiceStartup(*info));
    IDE_XFREE_AND_SET_NULL(info);
}

TEST_F(ADX_SERVER_MANGER_TEST, AdxServiceCleanup)
{
    MOCKER(AdxComponentServerCleanup)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK))
    .then(returnValue(IDE_DAEMON_ERROR));
    drvHdcServiceType serviceType;
    EXPECT_EQ(IDE_DAEMON_OK, AdxServiceCleanup(serviceType));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxServiceCleanup(serviceType));
}