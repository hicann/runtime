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
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "stars.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream_david.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include "thread_local_container.hpp"
#include "task_david.hpp"
#include "task_res_da.hpp"
#include "stream_david.hpp"
#include "stream_c.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiTestUb : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "UbApiTest SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        std::cout << "UbApiTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        std::cout << "UbApiTest end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);

        (void)rtSetSocVersion("Ascend910_9599");

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_910_9599);
        engine_ = ((RawDevice *)device_)->engine_;

        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
        stream_->SetSqMemAttr(false);
        davidSqe_ = static_cast<rtDavidSqe_t *>(malloc(sizeof(rtDavidSqe_t)));
        oldSqAddr_ = stream_->GetSqBaseAddr();
        uint64_t sqeAddr = reinterpret_cast<uint64_t>(davidSqe_);
        stream_->SetSqBaseAddr(sqeAddr);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));

        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));

        grp_ = new DvppGrp(device_, 0);
        rtDvppGrp_t grp_t = (rtDvppGrp_t *)grp_;
        rtError_t ret = rtStreamCreateByGrp(&streamHandleDvpp_, 0, 0, grp_t);
        streamDvpp_ = (Stream *)streamHandleDvpp_;
        streamDvpp_->SetLimitFlag(true);
        EXPECT_EQ(res, RT_ERROR_NONE);

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);

        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
    }

    virtual void TearDown()
    {
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        stream_->SetSqBaseAddr(oldSqAddr_);
        rtStreamDestroy(streamHandle_);
        rtStreamDestroy(streamHandleDvpp_);
        delete grp_;
        free(davidSqe_);
        stream_ = nullptr;
        streamDvpp_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Stream *streamDvpp_ = nullptr;
    Engine *engine_ = nullptr;
    DvppGrp *grp_ = nullptr;
    rtDavidSqe_t *davidSqe_ = nullptr;
    rtStream_t streamHandle_ = 0;
    rtStream_t streamHandleDvpp_ = 0;
    uint64_t oldSqAddr_ = 0;
    static rtChipType_t originType_;
    static void *binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

rtChipType_t ApiTestUb::originType_ = CHIP_MINI;
void *ApiTestUb::binHandle_ = nullptr;
char ApiTestUb::function_ = 'a';
uint32_t ApiTestUb::binary_[32] = {};

static void ApiTest_Stream_Cb(void *arg) {}

TEST_F(ApiTestUb, ub_doorbell_send_test_submit)
{
    rtError_t error;
    rtUbDbInfo_t dbSendInfo;
    dbSendInfo.dbNum = 0;
    error = rtUbDbSend(&dbSendInfo, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    dbSendInfo.dbNum = 2;
    dbSendInfo.info[0].dieId = 0;
    dbSendInfo.info[0].functionId = 1;
    dbSendInfo.info[0].jettyId = 10;
    dbSendInfo.info[0].piValue = 20;
    dbSendInfo.info[1].dieId = 1;
    dbSendInfo.info[1].functionId = 1;
    dbSendInfo.info[1].jettyId = 10;
    dbSendInfo.info[1].piValue = 20;
    error = rtUbDbSend(&dbSendInfo, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
}

TEST_F(ApiTestUb, ub_direct_wqe_send_test_submit)
{
    rtError_t error;
    rtUbWqeInfo_t wqeInfo;
    wqeInfo.wqeSize = 0;
    wqeInfo.wqePtrLen = 128;
    error = rtUbDirectSend(&wqeInfo, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    wqeInfo.wqeSize = 1;
    wqeInfo.wqePtrLen = 64;
    error = rtUbDirectSend(&wqeInfo, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    wqeInfo.wrCqe = 1;
    wqeInfo.wqeSize = 0;
    wqeInfo.dieId = 0;
    wqeInfo.functionId = 1;
    wqeInfo.jettyId = 10;
    wqeInfo.wqe = (uint8_t *)malloc(64 * sizeof(uint8_t));
    wqeInfo.wqePtrLen = 64U;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(5 * sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);

    error = rtUbDirectSend(&wqeInfo, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    free(wqeInfo.wqe);
    wqeInfo.wqe = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
}

TEST_F(ApiTestUb, ub_direct_wqe_send_test_submit_wqe2)
{
    rtError_t error;
    rtUbWqeInfo_t wqeInfo;
    wqeInfo.wrCqe = 1;
    wqeInfo.wqeSize = 1;
    wqeInfo.dieId = 0;
    wqeInfo.functionId = 1;
    wqeInfo.jettyId = 10;
    wqeInfo.wqe = (uint8_t *)malloc(128 * sizeof(uint8_t));
    wqeInfo.wqePtrLen = 128U;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(3 * sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);

    error = rtUbDirectSend(&wqeInfo, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    free(wqeInfo.wqe);
    wqeInfo.wqe = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
}

TEST_F(ApiTestUb, cmo_addr_send_test_submit)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    info.stride_outer = 0;
    info.stride_inner = 0;
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_RESERVED, stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTestUb, cmo_addr_cmotype_isinValid)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_RESERVED, stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, cmo_addr_test_submit_01)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    rtDavidCmoAddrInfo info = {};
    rtModel_t model;
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetModel((Model *)model);
    stream_->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->models_.clear();
    ;
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, cmo_addr_test_submit_02)
{
    rtError_t error;
    rtModel_t model;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    uint32_t pos = 5;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetModel((Model *)model);
    stream_->SetLatestModlId(((Model *)model)->Id_());
    MOCKER(AllocTaskInfo).stubs().with(mockcpp::any(), mockcpp::any(), outBound(pos)).will(returnValue(RT_ERROR_INVALID_VALUE));
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->models_.clear();
    ;
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, allocTaskInfo_stream_full)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL));
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, static_cast<Stream *>(stream), 0);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_TASK_FULL);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, allocTaskInfo_device_down)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    InitByStream(task, stream_);
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetModel((Model *)model);
    stream_->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    engine_->SetDevRunningState(DEV_RUNNING_DOWN);
    ((Stream *)stream_)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream_)->Context_()->SetFailureError(ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    ((Stream *)stream_)->SetFailureMode(STOP_ON_FAILURE);
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL));
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    engine_->SetDevRunningState(DEV_RUNNING_NORMAL);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->models_.clear();
    ;
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, allocTaskInfo_abort_on_fail)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL));
    ((Stream *)stream)->failureMode_ = ABORT_ON_FAILURE;
    ((Stream *)stream)->abortStatus_ = RT_ERROR_NONE;
    MOCKER_CPP(&Stream::GetError).stubs().will(returnValue(RT_ERROR_NONE));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(ACL_ERROR_RT_MEMORY_ALLOCATION);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, static_cast<Stream *>(stream), 0);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, allocTaskInfo_abortStatus)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(ACL_ERROR_RT_DEVICE_TASK_ABORT);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, static_cast<Stream *>(stream), 0);
    EXPECT_EQ(error, ACL_ERROR_RT_DEVICE_TASK_ABORT);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, allocTaskInfo_taskResMang_null)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    ((Stream *)stream)->ReleaseStreamTaskRes();
    EXPECT_EQ(((Stream *)stream)->taskResMang_, nullptr);
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(ACL_ERROR_RT_PARAM_INVALID);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, test_allocTaskInfo)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos)
        .stubs()
        .will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL))
        .then(returnValue(RT_ERROR_INVALID_VALUE));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(ACL_ERROR_RT_PARAM_INVALID);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, static_cast<Stream *>(stream), 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
}

