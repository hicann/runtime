/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "enum_log_impl.hpp"

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
#include "../../inc/kernel/elf.hpp"
#include "../../inc/task/task_base.hpp"
#include "../../inc/task/task_info.hpp"
#include <cstring>

#define RT_KERNEL_FUNCTION_TYPE_META(X)                                       \
    X(KERNEL_FUNCTION_TYPE_INVALID, "KERNEL_FUNCTION_TYPE_INVALID")           \
    X(KERNEL_FUNCTION_TYPE_AICORE, "KERNEL_FUNCTION_TYPE_AICORE")             \
    X(KERNEL_FUNCTION_TYPE_AIC, "KERNEL_FUNCTION_TYPE_AIC")                   \
    X(KERNEL_FUNCTION_TYPE_AIV, "KERNEL_FUNCTION_TYPE_AIV")                   \
    X(KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN, "KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN") \
    X(KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN, "KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN") \
    X(KERNEL_FUNCTION_TYPE_AIC_ROLLBACK, "KERNEL_FUNCTION_TYPE_AIC_ROLLBACK") \
    X(KERNEL_FUNCTION_TYPE_AIV_ROLLBACK, "KERNEL_FUNCTION_TYPE_AIV_ROLLBACK") \
    X(KERNEL_FUNCTION_TYPE_MAX, "UNKNOWN")

#define RT_PROF_TASK_TYPE_META(X)                                               \
    X(PROF_TASK_TYPE_KERNEL_SIMT, "PROF_TASK_TYPE_KERNEL_SIMT")                 \
    X(PROF_TASK_TYPE_MODEL_WAIT_COMPLETE, "PROF_TASK_TYPE_MODEL_WAIT_COMPLETE") \
    X(PROF_TASK_TYPE_NOTIFY_RESET, "PROF_TASK_TYPE_NOTIFY_RESET")               \
    X(PROF_TASK_TYPE_COUNT_NOTIFY_RECORD, "PROF_TASK_TYPE_COUNT_NOTIFY_RECORD") \
    X(PROF_TASK_TYPE_COUNT_NOTIFY_WAIT, "PROF_TASK_TYPE_COUNT_NOTIFY_WAIT")

namespace cce {
namespace runtime {

// These wrappers borrow names from Runtime task and kernel implementations.
const char* TsTaskTypeToString(const tsTaskType_t value) noexcept
{
    const char_t* name = GetTaskDescByType(static_cast<uint8_t>(value));
    constexpr char unknownStr[] = "unknown";
    constexpr std::size_t unknownStrLen = sizeof(unknownStr) - 1;
    if (name == nullptr || std::strncmp(name, unknownStr, unknownStrLen) == 0) {
        name = "UNKNOWN";
    }
    return name;
}

RT_ENUM_STRING_TO_STRING_U32(KernelFunctionTypeToString, KernelFunctionType, RT_KERNEL_FUNCTION_TYPE_META)

RT_ENUM_STRING_FROM_VALUE(KernelFunctionTypeToString, KernelFunctionType, RT_KERNEL_FUNCTION_TYPE_META, uint32_t)

RT_ENUM_STRING_FROM_VALUE(ProfTaskTypeToString, ProfTaskType, RT_PROF_TASK_TYPE_META, uint64_t)

} // namespace runtime
} // namespace cce

#endif // RUNTIME_ENABLE_ENUM_LOG_NAMES
