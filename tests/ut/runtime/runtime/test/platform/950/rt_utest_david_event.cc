/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common/enum_log.hpp"
#include <iostream>
#include <time.h>
#include <unistd.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "rt_unwrap.h"
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
#include "cnt_notify_res.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include "runtime_task_manager.h"
#include "memory_task.h"
#include "event_task.h"
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
#include "../../rt_utest_config_define.hpp"
#include "task_res_da.hpp"
#include "capture_model_utils.hpp"

using namespace testing;
using namespace cce::runtime;
extern int64_t g_device_driver_version_stub;
static rtChipType_t g_chipType;
static uint8_t* g_externalEventStatus = nullptr;
static uint32_t g_externalEventQueryTimes = 0U;
static uint32_t g_externalEventClockTimes = 0U;
static DavidEvent* g_externalSyncDavidEvent = nullptr;
constexpr uint32_t EXTERNAL_EVENT_COMPLETE_QUERY_TIMES = 10001U;

static int ExternalEventTimeoutClockStub(clockid_t clockId, struct timespec* timeSpec)
{
    timeSpec->tv_sec = 0;
    timeSpec->tv_nsec = 0;
    if (clockId == CLOCK_MONOTONIC_RAW) {
        timeSpec->tv_nsec = (g_externalEventClockTimes >= 5000U) ? 1000000L : 0L;
        g_externalEventClockTimes++;
    }
    return 0;
}

static bool CompleteExternalEventAfterRepeatedQueries()
{
    g_externalEventQueryTimes++;
    if (g_externalEventQueryTimes == EXTERNAL_EVENT_COMPLETE_QUERY_TIMES) {
        *g_externalEventStatus = 1U;
    }
    return true;
}

static bool CompleteDavidRecordAfterQuery()
{
    const DavidRecordTaskInfo latestRecord = g_externalSyncDavidEvent->GetLatestRecordInfo();
    g_externalSyncDavidEvent->UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_RECORDED, UINT64_MAX);
    return true;
}

static rtError_t CheckRecordOwnerThenFail(TaskInfo* task, Stream*)
{
    DavidEvent* event = static_cast<DavidEvent*>(task->u.memWriteValueTask.event);
    EXPECT_EQ(task->u.memWriteValueTask.ownedEventId, event->EventId_());
    EXPECT_EQ(event->idMap_[event->EventId_()], 1U);
    return RT_ERROR_DRV_ERR;
}

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value)
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

class EventTestDavid : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char* socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        std::cout << "EventTestDavid SetUP" << std::endl;
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        g_chipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "EventTestDavid start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(g_chipType);
        GlobalContainer::SetRtChipType(g_chipType);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "UbStreamTest end" << std::endl;
    }

    virtual void SetUp()
    {
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char* socVer = "Ascend950PR_9599";
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
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);

        device_ = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetChipType(CHIP_DAVID);
        engine_ = ((RawDevice*)device_)->engine_;

        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);

        stream_->SetSqMemAttr(false);
        TaskResManageDavid* taskResMang = ((TaskResManageDavid*)(static_cast<Stream*>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetResTail()))
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
        ((Runtime*)Runtime::Instance())->DeviceRelease(device_);
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device* device_ = nullptr;
    Stream* stream_ = nullptr;
    Engine* engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};

TEST_F(EventTestDavid, TestAllocEventIdResource)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    int32_t eventId = 0;
    evt->eventFlag_ = RT_EVENT_TIME_LINE;
    error = evt->GenEventId();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    evt->eventFlag_ = RT_EVENT_DEFAULT;
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(evt->GetCntNotifyRes(), nullptr); // 事件绑定流级计数通知资源

    MOCKER_CPP_VIRTUAL(stm, &Stream::IsCntNotifyReachThreshold).stubs().will(returnValue(true));
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(evt, &DavidEvent::QueryEventWaitStatus).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    ((Stream*)stm)->Context_()->SetCtxMode(STOP_ON_FAILURE);
    ((Stream*)stm)->Context_()->SetFailureError(RT_ERROR_DRV_ERR);
    error = evt->AllocEventIdResource(stm, eventId);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);

    EventPool* eventPool = new (std::nothrow) EventPool(device_, 0);
    EXPECT_EQ(eventPool->poolSize_, 0U);
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::NotifyIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    error = eventPool->AllocEventIdFromDrv(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete eventPool;
}

TEST_F(EventTestDavid, AllocEventIdResourceReturnsApplyCntNotifyIdError)
{
    DavidEvent event(device_, RT_EVENT_DEFAULT, stream_->Context_(), false);
    DavidStream* const stream = static_cast<DavidStream*>(stream_);
    stream->cntNotifyRes_ = nullptr;
    int32_t eventId = INVALID_EVENT_ID;
    MOCKER_CPP_VIRTUAL(stream_, &Stream::ApplyCntNotifyId)
        .expects(once())
        .will(returnValue(RT_ERROR_DRV_NO_EVENT_RESOURCES));

    EXPECT_EQ(event.AllocEventIdResource(stream_, eventId), RT_ERROR_DRV_NO_EVENT_RESOURCES);
    EXPECT_EQ(eventId, INVALID_EVENT_ID);        // 失败时出参保持未分配标记
    EXPECT_EQ(event.GetCntNotifyRes(), nullptr); // 失败时不绑定流级资源
}

TEST_F(EventTestDavid, EvtRecordReturnsAllocEventIdResourceError)
{
    rtEvent_t eventHandle = nullptr;
    ASSERT_EQ(rtEventCreate(&eventHandle), RT_ERROR_NONE);
    DavidEvent* const event = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(eventHandle));
    ASSERT_NE(event, nullptr);
    MOCKER_CPP_VIRTUAL(event, &DavidEvent::AllocEventIdResource)
        .expects(once())
        .will(returnValue(RT_ERROR_DRV_NO_EVENT_RESOURCES));
    MOCKER(DavidSendTask).expects(never());

    EXPECT_EQ(EvtRecord(event, stream_), RT_ERROR_DRV_NO_EVENT_RESOURCES);
    EXPECT_EQ(rtEventDestroy(eventHandle), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, TestWaitSendCheck)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));

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
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
    uint64_t mode = stm->GetFailureMode();
    std::shared_ptr<Stream> stmSharedPtr = stm->GetSharedPtr();
    MOCKER_CPP(&StreamSqCqManage::GetStreamSharedPtrById)
        .stubs()
        .with(mockcpp::any(), outBound(stmSharedPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    stm->failureMode_.Set(STOP_ON_FAILURE);
    error = evt->WaitTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    stm->failureMode_.Set(ABORT_ON_FAILURE);
    error = evt->WaitTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    stm->failureMode_.Set(CONTINUE_ON_FAILURE);
    error = evt->WaitTask(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    stm->failureMode_.Set(mode);
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
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));

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
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
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
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
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
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);
    task.errorCode = TS_ERROR_UNKNOWN;
    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
    DoCompleteSuccessForDavidEventRecordTask(&task, 0);
    delete evt;
}

