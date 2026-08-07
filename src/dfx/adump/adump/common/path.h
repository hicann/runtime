/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PATH_H
#define ADUMP_COMMON_PATH_H

#include <string>
#include "mmpa_api.h"

namespace Adx {
class Path {
public:
    Path() noexcept : path_() {}
    explicit Path(const std::string &path) : path_(path) {}
    ~Path() = default;

    Path &operator = (const std::string &path);
    bool operator == (const Path &other) const;
    Path &operator += (const std::string &path);
    Path &Assign(const std::string &path);
    Path &Append(const std::string &path);
    Path &Concat(const std::string &path);
    Path &AddExtension(const std::string &extension);
    std::string GetExtension() const;
    std::string GetFileName() const;
    bool Empty() const;
    bool Exist() const;
    bool Asccess(mmMode_t mode) const;
    bool IsDirectory() const;
    bool RealPath();
    Path ParentPath() const;
    bool CreateDirectory(bool recursion = false) const;
    std::string GetString() const;
    const char *GetCString() const;
    /*
     * @brief: 将相对文件 relativeFile 拼接到 rootPath 下，生成规范化的绝对文件路径。处理包括：
     *         1) 校验 relativeFile 不含 '..' 路径段（防路径穿越）；
     *         2) 递归创建父目录；
     *         3) 对父目录做 RealPath 解析并校验其确为目录；
     *         4) 纵深防御：校验解析后的父目录仍位于 rootPath 之内（防落盘根目录下的软链接指向外部）。
     * @param [in]  rootPath      根路径（限定的落盘根目录）
     * @param [in]  relativeFile  相对文件路径（不能为空，不允许包含 '..' 段；前导 '/' 会被 Concat 剥离）
     * @param [out] canonicalFile 规范化后的绝对文件路径（父目录已 RealPath 解析）
     * @return true: 合法且父目录就绪; false: 入参非法、路径穿越、创建目录失败、父目录非法或逃逸出 rootPath
     */
    static bool BuildFullPathUnderRoot(const std::string &rootPath, const std::string &relativeFile,
        std::string &canonicalFile);

    /*
     * @brief: 判断 realSubPath 是否位于 realDirPath 目录之内（含相等）。两个入参都必须是已 RealPath 解析
     *         的规范化绝对路径。按 '/' 路径段比较，避免 /root_evil 被 /root 误判为子路径。
     * @param [in] realDirPath 规范化后的目录路径
     * @param [in] realSubPath 规范化后的待判断路径
     * @return true: realSubPath 在 realDirPath 之内; false: 不在其内或入参为空
     */
    static bool IsUnderDirectory(const std::string &realDirPath, const std::string &realSubPath);

    /*
     * @brief: 判断相对路径中是否存在 '..' 路径段（按 '/' 分段判断，避免误杀 my..file.bin 这类合法文件名）。
     * @param [in] path 待判断的相对路径
     * @return true: 存在 '..' 路径段（可能导致路径穿越）; false: 不存在
     */
    static bool HasParentDirSegment(const std::string &path);

private:
    void AppendPath(const std::string &path);
    void AddSeperator();
    std::string path_;
};
} // namespace Adx

#endif // ADUMP_COMMON_PATH_H