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
#include <dlfcn.h>
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
#include "tsd.h"
#include "msprof_manager.h"
#include "common/bqs_feature_ctrl.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

static bool g_product_device_side = false;
RunContext GetRunContextFake()
{
    if (g_product_device_side) {
        return bqs::RunContext::DEVICE;
    } else {
        return bqs::RunContext::HOST;
    }
}

class QsInterfaceUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        backUpVariable();
        MOCKER(bqs::GetRunContext)
            .stubs()
            .will(invoke(GetRunContextFake));
    }

    virtual void TearDown()
    {
        recoverVariable();
        GlobalMockObject::verify();
    }
    static void SetUpTestCase()
    {
        std::cout << "QsInterfaceUtest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "QsInterfaceUtest TearDownTestCase" << std::endl;
    }

public:
    void backUpVariable()
    {
        is_product_device_ = g_product_device_side;
    }

    void recoverVariable()
    {
        g_product_device_side = is_product_device_;
    }

private:
    bool is_product_device_;
};

extern int32_t QueueScheduleMain(int32_t argc, char* argv[]);

TEST_F(QsInterfaceUtest, InitSucc)
{
    MOCKER_CPP(&QueueSchedule::WaitForStop)
    .stubs()
    .will(ignoreReturnValue());
    MOCKER_CPP(&QueueSchedule::StartQueueSchedule)
    .stubs()
    .will(returnValue(0));

    InitQsParams initQsParams = {};
    initQsParams.reschedInterval = 100U;
    initQsParams.runMode = bqs::QueueSchedulerRunMode::MULTI_PROCESS;
    initQsParams.pid = 1000;
    initQsParams.pidSign = "test\0";
    initQsParams.qsInitGrpName = "DEFAULT_NAME";
    EXPECT_EQ(QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams), 0);
    QueueScheduleInterface::GetInstance().WaitForStop();
}

TEST_F(QsInterfaceUtest, InitSuccWithProf)
{
    MOCKER_CPP(&QueueSchedule::WaitForStop)
    .stubs()
    .will(ignoreReturnValue());
    MOCKER_CPP(&QueueSchedule::StartQueueSchedule)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&BqsMsprofManager::InitBqsMsprofManager)
    .stubs()
    .will(ignoreReturnValue());

    InitQsParams initQsParams = {};
    initQsParams.reschedInterval = 100U;
    initQsParams.runMode = bqs::QueueSchedulerRunMode::MULTI_PROCESS;
    initQsParams.pid = 1000;
    initQsParams.pidSign = "test\0";
    initQsParams.qsInitGrpName = "DEFAULT_NAME";
    initQsParams.profCfgData = "{}";
    initQsParams.profFlag = true;
    EXPECT_EQ(QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams), 0);
    QueueScheduleInterface::GetInstance().WaitForStop();
}

TEST_F(QsInterfaceUtest, ThreadModeQsInterfaceSucc) {
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(InitQueueScheduler(0, 100), 0);
}

