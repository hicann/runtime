/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_impl.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImpl::KernelArgsGetHandleMemSize(Kernel* const funcHandle, size_t* memSize)
{
    UNUSED(funcHandle);
    UNUSED(memSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsFinalize(RtArgsHandle* argsHandle)
{
    UNUSED(argsHandle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsInitByUserMem(
    Kernel* const funcHandle, RtArgsHandle* argsHandle, void* userHostMem, size_t actualArgsSize)
{
    UNUSED(funcHandle);
    UNUSED(argsHandle);
    UNUSED(userHostMem);
    UNUSED(actualArgsSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsGetMemSize(Kernel* const funcHandle, size_t userArgsSize, size_t* actualArgsSize)
{
    UNUSED(funcHandle);
    UNUSED(userArgsSize);
    UNUSED(actualArgsSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsInit(Kernel* const funcHandle, RtArgsHandle** argsHandle)
{
    UNUSED(funcHandle);
    UNUSED(argsHandle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsAppendPlaceHolder(RtArgsHandle* argsHandle, ParaDetail** paraHandle)
{
    UNUSED(argsHandle);
    UNUSED(paraHandle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsGetPlaceHolderBuffer(
    RtArgsHandle* argsHandle, ParaDetail* paraHandle, size_t dataSize, void** bufferAddr)
{
    UNUSED(argsHandle);
    UNUSED(paraHandle);
    UNUSED(dataSize);
    UNUSED(bufferAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::KernelArgsAppend(RtArgsHandle* argsHandle, void* para, size_t paraSize, ParaDetail** paraHandle)
{
    UNUSED(argsHandle);
    UNUSED(para);
    UNUSED(paraSize);
    UNUSED(paraHandle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
