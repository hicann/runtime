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
#include <mockcpp/mockcpp.hpp>

#include "iostream"
#include "stdlib.h"
#define protected public
#define private public
#include "platform_info.h"
#undef protected
#undef private

namespace fe {
class PlatformManagerUTest : public testing::Test {
protected:
    void SetUp()
    {
        PlatformInfoManager::Instance().platform_infos_map_.clear();
        PlatformInfoManager::Instance().platform_info_map_.clear();
        PlatformInfoManager::Instance().device_platform_infos_map_.clear();
        PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();
        PlatformInfoManager::Instance().loaded_ini_files_.clear();
        PlatformInfoManager::Instance().cfg_file_real_path_.clear();
        PlatformInfoManager::Instance().opti_compilation_info_ = OptionalInfo();
        PlatformInfoManager::Instance().opti_compilation_infos_ = OptionalInfos();
        PlatformInfoManager::Instance().init_flag_ = false;
        PlatformInfoManager::Instance().runtime_init_flag_ = false;
    }

    void TearDown()
    {
        PlatformInfoManager::Instance().Finalize();
        GlobalMockObject::verify();
    }
};

TEST_F(PlatformManagerUTest, platform_instance_001)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    uint32_t ret_failed = instance.GetPlatformInfoWithOutSocVersion(platform_infos, optional_infos);
    EXPECT_NE(ret_failed, 0U);
    uint32_t ret1 = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_EQ(ret1, 0U);
    optional_infos.SetSocVersion(soc_version);
    optional_infos.SetCoreType("AiCore");
    optional_infos.SetL1FusionFlag("false");
    optional_infos.SetAICoreNum(24);
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    uint32_t ret2 = instance.GetPlatformInfo(soc_version, platform_info, optional_info);
    EXPECT_EQ(ret2, 0U);
    optional_info.soc_version = soc_version;
    instance.SetOptionalCompilationInfo(optional_info);
    ret2 = instance.GetPlatformInfoWithOutSocVersion(platform_info, optional_info);
    EXPECT_EQ(ret2, 0U);
    PlatFormInfos new_platform_infos;
    OptionalInfos new_optional_infos;
    ret2 = instance.GetPlatformInfoWithOutSocVersion(new_platform_infos, new_optional_infos);
    EXPECT_EQ(ret2, 0U);
    // platform info interface
    platform_infos.SetCoreNumByCoreType("AiCore");
    EXPECT_EQ(platform_infos.GetCoreNum(), 24);
    uint64_t l0a = 0;
    platform_infos.GetLocalMemSize(LocalMemType::L0_A, l0a);
    EXPECT_EQ(l0a, 65536);
    uint64_t l0b = 0;
    platform_infos.GetLocalMemSize(LocalMemType::L0_B, l0b);
    EXPECT_EQ(l0b, 65536);
    uint64_t l0c = 0;
    platform_infos.GetLocalMemSize(LocalMemType::L0_C, l0c);
    EXPECT_EQ(l0c, 131072);
    uint64_t l1 = 0;
    platform_infos.GetLocalMemSize(LocalMemType::L1, l1);
    EXPECT_EQ(l1, 524288);
    uint64_t l2 = 0;
    platform_infos.GetLocalMemSize(LocalMemType::L2, l2);
    EXPECT_EQ(l2, 201326592);
    uint64_t ub = 0;
    platform_infos.GetLocalMemSize(LocalMemType::UB, ub);
    EXPECT_EQ(ub, 196608);
    std::string value;
    bool b_ret = platform_infos.GetPlatformRes("SoCInfo", "cube_vector_combine", value);
    EXPECT_EQ(b_ret, true);
    EXPECT_EQ(value, "split");
    std::map<std::string, std::string> value_map;
    b_ret = platform_infos.GetPlatformRes("SoCInfo", value_map);
    EXPECT_EQ(b_ret, true);
    b_ret = platform_infos.GetPlatformRes("ONLYTEST", value_map);
    EXPECT_EQ(b_ret, false);

