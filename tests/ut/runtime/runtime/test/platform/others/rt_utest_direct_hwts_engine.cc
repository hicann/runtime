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
#include "base.hpp"
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "npu_driver.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "direct_hwts_engine.hpp"
#include "stars_engine.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef protected
#undef private
#include "scheduler.hpp"
#include "hwts.hpp"
#include "stream.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "device/device_error_proc.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "mmpa_api.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

using std::pair;
using std::make_pair;

class RtOtherDirectHwtsEngineTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"RtOtherDirectHwtsEngine test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"RtOtherDirectHwtsEngine test end"<<std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

TEST_F(RtOtherDirectHwtsEngineTest, Start_failed)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originType = rtInstance->GetChipType();
    RawDevice *device = new RawDevice(0);
    device->Init();
    DirectHwtsEngine engine(device);
 
    MOCKER_CPP(&DirectHwtsEngine::CreateRecycleThread)
        .stubs()
        .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    rtError_t error = engine.Start();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(RtOtherDirectHwtsEngineTest, ReportTimeoutProc_01)
{
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    rtError_t ret = device->Init();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    std::unique_ptr<Engine> engine = std::make_unique<DirectHwtsEngine>(device);
    int32_t timeoutCnt = 1U;
    int32_t oldTimeoutCnt = Runtime::macroValue_.maxReportTimeoutCnt;
    Runtime::macroValue_.maxReportTimeoutCnt = 0U;
    engine->pendingNum_.Add(1U);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    const bool old = rtInstance->GetDisableThread();
    rtInstance->SetDisableThread(true);
    engine->ReportTimeoutProc(RT_ERROR_REPORT_TIMEOUT, timeoutCnt, 0, 0, 0, 0);
    rtInstance->SetDisableThread(old);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
    Runtime::macroValue_.maxReportTimeoutCnt = oldTimeoutCnt;
    delete device;
    GlobalMockObject::reset();
}

TEST_F(RtOtherDirectHwtsEngineTest, TryRecycleTask_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    DirectHwtsEngine engine(device);
    Stream *stm = new Stream(device, 0);

    device->tschVersion_ = TS_VERSION_LATEST;
    
    rtShmQuery_t shareMemInfo;
    shareMemInfo.taskId = 0U;
    shareMemInfo.valid = SQ_SHARE_MEMORY_VALID;
    MOCKER_CPP(&ShmCq::QueryCqShm)
        .stubs()
        .with(mockcpp::any(), outBound(shareMemInfo))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&DirectHwtsEngine::TaskReclaimEx)
        .stubs();
    // 512 is TASK_WAIT_EXECUTE_MAX_NUM, 64 is TASK_QUERY_INTERVAL_NUM
    stm->lastTaskId_ = 512U + 64U;
    rtError_t ret = engine.TryRecycleTask(stm);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete stm;
    delete device;
}

TEST_F(RtOtherDirectHwtsEngineTest, SendingWait_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    DirectHwtsEngine engine(device);
    Stream *stm = new Stream(device, 0);

    MOCKER_CPP_VIRTUAL(engine, &DirectHwtsEngine::TaskReclaim)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint8_t failCount = 0U;
    engine.SendingWait(stm, failCount);
    EXPECT_EQ(failCount, 1U);

    delete stm;
    delete device;
}