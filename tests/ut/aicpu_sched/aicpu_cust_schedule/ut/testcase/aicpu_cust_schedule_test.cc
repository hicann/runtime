/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <unistd.h>
#include <linux/seccomp.h>
#include <stdlib.h>
#include <sys/file.h>
#include <sys/ioctl.h>
#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "slog.h"
#include "tsd.h"
#include "securec.h"
#define private public
#include "aicpusd_status.h"
#include "aicpu_pulse.h"
#include "profiling_adp.h"
#include "aicpu_context.h"
#include "ascend_hal.h"
#include "aicpusd_task_queue.h"
#include "aicpu_engine.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpu_sharder.h"
#include "dump_task.h"
#include "aicpusd_util.h"
#include "aicpusd_threads_process.h"
#include "core/aicpusd_interface_process.h"
#include "core/aicpusd_event_process.h"
#include "core/aicpusd_event_manager.h"
#include "aicpusd_monitor.h"
#include "core/aicpusd_worker.h"
#include "core/aicpusd_drv_manager.h"
#include "core/aicpusd_op_executor.h"
#include "common/aicpusd_common.h"
#include "aicpusd_resource_limit.h"
#include "aicpu_cust_sd_dump_process.h"
#include "aicpusd_args_parser.h"
#include "aicpu_cust_platform_info_process.h"
#include "aicpu_cust_sd_mc2_maintenance_thread_api.h"
#include "aicpu_cust_sd_mc2_maintenance_thread.h"
#include "aicpu_mc2_maintenance_thread.h"
#include "aicpusd_info.h"
#undef private

using namespace aicpu;
using namespace AicpuSchedule;

class AICPUCustScheduleTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUCustScheduleTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUCustScheduleTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUCustScheduleTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUCustScheduleTEST TearDown" << std::endl;
    }
};

namespace {
    constexpr uint64_t CHIP_MDC = 2U;
    constexpr uint64_t CHIP_CLOUD_V2 = 5U;
    drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        if (moduleType == 1 && infoType == 3) {
            *value = 14;
        }
        if (moduleType == 1 && infoType == 8) {
            *value = 65532;
        }

        if ((moduleType == MODULE_TYPE_SYSTEM) && (infoType == INFO_TYPE_VERSION)) {
            *value = CHIP_MDC << 8;
        }
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoFake2(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        if (moduleType == 1 && infoType == 3) {
            *value = 8;
        }
        if (moduleType == 1 && infoType == 8) {
            *value = 1020;
        }

        return DRV_ERROR_NONE;
    }

    hdcError_t drvHdcGetCapacityPCIE(struct drvHdcCapacity *capacity)
    {
        capacity->chanType = HDC_CHAN_TYPE_PCIE;
        return DRV_ERROR_NONE;
    }

    hdcError_t drvHdcGetCapacitySocket(struct drvHdcCapacity *capacity)
    {
        capacity->chanType = HDC_CHAN_TYPE_SOCKET;
        return DRV_ERROR_NONE;
    }

    hdcError_t drvHdcGetCapacityError(struct drvHdcCapacity *capacity)
    {
        capacity->chanType = HDC_CHAN_TYPE_PCIE;
        return DRV_ERROR_QUEUE_EMPTY;
    }

    drvError_t halEschedSubmitEventBatchPart(unsigned int devId, SUBMIT_FLAG flag,
        struct event_summary *events, unsigned int event_num, unsigned int *succ_event_num)
    {
        if (event_num >= 1) {
            *succ_event_num = event_num - 1;
        } else {
            *succ_event_num = event_num;
        }
        return DRV_ERROR_NONE;
    }
    drvError_t drvQueryProcessHostPidFake1(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        *host_pid = 1;
        *cp_type = DEVDRV_PROCESS_CP2;
        return DRV_ERROR_NONE;
    }

    drvError_t drvQueryProcessHostPidFake2(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        static uint32_t cnt = 0U;
        if (cnt == 0U) {
            ++cnt;
            return DRV_ERROR_NO_PROCESS;
        }

        return DRV_ERROR_UNINIT;
    }

    drvError_t drvQueryProcessHostPidFake3(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        return DRV_ERROR_INNER_ERR;
    }

    drvError_t drvQueryProcessHostPidFake4(int pid, unsigned int *chip_id, unsigned int *vfid,
                                       unsigned int *host_pid, unsigned int *cp_type)
    {
        static uint32_t cnt = 0U;
        if (cnt == 0) {
            ++cnt;
            *host_pid = 1;
            *cp_type = DEVDRV_PROCESS_CP1;
            return DRV_ERROR_NONE;
        }
        *host_pid = 2;
        *cp_type = DEVDRV_PROCESS_CP1;
        return DRV_ERROR_NONE;
    }

    drvError_t drvQueryProcessHostPidFake5(int pid, unsigned int *chip_id, unsigned int *vfid,
                                           unsigned int *host_pid, unsigned int *cp_type)
    {
        return DRV_ERROR_NO_PROCESS;
    }
}

extern int32_t SecureCompute();
extern int32_t ComputeProcessMain(int32_t argc, char* argv[]);

TEST_F(AICPUCustScheduleTEST, MainTest) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;

    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(StartUpRspAndWaitProcess)
        .stubs()
        .will(returnValue(1));
     ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, MainTestErr) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=0";
    char paramDeviceIdErr1[] = "--deviceId=20";
    char paramDeviceIdErr2[] = "--deviceId=0A";
    char paramAicpuPidOk[] = "--aicpuPid=1000";
    char paramAicpuPidErr[] = "--aicpuPid=-1000";
    char paramPidOk[] = "--pid=2";
    char paramPidErr[] = "--pid=-100";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramModeErr[] = "--profilingMode=100";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramLogLevelErr[] = "--logLevelInPid=0A";
    char paramVfIdOk[] = "--vfId=16";
    char paramVfIdErr1[] = "--vfId=20";
    char paramVfIdErr2[] = "--vfId=10A";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameListErr[] = "--groupNameList=";
    char groupNameListErr2[] = "--groupNameList=default";
    char groupNameNumOk[] = "--groupNameNum=2";
    char groupNameNumErr1[] = "--groupNameNum=a";
    char groupNameNumErr2[] = "--groupNameNum=-1";
    char paramLogLevelOk[] = "--logLevelInPid=0";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char *argv1[] = {processName};
    int32_t argc1 = 1;
    int32_t ret = ComputeProcessMain(argc1, argv1);
    EXPECT_EQ(ret, -1);

    char *argv2[] = {processName, paramDeviceIdErr1};
    int32_t argc2 = 2;
    ret = ComputeProcessMain(argc2, argv2);
    EXPECT_EQ(ret, -1);

    char *argv3[] = {processName, paramDeviceIdErr2};
    int32_t argc3 = 2;
    ret = ComputeProcessMain(argc3, argv3);
    EXPECT_EQ(ret, -1);

    char *argv4[] = {processName, paramDeviceIdOk};
    int32_t argc4 = 2;
    ret = ComputeProcessMain(argc4, argv4);
    EXPECT_EQ(ret, -1);

    char *argv5[] = {processName, paramDeviceIdOk, paramPidErr};
    int32_t argc5 = 3;
    ret = ComputeProcessMain(argc5, argv5);
    EXPECT_EQ(ret, -1);

    char *argv6[] = {processName, paramDeviceIdOk, paramPidOk};
    int32_t argc6 = 3;
    ret = ComputeProcessMain(argc6, argv6);
    EXPECT_EQ(ret, -1);

    char *argv7[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeErr};
    int32_t argc7 = 5;
    ret = ComputeProcessMain(argc7, argv7);
    EXPECT_EQ(ret, -1);

    char *argv8[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeOk};
    int32_t argc8 = 5;
    ret = ComputeProcessMain(argc8, argv8);
    EXPECT_EQ(ret, -1);

    char *argv9[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeOk, paramVfIdErr1};
    int32_t argc9 = 6;
    ret = ComputeProcessMain(argc9, argv9);
    EXPECT_EQ(ret, -1);

    char *argv10[] = {processName, paramDeviceIdOk, paramPidOk,  paramPidSignOk,  paramModeOk, paramVfIdErr2};
    int32_t argc10 = 6;
    ret = ComputeProcessMain(argc10, argv10);
    EXPECT_EQ(ret, -1);

    char *argv11[] = {processName, paramDeviceIdOk, paramPidOk,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelErr};
    int32_t argc11 = 7;
    ret = ComputeProcessMain(argc11, argv11);
    EXPECT_EQ(ret, -1);

    char *argv12[] = {processName, paramDeviceIdOk, paramPidOk,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameListOk, groupNameNumErr1};
    int32_t argc12 = 9;
    ret = ComputeProcessMain(argc12, argv12);
    EXPECT_EQ(ret, -1);


    char *argv13[] = {processName, paramDeviceIdOk, paramPidOk,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameListOk, groupNameNumErr2};
    int32_t argc13 = 9;
    ret = ComputeProcessMain(argc13, argv13);
    EXPECT_EQ(ret, -1);

    char *argv14[] = {processName, paramDeviceIdOk, paramPidOk,paramCustSoPath,paramAicpuPidOk,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameNumOk};
    int32_t argc14 = 10;
    ret = ComputeProcessMain(argc14, argv14);
    EXPECT_EQ(ret, -1);

    MOCKER(StartupResponse)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    char *argv15[] = {processName, paramDeviceIdOk, paramPidOk,paramCustSoPath,paramAicpuPidOk,groupNameListErr,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameNumOk};
    int32_t argc15 = 11;
    ret = ComputeProcessMain(argc15, argv15);
    EXPECT_EQ(ret, -1);

    char *argv16[] = {processName, paramDeviceIdOk, paramPidOk,paramCustSoPath,paramAicpuPidOk,groupNameListErr2,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameNumOk};
    int32_t argc16 = 11;
    ret = ComputeProcessMain(argc16, argv16);
    EXPECT_EQ(ret, -1);

    MOCKER(halGrpAttach)
        .stubs()
        .will(returnValue(1)).then(returnValue(0));
    char *argv17[] = {processName, paramDeviceIdOk, paramPidOk,paramCustSoPath,paramAicpuPidOk,groupNameListOk,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameNumOk};
    int32_t argc17 = 11;
    ret = ComputeProcessMain(argc17, argv17);
    EXPECT_EQ(ret, -1);

    MOCKER(halBuffInit)
        .stubs()
        .will(returnValue(1));
    char *argv18[] = {processName, paramDeviceIdOk, paramPidOk,paramCustSoPath,paramAicpuPidOk,groupNameListOk,
                      paramPidSignOk,  paramModeOk, paramVfIdOk, paramLogLevelOk, groupNameNumOk};
    int32_t argc18 = 11;
    ret = ComputeProcessMain(argc18, argv18);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, MainTest_regwarn) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;

    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER(RegEventMsgCallBackFunc)
        .stubs()
        .will(returnValue(-1));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

}


