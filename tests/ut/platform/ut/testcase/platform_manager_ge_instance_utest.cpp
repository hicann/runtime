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
    PlatformInfoManager::GeInstance().Finalize();
    GlobalMockObject::verify();
  }
};

TEST_F(PlatformManagerGeUTest, platform_ge_instance_001) {
  PlatformInfoManager &ge_instance = PlatformInfoManager::GeInstance();
  std::string soc_version = "Ascend910B1";
  ge_instance.InitRuntimePlatformInfos(soc_version);
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  uint32_t ret1 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret1, 0U);
  uint32_t ret2 = ge_instance.GetRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret2, 0U);
  uint32_t ret3 = ge_instance.UpdateRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret3, 0U);
}

TEST_F(PlatformManagerGeUTest, platform_ge_instance_kirinx90) {
  PlatformInfoManager &ge_instance = PlatformInfoManager::GeInstance();
  std::string soc_version = "KirinX90";
  ge_instance.InitRuntimePlatformInfos(soc_version);
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  uint32_t ret1 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret1, 0U);
  uint32_t ret2 = ge_instance.GetRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret2, 0U);
  uint32_t ret3 = ge_instance.UpdateRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret3, 0U);
}

TEST_F(PlatformManagerGeUTest, platform_ge_instance_kirin9030) {
  PlatformInfoManager &ge_instance = PlatformInfoManager::GeInstance();
  std::string soc_version = "Kirin9030";
  ge_instance.InitRuntimePlatformInfos(soc_version);
  PlatFormInfos platform_infos;
  OptionalInfos optional_infos;
  uint32_t ret1 = ge_instance.GetPlatformInfos(soc_version, platform_infos, optional_infos);
  EXPECT_EQ(ret1, 0U);
  uint32_t ret2 = ge_instance.GetRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret2, 0U);
  uint32_t ret3 = ge_instance.UpdateRuntimePlatformInfosByDevice(0, platform_infos);
  EXPECT_EQ(ret3, 0U);
}
}
