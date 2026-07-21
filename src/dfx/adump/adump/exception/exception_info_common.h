/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef EXCEPTION_INFO_COMMON_H
#define EXCEPTION_INFO_COMMON_H

#include <string>
#include "runtime/rt.h"

namespace Adx {

struct ExceptionRegInfo {
    uint32_t coreNum;
    rtExceptionErrRegInfo_t *errRegInfo;
};

enum class KernelMixType {
    NONE,
    AIC,
    AIV
};

class ExceptionInfoCommon {
public:
    static int32_t GetExceptionInfo(const rtExceptionInfo &exception, rtExceptionArgsInfo_t &exceptionArgsInfo);
    static int32_t GetExceptionRegInfo(const rtExceptionInfo &exception, ExceptionRegInfo &exceptionRegInfo);
    static int32_t GetBinDataFromHandle(rtBinHandle binHandle, std::string &binData, uint32_t &binSize);
    static std::string GetExceptionTaskTypeName(const rtExceptionInfo &exception);
    static bool IsSupportExceptionDump(const rtExceptionInfo &exception);
    static bool IsSupportDefaultExceptionDump(const rtExceptionInfo &exception);
    static std::string GetKernelNameWithoutMixSuffix(const std::string &kernelName);
    static std::string GetExceptionKernelName(const rtExceptionInfo &exception);
    static int32_t GetKernelDeviceAddr(rtBinHandle binHandle, void * &devAddr);
    static KernelMixType GetKernelMixType(const std::string &kernelName);
};
}  // namespace Adx
#endif
