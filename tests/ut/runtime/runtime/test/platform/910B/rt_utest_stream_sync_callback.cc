/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <cstdlib>
#include <list>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "runtime/rts/rts_stream.h"
#include "runtime.hpp"
#include "api_impl.hpp"
#include "raw_device.hpp"
#include "context.hpp"
#include "event.hpp"
#include "npu_driver.hpp"
#include "osal.hpp"
#include "task.hpp"
#include "stream.hpp"
#include "subscribe.hpp"
#include "rt_unwrap.h"

using namespace cce::runtime;

namespace {
constexpr uint64_t CALLBACK_THREAD_ID = 0x12345678U;
uint32_t callbackThreadStarts = 0U;
std::vector<Stream*> synchronizedStreams;
Stream* abortOtherStream = nullptr;
rtCallback_t pendingCallback = nullptr;
SyncFuncArgs* pendingArgs = nullptr;
rtHostFuncCqReport_t* callbackReport = nullptr;
uint32_t callbackCq = 0U;
rtError_t launchError = RT_ERROR_NONE;
std::vector<rtHostFuncCqReport_t> releasedReports;

// Keep the original worker creation/subscription path, but let each test supply reports deterministically.
class CallbackThreadForTest : public Thread {
public:
    int32_t Start() override
    {
        ++callbackThreadStarts;
        return EN_OK;
    }
    void Join() override {}
    bool IsAlive() override { return true; }
    uint64_t GetThreadId() override { return CALLBACK_THREAD_ID; }
};

Thread* CreateCallbackThread(const char_t* name, ThreadRunnable*, void*)
{
    EXPECT_STREQ(name, "THREAD_CALLBACK");
    return new CallbackThreadForTest();
}

rtError_t AllocateCallbackQueue(Driver*, uint32_t, uint32_t, uint32_t, uint32_t* sqId, uint32_t* cqId)
{
    *sqId = 17U;
    *cqId = 19U;
    return RT_ERROR_NONE;
}

void CountCallback(void* data) { ++*static_cast<uint32_t*>(data); }

rtError_t CompleteNonBlockingCallback(ApiImpl*, rtCallback_t callback, void* data, Stream*, bool isBlock)
{
    EXPECT_FALSE(isBlock);
    callback(data);
    return RT_ERROR_NONE;
}

rtError_t CaptureNonBlockingCallback(ApiImpl*, rtCallback_t callback, void* data, Stream*, bool isBlock)
{
    EXPECT_FALSE(isBlock);
    pendingCallback = callback;
    pendingArgs = static_cast<SyncFuncArgs*>(data);
    return RT_ERROR_NONE;
}

rtError_t CaptureFailedLaunch(Api*, Stream*, rtCallback_t callback, void* data, bool isBlock)
{
    EXPECT_FALSE(isBlock);
    EXPECT_NE(callback, nullptr);
    pendingArgs = static_cast<SyncFuncArgs*>(data);
    return launchError;
}

void ReleaseFailedLaunchArgs(SyncFuncArgs* args)
{
    ASSERT_NE(args, nullptr);
    EXPECT_EQ(args, pendingArgs);
    EXPECT_EQ(pthread_cond_destroy(&args->cond), 0);
    EXPECT_EQ(pthread_mutex_destroy(&args->mutex), 0);
    free(args);
    pendingArgs = nullptr;
}

rtError_t InspectNonBlockingTask(Device*, TaskInfo* task, uint32_t*, int32_t)
{
    EXPECT_EQ(task->type, TS_TASK_TYPE_HOSTFUNC_CALLBACK);
    EXPECT_FALSE(task->u.callbackLaunchTask.isBlock);
    EXPECT_EQ(task->u.callbackLaunchTask.eventId, INVALID_EVENT_ID);
    EXPECT_EQ(task->u.callbackLaunchTask.callBackFunc, CountCallback);
    // Use the existing failed-submit recycle path so this test owns no queued device task.
    return RT_ERROR_DRV_ERR;
}

rtError_t SupplyCallbackIrq(Driver*, uint32_t, uint32_t, uint32_t, int32_t, uint64_t* bits, uint32_t count)
{
    std::fill(bits, bits + count, 0U);
    bits[callbackCq / 64U] = 1ULL << (callbackCq % 64U);
    return RT_ERROR_NONE;
}

rtError_t SupplyCallbackReport(Driver*, uint32_t, uint32_t, uint32_t, rtHostFuncCqReport_t** report, uint32_t* count)
{
    *report = callbackReport;
    *count = 1U;
    return RT_ERROR_NONE;
}

rtError_t SupplyTwoCallbackReports(
    Driver*, uint32_t, uint32_t, uint32_t, rtHostFuncCqReport_t** report, uint32_t* count)
{
    *report = callbackReport;
    *count = 2U;
    return RT_ERROR_NONE;
}

rtError_t InspectReleasedReport(Driver*, rtHostFuncCqReport_t* report, uint32_t, uint32_t, uint32_t, bool)
{
    releasedReports.push_back(*report);
    return RT_ERROR_NONE;
}

rtError_t SynchronizeWithChangedConfiguration(Stream* stream, bool waitSyncCq, int32_t timeout, uint32_t mode)
{
    EXPECT_FALSE(waitSyncCq);
    EXPECT_GT(timeout, 0);
    EXPECT_EQ(mode, static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
    synchronizedStreams.push_back(stream);
    stream->Context_()->SetDeviceFlags(RT_DEVICE_SCHEDULE_YIELD);
    return RT_ERROR_NONE;
}

rtError_t SynchronizeContinueAfterAnotherTargetAborts(Stream* stream, bool, int32_t, uint32_t mode)
{
    EXPECT_EQ(mode, static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
    synchronizedStreams.push_back(stream);
    if (synchronizedStreams.size() == 1U) {
        abortOtherStream->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    }
    return stream == abortOtherStream ? RT_ERROR_STREAM_ABORT : RT_ERROR_NONE;
}

struct CallbackRoute {
    uint64_t threadId = 0U;
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;
    Event* event = nullptr;
};

CallbackRoute ReadCallbackRoute(Stream* stream)
{
    Runtime* const runtime = Runtime::Instance();
    const uint32_t deviceId = stream->Device_()->Id_();
    const int32_t streamId = stream->Id_();
    CallbackRoute route;
    EXPECT_EQ(runtime->GetThreadIdByStreamId(deviceId, streamId, &route.threadId), RT_ERROR_NONE);
    EXPECT_EQ(runtime->GetSqIdByStreamId(deviceId, streamId, &route.sqId), RT_ERROR_NONE);
    EXPECT_EQ(runtime->GetCqIdByStreamId(deviceId, streamId, &route.cqId), RT_ERROR_NONE);
    EXPECT_EQ(runtime->GetEventByStreamId(deviceId, streamId, &route.event), RT_ERROR_NONE);
    return route;
}

void ExpectSameRoute(const CallbackRoute& before, const CallbackRoute& after)
{
    EXPECT_EQ(after.threadId, before.threadId);
    EXPECT_EQ(after.sqId, before.sqId);
    EXPECT_EQ(after.cqId, before.cqId);
    EXPECT_EQ(after.event, before.event);
}
} // namespace

class StreamSyncCallbackTest : public testing::Test {
protected:
    void SetUp() override
    {
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        ASSERT_EQ(rtStreamCreate(&handle_, 0), RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(handle_);
        ASSERT_NE(stream_, nullptr);
        context_ = stream_->Context_();
        callbackThreadStarts = 0U;
        pendingCallback = nullptr;
        pendingArgs = nullptr;
        callbackReport = nullptr;
        releasedReports.clear();
        synchronizedStreams.clear();
        launchError = RT_ERROR_NONE;
    }

    void TearDown() override
    {
        context_->DestroyContextCallBackThread();
        GlobalMockObject::verify();
        stream_->Device_()->DestroySyncArgs();
        context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_AUTO);
        if (abortOtherStream != nullptr) {
            abortOtherStream->SetAbortStatus(RT_ERROR_NONE);
            abortOtherStream = nullptr;
        }
        pendingCallback = nullptr;
        pendingArgs = nullptr;
        callbackReport = nullptr;
        releasedReports.clear();
        synchronizedStreams.clear();
        EXPECT_EQ(rtStreamDestroy(handle_), RT_ERROR_NONE);
        EXPECT_EQ(rtDeviceReset(0), RT_ERROR_NONE);
    }

    void UseOriginalRuntimeSubscription()
    {
        MOCKER(OsalFactory::CreateThread).expects(once()).will(invoke(CreateCallbackThread));
        MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::SqCqAllocate)
            .expects(once())
            .will(invoke(AllocateCallbackQueue));
    }

    void CheckRuntimeSubscriptionReuse(bool publicFirst)
    {
        UseOriginalRuntimeSubscription();
        MOCKER_CPP(&ApiImpl::StarsLaunchEventProc).expects(once()).will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP(&ApiImpl::CallbackLaunchWithoutEvent).expects(once()).will(invoke(CompleteNonBlockingCallback));
        uint32_t callbackCount = 0U;
        if (publicFirst) {
            ASSERT_EQ(rtsLaunchHostFunc(handle_, CountCallback, &callbackCount), RT_ERROR_NONE);
        } else {
            ASSERT_EQ(stream_->SynchronizeBlocking(1000), RT_ERROR_NONE);
        }
        const CallbackRoute first = ReadCallbackRoute(stream_);
        EXPECT_EQ(first.threadId, CALLBACK_THREAD_ID);
        EXPECT_NE(first.event, nullptr);
        EXPECT_EQ(stream_->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_RUNTIME);
        EXPECT_EQ(
            stream_->ResolveSyncScheduleMode(RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
            static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
        if (publicFirst) {
            ASSERT_EQ(stream_->SynchronizeBlocking(1000), RT_ERROR_NONE);
        } else {
            ASSERT_EQ(rtsLaunchHostFunc(handle_, CountCallback, &callbackCount), RT_ERROR_NONE);
        }
        ExpectSameRoute(first, ReadCallbackRoute(stream_));
        EXPECT_EQ(callbackThreadStarts, 1U);
        EXPECT_EQ(callbackCount, 0U);
        EXPECT_TRUE(stream_->Device_()->syncArgs_.empty());
    }

    rtStream_t handle_ = nullptr;
    Stream* stream_ = nullptr;
    Context* context_ = nullptr;
};

TEST_F(StreamSyncCallbackTest, DeviceSynchronizationKeepsModeSnapshotForEveryTarget)
{
    rtStream_t secondHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&secondHandle, 0), RT_ERROR_NONE);
    Stream* const second = rt_ut::UnwrapOrNull<Stream>(secondHandle);
    synchronizedStreams.clear();
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream_, &Stream::Synchronize)
        .expects(exactly(3))
        .will(invoke(SynchronizeWithChangedConfiguration));
    EXPECT_EQ(context_->Synchronize(1000), RT_ERROR_NONE);
    EXPECT_EQ(synchronizedStreams.size(), 3U);
    for (Stream* const expected : {stream_, second, context_->DefaultStream_()}) {
        EXPECT_EQ(std::count(synchronizedStreams.begin(), synchronizedStreams.end(), expected), 1);
    }
    EXPECT_EQ(context_->GetDeviceFlags(), static_cast<uint32_t>(RT_DEVICE_SCHEDULE_YIELD));
    GlobalMockObject::verify();
    synchronizedStreams.clear();
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_AUTO);
    EXPECT_EQ(rtStreamDestroy(secondHandle), RT_ERROR_NONE);
}

