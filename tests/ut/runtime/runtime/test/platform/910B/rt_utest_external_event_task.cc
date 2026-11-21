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
#include <cstdlib>
#include <cstring>
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

void InitExternalRecordUpdateTask(
    TaskInfo& taskInfo, TaskUpdateInfo& taskUpdate, Stream* stream, const uint16_t taskId, Event* oldEvent,
    Event* updatedEvent)
{
    taskInfo.stream = stream;
    taskInfo.id = taskId;
    taskInfo.pos = taskId;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.sqeNum = static_cast<uint8_t>(GetSendSqeNum(&taskInfo));
    taskInfo.updateInfo = &taskUpdate;
    taskInfo.u.writeValTask.event = oldEvent;
    taskInfo.u.writeValTask.cqeFlag = oldEvent->IsEventWithTimeline() ? TASK_WR_CQE_ALWAYS : TASK_WR_CQE_NEVER;
    taskUpdate.latestParams.type = RT_TASK_EVENT_RECORD;
    taskUpdate.latestParams.isValid = 1U;
    taskUpdate.latestParams.u.eventRecordUpdateParams.event = updatedEvent;
}

rtError_t AllocateGraphUpdateHostMemory(Driver*, void** addr, uint64_t size, uint32_t, uint16_t, uint32_t)
{
    *addr = std::malloc(size);
    return (*addr == nullptr) ? RT_ERROR_MEMORY_ALLOCATION : RT_ERROR_NONE;
}

rtError_t FreeGraphUpdateHostMemory(Driver*, void* addr)
{
    std::free(addr);
    return RT_ERROR_NONE;
}

