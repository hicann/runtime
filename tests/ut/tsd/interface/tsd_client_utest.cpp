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
#include "tsd/tsd_client.h"
#include "tsd/status.h"
#define private public
#define protected public
#include "inc/client_manager.h"
#include "inc/process_mode_manager.h"
#include "tsd_hdc_client.h"
#undef private
#undef protected
#include "stub_server_reply.h"
#include "stub_server_msg_proc_def.h"
#include "common_util_func.h"
#include <memory>

using namespace tsd;
using namespace std;

namespace {
TSD_StatusT IdentityDeviceId(const uint32_t userDeviceId, uint32_t& logicDeviceId)
{
    logicDeviceId = userDeviceId;
    return TSD_OK;
}

void InitProcOpenArgs(
    ProcOpenArgs& args, ProcEnvParam& env, ProcExtParam& ext, pid_t& pid, const SubProcType type,
    const std::string& envName, const std::string& envValue, const std::string& extValue, const std::string& path)
{
    env = {envName.c_str(), envName.size(), envValue.c_str(), envValue.size()};
    ext = {extValue.c_str(), extValue.size()};
    args.envParaList = &env;
    args.envCnt = 1UL;
    args.extParamList = &ext;
    args.extParamCnt = 1UL;
    args.subPid = &pid;
    args.procType = type;
    args.filePath = path.c_str();
    args.pathLen = path.size();
}
} // namespace

class TsdClientTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before TsdClientTest." << endl;
        runModeEnv_ = std::make_unique<ScopedEnvVar>("RUN_MODE");
        savedRunningMode_ = ClientManager::g_runningMode;
        savedSchedMode_ = ClientManager::aicpuSchedMode_;
        savedProfilingCallback_ = ClientManager::g_profilingCallback;
        savedDeviceCommMap_ = *DeviceComm::DeviceCommMap();
        serverReplyState_ = StubServerReply::GetInstance()->SaveState();
        ClientManager::SetRunMode("PROCESS_MODE");
        ClientManager::ResetPlatInfoFlag();
        manager_ = std::make_shared<ProcessModeManager>(0U, 0U);
        ASSERT_NE(manager_, nullptr);
        RegisterFixtureMocks(false);
        DeviceComm::DeviceCommMap()->clear();
        manager_->commAgent_.devCommClient_.reset();
        manager_->commAgent_.tsdSessionId_ = 0U;

        StubServerReply::GetInstance()->ResetServerReply();
        setenv("RUN_MODE", "PROCESS", 1);
    }

    virtual void TearDown()
    {
        cout << "After TsdClientTest." << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreFixtureState();
            throw;
        }
        GlobalMockObject::reset();
        RestoreFixtureState();
    }

    std::unique_ptr<ScopedEnvVar> runModeEnv_;
    RunningMode savedRunningMode_ = RunningMode::UNSET_MODE;
    SchedMode savedSchedMode_ = AICPU_SCHED_MODE_INTERRUPT;
    MsprofReporterCallback savedProfilingCallback_ = nullptr;
    std::shared_ptr<ProcessModeManager> manager_;
    std::map<uint64_t, std::shared_ptr<DeviceComm>> savedDeviceCommMap_;
    StubServerReply::State serverReplyState_;

    void SetDestructFlag(const bool value)
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        RegisterFixtureMocks(value);
    }

    void RegisterFixtureMocks(const bool destructFlag)
    {
        MOCKER_CPP(&ClientManager::GetInstance)
            .stubs()
            .will(returnValue(std::static_pointer_cast<ClientManager>(manager_)));
        MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(invoke(IdentityDeviceId));
        MOCKER_CPP(&ClientManager::CheckDestructFlag).stubs().will(returnValue(destructFlag));
    }

    void RestoreFixtureState()
    {
        if (manager_ != nullptr) {
            manager_->commAgent_.devCommClient_.reset();
            manager_.reset();
        }
        DeviceComm::DeviceCommMap()->clear();
        *DeviceComm::DeviceCommMap() = savedDeviceCommMap_;
        StubServerReply::GetInstance()->RestoreState(serverReplyState_);
        ClientManager::g_runningMode = savedRunningMode_;
        ClientManager::aicpuSchedMode_ = savedSchedMode_;
        ClientManager::g_profilingCallback = savedProfilingCallback_;
        ClientManager::ResetPlatInfoFlag();
        runModeEnv_.reset();
    }
};

