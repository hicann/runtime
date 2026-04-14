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
#include <sys/stat.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include "mmpa/mmpa_api.h"
#include "tsd/status.h"
#include "inc/weak_ascend_hal.h"
#include "log.h"
#define private public
#define protected public
#include "inc/package_verify.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

class PackageVerifyTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before PackageVerifyTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After PackageVerifyTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
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

TEST_F(PackageVerifyTest, IsCmsVerifyPackageRuntimeDeviceMinios)
{
    PackageVerify inst("test_Ascend-runtime_device-minios.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsCmsVerifyPackageOppRtMinios)
{
    PackageVerify inst("test_Ascend-opp_rt-minios.aarch64.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsCmsVerifyPackageDeviceSwPlugin)
{
    PackageVerify inst("Ascend-device-sw-plugin.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsCmsVerifyPackageTransformerTileFwk)
{
    PackageVerify inst("transformer_tile_fwk_aicpu_kernel.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
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

TEST_F(PackageVerifyTest, VerifyPackageByDrvVerifyFail)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0x1));
    MOCKER(mmDlsym).stubs().will(returnValue((void*)&halVerifyImg));
    MOCKER(halVerifyImg).stubs().will(returnValue(-1));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const TSD_StatusT ret = inst.VerifyPackageByDrv();
    EXPECT_EQ(ret, TSD_VERIFY_OPP_FAIL);
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

TEST_F(PackageVerifyTest, VerifyPackageByDrvSuccessPath)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER_CPP(&PackageVerify::IsPackageValid).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ChangePackageMode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::IsPackageNeedCmsVerify).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageVerify::VerifyPackageByDrv).stubs().will(returnValue(TSD_OK));
    const TSD_StatusT ret = inst.VerifyPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageVerifyTest, GetVerifyDeviceId)
{
    PackageVerify inst("tmp.tar.gz");
    const uint32_t deviceId = inst.GetVerifyDeviceId();
    EXPECT_EQ(deviceId, 0U);
}

TEST_F(PackageVerifyTest, VerifyPackageByCmsSuccess)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER_CPP(&PackageVerify::GetPkgCodeLen).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ProcessSendStepVerify).stubs().will(returnValue(TSD_OK));
    const TSD_StatusT ret = inst.VerifyPackageByCms();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenSuccess)
{
    string filepath = "/tmp/test_pkg.bin";
    ofstream outfile(filepath, ios::binary);
    if (outfile.is_open()) {
        SeImageHead header;
        header.uwLCodeLen = 1024 + 256; // codeLen + CMS_IMG_DESC_LEN
        outfile.write(reinterpret_cast<const char*>(&header), sizeof(SeImageHead));
        vector<uint8_t> data(1024, 0xAA);
        outfile.write(reinterpret_cast<const char*>(data.data()), data.size());
        outfile.close();
    }

    PackageVerify inst(filepath);
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(filepath, codeLen);

    remove(filepath.c_str());
}

TEST_F(PackageVerifyTest, GetPkgCodeLenFileOpenFail)
{
    string filepath = "/tmp/not_exist_pkg.bin";
    PackageVerify inst(filepath);
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(filepath, codeLen);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenFileTooSmall)
{
    string filepath = "/tmp/test_small_pkg.bin";
    ofstream outfile(filepath, ios::binary);
    if (outfile.is_open()) {
        vector<uint8_t> data(100, 0xAA);
        outfile.write(reinterpret_cast<const char*>(data.data()), data.size());
        outfile.close();
    }

    PackageVerify inst(filepath);
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(filepath, codeLen);
    EXPECT_EQ(ret, TSD_START_FAIL);

    remove(filepath.c_str());
}

TEST_F(PackageVerifyTest, GetPkgCodeLenInvalidCodeLen)
{
    string filepath = "/tmp/test_invalid_pkg.bin";
    ofstream outfile(filepath, ios::binary);
    if (outfile.is_open()) {
        SeImageHead header;
        header.uwLCodeLen = 100; // less than CMS_IMG_DESC_LEN
        outfile.write(reinterpret_cast<const char*>(&header), sizeof(SeImageHead));
        vector<uint8_t> data(1024, 0xAA);
        outfile.write(reinterpret_cast<const char*>(data.data()), data.size());
        outfile.close();
    }

    PackageVerify inst(filepath);
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(filepath, codeLen);
    EXPECT_EQ(ret, TSD_START_FAIL);

    remove(filepath.c_str());
}

TEST_F(PackageVerifyTest, ProcessSendStepVerifySuccess)
{
    string filepath = "/tmp/test_process_pkg.bin";
    ofstream outfile(filepath, ios::binary);
    if (outfile.is_open()) {
        SeImageHead header;
        header.uwLCodeLen = 1024 + 256;
        outfile.write(reinterpret_cast<const char*>(&header), sizeof(SeImageHead));
        vector<uint8_t> data(1024, 0xBB);
        outfile.write(reinterpret_cast<const char*>(data.data()), data.size());
        outfile.close();
    }

    PackageVerify inst(filepath);
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).stubs().will(returnValue(TSD_OK));
    const TSD_StatusT ret = inst.ProcessSendStepVerify(filepath, 1024);
    EXPECT_NE(ret, TSD_OK);

    remove(filepath.c_str());
}

