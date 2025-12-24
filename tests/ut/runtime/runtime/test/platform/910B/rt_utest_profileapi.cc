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
#define private public
#define protected public
#include "runtime.hpp"
#include "context.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "prof_map_ge_model_device.hpp"
#include "engine.hpp"
#include "api_impl.hpp"
#include "raw_device.hpp"
#undef protected
#undef private
#include "api.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include <fstream>
#include "prof_ctrl_callback_manager.hpp"
#include "api_error.hpp"
#include "profiling_agent.hpp"
#include "cmodel_driver.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

extern void SetProfilerOn();
extern void SetProfilerOff();
extern void SetEnvVarOn();
extern void SetEnvVarOff();
#define PROF_TASK_TIME_MASK              0x00000002ULL
class ProfileApiTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        SetProfilerOn();
        oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
        Runtime::runtime_->api_ = Runtime::runtime_->profiler_->apiProfileDecorator_;
        Runtime::runtime_->profiler_->profCfg_.isRtsProfEn = 1;

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

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error3<<std::endl;
    }

    static void TearDownTestCase()
    {
        Context *context = NULL;

        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);

        Runtime::runtime_->api_ = oldApi_;
        oldApi_->ContextGetCurrent(&context);
        SetEnvVarOff();
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    void AddObserver()
    {
        Context *context = NULL;
        oldApi_->ContextGetCurrent(&context);
    }

    void DecObserver()
    {
        Context *context = NULL;
        oldApi_->ContextGetCurrent(&context);
        ((RawDevice*)(context->device_))->engine_->observerNum_--;
        ((RawDevice*)(context->device_))->engine_->observers_[((RawDevice*)(context->device_))->engine_->observerNum_] = NULL;
    }

public:
    static Api        *oldApi_;
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
};

Api * ProfileApiTest::oldApi_ = NULL;
rtStream_t ProfileApiTest::stream_ = NULL;
rtEvent_t ProfileApiTest::event_ = NULL;
void* ProfileApiTest::binHandle_ = NULL;
char  ProfileApiTest::function_ = 'a';
uint32_t ProfileApiTest::binary_[32] = {};

