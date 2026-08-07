/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager_test_common.h"
#include "env_internal_api.h"
#include "stub_server_msg_impl.h"
#include "stub_server_reply.h"
#include <sys/file.h>

using namespace tsd;
using namespace tsdtest;
using namespace std;

namespace {
auto mockerOpen = reinterpret_cast<int (*)(const char*, int)>(open);

struct SendFileCapture {
    int32_t calls = 0;
    int32_t peerNode = -1;
    int32_t deviceId = -1;
    std::string orgFile;
    std::string dstFile;
    drvError_t ret = DRV_ERROR_NONE;
};

SendFileCapture g_legacySend;
SendFileCapture g_v2Send;
std::vector<HDCMessage> g_checkCodeMessages;
int32_t g_getProcessSignCalls = 0;
drvError_t g_getProcessSignRet = DRV_ERROR_NONE;
pid_t g_processTgid = 4321;

void ResetSenderCaptures()
{
    g_legacySend = {};
    g_v2Send = {};
    g_checkCodeMessages.clear();
    g_getProcessSignCalls = 0;
    g_getProcessSignRet = DRV_ERROR_NONE;
    g_processTgid = 4321;
}

void CaptureCheckCodeMessage(HDCMessage msg) { g_checkCodeMessages.push_back(msg); }

void SetFallbackMessageIdentity(HDCMessage& msg)
{
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
    auto* const hashInfo = msg.add_package_hash_code_list();
    hashInfo->set_package_name("Ascend-aicpu_kernels.tar.gz");
    hashInfo->set_hash_code("host-hash");
}

void ExpectCapturedFallbackMessage()
{
    ASSERT_EQ(g_checkCodeMessages.size(), 1U);
    const auto& msg = g_checkCodeMessages[0];
    EXPECT_EQ(msg.package_type(), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
    ASSERT_EQ(msg.package_hash_code_list_size(), 1);
    EXPECT_EQ(msg.package_hash_code_list(0).package_name(), "Ascend-aicpu_kernels.tar.gz");
    EXPECT_EQ(msg.package_hash_code_list(0).hash_code(), "host-hash");
}

drvError_t CaptureLegacySend(
    int32_t peerNode, int32_t deviceId, const char* file, const char* dstPath, void (*)(struct drvHdcProgInfo*))
{
    ++g_legacySend.calls;
    g_legacySend.peerNode = peerNode;
    g_legacySend.deviceId = deviceId;
    g_legacySend.orgFile = file;
    g_legacySend.dstFile = dstPath;
    return g_legacySend.ret;
}

drvError_t CaptureV2Send(
    int32_t peerNode, int32_t deviceId, const char* file, const char* dstPath, void (*)(struct drvHdcProgInfo*))
{
    ++g_v2Send.calls;
    g_v2Send.peerNode = peerNode;
    g_v2Send.deviceId = deviceId;
    g_v2Send.orgFile = file;
    g_v2Send.dstFile = dstPath;
    return g_v2Send.ret;
}

drvError_t TrustedBasePathStub(int32_t, int32_t, char* basePath, uint32_t pathLen)
{
    (void)snprintf(basePath, pathLen, "%s", "/device/trusted");
    return DRV_ERROR_NONE;
}

drvError_t ProcessSignStub(process_sign* sign)
{
    ++g_getProcessSignCalls;
    if (g_getProcessSignRet == DRV_ERROR_NONE) {
        sign->tgid = g_processTgid;
    }
    return g_getProcessSignRet;
}

std::string GetHostSoPathFake() { return "test"; }
} // namespace

class PackageSenderComponentTest : public PackageManagerComponentTest {
protected:
    void SetUp() override
    {
        PackageManagerComponentTest::SetUp();
        serverReplyState_ = StubServerReply::GetInstance()->SaveState();
        StubServerReply::GetInstance()->ResetServerReply();
        ResetSenderCaptures();
    }

    void TearDown() override
    {
        try {
            PackageManagerComponentTest::TearDown();
        } catch (...) {
            StubServerReply::GetInstance()->RestoreState(serverReplyState_);
            throw;
        }
        StubServerReply::GetInstance()->RestoreState(serverReplyState_);
    }

