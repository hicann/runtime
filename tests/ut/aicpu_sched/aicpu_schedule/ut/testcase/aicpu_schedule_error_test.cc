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
#include <memory>
#include <map>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tdt_server.h"
#include "ascend_hal.h"
#include "aicpu_context.h"
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "tsd.h"
#include "adump/ide_daemon_api.h"
#define private public
#include "aicpusd_interface_process.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_task_queue.h"
#include "aicpu_task_struct.h"
#include "aicpusd_worker.h"
#include "aicpusd_drv_manager.h"
#include "aicpu_event_struct.h"
#include "aicpu_pulse.h"
#include "aicpusd_cust_so_manager.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AICPUScheduleTEST : public testing::Test {
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

extern int32_t ComputeProcessMain(int32_t argc, char* argv[]);

TEST_F(AICPUScheduleTEST, MainTestTsdFailed) {
    char processName[] = "aicpu_scheduler";
    char paramDeviceIdOk[] = "--deviceId=1";
    char paramPidOk[] = "--pid=2";
    char paramPidSignOk[] = "--pidSign=12345A";
    char paramModeOk[] = "--profilingMode=1";
    char paramLogLevelOk[] = "--logLevelInPid=0";

    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    char* argv[] = { processName, paramDeviceIdOk, paramPidOk, paramPidSignOk, paramModeOk, paramLogLevelOk };
    int32_t argc = 5;
    MOCKER_CPP(&AicpuScheduleInterface::InitAICPUScheduler)
        .stubs()
        .will(returnValue(0));
    int32_t ret = ComputeProcessMain(argc, argv);
    EXPECT_EQ(ret, -1);
}