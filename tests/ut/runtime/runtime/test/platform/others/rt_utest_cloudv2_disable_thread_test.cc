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

class ApiCloudV2DisableThreadTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910B");
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        originType_ = Runtime::Instance()->GetChipType();
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_910_B_93);
        GlobalContainer::SetRtChipType(CHIP_910_B_93);

        int64_t hardwareVersion = CHIP_910_B_93 << 8;
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), neq(INFO_TYPE_PHY_DIE_ID), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));
        int64_t phyDieId = 0;
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&phyDieId, sizeof(phyDieId)))
            .will(returnValue(RT_ERROR_NONE));
        std::cout<<"error2 : " << 1 <<endl;
        (void)rtSetDevice(0);
        std::cout<<"error2 : " << 2 <<endl;
        (void)rtSetTSDevice(0);
        rtError_t error1 = rtStreamCreateWithFlags(&stream_, 0, RT_STREAM_DEFAULT);
        std::cout<<"error1 : " << error1 <<endl;
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

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
    }

    static void TearDownTestCase()
    {
        Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        Stream *stream = new Stream((Device *)device, 0);
        MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
        rtError_t error1 = rtStreamDestroy(stream_);
        delete stream;
        rtError_t error2 = rtEventDestroy(event_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"api test start end : "<<error1<<", "<<error2<<", "<<error3<<std::endl;
        RawDevice *rawDevice = (RawDevice *)device;
        rawDevice->Engine_()->pendingNum_.Set(0U);
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->DeviceRelease(device);
        GlobalMockObject::verify();
        (void)rtSetSocVersion("");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);      // Recover.
    }

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_910_B_93);
        GlobalContainer::SetRtChipType(CHIP_910_B_93);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        GlobalMockObject::verify();
    }

public:
    rtChipType_t oldChipType;
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
    static rtChipType_t originType_;
    static Driver    *driver_;
};

rtStream_t ApiCloudV2DisableThreadTest::stream_ = nullptr;
rtEvent_t ApiCloudV2DisableThreadTest::event_ = nullptr;
void* ApiCloudV2DisableThreadTest::binHandle_ = nullptr;
char  ApiCloudV2DisableThreadTest::function_ = 'a';
uint32_t ApiCloudV2DisableThreadTest::binary_[32] = {};
rtChipType_t ApiCloudV2DisableThreadTest::originType_ = CHIP_910_B_93;
Driver* ApiCloudV2DisableThreadTest::driver_ = nullptr;

TEST_F(ApiCloudV2DisableThreadTest, capture_event_external)
{
    rtError_t error;
    rtEvent_t event = nullptr;
    rtModel_t model;
    rtStream_t stream1;
    rtStream_t stream2;
    void *args[] = {&error, NULL};
    rtStreamCaptureStatus status;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream1, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamGetCaptureInfo(stream1, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);
    EXPECT_NE(model, nullptr);

    error = rtStreamGetCaptureInfo(stream2, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_NONE);
    EXPECT_EQ(model, nullptr);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // 确保Event内存被释放
    Event *eventObj = static_cast<Event *>(event);
    uint32_t evtId = 0U;
    (void)eventObj->GetEventID(&evtId);
    TryToFreeEventIdAndDestroyEvent(&eventObj, evtId, false);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, capture_event_external2)
{
    rtError_t error;
    rtEvent_t event = nullptr;
    rtModel_t model;
    rtStream_t stream1;
    rtStream_t stream2;
    void *args[] = {&error, NULL};
    rtStreamCaptureStatus status;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamGetCaptureInfo(stream1, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);
    EXPECT_NE(model, nullptr);

    error = rtStreamGetCaptureInfo(stream2, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_NONE);
    EXPECT_EQ(model, nullptr);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // 确保Event内存被释放
    Event *eventObj = static_cast<Event *>(event);
    uint32_t evtId = 0U;
    (void)eventObj->GetEventID(&evtId);
    TryToFreeEventIdAndDestroyEvent(&eventObj, evtId, false);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, kernel_launch_success_dfx)
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

