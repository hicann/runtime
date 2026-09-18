/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <array>
#include <atomic>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <limits>
#include <memory>
#include <string>
#include <thread>
#include <unordered_map>
#include <vector>

#include <gtest/gtest.h>

#define private public
#include "runtime_thread_aicpu_service.hpp"
#include "runtime_thread_aicpu_so_manager.hpp"
#undef private

#include "aicpu_context.h"
#include "driver/ascend_hal.h"
#include "runtime/runtime/kernel.h"

namespace {

using cce::runtime_thread_aicpu::RuntimeThreadAicpuService;
using cce::runtime_thread_aicpu::SoManager;

constexpr uint32_t DEVICE_ID = 3U;
constexpr uint32_t TS_ID = 2U;
constexpr uint32_t STREAM_ID = 17U;
constexpr uint32_t GROUP_ID = 9U;
constexpr uint32_t SQ_ID = 13U;
constexpr uint32_t CQ_ID = 65U;
constexpr uint32_t EVENT_ID = 21U;

struct TestCallbackReport {
    volatile uint16_t phase : 1;
    volatile uint16_t sop : 1;
    volatile uint16_t mop : 1;
    volatile uint16_t eop : 1;
    volatile uint16_t cqId : 12;
    volatile uint16_t streamId;
    volatile uint16_t taskId;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t sequenceId;
    volatile uint8_t isBlock;
    volatile uint8_t reserved;
    volatile uint16_t eventId;
    volatile uint64_t funcPtr;
    volatile uint64_t fnData;
};

struct TestCallbackRecordCommand {
    uint32_t pid;
    uint8_t commandType;
    uint8_t vfId;
    uint8_t tid;
    uint8_t tsId;
    uint16_t streamId;
    uint16_t recordId;
    uint16_t taskId;
    uint16_t reserved;
    uint32_t reserved1[12];
};

struct TestBlockInfo {
    uint32_t blockNum;
    uint32_t blockId;
};

static_assert(sizeof(TestCallbackReport) == 32U, "test callback report layout must match driver ABI");
static_assert(sizeof(TestCallbackRecordCommand) == 64U, "test callback command layout must match driver ABI");

struct DriverState {
    drvError_t allocateResult = DRV_ERROR_NONE;
    drvError_t freeResult = DRV_ERROR_NONE;
    drvError_t memoryGetResult = DRV_ERROR_NONE;
    drvError_t messageSendResult = DRV_ERROR_NONE;
    drvError_t waitResult = DRV_ERROR_WAIT_TIMEOUT;
    drvError_t reportGetResult = DRV_ERROR_NONE;
    drvError_t reportReleaseResult = DRV_ERROR_NONE;
    uint32_t allocateCalls = 0U;
    uint32_t freeCalls = 0U;
    uint32_t memoryGetCalls = 0U;
    uint32_t messageSendCalls = 0U;
    uint32_t waitCalls = 0U;
    uint32_t reportGetCalls = 0U;
    uint32_t reportReleaseCalls = 0U;
    uint32_t allocatedSqId = SQ_ID;
    uint32_t allocatedCqId = CQ_ID;
    uint32_t memoryCommandCount = 1U;
    uint32_t reportCount = 0U;
    bool provideCommand = true;
    bool setExpectedCqBit = false;
    halSqCqInputInfo allocateInput = {};
    halSqCqFreeInfo freeInput = {};
    halSqMemGetInput memoryGetInput = {};
    halSqMsgInfo messageSendInput = {};
    halReportInfoInput waitInput = {};
    halReportGetInput reportGetInput = {};
    halReportReleaseInfo reportReleaseInput = {};
    TestCallbackRecordCommand command = {};
    std::array<TestCallbackReport, 2U> reports = {};
};

DriverState g_driver;

struct HookState {
    RuntimeThreadAicpuStatus reserveResult = RuntimeThreadAicpuStatus::OK;
    RuntimeThreadAicpuStatus createEventResult = RuntimeThreadAicpuStatus::OK;
    uint32_t reserveCalls = 0U;
    uint32_t releaseCalls = 0U;
    uint32_t createEventCalls = 0U;
    uint32_t destroyEventCalls = 0U;
    uint32_t streamErrorCalls = 0U;
    uint32_t monitorEnterCalls = 0U;
    uint32_t monitorExitCalls = 0U;
    uint32_t releasedGroupId = 0U;
    uint32_t streamErrorDeviceId = 0U;
    uint32_t streamErrorTsId = 0U;
    uint32_t streamErrorStreamId = 0U;
    uint32_t streamExecuteResult = 0U;
    void* eventHandle = reinterpret_cast<void*>(0x12340000ULL);
    uint32_t eventId = EVENT_ID;
    void* destroyedEventHandle = nullptr;
    std::atomic<bool> processExiting{true};
};

struct ContextState {
    uint32_t setContextCalls = 0U;
    uint32_t setTaskCalls = 0U;
    uint32_t setOpCalls = 0U;
    uint32_t setBlockCalls = 0U;
    aicpu::aicpuContext_t context = {};
    uint64_t taskId = 0U;
    uint32_t streamId = 0U;
    std::string opName;
    std::vector<TestBlockInfo> blocks;
};

ContextState g_context;
uint32_t g_kernelCalls = 0U;
uint32_t g_kernelResult = 0U;
void* g_kernelArgument = nullptr;
std::vector<TestBlockInfo> g_kernelBlocks;

RuntimeThreadAicpuStatus ReserveGroupId(void* runtimeData, uint32_t* groupId)
{
    auto* const state = static_cast<HookState*>(runtimeData);
    ++state->reserveCalls;
    if (state->reserveResult == RuntimeThreadAicpuStatus::OK) {
        *groupId = GROUP_ID;
    }
    return state->reserveResult;
}

void ReleaseGroupId(void* runtimeData, const uint32_t groupId)
{
    auto* const state = static_cast<HookState*>(runtimeData);
    ++state->releaseCalls;
    state->releasedGroupId = groupId;
}

RuntimeThreadAicpuStatus CreateCompletionEvent(
    void* runtimeData, void* streamHandle, void** eventHandle, uint32_t* eventId)
{
    (void)streamHandle;
    auto* const state = static_cast<HookState*>(runtimeData);
    ++state->createEventCalls;
    if (state->createEventResult == RuntimeThreadAicpuStatus::OK) {
        *eventHandle = state->eventHandle;
        *eventId = state->eventId;
    }
    return state->createEventResult;
}

void DestroyCompletionEvent(void* runtimeData, void* eventHandle)
{
    auto* const state = static_cast<HookState*>(runtimeData);
    ++state->destroyEventCalls;
    state->destroyedEventHandle = eventHandle;
}

void SetStreamError(
    void* runtimeData, const uint32_t deviceId, const uint32_t tsId, const uint32_t streamId,
    const uint32_t executeResult)
{
    auto* const state = static_cast<HookState*>(runtimeData);
    ++state->streamErrorCalls;
    state->streamErrorDeviceId = deviceId;
    state->streamErrorTsId = tsId;
    state->streamErrorStreamId = streamId;
    state->streamExecuteResult = executeResult;
}

void MonitorThreadEnter(void* runtimeData) { ++static_cast<HookState*>(runtimeData)->monitorEnterCalls; }

void MonitorThreadExit(void* runtimeData) { ++static_cast<HookState*>(runtimeData)->monitorExitCalls; }

bool IsProcessExiting(void* runtimeData) { return static_cast<HookState*>(runtimeData)->processExiting.load(); }

RuntimeThreadAicpuRuntimeHooks MakeHooks(HookState& state)
{
    return {
        .structSize = sizeof(RuntimeThreadAicpuRuntimeHooks),
        .runtimeData = &state,
        .reserveGroupId = &ReserveGroupId,
        .releaseGroupId = &ReleaseGroupId,
        .createCompletionEvent = &CreateCompletionEvent,
        .destroyCompletionEvent = &DestroyCompletionEvent,
        .setStreamError = &SetStreamError,
        .monitorThreadEnter = &MonitorThreadEnter,
        .monitorThreadExit = &MonitorThreadExit,
        .isProcessExiting = &IsProcessExiting,
    };
}

RuntimeThreadAicpuKernelRequest MakeRequest(const void* args = nullptr, const uint64_t argsSize = 0U)
{
    RuntimeThreadAicpuKernelRequest request = {
        .structSize = sizeof(RuntimeThreadAicpuKernelRequest),
        .kernelType = static_cast<uint32_t>(KERNEL_TYPE_AICPU),
        .blockDim = 1U,
        .deviceId = DEVICE_ID,
        .tsId = TS_ID,
        .streamId = STREAM_ID,
        .streamHandle = reinterpret_cast<void*>(0x56780000ULL),
        .soName = "libtest_aicpu.so",
        .functionName = "TestKernel",
        .opType = "TestOp",
        .args = args,
        .argsSize = argsSize,
        .cpuParamHeadOffset = 0U,
        .soNameAddrOffset = 0U,
        .kernelNameAddrOffset = 0U,
    };
    return request;
}

RuntimeThreadAicpuService::KernelContext MakeContext(
    const std::string& functionName = "TestKernel", const uint32_t blockDim = 1U)
{
    RuntimeThreadAicpuService::KernelContext context;
    context.soName = "libtest_aicpu.so";
    context.functionName = functionName;
    context.opType = "TestOp";
    context.args = {0x11U, 0x22U, 0x33U};
    context.cpuParamHeadOffset = 1U;
    context.blockDim = blockDim;
    context.deviceId = DEVICE_ID;
    context.streamId = STREAM_ID;
    context.taskId = 31U;
    return context;
}

uint32_t TestKernel(void* args)
{
    ++g_kernelCalls;
    g_kernelArgument = args;
    return g_kernelResult;
}

uint32_t TestKernelWithBlock(void* args, void* blockData)
{
    ++g_kernelCalls;
    g_kernelArgument = args;
    g_kernelBlocks.push_back(*static_cast<TestBlockInfo*>(blockData));
    return g_kernelResult;
}

void CacheFunction(RuntimeThreadAicpuService& service, const std::string& functionName, void* function)
{
    service.soManager_.functions_[std::string("libtest_aicpu.so\n") + functionName] = function;
}

class RuntimeThreadAicpuTest : public testing::Test {
protected:
    void SetUp() override
    {
        g_driver = DriverState();
        g_context = ContextState();
        g_kernelCalls = 0U;
        g_kernelResult = 0U;
        g_kernelArgument = nullptr;
        g_kernelBlocks.clear();
        cce::runtime_thread_aicpu::SetRuntimeThreadAicpuService(nullptr);
        unsetenv("RUNTIME_THREAD_AICPU_SO_PATH");
    }

