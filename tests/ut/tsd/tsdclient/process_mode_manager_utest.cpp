/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/file.h>
#include <cstdio>
#include <exception>
#include <unistd.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"
#define private public
#define protected public
#include "package_process_config.h"
#include "inc/client_manager.h"
#include "inc/process_mode_manager.h"
#include "capability_manager.h"
#include "plugin_pkg_version.h"
#include "device_comm.h"
#include "tsd_hdc_client.h"
#include "weak_ascend_hal.h"
#include "env_internal_api.h"
#include "platform_manager_v2.h"
#include "hdc_message_builder.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
// clientManager is a singleton, so a deviceId can only point to one mode in all st
// we define 0 to ProcessMode, and 1 to ThreadMode
static const int deviceId = 0;
constexpr int32_t PROCESS_MODE = 0;
constexpr int32_t THREAD_MODE = 1;

} // namespace

namespace {
// 测试用 DeviceComm 桩：覆盖所有虚接口，返回值可在用例中按需配置。
// 由于 mockcpp 的 JmpOnlyApiHookImpl 无法对虚成员函数的 PMF 进行打桩
// （PMF 实际为 vtable 偏移而非函数地址，会触发 SIGSEGV），
// 因此通过子类化 + 注入到 ProcessModeManager.commAgent_.devCommClient_ 的方式替代。
class StubDeviceComm : public tsd::DeviceComm {
public:
    explicit StubDeviceComm(uint32_t devId)
        : tsd::DeviceComm(devId, tsd::DeviceCommType::HDC), inspector_(std::make_shared<tsd::VersionVerify>())
    {}

    tsd::TSD_StatusT CommInit(const uint32_t, const bool) override { return commInitRet_; }
    tsd::TSD_StatusT CommCreateSession(uint32_t& sid) override
    {
        sid = sessionIdStub_;
        return commCreateSessionRet_;
    }
    void CommDestroy() override { ++destroyCount_; }
    tsd::TSD_StatusT CommRecvData(const uint32_t, const bool, const uint32_t) override { return commRecvDataRet_; }
    tsd::TSD_StatusT CommGetConctStatus(int32_t& s) override
    {
        s = sessStat_;
        return commGetConctStatusRet_;
    }
    tsd::TSD_StatusT CommSendMsg(const uint32_t, const HDCMessage&) override { return commSendMsgRet_; }
    tsd::TSD_StatusT CommGetVersionVerify(const uint32_t, std::shared_ptr<tsd::VersionVerify>& v) override
    {
        v = inspector_;
        return commGetVersionVerifyRet_;
    }

    tsd::TSD_StatusT commInitRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commCreateSessionRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commRecvDataRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commGetConctStatusRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commSendMsgRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commGetVersionVerifyRet_ = tsd::TSD_OK;
    uint32_t sessionIdStub_ = 1U;
    int32_t sessStat_ = 0;
    int destroyCount_ = 0;
    std::shared_ptr<tsd::VersionVerify> inspector_;
};

inline std::shared_ptr<StubDeviceComm> InjectStubComm(tsd::ProcessModeManager& pm, uint32_t devId)
{
    auto stub = std::make_shared<StubDeviceComm>(devId);
    pm.commAgent_.devCommClient_ = stub;
    return stub;
}
} // namespace

class ProcessModeManagerTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        savedRunningMode_ = ClientManager::g_runningMode;
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
        cout << "Before ProcessModeManagerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After ProcessModeManagerTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            ResetPackageProcessConfig();
            ClientManager::g_runningMode = savedRunningMode_;
            throw;
        }
        GlobalMockObject::reset();
        ResetPackageProcessConfig();
        ClientManager::g_runningMode = savedRunningMode_;
    }

private:
    RunningMode savedRunningMode_ = RunningMode::UNSET_MODE;

    static void ResetPackageProcessConfig()
    {
        auto* const config = tsd::PackageProcessConfig::GetInstance();
        config->configMap_.clear();
        config->hostPluginVersions_.clear();
        config->hashCode_.clear();
        config->finishParse_ = false;
    }
};

// ====== ProcessModeManager::WaitRsp 错误诊断逻辑测试 ======
// 本次重构将错误诊断与错误码映射从 DeviceCommAgent::WaitRsp 搬到 ProcessModeManager::WaitRsp，
// 以下用例覆盖搬迁后的各分支。

// 正常成功路径：通信成功 + sharedCtx_.rspCode==SUCCESS → TSD_OK

TEST_F(ProcessModeManagerTest, Open_ProcessAlreadyStarted_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    tsd::TSD_StatusT ret = processModeManager.Open(1);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessModeManagerTest, Open_AdcEnvironment_ReturnsNotSupported)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    processModeManager.sharedCtx_.isAdcEnv = true;
    tsd::TSD_StatusT ret = processModeManager.Open(1);
    EXPECT_EQ(ret, tsd::TSD_OPEN_NOT_SUPPORT_FOR_ADC);
}