TEST_F(AICPUCustScheduleTEST, GetLogLevel_001)
{
    char processName[] = "aicpu_scheduler";
    char paramCcecpuLogLevel[] = "--ccecpuLogLevel=1";
    char paramAicpuLogLevel[] = "--aicpuLogLevel=1";
    MOCKER_CPP(&ArgsParser::CheckRequiredParas).stubs().will(returnValue(true));
    MOCKER_CPP(&ArgsParser::GetCcecpuLogLevel).stubs().will(returnValue(0));
    MOCKER_CPP(&ArgsParser::GetAicpuLogLevel).stubs().will(returnValue(0));
    MOCKER(dlog_setlevel).stubs().will(returnValue(0)).then(returnValue(-1)).then(returnValue(-1));
    MOCKER_CPP(&aicpu::AddToCgroup).stubs().will(returnValue(-1));
    char *argv[] = {processName, paramCcecpuLogLevel, paramAicpuLogLevel};
    int32_t argc = 3;
    auto ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

extern bool AddToCgroup();
TEST_F(AICPUCustScheduleTEST, AddToCgroup_ERROR)
{
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";

    MOCKER(system)
        .stubs()
        .will(returnValue(-1));
    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath};
    int32_t argc = 6;
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartSuccNoEvent) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halEschedGetEvent).stubs().will(returnValue(DRV_ERROR_NO_EVENT));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartDealError) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halEschedGetEvent).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartSucc) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartCreateWorkerFail) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_COMMON_ERROR)));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartFail_002) {
    MOCKER_CPP(&AicpuCustDumpProcess::InitDumpProcess)
        .stubs()
        .will(returnValue(0));
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(returnValue(DRV_ERROR_OUT_OF_MEMORY));
    AicpuSchedule::AicpuMonitor::GetInstance().done_ = false;
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStart_MemorySvmDevice) {
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacityPCIE));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStart_InitTaskMonitorContext_ERR) {
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacityPCIE));
    MOCKER(InitTaskMonitorContext)
        .stubs()
        .will(returnValue(1));
    char ch[] = "1234";
    AicpuSchedule::AicpuDrvManager::GetInstance().aicpuNum_ = 1U;
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 0, 0, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartBindSinlingFail) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halMemBindSibling).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartBindSinling_Fail_SVM_MEM_BIND_SVM_GRP) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halMemBindSibling).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    AicpuSchedule::AicpuDrvManager::GetInstance().needSafeVerify_ = true;
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR));
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartBindSinling_Fail_SVM_MEM_BIND_SVM_GRP_and_SVM_MEM_BIND_SP_GRP) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halMemBindSibling).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    AicpuSchedule::AicpuDrvManager::GetInstance().needSafeVerify_ = false;
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, PROFILING_OPEN, 100, 0, aicpu::AicpuRunMode::PROCESS_PCIE_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR));
}

TEST_F(AICPUCustScheduleTEST, AICPUEventBindSdPid_SVM_MEM_BIND_SVM_GRP_and_SVM_MEM_BIND_SP_GRP) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halMemBindSibling).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuSchedule::AicpuDrvManager::GetInstance().needSafeVerify_ = false;
    event_info_priv privEventInfo = {};
    AICPUBindSdPidEventMsg subEventInfo = {};
    memcpy_s(privEventInfo.msg, sizeof(subEventInfo), &subEventInfo, sizeof(subEventInfo));
    privEventInfo.msg_len = sizeof(AICPUBindSdPidEventMsg);
    int ret = AicpuEventProcess::GetInstance().AICPUEventBindSdPid(privEventInfo);
    EXPECT_EQ(ret, static_cast<int32_t>(DRV_ERROR_NONE));
}

TEST_F(AICPUCustScheduleTEST, AICPUEventBindSdPid_SVM_MEM_BIND_SVM_GRP) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    MOCKER(halMemBindSibling).stubs().will(returnValue(DRV_ERROR_NONE));
    AicpuSchedule::AicpuDrvManager::GetInstance().needSafeVerify_ = true;
    event_info_priv privEventInfo = {};
    AICPUBindSdPidEventMsg subEventInfo = {};
    memcpy_s(privEventInfo.msg, sizeof(subEventInfo), &subEventInfo, sizeof(subEventInfo));
    privEventInfo.msg_len = sizeof(AICPUBindSdPidEventMsg);
    int ret = AicpuEventProcess::GetInstance().AICPUEventBindSdPid(privEventInfo);
    EXPECT_EQ(ret, static_cast<int32_t>(DRV_ERROR_NONE));
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUScheduler_Fail) {
    char pidSign[] = "12345A";

    // halEschedCreateGrp failed
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    auto ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(0, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);

    // halEschedAttachDevice failed
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(0, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);

    // StopAICPUScheduler failed
    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    ret = AicpuScheduleInterface::GetInstance().StopAICPUScheduler(0);
    EXPECT_EQ(ret, 1);

    // StopAICPUScheduler failed
    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER_CPP(&FeatureCtrl::ShouldInitDrvThread).stubs().will(returnValue(true));
    ret = AicpuScheduleInterface::GetInstance().StopAICPUScheduler(0);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUScheduler_Fail1) {
    char pidSign[] = "12345A";
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ComputeProcess::Start)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(0, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_CP_FAILED);
}
TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUScheduler_Fail2) {
    char pidSign[] = "12345A";
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ComputeProcess::Start)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(100, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUScheduler_Fail3) {
    char pidSign[] = "12345A";
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ComputeProcess::Start)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuScheduleInterface::GetCurrentRunMode)
        .stubs()
        .will(returnValue(1));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(0, 2, pidSign, PROFILING_OPEN, 1, 0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUScheduler_Fail4) {
    char pidSign[] = "12345A";
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ComputeProcess::Start)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(0, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);

}

