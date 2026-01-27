/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_DRIVER_EXTEND_PACKAGE_WORKER_H
#define TSD_DRIVER_EXTEND_PACKAGE_WORKER_H

#include "base_package_worker.h"

namespace tsd {
class DriverExtendPackageWorker final : public BasePackageWorker {
public:
    explicit DriverExtendPackageWorker(const PackageWorkerParas paras) : BasePackageWorker(paras),
                                                                         soInstallRootPath_(""),
                                                                         memoryLimitFilePath_(""),
                                                                         memoryUsedFilePath_("")
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    };
    ~DriverExtendPackageWorker() override = default;

    TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) override;
    TSD_StatusT UnloadPackage() override;
    bool IsBinHashCfgExist(const uint32_t uniqueVfId) const;
    uint64_t GetPackageCheckCode() override;

private:
    void PreProcessPackage(const std::string &packagePath, const std::string &packageName) override;
    bool IsNeedLoadPackage() override;
    void SetDecompressPackagePath() override;
    std::string GetMovePackageToDecompressDirCmd() const override;
    std::string GetDecompressPackageCmd() const override;
    TSD_StatusT DecompressPackage() const override;
    TSD_StatusT PostProcessPackage() override;
    TSD_StatusT ReadAndUpdateDriverVersion() const;
    TSD_StatusT ExecuteScript() const;
    TSD_StatusT BackupTheOldFile() const;
    void ReStoreTheBackupFile() const;
    TSD_StatusT LoadPackageWhenTsdEmpty();
protected:
    std::string soInstallRootPath_;
    std::string memoryLimitFilePath_;
    std::string memoryUsedFilePath_;
};
} // namespace tsd
 
#endif // TSD_DRIVER_EXTEND_PACKAGE_WORKER_H