    uint32_t ret3 = instance.UpdatePlatformInfos(soc_version, new_platform_infos);
    EXPECT_EQ(ret3, 0U);
    ret3 = instance.UpdatePlatformInfos(new_platform_infos);
    EXPECT_EQ(ret3, 0U);
    uint32_t ret4 = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_EQ(ret4, 0U);
    EXPECT_EQ(new_optional_infos.GetSocVersion(), soc_version);
    EXPECT_EQ(new_optional_infos.GetAICoreNum(), 24);
    EXPECT_EQ(new_optional_infos.GetCoreType(), "AiCore");
    EXPECT_EQ(new_optional_infos.GetL1FusionFlag(), "false");
}

TEST_F(PlatformManagerUTest, platform_instance_002)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend310P1";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    platform_infos.SetCoreNumByCoreType("MIX_AIV");
    EXPECT_EQ(platform_infos.GetCoreNum(), 18);
}

TEST_F(PlatformManagerUTest, platform_instance_003)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend310P1";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    std::string buf = platform_infos.SaveToBuffer();
    size_t len = buf.size();
    const char* buf_ptr = buf.c_str();
    platform_infos.LoadFromBuffer(buf_ptr, len);
}

TEST_F(PlatformManagerUTest, platform_instance_004)
{
    PlatFormInfos platform_infos;
    std::string buf = platform_infos.SaveToBuffer();
    size_t len = buf.size();
    const char* buf_ptr = buf.c_str();
    bool ret = platform_infos.LoadFromBuffer(buf_ptr, len);
    EXPECT_EQ(ret, true);
}

TEST_F(PlatformManagerUTest, platform_instance_005)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend310P3";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 7);
    EXPECT_EQ(aicore_num, 8);
}

TEST_F(PlatformManagerUTest, platform_instance_006)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend310P3";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    std::map<std::string, std::string> res;
    res["ai_core_cnt"] = "ss";
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    platform_infos.SetPlatformRes("SoCInfo", res);
    uint32_t aicore_num = platform_infos.GetCoreNumByType("ai_core_cnt");
    EXPECT_EQ(aicore_num, -1);
}

TEST_F(PlatformManagerUTest, platform_instance_007)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    std::map<std::string, std::string> version_map;
    std::string soc_version;
    version_map["Arch_type"] = "aaaa";
    instance.ParseVersion(version_map, soc_version, platform_info);
}

TEST_F(PlatformManagerUTest, platform_instance_008)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "KirinX90";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 1);
    EXPECT_EQ(aicore_num, 1);
}

TEST_F(PlatformManagerUTest, platform_instance_009)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Kirin9030";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    auto fixpipe_map = optional_infos.GetFixPipeDtypeMap();
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 1);
    EXPECT_EQ(aicore_num, 1);
}

TEST_F(PlatformManagerUTest, platform_instance_010)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "KirinDev0000";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    auto fixpipe_map = optional_infos.GetFixPipeDtypeMap();
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 4);
    EXPECT_EQ(aicore_num, 4);
}

TEST_F(PlatformManagerUTest, platform_instance_011)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "KirinDev0001";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    auto fixpipe_map = optional_infos.GetFixPipeDtypeMap();
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 5);
    EXPECT_EQ(aicore_num, 5);
}

TEST_F(PlatformManagerUTest, platform_instance_012)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "KirinDev0002";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    auto fixpipe_map = optional_infos.GetFixPipeDtypeMap();
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 1);
    EXPECT_EQ(aicore_num, 1);
}

TEST_F(PlatformManagerUTest, platform_instance_013)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "KirinDev0003";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    auto fixpipe_map = optional_infos.GetFixPipeDtypeMap();
    uint32_t aicore_num = platform_infos.GetCoreNumByType("AiCore");
    uint32_t vector_core_num = platform_infos.GetCoreNumByType("VectorCore");
    EXPECT_EQ(vector_core_num, 5);
    EXPECT_EQ(aicore_num, 5);
}

TEST_F(PlatformManagerUTest, platform_instance_Trim)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);

    std::string strOk = " \t \t \t \t \t123456 \t \t \t \t";
    instance.Trim(strOk);

    std::string strNg = " \t \t \t \t \t                  ";
    instance.Trim(strNg);
}

