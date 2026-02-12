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
#include <iostream>
#include <csignal>
#define private public
#define protected public
#include "driver/ascend_hal.h"
#include "securec.h"
#include "bind_relation.h"
#include "subscribe_manager.h"
#include "queue_manager.h"
#include "router_server.h"
#include "bqs_msg.h"
#include "bqs_status.h"
#include "qs_interface_process.h"
#include "queue_schedule_interface.h"
#include "common/bqs_util.h"
#include "queue_schedule_sub_module_interface.h"
#undef private
#undef protected
#include <iostream>
#include <fstream>
#undef private
#include <dlfcn.h>
#include <pwd.h>
#include "tsd.h"
using namespace std;
using namespace bqs;

namespace {
std::string GetWorkDir()
{
    struct passwd *user = getpwuid(getuid());
    if ((user == nullptr) || (user->pw_dir == nullptr)) {
        return "";
    }

    std::string pwDir = user->pw_dir;
    std::string workdir = pwDir + "/tmp/" + std::to_string(getpid()) + "qs_sub_module/";
    return workdir;
};
}

class QsSubModuleInterfaceUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    static void SetUpTestCase() {
        const std::string workDir = GetWorkDir();
        const std::string cmd = "mkdir -p " + workDir;
        (void) system(cmd.c_str());

        std::cout << "QsSubModuleInterfaceUtest setup cmd=" << cmd << std::endl;
    }

    static void TearDownTestCase() {
        const std::string workDir = GetWorkDir();
        const std::string cmd = "rm -rf " + workDir;
        (void) system(cmd.c_str());
        std::cout << "QsSubModuleInterfaceUtest teardown" << std::endl;
    }
};

TEST_F(QsSubModuleInterfaceUtest, StartQueueScheduleModule_001)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    setenv("REGISTER_TO_ASCENDMONITOR", "0", 1);
    MOCKER_CPP(&SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&SubModuleInterface::QsSubModuleAttachGroup).stubs().will(returnValue(true));
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(0));
    MOCKER_CPP(&SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(0));
    int32_t ret = StartQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, 0);
    MOCKER_CPP(&SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(0));
    ret = StopQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, StartQueueScheduleModule_002)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    MOCKER_CPP(&SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(false));
    int32_t ret = StartQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, StartQueueScheduleModule_003)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    MOCKER_CPP(&SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&SubModuleInterface::QsSubModuleAttachGroup).stubs().will(returnValue(false));
    int32_t ret = StartQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, StartQueueScheduleModule_004)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    MOCKER_CPP(&SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&SubModuleInterface::QsSubModuleAttachGroup).stubs().will(returnValue(true));
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(1));
    int32_t ret = StartQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, StartQueueScheduleModule_005)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    MOCKER_CPP(&SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&SubModuleInterface::QsSubModuleAttachGroup).stubs().will(returnValue(true));
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(0));
    MOCKER_CPP(&SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(1));
    int32_t ret = StartQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, StopQueueScheduleModule_001)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    MOCKER_CPP(&SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(0));
    auto ret = StopQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, StopQueueScheduleModule_002)
{
    TsdSubEventInfo eventInfo;
    eventInfo.deviceId = 0;
    eventInfo.hostPid = 123;
    eventInfo.dstPid = 456;
    eventInfo.procType = 1;
    eventInfo.srcPid = 789;
    eventInfo.startProcPid = 4568;
    MOCKER_CPP(&SubModuleInterface::ParseArgsFromFile).stubs().will(returnValue(true));
    MOCKER_CPP(&SubModuleInterface::QsSubModuleAttachGroup).stubs().will(returnValue(true));
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(0));
    MOCKER_CPP(&SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(0));
    int32_t ret = StartQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, 0);
    MOCKER_CPP(&SubModuleInterface::SendSubModuleRsponse).stubs().will(returnValue(1));
    ret = StopQueueScheduleModule(&eventInfo);
    EXPECT_EQ(ret, 0);
    GlobalMockObject::verify();
}

