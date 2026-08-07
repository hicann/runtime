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
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <sys/stat.h>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include "mmpa/mmpa_api.h"
#include "tsd/status.h"
#include "weak_ascend_hal.h"
#include "tsd_log.h"
#define private public
#define protected public
#include "package_verify.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
constexpr uint32_t kCmsHeadFixPacketLen = 8U * 1024U;
constexpr uint32_t kCmsImgDescLen = 256U;

class TempFile {
public:
    TempFile()
    {
        char path[] = "/tmp/package_verify_ut_XXXXXX";
        const int fd = mkstemp(path);
        if (fd >= 0) {
            (void)close(fd);
            path_ = path;
        }
    }

    ~TempFile()
    {
        if (!path_.empty()) {
            (void)remove(path_.c_str());
        }
    }

    const string& Path() const { return path_; }

private:
    string path_;
};

class TempDir {
public:
    TempDir()
    {
        char path[] = "/tmp/package_verify_dir_ut_XXXXXX";
        char* const dir = mkdtemp(path);
        if (dir != nullptr) {
            path_ = dir;
        }
    }

    ~TempDir()
    {
        if (!path_.empty()) {
            (void)rmdir(path_.c_str());
        }
    }

    const string& Path() const { return path_; }

private:
    string path_;
};

bool WriteCmsPackage(const string& path, const uint32_t codeLen, const uint32_t totalLen)
{
    vector<uint8_t> bytes(totalLen, 0U);
    SeImageHead header{};
    header.uwLCodeLen = codeLen + kCmsImgDescLen;
    if (bytes.size() >= sizeof(header)) {
        (void)memcpy(bytes.data(), &header, sizeof(header));
    }
    for (uint32_t i = 0U; i < codeLen && (kCmsHeadFixPacketLen + kCmsImgDescLen + i) < bytes.size(); ++i) {
        bytes[kCmsHeadFixPacketLen + kCmsImgDescLen + i] = static_cast<uint8_t>(i & 0xFFU);
    }
    ofstream output(path, ios::binary | ios::trunc);
    output.write(reinterpret_cast<const char*>(bytes.data()), static_cast<streamsize>(bytes.size()));
    return output.good();
}

struct DrvCallRecord {
    vector<string> events;
    vector<string> openPaths;
    vector<int32_t> openModes;
    int32_t symCalls = 0;
    string symbol;
    int32_t closeCalls = 0;
    void* handle = reinterpret_cast<void*>(0x1234);
    bool failFirstOpen = false;
    bool failAllOpen = false;
    bool failSymbol = false;
    int32_t verifyCalls = 0;
    HAL_VERIFY_TYPE verifyType = VERIFY_TYPE_MAX;
    HAL_IMG_ID imageId = IMAGE_ID_MAX;
    string verifyPath;
    int32_t verifyMode = 0;
};

struct RewriteCallRecord {
    int32_t calls = 0;
    string path;
    uint32_t len = 0U;
    vector<uint8_t> payload;
};

DrvCallRecord g_drvCalls;
RewriteCallRecord g_rewriteCall;
const uint8_t* g_rewriteBuffer = nullptr;
int32_t g_fwriteCalls = 0;
size_t g_fwriteSize = 0U;
size_t g_fwriteCount = 0U;

void* CaptureDlopen(const char* path, int32_t mode)
{
    g_drvCalls.events.emplace_back("dlopen");
    g_drvCalls.openPaths.emplace_back(path == nullptr ? "" : path);
    g_drvCalls.openModes.push_back(mode);
    if (g_drvCalls.failAllOpen || (g_drvCalls.failFirstOpen && g_drvCalls.openPaths.size() == 1U)) {
        return nullptr;
    }
    return g_drvCalls.handle;
}

int32_t CaptureDlclose(void* handle)
{
    EXPECT_EQ(handle, g_drvCalls.handle);
    g_drvCalls.events.emplace_back("close");
    ++g_drvCalls.closeCalls;
    return 0;
}

int32_t CaptureVerifyImg(
    const HAL_VERIFY_TYPE verifyType, const HAL_IMG_ID imageId, const char_t* path, const int32_t mode)
{
    g_drvCalls.events.emplace_back("verify");
    ++g_drvCalls.verifyCalls;
    g_drvCalls.verifyType = verifyType;
    g_drvCalls.imageId = imageId;
    g_drvCalls.verifyPath = path == nullptr ? "" : path;
    g_drvCalls.verifyMode = mode;
    return 0;
}