TEST_F(PlatformManagerUTest, platform_instance_InitByInstance_success)
{
    PlatFormInfos platform_infos;
    EXPECT_EQ(platform_infos.platform_infos_impl_, nullptr);
    bool ret = platform_infos.InitByInstance();
    EXPECT_EQ(ret, true);
    EXPECT_NE(platform_infos.platform_infos_impl_, nullptr);
}

TEST_F(PlatformManagerUTest, platform_instance_InitByInstance_already_initialized)
{
    PlatFormInfos platform_infos;
    bool ret = platform_infos.InitByInstance();
    EXPECT_EQ(ret, true);
    auto first_impl = platform_infos.platform_infos_impl_;
    ret = platform_infos.InitByInstance();
    EXPECT_EQ(ret, true);
    EXPECT_EQ(platform_infos.platform_infos_impl_, first_impl);
}

TEST_F(PlatformManagerUTest, platform_instance_lazy_load_success)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    EXPECT_EQ(instance.platform_infos_map_.count(soc_version), 0U);
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    ret = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.platform_infos_map_.count(soc_version), 1U);
    EXPECT_EQ(instance.loaded_ini_files_.count(soc_version), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_lazy_load_no_repeat)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    ret = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_EQ(ret, 0U);
    size_t loaded_count = instance.loaded_ini_files_.size();
    ret = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.loaded_ini_files_.size(), loaded_count);
}

TEST_F(PlatformManagerUTest, platform_instance_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "NonExistentSoC";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    ret = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfo_lazy_load)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    ret = instance.GetPlatformInfo(soc_version, platform_info, optional_info);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.platform_info_map_.count(soc_version), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfoWithOutSocVersion_lazy_load)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    OptionalInfo optional_info;
    optional_info.soc_version = soc_version;
    instance.SetOptionalCompilationInfo(optional_info);
    PlatformInfo platform_info;
    OptionalInfo out_optional_info;
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_info, out_optional_info);
    EXPECT_EQ(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInstanceByDevice_lazy_load)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion(soc_version);
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos platform_infos;
    ret = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.device_platform_infos_map_.count(0), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_EnsureSocVersionLoaded_empty)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.EnsureSocVersionLoaded("");
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_Finalize_clears_loaded)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_FALSE(instance.loaded_ini_files_.empty());
    EXPECT_FALSE(instance.cfg_file_real_path_.empty());
    ret = instance.Finalize();
    EXPECT_EQ(ret, 0U);
    EXPECT_TRUE(instance.loaded_ini_files_.empty());
    EXPECT_TRUE(instance.cfg_file_real_path_.empty());
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfo_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "NonExistentSoC";
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    ret = instance.GetPlatformInfo(soc_version, platform_info, optional_info);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfoWithOutSocVersion_empty_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_info, optional_info);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfoWithOutSocVersion_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfo optional_info;
    optional_info.soc_version = "NonExistentSoC";
    instance.SetOptionalCompilationInfo(optional_info);
    PlatformInfo platform_info;
    OptionalInfo out_optional_info;
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_info, out_optional_info);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfoWithOutSocVersion_PlatformInfos_empty_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_infos, optional_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfoWithOutSocVersion_PlatformInfos_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion("NonExistentSoC");
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos platform_infos;
    OptionalInfos out_optional_infos;
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_infos, out_optional_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInstanceByDevice_empty_soc_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatFormInfos platform_infos;
    ret = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInstanceByDevice_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion("NonExistentSoC");
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos platform_infos;
    ret = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInstanceByDevice_Ascend910_mapping)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion("Ascend910");
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos platform_infos;
    ret = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.loaded_ini_files_.count("Ascend910A"), 1U);
    EXPECT_EQ(instance.device_platform_infos_map_.count(0), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_InitializePlatformInfo_repeat)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_Trim_empty)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    std::string str = "";
    instance.Trim(str);
    EXPECT_EQ(str, "");
}

