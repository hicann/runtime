/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under
 * the terms and conditions of CANN Open Software License Agreement Version 2.0
 * (the "License"). Please refer to the License for details. You may not use
 * this file except in compliance with the License. THIS SOFTWARE IS PROVIDED ON
 * AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS
 * FOR A PARTICULAR PURPOSE. See LICENSE in the root of the software repository
 * for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_KERNEL_FUNC_HPP
#define CCE_RUNTIME_API_KERNEL_FUNC_HPP

#include "base.hpp"
#include "runtime/rt.h"

namespace cce {
namespace runtime {

class Kernel;
class Program;

class ApiKernelFunc {
public:
    ApiKernelFunc() = default;
    virtual ~ApiKernelFunc() = default;

    ApiKernelFunc(const ApiKernelFunc&) = delete;
    ApiKernelFunc& operator=(const ApiKernelFunc&) = delete;
    ApiKernelFunc(ApiKernelFunc&&) = delete;
    ApiKernelFunc& operator=(ApiKernelFunc&&) = delete;

    static ApiKernelFunc* Instance();

    virtual rtError_t FuncGetAddr(const Kernel* const funcHandle, void** const aicAddr, void** const aivAddr) = 0;
    virtual rtError_t FuncGetName(const Kernel* const kernel, const uint32_t maxLen, char_t* const name) = 0;
    virtual rtError_t FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t* attrValue) = 0;
    virtual rtError_t FuncGetSize(const Kernel* const funcHandle, size_t* const aicSize, size_t* const aivSize) = 0;
    virtual rtError_t FunctionGetBinary(const Kernel* const funcHandle, Program** const binHandle) = 0;
    virtual rtError_t FunctionGetParamCount(const Kernel* funcHandle, size_t* paramCount) = 0;
    virtual rtError_t FunctionGetParamInfo(
        const Kernel* funcHandle, size_t paramIndex, size_t* paramOffset, size_t* paramSize) = 0;
    virtual rtError_t FunctionGetAvailDynUbufPerBlock(Kernel* funcHandle, uint32_t flags, size_t* dynamicUbufSize) = 0;
    virtual rtError_t GetFunctionBySymbol(const void* symbol, Kernel** const funcHandle) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_KERNEL_FUNC_HPP
