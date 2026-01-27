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
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "program.hpp"
#include "context.hpp"
#include "device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "arg_loader.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "task_res.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "subscribe.hpp"
#include "task_submit.hpp"
#include "thread_local_container.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

rtError_t CheckSupportPcieBarCopyStub(NpuDriver *This, const uint32_t deviceId, uint32_t &val)
{
    UNUSED(deviceId);
    val = RT_CAPABILITY_SUPPORT;
    return RT_ERROR_NONE;
}

class ApiDCDisableThreadTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend310P");
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        originType_ = Runtime::Instance()->GetChipType();
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_DC);
        GlobalContainer::SetRtChipType(CHIP_DC);

        // using for lite stream condition1 1 online mode
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        // using for lite stream condition1 2 support picebar
        MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .will(invoke(CheckSupportPcieBarCopyStub));

        (void)rtSetDevice(0);
        (void)rtSetTSDevice(0);


        // env check
        const bool isDisableThread = Runtime::Instance()->GetDisableThread();
        EXPECT_EQ(isDisableThread, true);

        rtError_t error1 = rtStreamCreate(&stream_, 0);
        rtError_t error2 = rtEventCreate(&event_);

        for (uint32_t i = 0; i < sizeof(binary_)/sizeof(uint32_t); i++)
        {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);

        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);

        MOCKER(memcpy_s).stubs().will(returnValue(NULL));

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
    }

    static void TearDownTestCase()
    {
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error2 = rtEventDestroy(event_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"api test start end : "<<error1<<", "<<error2<<", "<<error3<<std::endl;
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);      // Recover.
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

public:
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
    static rtChipType_t originType_;
    static Driver    *driver_;
};


rtStream_t ApiDCDisableThreadTest::stream_ = NULL;
rtEvent_t ApiDCDisableThreadTest::event_ = NULL;
void* ApiDCDisableThreadTest::binHandle_ = NULL;
char  ApiDCDisableThreadTest::function_ = 'a';
uint32_t ApiDCDisableThreadTest::binary_[32] = {};
rtChipType_t ApiDCDisableThreadTest::originType_ = CHIP_BEGIN;
Driver* ApiDCDisableThreadTest::driver_ = NULL;

TEST_F(ApiDCDisableThreadTest, hwts_veresion_task_to_command_test)
{
    rtCommand_t command;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_GET_STARS_VERSION;

    rtStream_t stream = NULL;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);

    ToCommand(&task, &command);
    Complete(&task, 0);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDCDisableThreadTest, hwts_veresion_task_fail_to_command_test)
{
    rtCommand_t command;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_GET_STARS_VERSION;

    rtStream_t stream = NULL;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);

    ToCommand(&task, &command);
    uint32_t errorcode[3] = {0};
    errorcode[0] = 1;
    SetResult(&task, (void*)&errorcode,1);
    Complete(&task, 0);
    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}