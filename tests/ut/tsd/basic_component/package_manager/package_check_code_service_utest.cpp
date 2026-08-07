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

using namespace tsd;
using namespace tsdtest;
using namespace std;

namespace {
HDCMessage g_retryRequest;

void CaptureRetryRequest(HDCMessage msg) { g_retryRequest = std::move(msg); }
} // namespace

class PackageCheckCodeServiceComponentTest : public PackageManagerComponentTest {};

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCode_PackageAlreadyExists_ReturnsExisted)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().ctx_.aicpuPackageExistInDevice = true;
    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_AICPUPACKAGE_EXISTED);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetrySupport_FeatureSupported_SetsTrue)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    processModeManager.GetPackageManager().ctx_.getCheckCodeRetrySupport = false;
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).stubs().will(returnValue(true));

    processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetrySupport();

    EXPECT_TRUE(processModeManager.GetPackageManager().ctx_.getCheckCodeRetrySupport);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetrySupport_FeatureUnsupported_SetsFalse)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    processModeManager.GetPackageManager().ctx_.getCheckCodeRetrySupport = true;
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).stubs().will(returnValue(false));

    processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetrySupport();

    EXPECT_FALSE(processModeManager.GetPackageManager().ctx_.getCheckCodeRetrySupport);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetrySupport_VersionUnavailable_PreservesState)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);
    stub->inspector_.reset();
    processModeManager.GetPackageManager().ctx_.getCheckCodeRetrySupport = true;

    processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetrySupport();

    EXPECT_TRUE(processModeManager.GetPackageManager().ctx_.getCheckCodeRetrySupport);
    EXPECT_EQ(stub->commGetVersionVerifyRet_, TSD_OK);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetry_DeviceCommMissing_ReturnsNotFound)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_INSTANCE_NOT_FOUND);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetry_SendError_PreservesRequestAndReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectPackageStubComm(processModeManager, deviceId);
    g_retryRequest.Clear();
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).expects(once()).will(returnValue(tsd::TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(2026U);
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
    msg.set_wait_flag(true);
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeOnce)
        .expects(once())
        .with(processWith(CaptureRetryRequest))
        .will(returnValue(static_cast<TSD_StatusT>(TSD_HDC_SEND_MSG_ERROR)));

    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();

    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    EXPECT_EQ(g_retryRequest.real_device_id(), msg.real_device_id());
    EXPECT_EQ(g_retryRequest.type(), msg.type());
    EXPECT_EQ(g_retryRequest.check_code(), msg.check_code());
    EXPECT_EQ(g_retryRequest.package_type(), msg.package_type());
    EXPECT_EQ(g_retryRequest.wait_flag(), msg.wait_flag());
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetry_InitFails_PropagatesError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(100U));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 100U);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCode_ExtendPackageConfiguredAndReceiveFails_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().ctx_.aicpuPackageExistInDevice = false;
    processModeManager.commAgent_.tsdSessionId_ = 0U;
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.commAgent_.devCommClient_)->hdcClientSessionMap_[0U] =
        session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.commAgent_.devCommClient_)->hdcClientVerifyMap_[0U] =
        std::make_shared<VersionVerify>();
    processModeManager.GetPackageManager().envInfo_.GetPackageNameRef(1) = "Ascend-aicpu_extend_syskernels.tar.gz";
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).stubs().will(returnValue(true));
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));

    tsd::TSD_StatusT ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(PackageCheckCodeServiceComponentTest, SaveDeviceCheckCode_AicpuResponse_StoresBaseExtendAndCapabilityValues)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RSP);
    msg.set_check_code(1U);
    msg.set_extendpkg_check_code(2U);
    msg.set_capability_level(5U);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().SaveDeviceCheckCode(msg);
    EXPECT_EQ(
        processModeManager.GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)],
        1U);
    EXPECT_EQ(
        processModeManager.GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)],
        2U);
    EXPECT_EQ(processModeManager.capabilityMgr_.tsdSupportLevel_, 5U);
}

TEST_F(PackageCheckCodeServiceComponentTest, SaveDeviceCheckCode_DshapeResponse_StoresCodeAndSuccessStatus)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().SaveDeviceCheckCode(msg);
    EXPECT_EQ(
        processModeManager.GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE)],
        1);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.GetPackageManager().ctx_.pkgRspCode), 0);
}

TEST_F(PackageCheckCodeServiceComponentTest, SaveDeviceCheckCode_RuntimeResponse_StoresCodeAndSuccessStatus)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().SaveDeviceCheckCode(msg);
    EXPECT_EQ(
        processModeManager.GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME)],
        1);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.GetPackageManager().ctx_.pkgRspCode), 0);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceHsPkgCheckCode_ClientInitializationFails_ReturnsInternalError)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::InitTsdClient)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceHsPkgCheckCode(
        0U, HDCMessage::INIT, false, processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetCannHsPkgCheckCode_ValidPackageAndHash_SendsRequestAndReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);
    const std::string packageName = "cann-custom-kernels.tar.gz";
    const std::string hostHash = "0123456789abcdef";
    processModeManager.GetPackageManager().ctx_.pkgRspCode = ResponseCode::SUCCESS;

    const auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetCannHsPkgCheckCode(
        packageName, hostHash, processModeManager.GetTsdController().BuildBaseMessageContext());

    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(stub->sendCount_, 1);
    EXPECT_EQ(stub->recvCount_, 1);
    EXPECT_EQ(stub->lastMsg_.type(), HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE);
    ASSERT_EQ(stub->lastMsg_.package_hash_code_list_size(), 1);
    EXPECT_EQ(stub->lastMsg_.package_hash_code_list(0).package_name(), packageName);
    EXPECT_EQ(stub->lastMsg_.package_hash_code_list(0).hash_code(), hostHash);
    EXPECT_EQ(
        stub->lastMsg_.package_worker_type(), static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK));
    EXPECT_EQ(stub->lastMsg_.package_type(), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK));
}

