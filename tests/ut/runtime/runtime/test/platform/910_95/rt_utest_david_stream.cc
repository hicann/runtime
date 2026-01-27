/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>

#include <iostream>
#include <unistd.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "task_res.hpp"
#include "task_recycle.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "raw_device.hpp"
#include "profiler.hpp"
#include "task_info.hpp"
#include "context.hpp"
#include "stream_david.hpp"
#include "task_david.hpp"
#include "task_res_da.hpp"
#include "stream_sqcq_manage.hpp"
#undef private
#undef protected
#include "uma_arg_loader.hpp"
#include "program.hpp"
#include "profiler.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "stream_c.hpp"
#include "aix_c.hpp"
#include "aicpu_c.hpp"
#include "thread_local_container.hpp"
#include "config_define.hpp"
#include "event_c.hpp"
#include "api_impl_david.hpp"
#include "api_error.hpp"

using namespace testing;
using namespace cce::runtime;
extern int64_t g_device_driver_version_stub;
static rtChipType_t g_chipType;
static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_910_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

class DavidStreamTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        std::cout << "DavidStreamTest SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "DavidStreamTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "DavidStreamTest end" << std::endl;
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

        MOCKER_CPP_VIRTUAL(driver, &Driver::SetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
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

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }
        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);
        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", nullptr, 0);
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
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
    static void *binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

void *DavidStreamTest::binHandle_ = nullptr;
char DavidStreamTest::function_ = 'a';
uint32_t DavidStreamTest::binary_[32] = {};

TEST_F(DavidStreamTest, Apply_CntValue)
{
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::NotifyIdAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    DavidStream *stream = (DavidStream *)stream_;
    stream->cntNotifyId_ = MAX_UINT32_NUM;
    int32_t cntNotifyId;
    rtError_t res = stream->ApplyCntNotifyId(cntNotifyId);
    EXPECT_EQ(res, RT_ERROR_NONE);
    uint32_t cntValue;
    res = stream->ApplyCntValue(cntValue);
    EXPECT_EQ(res, RT_ERROR_INVALID_VALUE);
    stream->recordVersion_.Set(COUNT_NOTIFY_STATIC_THRESHOLD);
    stream->cntNotifyId_ = 0;
    res = stream->ApplyCntValue(cntValue);
    EXPECT_EQ(res, RT_ERROR_NONE);
    bool ret = stream->IsCntNotifyReachThreshold();
    EXPECT_EQ(ret, true);
}

TEST_F(DavidStreamTest, ApplyCntNotifyId_abnormal)
{
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::NotifyIdAlloc).stubs().will(returnValue(1));
    DavidStream *stream = (DavidStream *)stream_;
    stream->cntNotifyId_ = MAX_UINT32_NUM;
    int32_t cntNotifyId;
    rtError_t res = stream->ApplyCntNotifyId(cntNotifyId);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, StarsShowDfx)
{
    DavidStream *stream = (DavidStream *)stream_;
    stream->publicQueueHead_ = 0U;
    stream->publicQueueTail_ = 0U;
    stream->StarsShowPublicQueueDfxInfo();
    stream->publicQueueHead_ = 20U;
    stream->publicQueueTail_ = 40U;
    stream->StarsShowPublicQueueDfxInfo();
    stream->StarsShowStmDfxInfo();

    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;

    InitByStream(task, stream_);
    AicpuTaskInit(task, 1, 0);

    task->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint32_t>(TS_AICPU_KERNEL_AICPU);
    stream->StarsAddTaskToStream(task, 1);

    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    stream->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
    EXPECT_NE(beginCnt, 0ULL);

    stream->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
    EXPECT_NE(endCnt, 0ULL);
}

TEST_F(DavidStreamTest, PrintStmDfxAndCheckDevice_normal)
{
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    DavidStream *stream = (DavidStream *)stream_;
    MOCKER_CPP_VIRTUAL(device_, &Device::GetDevRunningState).stubs().will(returnValue((uint32_t)DEV_RUNNING_NORMAL));
    rtError_t res = stream->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, 1000U);
    EXPECT_EQ(res, RT_ERROR_NONE);
    res = stream->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, 1);
    EXPECT_EQ(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, CreateStreamTaskRes)
{
    DavidStream *stream = new DavidStream(device_, 0, 0, nullptr);
    TaskResManageDavid *task = new (std::nothrow) TaskResManageDavid();
    MOCKER_CPP_VIRTUAL(task, &TaskResManageDavid::CreateTaskRes).stubs().will(returnValue(false));
    rtError_t res = stream->CreateStreamTaskRes();
    EXPECT_NE(res, RT_ERROR_NONE);
    delete stream;
    delete task;
}

