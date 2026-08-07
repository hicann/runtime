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
#include "package_worker.h"
#include "common_util_func.h"
#include <cstring>
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
// clientManager is a singleton, so a deviceId can only point to one mode in all st
// we define 0 to ProcessMode, and 1 to ThreadMode
static const int deviceId = 1;
} // namespace

class ThreadManagerTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        homeEnv_ = std::make_unique<ScopedEnvVar>("HOME");
        savedRunningMode_ = ClientManager::g_runningMode;
        savedSchedMode_ = ClientManager::aicpuSchedMode_;
        savedProfilingCallback_ = ClientManager::g_profilingCallback;
        // this must be set, ThreadManager:THREAD, ProcessManager:PROCESS
        // setenv("RUN_MODE", "THREAD", "THREAD");
        std::string valueStr("THREAD_MODE");
        ClientManager::SetRunMode(valueStr);
        cout << "Before ThreadManagerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After ThreadManagerTest" << endl;
        std::string valueStr("THREAD_MODE");
        ClientManager::SetRunMode(valueStr);
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreClientState();
            homeEnv_.reset();
            throw;
        }
        GlobalMockObject::reset();
        RestoreClientState();
        homeEnv_.reset();
    }

    std::unique_ptr<ScopedEnvVar> homeEnv_;
    RunningMode savedRunningMode_ = RunningMode::UNSET_MODE;
    SchedMode savedSchedMode_ = AICPU_SCHED_MODE_INTERRUPT;
    MsprofReporterCallback savedProfilingCallback_ = nullptr;

private:
    void RestoreClientState()
    {
        ClientManager::g_runningMode = savedRunningMode_;
        ClientManager::aicpuSchedMode_ = savedSchedMode_;
        ClientManager::g_profilingCallback = savedProfilingCallback_;
        ClientManager::ResetPlatInfoFlag();
    }
};

int32_t testAdprofStart(int32_t argc, const char* argv) { return 0; }
int32_t testAdprofStop() { return 0; }
VOID* mmDlsymFakeAdprofStart(VOID* handle, const CHAR* funcName) { return reinterpret_cast<void*>(testAdprofStart); }
VOID* mmDlsymFakeAdprofStop(VOID* handle, const CHAR* funcName) { return reinterpret_cast<void*>(testAdprofStop); }
int32_t testAdprofStart1(int32_t argc, const char* argv) { return 1; }
int32_t testAdprofStop1() { return 1; }
VOID* mmDlsymFakeAdprofStart1(VOID* handle, const CHAR* funcName) { return reinterpret_cast<void*>(testAdprofStart1); }
VOID* mmDlsymFakeAdprofStop1(VOID* handle, const CHAR* funcName) { return reinterpret_cast<void*>(testAdprofStop1); }

struct SchedulerCalls {
    uint32_t startDevice = 0U;
    int32_t startPid = 0;
    ProfilingMode profilingMode = ProfilingMode::PROFILING_CLOSE;
    uint32_t updateDevice = 0U;
    int32_t updatePid = 0;
    uint32_t updateFlag = 0U;
    uint32_t stopDevice = 0U;
    int32_t stopPid = 0;
    uint32_t qsDevice = 0U;
    int32_t startRet = 0;
    int32_t updateRet = 0;
    int32_t startCount = 0;
    int32_t updateCount = 0;
    int32_t stopCount = 0;
    int32_t qsCount = 0;
    int32_t callbackCount = 0;
    MsprofReporterCallback callback = nullptr;
} g_schedulerCalls;

int32_t TestProfilingReporter(uint32_t, uint32_t, void*, uint32_t) { return 0; }

int32_t CaptureStartAicpu(uint32_t device, int32_t pid, ProfilingMode mode)
{
    g_schedulerCalls.startDevice = device;
    g_schedulerCalls.startPid = pid;
    g_schedulerCalls.profilingMode = mode;
    ++g_schedulerCalls.startCount;
    return g_schedulerCalls.startRet;
}

int32_t CaptureStopAicpu(uint32_t device, int32_t pid)
{
    g_schedulerCalls.stopDevice = device;
    g_schedulerCalls.stopPid = pid;
    ++g_schedulerCalls.stopCount;
    return 0;
}

int32_t CaptureUpdateProfiling(uint32_t device, int32_t pid, uint32_t flag)
{
    g_schedulerCalls.updateDevice = device;
    g_schedulerCalls.updatePid = pid;
    g_schedulerCalls.updateFlag = flag;
    ++g_schedulerCalls.updateCount;
    return g_schedulerCalls.updateRet;
}