TEST_F(AICPUCustScheduleTEST, CheckBindHostPid001) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake1));
    drvMgr.hostPid_ = 1;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, CheckBindHostPid002) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake2));
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, CheckBindHostPid003) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake3));
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, CheckBindHostPid004) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake1));
    drvMgr.hostPid_ = 2;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, CheckBindHostPid005) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .will(invoke(drvQueryProcessHostPidFake5));
    drvMgr.hostPid_ = 2;
    int32_t bindPidRet = drvMgr.CheckBindHostPid();
    EXPECT_EQ(bindPidRet, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, InitDrvSchedModule_Succ) {
    AicpuDrvManager &drvMgr = AicpuDrvManager::GetInstance();
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    int32_t Ret = drvMgr.InitDrvSchedModule(0U);
    EXPECT_EQ(Ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUScheduler_Succ) {
    char pidSign[] = "12345A";
    MOCKER_CPP(&ComputeProcess::Start)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(0, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    // alread init, try again
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(1, 2, pidSign, PROFILING_OPEN, 1, 1, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, AICPUEventCustUpdateProfilingMode)
{
    event_info_priv eventInfoPriv;
    AICPUSubEventInfo subEventInfo = {0U};
    subEventInfo.modelId = 0U;
    subEventInfo.para.modeInfo.deviceId = 0U;
    subEventInfo.para.modeInfo.hostpId = static_cast<pid_t>(12345);
    subEventInfo.para.modeInfo.flag = 7U;
    memcpy_s(eventInfoPriv.msg, sizeof(subEventInfo), &subEventInfo, sizeof(subEventInfo));
    int ret = AicpuEventProcess::GetInstance().AICPUEventCustUpdateProfilingMode(eventInfoPriv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, GetCurrentRunModeThread) {
    bool isOnline = false;
    aicpu::AicpuRunMode runMode;
    auto ret = AicpuScheduleInterface::GetInstance().GetCurrentRunMode(isOnline, runMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(runMode, AicpuRunMode::THREAD_MODE);
}

TEST_F(AICPUCustScheduleTEST, GetCurrentRunModePCIE) {
    bool isOnline = true;
    aicpu::AicpuRunMode runMode;
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacityPCIE));
    auto ret = AicpuScheduleInterface::GetInstance().GetCurrentRunMode(isOnline, runMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(runMode, AicpuRunMode::PROCESS_PCIE_MODE);
}

TEST_F(AICPUCustScheduleTEST, GetCurrentRunModeSocket) {
    bool isOnline = true;
    aicpu::AicpuRunMode runMode;
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacitySocket));
    auto ret = AicpuScheduleInterface::GetInstance().GetCurrentRunMode(isOnline, runMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(runMode, AicpuRunMode::PROCESS_SOCKET_MODE);
}


TEST_F(AICPUCustScheduleTEST, GetCurrentRunModeError) {
    bool isOnline = true;
    aicpu::AicpuRunMode runMode;
    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(invoke(drvHdcGetCapacityError));
    auto ret = AicpuScheduleInterface::GetInstance().GetCurrentRunMode(isOnline, runMode);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, DumpDataFailTEST) {
    const uint32_t taskId = 111;
    const uint32_t streamId = 1;
    const uint32_t modelId = 222;

    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_n a.m\\ /e");
    op->set_op_type("op_t y.p\\e/ rr");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    aicpu::dump::Shape *originShape = output->mutable_origin_shape();
    originShape->add_dim(2);
    originShape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(&p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(2);
    inShape->add_dim(2);
    aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
    inputOriginShape->add_dim(2);
    inputOriginShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    input->set_address(reinterpret_cast<uint64_t>(&p));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    int32_t ret = 0;
    // load op mapping info
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());

    // task not exist
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId + 1), AICPU_SCHEDULE_OK);

    // op mapping info is nullptr
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(nullptr, 1), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    // op mapping info parse fail
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), 1), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // loop cond addr is null
    output->set_data_type(dataType);
    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(0LLU);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_OK);
    EXPECT_EQ(opDumpTaskMgr.DumpOpInfo(streamId, taskId), AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // invalied dump step
    opMappingInfo.set_dump_step("1000000000000000000000000000000000000000000000000000000000000");
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    // unload model
    opMappingInfo.set_flag(0x00);
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    // Flag invalid
    opMappingInfo.set_flag(0x02);
    opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());

}
namespace aicpu {

#pragma pack(push, 1)
struct AicpuParamHead
{
    uint32_t        length;                    // Total length: include cunstom message
    uint32_t        ioAddrNum;                 // Input and output address number
    uint32_t        extInfoLength;             // extInfo struct Length
    uint64_t        extInfoAddr;               // extInfo address
};
#pragma pack(pop)

}  // namespace aicpu

TEST_F(AICPUCustScheduleTEST, SingleOpOrUnknownShapeOpDumpTest) {
    const int32_t dataType = 7; //int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");

    uint64_t stepId = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    aicpu::dump::Task *task = opMappingInfo.add_task();

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("handsome");
    op->set_op_type("Handsome");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(2);
    inShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &(inData[0]);
    input->set_address(reinterpret_cast<uint64_t>(q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    uint64_t protoSize = opMappingInfoStr.size();

    HwtsTsKernel kernelInfo = { };
    kernelInfo.kernelType = aicpu::KERNEL_TYPE_AICPU_CUSTOM;
    kernelInfo.kernelBase.cceKernel.kernelSo = 0;
    const char *kernelName = "DumpDataInfo";
    kernelInfo.kernelBase.cceKernel.kernelName = uint64_t(kernelName);
    const uint32_t singleOpDumpParamNum = 2;
    const uint32_t paramLen =  sizeof(AicpuParamHead) + singleOpDumpParamNum*sizeof(uint64_t);
    std::unique_ptr<char[]> buff(new (std::nothrow) char[paramLen]);
    if (buff == nullptr) {
        return;
    }
    AicpuParamHead *paramHead = (AicpuParamHead*)(buff.get());
    paramHead->length = paramLen;
    paramHead->ioAddrNum = 2;
    uint64_t *param = (uint64_t*)((char*)(buff.get()) + sizeof(AicpuParamHead));
    param[0] = uint64_t(opMappingInfoStr.data());
    param[1] = uint64_t(&protoSize);
    kernelInfo.kernelBase.cceKernel.paramBase = uint64_t(buff.get());

    const aicpu::HwtsTsKernel &tsKernelInfo = kernelInfo;
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    // dump op has two param, one is protobuf addr
    const size_t len =  sizeof(aicpu::AicpuParamHead) + (singleOpDumpParamNum * sizeof(uint64_t));
    const auto ioAddrBase = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(kernel.paramBase +
                                                                                sizeof(aicpu::AicpuParamHead)));
    const uint64_t opMappingInfoAddr = ioAddrBase[0];
    const uint64_t * const lenAddr = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(ioAddrBase[1]));
    const uint64_t opMappingInfoLen = *lenAddr;

    const AicpuSchedule::OpDumpTaskManager &dumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
    auto ret = dumpTaskMgr.DumpOpInfoForUnknowShape(opMappingInfoAddr, opMappingInfoLen);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = dumpTaskMgr.DumpOpInfoForUnknowShape(0, opMappingInfoLen);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}
namespace AicpuSchedule {
bool StubCheckOverflow1(int32_t &result)
{
    result = AICPU_SCHEDULE_ERROR_UNDERFLOW;
    return true;
}
bool StubCheckOverflow2(int32_t &result)
{
    result = AICPU_SCHEDULE_ERROR_OVERFLOW;
    return true;
}
bool StubCheckOverflow3(int32_t &result)
{
    result = AICPU_SCHEDULE_ERROR_DIVISIONZERO;
    return true;
}

void ResetFpsrStub() {}
}

