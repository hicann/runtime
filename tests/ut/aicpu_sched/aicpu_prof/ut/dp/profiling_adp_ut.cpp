/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include <stdio.h>
#include <pthread.h>
#include <iostream>
#include <unistd.h>
#include <fstream>
#include <sys/stat.h>
#include <sys/eventfd.h>
#include <functional>
#include <memory>
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "aicpu_prof/profiling_adp.h"
#include "aicpu_prof.h"
#include "prof_so_manager.h"
#undef protected
#undef private

using namespace std;
using namespace aicpu;

class ProfilingAdpUt : public testing::Test
{
public:
protected:
    static void SetUpTestCase() {
        printf("ProfilingAdpUt UT SetUp\n");
    }
    static void TearDownTestCase() {
        printf("ProfilingAdpUt UT TearDown\n");

    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

namespace {
int32_t AdprofAicpuStartRegister(AicpuStartFunc aicpuStartCallback, const struct AicpuStartPara *para)
{
    return 0;
}

int32_t AdprofReportData(VOID_PTR data, uint32_t len)
{
    return 0;
}

int32_t AdprofReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t length)
{
    return 0;
}

int32_t AdprofAicpuStop()
{
    return 0;
}

void *dlsymSucFake(void *handle, const char *symbol)
{
    if (std::string(symbol) == "AdprofAicpuStartRegister") {
        return (void *)AdprofAicpuStartRegister;
    } else if (std::string(symbol) == "AdprofReportData") {
        return (void *)AdprofReportData;
    } else if (std::string(symbol) == "AdprofReportAdditionalInfo") {
        return (void *)AdprofReportAdditionalInfo;
    } else if (std::string(symbol) == "AdprofAicpuStop") {
        return (void *)AdprofAicpuStop;
    } else {
        return nullptr;
    }
}

void *dlsymNullFake(void *handle, const char *symbol)
{
    return nullptr;
}
}

int32_t ReportCallbackImp(uint32_t moduleId, uint32_t type, void *data, uint32_t len) {
    return 0;
}

TEST_F(ProfilingAdpUt, InitProfilingCheck)
{
    aicpu::UpdateMode(true);
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymSucFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    //init profiling
    aicpu::InitProfiling(0, 100, 0);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, InitProfilingCheckCallback)
{
    aicpu::UpdateMode(true);
    //set callback function valid
    MsprofReporterCallback reporterCallback = ReportCallbackImp;
    ProfilingAdp::GetInstance().SetReportCallbackValid(true, reporterCallback);

    //init profiling
    aicpu::InitProfiling(0, 100, 0);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, SendProcessCheck)
{
    aicpu::UpdateMode(true);
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymSucFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    aicpu::SendToProfiling("sendData", "mark");
    EXPECT_EQ(aicpu::IsProfOpen(), true);
    aicpu::ReleaseProfiling();
}

TEST_F(ProfilingAdpUt, SendProcessCheck01)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlclose).stubs().will(returnValue(0));
    aicpu::UpdateMode(true);
    aicpu::SendToProfiling("sendData", "mark");
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, SendProcessCheckCallback)
{
    aicpu::UpdateMode(true);
    //set callback function valid
    MsprofReporterCallback reporterCallback = ReportCallbackImp;
    ProfilingAdp::GetInstance().SetReportCallbackValid(true, reporterCallback);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
    aicpu::SendToProfiling("sendData", "mark");
    aicpu::ReleaseProfiling();

    reporterCallback = nullptr;
    ProfilingAdp::GetInstance().SetReportCallbackValid(true, reporterCallback);
}

TEST_F(ProfilingAdpUt, SendToProfilingCheck)
{
    aicpu::UpdateMode(true);
    aicpu::SendToProfiling("sendData", "mark");

    //mark size == 0
    aicpu::SendToProfiling("sendData", "");

    //sendSize == 0
    aicpu::SendToProfiling("", "mark");

    //sendData length > 1024
    string sendData( 1048, 'c' );
    aicpu::SendToProfiling(sendData, "mark");
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, ReleaseProfilingCheck)
{
    aicpu::UpdateMode(true);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
    aicpu::ReleaseProfiling();
}

TEST_F(ProfilingAdpUt, ReleaseProfilingCheckCallback)
{
    aicpu::UpdateMode(true);
    //set callback function valid
    MsprofReporterCallback reporterCallback = ReportCallbackImp;
    ProfilingAdp::GetInstance().SetReportCallbackValid(true, reporterCallback);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
    //release profiling
    aicpu::ReleaseProfiling();
}