TEST_F(DavidStreamTest, AbortStreamTearDown)
{
    DavidStream *stream = new DavidStream(device_, 0, 0, nullptr);
    TaskResManageDavid *task = new (std::nothrow) TaskResManageDavid();
    MOCKER_CPP_VIRTUAL(task, &TaskResManageDavid::CreateTaskRes).stubs().will(returnValue(false));
    device_->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    rtError_t res = stream->CreateStreamTaskRes();
    EXPECT_NE(res, RT_ERROR_NONE);
    delete stream;
    delete task;
    device_->SetDeviceStatus(RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, PrintStmDfxAndCheckDevice_abnormal)
{
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    DavidStream *stream = (DavidStream *)stream_;
    MOCKER_CPP_VIRTUAL(device_, &Device::GetDevRunningState).stubs().will(returnValue((uint32_t)DEV_RUNNING_DOWN));
    rtError_t res = stream->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, 1000U);
    EXPECT_EQ(res, RT_ERROR_DRV_ERR);
}

TEST_F(DavidStreamTest, setup_checkgroup)
{
    DavidStream *stream = new DavidStream(device_, 0, 0, nullptr);
    MOCKER_CPP(&Stream::CheckGroup).stubs().will(returnValue(1));
    rtError_t res = stream->Setup();
    EXPECT_NE(res, RT_ERROR_NONE);
    delete stream;
}

TEST_F(DavidStreamTest, setup_forbidden)
{
    DavidStream *stream = new DavidStream(device_, 0, RT_STREAM_FORBIDDEN_DEFAULT, nullptr);
    MOCKER_CPP(&StreamSqCqManage::AllocDavidStreamSqCq).stubs().will(returnValue(1));
    rtError_t res = stream->Setup();
    EXPECT_EQ(res, RT_ERROR_NONE);
    delete stream;
}

TEST_F(DavidStreamTest, setup_persisit_alloc_sq_fail)
{
    rtStream_t stream = 0;
    MOCKER_CPP(&StreamSqCqManage::AllocDavidStreamSqCq).stubs().will(returnValue(1));
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, setup_persisit_logic_alloc)
{
    rtStream_t stream = 0;
    MOCKER_CPP(&StreamSqCqManage::AllocLogicCq).stubs().will(returnValue(1));
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, setup_persisit_modelexe)
{
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::DevMemAlloc).stubs().will(returnValue(0));
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::GetSqRegVirtualAddrBySqid)
        .stubs()
        .will(returnValue(1));
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, setup_persisit_modelexe_suc)
{
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::DevMemAlloc).stubs().will(returnValue(0));
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::GetSqRegVirtualAddrBySqid)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::MemCopySync).stubs().will(returnValue(0));
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    rtStreamDestroy(stream);
}

TEST_F(DavidStreamTest, setup_aicpu)
{
    DavidStream *stream = new DavidStream(device_, 0, RT_STREAM_AICPU, nullptr);
    rtError_t res = stream->Setup();
    EXPECT_EQ(res, RT_ERROR_NONE);
    delete stream;
}

TEST_F(DavidStreamTest, setup_flow)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_OVERFLOW);
    EXPECT_EQ(res, RT_ERROR_NONE);
    rtStreamDestroy(stream);
}

TEST_F(DavidStreamTest, setup_normal_delete)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::DevMemAlloc).stubs().will(returnValue(0));
    ((Stream *)stream)->GetDvppRRTaskAddr();
    ((Stream *)stream)->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_USER);
    rtStreamDestroy(stream);
}

TEST_F(DavidStreamTest, setup_normal_modelexe)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    ((Stream *)stream)->GetDvppRRTaskAddr();
    ((Stream *)stream)->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_USER);
    rtStreamDestroy(stream);
}

TEST_F(DavidStreamTest, setup_cnt_free_fail)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    ((DavidStream *)stream)->cntNotifyId_ = MAX_UINT32_NUM;
    int32_t cntNotifyId;
    res = ((DavidStream *)stream)->ApplyCntNotifyId(cntNotifyId);
    EXPECT_EQ(res, RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::NotifyIdFree).stubs().will(returnValue(1));
    rtStreamDestroy(stream);
}

