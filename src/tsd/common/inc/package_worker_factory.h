/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_WORKER_FACTORY_H
#define TSD_PACKAGE_WORKER_FACTORY_H

#include <map>
#include <string>
#include <mutex>
#include <memory>
#include <functional>
#include "inc/base_package_worker.h"
#include "inc/basic_define.h"

namespace tsd {
using PackageWorkerCreateFunc = std::function<std::shared_ptr<BasePackageWorker>(const PackageWorkerParas &)>;

class PackageWorkerFactory {
public:
    static PackageWorkerFactory &GetInstance();
    static bool RegisterPackageWorker(const PackageWorkerType type, const PackageWorkerCreateFunc &func);
    std::shared_ptr<BasePackageWorker> CreatePackageWorker(const PackageWorkerType type,
                                                           const PackageWorkerParas paras) const;

private:
    PackageWorkerFactory() : creatorMapMtx_(), creatorMap_() {};
    ~PackageWorkerFactory() = default;

    PackageWorkerFactory(PackageWorkerFactory const&) = delete;
    PackageWorkerFactory& operator=(PackageWorkerFactory const&) = delete;
    PackageWorkerFactory(PackageWorkerFactory&&) = delete;
    PackageWorkerFactory& operator=(PackageWorkerFactory&&) = delete;

    bool RegisterPackageWorkerCreator(const PackageWorkerType type, const PackageWorkerCreateFunc &func);

    std::mutex creatorMapMtx_;
    std::map<PackageWorkerType, PackageWorkerCreateFunc> creatorMap_;
};
} // namespace tsd

#define REGISTER_PACKAGE_WORKER(type, clazz)                                                                      \
namespace {                                                                                                       \
    static bool __attribute__((unused)) g_Creator_##clazz = PackageWorkerFactory::RegisterPackageWorker((type),   \
        [](const PackageWorkerParas paras) -> std::shared_ptr<clazz> { return std::make_shared<clazz>(paras); }); \
}

#endif // TSD_PACKAGE_WORKER_FACTORY_H