TEST_F(QsInterfaceUtest, MainTestSucc) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramLogLevelOk[] = "--logLevelInPid=103";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paramStarter[] = "--starter=1";
    char paramAbnormalInterval[] = "--abnormalInterval=20";
    char paramResIdOk[] = "--resIds=1,2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramLogLevelOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, paramStarter, paramAbnormalInterval,
                    paramResIdOk};
    int32_t argc = 12;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, MainTestSuccess02) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paramStarter[] = "--starter=1";
    char paramAbnormalInterval[] = "--abnormalInterval=20";
    char paramResIdOk[] = "--resIds=1,2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, paramStarter, paramAbnormalInterval,
                    paramResIdOk};
    int32_t argc = 11;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);

    setenv("ASCEND_GLOBAL_LOG_LEVEL", "3", 1);
    ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_starter) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "";
    char paramStarter[] = "--starter=a";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, paramStarter};
    int32_t argc = 9;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_deviceId) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=a";
    char paramPidErr[] = "--pid=b";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=c";
    char paramModeOk[] = "--deployMode=d";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";

    char* argv[] = {processName, paramDeviceIdOk, paramPidErr, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_pid) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=-10";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedErr[] = "--reschedInterval=c";
    char paramModeOk[] = "--deployMode=d";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedErr, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_reschedInterval) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=10";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedErr[] = "--reschedInterval=-100";
    char paramModeOk[] = "--deployMode=d";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedErr, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_deployMode) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=10";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeErr[] = "--deployMode=d";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeErr, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_vfId) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=10";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdErr[] = "--vfId=e";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdErr, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_deviceId_negative) {
    char processName[] = "queue_schedule";
    char paramDeviceIdErr[] = "--deviceId=-1";
    char paramPidOk[] = "--pid=10";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=e";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdErr, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_vfId_negative) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=10";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdErr[] = "--vfId=-10";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdErr, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_deviceId_undigital) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=mm";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedErr[] = "--reschedInterval=c";
    char paramModeOk[] = "--deployMode=d";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedErr, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_deployMode_negative) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramPidOk[] = "--pid=10000";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=1";
    char paramModeErr[] = "--deployMode=-1";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=";

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeErr, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_deviceId_missing) {
    char processName[] = "queue_schedule";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";

    char* argv[] = {processName, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 7;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgsFail_pid_missing) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";

    char* argv[] = {processName, paramDeviceIdOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 7;
    EXPECT_EQ(QueueScheduleMain(argc, argv), -1);
}

TEST_F(QsInterfaceUtest, ParseArgs_resIds_succ) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paraResIdsOk[] = "--resIds=0";
    char paraDevIdsOk[] = "--devIds=0,1";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));
    g_product_device_side = true;

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraGrpNameOk, paraResIdsOk, paraDevIdsOk};
    int32_t argc = 9;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, ParseArgs_resIds_fail) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paraResIdsOk[] = "--resIds=0,1";
    char paraDevIdsOk[] = "--devIds=0,11111111111111111111111111111111";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));
    g_product_device_side = true;

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraGrpNameOk, paraResIdsOk, paraDevIdsOk};
    int32_t argc = 9;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, ParseArgs_resIds_deviceIds_succ) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paraResIdsOk[] = "--resIds=0,1";
    char paraDevIdsOk[] = "--devIds=0,2,3";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));
    g_product_device_side = true;

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraGrpNameOk, paraResIdsOk, paraDevIdsOk};
    int32_t argc = 9;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, MainTestSuccess01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));
    g_product_device_side = true;

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraGrpNameOk};
    int32_t argc = 7;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, MainTestSuccessWithProf01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paraProfFlagOk[] = "--profFlag=1";
    char paraProfCfgDataOk[] = "--profCfgData={}";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));
    g_product_device_side = true;

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraGrpNameOk, paraProfCfgDataOk, paraProfFlagOk
                    };
    int32_t argc = 9;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&BqsMsprofManager::InitBqsMsprofManager)
        .stubs()
        .will(ignoreReturnValue());
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, MainAttachGroupFail) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=";
    char schedPolicy[] = "--schedPolicy=18446744073709551615";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, schedPolicy};
    int32_t argc = 9;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, error_report_00) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(dlopen).stubs().will(returnValue((void *)(nullptr)));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, error_report_01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(3));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}


TEST_F(QsInterfaceUtest, error_report_02) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

int32_t QsSubModuleProcessFake(const struct TsdSubEventInfo * const eventInfo)
{
    std::cout << "enter AicpuSchedulerSubModuleProcessFake" << std::endl;
    return 0;
}

void *dlsymStubQsMain(void *const soHandle, const char_t * const funcName)
{
    std::cout << "enter dlsymStub" << std::endl;
    return (reinterpret_cast<void *>(QsSubModuleProcessFake));
}
 
void *dlsymStubQsMainNull(void *const soHandle, const char_t * const funcName)
{
    std::cout << "enter dlsymStub null" << std::endl;
    return nullptr;
}