    StubServerReply::State serverReplyState_;
};

TEST_F(PackageSenderComponentTest, SendCommonPackage_ExtendDriverSendFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 0xFFFFFFFF;
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 13U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 123U;
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(1));
    const std::string path = "";
    const uint32_t packageType = 1;
    processModeManager.GetPackageManager().envInfo_.GetPackageNameRef(1) = "test";
    auto ret = processModeManager.GetPackageManager().sender_.SendCommonPackage(0, path, packageType);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageSenderComponentTest, SendCommonPackage_ExtendHashDiffers_SendsExpectedFile)
{
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL);
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    manager.capabilityMgr_.tsdSupportLevel_ = 1U << TSD_SUPPORT_EXTEND_PKG;
    manager.commAgent_.procSign_.tgid = 2468;
    packageManager.envInfo_.GetPackagePathRef(packageType) = "/host/opp/";
    packageManager.envInfo_.GetPackageNameRef(packageType) = "Ascend-aicpu_extend_syskernels.tar.gz";
    packageManager.ctx_.hostCheckCode[packageType] = 123U;
    packageManager.ctx_.peerCheckCode[packageType] = 456U;
    MOCKER(&drvHdcSendFile).expects(once()).will(invoke(CaptureLegacySend));

    EXPECT_EQ(packageManager.sender_.SendCommonPackage(7, "/device/packages", packageType), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.peerNode, 7);
    EXPECT_EQ(g_legacySend.deviceId, deviceId);
    EXPECT_EQ(g_legacySend.orgFile, "/host/opp/Ascend-aicpu_extend_syskernels.tar.gz");
    EXPECT_EQ(g_legacySend.dstFile, "/device/packages/2468_Ascend-aicpu_extend_syskernels.tar.gz");
}