TEST_F(QsSubModuleInterfaceUtest, BuildArgsFilePathSuccess)
{
    const std::string filePath = "./aaaaa";
    MOCKER(remove, int(const char*)).stubs().will(returnValue(-1));
    SubModuleInterface::DeleteArgsFile(filePath);
    setenv("ENV_NAME_REG_ASCEND_MONITOR", "0", 1);
    SubModuleInterface::GetInstance().tsdEventKey_.deviceId = 1;
    SubModuleInterface::GetInstance().tsdEventKey_.vfId = 2;
    SubModuleInterface::GetInstance().tsdEventKey_.hostPid = 3;
    const std::string path = SubModuleInterface::GetInstance().BuildArgsFilePath();
    const uint32_t curPid = static_cast<uint32_t>(getpid());
    const std::string expect = "/home/mdc/queue_schedule_start_param_1_2_" + std::to_string(curPid);
    EXPECT_STREQ(path.c_str(), expect.c_str());
}

TEST_F(QsSubModuleInterfaceUtest, ParseArgsFromFile_001)
{
    std::string argsFile = "./argsFile";
    std::string cmd = "touch argsFile";
    system(cmd.c_str());
    FILE *file_fp = fopen(argsFile.c_str(), "a");
    if (file_fp != nullptr) {
        fprintf(file_fp, "%s", "testaaa");
        fclose(file_fp);
    }
    ArgsParser startParams;
    MOCKER_CPP(&SubModuleInterface::BuildArgsFilePath).stubs().will(returnValue(argsFile));
    auto ret = SubModuleInterface::GetInstance().ParseArgsFromFile(startParams);
    EXPECT_EQ(ret, false);
    SubModuleInterface::DeleteArgsFile(argsFile);
}

TEST_F(QsSubModuleInterfaceUtest, ParseArgsFromFile_002)
{
    std::string argsFile = "./argsFile";
    ArgsParser startParams;
    MOCKER_CPP(&SubModuleInterface::BuildArgsFilePath).stubs().will(returnValue(argsFile));
    auto ret = SubModuleInterface::GetInstance().ParseArgsFromFile(startParams);
    EXPECT_EQ(ret, false);
}

TEST_F(QsSubModuleInterfaceUtest, DeleteArgsFileSuccess01)
{
    const std::string filePath = "./aaaaa";
    MOCKER(remove, int(const char*)).stubs().will(returnValue(0));
    SubModuleInterface::DeleteArgsFile(filePath);
    EXPECT_EQ(SubModuleInterface::GetInstance().startFlag_.load(), false);
}

TEST_F(QsSubModuleInterfaceUtest, DeleteArgsFileFail01)
{
    const std::string filePath = "./aaaaa";
    MOCKER(remove, int(const char*)).stubs().will(returnValue(-1));
    SubModuleInterface::DeleteArgsFile(filePath);
    EXPECT_EQ(SubModuleInterface::GetInstance().startFlag_.load(), false);
}

TEST_F(QsSubModuleInterfaceUtest, QsSubModuleAttachGroup_001)
{
    ArgsParser startParams;
    startParams.withGroupName_ = false;
    auto ret = SubModuleInterface::GetInstance().QsSubModuleAttachGroup(startParams);
    EXPECT_EQ(ret, true);
}

TEST_F(QsSubModuleInterfaceUtest, QsSubModuleAttachGroup_002)
{
    ArgsParser startParams;
    startParams.withGroupName_ = true;
    startParams.groupName_ = "";
    auto ret = SubModuleInterface::GetInstance().QsSubModuleAttachGroup(startParams);
    EXPECT_EQ(ret, true);
}

TEST_F(QsSubModuleInterfaceUtest, QsSubModuleAttachGroup_003)
{
    ArgsParser startParams;
    startParams.withGroupName_ = true;
    startParams.groupName_ = "aa,bb";
    MOCKER(halGrpAttach).stubs().will(returnValue(0));
    auto ret = SubModuleInterface::GetInstance().QsSubModuleAttachGroup(startParams);
    EXPECT_EQ(ret, true);
}

TEST_F(QsSubModuleInterfaceUtest, QsSubModuleAttachGroup_004)
{
    ArgsParser startParams;
    startParams.withGroupName_ = true;
    startParams.groupName_ = "aa,bb";
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    auto ret = SubModuleInterface::GetInstance().QsSubModuleAttachGroup(startParams);
    EXPECT_EQ(ret, false);
}

TEST_F(QsSubModuleInterfaceUtest, SendSubModuleRsponseSuccess01)
{
    auto ret = SubModuleInterface::GetInstance().SendSubModuleRsponse(TSD_EVENT_START_QS_MODULE_RSP);
    EXPECT_EQ(ret, 0);
}