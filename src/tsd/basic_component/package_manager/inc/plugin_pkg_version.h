/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_PLUGIN_PKG_VERSION_H
#define INNER_INC_PLUGIN_PKG_VERSION_H

#include <cstdint>
#include <string>

namespace tsd {

// 插件包更新策略，对应DRV设备管理模块设置
enum class PluginUpdateStrategy : uint32_t {
    PLUGIN_NOT_FORCE_UPDATE = 0U, // 不强制更新：版本比较决定是否更新
    PLUGIN_FORCE_UPDATE = 1U,     // 强制更新：忽略版本/hash，直接更新
    PLUGIN_NO_UPDATE = 2U         // 不更新：不加载插件包
};

// 插件包(.compat.tar.gz)版本信息，由同路径下同名.ini配置文件描述
struct PluginPkgVersion {
    std::string version;   // 例如 8.5.0
    std::string timestamp; // 例如 20260114_115609804

    bool Empty() const { return version.empty() && timestamp.empty(); }
};

class PluginPkgVersionUtil {
public:
    // 根据插件包文件名 (cann-xxx-compat.tar.gz) 得到对应ini配置文件名 (cann-xxx-compat.ini)
    static std::string GetIniNameByPkgName(const std::string& pkgName);

    // 从一行配置 (key=value) 中提取key 与 value，成功返回 true
    static bool ParseLine(const std::string& line, std::string& key, std::string& value);

    // 解析 .ini 文件得到 version / timestamp
    static bool ParseIniFile(const std::string& iniPath, PluginPkgVersion& info);

    // 比较两个版本号，按 '.' 分割逐段数值比较
    // 返回 -1 表示 a < b, 0 表示 ==, 1 表示 a > b
    static int32_t CompareVersion(const std::string& versionA, const std::string& versionB);

    // 比较两个时间戳，简单字典序比较 (时间戳格式 YYYYMMDD_HHMMSSXXX 单调)
    static int32_t CompareTimestamp(const std::string& timestampA, const std::string& timestampB);

    // 综合 version + timestamp 比较，version 优先
    static int32_t Compare(const PluginPkgVersion& a, const PluginPkgVersion& b);
};

} // namespace tsd

#endif // INNER_INC_PLUGIN_PKG_VERSION_H
