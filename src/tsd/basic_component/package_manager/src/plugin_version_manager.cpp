/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plugin_version_manager.h"
#include "tsd_log.h"

namespace tsd {

PluginVersionManager::PluginVersionManager(
    PackageEnvInfo& envInfo, PackageHashStore& hashStore, ResponseCode& pkgRspCode)
    : envInfo_(envInfo), hashStore_(hashStore), pkgRspCode_(pkgRspCode)
{}

bool PluginVersionManager::IsCompatPluginPackage(const PackConfDetail& detail) const
{
    return detail.decDstDir == DeviceInstallPath::COMPAT_PLUGIN_PATH;
}

PluginUpdateStrategy PluginVersionManager::GetPluginUpdateStrategy()
{
    if (hasComputedPluginStrategy_) {
        return pluginUpdateStrategy_;
    }

    int64_t flag = 0;
    auto drvRet =
        halGetDeviceInfo(envInfo_.GetLogicDeviceId(), MODULE_TYPE_SYSTEM, INFO_TYPE_SWPLUGIN_UPGRADE_POLICY, &flag);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_RUN_WARN(
            "[TsdClient][deviceId=%u] halGetDeviceInfo(INFO_TYPE_SWPLUGIN_UPGRADE_POLICY) failed, retCode[%d],"
            " fallback to PLUGIN_NOT_FORCE_UPDATE",
            envInfo_.GetLogicDeviceId(), drvRet);
        return PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    }
    if (flag < static_cast<int64_t>(PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE) ||
        flag > static_cast<int64_t>(PluginUpdateStrategy::PLUGIN_NO_UPDATE)) {
        TSD_RUN_WARN(
            "[TsdClient][deviceId=%u] invalid plugin update strategy from DRV: %lld,"
            " fallback to PLUGIN_NOT_FORCE_UPDATE",
            envInfo_.GetLogicDeviceId(), flag);
        return PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    }
    pluginUpdateStrategy_ = static_cast<PluginUpdateStrategy>(flag);
    hasComputedPluginStrategy_ = true;
    TSD_RUN_INFO("[TsdClient][deviceId=%u] plugin update strategy from DRV = %lld", envInfo_.GetLogicDeviceId(), flag);
    return pluginUpdateStrategy_;
}

bool PluginVersionManager::ShouldLoadCompatPluginPkg(const std::string& pkgPureName)
{
    const PluginUpdateStrategy strategy = GetPluginUpdateStrategy();
    if (strategy == PluginUpdateStrategy::PLUGIN_NO_UPDATE) {
        TSD_RUN_INFO("plugin update strategy is PLUGIN_NO_UPDATE, skip pkg:%s", pkgPureName.c_str());
        return false;
    }
    if (strategy == PluginUpdateStrategy::PLUGIN_FORCE_UPDATE) {
        TSD_RUN_INFO(
            "plugin update strategy is PLUGIN_FORCE_UPDATE, fallback to checkcode compare pkg:%s", pkgPureName.c_str());
        return !hashStore_.IsCommonSinkHostAndDevicePkgSame(pkgPureName);
    }
    return CompareHostDeviceCompatPluginVersion(pkgPureName);
}

bool PluginVersionManager::CompareHostDeviceCompatPluginVersion(const std::string& pkgPureName)
{
    const PluginPkgVersion hostInfo = PackageProcessConfig::GetInstance()->GetHostPluginVersion(pkgPureName);
    const auto itDev = devicePluginVersions_.find(pkgPureName);
    const PluginPkgVersion deviceInfo = (itDev != devicePluginVersions_.end()) ? itDev->second : PluginPkgVersion{};
    if (deviceInfo.version.empty()) {
        TSD_RUN_INFO("device plugin pkg:%s version unavailable, fallback to checkcode compare", pkgPureName.c_str());
        return !hashStore_.IsCommonSinkHostAndDevicePkgSame(pkgPureName);
    }
    if (hostInfo.Empty()) {
        TSD_RUN_WARN(
            "[TsdClient][deviceId=%u] host plugin pkg:%s version info unavailable, skip", envInfo_.GetLogicDeviceId(),
            pkgPureName.c_str());
        return false;
    }
    const int32_t cmp = PluginPkgVersionUtil::Compare(hostInfo, deviceInfo);
    if (cmp > 0) {
        TSD_RUN_INFO(
            "host plugin pkg:%s newer than device, load. host[%s/%s] device[%s/%s]", pkgPureName.c_str(),
            hostInfo.version.c_str(), hostInfo.timestamp.c_str(), deviceInfo.version.c_str(),
            deviceInfo.timestamp.c_str());
        return true;
    }
    TSD_RUN_INFO(
        "host plugin pkg:%s %s device, skip. host[%s/%s] device[%s/%s]", pkgPureName.c_str(),
        (cmp < 0 ? "older than" : "equals"), hostInfo.version.c_str(), hostInfo.timestamp.c_str(),
        deviceInfo.version.c_str(), deviceInfo.timestamp.c_str());
    return false;
}

void PluginVersionManager::HandleDevicePluginVersionRsp(const HDCMessage& msg)
{
    devicePluginVersions_.clear();
    for (int32_t i = 0; i < msg.device_plugin_versions_size(); ++i) {
        const auto& info = msg.device_plugin_versions(i);
        PluginPkgVersion ver;
        ver.version = info.version();
        ver.timestamp = info.timestamp();
        devicePluginVersions_[info.package_name()] = ver;
        TSD_RUN_INFO(
            "device plugin pkg:%s version:%s timestamp:%s", info.package_name().c_str(), ver.version.c_str(),
            ver.timestamp.c_str());
    }
    pkgRspCode_ = ((msg.tsd_rsp_code() == 0U) ? ResponseCode::SUCCESS : ResponseCode::FAIL);
    TSD_RUN_INFO("device plugin info rsp, pkgCount:%d", msg.device_plugin_versions_size());
}

} // namespace tsd
