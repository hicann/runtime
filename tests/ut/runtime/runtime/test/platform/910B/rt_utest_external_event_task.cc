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
#include "raw_device.hpp"
#include "stars.hpp"
#include "stream.hpp"
#include "stub_task.hpp"
#include "task.hpp"
#include "common_task.h"
#include "event_task.h"
#include "memory_task.h"
#include "notify_task.h"
#include "task_info_v100.h"
#include "rt_unwrap.h"
#include "stars_external_event_cond_isa_helper.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

namespace {
using NothrowNewFunc = void* (*)(size_t, const std::nothrow_t&);

void* NothrowNewFail(size_t size, const std::nothrow_t& tag)
{
    UNUSED(size);
    UNUSED(tag);
    return nullptr;
}

rtError_t CopyNormalEventValue(
    Driver*, void* dst, uint64_t, const void* src, uint64_t size, rtMemcpyKind_t kind, bool, uint32_t)
{
    EXPECT_EQ(size, sizeof(uint8_t));
    EXPECT_EQ(kind, RT_MEMCPY_DEVICE_TO_HOST);
    *static_cast<uint8_t*>(dst) = *static_cast<const uint8_t*>(src);
    return RT_ERROR_NONE;
}

void EnableSoftwareRecord(Event* event, uint8_t* recordValue, int32_t eventId)
{
    ASSERT_EQ(event->TrySwitchToSoftwareMode(), RT_ERROR_NONE);
    event->SetEventAddr(recordValue);
    event->SetEventId(eventId);
    event->SetRecord(true);
    event->SetHasReset(false);
}

CaptureModel* UnwrapCaptureModel(rtModel_t modelHandle)
{
    Model* modelBase = rt_ut::UnwrapOrNull<Model>(modelHandle);
    return dynamic_cast<CaptureModel*>(modelBase);
}

void CreateRecordedSoftwareEvent(
    rtStream_t& stream, rtEvent_t& event, Stream*& streamObj, Event*& eventObj, uint8_t& recordValue,
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
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
    }
};

