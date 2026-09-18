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
#ifndef CCE_RUNTIME_API_IMPL_KERNEL_FUNC_HPP
#define CCE_RUNTIME_API_IMPL_KERNEL_FUNC_HPP

#include "api_kernel_func.hpp"

namespace cce {
namespace runtime {

class ApiImplKernelFunc : public ApiKernelFunc {
public:
    rtError_t FuncGetAddr(const Kernel* const funcHandle, void** const aicAddr, void** const aivAddr) override;
    rtError_t FuncGetName(const Kernel* const kernel, const uint32_t maxLen, char_t* const name) override;
    rtError_t FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t* attrValue) override;
    rtError_t FuncGetSize(const Kernel* const funcHandle, size_t* const aicSize, size_t* const aivSize) override;
    rtError_t FunctionGetBinary(const Kernel* const funcHandle, Program** const binHandle) override;
    rtError_t FunctionGetParamCount(const Kernel* funcHandle, size_t* paramCount) override;
    rtError_t FunctionGetParamInfo(
        const Kernel* funcHandle, size_t paramIndex, size_t* paramOffset, size_t* paramSize) override;
    rtError_t FunctionGetAvailDynUbufPerBlock(Kernel* funcHandle, uint32_t flags, size_t* dynamicUbufSize) override;
    rtError_t GetFunctionBySymbol(const void* symbol, Kernel** const funcHandle) override;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_IMPL_KERNEL_FUNC_HPP
