/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "file_utils.h"
#include "mmpa/mmpa_api.h"
#include "common/log_inner.h"


namespace acl {
namespace file_utils {
aclError GetSoRealPath(std::string &path)
{
    mmDlInfo dlInfo;
    if ((mmDladdr(reinterpret_cast<void *>(&GetSoRealPath), &dlInfo) != EN_OK) || (dlInfo.dli_fname == nullptr)) {
        ACL_LOG_WARN("Failed to get shared library path! errmsg:%s", mmDlerror());
        return ACL_ERROR_INTERNAL_ERROR;
    }

    if (strlen(dlInfo.dli_fname) >= MMPA_MAX_PATH) {
        ACL_LOG_WARN("The shared library path is too long!");
        return ACL_ERROR_INTERNAL_ERROR;
    }

    char_t realPath[MMPA_MAX_PATH] = {};
    if (mmRealPath(dlInfo.dli_fname, &realPath[0], MMPA_MAX_PATH) != EN_OK) {
        constexpr size_t maxErrorStrLen = 128U;
        char_t errBuf[maxErrorStrLen + 1U] = {};
        const auto errMsg = mmGetErrorFormatMessage(mmGetErrorCode(), &errBuf[0], maxErrorStrLen);
        ACL_LOG_WARN("Failed to get realpath of %s, errmsg:%s", dlInfo.dli_fname, errMsg);
        return ACL_ERROR_INTERNAL_ERROR;
    }

    path = realPath;
    path = path.substr(0U, path.rfind('/') + 1U);
    return ACL_SUCCESS;
}

std::string GetLocalRealPath(const std::string &path)
{
    if (path.empty()) {
        return "";
    }

    char resolvedPath[PATH_MAX] = {0};
    
    if (realpath(path.c_str(), resolvedPath) == nullptr) {
        ACL_LOG_WARN("Failed to get real path for [%s], errno:%d", path.c_str(), errno);
        return "";
    }
    
    return std::string(resolvedPath);
}
} // namespace file_utils
} // namespace acl

