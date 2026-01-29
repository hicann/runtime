/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
#include "event.hpp"
#include "scheduler.hpp"
#include "gtest/gtest.h"
#include "stars.hpp"
#include "stream_david.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "event.hpp"
#include "subscribe.hpp"
#include "config_define.hpp"
#include "task_res.hpp"
#include "task_recycle.hpp"
#include "task_david.hpp"
#include "raw_device.hpp"
#include "task_res_da.hpp"
#include "stream_sqcq_manage.hpp"
#include "model.hpp"
#include <thread>
#include <chrono>
#include "stream.hpp"
#include "runtime.hpp"
#include "config.hpp"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "api.hpp"
#include "profiler_c.hpp"
#include "thread_local_container.hpp"
using namespace testing;
using namespace cce::runtime;

static bool g_disableThread;
static rtChipType_t g_chipType;

extern int64_t g_device_driver_version_stub;

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_950PR_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

class DavidTaskSendTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        // backup oringal attribute of runtime
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        g_disableThread = rtInstance->GetDisableThread();
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
    }

    static void TearDownTestCase()
    {
        // restore oringal attribute
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(g_disableThread);
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
    }

    virtual void SetUp()
    {
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
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

        (void)rtSetSocVersion("Ascend950PR_9599");

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_950PR_9599);
        engine_ = ((RawDevice *)device_)->engine_;

        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;

        stream_->SetSqMemAttr(false);
        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));
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
};

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_device_down)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    InitByStream(task, stream_);
    engine_->SetDevRunningState(DEV_RUNNING_DOWN);
    rtError_t res = SubmitTaskDavid(task, stream_, -1);
    EXPECT_NE(res, RT_ERROR_NONE);
    engine_->SetDevRunningState(DEV_RUNNING_NORMAL);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_sqe_invalid)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    InitByStream(task, stream_);
    MOCKER(GetSendDavidSqeNum).stubs().will(returnValue(10));
    rtError_t res = SubmitTaskDavid(task, stream_, -1);
    EXPECT_NE(res, RT_ERROR_NONE);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_aicpu)
{
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_AICPU);
    EXPECT_EQ(res, RT_ERROR_NONE);
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    taskInfo.type = TS_TASK_TYPE_NOTIFY_RECORD;
    taskInfo.stream = (Stream *)stream;
    res = SubmitTaskDavid(task, (Stream *)stream, -1);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.type = TS_TASK_TYPE_MODEL_END_GRAPH;
    res = SubmitTaskDavid(task, (Stream *)stream, -1);
    EXPECT_NE(res, RT_ERROR_NONE);
    rtModel_t rtModel;
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::CmoIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::CmoIdFree).stubs().will(returnValue(RT_ERROR_NONE));
    res = rtModelCreate(&rtModel, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    ((Stream *)stream)->SetModel((Model *)rtModel);
    ((Stream *)stream)->SetLatestModlId(((Model *)rtModel)->Id_());
    res = SubmitTaskDavid(task, (Stream *)stream, -1);
    EXPECT_EQ(res, RT_ERROR_NONE);
    ((Stream *)stream)->DelModel((Model *)rtModel);
    res = rtModelDestroy(rtModel);
    EXPECT_EQ(res, RT_ERROR_NONE);
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_halsqsend)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    InitByStream(task, stream_);
    task->type = TS_TASK_TYPE_NOTIFY_RECORD;
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    MOCKER(halSqTaskSend).stubs().will(returnValue(DRV_ERROR_NO_RESOURCES));
    MOCKER_CPP_VIRTUAL(stream_, &Stream::PrintStmDfxAndCheckDevice).stubs().will(returnValue(1));
    rtError_t res = SubmitTaskDavid(task, stream_, -1);
    EXPECT_NE(res, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
    taskResMang->ResetTaskRes();
    free(sqe);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_full)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_NOTIFY_RECORD;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL));
    res = SubmitTaskDavid(task, static_cast<Stream *>(stream), -1);
    EXPECT_NE(res, RT_ERROR_NONE);
    taskResMang->ResetTaskRes();
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_full_check)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_DEFAULT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_NOTIFY_RECORD;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL)).then(returnValue(RT_ERROR_DRV_ERR));
    ((Stream *)stream)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    MOCKER_CPP_VIRTUAL(((Stream *)stream_)->Device_(), &Device::GetDevStatus)
    .stubs()
    .will(returnValue(RT_ERROR_NONE))
    .then(returnValue(RT_ERROR_DRV_ERR)); 
    res = SubmitTaskDavid(task, static_cast<Stream *>(stream), -1);
    EXPECT_EQ(res, RT_ERROR_DRV_ERR);
    taskResMang->ResetTaskRes();
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_full_failmode)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_PERSISTENT);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_NOTIFY_RECORD;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL));
    static_cast<Stream *>(stream)->SetFailureMode(ABORT_ON_FAILURE);
    res = SubmitTaskDavid(task, static_cast<Stream *>(stream), -1);
    EXPECT_NE(res, RT_ERROR_NONE);
    taskResMang->ResetTaskRes();
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_sqaddr)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    rtStream_t stream = 0;
    rtError_t res = rtStreamCreateWithFlags(&stream, 0, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskInfo.stream = (Stream *)stream;
    task->type = TS_TASK_TYPE_NOTIFY_RECORD;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream)->taskResMang_));
    TaskInfo addr[2] = {};
    ((DavidStream *)stream)->sqAddr_ = reinterpret_cast<uint64_t>(reinterpret_cast<void *>(addr));
    res = SubmitTaskDavid(task, static_cast<Stream *>(stream), -1);
    EXPECT_EQ(res, RT_ERROR_NONE);
    taskResMang->ResetTaskRes();
    rtStreamDestroy(stream);
}

