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
class PlatformManagerGeUTest : public testing::Test {
protected:
  void SetUp() {
    PlatformInfoManager::GeInstance().platform_infos_map_.clear();
    PlatformInfoManager::GeInstance().platform_info_map_.clear();
    PlatformInfoManager::GeInstance().device_platform_infos_map_.clear();
    PlatformInfoManager::GeInstance().runtime_device_platform_infos_map_.clear();
    PlatformInfoManager::GeInstance().init_flag_ = false;
    PlatformInfoManager::GeInstance().runtime_init_flag_ = false;
  }

  void TearDown() {
    GlobalMockObject::verify();
  }
};

TEST_F(PlatformManagerGeUTest, platform_ge_instance_001) {
  PlatformInfoManager &ge_instance = PlatformInfoManager::GeInstance();
  uint32_t ret11 = ge_instance.InitializePlatformInfo();
  EXPECT_EQ(ret11, 0U);
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  std::string soc_version = "Ascend910B1";
  uint32_t ret1 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret1, 0U);
  std::string intput_string = "abc";
  PlatformInfo intput_platform_info;

  OptionalInfo optional_info;
  uint32_t ret12 = ge_instance.GetPlatformInfo(intput_string, intput_platform_info, optional_info);
  EXPECT_EQ(ret12, 0U);
  uint32_t ret15 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret15, 0U);
  uint32_t device_id = 0;
  uint32_t ret17 = ge_instance.GetPlatformInstanceByDevice(device_id, platform_infos);
  EXPECT_EQ(ret17, 0U);
  uint32_t ret18 = ge_instance.UpdatePlatformInfos(platform_infos);
  EXPECT_EQ(ret18, 0U);
  uint32_t ret19 = ge_instance.UpdatePlatformInfos(soc_version, platform_infos);
  EXPECT_EQ(ret19, 0U);
  uint32_t ret20 = ge_instance.GetPlatformInfoWithOutSocVersion(platform_infos, optional_infos);
  EXPECT_EQ(ret20, 0U);
  uint32_t ret21 = ge_instance.UpdateRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret21, 0U);
  uint32_t ret22 = ge_instance.GetRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret22, 0U);
  uint32_t ret23 = ge_instance.InitRuntimePlatformInfos("abc");
  EXPECT_EQ(ret23, 0U);
  uint32_t ret24 = ge_instance.Finalize();
  EXPECT_EQ(ret24, 0U);
}

TEST_F(PlatformManagerGeUTest, platform_ge_instance_kirinx90) {
  PlatformInfoManager &ge_instance = PlatformInfoManager::GeInstance();
  uint32_t ret11 = ge_instance.InitializePlatformInfo();
  EXPECT_EQ(ret11, 0U);
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  std::string soc_version = "KirinX90";
  uint32_t ret1 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret1, 0U);
  std::string intput_string = "abc";
  PlatformInfo intput_platform_info;
  OptionalInfo optional_info;
  uint32_t ret12 = ge_instance.GetPlatformInfo(intput_string, intput_platform_info, optional_info);
  EXPECT_EQ(ret12, 0U);
  uint32_t ret15 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret15, 0U);
  uint32_t device_id = 0;
  uint32_t ret17 = ge_instance.GetPlatformInstanceByDevice(device_id, platform_infos);
  EXPECT_EQ(ret17, 0U);
  uint32_t ret18 = ge_instance.UpdatePlatformInfos(platform_infos);
  EXPECT_EQ(ret18, 0U);
  uint32_t ret19 = ge_instance.UpdatePlatformInfos(soc_version, platform_infos);
  EXPECT_EQ(ret19, 0U);
  uint32_t ret20 = ge_instance.GetPlatformInfoWithOutSocVersion(platform_infos, optional_infos);
  EXPECT_EQ(ret20, 0U);
  uint32_t ret21 = ge_instance.UpdateRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret21, 0U);
  uint32_t ret22 = ge_instance.GetRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret22, 0U);
  uint32_t ret23 = ge_instance.InitRuntimePlatformInfos("abc");
  EXPECT_EQ(ret23, 0U);
  uint32_t ret24 = ge_instance.Finalize();
  EXPECT_EQ(ret24, 0U);
}

TEST_F(PlatformManagerGeUTest, platform_ge_instance_kirin9030) {
  PlatformInfoManager &ge_instance = PlatformInfoManager::GeInstance();
  uint32_t ret11 = ge_instance.InitializePlatformInfo();
  EXPECT_EQ(ret11, 0U);
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  std::string soc_version = "Kirin9030";
  uint32_t ret1 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret1, 0U);
  std::string intput_string = "abc";
  PlatformInfo intput_platform_info;
  OptionalInfo optional_info;
  uint32_t ret12 = ge_instance.GetPlatformInfo(intput_string, intput_platform_info, optional_info);
  EXPECT_EQ(ret12, 0U);
  uint32_t ret15 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret15, 0U);
  uint32_t device_id = 0;
  uint32_t ret17 = ge_instance.GetPlatformInstanceByDevice(device_id, platform_infos);
  EXPECT_EQ(ret17, 0U);
  uint32_t ret18 = ge_instance.UpdatePlatformInfos(platform_infos);
  EXPECT_EQ(ret18, 0U);
  uint32_t ret19 = ge_instance.UpdatePlatformInfos(soc_version, platform_infos);
  EXPECT_EQ(ret19, 0U);
  uint32_t ret20 = ge_instance.GetPlatformInfoWithOutSocVersion(platform_infos, optional_infos);
  EXPECT_EQ(ret20, 0U);
  uint32_t ret21 = ge_instance.UpdateRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret21, 0U);
  uint32_t ret22 = ge_instance.GetRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret22, 0U);
  uint32_t ret23 = ge_instance.InitRuntimePlatformInfos("abc");
  EXPECT_EQ(ret23, 0U);
  uint32_t ret24 = ge_instance.Finalize();
  EXPECT_EQ(ret24, 0U);
}
}
