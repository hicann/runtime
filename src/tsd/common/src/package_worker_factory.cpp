/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/package_worker_factory.h"

#include "inc/log.h"


namespace tsd {
PackageWorkerFactory &PackageWorkerFactory::GetInstance()
{
    static PackageWorkerFactory inst;
    return inst;
}

bool PackageWorkerFactory::RegisterPackageWorker(const PackageWorkerType type, const PackageWorkerCreateFunc &func)
{
    return PackageWorkerFactory::GetInstance().RegisterPackageWorkerCreator(type, func);
}

bool PackageWorkerFactory::RegisterPackageWorkerCreator(const PackageWorkerType type,
                                                        const PackageWorkerCreateFunc &func)
{
    std::lock_guard<std::mutex> lk(creatorMapMtx_);
    auto iter = creatorMap_.find(type);
    if (iter != creatorMap_.end()) {
        TSD_RUN_WARN("Register[%u] package worker already exist", static_cast<uint32_t>(type));
        return true;
    }

    creatorMap_[type] = func;
    TSD_RUN_INFO("Register[%u] package worker was created successfully", static_cast<uint32_t>(type));
    return true;
}

std::shared_ptr<BasePackageWorker> PackageWorkerFactory::CreatePackageWorker(const PackageWorkerType type,
                                                                             const PackageWorkerParas paras) const
{
    const auto iter = creatorMap_.find(type);
    if (iter == creatorMap_.end()) {
        TSD_ERROR("Can not find package worker create func, type=%u", static_cast<uint32_t>(type));
        return nullptr;
    }

    const std::shared_ptr<BasePackageWorker> inst = iter->second(paras);
    if (inst == nullptr) {
        TSD_ERROR("Create package worker failed by nullptr, type=%u", static_cast<uint32_t>(type));
        return nullptr;
    }

    TSD_INFO("Create package worker success, type=%u", static_cast<uint32_t>(type));

    return inst;
}
} // namespace tsd