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

class ModelTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend310B1");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_MINI_V3);
        GlobalContainer::SetRtChipType(CHIP_MINI_V3);
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetSocVersion("");
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ModelTest, model_abort)
{
    RawDevice * dev = new RawDevice(1);
    cce::runtime::NpuDriver * drv = new NpuDriver();
    dev->driver_ = drv;
    dev->Init();
    Context * ctx = new Context(dev, false);
    ctx->Init();
    Model * model = new Model();
    model->context_ = ctx;
    Stream * stream = new Stream(dev, 0);
    Stream * stm;
 
    rtError_t error;
    dev->properties_.isStars = true;
    ctx->SetDefaultStream(stream);
    MOCKER_CPP_VIRTUAL(ctx, &Context::StreamCreate).stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&stream), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    TaskInfo * kernTask = new TaskInfo();
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(kernTask));
    MOCKER(ModelMaintainceTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL((RawDevice *)dev, &RawDevice::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(ctx, &Context::StreamDestroy).stubs().will(returnValue(RT_ERROR_NONE));

    error = model->ModelAbort();
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
    delete kernTask;
    delete model;
    delete ctx;
    delete dev;
    delete drv;
}
