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

#include <cstring>
#include <iostream>
#include <string>
#include <vector>

#include "acl/acl_platform.h"

#define protected public
#define private public
#include "platform_info.h"
#undef protected
#undef private

namespace fe {
class PlatformManagerAclUTest : public testing::Test {
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

    uint32_t ret = PlatformInfoManager::Instance().InitializePlatformInfo();
    ASSERT_EQ(ret, 0U);

    // Bind soc_version via OptionalInfos so GetPlatformInfoWithOutSocVersion succeeds
    PlatFormInfos pf;
    OptionalInfos opti;
    ret = PlatformInfoManager::Instance().GetPlatformInfos("Ascend910B1", pf, opti);
    ASSERT_EQ(ret, 0U);
    opti.SetSocVersion("Ascend910B1");
    opti.SetCoreType("AiCore");
    opti.SetL1FusionFlag("false");
    opti.SetAICoreNum(24);
    PlatformInfoManager::Instance().SetOptionalCompilationInfo(opti);
  }

  void TearDown()
  {
    PlatformInfoManager::Instance().Finalize();
    GlobalMockObject::verify();
  }
};

// ============================================================================
// aclplatformGetDeviceInfo — normal path
// ============================================================================

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_AICORE_CNT)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "24");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_AICORE_UB_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_UB_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "196608");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_CUBE_CORE_CNT)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_CUBE_CORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "24");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_VECTOR_CORE_CNT)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_VECTOR_CORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "48");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_L2_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_L2_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "201326592");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_MEMORY_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_MEMORY_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "68719476736");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_CUBE_FREQ)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_CUBE_FREQ, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "1850");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_VEC_FREQ)
{
  // Ascend910B1 has no independent VectorCoreSpec section → vec_freq not found
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_VEC_FREQ, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_BT_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_BT_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "1024");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_L0_A_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_L0_A_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "65536");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_L0_B_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_L0_B_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "65536");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_L0_C_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_L0_C_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "131072");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_L1_SIZE)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_L1_SIZE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "524288");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_SOC_VERSION)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_SOC_VERSION, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "Ascend910B1");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_AIC_VERSION)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AIC_VERSION, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "AIC-C-220");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_NPU_ARCH)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_NPU_ARCH, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "2201");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_MEMORY_TYPE)
{
  // Ascend910B1.ini has empty memory_type → returns not found
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_MEMORY_TYPE, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// ============================================================================
// aclplatformGetDeviceInfo — error paths
// ============================================================================

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_null_value)
{
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, nullptr, 64);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_zero_maxLen)
{
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, 0U);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_buffer_too_small)
{
  char buf[2] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_SOC_VERSION, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetDeviceInfo_invalid_enum)
{
  char buf[64] = {0};
  // Cast a value beyond the last valid enum
  aclError ret = aclplatformGetDeviceInfo(static_cast<aclplatformDevInfo>(999), buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// ============================================================================
// aclplatformGetInstructionInfo — normal path
// ============================================================================

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_AI_CORE_vadd)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_vadd", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "float16,float32,int32,int16");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_AI_CORE_vmul)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_vmul", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "float16,float32,int32,int16");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_AI_CORE_vrec)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_vrec", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "float16,float32");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_VECTOR_CORE_vadd)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_VECTOR_CORE,
                                               "Intrinsic_vadd", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "float16,float32,int32,int16");
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_VECTOR_CORE_vmul)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_VECTOR_CORE,
                                               "Intrinsic_vmul", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "float16,float32,int32,int16");
}