TEST_F(EventTestDavid, TestDoCompleteSuccessForNotifyRecordTaskSetsStreamErrorCode)
{
    const rtChipType_t chipTypes[] = {CHIP_DAVID, CHIP_CLOUD_V5, CHIP_CLOUD_V6};
    for (const auto chipType : chipTypes) {
        SCOPED_TRACE(static_cast<int32_t>(chipType));
        PfnDoCompleteSucc completeFunc = g_taskFuncArrays[chipType].doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_RECORD];
        ASSERT_NE(completeFunc, nullptr);

        TaskInfo task = {};
        InitByStream(&task, stream_);
        task.type = TS_TASK_TYPE_NOTIFY_RECORD;
        task.typeName = const_cast<char_t*>("NOTIFY_RECORD");
        task.errorCode = TS_ERROR_TASK_EXCEPTION;
        stream_->SetErrCode(RT_ERROR_NONE);

        completeFunc(&task, 0U);

        EXPECT_EQ(stream_->GetErrCode(), TS_ERROR_TASK_EXCEPTION);
    }
}

TEST_F(EventTestDavid, TestToConstructDavidEventRecordTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    evt->isCntNotify_ = true;
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    delete evt;
}

// 事件持有一份计数通知资源引用：record 所在流(owner)销毁后资源仍存活，
// 事件析构时触发一次 NotifyIdFree 并自回收
TEST_F(EventTestDavid, EventOwnedRefKeepsCntNotifyResAliveAfterOwnerReleased)
{
    rtStream_t streamHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&streamHandle, 0), RT_ERROR_NONE);
    DavidStream* const recStm = static_cast<DavidStream*>(rt_ut::UnwrapOrNull<Stream>(streamHandle));
    ASSERT_NE(recStm, nullptr);
    CntNotifyRes* const cntRes = new (std::nothrow) CntNotifyRes(device_, device_->DevGetTsId(), 7U);
    ASSERT_NE(cntRes, nullptr);
    cntRes->Acquire(); // 流(owner)引用
    recStm->cntNotifyRes_ = cntRes;

    DavidEvent* const evt = new (std::nothrow) DavidEvent(device_, RT_EVENT_DEFAULT, stream_->Context_(), false);
    ASSERT_NE(evt, nullptr);
    int32_t eventId = INVALID_EVENT_ID;
    ASSERT_EQ(evt->AllocEventIdResource(recStm, eventId), RT_ERROR_NONE);
    EXPECT_EQ(eventId, 7);
    ASSERT_EQ(evt->GetCntNotifyRes(), cntRes);
    EXPECT_EQ(cntRes->refs_.load(), 2U); // owner(recStm) + event 各一份

    // 销毁 record 所在流：owner 释放引用，事件引用使资源保持存活（本次修复点）
    ASSERT_EQ(rtStreamDestroy(streamHandle), RT_ERROR_NONE);
    EXPECT_EQ(cntRes->refs_.load(), 1U);  // 仅剩事件引用
    EXPECT_EQ(cntRes->GetNotifyId(), 7U); // 资源未被释放，notify id 仍有效

    // 事件析构归还末位引用：NotifyIdFree 恰一次 + 资源自回收
    MOCKER_CPP_VIRTUAL((NpuDriver*)device_->Driver_(), &NpuDriver::NotifyIdFree)
        .expects(once())
        .will(returnValue(RT_ERROR_NONE));
    delete evt;
}

// 事件换流 record：旧资源仍被在途 wait 任务持有，旧 id 在 wait 收尾前不得释放
TEST_F(EventTestDavid, EventRebindKeepsOldResAliveWhileWaitPending)
{
    rtStream_t handleA = nullptr;
    rtStream_t handleB = nullptr;
    ASSERT_EQ(rtStreamCreate(&handleA, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamCreate(&handleB, 0), RT_ERROR_NONE);
    DavidStream* const stmA = static_cast<DavidStream*>(rt_ut::UnwrapOrNull<Stream>(handleA));
    DavidStream* const stmB = static_cast<DavidStream*>(rt_ut::UnwrapOrNull<Stream>(handleB));
    ASSERT_NE(stmA, nullptr);
    ASSERT_NE(stmB, nullptr);

    CntNotifyRes* const resA = new (std::nothrow) CntNotifyRes(device_, device_->DevGetTsId(), 10U);
    ASSERT_NE(resA, nullptr);
    resA->Acquire(); // owner(stmA) 引用
    stmA->cntNotifyRes_ = resA;
    CntNotifyRes* const resB = new (std::nothrow) CntNotifyRes(device_, device_->DevGetTsId(), 11U);
    ASSERT_NE(resB, nullptr);
    resB->Acquire(); // owner(stmB) 引用
    stmB->cntNotifyRes_ = resB;

    DavidEvent* const evt = new (std::nothrow) DavidEvent(device_, RT_EVENT_DEFAULT, stream_->Context_(), false);
    ASSERT_NE(evt, nullptr);
    int32_t eventId = INVALID_EVENT_ID;
    ASSERT_EQ(evt->AllocEventIdResource(stmA, eventId), RT_ERROR_NONE);
    EXPECT_EQ(resA->refs_.load(), 2U); // owner(stmA) + event

    // 旧绑定上已下发 wait 任务，任务持有一份 resA 引用
    TaskInfo waitTask = {};
    InitByStream(&waitTask, stream_);
    DavidEventWaitTaskInit(&waitTask, evt, eventId, 0U);
    EXPECT_EQ(resA->refs_.load(), 3U); // owner(stmA) + event + wait

    // 换绑到 B：事件归还 resA 引用，但 wait 任务仍持有，resA 不得释放
    ASSERT_EQ(evt->AllocEventIdResource(stmB, eventId), RT_ERROR_NONE);
    EXPECT_EQ(evt->GetCntNotifyRes(), resB);
    EXPECT_EQ(resA->refs_.load(), 2U);   // owner(stmA) + wait
    EXPECT_EQ(resA->GetNotifyId(), 10U); // 旧 id 仍有效

    // 旧流销毁：仍由 wait 任务兜住
    MOCKER_CPP_VIRTUAL((NpuDriver*)device_->Driver_(), &NpuDriver::NotifyIdFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(rtStreamDestroy(handleA), RT_ERROR_NONE);
    EXPECT_EQ(resA->refs_.load(), 1U);   // 仅剩 wait 任务
    EXPECT_EQ(resA->GetNotifyId(), 10U); // 旧 id 仍有效

    // wait 收尾：末位释放旧 id
    DavidEventWaitTaskUnInit(&waitTask);

    // 新流销毁 + 事件析构：resB 的引用依次归还
    delete evt;
    ASSERT_EQ(rtStreamDestroy(handleB), RT_ERROR_NONE);
}

// reset 任务与 wait 任务一致：初始化持有一份资源引用，收尾归还
TEST_F(EventTestDavid, TestResetTaskHoldsAndReleasesCntNotifyRef)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, RT_EVENT_DEFAULT, stream_->Context_(), false);
    ASSERT_NE(evt, nullptr);
    int32_t eventId = INVALID_EVENT_ID;
    ASSERT_EQ(evt->AllocEventIdResource(stream_, eventId), RT_ERROR_NONE);
    CntNotifyRes* const cntRes = evt->GetCntNotifyRes();
    ASSERT_NE(cntRes, nullptr);
    const uint32_t refsBefore = cntRes->refs_.load();

    DavidEventResetTaskInit(&task, evt, eventId);
    EXPECT_EQ(cntRes->refs_.load(), refsBefore + 1U); // reset 任务持有一份引用
    DavidEventResetTaskUnInit(&task);
    EXPECT_EQ(cntRes->refs_.load(), refsBefore);      // 任务收尾归还引用

    delete evt;
}