TEST_F(ProcessModeManagerTest, Close_ProcessNotStarted_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    tsd::TSD_StatusT ret = processModeManager.Close(0);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessModeManagerTest, ServerToClientMsgProc_FailureResponse_SetsFailureCode)
{
    constexpr uint32_t callbackDeviceId = 2100U;
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(callbackDeviceId);
    msg.set_device_id(1);
    msg.set_tsd_rsp_code(1);
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(callbackDeviceId, 0U, false));
    ProcessModeManager::ServerToClientMsgProc(1, msg);
    EXPECT_EQ(client->sharedCtx_.rspCode, ResponseCode::FAIL);
}

TEST_F(ProcessModeManagerTest, PackageInfoMsgProc_CheckPackageResponse_StoresCheckCode)
{
    constexpr uint32_t callbackDeviceId = 2101U;
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(callbackDeviceId);
    msg.set_check_code(1);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RSP);
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(callbackDeviceId, 0U, false));
    client->GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 0;
    ProcessModeManager::PackageInfoMsgProc(1, msg);
    EXPECT_EQ(
        client->GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)],
        1);
}

TEST_F(ProcessModeManagerTest, PackageInfoMsgProc_RetryResponse_StoresCheckCode)
{
    constexpr uint32_t callbackDeviceId = 2102U;
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(callbackDeviceId);
    msg.set_check_code(1);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY_RSP);
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(callbackDeviceId, 0U, false));
    client->GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 0;
    ProcessModeManager::PackageInfoMsgProc(1, msg);
    EXPECT_EQ(
        client->GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)],
        1);
}

TEST_F(ProcessModeManagerTest, PackageInfoMsgProc_UnrelatedMessage_DoesNotStoreCheckCode)
{
    constexpr uint32_t callbackDeviceId = 2103U;
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(callbackDeviceId);
    msg.set_check_code(1);
    msg.set_type(HDCMessage::INIT);
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(callbackDeviceId, 0U, false));
    client->GetPackageManager()
        .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 0;
    ProcessModeManager::PackageInfoMsgProc(1, msg);
    EXPECT_NE(
        client->GetPackageManager()
            .ctx_.peerCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)],
        1);
}

TEST_F(ProcessModeManagerTest, Open_AllDependenciesSucceed_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&TsdProcessController::CheckNeedToOpen).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageLoader::LoadSysOpKernel).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::SendOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::SetTsdStartInfo).stubs().will(ignoreReturnValue());
    ProcessModeManager processModeManager(deviceId, 0);
    ret = processModeManager.Open(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessModeManagerTest, CapabilityResMsgProc_FailureResponse_SetsFailureCode)
{
    constexpr uint32_t callbackDeviceId = 2104U;
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(callbackDeviceId);
    msg.set_device_id(1);
    msg.set_tsd_rsp_code(1);
    msg.set_pid_of_qos(100);
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(callbackDeviceId, 0U, false));
    ProcessModeManager::CapabilityResMsgProc(1, msg);
    EXPECT_EQ(client->sharedCtx_.rspCode, ResponseCode::FAIL);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, CapabilityResMsgProc_SuccessResponse_StoresPidQos)
{
    constexpr uint32_t callbackDeviceId = 2105U;
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(callbackDeviceId);
    msg.set_device_id(1);
    msg.set_tsd_rsp_code(0);
    msg.set_pid_of_qos(100);
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(callbackDeviceId, 0U, false));
    ProcessModeManager::CapabilityResMsgProc(1, msg);
    EXPECT_EQ(client->capabilityMgr_.pidQos_, 100);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, CapabilityGet_NullOutputPointer_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    int32_t type = 1;
    uint64_t ptr = 0UL;
    auto stub = InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::SendOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.Open(2U);
    tsd::TSD_StatusT ret = processModeManager.CapabilityGet(type, ptr);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, CapabilityGet_StartedProcessAndValidOutput_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    int32_t type = 0;
    uint64_t result = 0;
    uint64_t* ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    auto stub = InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&CapabilityManager::SendCapabilityMsg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    processModeManager.capabilityMgr_.SetStartCpStatus(true);
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::SendOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.Open(2U);
    tsd::TSD_StatusT ret = processModeManager.CapabilityGet(type, ptrRes);
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, GetLogLevel_GlobalLevelConfigured_UsesEnvironmentLevel)
{
    char env[] = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "101");
}

