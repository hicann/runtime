/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/package_worker_utils.h"

#include <sys/stat.h>
#include <fstream>
#include <sstream>
#include "mmpa/mmpa_api.h" 
#include "log.h"
#include "tsd_util_func.h"
#include "inc/package_verify.h"
#include "inc/tsd_path_mgr.h"

namespace tsd {
TSD_StatusT PackageWorkerUtils::VerifyPackage(const std::string &pkgPath)
{
    const PackageVerify pkgVerify(pkgPath);
    const TSD_StatusT ret = pkgVerify.VerifyPackage();
    if (ret != TSD_OK) {
        TSD_ERROR("Verify package failed, ret=%u, path=%s", ret, pkgPath.c_str());
        return TSD_VERIFY_OPP_FAIL;
    }

    return TSD_OK;
}

TSD_StatusT PackageWorkerUtils::MakeDirectory(const std::string &dirPath)
{
    if (dirPath.empty()) {
        TSD_ERROR("Dir path is empty");
        return TSD_INTERNAL_ERROR;
    }

    int32_t ret = access(dirPath.c_str(), F_OK);
    if (ret == 0) {
        ret = mmIsDir(dirPath.c_str());
        if (ret != EN_OK) {
            TSD_ERROR("File exist but not is a dir, ret=%d, path=%s, reason=%s",
                      ret, dirPath.c_str(), SafeStrerror().c_str());
            return TSD_INTERNAL_ERROR;
        }
        return TSD_OK;
    }

    ret = mkdir(dirPath.c_str(), (S_IRWXU|S_IRGRP|S_IXGRP));
    if (ret != 0) {
        TSD_ERROR("Create dir failed, ret=%d, path=%s, reason=%s",
                  ret, dirPath.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    // chmod is necessary, because mkdir can not really change mode in rc
    ret = chmod(dirPath.c_str(), (S_IRWXU|S_IRGRP|S_IXGRP));
    if (ret != 0) {
        TSD_ERROR("Change dir mode failed, ret=%d, path=%s, reason=%s",
                  ret, dirPath.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

void PackageWorkerUtils::RemoveFile(const std::string &filePath)
{
    RemoveOneFile(filePath);
}

uint64_t PackageWorkerUtils::GetFileSize(const std::string &filePath)
{
    return CalFileSize(filePath.c_str());
}

} // namespace tsd