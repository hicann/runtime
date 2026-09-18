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

#include "api_impl_kernel_func.hpp"

#include <cstring>
#include <new>
#include <sstream>
#include <string>

#include "api_impl_creator.hpp"
#include "base_david.hpp"
#include "context.hpp"
#include "device.hpp"
#include "error_message_manage.hpp"
#include "kernel.hpp"
#include "kernel_utils.hpp"
#include "program.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {

bool IsImplKernelFuncSupported() { return true; }

ApiKernelFunc* CreateImplKernelFuncAndGet()
{
    ApiKernelFunc* const apiImplKernelFunc = new (std::nothrow) ApiImplKernelFunc();
    if (apiImplKernelFunc == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplKernelFunc), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplKernelFunc failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplKernelFunc:Runtime_alloc_size %zu", sizeof(ApiImplKernelFunc));
    return apiImplKernelFunc;
}

void DestroyImplKernelFunc(ApiKernelFunc*& apiImplKernelFunc)
{
    delete apiImplKernelFunc;
    apiImplKernelFunc = nullptr;
}

// check if kernel is for vector core
static bool CheckVectorKernel(const Kernel* const kernel)
{
    // 1. common aiv kernel
    if (kernel->GetKernelAttrType() == RT_KERNEL_ATTR_TYPE_VECTOR) {
        return true;
    }
    // 2. mix aiv only kernel
    if (kernel->GetMixType() == MIX_AIV) {
        return true;
    }
    return false;
}

rtError_t ApiImplKernelFunc::FuncGetAddr(const Kernel* const funcHandle, void** const aicAddr, void** const aivAddr)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        funcHandle, RT_ERROR_INVALID_VALUE, "Obtaining the execution address of a specified kernel on the device");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        aicAddr, RT_ERROR_INVALID_VALUE, "Obtaining the execution address of a specified kernel on the device");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        aivAddr, RT_ERROR_INVALID_VALUE, "Obtaining the execution address of a specified kernel on the device");
    COND_RETURN_AND_MSG_OUTER(
        funcHandle->GetKernelRegisterType() != RT_KERNEL_REG_TYPE_NON_CPU, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Obtaining the execution address of a specified kernel on the device", "funcHandle",
        "The funcHandle obtained after registering the AI CPU operator is not supported");

    Runtime::Instance()->CallApiBegin(RT_PROF_API_FUNC_GET_ADDR);
    uint64_t funcAddr1 = 0ULL;
    uint64_t funcAddr2 = 0ULL;
    const rtError_t error = funcHandle->GetFunctionDevAddr(funcAddr1, funcAddr2);
    if (error != RT_ERROR_NONE) {
        *aicAddr = nullptr;
        *aivAddr = nullptr;
    } else if ((funcAddr1 != 0ULL) && (funcAddr2 == 0ULL) && CheckVectorKernel(funcHandle)) {
        // there is only one address, and the kernel is for vector core
        *aivAddr = RtValueToPtr<void*>(funcAddr1);
        *aicAddr = RtValueToPtr<void*>(funcAddr2);
    } else {
        *aicAddr = RtValueToPtr<void*>(funcAddr1);
        *aivAddr = RtValueToPtr<void*>(funcAddr2);
    }
    Runtime::Instance()->CallApiEnd(error);
    ERROR_RETURN(error, "Get func addr by function handle failed.");
    return error;
}