TEST_F(ProfilingAdpUt, UpdateMode)
{
    aicpu::UpdateMode(true);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, GetSystemTick_Test)
{
    aicpu::UpdateModelMode(true);
    GetSystemTick();
    EXPECT_EQ(aicpu::IsModelProfOpen(), true);
}

TEST_F(ProfilingAdpUt, GetSystemTickFreq_Test)
{
    aicpu::UpdateModelMode(true);
    GetSystemTickFreq();
    EXPECT_EQ(aicpu::IsModelProfOpen(), true);
}

TEST_F(ProfilingAdpUt, GetMicrosAndSysTick_Test)
{
    uint64_t micros;
    uint64_t tick;
    aicpu::UpdateModelMode(true);
    GetMicrosAndSysTick(micros, tick);
    EXPECT_EQ(aicpu::IsModelProfOpen(), true);
}

TEST_F(ProfilingAdpUt, SetProfHandle_Test)
{
    std::shared_ptr<ProfMessage> prof(nullptr);
    auto ret = SetProfHandle(prof);
    EXPECT_EQ(ret, 0);
}

TEST_F(ProfilingAdpUt, GetProfHandle_Test)
{
    aicpu::UpdateMode(true);
    GetProfHandle();
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, IsProfOpen_Test)
{
    aicpu::UpdateMode(true);
    auto ret = IsProfOpen();
    EXPECT_EQ(ret, true);
}

TEST_F(ProfilingAdpUt, ProfMessage_AICPU_MODEL_Test)
{
    aicpu::UpdateModelMode(true);
    EXPECT_EQ(aicpu::IsModelProfOpen(), true);
    MOCKER_CPP(&ProfilingAdp::SendProcess)
        .stubs()
        .will(returnValue(0));
    ProfModelMessage prof("AICPU_MODEL");
    const int32_t ret = prof.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
}

TEST_F(ProfilingAdpUt, ProfMessage_AICPU_Test)
{
    MOCKER_CPP(&ifstream::is_open, bool(ifstream::*)())
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::SendProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    aicpu::UpdateMode(true);
    ProfMessage prof("AICPU");
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, ProfMessage_AICPU_Unsupported_Test)
{
    MOCKER(&IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::SendProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    aicpu::UpdateMode(true);
    ProfMessage prof("AICPU");
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, ProfMessage_DP_Unsupported_Test)
{
    MOCKER(&IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::SendProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    aicpu::UpdateMode(true);
    ProfMessage prof("DP");
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}

TEST_F(ProfilingAdpUt, NewMemoryToStoreDataSuccess)
{
    const std::string sendData = "Node:GetNext_dequeue_wait, queue size:6, Run start:1034567891, Run end:1034567999";
    const int32_t sendSize = sendData.size();
    ReporterData reportData = {0};
    const bool ret = ProfilingAdp::GetInstance().NewMemoryToStoreData(sendSize, sendData, reportData);
    EXPECT_EQ(ret, true);
    free(reportData.data);
}

TEST_F(ProfilingAdpUt, NewMemoryToStoreDataFail)
{
    const std::string sendData = "Node:GetNext_dequeue_wait, queue size:6, Run start:1034567891, Run end:1034567999";
    const int32_t sendSize = sendData.size();
    ReporterData reportData = {0};
    MOCKER(memset_s).stubs().will(returnValue(-1));
    const bool ret = ProfilingAdp::GetInstance().NewMemoryToStoreData(sendSize, sendData, reportData);
    EXPECT_EQ(ret, false);
}

TEST_F(ProfilingAdpUt, SendProcessFailed)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymNullFake));
    ReporterData reportData = {0};
    ProfilingAdp::GetInstance().reportCallback_ = nullptr;
    int ret = ProfilingAdp::GetInstance().SendProcess(reportData);
    EXPECT_EQ(ret, -1);
}

TEST_F(ProfilingAdpUt, SendProcessSuc)
{
    auto profSoManager = ProfSoManager::GetInstance();
    profSoManager->soHandle_ = nullptr;
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymSucFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    profSoManager->LoadSo();
    ProfilingAdp::GetInstance().ProfilingModeOpenProcess();
    ReporterData reportData = {0};
    ProfilingAdp::GetInstance().reportCallback_ = nullptr;
    int ret = ProfilingAdp::GetInstance().SendProcess(reportData);
    EXPECT_EQ(ret, 0);
    profSoManager->UnloadSo();
}

