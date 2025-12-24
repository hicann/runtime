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

class RtApiTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(0);
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

        std::cout<<"api test start:" << error2<<", "<< error3<<", "<<error4<<std::endl;
    }

    static void TearDownTestCase()
    {
        rtError_t error2 = rtEventDestroy(event_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"api test start end : "<<", "<<error2<<", "<<error3<<std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
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
    static Driver*    driver_;
};
rtStream_t RtApiTest::stream_ = NULL;
rtEvent_t RtApiTest::event_ = NULL;
void* RtApiTest::binHandle_ = nullptr;
char  RtApiTest::function_ = 'a';
uint32_t RtApiTest::binary_[32] = {};
Driver* RtApiTest::driver_ = NULL;

TEST_F(RtApiTest, api_rtsSetCmoDesc)
{
    rtError_t error;

    rtCmoAddrInfo cmoAddrInfo;
    void *srcAddr = nullptr;
    error = rtMalloc(&srcAddr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsSetCmoDesc(&cmoAddrInfo, srcAddr, 64);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFree(srcAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_02)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_03)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    uint32_t num;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelGetNodes(model, &num);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_06)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t  newModel;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &newModel);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_08)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;
}

TEST_F(RtApiTest, capture_api_09)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Context::StreamActive)
                .stubs()
                .will(returnValue(RT_ERROR_INVALID_VALUE));

    uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    Runtime::macroValue_.rtsqDepth = 32;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream);


    error = rtStreamEndCapture(stream, &model);


    error = rtModelDestroy(model);


    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime::macroValue_.rtsqDepth = rtsqDepth;
}

TEST_F(RtApiTest, capture_api_15)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStream_t exeStream;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecutorSet(model, 0x1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(exeStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_18)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::StreamCreate)
               .stubs()
               .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_19)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::ModelBindStream)
               .stubs()
               .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);

    error = rtStreamDestroy(stream);
}

TEST_F(RtApiTest, capture_api_20)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t model;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * streamEx = static_cast<Stream *>(stream);
    Model * modelEx = static_cast<Model *>(model);
    Context * ctx = static_cast<Context *>(current);
    error = ctx->StreamAddToCaptureModelProc(streamEx, modelEx);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = ctx->StreamAddToCaptureModelProc(streamEx, NULL);
    EXPECT_EQ(error, RT_ERROR_MODEL_NULL);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_21)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t model;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * streamEx = static_cast<Stream *>(stream);
    Model * modelEx = static_cast<Model *>(model);
    Context * ctx = static_cast<Context *>(current);
    error = ctx->StreamAddToCaptureModelProc(streamEx, modelEx);
    EXPECT_EQ(error, RT_ERROR_MODEL_CAPTURE_STATUS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_22)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t model;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream * streamEx = static_cast<Stream *>(stream);
    Model * modelEx = static_cast<Model *>(captureMdl);
    Context * ctx = static_cast<Context *>(current);
    error = ctx->StreamAddToCaptureModelProc(streamEx, modelEx);
    EXPECT_EQ(error, RT_ERROR_STREAM_CAPTURED);

    ctx->FreeCascadeCaptureStream(NULL);
    Stream * streamNew = NULL;
    error = ctx->AllocCascadeCaptureStream(streamEx, NULL, &streamNew);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_23)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_24)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::ModelCreate)
               .stubs()
               .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_25)
{
    rtError_t error;
    rtStream_t stream;

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Context * ctx = static_cast<Context *>(current);
    Model *model;
    error = ctx->ModelCreate(&model, RT_MODEL_CAPTURE_MODEL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = ctx->ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *model2;
    error = ctx->ModelCreate(&model2, RT_MODEL_NORMAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = ctx->ModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_28)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // 校验阻拦接口
    error = rtModelSetExtId(model, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtEndGraph(model, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelExecutorSet(model, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelBindQueue(model, 0, RT_MODEL_INPUT_QUEUE);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelCreateV2(&model, model);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLabelCreateExV2(&model, model, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_29)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_30)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    error = rtModelDebugDotPrint(captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_31)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t addStream;
    error = rtStreamCreate(&addStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamAddToModel(addStream, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::AddNotifyToAddedCaptureStream)
               .stubs()
               .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_32)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t addStream;
    error = rtStreamCreate(&addStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::StreamAddToCaptureModelProc)
               .stubs()
               .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtStreamAddToModel(addStream, model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_33)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t addStream;
    error = rtStreamCreate(&addStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamAddToModel(addStream, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::SetNotifyForExeModel)
               .stubs()
               .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_34)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t addStream;
    error = rtStreamCreate(&addStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamAddToModel(addStream, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::CreateNotify).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtStreamEndCapture(stream, &model);

    error = rtModelDestroy(model);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_37)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t captureMdl;
    rtCallback_t stub_func = (rtCallback_t)0x12345;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::SubscribeReport).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtsCallbackLaunch(stub_func, nullptr, stream, true);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_38)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t captureMdl;
    rtCallback_t stub_func = (rtCallback_t)0x12345;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCallbackLaunch(stub_func, nullptr, stream, true);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCallbackLaunch(stub_func, nullptr, stream, true);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_39)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t captureMdl;
    rtCallback_t stub_func = (rtCallback_t)0x12345;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCallbackLaunch(stub_func, nullptr, stream, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCallbackLaunch(stub_func, nullptr, stream, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport(1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_40)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t captureMdl;
    rtCallback_t stub_func = (rtCallback_t)0x12345;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchHostFunc(stream, stub_func, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_mutil_thread)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    Stream *s = RtPtrToPtr<Stream*>(stream);
    s->SetBeginCaptureThreadId(0);
    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CAPTURE_WRONG_THREAD);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtApiTest, capture_api_mutil_thread_2)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_RELAXED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    Stream *s = RtPtrToPtr<Stream*>(stream);
    s->SetBeginCaptureThreadId(0);
    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}