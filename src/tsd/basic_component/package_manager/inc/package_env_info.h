/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_ENV_INFO_H
#define TSD_PACKAGE_ENV_INFO_H

#include "plugin_pkg_version.h"
#include "hdc_message_builder.h"
#include "driver/ascend_hal.h"
#include "proto/tsd_message.pb.h"
#include "basic_define.h"

#include <string>
#include <vector>

namespace tsd {

class PackageEnvInfo {
public:
    PackageEnvInfo(uint32_t logicDeviceId, uint32_t platInfoMode, bool isAdcEnv, uint32_t chipType);
    ~PackageEnvInfo() = default;

    // 平台信息
    uint32_t GetPlatInfoMode() const { return platInfoMode_; }
    void SetPlatInfoMode(uint32_t mode) { platInfoMode_ = mode; }
    bool IsAdcEnv() const { return isAdcEnv_; }
    uint32_t GetPlatInfoChipType() const { return chipType_; }
    void SetPlatInfoChipType(uint32_t chipType) { chipType_ = chipType; }
    uint32_t GetLogicDeviceId() const { return logicDeviceId_; }

    // 包扫描
    bool CheckPackageExists(const bool loadAicpuKernelFlag = true);
    bool GetPackageTitle(std::string& packageTitle) const;
    static bool ResolvePackageTitle(uint32_t chipType, uint32_t platInfoMode, std::string& packageTitle);
    const std::string& GetPackageName(uint32_t type) const { return packageName_[type]; }
    const std::string& GetPackagePath(uint32_t type) const { return packagePath_[type]; }

    // 路径解析
    void GetAscendLatestIntallPath(std::string& pkgBasePath) const;
    bool GetShortSocVersion(std::string& shortSocVersion) const;
    std::string GetCurHostMutexFile(bool useCannPath) const;
    std::string GetTrustedBasePath(bool useV2) const;
    TSD_StatusT GetTrustedBasePathFromDevice(int32_t& peerNode, std::string& dstDirPreFix) const;

    // 状态（public 供 Facade 引用别名访问）
    uint32_t platInfoMode_;
    bool isAdcEnv_;
    uint32_t chipType_;
    std::string hostSoPath_;
    std::string packageName_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    std::string packagePath_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];
    std::string packagePattern_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)];

    bool CheckPackageExistsOnce(const uint32_t packageType);
    bool GetPackagePath(std::string& packagePath, const uint32_t packageType) const;
    std::vector<std::string> ScanAndMatchPackages(const std::string& pkgPath, const uint32_t packageType) const;

private:
    uint32_t logicDeviceId_;
};

} // namespace tsd

#endif // TSD_PACKAGE_ENV_INFO_H