TEST_F(DavidTaskSendTest, AllocTaskAndSendDavid_add_queuefail)
{
    TaskInfo taskInfo = {};
    TaskInfo *task = &taskInfo;
    taskInfo.stream = stream_;
    task->type = TS_TASK_TYPE_NOTIFY_RECORD;
    TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(stream_->taskResMang_));
    ((DavidStream *)stream_)->SetSqMemAttr(false);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    MOCKER_CPP_VIRTUAL((DavidStream *)stream_, &DavidStream::StarsAddTaskToStream).stubs().will(returnValue(1));
    rtError_t res = SubmitTaskDavid(task, stream_, -1);
    EXPECT_NE(res, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
}

TEST_F(DavidTaskSendTest, DavidAllocAndSendFlipTask_Fail)
{
    Runtime::Instance()->SetTrackProfFlag(true);
    ((DavidStream *)stream_)->SetSqMemAttr(false);
    rtDavidSqe_t *sqe = (rtDavidSqe_t *)malloc(sizeof(rtDavidSqe_t));
    uint64_t oldSqAddr = stream_->GetSqBaseAddr();
    uint64_t newSqAddr = reinterpret_cast<uint64_t>(sqe);
    stream_->SetSqBaseAddr(newSqAddr);
    MOCKER_CPP_VIRTUAL((DavidStream *)stream_, &DavidStream::StarsAddTaskToStream).stubs().will(returnValue(1));
    rtError_t res = DavidAllocAndSendFlipTask(stream_, 2048);
    EXPECT_NE(res, RT_ERROR_NONE);
    stream_->SetSqBaseAddr(oldSqAddr);
    free(sqe);
    Runtime::Instance()->SetTrackProfFlag(false);
}

TEST_F(DavidTaskSendTest, david_send_aicpu_msg_version_task)
{
    uint16_t head = 1U;
    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER(GetDrvSqHead).stubs().with(mockcpp::any(), outBound(head)).will(returnValue(RT_ERROR_NONE));
    ((RawDevice *)(stream_->Device_()))->PrimaryStream_()->SetSqBaseAddr(0U);
    ((RawDevice *)(stream_->Device_()))->SendTopicMsgVersionToAicpu();
}
