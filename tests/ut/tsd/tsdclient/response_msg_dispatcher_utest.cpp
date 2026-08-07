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
#define private public
#define protected public
#include "inc/process_mode_manager.h"
#include <array>
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
static const int deviceId = 0;
} // namespace

class ResponseMsgDispatcherTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        savedRunningMode_ = ClientManager::g_runningMode;
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
        cout << "Before ResponseMsgDispatcherTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After ResponseMsgDispatcherTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            ClientManager::g_runningMode = savedRunningMode_;
            throw;
        }
        GlobalMockObject::reset();
        ClientManager::g_runningMode = savedRunningMode_;
    }

    RunningMode savedRunningMode_ = RunningMode::UNSET_MODE;
};

TEST_F(ResponseMsgDispatcherTest, DeviceMsgProcess_CapabilitySuccess_UpdatesCapabilityAndResponseState)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    msg.set_tsd_rsp_code(0U);
    msg.set_capability_level(9U);
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);

    processModeManager.GetDispatcher().DeviceMsgProcess(msg);

    EXPECT_EQ(processModeManager.sharedCtx_.rspCode, ResponseCode::SUCCESS);
    EXPECT_EQ(processModeManager.capabilityMgr_.GetTsdSupportLevel(), 9U);
    EXPECT_EQ(processModeManager.sharedCtx_.openSubPid, 0U);
}

TEST_F(ResponseMsgDispatcherTest, DeviceMsgProcess_OpenSubProcessResponse_UpdatesOnlyPidAndErrorFields)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.capabilityMgr_.SetTsdSupportLevel(7U);
    HDCMessage msg;
    msg.set_tsd_rsp_code(1U);
    msg.set_helper_sub_pid(4321U);
    msg.set_type(HDCMessage::TSD_OPEN_SUB_PROC_RSP);
    ErrInfo* const errorInfo = msg.mutable_error_info();
    errorInfo->set_error_code("E30004");
    errorInfo->set_message("open failed");
    errorInfo->set_error_log("device log");

    processModeManager.GetDispatcher().DeviceMsgProcess(msg);

    EXPECT_EQ(processModeManager.sharedCtx_.rspCode, ResponseCode::FAIL);
    EXPECT_EQ(processModeManager.sharedCtx_.openSubPid, 4321U);
    EXPECT_EQ(processModeManager.sharedCtx_.startOrStopFailCode, "E30004");
    EXPECT_EQ(processModeManager.sharedCtx_.errMsg, "open failed");
    EXPECT_EQ(processModeManager.sharedCtx_.errorLog, "device log");
    EXPECT_EQ(processModeManager.capabilityMgr_.GetTsdSupportLevel(), 7U);
}

TEST_F(ResponseMsgDispatcherTest, DeviceMsgProcess_StatusListResponse_MapsPidAndStatusInOrder)
{
    ProcessModeManager processModeManager(deviceId, 0);
    std::array<ProcStatusInfo, 2U> statuses{};
    processModeManager.sharedCtx_.pidArry = statuses.data();
    processModeManager.sharedCtx_.pidArryLen = statuses.size();
    processModeManager.sharedCtx_.openSubPid = 99U;
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    auto* first = msg.add_sub_proc_status_list();
    first->set_sub_proc_pid(101U);
    first->set_proc_status(SUB_PROCESS_STATUS_NORMAL);
    auto* second = msg.add_sub_proc_status_list();
    second->set_sub_proc_pid(202U);
    second->set_proc_status(SUB_PROCESS_STATUS_EXITED);

    processModeManager.GetDispatcher().DeviceMsgProcess(msg);

    EXPECT_EQ(statuses[0].pid, 101);
    EXPECT_EQ(statuses[0].curStat, SUB_PROCESS_STATUS_NORMAL);
    EXPECT_EQ(statuses[1].pid, 202);
    EXPECT_EQ(statuses[1].curStat, SUB_PROCESS_STATUS_EXITED);
    EXPECT_EQ(processModeManager.sharedCtx_.openSubPid, 99U);
}

TEST_F(ResponseMsgDispatcherTest, DeviceMsgProcess_PackageHashResponse_StoresPackageWithoutChangingCapability)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.capabilityMgr_.SetTsdSupportLevel(5U);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    auto* hash = msg.add_package_hash_code_list();
    hash->set_package_name("pkg.tar.gz");
    hash->set_hash_code("abc123");

    processModeManager.GetDispatcher().DeviceMsgProcess(msg);

    EXPECT_EQ(processModeManager.packageMgr_.hashStore_.GetDeviceCommonSinkPackHashValue("pkg.tar.gz"), "abc123");
    EXPECT_EQ(processModeManager.capabilityMgr_.GetTsdSupportLevel(), 5U);
    EXPECT_EQ(processModeManager.sharedCtx_.openSubPid, 0U);
}

TEST_F(ResponseMsgDispatcherTest, PidQosMsgProc_FailureResponse_DoesNotUpdateCapability)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.capabilityMgr_.pidQos_ = 42;
    HDCMessage msg;
    msg.set_tsd_rsp_code(1U);
    msg.set_pid_of_qos(100U);

    processModeManager.GetDispatcher().PidQosMsgProc(msg);

    EXPECT_EQ(processModeManager.sharedCtx_.rspCode, ResponseCode::FAIL);
    EXPECT_EQ(processModeManager.capabilityMgr_.pidQos_, 42);
}
