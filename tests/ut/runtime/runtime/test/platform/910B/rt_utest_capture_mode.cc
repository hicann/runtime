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
#include "capture_model.hpp"
#include "cond_handle/cond_handle.hpp"
#include "rt_unwrap.h"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "memory_task.h"
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
#include "stream_task.h"
#include "thread_local_container.hpp"
#include "runtime/rt_inner_model.h"
#include "capture_model_utils.hpp"
#include "stream_jetty_handler.h"
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
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

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
    ret = SubmitRdmaPiValueModifyTask(rt_ut::UnwrapOrNull<Stream>(stream), &fftsPlusTaskInfo, &deviceDescAlignBuf);
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
    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_INFO)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureModel->UpdateNotifyId(stm);
    captureModel->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    captureModel->BuildSqCq(stm);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_INFO)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_INFO_FAIL)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_INFO_NONE)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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

    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_ZERO)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, PRINT_DFX_DEBUG_INFO_COPY_FAIL)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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

    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelTest, RDMA_PI_VALUE_MODIFY_TASK_INIT_FAILED)
{
    rtStream_t stream;
    auto ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);
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
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);
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
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);
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
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);
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

    CaptureModel *captureMdl1 = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1));
    captureMdl1->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl1->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);
    captureMdl1->BuildSqCq(rt_ut::UnwrapOrNull<Stream>(streamExe));

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

    streamActiveTask->activeStream = rt_ut::UnwrapOrNull<Stream>(stream);
    task.stream = rt_ut::UnwrapOrNull<Stream>(stream);
    streamActiveTask->activeStreamSqId = 0;

    MOCKER(InitFuncCallParaForStreamActiveTask).stubs().will(returnValue(0));
    cmodel.MarkStreamActiveTask(&task);
    cmodel.context_ = rt_ut::UnwrapOrNull<Stream>(stream)->context_;
    cmodel.UpdateStreamActiveTaskFuncCallMem();

    MOCKER(ReConstructStreamActiveTaskFc).stubs().will(returnValue(1));
    cmodel.UpdateStreamActiveTaskFuncCallMem();

    rt_ut::UnwrapOrNull<Stream>(stream)->StarsCheckSqeFull(1);
    rt_ut::UnwrapOrNull<Stream>(stream)->StarsSqTailAdd();
    rt_ut::UnwrapOrNull<Stream>(stream)->StarsSqHeadSet(0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

class CloudV2CondHandleTest : public testing::Test {
protected:
    static void SetUpTestCase() {}
    static void TearDownTestCase() {}

    std::string socVersion_;

    virtual void SetUp()
    {
        rtSetDevice(0);
        socVersion_ = GlobalContainer::GetSocVersion();
        GlobalContainer::SetSocVersion("Ascend910B2");
        Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
            .stubs()
            .with(eq(TS_FEATURE_SOFTWARE_SQ_ENABLE))
            .will(returnValue(true));
        MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
            .stubs()
            .with(eq(TS_FEATURE_ACLGRAPH_COND_OP))
            .will(returnValue(true));
        MOCKER(CheckCaptureModelSupportSoftwareSq)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP(&Model::LoadCompleteByStreamPostp)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        GlobalContainer::SetSocVersion(socVersion_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(CloudV2CondHandleTest, CondHandleWhileE2E)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t subStream;
    ret = rtStreamCreate(&subStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    rtModel_t parentModel;
    ret = rtStreamGetCaptureInfo(stream, &status, &parentModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t condHandle = nullptr;
    ret = rtModelCondHandleCreate(parentModel, 0, static_cast<rtCondHandleFlag_t>(0), &condHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(condHandle, nullptr);

    uint64_t *condDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(condHandle, &condDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(condDevPtr, nullptr);

    rtModel_t subModels[1] = {};
    rtCondTaskParams params;
    params.handle = condHandle;
    params.type = RT_COND_TASK_TYPE_WHILE;
    params.size = 1;
    params.modelRIArray = subModels;
    ret = rtStreamAddCondTask(params, stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(subModels[0], nullptr);

    ret = rtStreamBeginCaptureToModel(subStream, subModels[0], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t subModelResult;
    ret = rtStreamEndCapture(subStream, &subModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t parentModelResult;
    ret = rtStreamEndCapture(stream, &parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t exeStream;
    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    void *memBase = (void *)0x1000;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::SqSwitchStreamBatch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(parentModelResult));
    captureMdl->isModelComplete_ = true;
    Notify *endGraphNotify = new Notify(0, 0);
    MOCKER_CPP(&Notify::Setup).stubs().with(eq(endGraphNotify)).will(returnValue(RT_ERROR_NONE));
    endGraphNotify->SetEndGraphModel(captureMdl);
    captureMdl->SetEndGraphNotify(endGraphNotify);

    ret = rtModelExecute(parentModelResult, exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    delete rawDrv;
    ret = rtModelDestroy(parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(subStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CondHandleTest, CondHandleWhileWithAssignDefault)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t subStream;
    ret = rtStreamCreate(&subStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    rtModel_t parentModel;
    ret = rtStreamGetCaptureInfo(stream, &status, &parentModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t condHandle = nullptr;
    ret = rtModelCondHandleCreate(parentModel, 1, RT_COND_HANDLE_ASSIGN_DEFAULT, &condHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint64_t *condDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(condHandle, &condDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t subModels[1] = {};
    rtCondTaskParams params;
    params.handle = condHandle;
    params.type = RT_COND_TASK_TYPE_WHILE;
    params.size = 1;
    params.modelRIArray = subModels;
    ret = rtStreamAddCondTask(params, stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(subStream, subModels[0], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t subModelResult;
    ret = rtStreamEndCapture(subStream, &subModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t parentModelResult;
    ret = rtStreamEndCapture(stream, &parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t exeStream;
    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    void *memBase = (void *)0x1000;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::SqSwitchStreamBatch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(parentModelResult));
    captureMdl->isModelComplete_ = true;
    Notify *endGraphNotify = new Notify(0, 0);
    MOCKER_CPP(&Notify::Setup).stubs().with(eq(endGraphNotify)).will(returnValue(RT_ERROR_NONE));
    endGraphNotify->SetEndGraphModel(captureMdl);
    captureMdl->SetEndGraphNotify(endGraphNotify);

    ret = rtModelExecute(parentModelResult, exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    delete rawDrv;
    ret = rtModelDestroy(parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(subStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CondHandleTest, CondHandleIfE2E)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t subStream1;
    ret = rtStreamCreate(&subStream1, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t subStream2;
    ret = rtStreamCreate(&subStream2, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    rtModel_t parentModel;
    ret = rtStreamGetCaptureInfo(stream, &status, &parentModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t condHandle = nullptr;
    ret = rtModelCondHandleCreate(parentModel, 0, static_cast<rtCondHandleFlag_t>(0), &condHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint64_t *condDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(condHandle, &condDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t subModels[2] = {};
    rtCondTaskParams params;
    params.handle = condHandle;
    params.type = RT_COND_TASK_TYPE_IF;
    params.size = 2;
    params.modelRIArray = subModels;
    ret = rtStreamAddCondTask(params, stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(subStream1, subModels[0], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtModel_t subModelResult1;
    ret = rtStreamEndCapture(subStream1, &subModelResult1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(subStream2, subModels[1], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtModel_t subModelResult2;
    ret = rtStreamEndCapture(subStream2, &subModelResult2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t parentModelResult;
    ret = rtStreamEndCapture(stream, &parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t exeStream;
    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    void *memBase = (void *)0x1000;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::SqSwitchStreamBatch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(parentModelResult));
    captureMdl->isModelComplete_ = true;
    Notify *endGraphNotify = new Notify(0, 0);
    MOCKER_CPP(&Notify::Setup).stubs().with(eq(endGraphNotify)).will(returnValue(RT_ERROR_NONE));
    endGraphNotify->SetEndGraphModel(captureMdl);
    captureMdl->SetEndGraphNotify(endGraphNotify);

    ret = rtModelExecute(parentModelResult, exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    delete rawDrv;
    ret = rtModelDestroy(parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(subStream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(subStream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CondHandleTest, CondHandleIfSizeOneE2E)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t subStream1;
    ret = rtStreamCreate(&subStream1, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    rtModel_t parentModel;
    ret = rtStreamGetCaptureInfo(stream, &status, &parentModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t condHandle = nullptr;
    ret = rtModelCondHandleCreate(parentModel, 0, static_cast<rtCondHandleFlag_t>(0), &condHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint64_t *condDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(condHandle, &condDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t subModels[1] = {};
    rtCondTaskParams params;
    params.handle = condHandle;
    params.type = RT_COND_TASK_TYPE_IF;
    params.size = 1;
    params.modelRIArray = subModels;
    ret = rtStreamAddCondTask(params, stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(subStream1, subModels[0], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtModel_t subModelResult1;
    ret = rtStreamEndCapture(subStream1, &subModelResult1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t parentModelResult;
    ret = rtStreamEndCapture(stream, &parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t exeStream;
    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    void *memBase = (void *)0x1000;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::SqSwitchStreamBatch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(parentModelResult));
    captureMdl->isModelComplete_ = true;
    Notify *endGraphNotify = new Notify(0, 0);
    MOCKER_CPP(&Notify::Setup).stubs().with(eq(endGraphNotify)).will(returnValue(RT_ERROR_NONE));
    endGraphNotify->SetEndGraphModel(captureMdl);
    captureMdl->SetEndGraphNotify(endGraphNotify);

    ret = rtModelExecute(parentModelResult, exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    delete rawDrv;
    ret = rtModelDestroy(parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(subStream1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CondHandleTest, CondHandleSwitchE2E)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    const uint32_t switchSize = 3;
    rtStream_t subStreams[switchSize];
    for (uint32_t i = 0; i < switchSize; i++) {
        ret = rtStreamCreate(&subStreams[i], 0);
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    rtModel_t parentModel;
    ret = rtStreamGetCaptureInfo(stream, &status, &parentModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t condHandle = nullptr;
    ret = rtModelCondHandleCreate(parentModel, 0, static_cast<rtCondHandleFlag_t>(0), &condHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint64_t *condDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(condHandle, &condDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t subModels[switchSize] = {};
    rtCondTaskParams params;
    params.handle = condHandle;
    params.type = RT_COND_TASK_TYPE_SWITCH;
    params.size = switchSize;
    params.modelRIArray = subModels;
    ret = rtStreamAddCondTask(params, stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    for (uint32_t i = 0; i < switchSize; i++) {
        ret = rtStreamBeginCaptureToModel(subStreams[i], subModels[i], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        rtModel_t subModelResult;
        ret = rtStreamEndCapture(subStreams[i], &subModelResult);
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }

    rtModel_t parentModelResult;
    ret = rtStreamEndCapture(stream, &parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t exeStream;
    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    void *memBase = (void *)0x1000;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::SqSwitchStreamBatch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(parentModelResult));
    captureMdl->isModelComplete_ = true;
    Notify *endGraphNotify = new Notify(0, 0);
    MOCKER_CPP(&Notify::Setup).stubs().with(eq(endGraphNotify)).will(returnValue(RT_ERROR_NONE));
    endGraphNotify->SetEndGraphModel(captureMdl);
    captureMdl->SetEndGraphNotify(endGraphNotify);

    ret = rtModelExecute(parentModelResult, exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    delete rawDrv;
    ret = rtModelDestroy(parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    for (uint32_t i = 0; i < switchSize; i++) {
        ret = rtStreamDestroy(subStreams[i]);
        EXPECT_EQ(ret, RT_ERROR_NONE);
    }
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CondHandleTest, CondHandleIfNestedIfE2E)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t parentStream;
    ret = rtStreamCreate(&parentStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t ifTrueSubStream;
    ret = rtStreamCreate(&ifTrueSubStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t ifFalseSubStream;
    ret = rtStreamCreate(&ifFalseSubStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t innerIfSubStream;
    ret = rtStreamCreate(&innerIfSubStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(parentStream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus status;
    rtModel_t parentModel;
    ret = rtStreamGetCaptureInfo(parentStream, &status, &parentModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t outerCondHandle = nullptr;
    ret = rtModelCondHandleCreate(parentModel, 0, static_cast<rtCondHandleFlag_t>(0), &outerCondHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint64_t *outerCondDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(outerCondHandle, &outerCondDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t outerSubModels[2] = {};
    rtCondTaskParams outerParams;
    outerParams.handle = outerCondHandle;
    outerParams.type = RT_COND_TASK_TYPE_IF;
    outerParams.size = 2;
    outerParams.modelRIArray = outerSubModels;
    ret = rtStreamAddCondTask(outerParams, parentStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(ifTrueSubStream, outerSubModels[0], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStreamCaptureStatus innerStatus;
    rtModel_t ifTrueModel;
    ret = rtStreamGetCaptureInfo(ifTrueSubStream, &innerStatus, &ifTrueModel);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtCondHandle_t innerCondHandle = nullptr;
    ret = rtModelCondHandleCreate(ifTrueModel, 0, static_cast<rtCondHandleFlag_t>(0), &innerCondHandle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint64_t *innerCondDevPtr = nullptr;
    ret = rtModelCondHandleGetCondPtr(innerCondHandle, &innerCondDevPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t innerSubModels[1] = {};
    rtCondTaskParams innerParams;
    innerParams.handle = innerCondHandle;
    innerParams.type = RT_COND_TASK_TYPE_IF;
    innerParams.size = 1;
    innerParams.modelRIArray = innerSubModels;
    ret = rtStreamAddCondTask(innerParams, ifTrueSubStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(innerIfSubStream, innerSubModels[0], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtModel_t innerSubModelResult;
    ret = rtStreamEndCapture(innerIfSubStream, &innerSubModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t ifTrueModelResult;
    ret = rtStreamEndCapture(ifTrueSubStream, &ifTrueModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCaptureToModel(ifFalseSubStream, outerSubModels[1], RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtModel_t ifFalseModelResult;
    ret = rtStreamEndCapture(ifFalseSubStream, &ifFalseModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t parentModelResult;
    ret = rtStreamEndCapture(parentStream, &parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t exeStream;
    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver *rawDrv = new NpuDriver();
    void *memBase = (void *)0x1000;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::SqSwitchStreamBatch)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(parentModelResult));
    captureMdl->isModelComplete_ = true;

    Stream *origCaptureStream = rt_ut::UnwrapOrNull<Stream>(parentStream);
    Notify *endGraphNotify = new Notify(0, 0);
    MOCKER_CPP(&Notify::Setup).stubs().with(eq(endGraphNotify)).will(returnValue(RT_ERROR_NONE));
    endGraphNotify->SetEndGraphModel(captureMdl);
    captureMdl->SetEndGraphNotify(endGraphNotify);

    ret = rtModelExecute(parentModelResult, exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);
    uint32_t releaseSqNum = 0U;
    uint32_t releaseNtyNum = 0;
    captureMdl->ReleaseSqCqAndNotifyId(releaseSqNum, releaseNtyNum);

    delete rawDrv;
    ret = rtModelDestroy(parentModelResult);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(parentStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(ifTrueSubStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(ifFalseSubStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(innerIfSubStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
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

    error = (RtPtrToPtr<Context *>(ctx))->TryRecycleCaptureModelResource(1, 1,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model3)));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = (RtPtrToPtr<Context *>(ctx))->TryRecycleCaptureModelJettyResource(
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model3)),
        JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);

    CaptureModel *captureMdl1 = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1));
    captureMdl1->CaptureModelExecuteFinish(RT_ERROR_NONE);

    CaptureModel *captureMdl2 = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model2));
    captureMdl2->CaptureModelExecuteFinish(RT_ERROR_NONE);

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

    rt_ut::UnwrapOrNull<Stream>(streamExe)->taskPosTail_.Set(5000);
    uint32_t streamId = (rt_ut::UnwrapOrNull<Stream>(streamExe))->Id_();
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 10);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 100);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model2)), 2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model2)), 20);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model3)), 3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model3)), 30);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDevice->DeleteEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model3)), 3, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->DeleteEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model3)), 30, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDevice->ClearEndGraphNotifyInfoByModel(rt_ut::UnwrapOrNull<Model>(model2));
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint16_t head_stub = 15;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(head_stub))
        .will(returnValue(RT_ERROR_NONE));
    rt_ut::UnwrapOrNull<Stream>(streamExe)->taskPosTail_.Set(15);
    rawDevice->PollEndGraphNotifyInfo();

    rt_ut::UnwrapOrNull<Stream>(streamExe)->taskPosTail_.Set(5);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 10);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 100);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t modelId;
    error = rtModelGetId(model1, &modelId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rawDevice->PollEndGraphNotifyInfoByModelId(1000);
    rawDevice->PollEndGraphNotifyInfoByModelId(modelId);
    rawDevice->PollEndGraphNotifyInfo();

    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 120);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rawDevice->StoreEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 49);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rt_ut::UnwrapOrNull<Stream>(streamExe)->taskPosTail_.Set(50);
    rawDevice->PollEndGraphNotifyInfo();

    error = rawDevice->DeleteEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 49, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rawDevice->DeleteEndGraphNotifyInfo(streamId,
        static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model1)), 49, 0);
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
    std::string socVersion = GlobalContainer::GetSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");

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
    ret = SubmitRdmaPiValueModifyTask(rt_ut::UnwrapOrNull<Stream>(stream), &fftsPlusTaskInfo, &deviceDescAlignBuf);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = SubmitRdmaPiValueModifyTask(rt_ut::UnwrapOrNull<Stream>(stream), &fftsPlusTaskInfo, &deviceDescAlignBuf);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelExecute(model, streamExe, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER_CPP(&Model::DelStream).stubs().will(returnValue(RT_ERROR_NONE));
    ret = curCtx->ModelDelStream(rt_ut::UnwrapOrNull<Model>(model), rt_ut::UnwrapOrNull<Stream>(streamExe));
    EXPECT_EQ(ret, RT_ERROR_NONE);

    CaptureModel *captureMdl = static_cast<CaptureModel *>(rt_ut::UnwrapOrNull<Model>(model));
    captureMdl->CaptureModelExecuteFinish(RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(streamExe);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetSocVersion(socVersion);
    GlobalMockObject::verify();
}

rtStream_t *createModelAndGetStreams(rtModel_t *model, rtStream_t *stream)
{
    rtError_t error;
    rtStreamCaptureStatus status;

    rtContext_t current = NULL;
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(static_cast<Context *>(current));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(*stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(*stream, &status, model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);

    // get model streams before end capture
    uint32_t numStreams = 0;
    error = rtModelGetStreams(*model, nullptr, &numStreams);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 1);

    rtStream_t addStream;
    error = rtStreamCreate(&addStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamAddToModel(addStream, *model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(*stream, model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // get model streams after end capture
    error = rtModelGetStreams(*model, nullptr, &numStreams);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t *inputStreams = (rtStream_t *)malloc(sizeof(rtStream_t) * numStreams);
    error = rtModelGetStreams(*model, inputStreams, &numStreams);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 2);

    return inputStreams;
}

TEST_F(CloudV2CaptureModelTest, model_get_streams_abnormal)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t *inputStreams = createModelAndGetStreams(&model, &stream);

    uint32_t numStreams = 0;
    error = rtModelGetStreams(nullptr, inputStreams, &numStreams);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelGetStreams(model, inputStreams, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(inputStreams);
}

TEST_F(CloudV2CaptureModelTest, model_get_streams_normal)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t *inputStreams = createModelAndGetStreams(&model, &stream);

    // input numStreams = actual stream num
    uint32_t numStreams = 2;
    error = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 2);

    // input numStreams < actual stream num
    uint32_t numStreamsLess = 1;
    rtStream_t *inputStreamsLess = (rtStream_t *)malloc(sizeof(rtStream_t) * numStreamsLess);
    error = rtModelGetStreams(model, inputStreamsLess, &numStreamsLess);
    EXPECT_EQ(error, ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY);
    EXPECT_EQ(numStreamsLess, 1);

    // input numStreams > actual stream num
    uint32_t numStreamsLarger = 5;
    rtStream_t *inputLargerStreams = (rtStream_t *)malloc(sizeof(rtStream_t) * numStreamsLarger);
    error = rtModelGetStreams(model, inputLargerStreams, &numStreamsLarger);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numStreamsLarger, 2);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(inputStreams);
    free(inputStreamsLess);
    free(inputLargerStreams);
}

TEST_F(CloudV2CaptureModelTest, stream_get_tasks_abnormal)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // The stream is not bound to a model.
    uint32_t numTasks = 0;
    error = rtStreamGetTasks(stream, nullptr, &numTasks);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtStream_t *inputStreams = createModelAndGetStreams(&model, &stream);

    rtTask_t *tasks = (rtTask_t *)malloc(sizeof(rtTask_t));
    error = rtStreamGetTasks(nullptr, tasks, &numTasks);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamGetTasks(inputStreams[1], tasks, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(inputStreams);
    free(tasks);
}

TEST_F(CloudV2CaptureModelTest, stream_get_tasks_normal)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t *inputStreams = createModelAndGetStreams(&model, &stream);

    uint32_t numTasks = 0;
    error = rtStreamGetTasks(inputStreams[1], nullptr, &numTasks);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numTasks, 1);

    // input numTasks = actual task num
    rtTask_t *tasks = (rtTask_t *)malloc(sizeof(rtTask_t) * numTasks);
    error = rtStreamGetTasks(inputStreams[1], tasks, &numTasks);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numTasks, 1);
    
    // input numTasks < actual task num
    uint32_t numTasksLess = 0;
    rtTask_t *inputTasksLess = (rtTask_t *)malloc(sizeof(rtTask_t) * numTasksLess);
    error = rtStreamGetTasks(inputStreams[1], inputTasksLess, &numTasksLess);
    EXPECT_EQ(error, ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY);
    EXPECT_EQ(numTasksLess, 0);

    // input numTasks > actual task num
    uint32_t numTasksLarger = 5;
    rtTask_t *inputTasksLarger = (rtTask_t *)malloc(sizeof(rtTask_t) * numTasksLarger);
    error = rtStreamGetTasks(inputStreams[1], inputTasksLarger, &numTasksLarger);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(numTasksLarger, 1);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(inputStreams);
    free(tasks);
    free(inputTasksLess);
    free(inputTasksLarger);
}

TaskInfo *createTaskInfo()
{
    rtError_t error;
    rtContext_t current = NULL;
    rtStream_t stream;

    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(static_cast<Context *>(current));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo *taskInfo = (TaskInfo *)malloc(sizeof(TaskInfo));
    taskInfo->id = 0;
    taskInfo->stream = rt_ut::UnwrapOrNull<Stream>(stream);
    taskInfo->taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);

    return taskInfo;
}

TEST_F(CloudV2CaptureModelTest, task_get_type_abnormal)
{
    rtError_t error;
    rtTaskType *type = (rtTaskType *)malloc(sizeof(rtTaskType));

    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo->typeName = "KERNEL_AICORE";

    rtTask_t task = (rtTask_t)taskInfo;

    error = rtTaskGetType(nullptr, type);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtTaskGetType(task, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(type);
    free(taskInfo);
}

TEST_F(CloudV2CaptureModelTest, task_get_type_normal_01)
{
    rtError_t error;
    rtTaskType *type = (rtTaskType *)malloc(sizeof(rtTaskType));
    
    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo->typeName = "KERNEL_AICORE";

    rtTask_t task = (rtTask_t)taskInfo;
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_KERNEL);

    taskInfo->type = TS_TASK_TYPE_KERNEL_AIVEC;
    taskInfo->typeName = "KERNEL_AIVEC";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_KERNEL);

    taskInfo->type = TS_TASK_TYPE_CAPTURE_WAIT;
    taskInfo->typeName = "CAPTURE_WAIT";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_EVENT_WAIT);

    taskInfo->type = TS_TASK_TYPE_STREAM_WAIT_EVENT;
    taskInfo->typeName = "EVENT_WAIT";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_EVENT_WAIT);

    taskInfo->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    taskInfo->typeName = "MEM_WAIT_VALUE";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_VALUE_WAIT);

    free(type);
    free(taskInfo);
}

TEST_F(CloudV2CaptureModelTest, task_get_type_normal_02)
{
    rtError_t error;
    rtTaskType *type = (rtTaskType *)malloc(sizeof(rtTaskType));
    
    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->type = TS_TASK_TYPE_EVENT_RECORD;
    taskInfo->typeName = "EVENT_RECORD";

    rtTask_t task = (rtTask_t)taskInfo;
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_EVENT_RECORD);

    taskInfo->type = TS_TASK_TYPE_CAPTURE_RECORD;
    taskInfo->typeName = "CAPTURE_RECORD";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_EVENT_RECORD);

    taskInfo->type = TS_TASK_TYPE_EVENT_RESET;
    taskInfo->typeName = "EVENT_RESET";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_EVENT_RESET);

    taskInfo->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    taskInfo->typeName = "EVENT_RESET";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_EVENT_RESET);

    taskInfo->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    taskInfo->typeName = "MEM_WRITE_VALUE";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_VALUE_WRITE);

    taskInfo->type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo->typeName = "KERNEL_AICPU";
    error = rtTaskGetType(task, type);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(*type, RT_TASK_DEFAULT);

    free(type);
    free(taskInfo);
}

TEST_F(CloudV2CaptureModelTest, task_get_seq_id)
{
    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->modelSeqId = 2;

    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
    taskInfo->stream = stm;

    Model model(RT_MODEL_CAPTURE_MODEL);
    stm->SetModel(&model);

    uint32_t id = 0;
    auto error = rtTaskGetSeqId(nullptr, &id);
    EXPECT_EQ(error,  ACL_ERROR_RT_PARAM_INVALID);

    rtTask_t task = (rtTask_t)taskInfo;
    error = rtTaskGetSeqId(task, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtTaskGetSeqId(task, &id);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(id, 2);

    free(taskInfo);
    stm->DelModel(&model);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, RecordSoftwareEvent_Success)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t captureStream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);

    error = rtStreamCreate(&captureStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *capStm = rt_ut::UnwrapOrNull<Stream>(captureStream);

    rtEvent_t event;
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Event *evt = rt_ut::UnwrapOrNull<Event>(event);

    evt->SetCaptureStream(capStm);

    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    MOCKER_CPP(&Stream::AllocTask)
        .stubs()
        .will(returnValue(&taskInfo));
    MOCKER_CPP_VIRTUAL(stm->Device_(), &Device::AllocExpandingPoolEvent)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm->Device_(), &Device::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFactory::Recycle)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = evt->RecordSoftwareEvent(stm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(captureStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, RecordSoftwareEvent_AllocEventFail)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t captureStream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);

    error = rtStreamCreate(&captureStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *capStm = rt_ut::UnwrapOrNull<Stream>(captureStream);

    rtEvent_t event;
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Event *evt = rt_ut::UnwrapOrNull<Event>(event);

    evt->SetCaptureStream(capStm);

    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    MOCKER_CPP(&Stream::AllocTask)
        .stubs()
        .will(returnValue(&taskInfo));
    MOCKER_CPP_VIRTUAL(stm->Device_(), &Device::AllocExpandingPoolEvent)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP(&TaskFactory::Recycle)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = evt->RecordSoftwareEvent(stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(captureStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, RecordSoftwareEvent_SubmitTaskFail)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t captureStream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);

    error = rtStreamCreate(&captureStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *capStm = rt_ut::UnwrapOrNull<Stream>(captureStream);

    rtEvent_t event;
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Event *evt = rt_ut::UnwrapOrNull<Event>(event);

    evt->SetCaptureStream(capStm);

    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    MOCKER_CPP(&Stream::AllocTask)
        .stubs()
        .will(returnValue(&taskInfo));
    MOCKER_CPP_VIRTUAL(stm->Device_(), &Device::AllocExpandingPoolEvent)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm->Device_(), &Device::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_STREAM_FULL));
    MOCKER_CPP(&TaskFactory::Recycle)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = evt->RecordSoftwareEvent(stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(captureStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, GetCaptureRecordTaskParams_Success)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Event *evt = rt_ut::UnwrapOrNull<Event>(event);

    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->type = TS_TASK_TYPE_CAPTURE_RECORD;
    taskInfo->typeName = "CAPTURE_RECORD";
    taskInfo->u.memWriteValueTask.event = evt;

    rtTaskParams params = {};
    error = GetCaptureRecordTaskParams(taskInfo, &params);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RECORD);
    EXPECT_EQ(params.eventRecordTaskParams.recordFlag, RT_EVENT_RECORD_DEFAULT);

    free(taskInfo);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, GetCaptureWaitTaskParams_Success)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Event *evt = rt_ut::UnwrapOrNull<Event>(event);

    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->type = TS_TASK_TYPE_CAPTURE_WAIT;
    taskInfo->typeName = "CAPTURE_WAIT";
    taskInfo->u.memWaitValueTask.event = evt;

    rtTaskParams params = {};
    error = GetCaptureWaitTaskParams(taskInfo, &params);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_WAIT);
    EXPECT_EQ(params.eventWaitTaskParams.waitFlag, RT_EVENT_WAIT_DEFAULT);

    free(taskInfo);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelTest, GetCaptureResetTaskParams_Success)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Event *evt = rt_ut::UnwrapOrNull<Event>(event);

    TaskInfo *taskInfo = createTaskInfo();
    taskInfo->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    taskInfo->typeName = "MEM_WRITE_VALUE";
    taskInfo->u.memWriteValueTask.event = evt;

    rtTaskParams params = {};
    error = GetCaptureResetTaskParams(taskInfo, &params);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RESET);
    EXPECT_EQ(params.eventResetTaskParams.resetFlag, RT_EVENT_WAIT_DEFAULT);

    free(taskInfo);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
