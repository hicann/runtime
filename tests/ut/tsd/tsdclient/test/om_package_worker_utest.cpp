/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream> 
 #include <pwd.h> 
 #include "gtest/gtest.h" 
 #include "mockcpp/mockcpp.hpp" 
 #include "inc/package_worker_utils.h" 
 #define private public 
 #define protected public 
 #include "inc/om_package_worker.h" 
 #undef private 
 #undef protected


 using namespace tsd; 
 
 
 namespace { 
 std::string GetWorkDir() 
 {
     struct passwd *user = getpwuid(getuid()); 
     if ((user == nullptr) || (user->pw_dir == nullptr)) { 
         return ""; 
     } 
 
 
     std::string pwDir = user->pw_dir; 
     std::string workdir = pwDir + "/tmp/" + std::to_string(getpid()) + "tsd_package_worker/"; 
     return workdir; 
 }; 
 } 
 
 
 class OmPackageWorkerTest : public testing::Test { 
 protected: 
     virtual void SetUp() {} 
 
 
     virtual void TearDown() 
     { 
         GlobalMockObject::verify(); 
     } 
 }; 
 
 
 TEST_F(OmPackageWorkerTest, LoadAndUnloadPackageSuccess) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     const std::string path = "/home/test"; 
     const std::string name = "tsd_test.tar.gz"; 
     MOCKER_CPP_VIRTUAL(inst, &OmPackageWorker::IsNeedLoadPackage).stubs().will(returnValue(true)); 
     MOCKER_CPP(&OmPackageWorker::WritePackageNameToFile).stubs().will(returnValue(TSD_OK)); 
     MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK)); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     auto ret = inst.LoadPackage(path, name); 
     EXPECT_EQ(ret, TSD_OK); 
     ret = inst.UnloadPackage(); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, LoadPackageNoNeedLoad) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     const std::string path = "/home/test"; 
     const std::string name = "tsd_test.tar.gz"; 
     MOCKER_CPP_VIRTUAL(inst, &OmPackageWorker::IsNeedLoadPackage).stubs().will(returnValue(false)); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     auto ret = inst.LoadPackage(path, name); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, LoadPackageHdcPathSuccess)
 { 
     const OmPackageWorker inst({0U, 0U}); 
     const std::string path = "/home/HwHiAiUser/hdcd/device1/"; 
     const std::string name = "tsd_om_file.tar.gz"; 
     MOCKER_CPP_VIRTUAL(inst, &OmPackageWorker::IsNeedLoadPackage).stubs().will(returnValue(true));
     MOCKER(PackSystem).stubs().will(returnValue(0));
     MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
     MOCKER_CPP(&OmPackageWorker::WritePackageNameToFile).stubs().will(returnValue(TSD_OK)); 
     auto ret = inst.LoadPackage(path, name);
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, LoadPackageHdcPathFailed)
 { 
     const OmPackageWorker inst({0U, 0U}); 
     const std::string path = "/home/HwHiAiUser/hdcd/deviceI/"; 
     const std::string name = "tsd_om_file.tar.gz";
     MOCKER_CPP_VIRTUAL(inst, &OmPackageWorker::IsNeedLoadPackage).stubs().will(returnValue(false)); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     auto ret = inst.LoadPackage(path, name);
 } 
 
 
 TEST_F(OmPackageWorkerTest, LoadPackageMoveFail) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     const std::string path = "/home/test"; 
     const std::string name = "tsd_test.tar.gz"; 
     MOCKER_CPP_VIRTUAL(inst, &OmPackageWorker::IsNeedLoadPackage).stubs().will(returnValue(true)); 
     MOCKER_CPP(&OmPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1)); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     auto ret = inst.LoadPackage(path, name); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, UnloadPackageSuccess) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     const auto ret = inst.UnloadPackage(); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, UnloadPackageSystemFail) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER(PackSystem).stubs().will(returnValue(-1)); 
     const auto ret = inst.UnloadPackage(); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, MoveToOriginPackageFail) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     const std::string path = "/home/test"; 
     const std::string name = "tsd_test.tar.gz"; 
     MOCKER_CPP(&OmPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1)); 
     MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR))); 
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     auto ret = inst.LoadPackage(path, name); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, ChangeOmFileRightsSuccess) 
 { 
     std::string dirName = "/home/HwHiAiUser/hs/0/omfile/123/ompkg/"; 
     const OmPackageWorker inst({0U, 0U}); 
     std::string dirCmd = "mkdir -p " + dirName + " && touch " + dirName + "tmpso.so"; 
     auto ret = system(dirCmd.c_str()); 
     if (ret == 0) { 
         inst.ChangeOmFileRights(); 
     } 
     std::string removeCmd = "rm -rf /home/HwHiAiUser/hs/0/omfile/123/ompkg/"; 
     system(removeCmd.c_str()); 
     removeCmd = "rm -rf /home/HwHiAiUser/hs"; 
     system(removeCmd.c_str()); 
     EXPECT_EQ(inst.GetCheckCode(), 0); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, ChangeSingleOmFileRightsSuccess) 
 { 
     std::string dirName = GetWorkDir(); 
     const std::string cmd = "mkdir -p " + dirName + "inner ; touch " + dirName + "aca ; touch" 
                             + dirName + "inner/ccc ; chmod -R 707 " + dirName; 
     const int32_t ret = PackSystem(cmd.c_str()); 
     const OmPackageWorker inst({0U, 0U}); 
     inst.ChangeSingleOmFileRights(GetWorkDir()); 
     EXPECT_EQ(inst.deviceId_, 0U); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, WritePackageNameToFileOpenSucess) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER(open, int(const char*, int, int)).stubs().will(returnValue(0)); 
     MOCKER(write, int(int32_t, const void*, size_t)).stubs().will(returnValue(0)); 
     const auto ret = inst.WritePackageNameToFile(); 
     EXPECT_EQ(ret, TSD_OK); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, WritePackageNameToFileOpenFail) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER(open, int(const char*, int, int)).stubs().will(returnValue(-1)); 
     MOCKER(write).stubs().will(returnValue(0)); 
     const auto ret = inst.WritePackageNameToFile(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, PostProcessPackageFail0) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER(PackSystem).stubs().will(returnValue(2)); 
     const auto ret = inst.PostProcessPackage(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, PostProcessPackageFail1) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER_CPP(&OmPackageWorker::FindAndDecompressOmInnerPkg).stubs() 
         .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR))); 
     const auto ret = inst.PostProcessPackage(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, PostProcessPackageFail2) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER_CPP(&OmPackageWorker::FindAndDecompressOmInnerPkg).stubs().will(returnValue(TSD_OK)); 
     MOCKER_CPP(&OmPackageWorker::ChangeOmFileRights).stubs() 
         .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR))); 
     const auto ret = inst.PostProcessPackage(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, PostProcessPackageFail3) 
 { 
     const OmPackageWorker inst({0U, 0U}); 
     MOCKER_CPP(&OmPackageWorker::FindAndDecompressOmInnerPkg).stubs().will(returnValue(TSD_OK)); 
     MOCKER_CPP(&OmPackageWorker::ChangeOmFileRights).stubs().will(returnValue(TSD_OK)); 
     MOCKER_CPP(&OmPackageWorker::WritePackageNameToFile).stubs() 
         .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR))); 
     const auto ret = inst.PostProcessPackage(); 
     EXPECT_EQ(ret, TSD_INTERNAL_ERROR); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, NoNeedLoadPkg) 
 { 
     const OmPackageWorker inst({0U, 1U}); 
     const auto ret = inst.IsNeedLoadPackage(); 
     EXPECT_EQ(ret, false); 
 } 
 
 
 TEST_F(OmPackageWorkerTest, FindAndDecompressOmInnerPkgCmdFail) 
 { 
     const OmPackageWorker inst({0U, 1U}); 
     MOCKER(PackSystem).stubs().will(returnValue(-1)); 
     const auto ret = inst.FindAndDecompressOmInnerPkg(); 
     EXPECT_EQ(ret, -1); 
 }

  
 TEST_F(OmPackageWorkerTest, GetOmFileStatusSucc) 
 { 
     const OmPackageWorker inst({0U, 1U}); 
     MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
     MOCKER(PackSystem).stubs().will(returnValue(0)); 
     MOCKER(read).stubs().will(returnValue((ssize_t)2));
     MOCKER(strncmp).stubs().will(returnValue(0));
     auto ret = inst.FindAndDecompressOmInnerPkg(); 
     EXPECT_EQ(ret, 0);
 }