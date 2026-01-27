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
#include "runtime.hpp"
#include "h2d_copy_mgr.hpp"

namespace cce {
namespace runtime {
class Device;
class Stream;
class Event;

struct ArgLoaderResult {
    void *handle;
    void *kerArgs;
    void *smArgs;
};

struct StreamSwitchNLoadResult {
    const void *valuePtr;
    const void *trueStreamPtr;
};

enum KernelInfoType {
    SO_NAME,
    KERNEL_NAME,
    MAX_NAME
};

struct Handle {
    void *kerArgs;
    void *smArgs;
    bool freeArgs;
    bool freeL2Desc;
    H2DCopyMgr *argsAlloc;
};


// Management of argment loading.
class ArgLoader : public NoCopy {
public:
    explicit ArgLoader(Device *dev) : NoCopy(), drv_(dev->Driver_()), device_(dev)
    {
    }

    ~ArgLoader() override
    {
        drv_ = nullptr;
        device_ = nullptr;
    }

    virtual rtError_t Init() = 0;
    virtual rtError_t AllocCopyPtr(const uint32_t size, ArgLoaderResult * const result) = 0; // for David, not use smArgs
    virtual rtError_t Load(const uint32_t kernelType, const rtArgsEx_t * const argsInfo,
                           rtSmDesc_t * const smDesc, Stream * const stm, ArgLoaderResult * const result) = 0;
    virtual rtError_t LoadForMix(const uint32_t kernelType, const rtArgsEx_t * const argsInfo,
                                 rtSmDesc_t * const smDesc, Stream * const stm, ArgLoaderResult * const result, bool &mixOpt) = 0;
    virtual rtError_t PureLoad(const uint32_t size, const void * const args, ArgLoaderResult * const result) = 0;
    virtual rtError_t Release(void * const argHandle) = 0;

    virtual rtError_t LoadCpuKernelArgs(const rtArgsEx_t * const argsInfo, Stream * const stm,
                                        ArgLoaderResult * const result) = 0;
    virtual rtError_t LoadCpuKernelArgsEx(const rtAicpuArgsEx_t * const argsInfo, Stream * const stm,
                                          ArgLoaderResult * const result) = 0;
    virtual rtError_t GetKernelInfoDevAddr(const char_t * const name, const KernelInfoType type, void ** const addr)
    {
        (void)name;
        (void)type;
        (void)addr;
        return RT_ERROR_NONE;
    }

    virtual void GetKernelInfoFromAddr(std::string &name, const KernelInfoType type, void* addr)
    {
        (void)name;
        (void)type;
        (void)addr;
    }
    virtual void RestoreAiCpuKernelInfo(void) = 0;

    virtual rtError_t LoadStreamSwitchNArgs(Stream * const stm, const void * const valuePtr,
                                            const uint32_t valueSize, Stream ** const trueStreamPtr,
                                            const uint32_t elementSize, const rtSwitchDataType_t dataType,
                                            StreamSwitchNLoadResult * const result) = 0;
    virtual bool CheckPcieBar(void) = 0;
protected:
    Driver *drv_;
    Device *device_;
};
}
}
#endif  // __CCE_RUNTIME_ARG_LOADER_HPP__
