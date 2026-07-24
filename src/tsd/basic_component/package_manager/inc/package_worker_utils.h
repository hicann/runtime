/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_PACKAGE_WORKER_UTILS_H
#define TSD_PACKAGE_WORKER_UTILS_H

#include <string>
#include <functional>
#include "tsd/status.h"

namespace tsd {

class PackageWorkerUtils {
public:
    using TraverseFileHandle = std::function<void(const std::string& filePath)>;
    static TSD_StatusT VerifyPackage(const std::string& pkgPath);
    static TSD_StatusT MakeDirectory(const std::string& dirPath);
    static void RemoveFile(const std::string& filePath);
    static uint64_t GetFileSize(const std::string& filePath);

private:
    PackageWorkerUtils() = default;
    ~PackageWorkerUtils() = default;
    PackageWorkerUtils(PackageWorkerUtils const&) = delete;
    PackageWorkerUtils& operator=(PackageWorkerUtils const&) = delete;
    PackageWorkerUtils(PackageWorkerUtils&&) = delete;
    PackageWorkerUtils& operator=(PackageWorkerUtils&&) = delete;
};
} // namespace tsd

#endif // TSD_PACKAGE_WORKER_UTILS_H