TEST_F(PackageSenderComponentTest, SendCommonPackage_ExtendHashMatches_DoesNotSend)
{
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL);
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    manager.capabilityMgr_.tsdSupportLevel_ = 1U << TSD_SUPPORT_EXTEND_PKG;
    packageManager.envInfo_.GetPackageNameRef(packageType) = "Ascend-aicpu_extend_syskernels.tar.gz";
    packageManager.ctx_.hostCheckCode[packageType] = 123U;
    packageManager.ctx_.peerCheckCode[packageType] = 123U;
    MOCKER(&drvHdcSendFile).expects(never());

    EXPECT_EQ(packageManager.sender_.SendCommonPackage(0, "/device/packages", packageType), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendAicpuPackage_RetryEnabledHashDiffers_SendsExpectedFileAndChecksTwice)
{
    MOCKER(&IsAsanMmSysEnv).stubs().will(returnValue(false));
    MOCKER(&IsFpgaMmSysEnv).stubs().will(returnValue(false));
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.ctx_.getCheckCodeRetrySupport = true;
    packageManager.envInfo_.SetHostSoPath("");
    packageManager.envInfo_.GetPackagePathRef(packageType) = "/host/opp/";
    packageManager.envInfo_.GetPackageNameRef(packageType) = "Ascend-aicpu_syskernels.tar.gz";
    packageManager.ctx_.hostCheckCode[packageType] = 123U;
    packageManager.ctx_.peerCheckCode[packageType] = 456U;
    manager.commAgent_.procSign_.tgid = 1357;
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(exactly(2))
        .with(processWith(CaptureCheckCodeMessage))
        .will(returnValue(TSD_OK));
    MOCKER(&drvHdcSendFile).expects(once()).will(invoke(CaptureLegacySend));

    EXPECT_EQ(packageManager.sender_.SendAICPUPackage(8, "/device/packages"), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.peerNode, 8);
    EXPECT_EQ(g_legacySend.orgFile, "/host/opp/Ascend-aicpu_syskernels.tar.gz");
    EXPECT_EQ(g_legacySend.dstFile, "/device/packages/1357_Ascend-aicpu_syskernels.tar.gz");
    ASSERT_EQ(g_checkCodeMessages.size(), 2U);
    EXPECT_FALSE(g_checkCodeMessages[0].wait_flag());
    EXPECT_TRUE(g_checkCodeMessages[1].wait_flag());
    EXPECT_EQ(g_checkCodeMessages[0].package_type(), packageType);
    EXPECT_EQ(g_checkCodeMessages[0].check_code(), 123U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_CompareMatchesAfterFirstCheck_SkipsFileSend)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(once())
        .with(processWith(CaptureCheckCodeMessage))
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).expects(never());
    MOCKER(drvHdcSendFile).expects(never());
    MOCKER(drvHdcSendFileV2).expects(never());
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(17U);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(2026U);
    SetFallbackMessageIdentity(msg);
    auto aicpuPkgCompareMethd = []() { return true; };
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
    ExpectCapturedFallbackMessage();
    EXPECT_EQ(g_checkCodeMessages[0].real_device_id(), 17U);
    EXPECT_EQ(g_checkCodeMessages[0].type(), HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    EXPECT_EQ(g_checkCodeMessages[0].check_code(), 2026U);
    EXPECT_FALSE(g_checkCodeMessages[0].wait_flag());
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_MutexOpenFails_UsesUnlockedSendFlow)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(-1));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    SetFallbackMessageIdentity(msg);
    auto aicpuPkgCompareMethd = []() { return true; };
    MOCKER(CheckRealPath).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(never());
    MOCKER_CPP(&PackageSender::SendMsgAndHostPackage)
        .expects(once())
        .with(0, srcFile, dstFile, processWith(CaptureCheckCodeMessage), mockcpp::any(), false)
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
    ExpectCapturedFallbackMessage();
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_RealCommFirstCheckFails_ReturnsInternalError)
{
    StubServerReply::GetInstance()->RegisterCallBack(
        HDCMessage::TSD_CHECK_PACKAGE_RETRY, StubServerMsgImpl::DefaultLoadRuntimePkgMsgProc);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return true; };
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_MutexPathUnavailable_UsesUnlockedSendFlow)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(never());
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    SetFallbackMessageIdentity(msg);
    auto aicpuPkgCompareMethd = []() { return true; };
    MOCKER(CheckRealPath).stubs().will(returnValue(false));
    MOCKER(mockerOpen).expects(never());
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    MOCKER_CPP(&PackageSender::SendMsgAndHostPackage)
        .expects(once())
        .with(0, srcFile, dstFile, processWith(CaptureCheckCodeMessage), mockcpp::any(), false)
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 0U);
    ExpectCapturedFallbackMessage();
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_FirstCheckFails_ReturnsInternalError)
{
    StubServerReply::GetInstance()->RegisterCallBack(
        HDCMessage::TSD_CHECK_PACKAGE_RETRY, StubServerMsgImpl::DefaultLoadRuntimePkgMsgProc);
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).stubs().will(returnValue(1U));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return true; };
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_CompareMatches_DoesNotSendFile)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(once())
        .with(processWith(CaptureCheckCodeMessage))
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).expects(never());
    MOCKER(drvHdcSendFile).expects(never());
    MOCKER(drvHdcSendFileV2).expects(never());
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(23U);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(3030U);
    SetFallbackMessageIdentity(msg);
    auto aicpuPkgCompareMethd = []() { return true; };
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
    ExpectCapturedFallbackMessage();
    EXPECT_EQ(g_checkCodeMessages[0].real_device_id(), 23U);
    EXPECT_EQ(g_checkCodeMessages[0].type(), HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    EXPECT_EQ(g_checkCodeMessages[0].check_code(), 3030U);
    EXPECT_FALSE(g_checkCodeMessages[0].wait_flag());
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_SecondCheckThresholdError_PropagatesError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK))
        .then(returnValue(100U));
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return false; };
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 100U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_SecondCheckFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK))
        .then(returnValue(1U));
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return false; };
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_FileSendFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).stubs().will(returnValue(1U));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return false; };
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_LockAndFileSendFail_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageSender::SendAICPUPackageSimple).stubs().will(returnValue(1U));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(-1));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return false; };
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_OpenMutexFileFails_UsesUnlockedSendFlow)
{
    ProcessModeManager processModeManager(deviceId, 0);
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    SetFallbackMessageIdentity(msg);
    auto aicpuPkgCompareMethd = []() { return true; };

    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    MOCKER(CheckRealPath).stubs().will(returnValue(true));
    MOCKER(mockerOpen).stubs().will(returnValue(-1));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(never());
    MOCKER_CPP(&PackageSender::SendMsgAndHostPackage)
        .expects(once())
        .with(0, srcFile, dstFile, processWith(CaptureCheckCodeMessage), mockcpp::any(), false)
        .will(returnValue(tsd::TSD_OK));

    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
    ExpectCapturedFallbackMessage();
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_FileLockFails_StillUsesSendFlow)
{
    ProcessModeManager processModeManager(deviceId, 0);
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    SetFallbackMessageIdentity(msg);
    auto aicpuPkgCompareMethd = []() { return true; };

    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    MOCKER(CheckRealPath).stubs().will(returnValue(true));
    MOCKER(mockerOpen).stubs().will(returnValue(3));
    MOCKER(flock).stubs().will(returnValue(-1));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(never());
    MOCKER_CPP(&PackageSender::SendMsgAndHostPackage)
        .expects(once())
        .with(0, srcFile, dstFile, processWith(CaptureCheckCodeMessage), mockcpp::any(), false)
        .will(returnValue(tsd::TSD_OK));

    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
    ExpectCapturedFallbackMessage();
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplex_FirstCheckThresholdError_PropagatesError)
{
    StubServerReply::GetInstance()->RegisterCallBack(
        HDCMessage::TSD_CHECK_PACKAGE_RETRY, StubServerMsgImpl::DefaultLoadRuntimePkgMsgProc);
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).stubs().will(returnValue(100U));
    processModeManager.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() { return true; };
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER(tsd::GetHostSoPath).stubs().will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.GetPackageManager().sender_.SendHostPackageComplex(
        0, srcFile, dstFile, msg, aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 100U);
}