TEST_F(AICPUCustScheduleTEST, ProcessOutputDump_baseaddr_null) {
    ::toolkit::dumpdata::DumpData dumpData;
    ::toolkit::dumpdata::OpBuffer *opBuffer = dumpData.add_buffer();
    int32_t data[4] = {1, 2, 3, 4};
    int *p = &data[0];
    if (opBuffer != nullptr) {

        opBuffer->set_buffer_type(::toolkit::dumpdata::BufferType::L1);
        opBuffer->set_size(sizeof(data));
        uint64_t baseAddr = uint64_t(p);
        OpDumpTask task(0, 0);
        task.opBufferAddr_.push_back(baseAddr);
        auto ret = task.ProcessOpBufferDump(dumpData, "", IdeDumpStart(nullptr));
        EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
        task.opBufferAddr_[0] = 0;
        ret = task.ProcessOpBufferDump(dumpData, "", IdeDumpStart(nullptr));
        EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUCustScheduleTEST, OpDumpTaskManager_tset) {
    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    std::set<TaskInfo> tasksInfo;
    const uint32_t taskId = 111;
    const uint32_t streamId = 1;
    TaskInfo taskInfo(streamId, taskId);
    (void)tasksInfo.insert(taskInfo);
    opDumpTaskMgr.modelIdToTask_.insert(std::make_pair(1, std::move(tasksInfo)));
    opDumpTaskMgr.ClearResource();
    opDumpTaskMgr.UpdateDumpNumByModelId(1);

    std::vector<std::shared_ptr<OpDumpTask>> opDumptasks;
    std::shared_ptr<OpDumpTask> opDumpTask(new OpDumpTask(0, 0));
    opDumptasks.push_back(std::move(opDumpTask));
    opDumpTaskMgr.ProcessEndGraph(opDumptasks);
    EXPECT_EQ(OpDumpTaskManager::GetInstance().modelIdToTask_.empty(), true);
}

TEST_F(AICPUCustScheduleTEST, OpDumpTask_tset) {
    OpDumpTask task(0, 0);
    task.UpdateDumpNum();
    uint32_t modelId = 1;
    task.optionalParam_.hasModelId = true;
    EXPECT_EQ(task.GetModelId(modelId), true);
    uint64_t dumpNum = 1;
    task.optionalParam_.hasStepId = true;
    task.optionalParam_.stepIdAddr = nullptr;
    auto ret = task.GetDumpNumber(dumpNum);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    task.optionalParam_.stepIdAddr = &dumpNum;
    task.optionalParam_.hasIterationsPerLoop = true;
    task.optionalParam_.iterationsPerLoopAddr = nullptr;
    ret = task.GetDumpNumber(dumpNum);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    task.optionalParam_.iterationsPerLoopAddr = &dumpNum;
    task.optionalParam_.loopCondAddr = &dumpNum;
    ret = task.GetDumpNumber(dumpNum);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    DumpStep dumpStep;
    dumpStep.DebugString();
}

TEST_F(AICPUCustScheduleTEST, ProcessInputDump_dump_fail) {
    ::toolkit::dumpdata::DumpData dumpData;
    ::toolkit::dumpdata::OpInput *opInput = dumpData.add_input();
    if (opInput != nullptr) {
        int64_t data = 0;
        uint64_t addr = (uint64_t)(&data);
        OpDumpTask task(0, 0);
        opInput->set_size(sizeof(data));
        task.inputsBaseAddr_.push_back((uint64_t)(&addr));
        task.buffSize_ = 4;
		task.offset_ = 0;
        task.buff_.reset(new char[task.buffSize_]);
        MOCKER(IdeDumpData)
            .stubs()
            .will(returnValue(IDE_DAEMON_UNKNOW_ERROR));
        EXPECT_EQ(task.ProcessInputDump(dumpData, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
		task.inputsBaseAddr_.pop_back();
		task.inputsBaseAddr_.push_back((uint64_t)(0));
		task.offset_ = 0;
		task.ProcessInputDump(dumpData, "", IdeDumpStart(nullptr));
        task.isSingleOrUnknowShapeOp_ = 1;
		task.ProcessInputDump(dumpData, "", IdeDumpStart(nullptr));
		opInput->set_size(0);
		task.offset_ = 0;
		task.ProcessInputDump(dumpData, "", IdeDumpStart(nullptr));
    }
}
uint32_t CastV3KFC(void * parm)
{
    return 0;
}
TEST_F(AICPUCustScheduleTEST, ProcessHWTSKernelEvent_CUSTOM_KFC_UTest) {
    MOCKER(dlsym).stubs().will(returnValue((void *)CastV3KFC));
    event_info eventInfo = {
                                .comm = {
                                    .event_id = EVENT_TEST,
                                    .subevent_id = 2,
                                    .pid = 3,
                                    .host_pid = 4,
                                    .grp_id = 5,
                                    .submit_timestamp = 6,
                                    .sched_timestamp = 7
                                },
                                .priv = {
                                    .msg_len = EVENT_MAX_MSG_LEN,
                                    .msg = {0}
                                }
                            };
    eventInfo.comm.event_id = EVENT_TS_HWTS_KERNEL;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM_KFC;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV3KFC";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    int ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    uint16_t version = 1;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, ProcessHWTSKernelEventTest_failed) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    (reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg))->cmd_type = AICPU_DATADUMP_LOADINFO;
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask)
        .stubs()
        .will(returnValue(0));
    MOCKER(AicpuUtil::ResetFpsr).stubs().will(invoke(AicpuSchedule::ResetFpsrStub));
    (reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg))->cmd_type = 65535;
    const int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AICPUCustScheduleTEST, ProcessCtrlEventTestMsg) {
    event_info eventInfo;
    TsAicpuSqe sqe;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(TsAicpuSqe);
    TsAicpuSqe *sqePtr = reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg);
    sqePtr->cmd_type = AICPU_MSG_VERSION;
    sqePtr->u.aicpu_msg_version.magic_num = 0x5A5A;
    sqePtr->u.aicpu_msg_version.version = 0;
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER_CPP(&AicpuSqeAdapter::AicpuMsgVersionResponseToTs)
        .stubs()
        .will(returnValue(1));
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    uint16_t version = 1;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    sqePtr->cmd_type = TS_AICPU_MSG_VERSION;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVALID_MAGIC_NUM);
    MOCKER_CPP(&AicpuSqeAdapter::AicpuMsgVersionResponseToTs)
    .stubs()
    .will(returnValue(1));
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVALID_MAGIC_NUM);
    sqePtr->u.aicpu_msg_version.magic_num = 0x5A5B;
    ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVALID_MAGIC_NUM);
}

TEST_F(AICPUCustScheduleTEST, ProcessDataDumpInfoLoad_succ) {
    event_info eventInfo;
    TsAicpuMsgInfo msgInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    TsAicpuMsgInfo *msgInfoPtr = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);
    msgInfoPtr->cmd_type = AICPU_DATADUMP_LOADINFO;
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    uint16_t version = 1;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    MOCKER_CPP(&OpDumpTaskManager::LoadOpMappingInfo)
        .stubs()
        .will(returnValue(0));
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, ProcessCmdType_fail) {
    event_info eventInfo;
    TsAicpuMsgInfo msgInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    TsAicpuMsgInfo *msgInfoPtr = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);
    msgInfoPtr->cmd_type = TS_INVALID_AICPU_CMD;
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    uint16_t version = 1;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AICPUCustScheduleTEST, ProcessDataDumpInfoLoadNoVersion_fail) {
    event_info eventInfo;
    TsAicpuMsgInfo msgInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    TsAicpuMsgInfo *msgInfoPtr = reinterpret_cast<TsAicpuMsgInfo *>(eventInfo.priv.msg);
    msgInfoPtr->cmd_type = AICPU_DATADUMP_LOADINFO;
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    uint16_t version = 5;
    MOCKER_CPP(&FeatureCtrl::GetTsMsgVersion)
        .stubs()
        .will(returnValue(version));
    MOCKER_CPP(&OpDumpTaskManager::LoadOpMappingInfo)
        .stubs()
        .will(returnValue(0));
    int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    AicpuSqeAdapter ada(5U);
    ret = ada.AicpuDataDumpLoadResponseToTs(0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION);
}

TEST_F(AICPUCustScheduleTEST, adapterTest) {
    AicpuSqeAdapter ada(0U);
    EXPECT_EQ(ada.IsAdapterInvalidParameter(), true);
    TsAicpuMsgInfo info;
    uint32_t handle = 0;
    uint32_t devid = 0;
    uint32_t tsId = 0;
    MOCKER_CPP(tsDevSendMsgAsync)
        .stubs()
        .will(returnValue(0));
    uint32_t ret = ada.ResponseToTs(info, handle, devid, tsId);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    hwts_response_t rep{};
    EVENT_ID eventid = 0;
    uint32_t subid = 0;
    MOCKER_CPP(halEschedAckEvent)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = ada.ResponseToTs(rep, devid, eventid, subid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    AicpuSqeAdapter ada1(5U);
    AicpuSqeAdapter::AicpuDataDumpInfoLoad infoLoad{};
    ada1.GetAicpuDataDumpInfoLoad(infoLoad);
}

TEST_F(AICPUCustScheduleTEST, ProcessHWTSKernelEventTest_failedResetFpsr) {
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    (reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg))->cmd_type = AICPU_DATADUMP_LOADINFO;
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask)
        .stubs()
        .will(returnValue(0));
    (reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg))->cmd_type = 65535;
    const int32_t ret = AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT);
}

