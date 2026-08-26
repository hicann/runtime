/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "platform_info.h"

/*
 * 本 UT 专门覆盖 src/tsd/stub/stub_external_deps.cpp 桩文件的行为。
 *
 * 该桩文件用于"没有 platform target 可以链接"的场景，为 fe::PlatformInfoManager
 * 和 fe::PlatFormInfos::GetPlatformRes 提供空实现占位符号。
 *
 * 现有 tsd_client_utest 链接的是真实 platform 库，桩的代码路径从未被执行。
 * 本 target 不链接 platform 库，直接编译桩文件，固化桩的返回值契约，
 * 防止将来桩行为变更无人察觉。
 */
namespace {

// Instance() 应返回非空引用，且多次调用返回同一实例（单例契约）
TEST(StubExternalDepsTest, InstanceReturnsSingleton)
{
    fe::PlatformInfoManager& ref1 = fe::PlatformInfoManager::Instance();
    fe::PlatformInfoManager& ref2 = fe::PlatformInfoManager::Instance();
    EXPECT_EQ(&ref1, &ref2);
}

// InitializePlatformInfo() 桩实现返回 0
TEST(StubExternalDepsTest, InitializePlatformInfoReturnsZero)
{
    uint32_t ret = fe::PlatformInfoManager::Instance().InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
}

// GetPlatformInfos() 桩实现返回 0，且不应修改出参
TEST(StubExternalDepsTest, GetPlatformInfosReturnsZero)
{
    fe::PlatFormInfos platform_infos;
    fe::OptionalInfos opt_infos;
    const std::string soc_version = "Ascend910B";
    uint32_t ret = fe::PlatformInfoManager::Instance().GetPlatformInfos(soc_version, platform_infos, opt_infos);
    EXPECT_EQ(ret, 0U);
}

// PlatFormInfos::GetPlatformRes(label, key, val) 桩实现返回 false，且不应修改 val
TEST(StubExternalDepsTest, GetPlatformResReturnsFalse)
{
    fe::PlatFormInfos platform_infos;
    const std::string original_val = "original";
    std::string val = original_val;
    bool ret = platform_infos.GetPlatformRes("label", "key", val);
    EXPECT_FALSE(ret);
    EXPECT_EQ(val, original_val);
}

} // namespace