void *dlsymStubQsMain2(void *const soHandle, const char_t * const funcName)
{
    if (strncmp(funcName, "StartAicpuSchedulerModule", strlen("StartAicpuSchedulerModule")) == 0) {
        return (reinterpret_cast<void *>(QsSubModuleProcessFake));
    } else {
        return nullptr;
    }
}

TEST_F(QsInterfaceUtest, RegAicpuSchedulerModuleCallBack_01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubQsMain));
    MOCKER(dlclose).stubs().will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, RegAicpuSchedulerModuleCallBack_02) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0)).then(returnValue(-1));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubQsMain));
    MOCKER(dlclose).stubs().will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, RegAicpuSchedulerModuleCallBack_03) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubQsMain2));
    MOCKER(dlclose).stubs().will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, RegAicpuSchedulerModuleCallBack_04) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(-1));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubQsMain));
    MOCKER(dlclose).stubs().will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, RegAicpuSchedulerModuleCallBack_05) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(-1));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubQsMainNull));
    MOCKER(dlclose).stubs().will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, StopAiCpuSubModuleInQs_01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    uint64_t rest = 0;
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    MOCKER(dlopen).stubs().will(returnValue((void *)(&rest)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(invoke(dlsymStubQsMain));
    MOCKER(dlclose).stubs().will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler).stubs().will(returnValue(0));

    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(QsInterfaceUtest, MainParseArgsFail01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paraProfFlagOk[] = "--profFlag=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, paraProfFlagOk};
    int32_t argc = 8;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(3));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, MainTsdWaitForShutdownFail01) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paramStarter[] = "--starter=0";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, paramStarter};
    int32_t argc = 8;
    g_product_device_side = true;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(TsdWaitForShutdown)
        .stubs()
        .will(returnValue(-1));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, MainTsdWaitForShutdown02) {
    char processName[] = "queue_schedule";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramReschedOk[] = "--reschedInterval=100";
    char paramModeOk[] = "--deployMode=2";
    char paraVfIdOk[] = "--vfId=0";
    char paraGrpNameOk[] = "--qsInitGroupName=DEAFAULT";
    char paramStarter[] = "--starter=0";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk,
                    paramReschedOk, paramModeOk, paraVfIdOk, paraGrpNameOk, paramStarter};
    int32_t argc = 8;
    g_product_device_side = true;
    MOCKER_CPP(&QueueScheduleInterface::InitQueueScheduler)
        .stubs()
        .will(returnValue(0));
    std::out_of_range oor("This is out of range from mockcpp");
    MOCKER_CPP(TsdWaitForShutdown)
        .stubs()
        .will(throws(oor));
    int32_t ret = QueueScheduleMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(QsInterfaceUtest, InitQueueSchedulerFailWithStartQueueScheduleFail) {
    MOCKER_CPP(&QueueSchedule::StartQueueSchedule).stubs().will(returnValue(1));
    InitQsParams initQsParams = {};
    initQsParams.reschedInterval = 100U;
    initQsParams.runMode = bqs::QueueSchedulerRunMode::SINGLE_PROCESS;
    initQsParams.pid = 1000;
    initQsParams.starter = bqs::QsStartType::START_BY_TSD;
    int32_t ret = QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams);
    EXPECT_NE(ret, 0);
}

drvError_t drvQueryProcessHostPidFake1(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    *host_pid = 1;
    *cp_type = DEVDRV_PROCESS_QS;
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPidFake2(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_NO_PROCESS;
}

drvError_t drvQueryProcessHostPidFake3(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_INNER_ERR;
}

TEST_F(QsInterfaceUtest, CheckBindHostPid001) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake1));
    int32_t bindPidRet = qsInterface.CheckBindHostPid(1);
    EXPECT_EQ(bindPidRet, bqs::BQS_STATUS_OK);
}