void* CaptureDlsym(void* handle, const char* symbol)
{
    EXPECT_EQ(handle, g_drvCalls.handle);
    g_drvCalls.events.emplace_back("dlsym");
    ++g_drvCalls.symCalls;
    g_drvCalls.symbol = symbol == nullptr ? "" : symbol;
    if (g_drvCalls.failSymbol) {
        return nullptr;
    }
    return reinterpret_cast<void*>(&CaptureVerifyImg);
}

void CaptureRewriteBuffer(const uint8_t* const buf)
{
    ++g_rewriteCall.calls;
    g_rewriteBuffer = buf;
}

void CaptureRewriteLength(const uint32_t len)
{
    g_rewriteCall.len = len;
    if (g_rewriteBuffer != nullptr) {
        g_rewriteCall.payload.assign(g_rewriteBuffer, g_rewriteBuffer + len);
    }
}

size_t CaptureFwrite(const void*, size_t size, size_t count, FILE*)
{
    ++g_fwriteCalls;
    g_fwriteSize = size;
    g_fwriteCount = count;
    return 0U;
}
} // namespace

class PackageVerifyTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before PackageVerifyTest()" << endl;
        g_drvCalls = DrvCallRecord{};
        g_rewriteCall = RewriteCallRecord{};
        g_rewriteBuffer = nullptr;
        g_fwriteCalls = 0;
        g_fwriteSize = 0U;
        g_fwriteCount = 0U;
    }

    virtual void TearDown()
    {
        cout << "After PackageVerifyTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            throw;
        }
        GlobalMockObject::reset();
    }
};

TEST_F(PackageVerifyTest, IsPackageValid_ExistingPath_ReturnsOk)
{
    PackageVerify inst("/tsd/test/test.pkg");
    MOCKER(access).stubs().will(returnValue(0));
    const TSD_StatusT ret = inst.IsPackageValid();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageVerifyTest, IsPackageValid_EmptyPath_ReturnsInternalError)
{
    PackageVerify inst("");
    MOCKER(access).stubs().will(returnValue(0));
    const TSD_StatusT ret = inst.IsPackageValid();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageVerifyTest, IsPackageValid_PathMissing_ReturnsInternalError)
{
    PackageVerify inst("/tsd/test/test.pkg");
    const TSD_StatusT ret = inst.IsPackageValid();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageVerifyTest, ChangePackageMode_ChmodSucceeds_ReturnsOk)
{
    PackageVerify inst("");
    MOCKER(chmod).stubs().will(returnValue(0));
    const TSD_StatusT ret = inst.ChangePackageMode();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageVerifyTest, ChangePackageMode_ChmodFails_ReturnsInternalError)
{
    PackageVerify inst("");
    const TSD_StatusT ret = inst.ChangePackageMode();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageVerifyTest, IsPackageNeedCmsVerify_SupportedCmsPackage_ReturnsTrue)
{
    PackageVerify inst("Ascend-aicpu_syskernels.tar.gz");
    MOCKER_CPP(&PackageVerify::IsSupportCmsVerify).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageVerify::IsCmsVerifyPackage).stubs().will(returnValue(true));
    const bool ret = inst.IsPackageNeedCmsVerify();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsPackageNeedCmsVerify_EmptyPackagePath_ReturnsFalse)
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

