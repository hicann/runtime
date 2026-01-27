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
#include "mockcpp/ChainingMockHelper.h"
#include "dlopen_stub.h"
#include "msprof_stub.h"
#define private public
#define protected public
#include "msprof_manager.h"
#undef private
#undef protected


using namespace bqs;

class BqsMsprofManagerUTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        const qstest::FuncNamePtrMap funcMap = {
            {"MsprofInit", reinterpret_cast<void *>(&MsprofInit)},
            {"MsprofFinalize", reinterpret_cast<void *>(&MsprofFinalize)},
            {"MsprofRegTypeInfo", reinterpret_cast<void *>(&MsprofRegTypeInfo)},
            {"MsprofRegisterCallback", reinterpret_cast<void *>(&MsprofRegisterCallback)},
            {"MsprofReportApi", reinterpret_cast<void *>(&MsprofReportApi)},
            {"MsprofReportEvent", reinterpret_cast<void *>(&MsprofReportEvent)},
            {"MsprofSysCycleTime", reinterpret_cast<void *>(&MsprofSysCycleTime)},
        };

        qstest::DlopenStub::GetInstance().RegDlopenFuncPtr("libprofapi.so", funcMap);

        std::cout << "Before BqsMsprofManagerUTest" << std::endl;
    }

    virtual void TearDown()
    {
        bqs::BqsMsprofManager::GetInstance().isInitMsprof_ = false;
        std::cout << "After BqsMsprofManagerUTest" << std::endl;
        GlobalMockObject::verify();
    }
};

TEST_F(BqsMsprofManagerUTest, InitBqsMsprofManagerSuccess)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    EXPECT_NE(cfgData, "xxx");
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlSwitchSuccess01)
{
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    BqsMsprofManager::GetInstance().InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_START;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(BqsMsprofManager::GetInstance().isRun_, true);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlSwitchSuccess02)
{
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    BqsMsprofManager::GetInstance().InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_STOP;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(BqsMsprofManager::GetInstance().isRun_, false);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlSwitchSuccess03)
{
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    BqsMsprofManager::GetInstance().InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_FINALIZE;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(BqsMsprofManager::GetInstance().isRun_, false);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlSwitchSuccess04)
{
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    BqsMsprofManager::GetInstance().InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_INIT;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(BqsMsprofManager::GetInstance().isRun_, false);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlSwitchSuccess05)
{
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    BqsMsprofManager::GetInstance().InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(BqsMsprofManager::GetInstance().isRun_, false);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlSwitchSuccess06)
{
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    BqsMsprofManager::GetInstance().InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(BqsMsprofManager::GetInstance().isRun_, false);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlRepoterSuccess)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_REPORTER, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackCtrlStepInfoSuccess)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_STEPINFO, &data, sizeof(data));
    EXPECT_EQ(ret, 0);
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackNullptr)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_STEPINFO, nullptr, 0);
    EXPECT_EQ(ret, static_cast<int32_t>(ProfStatus::PROF_INVALID_PARA));
}

TEST_F(BqsMsprofManagerUTest, ProfCallbackUnknownSwitch)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    const auto ret = qstest::RunMsprofCallback(UINT32_MAX, &data, sizeof(data));
    EXPECT_EQ(ret, static_cast<int32_t>(ProfStatus::PROF_SUCCESS));
}

TEST_F(BqsMsprofManagerUTest, ReportApiPerfSuccess01)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_START;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);

    const uint32_t transId = 15;
    bqs::ProfInfo reportData = {0U};
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::ENQUEUE_DATA);
        reportData.itemId = transId;
        reportData.timeStamp = bqs::GetTimeStamp();
    }

    bqs::BqsMsprofManager::GetInstance().ReportApiPerf(reportData);
}