rtError_t BuildGraphUpdateSqes(TaskInfo* taskInfo, void* hostAddr)
{
    EXPECT_EQ(taskInfo->u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
    std::memset(hostAddr, taskInfo->id, sizeof(rtStarsSqe_t) * GetSendSqeNum(taskInfo));
    return RT_ERROR_NONE;
}

rtError_t VerifyIndependentGraphUpdateCopies(
    void** dsts, const size_t* destMaxs, void** srcs, const size_t* sizes, size_t count, Stream*)
{
    EXPECT_EQ(count, 2U);
    if (count != 2U) {
        return RT_ERROR_INVALID_VALUE;
    }
    EXPECT_NE(srcs[0], srcs[1]);
    for (size_t index = 0U; index < count; ++index) {
        EXPECT_NE(srcs[index], nullptr);
        EXPECT_NE(dsts[index], nullptr);
        EXPECT_EQ(reinterpret_cast<uint64_t>(dsts[index]), 0x1000ULL + index * sizeof(rtStarsSqe_t) * 2U);
        EXPECT_EQ(sizes[index], sizeof(rtStarsSqe_t) * 2U);
        EXPECT_EQ(destMaxs[index], sizes[index]);
        EXPECT_EQ(*static_cast<uint8_t*>(srcs[index]), 7U + index);
    }
    return RT_ERROR_NONE;
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

TEST_F(ExternalEventTaskTest910B, SoftwareRecordAllocatesExpectedSqesAndOwnsEventId)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const stm = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(stm, nullptr);
    const struct {
        uint32_t flags;
        uint32_t sqes;
        uint8_t hasTimestamp;
    } cases[] = {{RT_EVENT_WITH_FLAG, 1U, 0U}, {RT_EVENT_TIME_LINE, 2U, 1U}, {RT_EVENT_DEFAULT, 2U, 1U}};
    for (const auto& test : cases) {
        SCOPED_TRACE(test.flags);
        rtEvent_t handle = nullptr;
        ASSERT_EQ(rtEventCreateExWithFlag(&handle, test.flags), RT_ERROR_NONE);
        Event* const event = rt_ut::UnwrapOrNull<Event>(handle);
        ASSERT_NE(event, nullptr);
        ASSERT_EQ(event->TrySwitchToSoftwareMode(), RT_ERROR_NONE);
        TaskInfo task = {};
        InitByStream(&task, stm);
        task.sqeNum = static_cast<uint8_t>(test.sqes);
        // Intercept submission so task inspection cannot race asynchronous recycling.
        MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                       &Stream::AllocTask))
            .expects(once())
            .with(mockcpp::any(), eq(TS_TASK_TYPE_EVENT_RECORD), mockcpp::any(), eq(test.sqes), mockcpp::any())
            .will(returnValue(&task));
        MOCKER_CPP_VIRTUAL(stm->Device_(), &Device::SubmitTask)
            .expects(once())
            .with(eq(&task), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
        ASSERT_EQ(rtEventRecord(handle, stream), RT_ERROR_NONE);
        EXPECT_EQ(task.type, TS_TASK_TYPE_MEM_WRITE_VALUE);
        EXPECT_EQ(task.sqeNum, test.sqes);
        EXPECT_EQ(task.u.memWriteValueTask.hasTimestamp, test.hasTimestamp);
        // Submission is mocked; emulate final task ID assignment and SQE construction.
        task.id = 1U;
        rtStarsSqe_t sqes[2] = {};
        ToConstructSqe(&task, sqes, TaskSqeInfo{0ULL, 0ULL});
        EXPECT_EQ(event->GetLatestRecord().taskId, task.id);
        ASSERT_NE(event->GetEventAddr(), nullptr);
        EXPECT_EQ(task.u.memWriteValueTask.devAddr, RtPtrToValue(event->GetEventAddr()));
        EXPECT_EQ(task.u.memWriteValueTask.value, 1U);
        EXPECT_EQ(task.u.memWriteValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
        EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, event->EventId_());
        ASSERT_EQ(event->idMap_.count(event->EventId_()), 1U);
        EXPECT_EQ(event->idMap_.at(event->EventId_()), 1U);
        GlobalMockObject::verify();
        DoCompleteSuccessForMemWriteValueTask(&task, stm->Device_()->Id_());
        EXPECT_EQ(event->GetLatestRecord().state, RECORDED);
        EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
        EXPECT_TRUE(event->idMap_.empty());
        MemWriteTaskUnInit(&task);
        EXPECT_EQ(rtEventDestroy(handle), RT_ERROR_NONE);
    }
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, TimelineMemWriteValueBuildsWriteValueAndCqePlaceholder)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);

    Event timelineEvent(streamObj->Device_(), RT_EVENT_TIME_LINE, nullptr);
    TaskInfo taskInfo = {};
    InitByStream(&taskInfo, streamObj);
    taskInfo.type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    taskInfo.u.memWriteValueTask.devAddr = 0x1000ULL;
    taskInfo.u.memWriteValueTask.awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    taskInfo.u.memWriteValueTask.event = &timelineEvent;
    taskInfo.u.memWriteValueTask.ownedEventId = 17;
    taskInfo.u.memWriteValueTask.hasTimestamp = 1U;
    rtStarsSqe_t sqes[2] = {};

    for (const uint64_t addr : {0ULL, 0x1000ULL}) {
        SCOPED_TRACE(addr);
        taskInfo.u.memWriteValueTask.devAddr = addr;
        EXPECT_EQ(GetSendSqeNum(&taskInfo), 2U);
        ToConstructSqe(&taskInfo, sqes, TaskSqeInfo{0ULL, 0ULL});
        EXPECT_EQ(
            sqes[0].writeValueSqe.header.type,
            addr == 0ULL ? RT_STARS_SQE_TYPE_INVALID : RT_STARS_SQE_TYPE_WRITE_VALUE);
        EXPECT_EQ(sqes[0].writeValueSqe.header.wr_cqe, 0U);
        EXPECT_EQ(sqes[1].phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
        EXPECT_EQ(sqes[1].phSqe.wr_cqe, 1U);
    }

    taskInfo.u.memWriteValueTask.ownedEventId = INVALID_EVENT_ID;
    EXPECT_EQ(GetSendSqeNum(&taskInfo), 1U);
    taskInfo.u.memWriteValueTask.ownedEventId = 17;
    taskInfo.u.memWriteValueTask.hasTimestamp = 0U;
    EXPECT_EQ(GetSendSqeNum(&taskInfo), 1U);
    taskInfo.u.memWriteValueTask.event = nullptr;
    EXPECT_EQ(GetSendSqeNum(&taskInfo), 1U);

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

    // This test checks task construction, not asynchronous HAL execution/recycling.
    TaskInfo taskInfo = {};
    InitByStream(&taskInfo, streamObj);
    constexpr uint32_t sqeNum = MEM_WAIT_SQE_NUM;
    taskInfo.sqeNum = static_cast<uint8_t>(sqeNum);
    MOCKER_CPP(static_cast<TaskInfo* (Stream::*)(TaskInfo*, tsTaskType_t, rtError_t&, uint32_t, UpdateTaskFlag)>(
                   &Stream::AllocTask))
        .expects(once())
        .with(mockcpp::any(), eq(TS_TASK_TYPE_MEM_WAIT_VALUE), mockcpp::any(), eq(sqeNum), mockcpp::any())
        .will(returnValue(&taskInfo));
    MOCKER_CPP_VIRTUAL(streamObj->Device_(), &Device::SubmitTask)
        .expects(once())
        .with(eq(&taskInfo), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    ASSERT_EQ(rtStreamWaitEvent(stream, event), RT_ERROR_NONE);
    TaskInfo* const waitTask = &taskInfo;
    EXPECT_EQ(waitTask->type, TS_TASK_TYPE_MEM_WAIT_VALUE);
    EXPECT_EQ(waitTask->u.memWaitValueTask.devAddr, RtPtrToValue(eventObj->GetEventAddr()));
    EXPECT_EQ(waitTask->u.memWaitValueTask.value, 1U);
    EXPECT_EQ(waitTask->u.memWaitValueTask.awSize, RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    EXPECT_EQ(waitTask->u.memWaitValueTask.ownedEventId, 7);
    ASSERT_EQ(eventObj->idMap_.count(7), 1U);
    EXPECT_EQ(eventObj->idMap_.at(7), 1U);

    GlobalMockObject::verify();
    DoCompleteSuccessForMemWaitValueTask(waitTask, streamObj->Device_()->Id_());
    EXPECT_EQ(waitTask->u.memWaitValueTask.ownedEventId, 7);
    MemWaitTaskUnInit(waitTask);
    EXPECT_EQ(waitTask->u.memWaitValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_TRUE(eventObj->idMap_.empty());
    MemWaitTaskUnInit(waitTask);
    EXPECT_TRUE(eventObj->idMap_.empty());
    // The event value is a stack buffer, not an allocation from the expanding pool.
    eventObj->SetEventAddr(nullptr);
    eventObj->SetEventId(INVALID_EVENT_ID);

    EXPECT_EQ(rtEventDestroy(event), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, WaitUnInitReleasesCurrentAndSharedEventReferences)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    ASSERT_NE(stream, nullptr);
    for (const bool current : {true, false}) {
        SCOPED_TRACE(current);
        Event event(stream->Device_(), RT_EVENT_DEFAULT, nullptr);
        event.SoftwareModeEnable();
        constexpr int32_t id = 65537;
        const uint32_t references = current ? 1U : 2U;
        TaskInfo tasks[2] = {};
        for (uint32_t i = 0; i < references; ++i) {
            InitByStream(&tasks[i], stream);
            tasks[i].type = TS_TASK_TYPE_MEM_WAIT_VALUE;
            tasks[i].u.memWaitValueTask.event = &event;
            tasks[i].u.memWaitValueTask.ownedEventId = id;
            event.EventIdCountAdd(id);
        }
        if (current) {
            event.PublishSoftwareRecordResource(nullptr, id, stream->Id_(), 0U, 0U);
        }
        ASSERT_EQ(event.EventId_(), current ? id : INVALID_EVENT_ID);
        MOCKER_CPP_VIRTUAL(stream->Device_(), &Device::FreeExpandingPoolEvent).expects(never());
        for (uint32_t i = 0; i < references; ++i) {
            if (i == 1U) {
                GlobalMockObject::verify();
                MOCKER_CPP_VIRTUAL(stream->Device_(), &Device::FreeExpandingPoolEvent).expects(once()).with(eq(id));
            }
            DoCompleteSuccessForMemWaitValueTask(&tasks[i], stream->Device_()->Id_());
            EXPECT_EQ(tasks[i].u.memWaitValueTask.ownedEventId, id);
            MemWaitTaskUnInit(&tasks[i]);
            EXPECT_EQ(tasks[i].u.memWaitValueTask.ownedEventId, INVALID_EVENT_ID);
            if (i + 1U < references) {
                ASSERT_EQ(event.idMap_.count(id), 1U);
                EXPECT_EQ(event.idMap_.at(id), references - i - 1U);
            } else {
                EXPECT_TRUE(event.idMap_.empty());
            }
            MemWaitTaskUnInit(&tasks[i]);
        }
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, MemWriteCqeCompletionAndReferenceLifetime)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    ASSERT_NE(stream, nullptr);
    for (const uint32_t flags : {RT_EVENT_WITH_FLAG, RT_EVENT_TIME_LINE}) {
        SCOPED_TRACE(flags);
        for (const bool error : {false, true}) {
            SCOPED_TRACE(error);
            const uint32_t originalError = stream->GetErrCode();
            const ScopeGuard restoreError([&]() { stream->SetErrCode(originalError); });
            Event event(stream->Device_(), flags, nullptr);
            event.SoftwareModeEnable();
            TaskInfo task = {};
            InitByStream(&task, stream);
            ASSERT_EQ(MemWriteValueTaskInit(&task, nullptr, 1U), RT_ERROR_NONE);
            task.type = TS_TASK_TYPE_MEM_WRITE_VALUE;
            task.u.memWriteValueTask.event = &event;
            task.u.memWriteValueTask.ownedEventId = 17;
            task.u.memWriteValueTask.hasTimestamp = (flags == RT_EVENT_TIME_LINE) ? 1U : 0U;
            event.EventIdCountAdd(17);
            event.PublishSoftwareRecordResource(nullptr, 17, stream->Id_(), task.id, 0U);
            rtCqReport_t report = {};
            report.u.timeStamp = 123U;
            report.errorType = error ? RT_STARS_EXIST_ERROR : 0U;
            report.errorCode = error ? TS_ERROR_END_OF_SEQUENCE : 0U;
            auto setResult = g_taskFuncArrays[CHIP_910_B_93].setStarsResultFunc[task.type];
            auto complete = g_taskFuncArrays[CHIP_910_B_93].doCompleteSuccFunc[task.type];
            ASSERT_EQ(setResult, &SetStarsResultForMemWriteValueTask);
            ASSERT_EQ(complete, &DoCompleteSuccessForMemWriteValueTask);
            setResult(&task, report);
            const uint64_t expected = !error && flags == RT_EVENT_TIME_LINE ? 123U : UINT64_MAX;
            EXPECT_EQ(task.u.memWriteValueTask.timestamp, expected);
            EXPECT_EQ(task.errorCode, error ? TS_ERROR_END_OF_SEQUENCE : 0U);
            complete(&task, stream->Device_()->Id_());
            EXPECT_EQ(event.TimeStamp(), expected);
            if (!error) {
                EXPECT_EQ(event.GetLatestRecord().state, RECORDED);
            }
            EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
            EXPECT_TRUE(event.idMap_.empty());
            event.SetTimeStamp(UINT64_MAX);
            complete(&task, stream->Device_()->Id_());
            EXPECT_EQ(event.TimeStamp(), UINT64_MAX);
            MemWriteTaskUnInit(&task);
            EXPECT_TRUE(event.idMap_.empty());
            task.u.memWriteValueTask.event = nullptr;
            EXPECT_NO_THROW(complete(&task, stream->Device_()->Id_()));
        }
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, MemWriteCompleteReleasesPendingDestroy)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    rtEvent_t eventHandle = nullptr;
    ASSERT_EQ(rtEventCreate(&eventHandle), RT_ERROR_NONE);
    Event* event = rt_ut::UnwrapOrNull<Event>(eventHandle);
    ASSERT_NE(event, nullptr);
    ASSERT_EQ(event->TrySwitchToSoftwareMode(), RT_ERROR_NONE);
    constexpr int32_t eventId = 41;
    event->PublishSoftwareRecordResource(nullptr, eventId, streamObj->Id_(), 0U, 0U);
    event->EventIdCountAdd(eventId);
    Event* owner = event;
    TryToFreeEventIdAndDestroyEvent(&owner, eventId, true);
    ASSERT_EQ(owner, event);
    TaskInfo task = {};
    InitByStream(&task, streamObj);
    ASSERT_EQ(MemWriteValueTaskInit(&task, nullptr, 1U), RT_ERROR_NONE);
    task.type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    task.u.memWriteValueTask.event = event;
    task.u.memWriteValueTask.ownedEventId = eventId;
    auto uninit = g_taskFuncArrays[CHIP_910_B_93].taskUnInitFunc[task.type];
    ASSERT_EQ(uninit, &MemWriteTaskUnInit);
    RawDevice* device = static_cast<RawDevice*>(event->Device_());
    DoCompleteSuccessForMemWriteValueTask(&task, device->Id_());
    EXPECT_EQ(task.u.memWriteValueTask.event, nullptr);
    EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_EQ(device->events_.find(event), device->events_.end());
    uninit(&task);
    EXPECT_EQ(task.u.memWriteValueTask.event, nullptr);
    EXPECT_EQ(task.u.memWriteValueTask.ownedEventId, INVALID_EVENT_ID);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
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
    Event waitEvent(nullptr, RT_EVENT_DDSYNC_NS, nullptr);
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

    ASSERT_EQ(model.CheckUpdateTask(), RT_ERROR_NONE);
    EXPECT_EQ(model.externalRecordEventItems_.begin()->second, &timelineEvent);
    EXPECT_EQ(model.updateInfo_.updateTask.count(&taskInfo), 1U);
    model.SwapUpdateTask();
    EXPECT_TRUE(model.updateInfo_.updateTask.empty());
    EXPECT_EQ(model.updateInfo_.curApplyUpdateTask.count(&taskInfo), 1U);
    taskUpdate.latestParams.u.eventRecordUpdateParams.event = &waitEvent;
    model.InsertGraphUpdateTask(&taskInfo);

    std::vector<void*> dsts;
    std::vector<void*> srcs;
    std::vector<size_t> sizes;
    MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
    MOCKER(UpdateHostSqeBufferAndCopySqeByTask).expects(once()).will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(model.PrepareTaskUpdate(&taskInfo, dsts, srcs, sizes), RT_ERROR_NONE);
    ASSERT_EQ(dsts.size(), 1U);
    ASSERT_EQ(srcs.size(), 1U);
    ASSERT_EQ(sizes.size(), 1U);
    ASSERT_EQ(model.updateInfo_.hostSqeUpdateBuffers.size(), 1U);
    EXPECT_EQ(srcs[0], model.updateInfo_.hostSqeUpdateBuffers.front().get());
    EXPECT_EQ(sizes[0], sizeof(rtStarsSqe_t) * 2U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
    ASSERT_EQ(model.PrepareExternalRecordReplayInfo(), RT_ERROR_NONE);
    EXPECT_EQ(taskInfo.u.writeValTask.expectCqeCnt, 1U);
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
    EXPECT_EQ(streamObj->GetCqePendingCnt(), 1U);
    ASSERT_EQ(taskUpdate.updateQueue.size(), 1U);
    EXPECT_EQ(taskUpdate.updateQueue.front().u.eventRecordInfo.event, &timelineEvent);
    EXPECT_EQ(model.updateInfo_.updateTask.count(&taskInfo), 1U);

    uint8_t eventValue = 0U;
    timelineEvent.PublishSoftwareRecordResource(&eventValue, 17, streamObj->Id_(), taskInfo.id, 1U);
    rtCqReport_t logicCq = {};
    logicCq.u.timeStamp = 123U;
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

TEST_F(ExternalEventTaskTest910B, GraphUpdateRejectsExternalRecordWaitConflictBeforeAllocation)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event oldEvent(nullptr, RT_EVENT_DDSYNC_NS, nullptr);
    Event updatedEvent(nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr);
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    InitExternalRecordUpdateTask(taskInfo, taskUpdate, streamObj, 7U, &oldEvent, &updatedEvent);
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    const uint32_t streamId = static_cast<uint32_t>(streamObj->Id_());
    ASSERT_EQ(model.AddExternalRecordEvent(&oldEvent, streamId, taskInfo.id), RT_ERROR_NONE);
    ASSERT_EQ(model.AddExternalWaitEvent(&updatedEvent, streamId, 8U), RT_ERROR_NONE);
    model.InsertGraphUpdateTask(&taskInfo);
    MOCKER_CPP_VIRTUAL(streamObj->Device_()->Driver_(), &Driver::HostMemAlloc).expects(never());
    MOCKER(BatchSendH2DAsyncTask).expects(never());

    EXPECT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_MODEL_EXE_FAILED);
    EXPECT_EQ(model.externalRecordEventItems_.begin()->second, &oldEvent);
    EXPECT_EQ(model.updateInfo_.updateTask.count(&taskInfo), 1U);
    EXPECT_TRUE(model.updateInfo_.curApplyUpdateTask.empty());
    EXPECT_TRUE(model.updateInfo_.hostSqeUpdateBuffers.empty());
    EXPECT_TRUE(taskUpdate.updateQueue.empty());
    EXPECT_EQ(model.updateInfo_.launchCnt, 0U);
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, ExternalUpdateValidationUsesFinalMappingForEventSwap)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event firstEvent(nullptr, RT_EVENT_DDSYNC_NS, nullptr);
    Event secondEvent(nullptr, RT_EVENT_DDSYNC_NS, nullptr);
    TaskInfo tasks[2] = {};
    TaskUpdateInfo updates[2] = {};
    InitExternalRecordUpdateTask(tasks[0], updates[0], streamObj, 7U, &firstEvent, &secondEvent);
    InitExternalRecordUpdateTask(tasks[1], updates[1], streamObj, 8U, &secondEvent, &firstEvent);
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    const uint32_t streamId = static_cast<uint32_t>(streamObj->Id_());
    ASSERT_EQ(model.AddExternalRecordEvent(&firstEvent, streamId, tasks[0].id), RT_ERROR_NONE);
    ASSERT_EQ(model.AddExternalRecordEvent(&secondEvent, streamId, tasks[1].id), RT_ERROR_NONE);
    model.InsertGraphUpdateTask(&tasks[0]);
    model.InsertGraphUpdateTask(&tasks[1]);

    ASSERT_EQ(model.CheckUpdateTask(), RT_ERROR_NONE);
    EXPECT_EQ(model.externalRecordEventItems_.at(std::make_tuple(streamId, tasks[0].id)), &secondEvent);
    EXPECT_EQ(model.externalRecordEventItems_.at(std::make_tuple(streamId, tasks[1].id)), &firstEvent);
    EXPECT_EQ(model.updateInfo_.updateTask.size(), 2U);
    EXPECT_TRUE(model.updateInfo_.curApplyUpdateTask.empty());
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, GraphUpdateAllocatesIndependentBuffersAndReleasesThemAtEndGraph)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event oldEvents[2] = {{nullptr, RT_EVENT_DDSYNC_NS, nullptr}, {nullptr, RT_EVENT_DDSYNC_NS, nullptr}};
    Event updatedEvents[2] = {
        {nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr},
        {nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr}};
    TaskInfo tasks[2] = {};
    TaskUpdateInfo updates[2] = {};
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    model.SetSoftwareSqEnable();
    for (size_t index = 0U; index < 2U; ++index) {
        InitExternalRecordUpdateTask(
            tasks[index], updates[index], streamObj, static_cast<uint16_t>(7U + index), &oldEvents[index],
            &updatedEvents[index]);
        ASSERT_EQ(
            model.AddExternalRecordEvent(&oldEvents[index], static_cast<uint32_t>(streamObj->Id_()), tasks[index].id),
            RT_ERROR_NONE);
        model.InsertGraphUpdateTask(&tasks[index]);
        MOCKER(GetTaskInfo)
            .stubs()
            .with(any(), any(), eq(static_cast<uint32_t>(tasks[index].id)), any())
            .will(returnValue(&tasks[index]));
    }
    Driver* const driver = streamObj->Device_()->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).expects(exactly(2)).will(invoke(AllocateGraphUpdateHostMemory));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).expects(exactly(2)).will(invoke(FreeGraphUpdateHostMemory));
    MOCKER(UpdateHostSqeBufferAndCopySqeByTask).expects(exactly(2)).will(invoke(BuildGraphUpdateSqes));
    MOCKER(BatchSendH2DAsyncTask).expects(once()).will(invoke(VerifyIndependentGraphUpdateCopies));
    MOCKER_CPP(&Stream::GetDeviceSqeAddrByPos)
        .expects(once())
        .with(eq(7U))
        .will(returnValue(reinterpret_cast<void*>(0x1000ULL)));
    MOCKER_CPP(&Stream::GetDeviceSqeAddrByPos)
        .expects(once())
        .with(eq(8U))
        .will(returnValue(reinterpret_cast<void*>(0x1080ULL)));

    ASSERT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_NONE);
    ASSERT_EQ(model.updateInfo_.hostSqeUpdateBuffers.size(), 2U);
    EXPECT_TRUE(model.updateInfo_.updateTask.empty());
    EXPECT_EQ(model.updateInfo_.curApplyUpdateTask.size(), 2U);
    EXPECT_EQ(model.updateInfo_.launchCnt, 1U);
    std::weak_ptr<void> firstBuffer = model.updateInfo_.hostSqeUpdateBuffers[0];
    std::weak_ptr<void> secondBuffer = model.updateInfo_.hostSqeUpdateBuffers[1];
    Notify notify(0, 0U);
    notify.SetEndGraphModel(&model);
    TaskInfo endGraphTask = {};
    endGraphTask.stream = streamObj;
    ASSERT_EQ(EndGraphNotifyWaitTaskInit(&endGraphTask, 0U, 0U, &notify), RT_ERROR_NONE);
    EXPECT_TRUE(model.updateInfo_.hostSqeUpdateBuffers.empty());
    ASSERT_NE(endGraphTask.u.endGraphNotifyWaitTask.hostSqeUpdateBuffers, nullptr);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.hostSqeUpdateBuffers->size(), 2U);
    EXPECT_FALSE(firstBuffer.expired());
    EXPECT_FALSE(secondBuffer.expired());
    endGraphTask.bindFlag = 1U;
    endGraphTask.u.endGraphNotifyWaitTask.isSoftwareSqCaptureModel = false;

    DoCompleteSuccessForEndGraphNotifyWaitTask(&endGraphTask, 0U);
    EXPECT_TRUE(firstBuffer.expired());
    EXPECT_TRUE(secondBuffer.expired());
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.hostSqeUpdateBuffers, nullptr);
    EXPECT_TRUE(updates[0].updateQueue.empty());
    EXPECT_TRUE(updates[1].updateQueue.empty());
    EndGraphNotifyWaitTaskUnInit(&endGraphTask);
    streamObj->SubCqePendingCnt();
    streamObj->SubCqePendingCnt();
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, EndGraphHostBufferOwnerAllocationFailureCleansTransferredTasksForCurrentLaunch)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    model.SetSoftwareSqEnable();
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.updateInfo = &taskUpdate;
    TaskUpdateItem currentItem = {};
    currentItem.launchNo = 7U;
    TaskUpdateItem futureItem = {};
    futureItem.launchNo = 8U;
    taskUpdate.updateQueue.push(currentItem);
    taskUpdate.updateQueue.push(futureItem);
    model.updateInfo_.launchCnt = 7U;
    model.updateInfo_.totalNeedCqeCnt = 3U;
    model.updateInfo_.isCurExecuteNeedCqe = 1U;
    model.updateInfo_.curApplyUpdateTask.insert(&taskInfo);
    model.updateInfo_.hostSqeUpdateBuffers.push_back(std::make_shared<int>(0));
    std::weak_ptr<void> retainedBuffer = model.updateInfo_.hostSqeUpdateBuffers.front();
    Notify notify(0, 0U);
    notify.SetEndGraphModel(&model);
    TaskInfo endGraphTask = {};
    endGraphTask.stream = streamObj;
    auto* const taskSet = new std::set<TaskInfo*>();
    MOCKER(static_cast<NothrowNewFunc>(&operator new))
        .expects(exactly(2))
        .will(returnValue(static_cast<void*>(taskSet)))
        .then(invoke(NothrowNewFail));

    EXPECT_EQ(EndGraphNotifyWaitTaskInit(&endGraphTask, 0U, 0U, &notify), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_TRUE(model.updateInfo_.curApplyUpdateTask.empty());
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.updateTask, taskSet);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.launchNo, 7U);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.expectTotalRecvCqeCnt, 3U);
    EXPECT_TRUE(endGraphTask.u.endGraphNotifyWaitTask.isCurExecuteNeedCqe);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.hostSqeUpdateBuffers, nullptr);
    EndGraphNotifyWaitTaskUnInit(&endGraphTask);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.updateTask, nullptr);
    ASSERT_EQ(taskUpdate.updateQueue.size(), 1U);
    EXPECT_EQ(taskUpdate.updateQueue.front().launchNo, 8U);
    EXPECT_EQ(model.updateInfo_.hostSqeUpdateBuffers.size(), 1U);
    EXPECT_FALSE(retainedBuffer.expired());
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, GraphUpdateAllocationFailureReleasesPreparedBuffersWithoutRollback)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event oldEvents[2] = {{nullptr, RT_EVENT_DDSYNC_NS, nullptr}, {nullptr, RT_EVENT_DDSYNC_NS, nullptr}};
    Event updatedEvents[2] = {
        {nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr},
        {nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr}};
    TaskInfo tasks[2] = {};
    TaskUpdateInfo updates[2] = {};
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    for (size_t index = 0U; index < 2U; ++index) {
        InitExternalRecordUpdateTask(
            tasks[index], updates[index], streamObj, static_cast<uint16_t>(7U + index), &oldEvents[index],
            &updatedEvents[index]);
        ASSERT_EQ(
            model.AddExternalRecordEvent(&oldEvents[index], static_cast<uint32_t>(streamObj->Id_()), tasks[index].id),
            RT_ERROR_NONE);
        model.InsertGraphUpdateTask(&tasks[index]);
    }
    Driver* const driver = streamObj->Device_()->Driver_();
    void* hostAddr = std::malloc(sizeof(rtStarsSqe_t) * 2U);
    ASSERT_NE(hostAddr, nullptr);
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc)
        .expects(exactly(2))
        .with(outBoundP(&hostAddr))
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).expects(once()).will(invoke(FreeGraphUpdateHostMemory));
    MOCKER(UpdateHostSqeBufferAndCopySqeByTask).expects(once()).will(invoke(BuildGraphUpdateSqes));
    MOCKER(BatchSendH2DAsyncTask).expects(never());

    EXPECT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_TRUE(model.updateInfo_.hostSqeUpdateBuffers.empty());
    EXPECT_TRUE(model.updateInfo_.updateTask.empty());
    ASSERT_EQ(model.updateInfo_.curApplyUpdateTask.size(), 2U);
    EXPECT_EQ(model.updateInfo_.launchCnt, 0U);
    for (size_t index = 0U; index < 2U; ++index) {
        EXPECT_EQ(
            tasks[index].u.writeValTask.cqeFlag,
            (&tasks[index] == *model.updateInfo_.curApplyUpdateTask.begin()) ? TASK_WR_CQE_ALWAYS : TASK_WR_CQE_NEVER);
        EXPECT_EQ(tasks[index].u.writeValTask.expectCqeCnt, 0U);
        EXPECT_TRUE(updates[index].updateQueue.empty());
        EXPECT_EQ(
            model.externalRecordEventItems_.at(
                std::make_tuple(static_cast<uint32_t>(streamObj->Id_()), tasks[index].id)),
            &updatedEvents[index]);
    }
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, GraphUpdateSqePreparationFailureReleasesBufferWithoutRollback)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event oldEvent(nullptr, RT_EVENT_DDSYNC_NS, nullptr);
    Event updatedEvent(nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr);
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    InitExternalRecordUpdateTask(taskInfo, taskUpdate, streamObj, 7U, &oldEvent, &updatedEvent);
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    ASSERT_EQ(
        model.AddExternalRecordEvent(&oldEvent, static_cast<uint32_t>(streamObj->Id_()), taskInfo.id), RT_ERROR_NONE);
    model.InsertGraphUpdateTask(&taskInfo);
    Driver* const driver = streamObj->Device_()->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).expects(once()).will(invoke(AllocateGraphUpdateHostMemory));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).expects(once()).will(invoke(FreeGraphUpdateHostMemory));
    MOCKER(UpdateHostSqeBufferAndCopySqeByTask).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER(BatchSendH2DAsyncTask).expects(never());

    EXPECT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_DRV_ERR);
    EXPECT_TRUE(model.updateInfo_.hostSqeUpdateBuffers.empty());
    EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
    EXPECT_EQ(model.externalRecordEventItems_.begin()->second, &updatedEvent);
    EXPECT_TRUE(model.updateInfo_.updateTask.empty());
    EXPECT_EQ(model.updateInfo_.curApplyUpdateTask.count(&taskInfo), 1U);
    EXPECT_TRUE(taskUpdate.updateQueue.empty());
    EXPECT_EQ(model.updateInfo_.launchCnt, 0U);
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, GraphUpdateBatchFailureRetainsBuffersWithoutRollback)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event oldEvent(nullptr, RT_EVENT_DDSYNC_NS, nullptr);
    Event updatedEvent(nullptr, RT_EVENT_DDSYNC_NS | RT_EVENT_TIME_LINE, nullptr);
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    InitExternalRecordUpdateTask(taskInfo, taskUpdate, streamObj, 7U, &oldEvent, &updatedEvent);
    Driver* const driver = streamObj->Device_()->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).expects(once()).will(invoke(AllocateGraphUpdateHostMemory));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).expects(once()).will(invoke(FreeGraphUpdateHostMemory));
    MOCKER(UpdateHostSqeBufferAndCopySqeByTask).expects(once()).will(invoke(BuildGraphUpdateSqes));
    MOCKER(BatchSendH2DAsyncTask).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
    std::weak_ptr<void> retainedBuffer;
    {
        CaptureModel model(RT_MODEL_CAPTURE_MODEL);
        model.context_ = streamObj->Context_();
        ASSERT_EQ(
            model.AddExternalRecordEvent(&oldEvent, static_cast<uint32_t>(streamObj->Id_()), taskInfo.id),
            RT_ERROR_NONE);
        model.InsertGraphUpdateTask(&taskInfo);

        EXPECT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_DRV_ERR);
        ASSERT_EQ(model.updateInfo_.hostSqeUpdateBuffers.size(), 1U);
        retainedBuffer = model.updateInfo_.hostSqeUpdateBuffers.front();
        EXPECT_FALSE(retainedBuffer.expired());
        EXPECT_EQ(model.externalRecordEventItems_.begin()->second, &updatedEvent);
        EXPECT_TRUE(model.updateInfo_.updateTask.empty());
        EXPECT_EQ(model.updateInfo_.curApplyUpdateTask.count(&taskInfo), 1U);
        EXPECT_EQ(taskInfo.u.writeValTask.cqeFlag, TASK_WR_CQE_ALWAYS);
        EXPECT_TRUE(taskUpdate.updateQueue.empty());
        EXPECT_EQ(model.updateInfo_.launchCnt, 0U);
        EXPECT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_INVALID_VALUE);
    }
    EXPECT_TRUE(retainedBuffer.expired());
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
}