TEST_F(EventTestDavid, TestToConstructDavidEventWaitTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    evt->isCntNotify_ = true;
    DavidEventWaitTaskInit(&task, evt, evt->EventId_(), 0U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    delete evt;
}

TEST_F(EventTestDavid, TestEventSqesPreserveSeventeenthNotifyIdBit)
{
    constexpr int32_t eventId = 0x10001;
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, RT_EVENT_WITH_FLAG, nullptr, false);
    ASSERT_NE(evt, nullptr);
    evt->SetEventId(eventId);

    const TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    TaskInfo recordTask = {};
    InitByStream(&recordTask, stream_);
    ASSERT_EQ(DavidEventRecordTaskInit(&recordTask, evt, eventId), RT_ERROR_NONE);
    rtDavidSqe_t recordSqe = {};
    ToConstructSqe(&recordTask, &recordSqe, sqeInfo);

    TaskInfo waitTask = {};
    InitByStream(&waitTask, stream_);
    DavidEventWaitTaskInit(&waitTask, evt, eventId, 0U);
    rtDavidSqe_t waitSqe = {};
    ToConstructSqe(&waitTask, &waitSqe, sqeInfo);

    TaskInfo resetTask = {};
    InitByStream(&resetTask, stream_);
    DavidEventResetTaskInit(&resetTask, evt, eventId);
    rtDavidSqe_t resetSqe = {};
    ToConstructSqe(&resetTask, &resetSqe, sqeInfo);

    EXPECT_EQ(recordSqe.notifySqe.notifyId, static_cast<uint32_t>(eventId));
    EXPECT_EQ(waitSqe.notifySqe.notifyId, static_cast<uint32_t>(eventId));
    EXPECT_EQ(resetSqe.notifySqe.notifyId, static_cast<uint32_t>(eventId));
    evt->SetEventId(INVALID_EVENT_ID);
    delete evt;
}

TEST_F(EventTestDavid, TestSetStarsResultForDavidEventRecordTask)
{
    TaskInfo task = {};
    rtCqReport_t report = {0};
    report.errorCode = TS_ERROR_END_OF_SEQUENCE;
    report.errorType = RT_STARS_EXIST_ERROR;
    SetStarsResultForDavidEventRecordTask(&task, report);
    EXPECT_EQ(task.errorCode, TS_ERROR_END_OF_SEQUENCE);
    task.errorCode = 0U;
    report.errorType = 0U;
    SetStarsResultForDavidEventRecordTask(&task, report);
    EXPECT_EQ(task.errorCode, 0U);
}

TEST_F(EventTestDavid, TestDavidEventRecordSetStarsResultMapsErrorTypeForTargetChips)
{
    const rtChipType_t chipTypes[] = {CHIP_DAVID, CHIP_CLOUD_V5, CHIP_CLOUD_V6};
    const uint32_t expectedErrorCodes[TS_STARS_ERROR_MAX_INDEX] = {
        TS_ERROR_TASK_EXCEPTION, TS_ERROR_TASK_BUS_ERROR,          TS_ERROR_TASK_TIMEOUT,
        TS_ERROR_TASK_SQE_ERROR, TS_ERROR_TASK_RES_CONFLICT_ERROR, TS_ERROR_TASK_SW_STATUS_ERROR};
    for (const auto chipType : chipTypes) {
        PfnTaskSetStarsResult setStarsResultFunc =
            g_taskFuncArrays[chipType].setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD];
        ASSERT_NE(setStarsResultFunc, nullptr);
        for (uint32_t errorIndex = 0U; errorIndex < TS_STARS_ERROR_MAX_INDEX; ++errorIndex) {
            SCOPED_TRACE(static_cast<int32_t>(chipType));
            SCOPED_TRACE(errorIndex);
            TaskInfo task = {};
            rtCqReport_t report = {};
            report.errorType = static_cast<uint8_t>(1U << errorIndex);
            report.errorCode = TS_SUCCESS;

            setStarsResultFunc(&task, report);

            EXPECT_EQ(task.errorCode, expectedErrorCodes[errorIndex]);
        }
    }
}

TEST_F(EventTestDavid, TestDavidEventWaitSetStarsResultMapsErrorTypeForTargetChips)
{
    const rtChipType_t chipTypes[] = {CHIP_DAVID, CHIP_CLOUD_V5, CHIP_CLOUD_V6};
    for (const auto chipType : chipTypes) {
        SCOPED_TRACE(static_cast<int32_t>(chipType));
        PfnTaskSetStarsResult setStarsResultFunc =
            g_taskFuncArrays[chipType].setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT];
        ASSERT_NE(setStarsResultFunc, nullptr);

        TaskInfo task = {};
        rtCqReport_t report = {};
        report.errorType = RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT;
        report.errorCode = TS_SUCCESS;

        setStarsResultFunc(&task, report);

        EXPECT_EQ(task.errorCode, TS_ERROR_TASK_TIMEOUT);
    }
}

TEST_F(EventTestDavid, TestDavidEventWaitSetStarsResultPreservesErrorCodeForTargetChips)
{
    const rtChipType_t chipTypes[] = {CHIP_DAVID, CHIP_CLOUD_V5, CHIP_CLOUD_V6};
    for (const auto chipType : chipTypes) {
        SCOPED_TRACE(static_cast<int32_t>(chipType));
        PfnTaskSetStarsResult setStarsResultFunc =
            g_taskFuncArrays[chipType].setStarsResultFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT];
        ASSERT_NE(setStarsResultFunc, nullptr);

        TaskInfo task = {};
        rtCqReport_t report = {};
        report.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
        report.errorCode = TS_ERROR_END_OF_SEQUENCE;

        setStarsResultFunc(&task, report);

        EXPECT_EQ(task.errorCode, TS_ERROR_END_OF_SEQUENCE);
    }
}

