/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdio>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define private public
#include "inc/tsd_hash_verify.h"
#include "inc/package_worker.h"
#undef private

using namespace tsd;
using namespace std;

namespace {
  void TouchFile(const char* fileName) {
    std::ofstream file(fileName, std::ios::out);
    file.close();
  }
}
class HashVerifyTest : public testing::Test {
protected:
  virtual void SetUp()
  {
      cout << "Before HashVerifyTest()" << endl;
  }

  virtual void TearDown()
  {
      cout << "After HashVerifyTest" << endl;
      GlobalMockObject::verify();
  }
};

TEST_F(HashVerifyTest, InsertOrUpdateHashValue_Success)
{
  TsdHashVerify verifier;
  verifier.InsertOrUpdateHashValue("key=key_hash", HashMapType::AICPU_KERNELS_HASHMAP);
  verifier.InsertOrUpdateHashValue("key=key_hash_update", HashMapType::AICPU_KERNELS_HASHMAP);
  const auto index = static_cast<size_t>(HashMapType::AICPU_KERNELS_HASHMAP);
  EXPECT_EQ(verifier.hashMap_[index]["key"], "key_hash_update");
}

TEST_F(HashVerifyTest, VerifyHashMapPostProcess_Success)
{
  TsdHashVerify verifier;
  auto pkgWorker = std::make_shared<PackageWorker>(0U, 0U);
  MOCKER_CPP(&PackageWorker::GetInstance).stubs().will(returnValue(pkgWorker));
  verifier.VerifyHashMapPostProcess(HashMapType::AICPU_KERNELS_HASHMAP, 0U, 0U);

  const auto aicpuKernelWorker = pkgWorker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS);
  EXPECT_EQ(aicpuKernelWorker->checkCode_, 0U);
  const auto aicpuExtendWorker = pkgWorker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_EXTEND_PROCESS);
  EXPECT_EQ(aicpuExtendWorker->checkCode_, 0U);
  const auto ascendCppWorker = pkgWorker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_ASCENDCPP_PROCESS);
  EXPECT_EQ(ascendCppWorker->checkCode_, 0U);
}

TEST_F(HashVerifyTest, GetSubPreFixConfFromCompat_Success)
{
  TsdHashVerify verifier;
  std::string filePreFix = "";
  std::string valuePreFix = "";
  EXPECT_TRUE(verifier.GetSubProcPreFixConfFromCompat(TsdSubProcessType::PROCESS_HCCP, filePreFix, valuePreFix));
  EXPECT_EQ(filePreFix, "hccp_compat");
  EXPECT_EQ(valuePreFix, "hccp_service.bin=");
  EXPECT_TRUE(verifier.GetSubProcPreFixConfFromCompat(TsdSubProcessType::PROCESS_COMPUTE, filePreFix, valuePreFix));
  EXPECT_EQ(filePreFix, "aicpu_compat");
  EXPECT_EQ(valuePreFix, "aicpu_scheduler=");
  EXPECT_TRUE(
    verifier.GetSubProcPreFixConfFromCompat(TsdSubProcessType::PROCESS_CUSTOM_COMPUTE, filePreFix, valuePreFix));
  EXPECT_EQ(filePreFix, "aicpu_compat");
  EXPECT_EQ(valuePreFix, "aicpu_custom_scheduler=");
  EXPECT_TRUE(
    verifier.GetSubProcPreFixConfFromCompat(TsdSubProcessType::PROCESS_QUEUE_SCHEDULE, filePreFix, valuePreFix));
  EXPECT_EQ(filePreFix, "aicpu_compat");
  EXPECT_EQ(valuePreFix, "queue_schedule=");

  filePreFix = "";
  EXPECT_FALSE(verifier.GetSubProcPreFixConfFromCompat(TsdSubProcessType::PROCESS_UDF, filePreFix, valuePreFix));
}

TEST_F(HashVerifyTest, GetSubProcHashValue_NotFound)
{
  TsdHashVerify verifier;
  std::string hashValue = verifier.GetSubProcHashValue(TsdSubProcessType::PROCESS_HCCP, 0U);
  EXPECT_TRUE(hashValue.empty());
}

TEST_F(HashVerifyTest, VerifyHashValueOnce_Success)
{
  TsdHashVerify verifier;
  TouchFile("empty_file");
  MOCKER_CPP(&TsdHashVerify::GetRealFileName).stubs().will(returnValue(std::string("empty_file")));
  EXPECT_FALSE(verifier.VerifyHashValueOnce("fileName", "hashValue", HashMapType::AICPU_KERNELS_HASHMAP, 0U, 0U));
  remove("empty_file");
}