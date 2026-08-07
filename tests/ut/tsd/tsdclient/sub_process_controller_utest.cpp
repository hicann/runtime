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
#include "tsd/status.h"
#define private public
#define protected public
#include "inc/process_mode_manager.h"
#include "device_comm.h"
#include "tsd_hdc_client.h"
#include <array>
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
static const int deviceId = 0;
constexpr int32_t PROCESS_MODE = 0;
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
    tsd::TSD_StatusT CommSendMsg(const uint32_t, const HDCMessage& msg) override
    {
        sentMessages_.push_back(msg);
        const size_t index = sentMessages_.size() - 1U;
        return (index < sendResults_.size()) ? sendResults_[index] : commSendMsgRet_;
    }
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
    std::vector<HDCMessage> sentMessages_;
    std::vector<tsd::TSD_StatusT> sendResults_;
    std::shared_ptr<tsd::VersionVerify> inspector_;
};

inline std::shared_ptr<StubDeviceComm> InjectStubComm(tsd::ProcessModeManager& pm, uint32_t devId)
{
    auto stub = std::make_shared<StubDeviceComm>(devId);
    pm.commAgent_.devCommClient_ = stub;
    return stub;
}
} // namespace

class SubProcessControllerTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        savedRunningMode_ = ClientManager::g_runningMode;
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
        cout << "Before SubProcessControllerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After SubProcessControllerTest" << endl;
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

TEST_F(SubProcessControllerTest, ConstructCommonOpenMsg_CommonParamSetupFails_ReturnsInternalError)
{
    MOCKER_CPP(&SubProcessController::SetCommonOpenParamList).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    auto ret = processModeManager.GetSubProcessController().ConstructCommonOpenMsg(hdcMsg, &procArgs);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(SubProcessControllerTest, SetCommonOpenParamList_EnvCountExceedsLimit_ReturnsFalse)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MessageContext ctx{};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 200UL;
    auto ret = processModeManager.GetSubProcessController().SetCommonOpenParamList(ctx, &procArgs);
    EXPECT_EQ(ret, false);
    GlobalMockObject::verify();
}

TEST_F(SubProcessControllerTest, OpenSubProc_UdfWithoutCommonInterface_ReturnsError)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_UDF;
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcessController().OpenSubProc(&openArg);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, OpenSubProc_BuiltinUdfWithoutCommonInterface_ReturnsError)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_BUILTIN_UDF;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcessController().OpenSubProc(&openArg);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, OpenSubProc_AdprofWithoutCommonInterface_ReturnsError)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_ADPROF;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcessController().OpenSubProc(&openArg);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, OpenAndCloseHccp_LegacyCloseList_ReturnsOk)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_HCCP;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&SubProcessController::SendCommonOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.sharedCtx_.openSubPid = curPid;
    auto ret = processModeManager.GetSubProcessController().OpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_HCCP;
    closeList[0].pid = curPid;
    uint32_t listSize = 1U;
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 4U;
    ret = processModeManager.GetSubProcessController().CloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    processModeManager.Destroy();
}

TEST_F(SubProcessControllerTest, OpenAndCloseHccp_CommonInterface_ReturnsOk)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_HCCP;
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&SubProcessController::SendCommonOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.sharedCtx_.openSubPid = curPid;
    auto ret = processModeManager.GetSubProcessController().OpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    ret = processModeManager.GetSubProcessController().CloseSubProc(curPid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, CloseSubProcList_FiftyOneEntries_Sends50Plus1Batches)
{
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    auto comm = InjectStubComm(processModeManager, deviceId);
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 4U;
    std::array<ProcStatusParam, 51U> closeList{};
    for (size_t i = 0; i < closeList.size(); ++i) {
        closeList[i].pid = static_cast<pid_t>(1000U + i);
        closeList[i].procType = (i % 2U == 0U) ? TSD_SUB_PROC_HCCP : TSD_SUB_PROC_UDF;
    }

    EXPECT_EQ(
        processModeManager.GetSubProcessController().CloseSubProcList(closeList.data(), closeList.size()), TSD_OK);
    ASSERT_EQ(comm->sentMessages_.size(), 2U);
    EXPECT_EQ(comm->sentMessages_[0].type(), HDCMessage::TSD_CLOSE_SUB_PROC_LIST);
    EXPECT_EQ(comm->sentMessages_[0].close_sub_list_size(), 50);
    EXPECT_EQ(comm->sentMessages_[0].close_sub_list(0).sub_proc_pid(), 1000U);
    EXPECT_EQ(comm->sentMessages_[0].close_sub_list(49).sub_proc_pid(), 1049U);
    EXPECT_EQ(comm->sentMessages_[0].sub_proc_type_list(0), TSD_SUB_PROC_HCCP);
    EXPECT_EQ(comm->sentMessages_[0].sub_proc_type_list(49), TSD_SUB_PROC_UDF);
    EXPECT_EQ(comm->sentMessages_[1].close_sub_list_size(), 1);
    EXPECT_EQ(comm->sentMessages_[1].close_sub_list(0).sub_proc_pid(), 1050U);
    EXPECT_EQ(comm->sentMessages_[1].sub_proc_type_list(0), TSD_SUB_PROC_HCCP);
}

