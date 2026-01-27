/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <malloc.h>
#include <stdio.h>
#include <cstdio>
#include <stdlib.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "context.hpp"
#include "context_protect.hpp"
#include "raw_device.hpp"
#include "kernel.hpp"
#include "module.hpp"
#include "stream.hpp"
#include "task_info.hpp"
#include "arg_loader.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "task_submit.hpp"
#include "task.hpp"
#include "task_res.hpp"
#include "thread_local_container.hpp"
#include "async_hwts_engine.hpp"
#include "runtime_keeper.h"
#include "memory_task.h"
#undef protected
#undef private
#include "ffts_task.h"

using namespace testing;
using namespace cce::runtime;

class ChipContextTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        std::cout << "ContextTest SetUp" << std::endl;
        rtSetDevice(0);
        std::cout << "ContextTest SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "ContextTest TearDown" << std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout << "ContextTest TearDown end" << std::endl;
    }
};

TEST_F(ChipContextTest, PrimaryContextRetain_test)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    EXPECT_NE(stm, nullptr);

    RefObject<Context*> *refObject = NULL;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    Runtime::Instance()->timeoutConfig_.isCfgOpExcTaskTimeout = true;
    Runtime::Instance()->timeoutConfig_.opExcTaskTimeout = 1000;
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    device->primaryStream_ = (Stream *)stm;
    (void)device->UpdateTimeoutConfig();

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    Runtime::Instance()->timeoutConfig_.isCfgOpExcTaskTimeout = false;
    Runtime::Instance()->timeoutConfig_.opExcTaskTimeout = 0;
    device->primaryStream_ = nullptr;

    rtStreamDestroy(stm);
    delete device;
    GlobalMockObject::verify();
}

TEST_F(ChipContextTest, ReduceAsync_test)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctx = refObject->GetVal();

    int tempMemory;
    auto preVal = stream->taskResMang_;
    stream->taskResMang_ = reinterpret_cast<TaskResManage *>(&tempMemory);

    MOCKER_CPP_VIRTUAL(ctx->device_, &Device::SubmitTask).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFactory::Recycle).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskInitV3)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));
    stream->streamId_ = MAX_INT32_NUM;
    MOCKER_CPP_VIRTUAL(ctx->device_, &Device::GetDeviceCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = ctx->ReduceAsync(nullptr, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_MAX, RT_DATA_TYPE_FP32, stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
    stream->taskResMang_ = preVal;
    delete stream;
    delete device;
    GlobalMockObject::verify();
}