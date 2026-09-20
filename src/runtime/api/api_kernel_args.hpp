/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_KERNEL_ARGS_HPP
#define CCE_RUNTIME_API_KERNEL_ARGS_HPP

#include <cstddef>

#include "base.hpp"

namespace cce {
namespace runtime {

class Kernel;

class ApiKernelArgs {
public:
    ApiKernelArgs() = default;
    virtual ~ApiKernelArgs() = default;

    ApiKernelArgs(const ApiKernelArgs&) = delete;
    ApiKernelArgs& operator=(const ApiKernelArgs&) = delete;
    ApiKernelArgs(ApiKernelArgs&&) = delete;
    ApiKernelArgs& operator=(ApiKernelArgs&&) = delete;

    static ApiKernelArgs* Instance();

    virtual rtError_t KernelArgsInit(Kernel* const funcHandle, RtArgsHandle** argsHandle) = 0;
    virtual rtError_t KernelArgsInitByUserMem(
        Kernel* const funcHandle, RtArgsHandle* argsHandle, void* userHostMem, size_t actualArgsSize) = 0;
    virtual rtError_t KernelArgsGetMemSize(Kernel* const funcHandle, size_t userArgsSize, size_t* actualArgsSize) = 0;
    virtual rtError_t KernelArgsGetHandleMemSize(Kernel* const funcHandle, size_t* memSize) = 0;
    virtual rtError_t KernelArgsAppend(
        RtArgsHandle* argsHandle, void* para, size_t paraSize, ParaDetail** paraHandle) = 0;
    virtual rtError_t KernelArgsAppendPlaceHolder(RtArgsHandle* argsHandle, ParaDetail** paraHandle) = 0;
    virtual rtError_t KernelArgsGetPlaceHolderBuffer(
        RtArgsHandle* argsHandle, ParaDetail* paraHandle, size_t dataSize, void** bufferAddr) = 0;
    virtual rtError_t KernelArgsFinalize(RtArgsHandle* argsHandle) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_KERNEL_ARGS_HPP
