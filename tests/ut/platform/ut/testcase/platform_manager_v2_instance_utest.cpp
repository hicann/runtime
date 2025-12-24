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
#include "platform_manager_v2.h"
#include "platform_infos_utils.h"
#include "platform_infos_lite_impl.h"
#undef protected
#undef private


namespace fe {
class PlatformManagerV2UTest : public testing::Test {
protected:
  void SetUp() {
    std::lock_guard<std::mutex> lock_guard(PlatformManagerV2::Instance().soc_lock_);
    PlatformManagerV2::Instance().soc_file_status_.clear();
    PlatformManagerV2::Instance().platform_infos_map_.clear();
  }

  void TearDown() {
    std::lock_guard<std::mutex> lock_guard(PlatformManagerV2::Instance().soc_lock_);
    PlatformManagerV2::Instance().soc_file_status_.clear();
    PlatformManagerV2::Instance().platform_infos_map_.clear();
    GlobalMockObject::verify();
  }
};

TEST_F(PlatformManagerV2UTest, platform_instance_001) {
  PlatformManagerV2 &instance = PlatformManagerV2::Instance();
  std::string value_arch = "";
  uint32_t ret = instance.GetSocSpec("Ascend910B1", "Version", "NpuArch", value_arch);
  EXPECT_EQ(value_arch, "");

  ret = instance.GetSocSpec("Ascend910B1", "version", "NpuArch", value_arch);
  EXPECT_EQ(value_arch, "2201");

  ret = instance.GetSocSpec("Ascend910B1", "version", "Npu-Arch", value_arch);
  EXPECT_EQ(ret, 0xFFFFFFFF);
}

TEST_F(PlatformManagerV2UTest, platform_instance_Trim) {
  std::string strOk = " \t \t \t \t \t123456 \t \t \t \t";
  std::vector<std::string> res_vec;
  fe::PlatformInfosUtils::Split(strOk, ' ', res_vec);
  fe::PlatformInfosUtils::Trim(strOk);
  EXPECT_EQ(strOk, "123456");

  std::string strNg = " \t \t \t \t \t                  ";
  fe::PlatformInfosUtils::Split(strOk, '\t', res_vec);
  fe::PlatformInfosUtils::Trim(strNg);
  EXPECT_EQ(strNg, "");
}

}