TEST_F(ProfilingAdpUt, BuildProfMiAdditionalData_Test_Success)
{
    const std::string sendData = "Node:GetNext_dequeue_wait, queue size:6, Run start:1034567891, Run end:1034567999";
    MsprofAdditionalInfo reportData;
    ProfilingAdp::GetInstance().reportCallback_ = nullptr;
    ProfilingAdp::GetInstance().BuildProfMiAdditionalData(sendData, reportData);
    MsprofAicpuMiAdditionalData expReportData = {GET_NEXT_DEQUEUE_WAIT, 0, 6, 1034567891, 1034567999};
    auto ReportDataInfo = reinterpret_cast<MsprofAicpuMiAdditionalData *>(reportData.data);
    EXPECT_EQ(ReportDataInfo->queueSize, expReportData.queueSize);
}

TEST_F(ProfilingAdpUt, ReleaseProfilingWithAdditionalFlagFail)
{
    ProfilingAdp::GetInstance().reportCallback_ = nullptr;
    EXPECT_EQ(ProfilingAdp::GetInstance().UninitProcess(), -1);
}

TEST_F(ProfilingAdpUt, ReleaseProfilingWithAdditionalFlagSuccess)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymSucFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    //init profiling
    aicpu::ProfSoManager::GetInstance()->LoadSo();
    aicpu::InitProfiling(0, 100, 0);
    ProfilingAdp::GetInstance().reportCallback_ = nullptr;
    EXPECT_EQ(ProfilingAdp::GetInstance().UninitProcess(), 0);
}

TEST_F(ProfilingAdpUt, BuildProfAicpuAdditionalData_Test_Success)
{
    MOCKER(&IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    aicpu::UpdateMode(true);
    auto ret = aicpu::AicpuStartCallback();
    EXPECT_EQ(ret, 0);
    std::shared_ptr<aicpu::ProfMessage> prof = std::make_shared<aicpu::ProfMessage>("AICPU");
    (void)prof->SetAicpuMagicNumber(static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM))
              ->SetAicpuDataTag(static_cast<uint16_t>(MSPROF_AICPU_DATA_TAG))
              ->SetStreamId(static_cast<uint16_t>(12))
              ->SetTaskId(static_cast<uint16_t>(12))->SetThreadId(1)
              ->SetDeviceId(1)
              ->SetKernelType(1)->SetSubmitTick(1034567891)
              ->SetScheduleTick(1034567989)->SetTickBeforeRun(1034568980)
              ->SetTickAfterRun(1034568990)->SetDispatchTime(1034569000)
              ->SetTotalTime(123)->SetVersion(aicpu::AICPU_PROF_VERSION);
}

TEST_F(ProfilingAdpUt, BuildProfDpAdditionalData_Test_Success)
{
    MOCKER(&IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    aicpu::UpdateMode(true);
    auto ret = aicpu::AicpuStartCallback();
    EXPECT_EQ(ret, 0);
    std::shared_ptr<aicpu::ProfMessage> prof = std::make_shared<aicpu::ProfMessage>("DP");
    (void)prof->SetDPMagicNumber(static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM))
              ->SetDPDataTag(static_cast<uint16_t>(MSPROF_DP_DATA_TAG))
              ->SetAction("Last dequeue")
              ->SetSource("test_source")->SetIndex(1)->SetSize(20);
}

