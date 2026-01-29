/** 
  * Copyright (c) 2025 Huawei Technologies Co., Ltd. 
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of 
  * CANN Open Software License Agreement Version 2.0 (the "License"). 
  * Please refer to the License for details. You may not use this file except in compliance with the License. 
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, 
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. 
  * See LICENSE in the root of the software repository for the full text of the License. 
  */ 
 #include <unistd.h> 
 #include "gtest/gtest.h" 
 #include "mockcpp/mockcpp.hpp" 
 #include "mmpa/mmpa_api.h" 
 #include "tsd/status.h" 
 #include "inc/weak_ascend_hal.h" 
 #include "inc/log.h"
 #define private public 
 #define protected public 
 #include "inc/package_verify.h" 
 #undef private 
 #undef protected 
 
 
 using namespace tsd; 
 
 
 class PackageVerifyTest : public testing::Test { 
 protected: 
     virtual void SetUp() {} 
 
 
     virtual void TearDown() 
     { 
         GlobalMockObject::verify(); 
     } 
 }; 
 
 
 TEST_F(PackageVerifyTest, IsPackageValidSuccess) 
 { 
     PackageVerify inst("/tsd/test/test.pkg"); 
     MOCKER(access).stubs().will(returnValue(0)); 
     const TSD_StatusT ret = inst.IsPackageValid(); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(PackageVerifyTest, IsPackageValidPathEmpty) 
 { 
     PackageVerify inst(""); 
     MOCKER(access).stubs().will(returnValue(0)); 
     const TSD_StatusT ret = inst.IsPackageValid(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(PackageVerifyTest, IsPackageValidPathNotExist) 
 { 
     PackageVerify inst("/tsd/test/test.pkg"); 
     const TSD_StatusT ret = inst.IsPackageValid(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(PackageVerifyTest, ChangePackageModeSuccess) 
 { 
     PackageVerify inst(""); 
     MOCKER(chmod).stubs().will(returnValue(0)); 
     const TSD_StatusT ret = inst.ChangePackageMode(); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(PackageVerifyTest, ChangePackageModeFail) 
 { 
     PackageVerify inst(""); 
     const TSD_StatusT ret = inst.ChangePackageMode(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(PackageVerifyTest, IsPackageNeedCmsVerifyNeedVerify) 
 { 
     PackageVerify inst("Ascend-aicpu_syskernels.tar.gz"); 
     MOCKER_CPP(&PackageVerify::IsSupportCmsVerify).stubs().will(returnValue(true)); 
     MOCKER_CPP(&PackageVerify::IsCmsVerifyPackage).stubs().will(returnValue(true)); 
     const bool ret = inst.IsPackageNeedCmsVerify(); 
     EXPECT_EQ(ret, true); 
 } 
 
 
 TEST_F(PackageVerifyTest, IsPackageNeedCmsVerifyNoNeedVerify) 
 { 
     PackageVerify inst(""); 
     const bool ret = inst.IsPackageNeedCmsVerify(); 
     EXPECT_EQ(ret, false); 
 } 
  
 TEST_F(PackageVerifyTest, IsCmsVerifyPackageTrue) 
 { 
     PackageVerify inst("Ascend-aicpu_extend_syskernels.tar.gz"); 
     const bool ret = inst.IsCmsVerifyPackage(); 
     EXPECT_EQ(ret, true); 
 } 
 
 
 TEST_F(PackageVerifyTest, IsCmsVerifyPackageFalse) 
 { 
     PackageVerify inst("tmp.tar.gz"); 
     const bool ret = inst.IsCmsVerifyPackage(); 
     EXPECT_EQ(ret, false); 
 } 
 
 
 
 TEST_F(PackageVerifyTest, VerifyPackageByDrvSuccess) 
 { 
     PackageVerify inst("tmp.tar.gz"); 
     MOCKER(mmDlopen).stubs().will(returnValue((void*)0x1)); 
     MOCKER(mmDlsym).stubs().will(returnValue((void*)&halVerifyImg)); 
     MOCKER(mmDlclose).stubs().will(returnValue(0)); 
     const TSD_StatusT ret = inst.VerifyPackageByDrv(); 
     EXPECT_EQ(ret, TSD_OK); 
 }