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
 #include <fstream>
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

  TEST_F(PackageVerifyTest, VerifyPackageSuccess) 
 { 
     PackageVerify inst("tmp.tar.gz"); 
     MOCKER_CPP(&PackageVerify::IsPackageValid).stubs().will(returnValue(TSD_OK)); 
     MOCKER_CPP(&PackageVerify::ChangePackageMode).stubs().will(returnValue(TSD_OK));
     MOCKER_CPP(&PackageVerify::IsPackageNeedCmsVerify).stubs().will(returnValue(true));
     MOCKER_CPP(&PackageVerify::VerifyPackageByCms).stubs().will(returnValue(TSD_OK));
     const TSD_StatusT ret = inst.VerifyPackage(); 
     EXPECT_EQ(ret, TSD_OK); 
 }

  TEST_F(PackageVerifyTest, GetPkgCodeLen) 
 { 
     PackageVerify inst("tmp.tar.gz"); 
     std::ofstream outfile("1.txt");
     std::ofstream outfile1("2.txt");
     FILE *fp = fopen("1.txt", "r");
     MOCKER(fopen).stubs().will(returnValue(fp)); 
     MOCKER(fseek).stubs().will(returnValue(0));
     MOCKER(ftell).stubs().will(returnValue(88888888888));
     MOCKER(fread).stubs().will(returnValue(1484));
     MOCKER(fwrite).stubs().will(returnValue(1));
     MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).stubs().will(returnValue(TSD_OK));
     std::string srcPath = "";
     uint32_t val = 288;
     TSD_StatusT ret = inst.GetPkgCodeLen(srcPath, val); 
     EXPECT_EQ(ret, TSD_START_FAIL); 
 }

   TEST_F(PackageVerifyTest, ProcessSendStepVerify) 
 { 
     PackageVerify inst("tmp.tar.gz"); 
     std::ofstream outfile("1.txt");
     std::ofstream outfile1("2.txt");
     MOCKER(fseek).stubs().will(returnValue(0));
     MOCKER(ftell).stubs().will(returnValue(88888888888));
     MOCKER(fread).stubs().will(returnValue(544));
     MOCKER(fwrite).stubs().will(returnValue(1));
     MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).stubs().will(returnValue(TSD_OK));
     std::string srcPath = "";
     uint32_t val = 288;
     FILE *fp = fopen("2.txt", "r");
     MOCKER(fopen).stubs().will(returnValue(fp)); 
     auto ret = inst.ProcessSendStepVerify(srcPath, val); 
     EXPECT_EQ(ret, TSD_OK);
 }

