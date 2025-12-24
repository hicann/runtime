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
#include "task_res.hpp"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "device_state_callback_manager.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include "thread_local_container.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiCloudDisableThreadDfxTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910B1");
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);

        int64_t hardwareVersion = CHIP_910_B_93 << 8;
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_,
            &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        (void)rtSetDevice(0);
        (void)rtSetTSDevice(0);
        rtError_t error1 = rtStreamCreateWithFlags(&stream_, 0, RT_STREAM_FAST_LAUNCH);
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

        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", nullptr, 0);

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

rtStream_t ApiCloudDisableThreadDfxTest::stream_ = nullptr;
rtEvent_t ApiCloudDisableThreadDfxTest::event_ = nullptr;
void* ApiCloudDisableThreadDfxTest::binHandle_ = nullptr;
char  ApiCloudDisableThreadDfxTest::function_ = 'a';
uint32_t ApiCloudDisableThreadDfxTest::binary_[32] = {};
rtChipType_t ApiCloudDisableThreadDfxTest::originType_ = CHIP_910_B_93;
Driver* ApiCloudDisableThreadDfxTest::driver_ = nullptr;

TEST_F(ApiCloudDisableThreadDfxTest, kernel_launch_with_handle_task_full)
{
    Stream *stm = (Stream*)stream_;
    stm->SetLimitFlag(true);
    stm->SetRecycleFlag(false);
    Context* context = stm->Context_();
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    rtTaskCfgInfo_t taskCfgInfo = {};
    stm->failureMode_ = CONTINUE_ON_FAILURE;
    rtError_t error = rtStreamSynchronize(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiCloudDisableThreadDfxTest, streamCreateFail1)
{
    rtStream_t stm;
    MOCKER_CPP(&TaskResManage::AllocTaskInfoByTaskResId)
        .stubs()
        .will(returnValue(static_cast<TaskInfo *>(nullptr)));
    MOCKER_CPP_VIRTUAL(((Stream *)stream_)->Device_(), &Device::GetDevStatus)
    .stubs()
    .will(returnValue(RT_ERROR_NONE))
    .then(returnValue(RT_ERROR_LOST_HEARTBEAT));
    rtError_t error1 = rtEventRecord(event_, stream_);

    EXPECT_EQ(error1, ACL_ERROR_RT_LOST_HEARTBEAT);
    GlobalMockObject::verify();
}
