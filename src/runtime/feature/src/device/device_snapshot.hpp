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
#include "base.hpp"
#include "h2d_copy_mgr.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
class Device;
class Stream;
class Model;

class DeviceSnapshot : public NoCopy {
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

    void SetArgPcieBarSize(size_t size)
    {
        argPcieBarSize_ = size;
    }
    size_t GetArgPcieBarSize(void) const
    {
        return argPcieBarSize_;
    }
 
    void SetArgPcieBarAddr(void *addr)
    {
        argPcieBarAddr_ = addr;
    }
 
    void *GetArgPcieBarAddr(void) const
    {
        return argPcieBarAddr_;
    }

    size_t GetOpTotalHostMemSize(void) const
    {
        return opTotalHostMemSize_;
    }

    void RecordOpAddrAndSize(const Stream *const stm);
    void GetOpTotalMemoryInfo(const Model *const mdl);
    void RecordFuncCallAddrAndSize(TaskInfo *const task);
    void RecordArgsAddrAndSize(TaskInfo *const task);
    rtError_t OpMemoryBackup(void);
    rtError_t OpMemoryRestore(void);
    rtError_t ArgsPoolRestore(void) const;
    rtError_t ArgsPoolConvertAddr(H2DCopyMgr *const mgr) const;
    void OpMemoryInfoInit(void);
private:
    std::vector<std::pair<void*, size_t>> opVirtualAddrs_{};
    std::unique_ptr<uint8_t[]> opBackUpAddrs_ = nullptr;
    void *argPcieBarAddr_ = nullptr;
    size_t argPcieBarSize_ = 0U;
    size_t opTotalHostMemSize_ = 0U;
    Device *device_ = nullptr;
};
}
}

#endif  // CCE_RUNTIME_DEVICE_SNAPSHOT_HPP