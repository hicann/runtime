/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_AICPU_SO_MANAGER_HPP
#define RUNTIME_THREAD_AICPU_SO_MANAGER_HPP

#include <mutex>
#include <string>
#include <unordered_map>

#include "aicpu_sched/runtime_thread_aicpu_plugin.h"

namespace cce {
namespace runtime_thread_aicpu {

class SoManager final {
public:
    RuntimeThreadAicpuStatus GetFunction(
        const std::string& soName, const std::string& functionName, void** const function, std::string& errorDetail);

private:
    std::string ResolvePath(const std::string& soName) const;

    std::mutex mutex_;
    std::unordered_map<std::string, void*> handles_;
    std::unordered_map<std::string, void*> functions_;
};

} // namespace runtime_thread_aicpu
} // namespace cce

#endif
