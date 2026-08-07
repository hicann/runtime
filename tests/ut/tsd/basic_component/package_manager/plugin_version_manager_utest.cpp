/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager_test_common.h"

using namespace tsd;
using namespace tsdtest;
using namespace std;

namespace {
drvError_t halGetDeviceInfoPluginFlag0(uint32_t, int32_t, int32_t, int64_t* value)
{
    *value = 0;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoPluginFlag1(uint32_t, int32_t, int32_t, int64_t* value)
{
    *value = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoPluginFlag2(uint32_t, int32_t, int32_t, int64_t* value)
{
    *value = 2;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoPluginFlagInvalid(uint32_t, int32_t, int32_t, int64_t* value)
{
    *value = 3;
    return DRV_ERROR_NONE;
}
} // namespace

class PluginVersionManagerComponentTest : public PackageManagerComponentTest {};

TEST_F(PluginVersionManagerComponentTest, IsCompatPluginPackage_CompatDestination_ReturnsTrueOtherwiseFalse)
{
    ProcessModeManager pm(deviceId, 0);
    tsd::PackConfDetail detail;
    detail.decDstDir = tsd::DeviceInstallPath::COMPAT_PLUGIN_PATH;
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.IsCompatPluginPackage(detail));
    detail.decDstDir = tsd::DeviceInstallPath::AICPU_KERNELS_PATH;
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.IsCompatPluginPackage(detail));
    detail.decDstDir = tsd::DeviceInstallPath::OM_PATH;
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.IsCompatPluginPackage(detail));
}

TEST_F(PluginVersionManagerComponentTest, GetPluginUpdateStrategy_DriverNotForce_CachesAndReturnsNotForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlag0));
    EXPECT_EQ(
        pm.GetPackageManager().pluginVersion_.GetPluginUpdateStrategy(),
        tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    // 第二次调用走缓存
    EXPECT_EQ(
        pm.GetPackageManager().pluginVersion_.GetPluginUpdateStrategy(),
        tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.HasComputedPluginStrategy());
}

TEST_F(PluginVersionManagerComponentTest, GetPluginUpdateStrategy_DriverForce_ReturnsForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlag1));
    EXPECT_EQ(
        pm.GetPackageManager().pluginVersion_.GetPluginUpdateStrategy(),
        tsd::PluginUpdateStrategy::PLUGIN_FORCE_UPDATE);
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.HasComputedPluginStrategy());
}

TEST_F(PluginVersionManagerComponentTest, GetPluginUpdateStrategy_DriverNoUpdate_ReturnsNoUpdate)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlag2));
    EXPECT_EQ(
        pm.GetPackageManager().pluginVersion_.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_NO_UPDATE);
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.HasComputedPluginStrategy());
}

TEST_F(PluginVersionManagerComponentTest, GetPluginUpdateStrategy_DriverFails_ReturnsNotForceWithoutCaching)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(
        pm.GetPackageManager().pluginVersion_.GetPluginUpdateStrategy(),
        tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    // 失败不缓存，可重新尝试
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.HasComputedPluginStrategy());
}