    void TearDown() override
    {
        cce::runtime_thread_aicpu::SetRuntimeThreadAicpuService(nullptr);
        unsetenv("RUNTIME_THREAD_AICPU_SO_PATH");
    }
};

TEST_F(RuntimeThreadAicpuTest, SoManagerValidatesInputAndResolvesPath)
{
    SoManager manager;
    void* function = nullptr;
    std::string detail;
    EXPECT_EQ(manager.GetFunction("", "malloc", &function, detail), RuntimeThreadAicpuStatus::INVALID_PARAM);
    EXPECT_FALSE(detail.empty());
    EXPECT_EQ(manager.ResolvePath("libc.so.6"), "libc.so.6");

    ASSERT_EQ(setenv("RUNTIME_THREAD_AICPU_SO_PATH", "/opt/aicpu", 1), 0);
    EXPECT_EQ(manager.ResolvePath("libop.so"), "/opt/aicpu/libop.so");
    EXPECT_EQ(manager.ResolvePath("/usr/lib/libop.so"), "/usr/lib/libop.so");
}

TEST_F(RuntimeThreadAicpuTest, SoManagerLoadsAndCachesFunctions)
{
    SoManager manager;
    void* first = nullptr;
    void* second = nullptr;
    void* freeFunction = nullptr;
    std::string detail;
    ASSERT_EQ(manager.GetFunction("libc.so.6", "malloc", &first, detail), RuntimeThreadAicpuStatus::OK);
    ASSERT_NE(first, nullptr);
    EXPECT_EQ(manager.GetFunction("libc.so.6", "malloc", &second, detail), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(second, first);
    EXPECT_EQ(manager.GetFunction("libc.so.6", "free", &freeFunction, detail), RuntimeThreadAicpuStatus::OK);
    EXPECT_NE(freeFunction, nullptr);
    EXPECT_EQ(manager.handles_.size(), 1U);
    EXPECT_EQ(manager.functions_.size(), 2U);
}

TEST_F(RuntimeThreadAicpuTest, SoManagerReportsLoadAndSymbolFailures)
{
    SoManager manager;
    void* function = nullptr;
    std::string detail;
    EXPECT_EQ(
        manager.GetFunction("lib_runtime_thread_aicpu_missing.so", "Kernel", &function, detail),
        RuntimeThreadAicpuStatus::OPEN_SO_FAILED);
    EXPECT_FALSE(detail.empty());
    EXPECT_EQ(
        manager.GetFunction("libc.so.6", "RuntimeThreadAicpuMissingSymbol", &function, detail),
        RuntimeThreadAicpuStatus::SYMBOL_NOT_FOUND);
    EXPECT_FALSE(detail.empty());
}

TEST_F(RuntimeThreadAicpuTest, AllocateAndReleaseCallbackChannel)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.deviceId_ = DEVICE_ID;
    service.tsId_ = TS_ID;
    service.groupId_ = GROUP_ID;
    ASSERT_EQ(service.AllocateCallbackChannel(), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(service.callbackSqId_, SQ_ID);
    EXPECT_EQ(service.callbackCqId_, CQ_ID);
    EXPECT_EQ(g_driver.allocateInput.type, DRV_CALLBACK_TYPE);
    EXPECT_EQ(g_driver.allocateInput.grpId, GROUP_ID);
    EXPECT_EQ(g_driver.allocateInput.sqeDepth, 1U);
    EXPECT_EQ(g_driver.allocateInput.cqeDepth, 512U);

    service.ReleaseCallbackChannel();
    EXPECT_EQ(g_driver.freeCalls, 1U);
    EXPECT_EQ(g_driver.freeInput.sqId, SQ_ID);
    EXPECT_EQ(g_driver.freeInput.cqId, CQ_ID);
    EXPECT_EQ(service.callbackSqId_, 0U);
    EXPECT_EQ(service.callbackCqId_, 0U);
}

TEST_F(RuntimeThreadAicpuTest, CallbackChannelDriverFailuresAreHandled)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.deviceId_ = DEVICE_ID;
    service.tsId_ = TS_ID;
    service.groupId_ = GROUP_ID;
    g_driver.allocateResult = static_cast<drvError_t>(1);
    EXPECT_EQ(service.AllocateCallbackChannel(), RuntimeThreadAicpuStatus::RUNTIME_ERROR);

    service.callbackSqId_ = SQ_ID;
    service.callbackCqId_ = CQ_ID;
    g_driver.freeResult = static_cast<drvError_t>(1);
    service.ReleaseCallbackChannel();
    EXPECT_EQ(service.callbackSqId_, 0U);
    EXPECT_EQ(service.callbackCqId_, 0U);
}

TEST_F(RuntimeThreadAicpuTest, EnsureStartedValidatesHooksAndRollsBackFailures)
{
    HookState state;
    RuntimeThreadAicpuRuntimeHooks invalidHooks = MakeHooks(state);
    invalidHooks.reserveGroupId = nullptr;
    RuntimeThreadAicpuService invalidService(invalidHooks);
    EXPECT_EQ(invalidService.EnsureStarted(MakeRequest()), RuntimeThreadAicpuStatus::INVALID_PARAM);

    state.reserveResult = RuntimeThreadAicpuStatus::NO_MEMORY;
    RuntimeThreadAicpuService reserveFailure(MakeHooks(state));
    EXPECT_EQ(reserveFailure.EnsureStarted(MakeRequest()), RuntimeThreadAicpuStatus::NO_MEMORY);
    EXPECT_EQ(reserveFailure.deviceId_, 0U);

    HookState allocateState;
    g_driver.allocateResult = static_cast<drvError_t>(1);
    RuntimeThreadAicpuService allocateFailure(MakeHooks(allocateState));
    EXPECT_EQ(allocateFailure.EnsureStarted(MakeRequest()), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    EXPECT_EQ(allocateState.releaseCalls, 1U);
    EXPECT_EQ(allocateFailure.groupId_, 0U);
}

TEST_F(RuntimeThreadAicpuTest, EnsureStartedCreatesOneReusableWorker)
{
    HookState state;
    state.processExiting.store(true);
    RuntimeThreadAicpuService service(MakeHooks(state));
    const RuntimeThreadAicpuKernelRequest request = MakeRequest();
    ASSERT_EQ(service.EnsureStarted(request), RuntimeThreadAicpuStatus::OK);
    ASSERT_TRUE(service.worker_.joinable());
    service.worker_.join();
    EXPECT_TRUE(service.started_);
    EXPECT_EQ(state.reserveCalls, 1U);
    EXPECT_EQ(state.monitorEnterCalls, 1U);
    EXPECT_EQ(state.monitorExitCalls, 1U);
    EXPECT_EQ(service.EnsureStarted(request), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(state.reserveCalls, 1U);

    RuntimeThreadAicpuKernelRequest otherDevice = request;
    otherDevice.deviceId = DEVICE_ID + 1U;
    EXPECT_EQ(service.EnsureStarted(otherDevice), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    service.ReleaseCallbackChannel();
    ReleaseGroupId(&state, GROUP_ID);
}

TEST_F(RuntimeThreadAicpuTest, EnsureStartedRejectsFailedWorker)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.failed_.store(true);
    EXPECT_EQ(service.EnsureStarted(MakeRequest()), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
}

TEST_F(RuntimeThreadAicpuTest, CompletionEventIsCachedAndDestroyedWithStream)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    RuntimeThreadAicpuService::EventEntry first;
    RuntimeThreadAicpuService::EventEntry second;
    void* const stream = reinterpret_cast<void*>(0x88ULL);
    ASSERT_EQ(service.GetOrCreateEvent(stream, STREAM_ID, first), RuntimeThreadAicpuStatus::OK);
    ASSERT_EQ(service.GetOrCreateEvent(stream, STREAM_ID, second), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(state.createEventCalls, 1U);
    EXPECT_EQ(second.eventHandle, first.eventHandle);

    service.StreamDestroyed(reinterpret_cast<void*>(0x99ULL));
    EXPECT_EQ(state.destroyEventCalls, 0U);
    service.StreamDestroyed(stream);
    EXPECT_EQ(state.destroyEventCalls, 1U);
    EXPECT_EQ(state.destroyedEventHandle, state.eventHandle);
    EXPECT_TRUE(service.events_.empty());
}

TEST_F(RuntimeThreadAicpuTest, CompletionEventCreationFailureIsPropagated)
{
    HookState state;
    state.createEventResult = RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    RuntimeThreadAicpuService service(MakeHooks(state));
    RuntimeThreadAicpuService::EventEntry event;
    EXPECT_EQ(
        service.GetOrCreateEvent(reinterpret_cast<void*>(0x88ULL), STREAM_ID, event),
        RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    EXPECT_TRUE(service.events_.empty());
}

TEST_F(RuntimeThreadAicpuTest, KernelNamesSupportDirectAndSerializedForms)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    RuntimeThreadAicpuService::KernelContext directContext;
    RuntimeThreadAicpuKernelRequest request = MakeRequest();
    EXPECT_EQ(service.ResolveKernelNames(request, directContext), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(directContext.soName, request.soName);
    EXPECT_EQ(directContext.functionName, request.functionName);

    const std::array<uint8_t, 24U> serialized = {'x', 'x',  'l', 'i', 'b', 'o', 'p', '.', 's',
                                                 'o', '\0', 'K', 'e', 'r', 'n', 'e', 'l', '\0'};
    RuntimeThreadAicpuService::KernelContext serializedContext;
    serializedContext.args.assign(serialized.begin(), serialized.end());
    request.soNameAddrOffset = 2U;
    request.kernelNameAddrOffset = 11U;
    EXPECT_EQ(service.ResolveKernelNames(request, serializedContext), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(serializedContext.soName, "libop.so");
    EXPECT_EQ(serializedContext.functionName, "Kernel");

    RuntimeThreadAicpuService::KernelContext mixedContext;
    mixedContext.args.assign(serialized.begin(), serialized.end());
    request.soName = "libdirect.so";
    request.soNameAddrOffset = std::numeric_limits<uint32_t>::max();
    EXPECT_EQ(service.ResolveKernelNames(request, mixedContext), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(mixedContext.soName, "libdirect.so");
}

TEST_F(RuntimeThreadAicpuTest, KernelNameValidationRejectsMalformedMetadata)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    RuntimeThreadAicpuKernelRequest request = MakeRequest();
    RuntimeThreadAicpuService::KernelContext context;
    request.soName = nullptr;
    EXPECT_EQ(service.ResolveKernelNames(request, context), RuntimeThreadAicpuStatus::INVALID_PARAM);

    context.args = {'x', 'y'};
    request.soNameAddrOffset = 3U;
    request.kernelNameAddrOffset = 1U;
    EXPECT_EQ(service.ResolveKernelNames(request, context), RuntimeThreadAicpuStatus::INVALID_PARAM);
    request.soNameAddrOffset = 0U;
    EXPECT_EQ(service.ResolveKernelNames(request, context), RuntimeThreadAicpuStatus::INVALID_PARAM);

    context.args = {'\0', 'K', '\0'};
    request.kernelNameAddrOffset = 1U;
    EXPECT_EQ(service.ResolveKernelNames(request, context), RuntimeThreadAicpuStatus::INVALID_PARAM);
}

TEST_F(RuntimeThreadAicpuTest, CreateKernelContextDeepCopiesArguments)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    std::array<uint8_t, 4U> args = {1U, 2U, 3U, 4U};
    RuntimeThreadAicpuKernelRequest request = MakeRequest(args.data(), args.size());
    request.cpuParamHeadOffset = 1U;
    uint64_t cookie = 0U;
    ASSERT_EQ(service.CreateKernelContext(request, cookie), RuntimeThreadAicpuStatus::OK);
    ASSERT_NE(cookie, 0U);
    args[1] = 99U;
    ASSERT_EQ(service.kernelContexts_.size(), 1U);
    EXPECT_EQ(service.kernelContexts_.at(cookie)->args[1], 2U);
    EXPECT_EQ(service.kernelContexts_.at(cookie)->cpuParamHeadOffset, 1U);
    EXPECT_EQ(service.kernelContexts_.at(cookie)->opType, "TestOp");
    service.ReleasePreparedKernel(cookie);
    EXPECT_TRUE(service.kernelContexts_.empty());
}

TEST_F(RuntimeThreadAicpuTest, CreateKernelContextValidatesArgumentRange)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    uint64_t cookie = 0U;
    RuntimeThreadAicpuKernelRequest request = MakeRequest(nullptr, 1U);
    EXPECT_EQ(service.CreateKernelContext(request, cookie), RuntimeThreadAicpuStatus::INVALID_PARAM);
    request.argsSize = 0U;
    request.cpuParamHeadOffset = 1U;
    EXPECT_EQ(service.CreateKernelContext(request, cookie), RuntimeThreadAicpuStatus::INVALID_PARAM);

    service.nextTaskCookie_.store(std::numeric_limits<uint64_t>::max());
    request.cpuParamHeadOffset = 0U;
    ASSERT_EQ(service.CreateKernelContext(request, cookie), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(cookie, std::numeric_limits<uint64_t>::max());
    ASSERT_EQ(service.CreateKernelContext(request, cookie), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(cookie, 1U);
}

TEST_F(RuntimeThreadAicpuTest, PrepareKernelValidatesRequestAndReturnsExecutionPayload)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.started_ = true;
    service.deviceId_ = DEVICE_ID;
    service.tsId_ = TS_ID;
    service.groupId_ = GROUP_ID;
    service.callbackCqId_ = CQ_ID;
    RuntimeThreadAicpuKernelRequest request = MakeRequest();
    RuntimeThreadAicpuPreparedKernel prepared = {};
    prepared.structSize = sizeof(prepared);

    request.kernelType = 1U;
    EXPECT_EQ(service.PrepareKernel(request, prepared), RuntimeThreadAicpuStatus::NOT_SUPPORTED);
    request.kernelType = static_cast<uint32_t>(KERNEL_TYPE_AICPU);
    request.blockDim = 0U;
    EXPECT_EQ(service.PrepareKernel(request, prepared), RuntimeThreadAicpuStatus::INVALID_PARAM);
    request.blockDim = 1U;
    ASSERT_EQ(service.PrepareKernel(request, prepared), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(prepared.callbackCqId, CQ_ID);
    EXPECT_EQ(prepared.callbackGroupId, GROUP_ID);
    EXPECT_EQ(prepared.eventId, EVENT_ID);
    EXPECT_EQ(prepared.eventHandle, state.eventHandle);
    EXPECT_NE(prepared.taskCookie, 0U);
    EXPECT_EQ(prepared.fnData, prepared.taskCookie);
    EXPECT_EQ(prepared.funcPtr, reinterpret_cast<uint64_t>(&RuntimeThreadAicpuService::ExecutePreparedKernelEntry));
}

TEST_F(RuntimeThreadAicpuTest, PrepareKernelPropagatesWorkerAndEventFailures)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.failed_.store(true);
    RuntimeThreadAicpuPreparedKernel prepared = {};
    prepared.structSize = sizeof(prepared);
    EXPECT_EQ(service.PrepareKernel(MakeRequest(), prepared), RuntimeThreadAicpuStatus::RUNTIME_ERROR);

    RuntimeThreadAicpuService eventFailure(MakeHooks(state));
    eventFailure.failed_.store(false);
    eventFailure.started_ = true;
    eventFailure.deviceId_ = DEVICE_ID;
    eventFailure.tsId_ = TS_ID;
    state.createEventResult = RuntimeThreadAicpuStatus::NO_MEMORY;
    EXPECT_EQ(eventFailure.PrepareKernel(MakeRequest(), prepared), RuntimeThreadAicpuStatus::NO_MEMORY);
}

TEST_F(RuntimeThreadAicpuTest, ExecuteKernelSetsContextAndHonorsArgumentOffset)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.tsId_ = TS_ID;
    CacheFunction(service, "TestKernel", reinterpret_cast<void*>(&TestKernel));
    RuntimeThreadAicpuService::KernelContext context = MakeContext();
    ASSERT_EQ(service.ExecuteKernel(context), 0U);
    EXPECT_EQ(g_kernelCalls, 1U);
    EXPECT_EQ(g_kernelArgument, context.args.data() + 1U);
    EXPECT_EQ(g_context.setContextCalls, 1U);
    EXPECT_EQ(g_context.context.deviceId, DEVICE_ID);
    EXPECT_EQ(g_context.context.tsId, TS_ID);
    EXPECT_EQ(g_context.taskId, context.taskId);
    EXPECT_EQ(g_context.streamId, STREAM_ID);
    EXPECT_EQ(g_context.opName, "TestOp");
    ASSERT_EQ(g_context.blocks.size(), 1U);
    EXPECT_EQ(g_context.blocks[0].blockId, 0U);
}

TEST_F(RuntimeThreadAicpuTest, ExecuteKernelSupportsBlockProtocolAndStopsOnFailure)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    CacheFunction(service, "RunCpuKernelWithBlock", reinterpret_cast<void*>(&TestKernelWithBlock));
    RuntimeThreadAicpuService::KernelContext context = MakeContext("RunCpuKernelWithBlock", 3U);
    ASSERT_EQ(service.ExecuteKernel(context), 0U);
    ASSERT_EQ(g_kernelBlocks.size(), 3U);
    EXPECT_EQ(g_kernelBlocks[0].blockNum, 3U);
    EXPECT_EQ(g_kernelBlocks[2].blockId, 2U);

    g_kernelCalls = 0U;
    g_kernelResult = 0x1234U;
    EXPECT_EQ(service.ExecuteKernel(context), 0x1234U);
    EXPECT_EQ(g_kernelCalls, 1U);
}

TEST_F(RuntimeThreadAicpuTest, ExecutePreparedKernelConsumesContextOnce)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    CacheFunction(service, "TestKernel", reinterpret_cast<void*>(&TestKernel));
    service.kernelContexts_[7U] = std::make_unique<RuntimeThreadAicpuService::KernelContext>(MakeContext());
    cce::runtime_thread_aicpu::SetRuntimeThreadAicpuService(&service);
    EXPECT_EQ(RuntimeThreadAicpuService::ExecutePreparedKernelEntry(reinterpret_cast<void*>(7U)), 0U);
    EXPECT_TRUE(service.kernelContexts_.empty());
    EXPECT_EQ(service.ExecutePreparedKernel(7U), static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR));
    cce::runtime_thread_aicpu::SetRuntimeThreadAicpuService(nullptr);
    EXPECT_EQ(
        RuntimeThreadAicpuService::ExecutePreparedKernelEntry(reinterpret_cast<void*>(7U)),
        static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR));
}