TEST_F(EventTestDavid, TestElapsedTime)
{
    rtError_t error;
    rtEvent_t start;
    rtEvent_t end;
    rtStream_t stream;

    rtEventCreate(&start);
    DavidEvent* startEvt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(start));
    startEvt->SetRecord(false);
    rtEventCreate(&end);
    DavidEvent* endEvt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(end));
    endEvt->SetRecord(false);

    float32_t timeInterval = 123.0F;
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);

    startEvt->SetRecord(true);
    endEvt->SetRecord(false);
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);

    endEvt->SetRecord(true);
    EXPECT_EQ(startEvt->TimeStamp(), UINT64_MAX);
    EXPECT_EQ(endEvt->TimeStamp(), UINT64_MAX);
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);
    EXPECT_FLOAT_EQ(timeInterval, 123.0F);

    startEvt->SetTimeStamp(10240000);
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);
    EXPECT_FLOAT_EQ(timeInterval, 123.0F);

    startEvt->SetTimeStamp(UINT64_MAX);
    endEvt->SetTimeStamp(20480000);
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);
    EXPECT_FLOAT_EQ(timeInterval, 123.0F);

    startEvt->SetTimeStamp(10240000);
    error = endEvt->ElapsedTime(&timeInterval, startEvt);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_FLOAT_EQ(timeInterval, 10.24F);

    error = rtEventDestroy(start);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(end);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestElapsedTimeCrossBackend)
{
    rtError_t error;
    rtEvent_t end;
    float32_t timeInterval = 0;
    Event startEvt;

    rtEventCreate(&end);
    DavidEvent* endEvt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(end));
    endEvt->SetRecord(true);
    endEvt->SetTimeStamp(20480000);

    error = endEvt->ElapsedTime(&timeInterval, &startEvt);
    EXPECT_EQ(error, RT_ERROR_EVENT_BASE);

    error = rtEventDestroy(end);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestGetTimeStamp)
{
    rtError_t error;
    rtEvent_t event = nullptr;

    ASSERT_EQ(rtEventCreate(&event), ACL_RT_SUCCESS);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);
    uint64_t recTimestamp = 123U;
    evt->SetRecord(false);

    error = evt->GetTimeStamp(&recTimestamp);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);
    EXPECT_EQ(recTimestamp, 123U);

    const DavidRecordTaskInfo recordInfo = {stream_->Id_(), 1U, 0U};
    evt->UpdateLatestRecord(recordInfo, DavidEventState_t::EVT_NOT_RECORDED, UINT64_MAX);
    error = evt->GetTimeStamp(&recTimestamp);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);
    EXPECT_EQ(recTimestamp, 123U);
    EXPECT_EQ(evt->GetRecordStatus(), DavidEventState_t::EVT_NOT_RECORDED);

    evt->UpdateLatestRecord(recordInfo, DavidEventState_t::EVT_RECORDED, 2000U);
    error = evt->GetTimeStamp(&recTimestamp);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(recTimestamp, 2U);
    EXPECT_EQ(evt->GetRecordStatus(), DavidEventState_t::EVT_RECORDED);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestResetTaskUnInit)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
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
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
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
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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

TEST_F(EventTestDavid, SynchronizeExternalStatusReturnsSuccessWhenDeviceValueIsOne)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 1U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetEventAddr(&recordValue);

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    EXPECT_EQ(evt->Synchronize(1), RT_ERROR_NONE);
    EXPECT_FALSE(evt->isEventSyncTimeout_);

    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, SynchronizeCompletedExternalStatusSkipsDeviceQuery)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetEventSyncTimeoutFlag(true);
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    EXPECT_EQ(evt->Synchronize(1), RT_ERROR_NONE);
    EXPECT_FALSE(evt->isEventSyncTimeout_);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, SynchronizeExternalTimelineWaitsUntilTimestampIsReady)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 1U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetTimeStamp(UINT64_MAX);
    evt->SetEventAddr(&recordValue);

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    EXPECT_EQ(evt->Synchronize(1), RT_ERROR_EVENT_SYNC_TIMEOUT);
    EXPECT_TRUE(evt->isEventSyncTimeout_);

    evt->SetTimeStamp(10U);
    EXPECT_EQ(evt->Synchronize(1), RT_ERROR_NONE);
    EXPECT_FALSE(evt->isEventSyncTimeout_);

    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, SynchronizeExternalStatusCompletesAfterRepeatedPolling)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 0U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetEventAddr(&recordValue);

    g_externalEventStatus = &recordValue;
    g_externalEventQueryTimes = 0U;
    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar)
        .expects(exactly(EXTERNAL_EVENT_COMPLETE_QUERY_TIMES))
        .will(invoke(CompleteExternalEventAfterRepeatedQueries));

    EXPECT_EQ(evt->Synchronize(-1), RT_ERROR_NONE);
    EXPECT_EQ(g_externalEventQueryTimes, EXTERNAL_EVENT_COMPLETE_QUERY_TIMES);

    g_externalEventStatus = nullptr;
    g_externalEventQueryTimes = 0U;
    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, SynchronizeExternalStatusChecksTimeoutDuringRepeatedPolling)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 0U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetEventAddr(&recordValue);

    g_externalEventClockTimes = 0U;
    MOCKER(clock_gettime).stubs().will(invoke(ExternalEventTimeoutClockStub));
    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar)
        .expects(exactly(5000))
        .will(returnValue(true));

    EXPECT_EQ(evt->Synchronize(1), RT_ERROR_EVENT_SYNC_TIMEOUT);
    EXPECT_TRUE(evt->isEventSyncTimeout_);

    g_externalEventClockTimes = 0U;
    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, SynchronizeExternalStatusReturnsWhenRecordCompletes)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 0U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetEventAddr(&recordValue);
    g_externalSyncDavidEvent = evt;

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar)
        .expects(once())
        .will(invoke(CompleteDavidRecordAfterQuery));

    EXPECT_EQ(evt->Synchronize(-1), RT_ERROR_NONE);

    g_externalSyncDavidEvent = nullptr;
    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, TestQueryEventStatus)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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