TEST_F(PackageSenderComponentTest, SendAicpuPackageSimpleUsesLegacyApiAndForwardsArguments)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));

    EXPECT_EQ(manager.GetPackageManager().sender_.SendAICPUPackageSimple(7, "/host/pkg", "/device/pkg", false), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.peerNode, 7);
    EXPECT_EQ(g_legacySend.deviceId, deviceId);
    EXPECT_EQ(g_legacySend.orgFile, "/host/pkg");
    EXPECT_EQ(g_legacySend.dstFile, "/device/pkg");
    EXPECT_EQ(g_v2Send.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendAicpuPackageSimpleUsesV2ApiAndReturnsFailure)
{
    ProcessModeManager manager(deviceId, 0);
    g_v2Send.ret = static_cast<drvError_t>(1);
    MOCKER(drvHdcSendFileV2).stubs().will(invoke(CaptureV2Send));

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendAICPUPackageSimple(8, "/host/cann.pkg", "/device/cann.pkg", true),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_v2Send.calls, 1);
    EXPECT_EQ(g_v2Send.peerNode, 8);
    EXPECT_EQ(g_v2Send.deviceId, deviceId);
    EXPECT_EQ(g_v2Send.orgFile, "/host/cann.pkg");
    EXPECT_EQ(g_v2Send.dstFile, "/device/cann.pkg");
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendAicpuPackageSimpleReturnsLegacyApiFailure)
{
    ProcessModeManager manager(deviceId, 0);
    g_legacySend.ret = static_cast<drvError_t>(1);
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendAICPUPackageSimple(9, "/host/pkg", "/device/pkg", false),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.peerNode, 9);
    EXPECT_EQ(g_v2Send.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendMsgAndHostPackageSendsAndPerformsSecondCheck)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(exactly(2))
        .with(processWith(CaptureCheckCodeMessage))
        .will(returnValue(TSD_OK));
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_real_device_id(17U);
    msg.set_check_code(2026U);

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendMsgAndHostPackage(
            3, "/host/aicpu.pkg", "/device/aicpu.pkg", msg, []() { return false; }, false),
        TSD_OK);
    EXPECT_TRUE(msg.wait_flag());
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.orgFile, "/host/aicpu.pkg");
    EXPECT_EQ(g_legacySend.dstFile, "/device/aicpu.pkg");
    ASSERT_EQ(g_checkCodeMessages.size(), 2U);
    EXPECT_FALSE(g_checkCodeMessages[0].wait_flag());
    EXPECT_TRUE(g_checkCodeMessages[1].wait_flag());
    for (const auto& capturedMsg : g_checkCodeMessages) {
        EXPECT_EQ(capturedMsg.type(), HDCMessage::TSD_CHECK_PACKAGE_RETRY);
        EXPECT_EQ(capturedMsg.real_device_id(), 17U);
        EXPECT_EQ(capturedMsg.check_code(), 2026U);
    }
}