TEST_F(RuntimeThreadAicpuTest, ProcessOneReportValidatesFunctionAndCookie)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    TestCallbackReport report = {};
    report.funcPtr = 1U;
    EXPECT_EQ(service.ProcessOneReport(&report), static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR));
    report.funcPtr = reinterpret_cast<uint64_t>(&RuntimeThreadAicpuService::ExecutePreparedKernelEntry);
    report.fnData = 100U;
    EXPECT_EQ(service.ProcessOneReport(&report), static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR));
}

TEST_F(RuntimeThreadAicpuTest, FinishReportWritesCompletionCommandAndStreamError)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.deviceId_ = DEVICE_ID;
    service.tsId_ = TS_ID;
    service.groupId_ = GROUP_ID;
    service.callbackSqId_ = SQ_ID;
    TestCallbackReport report = {};
    report.streamId = STREAM_ID;
    report.taskId = 31U;
    report.eventId = EVENT_ID;
    g_driver.command.pid = 1U;
    g_driver.command.commandType = 1U;
    g_driver.command.vfId = 1U;
    g_driver.command.tid = 1U;
    g_driver.command.tsId = 1U;
    for (auto& value : g_driver.command.reserved1) {
        value = 1U;
    }
    constexpr uint32_t executeResult = 0x5678U;
    ASSERT_EQ(service.FinishReport(&report, executeResult), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(state.streamErrorCalls, 1U);
    EXPECT_EQ(state.streamErrorDeviceId, DEVICE_ID);
    EXPECT_EQ(state.streamErrorTsId, TS_ID);
    EXPECT_EQ(state.streamErrorStreamId, STREAM_ID);
    EXPECT_EQ(state.streamExecuteResult, executeResult);
    EXPECT_EQ(g_driver.command.pid, 0U);
    EXPECT_EQ(g_driver.command.commandType, 15U);
    EXPECT_EQ(g_driver.command.vfId, 0U);
    EXPECT_EQ(g_driver.command.tid, 0U);
    EXPECT_EQ(g_driver.command.tsId, 0U);
    EXPECT_EQ(g_driver.command.streamId, STREAM_ID);
    EXPECT_EQ(g_driver.command.recordId, EVENT_ID);
    EXPECT_EQ(g_driver.command.taskId, 31U);
    EXPECT_EQ(g_driver.command.reserved, GROUP_ID);
    EXPECT_EQ(g_driver.command.reserved1[0], static_cast<uint32_t>(RuntimeThreadAicpuSqeSubtype::AICPU));
    EXPECT_EQ(g_driver.command.reserved1[1], executeResult);
    for (size_t index = 2U; index < 12U; ++index) {
        EXPECT_EQ(g_driver.command.reserved1[index], 0U);
    }
    EXPECT_EQ(g_driver.messageSendInput.sqId, SQ_ID);
    EXPECT_EQ(g_driver.messageSendInput.reportCount, 1U);
}

