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
#include "register_config.h"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "dump_common.h"
#include "acc_error_info.h"

using namespace Adx;

class RegisterManagerPlatformUtest : public testing::Test {
protected:
    virtual void SetUp() { Adx::ResetAllPlatformManagers(); }
    virtual void TearDown()
    {
        Adx::ResetAllPlatformManagers();
        GlobalMockObject::verify();
    }
};

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterFail)
{
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterNotSupport)
{
    uint32_t vtype = 0;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterNotCloudV2)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_MINI_V3_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV4)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_NE(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV5)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V5);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_NE(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CloudV5ErrorRegisterTableIntegrity)
{
    CloudV5Register reg;
    const auto& table = reg.GetErrorRegisterTable();
    EXPECT_FALSE(table.empty());

    // 名称与 errIndex 一一对应，且偏移地址、字节宽度非零（地址表完整性）。
    for (const auto& item : table) {
        EXPECT_FALSE(item.name.empty());
        EXPECT_NE(0U, item.offsetAddr);
        EXPECT_NE(0U, item.byteWidth);
    }

    auto find = [&table](uint8_t errIndex) -> const ErrorRegisterTable* {
        for (const auto& item : table) {
            if (item.errIndex == errIndex) {
                return &item;
            }
        }
        return nullptr;
    };

    // 关键条目校验（覆盖历史检视意见涉及的寄存器）。
    const ErrorRegisterTable* vec = find(RT_V200_VEC_ERR_INFO_T0_3);
    ASSERT_NE(nullptr, vec);
    EXPECT_EQ("VEC_ERR_INFO_T0_3", vec->name);
    EXPECT_EQ(0x773CU, vec->offsetAddr);

    const ErrorRegisterTable* l1 = find(RT_V200_L1_ERR_INFO_T0_1);
    ASSERT_NE(nullptr, l1);
    EXPECT_EQ("L1_ERR_INFO_T0_1", l1->name);
    EXPECT_EQ(0xA71CU, l1->offsetAddr);

    const ErrorRegisterTable* su = find(RT_V200_SU_ERROR_T0_1);
    ASSERT_NE(nullptr, su);
    EXPECT_EQ("SU_ERROR_T0_1", su->name);
    EXPECT_EQ(0x5704U, su->offsetAddr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV2)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_NE(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterBothV2AndV4)
{
    uint32_t v2type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    RegisterManager registerManagerV2 = RegisterManager();
    registerManagerV2.CreateRegister();
    auto regV2 = registerManagerV2.GetRegister();
    EXPECT_NE(regV2, nullptr);

    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    RegisterManager registerManagerV4 = RegisterManager();
    registerManagerV4.CreateRegister();
    auto regV4 = registerManagerV4.GetRegister();
    EXPECT_NE(regV4, nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterV4TypeCorrect)
{
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    auto reg = registerManager.GetRegister();
    EXPECT_NE(reg, nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterDCType)
{
    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterAllUnsupportedTypes)
{
    uint32_t unsupportedType = 1;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unsupportedType)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);

    unsupportedType = 2;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unsupportedType)).will(returnValue(true));
    RegisterManager registerManager2 = RegisterManager();
    registerManager2.CreateRegister();
    EXPECT_EQ(registerManager2.GetRegister(), nullptr);

    unsupportedType = 3;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unsupportedType)).will(returnValue(true));
    RegisterManager registerManager3 = RegisterManager();
    registerManager3.CreateRegister();
    EXPECT_EQ(registerManager3.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_GetRegisterTwice)
{
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    auto reg1 = registerManager.GetRegister();
    auto reg2 = registerManager.GetRegister();
    EXPECT_NE(reg1, nullptr);
    EXPECT_EQ(reg1, reg2);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedType0)
{
    uint32_t type = 0;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedType1)
{
    uint32_t type = 1;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedType2)
{
    uint32_t type = 2;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedType3)
{
    uint32_t type = 3;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedType10)
{
    uint32_t type = 10;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedType255)
{
    uint32_t type = 255;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_GetRegisterBeforeCreate)
{
    RegisterManager registerManager = RegisterManager();
    EXPECT_EQ(registerManager.GetRegister(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCalledTwice)
{
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    auto reg1 = registerManager.GetRegister();
    EXPECT_NE(reg1, nullptr);
}