TEST_F(PackageVerifyTest, IsCmsVerifyPackage_RuntimeDeviceMiniosName_ReturnsTrue)
{
    PackageVerify inst("test_Ascend-runtime_device-minios.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsCmsVerifyPackage_OppRtMiniosName_ReturnsTrue)
{
    PackageVerify inst("test_Ascend-opp_rt-minios.aarch64.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsCmsVerifyPackage_DeviceSwPluginName_ReturnsTrue)
{
    PackageVerify inst("Ascend-device-sw-plugin.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, IsCmsVerifyPackage_TransformerTileFwkName_ReturnsTrue)
{
    PackageVerify inst("transformer_tile_fwk_aicpu_kernel.tar.gz");
    const bool ret = inst.IsCmsVerifyPackage();
    EXPECT_EQ(ret, true);
}

TEST_F(PackageVerifyTest, VerifyPackageByDrv_DriverApiSucceeds_ReturnsOk)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER(mmDlopen).stubs().will(invoke(CaptureDlopen));
    MOCKER(mmDlsym).stubs().will(invoke(CaptureDlsym));
    MOCKER(mmDlclose).stubs().will(invoke(CaptureDlclose));
    const TSD_StatusT ret = inst.VerifyPackageByDrv();
    EXPECT_EQ(ret, TSD_OK);
    ASSERT_EQ(g_drvCalls.openPaths.size(), 1U);
    EXPECT_EQ(g_drvCalls.openPaths[0], "/usr/lib64/libascend_drvupgrade.so");
    ASSERT_EQ(g_drvCalls.openModes.size(), 1U);
    EXPECT_EQ(g_drvCalls.openModes[0], MMPA_RTLD_LAZY);
    EXPECT_EQ(g_drvCalls.symCalls, 1);
    EXPECT_EQ(g_drvCalls.symbol, "halVerifyImg");
    EXPECT_EQ(g_drvCalls.verifyCalls, 1);
    EXPECT_EQ(g_drvCalls.verifyType, VERIFY_TYPE_SOC);
    EXPECT_EQ(g_drvCalls.imageId, ITEE_IMG_ID);
    EXPECT_EQ(g_drvCalls.verifyPath, "tmp.tar.gz");
    EXPECT_EQ(g_drvCalls.verifyMode, HAL_VERIFY_MODE_COVER_WITH_HEAD_OFF);
    EXPECT_EQ(g_drvCalls.closeCalls, 1);
    EXPECT_EQ(g_drvCalls.events, (vector<string>{"dlopen", "dlsym", "verify", "close"}));
}

TEST_F(PackageVerifyTest, VerifyPackageByDrv_ImageVerificationFails_ReturnsVerifyError)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0x1));
    MOCKER(mmDlsym).stubs().will(returnValue((void*)&halVerifyImg));
    MOCKER(halVerifyImg).stubs().will(returnValue(-1));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const TSD_StatusT ret = inst.VerifyPackageByDrv();
    EXPECT_EQ(ret, TSD_VERIFY_OPP_FAIL);
}

TEST_F(PackageVerifyTest, VerifyPackageByDrvUsesFallbackLibraryPath)
{
    PackageVerify inst("fallback.tar.gz");
    g_drvCalls.failFirstOpen = true;
    MOCKER(mmDlopen).stubs().will(invoke(CaptureDlopen));
    MOCKER(mmDlsym).stubs().will(invoke(CaptureDlsym));
    MOCKER(mmDlclose).stubs().will(invoke(CaptureDlclose));

    EXPECT_EQ(inst.VerifyPackageByDrv(), TSD_OK);
    ASSERT_EQ(g_drvCalls.openPaths.size(), 2U);
    EXPECT_EQ(g_drvCalls.openPaths[0], "/usr/lib64/libascend_drvupgrade.so");
    EXPECT_EQ(g_drvCalls.openPaths[1], "libascend_drvupgrade.so");
    EXPECT_EQ(g_drvCalls.openModes[0], MMPA_RTLD_LAZY);
    EXPECT_EQ(g_drvCalls.openModes[1], MMPA_RTLD_LAZY);
    EXPECT_EQ(g_drvCalls.verifyCalls, 1);
    EXPECT_EQ(g_drvCalls.verifyType, VERIFY_TYPE_SOC);
    EXPECT_EQ(g_drvCalls.imageId, ITEE_IMG_ID);
    EXPECT_EQ(g_drvCalls.verifyPath, "fallback.tar.gz");
    EXPECT_EQ(g_drvCalls.verifyMode, HAL_VERIFY_MODE_COVER_WITH_HEAD_OFF);
    EXPECT_EQ(g_drvCalls.closeCalls, 1);
    EXPECT_EQ(g_drvCalls.events, (vector<string>{"dlopen", "dlopen", "dlsym", "verify", "close"}));
}

TEST_F(PackageVerifyTest, VerifyPackageByDrvReturnsErrorWhenBothLibraryPathsFail)
{
    PackageVerify inst("missing-driver.tar.gz");
    g_drvCalls.failAllOpen = true;
    MOCKER(mmDlopen).stubs().will(invoke(CaptureDlopen));
    MOCKER(mmDlsym).expects(never());
    MOCKER(mmDlclose).expects(never());

    EXPECT_EQ(inst.VerifyPackageByDrv(), TSD_INTERNAL_ERROR);
    ASSERT_EQ(g_drvCalls.openPaths.size(), 2U);
    EXPECT_EQ(g_drvCalls.openPaths[1], "libascend_drvupgrade.so");
    EXPECT_EQ(g_drvCalls.verifyCalls, 0);
}

TEST_F(PackageVerifyTest, VerifyPackageByDrvClosesLibraryWhenSymbolMissing)
{
    PackageVerify inst("missing-symbol.tar.gz");
    g_drvCalls.failSymbol = true;
    MOCKER(mmDlopen).stubs().will(invoke(CaptureDlopen));
    MOCKER(mmDlsym).stubs().will(invoke(CaptureDlsym));
    MOCKER(mmDlclose).stubs().will(invoke(CaptureDlclose));

    EXPECT_EQ(inst.VerifyPackageByDrv(), TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_drvCalls.symCalls, 1);
    EXPECT_EQ(g_drvCalls.symbol, "halVerifyImg");
    EXPECT_EQ(g_drvCalls.verifyCalls, 0);
    EXPECT_EQ(g_drvCalls.closeCalls, 1);
}

TEST_F(PackageVerifyTest, VerifyPackage_CmsVerificationSucceeds_ReturnsOk)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER_CPP(&PackageVerify::IsPackageValid).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ChangePackageMode).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::IsPackageNeedCmsVerify).expects(once()).will(returnValue(true));
    MOCKER_CPP(&PackageVerify::VerifyPackageByCms).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::VerifyPackageByDrv).expects(never());
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

