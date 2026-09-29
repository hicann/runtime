/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime_thread_aicpu.hpp"

#include <atomic>
#include <cstddef>
#include <dlfcn.h>
#include <functional>
#include <memory>
#include <mutex>
#include <new>
#include <string>
#include <vector>

#include "aicpu_sched/runtime_thread_aicpu_plugin.h"
#include "api.hpp"
#include "davinci_kernel_task.h"
#include "device.hpp"
#include "dfx_api.hpp"
#include "event.hpp"
#include "inner_thread_local.hpp"
#include "kernel.hpp"
#include "runtime.hpp"
#include "runtime_handle_guard.h"
#include "runtime_task_manager.h"
#include "stars.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "stream_state_callback_manager.hpp"
#include "subscribe.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "task_scheduler_error.h"

namespace cce {
namespace runtime {

rtError_t CbSubscribe::ReserveInternalGroupId(uint32_t* const groupId)
{
    COND_RETURN_ERROR(groupId == nullptr, RT_ERROR_INVALID_VALUE, "groupId is null.");
    std::lock_guard<std::mutex> lock(subscribeLock_);
    const rtError_t bitmapError = grpIdWaitBitmap_.AllocBitmap();
    if (bitmapError != RT_ERROR_NONE) {
        return bitmapError;
    }

    std::vector<int32_t> waitingGroupIds;
    const std::function<void()> releaseSkippedIds = [this, &waitingGroupIds]() {
        for (const int32_t waitingGroupId : waitingGroupIds) {
            grpIdBitmap_.FreeId(waitingGroupId);
        }
    };
    const ScopeGuard skippedIdGuard(releaseSkippedIds);
    while (true) {
        const int32_t candidate = grpIdBitmap_.AllocId();
        if (candidate < 0) {
            RT_LOG(
                RT_LOG_ERROR,
                "Reserve RuntimeThreadAicpu callback group failed, no group ID is available, max_group_num=%u, "
                "retCode=%#x.",
                maxGroupNum_, static_cast<uint32_t>(RT_ERROR_SUBSCRIBE_GROUP));
            return RT_ERROR_SUBSCRIBE_GROUP;
        }
        if (grpIdWaitBitmap_.IsIdOccupied(candidate)) {
            waitingGroupIds.emplace_back(candidate);
            continue;
        }
        grpIdWaitBitmap_.OccupyId(candidate);
        *groupId = static_cast<uint32_t>(candidate);
        RT_LOG(RT_LOG_INFO, "Reserve internal callback groupId=%u.", *groupId);
        return RT_ERROR_NONE;
    }
}

void CbSubscribe::ReleaseInternalGroupId(const uint32_t groupId)
{
    std::lock_guard<std::mutex> lock(subscribeLock_);
    grpIdWaitBitmap_.FreeId(static_cast<int32_t>(groupId));
    grpIdBitmap_.FreeId(static_cast<int32_t>(groupId));
    RT_LOG(RT_LOG_INFO, "Release internal callback groupId=%u.", groupId);
}

namespace {

constexpr char PLUGIN_SO_NAME[] = "libruntime_thread_aicpu.so";
constexpr char PLUGIN_QUERY_SYMBOL[] = "RuntimeThreadAicpuGetPluginApi";
constexpr char STREAM_OBSERVER_NAME[] = "Inner#RuntimeThreadAicpu";
std::mutex g_streamErrorMutex;
std::atomic<const RuntimeThreadAicpuPluginApi*> g_monitorPluginApi{nullptr};
static_assert(
    static_cast<uint32_t>(RuntimeThreadAicpuSqeSubtype::AICPU) == static_cast<uint32_t>(RT_SQE_SUBTYPE_AICPU),
    "RuntimeThreadAicpu SQE subtype does not match the runtime protocol");
static_assert(
    static_cast<uint32_t>(RuntimeThreadAicpuSqeSubtype::DATADUMP) == static_cast<uint32_t>(RT_SQE_SUBTYPE_DATADUMP),
    "RuntimeThreadAicpu DataDump SQE subtype does not match the runtime protocol");

RuntimeThreadAicpuStatus ToPluginStatus(const rtError_t error)
{
    if (error == RT_ERROR_NONE) {
        return RuntimeThreadAicpuStatus::OK;
    }
    if (error == RT_ERROR_MEMORY_ALLOCATION) {
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    }
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        return RuntimeThreadAicpuStatus::NOT_SUPPORTED;
    }
    if ((error == RT_ERROR_INVALID_VALUE) || (error == RT_ERROR_STREAM_NULL)) {
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
}

rtError_t ToRuntimeStatus(const RuntimeThreadAicpuStatus status)
{
    switch (status) {
        case RuntimeThreadAicpuStatus::OK:
            return RT_ERROR_NONE;
        case RuntimeThreadAicpuStatus::INVALID_PARAM:
        case RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED:
            return RT_ERROR_INVALID_VALUE;
        case RuntimeThreadAicpuStatus::NO_MEMORY:
            return RT_ERROR_MEMORY_ALLOCATION;
        case RuntimeThreadAicpuStatus::NOT_SUPPORTED:
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        case RuntimeThreadAicpuStatus::SYMBOL_NOT_FOUND:
            return RT_ERROR_SYMBOL_NOT_FOUND;
        default:
            return RT_ERROR_AICPU_INTERNAL_ERROR;
    }
}

RuntimeThreadAicpuStatus ReserveGroupId(void* const runtimeData, uint32_t* const groupId)
{
    UNUSED(runtimeData);
    if (groupId == nullptr) {
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    Runtime* const runtime = Runtime::Instance();
    CbSubscribe* const subscribe = (runtime == nullptr) ? nullptr : runtime->GetCbSubscribe();
    if (subscribe == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Reserve RuntimeThreadAicpu callback group failed because callback subscriber is null.");
        return RuntimeThreadAicpuStatus::RUNTIME_ERROR;
    }
    return ToPluginStatus(subscribe->ReserveInternalGroupId(groupId));
}

void ReleaseGroupId(void* const runtimeData, const uint32_t groupId)
{
    UNUSED(runtimeData);
    Runtime* const runtime = Runtime::Instance();
    CbSubscribe* const subscribe = (runtime == nullptr) ? nullptr : runtime->GetCbSubscribe();
    if (subscribe != nullptr) {
        subscribe->ReleaseInternalGroupId(groupId);
    }
}

RuntimeThreadAicpuStatus CreateCompletionEvent(
    void* const runtimeData, void* const streamHandle, void** const eventHandle, uint32_t* const eventId)
{
    if ((runtimeData == nullptr) || (streamHandle == nullptr) || (eventHandle == nullptr) || (eventId == nullptr)) {
        RT_LOG(
            RT_LOG_ERROR,
            "Create RuntimeThreadAicpu completion event failed because hook arguments are invalid, "
            "runtime_data_valid=%u, stream_valid=%u, event_output_valid=%u, event_id_output_valid=%u.",
            static_cast<uint32_t>(runtimeData != nullptr), static_cast<uint32_t>(streamHandle != nullptr),
            static_cast<uint32_t>(eventHandle != nullptr), static_cast<uint32_t>(eventId != nullptr));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    Stream* stream = nullptr;
    const rtError_t validationError = GetValidatedObject<Stream>(streamHandle, stream);
    if (validationError != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Validate RuntimeThreadAicpu stream failed, retCode=%#x.",
            static_cast<uint32_t>(validationError));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    Api* const api = static_cast<Api*>(runtimeData);
    Event* event = nullptr;
    rtError_t error = api->EventCreate(&event, RT_EVENT_DDSYNC_NS);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Create RuntimeThreadAicpu completion event failed, stream_id=%d, retCode=%#x.",
            stream->Id_(), static_cast<uint32_t>(error));
        return ToPluginStatus(error);
    }
    event->SetEventOwner(EventOwner::EVENT_INNER);
    error = event->GetEventID(eventId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Get RuntimeThreadAicpu completion event ID failed, stream_id=%d, retCode=%#x.",
            stream->Id_(), static_cast<uint32_t>(error));
        (void)api->EventDestroy(event);
        return ToPluginStatus(error);
    }
    *eventHandle = event;
    return RuntimeThreadAicpuStatus::OK;
}

void DestroyCompletionEvent(void* const runtimeData, void* const eventHandle)
{
    if ((runtimeData != nullptr) && (eventHandle != nullptr)) {
        const rtError_t error = static_cast<Api*>(runtimeData)->EventDestroy(static_cast<Event*>(eventHandle));
        COND_PROC(
            error != RT_ERROR_NONE,
            RT_LOG(RT_LOG_WARNING, "Destroy RuntimeThreadAicpu event failed, retCode=%#x.", error));
    }
}

void SetStreamError(
    void* const runtimeData, const uint32_t deviceId, const uint32_t tsId, const uint32_t streamId,
    void* const streamHandle, const RuntimeThreadAicpuStreamErrorType errorType, const uint32_t errorDetail)
{
    UNUSED(runtimeData);
    const bool isTimeout = errorType == RuntimeThreadAicpuStreamErrorType::EXECUTION_TIMEOUT;
    if ((errorType != RuntimeThreadAicpuStreamErrorType::EXECUTION_FAILED) && (!isTimeout)) {
        RT_LOG(
            RT_LOG_ERROR, "Set RuntimeThreadAicpu stream error failed because error type is invalid, error_type=%u.",
            static_cast<uint32_t>(errorType));
        return;
    }
    if (isTimeout && (streamHandle == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Set RuntimeThreadAicpu timeout error failed because stream handle is null.");
        return;
    }

    Runtime* const runtime = Runtime::Instance();
    Device* const device = (runtime == nullptr) ? nullptr : runtime->GetDevice(deviceId, tsId, false);
    StreamSqCqManage* const streamManage = (device == nullptr) ? nullptr : device->GetStreamSqCqManage();
    if (streamManage == nullptr) {
        RT_LOG(
            RT_LOG_ERROR,
            "Set RuntimeThreadAicpu stream error failed, device_id=%u, ts_id=%u, stream_id=%u, error_type=%u.",
            deviceId, tsId, streamId, static_cast<uint32_t>(errorType));
        return;
    }

    std::shared_ptr<Stream> reportStream;
    const rtError_t error = streamManage->GetStreamSharedPtrById(streamId, reportStream);
    if ((error != RT_ERROR_NONE) || (reportStream == nullptr)) {
        RT_LOG(
            RT_LOG_ERROR,
            "Get RuntimeThreadAicpu error stream failed, device_id=%u, ts_id=%u, stream_id=%u, error_type=%u, "
            "error_detail=%#x, retCode=%#x.",
            deviceId, tsId, streamId, static_cast<uint32_t>(errorType), errorDetail, static_cast<uint32_t>(error));
        return;
    }
    if ((streamHandle != nullptr) && (reportStream->GetInnerHandle() != streamHandle)) {
        RT_LOG(
            RT_LOG_WARNING,
            "Skip RuntimeThreadAicpu stream error because stream has been reused, device_id=%u, ts_id=%u, "
            "stream_id=%u, error_type=%u.",
            deviceId, tsId, streamId, static_cast<uint32_t>(errorType));
        return;
    }

    Stream* const errorStream = GetReportStream(reportStream.get());
    if (errorStream == nullptr) {
        RT_LOG(
            RT_LOG_ERROR,
            "Set RuntimeThreadAicpu stream error failed because report stream is null, device_id=%u, ts_id=%u, "
            "stream_id=%u, error_type=%u.",
            deviceId, tsId, streamId, static_cast<uint32_t>(errorType));
        return;
    }

    const std::lock_guard<std::mutex> lock(g_streamErrorMutex);
    const uint32_t currentError = errorStream->GetErrCode();
    if (isTimeout) {
        if ((currentError != static_cast<uint32_t>(RT_ERROR_NONE)) &&
            (currentError != static_cast<uint32_t>(RT_ERROR_HOST_FUNC_EXE_FAILED))) {
            RT_LOG(
                RT_LOG_WARNING,
                "Keep existing stream error when RuntimeThreadAicpu operator times out, stream_id=%u, "
                "error_stream_id=%d, current_error=%#x.",
                streamId, errorStream->Id_(), currentError);
            return;
        }
        RT_LOG(
            RT_LOG_ERROR, "Set RuntimeThreadAicpu timeout error, stream_id=%u, error_stream_id=%d.", streamId,
            errorStream->Id_());
        errorStream->SetErrCode(static_cast<uint32_t>(TS_ERROR_AICPU_TIMEOUT));
    } else {
        RT_LOG(
            RT_LOG_ERROR, "RuntimeThreadAicpu operator failed, stream_id=%u, error_stream_id=%d, execute_result=%#x.",
            streamId, errorStream->Id_(), errorDetail);
        if (currentError == static_cast<uint32_t>(TS_ERROR_AICPU_TIMEOUT)) {
            RT_LOG(
                RT_LOG_WARNING,
                "Keep RuntimeThreadAicpu timeout error instead of overwriting it with execution failure, "
                "stream_id=%u, error_stream_id=%d.",
                streamId, errorStream->Id_());
            return;
        }
        errorStream->SetErrCode(static_cast<uint32_t>(RT_ERROR_HOST_FUNC_EXE_FAILED));
    }
}

uint64_t RuntimeThreadAicpuClockGetTimeUs(void* const runtimeData)
{
    UNUSED(runtimeData);
    return ClockGetTimeUs();
}

void MonitorThreadEnter(void* const runtimeData)
{
    UNUSED(runtimeData);
    Runtime* const runtime = Runtime::Instance();
    if (runtime != nullptr) {
        runtime->MonitorNumAdd(1U);
    }
}

void MonitorThreadExit(void* const runtimeData)
{
    UNUSED(runtimeData);
    Runtime* const runtime = Runtime::Instance();
    if (runtime != nullptr) {
        runtime->MonitorNumSub(1U);
    }
}

bool IsProcessExiting(void* const runtimeData)
{
    UNUSED(runtimeData);
    return Runtime::IsProcessExiting(Runtime::Instance());
}

RuntimeThreadAicpuRuntimeHooks BuildRuntimeHooks(Api* const api)
{
    return {
        .structSize = sizeof(RuntimeThreadAicpuRuntimeHooks),
        .runtimeData = api,
        .reserveGroupId = &ReserveGroupId,
        .releaseGroupId = &ReleaseGroupId,
        .createCompletionEvent = &CreateCompletionEvent,
        .destroyCompletionEvent = &DestroyCompletionEvent,
        .setStreamError = &SetStreamError,
        .monitorThreadEnter = &MonitorThreadEnter,
        .monitorThreadExit = &MonitorThreadExit,
        .isProcessExiting = &IsProcessExiting,
        .clockGetTimeUs = &RuntimeThreadAicpuClockGetTimeUs,
    };
}

void MonitorRuntimeThreadAicpuExecution(Device* const dev)
{
    UNUSED(dev);
    const RuntimeThreadAicpuPluginApi* const pluginApi = g_monitorPluginApi.load(std::memory_order_acquire);
    if (pluginApi != nullptr) {
        pluginApi->monitorExecutionTimeout();
    }
}

class RuntimeThreadAicpuAdapter final {
public:
    explicit RuntimeThreadAicpuAdapter(Api* const api) : api_(api) {}

    ~RuntimeThreadAicpuAdapter() noexcept
    {
        if (monitorTaskRegistered_ && (pluginApi_ != nullptr)) {
            (void)UnregisterStarsMonitorTask(&MonitorRuntimeThreadAicpuExecution);
            g_monitorPluginApi.store(nullptr, std::memory_order_release);
        }
        if (streamObserverRegistered_) {
            (void)StreamStateCallbackManager::Instance().RegStreamStateCallback(
                STREAM_OBSERVER_NAME, nullptr, nullptr, cce::runtime::StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
        }
    }

    rtError_t SetExecuteTimeout(const uint64_t timeoutUs)
    {
        const std::lock_guard<std::mutex> lock(mutex_);
        executeTimeoutUs_ = timeoutUs;
        if (pluginApi_ != nullptr) {
            pluginApi_->setExecuteTimeout(timeoutUs);
        }
        return RT_ERROR_NONE;
    }

    rtError_t PrepareKernel(
        const RuntimeThreadAicpuKernelRequest& request, RuntimeThreadAicpuPreparedKernel& preparedKernel)
    {
        std::lock_guard<std::mutex> lock(mutex_);
        rtError_t error = EnsurePlugin();
        if (error != RT_ERROR_NONE) {
            return error;
        }
        return ToRuntimeStatus(pluginApi_->prepareKernel(&request, &preparedKernel));
    }

    rtError_t LoadDumpInfo(
        const uint32_t deviceId, const uint32_t tsId, const void* const dumpInfo, const uint32_t length)
    {
        std::lock_guard<std::mutex> lock(mutex_);
        rtError_t error = EnsurePlugin();
        if (error != RT_ERROR_NONE) {
            return error;
        }
        const RuntimeThreadAicpuStartRequest startRequest = {
            .structSize = sizeof(RuntimeThreadAicpuStartRequest), .deviceId = deviceId, .tsId = tsId};
        error = ToRuntimeStatus(pluginApi_->startWorker(&startRequest));
        if (error != RT_ERROR_NONE) {
            return error;
        }
        const RuntimeThreadAicpuDumpInfoRequest loadRequest = {
            .structSize = sizeof(RuntimeThreadAicpuDumpInfoRequest),
            .deviceId = deviceId,
            .tsId = tsId,
            .dumpInfo = dumpInfo,
            .length = length,
        };
        return ToRuntimeStatus(pluginApi_->loadDumpInfo(&loadRequest));
    }

    void ReleasePreparedKernel(const uint64_t taskCookie)
    {
        std::lock_guard<std::mutex> lock(mutex_);
        if (pluginApi_ != nullptr) {
            pluginApi_->releasePreparedKernel(taskCookie);
        }
    }

    void StreamDestroyed(void* const streamHandle)
    {
        std::lock_guard<std::mutex> lock(mutex_);
        if (pluginApi_ != nullptr) {
            pluginApi_->streamDestroyed(streamHandle);
        }
    }

private:
    static void StreamStateCallback(rtStream_t stream, const rtStreamState state, void* const callbackData)
    {
        if ((state == RT_STREAM_STATE_DESTROY_PRE) && (callbackData != nullptr)) {
            static_cast<RuntimeThreadAicpuAdapter*>(callbackData)->StreamDestroyed(stream);
        }
    }

    rtError_t EnsurePlugin()
    {
        if (unsupported_) {
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        if (pluginApi_ != nullptr) {
            return RT_ERROR_NONE;
        }

        libraryHandle_ = dlopen(PLUGIN_SO_NAME, RTLD_NOW | RTLD_GLOBAL);
        if (libraryHandle_ == nullptr) {
            unsupported_ = true;
            const char* const loadError = dlerror();
            RT_LOG(
                RT_LOG_WARNING, "Load optional RuntimeThreadAicpu plugin failed, so_name=%s, reason=%s.",
                PLUGIN_SO_NAME, (loadError == nullptr) ? "unknown" : loadError);
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        (void)dlerror();
        const auto queryPlugin =
            RtPtrToPtr<RuntimeThreadAicpuGetPluginApiFunc>(dlsym(libraryHandle_, PLUGIN_QUERY_SYMBOL));
        const char* const symbolError = dlerror();
        if ((queryPlugin == nullptr) || (symbolError != nullptr)) {
            unsupported_ = true;
            RT_LOG(
                RT_LOG_ERROR, "Query RuntimeThreadAicpu plugin symbol failed, so_name=%s, symbol=%s, reason=%s.",
                PLUGIN_SO_NAME, PLUGIN_QUERY_SYMBOL, (symbolError == nullptr) ? "symbol address is null" : symbolError);
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }

        const RuntimeThreadAicpuRuntimeHooks hooks = BuildRuntimeHooks(api_);
        const RuntimeThreadAicpuStatus status = queryPlugin(&hooks, &pluginApi_);
        const uint32_t apiSize = (pluginApi_ == nullptr) ? 0U : pluginApi_->structSize;
        const bool apiTableValid = (pluginApi_ != nullptr) && (apiSize >= sizeof(RuntimeThreadAicpuPluginApi));
        const bool prepareValid = apiTableValid && (pluginApi_->prepareKernel != nullptr);
        const bool releaseValid = apiTableValid && (pluginApi_->releasePreparedKernel != nullptr);
        const bool streamDestroyedValid = apiTableValid && (pluginApi_->streamDestroyed != nullptr);
        const bool startWorkerValid = apiTableValid && (pluginApi_->startWorker != nullptr);
        const bool loadDumpInfoValid = apiTableValid && (pluginApi_->loadDumpInfo != nullptr);
        const bool setTimeoutValid = apiTableValid && (pluginApi_->setExecuteTimeout != nullptr);
        const bool monitorValid = apiTableValid && (pluginApi_->monitorExecutionTimeout != nullptr);
        if ((status != RuntimeThreadAicpuStatus::OK) || (!apiTableValid) || (!prepareValid) || (!releaseValid) ||
            (!streamDestroyedValid) || (!startWorkerValid) || (!loadDumpInfoValid) || (!setTimeoutValid) ||
            (!monitorValid)) {
            RT_LOG(
                RT_LOG_ERROR,
                "Initialize RuntimeThreadAicpu plugin interface failed, plugin_status=%u, api_valid=%u, "
                "api_size=%u, expected_size=%zu, prepare_valid=%u, release_valid=%u, stream_destroy_valid=%u, "
                "start_worker_valid=%u, load_dump_info_valid=%u, set_timeout_valid=%u, monitor_valid=%u.",
                static_cast<uint32_t>(status), static_cast<uint32_t>(pluginApi_ != nullptr), apiSize,
                sizeof(RuntimeThreadAicpuPluginApi), static_cast<uint32_t>(prepareValid),
                static_cast<uint32_t>(releaseValid), static_cast<uint32_t>(streamDestroyedValid),
                static_cast<uint32_t>(startWorkerValid), static_cast<uint32_t>(loadDumpInfoValid),
                static_cast<uint32_t>(setTimeoutValid), static_cast<uint32_t>(monitorValid));
            unsupported_ = true;
            pluginApi_ = nullptr;
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }

        pluginApi_->setExecuteTimeout(executeTimeoutUs_);
        rtError_t error = StreamStateCallbackManager::Instance().RegStreamStateCallback(
            STREAM_OBSERVER_NAME, RtPtrToPtr<void*>(&RuntimeThreadAicpuAdapter::StreamStateCallback), this,
            cce::runtime::StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "Register RuntimeThreadAicpu stream observer failed, observer_name=%s, retCode=%#x.",
                STREAM_OBSERVER_NAME, static_cast<uint32_t>(error));
            pluginApi_ = nullptr;
            return error;
        }
        streamObserverRegistered_ = true;

        g_monitorPluginApi.store(pluginApi_, std::memory_order_release);
        error = RegisterStarsMonitorTask(&MonitorRuntimeThreadAicpuExecution);
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "Register RuntimeThreadAicpu monitor task failed, retCode=%#x.",
                static_cast<uint32_t>(error));
            (void)StreamStateCallbackManager::Instance().RegStreamStateCallback(
                STREAM_OBSERVER_NAME, nullptr, nullptr, cce::runtime::StreamStateCallback::RTS_STREAM_STATE_CALLBACK);
            streamObserverRegistered_ = false;
            g_monitorPluginApi.store(nullptr, std::memory_order_release);
            pluginApi_ = nullptr;
            return error;
        }
        monitorTaskRegistered_ = true;
        return RT_ERROR_NONE;
    }

    Api* api_ = nullptr;
    std::mutex mutex_;
    uint64_t executeTimeoutUs_ = RUNTIME_THREAD_AICPU_DEFAULT_EXECUTE_TIMEOUT_US;
    void* libraryHandle_ = nullptr;
    const RuntimeThreadAicpuPluginApi* pluginApi_ = nullptr;
    bool streamObserverRegistered_ = false;
    bool monitorTaskRegistered_ = false;
    bool unsupported_ = false;
};

RuntimeThreadAicpuAdapter* GetAdapter(Api* const api)
{
    static RuntimeThreadAicpuAdapter* const adapter = new (std::nothrow) RuntimeThreadAicpuAdapter(api);
    return adapter;
}

rtError_t SubmitAicpuTask(
    RuntimeThreadAicpuAdapter& adapter, Stream* const stream, const RuntimeThreadAicpuPreparedKernel& preparedKernel)
{
    if ((preparedKernel.eventHandle == nullptr) || (preparedKernel.taskCookie == 0U) ||
        (preparedKernel.funcPtr == 0U) || (preparedKernel.fnData == 0U)) {
        RT_LOG(
            RT_LOG_ERROR,
            "Invalid prepared RuntimeThreadAicpu kernel, stream_id=%d, task_cookie=%llu, event_valid=%u, "
            "func_valid=%u, fndata_valid=%u.",
            stream->Id_(), static_cast<unsigned long long>(preparedKernel.taskCookie),
            static_cast<uint32_t>(preparedKernel.eventHandle != nullptr),
            static_cast<uint32_t>(preparedKernel.funcPtr != 0U), static_cast<uint32_t>(preparedKernel.fnData != 0U));
        adapter.ReleasePreparedKernel(preparedKernel.taskCookie);
        return RT_ERROR_INVALID_VALUE;
    }

    TaskInfo submitTask = {};
    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo* const task =
        stream->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICPU, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT);
    if (task == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "Allocate RuntimeThreadAicpu task failed, stream_id=%d, task_cookie=%llu, retCode=%#x.",
            stream->Id_(), static_cast<unsigned long long>(preparedKernel.taskCookie),
            static_cast<uint32_t>(errorReason));
        adapter.ReleasePreparedKernel(preparedKernel.taskCookie);
        return errorReason;
    }
    Device* const device = stream->Device_();
    const std::function<void()> recycleTask = [device, task]() { (void)device->GetTaskFactory()->Recycle(task); };
    ScopeGuard taskGuard(recycleTask);