TEST_F(ApiCloudV2DisableThreadTest, kernel_launch_sq_task_send_error)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    Stream *stm = (Stream*)stream_;
    Device* dev = stm->Device_();
    MOCKER_CPP_VIRTUAL(dev, &Device::GetDevRunningState)
    .stubs()
    .will(returnValue((uint32_t)DEV_RUNNING_DOWN));

    int32_t errCode = 8888;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(dev->Driver_()), &NpuDriver::SqTaskSend)
        .stubs().will(returnValue(errCode));

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, errCode);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_create)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(nullptr, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskGrp(stream1, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskGrp(nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, capture_event_not_support)
{
    rtError_t error;
    rtEvent_t event1;
    rtEvent_t event2;
    rtModel_t model;
    rtStream_t stream1;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    
    error = rtEventCreateWithFlag(&event1, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Event *evt = (Event*)event1;
    evt->isNewMode_ = true;
    evt->hasRecord_.Set(true);

    error = rtEventCreateExWithFlag(&event2, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);    

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Exception
    error = rtStreamWaitEvent(stream1, event1);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_DEPENDENCY);
    
    // Normal
    error = rtEventRecord(event2, stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream1, event2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_unclosed)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_no_captured)
{
    rtError_t error;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_repeat)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_update)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_update_task)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtStream_t stream2;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1)); 

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
 
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream2, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream2);

    error = rtsStreamEndTaskUpdate(stream2);
    int32_t streamId = -1;
    (void)rtGetStreamId(stream2, &streamId);
    TaskInfo * const h2dTask = device->GetTaskFactory()->GetTask(streamId, 0);
    if (h2dTask != nullptr) {
        EXPECT_EQ(h2dTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(h2dTask);
    }

    TaskInfo * const d2hTask = device->GetTaskFactory()->GetTask(streamId, 1);
    if (d2hTask != nullptr) {
        EXPECT_EQ(d2hTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(d2hTask);
    }

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_cascade)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1 = stream_;
    rtStream_t stream2;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32U + PREFETCH_CNT_CLOUD_V2;

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));
    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream2, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream2);

    error = rtsStreamEndTaskUpdate(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int32_t streamId = -1;
    (void)rtGetStreamId(stream2, &streamId);
    TaskInfo * const h2dTask = device->GetTaskFactory()->GetTask(streamId, 0);
    if (h2dTask != nullptr) {
        EXPECT_EQ(h2dTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(h2dTask);
    }

    TaskInfo * const d2hTask = device->GetTaskFactory()->GetTask(streamId, 1);
    if (d2hTask != nullptr) {
        EXPECT_EQ(d2hTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(d2hTask);
    }

    //debug print;
    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDebugJsonPrint(model, "test.json", 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDebugJsonPrint(model, "./testpath/test.json", 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_cascade2)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1 = stream_;
    rtStream_t stream2;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};
    const uint16_t taskNum = 10U;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32U + PREFETCH_CNT_CLOUD_V2;

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1)); 
    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    for (uint16_t i = 0U; i < taskNum; i++) {
         error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream2, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    for (uint16_t i = 0U; i < taskNum; i++) {
         error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream2);
    }

    error = rtsStreamEndTaskUpdate(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int32_t streamId = -1;
    (void)rtGetStreamId(stream2, &streamId);
    for (uint16_t i = 0U; i < (taskNum * 2U); i++) {
        TaskInfo * const task = device->GetTaskFactory()->GetTask(streamId, i);
        if (task != nullptr) {
            EXPECT_EQ(task->type, TS_TASK_TYPE_MEMCPY);
            (void)device->GetTaskFactory()->Recycle(task);
        }
    }

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_capture_invalid)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Context::AllocCascadeCaptureStream).stubs().will(returnValue(RT_ERROR_DRV_NO_RESOURCES));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32U + PREFETCH_CNT_CLOUD_V2;

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_RESOURCE_ALLOC_FAIL);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;
}

TEST_F(ApiCloudV2DisableThreadTest, ModelDebugJsonPrint_AicpuTask)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1 = stream_;
    rtStream_t stream2;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32U + PREFETCH_CNT_CLOUD_V2;

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1)); 

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream2, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream2);

    error = rtsStreamEndTaskUpdate(stream2);
    int32_t streamId = -1;
    (void)rtGetStreamId(stream2, &streamId);
    TaskInfo * const h2dTask = device->GetTaskFactory()->GetTask(streamId, 0);
    if (h2dTask != nullptr) {
        EXPECT_EQ(h2dTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(h2dTask);
    }

    TaskInfo * const d2hTask = device->GetTaskFactory()->GetTask(streamId, 1);
    if (d2hTask != nullptr) {
        EXPECT_EQ(d2hTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(d2hTask);
    }

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // aicpu task;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    AicpuTaskInfo *aicpuTask = &(task.u.aicpuTaskInfo);
    aicpuTask->kernel = nullptr;
    
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&task));
    ((Stream *)stream1)->SetBindFlag(true);
    ((Stream *)stream1)->StarsAddTaskToStream(&task, 1);
    std::ofstream outputFile("graph_dump.json");
    ((Stream *)stream1)->DebugJsonPrintForModelStm(outputFile, 0, true);
    ((Stream *)stream1)->SetBindFlag(false);
    outputFile.close();

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;

}