TEST_F(PackageVerifyTest, VerifyPackageRejectsInvalidPathBeforeChangingMode)
{
    PackageVerify inst("invalid.tar.gz");
    MOCKER_CPP(&PackageVerify::IsPackageValid)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&PackageVerify::ChangePackageMode).expects(never());
    MOCKER_CPP(&PackageVerify::VerifyPackageByCms).expects(never());
    MOCKER_CPP(&PackageVerify::VerifyPackageByDrv).expects(never());

    EXPECT_EQ(inst.VerifyPackage(), TSD_VERIFY_OPP_FAIL);
}

TEST_F(PackageVerifyTest, VerifyPackageRejectsChmodFailureBeforeVerification)
{
    PackageVerify inst("readonly.tar.gz");
    MOCKER_CPP(&PackageVerify::IsPackageValid).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ChangePackageMode)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&PackageVerify::IsPackageNeedCmsVerify).expects(never());
    MOCKER_CPP(&PackageVerify::VerifyPackageByCms).expects(never());
    MOCKER_CPP(&PackageVerify::VerifyPackageByDrv).expects(never());

    EXPECT_EQ(inst.VerifyPackage(), TSD_VERIFY_OPP_FAIL);
}

TEST_F(PackageVerifyTest, VerifyPackageMapsCmsFailureToVerifyFailure)
{
    PackageVerify inst("cms.tar.gz");
    MOCKER_CPP(&PackageVerify::IsPackageValid).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ChangePackageMode).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::IsPackageNeedCmsVerify).expects(once()).will(returnValue(true));
    MOCKER_CPP(&PackageVerify::VerifyPackageByCms)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_START_FAIL)));
    MOCKER_CPP(&PackageVerify::VerifyPackageByDrv).expects(never());

    EXPECT_EQ(inst.VerifyPackage(), TSD_VERIFY_OPP_FAIL);
}

TEST_F(PackageVerifyTest, VerifyPackageMapsDriverFailureToVerifyFailure)
{
    PackageVerify inst("driver.tar.gz");
    MOCKER_CPP(&PackageVerify::IsPackageValid).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ChangePackageMode).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::IsPackageNeedCmsVerify).expects(once()).will(returnValue(false));
    MOCKER_CPP(&PackageVerify::VerifyPackageByDrv)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&PackageVerify::VerifyPackageByCms).expects(never());

    EXPECT_EQ(inst.VerifyPackage(), TSD_VERIFY_OPP_FAIL);
}