TEST_F(EventTestDavid, QueryExternalStatusReturnsRecordedWhenDeviceValueIsOne)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 1U;
    evt->SetRecord(true);
    evt->latestRecord_.state = RECORDING;
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetLatestRecordInfo(0U, stream_->Id_());
    evt->SetEventAddr(&recordValue);

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    rtEventStatus_t status = RT_EVENT_INIT;
    EXPECT_EQ(evt->QueryEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, QueryExternalStatusWithoutRecordReturnsInitInOldMode)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);

    rtEventStatus_t status = RT_EVENT_RECORDED;
    EXPECT_EQ(evt->QueryEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_INIT);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, QueryExternalStatusChecksTimestampForDavidTimeline)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 1U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetLatestRecordInfo(0U, stream_->Id_());
    evt->SetTimeStamp(UINT64_MAX);
    evt->SetEventAddr(&recordValue);

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());
    rtEventStatus_t status = RT_EVENT_INIT;
    EXPECT_EQ(evt->QueryEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_INIT);

    evt->SetTimeStamp(10U);
    status = RT_EVENT_INIT;
    EXPECT_EQ(evt->QueryEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, QueryExternalStatusIgnoresInvalidDeviceValueError)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 2U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetRecordFlag(RT_EVENT_RECORD_EXTERNAL);
    evt->SetLatestRecordInfo(0U, stream_->Id_());
    evt->SetEventAddr(&recordValue);

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    rtEventStatus_t status = RT_EVENT_INIT;
    EXPECT_EQ(evt->QueryEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_INIT);

    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, EventQueryStatusUsesExternalStatusWhenWaitFlagIsExternal)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);

    uint8_t recordValue = 1U;
    evt->SetRecord(true);
    evt->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    evt->SetWaitFlag(RT_EVENT_WAIT_EXTERNAL);
    evt->SetLatestRecordInfo(0U, stream_->Id_());
    evt->SetEventAddr(&recordValue);

    MOCKER_CPP_VIRTUAL(evt->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(evt->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    rtEventStatus_t status = RT_EVENT_INIT;
    EXPECT_EQ(evt->QueryEventTask(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    evt->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(EventTestDavid, TestQueryEventTask)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
    std::shared_ptr<Stream> stmSharedPtr = stm->GetSharedPtr();

    rtEventStatus_t status1 = RT_EVENT_RECORDED;
    MOCKER_CPP(&StreamSqCqManage::GetStreamSharedPtrById)
        .stubs()
        .with(mockcpp::any(), outBound(stmSharedPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stm, &Stream::JudgeHeadTailPos)
        .stubs()
        .with(outBoundP(&status1, sizeof(status1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(TaskReclaimByStream).stubs().will(returnValue(RT_ERROR_NONE));

    evt->timestamp_ = UINT64_MAX;
    error = evt->QueryEventTask(&status);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_INIT);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    std::weak_ptr<Stream> streamLifetime = stmSharedPtr;
    // Release the mock's shared ownership before fixture teardown releases the device.
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), ACL_RT_SUCCESS);
    stmSharedPtr.reset();
    EXPECT_TRUE(streamLifetime.expired());
}

TEST_F(EventTestDavid, TestQueryEventWaitStatus)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    bool waitFlag = false;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

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
    Event* evt = NULL;
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
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
    Device* dev = stm->Device_();
    MOCKER(DavidEventRecordTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    error = ProcStreamRecordTask(stm, 0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, TestRecordCompletePolymorphism)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    TaskInfo taskInfo = {0};
    taskInfo.stream = stm;
    taskInfo.id = 0;
    taskInfo.type = TS_TASK_TYPE_EVENT_RECORD;

    const DavidRecordTaskInfo latestRecord = {stm->Id_(), static_cast<uint32_t>(taskInfo.id), 2U};
    evt->UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_NOT_RECORDED, UINT64_MAX);

    Event* const baseEvent = evt;
    baseEvent->RecordComplete(&taskInfo, 0ULL, UINT64_MAX, 1U);
    EXPECT_EQ(evt->status_, DavidEventState_t::EVT_NOT_RECORDED);
    baseEvent->RecordComplete(&taskInfo, 0ULL, UINT64_MAX, 2U);
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
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);

    MOCKER(TryToFreeEventIdAndDestroyEvent).stubs();
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
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventRecordTaskInit(&task, evt, evt->EventId_());
    evt->InsertRecordResetToMap(&task);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_RECORD);
    Event* evtTmp = (Event*)evt;
    evt->SetIsNeedDestroy(true);
    DavidUpdateAndTryToDestroyEvent(&task, &evtTmp, DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);
}

TEST_F(EventTestDavid, TestDavidUpdateAndTryToDestroyEvent1)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    uint32_t value = 0U;
    void* addr = &value;
    rtDavidSqe_t sqe = {};
    DavidEvent* evt = new (std::nothrow) DavidEvent(device_, 0x1, nullptr, false);
    DavidEventWaitTaskInit(&task, evt, evt->EventId_(), 1000);
    evt->InsertWaitToMap(&task);
    EXPECT_EQ(task.type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    Event* evtTmp = (Event*)evt;
    evt->SetIsNeedDestroy(true);
    DavidUpdateAndTryToDestroyEvent(&task, &evtTmp, DavidTaskMapType::TASK_MAP_TYPE_WAIT_MAP);
}

TEST_F(EventTestDavid, HardwareAndSoftwareDestroyUseIsolatedOwnership)
{
    TaskInfo hardwareTask = {};
    InitByStream(&hardwareTask, stream_);
    DavidEvent hardwareEvent(device_, RT_EVENT_DEFAULT, nullptr, false);
    ASSERT_EQ(DavidEventRecordTaskInit(&hardwareTask, &hardwareEvent, hardwareEvent.EventId_()), RT_ERROR_NONE);
    hardwareEvent.InsertRecordResetToMap(&hardwareTask);
    hardwareEvent.idMap_[7] = 1U;

    EXPECT_FALSE(hardwareEvent.TryFreeEventIdAndCheckCanBeDelete(hardwareEvent.EventId_(), true));
    EXPECT_TRUE(hardwareEvent.DavidUpdateRecordMapAndDestroyEvent(&hardwareTask));
    hardwareEvent.idMap_.clear();

    DavidEvent softwareEvent(device_, RT_EVENT_DEFAULT, nullptr, false);
    softwareEvent.SoftwareModeEnable();
    softwareEvent.EventIdCountAdd(7);
    softwareEvent.InsertRecordResetToMap(&hardwareTask);
    EXPECT_FALSE(softwareEvent.TryFreeEventIdAndCheckCanBeDelete(7, true));
    EXPECT_TRUE(softwareEvent.TryFreeEventIdAndCheckCanBeDelete(7, false));
    EXPECT_FALSE(softwareEvent.IsEventTaskEmpty());
    softwareEvent.DeleteRecordResetFromMap(&hardwareTask);
}

TEST_F(EventTestDavid, event_recordnull)
{
    rtError_t error;
    error = EvtRecordSoftwareMode(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(EventTestDavid, event_waitnull)
{
    rtError_t error;
    error = EvtWaitSoftwareMode(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(EventTestDavid, event_resetnull)
{
    rtError_t error;
    error = EvtResetSoftwareMode(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(EventTestDavid, GetCaptureEvent1)
{
    rtEvent_t event;
    rtStream_t stream;
    rtStream_t captureStream;
    ApiImplDavid apiImpl;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    evt->SoftwareModeEnable();
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    rtStreamCreate(&captureStream, 0);
    Stream* stmCapture = rt_ut::UnwrapOrNull<Stream>(captureStream);
    stm->UpdateCaptureStream(stmCapture);
    stm->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    CaptureModel* captureModel = new CaptureModel();
    stmCapture->SetModel(static_cast<Model*>(captureModel));
    captureModel->context_ = stm->Context_();

    Event* curEvent = evt->GetCaptureEvent();

    rtError_t error = apiImpl.GetCaptureEvent(stm, evt, &curEvent);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(RT_ERROR_INVALID_VALUE), mockcpp::any(), mockcpp::any())
        .will(returnValue(static_cast<TaskInfo*>(nullptr)));
    error = apiImpl.CaptureRecordEvent(stm->Context_(), evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiImpl.CaptureWaitEvent(stm->Context_(), stm, evt, 0U);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiImpl.CaptureResetEvent(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    stmCapture->SetModel(nullptr);
    stm->UpdateCaptureStream(nullptr);
    stm->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
    rtStreamDestroy(captureStream);
    rtStreamDestroy(stream);
    delete captureModel;
    EXPECT_EQ(evt->GetCaptureEvent(), nullptr);
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, GetCaptureEvent2)
{
    rtEvent_t event;
    rtStream_t stream;
    ApiImplDavid apiImpl;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
    Event* curEvent = evt->GetCaptureEvent();

    rtError_t error = apiImpl.GetCaptureEvent(stm, evt, &curEvent);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
    delete curEvent;
}

TEST_F(EventTestDavid, GetCaptureEvent3)
{
    rtEvent_t event;
    rtStream_t stream;
    rtStream_t captureStream;
    ApiImplDavid apiImpl;

    rtEventCreate(&event);
    Event* evtTmp = rt_ut::UnwrapOrNull<Event>(event);
    DavidEvent* evt = (DavidEvent*)evtTmp;
    evt->SoftwareModeEnable();
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(IsUseHardwareEvent).stubs().will(returnValue(false));

    rtStreamCreate(&captureStream, 0);
    Stream* stmCapture = rt_ut::UnwrapOrNull<Stream>(captureStream);
    stm->UpdateCaptureStream(stmCapture);
    stm->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    CaptureModel captureModel(RT_MODEL_CAPTURE_MODEL);
    stmCapture->SetModel(&captureModel);
    captureModel.context_ = stm->Context_();

    Event* curEvent = evt->GetCaptureEvent();

    rtError_t error = apiImpl.GetCaptureEvent(stm, evt, &curEvent);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(RT_ERROR_INVALID_VALUE), mockcpp::any(), mockcpp::any())
        .will(returnValue(static_cast<TaskInfo*>(nullptr)));
    error = apiImpl.CaptureRecordEvent(stm->Context_(), evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiImpl.CaptureWaitEvent(stm->Context_(), stm, evt, 0U);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiImpl.CaptureResetEvent(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    stmCapture->SetModel(nullptr);
    stm->UpdateCaptureStream(nullptr);
    stm->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
    rtStreamDestroy(captureStream);
    rtStreamDestroy(stream);
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, CaptureResetEvent1)
{
    rtEvent_t event;
    rtStream_t stream;
    ApiImplDavid apiImpl;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    evt->SoftwareModeEnable();
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    rtError_t error = apiImpl.CaptureResetEvent(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, CaptureResetEvent2)
{
    rtEvent_t event;
    rtStream_t stream;
    ApiImplDavid apiImpl;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    rtError_t error = apiImpl.CaptureResetEvent(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtRecordSoftwareMode1)
{
    rtEvent_t event;
    rtStream_t stream;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    evt->SoftwareModeEnable();
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
    TaskInfo task = {};
    task.stream = stm;
    TaskInfo* taskOut = &task;
    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(taskOut));
    MOCKER(DavidSendTask).stubs().will(invoke(CheckRecordOwnerThenFail));

    rtError_t error = EvtRecordSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);
    EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_TRUE(evt->idMap_.empty());
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtRecordSoftwareMode2)
{
    rtError_t error;
    rtEvent_t event;
    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));

    error = EvtRecordSoftwareMode(evt, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtEventDestroy(event);
}

struct SoftwareRecordCase {
    uint32_t flags;
    bool capture;
    bool bound;
    bool error;
    uint32_t sqes;
};
class SoftwareRecordTestDavid : public EventTestDavid, public testing::WithParamInterface<SoftwareRecordCase> {};

TEST_P(SoftwareRecordTestDavid, SqesCqeAndCapturePolicy)
{
    rtStream_t captureHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&captureHandle, 0), RT_ERROR_NONE);
    Stream* const capture = rt_ut::UnwrapOrNull<Stream>(captureHandle);
    ASSERT_NE(capture, nullptr);
    Model model;
    const auto& test = GetParam();
    const uint32_t originalError = stream_->GetErrCode();
    {
        const ScopeGuard restore([&]() {
            stream_->SetErrCode(originalError);
            stream_->SetBindFlag(false);
            stream_->SetModel(nullptr);
            stream_->UpdateCaptureStream(nullptr);
            stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
            capture->SetBindFlag(false);
        });
        SCOPED_TRACE(test.flags);
        SCOPED_TRACE(test.capture);
        SCOPED_TRACE(test.bound);
        SCOPED_TRACE(test.error);
        DavidEvent event(device_, test.flags, nullptr, false);
        event.SoftwareModeEnable();
        stream_->SetBindFlag(test.bound);
        stream_->SetModel(test.bound ? &model : nullptr);
        stream_->UpdateCaptureStream(test.capture ? capture : nullptr);
        stream_->SetCaptureStatus(test.capture ? RT_STREAM_CAPTURE_STATUS_ACTIVE : RT_STREAM_CAPTURE_STATUS_NONE);
        capture->SetBindFlag(test.capture);
        TaskInfo task = {};
        InitByStream(&task, test.capture ? capture : stream_);
        task.sqeNum = static_cast<uint8_t>(test.sqes);
        MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                       &Stream::AllocTask))
            .expects(once())
            .with(
                eq(static_cast<TaskInfo*>(nullptr)), eq(TS_TASK_TYPE_DAVID_EVENT_RECORD), mockcpp::any(), eq(test.sqes),
                mockcpp::any())
            .will(returnValue(&task));
        MOCKER(DavidSendTask).expects(once()).will(returnValue(RT_ERROR_NONE));
        MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
        ASSERT_EQ(EvtRecordSoftwareMode(&event, stream_), RT_ERROR_NONE);
        EXPECT_EQ(task.u.memWriteValueTask.hasTimestamp, test.sqes == 2U ? 1U : 0U);
        EXPECT_EQ(task.stream, test.capture ? capture : stream_);
        EXPECT_EQ(GetSendSqeNum(&task), test.sqes);
        if (!test.capture && !test.bound) {
            ASSERT_EQ(event.idMap_.count(task.u.memWriteValueTask.ownedEventId), 1U);
            rtCqReport_t report = {};
            report.u1.timeStamp = 123U;
            report.errorType = test.error ? RT_STARS_EXIST_ERROR : 0U;
            report.errorCode = test.error ? TS_ERROR_END_OF_SEQUENCE : 0U;
            SetStarsResultForDavidMemWriteValueTask(&task, report);
            EXPECT_EQ(task.errorCode, test.error ? TS_ERROR_END_OF_SEQUENCE : 0U);
            const uint64_t expected = !test.error && test.sqes == 2U ? 123U : UINT64_MAX;
            EXPECT_EQ(task.u.memWriteValueTask.timestamp, expected);
            DoCompleteSuccessForMemWriteValueTask(&task, device_->Id_());
            EXPECT_EQ(event.TimeStamp(), expected);
            if (!test.error) {
                EXPECT_EQ(event.GetRecordStatus(), DavidEventState_t::EVT_RECORDED);
            }
            EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
            EXPECT_TRUE(event.idMap_.empty());
        }
        TaskUnInitProc(&task);
    }
    EXPECT_EQ(rtStreamDestroy(captureHandle), RT_ERROR_NONE);
}

INSTANTIATE_TEST_SUITE_P(
    SoftwareEvents, SoftwareRecordTestDavid,
    testing::Values(
        SoftwareRecordCase{RT_EVENT_TIME_LINE, false, false, false, 2U},
        SoftwareRecordCase{RT_EVENT_TIME_LINE, false, false, true, 2U},
        SoftwareRecordCase{RT_EVENT_WITH_FLAG, false, false, false, 1U},
        SoftwareRecordCase{RT_EVENT_TIME_LINE, true, false, false, 1U},
        SoftwareRecordCase{RT_EVENT_TIME_LINE, false, true, false, 1U}));

TEST_F(EventTestDavid, EvtWaitSoftwareMode2)
{
    rtEvent_t event;
    rtStream_t stream = nullptr;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));

    error = EvtWaitSoftwareMode(evt, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtEventDestroy(event);
}

TEST_F(EventTestDavid, EvtWaitSoftwareMode3)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    error = EvtWaitSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtWaitSoftwareMode4)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    evt->SetEventAddr(nullptr);

    error = EvtWaitSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtWaitSoftwareMode5)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    void* eventAddr = malloc(RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    evt->SetEventAddr(eventAddr);

    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(RT_ERROR_INVALID_VALUE), mockcpp::any(), mockcpp::any())
        .will(returnValue(static_cast<TaskInfo*>(nullptr)));

    error = EvtWaitSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    free(eventAddr);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtWaitSoftwareMode6)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    void* eventAddr = malloc(RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    evt->SetEventAddr(eventAddr);

    TaskInfo task1 = {};
    task1.stream = stm;
    TaskInfo* tmpTask = &task1;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(tmpTask));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    error = EvtWaitSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);

    free(eventAddr);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtWaitSoftwareMode7)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    evt->SoftwareModeEnable();
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    void* eventAddr = malloc(RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    evt->PublishSoftwareRecordResource(eventAddr, 7, stm->Id_(), 0U, 0U);

    TaskInfo task1 = {};
    task1.stream = stm;
    TaskInfo* tmpTask = &task1;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(tmpTask));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    error = EvtWaitSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);
    EXPECT_EQ(task1.u.memWaitValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_TRUE(evt->idMap_.empty());
    evt->SetEventAddr(nullptr);
    evt->SetEventId(INVALID_EVENT_ID);
    free(eventAddr);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtWaitSoftwareMode8)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    evt->SoftwareModeEnable();
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    void* eventAddr = malloc(RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    evt->PublishSoftwareRecordResource(eventAddr, 7, stm->Id_(), 0U, 0U);

    TaskInfo task1 = {};
    task1.stream = stm;
    TaskInfo* tmpTask = &task1;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(tmpTask));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    error = EvtWaitSoftwareMode(evt, stm);
    EXPECT_NE(error, RT_ERROR_NONE);
    EXPECT_EQ(task1.u.memWaitValueTask.ownedEventId, 7);
    EXPECT_EQ(evt->idMap_[7], 1U);
    TaskUnInitProc(&task1);

    EXPECT_TRUE(evt->idMap_.empty());
    evt->SetEventAddr(nullptr);
    evt->SetEventId(INVALID_EVENT_ID);
    free(eventAddr);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EvtResetSoftwareMode1)
{
    rtEvent_t event;
    rtStream_t stream;
    rtError_t error;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    void* eventAddr = malloc(RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    evt->SetEventAddr(eventAddr);

    TaskInfo task1 = {};
    task1.stream = stm;
    TaskInfo* tmpTask = &task1;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(tmpTask));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));

    error = EvtResetSoftwareMode(evt, stm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(eventAddr);
    rtEventDestroy(event);
    rtStreamDestroy(stream);
}

