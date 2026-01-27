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
#include "async_hwts_engine.hpp"
#include "runtime.hpp"
#include "task_res.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include "scheduler.hpp"
#include "hwts.hpp"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "context.hpp"
#include "npu_driver.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "mmpa_api.h"
#include "task_submit.hpp"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

using std::pair;
using std::make_pair;

class AdcEngineTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout<<"AdcEngineTest test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"AdcEngineTest test start end"<<std::endl;

    }

    virtual void SetUp()
    {
        rtSetDevice(0);

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
        /* sleep 10ms，advoid stream_create task not processed in no-disable-thread scene, */
        /* in some case which may change the disable-thread flag. */
        usleep(10 * 1000);
        delete rawDevice;
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};

TEST_F(AdcEngineTest, StarsEngine_init)
{
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    rtError_t error = engine->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(AdcEngineTest, Monitor_RingbufferTaskError)
{
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    MOCKER_CPP(&DeviceErrorProc::ReportRingBuffer)
        .stubs()
        .will(returnValue(RT_ERROR_TASK_MONITOR));
    engine->MonitoringRun();
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    rtError_t error = ((Runtime *)Runtime::Instance())->GetWatchDogDevStatus(device_->Id_(), &deviceStatus);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(AdcEngineTest, WaitCompletion_test)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->pendingNum_.Add(1U);
    uint32_t pendingNumBefore = engine->pendingNum_.Value();
    engine->WaitCompletion();
    auto &engine2 = engine;
    uint32_t pendingNumAfter = engine2->pendingNum_.Value();
    EXPECT_EQ(pendingNumBefore, pendingNumAfter);
}