TEST_F(PackageVerifyTest, VerifyPackageByCms_CodeLengthAndRewriteSucceed_ReturnsOk)
{
    PackageVerify inst("tmp.tar.gz");
    MOCKER_CPP(&PackageVerify::GetPkgCodeLen).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ProcessSendStepVerify).expects(once()).will(returnValue(TSD_OK));
    const TSD_StatusT ret = inst.VerifyPackageByCms();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageVerifyTest, VerifyPackageByCmsStopsWhenCodeLengthFails)
{
    PackageVerify inst("bad-header.tar.gz");
    MOCKER_CPP(&PackageVerify::GetPkgCodeLen)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_START_FAIL)));
    MOCKER_CPP(&PackageVerify::ProcessSendStepVerify).expects(never());

    EXPECT_EQ(inst.VerifyPackageByCms(), TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, VerifyPackageByCmsMapsSendStepFailure)
{
    PackageVerify inst("bad-payload.tar.gz");
    MOCKER_CPP(&PackageVerify::GetPkgCodeLen).expects(once()).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageVerify::ProcessSendStepVerify)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(inst.VerifyPackageByCms(), TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, GetPkgCodeLen_ValidCmsHeader_ReturnsCodeLength)
{
    TempFile file;
    ASSERT_FALSE(file.Path().empty());
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1024U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1024U));
    PackageVerify inst(file.Path());
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(file.Path(), codeLen);

    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(codeLen, 1024U);
}

TEST_F(PackageVerifyTest, GetPkgCodeLen_MissingFile_ReturnsStartFail)
{
    TempFile file;
    ASSERT_FALSE(file.Path().empty());
    ASSERT_EQ(remove(file.Path().c_str()), 0);
    PackageVerify inst(file.Path());
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(file.Path(), codeLen);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenFileTooSmall)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1U, kCmsHeadFixPacketLen + kCmsImgDescLen));
    PackageVerify inst(file.Path());
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(file.Path(), codeLen);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenInvalidCodeLen)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 0U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    uint32_t codeLen = 0;
    const TSD_StatusT ret = inst.GetPkgCodeLen(file.Path(), codeLen);
    EXPECT_EQ(ret, TSD_START_FAIL);
    EXPECT_EQ(codeLen, kCmsImgDescLen);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenAcceptsFirstValidCodeLength)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    uint32_t codeLen = 0U;

    EXPECT_EQ(inst.GetPkgCodeLen(file.Path(), codeLen), TSD_OK);
    EXPECT_EQ(codeLen, 1U);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenReturnsErrorWhenSeekFails)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    uint32_t codeLen = 99U;
    MOCKER(fseek).expects(once()).will(returnValue(-1));

    EXPECT_EQ(inst.GetPkgCodeLen(file.Path(), codeLen), TSD_START_FAIL);
    EXPECT_EQ(codeLen, 99U);
}

TEST_F(PackageVerifyTest, GetPkgCodeLenReturnsErrorOnShortHeaderRead)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    uint32_t codeLen = 77U;
    MOCKER(fread).expects(once()).will(returnValue(static_cast<size_t>(0U)));

    EXPECT_EQ(inst.GetPkgCodeLen(file.Path(), codeLen), TSD_START_FAIL);
    EXPECT_EQ(codeLen, 77U);
}

