/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/plugin_pkg_version.h"

#include <algorithm>
#include <cctype>
#include <fstream>
#include <sstream>
#include <vector>

#include "tsd_util_func.h"

namespace tsd {
namespace {
const std::string PKG_SUFFIX = ".tar.gz";
const std::string INI_SUFFIX = ".ini";
const std::string KEY_VERSION = "version";
const std::string KEY_TIMESTAMP = "timestamp";
} // namespace

std::string PluginPkgVersionUtil::GetIniNameByPkgName(const std::string& pkgName)
{
    if (pkgName.size() > PKG_SUFFIX.size() &&
        pkgName.compare(pkgName.size() - PKG_SUFFIX.size(), PKG_SUFFIX.size(), PKG_SUFFIX) == 0) {
        return pkgName.substr(0U, pkgName.size() - PKG_SUFFIX.size()) + INI_SUFFIX;
    }
    return pkgName + INI_SUFFIX;
}

bool PluginPkgVersionUtil::ParseLine(const std::string& line, std::string& key, std::string& value)
{
    std::string trimmed = line;
    TrimWhitespace(trimmed);
    if (trimmed.empty() || trimmed[0] == '#' || trimmed[0] == ';') {
        return false;
    }
    auto pos = trimmed.find('=');
    if (pos == std::string::npos || pos == 0U) {
        return false;
    }
    key = trimmed.substr(0U, pos);
    value = trimmed.substr(pos + 1U);
    TrimWhitespace(key);
    TrimWhitespace(value);
    return !key.empty();
}

bool PluginPkgVersionUtil::ParseIniFile(const std::string& iniPath, PluginPkgVersion& info)
{
    std::ifstream ifs(iniPath);
    if (!ifs.is_open()) {
        return false;
    }
    info.version.clear();
    info.timestamp.clear();
    constexpr int32_t kMaxLines = 10;
    int32_t lineCount = 0;
    std::string line;
    while (lineCount < kMaxLines && std::getline(ifs, line)) {
        ++lineCount;
        std::string k;
        std::string v;
        if (!ParseLine(line, k, v)) {
            continue;
        }
        // key 大小写不敏感，统一转小写后再比较，兼容 Version=/VERSION=/version= 等写法
        std::transform(
            k.begin(), k.end(), k.begin(), [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
        if (k == KEY_VERSION) {
            info.version = v;
        } else if (k == KEY_TIMESTAMP) {
            info.timestamp = v;
        }
        if (!info.version.empty() && !info.timestamp.empty()) {
            break;
        }
    }
    return !info.version.empty();
}

int32_t PluginPkgVersionUtil::CompareVersion(const std::string& versionA, const std::string& versionB)
{
    std::vector<std::string> partsA = SplitByChar(versionA, '.');
    std::vector<std::string> partsB = SplitByChar(versionB, '.');
    size_t n = std::max(partsA.size(), partsB.size());
    for (size_t i = 0U; i < n; ++i) {
        const std::string& a = (i < partsA.size()) ? partsA[i] : std::string("0");
        const std::string& b = (i < partsB.size()) ? partsB[i] : std::string("0");
        int32_t cmp = CompareSegmentNumeric(a, b);
        if (cmp != 0) {
            return cmp;
        }
    }
    return 0;
}

int32_t PluginPkgVersionUtil::CompareTimestamp(const std::string& timestampA, const std::string& timestampB)
{
    if (timestampA == timestampB) {
        return 0;
    }
    return (timestampA < timestampB) ? -1 : 1;
}

int32_t PluginPkgVersionUtil::Compare(const PluginPkgVersion& a, const PluginPkgVersion& b)
{
    int32_t cmp = CompareVersion(a.version, b.version);
    if (cmp != 0) {
        return cmp;
    }
    return CompareTimestamp(a.timestamp, b.timestamp);
}

} // namespace tsd