TEST_F(ApiTestUb, davidSendTask_addTaskToPublicQueue_fail)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(ACL_ERROR_RT_INTERNAL_ERROR);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    MOCKER_CPP_VIRTUAL((Stream *)stream, &Stream::StarsAddTaskToStream).stubs().will(returnValue(RT_ERROR_TASK_NULL));
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
    free(sqe);
}

TEST_F(ApiTestUb, davidSendTask_halSqTaskSend)
{
    rtError_t error;
    uint32_t infoSize = 64U;
    uint8_t *cmoAddrPtr = nullptr;
    uint8_t *src = nullptr;
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtModel_t model;

    rtDavidCmoAddrInfo info = {};
    info.num_outer = 2;
    info.num_inner = 16;
    info.len_inner = 2;
    rtMalloc((void **)&src, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    info.src = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
    info.stride_outer = 0;
    info.stride_inner = 0;
    rtMalloc((void **)&cmoAddrPtr, infoSize, RT_MEMORY_HBM, DEFAULT_MODULEID);
    rtMemcpy(cmoAddrPtr, infoSize, &info, infoSize, RT_MEMCPY_HOST_TO_DEVICE);
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    task->type = TS_TASK_TYPE_CMO;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)model);
    ((Stream *)stream)->SetLatestModlId(((Model *)model)->Id_());

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stream)->Context_()->SetFailureError(ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    ((Stream *)stream)->SetFailureMode(STOP_ON_FAILURE);
    MOCKER(halSqTaskSend).stubs().will(returnValue(DRV_ERROR_NO_RESOURCES));
    Stream *stm = (Stream *)stream;
    MOCKER_CPP_VIRTUAL(stm, &Stream::PrintStmDfxAndCheckDevice).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    error = rtCmoAddrTaskLaunch(cmoAddrPtr, infoSize, RT_CMO_INVALID, stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->models_.clear();
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    rtStreamDestroy(stream);
    rtFree(cmoAddrPtr);
    rtFree(src);
    free(sqe);
}

class ApiTestUb1 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "ApiTestUb1 SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(true);
        std::cout << "ApiTestUb1 start" << std::endl;
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ApiTestUb1 end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);

        (void)rtSetSocVersion("Ascend910_9599");

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_910_9599);
        engine_ = ((RawDevice *)device_)->engine_;

        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
        stream_->SetSqMemAttr(false);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));

        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));

        grp_ = new DvppGrp(device_, 0);
        rtDvppGrp_t grp_t = (rtDvppGrp_t *)grp_;
        rtError_t ret = rtStreamCreateByGrp(&streamHandleDvpp_, 0, 0, grp_t);
        streamDvpp_ = (Stream *)streamHandleDvpp_;
        streamDvpp_->SetLimitFlag(true);
        EXPECT_EQ(res, RT_ERROR_NONE);

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
    }

    virtual void TearDown()
    {
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        rtStreamDestroy(streamHandleDvpp_);
        delete grp_;
        stream_ = nullptr;
        streamDvpp_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Stream *streamDvpp_ = nullptr;
    Engine *engine_ = nullptr;
    DvppGrp *grp_ = nullptr;
    rtStream_t streamHandle_ = 0;
    rtStream_t streamHandleDvpp_ = 0;
    static rtChipType_t originType_;
    static void *binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

rtChipType_t ApiTestUb1::originType_ = CHIP_MINI;
void *ApiTestUb1::binHandle_ = nullptr;
char ApiTestUb1::function_ = 'a';
uint32_t ApiTestUb1::binary_[32] = {};
static drvError_t halAsyncDmaCreateStub(uint32_t devId, struct halAsyncDmaInputPara *in,
                                        struct halAsyncDmaOutputPara *out)
{
    out->wqe = (uint8_t *)malloc(64);
    out->dieId = 1;
    out->functionId = 10;
    out->jettyId = 12;
    out->size = 64;
    return DRV_ERROR_NONE;
}

static drvError_t halAsyncDmaDestoryStub(uint32_t devId, halAsyncDmaDestoryPara *para)
{
    para->size = 64;
    free(para->wqe);

    return DRV_ERROR_NONE;
}

DVresult drvMemGetAttribute_DEV(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_LOCK_DEV;
    return DRV_ERROR_NONE;
}
DVresult drvMemGetAttribute_HOST(DVdeviceptr vptr, struct DVattribute *attr)
{
    attr->memType = DV_MEM_LOCK_HOST;
    return DRV_ERROR_NONE;
}

TEST_F(ApiTestUb1, ub_async_h2d_dma_submit)
{
    rtError_t error;
    void *src;
    void *dst;
    uint64_t count = 100;
    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    error = rtMalloc(&dst, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMallocHost(&src, 100, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    MOCKER(halAsyncDmaCreate).stubs().will(invoke(halAsyncDmaCreateStub));
    MOCKER(halAsyncDmaDestory).stubs().will(invoke(halAsyncDmaDestoryStub));
    TaskInfo *task = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MEMCPY, error);
    EXPECT_NE(task, nullptr);
    InitByStream(task, (Stream *)stream_);
    MemcpyAsyncTaskInitV3(task, kind, src, dst, count, 0, NULL);

    rtDavidSqe_t sqe[2];
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(task, sqe, sqBaseAddr);
    auto taskNum = GetSendDavidSqeNum(task);
    EXPECT_EQ(taskNum, 2);
    TaskUnInitProc(task);
    error = rtFreeHost(src);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(dst);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

extern int32_t drv_trans_type;
TEST_F(ApiTestUb1, ub_async_d2d_dma_submit)
{
    rtError_t error;
    void *src;
    void *dst;
    uint64_t count = 100;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    error = rtMalloc(&dst, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtMalloc(&src, 100, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);
    drv_trans_type = RT_MEMCPY_CHANNEL_TYPE_UB;
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    MOCKER(halAsyncDmaCreate).stubs().will(invoke(halAsyncDmaCreateStub));
    MOCKER(halAsyncDmaDestory).stubs().will(invoke(halAsyncDmaDestoryStub));
    TaskInfo *task = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MEMCPY, error);
    EXPECT_NE(task, nullptr);
    InitByStream(task, (Stream *)stream_);
    MemcpyAsyncTaskInitV3(task, kind, src, dst, count, 0, NULL);

    rtDavidSqe_t sqe[2];
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(task, sqe, sqBaseAddr);
    auto taskNum = GetSendDavidSqeNum(task);
    EXPECT_EQ(taskNum, 2);
    drv_trans_type = RT_MEMCPY_CHANNEL_TYPE_PCIe;
    MemcpyAsyncTaskInitV3(task, kind, src, dst, count, 0, NULL);

    drv_trans_type = RT_MEMCPY_CHANNEL_TYPE_HCCs;
    MemcpyAsyncTaskInitV3(task, kind, src, dst, count, 0, NULL);
    
    TaskUnInitProc(task);
    error = rtFreeHost(src);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(dst);
    EXPECT_EQ(error, RT_ERROR_NONE);
    drv_trans_type = 0;
}

class ApiTestUb2 : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "ApiTestUb2 SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(true);
        std::cout << "ApiTestUb2 start" << std::endl;
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ApiTestUb2 end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend910_9599");
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_910_9599);
        engine_ = ((RawDevice *)device_)->engine_;

        rtError_t res = rtStreamCreateWithFlags(&streamHandle_, 0, RT_STREAM_FAST_LAUNCH | RT_STREAM_FAST_SYNC);
        EXPECT_EQ(res, RT_ERROR_NONE);

        Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
        DavidStream *str = new (std::nothrow) DavidStream(dev, 0, RT_STREAM_DEFAULT, nullptr);
        str->argManage_ = new (std::nothrow) UbArgManage(str);
        MOCKER_CPP_VIRTUAL(str->ArgManagePtr(), &DavidArgManage::CreateArgRes).stubs().will(returnValue(true));

        stream_ = (Stream *)streamHandle_;
        stream_->SetSqMemAttr(false);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));

        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        DELETE_O(str);
    }

    virtual void TearDown()
    {
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);

        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

        Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
        DavidStream *str = new (std::nothrow) DavidStream(dev, 0, RT_STREAM_DEFAULT, nullptr);
        str->argManage_ = new (std::nothrow) UbArgManage(str);
        MOCKER_CPP_VIRTUAL(str->ArgManagePtr(), &DavidArgManage::CreateArgRes).stubs().will(returnValue(false));

        rtDeviceReset(0);
        GlobalMockObject::reset();
        DELETE_O(str);
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
    rtStream_t streamHandleDvpp_ = 0;
    static rtChipType_t originType_;
    static void *binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