TEST_F(BqsMsprofManagerUTest, ReportApiPerfSuccess02)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_STOP;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);

    const uint32_t transId = 15;
    bqs::ProfInfo reportData = {0U};
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::ENQUEUE_DATA);
        reportData.itemId = transId;
        reportData.timeStamp = bqs::GetTimeStamp();
    }

    bqs::BqsMsprofManager::GetInstance().ReportApiPerf(reportData);
}

TEST_F(BqsMsprofManagerUTest, ReportEventPerfSuccess01)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_START;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);

    const uint32_t transId = 15;
    bqs::ProfInfo reportData = {0U};
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::ENQUEUE_DATA);
        reportData.itemId = transId;
        reportData.timeStamp = bqs::GetTimeStamp();
    }

    bqs::BqsMsprofManager::GetInstance().ReportEventPerf(reportData);
}

TEST_F(BqsMsprofManagerUTest, ReportEventPerfSuccess02)
{
    BqsMsprofManager profManager;
    const bool initFlag = true;
    const std::string cfgData = "{}";

    MOCKER_DLFCN();
    profManager.InitBqsMsprofManager(initFlag, cfgData);
    MsprofCommandHandle data = {0U};
    data.type = PROF_COMMANDHANDLE_TYPE_STOP;
    const auto ret = qstest::RunMsprofCallback(PROF_CTRL_SWITCH, &data, sizeof(data));
    EXPECT_EQ(ret, 0);

    const uint32_t transId = 15;
    bqs::ProfInfo reportData = {0U};
    if (bqs::BqsMsprofManager::GetInstance().IsStartProfling()) {
        reportData.type = static_cast<uint32_t>(bqs::DgwProfInfoType::ENQUEUE_DATA);
        reportData.itemId = transId;
        reportData.timeStamp = bqs::GetTimeStamp();
    }

    bqs::BqsMsprofManager::GetInstance().ReportEventPerf(reportData);
}

TEST_F(BqsMsprofManagerUTest, MsprofFinalizeNullptr)
{
    GlobalMockObject::verify();
    BqsMsprofApiAdapter apiAdapter("libaaaaa.so");
    EXPECT_EQ(apiAdapter.MsprofFinalize(), ProfStatus::PROF_MSPROF_API_NULLPTR);
}

TEST_F(BqsMsprofManagerUTest, MsprofRegTypeInfoNullptr)
{
    GlobalMockObject::verify();
    BqsMsprofApiAdapter apiAdapter("libaaaaa.so");
    EXPECT_EQ(apiAdapter.MsprofRegTypeInfo(0, 0, "typename"), ProfStatus::PROF_MSPROF_API_NULLPTR);
}

TEST_F(BqsMsprofManagerUTest, MsprofRegisterCallbackNullptr)
{
    GlobalMockObject::verify();
    BqsMsprofApiAdapter apiAdapter("libaaaaa.so");
    EXPECT_EQ(apiAdapter.MsprofRegisterCallback(0, 123), ProfStatus::PROF_MSPROF_API_NULLPTR);
}

TEST_F(BqsMsprofManagerUTest, MsprofReportApiNullptr)
{
    GlobalMockObject::verify();
    BqsMsprofApiAdapter apiAdapter("libaaaaa.so");
    EXPECT_EQ(apiAdapter.MsprofReportApi(0, nullptr), ProfStatus::PROF_MSPROF_API_NULLPTR);
}

TEST_F(BqsMsprofManagerUTest, MsprofReportEventNullptr)
{
    GlobalMockObject::verify();
    BqsMsprofApiAdapter apiAdapter("libaaaaa.so");
    EXPECT_EQ(apiAdapter.MsprofReportEvent(0, nullptr), ProfStatus::PROF_MSPROF_API_NULLPTR);
}

TEST_F(BqsMsprofManagerUTest, MsprofSysCycleTimeNullptr)
{
    GlobalMockObject::verify();
    BqsMsprofApiAdapter apiAdapter("libaaaaa.so");
    EXPECT_EQ(apiAdapter.MsprofSysCycleTime(), 0U);
}