int32_t CaptureSetCallback(MsprofReporterCallback callback)
{
    g_schedulerCalls.callback = callback;
    ++g_schedulerCalls.callbackCount;
    return 0;
}

int32_t CaptureStartQs(uint32_t device, uint32_t)
{
    g_schedulerCalls.qsDevice = device;
    ++g_schedulerCalls.qsCount;
    return 0;
}

VOID* ResolveSchedulerSymbol(VOID*, const CHAR* funcName)
{
    if (std::strcmp(funcName, "InitAICPUScheduler") == 0)
        return reinterpret_cast<VOID*>(CaptureStartAicpu);
    if (std::strcmp(funcName, "StopAICPUScheduler") == 0)
        return reinterpret_cast<VOID*>(CaptureStopAicpu);
    if (std::strcmp(funcName, "UpdateProfilingMode") == 0)
        return reinterpret_cast<VOID*>(CaptureUpdateProfiling);
    if (std::strcmp(funcName, "AicpuSetMsprofReporterCallback") == 0)
        return reinterpret_cast<VOID*>(CaptureSetCallback);
    if (std::strcmp(funcName, "InitQueueScheduler") == 0)
        return reinterpret_cast<VOID*>(CaptureStartQs);
    return nullptr;
}
TEST_F(ThreadManagerTest, UpdateProfilingConf_SchedulerNotStarted_ReturnsFailure)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ret = threadModeManager->UpdateProfilingConf(deviceId);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, Open_SchedulerLibraryOpenFails_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER(&ValidateStr).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorker::LoadPackage).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    ret = threadModeManager->Open(rankSize);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, Open_KernelPackageLoadFails_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER(&ValidateStr).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorker::LoadPackage).stubs().will(returnValue(103U));
    threadModeManager->packageName_[0] = "test";
    ret = threadModeManager->Open(rankSize);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, InitQs_LibraryOpenFails_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    InitFlowGwInfo info = {"test", 0U};
    ret = threadModeManager->InitQs(&info);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, InitQs_SchedulerSymbolMissing_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    MOCKER(mmDlsym).stubs().will(returnValue((void*)0));
    InitFlowGwInfo info = {"test", 0U};
    ret = threadModeManager->InitQs(&info);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, OpenAndProfiling_SchedulerSymbolsResolved_ForwardsArguments)
{
    g_schedulerCalls = {};
    ClientManager::g_profilingCallback = TestProfilingReporter;
    MOCKER(mmDlsym).stubs().will(invoke(ResolveSchedulerSymbol));
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(false));
    std::shared_ptr<ClientManager> clientManager = std::make_shared<ThreadModeManager>(deviceId);
    InitFlowGwInfo info = {nullptr, 0U};
    EXPECT_EQ(clientManager->InitQs(&info), tsd::TSD_OK);
    EXPECT_EQ(clientManager->Open(deviceId), tsd::TSD_OK);
    constexpr uint32_t profilingFlag = 17U;
    EXPECT_EQ(clientManager->UpdateProfilingConf(profilingFlag), tsd::TSD_OK);
    EXPECT_EQ(clientManager->Close(0), tsd::TSD_OK);
    EXPECT_EQ(g_schedulerCalls.qsCount, 1);
    EXPECT_EQ(g_schedulerCalls.qsDevice, static_cast<uint32_t>(deviceId));
    EXPECT_EQ(g_schedulerCalls.startCount, 1);
    EXPECT_EQ(g_schedulerCalls.startDevice, static_cast<uint32_t>(deviceId));
    EXPECT_EQ(g_schedulerCalls.profilingMode, ProfilingMode::PROFILING_CLOSE);
    EXPECT_EQ(g_schedulerCalls.updateCount, 1);
    EXPECT_EQ(g_schedulerCalls.updateDevice, static_cast<uint32_t>(deviceId));
    EXPECT_EQ(g_schedulerCalls.updateFlag, profilingFlag);
    EXPECT_EQ(g_schedulerCalls.stopCount, 1);
    EXPECT_EQ(g_schedulerCalls.stopDevice, static_cast<uint32_t>(deviceId));
    EXPECT_EQ(g_schedulerCalls.callbackCount, 1);
    EXPECT_EQ(g_schedulerCalls.callback, TestProfilingReporter);
    EXPECT_EQ(g_schedulerCalls.startPid, static_cast<int32_t>(getpid()));
    EXPECT_EQ(g_schedulerCalls.updatePid, static_cast<int32_t>(getpid()));
    EXPECT_EQ(g_schedulerCalls.stopPid, static_cast<int32_t>(getpid()));
}

