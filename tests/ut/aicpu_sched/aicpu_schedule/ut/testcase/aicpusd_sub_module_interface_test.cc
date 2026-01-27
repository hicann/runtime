/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include <dlfcn.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd.h"
#include "profiling_adp.h"
#include "aicpusd_status.h"
#define private public
#include "aicpusd_interface_process.h"
#include "aicpusd_sub_module_interface.h"
#undef private

using namespace AicpuSchedule;
class AicpusdSubModuleInterfaceTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "AicpusdSubModuleInterface SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        GlobalMockObject::verify();
        std::cout << "AicpusdSubModuleInterface TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpusdSubModuleInterfaceTest SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpusdSubModuleInterfaceTest TearDown" << std::endl;
    }
};

TEST_F(AicpusdSubModuleInterfaceTest, StartAicpuSchedulerModuleSuccess01)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::InitAICPUScheduler).stubs().will(returnValue(0));
    EXPECT_EQ(StartAicpuSchedulerModule(&eventInfo), 0);
}

TEST_F(AicpusdSubModuleInterfaceTest, StartAicpuSchedulerModuleFail01)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::InitAICPUScheduler).stubs().will(returnValue(1));
    EXPECT_EQ(StartAicpuSchedulerModule(&eventInfo), -1);
}

TEST_F(AicpusdSubModuleInterfaceTest, StartAicpuSchedulerModuleFail02)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(false));
    EXPECT_EQ(StartAicpuSchedulerModule(&eventInfo), -1);
}

TEST_F(AicpusdSubModuleInterfaceTest, StartAicpuSchedulerModuleFail03)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::InitAICPUScheduler).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::AttachHostGroup).stubs().will(returnValue(false));
    EXPECT_EQ(StartAicpuSchedulerModule(&eventInfo), -1);
}

TEST_F(AicpusdSubModuleInterfaceTest, StartAicpuSchedulerModuleFail04)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::InitAICPUScheduler).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::AttachHostGroup).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(1));
    EXPECT_EQ(StartAicpuSchedulerModule(&eventInfo), -1);
}

TEST_F(AicpusdSubModuleInterfaceTest, StopAicpuSchedulerModuleSuccess01)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::StopAICPUScheduler).stubs().will(returnValue(0));
    EXPECT_EQ(StopAicpuSchedulerModule(&eventInfo), 0);
}

TEST_F(AicpusdSubModuleInterfaceTest, StopAicpuSchedulerModuleSuccess02)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    SubModuleInterface::GetInstance().startFlag_ = true;
    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::StopAICPUScheduler).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuSchedule::SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(1));
    EXPECT_EQ(StopAicpuSchedulerModule(&eventInfo), -1);
}

TEST_F(AicpusdSubModuleInterfaceTest, StopAicpuSchedulerModuleSuccess03)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;

    MOCKER_CPP(&AicpuSchedule::AicpuScheduleInterface::StopAICPUScheduler).stubs().will(returnValue(0));
    SubModuleInterface::GetInstance().startFlag_ = false;
    EXPECT_EQ(StopAicpuSchedulerModule(&eventInfo), 0);
}

TEST_F(AicpusdSubModuleInterfaceTest, SetTsdEventKeySuccess01)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 5;
    eventInfo.hostPid = 8543;
    eventInfo.vfId = 13;
    SubModuleInterface::GetInstance().SetTsdEventKey(&eventInfo);
    EXPECT_EQ(SubModuleInterface::GetInstance().tsdEventKey_.deviceId, eventInfo.deviceId);
    EXPECT_EQ(SubModuleInterface::GetInstance().tsdEventKey_.hostPid, eventInfo.hostPid);
    EXPECT_EQ(SubModuleInterface::GetInstance().tsdEventKey_.vfId, eventInfo.vfId);
}

