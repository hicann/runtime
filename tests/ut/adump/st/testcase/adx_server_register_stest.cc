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
class ADX_SERVER_REGISTER_STEST: public testing::Test {
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

TEST_F(ADX_SERVER_REGISTER_STEST, ServerRegisterTest)
{
    drvHdcServiceType serverType = HDC_SERVICE_TYPE_DUMP;
    int mode = 0;
    int devId = -1;
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)AdxDumpReceive);
    EXPECT_EQ(IDE_DAEMON_OK, AdxRegisterComponentFunc(serverType, cpn));

    ServerInitInfo info = { (int32_t)serverType, mode, devId };
    EXPECT_EQ(IDE_DAEMON_OK, AdxComponentServerStartup(info));

    EXPECT_EQ(IDE_DAEMON_OK, AdxComponentServerCleanup(serverType));
}

TEST_F(ADX_SERVER_REGISTER_STEST, AdxServerProcess)
{
    int mode = 0;
    int devId = -1;
    ServerInitInfo info = { (int32_t)HDC_SERVICE_TYPE_DUMP, mode, devId };
    MOCKER_CPP(&Thread::CreateDetachTaskWithDefaultAttr)
        .stubs()
        .will(invoke(CreateDetachTaskWithDefaultAttrStub));

    EXPECT_EQ(IDE_DAEMON_OK, AdxComponentServerStartup(info));
}