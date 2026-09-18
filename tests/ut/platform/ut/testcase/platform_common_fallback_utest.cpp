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
#include <cstdio>     // std::remove
#include <sys/stat.h> // mkdir
#include <fstream>
#include <map>
#include <string>
#define protected public
#define private public
#include "platform_infos_utils.h"
#include "platform_info.h"
#include "platform_manager_v2.h"
#undef protected
#undef private
#include "driver/ascend_hal_base.h"

namespace fe {
namespace {

constexpr uint32_t UT_DEV_ID = 0;
const std::string UT_SOC_VERSION = "Ascend960PR_8399";
const std::string UT_CFG_DIR = "/tmp/ut_platform_config";

} // namespace

class PlatformCommonFallbackUTest : public testing::Test {
protected:
    void SetUp() override
    {
        // UT_CFG_DIR must exist before WriteCommonIni() writes the common ini into it,
        // otherwise std::ofstream fails silently and the fallback tests see a missing file.
        (void)mkdir(UT_CFG_DIR.c_str(), 0755);
    }

    void TearDown() override { GlobalMockObject::verify(); }

    // Minimal ini that satisfies AssemblePlatformInfoVector: [version] + [SoCInfo].
    static void WriteCommonIni(const std::string& path)
    {
        std::ofstream ofs(path);
        ofs << "[version]\n"
            << "SoC_version=Ascend960PR_common\n"
            << "Short_SoC_version=Ascend960PR\n"
            << "[SoCInfo]\n"
            << "memory_type=\n"
            << "memory_size=0\n"
            << "[AICoreSpec]\n"
            << "cube_freq=0\n";
    }

    static void ResetPimState()
    {
        auto& pim = PlatformInfoManager::Instance();
        pim.loaded_ini_files_.clear();
        pim.platform_info_map_.clear();
        pim.platform_infos_map_.clear();
    }

