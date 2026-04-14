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
#include "mockcpp/ChainingMockHelper.h"

#include "inc/tsd_path_mgr.h"
#include "tsd_util_func.h"

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
      GlobalMockObject::reset();
  }
};

TEST_F(PathMgrTest, BuildKernelSoRootPathWithDestPath)
{
    uint32_t uniqueVfId = 2;
    string destPath = "/custom/path/";
    string result = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId, destPath);
    EXPECT_EQ(result, "/custom/path/aicpu_kernels/2/");
}

TEST_F(PathMgrTest, BuildKernelSoRootPathWithDestPathEmpty)
{
    uint32_t uniqueVfId = 2;
    string destPath = "";
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(false));
    string result = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId, destPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/");
}

TEST_F(PathMgrTest, BuildKernelSoRootPathWithDestPathZeroVfId)
{
    uint32_t uniqueVfId = 0;
    string destPath = "/custom/path/";
    string result = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId, destPath);
    EXPECT_EQ(result, "/custom/path/aicpu_kernels/0/");
}

TEST_F(PathMgrTest, BuildKernelSoRootPathHeterogeneousProduct)
{
    uint32_t uniqueVfId = 1;
    string destPath = "";
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(true));
    string result = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId, destPath);
    EXPECT_EQ(result, "/home/HwHiAiUser/inuse/aicpu_kernels/1/");
}

TEST_F(PathMgrTest, BuildKernelSoRootPathNotHeterogeneousProduct)
{
    uint32_t uniqueVfId = 3;
    string destPath = "";
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(false));
    string result = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId, destPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/3/");
}

TEST_F(PathMgrTest, BuildKernelSoRootPathLargeVfId)
{
    uint32_t uniqueVfId = 65535;
    string destPath = "";
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(false));
    string result = TsdPathMgr::BuildKernelSoRootPath(uniqueVfId, destPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/65535/");
}

TEST_F(PathMgrTest, BuildKernelSoPathWithVfId)
{
    uint32_t uniqueVfId = 2;
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(false));
    string result = TsdPathMgr::BuildKernelSoPath(uniqueVfId);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/aicpu_kernels_device/");
}

TEST_F(PathMgrTest, BuildKernelSoPathWithVfIdZero)
{
    uint32_t uniqueVfId = 0;
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(false));
    string result = TsdPathMgr::BuildKernelSoPath(uniqueVfId);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/0/aicpu_kernels_device/");
}

TEST_F(PathMgrTest, BuildKernelSoPathWithVfIdHeterogeneous)
{
    uint32_t uniqueVfId = 1;
    MOCKER(IsHeterogeneousProduct).stubs().will(returnValue(true));
    string result = TsdPathMgr::BuildKernelSoPath(uniqueVfId);
    EXPECT_EQ(result, "/home/HwHiAiUser/inuse/aicpu_kernels/1/aicpu_kernels_device/");
}

TEST_F(PathMgrTest, BuildKernelSoPathWithRootPath)
{
    string kernelSoRootPath = "/usr/lib64/aicpu_kernels/2/";
    string result = TsdPathMgr::BuildKernelSoPath(kernelSoRootPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/aicpu_kernels_device/");
}

TEST_F(PathMgrTest, BuildKernelSoPathWithRootPathEmpty)
{
    string kernelSoRootPath = "";
    string result = TsdPathMgr::BuildKernelSoPath(kernelSoRootPath);
    EXPECT_EQ(result, "aicpu_kernels_device/");
}

TEST_F(PathMgrTest, BuildKernelSoPathWithRootPathCustom)
{
    string kernelSoRootPath = "/custom/path/";
    string result = TsdPathMgr::BuildKernelSoPath(kernelSoRootPath);
    EXPECT_EQ(result, "/custom/path/aicpu_kernels_device/");
}

TEST_F(PathMgrTest, BuildExtendKernelSoPath)
{
    string kernelSoRootPath = "/usr/lib64/aicpu_kernels/2/";
    string result = TsdPathMgr::BuildExtendKernelSoPath(kernelSoRootPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/aicpu_extend_syskernels/");
}

TEST_F(PathMgrTest, BuildExtendKernelSoPathEmptyRoot)
{
    string kernelSoRootPath = "";
    string result = TsdPathMgr::BuildExtendKernelSoPath(kernelSoRootPath);
    EXPECT_EQ(result, "aicpu_extend_syskernels/");
}

TEST_F(PathMgrTest, BuildExtendKernelSoPathCustomRoot)
{
    string kernelSoRootPath = "/custom/extend/path/";
    string result = TsdPathMgr::BuildExtendKernelSoPath(kernelSoRootPath);
    EXPECT_EQ(result, "/custom/extend/path/aicpu_extend_syskernels/");
}

TEST_F(PathMgrTest, BuildExtendKernelHashCfgPath)
{
    string kernelSoRootPath = "/usr/lib64/aicpu_kernels/2/";
    string result = TsdPathMgr::BuildExtendKernelHashCfgPath(kernelSoRootPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/aicpu_kernels_device/aicpuExtend_bin_hash.cfg");
}

TEST_F(PathMgrTest, BuildExtendKernelHashCfgPathEmptyRoot)
{
    string kernelSoRootPath = "";
    string result = TsdPathMgr::BuildExtendKernelHashCfgPath(kernelSoRootPath);
    EXPECT_EQ(result, "aicpu_kernels_device/aicpuExtend_bin_hash.cfg");
}

TEST_F(PathMgrTest, BuildExtendKernelHashCfgPathCustomRoot)
{
    string kernelSoRootPath = "/custom/hash/path/";
    string result = TsdPathMgr::BuildExtendKernelHashCfgPath(kernelSoRootPath);
    EXPECT_EQ(result, "/custom/hash/path/aicpu_kernels_device/aicpuExtend_bin_hash.cfg");
}

TEST_F(PathMgrTest, AddVersionInfoName)
{
    string kernelSoPath = "/usr/lib64/aicpu_kernels/2/aicpu_kernels_device/";
    string result = TsdPathMgr::AddVersionInfoName(kernelSoPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/aicpu_kernels_device/version.info");
}

TEST_F(PathMgrTest, AddVersionInfoNameEmptyPath)
{
    string kernelSoPath = "";
    string result = TsdPathMgr::AddVersionInfoName(kernelSoPath);
    EXPECT_EQ(result, "version.info");
}

TEST_F(PathMgrTest, AddVersionInfoNameCustomPath)
{
    string kernelSoPath = "/custom/version/path/";
    string result = TsdPathMgr::AddVersionInfoName(kernelSoPath);
    EXPECT_EQ(result, "/custom/version/path/version.info");
}

TEST_F(PathMgrTest, AddVersionInfoNameWithoutTrailingSlash)
{
    string kernelSoPath = "/usr/lib64/aicpu_kernels/2/aicpu_kernels_device";
    string result = TsdPathMgr::AddVersionInfoName(kernelSoPath);
    EXPECT_EQ(result, "/usr/lib64/aicpu_kernels/2/aicpu_kernels_deviceversion.info");
}