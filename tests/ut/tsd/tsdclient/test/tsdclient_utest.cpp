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
#include "inc/client_manager.h"
#include "tsd/status.h"
#include "inc/hdc_client.h"
#define private public
#define protected public
#include "inc/process_mode_manager.h"
#undef private
#undef protected
#include "stub_log.h"
using namespace tsd;
using namespace std;

class TsdClientTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before TsdClientTest." << endl;
    }

    virtual void TearDown()
    {
        cout << "After TsdClientTest." << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
public:
static const uint32_t deviceId = 0;
};

TEST_F(TsdClientTest, TsdOpen)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    const uint32_t deviceIdChipMode = 3;
    MOCKER_CPP(&HdcClient::Init)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::Destroy)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t,
            const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));

    setenv("AICPU_PROFILING_MODE", "true", 1);

    ret = TsdOpen(deviceId, 0);
    ret = TsdOpenEx(deviceIdChipMode, 0, 1);
    ret = UpdateProfilingMode(deviceId, 0);
    ret = TsdInitQs(deviceId);
    ret = TsdClose(deviceId);

    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(true));

    ret = TsdOpen(deviceId, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdOpenEx(deviceIdChipMode, 0, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdOpenAicpuSd(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdInitQs(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenChipModeFailed01)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&HdcClient::Init)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::Destroy)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t,
            const HDCMessage&, const bool))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    const uint32_t deviceIdChipMode = 4;
    MOCKER(halGetDeviceCountFromChip)
        .stubs()
        .will(returnValue(5));
    ret = TsdOpenEx(deviceIdChipMode, 0, 1);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenChipModeFailed02)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&HdcClient::Init)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs().will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::Destroy)
        .stubs().will(returnValue(tsd::TSD_OK));;

    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t,
            const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmDlopen)
        .stubs().will(returnValue(static_cast<void*>(nullptr)));
    const uint32_t deviceIdChipMode = 5;
    ret = TsdOpenEx(deviceIdChipMode, 0, 1);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenFailed1)
{
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
    tsd::TSD_StatusT ret = TsdOpen(deviceId, 0);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitQsFailed1)
{
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
        const char *groupName = "TestName";
    tsd::TSD_StatusT ret = TsdInitQs(deviceId, groupName);;
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenFailed2)
{
    tsd::TSD_StatusT ret = TsdOpen(deviceId, 0);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenMdc001)
{
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(true));
    tsd::TSD_StatusT ret = TsdOpen(deviceId, 0);
    EXPECT_EQ(ret, tsd::TSD_OPEN_NOT_SUPPORT_FOR_ADC);
}

TEST_F(TsdClientTest, TsdOpenAicpuSd001)
{
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::Init)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    tsd::TSD_StatusT ret = TsdOpenAicpuSd(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdOpenAicpuSd002)
{
    tsd::TSD_StatusT ret = TsdOpenAicpuSd(2U);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdInitQsFailed2)
{
    tsd::TSD_StatusT ret = TsdInitQs(deviceId, nullptr);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCloseNoNeed1)
{
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
    tsd::TSD_StatusT ret = TsdClose(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);

    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(true));
    ret = TsdClose(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdCloseExNotSetQuickTsdCloseFlagSucc) 
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&HdcClient::Init)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
 
    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
 
    MOCKER_CPP(&HdcClient::Destroy)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
 
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t,
            const HDCMessage&, const bool))
        .stubs()
        .will(returnValue(tsd::TSD_OK));;
    
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
 
    setenv("AICPU_PROFILING_MODE", "true", 1);;
 
    ret = TsdOpen(deviceId, 0);
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
    ret = TsdCloseEx(deviceId, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(deviceId);
}
 
TEST_F(TsdClientTest, TsdCloseExSetQuickTsdCloseFlagsucc) 
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&HdcClient::Init)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::Destroy)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
 
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t,
            const HDCMessage&, const bool))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    setenv("AICPU_PROFILING_MODE", "true", 1);
 
    ret = TsdOpen(deviceId, 0);
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
    ret = TsdCloseEx(deviceId, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdClose(deviceId);
}
 
TEST_F(TsdClientTest, TsdCloseExCheckDestructFlag) 
{
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(true));
    tsd::TSD_StatusT ret = TsdCloseEx(deviceId, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);
 
}
 
TEST_F(TsdClientTest, TsdCloseExClientManagerCloseFail) 
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&HdcClient::Init)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
 
    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::Destroy)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t,
            const HDCMessage&, const bool))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    

    setenv("AICPU_PROFILING_MODE", "true", 1);
    ret = TsdOpen(deviceId, 0);
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
    // const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(0);
    MOCKER_CPP(&ProcessModeManager::SendCloseMsg)
        .stubs()
        .will(returnValue(1));
    ret = TsdCloseEx(deviceId, 0);
    EXPECT_NE(ret, tsd::TSD_OK);
 
}

