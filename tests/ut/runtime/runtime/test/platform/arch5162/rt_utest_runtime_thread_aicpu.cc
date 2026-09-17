/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <cstring>
#include <string>

#include <gtest/gtest.h>
#include <mockcpp/mockcpp.hpp>

#define protected public
#define private public
#include "api_impl.hpp"
#include "context.hpp"
#include "event.hpp"
#include "kernel.hpp"
#include "raw_device.hpp"
#include "stream.hpp"
#include "stream_state_callback_manager.hpp"
#undef private
#undef protected

// This white-box translation unit owns the production implementation so that file-local adapter and hook behavior can
// be verified without adding test-only symbols to libruntime.so.
#include "runtime_thread_aicpu.cc"

namespace cce {
namespace runtime {
namespace {

struct PluginState {
    RuntimeThreadAicpuStatus queryStatus = RuntimeThreadAicpuStatus::OK;
    RuntimeThreadAicpuStatus prepareStatus = RuntimeThreadAicpuStatus::OK;
    bool returnNullApi = false;
    uint32_t prepareCalls = 0U;
    uint32_t releaseCalls = 0U;
    uint32_t streamDestroyedCalls = 0U;
    uint64_t releasedCookie = 0U;
    void* destroyedStream = nullptr;
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuRuntimeHooks hooks = {};
    RuntimeThreadAicpuPreparedKernel prepared = {};
};

PluginState g_plugin;
RuntimeThreadAicpuPluginApi g_pluginApi = {};
void* g_libraryHandle = reinterpret_cast<void*>(0x12345678ULL);

RuntimeThreadAicpuStatus FakePrepareKernel(
    const RuntimeThreadAicpuKernelRequest* const request, RuntimeThreadAicpuPreparedKernel* const prepared)
{
    ++g_plugin.prepareCalls;
    if (request != nullptr) {
        g_plugin.request = *request;
    }
    if (prepared != nullptr) {
        const uint32_t structSize = prepared->structSize;
        *prepared = g_plugin.prepared;
        prepared->structSize = structSize;
    }
    return g_plugin.prepareStatus;
}

void FakeReleasePreparedKernel(const uint64_t taskCookie)
{
    ++g_plugin.releaseCalls;
    g_plugin.releasedCookie = taskCookie;
}

void FakeStreamDestroyed(void* const streamHandle)
{
    ++g_plugin.streamDestroyedCalls;
    g_plugin.destroyedStream = streamHandle;
}

RuntimeThreadAicpuStatus FakeQueryPlugin(
    const RuntimeThreadAicpuRuntimeHooks* const hooks, const RuntimeThreadAicpuPluginApi** const pluginApi)
{
    if (hooks != nullptr) {
        g_plugin.hooks = *hooks;
    }
    if ((pluginApi != nullptr) && !g_plugin.returnNullApi) {
        *pluginApi = &g_pluginApi;
    }
    return g_plugin.queryStatus;
}

void* DlsymQueryPlugin(void* handle, const char* symbol)
{
    EXPECT_EQ(handle, g_libraryHandle);
    EXPECT_STREQ(symbol, "RuntimeThreadAicpuGetPluginApi");
    return reinterpret_cast<void*>(&FakeQueryPlugin);
}

char* NoDynamicLoadError() { return nullptr; }

char* DynamicLoadError()
{
    static char error[] = "injected dynamic loader failure";
    return error;
}

void DummyStreamStateCallback(rtStream_t stream, rtStreamState state, void* args)
{
    (void)stream;
    (void)state;
    (void)args;
}

class RuntimeThreadAicpuTestDevice final : public RawDevice {
public:
    explicit RuntimeThreadAicpuTestDevice(const uint32_t deviceId) : RawDevice(deviceId) {}

