/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_MODULE_HPP__
#define __CCE_RUNTIME_MODULE_HPP__

#include "base.hpp"

#define INSTR_ALIGN_SIZE (512U * sizeof(size_t))  // 4K
#define POOL_ALIGN_SIZE 0xFFFU // 4k - 1

namespace cce {
namespace runtime {
class Device;
class Program;
class Kernel;

class Module : public NoCopy {
public:
    explicit Module(Device * const dev);
    ~Module() noexcept override;

    rtError_t Load(Program * const prog);
    rtError_t GetFunction(const Kernel * const kernelIn, uint64_t * const function) const;
    rtError_t GetFunction(const Kernel * const kernelIn, uint64_t * const function1, uint64_t * const function2) const;
    rtError_t GetPrefetchCnt(const Kernel * const kernelIn, uint32_t &icachePrefetchCnt) const;
    rtError_t GetPrefetchCnt(const Kernel * const kernelIn, uint32_t &icachePrefetchCnt1,
                             uint32_t &icachePrefetchCnt2) const;
    rtError_t CalModuleHash(std::size_t &hash) const;
    rtError_t GetTaskRation(const Kernel * const kernelIn,  uint32_t &taskRation) const;

    Program *GetProgram() const;

    const Device *Device_() const
    {
        return device_;
    }

    const void *GetBaseAddr() const
    {
        return baseAddrAlign_;
    }
    
    uint32_t GetBaseAddrSize() const
    {
        return baseAddrSize_;
    }

    uint32_t GetProgMemType_() const
    {
        return progMemType_;
    }
    void GetAicpuLoadInfo(void** soNameBase, uint32_t *soNameSize,
        void** kernelNameBase, uint32_t *kenelNameSize) const
    {
        *soNameBase = soNamesBaseAddr_;
        *soNameSize = soNamesSize_;
        *kernelNameBase = kernelNamesBaseAddr_;
        *kenelNameSize = kernelNamesSize_;
        return;
    }
private:
    Device *device_;
    uint32_t programId_{UINT32_MAX};
    void *baseAddr_;
    void *baseFMAddr_;
    void *baseAddrAlign_;
    void *kernelNamesBaseAddr_;
    void *soNamesBaseAddr_;
    uint32_t progMemType_;
    uint32_t baseAddrSize_;
    uint32_t kernelNamesSize_;
    uint32_t soNamesSize_;
};
}
}

#endif  // __CCE_RUNTIME_MODULE_HPP__
