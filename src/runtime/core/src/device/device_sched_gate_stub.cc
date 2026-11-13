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
#include "base.hpp"
#include "event.hpp"
namespace cce {
namespace runtime {
DeviceSchedGate::DeviceSchedGate(Device* const device, const uint32_t interval) : device_(device), interval_(interval)
{}
DeviceSchedGate::~DeviceSchedGate() = default;
rtError_t DeviceSchedGate::Setup() { return RT_ERROR_FEATURE_NOT_SUPPORT; }
rtError_t DeviceSchedGate::Suspend() { return RT_ERROR_FEATURE_NOT_SUPPORT; }
rtError_t DeviceSchedGate::Resume() { return RT_ERROR_FEATURE_NOT_SUPPORT; }
bool DeviceSchedGate::NeedWait(const Stream*, tsTaskType_t) const { return false; }
rtError_t DeviceSchedGate::TryInsertGateWait(Stream*, tsTaskType_t) { return RT_ERROR_FEATURE_NOT_SUPPORT; }
void DeviceSchedGate::CountSubmittedOperator(Stream*) {}
void DeviceSchedGate::Release() {}
bool DeviceSchedGate::Eligible(const Stream*) { return false; }
} // namespace runtime
} // namespace cce