TEST_F(PackageSenderComponentTest, SendMsgAndHostPackageReturnsSecondCheckThresholdError)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(exactly(2))
        .will(returnValue(TSD_OK))
        .then(returnValue(static_cast<TSD_StatusT>(TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT)));
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));
    HDCMessage msg;

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendMsgAndHostPackage(
            0, "/host/pkg", "/device/pkg", msg, []() { return false; }, false),
        TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT);
    EXPECT_TRUE(msg.wait_flag());
    EXPECT_EQ(g_legacySend.calls, 1);
}

TEST_F(PackageSenderComponentTest, SendHostPackageComplexWithEmptyHostPathUsesRealSendFlow)
{
    ProcessModeManager manager(deviceId, 0);
    manager.GetPackageManager().envInfo_.SetHostSoPath("");
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(once()).will(returnValue(TSD_OK));
    MOCKER(drvHdcSendFile).expects(never());
    HDCMessage msg;

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendHostPackageComplex(
            0, "/host/pkg", "/device/pkg", msg, []() { return true; }, false),
        TSD_OK);
    EXPECT_FALSE(msg.wait_flag());
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendAicpuPackageLegacyPathBuildsExpectedNamesAndSends)
{
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.GetPackagePathRef(packageType) = "/host/opp/";
    packageManager.envInfo_.GetPackageNameRef(packageType) = "aicpu.tar.gz";
    packageManager.ctx_.hostCheckCode[packageType] = 11U;
    packageManager.ctx_.peerCheckCode[packageType] = 22U;
    packageManager.ctx_.getCheckCodeRetrySupport = false;
    manager.commAgent_.procSign_.tgid = 2468;
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));

    EXPECT_EQ(packageManager.sender_.SendAICPUPackage(4, "/device/packages"), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.peerNode, 4);
    EXPECT_EQ(g_legacySend.orgFile, "/host/opp/aicpu.tar.gz");
    EXPECT_EQ(g_legacySend.dstFile, "/device/packages/2468_aicpu.tar.gz");
}

TEST_F(PackageSenderComponentTest, SendAicpuPackageRetryPathBuildsMessageAndCompletesSend)
{
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.SetHostSoPath("");
    packageManager.envInfo_.GetPackagePathRef(packageType) = "/host/opp/";
    packageManager.envInfo_.GetPackageNameRef(packageType) = "aicpu.tar.gz";
    packageManager.ctx_.hostCheckCode[packageType] = 33U;
    packageManager.ctx_.peerCheckCode[packageType] = 44U;
    packageManager.ctx_.getCheckCodeRetrySupport = true;
    manager.commAgent_.procSign_.tgid = 1357;
    MOCKER(IsAsanMmSysEnv).stubs().will(returnValue(false));
    MOCKER(IsFpgaMmSysEnv).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(exactly(2))
        .with(processWith(CaptureCheckCodeMessage))
        .will(returnValue(TSD_OK));
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));

    EXPECT_EQ(packageManager.sender_.SendAICPUPackage(5, "/device/packages"), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.orgFile, "/host/opp/aicpu.tar.gz");
    EXPECT_EQ(g_legacySend.dstFile, "/device/packages/1357_aicpu.tar.gz");
    ASSERT_EQ(g_checkCodeMessages.size(), 2U);
    EXPECT_FALSE(g_checkCodeMessages[0].wait_flag());
    EXPECT_TRUE(g_checkCodeMessages[1].wait_flag());
    for (const auto& capturedMsg : g_checkCodeMessages) {
        EXPECT_EQ(capturedMsg.type(), HDCMessage::TSD_CHECK_PACKAGE_RETRY);
        EXPECT_EQ(capturedMsg.real_device_id(), deviceId);
        EXPECT_EQ(capturedMsg.check_code(), 33U);
        EXPECT_EQ(capturedMsg.package_type(), packageType);
    }
}

