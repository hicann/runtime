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

using namespace testing;
using namespace cce::runtime;

class ModelTest910B : public testing::Test {
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

TEST_F(ModelTest910B, model_api)
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
    EXPECT_NE(error, RT_ERROR_NONE);

    // multi model execute
    error = rtModelExecute(model, execStream, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelExecuteSync(model, execStream, 0, -1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(execStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest910B, get_model_id)
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

TEST_F(ModelTest910B, ModelSetSchGroupId_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int16_t schGrpId = 1;

    rtModel_t  model;
    rtError_t error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelSetSchGroupId(model, schGrpId);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    schGrpId = 5;
    error = rtModelSetSchGroupId(model, schGrpId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
TEST_F(ModelTest910B, TestCmoIdFree)
{
    rtError_t error;
    rtModel_t rtModel;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CmoIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CmoIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    uint16_t cmoId = 0;
    model->CmoIdAlloc(0, cmoId);
    model->GetCmoId(0, cmoId);
    model->CmoIdFree();

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(ModelTest910B, model_stream_bind_max)
{
    rtError_t error;
    rtContext_t ctx;
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = (Device *)((Context *)ctx)->Device_();
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_ONLINE)));
    rtModel_t model[257];
    rtStream_t stream;
    uint32_t modelId;
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MODEL_STREAM_REUSE);
    for (uint16_t i = 0; i < 257; i++) {
        error = rtModelCreate(&model[i], 0);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model[0], stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model[256], stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    for (uint16_t i = 0; i < 257; i++) {
        error = rtModelDestroy(model[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
    device->SetTschVersion(version);
}

TEST_F(ModelTest910B, TestAicpuModelDestroyWithFailed)
{
    rtError_t error;
    rtModel_t rtModel;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(ModelTest910B, datadumploadinfo)
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

TEST_F(ModelTest910B, datadumploadinfo_2)
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

TEST_F(ModelTest910B, datadumploadinfo_3)
{
    rtError_t error;
    rtContext_t ctx;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

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

    error = rtVectorCoreKernelLaunch(&function_, 1, &argsInfo, NULL, stream, 0, &taskCfgInfo);
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

TEST_F(ModelTest910B, l1fusiondumpaddrset)
{
    rtError_t error;
    rtContext_t ctx;
    char oldSocVsion[24]={0};

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    (void)rtGetSocVersion(oldSocVsion, sizeof(oldSocVsion));

    rtModel_t  model;
    rtStream_t stream;
    void *dumpAddr = nullptr;
    uint64_t dumpSize = 0x100000;
    rtDevBinary_t devBin;
    void      *binHandle_;
    char       function_;
    uint32_t   binary_[32];
    void *args[] = {&error, NULL};
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary_);
    devBin.data = binary_;

    error = rtMalloc((void **)&dumpAddr, dumpSize, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryRegister(&devBin, &binHandle_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtBinaryRegisterToFastMemory(binHandle_);

    error = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDumpAddrSet(model, dumpAddr, dumpSize, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)rtSetSocVersion("Hi3796CV300CS");
    error = rtDumpAddrSet(model, dumpAddr, dumpSize, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    (void)rtSetSocVersion(oldSocVsion);

    rtArgsEx_t argsInfo = {};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    error = rtKernelLaunchWithFlag(&function_, 1, &argsInfo, NULL, stream, 0x4);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtL2Ctrl_t l2Ctrl = {0};
    error = rtKernelLaunchWithFlag(&function_, 1, &argsInfo, &l2Ctrl, stream, 0x6);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(dumpAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ModelTest910B, TestModelSetupWithDevMemAllocFailed)
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

TEST_F(ModelTest910B, TestModelSetupWithMallocDevValueFailed)
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

TEST_F(ModelTest910B, TestModelSetupWithMallocDevStringEndGraphFailed)
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

TEST_F(ModelTest910B, TestModelSetupWithMallocDevStringAtiveEntryStreamFailed)
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

TEST_F(ModelTest910B, TestMallocDevStringFailed)
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

TEST_F(ModelTest910B, TestMallocDevValueStringFailed)
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

TEST_F(ModelTest910B, TestAicpuModelDestroyWithSubmitTaskFailed)
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

TEST_F(ModelTest910B, TestAicpuModelDestroyWithSynchronizeFailed)
{
    rtError_t error;
    rtModel_t rtModel;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model* model = static_cast<Model *>(rtModel);
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = model->AicpuModelDestroy();
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    GlobalMockObject::verify();

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ModelTest910B, TestGetStreamToSyncExecute)
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

TEST_F(ModelTest910B, TestMallocExecuteTask)
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

TEST_F(ModelTest910B, TestPacketAllStreamInfoWithAllocFailed)
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

TEST_F(ModelTest910B, TestPacketAllStreamInfoWithCopyFailed)
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

TEST_F(ModelTest910B, TestPacketAllStreamInfoWithFlushFailed)
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

TEST_F(ModelTest910B, TestPacketAicpuModelInfoWithCopyFailed)
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

TEST_F(ModelTest910B, TestPacketAicpuModelInfoWithFlushFailed)
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

TEST_F(ModelTest910B, TestPacketAicpuModelInfoWithPackAicpuTaskError)
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

TEST_F(ModelTest910B, TestPacketAicpuModelInfoWithQueueNotEmpty)
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

TEST_F(ModelTest910B, model_create_fail)
{
    rtError_t error;
    rtModel_t  model;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtModelCreate(&model, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ModelTest910B, save_aicpu_stream_task)
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

TEST_F(ModelTest910B, bind_queue)
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

TEST_F(ModelTest910B, model_maintain_init_fail)
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

TEST_F(ModelTest910B, model_aicpu_stream_reuse)
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

TEST_F(ModelTest910B, model_disable_sq)
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