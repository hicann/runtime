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
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "async_hwts_engine.hpp"
#include "task_res.hpp"
#include "rdma_task.h"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "capture_model.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include "thread_local_container.hpp"
#include "heterogenous.h"
#include "task_execute_time.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stream.h"
#include "api_c.h"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

// rts-event-notify-ut-begin
class ApiEventNotifyTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
    }

    virtual void SetUp()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};

TEST_F(ApiEventNotifyTest, rtsEventTest)
{
    rtEvent_t event = nullptr;

    rtError_t error1 = rtsEventCreate(&event, 0x888U);
    EXPECT_NE(error1, RT_ERROR_NONE);

    rtError_t error2 = rtsEventCreate(&event, RT_EVENT_FLAG_DEFAULT);
    EXPECT_EQ(error2, RT_ERROR_NONE);

    rtEvent_t eventEx = nullptr;
    rtError_t error3 = rtsEventCreateEx(&eventEx, 0x888U);
    EXPECT_NE(error3, RT_ERROR_NONE);
    
    uint32_t event_id = 0;
    rtError_t error4 = rtsEventGetId(event, &event_id);
    EXPECT_NE(error4, RT_ERROR_NONE);

    rtEventRecordStatus status = RT_EVENT_STATUS_NOT_RECORDED;
    rtError_t error5 = rtsEventQueryStatus(event, &status);
    EXPECT_EQ(error5, RT_ERROR_NONE);

    rtError_t error6 = rtsEventRecord(event, nullptr);
    EXPECT_EQ(error6, RT_ERROR_NONE);

    rtStream_t stream;
    rtError_t error7 = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(error7, RT_ERROR_NONE);

    rtError_t error8 = rtsEventWait(stream, event, 0);
    EXPECT_EQ(error8, RT_ERROR_NONE);

    rtError_t error9 = rtsEventSynchronize(event, -2);
    EXPECT_NE(error9, RT_ERROR_NONE);

    uint64_t timeStamp = 0;
    rtError_t error10 = rtsEventGetTimeStamp(&timeStamp, event);
    EXPECT_EQ(error10, RT_ERROR_NONE);

    rtError_t error11 = rtsEventReset(event, stream);
    EXPECT_EQ(error11, RT_ERROR_NONE);

    rtError_t error12 = rtStreamDestroy(stream);
    EXPECT_EQ(error12, RT_ERROR_NONE);

    uint32_t eventCount = 0;
    rtError_t error13 = rtsEventGetAvailNum(&eventCount);
    EXPECT_EQ(error13, RT_ERROR_NONE);

    float32_t timeInterval = 0;
    rtError_t error14 = rtsEventElapsedTime(&timeInterval, event, event);
    EXPECT_EQ(error14, RT_ERROR_NONE);

    rtError_t error15 = rtsEventDestroy(event);
    EXPECT_EQ(error15, RT_ERROR_NONE);
}

TEST_F(ApiEventNotifyTest, rtsNotifyTest)
{
    rtNotify_t notify = nullptr;
    int32_t device_id = 0;
    uint32_t notifyId = 0;

    uint32_t flag = 0x0U;

    rtError_t error1 = rtsNotifyCreate(&notify, 0x999U);
    EXPECT_NE(error1, RT_ERROR_NONE);

    rtError_t error2 = rtsNotifyCreate(&notify, RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_EQ(error2, RT_ERROR_NONE);

    rtStream_t stream;
    rtError_t error3 = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(error3, RT_ERROR_NONE);

    rtError_t error4 = rtsNotifyRecord(notify, stream);
    EXPECT_EQ(error4, RT_ERROR_NONE);

    rtError_t error5 = rtsNotifyWaitAndReset(notify, stream, 0);
    EXPECT_EQ(error5, RT_ERROR_NONE);

    rtError_t error6 = rtsNotifyWaitAndReset(notify, stream, UINT32_MAX);
    EXPECT_EQ(error6, RT_ERROR_NONE);

    rtError_t error7 = rtsNotifyGetId(notify, &notifyId);
    EXPECT_EQ(error7, RT_ERROR_NONE);

    rtError_t error8 = rtStreamDestroy(stream);
    EXPECT_EQ(error8, RT_ERROR_NONE);
    rtError_t error9 = rtsNotifyDestroy(notify);
    EXPECT_EQ(error9, RT_ERROR_NONE);
}
// rts-event-notify-ut-end