/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_SCHED_GATE_HPP
#define CCE_RUNTIME_DEVICE_SCHED_GATE_HPP
#include <atomic>
#include <memory>
#include "task_base.hpp"

namespace cce {
namespace runtime {
class Device;
class Stream;
class Event;

// Owned exclusively by Device. Tasks retain the existing Event references.
class DeviceSchedGate {
public:
    DeviceSchedGate(Device* const device, const uint32_t interval);
    // Device must stop task processing and destroy queues before releasing/destroying the gate.
    ~DeviceSchedGate();
    rtError_t Setup();
    // Caller holds the Runtime device-slot protection through control completion.
    rtError_t Suspend();
    rtError_t Resume();
    // Stop adding waits; Runtime resumes the gate before committing DISABLE configuration.
    void DisableInsertion() { insertionEnabled_.store(false, std::memory_order_release); }
    bool IsInsertionEnabled() const { return insertionEnabled_.load(std::memory_order_acquire); }
    bool NeedWait(const Stream* const stream, const tsTaskType_t taskType) const;
    // Called by operator launches on the originating stream, without holding the submission lock.
    rtError_t TryInsertGateWait(Stream* const stream, const tsTaskType_t taskType);
    void CountSubmittedOperator(Stream* const stream);
    void Release(); // queues have been destroyed; driver still alive
    static bool IsOperatorTask(const tsTaskType_t taskType)
    {
        return (
            (taskType == TS_TASK_TYPE_KERNEL_AICORE) || (taskType == TS_TASK_TYPE_KERNEL_AIVEC) ||
            (taskType == TS_TASK_TYPE_KERNEL_AICPU) || (taskType == TS_TASK_TYPE_FUSION_KERNEL) ||
            (taskType == TS_TASK_TYPE_KERNEL_MIX_AIC) || (taskType == TS_TASK_TYPE_KERNEL_MIX_AIV) ||
            (taskType == TS_TASK_TYPE_MULTIPLE_TASK));
    }
    static bool Eligible(const Stream* const stream);
    Event* GateEvent() const { return event_.get(); }

private:
    rtError_t Control(const bool open);
    Device* device_;
    std::unique_ptr<Event> event_;
    const uint32_t interval_;
    std::atomic<bool> insertionEnabled_{true};
};
} // namespace runtime
} // namespace cce
#endif
