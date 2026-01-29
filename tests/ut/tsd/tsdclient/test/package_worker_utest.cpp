/** 
  * Copyright (c) 2025 Huawei Technologies Co., Ltd. 
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of 
  * CANN Open Software License Agreement Version 2.0 (the "License"). 
  * Please refer to the License for details. You may not use this file except in compliance with the License. 
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, 
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. 
  * See LICENSE in the root of the software repository for the full text of the License. 
  */ 
 #include <thread> 
 #include "gtest/gtest.h" 
 #include "mockcpp/mockcpp.hpp" 
 
 
 #define private public 
 #define protected public 
 #include "inc/package_worker.h" 
 #include "inc/aicpu_process_package_worker.h"
 #undef private 
 #undef protected 
 #include "inc/package_worker_utils.h" 
 
 
 
 
 using namespace tsd; 
 
 
 class PackageWorkerTest : public testing::Test { 
 protected: 
     virtual void SetUp() {} 
 
 
     virtual void TearDown() 
     { 
         GlobalMockObject::verify(); 
     } 
 }; 
 
 
 TEST_F(PackageWorkerTest, StopTest) 
 { 
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     packageWorker->DestroyPackageWorker(); 
     EXPECT_EQ(PackageWorker::workerManager_.size(), 0); 
 } 
 
 
 void checkSum() 
 {
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     if (packageWorker == nullptr) { 
         return; 
     } 
 
 
     const auto worker = packageWorker->GetPackageWorker(tsd::PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS); 
     if (worker == nullptr) { 
         return; 
     } 
     std::dynamic_pointer_cast<AicpuProcessPackageWorker>(worker)->CheckSum(123); 
 } 
 
 
 TEST_F(PackageWorkerTest, CheckSum) 
 { 
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     std::thread th(checkSum); 
     packageWorker->Stop(); 
     if (th.joinable()) { 
         th.join(); 
     } 
 
 
     const auto worker = packageWorker->GetPackageWorker(tsd::PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS); 
     if (worker == nullptr) { 
         return; 
     } 
     EXPECT_EQ(std::dynamic_pointer_cast<AicpuProcessPackageWorker>(worker)->isStop_, true); 
 } 
 
 
 TEST_F(PackageWorkerTest, RemoveWholeResidualFile) 
 { 
     MOCKER(access).stubs().will(returnValue(0)); 
     MOCKER(tsd::PackSystem).stubs().will(returnValue(0)); 
     PackageWorker::RemoveWholeResidualFile(0, 0); 
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     EXPECT_EQ(packageWorker->deviceId_, 0U); 
 } 
 
 
 TEST_F(PackageWorkerTest, RemoveWholeResidualFileSystemFail) 
 { 
     MOCKER(access).stubs().will(returnValue(0)); 
     MOCKER(tsd::PackSystem).stubs().will(returnValue(1)); 
     PackageWorker::RemoveWholeResidualFile(0, 0); 
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     EXPECT_EQ(packageWorker->deviceId_, 0U); 
 } 
 
 
 TEST_F(PackageWorkerTest, LoadPackageNull) 
 { 
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     const auto ret = packageWorker->LoadPackage(PackageWorkerType::PACKAGE_WORKER_MAX, "", ""); 
     EXPECT_EQ(ret, TSD_INSTANCE_NOT_FOUND); 
 } 
 
 
 TEST_F(PackageWorkerTest, LoadPackageFail) 
 { 
     MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1)); 
     MOCKER_CPP(PackageWorkerUtils::VerifyPackage).stubs() 
         .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR))); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0); 
     packageWorker->isDestroy_ = false; 
     const auto ret = packageWorker->LoadPackage(PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS, 
                                                 "/home/test", "Ascend-aicpu_syskernels.tar.gz"); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 }

  TEST_F(PackageWorkerTest, UnloadPackageSucc) 
 { 
    PackageWorkerParas paras;
    PackageWorkerFactory &inst = PackageWorkerFactory().GetInstance();
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    auto reworker = inst.CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS, paras);
    MOCKER_CPP(&PackageWorker::GetPackageWorker).stubs().will(returnValue(reworker));
    const auto ret = packageWorker->UnloadPackage(PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS); 
    EXPECT_EQ(ret, TSD_OK); 
 }