TEST_F(PlatformManagerUTest, platform_instance_EnsureSocVersionLoaded_repeat)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    ret = instance.EnsureSocVersionLoaded("Ascend910B1");
    EXPECT_EQ(ret, 0U);
    ret = instance.EnsureSocVersionLoaded("Ascend910B1");
    EXPECT_EQ(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfo_Ascend910_mapping)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    ret = instance.GetPlatformInfo("Ascend910", platform_info, optional_info);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.loaded_ini_files_.count("Ascend910A"), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_SetOptionalCompilationInfo_Ascend910_mapping)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    OptionalInfo optional_info;
    optional_info.soc_version = "Ascend910";
    instance.SetOptionalCompilationInfo(optional_info);
    EXPECT_EQ(instance.opti_compilation_info_.soc_version, "Ascend910A");
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfos_Ascend910_mapping)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    ret = instance.GetPlatformInfos("Ascend910", platform_infos, optional_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.loaded_ini_files_.count("Ascend910A"), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfo_defensive)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    PlatformInfo platform_info;
    OptionalInfo optional_info;
    ret = instance.GetPlatformInfo(soc_version, platform_info, optional_info);
    EXPECT_EQ(ret, 0U);
    instance.platform_info_map_.erase(soc_version);
    ret = instance.GetPlatformInfo(soc_version, platform_info, optional_info);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfos_defensive)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    PlatFormInfos platform_infos;
    OptionalInfos optional_infos;
    ret = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_EQ(ret, 0U);
    instance.platform_infos_map_.erase(soc_version);
    ret = instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInfoWithOutSocVersion_PlatformInfos_defensive)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion("Ascend910B1");
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos platform_infos;
    OptionalInfos out_optional_infos;
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_infos, out_optional_infos);
    EXPECT_EQ(ret, 0U);
    instance.platform_infos_map_.erase("Ascend910B1");
    ret = instance.GetPlatformInfoWithOutSocVersion(platform_infos, out_optional_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_GetPlatformInstanceByDevice_defensive)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion("Ascend910B1");
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos platform_infos;
    ret = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_EQ(ret, 0U);
    instance.platform_infos_map_.erase("Ascend910B1");
    instance.device_platform_infos_map_.clear();
    ret = instance.GetPlatformInstanceByDevice(0, platform_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_with_soc_lazy_load_success)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    EXPECT_EQ(instance.platform_infos_map_.count(soc_version), 0U);
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos(soc_version, new_platform_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.platform_infos_map_.count(soc_version), 1U);
    EXPECT_EQ(instance.loaded_ini_files_.count(soc_version), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_with_soc_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "NonExistentSoC";
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos(soc_version, new_platform_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_with_soc_Ascend910_mapping)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos("Ascend910", new_platform_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.loaded_ini_files_.count("Ascend910A"), 1U);
    EXPECT_EQ(instance.platform_infos_map_.count("Ascend910A"), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_with_soc_empty_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos("", new_platform_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_no_soc_lazy_load_success)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    std::string soc_version = "Ascend910B1";
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion(soc_version);
    instance.SetOptionalCompilationInfo(optional_infos);
    EXPECT_EQ(instance.platform_infos_map_.count(soc_version), 0U);
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos(new_platform_infos);
    EXPECT_EQ(ret, 0U);
    EXPECT_EQ(instance.platform_infos_map_.count(soc_version), 1U);
    EXPECT_EQ(instance.loaded_ini_files_.count(soc_version), 1U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_no_soc_lazy_load_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    OptionalInfos optional_infos;
    optional_infos.Init();
    optional_infos.SetSocVersion("NonExistentSoC");
    instance.SetOptionalCompilationInfo(optional_infos);
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos(new_platform_infos);
    EXPECT_NE(ret, 0U);
}

TEST_F(PlatformManagerUTest, platform_instance_UpdatePlatformInfos_no_soc_empty_fail)
{
    PlatformInfoManager& instance = PlatformInfoManager::Instance();
    uint32_t ret = instance.InitializePlatformInfo();
    EXPECT_EQ(ret, 0U);
    PlatFormInfos new_platform_infos;
    ret = instance.UpdatePlatformInfos(new_platform_infos);
    EXPECT_NE(ret, 0U);
}
} // namespace fe