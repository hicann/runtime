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
#include "inc/package_worker_utils.h"
#define private public
#define protected public
#include "inc/dshape_package_worker.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

class DshapePackageWorkerTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DshapePackageWorkerTest, LoadAndUnloadPackageSuccess)
{
  const DshapePackageWorker inst({0U, 0U});
  const std::string path = "/home/test";
  const std::string name = "tsd_test.tar.gz";
  MOCKER_CPP(&DshapePackageWorker::GetOriginPackageSize)
  .stubs()
  .will(returnValue(1));
  MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
  .stubs()
  .will(returnValue(TSD_OK));
  MOCKER_CPP(&PackageWorkerUtils::MakeDirectory)
  .stubs()
  .will(returnValue(TSD_OK));
  MOCKER_CPP_VIRTUAL(inst, &DshapePackageWorker::IsNeedUnloadPackage)
  .stubs()
  .will(returnValue(true));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(0));
  auto ret = inst.LoadPackage(path, name);
  EXPECT_EQ(ret, TSD_OK);
  ret = inst.UnloadPackage();
  EXPECT_EQ(ret, TSD_OK);
}

TEST_F(DshapePackageWorkerTest, LoadPackageNoNeedLoad)
{
  const DshapePackageWorker inst({0U, 0U});
  const std::string path = "/home/test";
  const std::string name = "tsd_test.tar.gz";
  MOCKER_CPP_VIRTUAL(inst, &DshapePackageWorker::IsNeedLoadPackage)
  .stubs()
  .will(returnValue(false));
  MOCKER_CPP(&DshapePackageWorker::GetOriginPackageSize)
  .stubs()
  .will(returnValue(1));
  MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
  .stubs()
  .will(returnValue(TSD_OK));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(0));
  auto ret = inst.LoadPackage(path, name);
  EXPECT_EQ(ret, TSD_OK);
}

TEST_F(DshapePackageWorkerTest, LoadPackageVerifyFail)
{
  const DshapePackageWorker inst({0U, 0U});
  const std::string path = "/home/test";
  const std::string name = "tsd_test.tar.gz";
  MOCKER_CPP_VIRTUAL(inst, &DshapePackageWorker::IsNeedLoadPackage)
  .stubs()
  .will(returnValue(true));
  MOCKER_CPP(&DshapePackageWorker::GetOriginPackageSize)
  .stubs()
  .will(returnValue(1));
  MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
  .stubs()
  .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(0));
  auto ret = inst.LoadPackage(path, name);
  EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(DshapePackageWorkerTest, UnLoadPackageSuccess)
{
  const DshapePackageWorker inst({0U, 0U});
  MOCKER_CPP_VIRTUAL(inst, &DshapePackageWorker::IsNeedUnloadPackage)
  .stubs()
  .will(returnValue(true));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(0));
  auto ret = inst.UnloadPackage();
  EXPECT_EQ(ret, TSD_OK);
}

TEST_F(DshapePackageWorkerTest, UnLoadPackageFail)
{
  const DshapePackageWorker inst({0U, 0U});
  MOCKER_CPP_VIRTUAL(inst, &DshapePackageWorker::IsNeedUnloadPackage)
  .stubs()
  .will(returnValue(true));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(-1));
  auto ret = inst.UnloadPackage();
  EXPECT_EQ(ret, TSD_OK);
}

TEST_F(DshapePackageWorkerTest, MoveToOriginPackageFail)
{
  const DshapePackageWorker inst({0U, 0U});
  const std::string path = "/home/test";
  const std::string name = "tsd_test.tar.gz";
  MOCKER_CPP(&DshapePackageWorker::GetOriginPackageSize)
  .stubs()
  .will(returnValue(1));
  MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
  .stubs()
  .will(returnValue(TSD_OK));
  MOCKER_CPP(&PackageWorkerUtils::MakeDirectory)
  .stubs()
  .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
  MOCKER_CPP_VIRTUAL(inst, &DshapePackageWorker::IsNeedUnloadPackage)
  .stubs()
  .will(returnValue(true));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(0));
  auto ret = inst.LoadPackage(path, name);
  EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(DshapePackageWorkerTest, NoNeedUnloadPackage)
{
  const DshapePackageWorker inst({0U, 0U});
  const std::string path = "/home/test";
  const std::string name = "tsd_test.tar.gz";
  MOCKER_CPP(&DshapePackageWorker::GetOriginPackageSize)
  .stubs()
  .will(returnValue(1));
  MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
  .stubs()
  .will(returnValue(TSD_OK));
  MOCKER_CPP(&PackageWorkerUtils::MakeDirectory)
  .stubs()
  .will(returnValue(TSD_OK));
  MOCKER_CPP(PackSystem)
  .stubs()
  .will(returnValue(0));
  auto ret = inst.LoadPackage(path, name);
  EXPECT_EQ(ret, TSD_OK);
  inst.SetCheckCode(1U);
  ret = inst.UnloadPackage();
  EXPECT_EQ(ret, TSD_OK);
}