/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdarg>
#include "str_utils.h"
#include <algorithm>
#include <stdexcept>
#include "securec.h"

namespace Adx {
constexpr size_t const LIMIT_PER_MESSAGE = 1024U;

std::string StrUtils::TrimLeft(const std::string &s)
{
    std::string rs = s;
    (void)rs.erase(rs.begin(), std::find_if(rs.begin(), rs.end(), [](uint8_t ch) { return !std::isspace(ch); }));
    return rs;
}

std::string StrUtils::TrimRight(const std::string &s)
{
    std::string rs = s;
    (void)rs.erase(std::find_if(rs.rbegin(), rs.rend(), [](uint8_t ch) { return !std::isspace(ch); }).base(),
        rs.end());
    return rs;
}

std::string StrUtils::Trim(const std::string &s)
{
    std::string tmp = TrimLeft(s);
    return TrimRight(tmp);
}

std::string StrUtils::Replace(const std::string &s, const std::set<char> &oldChars, char newChar)
{
    auto replace = [&oldChars, newChar](char &ch) {
        if (oldChars.find(ch) != oldChars.cend()) {
            ch = newChar;
        }
    };
    std::string rs = s;
    (void)std::for_each(rs.begin(), rs.end(), replace);
    return rs;
}

std::vector<std::string> StrUtils::Split(const std::string &str, const char * const delimiter)
{
    std::vector<std::string> resVec;
    if (str.empty()) {
        return resVec;
    }

    if (delimiter == nullptr) {
        return resVec;
    }

    std::string token;
    std::istringstream tokenStream(str);
    while (std::getline(tokenStream, token, *delimiter)) {
        resVec.emplace_back(token);
    }
    return resVec;
}
std::string StrUtils::Format(const char *const fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    char formatStr[LIMIT_PER_MESSAGE] = {};
    const int32_t ret = vsnprintf_s(formatStr, static_cast<size_t>(LIMIT_PER_MESSAGE),
        static_cast<size_t>(LIMIT_PER_MESSAGE - 1U), fmt, ap);
    va_end(ap);
    return ret == -1 ? "" : formatStr;
}
} // namespace Adx