// ============================================================================
// aclplatformGetInstructionInfo — error paths
// ============================================================================

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_null_instruction)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               nullptr, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_null_value)
{
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_vadd", nullptr, 256);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_zero_maxLen)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_vadd", buf, 0U);
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_invalid_core_type)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(static_cast<aclplatformCoreType>(99),
                                               "Intrinsic_vadd", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_not_found)
{
  char buf[256] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_NotExist", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(PlatformManagerAclUTest, acl_platform_GetInstructionInfo_buffer_too_small)
{
  char buf[4] = {0};
  aclError ret = aclplatformGetInstructionInfo(ACL_PLATFORM_CORE_TYPE_AI_CORE,
                                               "Intrinsic_vadd", buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// ============================================================================
// GetPlatFormInfos — fallback chain coverage
// ============================================================================
// Query order:
//   Step 1: Instance  – GetRuntimePlatformInfosByDevice(0)
//   Step 2: Instance  – GetPlatformInfoWithOutSocVersion
//   Step 3: GeInstance – GetRuntimePlatformInfosByDevice(0)
//   Step 4: GeInstance – GetPlatformInfoWithOutSocVersion

// ---- Step 1: Instance GetRuntimePlatformInfosByDevice succeeds ----
TEST_F(PlatformManagerAclUTest, GetPlatFormInfos_Step1_Instance_RuntimeDevice)
{
  // Wipe OptionalInfos so step 2 won't accidentally succeed
  PlatformInfoManager::Instance().opti_compilation_infos_ = OptionalInfos();

  // Load valid PlatFormInfos and inject into runtime_device_platform_infos_map_
  fe::PlatFormInfos pf;
  fe::OptionalInfos opti;
  ASSERT_EQ(PlatformInfoManager::Instance().GetPlatformInfos("Ascend910B1", pf, opti), 0U);
  PlatformInfoManager::Instance().runtime_device_platform_infos_map_[0] = pf;

  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "24");
}

// ---- Step 2: Instance GetPlatformInfoWithOutSocVersion succeeds ----
// (all existing normal-path tests exercise this path implicitly)

// ---- Steps 1-2 fail, Step 3: GeInstance GetRuntimePlatformInfosByDevice succeeds ----
TEST_F(PlatformManagerAclUTest, GetPlatFormInfos_Step3_GeInstance_RuntimeDevice)
{
  // Wipe Instance completely so steps 1-2 fail
  PlatformInfoManager::Instance().opti_compilation_infos_ = OptionalInfos();
  PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();

  // Initialize GeInstance and inject runtime device data
  PlatformInfoManager::GeInstance().InitializePlatformInfo();
  fe::PlatFormInfos pf;
  fe::OptionalInfos opti;
  ASSERT_EQ(PlatformInfoManager::GeInstance().GetPlatformInfos("Ascend910B1", pf, opti), 0U);
  PlatformInfoManager::GeInstance().runtime_device_platform_infos_map_[0] = pf;

  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "24");

  PlatformInfoManager::GeInstance().Finalize();
}

// ---- Steps 1-3 fail, Step 4: GeInstance GetPlatformInfoWithOutSocVersion succeeds ----
TEST_F(PlatformManagerAclUTest, GetPlatFormInfos_Step4_GeInstance_OptionalInfos)
{
  // Wipe Instance completely
  PlatformInfoManager::Instance().opti_compilation_infos_ = OptionalInfos();
  PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();
  PlatformInfoManager::GeInstance().opti_compilation_infos_ = OptionalInfos();
  fe::PlatFormInfos pf;
  pf.Init();
  PlatformInfoManager::GeInstance().runtime_platform_infos_ = pf;
  PlatformInfoManager::GeInstance().runtime_device_platform_infos_map_.clear();

  // Initialize GeInstance with OptionalInfos
  PlatformInfoManager::GeInstance().InitializePlatformInfo();
  fe::OptionalInfos opti;
  ASSERT_EQ(PlatformInfoManager::GeInstance().GetPlatformInfos("Ascend910B1", pf, opti), 0U);
  opti.SetSocVersion("Ascend910B1");
  opti.SetCoreType("AiCore");
  opti.SetL1FusionFlag("false");
  opti.SetAICoreNum(24);
  PlatformInfoManager::GeInstance().SetOptionalCompilationInfo(opti);

  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_SUCCESS);
  EXPECT_STREQ(buf, "24");

  PlatformInfoManager::GeInstance().Finalize();
}

// ---- All 4 steps fail: returns ACL_ERROR_INTERNAL_ERROR ----
TEST_F(PlatformManagerAclUTest, GetPlatFormInfos_AllFail)
{
  // Wipe Instance completely
  PlatformInfoManager::Instance().opti_compilation_infos_ = OptionalInfos();
  PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();
  PlatformInfoManager::Instance().platform_infos_map_.clear();
  PlatformInfoManager::Instance().loaded_ini_files_.clear();
  PlatformInfoManager::GeInstance().opti_compilation_infos_ = OptionalInfos();
  fe::PlatFormInfos pf;
  pf.Init();
  PlatformInfoManager::GeInstance().runtime_platform_infos_ = pf;
  PlatformInfoManager::GeInstance().runtime_device_platform_infos_map_.clear();
  // GeInstance is uninitialized → all 4 steps fail
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

// ---- Instance OptionalInfos cleared, only GeInstance OptionalInfos set ----
// Ensures proper fallthrough when Instance env is clean.
TEST_F(PlatformManagerAclUTest, GetPlatFormInfos_FallbackToGeInstance_OnlyOptional)
{
  // Clear Instance OptionalInfos but keep platform_infos_map_ loaded
  PlatformInfoManager::Instance().opti_compilation_infos_ = OptionalInfos();
  PlatformInfoManager::Instance().runtime_device_platform_infos_map_.clear();
  PlatformInfoManager::GeInstance().opti_compilation_infos_ = OptionalInfos();
  fe::PlatFormInfos pf;
  pf.Init();
  PlatformInfoManager::GeInstance().runtime_platform_infos_ = pf;
  PlatformInfoManager::GeInstance().runtime_device_platform_infos_map_.clear();

  // GeInstance not set up → steps 1-4 all fail
  char buf[64] = {0};
  aclError ret = aclplatformGetDeviceInfo(ACL_PLATFORM_AICORE_CNT, buf, sizeof(buf));
  EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

}  // namespace fe