TEST_F(PackageSenderComponentTest, SendAicpuPackageReturnsBuilderFailureWithoutSending)
{
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.GetPackageNameRef(packageType) = "aicpu.tar.gz";
    packageManager.ctx_.hostCheckCode[packageType] = 1U;
    packageManager.ctx_.peerCheckCode[packageType] = 2U;
    packageManager.ctx_.getCheckCodeRetrySupport = true;
    MOCKER(IsAsanMmSysEnv).stubs().will(returnValue(false));
    MOCKER(IsFpgaMmSysEnv).stubs().will(returnValue(false));
    MOCKER_CPP(&HdcMessageBuilder::BuildCheckPackageRetry)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));
    MOCKER(drvHdcSendFile).expects(never());

    EXPECT_EQ(packageManager.sender_.SendAICPUPackage(0, "/device"), TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendCommonPackageRejectsUnsupportedTypeWithoutSending)
{
    ProcessModeManager manager(deviceId, 0);
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE);
    manager.GetPackageManager().envInfo_.GetPackageNameRef(packageType) = "dshape.pkg";
    MOCKER(drvHdcSendFile).expects(never());

    EXPECT_EQ(manager.GetPackageManager().sender_.SendCommonPackage(0, "/device", packageType), TSD_OK);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendCommonPackageClearsHashWhenAscendCppIsUnsupported)
{
    ProcessModeManager manager(deviceId, 0);
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.GetPackageNameRef(packageType) = "ascendcpp.pkg";
    packageManager.ctx_.hostCheckCode[packageType] = 88U;
    manager.capabilityMgr_.tsdSupportLevel_ = 0U;
    MOCKER(drvHdcSendFile).expects(never());

    EXPECT_EQ(packageManager.sender_.SendCommonPackage(0, "/device", packageType), TSD_OK);
    EXPECT_EQ(packageManager.ctx_.hostCheckCode[packageType], 0U);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendCommonPackageSkipsMatchingAscendCppHash)
{
    ProcessModeManager manager(deviceId, 0);
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.GetPackageNameRef(packageType) = "ascendcpp.pkg";
    packageManager.ctx_.hostCheckCode[packageType] = 77U;
    packageManager.ctx_.peerCheckCode[packageType] = 77U;
    manager.capabilityMgr_.tsdSupportLevel_ = 1U << TSD_SUPPORT_ASCENDCPP_PKG;
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));

    EXPECT_EQ(packageManager.sender_.SendCommonPackage(0, "/device", packageType), TSD_OK);
    EXPECT_EQ(packageManager.ctx_.hostCheckCode[packageType], 77U);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendCommonPackageAscendCppSuccessPreservesHashAndPaths)
{
    ProcessModeManager manager(deviceId, 0);
    constexpr uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.GetPackagePathRef(packageType) = "/host/builtin/";
    packageManager.envInfo_.GetPackageNameRef(packageType) = "ascendcpp.pkg";
    packageManager.ctx_.hostCheckCode[packageType] = 88U;
    packageManager.ctx_.peerCheckCode[packageType] = 99U;
    manager.capabilityMgr_.tsdSupportLevel_ = 1U << TSD_SUPPORT_ASCENDCPP_PKG;
    manager.commAgent_.procSign_.tgid = 9753;
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));

    EXPECT_EQ(packageManager.sender_.SendCommonPackage(6, "/device", packageType), TSD_OK);
    EXPECT_EQ(packageManager.ctx_.hostCheckCode[packageType], 88U);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.peerNode, 6);
    EXPECT_EQ(g_legacySend.orgFile, "/host/builtin/ascendcpp.pkg");
    EXPECT_EQ(g_legacySend.dstFile, "/device/9753_ascendcpp.pkg");
}

