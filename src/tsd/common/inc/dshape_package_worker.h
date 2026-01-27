/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_DSHAPE_PACKAGE_WORKER_H
#define TSD_DSHAPE_PACKAGE_WORKER_H

#include "base_package_worker.h"


namespace tsd {
class DshapePackageWorker final : public BasePackageWorker {
public:
    explicit DshapePackageWorker(const PackageWorkerParas paras) : BasePackageWorker(paras)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    };
    ~DshapePackageWorker() override = default;

    TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) override;
    TSD_StatusT UnloadPackage() override;

private:
    bool IsNeedLoadPackage() override;
    void SetDecompressPackagePath() override;
    std::string GetMovePackageToDecompressDirCmd() const override;
    std::string GetDecompressPackageCmd() const override;
    bool IsNeedUnloadPackage() override;
};
} // namespace tsd
 
#endif // TSD_DSHAPE_PACKAGE_WORKER_H