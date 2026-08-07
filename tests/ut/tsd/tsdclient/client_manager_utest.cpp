/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "tsd/status.h"

#define private public
#define protected public
#include "inc/client_manager.h"
#include "inc/process_mode_manager.h"
#undef private
#undef protected
#include "common_util_func.h"
#include <array>
#include <sys/wait.h>
#include <unistd.h>

using namespace tsd;
using namespace std;

namespace {
drvError_t fake_drvGetDevNum(uint32_t* num_dev)
{
    *num_dev = 8;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value)
{
    if ((moduleType == MODULE_TYPE_SYSTEM) && (infoType == INFO_TYPE_VERSION)) {
        *value = CHIP_ASCEND_910A << 8;
    }
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoAscend310P(uint32_t, int32_t, int32_t, int64_t* value)
{
    *value = 1024;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfoSuccess(uint32_t*) { return DRV_ERROR_NONE; }

TSD_StatusT IdentityDeviceId(const uint32_t userDeviceId, uint32_t& logicDeviceId)
{
    logicDeviceId = userDeviceId;
    return TSD_OK;
}

int VerifyVisibleDeviceMappingInChild()
{
    ScopedEnvVar visibleDevicesEnv("ASCEND_RT_VISIBLE_DEVICES");
    (void)setenv("ASCEND_RT_VISIBLE_DEVICES", "4,5,6,7", 1);
    char_t visibleDevices[] = "4,5,6,7";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char_t*>(visibleDevices)));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    int result = ClientManager::GetVisibleDevices() ? 0 : 10;
    constexpr std::array<uint32_t, 4U> expectedLogicIds = {4U, 5U, 6U, 7U};
    for (uint32_t userId = 0U; (userId < expectedLogicIds.size()) && (result == 0); ++userId) {
        uint32_t logicId = UINT32_MAX;
        const auto ret = ClientManager::ChangeUserDeviceIdToLogicDeviceId(userId, logicId);
        result = (ret != TSD_OK) ? static_cast<int>(20U + userId) : result;
        result = ((result == 0) && (logicId != expectedLogicIds[userId])) ? static_cast<int>(30U + userId) : result;
    }
    uint32_t unmapped = 99U;
    result =
        ((result == 0) && ((ClientManager::ChangeUserDeviceIdToLogicDeviceId(4U, unmapped) != TSD_PARAMETER_INVALID) ||
                           (unmapped != 99U))) ?
            40 :
            result;
    uint32_t boundary = 88U;
    result = ((result == 0) &&
              ((ClientManager::ChangeUserDeviceIdToLogicDeviceId(UINT32_MAX, boundary) != TSD_PARAMETER_INVALID) ||
               (boundary != 88U))) ?
                 41 :
                 result;
    try {
        GlobalMockObject::verify();
    } catch (...) {
        result = 90;
    }
    GlobalMockObject::reset();
    return result;
}
} // namespace

TEST(ClientManagerVisibleDeviceIsolationTest, GetVisibleDevices_DeterministicList_MapsAndRejectsInChildProcess)
{
    const pid_t childPid = fork();
    ASSERT_NE(childPid, -1);
    if (childPid == 0) {
        _exit(VerifyVisibleDeviceMappingInChild());
    }
    int childStatus = 0;
    ASSERT_EQ(waitpid(childPid, &childStatus, 0), childPid);
    ASSERT_TRUE(WIFEXITED(childStatus));
    ASSERT_EQ(WEXITSTATUS(childStatus), 0);
}

class ClientManagerTest : public testing::Test {
protected:
    void SetUp() override
    {
        cout << "Before TsdClientTest" << endl;
        ascendAicpuPathEnv_ = std::make_unique<ScopedEnvVar>("ASCEND_AICPU_PATH");
        savedRunningMode_ = ClientManager::g_runningMode;
        savedSchedMode_ = ClientManager::aicpuSchedMode_;
        savedProfilingCallback_ = ClientManager::g_profilingCallback;
        ClientManager::g_runningMode = RunningMode::UNSET_MODE;
        ClientManager::ResetPlatInfoFlag();
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
    }

