/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/tsd_path_mgr.h"
#include "tsd_util_func.h"
namespace tsd {
namespace {
const std::string AICPU_PACKAGE_DECOMPRESSION_PATH = "/usr/lib64/aicpu_kernels/";
// aicpu kernels so inner dir name
constexpr const char_t *AICPU_KERNELS_SO_INNER_DIR_NAME = "aicpu_kernels_device/";
constexpr const char_t *AICPU_EXTEND_KERNELS_SO_INNER_DIR_NAME = "aicpu_extend_syskernels/";
// version.info file name
constexpr const char_t *VERSION_INFO_FILE_NAME = "version.info";
constexpr const char_t *HOME_SO_PATH_FOR_THREADMODE = "aicpu_kernels/";
const std::string HELPER_AICPU_OPKERNEL_PATH_HEAD = "/home/HwHiAiUser/inuse/";
const std::string AICPU_OPKERNEL_PATH_HEAD = "/home/HwHiAiUser/aicpu_kernels/";
const std::string AICPU_EXTEND_HASH_CFG_FILE = "aicpuExtend_bin_hash.cfg";
}  // namespace

// /usr/lib64/aicpu_kernels/2/
std::string TsdPathMgr::BuildKernelSoRootPath(const uint32_t uniqueVfId, const std::string &destPath)
{
    if (!destPath.empty()) {
        std::string path = destPath;
        return path.append(std::string(HOME_SO_PATH_FOR_THREADMODE)).append(std::to_string(uniqueVfId)).append("/");
    }

    if (IsHeterogeneousProduct()) {
        std::string curPath = HELPER_AICPU_OPKERNEL_PATH_HEAD;
        return curPath.append(std::string(HOME_SO_PATH_FOR_THREADMODE)).append(std::to_string(uniqueVfId)).append("/");
    } else {
        return std::string(AICPU_PACKAGE_DECOMPRESSION_PATH).append(std::to_string(uniqueVfId)).append("/");
    }
}

// /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/
std::string TsdPathMgr::BuildKernelSoPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::BuildKernelSoRootPath(uniqueVfId).append(AICPU_KERNELS_SO_INNER_DIR_NAME);
}

std::string TsdPathMgr::BuildKernelSoPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_KERNELS_SO_INNER_DIR_NAME);
}

std::string TsdPathMgr::BuildExtendKernelSoPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_EXTEND_KERNELS_SO_INNER_DIR_NAME);
}

std::string TsdPathMgr::BuildExtendKernelHashCfgPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_KERNELS_SO_INNER_DIR_NAME).append(AICPU_EXTEND_HASH_CFG_FILE);
}

// /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/version.info
std::string TsdPathMgr::AddVersionInfoName(const std::string &kernelSoPath)
{
    return std::string(kernelSoPath).append(VERSION_INFO_FILE_NAME);
}
}  // namespace tsd