/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver/ascend_hal.h"
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
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2CaptureModelTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
        rtSetDevice(0);
        Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
            .stubs()
            .with(eq(TS_FEATURE_SOFTWARE_SQ_ENABLE))
            .will(returnValue(true));
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        GlobalMockObject::verify();
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};


TEST_F(CloudV2CaptureModelTest, SUBMIT_RDMA_PI_VALUE_MODIFY_TASK)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    rtFftsPlusSqe_t sqe;
    fftsPlusTaskInfo.fftsPlusSqe = &sqe;
    rtFftsPlusWriteValueCtx_t writeValueCtx;
    writeValueCtx.contextType = RT_CTX_TYPE_WRITE_VALUE_RDMA;
    fftsPlusTaskInfo.descBuf = &writeValueCtx;
    fftsPlusTaskInfo.descBufLen = sizeof(rtFftsPlusWriteValueCtx_t);
    fftsPlusTaskInfo.descAddrType = RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_HOST;
    int32_t deviceDescAlignBuf = 1;
    Context *curCtx = static_cast<Context *>(ctx);
    MOCKER_CPP_VIRTUAL(curCtx->device_, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    ret = SubmitRdmaPiValueModifyTask(static_cast<Stream *>(stream), &fftsPlusTaskInfo, &deviceDescAlignBuf);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_INFO)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    CaptureModel* captureModel = new CaptureModel();
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;
    int32_t piValueModifyStreamId = 1;
    uint16_t piValueModifyTaskId = 1;
    captureModel->InsertRdmaPiValueModifyInfo(piValueModifyStreamId, piValueModifyTaskId);

    TaskInfo piValueModifyTask = {};
    piValueModifyTask.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    piValueModifyTask.u.rdmaPiValueModifyInfo.rdmaSubContextCount = 1;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().with(mockcpp::any(), mockcpp::any()).will(returnValue(&piValueModifyTask));

    std::vector<uint64_t> rdmaPiValueInfo{1};
    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::MemCopySync)
        .stubs()
        .with(outBoundP(static_cast<void*>(rdmaPiValueInfo.data()), sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_INVALID_VALUE;
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    notify.Setup();
    notify.FreeId();
    notify.AllocId();
    uint32_t releaseNum = 0U;
    captureModel->UpdateNotifyId(stm);
    captureModel->ReleaseSqCq(releaseNum);

    captureModel->BuildSqCq(stm);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_INFO)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    CaptureModel* captureModel = new CaptureModel();
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;
    int32_t piValueModifyStreamId = 1;
    uint16_t piValueModifyTaskId = 1;
    captureModel->InsertRdmaPiValueModifyInfo(piValueModifyStreamId, piValueModifyTaskId);

    TaskInfo piValueModifyTask = {};
    piValueModifyTask.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    piValueModifyTask.u.rdmaPiValueModifyInfo.rdmaSubContextCount = 1;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().with(mockcpp::any(), mockcpp::any()).will(returnValue(&piValueModifyTask));

    std::vector<uint64_t> rdmaPiValueInfo{1};
    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::MemCopySync)
        .stubs()
        .with(outBoundP(static_cast<void*>(rdmaPiValueInfo.data()), sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_NONE;
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_INFO_FAIL)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    Model* captureModel = new Model();
    captureModel->modelType_ = RT_MODEL_CAPTURE_MODEL;
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_NONE;
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_INFO_NONE)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    CaptureModel* captureModel = new CaptureModel();
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;
    int32_t piValueModifyStreamId = 1;
    uint16_t piValueModifyTaskId = 1;
    captureModel->InsertRdmaPiValueModifyInfo(piValueModifyStreamId, piValueModifyTaskId);

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_NONE;
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_ZERO)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    CaptureModel* captureModel = new CaptureModel();
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;
    int32_t piValueModifyStreamId = 1;
    uint16_t piValueModifyTaskId = 1;
    captureModel->InsertRdmaPiValueModifyInfo(piValueModifyStreamId, piValueModifyTaskId);

    TaskInfo piValueModifyTask = {};
    piValueModifyTask.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    piValueModifyTask.u.rdmaPiValueModifyInfo.rdmaSubContextCount = 0;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().with(mockcpp::any(), mockcpp::any()).will(returnValue(&piValueModifyTask));

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_NONE;
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_INFO_COPY_FAIL)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = static_cast<Stream*>(stream);

    CaptureModel* captureModel = new CaptureModel();
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;
    int32_t piValueModifyStreamId = 1;
    uint16_t piValueModifyTaskId = 1;
    captureModel->InsertRdmaPiValueModifyInfo(piValueModifyStreamId, piValueModifyTaskId);

    TaskInfo piValueModifyTask = {};
    piValueModifyTask.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    piValueModifyTask.u.rdmaPiValueModifyInfo.rdmaSubContextCount = 1;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().with(mockcpp::any(), mockcpp::any()).will(returnValue(&piValueModifyTask));

    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::MemCopySync)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_NONE;
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, RDMA_PI_VALUE_MODIFY_TASK_INIT_FAILED)
{
    rtStream_t stream;
    auto ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec{1};

    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    ret = RdmaPiValueModifyTaskInit(&taskInfo, rdmaPiValueDeviceAddrVec);
    EXPECT_EQ(ret, RT_ERROR_DRV_MEMORY);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, RDMA_PI_VALUE_MODIFY_TASK_INIT_FAILED_2)
{
    rtStream_t stream;
    auto ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec{1};

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    ret = RdmaPiValueModifyTaskInit(&taskInfo, rdmaPiValueDeviceAddrVec);
    EXPECT_EQ(ret, RT_ERROR_SEC_HANDLE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, RDMA_PI_VALUE_MODIFY_TASK_INIT_FAILED_3)
{
    rtStream_t stream;
    auto ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec{1};

    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(1));

    ret = RdmaPiValueModifyTaskInit(&taskInfo, rdmaPiValueDeviceAddrVec);
    EXPECT_EQ(ret, RT_ERROR_SEC_HANDLE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, RDMA_PI_VALUE_MODIFY_TASK_INIT_FAILED_4)
{
    rtStream_t stream;
    auto ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);
    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec{1};

    MOCKER(memcpy_s).stubs().will(returnValue(0));

    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::MemCopySync)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    ret = RdmaPiValueModifyTaskInit(&taskInfo, rdmaPiValueDeviceAddrVec);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, GET_RDMA_TASK_INFO_EMPTY)
{
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    fftsPlusTaskInfo.descAddrType = RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_DEVICE;
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec;
    GetRdmaTaskInfoFromFftsPlusTask(&fftsPlusTaskInfo, nullptr, rdmaPiValueDeviceAddrVec);
    EXPECT_EQ(0, rdmaPiValueDeviceAddrVec.size());
}