TEST_F(ProcessModeManagerTest, GetLogLevel_EnvironmentEmpty_UsesDlogLevel)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    char env[] = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessModeManagerTest, GetLogLevel_EnvironmentMalformed_UsesDlogLevel)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    char env[] = "16b";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessModeManagerTest, Open_CommonInterfaceUnsupported_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.SetPlatInfoChipType(CHIP_BEGIN);
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&PackageCheckCodeService::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageCheckCodeService::WaitPkgRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));

    auto ret = processModeManager.ProcessOpenSubProc(nullptr);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.ProcessCloseSubProc(0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.LoadFileToDevice(nullptr, 0U, nullptr, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.RemoveFileOnDevice(nullptr, 0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.GetSubProcStatus(nullptr, 0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.GetPackageManager().loader_.LoadRuntimePkgToDevice(
        processModeManager.GetTsdController().BuildBaseMessageContext());
    EXPECT_NE(ret, tsd::TSD_OK);

    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, CapabilityGet_capablity)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    int32_t type = 1;
    uint64_t result = 0;
    uint64_t* ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    MOCKER_CPP(&CapabilityManager::WaitRspForCapability).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&CapabilityManager::SendCapabilityMsg).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    processModeManager.capabilityMgr_.SetStartCpStatus(true);
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 1U;
    auto ret = processModeManager.CapabilityGet(type, ptrRes);
    EXPECT_EQ(ret, TSD_OK);

    processModeManager.capabilityMgr_.tsdSupportLevel_ = 0U;
    ret = processModeManager.CapabilityGet(type, ptrRes);
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, Close_InitializedCommunication_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::SendCloseMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    const auto ret = processModeManager.Close(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessModeManagerTest, IsSupportCommonInterface_CapabilitySendFails_ReturnsFalse)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 0;
    MOCKER_CPP(&DeviceCommAgent::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&CapabilityManager::SendCapabilityMsg)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.capabilityMgr_.IsSupportCommonInterface(0);
    EXPECT_EQ(ret, false);
}

TEST_F(ProcessModeManagerTest, ParseModuleLogLevel_ValidAndInvalidEntries_StoresValidLevels)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    std::string envModuleLogLevel = "CCECPU=1";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    envModuleLogLevel = "CCECPU=1:AICPU";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    envModuleLogLevel = "CCECPU";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    envModuleLogLevel = "CCECPU=1:AICPU=1";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    EXPECT_EQ(processModeManager.ccecpuLogLevel_, "1");
    EXPECT_EQ(processModeManager.aicpuLogLevel_, "1");
    envModuleLogLevel = "CCECPU=a";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
}

TEST_F(ProcessModeManagerTest, GetHdcConctStatus_AdcEnvironmentWithoutClient_ReturnsConnected)
{
    int32_t hdcSessStat;
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.commAgent_.devCommClient_ = nullptr;
    processModeManager.sharedCtx_.isAdcEnv = true;
    processModeManager.GetHdcConctStatus(hdcSessStat);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CONNECT);
}

TEST_F(ProcessModeManagerTest, GetHdcConctStatus_NonAdcWithoutClient_ReturnsClosed)
{
    int32_t hdcSessStat;
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.commAgent_.devCommClient_ = nullptr;
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(false));
    processModeManager.GetHdcConctStatus(hdcSessStat);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CLOSE);
}

TEST_F(ProcessModeManagerTest, OpenNetService_ClientInitFails_ReturnsNotSupported)
{
    ProcessModeManager processModeManager(0U, 0);
    MOCKER_CPP(&TsdProcessController::InitTsdClient)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    EXPECT_EQ(processModeManager.OpenNetService(nullptr), 201U);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, OpenNetService_ValidArgs_ReturnsOk)
{
    ProcessModeManager processModeManager(0U, 0);
    (void)InjectStubComm(processModeManager, 0U);
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    EXPECT_EQ(processModeManager.OpenNetService(&args), 0U);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, OpenNetService_NullArgs_ReturnsError)
{
    ProcessModeManager processModeManager(0U, 0);
    (void)InjectStubComm(processModeManager, 0U);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    EXPECT_EQ(processModeManager.OpenNetService(nullptr), TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, CloseNetService_StartedHccp_ReturnsOk)
{
    ProcessModeManager processModeManager(0U, 0);
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    (void)InjectStubComm(processModeManager, 0U);
    processModeManager.tsdCtrl_.hccpPid_ = 123;
    EXPECT_EQ(processModeManager.CloseNetService(), tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessModeManagerTest, Destroy_CallsReleaseDeviceConnection)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectStubComm(processModeManager, deviceId);

    processModeManager.Destroy();

    EXPECT_EQ(processModeManager.commAgent_.devCommClient_, nullptr);
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    EXPECT_EQ(stub->destroyCount_, 1);
}
