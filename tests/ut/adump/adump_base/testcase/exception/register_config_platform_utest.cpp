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
#include <algorithm>
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "coredump_register_interface.h"
#include "platform/cloud_v2_platform.h"
#include "platform/cloud_v4_platform.h"
#include "platform/cloud_v5_platform.h"
#include "platform/cloud_v6_platform.h"
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

// 平台注册接口：按平台类型创建对应寄存器配置。
static std::shared_ptr<RegisterInterface> CreateRegisterByPlatform()
{
    auto* plat = CoredumpManager::Get();
    return (plat == nullptr) ? nullptr : plat->CreateRegister();
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterFail)
{
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    EXPECT_EQ(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterNotSupport)
{
    uint32_t vtype = 0;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    EXPECT_EQ(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterNotCloudV2)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_MINI_V3_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    EXPECT_EQ(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV4)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    EXPECT_NE(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV5)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V5);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    EXPECT_NE(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV6)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V6);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    auto reg = CreateRegisterByPlatform();
    ASSERT_NE(reg, nullptr);
    // V6 寄存器配置按设计复用 V4，创建出的必须是 CloudV4Register，防止误接其它平台配置。
    EXPECT_NE(dynamic_cast<CloudV4Register*>(reg.get()), nullptr);
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

TEST_F(RegisterManagerPlatformUtest, Test_CloudV5DebugRegisterLayoutStaysPopulated)
{
    // V5 Debug 排列已适配，各类表必须完整非空，且错误寄存器使用 V5 专用排列。
    CloudV5Register reg;
    EXPECT_FALSE(reg.GetRegisterTypes(CORE_TYPE_AIC).empty());
    EXPECT_FALSE(reg.GetRegisterTypes(CORE_TYPE_AIV).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIC).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIV).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIC_DBG).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIV_DBG).empty());

    // 错误寄存器为 V5 专用排列，含 V4 没有的 SU/VEC 扩展条目。
    EXPECT_FALSE(reg.GetErrorRegisterTable().empty());
}

TEST_F(RegisterManagerPlatformUtest, Test_CloudV4DebugRegisterLayoutStaysPopulated)
{
    // 所属权下移到 V4 后，V4 自身的表必须仍然完整。
    CloudV4Register reg;
    const auto& aicTypes = reg.GetRegisterTypes(CORE_TYPE_AIC);
    const auto& aivTypes = reg.GetRegisterTypes(CORE_TYPE_AIV);
    ASSERT_EQ(2U, aicTypes.size());
    ASSERT_EQ(2U, aivTypes.size());
    EXPECT_EQ(RegisterType::AIC, aicTypes[0]);
    EXPECT_EQ(RegisterType::AIC_DBG, aicTypes[1]);
    EXPECT_EQ(RegisterType::AIV, aivTypes[0]);
    EXPECT_EQ(RegisterType::AIV_DBG, aivTypes[1]);

    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIC).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIV).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIC_DBG).empty());
    EXPECT_FALSE(reg.GetRegisterTable(RegisterType::AIV_DBG).empty());
    EXPECT_FALSE(reg.GetErrorRegisterTable().empty());
}