TEST_F(CloudV2CaptureModelTest, GET_RDMA_TASK_INFO_EMPTY_2)
{
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    fftsPlusTaskInfo.descAddrType = RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_HOST;
    fftsPlusTaskInfo.descBufLen = 1;
    std::vector<uint64_t> rdmaPiValueDeviceAddrVec;
    GetRdmaTaskInfoFromFftsPlusTask(&fftsPlusTaskInfo, nullptr, rdmaPiValueDeviceAddrVec);
    EXPECT_EQ(0, rdmaPiValueDeviceAddrVec.size());
}

TEST_F(CloudV2CaptureModelTest, PINRT_ERROR_INFO_RDMA_TASK)
{
    TaskInfo taskInfo = {};
    uint32_t devId = 0;
    PrintErrorInfoForRDMAPiValueModifyTask(&taskInfo, devId);
    EXPECT_EQ(0, devId);
}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_01)
{
    rtError_t error;
    rtStreamCaptureMode mode = RT_STREAM_CAPTURE_MODE_GLOBAL;

    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_GLOBAL);

    mode = RT_STREAM_CAPTURE_MODE_THREAD_LOCAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_GLOBAL);

    mode = RT_STREAM_CAPTURE_MODE_RELAXED;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);

    mode = RT_STREAM_CAPTURE_MODE_GLOBAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_RELAXED);

}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_02)
{
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamCaptureMode mode = RT_STREAM_CAPTURE_MODE_GLOBAL;

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_GLOBAL);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    mode = RT_STREAM_CAPTURE_MODE_THREAD_LOCAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_GLOBAL);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    mode = RT_STREAM_CAPTURE_MODE_RELAXED;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    mode = RT_STREAM_CAPTURE_MODE_GLOBAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_RELAXED);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_03)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model1;
    rtModel_t  model2;
    rtModel_t  model3;
    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream, &model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_RELAXED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_04)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    rtStream_t stream3;
    rtModel_t  model1;
    rtModel_t  model2;
    rtModel_t  model3;

    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqTail).stubs().will(returnValue(1));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream3, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream2, RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream3, RT_STREAM_CAPTURE_MODE_RELAXED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream2, &model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream3, &model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_05)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    rtStream_t stream3;
    rtModel_t  model1;
    rtModel_t  model2;
    rtModel_t  model3;

    void * devPtr;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqTail).stubs().will(returnValue(1));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream3, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_RELAXED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream2, RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream3, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream2, &model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream3, &model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_06)
{
    rtError_t error;
    rtStream_t stream1;
    rtModel_t  model1;
    void * devPtr;
    rtStreamCaptureMode mode;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    mode = RT_STREAM_CAPTURE_MODE_THREAD_LOCAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_GLOBAL);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    mode = RT_STREAM_CAPTURE_MODE_GLOBAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_07)
{
    rtError_t error;
    rtStream_t stream1;
    rtModel_t  model1;
    void * devPtr;
    rtStreamCaptureMode mode;

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_RELAXED);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    mode = RT_STREAM_CAPTURE_MODE_RELAXED;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_GLOBAL);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    mode = RT_STREAM_CAPTURE_MODE_GLOBAL;
    error = rtThreadExchangeCaptureMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_STREAM_CAPTURE_MODE_RELAXED);

    error = rtMemset(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_hardsq)
{
    rtError_t error;
    rtStream_t stream1;
    rtModel_t  model1;

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halSupportFeature).stubs().will(returnValue(false)); // 不支持 FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND
    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, capture_mode_api_normal)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t stream2;
    rtStream_t streamExe;
    rtModel_t  model1;
    void *srcPtr;
    void *dstPtr;
    void *devPtr;

    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    NpuDriver * rawDrv = new NpuDriver();
    rtPointerAttributes_t rtAttributes;
    rtAttributes.deviceID = 0;
    rtAttributes.memoryType = RT_MEMORY_TYPE_DEVICE;
    rtAttributes.locationType = RT_MEMORY_LOC_DEVICE;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::PointerGetAttributes)
                    .stubs()
                    .with(outBoundP(&rtAttributes, sizeof(rtAttributes)), mockcpp::any())
                    .will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    error = rtStreamGetCaptureInfo(stream1, &status, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamAddToModel(stream2, model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsValueWrite(devPtr, 0, 0, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsValueWait(devPtr, 0, 0, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model1, streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsModelExecuteAsync(model1, streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);

    CaptureModel *captureMdl1 = RtPtrToPtr<CaptureModel *>(model1);
    captureMdl1->CaptureModelExecuteFinish();
    uint32_t releaseNum;
    captureMdl1->ReleaseSqCq(releaseNum);
    captureMdl1->BuildSqCq(static_cast<Stream *>(streamExe));

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
    rtFree(srcPtr);
    rtFree(dstPtr);
    rtFree(devPtr);

}
#include "task_info.h"
#include "stream_task.h"
TEST_F(CloudV2CaptureModelTest, capture_activestream)
{
    rtError_t error;
    CaptureModel  cmodel(RT_MODEL_NORMAL);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_STREAM_ACTIVE;
    StreamActiveTaskInfo *streamActiveTask = &(task.u.streamactiveTask);


    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    streamActiveTask->activeStream = static_cast<Stream *>(stream);
    task.stream = static_cast<Stream *>(stream);
    streamActiveTask->activeStreamSqId = 0;

    MOCKER(InitFuncCallParaForStreamActiveTask).stubs().will(returnValue(0));
    cmodel.MarkStreamActiveTask(&task);
    cmodel.context_ = static_cast<Stream *>(stream)->context_;
    cmodel.UpdateStreamActiveTaskFuncCallMem();

    MOCKER(ReConstructStreamActiveTaskFc).stubs().will(returnValue(1));
    cmodel.UpdateStreamActiveTaskFuncCallMem();

    static_cast<Stream *>(stream)->StarsCheckSqeFull(1);
    static_cast<Stream *>(stream)->StarsSqTailAdd();
    static_cast<Stream *>(stream)->StarsSqHeadSet(0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, capture_activestream_nulltask)
{
    rtError_t error;
    rtContext_t currentCtx;
    CaptureModel  cmodel(RT_MODEL_NORMAL);

    error = rtCtxGetCurrent(&currentCtx);
    cmodel.context_ = static_cast<Context *>(currentCtx);
    cmodel.MarkStreamActiveTask(nullptr);
    error = cmodel.UpdateStreamActiveTaskFuncCallMem();
}

TEST_F(CloudV2CaptureModelTest, capture_mode_try_recycle)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t streamExe;
    rtModel_t  model1, model2, model3;
    void *srcPtr;
    void *dstPtr;

    error = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelExecute(model1, streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halStreamTaskFill).stubs().will(returnValue(DRV_ERROR_COPY_USER_FAIL));
    error = rtModelExecute(model2, streamExe, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_COPY_DATA);

    rtContext_t ctx;
    error = rtCtxGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = (RtPtrToPtr<Context *>(ctx))->TryRecycleCaptureModelResource(1, 1, RtPtrToPtr<CaptureModel *>(model3));
    EXPECT_EQ(error, RT_ERROR_NONE);

    CaptureModel *captureMdl1 = RtPtrToPtr<CaptureModel *>(model1);
    captureMdl1->CaptureModelExecuteFinish();

    CaptureModel *captureMdl2 = RtPtrToPtr<CaptureModel *>(model2);
    captureMdl2->CaptureModelExecuteFinish();

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtFree(srcPtr);
    rtFree(dstPtr);
}

TEST_F(CloudV2CaptureModelTest, poll_end_graph_notify)
{
    rtError_t error;
    rtStream_t stream1;
    rtStream_t streamExe;
    rtModel_t  model1, model2, model3;

    error = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream1, &model3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    RawDevice* rawDevice = RtPtrToPtr<RawDevice *>(device);

    RtPtrToPtr<Stream *>(streamExe)->taskPosTail_.Set(5000);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 10);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 100);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model2), 2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model2), 20);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model3), 3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model3), 30);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDevice->DeleteEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model3), 3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->DeleteEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model3), 30);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDevice->ClearEndGraphNotifyInfoByModel(RtPtrToPtr<Model *>(model2));
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint16_t head_stub = 15;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(head_stub))
        .will(returnValue(RT_ERROR_NONE));
    RtPtrToPtr<Stream *>(streamExe)->taskPosTail_.Set(15);
    rawDevice->PollEndGraphNotifyInfo();

    RtPtrToPtr<Stream *>(streamExe)->taskPosTail_.Set(5);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 10);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 100);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rawDevice->PollEndGraphNotifyInfo();

    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 120);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 49);
    EXPECT_EQ(error, RT_ERROR_NONE);
    RtPtrToPtr<Stream *>(streamExe)->taskPosTail_.Set(50);
    rawDevice->PollEndGraphNotifyInfo();

    error = rawDevice->DeleteEndGraphNotifyInfo(RtPtrToPtr<Stream *>(streamExe), RtPtrToPtr<CaptureModel *>(model1), 49);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(streamExe);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

