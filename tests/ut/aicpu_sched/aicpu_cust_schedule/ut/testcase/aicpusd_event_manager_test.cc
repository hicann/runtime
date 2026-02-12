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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "ascend_inpackage_hal.h"
#include "aicpusd_status.h"
#include "aicpu_context.h"
#include "aicpusd_interface.h"
#define private public
#include "aicpusd_monitor.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_op_executor.h"
#include "aicpusd_threads_process.h"
#include "aicpu_event_struct.h"
#include "aicpu_cust_sd_dump_process.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AicpuEventProcessManagerTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUScheduleTEST TearDown" << std::endl;
    }
};

TEST_F(AicpuEventProcessManagerTest, LoopProcessTest) {
    AicpuEventManager::GetInstance().runningFlag_ = false;
    AicpuEventManager::GetInstance().LoopProcess(0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AicpuEventProcessManagerTest, DoOnceTestSucc) {
    AicpuEventManager::GetInstance().DoOnce(0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AicpuEventProcessManagerTest, DoOnceTest1) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(1));
    AicpuEventManager::GetInstance().DoOnce(0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AicpuEventProcessManagerTest, DoOnceTest2) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(1));
    AicpuEventManager::GetInstance().DoOnce(0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AicpuEventProcessManagerTest, DoOnceTest3) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(1));
    AicpuEventManager::GetInstance().DoOnce(0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AicpuEventProcessManagerTest, DoOnceTest4) {
    AicpuEventManager::GetInstance().runningFlag_ = true;
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    AicpuEventManager::GetInstance().DoOnce(0);
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
    AicpuEventManager::GetInstance().runningFlag_ = false;
    EXPECT_EQ(AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_HWTS_001) {
    MOCKER_CPP(&AicpuCustDumpProcess::BeginDatadumpTask)
        .stubs()
        .will(returnValue(0));
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    char invalidKernelName[] = "";
    char invalidKernelSo[] = "";
    char kernelName[] = "CastV2";
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;

    // invalid kernelName addr
    eventMsg->kernel_info.kernelName = 0;
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    // invalid kernelName length
    eventMsg->kernel_info.kernelName = (uintptr_t)invalidKernelName;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // invalid kernelSo addr
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = 0;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    // invalid kernelSo length
    eventMsg->kernel_info.kernelSo = (uintptr_t)invalidKernelSo;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}


TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_HWTS_ACK_FAILED) {
    MOCKER(halEschedAckEvent)
    .stubs()
    .will(returnValue(5));
    event_info eventInfo;
    // Unknown event type
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcust_castv2.so";
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_HWTS_002) {
    event_info eventInfo;
    // Unknown event type
    eventInfo.comm.event_id = EVENT_DVPP_MSG;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU;
    // unsupport kernel type
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);


    char kernelName[] = "CastV2";
    char kernelSo[] = "libcust_castv2.so";
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_HWTS_003) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcust_castv2.so";
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    MOCKER_CPP(&CustomOpExecutor::ExecuteKernel).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    const auto ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_BindPid_Fail) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_AICPU_MSG;
    eventInfo.comm.subevent_id = AICPU_SUB_EVENT_BIND_SD_PID;
    AICPUBindSdPidEventMsg *eventMsg
        = reinterpret_cast<AICPUBindSdPidEventMsg *>(eventInfo.priv.msg);
    eventMsg->pid = 9527;
    // invalid msg len
    eventInfo.priv.msg_len = 2;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // bind pid success
    MOCKER_CPP(halMemBindSibling).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    eventInfo.priv.msg_len = sizeof(AICPUBindSdPidEventMsg);
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_BindPid) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_AICPU_MSG;
    eventInfo.comm.subevent_id = AICPU_SUB_EVENT_BIND_SD_PID;
    AICPUBindSdPidEventMsg *eventMsg
        = reinterpret_cast<AICPUBindSdPidEventMsg *>(eventInfo.priv.msg);
    eventMsg->pid = 9527;
    // invalid msg len
    eventInfo.priv.msg_len = 2;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // bind pid success
    eventInfo.priv.msg_len = sizeof(AICPUBindSdPidEventMsg);
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_OpenCustomSo) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_AICPU_MSG;
    eventInfo.comm.subevent_id = AICPU_SUB_EVENT_OPEN_CUSTOM_SO;
    AICPUOpenCustomSoEventMsg *eventMsg
        = reinterpret_cast<AICPUOpenCustomSoEventMsg *>(eventInfo.priv.msg);
    snprintf(eventMsg->kernelSoName, MAX_CUST_SO_NAME_LEN, "%s", "libcust_castv2.so");

    // invalid so name length
    eventInfo.priv.msg_len = MAX_CUST_SO_NAME_LEN + 1;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // open so failed
    eventInfo.priv.msg_len = strlen(eventMsg->kernelSoName);
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    eventInfo.priv.msg_len = strlen(eventMsg->kernelSoName);
    eventInfo.comm.subevent_id = 0;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_UNKNOW_AICPU_EVENT);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_RandomEvent) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_RANDOM_KERNEL;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_SplitEvent) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_SPLIT_KERNEL;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, 0);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_SplitEventFail) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_SPLIT_KERNEL;
    MOCKER_CPP(&ComputeProcess::DoSplitKernelTask).stubs().will(returnValue(false));
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_FAIL);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_FFTSEvent) {
    MOCKER_CPP(&AicpuCustDumpProcess::BeginDatadumpTask)
        .stubs()
        .will(returnValue(0));
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.comm.subevent_id = EVENT_FFTS_PLUS_MSG;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;

    // invalid kernelName addr
    eventMsg->kernel_info.kernelName = 0;
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_ProcSplitKernelEvent) {
    event_info eventInfo;
    MOCKER_CPP(&ComputeProcess::DoSplitKernelTask).stubs().will(returnValue(true));
    
    int32_t ret = AicpuEventManager::GetInstance().ProcSplitKernelEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuEventProcessManagerTest, ProcessEventTest_ProcRandomKernelEvent) {
    event_info eventInfo;
    MOCKER_CPP(&ComputeProcess::DoRandomKernelTask).stubs().will(returnValue(true));
    
    int32_t ret = AicpuEventManager::GetInstance().ProcRandomKernelEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}