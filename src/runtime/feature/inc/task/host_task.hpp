/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_HOST_TASK_HPP
#define CCE_RUNTIME_HOST_TASK_HPP

#include "base.hpp"
#include "device.hpp"
#include "driver.hpp"

namespace cce {
namespace runtime {
enum HostTaskTypeT {
    RT_HOST_TASK_TYPE_MEMCPY = 0, // Async memcpy task
    RT_HOST_TASK_TYPE_MAX
};

class HostTaskBase : public NoCopy {
public:
    explicit HostTaskBase(HostTaskTypeT type) : type_(type) {}
    ~HostTaskBase() override = default;
    HostTaskTypeT Type_() const {
        return type_;
    }
    virtual rtError_t AsyncCall() = 0;
    virtual rtError_t WaitFinish() = 0;
private:
    HostTaskTypeT type_;
};

class HostTaskMemCpy : public HostTaskBase {
public:
    explicit HostTaskMemCpy(Device * const dev, void * const dst, const uint64_t destMax, const void * const src,
        const uint64_t cnt, const rtMemcpyKind_t kind) : HostTaskBase(RT_HOST_TASK_TYPE_MEMCPY),
        drv_(dev->Driver_()), device_(dev),
        dst_(dst), destMax_(destMax), src_(src), cnt_(cnt), kind_(kind), copyFd_(0ULL)
    {
    }
    ~HostTaskMemCpy() override
    {
        drv_ = nullptr;
        device_ = nullptr;
    }

    rtError_t AsyncCall() override;
    rtError_t WaitFinish() override;
private:
    Driver *drv_;
    Device *device_;
    void * const dst_;
    const uint64_t destMax_;
    const void * const src_;
    const uint64_t cnt_;
    rtMemcpyKind_t kind_;
    volatile uint64_t copyFd_;
};
}
}

#endif // CCE_RUNTIME_HOST_TASK_HPP
