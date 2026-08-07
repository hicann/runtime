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
mmDirent2** g_packageDirList = nullptr;
std::string g_platformLabel;
std::string g_platformKey;

bool CaptureShortSocVersion(fe::PlatFormInfos*, const std::string& label, const std::string& key, std::string& value)
{
    g_platformLabel = label;
    g_platformKey = key;
    value = "Ascend910B";
    return true;
}

drvError_t halGetSocVersionStub(uint32_t, char* socVersion, uint32_t len)
{
    return strcpy_s(socVersion, len, "Ascend910B1") == EOK ? DRV_ERROR_NONE : DRV_ERROR_INVALID_VALUE;
}

int32_t mmScandir2_invoke(const char*, mmDirent2*** entryList, mmFilter2, mmSort2)
{
    g_packageDirList = static_cast<mmDirent2**>(malloc(sizeof(mmDirent2*)));
    g_packageDirList[0] = static_cast<mmDirent2*>(malloc(sizeof(mmDirent2)));
    (void)strcpy_s(
        g_packageDirList[0]->d_name, sizeof(g_packageDirList[0]->d_name), "Ascend310-aicpu_syskernels.tar.gz");
    *entryList = g_packageDirList;
    return 1;
}

void mmScandirFree2_invoke(mmDirent2**, int32_t)
{
    free(g_packageDirList[0]);
    free(g_packageDirList);
    g_packageDirList = nullptr;
}

int32_t mmScandir2_invokeExtend(const char*, mmDirent2*** entryList, mmFilter2, mmSort2)
{
    g_packageDirList = static_cast<mmDirent2**>(malloc(sizeof(mmDirent2*) * 2U));
    g_packageDirList[0] = static_cast<mmDirent2*>(malloc(sizeof(mmDirent2)));
    g_packageDirList[1] = static_cast<mmDirent2*>(malloc(sizeof(mmDirent2)));
    (void)strcpy_s(
        g_packageDirList[0]->d_name, sizeof(g_packageDirList[0]->d_name), "Ascend-aicpu_extend_syskernels.tar.gz");
    (void)strcpy_s(g_packageDirList[1]->d_name, sizeof(g_packageDirList[1]->d_name), "Ascend-aicpu_syskernels.tar.gz");
    *entryList = g_packageDirList;
    return 2;
}

void mmScandirFree2_invokeExtend(mmDirent2**, int32_t)
{
    free(g_packageDirList[0]);
    free(g_packageDirList[1]);
    free(g_packageDirList);
    g_packageDirList = nullptr;
}
} // namespace

class PackageEnvInfoComponentTest : public PackageManagerComponentTest {};

TEST_F(PackageEnvInfoComponentTest, GetAscendLatestIntallPath_LatestPathEnvSet_ReturnsEnvValue)
{
    char env[] = "/usr/local/Asend/lastest";
    MOCKER(&mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    std::string pkgBasePath;
    envInfo.GetAscendLatestIntallPath(pkgBasePath);
    EXPECT_EQ(pkgBasePath, "/usr/local/Asend/lastest");
}

TEST_F(PackageEnvInfoComponentTest, GetCurHostMutexFile_LegacyAndV2DriverResults_ReturnExpectedNames)
{
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);

    EXPECT_EQ(envInfo.GetCurHostMutexFile(false), "libqueue_schedule.so");

    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(envInfo.GetCurHostMutexFile(true), "libqueue_schedule.so");

    EXPECT_EQ(envInfo.GetCurHostMutexFile(true), "sink_file_mutex_0.cfg");
}

TEST_F(PackageEnvInfoComponentTest, GetCurHostMutexFile_PhysicalIdLookupFails_ReturnsLegacyMutexName)
{
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    EXPECT_EQ(envInfo.GetCurHostMutexFile(false), "libqueue_schedule.so");
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    MOCKER(drvDeviceGetPhyIdByIndex).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(envInfo.GetCurHostMutexFile(true), "libqueue_schedule.so");
}

TEST_F(PackageEnvInfoComponentTest, GetCurHostMutexFile_MasterIdAvailable_ReturnsDeviceMutexName)
{
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    EXPECT_EQ(envInfo.GetCurHostMutexFile(false), "libqueue_schedule.so");
    EXPECT_EQ(envInfo.GetCurHostMutexFile(true), "sink_file_mutex_0.cfg");
}

TEST_F(PackageEnvInfoComponentTest, GetShortSocVersion_PlatformResourceAvailable_ReturnsExactShortVersion)
{
    MOCKER(halGetSocVersion).stubs().will(invoke(halGetSocVersionStub));
    using GetPlatformResFnT = bool (fe::PlatFormInfos::*)(const std::string&, const std::string&, std::string&);
    const std::string expectedShortVersion = "Ascend910B";
    g_platformLabel.clear();
    g_platformKey.clear();
    MOCKER_CPP(static_cast<GetPlatformResFnT>(&fe::PlatFormInfos::GetPlatformRes))
        .expects(once())
        .will(invoke(CaptureShortSocVersion));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    std::string shortSocVersion = "sentinel";
    const auto ret = envInfo.GetShortSocVersion(shortSocVersion);
    EXPECT_TRUE(ret);
    EXPECT_EQ(g_platformLabel, "version");
    EXPECT_EQ(g_platformKey, "Short_SoC_version");
    EXPECT_EQ(shortSocVersion, expectedShortVersion);
}