TEST_F(PluginVersionManagerComponentTest, GetPluginUpdateStrategy_DriverValueInvalid_ReturnsNotForceWithoutCaching)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlagInvalid));
    EXPECT_EQ(
        pm.GetPackageManager().pluginVersion_.GetPluginUpdateStrategy(),
        tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.HasComputedPluginStrategy());
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_NoUpdateStrategy_ReturnsFalse)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NO_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_DriverFailsAndHostNewer_ReturnsTrue)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {
        "8.4.0", "20260114_115609804"};
    // DRV 失败退化为 NOT_FORCE_UPDATE 走版本比较：host 新于 device 需装包
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_ForceUpdateAndHashDiffers_ReturnsTrue)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    // FORCE_UPDATE 也走 checkcode 兑底：hash 不一致时才下发
    pm.GetPackageManager().hashStore_.GetPkgHostHashValue()["cann-hcomm-compat.tar.gz"] = "hash_host";
    pm.GetPackageManager().hashStore_.GetPkgDeviceHashValue()["cann-hcomm-compat.tar.gz"] = "hash_dev";
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_ForceUpdateAndHashMatches_ReturnsFalse)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    // FORCE_UPDATE 但 host/device checkcode 一致 => 不下发
    pm.GetPackageManager().hashStore_.GetPkgHostHashValue()["cann-hcomm-compat.tar.gz"] = "same";
    pm.GetPackageManager().hashStore_.GetPkgDeviceHashValue()["cann-hcomm-compat.tar.gz"] = "same";
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_DeviceVersionEmptyAndHashDiffers_ReturnsTrue)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    // device 侧未上报该包版本号 => 回落到 checkcode 比较
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {"", ""};
    pm.GetPackageManager().hashStore_.GetPkgHostHashValue()["cann-hcomm-compat.tar.gz"] = "hash_host";
    pm.GetPackageManager().hashStore_.GetPkgDeviceHashValue()["cann-hcomm-compat.tar.gz"] = "hash_dev";
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_DeviceVersionEmptyAndHashMatches_ReturnsFalse)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {"", ""};
    // device 未上报版本，但 checkcode 一致（上轮已下发同版本包）=> 不重复下发
    pm.GetPackageManager().hashStore_.GetPkgHostHashValue()["cann-hcomm-compat.tar.gz"] = "same";
    pm.GetPackageManager().hashStore_.GetPkgDeviceHashValue()["cann-hcomm-compat.tar.gz"] = "same";
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_HostVersionNewer_ReturnsTrue)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {
        "8.5.1", "20260114_115609804"};
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    EXPECT_TRUE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_HostVersionOlder_ReturnsFalse)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {
        "8.4.0", "20260114_115609804"};
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_VersionsMatch_ReturnsFalseWithoutHashFallback)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    // 版本+时间戳完全相等：不再回落 checkcode，直接跳过下发
    pm.GetPackageManager().hashStore_.GetPkgHostHashValue()["cann-hcomm-compat.tar.gz"] = "hash_host";
    pm.GetPackageManager().hashStore_.GetPkgDeviceHashValue()["cann-hcomm-compat.tar.gz"] = "hash_dev";
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, ShouldLoadCompatPluginPkg_HostVersionMissing_ReturnsFalse)
{
    ProcessModeManager pm(deviceId, 0);
    pm.GetPackageManager().pluginVersion_.SetPluginUpdateStrategy(tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    pm.GetPackageManager().pluginVersion_.SetHasComputedPluginStrategy(true);
    pm.GetPackageManager().pluginVersion_.GetDevicePluginVersions()["cann-hcomm-compat.tar.gz"] = {
        "8.5.0", "20260114_115609804"};
    // 不写入 hostPluginVersions_，模拟 .ini 缺失 → 跳过下发 + WARN
    pm.GetPackageManager().hashStore_.GetPkgHostHashValue()["cann-hcomm-compat.tar.gz"] = "h1";
    pm.GetPackageManager().hashStore_.GetPkgDeviceHashValue()["cann-hcomm-compat.tar.gz"] = "h2";
    EXPECT_FALSE(pm.GetPackageManager().pluginVersion_.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(PluginVersionManagerComponentTest, HandleDevicePluginVersionRsp_SuccessWithDuplicates_ReplacesOldData)
{
    ProcessModeManager manager(deviceId, 0);
    auto& pluginVersion = manager.GetPackageManager().pluginVersion_;
    pluginVersion.GetDevicePluginVersions()["stale.tar.gz"] = {"1.0", "old"};
    HDCMessage msg;
    msg.set_tsd_rsp_code(0U);
    auto* first = msg.add_device_plugin_versions();
    first->set_package_name("plugin-a.tar.gz");
    first->set_version("8.5.0");
    first->set_timestamp("20260801");
    auto* second = msg.add_device_plugin_versions();
    second->set_package_name("plugin-b.tar.gz");
    second->set_version("9.0.0");
    second->set_timestamp("20260802");
    auto* duplicate = msg.add_device_plugin_versions();
    duplicate->set_package_name("plugin-a.tar.gz");
    duplicate->set_version("8.5.1");
    duplicate->set_timestamp("20260803");

    pluginVersion.HandleDevicePluginVersionRsp(msg);

    const auto& versions = pluginVersion.GetDevicePluginVersions();
    EXPECT_EQ(versions.size(), 2U);
    EXPECT_EQ(versions.count("stale.tar.gz"), 0U);
    EXPECT_EQ(versions.at("plugin-a.tar.gz").version, "8.5.1");
    EXPECT_EQ(versions.at("plugin-a.tar.gz").timestamp, "20260803");
    EXPECT_EQ(versions.at("plugin-b.tar.gz").version, "9.0.0");
    EXPECT_EQ(manager.GetPackageManager().ctx_.pkgRspCode, ResponseCode::SUCCESS);
}

TEST_F(PluginVersionManagerComponentTest, HandleDevicePluginVersionRsp_FailureCode_SetsFailureAndStoresPayload)
{
    ProcessModeManager manager(deviceId, 0);
    HDCMessage msg;
    msg.set_tsd_rsp_code(17U);
    auto* info = msg.add_device_plugin_versions();
    info->set_package_name("plugin.tar.gz");
    info->set_version("8.4.0");
    info->set_timestamp("20260731");

    manager.GetPackageManager().pluginVersion_.HandleDevicePluginVersionRsp(msg);

    const auto& versions = manager.GetPackageManager().pluginVersion_.GetDevicePluginVersions();
    ASSERT_EQ(versions.size(), 1U);
    EXPECT_EQ(versions.at("plugin.tar.gz").version, "8.4.0");
    EXPECT_EQ(versions.at("plugin.tar.gz").timestamp, "20260731");
    EXPECT_EQ(manager.GetPackageManager().ctx_.pkgRspCode, ResponseCode::FAIL);
}
