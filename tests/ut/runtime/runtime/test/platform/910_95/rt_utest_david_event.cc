/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <unistd.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "api_impl_david.hpp"
#include "engine.hpp"
#include "task_res.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "event_pool.hpp"
#include "event_david.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include "context.hpp"
#include "stream_david.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#undef private
#undef protected
#include "event_c.hpp"
#include "task_recycle.hpp"
#include "securec.h"
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "stream_c.hpp"
#include "thread_local_container.hpp"
#include "config_define.hpp"
#include "task_res_da.hpp"

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

class EventTestDavid : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        std::cout << "EventTestDavid SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "EventTestDavid start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "UbStreamTest end" << std::endl;
    }

    virtual void SetUp()
    {
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

TEST_F(EventTestDavid, TestAllocEventIdResource)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    int32_t eventId = 0;
    evt->eventFlag_ = RT_EVENT_TIME_LINE;
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    evt->eventFlag_ = RT_EVENT_DEFAULT;
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(stm, &Stream::IsCntNotifyReachThreshold).stubs().will(returnValue(true));
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(evt, &DavidEvent::QueryEventWaitStatus).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    ((Stream *)stm)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream *)stm)->Context_()->SetFailureError(RT_ERROR_DRV_ERR); 
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);

    EventPool *eventPool = new (std::nothrow) EventPool(device_, 0);
    EXPECT_EQ(eventPool->poolSize_, 0U);
    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::NotifyIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    error = eventPool->AllocEventIdFromDrv(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete eventPool;
}

TEST_F(EventTestDavid, TestWaitSendCheck)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    int32_t eventId = -1;
    evt->isNewMode_ = true;
    evt->status_ = DavidEventState_t::EVT_RECORDED;
    error = evt->WaitSendCheck(stm, eventId);
    EXPECT_EQ(error, 0);

    evt->status_ = DavidEventState_t::EVT_NOT_RECORDED;
    error = evt->WaitSendCheck(stm, eventId);
    EXPECT_EQ(error, 0);

    evt->eventId_ = 1;
    error = evt->WaitSendCheck(stm, eventId);
    EXPECT_EQ(error, 1);

    stm->bindFlag_.Set(true);
    error = evt->WaitSendCheck(stm, eventId);
    EXPECT_EQ(error, 1);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    stm->bindFlag_.Set(false);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestReclaimTask)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;

    error = evt->ReclaimTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestWaitTask)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;
    uint64_t mode = stm->GetFailureMode();
    std::shared_ptr<Stream> stmSharedPtr = stm->GetSharedPtr();
    MOCKER_CPP(&StreamSqCqManage::GetStreamSharedPtrById)
        .stubs()
        .with(mockcpp::any(), outBound(stmSharedPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    stm->failureMode_ = STOP_ON_FAILURE;
    error = evt->WaitTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    stm->failureMode_ = ABORT_ON_FAILURE;
    error = evt->WaitTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    stm->failureMode_ = CONTINUE_ON_FAILURE;
    error = evt->WaitTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    stm->failureMode_ = mode;
    GlobalMockObject::verify();
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestClearRecordStatus)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;

    error = evt->ClearRecordStatus();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestDoCompleteSuccessForDavidEventWaitTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventWaitTaskInit(&task, evt, evt->EventId_(), 0U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    task.id = 0;
    task.errorCode = TS_ERROR_END_OF_SEQUENCE;

    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
    MOCKER_CPP(&Event::DeleteWaitFromMap).stubs();
    DoCompleteSuccessForDavidEventWaitTask(&task, 0);
    task.errorCode = TS_ERROR_TASK_EXCEPTION;
    DoCompleteSuccessForDavidEventWaitTask(&task, 0);
    delete evt;
}

TEST_F(EventTestDavid, TestDoCompleteSuccessForDavidEventResetTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventResetTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RESET);
    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
    MOCKER_CPP(&Event::DeleteWaitFromMap).stubs();
    DoCompleteSuccessForDavidEventResetTask(&task, 0);
    delete evt;
}

TEST_F(EventTestDavid, TestDoCompleteSuccessForDavidEventRecordTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);
    task.errorCode = TS_ERROR_UNKNOWN;
    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
    MOCKER_CPP(&DavidEvent::RecordComplete).stubs();
    DoCompleteSuccessForDavidEventRecordTask(&task, 0);
    delete evt;
}

TEST_F(EventTestDavid, TestToConstructDavidEventRecordTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    evt->isCntNotify_ = true;
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    delete evt;
}

TEST_F(EventTestDavid, TestToConstructDavidEventWaitTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    evt->isCntNotify_ = true;
    DavidEventWaitTaskInit(&task, evt, evt->EventId_(), 0U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&task, &sqe, sqBaseAddr);
    delete evt;
}

TEST_F(EventTestDavid, TestSetStarsResultForDavidEventRecordTask)
{
    TaskInfo task = {};
    rtLogicCqReport_t report = {0};
    report.errorCode = TS_ERROR_END_OF_SEQUENCE;
    report.errorType = RT_STARS_EXIST_ERROR;
    SetStarsResultForDavidEventRecordTask(&task, report);
    EXPECT_EQ(task.errorCode, TS_ERROR_END_OF_SEQUENCE);
    task.errorCode = 0U;
    report.errorType = 0U;
    SetStarsResultForDavidEventRecordTask(&task, report);
    EXPECT_EQ(task.errorCode, 0U);
}

