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
#include "base.hpp"
namespace cce {
namespace runtime {

rtError_t Program::XpuSetKernelLiteralNameDevAddr(Kernel* kernel, const uint32_t devId)
{
    void* funcPc = nullptr;

    if (kernel == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to set the XPU kernel address because kernel is null.");
        return RT_ERROR_KERNEL_NULL;
    }

    std::string binPath = GetBinPath();
    binHandle_ = mmDlopen(binPath.c_str(), RTLD_LAZY);
    if (binHandle_ == nullptr) {
        const char_t* const dlError = mmDlerror();
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1014, RtFmtMsg(
                                   "The operator binary file %s cannot be loaded, reason=%s", binPath.c_str(),
                                   (dlError == nullptr) ? "unknown" : dlError));
        return RT_ERROR_INVALID_VALUE;
    }

    funcPc = mmDlsym(binHandle_, kernel->Name_().c_str());
    if (funcPc == nullptr) {
        const char_t* const dlError = mmDlerror();
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1014,
            RtFmtMsg(
                "The symbol %s does not exist in the operator binary file %s, reason=%s", kernel->Name_().c_str(),
                binPath.c_str(), (dlError == nullptr) ? "unknown" : dlError));
        return RT_ERROR_INVALID_VALUE;
    }

    kernel->SetKernelLiteralNameDevAddr(nullptr, funcPc, devId);
    RT_LOG(
        RT_LOG_INFO, "Get function symbol[%s] in binary file[%s], binHandle: %p, funcPc: %p, devId: %u.",
        kernel->Name_().c_str(), binPath.c_str(), binHandle_, funcPc, devId);

    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