rtError_t ApiImplKernelFunc::FuncGetName(const Kernel* const kernel, const uint32_t maxLen, char_t* const name)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(kernel, RT_ERROR_INVALID_VALUE, "Obtaining the kernel function name");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(name, RT_ERROR_INVALID_VALUE, "Obtaining the kernel function name");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        maxLen < (kernel->Name_().length() + 1U), RT_ERROR_INVALID_VALUE, "Obtaining the kernel function name", maxLen,
        "greater than or equal to " + std::to_string(kernel->Name_().length() + 1U));

    const errno_t error =
        memcpy_s(name, static_cast<size_t>(maxLen), kernel->Name_().c_str(), kernel->Name_().length() + 1U);
    if (error != EOK) {
        std::stringstream ss;
        ss << std::hex << "name=0x" << RtPtrToValue(name) << ", kernelName=0x" << RtPtrToValue(kernel->Name_().c_str())
           << std::dec << ", maxLen=" << maxLen << ", actualLen=" << kernel->Name_().length() + 1U << ".";
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1020, "Obtaining the kernel function name", "memcpy_s", std::to_string(error).c_str(),
            strerror(error), ss.str().c_str());
        const rtError_t ret = RT_ERROR_SEC_HANDLE;
        ERROR_RETURN(ret, "get func name failed");
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t* attrValue)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        funcHandle, RT_ERROR_INVALID_VALUE, "Obtaining kernel function attributes");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(attrValue, RT_ERROR_INVALID_VALUE, "Obtaining kernel function attributes");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        ((static_cast<uint32_t>(attrType) < RT_FUNCTION_ATTR_KERNEL_TYPE) ||
         (static_cast<uint32_t>(attrType) >= RT_FUNCTION_ATTR_MAX)),
        RT_ERROR_INVALID_VALUE, "Obtaining kernel function attributes",
        (attrType == RT_FUNCTION_ATTR_MAX) ? "FUNCTION_ATTR_MAX(4)" :
                                             RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(attrType)),
        "attrType",
        "[" + std::to_string(RT_FUNCTION_ATTR_KERNEL_TYPE) + ", " + std::to_string(RT_FUNCTION_ATTR_MAX) + ")");

    if (attrType == RT_FUNCTION_ATTR_KERNEL_RATIO) {
        const Runtime* const rtInstance = Runtime::Instance();
        NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
        const rtChipType_t chipType = rtInstance->GetChipType();
        COND_RETURN_WARN(
            !IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH),
            ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) does not support rtFunctionGetAttribute api, return.",
            static_cast<int32_t>(chipType));
        const Kernel* const kernel = RtPtrToPtr<Kernel*>(funcHandle);
        COND_RETURN_AND_MSG_OUTER(
            kernel->GetKernelRegisterType() != RT_KERNEL_REG_TYPE_NON_CPU, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
            "Obtaining kernel function attributes", "funcHandle",
            "The funcHandle obtained after registering the AI CPU operator is not supported");
    }

    const Kernel* const kernel = RtPtrToPtr<Kernel*>(funcHandle);
    switch (attrType) {
        case RT_FUNCTION_ATTR_KERNEL_TYPE: {
            *attrValue = static_cast<int64_t>(kernel->GetKernelAttrType());
            COND_RETURN_ERROR_MSG_INNER(
                *attrValue == static_cast<int64_t>(RT_KERNEL_ATTR_TYPE_INVALID), RT_ERROR_INVALID_VALUE,
                "Invalid kernel type.");
            break;
        }
        case RT_FUNCTION_ATTR_KERNEL_RATIO: {
            const uint32_t taskRatio = kernel->GetTaskRation();
            const uint32_t mixType = kernel->GetMixType();
            uint16_t ratio[2];
            ComputeRatio(ratio, mixType, taskRatio);
            uint16_t* ratioArr = RtPtrToPtr<uint16_t*>(attrValue);
            ratioArr[1] = ratio[0]; // aicratio
            ratioArr[0] = ratio[1]; // aivratio
            RT_LOG(RT_LOG_DEBUG, "mixType=%u, ratio[0]=%u, ratio[1]=%u.", mixType, ratio[0], ratio[1]);
            break;
        }
        case RT_FUNCTION_ATTR_KERNEL_SCHED_MODE: {
            *attrValue = static_cast<int64_t>(kernel->GetSchedMode());
            break;
        }
        default: {
            if (attrType == RT_FUNCTION_ATTR_MAX) {
                RT_LOG(RT_LOG_WARNING, "Invalid attrType=FUNCTION_ATTR_MAX(4)");
            } else {
                RT_LOG(RT_LOG_WARNING, "Invalid attrType=UNKNOWN(%d)", static_cast<int32_t>(attrType));
            }
            break;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::FuncGetSize(const Kernel* const funcHandle, size_t* const aicSize, size_t* const aivSize)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        funcHandle, RT_ERROR_INVALID_VALUE, "Obtaining the size of the kernel function code segment");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        aicSize, RT_ERROR_INVALID_VALUE, "Obtaining the size of the kernel function code segment");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        aivSize, RT_ERROR_INVALID_VALUE, "Obtaining the size of the kernel function code segment");
    COND_RETURN_AND_MSG_OUTER(
        funcHandle->GetKernelRegisterType() != RT_KERNEL_REG_TYPE_NON_CPU, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Obtaining the size of the kernel function code segment", "funcHandle",
        "The funcHandle obtained after registering the AI CPU operator is not supported");

    uint32_t funcSize1 = 0U;
    uint32_t funcSize2 = 0U;
    funcHandle->GetKernelLength(funcSize1, funcSize2);
    if ((funcSize1 != 0U) && (funcSize2 == 0U) && (CheckVectorKernel(funcHandle))) {
        // there is only one size, and the kernel is for vector core
        *aivSize = RtValueToPtr<size_t>(funcSize1);
        *aicSize = RtValueToPtr<size_t>(funcSize2);
    } else {
        *aicSize = RtValueToPtr<size_t>(funcSize1);
        *aivSize = RtValueToPtr<size_t>(funcSize2);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::FunctionGetBinary(const Kernel* const funcHandle, Program** const binHandle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        funcHandle, RT_ERROR_INVALID_VALUE, "Obtaining the binary handle of an operator");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        binHandle, RT_ERROR_INVALID_VALUE, "Obtaining the binary handle of an operator");
    Program* const prog = funcHandle->Program_();
    *binHandle = prog;
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::FunctionGetParamCount(const Kernel* funcHandle, size_t* paramCount)
{
    COND_RETURN_WARN(
        funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU, RT_ERROR_FEATURE_NOT_SUPPORT,
        "AI CPU kernels are not supported.");
    COND_RETURN_AND_MSG_OUTER(
        !funcHandle->HasParamSummary(), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Obtaining the number of parameters from the kernel function handle", "funcHandle",
        "Kernel does not have parameter information");
    *paramCount = static_cast<size_t>(funcHandle->GetParamCount());
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::FunctionGetParamInfo(
    const Kernel* funcHandle, size_t paramIndex, size_t* paramOffset, size_t* paramSize)
{
    COND_RETURN_WARN(
        funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU, RT_ERROR_FEATURE_NOT_SUPPORT,
        "AI CPU kernels are not supported.");
    COND_RETURN_AND_MSG_OUTER(
        !funcHandle->HasParamSummary(), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Obtaining parameter information from the kernel function handle", "funcHandle",
        "Kernel does not have parameter information");
    if (paramIndex >= funcHandle->GetParamCount()) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1003, "Obtaining parameter information from the kernel function handle", paramIndex,
            "paramIndex", "[0, " + std::to_string(funcHandle->GetParamCount()) + ")");
        return RT_ERROR_INVALID_VALUE;
    }

    uint32_t offset = 0U;
    uint32_t size = 0U;
    const rtError_t error = funcHandle->GetParamInfo(static_cast<uint32_t>(paramIndex), &offset, &size);
    ERROR_RETURN(error, "GetParamInfo failed, paramIndex=%zu.", paramIndex);
    if (paramOffset != nullptr) {
        *paramOffset = static_cast<size_t>(offset);
    }
    if (paramSize != nullptr) {
        *paramSize = static_cast<size_t>(size);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::FunctionGetAvailDynUbufPerBlock(
    Kernel* funcHandle, uint32_t flags, size_t* dynamicUbufSize)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        funcHandle, RT_ERROR_INVALID_VALUE,
        "Querying the maximum size of the dynamic UB buffer that can be set for a kernel function");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        dynamicUbufSize, RT_ERROR_INVALID_VALUE,
        "Querying the maximum size of the dynamic UB buffer that can be set for a kernel function");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flags != 0U), RT_ERROR_INVALID_VALUE,
        "Querying the maximum size of the dynamic UB buffer that can be set for a kernel function", flags, "0");
    NULL_PTR_RETURN_MSG(funcHandle->Program_(), RT_ERROR_PROGRAM_NULL);

    const uint32_t kernelVfType = funcHandle->KernelVfType_();
    const bool simtFlag = (kernelVfType == static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY)) ||
                          (kernelVfType == static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMD_SIMT_MIX_VF));
    if (!simtFlag) {
        *dynamicUbufSize = 0U;
        return RT_ERROR_NONE;
    }

    COND_RETURN_ERROR_MSG_INNER(
        funcHandle->ShareMemSize_() > RT_SIMT_REMAIN_UB_SIZE, RT_ERROR_INVALID_VALUE,
        "Compiler alloc ub size %u exceeds the maximum simt ub limit %u.", funcHandle->ShareMemSize_(),
        RT_SIMT_REMAIN_UB_SIZE);
    *dynamicUbufSize = static_cast<size_t>(RT_SIMT_REMAIN_UB_SIZE - funcHandle->ShareMemSize_());
    return RT_ERROR_NONE;
}

rtError_t ApiImplKernelFunc::GetFunctionBySymbol(const void* symbol, Kernel** const funcHandle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        symbol, RT_ERROR_INVALID_VALUE, "Obtaining the kernel function handle based on the function symbol name");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        funcHandle, RT_ERROR_INVALID_VALUE, "Obtaining the kernel function handle based on the function symbol name");

    const Kernel* kernelTmp = nullptr;
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG(device, RT_ERROR_DEVICE_NULL);
    Runtime* const rtInstance = Runtime::Instance();
    kernelTmp = rtInstance->funcSymbolTable_.Lookup(symbol);
    if (kernelTmp == nullptr) {
        return RT_ERROR_INVALID_DEVICE_FUNCTION;
    }

    const Program* const prog = kernelTmp->Program_();
    Program* const progTmp = const_cast<Program*>(prog);
    rtError_t ret = progTmp->CopySoAndNameToCurrentDevice();
    ERROR_RETURN(ret, "copy program failed retCode=%#x.", ret);

    *funcHandle = const_cast<Kernel*>(kernelTmp);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