TEST_F(RegisterManagerPlatformUtest, Test_CloudV2DebugRegisterLayoutUsesV4StyleAggregation)
{
    CloudV2Register reg;
    const auto& aicTypes = reg.GetRegisterTypes(CORE_TYPE_AIC);
    const auto& aivTypes = reg.GetRegisterTypes(CORE_TYPE_AIV);
    ASSERT_EQ(1U, aicTypes.size());
    ASSERT_EQ(1U, aivTypes.size());
    EXPECT_EQ(RegisterType::AIC_DBG, aicTypes[0]);
    EXPECT_EQ(RegisterType::AIV_DBG, aivTypes[0]);

    const auto& aicDbg = reg.GetRegisterTable(RegisterType::AIC_DBG);
    const auto& aivDbg = reg.GetRegisterTable(RegisterType::AIV_DBG);
    ASSERT_EQ(10U, aicDbg.size());
    ASSERT_EQ(8U, aivDbg.size());

    EXPECT_EQ(0X0U, aicDbg[0].startAddr);
    EXPECT_EQ(0X203000000000000U, aicDbg[5].startAddr);
    EXPECT_EQ(0X300000000000000U, aicDbg[7].startAddr);
    EXPECT_EQ(0X0U, aivDbg[0].startAddr);
    EXPECT_EQ(0X100000000000000U, aivDbg[5].startAddr);
    EXPECT_EQ(0X101000000000000U, aivDbg[7].startAddr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterCloudV2)
{
    uint32_t vtype = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(vtype)).will(returnValue(true));
    EXPECT_NE(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterBothV2AndV4)
{
    uint32_t v2type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_NE(CreateRegisterByPlatform(), nullptr);

    Adx::ResetAllPlatformManagers();
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_NE(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterDCType)
{
    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    EXPECT_EQ(CreateRegisterByPlatform(), nullptr);
}

TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterAllUnsupportedTypes)
{
    for (uint32_t unsupportedType : {1U, 2U, 3U}) {
        Adx::ResetAllPlatformManagers();
        MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unsupportedType)).will(returnValue(true));
        EXPECT_EQ(CreateRegisterByPlatform(), nullptr);
    }
}

// 平台类型逐值边界：驱动上报未支持的平台号时必须返回空寄存器配置，不得误创建。
TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterUnsupportedTypeBoundary)
{
    for (uint32_t type : {0U, 1U, 2U, 3U, 10U, 255U}) {
        Adx::ResetAllPlatformManagers();
        MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
        EXPECT_EQ(CreateRegisterByPlatform(), nullptr) << "platform type " << type;
    }
}

// V4 平台创建出的配置必须带正确的表类型注册（AIC/AIV 各含直读表与 Debug 表）。
TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterV4TypeCorrect)
{
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    auto reg = CreateRegisterByPlatform();
    ASSERT_NE(reg, nullptr);
    const auto& aicTypes = reg->GetRegisterTypes(CORE_TYPE_AIC);
    const auto& aivTypes = reg->GetRegisterTypes(CORE_TYPE_AIV);
    EXPECT_NE(std::find(aicTypes.begin(), aicTypes.end(), RegisterType::AIC_DBG), aicTypes.end());
    EXPECT_NE(std::find(aivTypes.begin(), aivTypes.end(), RegisterType::AIV_DBG), aivTypes.end());
}

// V6 平台创建出的配置必须带正确的表类型注册（AIC/AIV 各含直读表与 Debug 表）。
TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterV6TypeCorrect)
{
    uint32_t v6type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V6);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v6type)).will(returnValue(true));
    auto reg = CreateRegisterByPlatform();
    ASSERT_NE(reg, nullptr);
    const auto& aicTypes = reg->GetRegisterTypes(CORE_TYPE_AIC);
    const auto& aivTypes = reg->GetRegisterTypes(CORE_TYPE_AIV);
    ASSERT_EQ(2U, aicTypes.size());
    ASSERT_EQ(2U, aivTypes.size());
    EXPECT_EQ(RegisterType::AIC, aicTypes[0]);
    EXPECT_EQ(RegisterType::AIC_DBG, aicTypes[1]);
    EXPECT_EQ(RegisterType::AIV, aivTypes[0]);
    EXPECT_EQ(RegisterType::AIV_DBG, aivTypes[1]);
}

// V4 各表条目数量看护：表被整段误删/段函数返回空时必须失败（non-empty 断言无法发现此类缺陷）。
TEST_F(RegisterManagerPlatformUtest, Test_CloudV4RegisterTableCountsStayStable)
{
    CloudV4Register reg;
    EXPECT_EQ(109U, reg.GetRegisterTable(RegisterType::AIC).size());
    EXPECT_EQ(98U, reg.GetRegisterTable(RegisterType::AIV).size());
    EXPECT_EQ(59U, reg.GetRegisterTable(RegisterType::AIC_DBG).size());
    EXPECT_EQ(165U, reg.GetRegisterTable(RegisterType::AIV_DBG).size());
    EXPECT_EQ(32U, reg.GetErrorRegisterTable().size());
}

