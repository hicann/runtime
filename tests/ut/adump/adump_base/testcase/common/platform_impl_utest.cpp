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
#include "platform/cloud_v2_platform.h"
#include "platform/cloud_v4_platform.h"
#include "platform/dc_platform.h"
#include "kernel_pc_fixer.h"
#include "register_config.h"
#include "dump_common.h"
#include "dump_core.h"
#include "hccl_mc2_define.h"

using namespace Adx;

namespace {
constexpr uint32_t BLOCK_MIN_SIZE = 32U;
constexpr uint32_t INTEGER_KILOBYTE = 1024U;

rtError_t rtGetSocVersion910_93Stub(char *version, const uint32_t maxLen)
{
    strcpy_s(version, maxLen, "Ascend910_9381");
    return RT_ERROR_NONE;
}

rtError_t rtGetSocVersion910BStub(char *version, const uint32_t maxLen)
{
    strcpy_s(version, maxLen, "Ascend910B4");
    return RT_ERROR_NONE;
}
}

class PlatformImplUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

// ---------------- DcPlatform (CHIP_DC_TYPE / Ascend310P) ----------------
TEST_F(PlatformImplUtest, DcFeatures_SupportMatrix)
{
    DcFeatures features;
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_DATA_DUMP));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1));
    // DC 不支持 coredump
    EXPECT_FALSE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_CORE_DUMP));
    EXPECT_FALSE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_INVALID));
}

TEST_F(PlatformImplUtest, DcException_Behaviour)
{
    DcException exception;
    EXPECT_TRUE(exception.IsArgsDataTypeSizeByByte());
    // 走基类默认值
    EXPECT_FALSE(exception.SupportMc2SpacesDump());
    EXPECT_EQ(exception.GetMc2StructSize(), 0U);
}

TEST_F(PlatformImplUtest, DcDataDump_Behaviour)
{
    DcDataDump dataDump;
    EXPECT_EQ(dataDump.GetKfcStackSize(), static_cast<uint64_t>(2) * BLOCK_MIN_SIZE * INTEGER_KILOBYTE);
    EXPECT_EQ(dataDump.GetKfcBinName(), "kfc_dump_stat_ascend310p3.o");
    // 走基类默认值（printf 参数、UbFromAiCore）
    EXPECT_FALSE(dataDump.IsUbFromAiCore());
    EXPECT_EQ(dataDump.GetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(dataDump.GetBlockNum(), 75U);
    EXPECT_EQ(dataDump.GetStreamSyncTimeout(), 60000);
    EXPECT_FALSE(dataDump.IsSimtDumpEnabled(1U));
}

// ---------------- CloudV4Platform (CHIP_CLOUD_V4 / Ascend950) ----------------
TEST_F(PlatformImplUtest, CloudV4Features_SupportMatrix)
{
    CloudV4Features features;
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_DATA_DUMP));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_CORE_DUMP));
}

TEST_F(PlatformImplUtest, CloudV4Coredump_Behaviour)
{
    CloudV4Coredump coredump;
    EXPECT_NE(coredump.CreatePcFixer(), nullptr);
    EXPECT_NE(coredump.CreateRegister(), nullptr);
    // ConvertCoreId: AIC 直返 coreId，非 AIC 偏移 CORE_SIZE_AIC_DAVID
    EXPECT_EQ(coredump.ConvertCoreId(CORE_TYPE_AIC, 3), 3U);
    EXPECT_EQ(coredump.ConvertCoreId(CORE_TYPE_AIV, 3), static_cast<uint16_t>(CORE_SIZE_AIC_DAVID + 3));
    // DumpRegister 委托到 DumpCore::DumpV4Register，桩掉避免真实寄存器访问
    DumpCore core("/tmp/dump_core_v4", 0);
    MOCKER_CPP(&DumpCore::DumpV4Register).stubs();
    coredump.DumpRegister(core, CORE_TYPE_AIC, 0);
}

TEST_F(PlatformImplUtest, CloudV4Exception_Behaviour)
{
    CloudV4Exception exception;
    EXPECT_FALSE(exception.IsArgsDataTypeSizeByByte());
    EXPECT_FALSE(exception.SupportMc2SpacesDump());
    EXPECT_EQ(exception.GetMc2StructSize(), 0U);
}

TEST_F(PlatformImplUtest, CloudV4DataDump_Behaviour)
{
    CloudV4DataDump dataDump;
    EXPECT_EQ(dataDump.GetKfcStackSize(), static_cast<uint64_t>(108) * BLOCK_MIN_SIZE * INTEGER_KILOBYTE);
    EXPECT_EQ(dataDump.GetKfcBinName(), "kfc_dump_stat_ascend950.o");
    EXPECT_TRUE(dataDump.IsUbFromAiCore());
    EXPECT_EQ(dataDump.GetCoreTypeIDOffset(), 36U * 2U);
    EXPECT_EQ(dataDump.GetBlockNum(), 36U * 3U);
    EXPECT_EQ(dataDump.GetStreamSyncTimeout(), 60000 * 30);
    // IsSimtDumpEnabled: > GetBlockNum() * 1M 时启用
    constexpr size_t maxStrLen = 1024U * 1024U;
    EXPECT_FALSE(dataDump.IsSimtDumpEnabled(dataDump.GetBlockNum() * maxStrLen));
    EXPECT_TRUE(dataDump.IsSimtDumpEnabled(dataDump.GetBlockNum() * maxStrLen + 1U));
}

