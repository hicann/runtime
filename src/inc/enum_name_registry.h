/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ENUM_NAME_REGISTRY_H
#define ENUM_NAME_REGISTRY_H

#include <map>
#include <string>
#include <type_traits>

namespace enum_name {
template <typename Enum>
using EnumNameMap = std::map<Enum, std::string>;

template <typename Enum>
struct EnumNameTable;

template <typename Enum>
inline std::string GetEnumName(const Enum value)
{
    static_assert(std::is_enum<Enum>::value, "Enum type required");
    const EnumNameMap<Enum>& table = EnumNameTable<Enum>::Get();
    const typename EnumNameMap<Enum>::const_iterator iter = table.find(value);
    return (iter == table.end()) ? "UNKNOWN" : iter->second;
}
} // namespace enum_name

#endif // ENUM_NAME_REGISTRY_H