TEST_F(TsdClientTest, TsdOpenAndClose_RankSizeZero_ReturnOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenAndClose_RankSizeTwo_ReturnOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenExAndClose_RankSizeZeroDieMode_ReturnOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 0U, static_cast<uint32_t>(tsd::DeviceRunMode::DIE_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenExAndClose_RankSizeTwoDieMode_ReturnOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 2U, static_cast<uint32_t>(tsd::DeviceRunMode::DIE_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenExAndClose_RankSizeZeroChipMode_ReturnOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    // TsdOpenEx使用CHIP_MODE的接口已经不建议使用，在日落计划中。
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 0U, static_cast<uint32_t>(tsd::DeviceRunMode::CHIP_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenExAndClose_RankSizeTwoChipMode_ReturnOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    // TsdOpenEx使用CHIP_MODE的接口已经不建议使用，在日落计划中。
    tsd::TSD_StatusT ret = TsdOpenEx(0U, 2U, static_cast<uint32_t>(tsd::DeviceRunMode::CHIP_MODE));
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenAicpuSd_DefaultProcessMode_OpensAndCloses)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpenAicpuSd(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, UpdateProfilingMode_AfterOpen_UpdatesAndCloses)
{
    StubServerMsgProcDef::RegisterUpdateProfilingModeMsgDefaultCallBack();
    // 使用updateprofilingmode 接口需要先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = UpdateProfilingMode(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetMsprofReporterCallback_NullThenValid_UpdatesStoredCallback)
{
    tsd::TSD_StatusT ret = TsdSetMsprofReporterCallback(nullptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(ClientManager::g_profilingCallback, nullptr);
    ret = TsdSetMsprofReporterCallback(&StubServerMsgImpl::StubMsProfReportCallBack);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(ClientManager::g_profilingCallback, &StubServerMsgImpl::StubMsProfReportCallBack);
}

TEST_F(TsdClientTest, TsdInitQs_DefaultGroup_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdInitQsMsgDefaultCallBack();
    const std::string dfGrp = "default_group";
    tsd::TSD_StatusT ret = TsdInitQs(0U, dfGrp.c_str());
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitFlowGw_ValidArgs_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdInitQsMsgDefaultCallBack();
    const std::string argGrp = "args_group";
    InitFlowGwInfo startArgs;
    startArgs.groupName = argGrp.c_str();
    startArgs.schedPolicy = 0UL;
    startArgs.reschedInterval = 0UL;
    tsd::TSD_StatusT ret = TsdInitFlowGw(0U, &startArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, GetHdcConctStatus_AfterOpen_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    // GetHdcConctStatus 接口需要先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    int32_t curStat = 0;
    ret = GetHdcConctStatus(0U, &curStat);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAttr_KnownAndUnknownKeys_ReturnOk)
{
    // TsdSetAttr 接口已经在日落计划中，已经不建议外部使用
    tsd::TSD_StatusT ret = TsdSetAttr("SetTest", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdSetAttr("test", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, SetAicpuSchedMode_InterruptMode_ReturnsOk)
{
    // SetAicpuSchedMode 接口已经在日落计划中，已经不建议外部使用
    const tsd::TSD_StatusT ret = SetAicpuSchedMode(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_PidQos_StoresDeviceValue)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetPidQosMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取PidQos需要先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint8_t pidQos = 0;
    uint64_t pidQosPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&pidQos));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_PIDQOS, pidQosPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(pidQos, 1);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_OmInnerDec_StoresSupported)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetOmInnerDecMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取Support OM inner先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t supportOmInner = 0UL;
    uint64_t omInnerPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&supportOmInner));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_OM_INNER_DEC, omInnerPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(supportOmInner, 1UL);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_BuiltInUdf_StoresSupported)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetCapabilityLevelMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取Support built in udf先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t supportBuiltInUdf = 0UL;
    uint64_t builtinUdfPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&supportBuiltInUdf));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_BUILTIN_UDF, builtinUdfPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(supportBuiltInUdf, 1UL);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_MultipleHccp_StoresSupported)
{
    // TsdCapabilityGet 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterGetCapabilityLevelMsgDefaultCallBack();
    // 使用TsdCapabilityGet 接口获取Support mutiple hccp先调用TsdOpen设置运行上下文
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    uint64_t supportMulHccp = 0UL;
    uint64_t mulHccpPtrValue = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&supportMulHccp));
    ret = TsdCapabilityGet(0U, TSD_CAPABILITY_MUTIPLE_HCCP, mulHccpPtrValue);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(supportMulHccp, 1UL);
    ret = TsdClose(0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdFileLoadAndUnload_RuntimePackage_ReturnOk)
{
    // TsdFileLoad 及 TsdFileUnLoad 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack();
    const std::string runtimePkgName = "Ascend-runtime_device-minios.tar.gz";
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    ScopedTempDir tempDir;
    ASSERT_TRUE(tempDir.IsValid());
    ASSERT_TRUE(tempDir.WriteFile(runtimePkgName));
    const std::string& filepath = tempDir.Path();
    tsd::TSD_StatusT ret =
        TsdFileLoad(0U, filepath.c_str(), filepath.size(), runtimePkgName.c_str(), runtimePkgName.size());
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdFileUnLoad(0U, filepath.c_str(), filepath.size());
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdFileLoadAndUnload_DshapePackage_ReturnOk)
{
    // TsdFileLoad 及 TsdFileUnLoad 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack();
    const std::string dShapePkgName = "Ascend-opp_rt-minios.aarch64.tar.gz";
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    ScopedTempDir tempDir;
    ASSERT_TRUE(tempDir.IsValid());
    ASSERT_TRUE(tempDir.WriteFile(dShapePkgName));
    const std::string& filepath = tempDir.Path();
    tsd::TSD_StatusT ret =
        TsdFileLoad(0U, filepath.c_str(), filepath.size(), dShapePkgName.c_str(), dShapePkgName.size());
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdFileUnLoad(0U, filepath.c_str(), filepath.size());
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessOpenQueryClose_ValidUdf_MapsStatusAndReturnsOk)
{
    // TsdProcessOpen TsdGetProcStatus TsdProcessClose接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgs;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgs.envParaList = &envParam;
    openArgs.envCnt = 1UL;
    std::string extPam("levevl=5");
    ProcExtParam extmm;
    extmm.paramInfo = extPam.c_str();
    extmm.paramLen = extPam.size();
    openArgs.extParamList = &extmm;
    openArgs.extParamCnt = 1;
    pid_t subpid = 0;
    openArgs.subPid = &subpid;
    openArgs.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgs.filePath = filepathprefix.c_str();
    openArgs.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(subpid, getpid());
    ProcStatusInfo curStat{};
    curStat.pid = subpid;
    curStat.curStat = SUB_PROCESS_STATUS_UNKNOW;
    ret = TsdGetProcStatus(0U, &curStat, 1U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(curStat.pid, subpid);
    EXPECT_EQ(curStat.curStat, SUB_PROCESS_STATUS_NORMAL);
    ret = TsdProcessClose(0U, subpid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessListOpenQueryClose_UdfAndNpu_MapsInOrder)
{
    // TsdProcessOpen TsdGetProcListsStatus ProcessCloseSubProcList 接口已经在日落计划中，已经不建议外部使用
    StubServerMsgProcDef::RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack();
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    std::string extPamUdf("levevl=Udf");
    std::string extPamNpu("levevl=Npu");
    std::string filepathprefix = "/home";
    pid_t subPidUdf = 0;
    pid_t subPidNpu = 0;
    ProcOpenArgs openArgsUdf{};
    ProcOpenArgs openArgsNpu{};
    ProcEnvParam envParamUdf{};
    ProcEnvParam envParamNpu{};
    ProcExtParam extmmUdf{};
    ProcExtParam extmmNpu{};
    InitProcOpenArgs(
        openArgsUdf, envParamUdf, extmmUdf, subPidUdf, TSD_SUB_PROC_UDF, envName, envValue, extPamUdf, filepathprefix);
    InitProcOpenArgs(
        openArgsNpu, envParamNpu, extmmNpu, subPidNpu, TSD_SUB_PROC_NPU, envName, envValue, extPamNpu, filepathprefix);
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgsUdf);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(subPidUdf, getpid());

    ret = TsdProcessOpen(0U, &openArgsNpu);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(subPidNpu, getpid());

    ProcStatusParam curStatArray[2U]{};
    curStatArray[0U].pid = subPidUdf;
    curStatArray[0U].procType = TSD_SUB_PROC_UDF;
    curStatArray[0U].curStat = SUB_PROCESS_STATUS_UNKNOW;
    curStatArray[1U].pid = subPidNpu;
    curStatArray[1U].procType = TSD_SUB_PROC_NPU;
    curStatArray[1U].curStat = SUB_PROCESS_STATUS_UNKNOW;
    ret = TsdGetProcListStatus(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_EQ(curStatArray[0U].pid, subPidUdf);
    EXPECT_EQ(curStatArray[0U].procType, TSD_SUB_PROC_UDF);
    EXPECT_EQ(curStatArray[0U].curStat, SUB_PROCESS_STATUS_NORMAL);
    EXPECT_EQ(curStatArray[1U].pid, subPidNpu);
    EXPECT_EQ(curStatArray[1U].procType, TSD_SUB_PROC_NPU);
    EXPECT_EQ(curStatArray[1U].curStat, SUB_PROCESS_STATUS_NORMAL);
    ret = ProcessCloseSubProcList(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenNetService_ValidArgs_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    const tsd::TSD_StatusT result = TsdOpenNetService(0U, &args);
    EXPECT_EQ(result, tsd::TSD_OK);
    EXPECT_NE(TsdCloseNetService(0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, NotifyPmToStartTsdaemon_DeprecatedApi_ReturnsInvalidParameter)
{
    // NotifyPmToStartTsdaemon 接口已经在日落计划中，已经不建议外部使用
    // 直接返回ERROR
    auto result = NotifyPmToStartTsdaemon(0U);
    EXPECT_EQ(result, TSD_PARAMETER_INVALID);
}

TEST_F(TsdClientTest, TsdCloseEx_AfterOpen_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack();
    tsd::TSD_StatusT ret = TsdOpen(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdCloseEx(0U, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessOpen_NullArgs_ReturnsError)
{
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, TsdProcessClose_AfterProcessOpen_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgs;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgs.envParaList = &envParam;
    openArgs.envCnt = 1UL;
    std::string extPam("levevl=5");
    ProcExtParam extmm;
    extmm.paramInfo = extPam.c_str();
    extmm.paramLen = extPam.size();
    openArgs.extParamList = &extmm;
    openArgs.extParamCnt = 1;
    pid_t subpid = 0;
    openArgs.subPid = &subpid;
    openArgs.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgs.filePath = filepathprefix.c_str();
    openArgs.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessClose(0U, subpid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, ProcessCloseSubProcList_AfterTwoProcessesOpen_ReturnsOk)
{
    StubServerMsgProcDef::RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack();
    ProcOpenArgs openArgsUdf;
    std::string envName("UDP_PATH");
    std::string envValue("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = envName.c_str();
    envParam.nameLen = envName.size();
    envParam.envValue = envValue.c_str();
    envParam.valueLen = envValue.size();
    openArgsUdf.envParaList = &envParam;
    openArgsUdf.envCnt = 1UL;
    std::string extPamUdf("levevl=Udf");
    ProcExtParam extmmUdf;
    extmmUdf.paramInfo = extPamUdf.c_str();
    extmmUdf.paramLen = extPamUdf.size();
    openArgsUdf.extParamList = &extmmUdf;
    openArgsUdf.extParamCnt = 1;
    pid_t subPidUdf = 0;
    openArgsUdf.subPid = &subPidUdf;
    openArgsUdf.procType = TSD_SUB_PROC_UDF;
    std::string filepathprefix = "/home";
    openArgsUdf.filePath = filepathprefix.c_str();
    openArgsUdf.pathLen = filepathprefix.length();
    tsd::TSD_StatusT ret = TsdProcessOpen(0U, &openArgsUdf);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcOpenArgs openArgsNpu;
    openArgsNpu.envParaList = &envParam;
    openArgsNpu.envCnt = 1UL;
    std::string extPamNpu("levevl=Npu");
    ProcExtParam extmmNpu;
    extmmNpu.paramInfo = extPamNpu.c_str();
    extmmNpu.paramLen = extPamNpu.size();
    openArgsNpu.extParamList = &extmmNpu;
    openArgsNpu.extParamCnt = 1;
    pid_t subPidNpu = 0;
    openArgsNpu.subPid = &subPidNpu;
    openArgsNpu.procType = TSD_SUB_PROC_NPU;
    openArgsNpu.filePath = filepathprefix.c_str();
    openArgsNpu.pathLen = filepathprefix.length();
    ret = TsdProcessOpen(0U, &openArgsNpu);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ProcStatusParam curStatArray[2U];
    curStatArray[0U].pid = subPidUdf;
    curStatArray[1U].pid = subPidNpu;
    ret = ProcessCloseSubProcList(0U, &(curStatArray[0]), 2U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCloseNetService_AfterOpen_ReturnsUnsupportedClose)
{
    StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack();
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    const tsd::TSD_StatusT result = TsdOpenNetService(0U, &args);
    EXPECT_EQ(result, tsd::TSD_OK);
    const tsd::TSD_StatusT closeResult = TsdCloseNetService(0U);
    EXPECT_NE(closeResult, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpen_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdOpen(0U, 0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenEx_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdOpenEx(0U, 0U, 0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenAicpuSd_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdOpenAicpuSd(0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdClose_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdClose(0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCloseEx_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdCloseEx(0U, 0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, UpdateProfilingMode_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(UpdateProfilingMode(0U, 0U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitFlowGw_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    InitFlowGwInfo info{};
    EXPECT_EQ(TsdInitFlowGw(0U, &info), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitFlowGw_NullArgs_ReturnsError)
{
    EXPECT_EQ(TsdInitFlowGw(0U, nullptr), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, GetHdcConctStatus_NullArg_ReturnOk) { EXPECT_EQ(GetHdcConctStatus(0U, nullptr), tsd::TSD_OK); }

TEST_F(TsdClientTest, GetHdcConctStatus_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    int32_t status = 0;
    EXPECT_EQ(GetHdcConctStatus(0U, &status), tsd::TSD_OK);
    EXPECT_EQ(status, HDC_SESSION_STATUS_CONNECT);
}

TEST_F(TsdClientTest, TsdSetAttr_NullKey_ReturnsError) { EXPECT_EQ(TsdSetAttr(nullptr, "v"), tsd::TSD_INTERNAL_ERROR); }

TEST_F(TsdClientTest, TsdSetAttr_NullValue_ReturnsError)
{
    EXPECT_EQ(TsdSetAttr("k", nullptr), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, TsdSetAttr_RunMode_OK) { EXPECT_EQ(TsdSetAttr("RunMode", "PROCESS"), tsd::TSD_OK); }

TEST_F(TsdClientTest, TsdSetAttr_UnsupportedKey_OK) { EXPECT_EQ(TsdSetAttr("AnyKey", "v"), tsd::TSD_OK); }

TEST_F(TsdClientTest, TsdCapabilityGet_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdCapabilityGet(0U, 0, 0ULL), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCapabilityGet_TypeOutOfRange_ReturnsOpenFailed)
{
    EXPECT_EQ(TsdCapabilityGet(0U, TSD_CAPABILITY_BUT, 0ULL), tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(TsdClientTest, TsdFileLoad_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdFileLoad(0U, "/tmp", 4U, "f", 1U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdFileUnLoad_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdFileUnLoad(0U, "/tmp", 4U), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessOpen_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    ProcOpenArgs args{};
    EXPECT_EQ(TsdProcessOpen(0U, &args), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdProcessClose_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    EXPECT_EQ(TsdProcessClose(0U, 1234), tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdGetProcStatus_DestructFlagTrue_ReturnOk)
{
    SetDestructFlag(true);
    ProcStatusInfo info{};
    EXPECT_EQ(TsdGetProcStatus(0U, &info, 1U), tsd::TSD_OK);
}