// ---------------- CloudV2Platform (CHIP_CLOUD_V2 / Ascend910B) ----------------
TEST_F(PlatformImplUtest, CloudV2Features_SupportMatrix)
{
    CloudV2Features features;
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_DATA_DUMP));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1));
    EXPECT_TRUE(features.FeatureIsSupport(AdumpPlatformFeature::FEATURE_CORE_DUMP));
}

TEST_F(PlatformImplUtest, CloudV2Coredump_Behaviour)
{
    CloudV2Coredump coredump;
    EXPECT_NE(coredump.CreatePcFixer(), nullptr);
    EXPECT_NE(coredump.CreateRegister(), nullptr);
    EXPECT_EQ(coredump.ConvertCoreId(CORE_TYPE_AIC, 3), 3U);
    EXPECT_EQ(coredump.ConvertCoreId(CORE_TYPE_AIV, 3), static_cast<uint16_t>(CORE_SIZE_AIC + 3));
    DumpCore core("/tmp/dump_core_v2", 0);
    MOCKER_CPP(&DumpCore::DumpV2Register).stubs();
    coredump.DumpRegister(core, CORE_TYPE_AIC, 0);
}

TEST_F(PlatformImplUtest, CloudV2Exception_Behaviour)
{
    CloudV2Exception exception;
    EXPECT_TRUE(exception.IsArgsDataTypeSizeByByte());
    EXPECT_TRUE(exception.SupportMc2SpacesDump());
}

TEST_F(PlatformImplUtest, CloudV2Exception_Mc2StructSize_910_93)
{
    MOCKER(rtGetSocVersion).stubs().will(invoke(rtGetSocVersion910_93Stub));
    CloudV2Exception exception;
    // Ascend910_93 走 HcclOpResParam
    EXPECT_EQ(exception.GetMc2StructSize(), sizeof(HcclOpResParam));
}

TEST_F(PlatformImplUtest, CloudV2Exception_Mc2StructSize_910B)
{
    MOCKER(rtGetSocVersion).stubs().will(invoke(rtGetSocVersion910BStub));
    CloudV2Exception exception;
    // 非 910_93 走 HcclCombinOpParam
    EXPECT_EQ(exception.GetMc2StructSize(), sizeof(HcclCombinOpParam));
}

TEST_F(PlatformImplUtest, CloudV2Exception_Mc2StructSize_GetSocFailed)
{
    MOCKER(rtGetSocVersion).stubs().will(returnValue(static_cast<rtError_t>(1)));
    CloudV2Exception exception;
    // 获取 soc version 失败返回 0
    EXPECT_EQ(exception.GetMc2StructSize(), 0U);
}

TEST_F(PlatformImplUtest, CloudV2DataDump_Behaviour)
{
    CloudV2DataDump dataDump;
    EXPECT_EQ(dataDump.GetKfcStackSize(), static_cast<uint64_t>(75) * BLOCK_MIN_SIZE * INTEGER_KILOBYTE);
    EXPECT_EQ(dataDump.GetKfcBinName(), "kfc_dump_stat_ascend910B.o");
    EXPECT_TRUE(dataDump.IsUbFromAiCore());
    // printf 参数走基类默认值
    EXPECT_EQ(dataDump.GetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(dataDump.GetBlockNum(), 75U);
}

// ---------------- CloudLegacyException (CHIP_CLOUD_TYPE / Ascend910/910A) ----------------
TEST_F(PlatformImplUtest, CloudLegacyException_SupportMc2)
{
    CloudLegacyException exception;
    EXPECT_TRUE(exception.SupportMc2SpacesDump());
    // 未 override，走基类默认
    EXPECT_FALSE(exception.IsArgsDataTypeSizeByByte());
}

TEST_F(PlatformImplUtest, CloudLegacyException_Mc2StructSize_910_93)
{
    MOCKER(rtGetSocVersion).stubs().will(invoke(rtGetSocVersion910_93Stub));
    CloudLegacyException exception;
    EXPECT_EQ(exception.GetMc2StructSize(), sizeof(HcclOpResParam));
}

TEST_F(PlatformImplUtest, CloudLegacyException_Mc2StructSize_NotV93)
{
    MOCKER(rtGetSocVersion).stubs().will(invoke(rtGetSocVersion910BStub));
    CloudLegacyException exception;
    EXPECT_EQ(exception.GetMc2StructSize(), sizeof(HcclCombinOpParam));
}
