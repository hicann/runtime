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
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2SetDeviceFailureModeTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_continue)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    uint64_t failureMode = CONTINUE_ON_FAILURE;
    auto ret = rtSetDeviceFailureMode(failureMode);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_stop)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    uint64_t failureMode = STOP_ON_FAILURE;
    auto ret = rtSetDeviceFailureMode(failureMode);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_different)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    auto ret = rtSetDeviceFailureMode(STOP_ON_FAILURE);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtSetDeviceFailureMode(CONTINUE_ON_FAILURE);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_ts_version_failed)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_CTRL_SQ);
    auto ret = rtSetDeviceFailureMode(STOP_ON_FAILURE);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_create_stream)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    uint64_t failureMode = STOP_ON_FAILURE;
    auto ret = rtSetDeviceFailureMode(failureMode);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtStream_t newStream;
    ret = rtStreamCreate(&newStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stream = static_cast<Stream *>(newStream);
    EXPECT_EQ(stream->GetFailureMode(), failureMode);
    ret = rtStreamDestroy(newStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, res_clear)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    rtStream_t newStream;
    auto ret = rtStreamCreate(&newStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stream = static_cast<Stream *>(newStream);
    stream->isSupportASyncRecycle_ = true;
    ret = stream->ResClear();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(newStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, res_clear_timeout)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    rtStream_t newStream;
    auto ret = rtStreamCreate(&newStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stream = static_cast<Stream *>(newStream);
    stream->isSupportASyncRecycle_ = true;
    stream->pendingNum_.Set(1);

    MOCKER_CPP_VIRTUAL(device, &Device::TaskReclaim)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    ret = stream->ResClear(1);
    EXPECT_EQ(ret, RT_ERROR_WAIT_TIMEOUT);
    stream->pendingNum_.Set(0);
    ret = rtStreamDestroy(newStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_create_stream_mc2)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_MC2_ENHANCE);
    uint64_t failureMode = STOP_ON_FAILURE;
    auto ret = rtSetDeviceFailureMode(failureMode);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtStream_t newStream;
    ret = rtStreamCreateWithFlags(&newStream, 0, RT_STREAM_CP_PROCESS_USE);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2SetDeviceFailureModeTest, set_mode_create_stream_failed)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_MC2_ENHANCE);
    uint64_t failureMode = STOP_ON_FAILURE;
    auto ret = rtSetDeviceFailureMode(failureMode);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtStream_t newStream;

    MOCKER_CPP(&Stream::SetFailMode)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(RT_ERROR_DRV_ERR));

    ret = rtStreamCreateWithFlags(&newStream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(ret, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    rtInstance->DeviceRelease(device);
}

class CloudV2DoCompleteSuccessForNotifyWaitTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();

        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        char *socVer = "Ascend910B1";
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910B1")), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver,
            &Driver::GetSqEnable).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::SetSqHead)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        if (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Set(0U);
        }
        if (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Engine *engine_ = nullptr;
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    rtStream_t streamHandle_ = 0;
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2DoCompleteSuccessForNotifyWaitTaskTest, dfx_case)
{
    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_WAIT_TIMEOUT;
    taskInfo.bindFlag = true;
    Notify notify(0, 1);
    Model *model = new Model();
    notify.SetEndGraphModel(model);
    taskInfo.u.notifywaitTask.u.notify = &notify;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);
    EXPECT_EQ(notify.GetEndGraphModel(), model);
    delete model;
}

extern int32_t faultEventFlag;
TEST_F(CloudV2DoCompleteSuccessForNotifyWaitTaskTest, TestNotifyError)
{
    faultEventFlag = 1;
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.errorCode = TS_ERROR_SDMA_POISON_ERROR;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);
    faultEventFlag = 0;

    taskInfo.errorCode = AICPU_HCCL_OP_RETRY_FAILED;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);
    EXPECT_EQ(taskInfo.errorCode, TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED);
}