TEST_F(StreamSyncCallbackTest, DeviceSynchronizationChecksTargetsInOriginalOrder)
{
    rtStream_t secondHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&secondHandle, 0), RT_ERROR_NONE);
    abortOtherStream = rt_ut::UnwrapOrNull<Stream>(secondHandle);
    const TsStreamFailureMode previousFailureMode = context_->GetCtxMode();
    context_->SetCtxMode(ABORT_ON_FAILURE);
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
    synchronizedStreams.clear();
    MOCKER_CPP_VIRTUAL(stream_, &Stream::Synchronize)
        .expects(exactly(2))
        .will(invoke(SynchronizeContinueAfterAnotherTargetAborts));
    EXPECT_EQ(context_->Synchronize(1000), RT_ERROR_STREAM_ABORT);
    ASSERT_EQ(synchronizedStreams.size(), 2U);
    EXPECT_EQ(synchronizedStreams[0], stream_);
    EXPECT_EQ(synchronizedStreams[1], abortOtherStream);
    synchronizedStreams.clear();
    GlobalMockObject::verify();
    abortOtherStream->SetAbortStatus(RT_ERROR_NONE);
    abortOtherStream = nullptr;
    context_->SetCtxMode(previousFailureMode);
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_AUTO);
    EXPECT_EQ(rtStreamDestroy(secondHandle), RT_ERROR_NONE);
}

