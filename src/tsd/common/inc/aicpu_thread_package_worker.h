/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_AICPU_THREAD_PACKAGE_WORKER_H
#define TSD_AICPU_THREAD_PACKAGE_WORKER_H

#include "inc/base_package_worker.h"


namespace tsd {
const std::string VERIFY_FILE_NAME = "aicpu_package_install.info";
const std::string EXTEND_VERIFY_FILE_NAME = "extend_aicpu_package_install.info";

class AicpuThreadPackageWorker : public BasePackageWorker {
public:
    explicit AicpuThreadPackageWorker(const PackageWorkerParas paras) : BasePackageWorker(paras), verifyFileName_(""),
                                                                        verifyFilePath_(""), soInstallRootPath_(""),
                                                                        fd_(-1)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
        verifyFileName_ = VERIFY_FILE_NAME;
    };
    virtual ~AicpuThreadPackageWorker() override = default;

    TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) override;
    TSD_StatusT UnloadPackage() override;

private:
    void PreProcessPackage(const std::string &packagePath, const std::string &packageName) override;
    void SetDecompressPackagePath() override;
    TSD_StatusT OpenVerifyFile();
    bool IsNeedLoadPackage() override;
    TSD_StatusT GetSavedCheckCodeShared(uint64_t &savedCheckCode) const;
    TSD_StatusT GetSavedCheckCodeUnshared(uint64_t &savedCheckCode) const;
    TSD_StatusT ReadCheckCode(uint64_t &savedCheckCode) const;
    std::string GetMovePackageToDecompressDirCmd() const override;
    std::string GetDecompressPackageCmd() const override;
    TSD_StatusT PostProcessPackage() override;
    TSD_StatusT ResetExtendVerifyFile() const;

protected:
    TSD_StatusT WriteCheckCode(const int32_t fd, const uint64_t checkCode) const;

    std::string verifyFileName_;
    std::string verifyFilePath_;
    std::string soInstallRootPath_;
    int32_t fd_;
};

class ExtendThreadPackageWorker final : public AicpuThreadPackageWorker {
public:
    explicit ExtendThreadPackageWorker(const PackageWorkerParas paras) : AicpuThreadPackageWorker(paras)
    {
        TSD_RUN_INFO("Start init %s. %s", __func__, paras.DebugString().c_str());
        verifyFileName_ = EXTEND_VERIFY_FILE_NAME;
    };
    ~ExtendThreadPackageWorker() override = default;

private:
    TSD_StatusT PostProcessPackage() override;
};
} // namespace tsd

#endif // TSD_AICPU_THREAD_PACKAGE_WORKER_H