TEST_F(ExternalEventTaskTest910B, GraphUpdateRejectsUnsupportedTaskWithoutReadingExternalParams)
{
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = Runtime::Instance()->CurrentContext();
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    model.InsertGraphUpdateTask(&taskInfo);
    MOCKER_CPP_VIRTUAL(model.context_->Device_()->Driver_(), &Driver::HostMemAlloc).expects(never());
    MOCKER(BatchSendH2DAsyncTask).expects(never());

    EXPECT_EQ(model.CheckUpdateTask(), RT_ERROR_MODEL_EXE_FAILED);
    EXPECT_EQ(model.PrepareGraphUpdateProc(nullptr), RT_ERROR_MODEL_EXE_FAILED);
    EXPECT_EQ(model.updateInfo_.updateTask.count(&taskInfo), 1U);
    EXPECT_TRUE(model.updateInfo_.curApplyUpdateTask.empty());
    EXPECT_TRUE(model.updateInfo_.hostSqeUpdateBuffers.empty());
    EXPECT_EQ(model.updateInfo_.launchCnt, 0U);
}

TEST_F(ExternalEventTaskTest910B, TimelineExternalRecordMaintainsCqeTrackingWithoutPendingUpdates)
{
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    Event timelineEvent(nullptr, RT_EVENT_TIME_LINE, nullptr);
    TaskUpdateInfo taskUpdate = {};
    TaskInfo taskInfo = {};
    InitExternalRecordUpdateTask(taskInfo, taskUpdate, streamObj, 7U, &timelineEvent, &timelineEvent);
    CaptureModel model(RT_MODEL_CAPTURE_MODEL);
    model.context_ = streamObj->Context_();
    ASSERT_EQ(
        model.AddExternalRecordEvent(&timelineEvent, static_cast<uint32_t>(streamObj->Id_()), taskInfo.id),
        RT_ERROR_NONE);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
    MOCKER_CPP_VIRTUAL(streamObj->Device_()->Driver_(), &Driver::HostMemAlloc).expects(never());
    MOCKER(BatchSendH2DAsyncTask).expects(never());

    ASSERT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_NONE);
    ASSERT_EQ(model.PrepareGraphUpdateProc(streamObj), RT_ERROR_NONE);
    EXPECT_EQ(model.updateInfo_.launchCnt, 2U);
    EXPECT_EQ(model.updateInfo_.totalNeedCqeCnt, 2U);
    EXPECT_EQ(taskInfo.u.writeValTask.expectCqeCnt, 2U);
    EXPECT_EQ(taskUpdate.updateQueue.size(), 2U);
    EXPECT_EQ(streamObj->GetCqePendingCnt(), 2U);
    EXPECT_TRUE(model.updateInfo_.curApplyUpdateTask.empty());
    const rtCqReport_t logicCq = {};
    model.ProcessExternalRecordNormalCqe(&taskInfo, logicCq);
    model.ProcessExternalRecordNormalCqe(&taskInfo, logicCq);
    EXPECT_TRUE(taskUpdate.updateQueue.empty());
    EXPECT_EQ(streamObj->GetCqePendingCnt(), 0U);
    EXPECT_EQ(model.updateInfo_.totalRecvCqeCnt.Value(), 2U);
    model.SetSoftwareSqEnable();
    Notify notify(0, 0U);
    notify.SetEndGraphModel(&model);
    TaskInfo endGraphTask = {};
    endGraphTask.stream = streamObj;
    MOCKER(static_cast<NothrowNewFunc>(&operator new)).expects(never());
    ASSERT_EQ(EndGraphNotifyWaitTaskInit(&endGraphTask, 0U, 0U, &notify), RT_ERROR_NONE);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.updateTask, nullptr);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.hostSqeUpdateBuffers, nullptr);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.launchNo, 2U);
    EXPECT_EQ(endGraphTask.u.endGraphNotifyWaitTask.expectTotalRecvCqeCnt, 2U);
    EXPECT_TRUE(endGraphTask.u.endGraphNotifyWaitTask.isCurExecuteNeedCqe);
    EndGraphNotifyWaitTaskUnInit(&endGraphTask);
    GlobalMockObject::verify();
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
