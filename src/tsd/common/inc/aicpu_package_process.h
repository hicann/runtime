/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_AICPU_PACKAGE_PROCESS_H
#define TSD_AICPU_PACKAGE_PROCESS_H

#include <string>
#include <functional>
#include "tsd/status.h"


namespace tsd {
class AicpuPackageProcess {
public:
    static TSD_StatusT CheckPackageName(const std::string &soInstallPath, const std::string &packageName);
    static TSD_StatusT MoveSoToSandBox(const std::string &soInstallPath);
    static bool IsSoExist(const uint32_t uniqueVfId);
    static TSD_StatusT CopyExtendSoToCommonSoPath(const std::string &soInstallRootPath, const bool isAsan);

private:
    AicpuPackageProcess() = default;
    ~AicpuPackageProcess() = default;

    AicpuPackageProcess(AicpuPackageProcess const&) = delete;
    AicpuPackageProcess& operator=(AicpuPackageProcess const&) = delete;
    AicpuPackageProcess(AicpuPackageProcess&&) = delete;
    AicpuPackageProcess& operator=(AicpuPackageProcess&&) = delete;

    using VersionLineHandler = std::function<bool (const std::string &)>;
    static TSD_StatusT GetSrcPackageName(const std::string &packageName, std::string &srcPkgName);
    static TSD_StatusT GetInnerPkgName(const std::string &versionFilePath, std::string &innerPkgName);
    static TSD_StatusT WalkInVersionFile(const std::string &soInstallPath, const VersionLineHandler &handler);
    static TSD_StatusT GetSandBoxSoListInVersionFile(const std::string &versionFilePath, std::string &soList);
};
} // namespace tsd

#endif // TSD_AICPU_PACKAGE_PROCESS_H