    AicpuTaskInit(task, 1U, RT_KERNEL_DEFAULT);
    AicpuTaskInfo& aicpuTask = task->u.aicpuTaskInfo;
    aicpuTask.extraInfo.runtimeThread = {
        preparedKernel.funcPtr,         preparedKernel.fnData,  preparedKernel.callbackCqId,
        preparedKernel.callbackGroupId, preparedKernel.eventId,
    };

    const rtError_t error = device->SubmitTask(task);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR,
            "Submit RuntimeThreadAicpu task failed, device_id=%u, stream_id=%d, task_id=%u, task_cookie=%llu, "
            "retCode=%#x.",
            device->Id_(), stream->Id_(), static_cast<uint32_t>(task->id),
            static_cast<unsigned long long>(preparedKernel.taskCookie), static_cast<uint32_t>(error));
        adapter.ReleasePreparedKernel(preparedKernel.taskCookie);
        return error;
    }
    taskGuard.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(task, stream->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

} // namespace

rtError_t SetRuntimeThreadAicpuExecuteTimeout(Api* const api, const uint64_t timeoutUs)
{
    if (api == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    RuntimeThreadAicpuAdapter* const adapter = GetAdapter(api);
    return (adapter == nullptr) ? RT_ERROR_MEMORY_ALLOCATION : adapter->SetExecuteTimeout(timeoutUs);
}

rtError_t LaunchRuntimeThreadAicpuKernel(
    Api* const api, const Kernel* const kernel, const uint32_t blockDim, const rtCpuKernelArgs_t* const argsInfo,
    Stream* const stream)
{
    if ((api == nullptr) || (kernel == nullptr) || (argsInfo == nullptr) || (stream == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (stream->IsCapturing()) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    RuntimeThreadAicpuAdapter* const adapter = GetAdapter(api);
    if (adapter == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    const std::string soName = kernel->GetCpuKernelSo();
    const std::string functionName = kernel->GetCpuFuncName();
    const std::string opType = kernel->GetCpuOpType();
    RuntimeThreadAicpuKernelRequest request = {
        .structSize = sizeof(RuntimeThreadAicpuKernelRequest),
        .kernelType = kernel->GetAicpuKernelType_(),
        .blockDim = blockDim,
        .deviceId = stream->Device_()->Id_(),
        .tsId = stream->Device_()->DevGetTsId(),
        .streamId = static_cast<uint32_t>(stream->Id_()),
        .streamHandle = stream->GetInnerHandle(),
        .soName = soName.c_str(),
        .functionName = functionName.c_str(),
        .opType = opType.c_str(),
        .args = argsInfo->baseArgs.args,
        .argsSize = argsInfo->baseArgs.argsSize,
        .cpuParamHeadOffset = argsInfo->cpuParamHeadOffset,
        .soNameAddrOffset = argsInfo->baseArgs.soNameAddrOffset,
        .kernelNameAddrOffset = argsInfo->baseArgs.kernelNameAddrOffset,
    };
    RuntimeThreadAicpuPreparedKernel preparedKernel = {};
    preparedKernel.structSize = sizeof(RuntimeThreadAicpuPreparedKernel);
    rtError_t error = adapter->PrepareKernel(request, preparedKernel);
    ERROR_RETURN(error, "Prepare RuntimeThreadAicpu kernel failed, retCode=%#x.", error);

    error = SubmitAicpuTask(*adapter, stream, preparedKernel);
    ERROR_RETURN(error, "Submit RuntimeThreadAicpu kernel failed, retCode=%#x.", error);

    Event* const event = static_cast<Event*>(preparedKernel.eventHandle);
    error = stream->WaitEvent(event, 0U);
    ERROR_RETURN(error, "Wait RuntimeThreadAicpu event failed, retCode=%#x.", error);
    error = event->Reset(stream);
    ERROR_RETURN(error, "Reset RuntimeThreadAicpu event failed, retCode=%#x.", error);
    return RT_ERROR_NONE;
}

rtError_t LoadRuntimeThreadAicpuDumpInfo(
    Api* const api, const uint32_t deviceId, const uint32_t tsId, const void* const dumpInfo, const uint32_t length)
{
    if ((api == nullptr) || (dumpInfo == nullptr) || (length == 0U)) {
        return RT_ERROR_INVALID_VALUE;
    }
    RuntimeThreadAicpuAdapter* const adapter = GetAdapter(api);
    return (adapter == nullptr) ? RT_ERROR_MEMORY_ALLOCATION : adapter->LoadDumpInfo(deviceId, tsId, dumpInfo, length);
}

} // namespace runtime
} // namespace cce
