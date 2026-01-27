/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "program_common.hpp"

namespace cce {
namespace runtime {
void SetCpuKernelAttr(Kernel *kernel, const CpuKernelInfo &kernelInfo, const std::string &opType)
{
    rtKernelType_t kernelType = KERNEL_TYPE_RESERVED;
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetCpuFuncName(kernelInfo.funcName);
    kernel->SetCpuKernelSo(kernelInfo.kernelSo);
    kernel->SetCpuOpType(opType);
    kernel->SetSystemParaNum(0U);
    kernel->SetUserParaNum(USER_ARGS_MAX_NUM);
    kernel->SetIsNeedSetFftsAddrInArg(false);
    kernel->SetIsSupportOverFlow(false);
    kernel->SetKernelType_(static_cast<uint32_t>(kernelType));
    kernel->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_AICPU);
    if (!kernelInfo.hasOpKernelLib) {
        RT_LOG(RT_LOG_ERROR, "opKernelLib does not exist, return");
        return;
    }

    const std::string opKernelLib = kernelInfo.opKernelLib;
    if ((opKernelLib == "CUSTAICPUKernel")) {
        kernelType = KERNEL_TYPE_AICPU_CUSTOM;
    } else if (opKernelLib == "AICPUKernel") {
        kernelType = kernelInfo.isUserDefined ? KERNEL_TYPE_AICPU_CUSTOM : KERNEL_TYPE_AICPU;
    } else if (opKernelLib == "TFKernel") {
        kernelType = KERNEL_TYPE_FWK;
    } else if (opKernelLib == "KFCKernel") {
        kernelType = KERNEL_TYPE_AICPU_KFC;
    } else if (opKernelLib == "CUSTKFCKernel"){
        kernelType = KERNEL_TYPE_CUSTOM_KFC;
    } else {
        // skip, no operation
        RT_LOG(RT_LOG_ERROR, "opKernelLib does not exist, default KERNEL_TYPE_RESERVED");
    }

    kernel->SetKernelType_(static_cast<uint32_t>(kernelType));
    return;
}

}
}