TEST_F(PackageEnvInfoComponentTest, GetShortSocVersion_HalLookupFails_ReturnsFalse)
{
    MOCKER(halGetSocVersion).stubs().will(returnValue(1));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    std::string shortSocVersion;
    const auto ret = envInfo.GetShortSocVersion(shortSocVersion);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageEnvInfoComponentTest, GetShortSocVersion_PlatformResourceMissing_ReturnsFalse)
{
    MOCKER(halGetSocVersion).stubs().will(invoke(halGetSocVersionStub));
    MOCKER_CPP(
        &fe::PlatFormInfos::GetPlatformRes,
        bool(fe::PlatFormInfos::*)(const std::string& label, const std::string& key, std::string& val))
        .stubs()
        .will(returnValue(false));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    std::string shortSocVersion;
    const auto ret = envInfo.GetShortSocVersion(shortSocVersion);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageEnvInfoComponentTest, CheckPackageExists_NoDirectoryEntryMatches_ReturnsFalse)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    // MOCKER(mmScandir2).stubs().will(returnValue(0));
    // MOCKER(mmScandirFree2).stubs().will(returnValue(0));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    const bool ret = envInfo.CheckPackageExists();
    EXPECT_EQ(ret, false);
}

TEST_F(PackageEnvInfoComponentTest, CheckPackageExists_ScanFails_ReturnsFalse)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    MOCKER(mmScandir2).stubs().will(returnValue(-1));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    const bool ret = envInfo.CheckPackageExists();
    EXPECT_EQ(ret, false);
}

TEST_F(PackageEnvInfoComponentTest, CheckPackageExists_AicpuPackageEntryMatches_ReturnsTrue)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    MOCKER(mmScandir2).stubs().will(invoke(mmScandir2_invoke));
    MOCKER(mmScandirFree2).stubs().will(invoke(mmScandirFree2_invoke));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    const bool ret = envInfo.CheckPackageExists();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageEnvInfoComponentTest, GetPackagePath_AicpuEnvSet_ReturnsChipSpecificPath)
{
    char envpath[] = "/home";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&envpath[0U]));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    std::string env = "";
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    envInfo.GetPackagePath(env, 0U);
    EXPECT_EQ(env, "/home/opp/Ascend310/aicpu/");
}

TEST_F(PackageEnvInfoComponentTest, GetPackageTitle_Ascend910B_ReturnsAscend)
{
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_ASCEND_910B);
    std::string pkgTitle;
    envInfo.GetPackageTitle(pkgTitle);
    EXPECT_EQ(pkgTitle, "Ascend");
}

TEST_F(PackageEnvInfoComponentTest, CheckPackageExists_ExtendPackageEntryMatches_ReturnsTrue)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    MOCKER(mmScandir2).stubs().will(invoke(mmScandir2_invokeExtend));
    MOCKER(mmScandirFree2).stubs().will(invoke(mmScandirFree2_invokeExtend));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_ASCEND_910B);
    const bool ret = envInfo.CheckPackageExists();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageEnvInfoComponentTest, CheckPackageExists_PackagePathResolutionFails_ReturnsFalse)
{
    using GetPackagePathSig = bool (PackageEnvInfo::*)(std::string&, const uint32_t) const;
    MOCKER_CPP(static_cast<GetPackagePathSig>(&PackageEnvInfo::GetPackagePath)).stubs().will(returnValue(false));
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    const bool ret = envInfo.CheckPackageExists();
    EXPECT_EQ(ret, false);
}

TEST_F(PackageEnvInfoComponentTest, GetPackagePath_PackageTitleUnavailable_ReturnsFalse)
{
    MOCKER_CPP(&PackageEnvInfo::GetPackageTitle).stubs().will(returnValue(false));
    std::string kernelPath;
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_MINI);
    const bool ret = envInfo.GetPackagePath(kernelPath, 0U);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageEnvInfoComponentTest, GetPackageTitle_UnknownChip_ReturnsFalseAndEmptyTitle)
{
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_END);
    std::string pkgTitle;
    const bool ret = envInfo.GetPackageTitle(pkgTitle);
    EXPECT_EQ(ret, false);
    EXPECT_STREQ(pkgTitle.c_str(), "");
}

TEST_F(PackageEnvInfoComponentTest, GetPackageTitle_Ascend910A_ReturnsAscend910)
{
    PackageEnvInfo envInfo(deviceId, static_cast<uint32_t>(ModeType::ONLINE), false, CHIP_ASCEND_910A);
    std::string pkgTitle;
    const bool ret = envInfo.GetPackageTitle(pkgTitle);
    EXPECT_EQ(ret, true);
    EXPECT_STREQ(pkgTitle.c_str(), "Ascend910");
}