TEST_F(ProfileApiTest, stream_create_and_destroy)
{
    rtError_t error;
    rtStream_t stream;

    AddObserver();

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(ProfileApiTest, stream_wait_event_and_sync)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(stream_, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, stream_wait_event_default_stream)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(NULL, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, event_create_and_destroy)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, event_record_and_sync)
{
    rtError_t error;

    error = rtEventRecord(event_, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventSynchronize(event_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    DecObserver();
}

TEST_F(ProfileApiTest, kernel_launch)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    error = rtKernelLaunch(&error, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, NULL, 0, NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 0, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ProfileApiTest, kernel_launch_l2_preload)
{
    rtError_t error;
    rtL2Ctrl_t ctrl;
    void *args[] = {&error, NULL};

    memset_s(&ctrl, sizeof(rtL2Ctrl_t), 0, sizeof(rtL2Ctrl_t));

    ctrl.size = 0;

    /* preload is right */
    ctrl.size = 128;
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), &ctrl, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

static rtError_t kernel_launch_stub(const void *stubFunc,
                         uint32_t blockDim,
                         void *args,
                         uint32_t argsSize,
                         rtSmDesc_t *smDesc,
                         rtStream_t stream)
{
    return (stubFunc == &ProfileApiTest::function_)
          && (blockDim == 1)
          && (((void **)args)[0] == (void*)100)
          && (((void **)args)[1] == (void*)200)
          && (argsSize == 2*sizeof(void*))
          && (smDesc == NULL)
          && (stream == ProfileApiTest::stream_)
          ? RT_ERROR_NONE
          : RT_ERROR_INVALID_VALUE;
}

TEST_F(ProfileApiTest, kernel_launch_config)
{
    rtSmDesc_t desc;
    rtError_t error;
    void *args[] = {(void*)100, (void*)200};

    MOCKER(rtKernelLaunch).stubs().will(invoke(kernel_launch_stub));

    desc.size = 128;

    error = rtConfigureCall(1, NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtConfigureCall(1, &desc, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetupArgument(&args[0], sizeof(void*), 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetupArgument(&args[1], sizeof(void*), sizeof(void*));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLaunch(&function_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtSetupArgument(NULL, sizeof(void*), 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLaunch(&function_);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, kernel_trans_arg)
{
    rtError_t error;
    void *arg = NULL;

    error = rtKernelConfigTransArg(NULL, 128, 0, &arg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelConfigTransArg(&error, 128, 0, &arg);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, kernel_launch_ex)
{
    rtError_t error;
    error = rtKernelLaunchEx((void *)1, 1, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, kernel_launch_with_default_stream)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, get_device_count)
{
    rtError_t error;
    int32_t count;

    error = rtGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, get_device_handle)
{
    rtError_t error;
    int32_t handle;

    error = rtGetDevice(&handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, set_device_repeat)
{
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, get_priority_range)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, device_mem_alloc_free)
{
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, device_dvpp_mem_alloc_free)
{
    rtError_t error;
    void * devPtr;

    error = rtDvppMalloc(&devPtr, 64, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, memcpy_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, memcpy_async_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);
    //EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, hosttask_memcpy_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    error = api.MemcpyHostTask(NULL, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.MemcpyHostTask(devPtr, 64, NULL, 64, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = api.MemcpyHostTask(devPtr, 0, hostPtr, 0, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, hosttask_memcpy_default_stream)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(cmodelDrvMemcpy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtMemcpyHostTask(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, memcpy_async_host_to_device_default_stream)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    //EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}



TEST_F(ProfileApiTest, dev_sync_null)
{
    int32_t devId;
    rtError_t error;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

//    error = rtDeviceReset(0);
//    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceSynchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ProfileApiTest, dev_sync_ok)
{
    rtError_t error;

    error = rtDeviceSynchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, dev_get_all)
{
    int32_t devId;
    rtError_t error;

    //error = rtGetDevice(NULL);
    //EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

   // error = rtDeviceReset(0);
   // EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devId, 0);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

// TEST_F(ProfileApiTest, device_exchange)
// {
//     int32_t devId;
//     rtError_t error;

//     error = rtGetDevice(&devId);
//     EXPECT_EQ(error, RT_ERROR_NONE);

//     (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

//     error = rtSetDevice(1);
//     EXPECT_EQ(error, RT_ERROR_NONE);
//     error = rtDeviceReset(1);
//     EXPECT_EQ(error, RT_ERROR_NONE);

// //    error = rtDeviceReset(0);
//  //   EXPECT_EQ(error, RT_ERROR_NONE);

//     error =rtSetDevice(devId);
//     EXPECT_EQ(error, RT_ERROR_NONE);
//     error = rtDeviceReset(devId);
//     EXPECT_EQ(error, RT_ERROR_NONE);

//     (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
// }

TEST_F(ProfileApiTest, dev_default_use)
{
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;
    int32_t devId, defaultDevId;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //error = rtCtxSetCurrent(NULL);
    //EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    //error = rtDeviceReset(0);
    //EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&defaultDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetDevice(&defaultDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(defaultDevId, 0);

    error =rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, context_create_and_destroy)
{
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;

    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_NE(error, RT_ERROR_NONE);

    //error = rtCtxCreate(NULL, 0, 0);
    //EXPECT_NE(error, RT_ERROR_NONE);

    int32_t devNum = 0;
    error = rtGetDeviceCount(&devNum);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devNum);
    EXPECT_NE(error, RT_ERROR_NONE);

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ctx, (rtContext_t)NULL);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctx);

    //error = rtCtxDestroy(ctx);
    //EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //error = rtCtxDestroy(NULL);
    //EXPECT_NE(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(ProfileApiTest, context_set_and_get)
{
    rtError_t error;
    rtContext_t ctxA, ctxB;
    rtContext_t current = NULL;
    int32_t currentDevId = -1;

    //error = rtCtxGetDevice(NULL);
    //EXPECT_NE(error, RT_ERROR_NONE);

    //error = rtCtxGetCurrent(NULL);
    //EXPECT_NE(error, RT_ERROR_NONE);

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctxB, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctxA);

    error = rtCtxSetCurrent(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctxB);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, context_sync)
{
    rtError_t error;
    rtContext_t ctx;

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, context_destroy_with_stream_abandon)
{
    int32_t devId = 0;
    rtError_t error;
    rtContext_t ctx;
    rtStream_t stream;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, managed_mem)
{
    rtError_t error;
    void *ptr = NULL;

    error = rtMemAllocManaged(&ptr, 128, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
    //EXPECT_EQ(error, RT_ERROR_NONE);
}

/*UT for profiler.cc SetDevice() "if (RT_ERROR_NONE != error)" Line:655*/
TEST_F(ProfileApiTest, SET_DEVICE_TEST_1)
{
    rtError_t error;

	MOCKER_CPP_VIRTUAL((Api *)(((Runtime *)Runtime::Instance())->Api_()), &Api::ContextGetCurrent).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, model_api)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t execStream;
    rtModel_t  model;
    uint32_t taskid = 0;
    uint32_t streamId = 0;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&execStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &taskid, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, execStream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_MODEL_EXECUTE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, notify_record_cloud)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, notify_record_mini)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, stream_with_flag_create_and_destroy)
{
    rtError_t error;
    rtStream_t stream;

    AddObserver();

    error = rtStreamCreateWithFlags(&stream, 0, 0);/*flag = 3*/
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

void STREAM_cb(void *arg)
{
}

static uint32_t g_profilingSwitchFlag = 0;
static uint32_t g_profilingReporterFlag = 0;
static uint32_t g_regkernelLaunchFlag = 0;
static rtError_t StubProfRegisterCtrlCallback(uint32_t dataType, void *data, uint32_t dataLen)
{
    if (dataType == 1) {
        g_profilingSwitchFlag = 1;
    } else if (dataType == 2) {
        g_profilingReporterFlag = 1;
    }
}

static void StubProfilingDelAll()
{
    g_profilingSwitchFlag = 0;
    g_profilingReporterFlag = 0;
}

static rtError_t StubRegkernelLaunchFillFunc(void *cfgAddr, uint32_t cfgLen)
{
    g_regkernelLaunchFlag = cfgLen;
    return 0;
}

TEST_F(ProfileApiTest, rtRegKernelLaunchFillFunc)
{
    uint64_t offset;
    rtError_t error = rtRegKernelLaunchFillFunc("g_opSystemRunCfg", StubRegkernelLaunchFillFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtUnRegKernelLaunchFillFunc("g_opSystemRunCfg");
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtRegKernelLaunchFillFunc("g_opSystemRunCfg", StubRegkernelLaunchFillFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtRegKernelLaunchFillFunc("g_opSystemConfig", StubRegkernelLaunchFillFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtInstance->callbackMap_.count("g_opSystemRunCfg");
    EXPECT_EQ(error, 1);
    rtError_t ret = rtInstance->ExeCallbackFillFunc("g_opSystemRunCfg", (void *)(0x02), 100);
    EXPECT_EQ(g_regkernelLaunchFlag, 100);
    error = rtUnRegKernelLaunchFillFunc("g_opSystemRunCfg");
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtInstance->callbackMap_.count("g_opSystemRunCfg");
    EXPECT_EQ(error, 0);

    MOCKER(halMemCtl).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rtGetL2CacheOffset(0, &offset);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, GetL2CacheOffset_fail)
{
    uint64_t offset;
    MOCKER(halMemCtl).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    ApiErrorDecorator *apiErrDecorator_ = new ApiErrorDecorator(oldApi_);
    rtError_t error = apiErrDecorator_->GetL2CacheOffset(0,&offset);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);
    delete apiErrDecorator_;
}

TEST_F(ProfileApiTest, model_api_cacheTrack)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t execStream;
    rtModel_t  model;
    uint32_t taskid = 0;
    uint32_t streamId = 0;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&execStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetTaskId(model, &taskid, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, execStream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_MODEL_EXECUTE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtProfCommandHandle_t profilerConfig = {0};
    profilerConfig.devNums = 1;
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = 0xc000000084000000ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch |= 0xc000000084000000ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = 0xc000000084000000ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch |= 0xc000000084000000ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = PROF_TASK_TIME_MASK;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

        ProfCtrlCallbackManager::Instance().DelAllData();
    StubProfilingDelAll();
}

TEST_F(ProfileApiTest, rtProfSetProSwitch)
{
    rtProfCommandHandle_t profilerConfig = {0};
    profilerConfig.devNums = 1;
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    rtError_t error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtProfSetProSwitch(NULL, sizeof(profilerConfig));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtProfSetProSwitch(&profilerConfig, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    ProfCtrlCallbackManager::Instance().DelAllData();

    profilerConfig.devNums = 100;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    ProfCtrlCallbackManager::Instance().DelAllData();

    profilerConfig.devNums = 1;
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch |= 0x00800000ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch |= 0x00800000ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch |= 0x00000010ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch |= 0x00000010ULL;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch |= PROF_RUNTIME_PROFILE_LOG_MASK;
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig));
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    ProfCtrlCallbackManager::Instance().DelAllData();
    StubProfilingDelAll();
}

TEST_F(ProfileApiTest, rtSetDeviceIdByGeModelIdx)
{
    rtError_t error = rtSetDeviceIdByGeModelIdx(0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDeviceIdByGeModelIdx(0, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    ProfMapGeModelDevice::Instance().DelAllData();
}

TEST_F(ProfileApiTest, rtUnsetDeviceIdByGeModelIdx)
{
    rtError_t error = rtUnsetDeviceIdByGeModelIdx(0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtUnsetDeviceIdByGeModelIdx(0, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ProfileApiTest, rtGetDeviceIdByGeModelIdx)
{
    uint32_t deviceId = 0;
    rtError_t error = rtGetDeviceIdByGeModelIdx(1, &deviceId);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtGetDeviceIdByGeModelIdx(1, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtSetDeviceIdByGeModelIdx(0, 1);
    error = rtGetDeviceIdByGeModelIdx(0, &deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(deviceId, 1);

    ProfMapGeModelDevice::Instance().DelAllData();
}

TEST_F(ProfileApiTest, rtGetDeviceIdByGeModeIdxWithVisibleDevice)
{
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());

    setenv("ASCEND_RT_VISIBLE_DEVICES", "1", 1);
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;
    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    uint32_t deviceId = 0;
    rtSetDeviceIdByGeModelIdx(0, 0);
    rtError_t error = rtGetDeviceIdByGeModelIdx(0, &deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(deviceId, 0);

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isSetVisibleDev = false;
    rtInstance->userDeviceCnt = 0;
    rtInstance->isHaveDevice_ = haveDevice;
}

TEST_F(ProfileApiTest, RegProfCtrlCallback)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    rtError_t  error = api.RegProfCtrlCallback(1, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfileApiTest, GetMsprofReporterCallback)
{
    auto &instance = ProfilingAgent::Instance();
    EXPECT_NE(&instance, nullptr);
    instance.GetMsprofReporterCallback();
}

TEST_F(ProfileApiTest, NotifyProfInfo)
{
    auto &instance = ProfCtrlCallbackManager::Instance();
    EXPECT_NE(&instance, nullptr);
    instance.NotifyProfInfo(1);
}

TEST_F(ProfileApiTest, EventCreateEx)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ProfileApiTest, get_srvid_by_sdid_test)
{
    rtError_t error;
    uint32_t sdid1 = 0x66660000U;
    uint32_t sdid3 = 0x0U;
    uint32_t srvid = 0;

    error = rtGetServerIDBySDID(sdid1, &srvid);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(ProfileApiTest, prof_mechanism_test)
{
    rtError_t error;
    rtStream_t stream;
    uint64_t profConfig = 1;
    int32_t numsDev = 1;
    uint32_t devid = 0;
    uint32_t *deviceList = &devid;

    Runtime::runtime_->api_ = oldApi_;

    // start profile
    profConfig = 0xc0000000a4000947;
    error = Runtime::runtime_->RuntimeApiProfilerStart(profConfig, numsDev, deviceList);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // stop profile
    profConfig = 0xc000000024000947;
    error = Runtime::runtime_->RuntimeApiProfilerStop(profConfig, numsDev, deviceList);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // start profilelog
    profConfig = 0xc0000000a4000947;
    error = Runtime::runtime_->RuntimeProfileLogStart(profConfig, numsDev, deviceList);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // stop profilelog
    profConfig = 0xc000000024000947;
    error = Runtime::runtime_->RuntimeProfileLogStop(profConfig, numsDev, deviceList);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime::runtime_->api_ = Runtime::runtime_->profiler_->apiProfileDecorator_;
}

TEST_F(ProfileApiTest, device_reset_force_test)
{
    rtError_t error = RT_ERROR_NONE;
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    // stream_在此用例中已经销毁 无需在TearDownTestCase()中重复销毁
    error = rtDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}