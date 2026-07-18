/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_ADUMP_PLATFORM_MANAGER_H
#define ADUMP_COMMON_ADUMP_PLATFORM_MANAGER_H

#include <memory>
#include <mutex>
#include "adump_dsmi.h"
#include "adump_platform_registry.h"
#include "features_support_interface.h"
#include "coredump_interface.h"
#include "exception_dump_interface.h"
#include "data_dump_interface.h"
#include "log/adx_log.h"

namespace Adx {

// 各平台接口域共用的懒加载单例管理器基类：加锁缓存成功实例；创建失败不固化，
// 后续 Get() 可重试；Reset() 供 UT 清理缓存以重新 mock 平台类型。
// 每个域用一个空派生类特化出独立的静态存储（见下方 4 个 Manager）。
template<typename Iface, typename Derived>
class AdumpPlatformManagerBase {
public:
    static Iface* Get()
    {
        std::lock_guard<std::mutex> lock(mtx_);
        if (instance_ != nullptr) {
            return instance_.get();
        }
        instance_ = CreateOnce();
        return instance_.get();
    }

    static void Reset()
    {
        std::lock_guard<std::mutex> lock(mtx_);
        instance_.reset();
    }

private:
    static std::shared_ptr<Iface> CreateOnce()
    {
        uint32_t type = 0;
        if (!AdumpDsmi::DrvGetPlatformType(type)) {
            IDE_LOGE("[AdumpPlatform] Failed to get platform type.");
            return nullptr;
        }
        auto plat = PlatformReflection<Iface>::CreatePlatform(static_cast<PlatformType>(type));
        if (plat == nullptr) {
            IDE_LOGW("[AdumpPlatform] Platform type %u not registered for this capability.", type);
        }
        return plat;
    }

    static std::shared_ptr<Iface> instance_;
    static std::mutex mtx_;
};

template<typename Iface, typename Derived>
std::shared_ptr<Iface> AdumpPlatformManagerBase<Iface, Derived>::instance_;
template<typename Iface, typename Derived>
std::mutex AdumpPlatformManagerBase<Iface, Derived>::mtx_;

class FeaturesSupportManager
    : public AdumpPlatformManagerBase<FeaturesSupportInterface, FeaturesSupportManager> {};

class CoredumpManager
    : public AdumpPlatformManagerBase<CoredumpInterface, CoredumpManager> {};

class ExceptionDumpManager
    : public AdumpPlatformManagerBase<ExceptionDumpInterface, ExceptionDumpManager> {};

class DataDumpManager
    : public AdumpPlatformManagerBase<DataDumpInterface, DataDumpManager> {};

// 聚合重置，供 UT fixture 在 SetUp/TearDown 中一次清空全部域缓存。
inline void ResetAllPlatformManagers()
{
    FeaturesSupportManager::Reset();
    CoredumpManager::Reset();
    ExceptionDumpManager::Reset();
    DataDumpManager::Reset();
}

} // namespace Adx
#endif // ADUMP_COMMON_ADUMP_PLATFORM_MANAGER_H