TEST_F(DavidStreamTest, public_queue)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    ((Stream *)stream)->taskPublicBuffSize_ = 0U;
    res = ((DavidStream *)stream)->DavidUpdatePublicQueue();
    EXPECT_NE(res, RT_ERROR_NONE);
    ((Stream *)stream)->taskPublicBuffSize_ = Runtime::macroValue_.rtsqDepth;
    res = ((DavidStream *)stream)->DavidUpdatePublicQueue();
    EXPECT_NE(res, RT_ERROR_NONE);
    ((DavidStream *)stream)->publicQueueHead_ = 0;
    ((DavidStream *)stream)->publicQueueTail_ = 1;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    taskResMang->taskResATail_.Set(10);
    ((Stream *)stream)->taskPublicBuff_[0] = 6;
    uint16_t endRecylePos = 5;
    uint16_t delTaskPos;
    res = ((DavidStream *)stream)->StarsGetPublicTaskHead(nullptr, false, endRecylePos, &delTaskPos);
    EXPECT_NE(res, RT_ERROR_NONE);
    endRecylePos = 15;
    ((Stream *)stream)->taskPublicBuff_[0] = 11;
    res = ((DavidStream *)stream)->StarsGetPublicTaskHead(nullptr, false, endRecylePos, &delTaskPos);
    EXPECT_EQ(res, RT_ERROR_NONE);
    ((Stream *)stream)->taskPublicBuff_[0] = 5;
    res = ((DavidStream *)stream)->StarsGetPublicTaskHead(nullptr, false, endRecylePos, &delTaskPos);
    EXPECT_NE(res, RT_ERROR_NONE);
    endRecylePos = 10;
    res = ((DavidStream *)stream)->StarsGetPublicTaskHead(nullptr, false, endRecylePos, &delTaskPos);
    EXPECT_NE(res, RT_ERROR_NONE);
    taskResMang->taskResATail_.Set(0);
    rtStreamDestroy(stream);
}
TEST_F(DavidStreamTest, npu_driver_sw_success)
{
    NpuDriver *driver = (NpuDriver *)device_->Driver_();
    uint32_t version;
    size_t ackCount = sizeof(ts_ctrl_msg_body_t);
    MOCKER(halTsdrvCtl)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&ackCount, sizeof(ackCount)))
        .will(returnValue(DRV_ERROR_NONE));
    rtError_t res = driver->GetTsfwVersion(0, 0, version);
    EXPECT_EQ(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, npu_driver_sw_fail)
{
    NpuDriver *driver = (NpuDriver *)device_->Driver_();
    uint32_t version;
    MOCKER(halTsdrvCtl).stubs().will(returnValue(1));
    rtError_t res = driver->GetTsfwVersion(0, 0, version);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, ResClear_01)
{
    DavidStream *stream = new DavidStream(device_, 0, RT_STREAM_AICPU, nullptr);
    rtError_t ret = stream->Setup();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::NotifyIdFree).stubs().will(returnValue(0));

    MOCKER_CPP_VIRTUAL(device_, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
        .then(returnValue((uint32_t)DEV_RUNNING_DOWN));

    stream->pendingNum_.Set(1);
    stream->cntNotifyId_ = 1U;

    rtError_t error = stream->ResClear();
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
}

TEST_F(DavidStreamTest, ResClear_02)
{
    DavidStream *stream = new DavidStream(device_, 0, RT_STREAM_AICPU, nullptr);
    rtError_t ret = stream->Setup();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskResManageDavid *taskRes = reinterpret_cast<TaskResManageDavid *>(stream->taskResMang_);
    uint16_t tail = taskRes->taskResATail_.Value();
    taskRes->taskResATail_.Set(10);

    MOCKER_CPP_VIRTUAL(device_, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
        .then(returnValue((uint32_t)DEV_RUNNING_DOWN));

    int32_t timeout = 60000;
    rtError_t error = stream->ResClear(timeout);
    taskRes->taskResATail_.Set(tail);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    delete stream;
}

TEST_F(DavidStreamTest, DavidrtStreamTaskAbort_01)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);

    MOCKER_CPP(&Context::IsStreamAbortSupported)
        .stubs()
        .will(returnValue(true));
    
    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::TaskAbortByType).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::QueryAbortStatusByType).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = ((DavidStream *)stream)->StreamAbort();
    EXPECT_EQ(error, RT_ERROR_WAIT_TIMEOUT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

uint32_t gabort_times = 0U;
uint32_t gquery_times = 0U;
rtError_t TaskAbortByTypeByTimes(NpuDriver *drv, const uint32_t deviceId, const uint32_t tsId, const uint32_t opType,
    const uint32_t targetId, uint32_t &result)
{
    if (gabort_times == 0U) {
        result = 0x115;
    } else if (gabort_times == 1U) {
        result = 0U;
    }
    gabort_times++;
    return RT_ERROR_NONE;
}
 
rtError_t QueryAbortStatusByTypeByTimes(NpuDriver *drv, const uint32_t deviceId, const uint32_t tsId, const uint32_t queryType,
    const uint32_t targetId, uint32_t &status)
{
    if (gquery_times == 0U) {
        status = 1;
    } else if (gquery_times == 1U) {
        status = 5U;
    } else if (gquery_times == 2U) {
        status = 6U;
    }
    gquery_times++;
    return RT_ERROR_NONE;
}

TEST_F(DavidStreamTest, DavidrtStreamStop_01)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);

    ((DavidStream *)stream)->SetBindFlag(true);
    rtError_t error = rtsStreamStop(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, DavidrtStreamStop_02)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    gabort_times = 0U;
    gquery_times = 0U;
    MOCKER(halSqCqConfig)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::TaskAbortByType)
        .stubs()
        .will(invoke(TaskAbortByTypeByTimes));

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::QueryAbortStatusByType)
        .stubs()
        .will(invoke(QueryAbortStatusByTypeByTimes));
    rtError_t error = rtsStreamStop(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, DavidrtStreamStop_03)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    ApiImpl impl;
    ApiDecorator apiDecorator(&impl);
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::StreamClear)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = apiDecorator.StreamStop(((DavidStream *)stream));
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, DavidrtStreamRecover_01)
{
    RawDevice *device = new RawDevice(0);

    device->Init();
    DavidStream *stream = new DavidStream(device, 0, 0, nullptr);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::RecoverAbortByType).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::QueryRecoverStatusByType).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->StreamRecoverAbort();
    EXPECT_EQ(error, RT_ERROR_WAIT_TIMEOUT);
    MOCKER(ProcStreamRecordTask).stubs().will(returnValue(0));
    delete stream;
    delete device;
}

