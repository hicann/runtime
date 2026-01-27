/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_COMMON_SINK_PACKAGE_WORKER_H
#define TSD_COMMON_SINK_PACKAGE_WORKER_H

#include <unordered_map>
#include "base_package_worker.h"

namespace tsd {

struct SinkPkgPriInfo {
    std::string hashCode;
};

class CommonSinkPackageWorker final : public BasePackageWorker {
public:
    explicit CommonSinkPackageWorker(const PackageWorkerParas paras) : BasePackageWorker(paras),
                                                                       soInstallRootPath_(""),
                                                                       memoryLimitFilePath_(""),
                                                                       memoryUsedFilePath_("")
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    }

    ~CommonSinkPackageWorker() override = default;

    TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) override;
    TSD_StatusT UnloadPackage() override;

private:
    void PreProcessPackage(const std::string &packagePath, const std::string &packageName) override;
    bool IsNeedLoadPackage() override;
    void SetDecompressPackagePath() override;
    std::string GetMovePackageToDecompressDirCmd() const override;
    std::string GetDecompressPackageCmd() const override;
    TSD_StatusT DecompressPackage() const override;
    TSD_StatusT PostProcessPackage() override;
    std::string GetSoInstallPathByConfig(const uint32_t conPath) const;
    TSD_StatusT StartLoadCommonSinkPackage();
    std::string GetProcessedPkgHashCode(const std::string &pkgName) override;
    void SetCurPkgHashCode(const std::string &pkgName, const std::string &hashCode);
    bool IsNeedLoadPackageByName(const std::string &fileName);
    std::string CalOriginalPkgHashCode();
    std::string SetAicpuThreadModeInstallPath() const;
    std::string GetCommonSinkTmpStorePath() const;
    std::string GetOriPkgHashCode() const
    {
        return originPackageHashCode_;
    }
    void SetOriPkgHashCode(const std::string &pkgHashCode)
    {
        originPackageHashCode_ = pkgHashCode;
    }
    void SetOriPkgPureName(const std::string &pkgName)
    {
        originPackagePureName_ = pkgName;
    }
    std::string GetOriPkgPureName() const
    {
        return originPackagePureName_;
    }
    void GetAllPackageHashCode(std::map<std::string, std::string> &pkgHashMap) override;
    TSD_StatusT LoadTsFw(const bool reset = false) const;
protected:
    std::string soInstallRootPath_;
    std::string memoryLimitFilePath_;
    std::string memoryUsedFilePath_;
    std::string originPackageHashCode_;
    std::string originPackagePureName_;
    std::mutex priInfoMtx_;
    std::unordered_map<std::string, SinkPkgPriInfo> pkgPrivInfo_;
};
} // namespace tsd
 
#endif // TSD_COMMON_SINK_PACKAGE_WORKER_H