TEST_F(StreamSyncCallbackTest, DeviceSynchronizationContinueOnFailureWaitsHealthyTargets)
{
    rtStream_t secondHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&secondHandle, 0), RT_ERROR_NONE);
    abortOtherStream = rt_ut::UnwrapOrNull<Stream>(secondHandle);
    const TsStreamFailureMode previousFailureMode = context_->GetCtxMode();
    context_->SetCtxMode(CONTINUE_ON_FAILURE);
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    synchronizedStreams.clear();
    MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream_, &Stream::Synchronize)
        .expects(exactly(3))
        .will(invoke(SynchronizeContinueAfterAnotherTargetAborts));

    EXPECT_EQ(context_->Synchronize(1000), RT_ERROR_STREAM_ABORT);
    EXPECT_EQ(synchronizedStreams.size(), 3U);
    GlobalMockObject::verify();

    abortOtherStream->SetAbortStatus(RT_ERROR_NONE);
    abortOtherStream = nullptr;
    synchronizedStreams.clear();
    context_->SetCtxMode(previousFailureMode);
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_AUTO);
    EXPECT_EQ(rtStreamDestroy(secondHandle), RT_ERROR_NONE);
}

TEST_F(StreamSyncCallbackTest, UserSubscriptionResolvesToAutoWithoutChangingRoute)
{
    const uint64_t userTid = PidTidFetcher::GetCurrentUserTid();
    ASSERT_EQ(Runtime::Instance()->ApiImpl_()->SubscribeReport(userTid, stream_), RT_ERROR_NONE);
    const CallbackRoute before = ReadCallbackRoute(stream_);
    EXPECT_EQ(
        stream_->ResolveSyncScheduleMode(RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        static_cast<uint32_t>(RT_DEVICE_SCHEDULE_AUTO));
    MOCKER_CPP(&Stream::SynchronizeBlocking).expects(never());
    MOCKER_CPP_VIRTUAL(stream_, &Stream::SynchronizeExecutedTask)
        .expects(once())
        .with(any(), any(), any(), eq(static_cast<uint32_t>(RT_DEVICE_SCHEDULE_AUTO)))
        .will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(
        stream_->SynchronizeImpl(MAX_UINT32_NUM, MAX_UINT16_NUM, 1000, RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        RT_ERROR_NONE);
    EXPECT_EQ(stream_->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_USER);
    EXPECT_FALSE(context_->GetCallBackThreadExistFlag());
    ExpectSameRoute(before, ReadCallbackRoute(stream_));
    EXPECT_EQ(Runtime::Instance()->ApiImpl_()->UnSubscribeReport(userTid, stream_), RT_ERROR_NONE);
}

TEST_F(StreamSyncCallbackTest, EventWaitFromAnotherContextUsesAutoWithoutSubmittingCallback)
{
    Runtime* const runtime = Runtime::Instance();
    rtContext_t ownerContext = nullptr;
    ASSERT_EQ(rtCtxGetCurrent(&ownerContext), RT_ERROR_NONE);
    rtContext_t otherContext = nullptr;
    ASSERT_EQ(rtCtxCreate(&otherContext, RT_CTX_NORMAL_MODE, 1), RT_ERROR_NONE);
    const ScopeGuard restoreCurrentContext([&]() {
        EXPECT_EQ(rtCtxDestroy(otherContext), RT_ERROR_NONE);
        EXPECT_EQ(rtCtxSetCurrent(ownerContext), RT_ERROR_NONE);
    });
    ASSERT_EQ(rtCtxSetCurrent(otherContext), RT_ERROR_NONE);
    Context* const other = runtime->CurrentContext();
    ASSERT_NE(other, nullptr);
    ASSERT_NE(other, context_);
    ASSERT_NE(other->Device_(), stream_->Device_());
    ASSERT_EQ(rtCtxSetCurrent(ownerContext), RT_ERROR_NONE);
    ASSERT_TRUE(stream_->IsSeparateSendAndRecycle());

    const uint32_t previousMode = context_->GetDeviceFlags();
    const uint32_t previousLastTaskId = stream_->GetLastTaskId();
    const uint16_t previousExecuteEndTaskId = stream_->GetExecuteEndTaskId();
    const uint32_t previousTail = stream_->GetTaskPosTail();
    const uint32_t previousHead = stream_->GetTaskPosHead();
    const uint16_t previousConcernedTaskId = stream_->latestConcernedTaskId.Value();
    stream_->StreamRecycleLock();
    const ScopeGuard restoreStream([&]() {
        context_->SetDeviceFlags(previousMode);
        stream_->SetLastTaskId(previousLastTaskId);
        stream_->SetExecuteEndTaskId(previousExecuteEndTaskId);
        stream_->taskPosTail_.Set(previousTail);
        stream_->taskPosHead_.Set(previousHead);
        stream_->latestConcernedTaskId.Set(previousConcernedTaskId);
        stream_->StreamRecycleUnlock();
    });
    constexpr uint32_t recordTaskId = 3U;
    context_->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    stream_->SetLastTaskId(recordTaskId);
    stream_->SetExecuteEndTaskId(MAX_UINT16_NUM);
    stream_->taskPosTail_.Set(1U);
    stream_->taskPosHead_.Set(0U);
    stream_->latestConcernedTaskId.Set(MAX_UINT16_NUM);
    Event event(stream_->Device_(), RT_EVENT_WITH_FLAG, context_);
    RecordTaskInfo record{stream_->Id_(), recordTaskId, RECORDING, 0ULL};
    event.UpdateLatestRecord(record);
    ASSERT_EQ(event.GetLatestRecord().state, RECORDING);
    ASSERT_EQ(event.GetLatestRecord().taskId, stream_->GetLastTaskId());

    ASSERT_EQ(rtCtxSetCurrent(otherContext), RT_ERROR_NONE);
    ASSERT_EQ(runtime->CurrentContext(), other);
    EXPECT_EQ(
        stream_->ResolveSyncScheduleMode(RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
    MOCKER_CPP_VIRTUAL(runtime->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
    uint16_t completedHead = 1U;
    Device* const device = stream_->Device_();
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetSqHead)
        .expects(once())
        .with(eq(device->Id_()), eq(device->DevGetTsId()), eq(stream_->GetSqId()), outBound(completedHead))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(event.WaitTask(1000), RT_ERROR_NONE);
    EXPECT_EQ(runtime->CurrentContext(), other);
    EXPECT_EQ(context_->GetDeviceFlags(), static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
    EXPECT_EQ(stream_->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_NONE);
    EXPECT_FALSE(context_->GetCallBackThreadExistFlag());
    GlobalMockObject::verify();

    ASSERT_EQ(rtCtxSetCurrent(ownerContext), RT_ERROR_NONE);
    EXPECT_EQ(
        stream_->ResolveSyncScheduleMode(RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
}

TEST_F(StreamSyncCallbackTest, BlockReusesHostFuncRuntimeSubscription) { CheckRuntimeSubscriptionReuse(true); }

TEST_F(StreamSyncCallbackTest, HostFuncReusesBlockRuntimeSubscription) { CheckRuntimeSubscriptionReuse(false); }

TEST_F(StreamSyncCallbackTest, InternalNonBlockingLaunchBuildsNonBlockingTask)
{
    UseOriginalRuntimeSubscription();
    MOCKER_CPP(&ApiImpl::StarsLaunchEventProc).expects(never());
    MOCKER_CPP_VIRTUAL(stream_->Device_(), &Device::SubmitTask).expects(once()).will(invoke(InspectNonBlockingTask));
    uint32_t callbackCount = 0U;
    EXPECT_EQ(
        Runtime::Instance()->ApiImpl_()->LaunchHostFunc(stream_, CountCallback, &callbackCount, false),
        RT_ERROR_DRV_ERR);
    EXPECT_EQ(callbackCount, 0U);
    EXPECT_EQ(stream_->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_RUNTIME);
}

TEST_F(StreamSyncCallbackTest, SubscribeFailureDoesNotLaunchEitherCallbackKind)
{
    MOCKER(OsalFactory::CreateThread).expects(once()).will(invoke(CreateCallbackThread));
    MOCKER_CPP(&Runtime::SubscribeCallback).expects(exactly(2)).will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP(&ApiImpl::StarsLaunchEventProc).expects(never());
    MOCKER_CPP(&ApiImpl::CallbackLaunchWithoutEvent).expects(never());
    uint32_t callbackCount = 0U;
    Api* const api = Runtime::Instance()->ApiImpl_();
    EXPECT_EQ(api->LaunchHostFunc(stream_, CountCallback, &callbackCount), RT_ERROR_DRV_ERR);
    EXPECT_EQ(api->LaunchHostFunc(stream_, CountCallback, &callbackCount, false), RT_ERROR_DRV_ERR);
    EXPECT_EQ(stream_->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_NONE);
    EXPECT_EQ(callbackCount, 0U);
    EXPECT_EQ(callbackThreadStarts, 1U);
}

TEST_F(StreamSyncCallbackTest, TimeoutRetainsArgsUntilLateOriginalReportCompletes)
{
    UseOriginalRuntimeSubscription();
    MOCKER_CPP(&ApiImpl::CallbackLaunchWithoutEvent).expects(once()).will(invoke(CaptureNonBlockingCallback));
    ASSERT_EQ(stream_->SynchronizeBlocking(10), RT_ERROR_STREAM_SYNC_TIMEOUT);
    ASSERT_NE(pendingCallback, nullptr);
    ASSERT_NE(pendingArgs, nullptr);
    Device* const device = stream_->Device_();
    ASSERT_EQ(device->syncArgs_.size(), 1U);
    EXPECT_EQ(device->syncArgs_.front(), pendingArgs);
    EXPECT_EQ(pendingArgs->currentCnt, 0U);
    device->DestroySyncArgs(false);
    ASSERT_EQ(device->syncArgs_.size(), 1U);

    rtHostFuncCqReport_t report = {};
    report.hostFuncCbPtr = RtPtrToValue(pendingCallback);
    report.fnDataPtr = RtPtrToValue(pendingArgs);
    report.streamId = static_cast<uint16_t>(stream_->Id_());
    report.isBlock = 0U;
    callbackReport = &report;
    callbackCq = ReadCallbackRoute(stream_).cqId;
    MOCKER(PidTidFetcher::GetCurrentUserTid).stubs().will(returnValue(CALLBACK_THREAD_ID));
    Driver* const driver = device->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::CqReportIrqWait).expects(once()).will(invoke(SupplyCallbackIrq));
    MOCKER_CPP_VIRTUAL(driver, &Driver::CqReportGet).expects(once()).will(invoke(SupplyCallbackReport));
    MOCKER_CPP_VIRTUAL(driver, &Driver::SqCommandOccupy).expects(never());
    MOCKER_CPP_VIRTUAL(driver, &Driver::CqReportRelease).expects(once()).will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(Runtime::Instance()->ApiImpl_()->ProcessReport(0, true), RT_ERROR_NONE);
    EXPECT_EQ(pendingArgs->currentCnt, 1U);
    device->DestroySyncArgs(false);
    EXPECT_TRUE(device->syncArgs_.empty());
    pendingArgs = nullptr;
}

TEST_F(StreamSyncCallbackTest, EveryLaunchFailureReleasesArgsImmediately)
{
    Api* const api = Runtime::Instance()->ApiImpl_();
    Device* const device = stream_->Device_();
    for (const rtError_t error : {RT_ERROR_TASK_NEW, RT_ERROR_DRV_ERR}) {
        SCOPED_TRACE(error);
        launchError = error;
        MOCKER_CPP_VIRTUAL(api, &Api::LaunchHostFunc).expects(once()).will(invoke(CaptureFailedLaunch));
        MOCKER(DestroySyncFuncArgs).expects(once()).will(invoke(ReleaseFailedLaunchArgs));
        EXPECT_EQ(stream_->SynchronizeBlocking(1000), error);
        EXPECT_EQ(pendingArgs, nullptr);
        EXPECT_TRUE(device->syncArgs_.empty());
        device->DestroySyncArgs(false);
        EXPECT_TRUE(device->syncArgs_.empty());
        GlobalMockObject::verify();
    }
}

TEST_F(StreamSyncCallbackTest, DeviceDestructionCanReleaseUnreportedFailedArgs)
{
    UseOriginalRuntimeSubscription();
    MOCKER_CPP(&ApiImpl::CallbackLaunchWithoutEvent).expects(once()).will(invoke(CaptureNonBlockingCallback));
    EXPECT_EQ(stream_->SynchronizeBlocking(10), RT_ERROR_STREAM_SYNC_TIMEOUT);
    Device* const device = stream_->Device_();
    ASSERT_EQ(device->syncArgs_.size(), 1U);
    EXPECT_EQ(device->syncArgs_.front(), pendingArgs);
    device->DestroySyncArgs();
    EXPECT_TRUE(device->syncArgs_.empty());
    pendingArgs = nullptr;
}

TEST_F(StreamSyncCallbackTest, NonBlockingReportProcessesEntireBatch)
{
    UseOriginalRuntimeSubscription();
    MOCKER_CPP(&ApiImpl::StarsLaunchEventProc).expects(once()).will(returnValue(RT_ERROR_NONE));
    uint32_t callbackCount = 0U;
    ASSERT_EQ(Runtime::Instance()->ApiImpl_()->LaunchHostFunc(stream_, CountCallback, &callbackCount), RT_ERROR_NONE);
    rtHostFuncCqReport_t reports[2] = {};
    reports[0].hostFuncCbPtr = RtPtrToValue(CountCallback);
    reports[0].fnDataPtr = RtPtrToValue(&callbackCount);
    reports[1].hostFuncCbPtr = RtPtrToValue(CountCallback);
    reports[1].fnDataPtr = RtPtrToValue(&callbackCount);
    for (uint16_t index = 0U; index < 2U; ++index) {
        reports[index].streamId = static_cast<uint16_t>(stream_->Id_());
        reports[index].taskId = 11U + index;
        reports[index].isBlock = 0U;
    }
    callbackReport = reports;
    callbackCq = ReadCallbackRoute(stream_).cqId;
    MOCKER(PidTidFetcher::GetCurrentUserTid).stubs().will(returnValue(CALLBACK_THREAD_ID));
    Driver* const driver = stream_->Device_()->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::CqReportIrqWait).expects(once()).will(invoke(SupplyCallbackIrq));
    MOCKER_CPP_VIRTUAL(driver, &Driver::CqReportGet).expects(once()).will(invoke(SupplyTwoCallbackReports));
    MOCKER_CPP_VIRTUAL(driver, &Driver::SqCommandOccupy).expects(never());
    MOCKER_CPP_VIRTUAL(driver, &Driver::CqReportRelease).expects(exactly(2)).will(invoke(InspectReleasedReport));
    EXPECT_EQ(Runtime::Instance()->ApiImpl_()->ProcessReport(0, true), RT_ERROR_NONE);
    EXPECT_EQ(callbackCount, 2U);
    EXPECT_EQ(reports[1].hostFuncCbPtr, RtPtrToValue(CountCallback));
    ASSERT_EQ(releasedReports.size(), 2U);
    EXPECT_EQ(releasedReports[0].taskId, 11U);
    EXPECT_EQ(releasedReports[1].taskId, 12U);
    EXPECT_EQ(releasedReports[1].streamId, static_cast<uint16_t>(stream_->Id_()));
    EXPECT_EQ(releasedReports[1].fnDataPtr, RtPtrToValue(&callbackCount));
}
