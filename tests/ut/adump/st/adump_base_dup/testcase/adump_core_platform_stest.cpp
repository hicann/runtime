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
#include "dump_core.h"
#include "register_config.h"
#include "adump_dsmi.h"
#include "dump_common.h"

using namespace Adx;

class DupDumpCoreStest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DupDumpCoreStest, Test_DumpRegisterNotSupport)
{
    DumpCore core("", 10);
    uint32_t v4type = 15;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    std::shared_ptr<RegisterInterface> register_ = std::make_shared<CloudV2Register>();
    core.DumpRegister(0, 0);
}

TEST_F(DupDumpCoreStest, Test_DumpRegister)
{
    DumpCore core("", 10);
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    core.DumpRegister(0, 0);
}

TEST_F(DupDumpCoreStest, Test_ConvertCoreIdNotSupport)
{
    uint32_t v4type = 15;
    uint8_t coreType = 0;
    uint16_t coreId = 1;
    DumpCore core("", 10);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(core.ConvertCoreId(coreType, coreId), 1);
}

TEST_F(DupDumpCoreStest, Test_ConvertCoreId)
{
    uint32_t v2type = 5;
    uint8_t coreType = 0;
    uint16_t coreId = 1;
    DumpCore core("", 10);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(core.ConvertCoreId(coreType, coreId), 1);
    coreType = 1;
    EXPECT_EQ(core.ConvertCoreId(coreType, coreId), 26);
}