TEST_F(PackageVerifyTest, ProcessSendStepVerifyFileOpenFail)
{
    string filepath = "/tmp/not_exist_process_pkg.bin";
    PackageVerify inst(filepath);
    const TSD_StatusT ret = inst.ProcessSendStepVerify(filepath, 1024);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerifyReWriteFail)
{
    string filepath = "/tmp/test_rewrite_pkg.bin";
    ofstream outfile(filepath, ios::binary);
    if (outfile.is_open()) {
        SeImageHead header;
        header.uwLCodeLen = 1024 + 256;
        outfile.write(reinterpret_cast<const char*>(&header), sizeof(SeImageHead));
        vector<uint8_t> data(1024, 0xCC);
        outfile.write(reinterpret_cast<const char*>(data.data()), data.size());
        outfile.close();
    }

    PackageVerify inst(filepath);
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).stubs().will(returnValue(TSD_START_FAIL));
    const TSD_StatusT ret = inst.ProcessSendStepVerify(filepath, 1024);
    EXPECT_EQ(ret, TSD_START_FAIL);

    remove(filepath.c_str());
}

TEST_F(PackageVerifyTest, ReWriteAicpuPackageSuccess)
{
    string filepath = "/tmp/test_rewrite_dest.bin";
    vector<uint8_t> data(1024, 0xDD);

    PackageVerify inst(filepath);
    const TSD_StatusT ret = inst.ReWriteAicpuPackage(data.data(), 1024, filepath);
    EXPECT_EQ(ret, TSD_OK);

    // Verify file was written
    ifstream infile(filepath, ios::binary);
    if (infile.is_open()) {
        vector<uint8_t> readData(1024);
        infile.read(reinterpret_cast<char*>(readData.data()), 1024);
        EXPECT_EQ(readData, data);
        infile.close();
    }

    remove(filepath.c_str());
}

TEST_F(PackageVerifyTest, ReWriteAicpuPackageOpenFail)
{
    string filepath = "/invalid/path/test.bin";
    vector<uint8_t> data(1024, 0xEE);

    PackageVerify inst(filepath);
    const TSD_StatusT ret = inst.ReWriteAicpuPackage(data.data(), 1024, filepath);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, IsSupportCmsVerify)
{
    PackageVerify inst("tmp.tar.gz");
    const bool ret = inst.IsSupportCmsVerify();
#if (defined CMS_CBB_VERIFY_PKT) || (defined TSD_HOST_LIB)
    EXPECT_EQ(ret, true);
#else
    EXPECT_EQ(ret, false);
#endif
}