TEST_F(QsInterfaceUtest, CheckBindHostPid002) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake2));
    int32_t bindPidRet = qsInterface.CheckBindHostPid(1);
    EXPECT_EQ(bindPidRet, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(QsInterfaceUtest, CheckBindHostPid003) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake3));
    int32_t bindPidRet = qsInterface.CheckBindHostPid(1);
    EXPECT_EQ(bindPidRet, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(QsInterfaceUtest, InitQueueSchedulerFailWithBindHostPidFail) {
    g_product_device_side = true;
    InitQsParams initQsParams = {};
    initQsParams.reschedInterval = 100U;
    initQsParams.runMode = bqs::QueueSchedulerRunMode::SINGLE_PROCESS;
    initQsParams.pid = 1000;
    initQsParams.starter = bqs::QsStartType::START_BY_TSD;
    int32_t ret = QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams);
    EXPECT_NE(ret, 0);
}

TEST_F(QsInterfaceUtest, InitQueueSchedulerFailWithGetDevCpuInfoFail) {
    g_product_device_side = true;
    InitQsParams initQsParams = {};
    initQsParams.reschedInterval = 100U;
    initQsParams.runMode = bqs::QueueSchedulerRunMode::SINGLE_PROCESS;
    initQsParams.pid = 1000;
    initQsParams.starter = bqs::QsStartType::START_BY_TSD;
    initQsParams.numaFlag = true;
    MOCKER_CPP(&BindCpuUtils::GetDevCpuInfo)
    .stubs()
    .will(returnValue(bqs::BQS_STATUS_PARAM_INVALID));
    int32_t ret = QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams);
    EXPECT_EQ(ret, 1);
    g_product_device_side = false;
    ret = QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams);
    EXPECT_EQ(ret, 1);
}

TEST_F(QsInterfaceUtest, GetAicpuPhysIndex001) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    qsInterface.aiCpuIds_ = {12, 34};
    uint32_t getResult = qsInterface.GetAicpuPhysIndexInVfMode(3, 0);
    EXPECT_EQ(getResult, 0);
    getResult = qsInterface.GetAicpuPhysIndexInVfMode(1, 0);
    EXPECT_EQ(getResult, 34);
}

TEST_F(QsInterfaceUtest, GetAicpuPhysIndex002) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    qsInterface.aiCpuIdsExtra_ = {56, 78};
    uint32_t getResult = qsInterface.GetExtraAicpuPhysIndexInVfMode(4, 0);
    EXPECT_EQ(getResult, 0);
    getResult = qsInterface.GetExtraAicpuPhysIndexInVfMode(0, 0);
    EXPECT_EQ(getResult, 56);
    qsInterface.aicpuNumExtra_ = 99;
    getResult = qsInterface.GetExtraAiCpuNum();
    EXPECT_EQ(getResult, 99);
}

TEST_F(QsInterfaceUtest, GetAicpuPhysIndex003) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    qsInterface.aiCpuIdsExtra_ = {89, 91};
    uint32_t getResult = qsInterface.GetExtraAicpuPhysIndex(0, 4);
    EXPECT_EQ(getResult, 0);
    getResult = qsInterface.GetExtraAicpuPhysIndex(0, 1);
    EXPECT_EQ(getResult, 91);
}

TEST_F(QsInterfaceUtest, ReportAbnormal001) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    MOCKER_CPP(&QueueSchedule::ReportAbnormal)
    .stubs()
    .will(returnValue(1));
    qsInterface.ReportAbnormal();
    EXPECT_NE(qsInterface.queueSchedule_, nullptr);
}

TEST_F(QsInterfaceUtest, GetAicpuPhysIndex_001) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    uint32_t ret = qsInterface.GetAicpuPhysIndex(0, 1);
    EXPECT_EQ(ret, 1); 
}

TEST_F(QsInterfaceUtest, GetAicpuPhysIndex_002) {
    QueueScheduleInterface &qsInterface = QueueScheduleInterface::GetInstance();
    MOCKER_CPP(&FeatureCtrl::BindCpuOnlyOneDevice).stubs().will(returnValue(true));
    uint32_t ret = qsInterface.GetAicpuPhysIndex(0, 1);
    EXPECT_EQ(ret, 34); 
}