TEST_F(ProfilingAdpUt, BuildProfModelAdditionalData_Test_Success)
{
    MOCKER(&IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    MOCKER(aicpu::AdprofReportAdditionalInfoFunc).stubs().will(returnValue(0));
    aicpu::UpdateMode(true);
    aicpu::AicpuStartCallback();
    aicpu::ProfModelMessage prof("AICPU_MODEL");
    (void)prof.SetAicpuModelId(1)
              ->SetDataTagId(MSPROF_AICPU_MODEL_TAG)
                ->SetAicpuModelIterId(12)
                ->SetAicpuModelTimeStamp(aicpu::GetSystemTick())
                ->SetAicpuTagId(aicpu::MODEL_EXECUTE_START)
                ->SetEventId(0)
                ->SetDeviceId(1);
    const int32_t ret = prof.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
}

TEST_F(ProfilingAdpUt, BuildProfModelAdditionalData_Test_Success001)
{
    MOCKER(&IsSupportedProfData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProfilingAdp::GetReportValid)
        .stubs()
        .will(returnValue(true));
    auto profSoManager = ProfSoManager::GetInstance();
    profSoManager->soHandle_ = nullptr;
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymSucFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    aicpu::ProfSoManager::GetInstance()->LoadSo();
    ProfilingAdp::GetInstance().ProfilingModeOpenProcess();
    aicpu::UpdateMode(true);
    aicpu::AicpuStartCallback();
    aicpu::ProfModelMessage prof("AICPU_MODEL");
    (void)prof.SetAicpuModelId(1)
              ->SetDataTagId(MSPROF_AICPU_MODEL_TAG)
                ->SetAicpuModelIterId(12)
                ->SetAicpuModelTimeStamp(aicpu::GetSystemTick())
                ->SetAicpuTagId(aicpu::MODEL_EXECUTE_START)
                ->SetEventId(0)
                ->SetDeviceId(1);
    const int32_t ret = prof.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
    profSoManager->UnloadSo();
}

TEST_F(ProfilingAdpUt, ProfilingModeOpenProcessFailed001)
{
    auto profSoManager = ProfSoManager::GetInstance();
    int tmp = 9;
    profSoManager->soHandle_ = &tmp;
    MOCKER(AdprofAicpuStartRegisterFunc).stubs().will(returnValue(-1));
    EXPECT_EQ(ProfilingAdp::GetInstance().ProfilingModeOpenProcess(), -1);
}

TEST_F(ProfilingAdpUt, ProfilingModeOpenProcessFailed002)
{
    auto profSoManager = ProfSoManager::GetInstance();
    profSoManager->soHandle_ = nullptr;
    MOCKER(AdprofAicpuStartRegisterFunc).stubs().will(returnValue(-1));
    EXPECT_EQ(ProfilingAdp::GetInstance().ProfilingModeOpenProcess(), -1);
    profSoManager->UnloadSo();
}

TEST_F(ProfilingAdpUt, ProfilingModeOpenProcessFailed003)
{
    auto profSoManager = ProfSoManager::GetInstance();
    profSoManager->soHandle_ = nullptr;
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymNullFake));
    EXPECT_EQ(ProfilingAdp::GetInstance().ProfilingModeOpenProcess(), -1);
    MOCKER(dlclose).stubs().will(returnValue(0));
    profSoManager->UnloadSo();
}

TEST_F(ProfilingAdpUt, SetProfilingFlagForKFC)
{
    aicpu::UpdateMode(true);
    SetProfilingFlagForKFC(0);
    EXPECT_EQ(aicpu::IsProfOpen(), true);
}
TEST_F(ProfilingAdpUt, LoadProfilingLib)
{
    aicpu::UpdateMode(true);
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(invoke(dlsymSucFake));
    MOCKER(dlclose).stubs().will(returnValue(0));
    LoadProfilingLib();
    EXPECT_EQ(aicpu::IsProfOpen(), true);
    ProfSoManager::GetInstance()->UnloadSo();
}

TEST_F(ProfilingAdpUt, BuildSendContentFail)
{
    char_t buffer[1024] = {};
    std::string test = "test string";
    std::string test_mark = "AICPU";
    ReporterData reportData = {0};
    bool needNewFlag = false;
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ProfilingAdp::GetInstance().BuildSendContent(test, test_mark, &buffer[0], 1024, needNewFlag, reportData);
    EXPECT_EQ(strlen(reportData.tag), 0);
}

TEST_F(ProfilingAdpUt, BuildProfDataFail)
{
    std::string test_mark = "AICPU";
    ReporterData reportData = {0};
    MsprofAicpuProfData sendData;
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ProfilingAdp::GetInstance().BuildProfData<MsprofAicpuProfData>(sendData, test_mark, reportData);
    EXPECT_EQ(strlen(reportData.tag), 0);
}

TEST_F(ProfilingAdpUt, BuildProfDpAdditionalDataFail)
{
    std::string test_mark = "AICPU";
    MsprofAdditionalInfo reportData;
    MsprofDpProfData sendData;
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ProfilingAdp::GetInstance().BuildProfDpAdditionalData(sendData, reportData);
    EXPECT_EQ(reportData.level, MSPROF_REPORT_AICPU_LEVEL);
}

TEST_F(ProfilingAdpUt, SendProfModelMessageWithOldChannelFail)
{
    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    aicpu::UpdateModelMode(true);
    EXPECT_EQ(aicpu::IsModelProfOpen(), true);
    MOCKER_CPP(&ProfilingAdp::SendProcess)
        .stubs()
        .will(returnValue(0));
    ProfilingAdp::GetInstance().reportCallback_ = ReportCallbackImp;
    ProfModelMessage prof("AICPU_MODEL");
    const int32_t ret = prof.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
}