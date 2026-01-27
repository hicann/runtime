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
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "dump_manager.h"
#include "adump_dsmi.h"
#include "dump_common.h"

using namespace Adx;

class DupDumpManagerStest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(DupDumpManagerStest, Test_CheckCoredumpSupportedPlatformFail)
{
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerStest, Test_CheckCoredumpSupportedPlatformNotSupport)
{
    uint32_t v4type = 15;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerStest, Test_CheckCoredumpSupportedPlatform)
{
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);
}