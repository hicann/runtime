/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/package_worker.h"
#include "inc/tsd_path_mgr.h"


namespace tsd {
std::map<std::pair<uint32_t, uint32_t>, std::shared_ptr<PackageWorker>> PackageWorker::workerManager_ = {};
std::mutex PackageWorker::workerManagerMutex_;

std::shared_ptr<PackageWorker> PackageWorker::GetInstance(const uint32_t devId, const uint32_t vfId)
{
    // All device use unique obj in physical scenarios
    uint32_t deviceKey = (vfId == 0U) ? 0U : devId;
    if (IsVfModeCheckedByDeviceId(devId)) {
        deviceKey = devId;
    }
    std::pair<uint32_t, uint32_t> key = std::make_pair(deviceKey, vfId);

    std::shared_ptr<PackageWorker> inst = nullptr;
    {
        const std::lock_guard<std::mutex> lk(PackageWorker::workerManagerMutex_);
        const auto iter = workerManager_.find(key);
        if (iter != workerManager_.end()) {
            inst = iter->second;
            return inst;
        }

        inst = std::make_shared<PackageWorker>(deviceKey, vfId);
        if (inst == nullptr) {
            TSD_ERROR("Failed to create new package worker manager, deviceId=%u, vfId=%u", devId, vfId);
        }
        (void)workerManager_.insert(std::make_pair(key, inst));
    }

    return inst;
}

TSD_StatusT PackageWorker::LoadPackage(const PackageWorkerType type, const std::string &path,
                                       const std::string &fileName)
{
    const std::shared_ptr<BasePackageWorker> packageWorker = GetPackageWorker(type);
    if (packageWorker == nullptr) {
        TSD_ERROR("Get package worker inst failed by nullptr, type=%u, path=%s, fileName=%s",
                  static_cast<uint32_t>(type), path.c_str(), fileName.c_str());
        return TSD_INSTANCE_NOT_FOUND;
    }

    const TSD_StatusT ret = packageWorker->LoadPackage(path, fileName);
    if (ret != TSD_OK) {
        TSD_ERROR("Load package failed, ret=%u, type=%u, path=%s, fileName=%s",
                  ret, static_cast<uint32_t>(type), path.c_str(), fileName.c_str());
    }

    return ret;
}

TSD_StatusT PackageWorker::UnloadPackage(const PackageWorkerType type)
{
    const std::shared_ptr<BasePackageWorker> packageWorker = GetPackageWorker(type);
    if (packageWorker == nullptr) {
        TSD_ERROR("Get package worker inst failed by nullptr, type=%u", static_cast<uint32_t>(type));
        return TSD_INSTANCE_NOT_FOUND;
    }

    const TSD_StatusT ret = packageWorker->UnloadPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Unload package failed, ret=%u, type=%u", ret, static_cast<uint32_t>(type));
    }

    return ret;
}

uint64_t PackageWorker::GetPackageCheckCode(const PackageWorkerType type)
{
    const std::shared_ptr<BasePackageWorker> packageWorker = GetPackageWorker(type);
    if (packageWorker == nullptr) {
        TSD_ERROR("Get package worker inst failed by nullptr, type=%u", static_cast<uint32_t>(type));
        return 0UL;
    }

    return packageWorker->GetPackageCheckCode();
}

void PackageWorker::ClearPackageCheckCode(const PackageWorkerType type)
{
    const std::shared_ptr<BasePackageWorker> packageWorker = GetPackageWorker(type);
    if (packageWorker == nullptr) {
        TSD_ERROR("Get package worker inst failed by nullptr, type=%u", static_cast<uint32_t>(type));
        return;
    }

    packageWorker->ClearPackageCheckCode();
}

std::shared_ptr<BasePackageWorker> PackageWorker::GetPackageWorker(const PackageWorkerType type)
{
    std::lock_guard<std::mutex> lk(workersMutex_);
    const std::shared_ptr<BasePackageWorker> worker = workers_[static_cast<size_t>(type)];
    if (worker != nullptr) {
        return worker;
    }

    if (isDestroy_) {
        return nullptr;
    }

    const PackageWorkerParas paras(deviceId_, vfId_);
    const auto newWorker = PackageWorkerFactory::GetInstance().CreatePackageWorker(type, paras);
    if (newWorker == nullptr) {
        TSD_ERROR("Create worker failed, type=%u", static_cast<uint32_t>(type));
        return nullptr;
    }

    workers_[static_cast<size_t>(type)] = newWorker;

    TSD_INFO("Get and create package worker success, type=%u", static_cast<uint32_t>(type));
    return newWorker;
}

void PackageWorker::DestroyPackageWorker()
{
    Stop();
    ClearWorkerManager();
}

void PackageWorker::Stop() noexcept
{
    isDestroy_ = true;
}

void PackageWorker::ClearWorkerManager()
{
    const std::lock_guard<std::mutex> lk(PackageWorker::workerManagerMutex_);
    const auto iter = PackageWorker::workerManager_.find(std::make_pair(deviceId_, vfId_));
    if (iter == workerManager_.end()) {
        TSD_WARN("Delete package worker manager but not exist, deviceId=%u, vfId=%u", deviceId_, vfId_);
        return;
    }

    (void)workerManager_.erase(iter);
}

void PackageWorker::SetAsanMode(const bool isAsan)
{
    std::lock_guard<std::mutex> lk(workersMutex_);
    for (const auto &worker : workers_) {
        if (worker != nullptr) {
            worker->SetAsanMode(isAsan);
        }
    }
}
} // namespace tsd