TEST_F(AICPUCustScheduleTEST, DumpDataLoadOpMappingInfo) {
    const uint32_t taskId = 11;
    const uint32_t streamId = 1;
    const uint32_t modelId = 22;
    const int32_t dataType = 3;
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model_n a.m\\ /e");
    opMappingInfo.set_model_id(modelId);

    uint64_t stepId = 1;
    uint64_t iterationsPerLoop = 1;
    uint64_t loopCond = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));

    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);
    task->set_context_id(INVALID_VAL);

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("op_n a.m\\ /e");
    op->set_op_type("op_t y.p\\e/ rr");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(&p));
    output->set_original_name("original_name");
    output->set_original_output_index(11);
    output->set_original_output_data_type(dataType);
    output->set_original_output_format(1);
    output->set_size(sizeof(data));
    aicpu::dump::DimRange *dimRange = output->add_dim_range();
    dimRange->set_dim_start(1);
    dimRange->set_dim_end(2);

    aicpu::dump::Output *output1 = task->add_output();
    output1->set_data_type(dataType);
    output1->set_format(1);
    int32_t data2[4] = {1, 2, 3, 4};
    int *p2 = &data2[0];
    aicpu::dump::Shape *shape1 = output1->mutable_shape();
    shape1->add_dim(-1);
    shape1->add_dim(2);
    output1->set_size(sizeof(data2));
    output1->set_addr_type(aicpu::dump::AddressType::NOTILING_ADDR); // aicpu::dump::AddressType::NOTILING_ADDR

    aicpu::dump::OpBuffer *opBuffer = task->add_buffer();
    opBuffer->set_buffer_type(aicpu::dump::BufferType::L1);
    opBuffer->set_address(uint64_t(p));
    opBuffer->set_size(sizeof(data));

    aicpu::dump::Input *input = task->add_input();
    input->set_data_type(dataType);
    input->set_format(1);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &inData[0];
    aicpu::dump::Shape *inShape = input->mutable_shape();
    inShape->add_dim(-1);
    inShape->add_dim(2);
    input->set_size(sizeof(inData));

    // std::cout << "total size: " << opMappingInfo.ByteSize() <<std::endl;
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    event_info eventInfo;
    eventInfo.comm.event_id = EVENT_TS_CTRL_MSG;
    eventInfo.priv.msg_len = sizeof(hwts_ts_task);
    struct hwts_ts_task *eventMsg = reinterpret_cast<hwts_ts_task *>(eventInfo.priv.msg);
    eventMsg->mailbox_id = 1;
    eventMsg->serial_no = 9527;
    eventMsg->kernel_info.kernel_type = KERNEL_TYPE_AICPU_CUSTOM;
    eventMsg->kernel_info.streamID = 203;
    char kernelName[] = "CastV2";
    char kernelSo[] = "libcpu_kernels.so";
    eventMsg->kernel_info.kernelName = (uintptr_t)kernelName;
    eventMsg->kernel_info.kernelSo = (uintptr_t)kernelSo;
    (reinterpret_cast<TsAicpuSqe *>(eventInfo.priv.msg))->cmd_type = AICPU_DATADUMP_LOADINFO;
    MOCKER_CPP(&AicpuEventProcess::ExecuteTsKernelTask)
        .stubs()
        .will(returnValue(0));
    MOCKER(AicpuUtil::ResetFpsr).stubs().will(invoke(AicpuSchedule::ResetFpsrStub));

    TsAicpuSqe * ctrlMsg = reinterpret_cast< TsAicpuSqe *>(eventInfo.priv.msg);
    TsToAicpuDataDumpInfoLoad &info = (*ctrlMsg).u.ts_to_aicpu_datadumploadinfo;
    info.dumpinfoPtr = (uint64_t)opMappingInfoStr.c_str();
    info.length = opMappingInfoStr.length();
    AicpuEventManager::GetInstance().ProcessEvent(eventInfo, 0);

    OpDumpTaskManager &opDumpTaskMgr = OpDumpTaskManager::GetInstance();
    // load op mapping info
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()), AICPU_SCHEDULE_OK);

    task->set_task_id(65536U);

    opMappingInfo.SerializeToString(&opMappingInfoStr);
    EXPECT_EQ(opDumpTaskMgr.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length()),
        AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, ProcessCustOpWorkspaceDumpFailTes) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = sizeof(data);
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(0);
        task.buffSize_ = data_size;

        // 预期打印 [ERROR] op space[0] addr is null
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);

        workSpace->set_size(0);
        task.buffSize_ = data_size;
        task.opWorkspaceAddr_[0] = data;
        // 预期打印 [ERROR] data size is zero
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUCustScheduleTEST, ProcessCustOpWorkspaceDumpSuccessTest) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = sizeof(data);
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(data_size);
        task.buffSize_ = data_size;
        // 预期无 [ERROR] 打印
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUCustScheduleTEST, ProcessCustOpWorkspaceDumpSuccessTest_bigsize) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = 100000;
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(data_size);
        task.buffSize_ = data_size;
        // 预期无 [ERROR] 打印
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_OK);
    }
}

TEST_F(AICPUCustScheduleTEST, ProcessCustOpWorkspaceDumpSuccessTest_memcpy_s_Fail1) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = sizeof(data);
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(data_size);
        task.buffSize_ = data_size;
        // 预期 [AICPU_SCHEDULE_ERROR_DUMP_FAILED] 打印
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUCustScheduleTEST, ProcessCustOpWorkspaceDumpSuccessTest_dump_Fail2) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    int32_t data[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
    uint64_t data_size = sizeof(data);
    OpDumpTask task(0, 0);
    uint64_t data_addr = data;
    ::toolkit::dumpdata::Workspace *workSpace = task.baseDumpData_.add_space();
    if (workSpace != nullptr) {
        workSpace->set_size(data_size);
        task.opWorkspaceAddr_.push_back(data_size);
        task.buffSize_ = data_size;
        // 预期 [AICPU_SCHEDULE_ERROR_DUMP_FAILED] 打印
        EXPECT_EQ(task.ProcessOpWorkspaceDump(task.baseDumpData_, "", IdeDumpStart(nullptr)), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    }
}

TEST_F(AICPUCustScheduleTEST, PreProcessWorkspaceSuccessTest) {
    MOCKER_CPP(&IdeDumpData)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)111));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    OpDumpTask opDumpTask(0, 0);
    aicpu::dump::OpMappingInfo opMappingInfo;
    {
        const uint32_t taskId = 402;
        const uint32_t streamId = 402;
        int32_t input[8] = {1, 2, 3, 4, 5, 6, 7 ,8};
        int32_t *inputaddress = &input[0];
        int32_t inputSize = sizeof(input);
        int32_t inputoffset = 0;
        int32_t data[10] = {1, 2, 3, 4, 5, 6, 7 ,8, 9, 10}; // workspace
        const int32_t dataType = 7; // int32
        opMappingInfo.set_dump_path("dump_path");
        opMappingInfo.set_model_name("model_n a.m\\ /e");
        uint64_t stepId = 1;
        uint64_t iterationsPerLoop = 1;
        opMappingInfo.set_flag(0x01);
        aicpu::dump::Task *task = opMappingInfo.add_task();
        {
            task->set_task_id(taskId+1);
            task->set_stream_id(streamId+1);
            // input
            aicpu::dump::Input *input = task->add_input();
            {
                input->set_data_type(dataType);
                input->set_format(1);
                aicpu::dump::Shape *inShape = input->mutable_shape();
                {
                    inShape->add_dim(2);
                    inShape->add_dim(2);
                }
                input->set_address(reinterpret_cast<uint64_t>(&inputaddress));
                aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
                {
                    inputOriginShape->add_dim(2);
                    inputOriginShape->add_dim(2);
                }
                input->set_addr_type(0);
                input->set_size(inputSize);
                input->set_offset(inputoffset);
            }
            aicpu::dump::Op *op = task->mutable_op();
            {
                op->set_op_name("op_n a.m\\ /e");
                op->set_op_type("op_t y.p\\e/ rr");
            }
            // Workspace
            aicpu::dump::Workspace *space = task->add_space();
            {
                space->set_type(aicpu::dump::Workspace::LOG);
                space->set_data_addr(0); // task0 的data_addr为0
                space->set_size(sizeof(data));
            }
        }
    }
    ::toolkit::dumpdata::DumpData dumpData;
    aicpu::dump::Task task = opMappingInfo.task().at(0);
    EXPECT_EQ(opDumpTask.PreProcessWorkspace(task, dumpData), AICPU_SCHEDULE_OK);
}

// 此用例请务必保证最后执行，可能影响其余用例的正常运行
TEST_F(AICPUCustScheduleTEST, MainTestWithVf) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=1";
    char paramGrpNameOk[] = "--groupNameList=Grp1";
    char paramGrpNumOk[] = "--groupNameNum=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramCustSoPath, paramAicpuPid, paramLogLevelOk,
                     paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 11;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCustScheduleTEST, custMainTestWithVf_openFail) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char paramVfId[] = "--vfId=1";
    char paramGrpNameOk[] = "--groupNameList=Grp1";
    char paramGrpNumOk[] = "--groupNameNum=1";
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
        MOCKER(open, int(const char*, int)).stubs().will(returnValue(-1));
    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk,
                     paramModeOk, paramCustSoPath, paramAicpuPid, paramLogLevelOk,
                     paramVfId, paramGrpNameOk, paramGrpNumOk };
    int32_t argc = 11;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUSchedulerVF_Succ) {
    AicpuScheduleInterface::GetInstance().StopAICPUScheduler(0);
    char pidSign[] = "12345A";
    MOCKER_CPP(&ComputeProcess::Start)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid)
        .stubs()
        .will(returnValue(0));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(32, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, ComputeProcessStartWithProfilingSucc) {
    MOCKER_CPP(&ThreadPool::CreateWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(0));
    char ch[] = "000000000000000000000000000000000000000000000000";
    int ret = ComputeProcess::GetInstance().Start(0, 100, 7, 100, 0, aicpu::AicpuRunMode::PROCESS_SOCKET_MODE);
    EXPECT_EQ(ret, static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS));
}

