/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_sched_gate.hpp"
#include "device_enum_desc.hpp"
#include "device.hpp"
#include "event_david.hpp"
#include "event_c.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "task.hpp"
#include "event_task.h"

namespace cce {
namespace runtime {
DeviceSchedGate::DeviceSchedGate(Device* const device, const uint32_t interval) : device_(device), interval_(interval)
{}

DeviceSchedGate::~DeviceSchedGate()
{
    if (event_ == nullptr) {
        return;
    }
    if (Runtime::IsProcessExiting(Runtime::Instance())) {
        // Match Device's process-exit policy: the driver and Device state may already be unavailable.
        // Leave the event to process/driver APP-exit cleanup instead of accessing a partially destroyed Device.
        (void)event_.release();
        return;
    }
    Release();
}

bool DeviceSchedGate::Eligible(const Stream* const stream)
{
    return (stream != nullptr) && !stream->IsCtrlStream() && !stream->IsCtrlSQStream() &&
           ((stream->Flags() & (RT_STREAM_AICPU | RT_STREAM_CP_PROCESS_USE)) == 0U);
}

rtError_t DeviceSchedGate::Setup()
{
    Runtime* rt = Runtime::Instance();
    if (!IS_SUPPORT_CHIP_FEATURE(rt->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FUSION) ||
        !IS_SUPPORT_CHIP_FEATURE(rt->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RT_LOG(
            RT_LOG_WARNING, "Chip type(%d) does not support device execution suspend and resume.",
            static_cast<int32_t>(rt->GetChipType()));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Stream* ctrl = device_->GetCtrlSQStream(nullptr);
    if ((ctrl == nullptr) || !ctrl->IsCtrlSQStream()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to get ctrl stream.");
        return RT_ERROR_STREAM_NULL;
    }
    event_.reset(new (std::nothrow) DavidEvent(device_, RT_EVENT_DDSYNC_NS, nullptr, false));
    COND_PROC_RETURN_AND_MSG_ALLOC_FAILED(event_ == nullptr, RT_ERROR_EVENT_NEW, (void)0, sizeof(DavidEvent), "new");
    event_->SetEventOwner(EventOwner::EVENT_INNER);
    rtError_t error = event_->GenEventId();
    if (error != RT_ERROR_NONE) {
        event_.reset();
        return error;
    }
    device_->PushEvent(event_.get());
    return Control(true);
}

rtError_t DeviceSchedGate::Control(const bool open)
{
    if (event_ == nullptr) {
        return RT_ERROR_EVENT_NULL;
    }
    Stream* ctrl = device_->GetCtrlSQStream(nullptr);
    if ((ctrl == nullptr) || !ctrl->IsCtrlSQStream()) {
        return RT_ERROR_STREAM_NULL;
    }
    const rtError_t error = open ? EvtRecord(event_.get(), ctrl) : EvtReset(event_.get(), ctrl);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    return ctrl->Synchronize(false);
}

rtError_t DeviceSchedGate::Suspend() { return Control(false); }

rtError_t DeviceSchedGate::Resume() { return Control(true); }

bool DeviceSchedGate::NeedWait(const Stream* const stream, const tsTaskType_t taskType) const
{
    return IsOperatorTask(taskType) && IsInsertionEnabled() && Eligible(stream) && !stream->IsTaskGroupUpdate() &&
           (stream->GetSchedOperatorCount() >= interval_);
}

rtError_t DeviceSchedGate::TryInsertGateWait(Stream* const stream, const tsTaskType_t taskType)
{
    if (!IsInsertionEnabled() || !Eligible(stream) || stream->IsTaskGroupUpdate() || stream->IsTaskGrouping()) {
        return RT_ERROR_NONE;
    }
    if (stream->GetAbortStatus() != RT_ERROR_NONE) {
        const rtError_t error = stream->GetAbortStatus();
        COND_RETURN_AND_MSG_OUTER(
            error == RT_ERROR_STREAM_ABORT, error, ErrorCode::EE1018, "Submitting a task to a stream",
            RtFmtMsg(
                "Stream (stream_id=%d) on device (device_id=%u) is in abort state. Submit tasks only after the stream "
                "abort operation has completed successfully",
                stream->Id_(), device_->Id_()));
        ERROR_RETURN_MSG_INNER(
            error,
            "Failed to prepare the scheduling gate wait because stream (stream_id=%d) on device (device_id=%u) "
            "is in an error state, retCode=%#x.",
            stream->Id_(), device_->Id_(), static_cast<uint32_t>(error));
    }
    // The caller serializes launches and state changes on the originating stream.
    Stream* target = stream;
    if (stream->IsAutoSplitSq()) {
        const auto& slaves = stream->GetSlaveStreams();
        if (!slaves.empty()) {
            target = slaves.back();
        }
    } else if (stream->GetCaptureStream() != nullptr) {
        target = stream->GetCaptureStream();
    }
    // EvtWait owns the submission lock and resolves the final stream through AllocTask.
    return NeedWait(target, taskType) ? EvtWait(event_.get(), stream, UINT32_MAX) : RT_ERROR_NONE;
}

void DeviceSchedGate::CountSubmittedOperator(Stream* const stream)
{
    if (IsInsertionEnabled() && Eligible(stream) && !stream->IsTaskGroupUpdate()) {
        stream->CountSchedOperator(interval_);
    }
}

void DeviceSchedGate::Release()
{
    DisableInsertion();
    if (event_ == nullptr) {
        return;
    }
    // This protocol may delete the event itself; relinquish ownership before calling it.
    Event* event = event_.release();
    TryToFreeEventIdAndDestroyEvent(&event, event->EventId_(), true);
    event_.reset(event);
    if (event_ != nullptr) {
        // All Host queues are gone. For an unconfirmed task, leave the hardware ID to DeviceClose
        // instead of recycling it before the driver has finished cancellation.
        device_->RemoveEvent(event_.get());
        event_->SetEventId(INVALID_EVENT_ID);
        event_.reset();
    }
}
} // namespace runtime
} // namespace cce