TEST_F(RuntimeThreadAicpuTest, FinishReportHandlesDriverFailures)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    TestCallbackReport report = {};
    g_driver.memoryGetResult = static_cast<drvError_t>(1);
    EXPECT_EQ(service.FinishReport(&report, 0U), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    g_driver.memoryGetResult = DRV_ERROR_NONE;
    g_driver.provideCommand = false;
    EXPECT_EQ(service.FinishReport(&report, 0U), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    g_driver.provideCommand = true;
    g_driver.memoryCommandCount = 0U;
    EXPECT_EQ(service.FinishReport(&report, 0U), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
    g_driver.memoryCommandCount = 1U;
    g_driver.messageSendResult = static_cast<drvError_t>(1);
    EXPECT_EQ(service.FinishReport(&report, 0U), RuntimeThreadAicpuStatus::RUNTIME_ERROR);
}

TEST_F(RuntimeThreadAicpuTest, ProcessReportsHandlesWaitAndCqSelection)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.callbackCqId_ = CQ_ID;
    service.groupId_ = GROUP_ID;
    service.tsId_ = TS_ID;
    EXPECT_TRUE(service.ProcessReports());
    EXPECT_EQ(g_driver.reportGetCalls, 0U);

    g_driver.waitResult = static_cast<drvError_t>(1);
    EXPECT_FALSE(service.ProcessReports());
    g_driver.waitResult = DRV_ERROR_NONE;
    EXPECT_TRUE(service.ProcessReports());
    EXPECT_EQ(g_driver.reportGetCalls, 0U);

    service.callbackCqId_ = 1024U;
    EXPECT_FALSE(service.ProcessReports());
}

TEST_F(RuntimeThreadAicpuTest, ProcessReportsGetsExecutesAndReleasesEveryReport)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.deviceId_ = DEVICE_ID;
    service.tsId_ = TS_ID;
    service.groupId_ = GROUP_ID;
    service.callbackSqId_ = SQ_ID;
    service.callbackCqId_ = CQ_ID;
    CacheFunction(service, "TestKernel", reinterpret_cast<void*>(&TestKernel));
    service.kernelContexts_[7U] = std::make_unique<RuntimeThreadAicpuService::KernelContext>(MakeContext());
    cce::runtime_thread_aicpu::SetRuntimeThreadAicpuService(&service);
    g_driver.waitResult = DRV_ERROR_NONE;
    g_driver.setExpectedCqBit = true;
    g_driver.reportCount = 1U;
    g_driver.reports[0].streamId = STREAM_ID;
    g_driver.reports[0].taskId = 31U;
    g_driver.reports[0].eventId = EVENT_ID;
    g_driver.reports[0].funcPtr = reinterpret_cast<uint64_t>(&RuntimeThreadAicpuService::ExecutePreparedKernelEntry);
    g_driver.reports[0].fnData = 7U;
    ASSERT_TRUE(service.ProcessReports());
    EXPECT_EQ(g_kernelCalls, 1U);
    EXPECT_EQ(g_driver.reportGetCalls, 1U);
    EXPECT_EQ(g_driver.reportReleaseCalls, 1U);
    EXPECT_EQ(g_driver.reportReleaseInput.cqId, CQ_ID);
    EXPECT_EQ(g_driver.command.taskId, 31U);

    g_driver.reportCount = 0U;
    EXPECT_TRUE(service.ProcessReports());
    g_driver.reportGetResult = static_cast<drvError_t>(1);
    EXPECT_FALSE(service.ProcessReports());
}