rtChipType_t ApiTestUb2::originType_ = CHIP_MINI;
void *ApiTestUb2::binHandle_ = nullptr;
char ApiTestUb2::function_ = 'a';
uint32_t ApiTestUb2::binary_[32] = {};
TEST_F(ApiTestUb2, ub_doorbell_send_test_submit3)
{
    rtError_t error;
    rtUbDbInfo_t dbSendInfo;
    dbSendInfo.dbNum = 2;
    dbSendInfo.info[0].dieId = 0;
    dbSendInfo.info[0].functionId = 1;
    dbSendInfo.info[0].jettyId = 10;
    dbSendInfo.info[0].piValue = 20;
    dbSendInfo.info[1].dieId = 1;
    dbSendInfo.info[1].functionId = 1;
    dbSendInfo.info[1].jettyId = 10;
    dbSendInfo.info[1].piValue = 20;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    error = rtUbDbSend(&dbSendInfo, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
}

TEST_F(ApiTestUb2, ub_direct_wqe_send_test_normal)
{
    rtError_t error;
    int32_t devId = 0;
    rtContext_t ctxA, current;
    rtStream_t stream;
    rtUbWqeInfo_t wqeInfo;
    wqeInfo.wrCqe = 1;
    wqeInfo.dieId = 0;
    wqeInfo.wqeSize = 0;
    wqeInfo.functionId = 1;
    wqeInfo.jettyId = 10;
    wqeInfo.wqe = (uint8_t *)malloc(64 * sizeof(uint8_t));
    wqeInfo.wqePtrLen = 64U;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Stream *)stream)->SetSqMemAttr(false);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
        .will(returnValue(RT_ERROR_NONE));

    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    error = rtUbDirectSend(&wqeInfo, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    taskResMang->ResetTaskRes();
    ((Stream *)stream)->Context_()->DefaultStream_()->SetSqMemAttr(false);

    Context *curCtx = Runtime::Instance()->CurrentContext();
    Stream *defaultStm = curCtx->DefaultStream_();
    defaultStm->SetSqBaseAddr(newSqAddr);
    error = rtUbDirectSend(&wqeInfo, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    defaultStm->SetSqBaseAddr(oldSqAddr);
    stream_->SetSqBaseAddr(oldSqAddr);
    taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(defaultStm)->taskResMang_));
    taskResMang->ResetTaskRes();
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtUbDirectSend(&wqeInfo, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CONTEXT);
    error = rtCtxSetCurrent(current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(sqe);
    free(wqeInfo.wqe);
    wqeInfo.wqe = nullptr;
}

