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
    using TraverseFileHandle = std::function<void(const std::string &filePath)>;
    static TSD_StatusT VerifyPackage(const std::string &pkgPath);
    static TSD_StatusT MakeDirectory(const std::string &dirPath);
    static void RemoveFile(const std::string &filePath);
    static void WalkInDir(const std::string &dirPath,
                          const PackageWorkerUtils::TraverseFileHandle &handler,
                          const uint32_t depth);
    static uint64_t GetDirSize(const std::string &dirPath);
    static uint64_t GetFileSize(const std::string &filePath);
    static bool IsSetMemLimit(bool isVfMode, const uint32_t deviceId, const uint32_t vfId);
    static TSD_StatusT CheckMemoryUsage(const std::string &soInstallRootPath, const std::string &memoryLimitFilePath,
                                        const std::string &memoryUsedFilePath, const uint32_t deviceId,
                                        const uint32_t vfId);
    static TSD_StatusT RestoreMemUsage(const uint64_t oldSize, const uint64_t newSize,
                                       const uint32_t deviceId,const uint32_t vfId,
                                       const std::string &memoryLimitFilePath);
private:
    PackageWorkerUtils() = default;
    ~PackageWorkerUtils() = default;

    PackageWorkerUtils(PackageWorkerUtils const&) = delete;
    PackageWorkerUtils& operator=(PackageWorkerUtils const&) = delete;
    PackageWorkerUtils(PackageWorkerUtils&&) = delete;
    PackageWorkerUtils& operator=(PackageWorkerUtils&&) = delete;
    static bool IsCgroupMemMode(const uint32_t deviceId, const uint32_t vfId);
    static TSD_StatusT GetUserMemoryLimit(uint64_t &userMemoryLimit, const std::string &memoryLimitFilePath);
    static TSD_StatusT GetUserMemoryUsed(uint64_t &userMemoryUsed, const std::string &memoryUsedFilePath);
    static TSD_StatusT ReadMemControlValue(const std::string &path, uint64_t &memSize);
    static TSD_StatusT SetMemoryControlValue(const uint64_t userMemoryLimit, const uint32_t deviceId,
                                             const uint32_t vfId);
};
} // namespace tsd

#endif // TSD_PACKAGE_WORKER_UTILS_H