TEST_F(TsdClientTest, UpdateProfilingMode_SUCCESS)
{
    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(false));
    tsd::TSD_StatusT ret = UpdateProfilingMode(deviceId, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);

    MOCKER(&ClientManager::CheckDestructFlag)
        .stubs()
        .will(returnValue(true));
    ret = UpdateProfilingMode(deviceId, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetMsprofReporterCallback)
{
    tsd::TSD_StatusT ret = TsdSetMsprofReporterCallback(nullptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAttr)
{
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdSetAttr("test", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAttr1)
{
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "THREAD_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAtt2)
{
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "OTHER_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, TsdSetAtt3)
{
    tsd::TSD_StatusT ret = TsdSetAttr(nullptr, "");
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, TsdSetAtt4)
{
    tsd::TSD_StatusT ret = TsdSetAttr("Misc", nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(TsdClientTest, TsdSetAttAicpuInterruptMode)
{
    const uint32_t ret = SetAicpuSchedMode(AICPU_SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, 0);
}

TEST_F(TsdClientTest, TsdSetAttAicpuMsgqMode)
{
    const uint32_t ret = SetAicpuSchedMode(AICPU_SCHED_MODE_MSGQ);
    EXPECT_EQ(ret, 0);
}

TEST_F(TsdClientTest, TsdSetAttAicpuUnknownMode)
{
    const uint32_t ret = SetAicpuSchedMode(AICPU_SCHED_MODE_INVALID);
    EXPECT_EQ(ret, 0);
}

TEST_F(TsdClientTest, TsdCapabilityGet_SUCCESS)
{
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    uint64_t ptr = 0;
    tsd::TSD_StatusT ret = TsdCapabilityGet(deviceId, TSD_CAPABILITY_PIDQOS, ptr);
    EXPECT_EQ(ret, tsd::TSD_OK);

    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(true));
    ret = TsdCapabilityGet(deviceId, TSD_CAPABILITY_PIDQOS, ptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, GetHdcConctStatus)
{
    int32_t hdcSessStat;
    tsd::TSD_StatusT ret = GetHdcConctStatus(0, &hdcSessStat);

    ret = GetHdcConctStatus(0, nullptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
    
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(true));
    ret = GetHdcConctStatus(0, &hdcSessStat);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, CapabilityGetFailTest_InputIsNull) {
    MOCKER_CPP(&HdcClient::Init)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::CreateHdcSession)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    setenv("AICPU_PROFILING_MODE", "true", 1);
    TsdOpen(deviceId, 0);
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(0);
    uint64_t ptr = 0;
    const tsd::TSD_StatusT ret = clientManager->CapabilityGet(TSD_CAPABILITY_PIDQOS, ptr);
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(TsdClientTest, TsdCapabilityGetIsFailTest_InputIsNull) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    uint64_t ptr = 0;
    tsd::TSD_StatusT ret = TsdCapabilityGet(deviceId, TSD_CAPABILITY_BUT + 1, ptr);
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(TsdClientTest, TsdCapabilityGetFailTest_TypeisnotPIDQOS) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    uint64_t ptr = 0;
    tsd::TSD_StatusT ret = TsdCapabilityGet(deviceId, TSD_CAPABILITY_BUT + 1, ptr);
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

const std::string RUNTIME_PKG_NAME_UT = "Ascend-runtime_device-minios.tar.gz";
const std::string DSHAPE_PKG_NAME_UT = "Ascend-opp_rt-minios.aarch64.tar.gz";
TEST_F(TsdClientTest, TsdFileLoadTest_TsdFileLoadSucc) {
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "PROCESS_MODE");
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    MOCKER(&drvHdcGetTrustedBasePath).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(&drvGetProcessSign).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    std::string filepath = "/home";
    std::string filename = "tmp.txt";
    ret = TsdFileLoad(deviceId, filepath.c_str(), filepath.size(), filename.c_str(), filename.size());
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdFileUnLoad(deviceId, filepath.c_str(), filepath.size());
    MOCKER_CPP(&ProcessModeManager::LoadRuntimePkgToDevice).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::LoadDShapePkgToDevice).stubs().will(returnValue(tsd::TSD_OK));
    ret = TsdFileLoad(deviceId, nullptr, 0UL, RUNTIME_PKG_NAME_UT.c_str(), RUNTIME_PKG_NAME_UT.size());
    ret = TsdFileLoad(deviceId, nullptr, 0UL, DSHAPE_PKG_NAME_UT.c_str(), DSHAPE_PKG_NAME_UT.size());
    GlobalMockObject::verify();
}

TEST_F(TsdClientTest, TsdProcessOpenTest_TsdProcessOpenSucc) {
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "PROCESS_MODE");
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcOpenArgs openArgs;
    std::string env1("UDP_PATH");
    std::string ev1value("/home/HwHiAiUser");
    ProcEnvParam envParam;
    envParam.envName = env1.c_str();
    envParam.nameLen = env1.size();
    envParam.envValue = ev1value.c_str();
    envParam.valueLen = ev1value.size();
    openArgs.envParaList = &envParam;
    openArgs.envCnt = 1;
    openArgs.filePath = nullptr;
    openArgs.pathLen = 0;
    std::string extPam("levevl=5");
    ProcExtParam extmm;
    extmm.paramInfo = extPam.c_str();
    extmm.paramLen = extPam.size();
    openArgs.extParamList = &extmm;
    openArgs.extParamCnt = 1;
    pid_t subpid = 0;
    openArgs.subPid = &subpid;
    openArgs.procType = TSD_SUB_PROC_NPU;
    std::string filepathprefix = "/home";
    openArgs.filePath = filepathprefix.c_str();
    openArgs.pathLen = filepathprefix.length();
    ret = TsdProcessOpen(deviceId, &openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessOpen(deviceId, nullptr);
    EXPECT_NE(ret, tsd::TSD_OK);
    openArgs.subPid = nullptr;
    ret = TsdProcessOpen(deviceId, &openArgs);
    EXPECT_NE(ret, tsd::TSD_OK);
    ret = TsdProcessClose(deviceId, 0);
    EXPECT_NE(ret, tsd::TSD_OK);
    ret = TsdProcessClose(deviceId, 123456U);
    ProcStatusInfo pidArry;
    ret = TsdGetProcStatus(deviceId, &pidArry, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}


TEST_F(TsdClientTest, HelperTest_checkdestruct) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(true));
    auto ret = TsdFileLoad(0, 0, 0, 0, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessOpen(0, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdProcessClose(0, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdFileUnLoad(0, 0, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = TsdGetProcStatus(0, 0, 0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(TsdClientTest, HelperTest_CheckProcessSuccess) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(true));
    tsd::TSD_StatusT ret = ProcessCloseSubProcList(0U, nullptr, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);

    ret = TsdGetProcListStatus(0U, nullptr, 0U);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdClientTest, HelperTest_checkprocessfail) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "PROCESS_MODE");

    ret = TsdFileLoad(0, 0, 0, 0, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = TsdProcessOpen(0, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = TsdProcessClose(0, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = TsdFileUnLoad(0, 0, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = TsdGetProcStatus(0, 0, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = NotifyPmToStartTsdaemon(0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = ProcessCloseSubProcList(0U, nullptr, 0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = TsdGetProcListStatus(0U, nullptr, 0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    GlobalMockObject::verify();
}
int32_t g_addr = 0;
void *dlopenFakeStub(const char *filename, int flags)
{
    return &g_addr;
}
int dlcloseFakeStub(void *handle)
{
    return 0;
}
int32_t FakeStartStub(const char *appName, const size_t nameLen, const int32_t timeout)
{
    return 0;
}
void *dlsymFakeStub(void *handle, const char *symbol)
{
    return reinterpret_cast<void*>(FakeStartStub);
}

TEST_F(TsdClientTest, NotifyPmToStartTsdaemon) {
    MOCKER_CPP(&dlopen).stubs().will(invoke(dlopenFakeStub));
    MOCKER_CPP(&dlclose).stubs().will(invoke(dlcloseFakeStub));
    MOCKER_CPP(&dlsym).stubs().will(invoke(dlsymFakeStub));
    tsd::TSD_StatusT ret = TsdSetAttr("RunMode", "PROCESS_MODE");
    EXPECT_EQ(ret, tsd::TSD_OK);
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    auto result = NotifyPmToStartTsdaemon(0U);

    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(true));
    result = NotifyPmToStartTsdaemon(0U);
    EXPECT_EQ(result, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(TsdClientTest, TsdOpenNetService_01) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    auto result = TsdOpenNetService(0U, &args);
    EXPECT_EQ(result, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(TsdClientTest, TsdOpenNetService_02) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(true));
    NetServiceOpenArgs args;
    args.extParamCnt = 1U;
    ProcExtParam extParamList;
    std::string extPam("levevl=5");
    extParamList.paramLen = extPam.size();
    extParamList.paramInfo = extPam.c_str();
    args.extParamList = &extParamList;
    auto result = TsdOpenNetService(0U, &args);
    EXPECT_EQ(result, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(TsdClientTest, TsdCloseNetService_01) {
    MOCKER_CPP(&tsd::ClientManager::CheckDestructFlag).stubs().will(returnValue(false));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    auto result = TsdCloseNetService(0U);
    EXPECT_EQ(result, tsd::TSD_OK);
    GlobalMockObject::verify();
}