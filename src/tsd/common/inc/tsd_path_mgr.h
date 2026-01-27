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
    // /home/CustAiCpuUser2/cust_aicpu_1_2_10086/
    static std::string BuildCustomSoVfIdPath(
        const uint32_t deviceId, const uint32_t vfId, const uint32_t uniqueVfId, const uint32_t fmkPid);

    // /home/HwHiAiUser/aicpu_kernels/ || /home/HwHiAiUser/aicpu_kernels/32/
    static std::string BuildAicpuPackageRootPath(const uint32_t uniqueVfId);

    // /usr/lib64/aicpu_kernels/2/ || /home/HwHiAiUser/inuse/aicpu_kernels/0/
    static std::string BuildKernelSoRootPath(const uint32_t uniqueVfId, const std::string &destPath = "");

    // /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/
    static std::string BuildKernelSoPath(const uint32_t uniqueVfId);

    static std::string BuildKernelSoPath(const std::string &kernelSoRootPath);

    static std::string BuildKernelHashCfgPath(const std::string &kernelSoRootPath);

    // /usr/lib64/aicpu_kernels/2/aicpu_extend_syskernels/
    static std::string BuildExtendKernelSoPath(const std::string &kernelSoRootPath);

    static std::string BuildExtendKernelHashCfgPath(const std::string &kernelSoRootPath);

    static std::string BuildAscendcppSoPath(const std::string &kernelSoRootPath);

    static std::string BuildAscendcppKernelHashCfgPath(const std::string &kernelSoRootPath);

    // /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/version.info
    static std::string AddVersionInfoName(const std::string &kernelSoPath);

    static std::string BuildCustAicpuRootPath(const std::string &userId);

    static std::string BuildCustAicpuLibPath(const std::string &userId);

    static std::string BuildCustAicpuLibLockerPath(const std::string &userId);

    // /home/CustAiCpuUser2/
    static std::string BuildCustAiCpuUserPath(const uint32_t uniqueVfId);

    static std::string BuildCustAicpuLibPath(const uint32_t uniqueVfId);

    static std::string BuildCustAicpuLibLockerPath(const uint32_t uniqueVfId);

    // dev0/vf2/
    static std::string BuildVfSubMultiLevelDir(const uint32_t deviceId, const uint32_t vfId);

    // /sys/fs/cgroup/memory/usermemory/dev0/vf2/
    static std::string BuildMemoryConfigRootPath(const uint32_t deviceId, const uint32_t vfId);

    // /sys/fs/cgroup/memory/usermemory/dev0/vf2/memory.usage_in_bytes
    static std::string BuildMemoryConfigUsageFileDir(const uint32_t deviceId, const uint32_t vfId);

    // /sys/fs/cgroup/memory/usermemory/dev0/vf2/memory.limit_in_bytes
    static std::string BuildMemoryConfigLimitFileDir(const uint32_t deviceId, const uint32_t vfId);

    // CUSTOM_SO_DIR_NAME_PREFIX
    static std::string GetCustomSoSubDirName();

    // CUSTOM_COMPUTE_PATCH_NAME
    static std::string GetCustomComputePatchName(const uint32_t uniqueVfId);

    // COMPUTE_PATCH_NAME
    static std::string GetComputePatchName(const uint32_t uniqueVfId);

    // QUEUE_SCHEDULE_PATCH_NAME
    static std::string GetQueueSchPatchName(const uint32_t uniqueVfId);

    // QUEUE_SCHEDULE_PATCH_NAME
    static std::string GetHccpPatchName(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousPkgCommonPrefixPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousRuntimePkgBinPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousRuntimePkgLibPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousOmFilePrefixPath(const uint32_t uniqueVfId, const std::string &hostPidStr);

    static std::string GetHeterogeneousOmFilePrefixPath(const uint32_t uniqueVfId, const uint32_t hostPid);

    static std::string GetHeterogeneousRuntimePkgPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousOppPkgPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousOpsPkgPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousOmFileWholePath(const uint32_t uniqueVfId);

    static std::string GetSubProcHashFileName();

    static std::string GetHeterogeneousRemoteBinPath(const std::string &basePath);

    static std::string GetHeterogeneousRemoteAicpuKernelSoPath(const uint32_t uniqueVfId);

    static std::string GetHeterogeneousRemoteRuntimelibPath(const std::string &basePath);

    static std::string GetHeterogeneousRemoteComoplibPath(const std::string &basePath);

    static std::string GetHostSinkSoPath(const uint32_t uniqueVfId, const uint32_t hostPid, const uint32_t deviceId);

    static std::string BuildDriverExtendPackageRootPath(const uint32_t uniqueVfId);

    static std::string BuildDriverExtendKernelSoRootPath(const uint32_t uniqueVfId);

    static std::string BuildDriverExtendPackageDecRootPath(const uint32_t uniqueVfId);

    static std::string BuildCompatPluginPackageDecRootPath(const uint32_t uniqueVfId);

    static std::string BuildCompatPluginPackageSoInstallPath(const uint32_t uniqueVfId);
};
}  // namespace tsd

#endif  // TSD_PATH_MGR_H