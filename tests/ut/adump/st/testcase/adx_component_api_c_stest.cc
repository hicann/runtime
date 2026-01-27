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
class ADX_SERVER_MANGER_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_SERVER_MANGER_STEST, ServerMangerFunc)
{
    drvHdcServiceType serviceType = HDC_SERVICE_TYPE_IDE_FILE_TRANS;
    ComponentType componentType = ComponentType::COMPONENT_GETD_FILE;
    AdxComponentInit init = nullptr;
    AdxComponentProcess process = nullptr;
    AdxComponentUnInit uninit = nullptr;
    EXPECT_EQ(IDE_DAEMON_OK, AdxRegisterService(serviceType, componentType, init, process, uninit));

    ServerInitInfo *info = (ServerInitInfo *)malloc(sizeof(ServerInitInfo));
    info->serverType = (int32_t)HDC_SERVICE_TYPE_LOG;
    info->mode = 0;
    info->deviceId = -1;

    MOCKER(IdeXmalloc)
    .stubs()
    .will(returnValue((void*)info));

    MOCKER(memcpy_s)
    .stubs()
    .will(returnValue(EOK));

    EXPECT_EQ(IDE_DAEMON_OK, AdxServiceStartup(*info));

    EXPECT_EQ(IDE_DAEMON_OK, AdxServiceCleanup(serviceType));
    IDE_XFREE_AND_SET_NULL(info);
}

TEST_F(ADX_SERVER_MANGER_STEST, AdxUnRegisterService)
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