void StubAddCaptureSqeNum(Stream* ptr, uint32_t sqeNum)
{
    static uint32_t count = 1;
    if (count == 1) {
        ptr->captureSqeNum_ += 32736;
    } else {
        ptr->captureSqeNum_ += sqeNum;
    }

    count++;
}

TEST_F(CloudV2CaptureModelTest, cascade_stream)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtSocType_t socType = GlobalContainer::GetSocType();
    GlobalContainer::SetSocType(SOC_ASCEND910B2);

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t streamExe;
    ret = rtStreamCreate(&streamExe, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    rtFftsPlusSqe_t sqe;
    fftsPlusTaskInfo.fftsPlusSqe = &sqe;
    rtFftsPlusWriteValueCtx_t writeValueCtx;
    writeValueCtx.contextType = RT_CTX_TYPE_WRITE_VALUE_RDMA;
    fftsPlusTaskInfo.descBuf = &writeValueCtx;
    fftsPlusTaskInfo.descBufLen = sizeof(rtFftsPlusWriteValueCtx_t);
    fftsPlusTaskInfo.descAddrType = RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_HOST;
    int32_t deviceDescAlignBuf = 1;
    Context *curCtx = static_cast<Context *>(ctx);
    MOCKER_CPP_VIRTUAL(curCtx->device_, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&Stream::AddCaptureSqeNum).stubs().will(invoke(StubAddCaptureSqeNum));
    ret = SubmitRdmaPiValueModifyTask(static_cast<Stream *>(stream), &fftsPlusTaskInfo, &deviceDescAlignBuf);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = SubmitRdmaPiValueModifyTask(static_cast<Stream *>(stream), &fftsPlusTaskInfo, &deviceDescAlignBuf);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelExecute(model, streamExe, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER_CPP(&Model::DelStream).stubs().will(returnValue(RT_ERROR_NONE));
    ret = curCtx->ModelDelStream((Model *)model, (Stream *)streamExe);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    CaptureModel *captureMdl = RtPtrToPtr<CaptureModel *>(model);
    captureMdl->CaptureModelExecuteFinish();

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(streamExe);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocType(socType);
    GlobalMockObject::verify();
}