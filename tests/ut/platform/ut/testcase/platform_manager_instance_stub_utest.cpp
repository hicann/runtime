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
  void SetUp() {
    PlatformInfoManager::Instance().platform_infos_map_.clear();
    PlatformInfoManager::Instance().platform_info_map_.clear();
    PlatformInfoManager::Instance().device_platform_infos_map_.clear();
    PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();
    PlatformInfoManager::Instance().init_flag_ = false;
    PlatformInfoManager::Instance().runtime_init_flag_ = false;
  }

  void TearDown() {
    GlobalMockObject::verify();
  }
};

TEST_F(PlatformManagerUTest, platform_instance_001) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
  uint32_t ret = instance.InitializePlatformInfo();
  EXPECT_EQ(ret, 0U);
  // platform info interface
  PlatFormInfos platform_infos;
  platform_infos.SetCoreNumByCoreType("AiCore");
  std::string label = "abc";
  std::string key = "abc";
  std::string val = "abc";
  platform_infos.GetPlatformResWithLock(label, key, val);
  std::map<std::string, std::string> res;
  platform_infos.GetPlatformResWithLock(label, res);
  platform_infos.SetPlatformResWithLock(label, res);
  platform_infos.GetPlatformRes(label, key, val);
  platform_infos.GetCoreNum();
  platform_infos.SaveToBuffer();
}

TEST_F(PlatformManagerUTest, platform_instance_002) {
  PlatformInfoManager &instance = PlatformInfoManager::Instance();
  // platform info interface
  uint32_t ret = instance.InitializePlatformInfo();
  PlatFormInfos platform_infos;
  platform_infos.SetCoreNumByCoreType("AiCore");
  std::string label = "abc";
  std::string key = "abc";
  std::string val = "abc";
  platform_infos.GetPlatformResWithLock(label, key, val);
  std::map<std::string, std::string> res;
  std::string soc = "AiCore";
  ret = platform_infos.GetCoreNumByType(soc);
  EXPECT_EQ(ret, 0);
}
}