TEST_F(AICPUCustScheduleTEST, AicpuScheduleInterface_InitAICPUSchedulerVF_FAIL) {
    AicpuScheduleInterface::GetInstance().StopAICPUScheduler(32);
    char pidSign[] = "12345A";
    MOCKER_CPP(&ComputeProcess::Start)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuMonitor::InitAicpuMonitor)
        .stubs()
        .will(returnValue(0));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    int ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(32, 2, pidSign, PROFILING_OPEN, 1, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, ProcessEventTest_cust) {
    MOCKER_CPP(&aicpu::SetProfHandle).stubs().will(returnValue(0));
    const uint32_t threadIndex = 1;
    const uint64_t streamId = 1;
    const uint64_t taskId = 1;
    std::shared_ptr<aicpu::ProfMessage> profMsg = nullptr;
    profMsg = std::make_shared<aicpu::ProfMessage>("AICPU");
    const aicpu::aicpuProfContext_t aicpuProfCtx = {
        .tickBeforeRun = 1,
        .drvSubmitTick = 1,
        .drvSchedTick = 1,
        .kernelType = 1
    };
    AicpuUtil::SetProfData(profMsg, aicpuProfCtx, threadIndex, streamId, taskId);
    EXPECT_EQ(AicpuEventProcess::GetInstance().eventTaskProcess_.empty(), false);
}

TEST_F(AICPUCustScheduleTEST, SendCtrlCpuMsgSubmitFail) {
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    auto ret = AicpuEventProcess::GetInstance().SendCtrlCpuMsg(0, 0, nullptr, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AICPUCustScheduleTEST, AddToCgroup_failed)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(waitpid).stubs().will(returnValue(-1));
    auto ret = aicpu::AddToCgroup(0,0);
    EXPECT_EQ(ret, true);
}

TEST_F(AICPUCustScheduleTEST, AddToCgroup_success)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(0));
    bool ret = aicpu::AddToCgroup(0,0);
    EXPECT_EQ(ret, true);
}

TEST_F(AICPUCustScheduleTEST, OpenKernelSo_failed)
{
    event_info_priv privMsg;
    privMsg.msg_len = 17;
    int retMem = memcpy_s(privMsg.msg, 17, "libcpu_kernels.so", 17);
    MOCKER(aeBatchLoadKernelSo)
        .stubs()
        .will(returnValue(1));;
    int ret = CustomOpExecutor::GetInstance().OpenKernelSo(privMsg);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustScheduleTEST, OpenKernelSoByAicpuEvent_failed0)
{
    struct TsdSubEventInfo msg;
    const int msgLen = 17;
    int retMem = memcpy_s(msg.priMsg, msgLen, "libcpu_kernels.so", 17);
    int ret = CustomOpExecutor::GetInstance().OpenKernelSoByAicpuEvent(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUCustScheduleTEST, OpenKernelSoByAicpuEvent_failed1)
{
    struct TsdSubEventInfo msg;
    const int msgLen = 17;
    int retMem = memcpy_s(msg.priMsg, msgLen, "libcpu_kernels.so", 17);
    MOCKER(aeBatchLoadKernelSo)
        .stubs()
        .will(returnValue(1));
    int ret = CustomOpExecutor::GetInstance().OpenKernelSoByAicpuEvent(&msg);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustScheduleTEST, OpenKernelSoByAicpuEvent_failed2)
{
    struct TsdSubEventInfo msg;
    const int msgLen = 17;
    int retMem = memcpy_s(msg.priMsg, msgLen, "libcpu_kernels.so", 17);
    MOCKER(strnlen)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(0)));
    int ret = CustomOpExecutor::GetInstance().OpenKernelSoByAicpuEvent(&msg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUCustScheduleTEST, OpenKernelSoByAicpuEvent_failed3)
{
    struct TsdSubEventInfo msg;
    const int msgLen = 17;
    int retMem = memcpy_s(msg.priMsg, msgLen, "libcpu_kernels.so", 17);
    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(ERANGE));
    int ret = CustomOpExecutor::GetInstance().OpenKernelSoByAicpuEvent(&msg);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUCustScheduleTEST, ExecuteKernel_failed)
{
    HwtsTsKernel kernelInfo = { };
    MOCKER(aeCallInterface)
        .stubs()
        .will(returnValue(6));
    int ret = CustomOpExecutor::GetInstance().ExecuteKernel(kernelInfo);
    EXPECT_EQ(ret, 6);
}

TEST_F(AICPUCustScheduleTEST, ExecuteKernel_failed2)
{
    HwtsTsKernel kernelInfo = { };
    MOCKER(aeCallInterface)
        .stubs()
        .will(returnValue(1));
    int ret = CustomOpExecutor::GetInstance().ExecuteKernel(kernelInfo);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustScheduleTEST, ExecuteCmdFailed) {
    std::string soFullPath = "";
    AicpuUtil::ResetFpsr();
    const int32_t ret = AicpuUtil::ExecuteCmd(soFullPath);
    EXPECT_EQ(ret, -1);
}
 
TEST_F(AICPUCustScheduleTEST, ExecuteCmdForkFailed) {
    std::string cmdStr = "ll";
    MOCKER(vfork).stubs().will(returnValue(-1));
    const int32_t ret = AicpuUtil::ExecuteCmd(cmdStr);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, MonitorDebugString) {
    TaskInfoForMonitor info = {.serialNo = 1UL, .taskId = 2UL, .streamId = 3UL, .isHwts = false};
    const auto ret = info.DebugString();
    EXPECT_STREQ(ret.c_str(), "serialNo=1, stream_id=3, task_id=2");
}

TEST_F(AICPUCustScheduleTEST, MainTestFailedAddToCgroup) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;
    MOCKER_CPP(&aicpu::AddToCgroup)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, MainTestInitAicpuSDFailed) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(-1));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, MainTestGetenvFailed) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;
    char_t *dirName = "";
    MOCKER(getenv)
        .stubs()
        .will(returnValue(dirName));
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCustScheduleTEST, MainTestGrpNameNumFailed) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=0";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCustScheduleTEST, MainTestWaitShutDownFailed) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk};
    int32_t argc = 10;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER(WaitForShutDown).stubs().will(returnValue(-1));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}

TEST_F(AICPUCustScheduleTEST, ProcessMessageTest1) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PARA_ERR));
    int32_t ret = AicpuCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_PARA_ERR);
}

