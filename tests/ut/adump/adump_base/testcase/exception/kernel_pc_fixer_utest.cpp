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
#include <array>
#include <cstdint>
#include <string>
#include "mockcpp/mockcpp.hpp"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "kernel_pc_fixer.h"
#include "runtime/base.h"
#include "acc_error_info.h"

using namespace Adx;

namespace {
constexpr uint64_t TEST_PC = 0x123456789ABCDEF0ULL;

class KernelPcFixerUTest : public testing::Test {
protected:
    void SetUp() override
    {
        Adx::ResetAllPlatformManagers();
        PcFixerFactory::instance_.reset();
    }

    void TearDown() override
    {
        Adx::ResetAllPlatformManagers();
        PcFixerFactory::instance_.reset();
        GlobalMockObject::verify();
    }
};

std::array<uint32_t, RT_ERR_REG_NUMS> EmptyRegs()
{
    std::array<uint32_t, RT_ERR_REG_NUMS> regs = {};
    return regs;
}
} // namespace

TEST_F(KernelPcFixerUTest, CloudV2InvalidInputAndNoMatchedGroupKeepPc)
{
    CloudV2PcFixer fixer;
    auto regs = EmptyRegs();

    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, nullptr, RT_ERR_REG_NUMS));
    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, regs.data(), 0));
    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, regs.data(), regs.size()));
}

TEST_F(KernelPcFixerUTest, CloudV2FixesCubeCcuMteVecAndFixpPc)
{
    CloudV2PcFixer fixer;

    auto regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_0] = 1U << 9U;
    regs[RT_V100_CUBE_ERR_0] = 0x12000034U;
    EXPECT_EQ(0x48D0ULL, fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_0] = 1U << 3U;
    regs[RT_V100_CCU_ERR_0] = (0x56U << 23U) | 0x78U;
    EXPECT_EQ((0x78ULL << 2U) | (0x56ULL << 10U), fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_1] = 1U << 2U;
    regs[RT_V100_MTE_ERR_0] = 0x9AU;
    regs[RT_V100_MTE_ERR_1] = 0xBCU;
    EXPECT_EQ((0x9AULL << 2U) | (0xBCULL << 10U), fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_1] = 1U << 19U;
    regs[RT_V100_VEC_ERR_0] = 0x11U;
    regs[RT_V100_VEC_ERR_1] = 0x22U;
    EXPECT_EQ((0x11ULL << 2U) | (0x22ULL << 10U), fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_3] = 1U << 4U;
    regs[RT_V100_FIXP_ERR_0] = 0x33U;
    regs[RT_V100_FIXP_ERR_1] = 0x44U;
    EXPECT_EQ((0x33ULL << 2U) | (0x44ULL << 10U), fixer.FixPc(0, regs.data(), regs.size()));
}

TEST_F(KernelPcFixerUTest, CloudV2MixedModuleReturnsFirstModulePcAndShortRegisterArrayDoesNotChangePc)
{
    CloudV2PcFixer fixer;

    auto regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_0] = (1U << 3U) | (1U << 9U);
    regs[RT_V100_CCU_ERR_0] = 0x12U;
    regs[RT_V100_CUBE_ERR_0] = 0x34U;
    EXPECT_EQ((TEST_PC & ~0x3FFFCULL) | (0x34ULL << 2U), fixer.FixPc(TEST_PC, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V100_AIC_ERR_0] = 1U << 9U;
    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, regs.data(), RT_V100_CUBE_ERR_0));

}

TEST_F(KernelPcFixerUTest, CloudV2SameModuleAcrossErrorRegistersFixesPc)
{
    CloudV2PcFixer fixer;
    auto regs = EmptyRegs();

    regs[RT_V100_AIC_ERR_1] = 1U << 2U;
    regs[RT_V100_AIC_ERR_2] = 1U << 9U;
    regs[RT_V100_MTE_ERR_0] = 0x9AU;
    regs[RT_V100_MTE_ERR_1] = 0xBCU;
    EXPECT_EQ((0x9AULL << 2U) | (0xBCULL << 10U), fixer.FixPc(0, regs.data(), regs.size()));
}

TEST_F(KernelPcFixerUTest, CloudV4InvalidInputAndScError)
{
    CloudV4PcFixer fixer;
    auto regs = EmptyRegs();

    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, nullptr, RT_ERR_REG_NUMS));
    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, regs.data(), 0));

    regs[RT_V200_SC_ERROR_T0_0] = 1U;
    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, regs.data(), regs.size()));
}

