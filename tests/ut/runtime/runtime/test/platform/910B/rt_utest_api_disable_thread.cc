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

class ApiDisableThreadTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);

        (void)rtSetDevice(0);
        (void)rtSetTSDevice(0);
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

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<< error4 << std::endl;
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
        rtInstance->SetDisableThread(flag);      // Recover.
    }

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
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
    static Driver    *driver_;
    static bool flag;
};

rtStream_t ApiDisableThreadTest::stream_ = NULL;
rtEvent_t ApiDisableThreadTest::event_ = NULL;
void* ApiDisableThreadTest::binHandle_ = nullptr;
char  ApiDisableThreadTest::function_ = 'a';
uint32_t ApiDisableThreadTest::binary_[32] = {};
Driver* ApiDisableThreadTest::driver_ = nullptr;
bool ApiDisableThreadTest::flag = false;

TEST_F(ApiDisableThreadTest, kernel_launch)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetFunctionByName("foo", &stubFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(stubFunc, (void*)&function_);

    error = rtGetFunctionByName("fooooo", &stubFunc);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetFunctionByName(NULL, &stubFunc);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDisableThreadTest, SysParamOpt_test)
{
    rtError_t error;

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    int64_t val;
    // abnormal test not set
    error = rtCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_SYSPARAMOPT_NOT_SET);

    error = rtCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 1);

    // abnormal test
    error =rtCtxSetSysParamOpt(SYS_OPT_RESERVED, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error =rtCtxGetSysParamOpt(SYS_OPT_RESERVED, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDisableThreadTest, SysParamOpt_test_1)
{
    rtError_t error;

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    int64_t val;
    // abnormal test not set
    error = rtGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 1);

    error = rtGetSysParamOpt(SYS_OPT_ENABLE_DEBUG_KERNEL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    //normal test
    error = rtSetSysParamOpt(SYS_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 1);

    error = rtSetSysParamOpt(SYS_OPT_ENABLE_DEBUG_KERNEL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetSysParamOpt(SYS_OPT_ENABLE_DEBUG_KERNEL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 1);

    // abnormal test
    error = rtGetSysParamOpt(SYS_OPT_DETERMINISTIC, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetSysParamOpt(SYS_OPT_ENABLE_DEBUG_KERNEL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error =rtSetSysParamOpt(SYS_OPT_RESERVED, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error =rtGetSysParamOpt(SYS_OPT_RESERVED, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error =rtsSetSysParamOpt(SYS_OPT_RESERVED, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error =rtsGetSysParamOpt(SYS_OPT_RESERVED, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDisableThreadTest, kernel_launch_success_dfx)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    Stream *stm = (Stream*)stream_;
    stm->SetLimitFlag(true);
    stm->SetRecycleFlag(false);

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetFunctionByName("foo", &stubFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(stubFunc, (void*)&function_);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDisableThreadTest, kernel_launch_stream_full)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    Stream *stm = (Stream*)stream_;
    MOCKER_CPP(&Stream::AddTaskToStream)
    .stubs()
    .will(returnValue(RT_ERROR_STREAM_FULL));

    Device* dev = stm->Device_();
    MOCKER_CPP_VIRTUAL(dev, &Device::GetDevRunningState)
    .stubs()
    .will(returnValue((uint32_t)DEV_RUNNING_DOWN));

    uint32_t errCode = 8888;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(dev->Driver_()), &NpuDriver::CommandOccupy)
        .stubs().will(returnValue(errCode));

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);
    dev->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_LOST_HEARTBEAT);

    dev->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_LOST_HEARTBEAT);
    dev->SetDevStatus(RT_ERROR_NONE);
}

TEST_F(ApiDisableThreadTest, overflow_test)
{
    rtError_t error;

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    void *overflowAddr = nullptr;
    // normal test
    error = rtCtxGetOverflowAddr(&overflowAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(overflowAddr, nullptr);

    uint64_t buff_size = 64;
    uint32_t *devMemSrc;
    error = rtMalloc((void **)&devMemSrc, buff_size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDeviceSatStatus(devMemSrc, 512, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetDeviceSatStatus(devMemSrc, buff_size, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCleanDeviceSatStatus(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtFree(devMemSrc);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDisableThreadTest, rtsoverflow_test)
{
    rtError_t error;

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    void *overflowAddr = nullptr;
    // normal test
    error = rtsCtxGetFloatOverflowAddr(&overflowAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(overflowAddr, nullptr);

    error = rtsResetFloatOverflowStatus(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}