TEST_F(DavidStreamTest, DavidrtModelAbortByid)
{
    RawDevice *device = new RawDevice(0);

    device->Init();
    DavidStream *stream = new DavidStream(device, 0, 0, nullptr);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::TaskAbortByType).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::QueryAbortStatusByType).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(ProcStreamRecordTask).stubs().will(returnValue(0));
    rtError_t error = stream->ModelAbortById(1);
    EXPECT_EQ(error, RT_ERROR_WAIT_TIMEOUT);
    delete stream;
    delete device;
}

TEST_F(DavidStreamTest, record_task_fail_0)
{
    MOCKER(AllocTaskInfo).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t res = ((DavidStream *)stream_)->SubmitRecordTask(200);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, maintence_task)
{
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->Device_()->GetStreamSqCqManage()->sqIdToStreamIdMap_[0] = stream_->Id_();
    stream_->SetSqBaseAddr(newSqAddr);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    TaskInfo reportTask = {};
    reportTask.taskSn = 0U;
    reportTask.stream = stream_;
    MOCKER(GetTaskInfo).stubs().will(returnValue(&reportTask));
    rtError_t res = ((DavidStream *)stream_)->SubmitMaintenanceTask(MT_STREAM_RECYCLE_TASK, false, 0, 0, false);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskResMang->ResetTaskRes();
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
}

TEST_F(DavidStreamTest, record_task_fail_1)
{
    MOCKER(ProcStreamRecordTask).stubs().will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    rtError_t res = ((DavidStream *)stream_)->SubmitRecordTask(200);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, SYNCHRONIZE_TEST_DAVID)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context *> *refObject = NULL;
    refObject = (RefObject<Context *> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();

    bool ret = ctx->IsStreamNotSync(RT_STREAM_CP_PROCESS_USE);
    EXPECT_EQ(ret, true);
    ret = ctx->IsStreamNotSync(RT_STREAM_PERSISTENT);
    EXPECT_EQ(ret, true);
    ret = ctx->IsStreamNotSync(RT_STREAM_AICPU);
    EXPECT_EQ(ret, true);
    ret = ctx->IsStreamNotSync(RT_STREAM_DEFAULT);
    EXPECT_EQ(ret, false);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(DavidStreamTest, davidstream_IsReclaimAsync)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;
    TaskInfo tsk = {};
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    DavidStream *stream_var = static_cast<DavidStream *>(stream);

    tsk.type = TS_TASK_TYPE_NOTIFY_WAIT;
    bool ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, true);
    tsk.type = TS_TASK_TYPE_NOTIFY_RECORD;
    ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, true);
    tsk.type = TS_TASK_TYPE_MODEL_EXECUTE;
    ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, false);

    tsk.type = TS_TASK_TYPE_MEMCPY;
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, false);
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2H;
    ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, false);
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_PCIe;
    ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, false);
    tsk.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_SDMA;
    ret = stream_var->IsReclaimAsync(&tsk);
    EXPECT_EQ(ret, true);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DavidStreamTest, TestCreateStreamAndGet)
{
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::DevMemAlloc).stubs().will(returnValue(0));
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::GetSqRegVirtualAddrBySqid)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP_VIRTUAL((NpuDriver *)device_->Driver_(), &NpuDriver::MemCopySync).stubs().will(returnValue(0));
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_CP_PROCESS_USE);
    EXPECT_EQ(res, RT_ERROR_NONE);
    res = rtStreamDestroy(stream);
    EXPECT_EQ(res, RT_ERROR_NONE);
}
