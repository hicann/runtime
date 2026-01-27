/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_AICPU_PROCESS_PACKAGE_WORKER_H
#define TSD_AICPU_PROCESS_PACKAGE_WORKER_H

#include <atomic>
#include <condition_variable>
#include "inc/base_package_worker.h"


namespace tsd {
class AicpuProcessPackageWorker : public BasePackageWorker {
public:
    explicit AicpuProcessPackageWorker(const PackageWorkerParas paras) : BasePackageWorker(paras),
                                                                         soInstallRootPath_(""),
                                                                         memoryLimitFilePath_(""),
                                                                         memoryUsedFilePath_(""),
                                                                         isVerifyOppFail_(false),
                                                                         isStop_(false)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    };
    virtual ~AicpuProcessPackageWorker() override = default;

    TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) override;
    TSD_StatusT UnloadPackage() override;

    uint64_t GetPackageCheckCode() override;
    TSD_StatusT CheckSum(const uint64_t curCode);
    void RecordFinish();
    inline void SetStop()
    {
        isStop_ = true;
        return;
    }

private:
    void PreProcessPackage(const std::string &packagePath, const std::string &packageName) override;
    void SetDecompressPackagePath() override;
    std::string GetMovePackageToDecompressDirCmd() const override;
    TSD_StatusT DecompressPackage() const override;
    std::string GetDecompressPackageCmd() const override;
    TSD_StatusT PostProcessPackage() override;
    void RemoveRedundantSoFile() const;

protected:
    std::string soInstallRootPath_;
    std::string memoryLimitFilePath_;
    std::string memoryUsedFilePath_;
    bool isVerifyOppFail_;
    std::condition_variable isFinish_;
    std::atomic<bool> isStop_;
};

class ExtendProcessPackageWorker final : public AicpuProcessPackageWorker {
public:
    explicit ExtendProcessPackageWorker(const PackageWorkerParas paras) : AicpuProcessPackageWorker(paras)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    };
    ~ExtendProcessPackageWorker() override = default;
private:
    TSD_StatusT PostProcessPackage() override;
};

class AscendcppProcessPackageWorker final : public AicpuProcessPackageWorker {
public:
    explicit AscendcppProcessPackageWorker(const PackageWorkerParas paras) : AicpuProcessPackageWorker(paras)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
    };
    ~AscendcppProcessPackageWorker() override = default;
private:
    TSD_StatusT PostProcessPackage() override;
    TSD_StatusT CopyAscendcppSoToCommonSoPath(const std::string &soInstallRootPath, const bool isAsan) const;
};
} // namespace tsd

#endif // TSD_AICPU_PROCESS_PACKAGE_WORKER_H