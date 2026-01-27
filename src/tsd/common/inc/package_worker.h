/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_WORKER_H
#define TSD_PACKAGE_WORKER_H

#include <map>
#include <mutex>
#include <array>
#include <memory>
#include "inc/package_worker_factory.h"


namespace tsd {
class PackageWorker {
public:
    explicit PackageWorker(const uint32_t devId, const uint32_t vfId) : deviceId_(devId), vfId_(vfId),
                                                                        isDestroy_(false), workers_({})
    {
        workers_.fill(nullptr);
    };

    ~PackageWorker() {
        Stop();
    };

    static std::shared_ptr<PackageWorker> GetInstance(const uint32_t devId, const uint32_t vfId);
    TSD_StatusT LoadPackage(const PackageWorkerType type, const std::string &path, const std::string &fileName);
    TSD_StatusT UnloadPackage(const PackageWorkerType type);
    uint64_t GetPackageCheckCode(const PackageWorkerType type);
    void ClearPackageCheckCode(const PackageWorkerType type);
    std::shared_ptr<BasePackageWorker> GetPackageWorker(const PackageWorkerType type);
    void DestroyPackageWorker();
    void SetAsanMode(const bool isAsan);
    static void RemoveWholeResidualFile(const uint32_t devId, const uint32_t vfId);
    void GetAllPackageHashCode(const PackageWorkerType type, std::map<std::string, std::string> &pkgHashMap);
    std::string GetProcessedPkgHashCode(const PackageWorkerType type, const std::string &pkgName);

private:
    void Stop() noexcept;
    void ClearWorkerManager();

    uint32_t deviceId_;
    uint32_t vfId_;
    bool isDestroy_;
    std::mutex workersMutex_;
    std::array<std::shared_ptr<BasePackageWorker>, (static_cast<size_t>(PackageWorkerType::PACKAGE_WORKER_MAX)+1UL)> workers_;
    static std::mutex workerManagerMutex_;
    static std::map<std::pair<uint32_t, uint32_t>, std::shared_ptr<PackageWorker>> workerManager_;
};
} // namespace tsd
#endif // TSD_PACKAGE_WORKER_H