TEST_F(ApiTestUb2, ub_direct_wqe_send_test_submit3)
{
    rtError_t error;
    rtUbWqeInfo_t wqeInfo;
    ;

    wqeInfo.wrCqe = 1;
    wqeInfo.wqeSize = 0;
    wqeInfo.dieId = 0;
    wqeInfo.functionId = 1;
    wqeInfo.jettyId = 10;
    wqeInfo.wqe = (uint8_t *)malloc(64 * sizeof(uint8_t));
    wqeInfo.wqePtrLen = 64U;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);

    error = rtUbDirectSend(&wqeInfo, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    free(wqeInfo.wqe);
    wqeInfo.wqe = nullptr;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
}

TEST_F(ApiTestUb2, ub_doorbell_send_test_normal)
{
    rtError_t error;
    int32_t devId = 0;
    rtContext_t ctxA, current;

    rtStream_t stream;
    rtUbDbInfo_t dbSendInfo;
    dbSendInfo.dbNum = 1;
    dbSendInfo.info[0].dieId = 0;
    dbSendInfo.info[0].functionId = 1;
    dbSendInfo.info[0].jettyId = 10;
    dbSendInfo.info[0].piValue = 20;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Stream *)stream)->SetSqMemAttr(false);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    Driver *driver;
    driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
        .will(returnValue(RT_ERROR_NONE));

    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = ((Stream *)stream)->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    ((Stream *)stream)->SetSqBaseAddr(newSqAddr);
    error = rtUbDbSend(&dbSendInfo, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    taskResMang->ResetTaskRes();
    ((Stream *)stream)->Context_()->DefaultStream_()->SetSqMemAttr(false);
    Context *curCtx = Runtime::Instance()->CurrentContext();
    Stream *defaultStm = curCtx->DefaultStream_();
    defaultStm->SetSqBaseAddr(newSqAddr);
    error = rtUbDbSend(&dbSendInfo, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Stream *)stream)->SetSqBaseAddr(oldSqAddr);
    defaultStm->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(defaultStm)->taskResMang_));
    taskResMang->ResetTaskRes();
    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUbDbSend(&dbSendInfo, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CONTEXT);
    error = rtCtxSetCurrent(current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTestUb1, host_shared_memory_david00)
{
    rtError_t error;
    int fd = 0;
    int sharedMemAddr;
    int devSharedMemAddr;
    rtMallocHostSharedMemoryIn input = {"abcd", 100, 0};
    rtMallocHostSharedMemoryOut output = {fd, &sharedMemAddr, &devSharedMemAddr};
    rtFreeHostSharedMemoryIn inputPara = {"abcd", 100, fd, &sharedMemAddr, &devSharedMemAddr};

    NpuDriver *rawDrv = new NpuDriver();
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::MallocHostSharedMemory).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::FreeHostSharedMemory).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtMallocHostSharedMemory(&input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFreeHostSharedMemory(&inputPara);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(ApiTestUb1, host_shared_memory_david_stub_hal)
{
    rtError_t error;
    int fd = 0;
    int sharedMemAddr;
    int devSharedMemAddr;
    /* name, size, flag */
    rtMallocHostSharedMemoryIn input = {"abcd", 100, 0};
    /* fd, ptr, devPtr */
    rtMallocHostSharedMemoryOut output = {fd, &sharedMemAddr, &devSharedMemAddr};

    MOCKER(halHostRegister)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtMallocHostSharedMemory(&input, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTestUb1, host_shared_memory_david_stub_stat)
{
    rtError_t error;
    int fd = 0;
    int sharedMemAddr;
    int devSharedMemAddr;
    /* name, size, flag */
    rtMallocHostSharedMemoryIn input = {"abcd", 100, 0};
    /* fd, ptr, devPtr */
    rtMallocHostSharedMemoryOut output = {fd, &sharedMemAddr, &devSharedMemAddr};

    MOCKER(stat)
        .stubs()
        .will(returnValue(0));

    error = rtMallocHostSharedMemory(&input, &output);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTestUb1, free_host_shared_memory_david_stub_hal)
{
    rtError_t error;
    int fd = 0;
    int sharedMemAddr;
    int devSharedMemAddr;

    MOCKER(halHostUnregister)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));

    rtFreeHostSharedMemoryIn inputPara = {"abcd", 100, fd, &sharedMemAddr, &devSharedMemAddr};
    error = rtFreeHostSharedMemory(&inputPara);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTestUb1, free_host_shared_memory_david_stub_stat_hal)
{
    rtError_t error;
    int fd = 0;
    int sharedMemAddr;
    int devSharedMemAddr;

    MOCKER(halHostUnregister)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(stat)
        .stubs()
        .will(returnValue(0));

    MOCKER(munmap)
        .stubs()
        .will(returnValue(0));

    rtFreeHostSharedMemoryIn inputPara = {"abcd", 100, fd, &sharedMemAddr, &devSharedMemAddr};
    error = rtFreeHostSharedMemory(&inputPara);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTestUb1, onlineprof_david00)
{
    rtError_t error;
    error = rtStartOnlineProf(stream_, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtStopOnlineProf(stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtProfDataInfo_t pProfData = {0};
    error = rtGetOnlineProfData(stream_, &pProfData, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiTestUb1, PROCESS_REPORT_DAVID)
{
    ApiImpl apiImpl;
    rtError_t error;
    error = apiImpl.ProcessReport(0);

    uint32_t groupId = 0;
    uint32_t deviceId = 0;
    uint32_t tsId = 0;
    uint64_t threadId = 123;

    rtSubscribeReport(123, stream_);
    MOCKER_CPP(&Stream::IsHostFuncCbReg).stubs().will(returnValue(true));
    stream_->IsHostFuncCbReg();
    rtCallback_t stub_func = (rtCallback_t)0x12345;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    error = rtCallbackLaunch(stub_func, nullptr, stream_, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
    error = rtUnSubscribeReport(123, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTestUb1, api_rts_rtsCallbackLaunch_david)
{
    rtError_t error = rtsLaunchHostFunc(NULL, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTestUb1, api_rts_rtsCallbackLaunch_david2)
{
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLaunchHostFunc(stream, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}