TEST_F(EventTestDavid, EventRecordSoftwareModeDispatchesSoftwareHelper)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);
    evt->SoftwareModeEnable();

    ApiImplDavid apiImpl;
    MOCKER(EvtRecord).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(EvtRecordSoftwareMode).expects(once()).will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(apiImpl.EventRecord(evt, stream_, RT_EVENT_RECORD_DEFAULT), RT_ERROR_NONE);

    rtEventDestroy(event);
}

TEST_F(EventTestDavid, EventResetSoftwareModeDispatchesSoftwareHelper)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);
    evt->SoftwareModeEnable();

    ApiImplDavid apiImpl;
    MOCKER(EvtReset).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(EvtResetSoftwareMode).expects(once()).will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(apiImpl.EventReset(evt, stream_), RT_ERROR_NONE);

    rtEventDestroy(event);
}

TEST_F(EventTestDavid, EventRecordAndResetRejectCrossDevice)
{
    RawDevice eventDevice(1U);
    eventDevice.SetChipType(CHIP_DAVID);
    DavidEvent event(&eventDevice, RT_EVENT_DEFAULT, nullptr, false);
    ApiImplDavid apiImpl;

    EXPECT_EQ(apiImpl.EventRecord(&event, stream_, RT_EVENT_RECORD_DEFAULT), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(apiImpl.EventReset(&event, stream_), RT_ERROR_INVALID_VALUE);
}

TEST_F(EventTestDavid, StreamWaitSoftwareModeAfterResetDispatchesSoftwareHelper)
{
    rtEvent_t event = nullptr;
    uint8_t recordValue = 0U;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    ASSERT_NE(evt, nullptr);
    evt->SoftwareModeEnable();
    evt->SetEventAddr(&recordValue);
    evt->SetEventId(7);
    evt->SetRecord(true);
    evt->SetHasReset(true);

    ApiImplDavid apiImpl;
    MOCKER(EvtWait).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(EvtWaitSoftwareMode).expects(once()).will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(apiImpl.StreamWaitEvent(stream_, evt, 0U, RT_EVENT_WAIT_DEFAULT), RT_ERROR_NONE);

    evt->SetEventAddr(nullptr);
    evt->SetEventId(INVALID_EVENT_ID);
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, CaptureExternalRecordRegistersPlaceholder)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    auto* captureModel = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
    ASSERT_NE(evt, nullptr);
    ASSERT_NE(captureModel, nullptr);
    stream_->UpdateCaptureStream(stream_);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    stream_->SetModel(captureModel);
    captureModel->context_ = stream_->Context_();

    ApiImplDavid apiImpl;
    TaskInfo phTask = {};
    phTask.stream = stream_;
    phTask.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(&phTask));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(apiImpl.CaptureExternalEventRecord(evt, stream_), RT_ERROR_NONE);

    EXPECT_FALSE(evt->IsHardwareMode());
    EXPECT_EQ(phTask.type, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL);
    EXPECT_EQ(phTask.sqeNum, 2U);
    EXPECT_EQ(phTask.u.writeValTask.cqeFlag, TASK_WR_CQE_DEFAULT);
    EXPECT_EQ(captureModel->externalRecordEventItems_.size(), 1U);
    stream_->SetModel(nullptr);
    stream_->UpdateCaptureStream(nullptr);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
    delete captureModel;
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, ExternalRecordCapturePlaceholderKeepsDefaultCqe)
{
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_ALWAYS;
    taskInfo.sqeNum = static_cast<uint8_t>(GetSendDavidSqeNum(&taskInfo));
    rtDavidSqe_t sqes[2] = {};
    const TaskSqeInfo sqeInfo = {0ULL, 0ULL};

    EXPECT_EQ(GetSendDavidSqeNum(&taskInfo), 2U);
    ToConstructSqe(&taskInfo, static_cast<void*>(sqes), sqeInfo);
    EXPECT_EQ(sqes[0].commonSqe.sqeHeader.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqes[0].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(sqes[1].commonSqe.sqeHeader.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqes[1].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);

    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_NEVER;
    ToConstructSqe(&taskInfo, static_cast<void*>(sqes), sqeInfo);
    EXPECT_EQ(sqes[0].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(sqes[1].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_NEVER);
}

TEST_F(EventTestDavid, ExternalRecordMaterializedBuildsWriteValueThenCqePlaceholder)
{
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo.u.writeValTask.sqeAddr = 0x1000ULL;
    taskInfo.u.writeValTask.ptrFlag = 1U;
    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_NEVER;
    rtDavidSqe_t sqes[2] = {};
    const TaskSqeInfo sqeInfo = {0ULL, 0ULL};

    EXPECT_EQ(GetSendDavidSqeNum(&taskInfo), 2U);
    ToConstructSqe(&taskInfo, static_cast<void*>(sqes), sqeInfo);
    EXPECT_EQ(sqes[0].commonSqe.sqeHeader.type, RT_DAVID_SQE_TYPE_WRITE_VALUE);
    EXPECT_EQ(sqes[0].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(sqes[1].commonSqe.sqeHeader.type, RT_DAVID_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqes[1].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_NEVER);

    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_ALWAYS;
    ToConstructSqe(&taskInfo, static_cast<void*>(sqes), sqeInfo);
    EXPECT_EQ(sqes[0].commonSqe.sqeHeader.wrCqe, 0U);
    EXPECT_EQ(sqes[1].commonSqe.sqeHeader.wrCqe, 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
}

TEST_F(EventTestDavid, EventRecordExternalDispatchesThroughApiImpl)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    auto* captureModel = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
    ASSERT_NE(evt, nullptr);
    ASSERT_NE(captureModel, nullptr);
    evt->isNewMode_ = false;
    stream_->UpdateCaptureStream(stream_);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    stream_->SetModel(captureModel);
    captureModel->context_ = stream_->Context_();

    ApiImplDavid apiImpl;
    TaskInfo phTask = {};
    phTask.stream = stream_;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(&phTask));
    MOCKER(CheckCaptureModelSupportExternalEvent)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(apiImpl.EventRecord(evt, stream_, RT_EVENT_RECORD_EXTERNAL), RT_ERROR_NONE);

    EXPECT_EQ(apiImpl.EventRecord(evt, stream_, RT_EVENT_RECORD_EXTERNAL), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel->externalRecordEventItems_.size(), 1U);
    stream_->SetModel(nullptr);
    stream_->UpdateCaptureStream(nullptr);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
    delete captureModel;
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, CaptureExternalWaitRegistersPlaceholder)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    auto* captureModel = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
    ASSERT_NE(evt, nullptr);
    ASSERT_NE(captureModel, nullptr);
    stream_->UpdateCaptureStream(stream_);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    stream_->SetModel(captureModel);
    captureModel->context_ = stream_->Context_();

    ApiImplDavid apiImpl;
    TaskInfo phTask = {};
    phTask.stream = stream_;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(&phTask));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(apiImpl.CaptureExternalEventWait(evt, stream_), RT_ERROR_NONE);

    EXPECT_FALSE(evt->IsHardwareMode());
    EXPECT_EQ(captureModel->externalWaitEventItems_.size(), 1U);
    stream_->SetModel(nullptr);
    stream_->UpdateCaptureStream(nullptr);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
    delete captureModel;
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, StreamWaitExternalDispatchesThroughApiImpl)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    auto* captureModel = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
    ASSERT_NE(evt, nullptr);
    ASSERT_NE(captureModel, nullptr);
    evt->isNewMode_ = false;
    stream_->UpdateCaptureStream(stream_);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    stream_->SetModel(captureModel);
    captureModel->context_ = stream_->Context_();

    ApiImplDavid apiImpl;
    TaskInfo phTask = {};
    phTask.stream = stream_;
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .stubs()
        .will(returnValue(&phTask));
    MOCKER(CheckCaptureModelSupportExternalEvent)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(apiImpl.StreamWaitEvent(stream_, evt, 0U, RT_EVENT_WAIT_EXTERNAL), RT_ERROR_NONE);

    EXPECT_EQ(apiImpl.StreamWaitEvent(stream_, evt, 0U, RT_EVENT_WAIT_EXTERNAL), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(captureModel->externalWaitEventItems_.size(), 1U);
    stream_->SetModel(nullptr);
    stream_->UpdateCaptureStream(nullptr);
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
    delete captureModel;
    rtEventDestroy(event);
}