class CloudV2ReportErrorInfoForModelExecuteTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2ReportErrorInfoForModelExecuteTaskTest, dfx_case)
{
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskInfo taskInfo = {};
    Model *model = new Model();
    ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo.u.modelExecuteTaskInfo);
    modelExecuteTaskInfo->model = model;
    EXPECT_EQ(model, modelExecuteTaskInfo->model);

    modelExecuteTaskInfo->model->SetFunCallMemSize(sizeof(RtStarsModelExeFuncCall) + sizeof(uint64_t) + sizeof(uint64_t));
    Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver_, &Driver::MemCopySync)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    InitByStream(&taskInfo, (Stream *)stream);
    ((RawDevice *)(((Stream *)stream)->device_))->driver_ = driver_;
    uint8_t* funcCallSvmMem = new uint8_t[modelExecuteTaskInfo->model->GetFunCallMemSize()];
    modelExecuteTaskInfo->model->SetFuncCallSvmMem(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(funcCallSvmMem)));
    PrintErrorModelExecuteTaskFuncCall(&taskInfo);
    delete []funcCallSvmMem;
    delete model;
    rtStreamDestroy(stream);
}

TEST_F(CloudV2ReportErrorInfoForModelExecuteTaskTest, ffts_plus)
{

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_WAIT_TIMEOUT;
    taskInfo.type = TS_TASK_TYPE_FFTS_PLUS;
    taskInfo.bindFlag = true;
    taskInfo.stream = static_cast<Stream*>(stream);

    MOCKER(PrintErrorInfo).stubs();
    MOCKER(DoCompleteSuccForFftsPlusTask).stubs();
    MOCKER(GetRealReportFaultTaskForModelExecuteTask).stubs().with(outBoundP(&taskInfo)).will(returnValue(&taskInfo));
    ReportErrorInfoForModelExecuteTask(&taskInfo, 0);
    EXPECT_EQ(taskInfo.errorCode, RT_ERROR_WAIT_TIMEOUT);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2ReportErrorInfoForModelExecuteTaskTest, ffts_plus_1)
{

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_WAIT_TIMEOUT;
    taskInfo.bindFlag = true;
    
    Notify notify(0, 1);
    Model *model = new Model();
    notify.SetEndGraphModel(model);
    taskInfo.u.notifywaitTask.u.notify = &notify;
    taskInfo.stream = static_cast<Stream*>(stream);
    MOCKER_CPP(&Context::ModelIsExistInContext).stubs().will(returnValue(true));
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);
    EXPECT_EQ(notify.GetEndGraphModel(), model);
    delete model;

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ReportErrorInfoForModelExecuteTaskTest, model_exe_result_for_software_sq)
{
    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    RawDevice *dev = new RawDevice(1);
    dev->Init();

    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    Stream *stream = new Stream(dev, 0);
    stream->SetContext(static_cast<Context *>(ctx));

    TaskInfo taskInfo = {};
    taskInfo.bindFlag = true;

    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    
    Notify notify(0, 1);
    Model *model = new Model();
    notify.SetEndGraphModel(model);
    taskInfo.u.notifywaitTask.u.notify = &notify;
    taskInfo.stream = static_cast<Stream*>(stream);
    MOCKER_CPP(&Context::ModelIsExistInContext).stubs().will(returnValue(true));

    rtStarsCqeSwStatus_t swStatus = {};
    swStatus.model_exec_ex.result = TS_STARS_MODEL_STREAM_EXE_FAILED;
    taskInfo.errorCode = swStatus.value;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    swStatus.model_exec_ex.result = TS_STARS_MODEL_END_OF_SEQ;
    taskInfo.errorCode = swStatus.value;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    swStatus.model_exec_ex.result = TS_STARS_MODEL_AICPU_TIMEOUT;
    taskInfo.errorCode = swStatus.value;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    swStatus.model_exec_ex.result = TS_STARS_MODEL_EXE_ABORT;
    swStatus.model_exec_ex.sq_id = stream->GetSqId();
    taskInfo.errorCode = swStatus.value;
    model->ModelPushFrontStream(stream);
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);
    model->ModelRemoveStream(stream);

    swStatus.model_exec_ex.result = RT_ERROR_WAIT_TIMEOUT;
    taskInfo.errorCode = swStatus.value;
    DoCompleteSuccessForNotifyWaitTask(&taskInfo, 0);

    EXPECT_EQ(notify.GetEndGraphModel(), model);
    delete model;

    GlobalMockObject::verify();

    delete stream;
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2ReportErrorInfoForModelExecuteTaskTest, socket_close)
{

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo taskInfo = {};
    taskInfo.errorCode = RT_ERROR_WAIT_TIMEOUT;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = true;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.drvErr = RT_ERROR_SOCKET_CLOSE;

    MOCKER(PrintErrorInfo).stubs();
    MOCKER(DoCompleteSuccForFftsPlusTask).stubs();
    MOCKER(GetRealReportFaultTaskForModelExecuteTask).stubs().with(outBoundP(&taskInfo)).will(returnValue(&taskInfo));
    ReportErrorInfoForModelExecuteTask(&taskInfo, 0);
    EXPECT_EQ((static_cast<Stream*>(stream)->GetDrvErr()), RT_ERROR_SOCKET_CLOSE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

class CloudV2CaptureModelProfilerTest : public testing::Test
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
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2CaptureModelProfilerTest, TASK_TYPE_MIX_AIC)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    bool tmp = rt->isHaveDevice_;
    rt->isHaveDevice_ = true;
    Profiler* profiler = rt->profiler_;
    profiler->streamSet_.clear();
    profiler->SetTrackProfEnable(true);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;

    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    taskInfo.u.aicTaskInfo.kernel = &kernel;
    kernel.SetMixType(MIX_AIC);

    // task track
    profiler->ReportTaskTrack(&taskInfo, 1);
    RuntimeProfTrackData trackData = profiler->GetProfTaskTrackData().trackBuff[0];
    EXPECT_EQ(trackData.compactInfo.data.runtimeTrack.taskType, TS_TASK_TYPE_KERNEL_MIX_AIC);
    rt->isHaveDevice_ = tmp;
}