TEST_F(SubProcessControllerTest, CloseSubProcList_FiftyOneEntries_Second50Plus1BatchFails)
{
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    auto comm = InjectStubComm(processModeManager, deviceId);
    comm->sendResults_ = {TSD_OK, TSD_INTERNAL_ERROR};
    processModeManager.capabilityMgr_.tsdSupportLevel_ = 4U;
    std::array<ProcStatusParam, 51U> closeList{};
    for (size_t i = 0; i < closeList.size(); ++i) {
        closeList[i].pid = static_cast<pid_t>(2000U + i);
        closeList[i].procType = TSD_SUB_PROC_HCCP;
    }

    EXPECT_EQ(
        processModeManager.GetSubProcessController().CloseSubProcList(closeList.data(), closeList.size()),
        TSD_INTERNAL_ERROR);
    ASSERT_EQ(comm->sentMessages_.size(), 2U);
    EXPECT_EQ(comm->sentMessages_[0].close_sub_list_size(), 50);
    EXPECT_EQ(comm->sentMessages_[1].close_sub_list_size(), 1);
    EXPECT_EQ(comm->sentMessages_[1].close_sub_list(0).sub_proc_pid(), 2050U);
}

TEST_F(SubProcessControllerTest, CloseSubProc_CommonInterfaceUnsupported_ReturnsError)
{
    pid_t pid = 0;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcessController().CloseSubProc(pid);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, GetSubProcStatus_CommonInterfaceUnsupported_ReturnsError)
{
    ProcStatusInfo info;
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcessController().GetSubProcStatus(&info, 1U);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, RemoveFileOnDevice_CommonInterfaceUnsupported_ReturnsError)
{
    const char_t* filePath = "";
    MOCKER(tsd::CheckValidatePath).stubs().will(returnValue(true));
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcessController().RemoveFileOnDevice(filePath, 1U);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, GetSubProcListStatus_CommonInterfaceSupported_ReturnsOk)
{
    MOCKER_CPP(&CapabilityManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcStatusParam pidInfo;
    pidInfo.procType = TSD_SUB_PROC_COMPUTE;
    auto ret = processModeManager.GetSubProcessController().GetSubProcListStatus(&pidInfo, 1U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(SubProcessControllerTest, ConstructCommonOpenMsg_HccpWithoutOptionalParams_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::InitTsdClient)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    procArgs.procType = SubProcType::TSD_SUB_PROC_HCCP;
    procArgs.envParaList = nullptr;
    procArgs.envCnt = 0UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    pid_t subpid = 0;
    procArgs.subPid = &subpid;
    const auto ret = processModeManager.GetSubProcessController().ConstructCommonOpenMsg(hdcMsg, &procArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(SubProcessControllerTest, SetCommonOpenParamList_UdfEnvironment_StoresEntry)
{
    ProcessModeManager processModeManager(deviceId, 0);
    ProcOpenArgs procArgs;
    procArgs.envCnt = 1UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    procArgs.subPid = nullptr;
    std::string testEnv = "TESTENV";
    std::string testEnvValue = "TESTTESTUDF";
    ProcEnvParam envParaList;
    envParaList.envName = testEnv.c_str();
    envParaList.nameLen = testEnv.size();
    envParaList.envValue = testEnvValue.c_str();
    envParaList.valueLen = testEnvValue.size();
    procArgs.envParaList = &envParaList;
    procArgs.procType = SubProcType::TSD_SUB_PROC_UDF;
    MessageContext ctx{};
    auto ret = processModeManager.GetSubProcessController().SetCommonOpenParamList(ctx, &procArgs);
    EXPECT_EQ(ctx.subProcOpenType, static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_UDF));
    EXPECT_EQ(ctx.subProcEnvList.size(), 1UL);
    EXPECT_EQ(ctx.subProcEnvList[0].first, testEnv);
    EXPECT_EQ(ctx.subProcEnvList[0].second, testEnvValue);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

TEST_F(SubProcessControllerTest, SetCommonOpenParamList_BuiltinUdfEnvironment_StoresEntry)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MessageContext ctx{};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 1UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    procArgs.subPid = nullptr;
    std::string testEnv = "TESTENV";
    std::string testEnvValue = "TESTTESTBUILTINUDF";
    ProcEnvParam envParaList;
    envParaList.envName = testEnv.c_str();
    envParaList.nameLen = testEnv.size();
    envParaList.envValue = testEnvValue.c_str();
    envParaList.valueLen = testEnvValue.size();
    procArgs.envParaList = &envParaList;
    procArgs.procType = SubProcType::TSD_SUB_PROC_BUILTIN_UDF;
    auto ret = processModeManager.GetSubProcessController().SetCommonOpenParamList(ctx, &procArgs);
    EXPECT_EQ(ctx.subProcOpenType, static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_BUILTIN_UDF));
    EXPECT_EQ(ctx.subProcEnvList.size(), 1UL);
    EXPECT_EQ(ctx.subProcEnvList[0].first, testEnv);
    EXPECT_EQ(ctx.subProcEnvList[0].second, testEnvValue);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

TEST_F(SubProcessControllerTest, SetCommonOpenParamList_HccpEnvironment_IgnoresEntry)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MessageContext ctx{};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 1UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    procArgs.subPid = nullptr;
    std::string testEnv = "TESTENV";
    std::string testEnvValue = "TESTTESTHCCP";
    ProcEnvParam envParaList;
    envParaList.envName = testEnv.c_str();
    envParaList.nameLen = testEnv.size();
    envParaList.envValue = testEnvValue.c_str();
    envParaList.valueLen = testEnvValue.size();
    procArgs.envParaList = &envParaList;
    procArgs.procType = SubProcType::TSD_SUB_PROC_HCCP;
    auto ret = processModeManager.GetSubProcessController().SetCommonOpenParamList(ctx, &procArgs);
    EXPECT_EQ(ctx.subProcOpenType, static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP));
    EXPECT_EQ(ctx.subProcEnvList.size(), 0UL);
    EXPECT_EQ(ret, true);
}