    void TearDown() override
    {
        cout << "After TsdClientTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreClientState();
            throw;
        }
        GlobalMockObject::reset();
        RestoreClientState();
    }

private:
    void RestoreClientState()
    {
        ClientManager::g_runningMode = savedRunningMode_;
        ClientManager::aicpuSchedMode_ = savedSchedMode_;
        ClientManager::g_profilingCallback = savedProfilingCallback_;
        ClientManager::ResetPlatInfoFlag();
        ascendAicpuPathEnv_.reset();
    }

    std::unique_ptr<ScopedEnvVar> ascendAicpuPathEnv_;
    RunningMode savedRunningMode_ = RunningMode::UNSET_MODE;
    SchedMode savedSchedMode_ = AICPU_SCHED_MODE_INTERRUPT;
    MsprofReporterCallback savedProfilingCallback_ = nullptr;
};

TEST_F(ClientManagerTest, GetPlatInfoMode_NewProcessManager_ReturnsOnlineMode)
{
    auto instance = ClientManager::GetInstance(1000U, 0U, false);
    uint32_t platInfoMode = instance->GetPlatInfoMode();
    EXPECT_EQ(platInfoMode, 1);
}

TEST_F(ClientManagerTest, GetPackageTitle_Ascend310PPlatform_ReturnsAscend310P)
{
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoAscend310P));
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfoSuccess));
    constexpr uint32_t deviceId = 1001U;
    auto client = ClientManager::GetInstance(deviceId, 0U, false);
    ASSERT_NE(client, nullptr);
    EXPECT_EQ(client->GetPlatformInfo(deviceId), TSD_OK);

    std::string packageTitle;
    EXPECT_TRUE(client->GetPackageTitle(packageTitle));
    EXPECT_EQ(packageTitle, "Ascend310P");
}

TEST_F(ClientManagerTest, GetInstance_PlatformInfoQueryFails_ReturnsNull)
{
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(drvGetPlatformInfo).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(1010U, 0U, false));
}

TEST_F(ClientManagerTest, GetInstance_DeviceInfoQueryFails_ReturnsNull)
{
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(1101U, 0U, false));
}

TEST_F(ClientManagerTest, GetInstance_ProcessModeConfigured_ReturnsManager)
{
    std::string valueStr("PROCESS_MODE");
    ClientManager::SetRunMode(valueStr);
    uint32_t runMode = static_cast<uint32_t>(ClientManager::g_runningMode);
    EXPECT_EQ(1, runMode);
    EXPECT_NE(nullptr, ClientManager::GetInstance(1002U, 0U, false));
}

TEST_F(ClientManagerTest, GetInstance_ThreadModeConfigured_ReturnsManager)
{
    std::string valueStr("THREAD_MODE");
    ClientManager::SetRunMode(valueStr);
    uint32_t runMode = static_cast<uint32_t>(ClientManager::g_runningMode);
    EXPECT_EQ(2, runMode);
    EXPECT_NE(nullptr, ClientManager::GetInstance(1003U, 0U, false));
}

TEST_F(ClientManagerTest, GetInstance_InvalidConfiguredModeUsesDetectedProcessMode_ReturnsManager)
{
    std::string valueStr("OTHER_MODE");
    ClientManager::SetRunMode(valueStr);
    uint32_t runMode = static_cast<uint32_t>(ClientManager::g_runningMode);
    EXPECT_EQ(0, runMode);
    MOCKER_CPP(&ClientManager::GetClientRunMode).stubs().will(returnValue(RunningMode::PROCESS_MODE));
    EXPECT_NE(nullptr, ClientManager::GetInstance(1004U, 0U, false));
}

TEST_F(ClientManagerTest, GetInstance_DetectedModeUnset_ReturnsNull)
{
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(static_cast<uint32_t>(0)));
    MOCKER_CPP(&ClientManager::GetClientRunMode).stubs().will(returnValue(RunningMode::UNSET_MODE));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(1105U, 0U, false));
}

