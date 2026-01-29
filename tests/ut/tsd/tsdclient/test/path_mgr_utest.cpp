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
#include "mockcpp/mockcpp.hpp"

#include "inc/tsd_path_mgr.h"

using namespace tsd;
using namespace std;

class PathMgrTest : public testing::Test {
protected:
  virtual void SetUp()
  {
      cout << "Before PathMgrTest()" << endl;
  }

  virtual void TearDown()
  {
      cout << "After PathMgrTest" << endl;
      GlobalMockObject::verify();
  }
};

TEST_F(PathMgrTest, BuildCustomSoVfIdPath_Success)
{
  EXPECT_EQ(TsdPathMgr::BuildCustomSoVfIdPath(0U, 0U, 0U, 12345U),
    "/home/CustAiCpuUser/cust_aicpu_0_0_12345/");
}

TEST_F(PathMgrTest, BuildCustAiCpuUserPath_Success)
{
  EXPECT_EQ(TsdPathMgr::BuildCustAiCpuUserPath(32U),
    "/home/CustAiCpuUser1/");
  EXPECT_EQ(TsdPathMgr::BuildCustAiCpuUserPath(1U),
    "/home/CustAiCpuUser1/");
}

TEST_F(PathMgrTest, BuildCustAicpuRootPath_Test)
{
  EXPECT_EQ(TsdPathMgr::BuildCustAicpuRootPath("0"), "/home/CustAiCpuUser");
  EXPECT_EQ(TsdPathMgr::BuildCustAicpuRootPath("1"), "/home/CustAiCpuUser1");
}

TEST_F(PathMgrTest, BuildCustAicpuLibPath_Test)
{
  EXPECT_EQ(TsdPathMgr::BuildCustAicpuLibPath("0"), "/home/CustAiCpuUser/lib/");
}

TEST_F(PathMgrTest, BuildCustAicpuLibLockerPath_Test)
{
  EXPECT_EQ(TsdPathMgr::BuildCustAicpuLibLockerPath("1"), "/home/CustAiCpuUser1/lib_locker");
}

TEST_F(PathMgrTest, GetCustomComputePatchName_Accessless)
{
  EXPECT_EQ(TsdPathMgr::GetCustomComputePatchName(0U), "/var/aicpu_custom_scheduler");
}

TEST_F(PathMgrTest, GetComputePatchName_Accessless)
{
  EXPECT_EQ(TsdPathMgr::GetComputePatchName(0U), "/var/aicpu_scheduler");
}

TEST_F(PathMgrTest, GetQueueSchPatchName_Accessless)
{
  EXPECT_EQ(TsdPathMgr::GetQueueSchPatchName(0U), "/var/queue_schedule");
}

TEST_F(PathMgrTest, GetHccpPatchName_Accessless)
{
  EXPECT_EQ(TsdPathMgr::GetHccpPatchName(0U), "/var/hccp_service.bin");
}

TEST_F(PathMgrTest, GetHeterogeneousRemoteBinPath)
{
  EXPECT_EQ(TsdPathMgr::GetHeterogeneousRemoteBinPath("prefix"), "prefix/runtime/bin/");
}

TEST_F(PathMgrTest, GetHeterogeneousRemoteComoplibPath)
{
  EXPECT_EQ(TsdPathMgr::GetHeterogeneousRemoteComoplibPath("prefix"), "prefix/comop/lib64/");
}

TEST_F(PathMgrTest, GetHeterogeneousRemoteRuntimelibPath)
{
  EXPECT_EQ(TsdPathMgr::GetHeterogeneousRemoteRuntimelibPath("prefix/"), "prefix/runtime/lib64/");
}

TEST_F(PathMgrTest, GetHostSinkSoPath)
{
  EXPECT_EQ(TsdPathMgr::GetHostSinkSoPath(0U, 12345U, 0U),
    "/usr/lib64/aicpu_kernels/0/aicpu_kernels_device/12345_0");
}

TEST_F(PathMgrTest, BuildDriverExtendPackageRootPath)
{
  EXPECT_EQ(TsdPathMgr::BuildDriverExtendPackageRootPath(2U),
    "/home/HwHiAiUser/device-sw-plugin/2/");
}

TEST_F(PathMgrTest, BuildDriverExtendKernelSoRootPath)
{
  EXPECT_EQ(TsdPathMgr::BuildDriverExtendKernelSoRootPath(0U),
    "/usr/lib64/device-sw-plugin/0/device-sw-plugin/");
}

TEST_F(PathMgrTest, BuildDriverExtendPackageDecRootPath)
{
  EXPECT_EQ(TsdPathMgr::BuildDriverExtendPackageDecRootPath(0U),
    "/usr/lib64/device-sw-plugin/0/");
}