TEST_F(AICPUCustScheduleTEST, ProcessMessageTest2) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    int32_t ret = AicpuCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_PROCESS_EXIT);
}
TEST_F(AICPUCustScheduleTEST, ProcessMessageTest3) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(1));
    int32_t ret = AicpuCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, 1);
}
TEST_F(AICPUCustScheduleTEST, ProcessMessageTest4AicpuIllegalCPU) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU));
    AicpuCustDumpProcess::GetInstance().runningFlag_ = true;
    int32_t ret = AicpuCustDumpProcess::GetInstance().ProcessMessage(0);
    EXPECT_EQ(ret, DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU);
}
TEST_F(AICPUCustScheduleTEST, SendDumpMessageToAicpuSdTest_failed) {
    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_DRV_ERR));
    AICPUDumpCustInfo subEventInfo = {0U};
    int32_t ret = AicpuCustDumpProcess::GetInstance().SendDumpMessageToAicpuSd(PtrToPtr<AICPUDumpCustInfo, char_t>(&subEventInfo), static_cast<uint32_t>(sizeof(AICPUDumpCustInfo)));
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}
TEST_F(AICPUCustScheduleTEST, SendDumpMessageToAicpuSdTest_success) {
    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    AICPUDumpCustInfo subEventInfo = {0U};
    int32_t ret = AicpuCustDumpProcess::GetInstance().SendDumpMessageToAicpuSd(PtrToPtr<AICPUDumpCustInfo, char_t>(&subEventInfo), static_cast<uint32_t>(sizeof(AICPUDumpCustInfo)));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(AICPUCustScheduleTEST, BeginDatadumpTask_test1) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    DumpTaskMsg dumpTaskMsg = { };
    AicpuCustDumpProcess::GetInstance().waitCondVec_.push_back(dumpTaskMsg);
    int32_t ret = AicpuCustDumpProcess::GetInstance().BeginDatadumpTask(0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = AicpuCustDumpProcess::GetInstance().BeginDatadumpTask(100, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
TEST_F(AICPUCustScheduleTEST, BeginDatadumpTask_test2) {
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1));
    DumpTaskMsg dumpTaskMsg = { };
    AicpuCustDumpProcess::GetInstance().waitCondVec_.push_back(dumpTaskMsg);
    int32_t ret = AicpuCustDumpProcess::GetInstance().BeginDatadumpTask(0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_TASK_WAIT_ERROR);
}
TEST_F(AICPUCustScheduleTEST, GetCcpuInfo_success) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(0));
    int32_t ret = AicpuSchedule::AicpuDrvManager::GetInstance().GetCcpuInfo(1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(AICPUCustScheduleTEST, GetCcpuInfo_failed) {
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    int32_t ret = AicpuSchedule::AicpuDrvManager::GetInstance().GetCcpuInfo(1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}
TEST_F(AICPUCustScheduleTEST, UnitDataDumpProcess) {
    AicpuCustDumpProcess::GetInstance().initFlag_ = false;
    AicpuCustDumpProcess::GetInstance().UnitDataDumpProcess();
    EXPECT_EQ(AicpuCustDumpProcess::GetInstance().initFlag_, false);
    AicpuCustDumpProcess::GetInstance().initFlag_ = true;
    AicpuCustDumpProcess::GetInstance().UnitDataDumpProcess();
    EXPECT_EQ(AicpuCustDumpProcess::GetInstance().initFlag_, false);
}

TEST_F(AICPUCustScheduleTEST, ProcessDumpMessage) {
    event_info drvEventInfo = { };
    drvEventInfo.priv.msg_len = 0;
    int32_t ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    drvEventInfo.priv.msg_len = sizeof(AICPUDumpCustInfo);
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA+1;
    ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA;
    ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(-1));
    ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    AICPUDumpCustInfo * info = reinterpret_cast<AICPUDumpCustInfo *>(drvEventInfo.priv.msg);
    info->streamId = 100;
    ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    info->threadIndex = 100;
    ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    DumpTaskMsg dumpTaskMsg = { };
    AicpuCustDumpProcess::GetInstance().waitCondVec_.push_back(dumpTaskMsg);
    ret = AicpuCustDumpProcess::GetInstance().ProcessDumpMessage(drvEventInfo);
}

TEST_F(AICPUCustScheduleTEST, ActiveTheBlockThread) {
    event_info drvEventInfo = { };
    drvEventInfo.priv.msg_len = 0;
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA;
    int32_t ret = AicpuCustDumpProcess::GetInstance().ActiveTheBlockThread(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_CUST_LOAD_PLATFORM;
    ret = AicpuCustDumpProcess::GetInstance().ActiveTheBlockThread(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUCustScheduleTEST, CustProcessLoadPlatform) {
    int32_t ret = 0;
    event_info drvEventInfo = { };
    drvEventInfo.priv.msg_len = 0;
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA;
    ret = AicpuCustDumpProcess::GetInstance().ActiveTheBlockThread(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    drvEventInfo.comm.subevent_id = AICPU_SUB_EVENT_CUST_LOAD_PLATFORM;
    ret = AicpuCustDumpProcess::GetInstance().ActiveTheBlockThread(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    ret = AicpuCustDumpProcess::GetInstance().ActiveTheBlockThread(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    ret = CustProcessLoadPlatform(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
int32_t AicpuCustExtendKernelsLoadPlatformInfo(const uint64_t input_info, const uint32_t info_len)
{
    return 0;
}
using Func1Ptr = int32_t(*)(uint64_t, uint32_t);
Func1Ptr GetAicpuPlatformFuncPtr_stub()
{
    return &AicpuCustExtendKernelsLoadPlatformInfo;
}

TEST_F(AICPUCustScheduleTEST, GetAicpuPlatformFuncPtr) {
    Func1Ptr ptr = AicpuCustomSdLoadPlatformInfoProcess::GetInstance().GetAicpuPlatformFuncPtr();
    EXPECT_EQ(ptr, nullptr);
}

TEST_F(AICPUCustScheduleTEST, ProcessLoadPlatform) {
    MOCKER_CPP(&AicpuCustomSdLoadPlatformInfoProcess::DoSubmitEventSync).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustomSdLoadPlatformInfoProcess::GetAicpuPlatformFuncPtr).stubs().will(invoke(&GetAicpuPlatformFuncPtr_stub));
    uint8_t msg[128] = {};
    int32_t ret = AicpuCustomSdLoadPlatformInfoProcess::GetInstance().ProcessLoadPlatform(msg, 128);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, DoSubmitEventSync) {
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int32_t ret = 0;
    int len = 128;
    struct event_proc_result rsp = {};
    char msg[128];
    ret = AicpuCustomSdLoadPlatformInfoProcess::GetInstance().DoSubmitEventSync(msg, len, rsp);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, DoSubmitEventSync_failed1) {
    int32_t ret = 0;
    int len = 0;
    struct event_proc_result rsp = {};
    char msg[128];
    ret = AicpuCustomSdLoadPlatformInfoProcess::GetInstance().DoSubmitEventSync(msg, len, rsp);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUCustScheduleTEST, DoSubmitEventSync_failed2) {
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    int32_t ret = 0;
    int len = 128;
    struct event_proc_result rsp = {};
    char msg[128];
    ret = AicpuCustomSdLoadPlatformInfoProcess::GetInstance().DoSubmitEventSync(msg, len, rsp);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AICPUCustScheduleTEST, DoSubmitEventSync_failed3) {
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(1));
    int32_t ret = 0;
    int len = 128;
    struct event_proc_result rsp = {};
    char msg[128];
    ret = AicpuCustomSdLoadPlatformInfoProcess::GetInstance().DoSubmitEventSync(msg, len, rsp);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustScheduleTEST, InitWaitConVec) {
    int32_t ret = 0;
    ret = AicpuCustDumpProcess::GetInstance().InitWaitConVec(5);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(1));
    ret = AicpuCustDumpProcess::GetInstance().InitWaitConVec(5);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}
TEST_F(AICPUCustScheduleTEST, SetDataDumpThreadAffinity) {
    int32_t ret = 0;
    ret = AicpuCustDumpProcess::GetInstance().InitWaitConVec(5);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(1));
    ret = AicpuCustDumpProcess::GetInstance().InitWaitConVec(5);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUCustScheduleTEST, SetDataDumpThreadAffinity_test1) {
    int32_t ret = 0;
    ret = AicpuCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1));
    AicpuSchedule::AicpuDrvManager::GetInstance().GetCcpuInfo(1);
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ret = AicpuCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(ProcMgrBindThread)
        .stubs()
        .will(returnValue(2));
    ret = AicpuCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ret = AicpuCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(2));
    ret = AicpuCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, StartProcessEvent_test1) {
    int32_t ret = 0;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuCustDumpProcess::LoopProcessEvent)
        .stubs()
        .will(returnValue(0));
    AicpuCustDumpProcess::GetInstance().StartProcessEvent();
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1));
    AicpuCustDumpProcess::GetInstance().StartProcessEvent();
    MOCKER_CPP(&AicpuCustDumpProcess::SetDataDumpThreadAffinity)
        .stubs()
        .will(returnValue(1));
    AicpuCustDumpProcess::GetInstance().StartProcessEvent();
    MOCKER(halEschedCreateGrp)
        .stubs()
        .will(returnValue(1));
    AicpuCustDumpProcess::GetInstance().StartProcessEvent();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, LoopProcessEventTest4DRV_ERROR_SCHED_PROCESS_EXIT) {
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_SCHED_PROCESS_EXIT));
    AicpuCustDumpProcess::GetInstance().runningFlag_ = true;
    AicpuCustDumpProcess::GetInstance().LoopProcessEvent();
    EXPECT_EQ(AicpuCustDumpProcess::GetInstance().runningFlag_, false);
}
aicpu::status_t GetAicpuRunModeSOCKET(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
    return aicpu::AICPU_ERROR_NONE;
}
TEST_F(AICPUCustScheduleTEST, InitDumpProcess_test1) {
    int32_t ret = 0;
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    ret = AicpuCustDumpProcess::GetInstance().InitDumpProcess(2, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(-1));
    AicpuCustDumpProcess::GetInstance().initFlag_ = false;
    ret = AicpuCustDumpProcess::GetInstance().InitDumpProcess(2, 2);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    MOCKER_CPP(&AicpuCustDumpProcess::InitWaitConVec)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    AicpuCustDumpProcess::GetInstance().initFlag_ = false;
    ret = AicpuCustDumpProcess::GetInstance().InitDumpProcess(2, 2);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeSOCKET));
    AicpuCustDumpProcess::GetInstance().initFlag_ = false;
    ret = AicpuCustDumpProcess::GetInstance().InitDumpProcess(2, 2);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

