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
#include "inc/client_manager.h"
#include "inc/thread_mode_manager.h"
#include "inc/package_worker.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace
{
// clientManager is a singleton, so a deviceId can only point to one mode in all st
// we define 0 to ProcessMode, and 1 to ThreadMode
static const int deviceId = 1;
}


class ThreadManagerTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        // this must be set, ThreadManager:THREAD, ProcessManager:PROCESS
        //setenv("RUN_MODE", "THREAD", "THREAD");
        std::string valueStr("THREAD_MODE");
        ClientManager::SetRunMode(valueStr);
        cout << "Before ThreadManagerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After ThreadManagerTest" << endl;
        std::string valueStr("THREAD_MODE");
        ClientManager::SetRunMode(valueStr);
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

int32_t *testAdprofStart(int32_t argc, const char *argv)
{
    return 0;
}
int32_t *testAdprofStop()
{
    return 0;
}
VOID *mmDlsymFakeAdprofStart(VOID *handle, const CHAR *funcName)
{
    return reinterpret_cast<void*>(testAdprofStart);
}
VOID *mmDlsymFakeAdprofStop(VOID *handle, const CHAR *funcName)
{
    return reinterpret_cast<void*>(testAdprofStop);
}
int32_t *testAdprofStart1(int32_t argc, const char *argv)
{
    int32_t *ret = reinterpret_cast<int32_t*>(1);
    return ret;
}
int32_t *testAdprofStop1()
{
    int32_t *ret = reinterpret_cast<int32_t*>(1);
    return ret;
}
VOID *mmDlsymFakeAdprofStart1(VOID *handle, const CHAR *funcName)
{
    return reinterpret_cast<void*>(testAdprofStart1);
}
VOID *mmDlsymFakeAdprofStop1(VOID *handle, const CHAR *funcName)
{
    return reinterpret_cast<void*>(testAdprofStop1);
}
TEST_F(ThreadManagerTest, UpdateProfilFailed)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->UpdateProfilingConf(deviceId);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, LoadSysOpKernelFailed2)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER(&ValidateStr)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&PackageWorker::LoadPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER(mmDlopen)
        .stubs()
        .will(returnValue((void*)0));
    ret = threadModeManager->Open(rankSize);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, LoadSysOpKernelFailed3)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER(&ValidateStr)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&PackageWorker::LoadPackage)
        .stubs()
        .will(returnValue(103U));
    threadModeManager->packageName_[0] = "test";
    ret = threadModeManager->Open(rankSize);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, InitQsFail)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    InitFlowGwInfo info = {"test", 0U};
    ret = threadModeManager->InitQs(&info);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, InitQsFail2)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    MOCKER(mmDlsym).stubs().will(returnValue((void*)0));
    InitFlowGwInfo info = {"test", 0U};
    ret = threadModeManager->InitQs(&info);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, ThreadOpen)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> clientManager = ClientManager::GetInstance(deviceId);
    InitFlowGwInfo info = {nullptr,0U};
    ret = clientManager->InitQs(&info);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = clientManager->Open(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = clientManager->UpdateProfilingConf(deviceId);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = clientManager->Close(0);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, LoadSysOpKernelSuccess)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER(&ValidateStr)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&PackageWorker::LoadPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(CheckRealPath)
        .stubs()
        .will(returnValue(true));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, HandleAICPUPackageFail)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, HandleAICPUPackageFail2)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "_test", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, HandleAICPUPackageFail3)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "invalid_path", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, HandleAICPUPackageFail4)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "/home", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::LoadSysOpKernel)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ThreadManagerTest, CapabilityGet)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint64_t ptr = 1UL;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->CapabilityGet(0, ptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, CapabilityGet2)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    bool result = false;
    uint64_t ptrRes = reinterpret_cast<uint64_t>(&result);
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->CapabilityGet(TSD_CAPABILITY_ADPROF, ptrRes);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, CapabilityGet3)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint64_t ptrRes = 0;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->CapabilityGet(TSD_CAPABILITY_ADPROF, ptrRes);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, GetSubProcListStatus)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcStatusParam pidInfo;
    pidInfo.procType = TSD_SUB_PROC_ADPROF;
    ret = threadModeManager->GetSubProcListStatus(&pidInfo, 1);
    EXPECT_EQ(ret, tsd::TSD_OK);
}


