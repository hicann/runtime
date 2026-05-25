/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_SNAPSHOT_HPP
#define CCE_RUNTIME_DEVICE_SNAPSHOT_HPP
#include <vector>
#include <unordered_map>
#include "base.hpp"
#include "h2d_copy_mgr.hpp"
#include "task_info.hpp"
#include "idevice_snapshot_ops.hpp"

namespace cce {
namespace runtime {

class Device;
class Stream;
class Model;

class DeviceSnapshot : public NoCopy, public IDeviceSnapshotOps {
public:
    explicit DeviceSnapshot(Device *dev);

    ~DeviceSnapshot() noexcept override;

    void AddOpVirtualAddr(void* addr, size_t size)
    {
        opVirtualAddrs_.push_back(std::make_pair(addr, size));
        opTotalHostMemSize_ += size;
    }
 
    std::vector<std::pair<void*, size_t>> GetOpVirtualAddrs()
    {
        return opVirtualAddrs_;
    }
 
    std::unique_ptr<uint8_t []> &GetOpBackUpAddr()
    {
        return opBackUpAddrs_;
    }

    void SetOpBackUpAddr(std::unique_ptr<uint8_t []> &hostAddr)
    {
        opBackUpAddrs_ = std::move(hostAddr);
    }

    size_t GetOpTotalHostMemSize(void) const
    {
        return opTotalHostMemSize_;
    }

    void RecordOpAddrAndSize(const Stream *const stm);
    void GetOpTotalMemoryInfo(const Model *const mdl);
    void RecordFuncCallAddrAndSize(TaskInfo *const task);
    void RecordArgsAddrAndSize(TaskInfo *const task);
    rtError_t OpMemoryBackup(void) override;
    rtError_t OpMemoryRestore(void) override;
    rtError_t ArgsPoolRestore(void) const override;
    rtError_t UbArgsPoolRestore(void) const override;
    rtError_t ArgsPoolConvertAddr(H2DCopyMgr *const mgr) const;
    void OpMemoryInfoInit(void);
protected:
    using TaskHandlerFunc = void (*)(TaskInfo* const, DeviceSnapshot*);
    using TaskHandlerFuncMap = std::unordered_map<int, TaskHandlerFunc>;
    const TaskHandlerFuncMap& GetHandlerMap() const;
private:
    std::vector<std::pair<void*, size_t>> opVirtualAddrs_{};
    std::unique_ptr<uint8_t[]> opBackUpAddrs_ = nullptr;
    size_t opTotalHostMemSize_ = 0U;
    Device *device_ = nullptr;
};

namespace TaskHandlers {
    void HandleStreamSwitch(TaskInfo* const task, DeviceSnapshot* snapshot);
    void HandleStreamLabelSwitchByIndex(TaskInfo* const task, DeviceSnapshot* snapshot);
    void HandleMemWaitValue(TaskInfo* const task, DeviceSnapshot* snapshot);
    void HandleRdmaPiValueModify(TaskInfo* const task, DeviceSnapshot* snapshot);
    void HandleStreamActive(TaskInfo* const task, DeviceSnapshot* snapshot);
    void HandleModelTaskUpdate(TaskInfo* const task, DeviceSnapshot* snapshot);
} // namespace TaskHandlers
} // namespace runtime
} // namespace cce

#endif  // CCE_RUNTIME_DEVICE_SNAPSHOT_HPP