    static void ResetPm2State()
    {
        auto& pm2 = PlatformManagerV2::Instance();
        pm2.soc_file_status_.clear();
        pm2.platform_infos_map_.clear();
    }
};

// ---------- FindCommonFile ----------

TEST_F(PlatformCommonFallbackUTest, FindCommonFile_KnownPrefix_ReturnsCommonPath)
{
    std::string common_path;
    EXPECT_TRUE(PlatformInfosUtils::FindCommonFile("Ascend960PR_8399", UT_CFG_DIR, common_path));
    EXPECT_EQ(common_path, UT_CFG_DIR + "/Ascend960PR_common.ini");
}

TEST_F(PlatformCommonFallbackUTest, FindCommonFile_DtPrefix_ReturnsDtCommonPath)
{
    std::string common_path;
    EXPECT_TRUE(PlatformInfosUtils::FindCommonFile("Ascend960DT_1234", UT_CFG_DIR, common_path));
    EXPECT_EQ(common_path, UT_CFG_DIR + "/Ascend960DT_common.ini");
}

TEST_F(PlatformCommonFallbackUTest, FindCommonFile_UnknownPrefix_ReturnsFalse)
{
    std::string common_path;
    EXPECT_FALSE(PlatformInfosUtils::FindCommonFile("Ascend910B", UT_CFG_DIR, common_path));
    EXPECT_TRUE(common_path.empty());
}

TEST_F(PlatformCommonFallbackUTest, FindCommonFile_PrefixIsNotSubstring_RequiresLeadingMatch)
{
    // strncmp compares the leading bytes only: "xAscend960PR" must NOT match.
    std::string common_path;
    EXPECT_FALSE(PlatformInfosUtils::FindCommonFile("xAscend960PR", UT_CFG_DIR, common_path));
}

// ---------- IsFileExist ----------

TEST_F(PlatformCommonFallbackUTest, IsFileExist_ExistingFile_ReturnsTrue)
{
    const std::string path = "/tmp/ut_isfileexist_probe.ini";
    {
        std::ofstream ofs(path);
        ofs << "[version]\n";
    }
    EXPECT_TRUE(PlatformInfosUtils::IsFileExist(path));
    (void)std::remove(path.c_str());
}

TEST_F(PlatformCommonFallbackUTest, IsFileExist_MissingFile_ReturnsFalse)
{
    EXPECT_FALSE(PlatformInfosUtils::IsFileExist("/tmp/ut_isfileexist_no_such_file.ini"));
}

TEST_F(PlatformCommonFallbackUTest, IsFileExist_EmptyPath_ReturnsFalse)
{
    EXPECT_FALSE(PlatformInfosUtils::IsFileExist(""));
}

// ---------- GetDeviceIdBySocVersion ----------

TEST_F(PlatformCommonFallbackUTest, GetDeviceIdBySocVersion_MappedSoc_ReturnsDevId)
{
    uint32_t dev_id = 0xFFFFFFFF;
    EXPECT_TRUE(PlatformInfosUtils::GetDeviceIdBySocVersion(UT_SOC_VERSION, dev_id));
    EXPECT_EQ(dev_id, UT_DEV_ID);
}

TEST_F(PlatformCommonFallbackUTest, GetDeviceIdBySocVersion_UnmappedSoc_ReturnsFalse)
{
    uint32_t dev_id = 0xFFFFFFFF;
    EXPECT_FALSE(PlatformInfosUtils::GetDeviceIdBySocVersion("Ascend960DT_9999", dev_id));
}

// ---------- EnrichSectionsByHAL ----------

TEST_F(PlatformCommonFallbackUTest, EnrichSectionsByHAL_HalOk_FillsCoreCounts)
{
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    EXPECT_EQ(PlatformInfosUtils::EnrichSectionsByHAL(UT_SOC_VERSION, content_info_map), 0U);
    EXPECT_EQ(content_info_map["SoCInfo"]["ai_core_cnt"], "32");
    EXPECT_EQ(content_info_map["SoCInfo"]["cube_core_cnt"], "32");
    EXPECT_EQ(content_info_map["SoCInfo"]["ai_cpu_cnt"], "8");
}

TEST_F(PlatformCommonFallbackUTest, EnrichSectionsByHAL_NoDeviceMapping_ReturnsFailed)
{
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    // Unmapped soc -> GetDeviceIdBySocVersion fails -> PLATFORM_FAILED(0xFFFFFFFF)
    EXPECT_EQ(PlatformInfosUtils::EnrichSectionsByHAL("Ascend960DT_9999", content_info_map), 0xFFFFFFFFU);
    EXPECT_TRUE(content_info_map.empty());
}

// ---------- Exact ini missing -> quiet fallback ----------

TEST_F(PlatformCommonFallbackUTest, PimEnsureSocVersionLoaded_ExactIniMissing_FallsBackToCommonIni)
{
    ResetPimState();
    auto& pim = PlatformInfoManager::Instance();
    pim.cfg_file_real_path_ = UT_CFG_DIR;

    // Only the common ini exists on disk; the exact Ascend960PR_8399.ini does NOT.
    // The loader must probe existence first and quietly fall back (no error log for
    // the missing exact file), then enrich via HAL and cache under the target soc name.
    WriteCommonIni(UT_CFG_DIR + "/Ascend960PR_common.ini");

    EXPECT_EQ(pim.EnsureSocVersionLoaded(UT_SOC_VERSION), 0U);
    EXPECT_TRUE(pim.loaded_ini_files_.count(UT_SOC_VERSION) > 0);
    // Platform infos must be cached under the TARGET soc version, not the common name.
    EXPECT_TRUE(pim.platform_infos_map_.count(UT_SOC_VERSION) > 0);
    EXPECT_TRUE(pim.platform_infos_map_.count("Ascend960PR_common") == 0);
    // HAL-enriched field must be present.
    std::string ai_core_cnt;
    EXPECT_TRUE(pim.platform_infos_map_[UT_SOC_VERSION].GetPlatformRes("SoCInfo", "ai_core_cnt", ai_core_cnt));
    EXPECT_EQ(ai_core_cnt, "32");

    ResetPimState();
    (void)std::remove((UT_CFG_DIR + "/Ascend960PR_common.ini").c_str());
}

TEST_F(PlatformCommonFallbackUTest, Pm2InitPlatformInfos_ExactIniMissing_FallsBackToCommonIni)
{
    ResetPm2State();
    auto& pm2 = PlatformManagerV2::Instance();
    pm2.cfg_file_real_path_ = UT_CFG_DIR;
    WriteCommonIni(UT_CFG_DIR + "/Ascend960PR_common.ini");

    // Probe must skip the missing exact ini quietly and succeed via common file + HAL enrichment.
    EXPECT_EQ(pm2.InitPlatformInfos(UT_SOC_VERSION), 0U);
    EXPECT_TRUE(pm2.platform_infos_map_.count(UT_SOC_VERSION) > 0);
    std::string ai_core_cnt;
    EXPECT_TRUE(pm2.platform_infos_map_[UT_SOC_VERSION].GetPlatformRes("SoCInfo", "ai_core_cnt", ai_core_cnt));
    EXPECT_EQ(ai_core_cnt, "32");

    ResetPm2State();
    (void)std::remove((UT_CFG_DIR + "/Ascend960PR_common.ini").c_str());
}

TEST_F(PlatformCommonFallbackUTest, PimEnsureSocVersionLoaded_NoExactNoCommon_ReturnsFailed)
{
    ResetPimState();
    auto& pim = PlatformInfoManager::Instance();
    pim.cfg_file_real_path_ = UT_CFG_DIR;
    // Neither exact nor common ini exists -> fallback fails; error log IS expected here.
    (void)std::remove((UT_CFG_DIR + "/Ascend960PR_common.ini").c_str());
    EXPECT_EQ(pim.EnsureSocVersionLoaded(UT_SOC_VERSION), 0xFFFFFFFFU);
    EXPECT_TRUE(pim.loaded_ini_files_.empty());
    ResetPimState();
}

// ---------- Exact ini exists but broken -> error out, NO fallback ----------

TEST_F(PlatformCommonFallbackUTest, PimEnsureSocVersionLoaded_ExactIniExistsButBroken_ErrorsOutWithoutFallback)
{
    ResetPimState();
    auto& pim = PlatformInfoManager::Instance();
    pim.cfg_file_real_path_ = UT_CFG_DIR;

    // Exact ini EXISTS on disk but is unloadable (LoadIniFile stubbed to fail).
    // Contract: existence means "load it"; a load failure is a real fault ->
    // report error and return WITHOUT trying the common-file fallback.
    const std::string exact_path = UT_CFG_DIR + "/" + UT_SOC_VERSION + ".ini";
    {
        std::ofstream ofs(exact_path);
        ofs << "[version]\nSoC_version=" << UT_SOC_VERSION << "\n";
    }
    WriteCommonIni(UT_CFG_DIR + "/Ascend960PR_common.ini"); // fallback would succeed if attempted

    MOCKER(&PlatformInfoManager::LoadIniFile).stubs().will(returnValue(0xFFFFFFFFU));

    EXPECT_EQ(pim.EnsureSocVersionLoaded(UT_SOC_VERSION), 0xFFFFFFFFU);
    // Fallback must NOT have happened: nothing cached, soc not marked as loaded.
    EXPECT_TRUE(pim.loaded_ini_files_.empty());
    EXPECT_TRUE(pim.platform_infos_map_.empty());

    ResetPimState();
    (void)std::remove(exact_path.c_str());
    (void)std::remove((UT_CFG_DIR + "/Ascend960PR_common.ini").c_str());
}

TEST_F(PlatformCommonFallbackUTest, Pm2InitPlatformInfos_ExactIniExistsButBroken_ErrorsOutWithoutFallback)
{
    ResetPm2State();
    auto& pm2 = PlatformManagerV2::Instance();
    pm2.cfg_file_real_path_ = UT_CFG_DIR;

    const std::string exact_path = UT_CFG_DIR + "/" + UT_SOC_VERSION + ".ini";
    {
        std::ofstream ofs(exact_path);
        ofs << "[version]\nSoC_version=" << UT_SOC_VERSION << "\n";
    }
    WriteCommonIni(UT_CFG_DIR + "/Ascend960PR_common.ini");

    MOCKER(&PlatformManagerV2::LoadIniFile).stubs().will(returnValue(0xFFFFFFFFU));

    EXPECT_EQ(pm2.InitPlatformInfos(UT_SOC_VERSION), 0xFFFFFFFFU);
    EXPECT_TRUE(pm2.platform_infos_map_.empty());

    ResetPm2State();
    (void)std::remove(exact_path.c_str());
    (void)std::remove((UT_CFG_DIR + "/Ascend960PR_common.ini").c_str());
}

// ---------- PIM / PM2 LoadCommonIniFileWithHAL failure paths ----------

TEST_F(PlatformCommonFallbackUTest, PimLoadCommonIniFileWithHAL_IniLoadFails_ReturnsFailed)
{
    auto& pim = PlatformInfoManager::Instance();
    pim.cfg_file_real_path_ = "/nonexistent_dir"; // common ini will not be found on disk
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    EXPECT_EQ(pim.LoadCommonIniFileWithHAL(UT_SOC_VERSION, content_info_map), 0xFFFFFFFFU);
}

TEST_F(PlatformCommonFallbackUTest, PimLoadCommonIniFileWithHAL_UnknownPrefix_ReturnsFailed)
{
    auto& pim = PlatformInfoManager::Instance();
    pim.cfg_file_real_path_ = UT_CFG_DIR;
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    // Ascend910B has no prefix rule -> Step 1 fails directly.
    EXPECT_EQ(pim.LoadCommonIniFileWithHAL("Ascend910B", content_info_map), 0xFFFFFFFFU);
}

TEST_F(PlatformCommonFallbackUTest, Pm2LoadCommonIniFileWithHAL_UnknownPrefix_ReturnsFailed)
{
    auto& pm2 = PlatformManagerV2::Instance();
    pm2.cfg_file_real_path_ = UT_CFG_DIR;
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    EXPECT_EQ(pm2.LoadCommonIniFileWithHAL("Ascend910B", content_info_map), 0xFFFFFFFFU);
}

} // namespace fe
