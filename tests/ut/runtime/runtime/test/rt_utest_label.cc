/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/time.h>
#include <cstdio>
#include <stdlib.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "context.hpp"
#include "device.hpp"
#include "engine.hpp"
#include "task_info.hpp"
#include "label.hpp"
#include "npu_driver.hpp"
#include "model.hpp"
#include "task_res.hpp"
#include "device/device_error_proc.hpp"
#include "raw_device.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;
class LabelTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        rtSetDevice(0);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }

};

TEST_F(LabelTest, free_labelAllocator)
{
    rtError_t error;
    LabelAllocator labelAllocator(RT_MAX_LABEL_NUM);
    uint16_t id;

    error = labelAllocator.LabelIdAlloc(id);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(LabelTest, label_id_alloc_fail)
{
    rtError_t error;
    uint16_t id;
    LabelAllocator labelAllocator(RT_MAX_LABEL_INIT_NUM);

    labelAllocator.freeLabelIdsList.clear();
    labelAllocator.freeLabelIdsList.push_back(RT_MAX_LABEL_INIT_NUM);

    error = labelAllocator.LabelIdAlloc(id);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(LabelTest, label_id_alloc_not_model)
{
    rtError_t error;
    uint16_t id = 0;
    Label label(nullptr);
    label.labelId_ = 0;
    MOCKER_CPP(&LabelAllocator::LabelIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = label.LabelIdAlloc(id);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}

TEST_F(LabelTest, label_id_free_model_released)
{
    rtError_t error;
    uint16_t id = 0;
    Model *model = new Model();
    Label *label = new Label(model);
    label->labelId_ = 0;
    MOCKER_CPP(&LabelAllocator::LabelIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LabelFree).stubs().will(returnValue(RT_ERROR_NONE));
    error = label->LabelIdFree(id);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete label;
    delete model;
    GlobalMockObject::verify();
}

TEST_F(LabelTest, label_switch)
{
    rtError_t error;
    uint16_t id = 0;
    rtStream_t stream = NULL;

    Model *model = new Model();
    error = rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;
    Context *ctx = (Context *)stm->Context_();
    Label *label = new Label(model);
    stm->SetModel(model);
    stm->SetLatestModlId(model->Id_());
    label->labelId_ = 0;
    label->stream_ = stm;
    label->context_ = ctx;

    MOCKER_CPP(&LabelAllocator::LabelIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(LabelSwitchTaskInit).stubs().will(returnValue(RT_ERROR_NONE));

    error = label->Switch(nullptr, RT_GREATER_OR_EQUAL, 0, stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete label;
    delete model;
    stm->models_.clear();
    rtStreamDestroy(stream);
    GlobalMockObject::verify();
}

TEST_F(LabelTest, label_StreamGoto)
{
    rtError_t error;
    uint16_t id = 0;
    rtStream_t stream = NULL;

    Model *model = new Model();
    error = rtStreamCreate(&stream, 0);
    usleep(100000);   // wait for create_stream task done
    TaskResManage *trm = new (std::nothrow) TaskResManage();
    Stream *stm = (Stream *)stream;
    Context *ctx = (Context *)stm->Context_();
    Label *label = new Label(model);
    trm->taskPoolNum_ = 1;
    stm->SetModel(model);
    stm->taskResMang_ = trm;
    label->labelId_ = 0;
    label->stream_ = stm;
    label->context_ = ctx;

    MOCKER_CPP(&LabelAllocator::LabelIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(LabelSwitchTaskInit).stubs().will(returnValue(RT_ERROR_NONE));

    error = label->StreamGoto(stm);
    error = label->Set(stm);
    error = label->Switch(nullptr, RT_GREATER_OR_EQUAL, 0, stm);
    error = label->Goto(stm);
    stm->DelModel(model);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    delete label;
    delete model;
    GlobalMockObject::verify();
}

TEST_F(LabelTest, label_id_free_fail)
{
    rtError_t error;
    uint16_t id = 0;
    LabelAllocator labelAllocator(RT_MAX_LABEL_NUM);
    labelAllocator.labelIds_[id] = 0;

    error = labelAllocator.LabelIdFree(id);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(LabelTest, label_task_submit)
{
    rtError_t error;
    uint32_t value = 0;
    rtModel_t model;
    rtStream_t stream;
    rtLabel_t label;
    rtContext_t ctx;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_INIT);
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelGoto(label, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtLabelSet(label, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(LabelTest, label_gotoex_task_submit)
{
    rtError_t error;
    uint32_t value = 0;
    rtModel_t model;
    rtStream_t stream;
    rtLabel_t label;
    rtContext_t ctx;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_INIT);
    
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelGotoEx(label, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelSet(label, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

rtError_t LabelGotoTaskInitStubErr(TaskInfo* taskInfo, const uint16_t lblId)
{
    taskInfo->liteStreamResId = RTS_INVALID_RES_ID;
    taskInfo->liteTaskResId = RTS_INVALID_RES_ID;
    taskInfo->type = TS_TASK_TYPE_LABEL_GOTO;
    taskInfo->typeName = "LABEL_GOTO";
    taskInfo->u.labelGotoTask.labelId = lblId;
    return RT_ERROR_INVALID_VALUE;
}

rtError_t LabelSetTaskInitStubErr(TaskInfo* taskInfo, const uint16_t labelIndex, void * const devDestAddr)
{

    taskInfo->liteStreamResId = RTS_INVALID_RES_ID;
    taskInfo->liteTaskResId = RTS_INVALID_RES_ID;
    taskInfo->type = TS_TASK_TYPE_LABEL_SET;
    taskInfo->typeName = "LABEL_SET";
    taskInfo->u.labelSetTask.labelId = labelIndex;
    taskInfo->u.labelSetTask.devDstAddr = devDestAddr;
    return RT_ERROR_INVALID_VALUE;
}

rtError_t StreamLabelGotoTaskInitStubErr(TaskInfo* taskInfo, const uint16_t lblId)
{
    taskInfo->liteStreamResId = RTS_INVALID_RES_ID;
    taskInfo->liteTaskResId = RTS_INVALID_RES_ID;
    taskInfo->typeName = "STREAM_LABEL_GOTO";
    taskInfo->type = TS_TASK_TYPE_STREAM_LABEL_GOTO;
    taskInfo->u.streamLabelGotoTask.labelId = lblId;
    RT_LOG(RT_LOG_DEBUG, "stream label goto task, labelId=%u.",
        static_cast<uint32_t>(taskInfo->u.streamLabelGotoTask.labelId));
    return RT_ERROR_INVALID_VALUE;
}

TEST_F(LabelTest, label_task_recycle)
{
    rtError_t error;
    uint32_t value = 0;
    rtModel_t model;
    rtStream_t stream;
    rtLabel_t label;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelCreateV2(&label, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(LabelGotoTaskInit).stubs().will(invoke(LabelGotoTaskInitStubErr));

    error = rtLabelGoto(label, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(LabelSetTaskInit).stubs().will(invoke(LabelSetTaskInitStubErr));

    error = rtLabelSet(label, stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    MOCKER(StreamLabelGotoTaskInit).stubs().will(invoke(StreamLabelGotoTaskInitStubErr));

    error = rtLabelGotoEx(label, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtLabelDestroy(label);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(LabelTest, model_load_complete_mini)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(LabelTest, STARS_EventTimeout_ErrorInfo)
{
    rtSetDevice(1);
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};

    rtError_t ret = errorProc->ProcessStarsWaitTimeoutErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    errorInfo.u.timeoutErrorInfo.waitType = 5;
    ret = errorProc->ProcessStarsWaitTimeoutErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    rtDeviceReset(1);
}

TEST_F(LabelTest, STARS_WaitTimeout_ErrorInfo)
{
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};
    rtError_t ret = errorProc->ProcessStarsWaitTimeoutErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    errorInfo.u.timeoutErrorInfo.waitType = 7;
    ret = errorProc->ProcessStarsWaitTimeoutErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(LabelTest, STARS_OtherTimeout_ErrorInfo)
{
    Device* device= ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device);
    StarsDeviceErrorInfo errorInfo = {};
    rtError_t ret = errorProc->ProcessStarsWaitTimeoutErrorInfo(nullptr, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    errorInfo.u.timeoutErrorInfo.waitType = 63;
    ret = errorProc->ProcessStarsWaitTimeoutErrorInfo(&errorInfo, 0, device, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete errorProc;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}