TEST_F(KernelPcFixerUTest, CloudV4FixesSuMteVecCubeAndL1Pc)
{
    CloudV4PcFixer fixer;

    auto regs = EmptyRegs();
    regs[RT_V200_SU_ERROR_T0_0] = 1U;
    regs[RT_V200_SU_ERR_INFO_T0_0] = 0x1234U;
    EXPECT_EQ(0x48D0ULL, fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V200_MTE_ERROR_T1_0] = 1U;
    regs[RT_V200_MTE_ERR_INFO_T0_0] = 0x5678U;
    regs[RT_V200_MTE_ERR_INFO_T1_0] = 0x9ABCU;
    EXPECT_EQ(0x159E0ULL, fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V200_VEC_ERROR_T0_0] = 1U << 25U;
    regs[RT_V200_VEC_ERR_INFO_T0_1] = 0x89ABCDEFU;
    regs[RT_V200_VEC_ERR_INFO_T0_2] = 0x12345U;
    EXPECT_EQ(0x1234589ABCDEFULL, fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V200_CUBE_ERROR_T0_1] = 1U << 9U;
    regs[RT_V200_CUBE_ERR_INFO_T0_1] = 0xF155U;
    EXPECT_EQ(0x3C554ULL, fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V200_L1_ERROR_T0_1] = 1U << 21U;
    regs[RT_V200_L1_ERR_INFO_T0_1] = 0x12345678U;
    EXPECT_EQ(0x159E0ULL, fixer.FixPc(0, regs.data(), regs.size()));
}

TEST_F(KernelPcFixerUTest, CloudV4MixedModuleReturnsFirstModulePcAndShortRegisterArrayDoesNotChangePc)
{
    CloudV4PcFixer fixer;

    auto regs = EmptyRegs();
    regs[RT_V200_SU_ERROR_T0_0] = 1U;
    regs[RT_V200_MTE_ERROR_T0_0] = 1U;
    regs[RT_V200_SU_ERR_INFO_T0_0] = 0x1234U;
    regs[RT_V200_MTE_ERR_INFO_T0_0] = 0x5678U;
    EXPECT_EQ((TEST_PC & ~0x3FFFCULL) | 0x48D0ULL, fixer.FixPc(TEST_PC, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V200_L1_ERROR_T0_0] = 1U;
    EXPECT_EQ(TEST_PC, fixer.FixPc(TEST_PC, regs.data(), RT_V200_L1_ERR_INFO_T0_1));
}

TEST_F(KernelPcFixerUTest, CloudV4SameModuleAcrossErrorRegistersFixesPc)
{
    CloudV4PcFixer fixer;
    auto regs = EmptyRegs();

    regs[RT_V200_MTE_ERROR_T0_0] = 1U;
    regs[RT_V200_MTE_ERROR_T1_0] = 1U;
    regs[RT_V200_MTE_ERR_INFO_T0_0] = 0x5678U;
    regs[RT_V200_MTE_ERR_INFO_T1_0] = 0x9ABCU;
    EXPECT_EQ(0x159E0ULL, fixer.FixPc(0, regs.data(), regs.size()));

    regs = EmptyRegs();
    regs[RT_V200_VEC_ERROR_T0_0] = 1U << 25U;
    regs[RT_V200_VEC_ERROR_T0_2] = 1U;
    regs[RT_V200_VEC_ERR_INFO_T0_1] = 0x89ABCDEFU;
    regs[RT_V200_VEC_ERR_INFO_T0_2] = 0x12345U;
    EXPECT_EQ(0x1234589ABCDEFULL, fixer.FixPc(0, regs.data(), regs.size()));
}

TEST_F(KernelPcFixerUTest, FactoryCreatesSupportedFixersAndRejectsUnsupported)
{
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    EXPECT_NE(nullptr, dynamic_cast<CloudV2PcFixer *>(PcFixerFactory::GetInstance()));
    EXPECT_NE(nullptr, PcFixerFactory::GetInstance());

    GlobalMockObject::verify();
    PcFixerFactory::instance_.reset();
    Adx::ResetAllPlatformManagers();

    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    EXPECT_NE(nullptr, dynamic_cast<CloudV4PcFixer *>(PcFixerFactory::GetInstance()));

    GlobalMockObject::verify();
    PcFixerFactory::instance_.reset();
    Adx::ResetAllPlatformManagers();

    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    EXPECT_EQ(nullptr, PcFixerFactory::GetInstance());

    GlobalMockObject::verify();
    Adx::ResetAllPlatformManagers();

    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    EXPECT_EQ(nullptr, PcFixerFactory::GetInstance());
}
