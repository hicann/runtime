/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "runtime/event.h"
#include "runtime/rt_inner_event.h"
#include "runtime/rt_inner_stream.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "event.hpp"
#include "memcpy_c.hpp"
#include "notify.hpp"
#include "stars.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "common_task.h"
#include "memory_task.h"
#include "rt_unwrap.h"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

namespace {
void EnableSoftwareRecord(Event *event, uint8_t *recordValue, int32_t eventId)
{
    ASSERT_EQ(event->TrySwitchToSoftwareMode(), RT_ERROR_NONE);
    event->SetEventAddr(recordValue);
    event->SetEventId(eventId);
    event->SetRecord(true);
    event->SetHasReset(false);
}

CaptureModel *UnwrapCaptureModel(rtModel_t modelHandle)
{
    Model *modelBase = rt_ut::UnwrapOrNull<Model>(modelHandle);
    return dynamic_cast<CaptureModel *>(modelBase);
}

void CreateRecordedSoftwareEvent(
    rtStream_t &stream, rtEvent_t &event, Stream *&streamObj, Event *&eventObj, uint8_t &recordValue,
    const int32_t eventId)
{
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(streamObj, nullptr);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &recordValue, eventId);
}
} // namespace

class ExternalEventTaskTest910B : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::verify();
        (void)rtSetSocVersion("Ascend910B1");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
        (void)rtSetSocVersion("");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
    }
};

