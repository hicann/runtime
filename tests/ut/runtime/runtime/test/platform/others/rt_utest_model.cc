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
#include "rt_unwrap.h"
#include "../../data/elf.h"
#include "../../common/rt_utest_context_reset_helper.hpp"

using namespace testing;
using namespace cce::runtime;

class ChipModelTest : public testing::Test {
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
        GlobalMockObject::reset();
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
    }

};

TEST_F(ChipModelTest, TestCmoIdFree)
{
    rtError_t error;
    rtModel_t rtModel;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CmoIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CmoIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *model = rt_ut::UnwrapOrNull<Model>(rtModel);
    rtChipType_t chipType = ((RawDevice*)device)->chipType_;
    ((RawDevice*)device)->chipType_ = CHIP_AS31XM1;
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    uint16_t cmoId = 0;
    model->CmoIdAlloc(0, cmoId);
    model->GetCmoId(0, cmoId);
    model->CmoIdFree();
    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
    ((RawDevice*)device)->chipType_ = chipType;

    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipModelTest, TestAicpuModelDestroyWithFailed)
{
    rtError_t error;
    rtModel_t rtModel;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *model = rt_ut::UnwrapOrNull<Model>(rtModel);
    rtChipType_t preChipType = ((Runtime *)Runtime::Instance())->GetChipType();

    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
    error = rtModelDestroy(rtModel);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipModelTest, TestSynchronizeExecuteTimeout)
{
    rtError_t error;
    rtModel_t rtModel;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    const bool disableThread = rtInstance->GetDisableThread();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    Device *device = rtInstance->DeviceRetain(0, 0);
    rtStream_t rtStream;
    error = rtStreamCreate(&rtStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model *model = rt_ut::UnwrapOrNull<Model>(rtModel);

    Runtime::Instance()->SetDisableThread(true);
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    Stream *stream_var = rt_ut::UnwrapOrNull<Stream>(rtStream);
    MOCKER_CPP_VIRTUAL(stream_var, &Stream::Synchronize)
        .stubs()
        .will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    model->SetModelExecutorType(EXECUTOR_TS);

    error = model->SynchronizeExecute(rt_ut::UnwrapOrNull<Stream>(rtStream));
    EXPECT_EQ(error, RT_ERROR_STREAM_SYNC_TIMEOUT);

    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    error = model->SynchronizeExecute(rt_ut::UnwrapOrNull<Stream>(rtStream));
    EXPECT_EQ(error, RT_ERROR_STREAM_SYNC_TIMEOUT);

    GlobalMockObject::verify();
    GlobalMockObject::reset();

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    rtInstance->SetDisableThread(disableThread);
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipModelTest, model_stream_bind_max)
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
    rtChipType_t oldChipType = Runtime::Instance()->GetChipType();
    Runtime::Instance()->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
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

    error = rtModelUnbindStream(model[0], stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    for (uint16_t i = 0; i < 257; i++) {
        error = rtModelDestroy(model[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetTschVersion(version);
    Runtime::Instance()->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ChipModelTest, datadumploadinfo_3)
{
    rtError_t error;
    rtContext_t ctx;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t  model;
    rtStream_t stream;
    rtDevBinary_t devBin;
    void      *binHandle_;
    char       function_;
    uint32_t   binary_[32];
    void *args[] = {&error, NULL};
    devBin.magic = RT_DEV_BINARY_MAGIC_ELF;
    devBin.version = 2;
    devBin.data = (void*)elf_o;
    devBin.length = elf_o_len;
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

TEST_F(ChipModelTest, l1fusiondumpaddrset)
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
    devBin.magic = RT_DEV_BINARY_MAGIC_ELF;
    devBin.version = 2;
    devBin.data = (void*)elf_o;
    devBin.length = elf_o_len;

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
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtKernelLaunchWithFlag(&function_, 1, &argsInfo, &l2Ctrl, stream, 0x6);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(dumpAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDevBinaryUnRegister(binHandle_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
}

TEST_F(ChipModelTest, model_stream_offline_ok)
{
    rtError_t error;
    rtContext_t ctx;
    rtModel_t model;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = (Device *)((Context *)ctx)->Device_();
    Device *heldDevice = rtInstance->DeviceRetain(device->Id_(), device->DevGetTsId());
    ASSERT_EQ(heldDevice, device);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MODEL_STREAM_REUSE);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)));
    rtChipType_t oldChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    GlobalContainer::SetSocVersion("");
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    heldDevice->SetTschVersion(version);
    rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
    rtInstance->DeviceRelease(heldDevice);
}

TEST_F(ChipModelTest, model_stream_offline_fail)
{
    rtError_t error;
    rtContext_t ctx;
    rtModel_t model1;
    rtModel_t model2;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = (Device *)((Context *)ctx)->Device_();
    Device *heldDevice = rtInstance->DeviceRetain(device->Id_(), device->DevGetTsId());
    ASSERT_EQ(heldDevice, device);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MODEL_STREAM_REUSE);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)));
    rtChipType_t oldChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    GlobalContainer::SetSocVersion("");
    error = rtModelCreate(&model1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model1, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model2, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    error = rtModelUnbindStream(model1, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    heldDevice->SetTschVersion(version);
    rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
    rtInstance->DeviceRelease(heldDevice);
}

TEST_F(ChipModelTest, LoadCompleteByStreamPrep_UseDefaultStream_310P)
{
    rtError_t error;
    rtContext_t ctx;
    rtModel_t model;
    rtStream_t stream;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *device = (Device *)((Context *)ctx)->Device_();
    Device *heldDevice = rtInstance->DeviceRetain(device->Id_(), device->DevGetTsId());
    ASSERT_EQ(heldDevice, device);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MODEL_STREAM_REUSE);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode)
        .stubs().will(returnValue(static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)));
    rtChipType_t oldChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    GlobalContainer::SetSocVersion("");
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *resultStream = nullptr;
    Model *modelPtr = rt_ut::UnwrapOrNull<Model>(model);
    Stream *ctrlSQStream = modelPtr->context_->DefaultStream_();
    MOCKER_CPP_VIRTUAL(device, &Device::GetCtrlSQStream)
        .stubs()
        .will(returnValue(ctrlSQStream));

    error = modelPtr->LoadCompleteByStreamPrep(resultStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    EXPECT_EQ(resultStream, ctrlSQStream);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    heldDevice->SetTschVersion(version);
    rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
    rtInstance->DeviceRelease(heldDevice);
}