TEST_F(ExternalEventTaskTest910B, QueryExternalStatusReadsHostWhenPcieBarSupported)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    uint8_t recordValue = 1U;
    eventObj->SetEventAddr(&recordValue);
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(eventObj->Device_()->Driver_(), &Driver::MemCopySync).expects(never());

    rtEventStatus_t status = RT_EVENT_INIT;
    EXPECT_EQ(eventObj->QueryExternalEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);
    eventObj->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, QueryExternalStatusCopiesWhenPcieBarUnsupported)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreate(&event), RT_ERROR_NONE);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    uint8_t recordValue = 1U;
    eventObj->SetEventAddr(&recordValue);
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::IsEventExpandingPoolSupportBar).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(eventObj->Device_()->Driver_(), &Driver::MemCopySync)
        .expects(once())
        .will(invoke(CopyNormalEventValue));

    rtEventStatus_t status = RT_EVENT_INIT;
    EXPECT_EQ(eventObj->QueryExternalEventStatus(&status), RT_ERROR_NONE);
    EXPECT_EQ(status, RT_EVENT_RECORDED);
    eventObj->SetEventAddr(nullptr);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalEventItemsOrderedByTaskKey)
{
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = Runtime::Instance()->CurrentContext();
    Event* const firstEvent = RtValueToPtr<Event*>(0x1000U);
    Event* const secondEvent = RtValueToPtr<Event*>(0x2000U);
    constexpr uint32_t firstStreamId = 1U;
    constexpr uint32_t firstTaskId = 2U;
    constexpr uint32_t secondStreamId = 2U;
    constexpr uint32_t secondTaskId = 1U;
    const auto firstKey = std::make_tuple(firstStreamId, firstTaskId);
    const auto secondKey = std::make_tuple(secondStreamId, secondTaskId);

    ASSERT_EQ(model.AddExternalRecordEvent(secondEvent, secondStreamId, secondTaskId), RT_ERROR_NONE);
    ASSERT_EQ(model.AddExternalRecordEvent(firstEvent, firstStreamId, firstTaskId), RT_ERROR_NONE);
    ASSERT_EQ(model.AddExternalWaitEvent(secondEvent, secondStreamId, secondTaskId), RT_ERROR_NONE);
    ASSERT_EQ(model.AddExternalWaitEvent(firstEvent, firstStreamId, firstTaskId), RT_ERROR_NONE);

    auto recordIter = model.externalRecordEventItems_.cbegin();
    ASSERT_NE(recordIter, model.externalRecordEventItems_.cend());
    EXPECT_EQ(recordIter->first, firstKey);
    EXPECT_EQ(recordIter->second, firstEvent);
    recordIter++;
    ASSERT_NE(recordIter, model.externalRecordEventItems_.cend());
    EXPECT_EQ(recordIter->first, secondKey);
    EXPECT_EQ(recordIter->second, secondEvent);

    auto waitIter = model.externalWaitEventItems_.cbegin();
    ASSERT_NE(waitIter, model.externalWaitEventItems_.cend());
    EXPECT_EQ(waitIter->first, firstKey);
    EXPECT_EQ(waitIter->second, firstEvent);
    waitIter++;
    ASSERT_NE(waitIter, model.externalWaitEventItems_.cend());
    EXPECT_EQ(waitIter->first, secondKey);
    EXPECT_EQ(waitIter->second, secondEvent);
}

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

    Model* modelBase = rt_ut::UnwrapOrNull<Model>(captureMdlHandle);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(modelBase, nullptr);
    ASSERT_NE(streamObj, nullptr);
    auto* model = dynamic_cast<CaptureModel*>(modelBase);
    ASSERT_NE(model, nullptr);
    Stream* captureStream = streamObj->GetCaptureStream();
    ASSERT_NE(captureStream, nullptr);

    ASSERT_EQ(rtStreamWaitEventWithFlag(stream, event, 0U, RT_EVENT_WAIT_EXTERNAL), RT_ERROR_NONE);
    ASSERT_EQ(model->externalWaitEventItems_.size(), 1U);
    const uint32_t waitTaskId = std::get<1>(model->externalWaitEventItems_.begin()->first);
    TaskInfo* waitTask =
        captureStream->Device_()->GetTaskFactory()->GetTask(captureStream->Id_(), static_cast<uint16_t>(waitTaskId));
    ASSERT_NE(waitTask, nullptr);
    EXPECT_EQ(waitTask->type, TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL);
    EXPECT_EQ(GetSendSqeNum(waitTask), MEM_WAIT_V2_SQE_NUM);

    rtModel_t modelHandle = nullptr;
    ASSERT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(waitTask->type, TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL);
    EXPECT_EQ(waitTask->sqeNum, MEM_WAIT_V2_SQE_NUM);
    EXPECT_NE(waitTask->u.memWaitValueTask.profDisableStatusAddr, 0U);
    EXPECT_FALSE(model->devAddrList_.empty());

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

    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    CaptureModel* model = UnwrapCaptureModel(modelHandle);
    ASSERT_NE(eventObj, nullptr);
    ASSERT_NE(model, nullptr);
    ASSERT_EQ(model->externalRecordEventItems_.size(), 1U);
    const auto& recordTaskKey = model->externalRecordEventItems_.begin()->first;
    TaskInfo* const recordTask = model->Context_()->Device_()->GetTaskFactory()->GetTask(
        std::get<0>(recordTaskKey), static_cast<uint16_t>(std::get<1>(recordTaskKey)));
    ASSERT_NE(recordTask, nullptr);
    EXPECT_EQ(recordTask->type, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL);
    EXPECT_EQ(recordTask->sqeNum, 2U);
    EXPECT_EQ(recordTask->u.writeValTask.cqeFlag, TASK_WR_CQE_NEVER);
    EXPECT_EQ(model->GetCurReplayExternalEventsRes(), nullptr);
    ExternalEventRefreshInfo launch;
    ASSERT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_NONE);
    ASSERT_EQ(launch.preparedRecords.size(), 1U);

    CommitExternalEventRecords(&launch);

    EXPECT_NE(eventObj->GetEventAddr(), nullptr);
    EXPECT_NE(eventObj->EventId_(), INVALID_EVENT_ID);
    EXPECT_EQ(launch.retainedEventResources.size(), 1U);
    EXPECT_EQ(eventObj->idMap_[eventObj->EventId_()], 1U);
    EXPECT_TRUE(eventObj->HasRecord());
    EXPECT_FALSE(eventObj->HasReset());
    RollbackExternalEventRefreshInfo(&launch);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalRecordPrepareFailureReleasesAllocatedResource)
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
    CaptureModel* const model = UnwrapCaptureModel(modelHandle);
    Event* const eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(eventObj, nullptr);
    uint8_t recordValue = 0U;
    void* recordAddr = &recordValue;
    int32_t eventId = 7;
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::AllocExpandingPoolEvent)
        .expects(once())
        .with(outBoundP(&recordAddr, sizeof(recordAddr)), outBoundP(&eventId, sizeof(eventId)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeExpandingPoolEvent).expects(once()).with(eq(eventId));
    MOCKER(FillExternalRecordRefreshEntry).expects(once()).will(returnValue(RT_ERROR_INVALID_VALUE));

    ExternalEventRefreshInfo launch;
    EXPECT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_INVALID_VALUE);
    EXPECT_TRUE(launch.preparedRecords.empty());
    EXPECT_EQ(launch.hostRefresh, nullptr);

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
    ASSERT_EQ(rtStreamWaitEventWithFlag(stream, recordedEvent, 0U, RT_EVENT_WAIT_EXTERNAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamWaitEventWithFlag(stream, resetEvent, 0U, RT_EVENT_WAIT_EXTERNAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);

    CaptureModel* model = UnwrapCaptureModel(modelHandle);
    ASSERT_NE(model, nullptr);
    ExternalEventRefreshInfo launch;
    ASSERT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_NONE);
    auto* waitEntries = RtPtrToPtr<uint64_t*>(launch.hostRefresh.get() + model->externalEventRefreshLayout_.waitOffset);
    Event* const recordedEventObj = rt_ut::UnwrapOrNull<Event>(recordedEvent);
    Event* const resetEventObj = rt_ut::UnwrapOrNull<Event>(resetEvent);
    const Event* const expectedEvents[] = {recordedEventObj, resetEventObj};
    const uint64_t expectedHostEntries[] = {RtPtrToValue(&recordValue), 0U};
    ASSERT_EQ(model->externalWaitEventItems_.size(), 2U);
    size_t index = 0U;
    for (const auto& item : model->externalWaitEventItems_) {
        EXPECT_EQ(item.second, expectedEvents[index]);
        const uint32_t captureStreamId = std::get<0>(item.first);
        const uint32_t taskId = std::get<1>(item.first);
        TaskInfo* const waitTask =
            model->Context_()->Device_()->GetTaskFactory()->GetTask(captureStreamId, static_cast<uint16_t>(taskId));
        ASSERT_NE(waitTask, nullptr);
        EXPECT_EQ(waitTask->u.memWaitValueTask.event, expectedEvents[index]);
        EXPECT_EQ(
            waitTask->u.memWaitValueTask.devAddr, RtPtrToValue(model->externalEventRefreshDeviceBase_) +
                                                      model->externalEventRefreshLayout_.waitOffset +
                                                      index * EXTERNAL_WAIT_REFRESH_ENTRY_SIZE);
        EXPECT_EQ(waitEntries[index], expectedHostEntries[index]);
        index++;
    }
    EXPECT_EQ(launch.retainedEventResources.size(), 1U);
    RollbackExternalEventRefreshInfo(&launch);
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

    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(streamObj, nullptr);
    ASSERT_NE(eventObj, nullptr);
    ASSERT_EQ(eventObj->TrySwitchToSoftwareMode(), RT_ERROR_NONE);

    ASSERT_EQ(rtEventRecord(event, stream), RT_ERROR_NONE);
    TaskInfo* recordTask = streamObj->Device_()->GetTaskFactory()->GetTask(
        streamObj->Id_(), static_cast<uint16_t>(streamObj->GetLastTaskId()));
    ASSERT_NE(recordTask, nullptr);
    EXPECT_EQ(recordTask->type, TS_TASK_TYPE_MEM_WRITE_VALUE);
    ASSERT_NE(eventObj->GetEventAddr(), nullptr);
    EXPECT_EQ(recordTask->u.memWriteValueTask.value, 1U);
    EXPECT_EQ(recordTask->u.memWriteValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    EXPECT_EQ(recordTask->u.memWriteValueTask.ownedEventId, eventObj->EventId_());
    EXPECT_EQ(eventObj->idMap_[eventObj->EventId_()], 1U);

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

    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(streamObj, nullptr);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &recordValue, 7);

    ASSERT_EQ(rtStreamWaitEvent(stream, event), RT_ERROR_NONE);
    TaskInfo* waitTask = streamObj->Device_()->GetTaskFactory()->GetTask(
        streamObj->Id_(), static_cast<uint16_t>(streamObj->GetLastTaskId()));
    ASSERT_NE(waitTask, nullptr);
    EXPECT_EQ(waitTask->type, TS_TASK_TYPE_MEM_WAIT_VALUE);
    EXPECT_EQ(waitTask->u.memWaitValueTask.devAddr, RtPtrToValue(eventObj->GetEventAddr()));
    EXPECT_EQ(waitTask->u.memWaitValueTask.value, 1U);
    EXPECT_EQ(waitTask->u.memWaitValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    EXPECT_EQ(waitTask->u.memWaitValueTask.ownedEventId, 7);
    EXPECT_EQ(eventObj->idMap_[7], 1U);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalWaitUninitReleasesOwnedEventId)
{
    TaskInfo taskInfo = {};
    rtStream_t stream = nullptr;
    Event event(nullptr, 0, nullptr);
    constexpr int32_t ownedEventId = 65537;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    event.device_ = streamObj->Device_();
    event.EventIdCountAdd(ownedEventId);
    event.PublishSoftwareRecordResource(nullptr, ownedEventId, streamObj->Id_(), 0U, 0U);
    InitByStream(&taskInfo, streamObj);
    taskInfo.type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    taskInfo.u.memWaitValueTask.event = &event;
    taskInfo.u.memWaitValueTask.ownedEventId = ownedEventId;
    DoCompleteSuccessForMemWaitValueTask(&taskInfo, streamObj->Device_()->Id_());

    EXPECT_EQ(taskInfo.u.memWaitValueTask.ownedEventId, ownedEventId);
    EXPECT_EQ(event.idMap_[ownedEventId], 1U);
    MemWaitTaskUnInit(&taskInfo);
    EXPECT_EQ(taskInfo.u.memWaitValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_TRUE(event.idMap_.empty());
    event.device_ = nullptr;
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, MemWriteRegistrationReleasesPendingDestroyOnUninit)
{
    rtEvent_t eventHandle = nullptr;
    ASSERT_EQ(rtEventCreate(&eventHandle), RT_ERROR_NONE);
    Event* event = rt_ut::UnwrapOrNull<Event>(eventHandle);
    ASSERT_NE(event, nullptr);
    ASSERT_EQ(event->TrySwitchToSoftwareMode(), RT_ERROR_NONE);
    constexpr int32_t eventId = 41;
    event->PublishSoftwareRecordResource(nullptr, eventId, 0, 0U, 0U);
    event->EventIdCountAdd(eventId);
    Event* owner = event;
    TryToFreeEventIdAndDestroyEvent(&owner, eventId, true);
    ASSERT_EQ(owner, event);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    task.u.memWriteValueTask.event = event;
    task.u.memWriteValueTask.ownedEventId = eventId;
    auto uninit = g_taskFuncArrays[CHIP_910_B_93].taskUnInitFunc[task.type];
    ASSERT_EQ(uninit, &MemWriteTaskUnInit);
    RawDevice* device = static_cast<RawDevice*>(event->Device_());
    DoCompleteSuccess(&task, 0U);
    EXPECT_EQ(event->idMap_[eventId], 1U);
    uninit(&task);
    EXPECT_EQ(task.u.memWriteValueTask.event, nullptr);
    EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_EQ(device->events_.find(event), device->events_.end());
}

TEST_F(ExternalEventTaskTest910B, NormalResetSoftwareEventUsesMemWriteValueTask)
{
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    uint8_t recordValue = 1U;
    Stream* streamObj = nullptr;
    Event* eventObj = nullptr;
    ASSERT_NO_FATAL_FAILURE(CreateRecordedSoftwareEvent(stream, event, streamObj, eventObj, recordValue, 7));

    ASSERT_EQ(rtEventReset(event, stream), RT_ERROR_NONE);
    TaskInfo* resetTask = streamObj->Device_()->GetTaskFactory()->GetTask(
        streamObj->Id_(), static_cast<uint16_t>(streamObj->GetLastTaskId()));
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

    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
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

    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &oldRecordValue, 7);
    eventObj->EventIdCountAdd(7);

    eventObj->PublishSoftwareRecordResource(&newRecordValue, 8, 0, 0U, 0U);

    EXPECT_EQ(eventObj->GetEventAddr(), &newRecordValue);
    EXPECT_EQ(eventObj->EventId_(), 8);
    eventObj->EventIdCountSub(7);
    EXPECT_EQ(eventObj->GetEventAddr(), &newRecordValue);
    EXPECT_EQ(eventObj->EventId_(), 8);

    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, CompleteReleaseFreesOldSoftwareGenerationOnly)
{
    rtEvent_t eventHandle = nullptr;
    uint8_t oldRecordValue = 1U;
    uint8_t currentRecordValue = 1U;
    ASSERT_EQ(rtEventCreateExWithFlag(&eventHandle, RT_EVENT_DEFAULT), RT_ERROR_NONE);
    Event* event = rt_ut::UnwrapOrNull<Event>(eventHandle);
    ASSERT_NE(event, nullptr);
    ASSERT_EQ(event->TrySwitchToSoftwareMode(), RT_ERROR_NONE);
    event->PublishSoftwareRecordResource(&oldRecordValue, 7, 0, 0U, 0U);
    event->EventIdCountAdd(7);
    event->PublishSoftwareRecordResource(&currentRecordValue, 8, 0, 0U, 0U);
    MOCKER_CPP_VIRTUAL(event->Device_(), &Device::FreeExpandingPoolEvent).expects(once()).with(eq(7));
    Event* owner = event;
    TryToFreeEventIdAndDestroyEvent(&owner, 7, false);
    EXPECT_EQ(event->idMap_.find(7), event->idMap_.end());
    EXPECT_EQ(event->GetEventAddr(), &currentRecordValue);
    EXPECT_EQ(event->EventId_(), 8);
    event->SetEventAddr(nullptr);
    event->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(eventHandle), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, PublishSoftwareRecordResourceFreesStaleEvent)
{
    rtEvent_t event = nullptr;
    uint8_t oldRecordValue = 1U;
    uint8_t newRecordValue = 1U;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    EnableSoftwareRecord(eventObj, &oldRecordValue, 7);
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeExpandingPoolEvent).stubs().will(ignoreReturnValue());

    eventObj->PublishSoftwareRecordResource(&newRecordValue, 8, 0, 0U, 0U);

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
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    eventObj->SetEventId(9);
    eventObj->isHardwareMode_ = true;
    eventObj->isNewMode_ = true;
    eventObj->isIdAllocFromDrv_ = true;
    eventObj->idMap_[9] = 0U;
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::IsSupportEventPool).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeEventIdFromDrv).stubs().will(returnValue(RT_ERROR_NONE));

    eventObj->EventIdCountSub(9, true);

    EXPECT_EQ(eventObj->EventId_(), INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, EventBusyAndFreeBranchesUseIdMap)
{
    rtEvent_t event = nullptr;
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DEFAULT), RT_ERROR_NONE);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(eventObj, nullptr);
    eventObj->SetEventId(11);
    eventObj->isIdAllocFromDrv_ = true;
    eventObj->idMap_[11] = 0U;
    MOCKER_CPP_VIRTUAL(eventObj->Device_(), &Device::FreeEventIdFromDrv).stubs().will(returnValue(RT_ERROR_NONE));

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
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
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
    Stream* streamObj = nullptr;
    Event* eventObj = nullptr;
    ASSERT_NO_FATAL_FAILURE(CreateRecordedSoftwareEvent(stream, event, streamObj, eventObj, recordValue, 7));
    MOCKER_CPP_VIRTUAL(streamObj->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_NE(eventObj->Wait(streamObj, static_cast<uint32_t>(-1)), RT_ERROR_NONE);
    EXPECT_TRUE(eventObj->idMap_.empty());

    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, EndGraphNotifyWaitOwnerAllocationFailureKeepsReplayResources)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Notify notify(0, 0U);
    notify.notifyid_ = 0U;
    CaptureModel captureModel;
    captureModel.context_ = streamObj->Context_();
    captureModel.SetSoftwareSqEnable();
    std::vector<EventResource> retainedResources;
    retainedResources.push_back({nullptr, 0U, INVALID_EVENT_ID});
    captureModel.curReplayExternalEventsRes_ = &retainedResources;
    notify.SetEndGraphModel(&captureModel);
    MOCKER(static_cast<NothrowNewFunc>(&operator new)).expects(once()).will(invoke(NothrowNewFail));

    EXPECT_EQ(notify.EndGraphWait(streamObj, 0U), RT_ERROR_MEMORY_ALLOCATION);

    EXPECT_EQ(retainedResources.size(), 1U);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, EndGraphNotifyWaitSubmitFailureReleasesExternalWaitRetainedOwner)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Notify notify(0, 0U);
    notify.notifyid_ = 0U;
    Event event(streamObj->Device_(), RT_EVENT_DEFAULT, nullptr);
    CaptureModel captureModel;
    captureModel.context_ = streamObj->Context_();
    captureModel.SetSoftwareSqEnable();
    uint8_t eventStatus = 1U;
    const int32_t eventId = 7;
    EnableSoftwareRecord(&event, &eventStatus, eventId);
    event.EventIdCountAdd(eventId);
    std::vector<EventResource> retainedResources;
    retainedResources.push_back({&event, reinterpret_cast<uint64_t>(&eventStatus), eventId});
    captureModel.curReplayExternalEventsRes_ = &retainedResources;
    notify.SetEndGraphModel(&captureModel);
    MOCKER_CPP_VIRTUAL(streamObj->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(notify.EndGraphWait(streamObj, 0U), RT_ERROR_DRV_ERR);

    EXPECT_TRUE(retainedResources.empty());
    EXPECT_EQ(event.idMap_.find(eventId), event.idMap_.end());
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
    CaptureModel* model = UnwrapCaptureModel(captureMdlHandle);
    ASSERT_NE(model, nullptr);

    EXPECT_EQ(FillExternalRecordRefreshEntry(nullptr, eventAddr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(FillExternalRecordRefreshEntry(&slot, eventAddr), RT_ERROR_NONE);

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
    CaptureModel* model = UnwrapCaptureModel(captureMdlHandle);
    ASSERT_NE(model, nullptr);
    ExternalEventRefreshInfo launch;
    uint8_t deviceTable = 0U;
    model->externalEventRefreshLayout_.totalSize = sizeof(deviceTable);

    EXPECT_EQ(
        SubmitExternalEventRefreshInfo(nullptr, &launch, nullptr, sizeof(deviceTable), model->Id_()),
        RT_ERROR_STREAM_NULL);
    EXPECT_EQ(
        SubmitExternalEventRefreshInfo(
            rt_ut::UnwrapOrNull<Stream>(stream), nullptr, nullptr, sizeof(deviceTable), model->Id_()),
        RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(
        SubmitExternalEventRefreshInfo(
            rt_ut::UnwrapOrNull<Stream>(stream), &launch, nullptr, sizeof(deviceTable), model->Id_()),
        RT_ERROR_INVALID_VALUE);
    model->externalEventRefreshDeviceBase_ = &deviceTable;
    EXPECT_EQ(
        SubmitExternalEventRefreshInfo(
            rt_ut::UnwrapOrNull<Stream>(stream), &launch, model->externalEventRefreshDeviceBase_, sizeof(deviceTable),
            model->Id_()),
        RT_ERROR_INVALID_VALUE);

    launch.hostRefresh.reset(new uint8_t[sizeof(deviceTable)](), std::default_delete<uint8_t[]>());
    MOCKER(MemcopyAsync).stubs().will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(
        SubmitExternalEventRefreshInfo(
            rt_ut::UnwrapOrNull<Stream>(stream), &launch, model->externalEventRefreshDeviceBase_, sizeof(deviceTable),
            model->Id_()),
        RT_ERROR_NONE);
    model->externalEventRefreshDeviceBase_ = nullptr;
    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalEventRefreshLayoutAllocationFailureResetsState)
{
    MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream = nullptr;
    rtEvent_t event = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&event, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    ASSERT_EQ(rtEventRecordWithFlag(event, stream, RT_EVENT_RECORD_EXTERNAL), RT_ERROR_NONE);

    CaptureModel* model = UnwrapCaptureModel(captureMdlHandle);
    ASSERT_NE(model, nullptr);
    MOCKER_CPP_VIRTUAL(model->context_->Device_()->Driver_(), &Driver::DevMemAllocWithBackupFlag)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_NE(model->FinalizeExternalRefreshTable(), RT_ERROR_NONE);

    EXPECT_EQ(model->externalEventRefreshDeviceBase_, nullptr);
    EXPECT_EQ(model->externalEventRefreshLayout_.totalSize, 0U);
    rtModel_t modelHandle = nullptr;
    EXPECT_NE(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
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
    CaptureModel* model = UnwrapCaptureModel(captureMdlHandle);
    Event* eventObj = rt_ut::UnwrapOrNull<Event>(event);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(eventObj, nullptr);
    ExternalEventRefreshInfo launch;
    launch.hostRefresh.reset(new uint8_t[sizeof(uint64_t)](), std::default_delete<uint8_t[]>());

    launch.preparedRecords.push_back({eventObj, RtPtrToValue(&recordValue), 7});
    RollbackExternalEventRefreshInfo(&launch);
    launch.preparedRecords.push_back({nullptr, 0U, INVALID_EVENT_ID});
    CommitExternalEventRecords(&launch);
    launch.preparedRecords.push_back({eventObj, 0U, INVALID_EVENT_ID});
    CommitExternalEventRecords(&launch);
    model->externalEventRefreshLayout_.totalSize = sizeof(uint64_t);
    model->externalEventRefreshHostTemplate_.reset(new uint8_t[sizeof(uint64_t)](), std::default_delete<uint8_t[]>());
    ASSERT_EQ(model->AddExternalRecordEvent(nullptr, 0U, 0U), RT_ERROR_NONE);
    EXPECT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_INVALID_VALUE);
    model->externalRecordEventItems_.clear();
    ASSERT_EQ(model->AddExternalWaitEvent(nullptr, 0U, 0U), RT_ERROR_NONE);
    EXPECT_EQ(model->PrepareExternalEventRefreshInfo(&launch), RT_ERROR_EVENT_NULL);
    model->externalWaitEventItems_.clear();

    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalTaskSqeBuildRejectsInvalidTaskRefs)
{
    rtStream_t stream = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    rtModel_t modelHandle = nullptr;
    TaskInfo taskInfo = {};
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    CaptureModel* model = UnwrapCaptureModel(captureMdlHandle);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(streamObj, nullptr);
    Stream* captureStream = streamObj->GetCaptureStream();
    ASSERT_NE(captureStream, nullptr);

    EXPECT_EQ(UpdateHostSqeBufferByTask(nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(UpdateHostSqeBufferByTask(&taskInfo), RT_ERROR_INVALID_VALUE);
    taskInfo.stream = streamObj;
    EXPECT_EQ(UpdateHostSqeBufferByTask(&taskInfo), RT_ERROR_INVALID_VALUE);
    ASSERT_EQ(model->AddExternalRecordEvent(nullptr, streamObj->Id_(), 0U), RT_ERROR_NONE);
    EXPECT_EQ(model->RebuildAllExternalTaskSqes(), RT_ERROR_INVALID_VALUE);
    model->externalRecordEventItems_.clear();
    ASSERT_EQ(model->AddExternalWaitEvent(nullptr, streamObj->Id_(), 0U), RT_ERROR_NONE);
    EXPECT_EQ(model->RebuildAllExternalTaskSqes(), RT_ERROR_INVALID_VALUE);
    model->externalWaitEventItems_.clear();

    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalTaskSqeBuildSkipsNullBuffer)
{
    rtStream_t stream = nullptr;
    rtModel_t captureMdlHandle = nullptr;
    rtModel_t modelHandle = nullptr;
    TaskInfo taskInfo = {};
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamGetCaptureInfo(stream, nullptr, &captureMdlHandle), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(UnwrapCaptureModel(captureMdlHandle), nullptr);
    ASSERT_NE(streamObj, nullptr);
    Stream* captureStream = streamObj->GetCaptureStream();
    ASSERT_NE(captureStream, nullptr);

    uint8_t sqeBuffer[sizeof(rtStarsSqe_t) * MEM_WAIT_SQE_NUM] = {};
    uint8_t funcCallMem[sizeof(RtStarsExternalWaitFuncCall)] = {};
    uint32_t oldSqeBufferSize = captureStream->sqeBufferSize_;
    uint8_t* oldSqeBuffer = captureStream->sqeBuffer_;
    taskInfo.stream = captureStream;
    ASSERT_EQ(CaptureWaitExternalTaskInit(&taskInfo, nullptr, &sqeBuffer[0]), RT_ERROR_NONE);
    taskInfo.u.memWaitValueTask.funcCallSvmMem2 = funcCallMem;
    taskInfo.u.memWaitValueTask.funCallMemSize2 = sizeof(funcCallMem);
    EXPECT_TRUE(NeedReBuildSqe(&taskInfo));
    captureStream->SetSqeBuffer(sqeBuffer);
    captureStream->SetSqeBufferSize(0U);
    EXPECT_EQ(UpdateHostSqeBufferByTask(&taskInfo), RT_ERROR_INVALID_VALUE);
    captureStream->SetSqeBufferSize(sizeof(sqeBuffer));
    ASSERT_EQ(memset_s(sqeBuffer, sizeof(sqeBuffer), 0x5A, sizeof(sqeBuffer)), EOK);
    MOCKER_CPP_VIRTUAL(captureStream->Device_()->Driver_(), &Driver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    taskInfo.sqeNum = MEM_WAIT_V2_SQE_NUM;
    captureStream->SetSqeBufferSize(sizeof(sqeBuffer));
    EXPECT_EQ(UpdateHostSqeBufferByTask(&taskInfo), RT_ERROR_NONE);
    EXPECT_EQ(GetSendSqeNum(&taskInfo), MEM_WAIT_V2_SQE_NUM);
    const size_t untouchedOffset = sizeof(rtStarsSqe_t) * MEM_WAIT_V2_SQE_NUM;
    for (size_t i = untouchedOffset; i < sizeof(sqeBuffer); ++i) {
        EXPECT_EQ(sqeBuffer[i], 0x5A);
    }
    MOCKER(memcpy_s).expects(once()).will(returnValue(EINVAL));
    EXPECT_EQ(UpdateHostSqeBufferByTask(&taskInfo), RT_ERROR_INVALID_VALUE);
    captureStream->SetSqeBuffer(oldSqeBuffer);
    captureStream->SetSqeBufferSize(oldSqeBufferSize);

    EXPECT_EQ(rtStreamEndCapture(stream, &modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalWaitPlaceholderSqeSkipsFuncCallCopy)
{
    rtStream_t stream = nullptr;
    TaskInfo taskInfo = {};
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    taskInfo.stream = streamObj;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL;
    taskInfo.typeName = "CAPTURE_WAIT_EXTERNAL";
    taskInfo.sqeNum = static_cast<uint8_t>(GetSendSqeNum(&taskInfo));
    rtStarsSqe_t sqes[MEM_WAIT_V2_SQE_NUM] = {};
    MOCKER_CPP_VIRTUAL(streamObj->Device_()->Driver_(), &Driver::MemCopySync).expects(never());
    ToConstructSqe(&taskInfo, sqes, TaskSqeInfo{0ULL, 0ULL});
    for (uint32_t i = 0U; i < MEM_WAIT_V2_SQE_NUM; ++i) {
        EXPECT_EQ(sqes[i].phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
        EXPECT_EQ(sqes[i].phSqe.task_type, TS_TASK_TYPE_NOP);
    }

    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalRecordCapturePlaceholderKeepsDefaultCqe)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.stream = streamObj;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_ALWAYS;
    taskInfo.sqeNum = static_cast<uint8_t>(GetSendSqeNum(&taskInfo));
    rtStarsSqe_t sqes[2] = {};

    EXPECT_EQ(GetSendSqeNum(&taskInfo), 2U);
    ToConstructSqe(&taskInfo, sqes, TaskSqeInfo{0ULL, 0ULL});
    EXPECT_EQ(sqes[0].phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqes[0].phSqe.wr_cqe, 0U);
    EXPECT_EQ(sqes[1].phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqes[1].phSqe.wr_cqe, 0U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);

    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_NEVER;
    ToConstructSqe(&taskInfo, sqes, TaskSqeInfo{0ULL, 0ULL});
    EXPECT_EQ(sqes[0].phSqe.wr_cqe, 0U);
    EXPECT_EQ(sqes[1].phSqe.wr_cqe, 0U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_NEVER);

    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalRecordMaterializedBuildsWriteValueThenCqePlaceholder)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.stream = streamObj;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo.u.writeValTask.sqeAddr = 0x1000ULL;
    taskInfo.u.writeValTask.ptrFlag = 1U;
    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_NEVER;
    rtStarsSqe_t sqes[2] = {};

    EXPECT_EQ(GetSendSqeNum(&taskInfo), 2U);
    ToConstructSqe(&taskInfo, sqes, TaskSqeInfo{0ULL, 0ULL});
    EXPECT_EQ(sqes[0].writeValuePtrSqe.header.type, RT_STARS_SQE_TYPE_WRITE_VALUE);
    EXPECT_EQ(sqes[0].writeValuePtrSqe.header.wr_cqe, 0U);
    EXPECT_EQ(sqes[1].phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqes[1].phSqe.wr_cqe, 0U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_NEVER);

    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_ALWAYS;
    ToConstructSqe(&taskInfo, sqes, TaskSqeInfo{0ULL, 0ULL});
    EXPECT_EQ(sqes[0].writeValuePtrSqe.header.wr_cqe, 0U);
    EXPECT_EQ(sqes[1].phSqe.wr_cqe, 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);

    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, TimelineCqeDoesNotConsumeNonTimelineUpdateItem)
{
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = Runtime::Instance()->CurrentContext();
    TaskInfo taskInfo = {};
    TaskUpdateInfo updateInfo = {};
    TaskUpdateItem updateItem = {};
    const rtCqReport_t logicCq = {};

    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.updateInfo = &updateInfo;
    updateItem.launchNo = 2U;
    updateItem.u.eventRecordInfo.event = nullptr;
    updateItem.u.eventRecordInfo.expectCqeNo = 0U;
    updateInfo.updateQueue.push(updateItem);

    model.ProcessExternalRecordNormalCqe(&taskInfo, logicCq);

    EXPECT_EQ(taskInfo.u.writeValTask.recvCqeNo, 0U);
    EXPECT_EQ(updateInfo.updateQueue.size(), 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.event, nullptr);
    EXPECT_EQ(model.updateInfo_.totalRecvCqeCnt.Value(), 0U);
}

TEST_F(ExternalEventTaskTest910B, ExternalRecordUpdateBuildsSqeRefreshAndConsumesTimelineCqe)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    Event oldEvent(nullptr, RT_EVENT_DEFAULT, nullptr);
    Event timelineEvent(nullptr, RT_EVENT_TIME_LINE, nullptr);
    Event waitEvent(nullptr, RT_EVENT_DEFAULT, nullptr);
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = Runtime::Instance()->CurrentContext();

    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    taskInfo.stream = streamObj;
    taskInfo.id = 7U;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.sqeNum = static_cast<uint8_t>(GetSendSqeNum(&taskInfo));
    taskInfo.updateInfo = &taskUpdate;
    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_NEVER;
    taskUpdate.latestParams.u.eventRecordUpdateParams.event = &timelineEvent;

    const uint32_t streamId = static_cast<uint32_t>(streamObj->Id_());
    ASSERT_EQ(model.AddExternalRecordEvent(&oldEvent, streamId, taskInfo.id), RT_ERROR_NONE);
    ASSERT_EQ(model.AddExternalWaitEvent(&waitEvent, streamId, taskInfo.id + 1U), RT_ERROR_NONE);
    model.InsertGraphUpdateTask(&taskInfo);

    uint32_t updateSqeNum = 0U;
    ASSERT_EQ(model.UpdateExternalRecordEventItems(updateSqeNum), RT_ERROR_NONE);
    EXPECT_EQ(updateSqeNum, GetSendSqeNum(&taskInfo));
    EXPECT_EQ(model.externalRecordEventItems_.begin()->second, &timelineEvent);
    EXPECT_TRUE(model.updateInfo_.updateTask.empty());
    EXPECT_EQ(model.updateInfo_.curApplyUpdateTask.count(&taskInfo), 1U);

    rtStarsSqe_t hostUpdateSqes[2] = {};
    std::vector<void*> dsts;
    std::vector<void*> srcs;
    std::vector<size_t> sizes;
    uint16_t count = 0U;
    MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
    MOCKER(UpdateHostSqeBufferAndCopySqeByTask).expects(once()).will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(
        model.PrepareExternalRecordTaskUpdateInfo(hostUpdateSqes, sizeof(hostUpdateSqes), dsts, srcs, sizes, count),
        RT_ERROR_NONE);
    ASSERT_EQ(count, 1U);
    ASSERT_EQ(dsts.size(), 1U);
    ASSERT_EQ(srcs.size(), 1U);
    ASSERT_EQ(sizes.size(), 1U);
    EXPECT_EQ(srcs[0], hostUpdateSqes);
    EXPECT_EQ(sizes[0], sizeof(hostUpdateSqes));
    EXPECT_EQ(taskInfo.u.writeValTask.expectCqeCnt, 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
    EXPECT_EQ(streamObj->GetCqePendingCnt(), 1U);
    ASSERT_EQ(taskUpdate.updateQueue.size(), 1U);

    uint8_t eventValue = 0U;
    timelineEvent.PublishSoftwareRecordResource(&eventValue, 17, streamObj->Id_(), taskInfo.id, 1U);
    rtCqReport_t logicCq = {};
    logicCq.u1.timeStamp = 123U;
    model.ProcessExternalRecordNormalCqe(&taskInfo, logicCq);

    EXPECT_EQ(taskInfo.u.writeValTask.recvCqeNo, 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.event, &timelineEvent);
    EXPECT_TRUE(taskUpdate.updateQueue.empty());
    EXPECT_EQ(model.updateInfo_.totalRecvCqeCnt.Value(), 1U);
    EXPECT_EQ(streamObj->GetCqePendingCnt(), 0U);
    EXPECT_EQ(timelineEvent.TimeStamp(), 123U);

    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, CompletedUpdateItemsStopAtFutureLaunch)
{
    Event firstEvent(nullptr, RT_EVENT_DEFAULT, nullptr);
    Event secondEvent(nullptr, RT_EVENT_DEFAULT, nullptr);
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.updateInfo = &taskUpdate;

    TaskUpdateItem firstItem = {};
    firstItem.launchNo = 1U;
    firstItem.u.eventRecordInfo.event = &firstEvent;
    TaskUpdateItem secondItem = {};
    secondItem.launchNo = 3U;
    secondItem.u.eventRecordInfo.event = &secondEvent;
    taskUpdate.updateQueue.push(firstItem);
    taskUpdate.updateQueue.push(secondItem);

    PopCompletedUpdateItems(nullptr, 1U);
    PopCompletedUpdateItems(&taskInfo, 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.event, &firstEvent);
    ASSERT_EQ(taskUpdate.updateQueue.size(), 1U);
    EXPECT_EQ(taskUpdate.updateQueue.front().launchNo, 3U);

    PopCompletedUpdateItems(&taskInfo, 3U);
    EXPECT_EQ(taskInfo.u.writeValTask.event, &secondEvent);
    EXPECT_TRUE(taskUpdate.updateQueue.empty());

    TaskInfo commonTask = {};
    commonTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    TaskUpdateItemPostProc(&commonTask, firstItem);
}

TEST_F(ExternalEventTaskTest910B, NonTimelineExternalRecordUpdateItemIsNotEnqueuedOnFollowingLaunch)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    Event oldEvent(nullptr, 0U, nullptr);
    Event updatedEvent(nullptr, 0U, nullptr);
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    taskInfo.stream = streamObj;
    taskInfo.id = 1U;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.updateInfo = &taskUpdate;
    taskInfo.u.writeValTask.cqeFlag = TASK_WR_CQE_NEVER;
    taskUpdate.latestParams.u.eventRecordUpdateParams.event = &updatedEvent;

    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = Runtime::Instance()->CurrentContext();
    ASSERT_EQ(
        model.AddExternalRecordEvent(&oldEvent, static_cast<uint32_t>(streamObj->Id_()), taskInfo.id), RT_ERROR_NONE);
    model.InsertGraphUpdateTask(&taskInfo);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));

    ASSERT_EQ(model.PrepareGraphUpdateProc(nullptr), RT_ERROR_NONE);
    ASSERT_EQ(taskUpdate.updateQueue.size(), 1U);
    ASSERT_EQ(model.updateInfo_.curApplyUpdateTask.count(&taskInfo), 1U);

    TaskInfo endGraphTask = {};
    endGraphTask.bindFlag = 1U;
    endGraphTask.u.endGraphNotifyWaitTask.launchNo = 1U;
    endGraphTask.u.endGraphNotifyWaitTask.updateTask = new std::set<TaskInfo*>();
    endGraphTask.u.endGraphNotifyWaitTask.updateTask->swap(model.updateInfo_.curApplyUpdateTask);
    DoCompleteSuccessForEndGraphNotifyWaitTask(&endGraphTask, 0U);
    EXPECT_TRUE(taskUpdate.updateQueue.empty());
    EXPECT_EQ(taskInfo.u.writeValTask.event, &updatedEvent);

    ASSERT_EQ(model.PrepareGraphUpdateProc(nullptr), RT_ERROR_NONE);
    EXPECT_TRUE(model.updateInfo_.curApplyUpdateTask.empty());
    EXPECT_TRUE(taskUpdate.updateQueue.empty());

    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, UpdateHostSqeBufferCopiesEntireExternalRecordTask)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.stream = streamObj;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.sqeNum = static_cast<uint8_t>(GetSendSqeNum(&taskInfo));
    uint8_t hostSqeBuffer[sizeof(rtStarsSqe_t) * 2U] = {};
    rtStarsSqe_t copiedSqes[2] = {};
    uint8_t* const oldSqeBuffer = streamObj->sqeBuffer_;
    const uint32_t oldSqeBufferSize = streamObj->sqeBufferSize_;
    streamObj->SetSqeBuffer(hostSqeBuffer);
    streamObj->SetSqeBufferSize(sizeof(hostSqeBuffer));

    ASSERT_EQ(UpdateHostSqeBufferAndCopySqeByTask(&taskInfo, copiedSqes), RT_ERROR_NONE);
    ASSERT_NE(streamObj->GetHostSqeAddrByPos(taskInfo.pos), nullptr);
    EXPECT_EQ(memcmp(copiedSqes, streamObj->GetHostSqeAddrByPos(taskInfo.pos), sizeof(copiedSqes)), 0);

    streamObj->SetSqeBuffer(oldSqeBuffer);
    streamObj->SetSqeBufferSize(oldSqeBufferSize);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, CacheExternalRecordUpdatePropagatesSoftwareModeFailure)
{
    rtStream_t stream = nullptr;
    rtEvent_t oldEventHandle = nullptr;
    rtEvent_t newEventHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&oldEventHandle, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    ASSERT_EQ(rtEventCreateExWithFlag(&newEventHandle, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    Event* const oldEvent = rt_ut::UnwrapOrNull<Event>(oldEventHandle);
    Event* const newEvent = rt_ut::UnwrapOrNull<Event>(newEventHandle);
    ASSERT_NE(oldEvent, nullptr);
    ASSERT_NE(newEvent, nullptr);
    newEvent->SetRecord(true);

    TaskUpdateInfo updateInfo = {};
    updateInfo.latestParams.type = RT_TASK_VALUE_WRITE;
    TaskInfo taskInfo = {};
    taskInfo.stream = rt_ut::UnwrapOrNull<Stream>(stream);
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.updateInfo = &updateInfo;
    taskInfo.u.writeValTask.event = oldEvent;
    rtTaskParams params = {};
    params.eventRecordTaskParams.event = newEventHandle;
    params.eventRecordTaskParams.eventFlag = static_cast<uint32_t>(newEvent->GetEventFlag());
    params.eventRecordTaskParams.recordFlag = RT_EVENT_RECORD_EXTERNAL;

    EXPECT_EQ(CacheEventRecordTaskParams(&taskInfo, &params), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(updateInfo.latestParams.type, RT_TASK_VALUE_WRITE);
    EXPECT_EQ(newEvent->GetRecordFlag(), UINT32_MAX);

    EXPECT_EQ(rtEventDestroy(newEventHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventDestroy(oldEventHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalPlaceholderBuildFailuresReleaseRefreshTable)
{
    CaptureModel recordModel(RT_MODEL_CAPTURE_MODEL);
    CaptureModel waitModel(RT_MODEL_CAPTURE_MODEL);
    Event event(nullptr, RT_EVENT_DEFAULT, nullptr);
    uint8_t deviceTable = 0U;
    void* deviceTablePtr = &deviceTable;
    recordModel.context_ = Runtime::Instance()->CurrentContext();
    waitModel.context_ = Runtime::Instance()->CurrentContext();
    ASSERT_EQ(recordModel.AddExternalRecordEvent(&event, 0U, 0U), RT_ERROR_NONE);
    ASSERT_EQ(waitModel.AddExternalWaitEvent(nullptr, 0U, 0U), RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL(recordModel.context_->Device_()->Driver_(), &Driver::DevMemAllocWithBackupFlag)
        .stubs()
        .with(outBoundP(&deviceTablePtr, sizeof(deviceTablePtr)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(recordModel.context_->Device_()->Driver_(), &Driver::DevMemFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(static_cast<rtError_t (*)(TaskInfo*, Event*, const void*, TaskWrCqeFlag)>(WriteValuePtrTaskInit))
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    EXPECT_EQ(recordModel.FinalizeExternalRefreshTable(), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(recordModel.externalEventRefreshDeviceBase_, nullptr);

    MOCKER(CaptureWaitExternalTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    EXPECT_EQ(waitModel.FinalizeExternalRefreshTable(), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(waitModel.externalEventRefreshDeviceBase_, nullptr);
}
