/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <mockcpp/mockcpp.hpp>
#include <cstdint>
#include <cstring>
#include <string>
#include "platform_plugin_manager_ut_helper.h"

namespace fe {
namespace {
constexpr uint32_t UT_MAX_DEV_NUM = 64;
} // namespace

class PlatformPluginManagerUTest : public testing::Test {
protected:
    void SetUp() override {}

    void TearDown() override { GlobalMockObject::verify(); }
};

// 单例已由 ut_helper 头文件的静态初始化配置为指向 depends/ascend_hal_stub.cc 的实现
// （懒加载 flag 置位，跳过 mmDlopen），覆盖生产代码经由 GetInstance() 调用 HAL 的路径。
TEST_F(PlatformPluginManagerUTest, Singleton_ConfiguredToHalStub_AllApisWork)
{
    auto& plugin_manager = PlatformPluginManager::GetInstance();

    uint32_t devices[UT_MAX_DEV_NUM] = {0};
    EXPECT_EQ(plugin_manager.DrvGetDevIDs(devices, UT_MAX_DEV_NUM), static_cast<drvError_t>(DRV_ERROR_NONE));
    EXPECT_EQ(devices[0], 0U);

    char soc_version[64] = {0};
    EXPECT_EQ(
        plugin_manager.HalGetSocVersion(0, soc_version, sizeof(soc_version)), static_cast<drvError_t>(DRV_ERROR_NONE));
    EXPECT_STREQ(soc_version, "Ascend960PR_8399");

    int64_t val = 0;
    EXPECT_EQ(
        plugin_manager.HalGetDeviceInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &val),
        static_cast<drvError_t>(DRV_ERROR_NONE));
    EXPECT_EQ(val, 32);

    EXPECT_EQ(
        plugin_manager.HalGetDeviceInfo(0, MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &val),
        static_cast<drvError_t>(DRV_ERROR_NONE));
    EXPECT_EQ(val, 8);
}

// 独立实例 + 懒加载 flag 置位但函数指针为空：模拟 dlsym 符号缺失，全部接口降级为
// DRV_ERROR_NOT_SUPPORT（每个接口独立校验，覆盖部分符号缺失场景）。
TEST_F(PlatformPluginManagerUTest, SymbolMissing_AllApisDegradeToNotSupport)
{
    PlatformPluginManager plugin_manager;
    plugin_manager.initialized_ = true;

    uint32_t devices[UT_MAX_DEV_NUM] = {0};
    EXPECT_EQ(plugin_manager.DrvGetDevIDs(devices, UT_MAX_DEV_NUM), static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));

    char soc_version[64] = {0};
    EXPECT_EQ(
        plugin_manager.HalGetSocVersion(0, soc_version, sizeof(soc_version)),
        static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));

    int64_t val = 0;
    EXPECT_EQ(
        plugin_manager.HalGetDeviceInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &val),
        static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));
}

// 独立实例（懒加载 flag 未置位）：真实 mmDlopen("libascend_hal.so") 在无驱动库的 UT 环境
// 加载失败，全部接口降级为 DRV_ERROR_NOT_SUPPORT。若 UT 环境恰好存在真实驱动库则跳过
// （该环境无法验证降级路径）。
TEST_F(PlatformPluginManagerUTest, RealDlopenFail_AllApisDegradeToNotSupport)
{
    PlatformPluginManager plugin_manager;
    // 经由真实 mmDlopen 触发懒加载后，句柄仍为空说明驱动库缺失，才能继续验证降级语义。
    uint32_t probe_devices[UT_MAX_DEV_NUM] = {0};
    (void)plugin_manager.DrvGetDevIDs(probe_devices, UT_MAX_DEV_NUM);
    if (plugin_manager.plugin_handle_ != nullptr) {
        return; // UT 环境存在真实 libascend_hal.so，无法构造加载失败场景
    }

    uint32_t devices[UT_MAX_DEV_NUM] = {0};
    EXPECT_EQ(plugin_manager.DrvGetDevIDs(devices, UT_MAX_DEV_NUM), static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));

    char soc_version_2[64] = {0};
    EXPECT_EQ(
        plugin_manager.HalGetSocVersion(0, soc_version_2, sizeof(soc_version_2)),
        static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));

    int64_t val = 0;
    EXPECT_EQ(
        plugin_manager.HalGetDeviceInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &val),
        static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));
}

// 独立实例的懒加载状态与单例相互隔离：局部实例加载失败不影响已配置的单例继续工作。
TEST_F(PlatformPluginManagerUTest, IndependentInstances_LazyStateIsolated)
{
    PlatformPluginManager plugin_manager;
    uint32_t devices[UT_MAX_DEV_NUM] = {0};
    (void)plugin_manager.DrvGetDevIDs(devices, UT_MAX_DEV_NUM); // 触发真实懒加载
    if (plugin_manager.plugin_handle_ == nullptr) {
        int64_t val = 0;
        EXPECT_EQ(
            plugin_manager.HalGetDeviceInfo(0, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &val),
            static_cast<drvError_t>(DRV_ERROR_NOT_SUPPORT));
    }

    auto& singleton = PlatformPluginManager::GetInstance();
    char soc_version[64] = {0};
    EXPECT_EQ(singleton.HalGetSocVersion(0, soc_version, sizeof(soc_version)), static_cast<drvError_t>(DRV_ERROR_NONE));
    EXPECT_STREQ(soc_version, "Ascend960PR_8399");
}

// 单例语义：GetInstance 返回同一实例。
TEST_F(PlatformPluginManagerUTest, GetInstance_ReturnsSameSingleton)
{
    PlatformPluginManager& first = PlatformPluginManager::GetInstance();
    PlatformPluginManager& second = PlatformPluginManager::GetInstance();
    EXPECT_EQ(&first, &second);
}
} // namespace fe
