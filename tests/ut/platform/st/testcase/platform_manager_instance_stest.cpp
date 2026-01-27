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
class PlatformManagerSTest : public testing::Test {
protected:
  void SetUp() {
    PlatformInfoManager::Instance().platform_infos_map_.clear();
    PlatformInfoManager::Instance().platform_info_map_.clear();
    PlatformInfoManager::Instance().device_platform_infos_map_.clear();
    PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();
    PlatformInfoManager::Instance().init_flag_ = false;
    PlatformInfoManager::Instance().runtime_init_flag_ = false;
  }

  void TearDown() {
    PlatformInfoManager::Instance().Finalize();
    GlobalMockObject::verify();
  }
};

TEST_F(PlatformManagerSTest, platform_instance_001) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
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
  optional_infos.SetCoreType("Aicore");
  optional_infos.SetL1FusionFlag("false");
  optional_infos.SetAICoreNum(24);
  instance.SetOptionalCompilationInfo(optional_infos);
  PlatFormInfos new_platform_infos;
  OptionalInfos new_optional_infos;
  uint32_t ret2 = instance.GetPlatformInfoWithOutSocVersion(new_platform_infos, new_optional_infos);
  EXPECT_EQ(ret2, 0U);
  uint32_t ret3 = instance.UpdatePlatformInfos(soc_version, new_platform_infos);
  EXPECT_EQ(ret3, 0U);
  uint32_t ret4 = instance.GetPlatformInstanceByDevice(0, platform_infos);
  EXPECT_EQ(ret3, 0U);
  EXPECT_EQ(new_optional_infos.GetAICoreNum(), 24);
}

TEST_F(PlatformManagerSTest, platform_instance_002) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
  uint32_t ret = instance.InitializePlatformInfo();
  EXPECT_EQ(ret, 0U);
  std::string soc_version = "Ascend310P3";
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  (void)instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  platform_infos.SetCoreNumByCoreType("MIX_AIC_AIV");
  EXPECT_EQ(platform_infos.GetCoreNum(), 15);
}

TEST_F(PlatformManagerSTest, platform_instance_003) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
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

TEST_F(PlatformManagerSTest, platform_instance_004) {
  PlatFormInfos platform_infos;
  std::string buf = platform_infos.SaveToBuffer();
  size_t len = buf.size();
  const char* buf_ptr = buf.c_str();
  bool ret = platform_infos.LoadFromBuffer(buf_ptr, len);
  EXPECT_EQ(ret, true);
}

TEST_F(PlatformManagerSTest, platform_instance_005) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
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

TEST_F(PlatformManagerSTest, platform_instance_006) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
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

TEST_F(PlatformManagerSTest, platform_instance_007) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
  uint32_t ret = instance.InitializePlatformInfo();
  EXPECT_EQ(ret, 0U);
  PlatformInfo platform_info;
  OptionalInfo optional_info;
  std::map<std::string, std::string> version_map; 
  std::string soc_version;
  version_map["Arch_type"] = "aaaa";
  instance.ParseVersion(version_map, soc_version, platform_info);
}

TEST_F(PlatformManagerSTest, platform_instance_Trim) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
  uint32_t ret = instance.InitializePlatformInfo();
  EXPECT_EQ(ret, 0U);

  std::string strOk = " \t \t \t \t \t123456 \t \t \t \t";
  instance.Trim(strOk);

  std::string strNg = " \t \t \t \t \t                  ";
  instance.Trim(strNg);
}
}