TEST_F(ClientManagerTest, GetInstance_VisibleDeviceTranslationFails_ReturnsNull)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(1U));
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(TSD_OK));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(106));
}

TEST_F(ClientManagerTest, GetHdcConctStatus_ThreadMode_ReturnsConnected)
{
    std::string valueStr("THREAD_MODE");
    ClientManager::SetRunMode(valueStr);
    auto client = ClientManager::GetInstance(1555U, 0U, false);
    ASSERT_NE(nullptr, client);
    int32_t hdcSessStat = HDC_SESSION_STATUS_CLOSE;

    EXPECT_EQ(client->GetHdcConctStatus(hdcSessStat), TSD_OK);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CONNECT);
}

TEST_F(ClientManagerTest, GetHdcConctStatus_ProcessModeWithoutClient_ReturnsClosed)
{
    std::string valueStr("PROCESS_MODE");
    ClientManager::SetRunMode(valueStr);
    auto client = ClientManager::GetInstance(1666U, 0U, false);
    ASSERT_NE(nullptr, client);
    int32_t hdcSessStat = HDC_SESSION_STATUS_CONNECT;

    EXPECT_EQ(client->GetHdcConctStatus(hdcSessStat), TSD_OK);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CLOSE);
}

TEST_F(ClientManagerTest, GetClientRunMode_OnlinePlatform_ReturnsProcessMode)
{
    ProcessModeManager processModeManager(0U, 0U);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));
    RunningMode mode = ClientManager::GetClientRunMode(0U);
    EXPECT_EQ(mode, RunningMode::PROCESS_MODE);
}

TEST_F(ClientManagerTest, GetClientRunMode_OfflinePlatform_ReturnsThreadMode)
{
    std::string valueStr("");
    ClientManager::SetRunMode(valueStr);
    ProcessModeManager processModeManager(0, 0);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::OFFLINE));
    RunningMode mode = ClientManager::GetClientRunMode(0U);
    EXPECT_EQ(mode, RunningMode::THREAD_MODE);
}

TEST_F(ClientManagerTest, SplitString_ValidAndInvalidSegments_ReturnsParsedPrefix)
{
    std::vector<std::string> validResult;
    ClientManager::SplitString("1,20,300", validResult);
    EXPECT_EQ(validResult, (std::vector<std::string>{"1", "20", "300"}));

    std::vector<std::string> invalidMiddleResult;
    ClientManager::SplitString("4,bad,6", invalidMiddleResult);
    EXPECT_EQ(invalidMiddleResult, (std::vector<std::string>{"4"}));

    std::vector<std::string> emptyTailResult;
    ClientManager::SplitString("7,", emptyTailResult);
    EXPECT_EQ(emptyTailResult, (std::vector<std::string>{"7"}));
}

TEST_F(ClientManagerTest, GetInstance_IdentityDeviceTranslation_UsesUserDeviceId)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(invoke(IdentityDeviceId));
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&ClientManager::GetClientRunMode).stubs().will(returnValue(RunningMode::PROCESS_MODE));
    constexpr uint32_t userDevId = 98765U;

    auto manager = ClientManager::GetInstance(userDevId);

    ASSERT_NE(manager, nullptr);
    EXPECT_EQ(manager->logicDeviceId_, userDevId);
}

TEST_F(ClientManagerTest, CheckDestructFlag_FirstLookup_ReturnsFalse)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(invoke(IdentityDeviceId));
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(static_cast<uint32_t>(1)));
    uint32_t devId = 0U;
    auto ret = ClientManager::CheckDestructFlag(devId);
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, CheckDestructFlag_TranslationFails_ReturnsFalse)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(static_cast<uint32_t>(0)));
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(1U));
    uint32_t devId = 0U;
    auto ret = ClientManager::CheckDestructFlag(devId);
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, IsSupportSetVisibleDevices_Ascend910A_ReturnsTrue)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1));
    auto ret = ClientManager::GetPlatformInfo(0U);
    EXPECT_EQ(ret, 0);
    auto supRet = ClientManager::IsSupportSetVisibleDevices();
    EXPECT_EQ(supRet, true);
}
