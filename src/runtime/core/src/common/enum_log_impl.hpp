/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ENUM_LOG_IMPL_HPP
#define CCE_RUNTIME_ENUM_LOG_IMPL_HPP

#include "common/enum_log.hpp"

// Private implementation macros; keep metadata and generated functions in source files.
#define RT_ENUM_STRING_CASE(symbol, text) \
    case symbol:                          \
        return text;
#define RT_ENUM_STRING_SCOPED_CASE(symbol, text) \
    case decltype(value)::symbol:                \
        return text;
#define RT_ENUM_LOG_I64_CASE(symbol, text)          \
    case static_cast<int64_t>(EnumLogType::symbol): \
        return text;

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
#define RT_ENUM_STRING_IMPL_TYPED(funcName, parameterType, enumScope, metaTable, itemMacro, numberType, fallback) \
    RT_ENUM_LOG_NOINLINE const char* funcName(parameterType value) noexcept                                       \
    {                                                                                                             \
        using EnumLogType = enumScope;                                                                            \
        (void)sizeof(EnumLogType);                                                                                \
        switch (value) {                                                                                          \
            metaTable(itemMacro) default : return fallback;                                                       \
        }                                                                                                         \
    }

#define RT_ENUM_STRING_IMPL(funcName, enumType, metaTable, itemMacro, numberType, fallback) \
    RT_ENUM_STRING_IMPL_TYPED(funcName, enumType, enumType, metaTable, itemMacro, numberType, fallback)
#define RT_ENUM_STRING_TO_STRING(funcName, enumType, metaTable) \
    RT_ENUM_STRING_IMPL(funcName, enumType, metaTable, RT_ENUM_STRING_CASE, int32_t, "UNKNOWN")
#define RT_ENUM_STRING_TO_STRING_U32(funcName, enumType, metaTable) \
    RT_ENUM_STRING_IMPL(funcName, enumType, metaTable, RT_ENUM_STRING_CASE, uint32_t, "UNKNOWN")
#define RT_ENUM_STRING_TO_STRING_SCOPED(funcName, enumType, metaTable) \
    RT_ENUM_STRING_IMPL(funcName, enumType, metaTable, RT_ENUM_STRING_SCOPED_CASE, int32_t, "UNKNOWN")
// Compare raw diagnostic values without narrowing them to the enum type.
#define RT_ENUM_STRING_TO_STRING_I64(funcName, enumType, metaTable) \
    RT_ENUM_STRING_IMPL_TYPED(funcName, int64_t, enumType, metaTable, RT_ENUM_LOG_I64_CASE, int64_t, "UNKNOWN")

#endif // RUNTIME_ENABLE_ENUM_LOG_NAMES

#endif // CCE_RUNTIME_ENUM_LOG_IMPL_HPP