TEST_F(RuntimeThreadAicpuTest, ProcessReportsSurfacesFinishAndReleaseFailures)
{
    HookState state;
    RuntimeThreadAicpuService service(MakeHooks(state));
    service.callbackCqId_ = CQ_ID;
    g_driver.waitResult = DRV_ERROR_NONE;
    g_driver.setExpectedCqBit = true;
    g_driver.reportCount = 1U;
    g_driver.reports[0].funcPtr = 1U;
    g_driver.memoryGetResult = static_cast<drvError_t>(1);
    EXPECT_FALSE(service.ProcessReports());

    g_driver.memoryGetResult = DRV_ERROR_NONE;
    g_driver.reportReleaseResult = static_cast<drvError_t>(1);
    EXPECT_FALSE(service.ProcessReports());
}

TEST_F(RuntimeThreadAicpuTest, WorkerLoopMarksUnexpectedDriverFailure)
{
    HookState state;
    state.processExiting.store(false);
    RuntimeThreadAicpuService service(MakeHooks(state));
    g_driver.waitResult = static_cast<drvError_t>(1);
    service.WorkerLoop();
    EXPECT_TRUE(service.failed_.load());
    EXPECT_EQ(state.monitorExitCalls, 1U);

    state.processExiting.store(true);
    RuntimeThreadAicpuService exitingService(MakeHooks(state));
    exitingService.WorkerLoop();
    EXPECT_FALSE(exitingService.failed_.load());
}

