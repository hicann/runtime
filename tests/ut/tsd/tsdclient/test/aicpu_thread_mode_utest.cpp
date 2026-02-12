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
#include "inc/process_mode_manager.h"
#include "inc/aicpu_thread_mode_manager.h"
#include "inc/hdc_client.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;


class AicpuThreadModeManagerTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        cout << "Before AicpuThreadModeManagerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After AicpuThreadModeManagerTest" << endl;
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(AicpuThreadModeManagerTest, Open_Close)
{
    AicpuThreadModeManager aicpuThreadModeManager(0, 0);
    auto ret = aicpuThreadModeManager.Open(0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = aicpuThreadModeManager.Close(0);
    EXPECT_EQ(ret, tsd::TSD_OK);
    int32_t status;
    ret = aicpuThreadModeManager.GetHdcConctStatus(status);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(AicpuThreadModeManagerTest, ProcessCloseSubProcList)
{
    ProcStatusParam *closeList = (ProcStatusParam *)malloc(sizeof(ProcStatusParam) * 51);
    if (closeList != nullptr) {
        for (auto index = 0; index < 51; index++) {
            closeList[index].procType = TSD_SUB_PROC_COMPUTE;
        }
        closeList[0].procType = TSD_SUB_PROC_COMPUTE;
        closeList[1].procType = TSD_SUB_PROC_QUEUE_SCHEDULE;
        closeList[2].procType = TSD_SUB_PROC_UDF;
        AicpuThreadModeManager aicpuThreadModeManager(0, 0);
        auto ret = aicpuThreadModeManager.ProcessCloseSubProcList(closeList, 51U);
        EXPECT_EQ(ret, tsd::TSD_OK);
        free(closeList);
    }
}

TEST_F(AicpuThreadModeManagerTest, ProcessCloseSubProcList_ext)
{
    ProcStatusParam *closeList = (ProcStatusParam *)malloc(sizeof(ProcStatusParam) * 51);
    if (closeList != nullptr) {
        for (auto index = 0; index < 51; index++) {
            closeList[index].procType = TSD_SUB_PROC_COMPUTE;
        }
        closeList[0].procType = TSD_SUB_PROC_COMPUTE;
        closeList[1].procType = TSD_SUB_PROC_QUEUE_SCHEDULE;
        closeList[2].procType = TSD_SUB_PROC_UDF;
        AicpuThreadModeManager aicpuThreadModeManager(0, 0);
        aicpuThreadModeManager.tsdSupportLevel_ = 15;
        MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
        MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
        auto ret = aicpuThreadModeManager.ProcessCloseSubProcList(closeList, 51U);
        EXPECT_EQ(ret, tsd::TSD_OK);
        free(closeList);
        GlobalMockObject::verify();
    }
}

TEST_F(AicpuThreadModeManagerTest, ProcessCloseSubProcList_ext_2)
{
    ProcStatusParam *closeList = (ProcStatusParam *)malloc(sizeof(ProcStatusParam) * 51);
    if (closeList != nullptr) {
        for (auto index = 0; index < 51; index++) {
            closeList[index].procType = TSD_SUB_PROC_COMPUTE;
        }
        closeList[0].procType = TSD_SUB_PROC_COMPUTE;
        closeList[1].procType = TSD_SUB_PROC_QUEUE_SCHEDULE;
        closeList[2].procType = TSD_SUB_PROC_UDF;
        AicpuThreadModeManager aicpuThreadModeManager(0, 0);
        aicpuThreadModeManager.tsdSupportLevel_ = 15;
        aicpuThreadModeManager.hdcTsdClient_ = HdcClient::GetInstance(0, HDCServiceType::TSD);
        MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
        MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
        auto ret = aicpuThreadModeManager.ProcessCloseSubProcList(closeList, 51U);
        EXPECT_EQ(ret, tsd::TSD_OK);
        free(closeList);
        GlobalMockObject::verify();
    }
}

TEST_F(AicpuThreadModeManagerTest, ProcessCloseSubProcList_ext_3)
{
    ProcStatusParam *closeList = (ProcStatusParam *)malloc(sizeof(ProcStatusParam) * 51);
    if (closeList != nullptr) {
        for (auto index = 0; index < 51; index++) {
            closeList[index].procType = TSD_SUB_PROC_COMPUTE;
        }
        closeList[0].procType = TSD_SUB_PROC_COMPUTE;
        closeList[1].procType = TSD_SUB_PROC_QUEUE_SCHEDULE;
        closeList[2].procType = TSD_SUB_PROC_UDF;
        AicpuThreadModeManager aicpuThreadModeManager(0, 0);
        aicpuThreadModeManager.tsdSupportLevel_ = 0;
        aicpuThreadModeManager.hdcTsdClient_ = HdcClient::GetInstance(0, HDCServiceType::TSD);
        MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
        MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
        auto ret = aicpuThreadModeManager.ProcessCloseSubProcList(closeList, 51U);
        EXPECT_NE(ret, tsd::TSD_OK);
        free(closeList);
        GlobalMockObject::verify();
    }
}

TEST_F(AicpuThreadModeManagerTest, GetSubProcListStatus)
{
    ProcStatusParam *closeList = (ProcStatusParam *)malloc(sizeof(ProcStatusParam) * 51);
    if (closeList != nullptr) {
        for (auto index = 0; index < 51; index++) {
            closeList[index].procType = TSD_SUB_PROC_COMPUTE;
        }
        closeList[0].procType = TSD_SUB_PROC_COMPUTE;
        closeList[1].procType = TSD_SUB_PROC_QUEUE_SCHEDULE;
        closeList[2].procType = TSD_SUB_PROC_UDF;
        AicpuThreadModeManager aicpuThreadModeManager(0, 0);
        aicpuThreadModeManager.tsdSupportLevel_ = 15;
        aicpuThreadModeManager.hdcTsdClient_ = HdcClient::GetInstance(0, HDCServiceType::TSD);
        MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
        MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
        EXPECT_EQ(aicpuThreadModeManager.GetSubProcListStatus(closeList, 51U), tsd::TSD_OK);
        free(closeList);
        GlobalMockObject::verify();
    }
}

TEST_F(AicpuThreadModeManagerTest, GetSubProcListStatus_01)
{
    ProcStatusParam *closeList = (ProcStatusParam *)malloc(sizeof(ProcStatusParam) * 51);
    if (closeList != nullptr) {
        for (auto index = 0; index < 51; index++) {
            closeList[index].procType = TSD_SUB_PROC_COMPUTE;
        }
        closeList[0].procType = TSD_SUB_PROC_COMPUTE;
        closeList[1].procType = TSD_SUB_PROC_QUEUE_SCHEDULE;
        closeList[2].procType = TSD_SUB_PROC_UDF;
        AicpuThreadModeManager aicpuThreadModeManager(0, 0);
        aicpuThreadModeManager.tsdSupportLevel_ = 15;
        aicpuThreadModeManager.hdcTsdClient_ = HdcClient::GetInstance(0, HDCServiceType::TSD);
        MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
        MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
        EXPECT_EQ(aicpuThreadModeManager.GetSubProcListStatus(nullptr, 51U), tsd::TSD_INTERNAL_ERROR);
        free(closeList);
        GlobalMockObject::verify();
    }
}

TEST_F(AicpuThreadModeManagerTest, UpdateProfilingConf)
{
    uint32_t flag = 0U;
    AicpuThreadModeManager aicpuThreadModeManager(0, 0);
    EXPECT_EQ(aicpuThreadModeManager.UpdateProfilingConf(flag), tsd::TSD_CLT_UPDATE_PROFILING_FAILED);
}
 
TEST_F(AicpuThreadModeManagerTest, DetectAndReconnectToServer)
{
    MOCKER_CPP(&HdcClient::GetHdcConctStatus).stubs().will(returnValue(1U));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    AicpuThreadModeManager aicpuThreadModeManager(0, 0);
    aicpuThreadModeManager.hdcTsdClient_ = HdcClient::GetInstance(0, HDCServiceType::TSD);
    int32_t hdcSessStat = 0;
    aicpuThreadModeManager.DetectAndReconnectToServer(hdcSessStat, true);
    EXPECT_EQ(aicpuThreadModeManager.hdcTsdClient_ != nullptr, true);
    GlobalMockObject::verify();
}
 
TEST_F(AicpuThreadModeManagerTest, DetectAndReconnectToServer_01)
{
    MOCKER_CPP(&HdcClient::GetHdcConctStatus).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    AicpuThreadModeManager aicpuThreadModeManager(0, 0);
    aicpuThreadModeManager.hdcTsdClient_ = nullptr;
    int32_t hdcSessStat = 0;
    aicpuThreadModeManager.DetectAndReconnectToServer(hdcSessStat, true);
    EXPECT_EQ(aicpuThreadModeManager.hdcTsdClient_ == nullptr, false);
    GlobalMockObject::verify();
}
 
TEST_F(AicpuThreadModeManagerTest, ProcessOpenSubProc)
{
    MOCKER(usleep).stubs().will(returnValue(0));
    MOCKER(sleep).stubs().will(returnValue(0U));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_COMPUTE;
    AicpuThreadModeManager aicpuThreadModeManager(0, 0);
    aicpuThreadModeManager.hdcTsdClient_ = nullptr;
    EXPECT_EQ(aicpuThreadModeManager.ProcessOpenSubProc(&openArg), tsd::TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}