TEST_F(EventTestDavid, TestEventSynchronizeWithEventInModel)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtModel_t model;

    rtEventCreate(&event);
    DavidEvent* evt = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(event));
    rtStreamCreate(&stream, 0);
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);

    const DavidRecordTaskInfo latestRecord = {stm->Id_(), 0U, 0U};
    evt->UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_RECORDED, UINT64_MAX);

    std::shared_ptr<Stream> stmSharedPtr(stm, [](Stream*) {});
    MOCKER_CPP(&StreamSqCqManage::GetStreamSharedPtrById)
        .stubs()
        .with(mockcpp::any(), outBound(stmSharedPtr))
        .will(returnValue(RT_ERROR_NONE));

    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqTail).stubs().will(returnValue(1));
    stm->flags_ = stm->flags_ | RT_STREAM_PERSISTENT;

    error = rtModelCreate(&model, 0);
    error = rtModelBindStream(model, stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtModelUnbindStream(model, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    TaskResManageDavid* taskResMang =
        ((TaskResManageDavid*)(static_cast<Stream*>(device_->PrimaryStream_())->taskResMang_));
    taskResMang->ResetTaskRes();
    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    GlobalMockObject::verify();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTestDavid, TestPrintErrorInfoForDavidEventWaitTaskWithAicpuTimeout)
{
    TaskInfo taskInfo = {};
    InitByStream(&taskInfo, stream_);
    taskInfo.errorCode = TS_ERROR_AICPU_TIMEOUT;
    taskInfo.type = TS_TASK_TYPE_DAVID_EVENT_WAIT;
    taskInfo.typeName = "EVENT_WAIT";
    taskInfo.id = 1;
    taskInfo.flipNum = 0;
    PrintErrorInfoForDavidEventWaitTask(&taskInfo, 0);
}

void ClearLastDlogRecordLine();
bool DlogRecordContains(const std::string& keyword);

TEST_F(EventTestDavid, EventStateLog_PreservesQueryResultAndRecordedStatus)
{
    rtEvent_t handle = nullptr;
    ASSERT_EQ(rtEventCreate(&handle), RT_ERROR_NONE);
    DavidEvent* const event = static_cast<DavidEvent*>(rt_ut::UnwrapOrNull<Event>(handle));
    ASSERT_NE(event, nullptr);
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    event->SetRecord(true);
    const DavidEventState_t states[] = {
        DavidEventState_t::EVT_NOT_RECORDED, DavidEventState_t::EVT_RECORDED,
        static_cast<DavidEventState_t>(UINT8_MAX)};
    const char* const names[] = {"EVT_NOT_RECORDED", "EVT_RECORDED", "UNKNOWN"};
    for (size_t i = 0U; i < sizeof(states) / sizeof(states[0]); ++i) {
        event->SetRecordStatus(states[i]);
        ClearLastDlogRecordLine();
        const rtError_t expected =
            (states[i] == DavidEventState_t::EVT_NOT_RECORDED) ? RT_ERROR_EVENT_NOT_COMPLETE : RT_ERROR_NONE;
        EXPECT_EQ(event->Query(), expected);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
        EXPECT_TRUE(DlogRecordContains(
            std::string("lateststate=") + names[i] + "(" + std::to_string(static_cast<int32_t>(states[i])) + ")"));
#else
        EXPECT_TRUE(DlogRecordContains("lateststate=" + std::to_string(static_cast<int32_t>(states[i]))));
#endif
        EXPECT_TRUE(DlogRecordContains("result=" + std::to_string(expected)));
    }
    event->SetRecordStatus(DavidEventState_t::EVT_RECORDED);
    rtEventStatus_t status = RT_EVENT_INIT;
    ClearLastDlogRecordLine();
    EXPECT_EQ(event->QueryEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_TRUE(DlogRecordContains("lateststate=EVT_RECORDED(1), status=EVENT_RECORDED(1)"));
#else
    EXPECT_TRUE(DlogRecordContains("lateststate=1, status=1"));
#endif
    event->SetRecord(false);
    event->SetRecordStatus(DavidEventState_t::EVT_NOT_RECORDED);
    EXPECT_EQ(rtEventDestroy(handle), RT_ERROR_NONE);
}