TEST_F(PackageSenderComponentTest, SendFileToDeviceInitializedAddsPrefixAndPathSeparator)
{
    ProcessModeManager manager(deviceId, 0);
    (void)InjectPackageStubComm(manager, deviceId);
    manager.commAgent_.procSign_.tgid = 8642;
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(invoke(TrustedBasePathStub));
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));
    const std::string path = "/host/models";
    const std::string name = "model.om";

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendFileToDevice(path.data(), path.size(), name.data(), name.size(), true),
        TSD_OK);
    EXPECT_EQ(g_getProcessSignCalls, 0);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.orgFile, "/host/models/model.om");
    EXPECT_EQ(g_legacySend.dstFile, "/device/trusted/8642_model.om");
}

TEST_F(PackageSenderComponentTest, SendFileToDeviceUninitializedReturnsProcessSignFailure)
{
    ProcessModeManager manager(deviceId, 0);
    g_getProcessSignRet = static_cast<drvError_t>(1);
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(invoke(TrustedBasePathStub));
    MOCKER(drvGetProcessSign).stubs().will(invoke(ProcessSignStub));
    MOCKER(drvHdcSendFile).expects(never());
    const std::string path = "/host/";
    const std::string name = "model.om";

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendFileToDevice(path.data(), path.size(), name.data(), name.size(), false),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_getProcessSignCalls, 1);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, SendFileToDeviceUninitializedUsesDriverPidAndReportsSendFailure)
{
    ProcessModeManager manager(deviceId, 0);
    g_processTgid = 7531;
    g_legacySend.ret = static_cast<drvError_t>(1);
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(invoke(TrustedBasePathStub));
    MOCKER(drvGetProcessSign).stubs().will(invoke(ProcessSignStub));
    MOCKER(drvHdcSendFile).stubs().will(invoke(CaptureLegacySend));
    const std::string path = "/host/";
    const std::string name = "model.om";

    EXPECT_EQ(
        manager.GetPackageManager().sender_.SendFileToDevice(path.data(), path.size(), name.data(), name.size(), true),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_getProcessSignCalls, 1);
    EXPECT_EQ(g_legacySend.calls, 1);
    EXPECT_EQ(g_legacySend.orgFile, "/host/model.om");
    EXPECT_EQ(g_legacySend.dstFile, "/device/trusted/7531_model.om");
}

TEST_F(PackageSenderComponentTest, CompareAndSendCommonSinkPackageReturnsBuilderFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&HdcMessageBuilder::BuildNormalCheckCode)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().sender_.CompareAndSendCommonSinkPkg(
            "driver.pkg", "host-hash", 0, "/host/pkg", "/device/pkg"),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageSenderComponentTest, CompareAndSendCommonSinkPackageReturnsComplexSendFailure)
{
    ProcessModeManager manager(deviceId, 0);
    MOCKER_CPP(&PackageSender::SendHostPackageComplex)
        .stubs()
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    EXPECT_EQ(
        manager.GetPackageManager().sender_.CompareAndSendCommonSinkPkg(
            "driver.pkg", "host-hash", 0, "/host/pkg", "/device/pkg"),
        TSD_INTERNAL_ERROR);
}

TEST_F(PackageSenderComponentTest, CompareAndSendCommonSinkPackageSkipsMatchingHashWithoutSending)
{
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.SetHostSoPath("");
    packageManager.hashStore_.SetHostCommonSinkPackHashValue("driver.pkg", "same-hash");
    packageManager.hashStore_.SetDeviceCommonSinkPackHashValue("driver.pkg", "same-hash");
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry).expects(once()).will(returnValue(TSD_OK));

    EXPECT_EQ(
        packageManager.sender_.CompareAndSendCommonSinkPkg("driver.pkg", "same-hash", 0, "/host/pkg", "/device/pkg"),
        TSD_OK);
    EXPECT_EQ(g_v2Send.calls, 0);
    EXPECT_EQ(g_legacySend.calls, 0);
}

