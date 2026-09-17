/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime_thread_aicpu_service.hpp"

#include <cstddef>
#include <cstring>
#include <limits>
#include <new>
#include <unistd.h>

#include "aicpu_context.h"
#include "aicpu_sched/aicpu_schedule/common/aicpusd_status.h"
#include "driver/ascend_hal.h"
#include "runtime/runtime/kernel.h"

namespace cce {
namespace runtime_thread_aicpu {
namespace {

constexpr uint32_t CALLBACK_CQ_BITMAP_BITS = 1024U;
constexpr uint32_t CALLBACK_CQ_BITMAP_WORD_BITS = 64U;
constexpr uint32_t CALLBACK_CQ_BITMAP_WORDS = CALLBACK_CQ_BITMAP_BITS / CALLBACK_CQ_BITMAP_WORD_BITS;
constexpr uint32_t CALLBACK_CQ_DEPTH = 512U;
constexpr int32_t REPORT_WAIT_TIMEOUT_MS = 1000;
constexpr uint8_t CALLBACK_EVENT_RECORD_COMMAND = 15U;
constexpr char RUN_KERNEL_WITH_BLOCK[] = "RunCpuKernelWithBlock";

struct CallbackReport {
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

struct CallbackRecordCommand {
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

struct BlockInfo {
    uint32_t blockNum;
    uint32_t blockId;
};

using AicpuOpFunction = uint32_t (*)(void*);
using AicpuOpFunctionWithBlock = uint32_t (*)(void*, void*);
using RuntimeThreadExecuteFunction = uint32_t (*)(void*);

static_assert(sizeof(CallbackReport) == 32U, "callback report layout changed");
static_assert(offsetof(CallbackReport, funcPtr) == 16U, "callback report funcPtr offset changed");
static_assert(offsetof(CallbackReport, fnData) == 24U, "callback report fnData offset changed");
static_assert(sizeof(CallbackRecordCommand) == 64U, "callback record command layout changed");
static_assert(offsetof(CallbackRecordCommand, reserved) == 14U, "callback record reserved offset changed");
static_assert(offsetof(CallbackRecordCommand, reserved1) == 16U, "callback record reserved1 offset changed");

RuntimeThreadAicpuService* g_service = nullptr;

bool HooksAreValid(const RuntimeThreadAicpuRuntimeHooks& hooks)
{
    return (hooks.structSize >= sizeof(RuntimeThreadAicpuRuntimeHooks)) && (hooks.reserveGroupId != nullptr) &&
           (hooks.releaseGroupId != nullptr) && (hooks.createCompletionEvent != nullptr) &&
           (hooks.destroyCompletionEvent != nullptr) && (hooks.setStreamError != nullptr) &&
           (hooks.monitorThreadEnter != nullptr) && (hooks.monitorThreadExit != nullptr) &&
           (hooks.isProcessExiting != nullptr);
}

} // namespace

void SetRuntimeThreadAicpuService(RuntimeThreadAicpuService* const service) { g_service = service; }

RuntimeThreadAicpuService::RuntimeThreadAicpuService(const RuntimeThreadAicpuRuntimeHooks& hooks) : hooks_(hooks) {}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::AllocateCallbackChannel()
{
    halSqCqInputInfo input = {};
    input.type = DRV_CALLBACK_TYPE;
    input.tsId = tsId_;
    input.sqeSize = sizeof(CallbackRecordCommand);
    input.cqeSize = sizeof(CallbackReport);
    input.sqeDepth = 1U;
    input.cqeDepth = CALLBACK_CQ_DEPTH;
    input.grpId = groupId_;

    aicpusd_info(
        "Allocate callback SQ/CQ start, device_id=%u, ts_id=%u, group_id=%u, sqe_size=%u, cqe_size=%u.", deviceId_,
        tsId_, groupId_, input.sqeSize, input.cqeSize);
    halSqCqOutputInfo output = {};
    const drvError_t driverError = halSqCqAllocate(deviceId_, &input, &output);
    if (driverError != DRV_ERROR_NONE) {
        aicpusd_err(
            "Call halSqCqAllocate failed, device_id=%u, ts_id=%u, group_id=%u, drv_ret_code=%d.", deviceId_, tsId_,
            groupId_, static_cast<int32_t>(driverError));
        return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    }
    callbackSqId_ = output.sqId;
    callbackCqId_ = output.cqId;
    aicpusd_info(
        "Allocate callback SQ/CQ success, device_id=%u, ts_id=%u, group_id=%u, sq_id=%u, cq_id=%u.", deviceId_, tsId_,
        groupId_, callbackSqId_, callbackCqId_);
    return RuntimeThreadAicpuStatus::OK;
}

void RuntimeThreadAicpuService::ReleaseCallbackChannel()
{
    halSqCqFreeInfo freeInfo = {};
    freeInfo.type = DRV_CALLBACK_TYPE;
    freeInfo.tsId = tsId_;
    freeInfo.sqId = callbackSqId_;
    freeInfo.cqId = callbackCqId_;
    const drvError_t driverError = halSqCqFree(deviceId_, &freeInfo);
    if (driverError != DRV_ERROR_NONE) {
        aicpusd_err(
            "Call halSqCqFree failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u, drv_ret_code=%d.", deviceId_, tsId_,
            callbackSqId_, callbackCqId_, static_cast<int32_t>(driverError));
    } else {
        aicpusd_info(
            "Release callback SQ/CQ success, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u.", deviceId_, tsId_,
            callbackSqId_, callbackCqId_);
    }
    callbackSqId_ = 0U;
    callbackCqId_ = 0U;
}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::EnsureStarted(const RuntimeThreadAicpuKernelRequest& request)
{
    if (failed_.load(std::memory_order_acquire)) {
        aicpusd_err("RuntimeThreadAicpu worker is already in failed state.");
        return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    }

    std::lock_guard<std::mutex> lock(startMutex_);
    if (started_) {
        if ((request.deviceId != deviceId_) || (request.tsId != tsId_)) {
            aicpusd_err(
                "RuntimeThreadAicpu worker cannot switch device, request_device_id=%u, request_ts_id=%u, "
                "worker_device_id=%u, worker_ts_id=%u.",
                request.deviceId, request.tsId, deviceId_, tsId_);
            return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
        }
        return RuntimeThreadAicpuStatus::OK;
    }
    if (!HooksAreValid(hooks_)) {
        aicpusd_err(
            "RuntimeThreadAicpu runtime hooks are invalid, hooks_size=%u, expected_size=%zu, "
            "reserve_group_valid=%u, release_group_valid=%u, create_event_valid=%u, destroy_event_valid=%u, "
            "set_stream_error_valid=%u, monitor_enter_valid=%u, monitor_exit_valid=%u, process_exit_valid=%u.",
            hooks_.structSize, sizeof(RuntimeThreadAicpuRuntimeHooks),
            static_cast<uint32_t>(hooks_.reserveGroupId != nullptr),
            static_cast<uint32_t>(hooks_.releaseGroupId != nullptr),
            static_cast<uint32_t>(hooks_.createCompletionEvent != nullptr),
            static_cast<uint32_t>(hooks_.destroyCompletionEvent != nullptr),
            static_cast<uint32_t>(hooks_.setStreamError != nullptr),
            static_cast<uint32_t>(hooks_.monitorThreadEnter != nullptr),
            static_cast<uint32_t>(hooks_.monitorThreadExit != nullptr),
            static_cast<uint32_t>(hooks_.isProcessExiting != nullptr));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    deviceId_ = request.deviceId;
    tsId_ = request.tsId;
    RuntimeThreadAicpuStatus status = hooks_.reserveGroupId(hooks_.runtimeData, &groupId_);
    if (status != RuntimeThreadAicpuStatus::OK) {
        aicpusd_err("Reserve callback group ID failed, status=%u.", static_cast<uint32_t>(status));
        deviceId_ = 0U;
        tsId_ = 0U;
        return status;
    }
    status = AllocateCallbackChannel();
    if (status != RuntimeThreadAicpuStatus::OK) {
        hooks_.releaseGroupId(hooks_.runtimeData, groupId_);
        deviceId_ = 0U;
        tsId_ = 0U;
        groupId_ = 0U;
        return status;
    }

    hooks_.monitorThreadEnter(hooks_.runtimeData);
    try {
        worker_ = std::thread(&RuntimeThreadAicpuService::WorkerLoop, this);
    } catch (...) {
        aicpusd_err(
            "Create RuntimeThreadAicpu worker thread failed, device_id=%u, ts_id=%u, group_id=%u.", deviceId_, tsId_,
            groupId_);
        hooks_.monitorThreadExit(hooks_.runtimeData);
        ReleaseCallbackChannel();
        hooks_.releaseGroupId(hooks_.runtimeData, groupId_);
        deviceId_ = 0U;
        tsId_ = 0U;
        groupId_ = 0U;
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    }
    started_ = true;
    aicpusd_info(
        "RuntimeThreadAicpu worker started, device_id=%u, ts_id=%u, group_id=%u, sq_id=%u, cq_id=%u.", deviceId_, tsId_,
        groupId_, callbackSqId_, callbackCqId_);
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::GetOrCreateEvent(
    void* const streamHandle, const uint32_t streamId, EventEntry& event)
{
    std::lock_guard<std::mutex> lock(resourceMutex_);
    const auto eventIt = events_.find(streamHandle);
    if (eventIt != events_.end()) {
        event = eventIt->second;
        aicpusd_debug("Reuse completion event, stream_id=%u, event_id=%u.", event.streamId, event.eventId);
        return RuntimeThreadAicpuStatus::OK;
    }

    EventEntry newEvent;
    newEvent.streamId = streamId;
    const RuntimeThreadAicpuStatus status =
        hooks_.createCompletionEvent(hooks_.runtimeData, streamHandle, &newEvent.eventHandle, &newEvent.eventId);
    if (status != RuntimeThreadAicpuStatus::OK) {
        aicpusd_err(
            "Create completion event failed, stream_id=%u, status=%u.", streamId, static_cast<uint32_t>(status));
        return status;
    }
    try {
        events_.emplace(streamHandle, newEvent);
    } catch (...) {
        aicpusd_err(
            "Cache RuntimeThreadAicpu completion event failed, stream_id=%u, event_id=%u.", streamId, newEvent.eventId);
        hooks_.destroyCompletionEvent(hooks_.runtimeData, newEvent.eventHandle);
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    }
    event = newEvent;
    aicpusd_info("Create completion event success, stream_id=%u, event_id=%u.", event.streamId, event.eventId);
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::ResolveKernelNames(
    const RuntimeThreadAicpuKernelRequest& request, KernelContext& context) const
{
    const auto readName = [&context](const char* const fieldName, const uint32_t offset, std::string& name) {
        if (offset >= context.args.size()) {
            aicpusd_err(
                "Resolve AICPU kernel name failed, field=%s, offset=%u, args_size=%zu, reason=offset is out of range.",
                fieldName, offset, context.args.size());
            return false;
        }
        const char* const begin = reinterpret_cast<const char*>(context.args.data() + offset);
        const size_t remaining = context.args.size() - offset;
        const void* const terminator = std::memchr(begin, '\0', remaining);
        if (terminator == nullptr) {
            aicpusd_err(
                "Resolve AICPU kernel name failed, field=%s, offset=%u, args_size=%zu, "
                "reason=string is not null-terminated.",
                fieldName, offset, context.args.size());
            return false;
        }
        name.assign(begin, static_cast<const char*>(terminator));
        if (name.empty()) {
            aicpusd_err(
                "Resolve AICPU kernel name failed, field=%s, offset=%u, args_size=%zu, reason=string is empty.",
                fieldName, offset, context.args.size());
            return false;
        }
        return true;
    };

    if ((request.soNameAddrOffset == 0U) && (request.kernelNameAddrOffset == 0U)) {
        if ((request.soName == nullptr) || (request.functionName == nullptr)) {
            aicpusd_err(
                "Resolve AICPU kernel name failed, so_name_valid=%u, function_name_valid=%u.",
                static_cast<uint32_t>(request.soName != nullptr),
                static_cast<uint32_t>(request.functionName != nullptr));
            return RuntimeThreadAicpuStatus::INVALID_PARAM;
        }
        context.soName = request.soName;
        context.functionName = request.functionName;
    } else {
        if (request.soNameAddrOffset == std::numeric_limits<uint32_t>::max()) {
            if (request.soName == nullptr) {
                aicpusd_err("Resolve AICPU kernel name failed because the direct SO name is null.");
                return RuntimeThreadAicpuStatus::INVALID_PARAM;
            }
            context.soName = request.soName;
        } else if (!readName("so_name", request.soNameAddrOffset, context.soName)) {
            return RuntimeThreadAicpuStatus::INVALID_PARAM;
        }
        if (!readName("function_name", request.kernelNameAddrOffset, context.functionName)) {
            return RuntimeThreadAicpuStatus::INVALID_PARAM;
        }
    }
    if (context.soName.empty() || context.functionName.empty()) {
        aicpusd_err(
            "Resolve AICPU kernel name failed, so_name_empty=%u, function_name_empty=%u.",
            static_cast<uint32_t>(context.soName.empty()), static_cast<uint32_t>(context.functionName.empty()));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::CreateKernelContext(
    const RuntimeThreadAicpuKernelRequest& request, uint64_t& taskCookie)
{
    if ((request.argsSize > static_cast<uint64_t>(std::numeric_limits<size_t>::max())) ||
        (request.cpuParamHeadOffset > request.argsSize) || ((request.argsSize > 0U) && (request.args == nullptr))) {
        aicpusd_err(
            "Create AICPU kernel context failed because arguments are invalid, args_size=%llu, "
            "cpu_param_head_offset=%llu, args_valid=%u.",
            static_cast<unsigned long long>(request.argsSize),
            static_cast<unsigned long long>(request.cpuParamHeadOffset),
            static_cast<uint32_t>((request.argsSize == 0U) || (request.args != nullptr)));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    std::unique_ptr<KernelContext> context(new (std::nothrow) KernelContext());
    if (context == nullptr) {
        aicpusd_err(
            "Create AICPU kernel context failed because memory allocation failed, args_size=%llu, stream_id=%u.",
            static_cast<unsigned long long>(request.argsSize), request.streamId);
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    }
    try {
        if (request.argsSize > 0U) {
            const auto* const begin = static_cast<const uint8_t*>(request.args);
            context->args.assign(begin, begin + static_cast<size_t>(request.argsSize));
        }
        context->cpuParamHeadOffset = request.cpuParamHeadOffset;
        context->blockDim = request.blockDim;
        context->deviceId = request.deviceId;
        context->streamId = request.streamId;
        context->opType = (request.opType == nullptr) ? std::string() : std::string(request.opType);
        const RuntimeThreadAicpuStatus nameStatus = ResolveKernelNames(request, *context);
        if (nameStatus != RuntimeThreadAicpuStatus::OK) {
            return nameStatus;
        }

        taskCookie = nextTaskCookie_.fetch_add(1U, std::memory_order_relaxed);
        if (taskCookie == 0U) {
            taskCookie = nextTaskCookie_.fetch_add(1U, std::memory_order_relaxed);
        }
        std::lock_guard<std::mutex> lock(taskMutex_);
        kernelContexts_.emplace(taskCookie, std::move(context));
    } catch (...) {
        aicpusd_err(
            "Create AICPU kernel context failed because copying or caching task data threw an exception, "
            "args_size=%llu, stream_id=%u.",
            static_cast<unsigned long long>(request.argsSize), request.streamId);
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::PrepareKernel(
    const RuntimeThreadAicpuKernelRequest& request, RuntimeThreadAicpuPreparedKernel& preparedKernel)
{
    if (request.kernelType != static_cast<uint32_t>(KERNEL_TYPE_AICPU)) {
        aicpusd_err(
            "Prepare RuntimeThreadAicpu kernel is not supported, kernel_type=%u, expected_type=%u.", request.kernelType,
            static_cast<uint32_t>(KERNEL_TYPE_AICPU));
        return RuntimeThreadAicpuStatus::NOT_SUPPORTED;
    }
    if ((request.structSize < sizeof(RuntimeThreadAicpuKernelRequest)) ||
        (preparedKernel.structSize < sizeof(RuntimeThreadAicpuPreparedKernel)) || (request.streamHandle == nullptr) ||
        (request.blockDim == 0U)) {
        aicpusd_err(
            "Prepare RuntimeThreadAicpu kernel failed because request is invalid, request_size=%u, "
            "expected_request_size=%zu, prepared_size=%u, expected_prepared_size=%zu, stream_valid=%u, "
            "block_dim=%u.",
            request.structSize, sizeof(RuntimeThreadAicpuKernelRequest), preparedKernel.structSize,
            sizeof(RuntimeThreadAicpuPreparedKernel), static_cast<uint32_t>(request.streamHandle != nullptr),
            request.blockDim);
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    RuntimeThreadAicpuStatus status = EnsureStarted(request);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }
    if (failed_.load(std::memory_order_acquire)) {
        aicpusd_err("Prepare RuntimeThreadAicpu kernel failed because worker entered the failed state.");
        return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    }

    EventEntry event;
    status = GetOrCreateEvent(request.streamHandle, request.streamId, event);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }

    uint64_t taskCookie = 0U;
    status = CreateKernelContext(request, taskCookie);
    if (status != RuntimeThreadAicpuStatus::OK) {
        return status;
    }

    preparedKernel.callbackCqId = callbackCqId_;
    preparedKernel.callbackGroupId = groupId_;
    preparedKernel.eventId = event.eventId;
    preparedKernel.eventHandle = event.eventHandle;
    preparedKernel.taskCookie = taskCookie;
    preparedKernel.funcPtr = reinterpret_cast<uint64_t>(&RuntimeThreadAicpuService::ExecutePreparedKernelEntry);
    preparedKernel.fnData = taskCookie;
    aicpusd_info(
        "Prepare AICPU kernel success, device_id=%u, stream_id=%u, group_id=%u, cq_id=%u, event_id=%u, "
        "task_cookie=%llu, block_dim=%u.",
        request.deviceId, request.streamId, preparedKernel.callbackGroupId, preparedKernel.callbackCqId,
        preparedKernel.eventId, static_cast<unsigned long long>(taskCookie), request.blockDim);
    return RuntimeThreadAicpuStatus::OK;
}

void RuntimeThreadAicpuService::ReleasePreparedKernel(const uint64_t taskCookie)
{
    std::lock_guard<std::mutex> lock(taskMutex_);
    const size_t erasedCount = kernelContexts_.erase(taskCookie);
    aicpusd_debug(
        "Release prepared kernel, task_cookie=%llu, erased_count=%zu.", static_cast<unsigned long long>(taskCookie),
        erasedCount);
}

void RuntimeThreadAicpuService::StreamDestroyed(void* const streamHandle)
{
    EventEntry event;
    {
        std::lock_guard<std::mutex> lock(resourceMutex_);
        const auto eventIt = events_.find(streamHandle);
        if (eventIt == events_.end()) {
            return;
        }
        event = eventIt->second;
        events_.erase(eventIt);
    }
    hooks_.destroyCompletionEvent(hooks_.runtimeData, event.eventHandle);
    aicpusd_info("Destroy completion event, stream_id=%u, event_id=%u.", event.streamId, event.eventId);
}

bool RuntimeThreadAicpuService::SetReportedTaskId(const uint64_t taskCookie, const uint32_t taskId)
{
    std::lock_guard<std::mutex> lock(taskMutex_);
    const auto contextIt = kernelContexts_.find(taskCookie);
    if (contextIt == kernelContexts_.end()) {
        return false;
    }
    contextIt->second->taskId = taskId;
    return true;
}

uint32_t RuntimeThreadAicpuService::ExecutePreparedKernelEntry(void* const cookieData)
{
    RuntimeThreadAicpuService* const service = g_service;
    if (service == nullptr) {
        aicpusd_err("Execute prepared AICPU kernel failed because service is null.");
        return static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR);
    }
    return service->ExecutePreparedKernel(reinterpret_cast<uint64_t>(cookieData));
}

uint32_t RuntimeThreadAicpuService::ExecutePreparedKernel(const uint64_t taskCookie)
{
    std::unique_ptr<KernelContext> context;
    {
        std::lock_guard<std::mutex> lock(taskMutex_);
        const auto contextIt = kernelContexts_.find(taskCookie);
        if (contextIt == kernelContexts_.end()) {
            aicpusd_err(
                "Execute prepared AICPU kernel failed because task context was not found, task_cookie=%llu.",
                static_cast<unsigned long long>(taskCookie));
            return static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR);
        }
        context = std::move(contextIt->second);
        kernelContexts_.erase(contextIt);
    }
    return ExecuteKernel(*context);
}

uint32_t RuntimeThreadAicpuService::ExecuteKernel(KernelContext& context)
{
    void* functionAddress = nullptr;
    std::string resolveError;
    const RuntimeThreadAicpuStatus status =
        soManager_.GetFunction(context.soName, context.functionName, &functionAddress, resolveError);
    if (status != RuntimeThreadAicpuStatus::OK) {
        aicpusd_err(
            "Resolve AICPU operator function failed, so_name=%s, function_name=%s, status=%u, reason=%s.",
            context.soName.c_str(), context.functionName.c_str(), static_cast<uint32_t>(status), resolveError.c_str());
        return static_cast<uint32_t>(status);
    }
    aicpusd_info(
        "Execute AICPU operator start, device_id=%u, stream_id=%u, task_id=%u, so_name=%s, function_name=%s, "
        "block_dim=%u.",
        context.deviceId, context.streamId, context.taskId, context.soName.c_str(), context.functionName.c_str(),
        context.blockDim);

    ::aicpu::aicpuContext_t aicpuContext = {
        .deviceId = context.deviceId, .tsId = tsId_, .hostPid = getpid(), .vfId = 0U};
    (void)::aicpu::aicpuSetContext(&aicpuContext);
    (void)::aicpu::SetTaskAndStreamId(context.taskId, context.streamId);
    (void)::aicpu::SetOpname(context.opType.empty() ? context.functionName : context.opType);

    void* args = nullptr;
    if (!context.args.empty()) {
        args = static_cast<void*>(context.args.data() + static_cast<size_t>(context.cpuParamHeadOffset));
    }
    for (uint32_t blockId = 0U; blockId < context.blockDim; ++blockId) {
        aicpusd_debug(
            "Execute AICPU operator block, stream_id=%u, task_id=%u, block_id=%u, block_dim=%u.", context.streamId,
            context.taskId, blockId, context.blockDim);
        (void)::aicpu::SetBlockIdxAndBlockNum(blockId, context.blockDim);
        uint32_t executeResult = 0U;
        if (context.functionName == RUN_KERNEL_WITH_BLOCK) {
            BlockInfo blockInfo = {.blockNum = context.blockDim, .blockId = blockId};
            executeResult = reinterpret_cast<AicpuOpFunctionWithBlock>(functionAddress)(args, &blockInfo);
        } else {
            executeResult = reinterpret_cast<AicpuOpFunction>(functionAddress)(args);
        }
        if (executeResult != 0U) {
            aicpusd_err(
                "Execute AICPU operator failed, stream_id=%u, task_id=%u, block_id=%u, execute_result=%#x.",
                context.streamId, context.taskId, blockId, executeResult);
            return executeResult;
        }
    }
    aicpusd_info("Execute AICPU operator success, stream_id=%u, task_id=%u.", context.streamId, context.taskId);
    return 0U;
}

uint32_t RuntimeThreadAicpuService::ProcessOneReport(const void* const reportAddress)
{
    const auto* const report = static_cast<const CallbackReport*>(reportAddress);
    const uint64_t expectedFunction =
        reinterpret_cast<uint64_t>(&RuntimeThreadAicpuService::ExecutePreparedKernelEntry);
    if (report->funcPtr != expectedFunction) {
        aicpusd_err(
            "Invalid callback function in AICPU report, stream_id=%u, task_id=%u, func_ptr=%#llx, expected=%#llx.",
            static_cast<uint32_t>(report->streamId), static_cast<uint32_t>(report->taskId),
            static_cast<unsigned long long>(report->funcPtr), static_cast<unsigned long long>(expectedFunction));
        return static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR);
    }
    if (!SetReportedTaskId(report->fnData, report->taskId)) {
        aicpusd_err(
            "Cannot find AICPU task context for report, stream_id=%u, task_id=%u, task_cookie=%llu.",
            static_cast<uint32_t>(report->streamId), static_cast<uint32_t>(report->taskId),
            static_cast<unsigned long long>(report->fnData));
        return static_cast<uint32_t>(RuntimeThreadAicpuStatus::INTERNAL_ERROR);
    }
    const auto execute = reinterpret_cast<RuntimeThreadExecuteFunction>(report->funcPtr);
    return execute(reinterpret_cast<void*>(report->fnData));
}

RuntimeThreadAicpuStatus RuntimeThreadAicpuService::FinishReport(
    const void* const reportAddress, const uint32_t executeResult)
{
    const auto* const report = static_cast<const CallbackReport*>(reportAddress);
    if (executeResult != 0U) {
        aicpusd_err(
            "AICPU operator report execution failed, stream_id=%u, task_id=%u, execute_result=%#x.",
            static_cast<uint32_t>(report->streamId), static_cast<uint32_t>(report->taskId), executeResult);
        hooks_.setStreamError(
            hooks_.runtimeData, deviceId_, tsId_, static_cast<uint32_t>(report->streamId), executeResult);
    }

    halSqMemGetInput getInput = {};
    getInput.type = DRV_CALLBACK_TYPE;
    getInput.tsId = tsId_;
    getInput.sqId = callbackSqId_;
    getInput.cmdCount = 1U;
    aicpusd_info(
        "Callback SQ command occupy start, device_id=%u, ts_id=%u, sq_id=%u.", deviceId_, tsId_, callbackSqId_);
    halSqMemGetOutput getOutput = {};
    drvError_t driverError = halSqMemGet(deviceId_, &getInput, &getOutput);
    if ((driverError != DRV_ERROR_NONE) || (getOutput.cmdPtr == nullptr) || (getOutput.cmdCount == 0U)) {
        aicpusd_err(
            "Call halSqMemGet failed, device_id=%u, ts_id=%u, sq_id=%u, requested_count=%u, actual_count=%u, "
            "cmd_ptr=%p, drv_ret_code=%d.",
            deviceId_, tsId_, callbackSqId_, getInput.cmdCount, getOutput.cmdCount, const_cast<void*>(getOutput.cmdPtr),
            static_cast<int32_t>(driverError));
        return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    }

    auto* const command = static_cast<CallbackRecordCommand*>(const_cast<void*>(getOutput.cmdPtr));
    (void)std::memset(command, 0, sizeof(*command));
    command->commandType = CALLBACK_EVENT_RECORD_COMMAND;
    command->streamId = report->streamId;
    command->recordId = report->eventId;
    command->taskId = report->taskId;
    command->reserved = static_cast<uint16_t>(groupId_);
    const uint32_t sqeSubtype = static_cast<uint32_t>(RuntimeThreadAicpuSqeSubtype::AICPU);
    command->reserved1[0] = sqeSubtype;
    command->reserved1[1] = executeResult;
    aicpusd_debug(
        "Construct AICPU finish command, stream_id=%u, task_id=%u, event_id=%u, group_id=%u, sqe_subtype=%u, "
        "execute_result=%#x.",
        static_cast<uint32_t>(report->streamId), static_cast<uint32_t>(report->taskId),
        static_cast<uint32_t>(report->eventId), groupId_, sqeSubtype, executeResult);

    halSqMsgInfo sendInfo = {};
    sendInfo.type = DRV_CALLBACK_TYPE;
    sendInfo.tsId = tsId_;
    sendInfo.sqId = callbackSqId_;
    sendInfo.cmdCount = 1U;
    sendInfo.reportCount = 1U;
    aicpusd_info("Callback SQ command send start, device_id=%u, ts_id=%u, sq_id=%u.", deviceId_, tsId_, callbackSqId_);
    driverError = halSqMsgSend(deviceId_, &sendInfo);
    if (driverError != DRV_ERROR_NONE) {
        aicpusd_err(
            "Call halSqMsgSend failed, device_id=%u, ts_id=%u, sq_id=%u, cmd_count=%u, report_count=%u, "
            "drv_ret_code=%d.",
            deviceId_, tsId_, callbackSqId_, sendInfo.cmdCount, sendInfo.reportCount,
            static_cast<int32_t>(driverError));
        return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    }
    aicpusd_debug(
        "Callback SQ command send success, device_id=%u, ts_id=%u, sq_id=%u.", deviceId_, tsId_, callbackSqId_);
    return RuntimeThreadAicpuStatus::OK;
}

bool RuntimeThreadAicpuService::ProcessReports()
{
    uint64_t cqBitmap[CALLBACK_CQ_BITMAP_WORDS] = {0UL};
    halReportInfoInput waitInput = {};
    waitInput.type = DRV_CALLBACK_TYPE;
    waitInput.grpId = groupId_;
    waitInput.tsId = tsId_;
    waitInput.timeout = REPORT_WAIT_TIMEOUT_MS;
    halReportInfoOutput waitOutput = {};
    waitOutput.cqIdBitmap = cqBitmap;
    waitOutput.cqIdBitmapSize = CALLBACK_CQ_BITMAP_WORDS;
    aicpusd_debug(
        "Callback CQ irq wait start, device_id=%u, ts_id=%u, group_id=%u, expected_cq_id=%u.", deviceId_, tsId_,
        groupId_, callbackCqId_);
    const drvError_t waitError = halCqReportIrqWait(deviceId_, &waitInput, &waitOutput);
    if (waitError == DRV_ERROR_WAIT_TIMEOUT) {
        return true;
    }
    if (waitError != DRV_ERROR_NONE) {
        aicpusd_err(
            "Call halCqReportIrqWait failed, device_id=%u, ts_id=%u, group_id=%u, drv_ret_code=%d.", deviceId_, tsId_,
            groupId_, static_cast<int32_t>(waitError));
        return false;
    }
    aicpusd_debug(
        "Callback CQ irq wait success, device_id=%u, ts_id=%u, group_id=%u, expected_cq_id=%u.", deviceId_, tsId_,
        groupId_, callbackCqId_);

    if (callbackCqId_ >= CALLBACK_CQ_BITMAP_BITS) {
        aicpusd_err(
            "Callback CQ id exceeds irq bitmap range, cq_id=%u, bitmap_bits=%u.", callbackCqId_,
            CALLBACK_CQ_BITMAP_BITS);
        return false;
    }
    const uint32_t bitmapIndex = callbackCqId_ / CALLBACK_CQ_BITMAP_WORD_BITS;
    const uint32_t bitIndex = callbackCqId_ % CALLBACK_CQ_BITMAP_WORD_BITS;
    // This worker owns an exclusive callback group with exactly one registered CQ. Check the expected CQ bit instead
    // of scanning the bitmap; a full scan is only needed when multiple CQs are registered to the same wait group.
    if ((cqBitmap[bitmapIndex] & (1ULL << bitIndex)) == 0ULL) {
        aicpusd_warn(
            "Callback CQ irq bitmap does not contain the expected CQ, group_id=%u, expected_cq_id=%u.", groupId_,
            callbackCqId_);
        return true;
    }

    halReportGetInput getInput = {};
    getInput.type = DRV_CALLBACK_TYPE;
    getInput.tsId = tsId_;
    getInput.cqId = callbackCqId_;
    halReportGetOutput getOutput = {};
    aicpusd_info("Callback CQ report get start, device_id=%u, ts_id=%u, cq_id=%u.", deviceId_, tsId_, callbackCqId_);
    const drvError_t getError = halCqReportGet(deviceId_, &getInput, &getOutput);
    if (getError != DRV_ERROR_NONE) {
        aicpusd_err(
            "Call halCqReportGet failed, device_id=%u, ts_id=%u, cq_id=%u, drv_ret_code=%d.", deviceId_, tsId_,
            callbackCqId_, static_cast<int32_t>(getError));
        return false;
    }
    if ((getOutput.reportPtr == nullptr) || (getOutput.count == 0U)) {
        aicpusd_debug(
            "Callback CQ has no report after irq wait, device_id=%u, ts_id=%u, cq_id=%u, report_count=%u.", deviceId_,
            tsId_, callbackCqId_, getOutput.count);
        return true;
    }
    aicpusd_debug("Get callback reports, cq_id=%u, report_count=%u.", callbackCqId_, getOutput.count);

    const auto* const reports = static_cast<const CallbackReport*>(getOutput.reportPtr);
    bool success = true;
    for (uint32_t index = 0U; index < getOutput.count; ++index) {
        aicpusd_info(
            "AICPU report[%u], sq_id=%u, stream_id=%u, task_id=%u, event_id=%u, is_block=%u.", index,
            static_cast<uint32_t>(reports[index].sqId), static_cast<uint32_t>(reports[index].streamId),
            static_cast<uint32_t>(reports[index].taskId), static_cast<uint32_t>(reports[index].eventId),
            static_cast<uint32_t>(reports[index].isBlock));
        const uint32_t executeResult = ProcessOneReport(&reports[index]);
        if (FinishReport(&reports[index], executeResult) != RuntimeThreadAicpuStatus::OK) {
            success = false;
        }

        halReportReleaseInfo releaseInfo = {};
        releaseInfo.type = DRV_CALLBACK_TYPE;
        releaseInfo.tsId = tsId_;
        releaseInfo.cqId = callbackCqId_;
        releaseInfo.count = 1U;
        const drvError_t releaseError = halReportRelease(deviceId_, &releaseInfo);
        if (releaseError != DRV_ERROR_NONE) {
            aicpusd_err(
                "Call halReportRelease failed, device_id=%u, ts_id=%u, cq_id=%u, drv_ret_code=%d.", deviceId_, tsId_,
                callbackCqId_, static_cast<int32_t>(releaseError));
            success = false;
        } else {
            aicpusd_debug(
                "Release callback report success, device_id=%u, ts_id=%u, cq_id=%u.", deviceId_, tsId_, callbackCqId_);
        }
    }
    return success;
}

void RuntimeThreadAicpuService::WorkerLoop()
{
    aicpusd_info(
        "RuntimeThreadAicpu worker loop entered, device_id=%u, ts_id=%u, group_id=%u, cq_id=%u.", deviceId_, tsId_,
        groupId_, callbackCqId_);
    while (!hooks_.isProcessExiting(hooks_.runtimeData)) {
        if (!ProcessReports()) {
            if (!hooks_.isProcessExiting(hooks_.runtimeData)) {
                failed_.store(true, std::memory_order_release);
                aicpusd_err("RuntimeThreadAicpu worker stopped after a driver error.");
            }
            break;
        }
    }
    aicpusd_info("RuntimeThreadAicpu worker loop exited.");
    hooks_.monitorThreadExit(hooks_.runtimeData);
}

} // namespace runtime_thread_aicpu
} // namespace cce