TEST_F(AicpusdSubModuleInterfaceTest, ParseArgsFromFileFail01)
{
    const std::string filePath = "./aaaaa";
    MOCKER(remove).stubs().will(returnValue(0));
    SubModuleInterface::DeleteArgsFile(filePath);

    ArgsParser startParas;
    SubModuleInterface::GetInstance().tsdEventKey_.deviceId = 1;
    SubModuleInterface::GetInstance().tsdEventKey_.vfId = 2;
    SubModuleInterface::GetInstance().tsdEventKey_.hostPid = 3;
    const bool ret = SubModuleInterface::GetInstance().ParseArgsFromFile(startParas);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpusdSubModuleInterfaceTest, BuildArgsFilePathSuccess01)
{
    const std::string filePath = "./aaaaa";
    MOCKER(remove).stubs().will(returnValue(-1));
    SubModuleInterface::DeleteArgsFile(filePath);

    SubModuleInterface::GetInstance().tsdEventKey_.deviceId = 1;
    SubModuleInterface::GetInstance().tsdEventKey_.vfId = 2;
    SubModuleInterface::GetInstance().tsdEventKey_.hostPid = 3;
    const std::string path = SubModuleInterface::GetInstance().BuildArgsFilePath();
    const uint32_t curPid = static_cast<uint32_t>(getpid());
    const std::string expect = "/home/HwHiAiUser/aicpu_sd_start_param_1_2_" + std::to_string(curPid);
    EXPECT_STREQ(path.c_str(), expect.c_str());
}

TEST_F(AicpusdSubModuleInterfaceTest, AttachHostGroupSuccess01)
{
    MOCKER(TsdReportStartOrStopErrCode).stubs().will(returnValue(1));
    SubModuleInterface::GetInstance().ReportErrMsgToTsd(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    SubModuleInterface::GetInstance().ReportErrMsgToTsd(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    SubModuleInterface::GetInstance().ReportErrMsgToTsd(AICPU_SCHEDULE_ERROR_DRV_ERR);
    SubModuleInterface::GetInstance().ReportErrMsgToTsd(10);

    ArgsParser startParas;
    startParas.grpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.qsGrpNameList_ = {"GrpA", "GrpB", "GrpC"};
    startParas.grpNameNum_ = 3;
    bool ret = SubModuleInterface::AttachHostGroup(startParas);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpusdSubModuleInterfaceTest, AttachHostGroupSuccess02)
{
    ArgsParser startParas;
    startParas.grpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.qsGrpNameList_ = {"GrpA", "GrpD"};
    startParas.grpNameNum_ = 3;
    bool ret = SubModuleInterface::AttachHostGroup(startParas);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpusdSubModuleInterfaceTest, AttachHostGroupSuccess03)
{
    ArgsParser startParas;
    startParas.grpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.qsGrpNameList_ = {"GrpA", "GrpB", "GrpC"};
    startParas.grpNameNum_ = 0;
    bool ret = SubModuleInterface::AttachHostGroup(startParas);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpusdSubModuleInterfaceTest, AttachHostGroupSuccess04)
{
    ArgsParser startParas;
    startParas.grpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.qsGrpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.grpNameNum_ = 3;
    bool ret = SubModuleInterface::AttachHostGroup(startParas);
    EXPECT_EQ(ret, true);
}

TEST_F(AicpusdSubModuleInterfaceTest, AttachHostGroupFail01)
{
    ArgsParser startParas;
    startParas.grpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.qsGrpNameList_ = {};
    startParas.grpNameNum_ = 1;
    bool ret = SubModuleInterface::AttachHostGroup(startParas);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpusdSubModuleInterfaceTest, AttachHostGroupFail02)
{
    ArgsParser startParas;
    startParas.grpNameList_ = {"GrpA", "GrpD", "GrpC"};
    startParas.qsGrpNameList_ = {"GrpA", "GrpD", "GrpE"};
    startParas.grpNameNum_ = 3;
    MOCKER(halGrpAttach).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_BUSY)));
    bool ret = SubModuleInterface::AttachHostGroup(startParas);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpusdSubModuleInterfaceTest, SendSubModuleRsponseSuccess01)
{
    SubModuleInterface::GetInstance().SendPidQosMsgToTsd(1U);
    auto ret = SubModuleInterface::GetInstance().SendSubModuleRsponse(TSD_EVENT_START_AICPU_SD_MODULE_RSP);
    EXPECT_EQ(ret, 0);
}
