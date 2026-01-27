/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "utils/status.h"

#ifndef private
#define private public
#define protected public
#endif
#include "load_platform_info.h"
#undef private
#undef protected

using namespace std;
using namespace aicpu;

class TEST_PlatformRebuild_UTest : public testing::Test {};

TEST_F(TEST_PlatformRebuild_UTest, ProcessPlatformInfoMsg_01) {
  std::cout << "ProcessPlatformInfoMsg start" << std::endl;
  auto ret = PlatformRebuild::GetInstance().ProcessPlatformInfoMsg(0UL, 0UL);
  EXPECT_EQ(ret, KERNEL_STATUS_PARAM_INVALID);
  std::cout << "ProcessPlatformInfoMsg end" << std::endl;
}

TEST_F(TEST_PlatformRebuild_UTest, ProcessPlatformInfoMsg_02) {
  PlatformInfoArgs tempArgs;
  tempArgs.input_data_info = 0UL;
  tempArgs.input_data_len = 0UL;
  tempArgs.platform_instance = 0UL;
  uint64_t input_addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&tempArgs));
  uint64_t data_len = static_cast<uint64_t>(sizeof(tempArgs));
  auto ret = PlatformRebuild::GetInstance().ProcessPlatformInfoMsg(input_addr, data_len);
  EXPECT_EQ(ret, KERNEL_STATUS_PARAM_INVALID);
}

TEST_F(TEST_PlatformRebuild_UTest, ProcessPlatformInfoMsg_03) {
  fe::PlatFormInfos *platform_infos = new(std::nothrow) fe::PlatFormInfos();
  PlatformInfoArgs tempArgs;
  tempArgs.input_data_info = 123456UL;
  tempArgs.input_data_len = 10UL;
  tempArgs.platform_instance = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(platform_infos));
  uint64_t input_addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&tempArgs));
  uint64_t data_len = static_cast<uint64_t>(sizeof(tempArgs));
  auto ret = PlatformRebuild::GetInstance().ProcessPlatformInfoMsg(input_addr, data_len);
  if (platform_infos != nullptr) {
    delete platform_infos;
  }
  EXPECT_EQ(ret, KERNEL_STATUS_INNER_ERROR);
}

TEST_F(TEST_PlatformRebuild_UTest, ProcessPlatformInfoMsg_04) {
  fe::PlatFormInfos *platform_infos = new(std::nothrow) fe::PlatFormInfos();
  PlatformInfoArgs tempArgs;
  tempArgs.input_data_info = 123456UL;
  tempArgs.input_data_len = 5UL;
  tempArgs.platform_instance = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(platform_infos));
  uint64_t input_addr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&tempArgs));
  uint64_t data_len = static_cast<uint64_t>(sizeof(tempArgs));
  auto ret = PlatformRebuild::GetInstance().ProcessPlatformInfoMsg(input_addr, data_len);
  if (platform_infos != nullptr) {
    delete platform_infos;
  }
  EXPECT_EQ(ret, KERNEL_STATUS_OK);
}