/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_snapshot.hpp"

namespace cce {
namespace runtime {

DeviceSnapshot::DeviceSnapshot(Device* dev) : NoCopy(), IDeviceSnapshotOps(), device_(dev) {}

DeviceSnapshot::~DeviceSnapshot() noexcept {}

void DeviceSnapshot::RecordOpAddrAndSize(const Stream* const stm) { UNUSED(stm); }

void DeviceSnapshot::GetOpTotalMemoryInfo(const Model* const mdl) { UNUSED(mdl); }

void DeviceSnapshot::RecordFuncCallAddrAndSize(TaskInfo* const task) { UNUSED(task); }

void DeviceSnapshot::RecordArgsAddrAndSize(TaskInfo* const task) { UNUSED(task); }

rtError_t DeviceSnapshot::OpMemoryBackup(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceSnapshot::OpMemoryRestore(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceSnapshot::ArgsPoolRestore(void) const { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceSnapshot::UbArgsPoolRestore(void) const { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceSnapshot::ArgsPoolConvertAddr(H2DCopyMgr* const mgr) const
{
    UNUSED(mgr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void DeviceSnapshot::OpMemoryInfoInit(void) {}

const DeviceSnapshot::TaskHandlerFuncMap& DeviceSnapshot::GetHandlerMap() const
{
    static TaskHandlerFuncMap emptyMap;
    return emptyMap;
}

namespace TaskHandlers {
void HandleStreamSwitch(TaskInfo* const task, DeviceSnapshot* snapshot)
{
    UNUSED(task);
    UNUSED(snapshot);
}
void HandleStreamLabelSwitchByIndex(TaskInfo* const task, DeviceSnapshot* snapshot)
{
    UNUSED(task);
    UNUSED(snapshot);
}
void HandleMemWaitValue(TaskInfo* const task, DeviceSnapshot* snapshot)
{
    UNUSED(task);
    UNUSED(snapshot);
}
void HandleRdmaPiValueModify(TaskInfo* const task, DeviceSnapshot* snapshot)
{
    UNUSED(task);
    UNUSED(snapshot);
}
void HandleStreamActive(TaskInfo* const task, DeviceSnapshot* snapshot)
{
    UNUSED(task);
    UNUSED(snapshot);
}
void HandleModelTaskUpdate(TaskInfo* const task, DeviceSnapshot* snapshot)
{
    UNUSED(task);
    UNUSED(snapshot);
}
} // namespace TaskHandlers

} // namespace runtime
} // namespace cce