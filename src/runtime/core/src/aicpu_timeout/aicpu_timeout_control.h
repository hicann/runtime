/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_AICPU_TIMEOUT_CONTROL_H
#define CCE_RUNTIME_AICPU_TIMEOUT_CONTROL_H

#include <string>
#include <cstdint>

#include "base.hpp"

namespace cce {
namespace runtime {

class Device;
class Stream;

class AicpuTimeoutControl {
public:
    // Queries AI CPU package capability, not platform support; TS kernel names require the "tsKernel:" prefix.
    static rtError_t CheckKernelSupported(Device* const dev, const std::string& kernelName, bool& isSupported);

    static rtError_t CloseAicpuMonitor(Device* const dev, bool& closed);

private:
    static rtError_t LaunchAicpuBuiltinKernel(
        Stream* const stm, const char_t* const kernelName, void* const devArgs, const uint32_t argsSize);
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_AICPU_TIMEOUT_CONTROL_H
