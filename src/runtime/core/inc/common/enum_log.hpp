/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ENUM_LOG_HPP
#define CCE_RUNTIME_ENUM_LOG_HPP

// Internal host logging helpers and declaration macros for enum owners.

#include "enum_log.h"

#if defined(__GNUC__) || defined(__clang__)
#define RT_ENUM_LOG_NOINLINE __attribute__((noinline))
#elif defined(_MSC_VER)
#define RT_ENUM_LOG_NOINLINE __declspec(noinline)
#else
#define RT_ENUM_LOG_NOINLINE
#endif

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
namespace cce {
namespace runtime {

// Borrow only names whose storage outlives the synchronous log call.
static inline const char* NormalizeEnumLogName(const char* name) noexcept { return name != nullptr ? name : "UNKNOWN"; }

} // namespace runtime
} // namespace cce

#define RT_ENUM_LOG_NAME(name) ::cce::runtime::NormalizeEnumLogName(name)
#define RT_ENUM_LOG_FORMAT(numericFormat) "%s(" numericFormat ")"
#define RT_ENUM_LOG_VALUE(number, name) (name), (number)
#else
// Drop the name expression entirely, including references to disabled converters.
#define RT_ENUM_LOG_FORMAT(numericFormat) numericFormat
#define RT_ENUM_LOG_VALUE(number, name) (number)
#endif

#endif // CCE_RUNTIME_ENUM_LOG_HPP