TEST_F(RuntimeThreadAicpuTest, PluginApiValidatesInputsAndReturnsCompleteTable)
{
    const RuntimeThreadAicpuPluginApi* api = nullptr;
    HookState state;
    RuntimeThreadAicpuRuntimeHooks hooks = MakeHooks(state);
    EXPECT_EQ(RuntimeThreadAicpuGetPluginApi(nullptr, &api), RuntimeThreadAicpuStatus::INVALID_PARAM);
    EXPECT_EQ(RuntimeThreadAicpuGetPluginApi(&hooks, nullptr), RuntimeThreadAicpuStatus::INVALID_PARAM);
    hooks.structSize = sizeof(hooks) - 1U;
    EXPECT_EQ(RuntimeThreadAicpuGetPluginApi(&hooks, &api), RuntimeThreadAicpuStatus::INVALID_PARAM);
    hooks.structSize = sizeof(hooks);
    ASSERT_EQ(RuntimeThreadAicpuGetPluginApi(&hooks, &api), RuntimeThreadAicpuStatus::OK);
    ASSERT_NE(api, nullptr);
    EXPECT_GE(api->structSize, sizeof(RuntimeThreadAicpuPluginApi));
    EXPECT_NE(api->prepareKernel, nullptr);
    EXPECT_NE(api->releasePreparedKernel, nullptr);
    EXPECT_NE(api->streamDestroyed, nullptr);
    EXPECT_EQ(api->prepareKernel(nullptr, nullptr), RuntimeThreadAicpuStatus::INVALID_PARAM);
    api->releasePreparedKernel(0U);
    api->streamDestroyed(nullptr);
}

} // namespace