TEST_F(CloudV2CaptureModelProfilerTest, TASK_TYPE_MIX_AIV)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    bool tmp = rt->isHaveDevice_;
    rt->isHaveDevice_ = true;
    Profiler* profiler = rt->profiler_;
    profiler->streamSet_.clear();
    profiler->SetTrackProfEnable(true);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;

    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    taskInfo.u.aicTaskInfo.kernel = &kernel;
    kernel.SetMixType(MIX_AIV);

    // task track
    profiler->ReportTaskTrack(&taskInfo, 1);
    RuntimeProfTrackData trackData = profiler->GetProfTaskTrackData().trackBuff[0];
    EXPECT_EQ(trackData.compactInfo.data.runtimeTrack.taskType, TS_TASK_TYPE_KERNEL_MIX_AIV);
    rt->isHaveDevice_ = tmp;
}

TEST_F(CloudV2CaptureModelProfilerTest, STREAM_INFO)
{
    CaptureModel* captureModel = new CaptureModel();
    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->InsertSingleOperStmIdAndCaptureStmId(0, 1);
    captureModel->context_ = static_cast<Context *>(ctx);
    captureModel->ReportedStreamInfoForProfiling();
    delete captureModel;
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelProfilerTest, STREAM_INFO_ERROR)
{
    CaptureModel* captureModel = new CaptureModel();
    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->context_ = static_cast<Context*>(ctx);
    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(-1));
    captureModel->InsertSingleOperStmIdAndCaptureStmId(0, 1);
    captureModel->ReportedStreamInfoForProfiling();
    delete captureModel;
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelProfilerTest, ERASE_STREAM_INFO)
{
    CaptureModel* captureModel = new CaptureModel();
    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->context_ = static_cast<Context*>(ctx);
    captureModel->EraseStreamInfoForProfiling();
    delete captureModel;
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelProfilerTest, ERASE_STREAM_INFO_ERROR)
{
    CaptureModel* captureModel = new CaptureModel();
    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->context_ = static_cast<Context*>(ctx);
    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(-1));
    captureModel->EraseStreamInfoForProfiling();
    delete captureModel;
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelProfilerTest, REPORT_STREAM_INFO)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    bool tmp = rt->isHaveDevice_;
    rt->isHaveDevice_ = true;
    Profiler* profiler = rt->profiler_;
    profiler->streamSet_.clear();
    profiler->SetTrackProfEnable(true);
    CaptureModel* captureModel = new CaptureModel();
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context* curCtx = static_cast<Context*>(ctx);
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.push_back(static_cast<Stream*>(stream));
    profiler->InsertStream(static_cast<Stream*>(stream));
    // task track
    profiler->ReportCacheTrack(0);
    rt->isHaveDevice_ = tmp;
    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    profiler->streamSet_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}