TEST_F(EventTestDavid, TestElapsedTime)
{
    rtError_t error;
    rtEvent_t start;
    rtEvent_t end;
    rtStream_t stream;

    rtEventCreate(&start);
    DavidEvent *startEvt = (DavidEvent *)start;
    startEvt->SetRecord(false);
    rtEventCreate(&end);
    DavidEvent *endEvt = (DavidEvent *)end;
    endEvt->SetRecord(false);

    float32_t timeInterval = 0;
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);

    startEvt->SetRecord(true);
    endEvt->SetRecord(true);
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(start);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(end);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestGetTimeStamp)
{
    rtError_t error;
    rtEvent_t event;
    rtEvent_t end;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    uint64_t recTimestamp = 0UL;
    evt->SetRecord(false);

    error = evt->GetTimeStamp(&recTimestamp);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);

    evt->SetRecord(true);
    error = evt->GetTimeStamp(&recTimestamp);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);

    evt->timestamp_ = 1;
    error = evt->GetTimeStamp(&recTimestamp);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestResetTaskUnInit)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventResetTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RESET);
    DavidEventResetTaskUnInit(&task);
    delete evt;
}

TEST_F(EventTestDavid, TestWaitTaskUnInit)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventWaitTaskInit(&task, evt, evt->EventId_(), 0U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
    DavidEventWaitTaskUnInit(&task);
    delete evt;
}

TEST_F(EventTestDavid, TestQuery)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    TaskInfo taskInfo = {0};
    taskInfo.stream = stm;
    taskInfo.id = 0;
    taskInfo.type = TS_TASK_TYPE_EVENT_RECORD;
    evt->InsertWaitToMap(&taskInfo);

    MOCKER(TaskReclaimByStream).stubs().will(returnValue(RT_ERROR_NONE));
    evt->Query();

    evt->DeleteWaitFromMap(&taskInfo);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestSynchronize)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    MOCKER_CPP_VIRTUAL(evt, &DavidEvent::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    evt->SetRecord(false);
    error = evt->Synchronize(1U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    evt->SetRecord(true);
    error = evt->Synchronize(1U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestQueryEventStatus)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    MOCKER_CPP_VIRTUAL(evt, &DavidEvent::QueryEventTask).stubs().will(returnValue(RT_ERROR_NONE));
    evt->SetRecord(false);
    error = evt->QueryEventStatus(&status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_INIT);

    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_RECORDED);
    error = evt->QueryEventStatus(&status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestQueryEventTask)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    rtEventStatus_t status1 = RT_EVENT_RECORDED;
    MOCKER_CPP(&StreamSqCqManage::GetStreamById)
        .stubs()
        .with(mockcpp::any(), outBoundP(&stm), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm, &Stream::JudgeHeadTailPos)
        .stubs()
        .with(outBoundP(&status1, sizeof(status1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(TaskReclaimByStream).stubs().will(returnValue(RT_ERROR_NONE));

    evt->timestamp_ = UINT64_MAX;
    error = evt->QueryEventTask(&status);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestQueryEventWaitStatus)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    bool waitFlag = false;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    TaskInfo taskInfo = {0};
    taskInfo.stream = stm;
    taskInfo.id = 0;
    taskInfo.type = TS_TASK_TYPE_EVENT_RECORD;
    evt->InsertWaitToMap(&taskInfo);

    MOCKER_CPP_VIRTUAL(stm, &Stream::QueryWaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    evt->SetRecord(false);
    error = evt->QueryEventWaitStatus(true, waitFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    evt->DeleteWaitFromMap(&taskInfo);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestEventCreateEx)
{
    rtError_t error;
    rtStream_t stream;
    ApiImplDavid apiImpl;
    Event *evt = NULL;
    error = apiImpl.EventCreate(&evt, RT_EVENT_MC2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    apiImpl.EventDestroy(evt);

    error = apiImpl.EventCreateEx(&evt, RT_EVENT_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);
    apiImpl.EventDestroy(evt);
}

TEST_F(EventTestDavid, TestProcStreamRecordTask)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;
    Device *dev = stm->Device_();
    MOCKER(DavidEventRecordTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = ProcStreamRecordTask(stm, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestRecordDavidEventComplete)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent *evt = (DavidEvent *)event;
    rtStreamCreate(&stream, 0);
    Stream *stm = (Stream *)stream;

    TaskInfo taskInfo = {0};
    taskInfo.stream = stm;
    taskInfo.id = 0;
    taskInfo.type = TS_TASK_TYPE_EVENT_RECORD;

    DavidRecordTaskInfo latestRecord = {stm->Id_(), static_cast<uint32_t>(taskInfo.id)};
    evt->UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_NOT_RECORDED, UINT64_MAX);

    evt->RecordDavidEventComplete(&taskInfo, 0ULL);
    EXPECT_EQ(evt->status_, DavidEventState_t::EVT_RECORDED);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestDavidEventRecordTaskUnInit)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);

    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
    MOCKER_CPP(&DavidEvent::RecordComplete).stubs();
    stream_->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    DavidEventRecordTaskUnInit(&task);
    EXPECT_EQ(evt->status_, DavidEventState_t::EVT_NOT_RECORDED);
    stream_->Device_()->SetDeviceStatus(RT_ERROR_NONE);
    delete evt;
}

TEST_F(EventTestDavid, TestDavidUpdateAndTryToDestroyEvent)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    evt->InsertRecordResetToMap(&task);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);
    Event *evtTmp = (Event *)evt;
    evt->SetIsNeedDestroy(true);
    DavidUpdateAndTryToDestroyEvent(&task, &evtTmp, DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);
}

TEST_F(EventTestDavid, TestDavidUpdateAndTryToDestroyEvent1)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void *addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent *evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventWaitTaskInit(&task, evt, evt->EventId_(), 1000);
    evt->InsertWaitToMap(&task);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    Event *evtTmp = (Event *)evt;
    evt->SetIsNeedDestroy(true);
    DavidUpdateAndTryToDestroyEvent(&task, &evtTmp, DavidTaskMapType::TASK_MAP_TYPE_WAIT_MAP);
}