TEST_F(ThreadManagerTest, Open_SchedulerStartReturnsFailure_PropagatesOpenFailure)
{
    g_schedulerCalls = {};
    g_schedulerCalls.startRet = 1;
    MOCKER(mmDlsym).stubs().will(invoke(ResolveSchedulerSymbol));
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(false));
    ThreadModeManager manager(deviceId);

    EXPECT_EQ(manager.Open(1U), TSD_CLT_OPEN_FAILED);
    EXPECT_EQ(g_schedulerCalls.startCount, 1);
    EXPECT_EQ(g_schedulerCalls.startDevice, static_cast<uint32_t>(deviceId));
    EXPECT_EQ(g_schedulerCalls.startPid, static_cast<int32_t>(getpid()));
}

TEST_F(ThreadManagerTest, UpdateProfiling_SchedulerReturnsFailure_PropagatesDeviceError)
{
    g_schedulerCalls = {};
    g_schedulerCalls.updateRet = 1;
    MOCKER(mmDlsym).stubs().will(invoke(ResolveSchedulerSymbol));
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(false));
    ThreadModeManager manager(deviceId);
    ASSERT_EQ(manager.Open(1U), TSD_OK);

    EXPECT_EQ(manager.UpdateProfilingConf(9U), TSD_DEVICEID_ERROR);
    EXPECT_EQ(g_schedulerCalls.updateCount, 1);
    EXPECT_EQ(g_schedulerCalls.updateFlag, 9U);
}

TEST_F(ThreadManagerTest, Open_KernelPackagesAndSchedulerSucceed_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER(&ValidateStr).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorker::LoadPackage).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(CheckRealPath).stubs().will(returnValue(true));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, Open_EmptyHomeAndExistingPackage_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU).stubs().will(returnValue(tsd::TSD_OK));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, Open_NonCanonicalHomeAndExistingPackage_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "_test", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU).stubs().will(returnValue(tsd::TSD_OK));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, Open_InvalidHomeAndExistingPackage_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "invalid_path", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU).stubs().will(returnValue(tsd::TSD_OK));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, Open_PackageAndSchedulerSucceed_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint32_t rankSize = 1;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    threadModeManager->packageName_[0] = "Ascend310-aicpu_syskernels.tar.gz";
    setenv("HOME", "/home", 1);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::LoadSysOpKernel).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ThreadModeManager::StartCallAICPU).stubs().will(returnValue(tsd::TSD_OK));
    ret = threadModeManager->Open(rankSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ThreadManagerTest, CapabilityGet_UnrelatedType_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint64_t ptr = 1UL;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ret = threadModeManager->CapabilityGet(0, ptr);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, CapabilityGet_AdprofWithValidOutput_SetsSupported)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    bool result = false;
    uint64_t ptrRes = reinterpret_cast<uint64_t>(&result);
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ret = threadModeManager->CapabilityGet(TSD_CAPABILITY_ADPROF, ptrRes);
    EXPECT_EQ(ret, tsd::TSD_OK);
    EXPECT_TRUE(result);
}

TEST_F(ThreadManagerTest, CapabilityGet_AdprofWithNullOutput_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    uint64_t ptrRes = 0;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ret = threadModeManager->CapabilityGet(TSD_CAPABILITY_ADPROF, ptrRes);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, GetSubProcListStatus_AdprofProcess_SetsNormalStatus)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ProcStatusParam pidInfo{};
    pidInfo.procType = TSD_SUB_PROC_ADPROF;
    pidInfo.curStat = SUB_PROCESS_STATUS_UNKNOW;

    EXPECT_EQ(threadModeManager->GetSubProcListStatus(&pidInfo, 1U), tsd::TSD_OK);
    EXPECT_EQ(pidInfo.curStat, SUB_PROCESS_STATUS_NORMAL);
}

TEST_F(ThreadManagerTest, LoadFileToDevice_ThreadMode_ReturnsUnsupportedError)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->LoadFileToDevice(nullptr, 0U, nullptr, 0U), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, ProcessCloseSubProc_ThreadMode_ReturnsUnsupportedError)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->ProcessCloseSubProc(0), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, GetSubProcStatus_ThreadMode_ReturnsUnsupportedError)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->GetSubProcStatus(nullptr, 0U), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, RemoveFileOnDevice_ThreadMode_ReturnsUnsupportedError)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->RemoveFileOnDevice(nullptr, 0U), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, GetSubProcListStatus_NullList_ReturnsError)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->GetSubProcListStatus(nullptr, 0U), tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ThreadManagerTest, CloseNetService_ThreadMode_ReturnsNotSupported)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->CloseNetService(), TSD_CLOSE_NOT_SUPPORT_NET_SERVICE);
}

