/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PATH_MGR_H
#define TSD_PATH_MGR_H

#include <string>
#include <cstdint>
// char_t
#include "common/type_def.h"

namespace tsd {
const std::string BASE_HASH_CFG_FILE = "bin_hash.cfg";
class TsdPathMgr {
public:
    // /usr/lib64/aicpu_kernels/2/ || /home/HwHiAiUser/inuse/aicpu_kernels/0/
    static std::string BuildKernelSoRootPath(const uint32_t uniqueVfId, const std::string &destPath = "");

    // /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/
    static std::string BuildKernelSoPath(const uint32_t uniqueVfId);

    static std::string BuildKernelSoPath(const std::string &kernelSoRootPath);

    // /usr/lib64/aicpu_kernels/2/aicpu_extend_syskernels/
    static std::string BuildExtendKernelSoPath(const std::string &kernelSoRootPath);

    static std::string BuildExtendKernelHashCfgPath(const std::string &kernelSoRootPath);

    // /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/version.info
    static std::string AddVersionInfoName(const std::string &kernelSoPath);
};
}  // namespace tsd

#endif  // TSD_PATH_MGR_H