TEST_F(ApiCloudV2DisableThreadTest, ModelDebugJsonPrint_Error_01)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1 = stream_;
    rtStream_t stream2;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32U + PREFETCH_CNT_CLOUD_V2;

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));  

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream2, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream2);

    error = rtsStreamEndTaskUpdate(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    int32_t streamId = -1;
    (void)rtGetStreamId(stream2, &streamId);
    TaskInfo * const h2dTask = device->GetTaskFactory()->GetTask(streamId, 0);
    if (h2dTask != nullptr) {
        EXPECT_EQ(h2dTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(h2dTask);
    }

    TaskInfo * const d2hTask = device->GetTaskFactory()->GetTask(streamId, 1);
    if (d2hTask != nullptr) {
        EXPECT_EQ(d2hTask->type, TS_TASK_TYPE_MEMCPY);
        (void)device->GetTaskFactory()->Recycle(d2hTask);
    }

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // invalid input file name;
    error = rtModelDebugJsonPrint(model, "", 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;

}


TEST_F(ApiCloudV2DisableThreadTest, task_group_update_1)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1)); 

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    TaskGroup* taskGroup = (TaskGroup* )taskGrpHandle;
    uint32_t streamId = taskGroup->taskIds[0].first;
    taskGroup->taskIds[0].first = 345;

    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    taskGroup->taskIds[0].first = streamId;

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_update_2)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Model *model2 = new Model();
    ((Stream *)stream1)->ResetUpdateTaskGroup();

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID );

    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    delete model2;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, task_group_update_3)
{
    rtError_t error;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};
    rtModel_t model;

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // 直接endtask
    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    // taskGrpHandle为空
    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamBeginTaskUpdate(nullptr, taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskUpdate(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}
// okay
TEST_F(ApiCloudV2DisableThreadTest, task_group_update_4)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    NpuDriver * rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode)
                        .stubs()
                        .will(returnValue(1));  

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), nullptr, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS); // 重复调用报错

    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);  // 重复调用报错

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete rawDrv;
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiCloudV2DisableThreadTest, memcpy_batch_async_param_err0)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    size_t destMaxs[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
        destMaxs[i] = len;
    }
    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatchAsync(nullptr, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, nullptr, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, nullptr, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, nullptr, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, 0U, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, nullptr, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, nullptr, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, 0U, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    sizes[0] = 0;
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }

    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiCloudV2DisableThreadTest, memcpy_batch_async_param_err1)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    size_t destMaxs[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
        destMaxs[i] = len;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    constexpr size_t numAttrs0 = count + 1;
    rtMemcpyBatchAttr attrs0[numAttrs0];
    size_t attrsIdxs0[numAttrs0] = {0, 2, 4, 5};
    for (size_t i = 0; i < numAttrs0; i++) {
        attrs0[i].srcLoc.id = 0U;
        attrs0[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs0[i].dstLoc.id = 0U;
        attrs0[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs0, attrsIdxs0, numAttrs0, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs1[numAttrs] = {1, 3};
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs1, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs2[numAttrs + 1] = {0, 3, 5};
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs2, numAttrs + 1, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs3[numAttrs + 1] = {0, 3, 1};
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs3, numAttrs + 1, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(ApiCloudV2DisableThreadTest, memcpy_batch_param_err0)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatch(nullptr, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, nullptr, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, nullptr, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, 0U, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, nullptr, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, nullptr, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs, 0U, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(ApiCloudV2DisableThreadTest, memcpy_batch_param_err1)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    constexpr size_t numAttrs0 = count + 1;
    rtMemcpyBatchAttr attrs0[numAttrs0];
    size_t attrsIdxs0[numAttrs0] = {0, 2, 4, 5};
    for (size_t i = 0; i < numAttrs0; i++) {
        attrs0[i].srcLoc.id = 0U;
        attrs0[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs0[i].dstLoc.id = 0U;
        attrs0[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs0, attrsIdxs0, numAttrs0, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs1[numAttrs] = {1, 3};
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs1, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs2[numAttrs + 1] = {0, 3, 5};
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs2, numAttrs + 1, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs3[numAttrs + 1] = {0, 3, 1};
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs3, numAttrs + 1, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(ApiCloudV2DisableThreadTest, memcpy_batch_count_err)
{
    constexpr size_t count = static_cast<size_t>(DEVMM_MEMCPY_BATCH_MAX_COUNT) + 1U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = (i + 1U) % len;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}