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
#include "inc/package_worker_factory.h"
#include "inc/log.h"
#include "inc/package_worker_utils.h"
#include "inc/aicpu_process_package_worker.h"
#undef private 
#undef protected
 using namespace tsd; 
  class PackageWorkerFactoryTest : public testing::Test { 
 protected: 
     virtual void SetUp() {} 
 
 
     virtual void TearDown() 
     { 
         GlobalMockObject::verify(); 
     } 
 };

  TEST_F(PackageWorkerFactoryTest, CreatePackageWorkerSucc) 
 {
    PackageWorkerFactory &inst = PackageWorkerFactory::GetInstance();
    PackageWorkerParas para;
    inst.RegisterPackageWorker(PackageWorkerType::PACKAGE_WORKER_EXTEND_PROCESS, [](const PackageWorkerParas paras) -> std::shared_ptr<ExtendProcessPackageWorker> { return std::make_shared<ExtendProcessPackageWorker>(paras); });
    std::shared_ptr<BasePackageWorker> tmpins = inst.CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_EXTEND_PROCESS, para);
    EXPECT_NE(tmpins, nullptr);
 } 