TEST_F(PackageCheckCodeServiceComponentTest, SaveDeviceCheckCode_NormalPackageResponse_StoresCodeStatusAndIdleFlag)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND));
    msg.set_device_idle(true);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().SaveDeviceCheckCode(msg);
    EXPECT_EQ(
        processModeManager.GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)],
        1);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.GetPackageManager().ctx_.pkgRspCode), 0);
    EXPECT_EQ(processModeManager.GetPackageManager().ctx_.deviceIdle, true);
}

TEST_F(PackageCheckCodeServiceComponentTest, SaveDeviceCheckCode_NormalPackageTypeInvalid_PreservesIdleFalse)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    msg.set_package_type(0xff);
    msg.set_device_idle(true);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetPackageManager().SaveDeviceCheckCode(msg);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.sharedCtx_.rspCode), 1);
    EXPECT_EQ(processModeManager.GetPackageManager().ctx_.deviceIdle, false);
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCodeRetry_CallsReleaseDeviceConnection)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);

    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeOnce).stubs().will(returnValue(0U));

    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);

    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCodeRetry(msg);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(processModeManager.commAgent_.devCommClient_, nullptr);
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    EXPECT_EQ(stub->destroyCount_, 1);
    GlobalMockObject::verify();
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCode_SupportedFeature_SendsReceivesAndReleasesConnection)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);
    auto& packageManager = processModeManager.GetPackageManager();
    packageManager.ctx_.aicpuPackageExistInDevice = false;
    packageManager.ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 101U;
    packageManager.ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] =
        202U;
    packageManager.ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] = 303U;
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).expects(exactly(2)).will(returnValue(true));
    MOCKER(IsAsanMmSysEnv).stubs().will(returnValue(false));

    EXPECT_EQ(packageManager.checkCodeSvc_.GetDeviceCheckCode(), TSD_OK);
    EXPECT_TRUE(packageManager.ctx_.aicpuPackageExistInDevice);
    EXPECT_EQ(stub->sendCount_, 1);
    EXPECT_EQ(stub->recvCount_, 1);
    EXPECT_EQ(stub->lastMsg_.type(), HDCMessage::TSD_CHECK_PACKAGE);
    EXPECT_EQ(stub->lastMsg_.check_code(), 101U);
    EXPECT_EQ(stub->lastMsg_.extendpkg_check_code(), 202U);
    EXPECT_EQ(stub->lastMsg_.ascendcpppkg_check_code(), 303U);
    EXPECT_EQ(processModeManager.commAgent_.devCommClient_, nullptr);
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    EXPECT_EQ(stub->destroyCount_, 1);
    GlobalMockObject::verify();
}

TEST_F(
    PackageCheckCodeServiceComponentTest, GetDeviceCheckCode_WhenSpecialFeatureCheckFalse_CallsReleaseDeviceConnection)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);
    processModeManager.GetPackageManager().ctx_.aicpuPackageExistInDevice = false;

    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).stubs().will(returnValue(false));

    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCode();
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(processModeManager.commAgent_.devCommClient_, nullptr);
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    EXPECT_EQ(stub->destroyCount_, 1);
    GlobalMockObject::verify();
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceCheckCode_WhenGetOnceFails_CallsReleaseDeviceConnection)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);
    processModeManager.GetPackageManager().ctx_.aicpuPackageExistInDevice = false;

    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageCheckCodeService::GetDeviceCheckCodeOnce).stubs().will(returnValue(1U));

    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceCheckCode();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    EXPECT_EQ(processModeManager.commAgent_.devCommClient_, nullptr);
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    EXPECT_EQ(stub->destroyCount_, 1);
    GlobalMockObject::verify();
}

TEST_F(PackageCheckCodeServiceComponentTest, GetDeviceHsPkgCheckCode_SendFail_ResetsInitFlag)
{
    // SendMsg 失败时重置 commAgent_.IsInit()，保持与原代码行为一致
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectPackageStubComm(processModeManager, deviceId);
    stub->commSendMsgRet_ = tsd::TSD_INTERNAL_ERROR;

    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));

    auto ret = processModeManager.GetPackageManager().checkCodeSvc_.GetDeviceHsPkgCheckCode(
        0U, HDCMessage::INIT, false, processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    // 验证 SendFail 后 commAgent_.IsInit() 被重置为 false，与原代码行为一致
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    GlobalMockObject::verify();
}
