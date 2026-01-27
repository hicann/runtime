/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/base_package_worker.h"

#include <unistd.h>
#include <sstream>
#include "inc/log.h"
#include "inc/tsd_util.h"
#include "inc/internal_api.h"
#include "inc/package_worker_utils.h"


namespace tsd {
uint64_t BasePackageWorker::GetPackageCheckCode()
{
    const std::lock_guard<std::mutex> lk(packageMtx_);
    return checkCode_;
}

void BasePackageWorker::PreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    // The preprocess such as set the origin and decom path for package, calc the package size, must done in this func
    DefaultPreProcessPackage(packagePath, packageName);

    return;
}

void BasePackageWorker::DefaultPreProcessPackage(const std::string &packagePath, const std::string &packageName)
{
    // set the package path
    SetOriginPackagePath(packagePath, packageName);
    SetDecompressPackagePath();

    // calc and set the package original size
    const uint64_t packageSize = PackageWorkerUtils::GetFileSize(originPackagePath_.realPath);
    if (packageSize == 0UL) {
        TSD_RUN_WARN("Origin package size is 0, path=%s", originPackagePath_.realPath.c_str());
    }
    SetOriginPackageSize(packageSize);

    return;
}

bool BasePackageWorker::IsNeedLoadPackage()
{
    const size_t fileSize = GetOriginPackageSize();
    if (fileSize == GetCheckCode()) {
        TSD_RUN_INFO("No need load package, packageSize=%lu, checkCode=%lu", fileSize, GetCheckCode());
        return false;
    }

    return true;
}

TSD_StatusT BasePackageWorker::MoveOriginPackageToDecompressDir() const
{
    if (decomPackagePath_.path.empty()) {
        TSD_ERROR("Decompress path is empty");
        return TSD_INTERNAL_ERROR;
    }

    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory(decomPackagePath_.path);
    if (ret != TSD_OK) {
        TSD_ERROR("Make decompress dir failed, dir=%s", decomPackagePath_.path.c_str());
        return TSD_INTERNAL_ERROR;
    }

    const std::string cmd = GetMovePackageToDecompressDirCmd();
    const int32_t cmdRet = PackSystem(cmd.c_str());
    if (cmdRet != 0) {
        TSD_RUN_WARN("Move origin package to decompress path not success, ret=%d, cmd=%s, reason=%s",
                     cmdRet, cmd.c_str(), strerror(errno));
    }
    TSD_INFO("Move origin package to decompress path end, ret=%d, cmd=%s", cmdRet, cmd.c_str());

    return TSD_OK;
}

TSD_StatusT BasePackageWorker::DecompressPackage() const
{
    const std::string cmd = GetDecompressPackageCmd();
    TSD_INFO("Start decompress package, cmd=%s", cmd.c_str());
    const int32_t ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_RUN_WARN("Decompress package failed, ret=%d, cmd=%s, reason=%s", ret, cmd.c_str(), strerror(errno));
    }

    TSD_INFO("End decompress package, ret=%d, cmd=%s", ret, cmd.c_str());

    return TSD_OK;
}

TSD_StatusT BasePackageWorker::PostProcessPackage()
{
    SetDecompressTimeToNow();
    SetCheckCode(GetOriginPackageSize());

    return TSD_OK;
}

void BasePackageWorker::Clear()
{
    DefaultClear();

    return;
}

void BasePackageWorker::DefaultClear()
{
    originPackagePath_.Clear();
    decomPackagePath_.Clear();
    SetCheckCode(0UL);
    SetOriginPackageSize(0UL);

    return;
}

bool BasePackageWorker::IsNeedUnloadPackage()
{
    if (GetCheckCode() == 0UL) {
        return false;
    }

    return true;
}

} // namespace tsd
