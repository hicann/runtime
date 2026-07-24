/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_HASH_STORE_H
#define TSD_PACKAGE_HASH_STORE_H

#include "hdc_message_builder.h"
#include "proto/tsd_message.pb.h"

#include <map>
#include <string>

namespace tsd {

class PackageHashStore {
public:
    PackageHashStore() = default;
    ~PackageHashStore() = default;

    void SetDeviceCommonSinkPackHashValue(const std::string& pkgName, const std::string& hashValue);
    std::string GetDeviceCommonSinkPackHashValue(const std::string& pkgName) const;
    void SetHostCommonSinkPackHashValue(const std::string& pkgName, const std::string& hashValue);
    std::string GetHostCommonSinkPackHashValue(const std::string& pkgName) const;
    bool IsCommonSinkHostAndDevicePkgSame(const std::string& pkgName) const;
    void StoreAllPkgHashValue(const HDCMessage& msg);
    void Clear();

    std::map<std::string, std::string> pkgHostHashValue_;
    std::map<std::string, std::string> pkgDeviceHashValue_;
};

} // namespace tsd

#endif // TSD_PACKAGE_HASH_STORE_H