TEST_F(PackageSenderComponentTest, CompareAndSendCommonSinkPackageSendsMismatchedHashWithV2Api)
{
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.SetHostSoPath("");
    packageManager.hashStore_.SetHostCommonSinkPackHashValue("driver.pkg", "host-hash");
    packageManager.hashStore_.SetDeviceCommonSinkPackHashValue("driver.pkg", "device-hash");
    PackageProcessConfig::GetInstance()->hostPluginVersions_["driver.pkg"] = {"8.5.0", "20260806_120000000"};
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(exactly(2))
        .with(processWith(CaptureCheckCodeMessage))
        .will(returnValue(TSD_OK));
    MOCKER(drvHdcSendFileV2).expects(once()).will(invoke(CaptureV2Send));

    EXPECT_EQ(
        packageManager.sender_.CompareAndSendCommonSinkPkg(
            "driver.pkg", "host-hash", 11, "/host/driver.pkg", "/device/driver.pkg"),
        TSD_OK);
    EXPECT_EQ(g_v2Send.calls, 1);
    EXPECT_EQ(g_v2Send.peerNode, 11);
    EXPECT_EQ(g_v2Send.deviceId, deviceId);
    EXPECT_EQ(g_v2Send.orgFile, "/host/driver.pkg");
    EXPECT_EQ(g_v2Send.dstFile, "/device/driver.pkg");
    EXPECT_EQ(g_legacySend.calls, 0);
    ASSERT_EQ(g_checkCodeMessages.size(), 2U);
    EXPECT_FALSE(g_checkCodeMessages[0].wait_flag());
    EXPECT_TRUE(g_checkCodeMessages[1].wait_flag());
    for (const auto& msg : g_checkCodeMessages) {
        ASSERT_EQ(msg.package_hash_code_list_size(), 1);
        EXPECT_EQ(msg.package_hash_code_list(0).package_name(), "driver.pkg");
        EXPECT_EQ(msg.package_hash_code_list(0).hash_code(), "host-hash");
        EXPECT_EQ(msg.package_worker_type(), static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK));
        EXPECT_EQ(msg.package_type(), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK));
        EXPECT_EQ(msg.package_max_process_time(), 140U);
        ASSERT_EQ(msg.host_plugin_versions_size(), 1);
        EXPECT_EQ(msg.host_plugin_versions(0).version(), "8.5.0");
        EXPECT_EQ(msg.host_plugin_versions(0).timestamp(), "20260806_120000000");
    }
}

TEST_F(PackageSenderComponentTest, CompareAndSendCommonSinkPackageReturnsPostSendResponseFailure)
{
    ProcessModeManager manager(deviceId, 0);
    auto& packageManager = manager.GetPackageManager();
    packageManager.envInfo_.SetHostSoPath("");
    packageManager.hashStore_.SetHostCommonSinkPackHashValue("driver.pkg", "host-hash");
    packageManager.hashStore_.SetDeviceCommonSinkPackHashValue("driver.pkg", "device-hash");
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeRetry)
        .expects(exactly(2))
        .will(returnValue(TSD_OK))
        .then(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));
    MOCKER(drvHdcSendFileV2).stubs().will(invoke(CaptureV2Send));

    EXPECT_EQ(
        packageManager.sender_.CompareAndSendCommonSinkPkg(
            "driver.pkg", "host-hash", 12, "/host/driver.pkg", "/device/driver.pkg"),
        TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_v2Send.calls, 1);
    EXPECT_EQ(g_v2Send.peerNode, 12);
    EXPECT_EQ(g_v2Send.deviceId, deviceId);
    EXPECT_EQ(g_v2Send.orgFile, "/host/driver.pkg");
    EXPECT_EQ(g_v2Send.dstFile, "/device/driver.pkg");
}