    uint32_t GetDevRunningState() override { return static_cast<uint32_t>(DEV_RUNNING_DOWN); }
};

class RuntimeThreadAicpuTestApiImpl final : public ApiImpl {
public:
    rtError_t EventCreate(Event** const event, const uint64_t flag) override
    {
        (void)flag;
        if (event != nullptr) {
            *event = createdEvent;
        }
        return eventCreateStatus;
    }

    rtError_t EventDestroy(Event* const event) override
    {
        destroyedEvent = event;
        ++eventDestroyCalls;
        return eventDestroyStatus;
    }

    Event* createdEvent = nullptr;
    Event* destroyedEvent = nullptr;
    rtError_t eventCreateStatus = RT_ERROR_NONE;
    rtError_t eventDestroyStatus = RT_ERROR_NONE;
    uint32_t eventDestroyCalls = 0U;
};

void FakeAicpuTaskInit(TaskInfo* const task, const uint16_t dimNum, const uint32_t flag)
{
    (void)dimNum;
    (void)flag;
    task->type = TS_TASK_TYPE_KERNEL_AICPU;
}

class RuntimeThreadAicpuRuntimeTest : public testing::Test {
protected:
    void SetUp() override
    {
        static Runtime* const testRuntime = new Runtime();
        Runtime::runtime_ = testRuntime;
        g_plugin = PluginState();
        g_pluginApi = {
            .structSize = sizeof(RuntimeThreadAicpuPluginApi),
            .prepareKernel = &FakePrepareKernel,
            .releasePreparedKernel = &FakeReleasePreparedKernel,
            .streamDestroyed = &FakeStreamDestroyed,
        };
        g_plugin.prepared.structSize = sizeof(RuntimeThreadAicpuPreparedKernel);
        g_plugin.prepared.callbackCqId = 23U;
        g_plugin.prepared.callbackGroupId = 7U;
        g_plugin.prepared.eventId = 31U;
        g_plugin.prepared.eventHandle = reinterpret_cast<void*>(0x77770000ULL);
        g_plugin.prepared.taskCookie = 0x1122334455667788ULL;
        g_plugin.prepared.funcPtr = 0x123456789ABCDEF0ULL;
        g_plugin.prepared.fnData = g_plugin.prepared.taskCookie;
        (void)StreamStateCallbackManager::Instance().RegStreamStateCallback(
            STREAM_OBSERVER_NAME, nullptr, nullptr, StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
    }

    void TearDown() override
    {
        (void)StreamStateCallbackManager::Instance().RegStreamStateCallback(
            STREAM_OBSERVER_NAME, nullptr, nullptr, StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
        GlobalMockObject::verify();
    }

    void MockSuccessfulDynamicLoad()
    {
        MOCKER(dlopen).stubs().will(returnValue(g_libraryHandle));
        MOCKER(dlsym).stubs().will(invoke(DlsymQueryPlugin));
        MOCKER(dlerror).stubs().will(invoke(NoDynamicLoadError));
    }
};

TEST_F(RuntimeThreadAicpuRuntimeTest, StatusConversionPreservesPublicSemantics)
{
    EXPECT_EQ(ToPluginStatus(RT_ERROR_NONE), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(ToPluginStatus(RT_ERROR_MEMORY_ALLOCATION), RuntimeThreadAicpuStatus::NO_MEMORY);
    EXPECT_EQ(ToPluginStatus(RT_ERROR_FEATURE_NOT_SUPPORT), RuntimeThreadAicpuStatus::NOT_SUPPORTED);
    EXPECT_EQ(ToPluginStatus(RT_ERROR_INVALID_VALUE), RuntimeThreadAicpuStatus::INVALID_PARAM);
    EXPECT_EQ(ToPluginStatus(RT_ERROR_STREAM_NULL), RuntimeThreadAicpuStatus::INVALID_PARAM);
    EXPECT_EQ(ToPluginStatus(RT_ERROR_DRV_ERR), RuntimeThreadAicpuStatus::RUNTIME_ERROR);

    EXPECT_EQ(ToRuntimeStatus(RuntimeThreadAicpuStatus::OK), RT_ERROR_NONE);
    EXPECT_EQ(ToRuntimeStatus(RuntimeThreadAicpuStatus::INVALID_PARAM), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(ToRuntimeStatus(RuntimeThreadAicpuStatus::NO_MEMORY), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_EQ(ToRuntimeStatus(RuntimeThreadAicpuStatus::NOT_SUPPORTED), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ToRuntimeStatus(RuntimeThreadAicpuStatus::SYMBOL_NOT_FOUND), RT_ERROR_SYMBOL_NOT_FOUND);
    EXPECT_EQ(ToRuntimeStatus(RuntimeThreadAicpuStatus::KERNEL_FAILED), RT_ERROR_AICPU_INTERNAL_ERROR);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, InternalGroupReservationKeepsAllocationAndWaitBitmapsConsistent)
{
    CbSubscribe subscribe(2U);
    uint32_t first = 0U;
    uint32_t second = 0U;
    uint32_t reused = 0U;
    EXPECT_EQ(subscribe.ReserveInternalGroupId(nullptr), RT_ERROR_INVALID_VALUE);
    ASSERT_EQ(subscribe.ReserveInternalGroupId(&first), RT_ERROR_NONE);
    ASSERT_EQ(subscribe.ReserveInternalGroupId(&second), RT_ERROR_NONE);
    EXPECT_NE(first, second);
    EXPECT_TRUE(subscribe.grpIdBitmap_.IsIdOccupied(first));
    EXPECT_TRUE(subscribe.grpIdWaitBitmap_.IsIdOccupied(first));
    EXPECT_EQ(subscribe.ReserveInternalGroupId(&reused), RT_ERROR_SUBSCRIBE_GROUP);
    subscribe.ReleaseInternalGroupId(first);
    EXPECT_FALSE(subscribe.grpIdBitmap_.IsIdOccupied(first));
    EXPECT_FALSE(subscribe.grpIdWaitBitmap_.IsIdOccupied(first));
    ASSERT_EQ(subscribe.ReserveInternalGroupId(&reused), RT_ERROR_NONE);
    EXPECT_EQ(reused, first);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, RuntimeHooksExposeExpectedFunctionsAndValidateEventArguments)
{
    ApiImpl api;
    const RuntimeThreadAicpuRuntimeHooks hooks = BuildRuntimeHooks(&api);
    EXPECT_EQ(hooks.structSize, sizeof(RuntimeThreadAicpuRuntimeHooks));
    EXPECT_EQ(hooks.runtimeData, &api);
    EXPECT_NE(hooks.reserveGroupId, nullptr);
    EXPECT_NE(hooks.releaseGroupId, nullptr);
    EXPECT_NE(hooks.createCompletionEvent, nullptr);
    EXPECT_NE(hooks.destroyCompletionEvent, nullptr);
    EXPECT_NE(hooks.setStreamError, nullptr);
    EXPECT_NE(hooks.monitorThreadEnter, nullptr);
    EXPECT_NE(hooks.monitorThreadExit, nullptr);
    EXPECT_NE(hooks.isProcessExiting, nullptr);
    EXPECT_EQ(CreateCompletionEvent(nullptr, nullptr, nullptr, nullptr), RuntimeThreadAicpuStatus::INVALID_PARAM);
    EXPECT_EQ(ReserveGroupId(nullptr, nullptr), RuntimeThreadAicpuStatus::INVALID_PARAM);
    DestroyCompletionEvent(nullptr, nullptr);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, RuntimeHooksReserveAndReleaseInternalGroup)
{
    Runtime* const runtime = Runtime::Instance();
    ASSERT_NE(runtime, nullptr);
    CbSubscribe subscribe(4U);
    runtime->cbSubscribe_ = &subscribe;
    uint32_t groupId = 0U;

    EXPECT_EQ(ReserveGroupId(nullptr, &groupId), RuntimeThreadAicpuStatus::OK);
    EXPECT_TRUE(subscribe.grpIdBitmap_.IsIdOccupied(groupId));
    EXPECT_TRUE(subscribe.grpIdWaitBitmap_.IsIdOccupied(groupId));
    ReleaseGroupId(nullptr, groupId);
    EXPECT_FALSE(subscribe.grpIdBitmap_.IsIdOccupied(groupId));
    EXPECT_FALSE(subscribe.grpIdWaitBitmap_.IsIdOccupied(groupId));

    runtime->cbSubscribe_ = nullptr;
    EXPECT_EQ(ReserveGroupId(nullptr, &groupId), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    ReleaseGroupId(nullptr, groupId);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, RuntimeHooksCreateAndDestroyCompletionEvent)
{
    RuntimeThreadAicpuTestApiImpl api;
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    InitEmbeddedInnerHandle(&stream);
    Event event(nullptr, RT_EVENT_DEFAULT, nullptr);
    event.SetEventId(17);
    api.createdEvent = &event;
    void* eventHandle = nullptr;
    uint32_t eventId = 0U;

    ASSERT_EQ(
        CreateCompletionEvent(&api, stream.GetInnerHandle(), &eventHandle, &eventId), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(eventHandle, &event);
    EXPECT_EQ(eventId, 17U);
    EXPECT_EQ(event.eventOwner_, EventOwner::EVENT_INNER);
    DestroyCompletionEvent(&api, eventHandle);
    EXPECT_EQ(api.eventDestroyCalls, 1U);
    EXPECT_EQ(api.destroyedEvent, &event);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, RuntimeHooksPropagateEventFailures)
{
    RuntimeThreadAicpuTestApiImpl api;
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    InitEmbeddedInnerHandle(&stream);
    Event event(nullptr, RT_EVENT_DEFAULT, nullptr);
    rtInnerObject invalidStreamHandle = {};
    InitializeInnerObject(invalidStreamHandle, RT_EVENT_MAGIC, &stream);
    void* eventHandle = nullptr;
    uint32_t eventId = 0U;

    EXPECT_EQ(
        CreateCompletionEvent(&api, &invalidStreamHandle, &eventHandle, &eventId),
        RuntimeThreadAicpuStatus::INVALID_PARAM);
    api.eventCreateStatus = RT_ERROR_MEMORY_ALLOCATION;
    EXPECT_EQ(
        CreateCompletionEvent(&api, stream.GetInnerHandle(), &eventHandle, &eventId),
        RuntimeThreadAicpuStatus::NO_MEMORY);

    api.createdEvent = &event;
    api.eventCreateStatus = RT_ERROR_NONE;
    EXPECT_EQ(
        CreateCompletionEvent(&api, stream.GetInnerHandle(), &eventHandle, &eventId),
        RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    EXPECT_EQ(api.eventDestroyCalls, 1U);
    EXPECT_EQ(api.destroyedEvent, &event);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, RuntimeHooksMaintainMonitorCountAndHandleMissingDevice)
{
    Runtime* const runtime = Runtime::Instance();
    ASSERT_NE(runtime, nullptr);
    const uint32_t monitorCount = runtime->monitorThreadNum_.Value();

    MonitorThreadEnter(nullptr);
    EXPECT_EQ(runtime->monitorThreadNum_.Value(), monitorCount + 1U);
    MonitorThreadExit(nullptr);
    EXPECT_EQ(runtime->monitorThreadNum_.Value(), monitorCount);
    SetStreamError(nullptr, 99U, 0U, 1U, 2U);
    (void)IsProcessExiting(nullptr);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, AdapterCachesUnsupportedWhenPluginCannotBeLoaded)
{
    MOCKER(dlopen).stubs().will(returnValue(static_cast<void*>(nullptr)));
    MOCKER(dlerror).stubs().will(invoke(DynamicLoadError));
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel prepared = {};
    EXPECT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, AdapterRejectsMissingQuerySymbol)
{
    MOCKER(dlopen).stubs().will(returnValue(g_libraryHandle));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void*>(nullptr)));
    MOCKER(dlerror).stubs().will(invoke(NoDynamicLoadError));
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel prepared = {};
    EXPECT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, AdapterValidatesPluginApiTable)
{
    MockSuccessfulDynamicLoad();
    g_plugin.returnNullApi = true;
    RuntimeThreadAicpuAdapter nullApiAdapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel prepared = {};
    EXPECT_EQ(nullApiAdapter.PrepareKernel(request, prepared), RT_ERROR_FEATURE_NOT_SUPPORT);
    GlobalMockObject::verify();

    MockSuccessfulDynamicLoad();
    g_plugin.returnNullApi = false;
    g_pluginApi.structSize = sizeof(g_pluginApi) - 1U;
    RuntimeThreadAicpuAdapter shortApiAdapter(nullptr);
    EXPECT_EQ(shortApiAdapter.PrepareKernel(request, prepared), RT_ERROR_FEATURE_NOT_SUPPORT);
    GlobalMockObject::verify();

    MockSuccessfulDynamicLoad();
    g_pluginApi.structSize = sizeof(g_pluginApi);
    g_pluginApi.releasePreparedKernel = nullptr;
    RuntimeThreadAicpuAdapter missingFunctionAdapter(nullptr);
    EXPECT_EQ(missingFunctionAdapter.PrepareKernel(request, prepared), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, AdapterPropagatesPrepareAndForwardsLifecycleCalls)
{
    MockSuccessfulDynamicLoad();
    RuntimeThreadAicpuAdapter adapter(reinterpret_cast<Api*>(0x13570000ULL));
    RuntimeThreadAicpuKernelRequest request = {};
    request.structSize = sizeof(request);
    RuntimeThreadAicpuPreparedKernel prepared = {};
    prepared.structSize = sizeof(prepared);
    ASSERT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_NONE);
    EXPECT_EQ(g_plugin.prepareCalls, 1U);
    EXPECT_EQ(g_plugin.hooks.runtimeData, reinterpret_cast<void*>(0x13570000ULL));
    EXPECT_EQ(prepared.taskCookie, g_plugin.prepared.taskCookie);

    g_plugin.prepareStatus = RuntimeThreadAicpuStatus::SYMBOL_NOT_FOUND;
    EXPECT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_SYMBOL_NOT_FOUND);
    adapter.ReleasePreparedKernel(99U);
    EXPECT_EQ(g_plugin.releaseCalls, 1U);
    EXPECT_EQ(g_plugin.releasedCookie, 99U);
    void* const streamHandle = reinterpret_cast<void*>(0x24680000ULL);
    adapter.StreamDestroyed(streamHandle);
    EXPECT_EQ(g_plugin.streamDestroyedCalls, 1U);
    EXPECT_EQ(g_plugin.destroyedStream, streamHandle);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, AdapterReportsDuplicateObserverRegistration)
{
    ASSERT_EQ(
        StreamStateCallbackManager::Instance().RegStreamStateCallback(
            STREAM_OBSERVER_NAME, RtPtrToPtr<void*>(&DummyStreamStateCallback), nullptr,
            StreamStateCallback::RTS_STREAM_STATE_CALLBACK),
        RT_ERROR_NONE);
    MockSuccessfulDynamicLoad();
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel prepared = {};
    EXPECT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_INVALID_VALUE);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, StreamObserverForwardsDestroyNotification)
{
    MockSuccessfulDynamicLoad();
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel prepared = {};
    ASSERT_EQ(adapter.PrepareKernel(request, prepared), RT_ERROR_NONE);
    const auto callbackIt = StreamStateCallbackManager::Instance().callbackMap_.find(STREAM_OBSERVER_NAME);
    ASSERT_NE(callbackIt, StreamStateCallbackManager::Instance().callbackMap_.end());
    void* const streamHandle = reinterpret_cast<void*>(0x24680000ULL);
    callbackIt->second.callbackV2(
        RtPtrToPtr<rtStream_t>(streamHandle), RT_STREAM_STATE_DESTROY_PRE, callbackIt->second.args);
    EXPECT_EQ(g_plugin.streamDestroyedCalls, 1U);
    EXPECT_EQ(g_plugin.destroyedStream, streamHandle);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, SubmitRejectsIncompletePreparedPayloadAndReleasesCookie)
{
    MockSuccessfulDynamicLoad();
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel initialized = {};
    ASSERT_EQ(adapter.PrepareKernel(request, initialized), RT_ERROR_NONE);
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    RuntimeThreadAicpuPreparedKernel invalid = g_plugin.prepared;
    invalid.funcPtr = 0U;
    EXPECT_EQ(SubmitAicpuTask(adapter, &stream, invalid), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(g_plugin.releaseCalls, 1U);
    EXPECT_EQ(g_plugin.releasedCookie, invalid.taskCookie);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, SubmitInitializesRuntimeThreadPayloadAndTransfersTaskOwnership)
{
    MockSuccessfulDynamicLoad();
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel initialized = {};
    ASSERT_EQ(adapter.PrepareKernel(request, initialized), RT_ERROR_NONE);
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    TaskInfo task = {};
    task.stream = &stream;
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(&task));
    MOCKER(AicpuTaskInit).stubs().will(invoke(FakeAicpuTaskInit));
    MOCKER_CPP_VIRTUAL(static_cast<RawDevice*>(&device), &RawDevice::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    ASSERT_EQ(SubmitAicpuTask(adapter, &stream, g_plugin.prepared), RT_ERROR_NONE);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICPU);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.funcPtr, g_plugin.prepared.funcPtr);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.fnData, g_plugin.prepared.fnData);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.callbackCqId, g_plugin.prepared.callbackCqId);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.callbackGroupId, g_plugin.prepared.callbackGroupId);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.eventId, g_plugin.prepared.eventId);
    EXPECT_EQ(g_plugin.releaseCalls, 0U);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, SubmitRecyclesAndReleasesOnDriverFailure)
{
    MockSuccessfulDynamicLoad();
    RuntimeThreadAicpuAdapter adapter(nullptr);
    RuntimeThreadAicpuKernelRequest request = {};
    RuntimeThreadAicpuPreparedKernel initialized = {};
    ASSERT_EQ(adapter.PrepareKernel(request, initialized), RT_ERROR_NONE);
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    TaskFactory taskFactory(&device);
    device.taskFactory_ = &taskFactory;
    TaskInfo task = {};
    task.stream = &stream;
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(&task));
    MOCKER(AicpuTaskInit).stubs().will(invoke(FakeAicpuTaskInit));
    MOCKER_CPP_VIRTUAL(static_cast<RawDevice*>(&device), &RawDevice::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP(&TaskFactory::Recycle).stubs().will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(SubmitAicpuTask(adapter, &stream, g_plugin.prepared), RT_ERROR_DRV_ERR);
    EXPECT_EQ(g_plugin.releaseCalls, 1U);
    device.taskFactory_ = nullptr;
}

TEST_F(RuntimeThreadAicpuRuntimeTest, PublicLaunchValidatesArgumentsAndCaptureState)
{
    rtCpuKernelArgs_t args = {};
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    Kernel kernel("libcpu.so", "CpuKernel", "CpuOp");
    EXPECT_EQ(LaunchRuntimeThreadAicpuKernel(nullptr, &kernel, 1U, &args, &stream), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(
        LaunchRuntimeThreadAicpuKernel(reinterpret_cast<Api*>(1U), nullptr, 1U, &args, &stream),
        RT_ERROR_INVALID_VALUE);
    stream.SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    EXPECT_EQ(
        LaunchRuntimeThreadAicpuKernel(reinterpret_cast<Api*>(1U), &kernel, 1U, &args, &stream),
        RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, PublicLaunchBuildsRequestAndCompletesEventProtocol)
{
    MockSuccessfulDynamicLoad();
    static ApiImpl api;
    RuntimeThreadAicpuTestDevice device(3U);
    Stream stream(&device, 0U);
    Kernel kernel("libcpu_kernel.so", "CpuKernelEntry", "TestCpuOp");
    kernel.SetAicpuKernelType_(static_cast<uint32_t>(KERNEL_TYPE_AICPU));
    Event event(nullptr, RT_EVENT_DEFAULT, nullptr);
    g_plugin.prepared.eventHandle = &event;

    uint8_t argsBuffer[32] = {};
    rtCpuKernelArgs_t args = {};
    args.baseArgs.args = argsBuffer;
    args.baseArgs.argsSize = sizeof(argsBuffer);
    args.cpuParamHeadOffset = 8U;
    args.baseArgs.soNameAddrOffset = 12U;
    args.baseArgs.kernelNameAddrOffset = 20U;
    TaskInfo task = {};
    task.stream = &stream;
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(&task));
    MOCKER(AicpuTaskInit).stubs().will(invoke(FakeAicpuTaskInit));
    MOCKER_CPP_VIRTUAL(static_cast<RawDevice*>(&device), &RawDevice::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Event::Wait).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Event::Reset).stubs().will(returnValue(RT_ERROR_NONE));

    ASSERT_EQ(LaunchRuntimeThreadAicpuKernel(&api, &kernel, 4U, &args, &stream), RT_ERROR_NONE);
    EXPECT_EQ(g_plugin.prepareCalls, 1U);
    EXPECT_EQ(g_plugin.request.structSize, sizeof(RuntimeThreadAicpuKernelRequest));
    EXPECT_EQ(g_plugin.request.kernelType, static_cast<uint32_t>(KERNEL_TYPE_AICPU));
    EXPECT_EQ(g_plugin.request.blockDim, 4U);
    EXPECT_EQ(g_plugin.request.deviceId, device.Id_());
    EXPECT_EQ(g_plugin.request.tsId, device.DevGetTsId());
    EXPECT_EQ(g_plugin.request.streamId, static_cast<uint32_t>(stream.Id_()));
    EXPECT_EQ(g_plugin.request.streamHandle, stream.GetInnerHandle());
    EXPECT_STREQ(g_plugin.request.soName, "libcpu_kernel.so");
    EXPECT_STREQ(g_plugin.request.functionName, "CpuKernelEntry");
    EXPECT_STREQ(g_plugin.request.opType, "TestCpuOp");
    EXPECT_EQ(g_plugin.request.args, argsBuffer);
    EXPECT_EQ(g_plugin.request.argsSize, sizeof(argsBuffer));
    EXPECT_EQ(g_plugin.request.cpuParamHeadOffset, 8U);
    EXPECT_EQ(g_plugin.request.soNameAddrOffset, 12U);
    EXPECT_EQ(g_plugin.request.kernelNameAddrOffset, 20U);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.funcPtr, g_plugin.prepared.funcPtr);
    EXPECT_EQ(task.u.aicpuTaskInfo.extraInfo.runtimeThread.fnData, g_plugin.prepared.fnData);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, PublicLaunchPropagatesWaitAndResetFailures)
{
    MockSuccessfulDynamicLoad();
    static ApiImpl api;
    RuntimeThreadAicpuTestDevice device(0U);
    Stream stream(&device, 0U);
    Kernel kernel("libcpu.so", "CpuKernel", "CpuOp");
    kernel.SetAicpuKernelType_(static_cast<uint32_t>(KERNEL_TYPE_AICPU));
    Event event(nullptr, RT_EVENT_DEFAULT, nullptr);
    g_plugin.prepared.eventHandle = &event;
    rtCpuKernelArgs_t args = {};
    TaskInfo task = {};
    task.stream = &stream;
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(&task));
    MOCKER(AicpuTaskInit).stubs().will(invoke(FakeAicpuTaskInit));
    MOCKER_CPP_VIRTUAL(static_cast<RawDevice*>(&device), &RawDevice::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Event::Wait).stubs().will(returnValue(RT_ERROR_DRV_ERR)).then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Event::Reset).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(LaunchRuntimeThreadAicpuKernel(&api, &kernel, 1U, &args, &stream), RT_ERROR_DRV_ERR);
    EXPECT_EQ(LaunchRuntimeThreadAicpuKernel(&api, &kernel, 1U, &args, &stream), RT_ERROR_DRV_ERR);
    EXPECT_EQ(g_plugin.prepareCalls, 2U);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, CpuKernelLaunchExValidatesKernelContract)
{
    ApiImpl api;
    Kernel kernel("libcpu.so", "CpuKernel", "CpuOp");
    rtCpuKernelArgs_t args = {};
    TaskCfg taskCfg = {};
    EXPECT_EQ(api.CpuKernelLaunchEx(nullptr, 1U, &args, taskCfg, nullptr, 0U), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(api.CpuKernelLaunchEx(&kernel, 1U, nullptr, taskCfg, nullptr, 0U), RT_ERROR_INVALID_VALUE);
    kernel.SetAicpuKernelType_(static_cast<uint32_t>(KERNEL_TYPE_AICPU_CUSTOM));
    EXPECT_EQ(api.CpuKernelLaunchEx(&kernel, 1U, &args, taskCfg, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, CpuKernelLaunchExValidatesContextAndStream)
{
    ApiImpl api;
    Kernel kernel("libcpu.so", "CpuKernel", "CpuOp");
    kernel.SetAicpuKernelType_(static_cast<uint32_t>(KERNEL_TYPE_AICPU));
    rtCpuKernelArgs_t args = {};
    TaskCfg taskCfg = {};
    RuntimeThreadAicpuTestDevice device(0U);
    Context context(&device, false);
    Stream stream(&device, 0U);

    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(static_cast<Context*>(nullptr)));
    EXPECT_EQ(api.CpuKernelLaunchEx(&kernel, 1U, &args, taskCfg, &stream, 0U), RT_ERROR_CONTEXT_NULL);
    GlobalMockObject::verify();

    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
    EXPECT_EQ(api.CpuKernelLaunchEx(&kernel, 1U, &args, taskCfg, nullptr, 0U), RT_ERROR_STREAM_NULL);
    EXPECT_EQ(api.CpuKernelLaunchEx(&kernel, 1U, &args, taskCfg, &stream, 0U), RT_ERROR_STREAM_CONTEXT);
}

TEST_F(RuntimeThreadAicpuRuntimeTest, CpuKernelLaunchExRoutesAicpuKernelToRuntimeThreadFeature)
{
    ApiImpl api;
    Kernel kernel("libcpu.so", "CpuKernel", "CpuOp");
    kernel.SetAicpuKernelType_(static_cast<uint32_t>(KERNEL_TYPE_AICPU));
    rtCpuKernelArgs_t args = {};
    TaskCfg taskCfg = {};
    RuntimeThreadAicpuTestDevice device(0U);
    Context context(&device, false);
    Stream stream(&device, 0U);
    stream.SetContext(&context);
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
    MOCKER(LaunchRuntimeThreadAicpuKernel).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(api.CpuKernelLaunchEx(&kernel, 5U, &args, taskCfg, &stream, 0U), RT_ERROR_DRV_ERR);
}

} // namespace
} // namespace runtime
} // namespace cce
