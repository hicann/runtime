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
#include <unistd.h>
#include <memory>
#include "runtime/rt.h"
#define private public
#define protected public
#include "scheduler.hpp"
#include "event.hpp"
#include "raw_device.hpp"
#include "context.hpp"
#include "stream.hpp"
#include "model.hpp"
#include "profiler.hpp"
#include "profiler_struct.hpp"
#include "thread_local_container.hpp"
#include "toolchain/prof_api.h"
#undef protected
#undef private
#include "model_c.hpp"

using namespace testing;
using namespace cce::runtime;

class ModelTest : public testing::Test
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
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }

};

TEST_F(ModelTest, TestModelSetupWithDevMemAllocFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::ModelIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_DRV_INPUT));
    error = rtModelCreate(&rtModel, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_NE(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestModelSetupWithMallocDevValueFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::ModelIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_DRV_INPUT));
    error = rtModelCreate(&rtModel, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_NE(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestModelSetupWithMallocDevStringEndGraphFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::ModelIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_DRV_INPUT));
    error = rtModelCreate(&rtModel, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_NE(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestModelSetupWithMallocDevStringAtiveEntryStreamFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::ModelIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_DRV_INPUT));
    error = rtModelCreate(&rtModel, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_NE(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocDevStringFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    Model* model = static_cast<Model *>(rtModel);
    char *str = "demo";
    void *ptr = (void*) str;
    error = model->MallocDevString(str, &ptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocDevStringWithMemSetFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemSetSync).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    Model* model = static_cast<Model *>(rtModel);
    char *str = "demo";
    void *ptr = (void*) str;
    error = model->MallocDevString(str, &ptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocDevStringWithMemSyncFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemSetSync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    Model* model = static_cast<Model *>(rtModel);
    char *str = "demo";
    void *ptr = (void*) str;
    error = model->MallocDevString(str, &ptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocDevValueStringFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    Model* model = static_cast<Model *>(rtModel);
    char *str = "demo";
    void *ptr = (void*) str;
    error = model->MallocDevValue(ptr, 1, &ptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocDevValueWithMemSetFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemSetSync).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    Model* model = static_cast<Model *>(rtModel);
    char *str = "demo";
    void *ptr = (void*) str;
    error = model->MallocDevValue(ptr, 1, &ptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocDevValueWithMemSyncFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemSetSync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    Model* model = static_cast<Model *>(rtModel);
    char *str = "demo";
    void *ptr = (void*) str;
    error = model->MallocDevValue(ptr, 1, &ptr);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestAicpuModelDestroyWithSubmitTaskFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = model->AicpuModelDestroy();
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestGetStreamToSyncExecute)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    rtStream_t rtStream;
    error = rtStreamCreate(&rtStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP(&Model::SynchronizeExecute).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    Stream *onlineStream = model->context_->onlineStream_;
    model->context_->onlineStream_ = nullptr;
    error = model->GetStreamToSyncExecute();
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    model->context_->onlineStream_ = onlineStream;
    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestMallocExecuteTask)
{
    rtError_t error;
    rtModel_t rtModel;
    rtStream_t rtStream;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtStreamCreate(&rtStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER(ModelExecuteTaskInit).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = model->SubmitExecuteTask((Stream *)rtStream);
    EXPECT_EQ(error, RT_ERROR_MODEL_EXECUTOR);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStreamDestroy(rtStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAllStreamInfoWithAllocFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_DRV_INPUT));

    rtAicpuModelInfo_t infoAicpuModel;
    error = model->PacketAllStreamInfo(&infoAicpuModel);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAllStreamInfoWithCopyFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_INPUT));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_ONLINE)));

    rtAicpuModelInfo_t infoAicpuModel;
    error = model->PacketAllStreamInfo(&infoAicpuModel);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAllStreamInfoWithFlushFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFlushCache).stubs().will(returnValue(RT_ERROR_DRV_INPUT));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_ONLINE)));

    rtAicpuModelInfo_t infoAicpuModel;
    error = model->PacketAllStreamInfo(&infoAicpuModel);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAicpuModelInfoWithCopyFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFlushCache).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_ONLINE)));

    error = model->PacketAicpuModelInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAicpuModelInfoWithFlushFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFlushCache).stubs().will(returnValue(RT_ERROR_DRV_INPUT));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_ONLINE)));

    error = model->PacketAicpuModelInfo();
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAicpuModelInfoWithStreamNotNull)
{
    rtError_t error;
    rtModel_t rtModel;
    rtStream_t rtStream;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtStreamCreate(&rtStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);

    model->BindStream((Stream*) rtStream, 0);
    MOCKER_CPP(&Model::PacketAllStreamInfo).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    error = model->PacketAicpuModelInfo();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStreamDestroy(rtStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAicpuModelInfoWithPackAicpuTaskError)
{
    rtError_t error;
    rtModel_t rtModel;
    rtStream_t rtStream;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtStreamCreate(&rtStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    rtCommand_t command = {};
    command.type = static_cast<uint16_t>(TS_TASK_TYPE_ACTIVE_AICPU_STREAM);
    model->SaveAicpuStreamTask((Stream *)rtStream, &command);
    MOCKER_CPP(&Model::PacketAicpuTaskInfo).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));

    error = model->PacketAicpuModelInfo();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStreamDestroy(rtStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, TestPacketAicpuModelInfoWithQueueNotEmpty)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    model->BindQueue(0, RT_MODEL_INPUT_QUEUE);

    error = model->PacketAicpuModelInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, model_create_fail)
{
    rtError_t error;
    rtModel_t  model;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtModelCreate(&model, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

rtError_t task_gen_callback(rtModel_t model, rtTaskInfo_t *taskInfo)
{
    return RT_ERROR_NONE;
}



#if 1

TEST_F(ModelTest, CacheTaskTrackReport)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;
    rtStream_t syncStream;
    rtEvent_t event;
    char oldSocVsion[24]={0};

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = (Device *)((Context *)ctx)->Device_();
    device->SetPlatformType(PLATFORM_CLOUD_V1);

    (void)rtGetSocVersion(oldSocVsion, sizeof(oldSocVsion));
    (void)rtSetSocVersion("Ascend910B");

    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    profilerPtr->SetTrackProfEnable(false);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&syncStream, 0, RT_STREAM_FORBIDDEN_DEFAULT);
        EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);


    error=  rtEndGraph(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);

    // synchronize execute
    error = rtModelExecute(model, syncStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);


    profilerPtr->SetTrackProfEnable(true);

    ((Model *)model)->UnbindStream(stream_var , false);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(syncStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetPlatformType(PLATFORM_BEGIN);
    (void)rtSetSocVersion(oldSocVsion);
    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_stream_aicpu_bind)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t exe_stream;
    rtModel_t  model;

    error = rtStreamCreateWithFlags(&stream, 1, RT_STREAM_AICPU);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&exe_stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtEndGraph(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, exe_stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

rtError_t rtGetIsHeterogenousStub(int32_t *heterogenous)
{
    *heterogenous = 1;
    return RT_ERROR_NONE;
}

TEST_F(ModelTest, model_end_graph)
{
    MOCKER(&rtGetIsHeterogenous).stubs().will(invoke(rtGetIsHeterogenousStub));
    rtStream_t stream;
    rtStream_t exe_stream;
    rtModel_t  model;
    rtSocType_t oldSocType = Runtime::Instance()->GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND310P1);
    rtError_t error = rtStreamCreateWithFlags(&stream, 1, RT_STREAM_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&exe_stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error=  rtEndGraph(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, exe_stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    error = rtStreamDestroy(exe_stream);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalContainer::SetSocType(oldSocType);
}
#if 0
TEST_F(ModelTest, model_stream_unbind_task_pool)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    int32_t devId;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    Context *ctx = refObject->GetVal();

    error = rtStreamCreateWithFlags(&stream, 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);

    ((Model *)model)->SetNeedSubmitTask(true);

    //MOCKER_CPP_VIRTUAL( (*(((Context **)&ctx)))->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    Stream *stream_var = static_cast<Stream *>(stream);
    ((Model *)model)->UnbindStream(stream_var , false);

    error = rtStreamDestroy(stream);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //error = rtModelUnbindStream(model, stream);

    ((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}
#endif

TEST_F(ModelTest, datadumploadinfo)
{
    rtError_t error;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t  model;
    rtStream_t stream;
    rtDevBinary_t devBin;
    void      *binHandle_;
    char       function_;
    uint32_t   binary_[32];
    void *args[] = {&error, NULL};
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary_);
    devBin.data = binary_;
    uint32_t   datdumpinfo[32];

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryRegister(&devBin, &binHandle_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtBinaryRegisterToFastMemory(binHandle_);

    error = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *laodstream = (Stream *)(((Context*)ctx)->DefaultStream_());
    laodstream->SetErrCode(1);
    error = rtDatadumpInfoLoad(datdumpinfo, sizeof(datdumpinfo));
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDatadumpInfoLoad(datdumpinfo, sizeof(datdumpinfo));
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    error = rtKernelLaunchWithFlag(&function_, 1, &argsInfo, NULL, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, datadumploadinfo_2)
{
    rtError_t error;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t  model;
    rtStream_t stream;
    rtDevBinary_t devBin;
    void      *binHandle_;
    char       function_;
    uint32_t   binary_[32];
    void *args[] = {&error, NULL};
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 2;
    devBin.length = sizeof(binary_);
    devBin.data = binary_;
    uint32_t   datdumpinfo[32];

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryRegister(&devBin, &binHandle_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtBinaryRegisterToFastMemory(binHandle_);

    error = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *laodstream = (Stream *)(((Context*)ctx)->DefaultStream_());
    laodstream->SetErrCode(1);
    error = rtDatadumpInfoLoad(datdumpinfo, sizeof(datdumpinfo));
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDatadumpInfoLoad(datdumpinfo, sizeof(datdumpinfo));
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    rtTaskCfgInfo_t taskCfgInfo = {};
    taskCfgInfo.qos = 1;
    taskCfgInfo.partId = 1;

    error = rtKernelLaunchWithFlagV2(&function_, 1, &argsInfo, NULL, stream, 0, &taskCfgInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(binHandle_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, IsActiveTaskExceed)
{
    rtError_t error;
    rtContext_t ctx;
    char oldSocVsion[24]={0};

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    (void)rtGetSocVersion(oldSocVsion, sizeof(oldSocVsion));

    rtStream_t aicpuStream;
    rtStream_t activeStream;
    rtModel_t  model;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&aicpuStream, 0, 0x8);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&activeStream, 0, 0x1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, aicpuStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, activeStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)rtSetSocVersion(oldSocVsion);

    error = rtStreamActive(activeStream, aicpuStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(aicpuStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(activeStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_stream_unbind_stream_fail_01)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);

    ((Model *)model)->SetNeedSubmitTask(true);

    Stream *stream_var = static_cast<Stream *>(stream);
    //((Model *)model)->UnbindStream(NULL , true);

    error = rtModelDestroy(model);

    error = rtStreamDestroy(stream);

    //error = rtModelUnbindStream(model, stream);

    error = rtCtxDestroy(ctx);
}


TEST_F(ModelTest, model_stream_unbind_stream_fail_02)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);

    ((Model *)model)->SetNeedSubmitTask(true);

    Stream *stream_var = static_cast<Stream *>(stream);

    //Model model;
    ((Model *)model)->UnbindStream(NULL , false);

    error = rtModelDestroy(model);
    error = rtStreamDestroy(stream);
    error = rtCtxDestroy(ctx);
}

TEST_F(ModelTest, model_stream_unbind_stream_fail_03)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();

    Stream *stream_var = static_cast<Stream *>(stream);
    MOCKER_CPP_VIRTUAL(stream_var, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = ((Model *)model)->UnbindStream(stream_var , false);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    GlobalMockObject::verify();

    error = rtModelDestroy(model);
    error = rtStreamDestroy(stream);
    error = rtCtxDestroy(ctx);
}


#endif

TEST_F(ModelTest, model_stream_excute_task_fail)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    //EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL( (*(((Context **)&ctx)))->Device_(), &Device::SubmitTask).stubs().will(returnValue(ACL_ERROR_RT_PARAM_INVALID));

    error = rtModelExecute(model, stream, 0);
    //EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);

    error = rtCtxDestroy(ctx);
    //EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, save_aicpu_stream_task)
{
    rtError_t error;
    rtStream_t stream;
    rtCommand_t command;
    std::unique_ptr<Model> model = std::make_unique<Model>();

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);

    command.taskID = 1;

    command.type = TS_TASK_TYPE_ACTIVE_AICPU_STREAM;
    error = model->SaveAicpuStreamTask(stream_var, &command);
    EXPECT_EQ(error, RT_ERROR_NONE);

    command.type = TS_TASK_TYPE_KERNEL_AICPU;
    error = model->SaveAicpuStreamTask(stream_var, &command);
    EXPECT_EQ(error, RT_ERROR_NONE);

    command.type = TS_TASK_TYPE_MODEL_END_GRAPH;
    error = model->SaveAicpuStreamTask(stream_var, &command);
    EXPECT_EQ(error, RT_ERROR_NONE);

    command.type = TS_TASK_TYPE_KERNEL_AICORE;
    error = model->SaveAicpuStreamTask(stream_var, &command);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_abort)
{
    rtModel_t model;
    rtContext_t ctx;
    rtError_t error;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *model_var = static_cast<Model *>(model);
    error = model_var->ModelAbort();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, bind_queue)
{
    rtModel_t model;
    rtError_t error;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *model_var = static_cast<Model *>(model);
    error = model_var->BindQueue(1, RT_MODEL_INPUT_QUEUE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, AicpuModelSetExtId)
{
    rtModel_t model;

    rtError_t error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model *model_var = static_cast<Model *>(model);
    error = model_var->AicpuModelSetExtId(0U, 1U);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_head_stream)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;
    uint32_t modelId;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model* tmpMdl = static_cast<Model*>(model);
    uint16_t num = tmpMdl->IsModelHeadStream(static_cast<Stream*>(stream));
    EXPECT_EQ(num, 1);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_stream_not_dc_not_support_reuse)
{
    rtError_t error;
    rtContext_t ctx;
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = (Device *)((Context *)ctx)->Device_();
    rtModel_t model[2];
    rtStream_t stream;
    uint32_t modelId;
    for (uint16_t i = 0; i < 2; i++) {
        error = rtModelCreate(&model[i], 0);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    for (uint16_t i = 0; i < 2; i++) {
        error = rtModelBindStream(model[i], stream, 0);
    }
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    for (uint16_t i = 0; i < 2; i++) {
        error = rtModelDestroy(model[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
}

TEST_F(ModelTest, model_stream_get_head_stream)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;
    uint32_t modelId;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model* tmpMdl = static_cast<Model*>(model);

    EXPECT_EQ(tmpMdl->IsModelHeadStream(static_cast<Stream*>(stream)), 1);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_stream_dup_bind)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;
    uint32_t modelId;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_maintain_init_fail)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;
    uint32_t modelId;
    MOCKER(ModelMaintainceTaskInit).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtModelUnbindStream(model, stream); //bind fail
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, model_aicpu_stream_reuse)
{
    rtError_t error;
    rtModel_t modelA;
    rtModel_t modelB;
    rtStream_t stream;
    error = rtModelCreate(&modelA, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&modelB, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_AICPU);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(modelA, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(modelB, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    error = rtModelUnbindStream(modelA, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(modelA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(modelB);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest, load_comple_81)
{
    rtError_t error = RT_ERROR_NONE;
    rtModel_t model;
    rtStream_t stream;

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetSqTail).stubs().will(returnValue(1));
    bool temp = device->IsAddrFlatDev();
    device->SetDevType(true);
    error = rtModelLoadComplete(model);
    device->SetDevType(temp);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest, model_disable_sq)
{
    rtError_t error;
    rtModel_t model;
    rtContext_t ctx;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model *model_var = static_cast<Model *>(model);
    error = model_var->DisableSq(stream_var);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

static void acl_reg_func(rtStream_t stream, void **binHandle)
{
    rtError_t error;
    rtDevBinary_t devBin;
    char       function_;
    uint32_t   binary_[32];
    void *args[] = {&error, NULL};
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN_AICPU;
    devBin.version = 1;
    devBin.length = sizeof(binary_);
    devBin.data = binary_;
    error = rtDevBinaryRegister(&devBin, binHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFunctionRegister(*binHandle, &function_, "foo", NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

static void acl_unreg_func(void *binHandle)
{
    rtError_t error;
    error = rtDevBinaryUnRegister(binHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

/*
 * 1.模型绑定的首流为RT_STREAM_AICPU,此情形，不支持执行器为TS
 * 2.模型绑定的首流非RT_STREAM_AICPU时，才支持执行器为TS
 * uint8_t executorFlags:执行器标志
 * uint32_t exeStreamFlags:执行流标志,不支持AICPU流
 * uint32_t headStreamFlags:模型首流标志
 * bool exeStreamIsNull:执行流是否为空
 */
rtError_t utest_model_stream_setup_sub(Stream *stream)
{
    stream->streamId_ = 0;
    return RT_ERROR_NONE;
}

static void acl_sink_model_exe(uint8_t executorFlags,uint32_t exeStreamFlags,
uint32_t headStreamFlags, bool exeStreamIsNull = false)
{
    MOCKER_CPP(&Stream::Setup)
        .stubs()
        .will(invoke(utest_model_stream_setup_sub));

    rtError_t error;
    rtStream_t streamTs;
    rtStream_t streamHead;
    rtStream_t streamExe;
    rtModel_t  model;
    void *binHandle = NULL;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    if (!exeStreamIsNull) {
        error = rtStreamCreateWithFlags(&streamExe, 0, exeStreamFlags);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtStreamCreateWithFlags(&streamHead, 0, headStreamFlags);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&streamTs, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);
    if (executorFlags != EXECUTOR_NONE) {
        error = rtModelExecutorSet(model, executorFlags);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    error = rtModelBindStream(model, streamTs, RT_INVALID_FLAG);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, streamHead, RT_HEAD_STREAM);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamActive(streamTs, streamHead);
    EXPECT_EQ(error, RT_ERROR_NONE);
    acl_reg_func(streamHead, &binHandle);

    error = rtEndGraphEx(model, streamTs, 2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExit(model, streamTs);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model, exeStreamIsNull ? NULL: streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, streamHead);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, streamTs);
    EXPECT_EQ(error, RT_ERROR_NONE);

    if (!exeStreamIsNull) {
        error = rtStreamDestroy(streamExe);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    error = rtStreamDestroy(streamHead);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamTs);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    acl_unreg_func(binHandle);
}



/*
* 1.模型首流为AICPU
* 2.执行器为EXECUTOR_NONE
* 3.执行流为RT_STREAM_FORBIDDEN_DEFAULT
*/
#if 0
TEST_F(ModelTest, acl_001_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_NONE;
    uint32_t exeStreamFlags = RT_STREAM_FORBIDDEN_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_AICPU;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

/*
* 1.模型首流为AICPU
* 2.执行器为EXECUTOR_AICPU
* 3.执行流为RT_STREAM_FORBIDDEN_DEFAULT
*/
TEST_F(ModelTest, acl_002_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_AICPU;
    uint32_t exeStreamFlags = RT_STREAM_FORBIDDEN_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_AICPU;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}
/*
* 1.模型首流为AICPU
* 2.执行器为EXECUTOR_NONE
* 3.执行流为RT_STREAM_DEFAULT
*/
TEST_F(ModelTest, acl_003_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_NONE;
    uint32_t exeStreamFlags = RT_STREAM_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_AICPU;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

/*
* 1.模型首流为AICPU
* 2.执行器为EXECUTOR_AICPU
* 3.执行流为RT_STREAM_DEFAULT
*/
TEST_F(ModelTest, acl_004_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_AICPU;
    uint32_t exeStreamFlags = RT_STREAM_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_AICPU;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}
/*
* 1.模型首流为AICPU
* 2.执行器为EXECUTOR_AICPU
* 3.执行流为NULL
*/
TEST_F(ModelTest, acl_005_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_AICPU;
    uint32_t exeStreamFlags = RT_STREAM_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_AICPU;
    bool exeStreamIsNull = true;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags, exeStreamIsNull);
}

/*
* 执行器为TS的情形，小海思都不支持，而DC是支持的，2020-01-04,小海思的单线程开关还没有适配，DC场景无法测试
* 1.模型首流为RT_STREAM_DEFAULT
* 2.执行器为EXECUTOR_NONE
* 3.执行流为RT_STREAM_FORBIDDEN_DEFAULT
*/
TEST_F(ModelTest, acl_006_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_NONE;
    uint32_t exeStreamFlags = RT_STREAM_FORBIDDEN_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_DEFAULT;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

/*
* 执行器为TS的情形，小海思都不支持，而DC是支持的，2020-01-04,小海思的单线程开关还没有适配，DC场景无法测试
* 1.模型首流为RT_STREAM_DEFAULT
* 2.执行器为EXECUTOR_TS
* 3.执行流为RT_STREAM_FORBIDDEN_DEFAULT
*/
TEST_F(ModelTest, acl_007_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_TS;
    uint32_t exeStreamFlags = RT_STREAM_FORBIDDEN_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_DEFAULT;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

/*
* 执行器为TS的情形，小海思都不支持，而DC是支持的，2020-01-04,UT场景可以覆盖到
* 1.模型首流为RT_STREAM_DEFAULT
* 2.执行器为EXECUTOR_NONE
* 3.执行流为RT_STREAM_DEFAULT
*/
TEST_F(ModelTest, acl_008_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_NONE;
    uint32_t exeStreamFlags = RT_STREAM_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_DEFAULT;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

/*
* 执行器为TS的情形，小海思都不支持，而DC是支持的，2020-01-04,UT场景可以覆盖到
* 1.模型首流为RT_STREAM_DEFAULT
* 2.执行器为EXECUTOR_TS
* 3.执行流为RT_STREAM_DEFAULT
*/
TEST_F(ModelTest, acl_009_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_TS;
    uint32_t exeStreamFlags = RT_STREAM_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_DEFAULT;
    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

/*
* 覆盖AICPU流上挂载AICPU算子和endGraph场景
* 没有调用LoadComplete和ModelExe,仅仅覆盖Model::SaveAicpuStreamTask函数
*/
TEST_F(ModelTest, acl_010_sink_model_coverage)
{
    MOCKER_CPP(&Stream::Setup)
        .stubs()
        .will(invoke(utest_model_stream_setup_sub));

    rtError_t error;
    rtStream_t streamTs;
    rtStream_t streamHead;
    rtStream_t streamExe;
    rtModel_t  model;
    void *binHandle = NULL;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&streamExe, 0, RT_STREAM_FORBIDDEN_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&streamHead, 0, RT_STREAM_AICPU);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreateWithFlags(&streamTs, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecutorSet(model, EXECUTOR_AICPU);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, streamTs, RT_INVALID_FLAG);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, streamHead, RT_HEAD_STREAM);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamActive(streamTs, streamHead);
    EXPECT_EQ(error, RT_ERROR_NONE);
    acl_reg_func(streamHead, &binHandle);

    error = rtEndGraphEx(model, streamHead, 2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, streamHead);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, streamTs);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamHead);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamTs);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    acl_unreg_func(binHandle);
}

/*
* 1.模型首流为AICPU
* 2.执行器为EXECUTOR_AICPU
* 3.执行流为NULL
* 4.设置 IsSupportSingleThread 返回 true
*/
TEST_F(ModelTest, acl_011_sink_model_exe)
{
    uint8_t executorFlags = EXECUTOR_AICPU;
    uint32_t exeStreamFlags = RT_STREAM_DEFAULT;
    uint32_t headStreamFlags = RT_STREAM_AICPU;

//    MOCKER_CPP(&Config::IsSupportSingleThread).stubs().will(returnValue(true));

    acl_sink_model_exe(executorFlags, exeStreamFlags, headStreamFlags);
}

TEST_F(ModelTest, model_bind_queue)
{
    rtError_t error;
    rtModel_t model;
    rtModelCreate(&model, 0);
    error = rtModelBindQueue(model, 0, RT_MODEL_INPUT_QUEUE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindQueue(model, 1, RT_MODEL_OUTPUT_QUEUE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindQueue(NULL, 2, RT_MODEL_OUTPUT_QUEUE);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ModelTest, get_model_id)
{
    rtError_t error;
    rtModel_t model;
    uint32_t modelId;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelGetId(model, &modelId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelGetId(model, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelGetId(NULL, &modelId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
#if 0
TEST_F(ModelTest, cancel_surport_single_thread)
{
    rtError_t error;
    rtModel_t model;
    uint32_t  modelId;
    rtStream_t exeStream;
    int32_t  devId;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    Context *ctx = refObject->GetVal();

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithFlags(&exeStream, 0, RT_STREAM_FORBIDDEN_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((RawDevice *)(((Context *)ctx)->device_))->platformConfig_ = 0x300;
    error = rtModelExecute(model, exeStream, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelExecute(model, NULL, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(exeStream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->PrimaryContextRelease(0);
}
#endif
#endif