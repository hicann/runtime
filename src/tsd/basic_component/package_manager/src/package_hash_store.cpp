/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_hash_store.h"
#include "tsd_log.h"

namespace tsd {

void PackageHashStore::SetDeviceCommonSinkPackHashValue(const std::string& pkgName, const std::string& hashValue)
{
    pkgDeviceHashValue_[pkgName] = hashValue;
    TSD_INFO("update device package:%s hash value:%s", pkgName.c_str(), hashValue.c_str());
}

std::string PackageHashStore::GetDeviceCommonSinkPackHashValue(const std::string& pkgName) const
{
    auto iter = pkgDeviceHashValue_.find(pkgName);
    if (iter != pkgDeviceHashValue_.end()) {
        TSD_INFO("get device package:%s, hash value:%s", pkgName.c_str(), iter->second.c_str());
        return iter->second;
    }
    return "";
}

void PackageHashStore::SetHostCommonSinkPackHashValue(const std::string& pkgName, const std::string& hashValue)
{
    pkgHostHashValue_[pkgName] = hashValue;
    TSD_INFO("update host package:%s hash value:%s", pkgName.c_str(), hashValue.c_str());
}

std::string PackageHashStore::GetHostCommonSinkPackHashValue(const std::string& pkgName) const
{
    auto iter = pkgHostHashValue_.find(pkgName);
    if (iter != pkgHostHashValue_.end()) {
        TSD_INFO("get host package:%s, hash value:%s", pkgName.c_str(), iter->second.c_str());
        return iter->second;
    }
    return "";
}

bool PackageHashStore::IsCommonSinkHostAndDevicePkgSame(const std::string& pkgName) const
{
    return (
        (GetHostCommonSinkPackHashValue(pkgName) == GetDeviceCommonSinkPackHashValue(pkgName)) &&
        (!GetHostCommonSinkPackHashValue(pkgName).empty()));
}

void PackageHashStore::StoreAllPkgHashValue(const HDCMessage& msg)
{
    if ((msg.type() != HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP) &&
        (msg.type() != HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP)) {
        return;
    }

    for (int32_t j = 0; j < msg.package_hash_code_list_size(); j++) {
        SinkPackageHashCodeInfo tempNode = msg.package_hash_code_list(j);
        SetDeviceCommonSinkPackHashValue(tempNode.package_name(), tempNode.hash_code());
    }
}

void PackageHashStore::Clear()
{
    pkgHostHashValue_.clear();
    pkgDeviceHashValue_.clear();
}

} // namespace tsd
