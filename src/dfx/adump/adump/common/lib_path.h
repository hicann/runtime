/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TUNING_LIB_PATH_H
#define TUNING_LIB_PATH_H

#include <vector>
#include "path.h"

namespace Adx {
class LibPath {
public:
    LibPath(const LibPath&) = delete;
    LibPath& operator=(const LibPath&) = delete;
    static LibPath& Instance();
    Path GetInstallParentPath() const;
    Path GetInstallPath() const;
    std::string GetTargetPath(const std::string &concatName) const;
    std::vector<std::string> ObtainAllPluginSo(const std::string &searchPath) const;
private:
    LibPath(){};
    ~LibPath(){};
    Path GetSelfLibraryDir() const;
    Path GetSelfPath() const;
    bool IsPluginSo(const std::string &fileName) const;
};
} // namespace Adx
#endif