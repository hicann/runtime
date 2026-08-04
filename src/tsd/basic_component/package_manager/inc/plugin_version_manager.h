/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PLUGIN_VERSION_MANAGER_H
#define TSD_PLUGIN_VERSION_MANAGER_H

#include "plugin_pkg_version.h"
#include "package_process_config.h"
#include "package_env_info.h"
#include "package_hash_store.h"
#include "package_context.h"
#include "hdc_message_builder.h"
#include "basic_define.h"
#include "proto/tsd_message.pb.h"

#include <map>
#include <string>

namespace tsd {

class PluginVersionManager {
public:
    PluginVersionManager(PackageEnvInfo& envInfo, PackageHashStore& hashStore, PackageContext& ctx);
    ~PluginVersionManager() = default;

    bool IsCompatPluginPackage(const PackConfDetail& detail) const;
    PluginUpdateStrategy GetPluginUpdateStrategy();
    bool ShouldLoadCompatPluginPkg(const std::string& pkgPureName);
    bool CompareHostDeviceCompatPluginVersion(const std::string& pkgPureName);
    void HandleDevicePluginVersionRsp(const HDCMessage& msg);

    std::map<std::string, PluginPkgVersion>& GetDevicePluginVersions() { return devicePluginVersions_; }
    const std::map<std::string, PluginPkgVersion>& GetDevicePluginVersions() const { return devicePluginVersions_; }
    void SetPluginUpdateStrategy(PluginUpdateStrategy s) { pluginUpdateStrategy_ = s; }
    bool HasComputedPluginStrategy() const { return hasComputedPluginStrategy_; }
    void SetHasComputedPluginStrategy(bool v) { hasComputedPluginStrategy_ = v; }

private:
    std::map<std::string, PluginPkgVersion> devicePluginVersions_;
    PluginUpdateStrategy pluginUpdateStrategy_ = PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    bool hasComputedPluginStrategy_ = false;
    PackageEnvInfo& envInfo_;
    PackageHashStore& hashStore_;
    PackageContext& ctx_;
};

} // namespace tsd

#endif // TSD_PLUGIN_VERSION_MANAGER_H