TEST_F(PackageVerifyTest, VerifyPackageByCms_HeaderLengthExceedsFile_RejectsTruncatedPayload)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 4096U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).expects(never());

    EXPECT_EQ(inst.VerifyPackageByCms(), TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerify_CompletePayload_RewritesExactCode)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1024U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1024U));
    PackageVerify inst(file.Path());
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage)
        .expects(once())
        .with(processWith(CaptureRewriteBuffer), processWith(CaptureRewriteLength), spy(g_rewriteCall.path))
        .will(returnValue(TSD_OK));

    EXPECT_EQ(inst.ProcessSendStepVerify(file.Path(), 1024U), TSD_OK);
    EXPECT_EQ(g_rewriteCall.calls, 1);
    EXPECT_EQ(g_rewriteCall.path, file.Path());
    EXPECT_EQ(g_rewriteCall.len, 1024U);
    vector<uint8_t> expectedPayload(1024U);
    for (uint32_t i = 0U; i < expectedPayload.size(); ++i) {
        expectedPayload[i] = static_cast<uint8_t>(i & 0xFFU);
    }
    EXPECT_EQ(g_rewriteCall.payload, expectedPayload);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerify_MissingFile_ReturnsStartFail)
{
    TempFile file;
    ASSERT_FALSE(file.Path().empty());
    ASSERT_EQ(remove(file.Path().c_str()), 0);
    PackageVerify inst(file.Path());
    const TSD_StatusT ret = inst.ProcessSendStepVerify(file.Path(), 1024);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerify_RewriteFails_ReturnsStartFail)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1024U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1024U));
    PackageVerify inst(file.Path());
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_START_FAIL)));
    const TSD_StatusT ret = inst.ProcessSendStepVerify(file.Path(), 1024U);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerifyReturnsErrorWhenSeekFails)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    MOCKER(fseek).expects(once()).will(returnValue(-1));
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).expects(never());

    EXPECT_EQ(inst.ProcessSendStepVerify(file.Path(), 1U), TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerifyReturnsErrorOnShortPayloadRead)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 1U, kCmsHeadFixPacketLen + kCmsImgDescLen + 1U));
    PackageVerify inst(file.Path());
    MOCKER(fread).expects(once()).will(returnValue(static_cast<size_t>(0U)));
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).expects(never());

    EXPECT_EQ(inst.ProcessSendStepVerify(file.Path(), 1U), TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ProcessSendStepVerify_TruncatedDescriptor_RejectsBeforeRewrite)
{
    TempFile file;
    ASSERT_TRUE(WriteCmsPackage(file.Path(), 0U, kCmsHeadFixPacketLen + (kCmsImgDescLen / 2U)));
    PackageVerify inst(file.Path());
    MOCKER_CPP(&PackageVerify::ReWriteAicpuPackage).expects(never());

    EXPECT_EQ(inst.ProcessSendStepVerify(file.Path(), 1U), TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ReWriteAicpuPackage_ValidBuffer_WritesExactPayload)
{
    TempFile file;
    vector<uint8_t> data(1024, 0xDD);

    PackageVerify inst(file.Path());
    const TSD_StatusT ret = inst.ReWriteAicpuPackage(data.data(), 1024, file.Path());
    EXPECT_EQ(ret, TSD_OK);

    ifstream infile(file.Path(), ios::binary);
    ASSERT_TRUE(infile.is_open());
    vector<uint8_t> readData(1024);
    infile.read(reinterpret_cast<char*>(readData.data()), 1024);
    EXPECT_EQ(readData, data);
}

TEST_F(PackageVerifyTest, ReWriteAicpuPackage_MissingParentDirectory_ReturnsStartFail)
{
    TempDir dir;
    ASSERT_FALSE(dir.Path().empty());
    const string filepath = dir.Path() + "/missing/test.bin";
    vector<uint8_t> data(1024, 0xEE);

    PackageVerify inst(filepath);
    const TSD_StatusT ret = inst.ReWriteAicpuPackage(data.data(), 1024, filepath);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageVerifyTest, ReWriteAicpuPackage_ShortWrite_ReturnsStartFail)
{
    TempFile file;
    vector<uint8_t> data(1024, 0xEF);

    PackageVerify inst(file.Path());
    MOCKER(fwrite).stubs().will(invoke(CaptureFwrite));
    const TSD_StatusT ret = inst.ReWriteAicpuPackage(data.data(), 1024, file.Path());
    EXPECT_EQ(ret, TSD_START_FAIL);
    EXPECT_EQ(g_fwriteCalls, 1);
    EXPECT_EQ(g_fwriteSize, 1024U);
    EXPECT_EQ(g_fwriteCount, 1U);
}

TEST_F(PackageVerifyTest, IsSupportCmsVerify_BuildFlag_ReturnsConfiguredSupport)
{
    PackageVerify inst("tmp.tar.gz");
    const bool ret = inst.IsSupportCmsVerify();
#if (defined CMS_CBB_VERIFY_PKT) || (defined TSD_HOST_LIB)
    EXPECT_EQ(ret, true);
#else
    EXPECT_EQ(ret, false);
#endif
}
