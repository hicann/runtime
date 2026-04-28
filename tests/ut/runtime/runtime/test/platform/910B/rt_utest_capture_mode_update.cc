/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "capture_model_utils.hpp"
#include "thread_local_container.hpp"
#include "../../data/elf.h"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2CaptureModelUpdateTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        auto ret = rtSetDevice(0);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
        Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
        MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_ELF;
        devBin.version = 2;
        devBin.data = (void*)elf_o;
        devBin.length = elf_o_len;
        ret = rtDevBinaryRegister(&devBin, &binHandle_);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        ret = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }
    }

    virtual void TearDown()
    {
        auto ret = rtDevBinaryUnRegister(binHandle_);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

public:
    void* binHandle_;
    char function_;
    uint32_t binary_[32];
};

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskGetParams_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 1);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetParams_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 1;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    char rawInfo[] = "test_op_info_data";
    params.opInfoPtr = (void *)rawInfo;
    params.opInfoSize = sizeof(rawInfo);
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelUpdate_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 1;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDisable_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 1;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDisable_failed)
{
    void *srcPtr;
    void *dstPtr;
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver * rawDrv = new NpuDriver();
    rtPointerAttributes_t rtAttributes;
    rtAttributes.deviceID = 0;
    rtAttributes.memoryType = RT_MEMORY_TYPE_DEVICE;
    rtAttributes.locationType = RT_MEMORY_LOC_DEVICE;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::PointerGetAttributes)
        .stubs()
        .with(outBoundP(&rtAttributes, sizeof(rtAttributes)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    ret = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = rtModelTaskDisable(inputTasks[1]);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtFree(srcPtr);
    rtFree(dstPtr);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDefault_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

void CreateEventTaskModel(rtStream_t& stream, rtStream_t& stream2, rtEvent_t& event, rtEvent_t& event2,
    rtModel_t& model)
{
    rtError_t ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    
    ret = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventCreateExWithFlag(&event2, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    ret = rtEventRecord(event, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventRecord(event2, stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamWaitEvent(stream, event2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskEventParam001)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtStream_t stream2;
    rtEvent_t event;
    rtEvent_t event2;
    rtModel_t model;
    CreateEventTaskModel(stream, stream2, event, event2, model);

    uint32_t numStreams = 2;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 2);

    uint32_t numTask = 4;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[1], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RECORD);
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, 107000);

    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_WAIT);

    ret = rtModelTaskGetParams(inputTasks[2], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RESET);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtEventDestroy(event);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventDestroy(event2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

void CreateValueTaskModel(rtStream_t& stream, rtModel_t& model, void *addr)
{
    rtError_t ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    ret = rtsValueWrite(addr, 1, 0, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtsValueWait(addr, 1, 0, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskGetValueParam001)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtModel_t model;
    void *devAddr;
    ret = rtMalloc(&devAddr, 64U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    CreateValueTaskModel(stream, model, devAddr);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WRITE);
    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WAIT);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtFree(devAddr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetValueParam001)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtModel_t model;
    void *addr;
    ret = rtMalloc(&addr, 1024U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    CreateValueTaskModel(stream, model, addr);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WRITE);
    params.type = RT_TASK_VALUE_WAIT;
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WAIT);
    params.type = RT_TASK_VALUE_WRITE;
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtFree(addr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}


TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetValueParam002)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtStream_t exeStream;
    rtModel_t model;
    void *addr;
    ret = rtMalloc(&addr, 1024U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    CreateValueTaskModel(stream, model, addr);

    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WRITE);
    params.type = RT_TASK_VALUE_WAIT;
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WAIT);

    ret = rtModelExecute(model, exeStream, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtFree(addr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}
