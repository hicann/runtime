/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_STR_UTILS_H
#define ADUMP_COMMON_STR_UTILS_H
#include <string>
#include <set>
#include <vector>
#include <sstream>
#include <cstdint>

namespace Adx {
class StrUtils {
public:
    static std::string TrimLeft(const std::string &s);
    static std::string TrimRight(const std::string &s);
    static std::string Trim(const std::string &s);
    static std::string Replace(const std::string &s, const std::set<char> &oldChars, char newChar);

    template <typename T>
    static std::string ToString(const std::vector<T> &v);

    template <typename T>
    static bool ToInteger(const std::string &str, T &integer);
    static std::vector<std::string> Split(const std::string &str, const char * const delimiter);
    static std::string Format(const char *const fmt, ...);
};

template <typename T> std::string StrUtils::ToString(const std::vector<T> &v)
{
    std::stringstream ss;
    std::string delimeter = "";
    ss << '[';
    for (const auto &e : v) {
        ss << delimeter << e;
        delimeter = ",";
    }
    ss << ']';
    return ss.str();
}

template <typename T> struct ToIntegerTrait;
template <> struct ToIntegerTrait<int32_t> {
    static inline int32_t Invoke(const std::string &s)
    {
        return std::stoi(s);
    }
};
template <> struct ToIntegerTrait<uint32_t> {
    static inline uint32_t Invoke(const std::string &s)
    {
        return static_cast<uint32_t>(std::stoul(s));
    }
};

template <typename T>
bool StrUtils::ToInteger(const std::string &str, T &integer)
{
    auto stox = ToIntegerTrait<T>::Invoke;
    try {
        integer = stox(str);
    } catch (std::invalid_argument &) {
        return false;
    } catch (std::out_of_range &) {
        return false;
    }
    return true;
}
} // namespace Adx
#endif // ADUMP_COMMON_STR_UTILS_H