drvError_t halSqCqAllocate(uint32_t devId, halSqCqInputInfo* in, halSqCqOutputInfo* out)
{
    (void)devId;
    ++g_driver.allocateCalls;
    g_driver.allocateInput = *in;
    if (g_driver.allocateResult == DRV_ERROR_NONE) {
        out->sqId = g_driver.allocatedSqId;
        out->cqId = g_driver.allocatedCqId;
    }
    return g_driver.allocateResult;
}

drvError_t halSqCqFree(uint32_t devId, halSqCqFreeInfo* info)
{
    (void)devId;
    ++g_driver.freeCalls;
    g_driver.freeInput = *info;
    return g_driver.freeResult;
}

drvError_t halSqMemGet(uint32_t devId, halSqMemGetInput* in, halSqMemGetOutput* out)
{
    (void)devId;
    ++g_driver.memoryGetCalls;
    g_driver.memoryGetInput = *in;
    out->cmdCount = g_driver.memoryCommandCount;
    out->cmdPtr = g_driver.provideCommand ? &g_driver.command : nullptr;
    return g_driver.memoryGetResult;
}

drvError_t halSqMsgSend(uint32_t devId, halSqMsgInfo* info)
{
    (void)devId;
    ++g_driver.messageSendCalls;
    g_driver.messageSendInput = *info;
    return g_driver.messageSendResult;
}

