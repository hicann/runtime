/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ARG_LOADER_HPP__
#define __CCE_RUNTIME_ARG_LOADER_HPP__

#include <string>
#include <unordered_map>
#include "runtime/kernel.h"
#include "base.hpp"
#include "osal.hpp"
#include "driver.hpp"
#include "device.hpp"
#include "load_policy.hpp"
#include "h2d_copy_mgr.hpp"

namespace cce {
namespace runtime {
class Device;
class Stream;
class Event;

inline void UpdateAddrField(
    const void* const kerArgs, void* const argsHostAddr, const uint16_t hostInputInfoNum,
    const rtHostInputInfo* const hostInputInfoPtr)
{
    for (uint16_t i = 0U; i < hostInputInfoNum; i++) {
        const uint32_t addrOffset = hostInputInfoPtr[i].addrOffset;
        const uint32_t dataOffset = hostInputInfoPtr[i].dataOffset;
        *(RtPtrToPtr<uint64_t*, char_t*>(RtPtrToPtr<char_t*, void*>(argsHostAddr) + addrOffset)) =
            RtPtrToValue<const void*>(kerArgs) + dataOffset;
    }
}

struct ArgLoaderResult {
    void* handle;
    void* kerArgs;
    uint32_t allocatedEntrySize{0U}; // 实际分配的 entry 大小，0=按 argsSize 拷贝
};

struct StreamSwitchNLoadResult {
    const void* valuePtr;
    const void* trueStreamPtr;
};

enum KernelInfoType { SO_NAME, KERNEL_NAME, MAX_NAME };

struct Handle {
    void* kerArgs;
    bool freeArgs;
    H2DCopyMgr* argsAlloc;
};

// Management of argument loading.
class ArgLoader : public NoCopy {
public:
    explicit ArgLoader(Device* dev) : NoCopy(), drv_(dev->Driver_()), device_(dev) {}

    ~ArgLoader() override
    {
        drv_ = nullptr;
        device_ = nullptr;
    }

    virtual rtError_t Init() = 0;
    // for starsv2
    virtual rtError_t AllocCopyPtrWithGenericPolicy(const uint32_t size, ArgLoaderResult* const result) = 0;

    virtual rtError_t Load(const rtArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result) = 0;
    virtual rtError_t LoadForMix(
        const rtArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result, bool& mixOpt) = 0;
    virtual rtError_t PureLoad(const uint32_t size, const void* const args, ArgLoaderResult* const result) = 0;
    virtual rtError_t Release(void* const argHandle) = 0;

    virtual rtError_t LoadCpuKernelArgs(
        const rtArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result) = 0;
    virtual rtError_t LoadCpuKernelArgsEx(
        const rtAicpuArgsEx_t* const argsInfo, Stream* const stm, ArgLoaderResult* const result) = 0;
    virtual rtError_t GetKernelInfoDevAddr(const char_t* const name, const KernelInfoType type, void** const addr)
    {
        (void)name;
        (void)type;
        (void)addr;
        return RT_ERROR_NONE;
    }

    virtual void GetKernelInfoFromAddr(std::string& name, const KernelInfoType type, void* addr)
    {
        (void)name;
        (void)type;
        (void)addr;
    }
    virtual void RestoreAiCpuKernelInfo(void) = 0;

    virtual rtError_t LoadStreamSwitchNArgs(
        Stream* const stm, const void* const valuePtr, const uint32_t valueSize, Stream** const trueStreamPtr,
        const uint32_t elementSize, const rtSwitchDataType_t dataType, StreamSwitchNLoadResult* const result) = 0;
    virtual bool CheckPcieBar(void) = 0;

    virtual rtError_t AllocCopyPtr(uint32_t size, LoadPolicy policy, ArgLoaderResult* result)
    {
        if (policy == LoadPolicy::LP_GENERIC) {
            // starsv2
            return AllocCopyPtrWithGenericPolicy(size, result);
        }
        // stars
        return AllocCopyPtrWithSpecificPolicy(size, policy, result);
    }

    // ArgManager 统一流程：no-copy 时分配 Handle（freeArgs=false），按历史行为填充字段
    // 默认返回 FEATURE_NOT_SUPPORT，只有 UmaArgLoader override 提供实际实现
    virtual rtError_t AllocNoCopyPtr(void* hostArgs, ArgLoaderResult* result)
    {
        UNUSED(hostArgs);
        UNUSED(result);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    // ArgManager 统一流程：按策略分配设备内存 + Handle
    // 默认返回 FEATURE_NOT_SUPPORT，只有 UmaArgLoader override 提供实际实现
    virtual rtError_t AllocCopyPtrWithSpecificPolicy(uint32_t size, LoadPolicy policy, ArgLoaderResult* result)
    {
        UNUSED(size);
        UNUSED(policy);
        UNUSED(result);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

protected:
    Driver* drv_;
    Device* device_;
};
} // namespace runtime
} // namespace cce
#endif // __CCE_RUNTIME_ARG_LOADER_HPP__