// V5 各表条目数量看护：数量变化说明段函数被增删或表数据被改动，需同步确认是否为预期变更。
TEST_F(RegisterManagerPlatformUtest, Test_CloudV5RegisterTableCounts)
{
    CloudV5Register reg;
    EXPECT_EQ(142U, reg.GetRegisterTable(RegisterType::AIC).size());
    EXPECT_EQ(132U, reg.GetRegisterTable(RegisterType::AIV).size());
    EXPECT_EQ(159U, reg.GetRegisterTable(RegisterType::AIC_DBG).size());
    EXPECT_EQ(235U, reg.GetRegisterTable(RegisterType::AIV_DBG).size());
    EXPECT_EQ(38U, reg.GetErrorRegisterTable().size());
}

// V6 复用 V4 寄存器表：经 V6 平台创建的各表条目数量必须与 V4 看护值一致，防止 V6 路径误接/漏接表。
TEST_F(RegisterManagerPlatformUtest, Test_CreateRegisterV6TableCountsMatchV4)
{
    uint32_t v6type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V6);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v6type)).will(returnValue(true));
    auto reg = CreateRegisterByPlatform();
    ASSERT_NE(reg, nullptr);
    EXPECT_EQ(109U, reg->GetRegisterTable(RegisterType::AIC).size());
    EXPECT_EQ(98U, reg->GetRegisterTable(RegisterType::AIV).size());
    EXPECT_EQ(59U, reg->GetRegisterTable(RegisterType::AIC_DBG).size());
    EXPECT_EQ(165U, reg->GetRegisterTable(RegisterType::AIV_DBG).size());
    EXPECT_EQ(32U, reg->GetErrorRegisterTable().size());
}

// V2 错误寄存器表条目数量看护（Debug 表数量已在布局用例中精确断言）。
TEST_F(RegisterManagerPlatformUtest, Test_CloudV2ErrorRegisterTableCount)
{
    CloudV2Register reg;
    EXPECT_EQ(19U, reg.GetErrorRegisterTable().size());
}

// 展开后的寄存器总数看护：按 num 累加每张表实际读取的寄存器个数（GenAddrByStep 展开的段也计入）。
// 与"表条目数"互补：条目数看护表结构被误删，寄存器数看护 num/展开参数被改错。
namespace {
size_t SumRegNum(const std::vector<RegisterTable>& tables)
{
    size_t total = 0;
    for (const auto& table : tables) {
        total += table.num;
    }
    return total;
}
} // namespace

TEST_F(RegisterManagerPlatformUtest, Test_CloudV4RegisterTotalCounts)
{
    CloudV4Register reg;
    EXPECT_EQ(368U, SumRegNum(reg.GetRegisterTable(RegisterType::AIC)));
    EXPECT_EQ(337U, SumRegNum(reg.GetRegisterTable(RegisterType::AIV)));
    EXPECT_EQ(435U, SumRegNum(reg.GetRegisterTable(RegisterType::AIC_DBG)));
    EXPECT_EQ(5949U, SumRegNum(reg.GetRegisterTable(RegisterType::AIV_DBG)));
}

TEST_F(RegisterManagerPlatformUtest, Test_CloudV5RegisterTotalCounts)
{
    CloudV5Register reg;
    EXPECT_EQ(540U, SumRegNum(reg.GetRegisterTable(RegisterType::AIC)));
    EXPECT_EQ(504U, SumRegNum(reg.GetRegisterTable(RegisterType::AIV)));
    EXPECT_EQ(12862U, SumRegNum(reg.GetRegisterTable(RegisterType::AIC_DBG)));
    EXPECT_EQ(5562U, SumRegNum(reg.GetRegisterTable(RegisterType::AIV_DBG)));
}

TEST_F(RegisterManagerPlatformUtest, Test_CloudV2RegisterTotalCounts)
{
    CloudV2Register reg;
    EXPECT_EQ(102U, SumRegNum(reg.GetRegisterTable(RegisterType::AIC_DBG)));
    EXPECT_EQ(81U, SumRegNum(reg.GetRegisterTable(RegisterType::AIV_DBG)));
}
