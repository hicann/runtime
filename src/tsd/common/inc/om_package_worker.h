/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_OM_PACKAGE_WORKER_H
#define TSD_OM_PACKAGE_WORKER_H

#include "base_package_worker.h"


namespace tsd {
class OmPackageWorker final : public BasePackageWorker {
public:
    explicit OmPackageWorker(const PackageWorkerParas paras) : BasePackageWorker(paras)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    };
    ~OmPackageWorker() final = default;

    TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) final;
    TSD_StatusT UnloadPackage() final;
    bool GetOmFileStatus(const uint32_t hostPid, const std::string &hostFileName, const uint32_t deviceId);

private:
    void PreProcessPackage(const std::string &packagePath, const std::string &packageName) override;
    TSD_StatusT GetHostPidFromPackageName(const std::string &packageName);
    void SetDecompressPackagePath() override;
    bool IsNeedLoadPackage() override;
    std::string GetMovePackageToDecompressDirCmd() const override;
    std::string GetDecompressPackageCmd() const override;
    TSD_StatusT PostProcessPackage() override;
    TSD_StatusT FindAndDecompressOmInnerPkg() const;
    TSD_StatusT ChangeOmFileRights() const;
    void ChangeSingleOmFileRights(const std::string &filePath) const;
    TSD_StatusT WritePackageNameToFile() const;
    void Clear() final;
    TSD_StatusT CheckAndClearLinkFile() const;
    uint32_t ExtractDualDieDeviceId(const std::string &filePath) const;

    std::string hostPid_ = "";
    uint32_t dualDieDeviceId_ = 0U;
};
} // namespace tsd
 
#endif // TSD_OM_PACKAGE_WORKER_H