TEST_F(ThreadManagerTest, OpenNetService_ThreadMode_ReturnsNotSupported)
{
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);

    EXPECT_EQ(threadModeManager->OpenNetService(nullptr), TSD_OPEN_NOT_SUPPORT_NET_SERVICE);
}

TEST_F(ThreadManagerTest, ProcessOpenSubProc_NullArgs_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ret = threadModeManager->ProcessOpenSubProc(nullptr);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProc_ComputeType_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_COMPUTE;
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProc_AdprofLibraryOpenFails_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProc_AdprofSymbolMissing_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ProcOpenArgs openArgs;
    openArgs.procType = TSD_SUB_PROC_ADPROF;
    MOCKER(mmDlsym).stubs().will(returnValue((void*)0));
    ret = threadModeManager->ProcessOpenSubProc(&openArgs);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessOpenSubProc_AdprofStartFails_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
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

TEST_F(ThreadManagerTest, ProcessOpenSubProc_AdprofStartSucceeds_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
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

TEST_F(ThreadManagerTest, ProcessCloseSubProcList_NullList_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ret = threadModeManager->ProcessCloseSubProcList(nullptr, 0U);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcList_AdprofNotStarted_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcList_UnsupportedType_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_HCCP;
    uint32_t listSize = 1;
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcList_StopSymbolMissing_ReturnsErrorAndDestroyReleasesHandle)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    auto threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
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
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    MOCKER(mmDlsym).stubs().will(returnValue((void*)0));
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_NE(threadModeManager->adprofHandle_, nullptr);
    threadModeManager->Destroy();
    EXPECT_EQ(threadModeManager->adprofHandle_, nullptr);
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcList_StopReturnsFailure_ReturnsErrorAndDestroyReleasesHandle)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    auto threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
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
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStop1));
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_NE(threadModeManager->adprofHandle_, nullptr);
    threadModeManager->Destroy();
    EXPECT_EQ(threadModeManager->adprofHandle_, nullptr);
}

TEST_F(ThreadManagerTest, ProcessCloseSubProcList_StopSucceeds_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    std::shared_ptr<ClientManager> threadModeManager = std::make_shared<ThreadModeManager>(deviceId);
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
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_ADPROF;
    uint32_t listSize = 1;
    MOCKER(mmDlsym).stubs().will(invoke(mmDlsymFakeAdprofStop));
    ret = threadModeManager->ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    threadModeManager->Destroy();
}

TEST_F(ThreadManagerTest, OpenTfSo_DlopenFails_HandleRemainsNull)
{
    uint32_t vfId = 1;
    ThreadModeManager manager(deviceId);
    char home[] = "/tmp";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(home)));
    MOCKER(mmDlopen).stubs().will(returnValue((void*)0));
    MOCKER(access).stubs().will(returnValue(0));

    manager.OpenTfSo(vfId);

    EXPECT_EQ(manager.tfSoHandle_, nullptr);
}

TEST_F(ThreadManagerTest, OpenTfSo_ReadablePathAndDlopenSucceeds_StoresHandle)
{
    uint32_t vfId = 1;
    ThreadModeManager manager(deviceId);
    void* const expectedHandle = reinterpret_cast<void*>(const_cast<int*>(&deviceId));
    char home[] = "/tmp";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(static_cast<char*>(home)));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(mmDlopen).stubs().will(returnValue(expectedHandle));
    MOCKER(mmDlclose).expects(once()).with(eq(expectedHandle)).will(returnValue(0));
    manager.OpenTfSo(vfId);

    EXPECT_EQ(manager.tfSoHandle_, expectedHandle);
}

TEST_F(ThreadManagerTest, LoadSysOpKernel_ExtendPackageSucceeds_ReturnsOk)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    ThreadModeManager ThreadModeManager(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::HandleAICPUPackage).stubs().will(returnValue(TSD_OK));
    ThreadModeManager.packageName_[1] = "Ascend-aicpu_extend_syskernels.tar.gz";
    ret = ThreadModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ThreadManagerTest, LoadSysOpKernel_ExtendPackageFails_ReturnsError)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    ThreadModeManager ThreadModeManager(deviceId);
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ThreadModeManager::HandleAICPUPackage).stubs().will(returnValue(1U));
    ThreadModeManager.packageName_[1] = "Ascend-aicpu_extend_syskernels.tar.gz";
    ret = ThreadModeManager.LoadSysOpKernel();
    EXPECT_NE(ret, tsd::TSD_OK);
}