TEST_F(ExternalEventTaskTest910B, ExternalWaitPlaceholderMaterializesMemWaitResourceAtFinalize)
{
    MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);

    Model *modelBase = rt_ut::UnwrapOrNull<Model>(captureMdlHandle);
    Stream *streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(modelBase, nullptr);
    ASSERT_NE(streamObj, nullptr);
    auto *model = dynamic_cast<CaptureModel *>(modelBase);
    ASSERT_NE(model, nullptr);
    Stream *captureStream = streamObj->GetCaptureStream();
    ASSERT_NE(captureStream, nullptr);

    ASSERT_EQ(rtStreamWaitEventWithFlag(stream, event, static_cast<uint32_t>(-1), RT_EVENT_WAIT_EXTERNAL),
        RT_ERROR_NONE);
    ASSERT_EQ(model->externalWaitEventItems_.size(), 1U);
    TaskInfo *waitTask = captureStream->Device_()->GetTaskFactory()->GetTask(captureStream->Id_(),
        static_cast<uint16_t>(model->externalWaitEventItems_[0].taskId));
    ASSERT_NE(waitTask, nullptr);
    EXPECT_EQ(GetSendSqeNum(waitTask), MEM_WAIT_SQE_NUM);
    EXPECT_EQ(waitTask->u.memWaitValueTask.profDisableStatusAddr, 0U);

    rtModel_t modelHandle = nullptr;
    ASSERT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(waitTask->sqeNum, MEM_WAIT_SQE_NUM);
    EXPECT_NE(waitTask->u.memWaitValueTask.profDisableStatusAddr, 0U);

    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalRecordLaunchCommitPublishesSoftwareResource)
{
    MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    rtModel_t modelHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtEventRecordWithFlag(event, stream, RT_EVENT_RECORD_EXTERNAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);

    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    CaptureModel *model = UnwrapCaptureModel(modelHandle);
    ASSERT_NE(eventObj, nullptr);
    ASSERT_NE(model, nullptr);
    ExternalEventRefreshInfo launch;
    ASSERT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_NONE);
    ASSERT_EQ(launch.preparedRecords.size(), 1U);

    model->CommitExternalEventRecords(&launch);

    EXPECT_NE(eventObj->GetEventAddr(), nullptr);
    EXPECT_NE(eventObj->EventId_(), INVALID_EVENT_ID);
    EXPECT_TRUE(eventObj->HasRecord());
    EXPECT_FALSE(eventObj->HasReset());
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalWaitLaunchRetainsRecordedProducerOnly)
{
    MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream = nullptr;
    rtEvent_t recordedEvent = nullptr;
    rtEvent_t resetEvent = nullptr;
    rtModel_t modelHandle = nullptr;
    uint8_t recordValue = 1U;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&recordedEvent, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&resetEvent, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    EnableSoftwareRecord(rt_ut::UnwrapOrNull<Event>(recordedEvent), &recordValue, 7);
    EnableSoftwareRecord(rt_ut::UnwrapOrNull<Event>(resetEvent), &recordValue, 8);
    rt_ut::UnwrapOrNull<Event>(resetEvent)->SetHasReset(true);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamWaitEventWithFlag(stream, recordedEvent, static_cast<uint32_t>(-1), RT_EVENT_WAIT_EXTERNAL),
        RT_ERROR_NONE);
    ASSERT_EQ(rtStreamWaitEventWithFlag(stream, resetEvent, static_cast<uint32_t>(-1), RT_EVENT_WAIT_EXTERNAL),
        RT_ERROR_NONE);
    ASSERT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);

    CaptureModel *model = UnwrapCaptureModel(modelHandle);
    ASSERT_NE(model, nullptr);
    ExternalEventRefreshInfo launch;
    ASSERT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_NONE);
    auto *waitEntries = RtPtrToPtr<uint64_t *>(launch.hostRefresh.get() + model->externalEventSummaryInfo_.waitOffset);
    EXPECT_EQ(waitEntries[0], RtPtrToValue(&recordValue));
    EXPECT_EQ(waitEntries[1], 0U);
    EXPECT_EQ(launch.retainedWaitResources.size(), 1U);
    model->RollbackExternalEventRefreshInfo(&launch);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(recordedEvent), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(resetEvent), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, NormalRecordSoftwareEventUsesMemWriteValueTask)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);

    Stream *streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(streamObj, nullptr);
    ASSERT_NE(eventObj, nullptr);
    ASSERT_EQ(eventObj->TrySwitchToSoftwareMode(), RT_ERROR_NONE);

    ASSERT_EQ(rtEventRecord(event, stream), RT_ERROR_NONE);
    TaskInfo *recordTask = streamObj->Device_()->GetTaskFactory()->GetTask(streamObj->Id_(),
        static_cast<uint16_t>(streamObj->GetLastTaskId()));
    ASSERT_NE(recordTask, nullptr);
    EXPECT_EQ(recordTask->type, TS_TASK_TYPE_MEM_WRITE_VALUE);
    ASSERT_NE(eventObj->GetEventAddr(), nullptr);
    EXPECT_EQ(recordTask->u.memWriteValueTask.value, 1U);
    EXPECT_EQ(recordTask->u.memWriteValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, NormalWaitSoftwareEventUsesMemWaitValueTask)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    uint8_t recordValue = 0U;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);

    Stream *streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(streamObj, nullptr);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &recordValue, 7);

    ASSERT_EQ(rtStreamWaitEvent(stream, event), RT_ERROR_NONE);
    TaskInfo *waitTask = streamObj->Device_()->GetTaskFactory()->GetTask(streamObj->Id_(),
        static_cast<uint16_t>(streamObj->GetLastTaskId()));
    ASSERT_NE(waitTask, nullptr);
    EXPECT_EQ(waitTask->type, TS_TASK_TYPE_MEM_WAIT_VALUE);
    EXPECT_EQ(waitTask->u.memWaitValueTask.devAddr, RtPtrToValue(eventObj->GetEventAddr()));
    EXPECT_EQ(waitTask->u.memWaitValueTask.value, 1U);
    EXPECT_EQ(waitTask->u.memWaitValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, NormalResetSoftwareEventUsesMemWriteValueTask)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    uint8_t recordValue = 1U;
    Stream *streamObj = nullptr;
    Event *eventObj = nullptr;
    ASSERT_NO_FATAL_FAILURE(CreateRecordedSoftwareEvent(stream, event, streamObj, eventObj, recordValue, 7));

    ASSERT_EQ(rtEventReset(event, stream), RT_ERROR_NONE);
    TaskInfo *resetTask = streamObj->Device_()->GetTaskFactory()->GetTask(streamObj->Id_(),
        static_cast<uint16_t>(streamObj->GetLastTaskId()));
    ASSERT_NE(resetTask, nullptr);
    EXPECT_EQ(resetTask->type, TS_TASK_TYPE_MEM_WRITE_VALUE);
    EXPECT_EQ(resetTask->u.memWriteValueTask.value, 0U);
    EXPECT_EQ(resetTask->u.memWriteValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    EXPECT_TRUE(eventObj->HasReset());

    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, NormalWaitSoftwareEventWithoutProducerRejects)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);

    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    ASSERT_EQ(eventObj->TrySwitchToSoftwareMode(), RT_ERROR_NONE);

    EXPECT_NE(rtStreamWaitEvent(stream, event), RT_ERROR_NONE);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, PublishSoftwareRecordResourceLifetime)
{
    rtEvent_t event = nullptr;
    uint8_t oldRecordValue = 1U;
    uint8_t newRecordValue = 1U;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);

    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &oldRecordValue, 7);
    eventObj->EventIdCountAdd(7);

    eventObj->PublishSoftwareRecordResource(&newRecordValue, 8);

    EXPECT_EQ(eventObj->GetEventAddr(), &newRecordValue);
    EXPECT_EQ(eventObj->EventId_(), 8);
    eventObj->EventIdCountSub(7);
    EXPECT_EQ(eventObj->GetEventAddr(), &newRecordValue);
    EXPECT_EQ(eventObj->EventId_(), 8);

    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, PublishSoftwareRecordResourceFreesStaleEvent)
{
    rtEvent_t event = nullptr;
    uint8_t oldRecordValue = 1U;
    uint8_t newRecordValue = 1U;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &oldRecordValue, 7);
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeExpandingPoolEvent)
        .stubs()
        .will(ignoreReturnValue());

    eventObj->PublishSoftwareRecordResource(&newRecordValue, 8);

    EXPECT_EQ(eventObj->GetEventAddr(), &newRecordValue);
    EXPECT_EQ(eventObj->EventId_(), 8);
    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, EventIdCountSubFreesCurrentHardwareId)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    eventObj->SetEventId(9);
    eventObj->isHardwareMode_ = true;
    eventObj->isNewMode_ = true;
    eventObj->isIdAllocFromDrv_ = true;
    eventObj->idMap_[9] = 0U;
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::IsSupportEventPool).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeEventIdFromDrv)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    eventObj->EventIdCountSub(9, true);

    EXPECT_EQ(eventObj->EventId_(), INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, EventBusyAndFreeBranchesUseIdMap)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    eventObj->SetEventId(11);
    eventObj->isIdAllocFromDrv_ = true;
    eventObj->idMap_[11] = 0U;
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeEventIdFromDrv)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_TRUE(eventObj->HasPendingBusyWork());
    EXPECT_FALSE(eventObj->TryFreeEventIdAndCheckCanBeDelete(11, false));
    EXPECT_EQ(eventObj->EventId_(), INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, SoftwareEventWaitFirstReturnsSuccess)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    eventObj->SoftwareModeEnable();
    eventObj->isNewMode_ = true;

    EXPECT_EQ(eventObj->Wait(rt_ut::UnwrapOrNull<Stream>(stream), static_cast<uint32_t>(-1)), RT_ERROR_NONE);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, SoftwareEventWaitSubmitFailureRecyclesTask)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    uint8_t recordValue = 1U;
    Stream *streamObj = nullptr;
    Event *eventObj = nullptr;
    ASSERT_NO_FATAL_FAILURE(CreateRecordedSoftwareEvent(stream, event, streamObj, eventObj, recordValue, 7));
    MOCKER_CPP_VIRTUAL(streamObj->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_NE(eventObj->Wait(streamObj, static_cast<uint32_t>(-1)), RT_ERROR_NONE);

    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, NotifyWaitTakesExternalWaitRetainedOwner)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream *streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Notify notify(0, 0U);
    notify.notifyid_ = 0U;
    std::vector<EventResource> retainedResources;
    retainedResources.push_back({nullptr, 0U, INVALID_EVENT_ID});
    MOCKER_CPP_VIRTUAL(streamObj->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(notify.Wait(streamObj, 0U, true, nullptr, &retainedResources), RT_ERROR_NONE);

    EXPECT_TRUE(retainedResources.empty());
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalRecordRefreshSlotUsesStarsWriteValuePtr)
{
    rtStream_t stream = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    rtModel_t modelHandle = nullptr;
    RtStarsWriteValuePtrDst slot = {};
    const uint64_t eventAddr = 0x123456789ABCU;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    CaptureModel *model = UnwrapCaptureModel(captureMdlHandle);
    ASSERT_NE(model, nullptr);

    EXPECT_EQ(model->FillExternalRecordRefreshSlot(nullptr, eventAddr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(model->FillExternalRecordRefreshSlot(&slot, eventAddr), RT_ERROR_NONE);

    EXPECT_EQ(slot.awcache, 2U);
    EXPECT_EQ(slot.va, 1U);
    EXPECT_EQ(slot.awsize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    EXPECT_EQ(slot.write_addr_low, static_cast<uint32_t>(eventAddr & 0xFFFFFFFFU));
    EXPECT_EQ(slot.write_addr_high, static_cast<uint32_t>((eventAddr >> 32U) & 0x1FFFFU));
    EXPECT_EQ(slot.write_value_part[0], 1U);
    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalRefreshRejectsInvalidLaunchInputs)
{
    rtStream_t stream = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    rtModel_t modelHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    CaptureModel *model = UnwrapCaptureModel(captureMdlHandle);
    ASSERT_NE(model, nullptr);
    ExternalEventRefreshInfo launch;
    uint8_t deviceTable = 0U;
    model->externalEventSummaryInfo_.totalSize = sizeof(deviceTable);

    EXPECT_EQ(model->SubmitExternalEventRefreshInfo(nullptr, &launch), RT_ERROR_STREAM_NULL);
    EXPECT_EQ(model->SubmitExternalEventRefreshInfo(rt_ut::UnwrapOrNull<Stream>(stream), nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(model->SubmitExternalEventRefreshInfo(rt_ut::UnwrapOrNull<Stream>(stream), &launch), RT_ERROR_INVALID_VALUE);
    model->externalEventRefreshDeviceBase_ = &deviceTable;
    EXPECT_EQ(model->SubmitExternalEventRefreshInfo(rt_ut::UnwrapOrNull<Stream>(stream), &launch), RT_ERROR_INVALID_VALUE);

    launch.hostRefresh.reset(new uint8_t[sizeof(deviceTable)](), std::default_delete<uint8_t[]>());
    MOCKER(MemcopyAsync).stubs().will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(model->SubmitExternalEventRefreshInfo(rt_ut::UnwrapOrNull<Stream>(stream), &launch), RT_ERROR_NONE);
    model->externalEventRefreshDeviceBase_ = nullptr;
    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalEventSummaryInfoAllocationFailureResetsState)
{
    auto *model = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
    ASSERT_NE(model, nullptr);
    model->context_ = Runtime::Instance()->CurrentContext();
    ASSERT_NE(model->context_, nullptr);
    model->externalEventSummaryInfo_.totalSize = sizeof(uint64_t);
    MOCKER_CPP_VIRTUAL(model->context_->Device_()->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_NE(model->AllocateExternalRefreshTable(), RT_ERROR_NONE);

    EXPECT_EQ(model->externalEventRefreshDeviceBase_, nullptr);
    EXPECT_EQ(model->externalEventSummaryInfo_.totalSize, 0U);
}

TEST_F(ExternalEventTaskTest910B, ExternalLaunchRollbackAndPrepareRejectInvalidEntries)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    rtModel_t modelHandle = nullptr;
    uint8_t recordValue = 1U;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    CaptureModel *model = UnwrapCaptureModel(captureMdlHandle);
    Event *eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(eventObj, nullptr);
    ExternalEventRefreshInfo launch;
    launch.hostRefresh.reset(new uint8_t[sizeof(uint64_t)](), std::default_delete<uint8_t[]>());

    launch.preparedRecords.push_back({eventObj, RtPtrToValue(&recordValue), 7});
    model->RollbackExternalEventRefreshInfo(&launch);
    launch.preparedRecords.push_back({nullptr, 0U, INVALID_EVENT_ID});
    model->CommitExternalEventRecords(&launch);
    launch.preparedRecords.push_back({eventObj, 0U, INVALID_EVENT_ID});
    model->CommitExternalEventRecords(&launch);
    model->externalRecordEventItems_.push_back({nullptr, 0U, 0U});
    EXPECT_EQ(model->PrepareExternalEventRecords(&launch), RT_ERROR_EVENT_NULL);
    model->externalRecordEventItems_.clear();
    model->externalWaitEventItems_.push_back({nullptr, 0U, 0U});
    EXPECT_EQ(model->PrepareExternalEventWaits(&launch), RT_ERROR_EVENT_NULL);
    model->externalWaitEventItems_.clear();

    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalTaskSqeBuildRejectsInvalidAndSkipsNullBuffer)
{
    rtStream_t stream = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    rtModel_t modelHandle = nullptr;
    TaskInfo taskInfo = {};
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    CaptureModel *model = UnwrapCaptureModel(captureMdlHandle);
    Stream *streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(streamObj, nullptr);

    EXPECT_EQ(model->BuildActualExternalTaskSqe(nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(model->BuildActualExternalTaskSqe(&taskInfo), RT_ERROR_INVALID_VALUE);
    taskInfo.stream = streamObj;
    EXPECT_EQ(model->BuildActualExternalTaskSqe(&taskInfo), RT_ERROR_NONE);
    model->externalRecordEventItems_.push_back({nullptr, streamObj->Id_(), 0U});
    EXPECT_EQ(model->RebuildExternalTaskSqes(), RT_ERROR_INVALID_VALUE);
    model->externalRecordEventItems_.clear();
    model->externalWaitEventItems_.push_back({nullptr, streamObj->Id_(), 0U});
    EXPECT_EQ(model->RebuildExternalTaskSqes(), RT_ERROR_INVALID_VALUE);
    model->externalWaitEventItems_.clear();

    uint8_t sqeBuffer[sizeof(rtStarsSqe_t) * MEM_WAIT_SQE_NUM] = {};
    uint8_t funcCallMem[sizeof(RtStarsExternalWaitFuncCall)] = {};
    uint32_t oldSqeBufferSize = streamObj->sqeBufferSize_;
    uint8_t *oldSqeBuffer = streamObj->sqeBuffer_;
    ASSERT_EQ(CaptureWaitExternalTaskInit(&taskInfo, &sqeBuffer[0]), RT_ERROR_NONE);
    taskInfo.u.memWaitValueTask.funcCallSvmMem2 = funcCallMem;
    taskInfo.u.memWaitValueTask.funCallMemSize2 = sizeof(funcCallMem);
    EXPECT_TRUE(NeedReBuildSqe(&taskInfo));
    streamObj->SetSqeBuffer(sqeBuffer);
    streamObj->SetSqeBufferSize(0U);
    EXPECT_EQ(model->BuildActualExternalTaskSqe(&taskInfo), RT_ERROR_INVALID_VALUE);
    streamObj->SetSqeBufferSize(sizeof(sqeBuffer));
    MOCKER_CPP_VIRTUAL(streamObj->Device_()->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(model->BuildActualExternalTaskSqe(&taskInfo), RT_ERROR_NONE);
    MOCKER(memcpy_s).expects(once()).will(returnValue(EINVAL));
    EXPECT_EQ(model->BuildActualExternalTaskSqe(&taskInfo), RT_ERROR_INVALID_VALUE);
    streamObj->SetSqeBuffer(oldSqeBuffer);
    streamObj->SetSqeBufferSize(oldSqeBufferSize);

    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalPlaceholderBuildFailuresReleaseRefreshTable)
{
    auto *model = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
    ASSERT_NE(model, nullptr);
    uint8_t deviceTable = 0U;
    model->context_ = Runtime::Instance()->CurrentContext();
    model->externalEventRefreshDeviceBase_ = &deviceTable;
    model->externalEventSummaryInfo_.totalSize = sizeof(deviceTable);
    model->externalRecordEventItems_.push_back({nullptr, 0U, 0U});
    MOCKER_CPP_VIRTUAL(model->context_->Device_()->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(CaptureRecordExternalTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    EXPECT_EQ(model->BuildExternalRecordPlaceholders(), RT_ERROR_INVALID_VALUE);

    EXPECT_EQ(model->externalEventRefreshDeviceBase_, nullptr);
    model->externalEventRefreshDeviceBase_ = &deviceTable;
    model->externalEventSummaryInfo_.totalSize = sizeof(deviceTable);
    model->externalWaitEventItems_.push_back({nullptr, 0U, 0U});
    MOCKER(CaptureWaitExternalTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    EXPECT_EQ(model->BuildExternalWaitPlaceholders(), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(model->externalEventRefreshDeviceBase_, nullptr);
}