TEST_F(ThreadManagerTest, HelperTest)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->LoadFileToDevice(nullptr, 0, nullptr, 0);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->ProcessOpenSubProc(nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->ProcessCloseSubProc(0);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->GetSubProcStatus(nullptr, 0);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->RemoveFileOnDevice(nullptr, 0);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->NotifyPmToStartTsdaemon();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->ProcessCloseSubProcList(nullptr, 0U);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->GetSubProcListStatus(nullptr, 0U);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    ret = threadModeManager->CloseNetService();
    EXPECT_EQ(ret, TSD_CLOSE_NOT_SUPPORT_NET_SERVICE);
    ret = threadModeManager->OpenNetService(nullptr);
    EXPECT_EQ(ret, TSD_OPEN_NOT_SUPPORT_NET_SERVICE);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProcTest1)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->ProcessOpenSubProc(nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProcTest2)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_COMPUTE;
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProcTest3)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProcTest4)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    MOCKER(mmDlsym).stubs().will(returnValue((void*)0));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProcTest5)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    openArgs.extParamCnt = 1;
    char test = 'a';
    ProcExtParam extParamList;
    extParamList.paramInfo = &test;
    extParamList.paramLen = 1;
    openArgs.extParamList = &extParamList;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStart1));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProcTest6)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    openArgs.extParamCnt = 1;
    char test = 'a';
    ProcExtParam extParamList;
    extParamList.paramInfo = &test;
    extParamList.paramLen = 1;
    openArgs.extParamList = &extParamList;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStart));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcListTest1)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ret = threadModeManager->ProcessCloseSubProcList(nullptr, 0U);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcListTest2)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcListTest3)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_HCCP;
    uint32_t listSize = 1;
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcListTest4)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    openArgs.extParamCnt = 1;
    char test = 'a';
    ProcExtParam extParamList;
    extParamList.paramInfo = &test;
    extParamList.paramLen = 1;
    openArgs.extParamList = &extParamList;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStart));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    MOCKER(mmDlsym).stubs().will(returnValue((void*)0));
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcListTest5)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    openArgs.extParamCnt = 1;
    char test = 'a';
    ProcExtParam extParamList;
    extParamList.paramInfo = &test;
    extParamList.paramLen = 1;
    openArgs.extParamList = &extParamList;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStart));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStop1));
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcListTest6)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = ClientManager::GetInstance(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    openArgs.extParamCnt = 1;
    char test = 'a';
    ProcExtParam extParamList;
    extParamList.paramInfo = &test;
    extParamList.paramLen = 1;
    openArgs.extParamList = &extParamList;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStart));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStop));
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    threadModeManager->Destroy();
}

void GetScheduleEnvStub2(const char_t * const envName, std::string &envValue)
{
    envValue = "";
}
TEST_F(ThreadManagerTest, ProcessOpenTfSoFailed)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t vfId = 1;
    ThreadModeManager ThreadModeManager(deviceId);
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    ThreadModeManager.OpenTfSo(vfId);
    ThreadModeManager.tfSoHandle_ = nullptr;
    MOCKER(access).stubs().will(returnValue(0));
    ThreadModeManager.OpenTfSo(vfId);
    ThreadModeManager.tfSoHandle_ = nullptr;
    ThreadModeManager.OpenTfSo(vfId);
    MOCKER(tsd::GetScheduleEnv).stubs().will(invoke(GetScheduleEnvStub2));
    ThreadModeManager.tfSoHandle_ = nullptr;
    ThreadModeManager.OpenTfSo(vfId);
    ThreadModeManager.OpenTfSo(vfId);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, ProcessOpenTfSoSuccess)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t vfId = 1;
    ThreadModeManager ThreadModeManager(deviceId);
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(mmDlopen).stubs().will(returnValue((void*)(&deviceId)));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    ThreadModeManager.OpenTfSo(vfId);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, LoadSysOpKernel_Extend)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    ThreadModeManager ThreadModeManager(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::HandleAICPUPackage).stubs().will(returnValue(TSD_OK));
    ThreadModeManager.packageName_[1] = "Ascend-aicpu_extend_syskernels.tar.gz";
    ret = ThreadModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, LoadSysOpKernel_Extend_01)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    ThreadModeManager ThreadModeManager(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::HandleAICPUPackage).stubs().will(returnValue(1U));
    ThreadModeManager.packageName_[1] = "Ascend-aicpu_extend_syskernels.tar.gz";
    ret = ThreadModeManager.LoadSysOpKernel();
    EXPECT_NE(ret, tsd::TSD_OK);
}