drvError_t halCqReportIrqWait(uint32_t devId, halReportInfoInput* in, halReportInfoOutput* out)
{
    (void)devId;
    ++g_driver.waitCalls;
    g_driver.waitInput = *in;
    if ((g_driver.waitResult == DRV_ERROR_NONE) && g_driver.setExpectedCqBit &&
        (g_driver.allocatedCqId < out->cqIdBitmapSize * 64U)) {
        const uint32_t index = g_driver.allocatedCqId / 64U;
        const uint32_t bit = g_driver.allocatedCqId % 64U;
        out->cqIdBitmap[index] |= 1ULL << bit;
    }
    return g_driver.waitResult;
}

drvError_t halCqReportGet(uint32_t devId, halReportGetInput* in, halReportGetOutput* out)
{
    (void)devId;
    ++g_driver.reportGetCalls;
    g_driver.reportGetInput = *in;
    out->count = g_driver.reportCount;
    out->reportPtr = (g_driver.reportCount == 0U) ? nullptr : g_driver.reports.data();
    return g_driver.reportGetResult;
}

drvError_t halReportRelease(uint32_t devId, halReportReleaseInfo* info)
{
    (void)devId;
    ++g_driver.reportReleaseCalls;
    g_driver.reportReleaseInput = *info;
    return g_driver.reportReleaseResult;
}

namespace aicpu {

status_t aicpuSetContext(aicpuContext_t* context)
{
    ++g_context.setContextCalls;
    g_context.context = *context;
    return AICPU_ERROR_NONE;
}

status_t SetTaskAndStreamId(const uint64_t taskId, const uint32_t streamId)
{
    ++g_context.setTaskCalls;
    g_context.taskId = taskId;
    g_context.streamId = streamId;
    return AICPU_ERROR_NONE;
}

status_t SetOpname(const std::string& opName)
{
    ++g_context.setOpCalls;
    g_context.opName = opName;
    return AICPU_ERROR_NONE;
}

status_t SetBlockIdxAndBlockNum(const uint32_t blockIdx, const uint32_t blockNum)
{
    ++g_context.setBlockCalls;
    g_context.blocks.push_back({blockNum, blockIdx});
    return AICPU_ERROR_NONE;
}

} // namespace aicpu