aicpu::status_t GetAicpuRunModeFailed(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::THREAD_MODE;
    return aicpu::AICPU_ERROR_FAILED;
}
TEST_F(AICPUCustScheduleTEST, InitDumpProcess_test2) {
    int32_t ret = 0;
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeFailed));
    AicpuCustDumpProcess::GetInstance().initFlag_ = false;
    ret = AicpuCustDumpProcess::GetInstance().InitDumpProcess(2, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUCustScheduleTEST, GetAicpuPhyIndexSucc) {
    AicpuDrvManager inst;
    inst.isInit_ = false;
    inst.GetHostPid();
    inst.aicpuIdVec_.push_back(0);
    const auto ret = inst.GetAicpuPhysIndexInVfMode(0, 0);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCustScheduleTEST, MainTestPmStart) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";
    char paramCpuListOk[] = "--ctrolCpuList=0,1";
    char paramTsdPidOk[] = "--tsdPid=123";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk, paramCpuListOk, paramTsdPidOk};
    int32_t argc = 12;

    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(StartUpRspAndWaitProcess)
        .stubs()
        .will(returnValue(1));
     ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(AICPUCustScheduleTEST, MainTestPmStart_01) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";
    char paramCpuListOk[] = "--ctrolCpuList=0,1";
    char paramTsdPidOk[] = "--tsdPid=123";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk, paramCpuListOk, paramTsdPidOk};
    int32_t argc = 12;

    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_getaffinity_np)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(StartUpRspAndWaitProcess)
        .stubs()
        .will(returnValue(1));
     ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(AICPUCustScheduleTEST, MainTestPmStart_02) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";
    char paramCpuListOk[] = "--ctrolCpuList=0,1";
    char paramTsdPidOk[] = "--tsdPid=123";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk, paramCpuListOk, paramTsdPidOk};
    int32_t argc = 12;

    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(1));
    MOCKER(pthread_getaffinity_np)
        .stubs()
        .will(returnValue(0));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(StartUpRspAndWaitProcess)
        .stubs()
        .will(returnValue(1));
     ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(AICPUCustScheduleTEST, MainTestPmStart_03) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramCustSoPath[] = "--custSoPath=/home/HwHiAiUser/cust_aicpu";
    char paramAicpuPid[] = "--aicpuPid=1000";
    char paramLogLevelOk[] = "--logLevelInPid=0";
    char groupNameListOk[] = "--groupNameList=default,default2";
    char groupNameNumOk[] = "--groupNameNum=2";
    char paramCpuListOk[] = "--ctrolCpuList=0,1";
    char paramTsdPidOk[] = "--tsdPid=123";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    char* argv[] = {processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramCustSoPath,
                    paramAicpuPid, paramLogLevelOk, groupNameListOk, groupNameNumOk, paramCpuListOk, paramTsdPidOk};
    int32_t argc = 12;

    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_getaffinity_np)
        .stubs()
        .will(returnValue(1));
    int ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER(StartUpRspAndWaitProcess)
        .stubs()
        .will(returnValue(1));
     ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
    GlobalMockObject::verify();
}

TEST_F(AICPUCustScheduleTEST, InitSocType_CHIP_CLOUD_V2) {
    AicpuDrvManager inst;
    int64_t deviceInfo = CHIP_CLOUD_V2 << 8;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(any(), any(), any(), outBoundP(&deviceInfo))
        .will(returnValue(DRV_ERROR_NONE));
    char socVersion[] = "Ascend910_93";
    MOCKER(halGetSocVersion)
        .stubs()
        .with(any(), outBoundP(socVersion, strlen(socVersion)), any())
        .will(returnValue(DRV_ERROR_NONE));

    inst.InitSocType(0);

    EXPECT_TRUE(FeatureCtrl::IsBindPidByHal());
    EXPECT_TRUE(FeatureCtrl::IsDoubleDieProduct());

    FeatureCtrl::aicpuFeatureBindPidByHal_ = false;
    FeatureCtrl::aicpuFeatureDoubleDieProduct_ = false;
}

uint32_t CastV2(void * parm)
{
    return 0;
}

void func111(void *param)
{
  return;
}

void stopfunc111(void *param)
{
  return;
}
aicpu::status_t GetAicpuRunModeSOCKET1(aicpu::AicpuRunMode &runMode)
{
    static uint32_t ret = 0;
    runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
    return ret++;
}
void SendMc2CreateThreadMsgToMain_stub()
{
    struct TsdSubEventInfo *msg = nullptr;
    CreateCustMc2MaintenanceThread(msg);
}

TEST_F(AICPUCustScheduleTEST, ST_StartMC2MaintenanceThread) {
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&AicpuCustMc2MaintenanceThread::SendCustMc2CreateThreadMsgToMain).stubs().will(invoke(SendMc2CreateThreadMsgToMain_stub));
    int ret = 0;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_OK);
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(2));
    AicpuCustMc2MaintenanceThread::GetInstance(0).StartProcessEvent();
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(nullptr, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeSOCKET1));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_NOT_SUPPORT);
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
 
    AicpuCustMc2MaintenanceThread::GetInstance(0).processEventFuncPtr_ = nullptr;
    AicpuCustMc2MaintenanceThread::GetInstance(0).ProcessEventFunc();
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    AicpuCustMc2MaintenanceThread::GetInstance(0).UnitCustMc2MaintenanceProcess();
    AicpuCustMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
}

TEST_F(AICPUCustScheduleTEST, ST_SetMc2MaintenanceThreadAffinity) {
    int32_t ret = 0;
    ret = AicpuCustMc2MaintenanceThread::GetInstance(0).SetCustMc2MaintenanceThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    ret = AicpuCustMc2MaintenanceThread::GetInstance(0).SetCustMc2MaintenanceThreadAffinity();
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(2));
    ret = AicpuCustMc2MaintenanceThread::GetInstance(0).SetCustMc2MaintenanceThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    AicpuDrvManager::GetInstance().ccpuIdVec_.clear();
    ret = AicpuCustMc2MaintenanceThread::GetInstance(0).SetCustMc2MaintenanceThreadAffinity();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, StartMC2MaintenanceThread_loopFunIsNULL_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(nullptr, nullptr, &stopfunc111, nullptr);
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
}

TEST_F(AICPUCustScheduleTEST, StartMC2MaintenanceThread_stopNotifyFunIsNULL_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, nullptr, nullptr);
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
}

TEST_F(AICPUCustScheduleTEST, StartMC2MaintenanceThread_loopFunIsNULL_stopNotifyFunIsNULL_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(nullptr, nullptr, nullptr, nullptr);
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_PARAMETER_IS_NULL);
}

TEST_F(AICPUCustScheduleTEST, StartMC2MaintenanceThread_AICPU_SCHEDULE_THREAD_ALREADY_EXISTS_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(&halEschedSubmitEvent).stubs().will(returnValue(1));
    int ret = 0;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_OK);
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    AicpuCustMc2MaintenanceThread::GetInstance(0).UnitCustMc2MaintenanceProcess();
    AicpuCustMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
}
aicpu::status_t GetAicpuRunModeSOCKET2(aicpu::AicpuRunMode &runMode)
{
    static uint32_t ret = 0;
    runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
    return ret;
}
TEST_F(AICPUCustScheduleTEST, StartMC2MaintenanceThread_AICPU_SCHEDULE_NOT_SUPPORT_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(aicpu::GetAicpuRunMode)
        .stubs()
        .will(invoke(GetAicpuRunModeSOCKET2));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_NOT_SUPPORT);
}
TEST_F(AICPUCustScheduleTEST, CreateMc2MaintenanceThread_already_init_St) {
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(2));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    ret = AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).CreateCustMc2MaintenanceThread();
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(AICPUCustScheduleTEST, CreateMc2MaintenanceThread_Start_thread_multiple_times_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    int ret = 0;
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).CreateCustMc2MaintenanceThread();
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).CreateCustMc2MaintenanceThread();
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
 
TEST_F(AICPUCustScheduleTEST, CreateMc2MaintenanceThread_destructor_St) {
    MOCKER(sem_init) .stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustMc2MaintenanceThread::UnitCustMc2MaintenanceProcess).stubs().will(returnValue(0));
    auto ret = CastV2(nullptr);
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_ = std::thread(&func111, this);
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).~AicpuCustMc2MaintenanceThread();
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustScheduleTEST, CreateMc2MaintenanceThread_failed_St) {
    MOCKER_CPP(&AicpuCustMc2MaintenanceThread::CreateCustMc2MaintenanceThread).stubs().will(returnValue(1));
    int ret = 0;
    struct TsdSubEventInfo msg;
    ret = CreateCustMc2MaintenanceThread(&msg);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustScheduleTEST, StartMC2MaintenanceThread_sem_wait_failed_St) {
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    int ret = 0;
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = false;
    ret = StartMC2MaintenanceThread(&func111, nullptr, &stopfunc111, nullptr);
    EXPECT_EQ(ret, AicpuSchedule::AICPU_SCHEDULE_ERROR_INIT_FAILED);
    AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).initFlag_ = true;
    AicpuCustMc2MaintenanceThread::GetInstance(0).UnitCustMc2MaintenanceProcess();
    AicpuCustMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    if (AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.joinable()) {
        AicpuSchedule::AicpuCustMc2MaintenanceThread::GetInstance(0).processThread_.join();
    }
}

