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
#include "inc/tsd_feature_ctrl.h"

namespace tsd {
namespace {
const std::string COMPUTE_PATCH_NAME = "/var/aicpu_scheduler";
const std::string CUSTOM_COMPUTE_PATCH_NAME = "/var/aicpu_custom_scheduler";
const std::string QUEUE_SCHEDULE_PATCH_NAME = "/var/queue_schedule";
const std::string HCCP_PATCH_NAME = "/var/hccp_service.bin";

const std::string AICPU_PACKAGE_DECOMPRESSION_PATH = "/usr/lib64/aicpu_kernels/";

const std::string MEMORY_CONTROL_BASE_PATH = "/sys/fs/cgroup/memory/usermemory/";
// aicpu kernels so inner dir name
constexpr const char_t *AICPU_KERNELS_SO_INNER_DIR_NAME = "aicpu_kernels_device/";
constexpr const char_t *AICPU_EXTEND_KERNELS_SO_INNER_DIR_NAME = "aicpu_extend_syskernels/";
constexpr const char_t *AICPU_ASCENDCPP_SO_INNER_DIR_NAME = "aicpu_kernels_device/tile_fwk_machine/";
// version.info file name
constexpr const char_t *VERSION_INFO_FILE_NAME = "version.info";

// prefix of cust so dir name
constexpr const char_t *CUSTOM_SO_DIR_NAME_PREFIX = "cust_aicpu_";

// cust so path for cust_aicpu_sd: CustAiCpuUser
const std::string CUST_USER_SO_PATH = "/home/CustAiCpuUser";

// physical machine VFID == 0
constexpr uint32_t DEFAULT_VFID = 0U;
constexpr const uint32_t DIV_NUM = 2U;

constexpr const char_t *HOME_SO_PATH_FOR_THREADMODE = "aicpu_kernels/";

const std::string HELPER_PKG_COMMON_PATH_PREFIX = "/home/HwHiAiUser/hs/";
const std::string HELPER_PKG_RUNTIME_BIN_PATH = "runtime/bin/";
const std::string HELPER_PKG_RUNTIME_LIB_PATH = "runtime/lib64/";
const std::string HELPER_PKG_OPP_PATH = "opp";
const std::string OMFILE_PKG_PATH = "omfile/";
const std::string RUNTIME_PKG_PATH = "runtime/";
const std::string HELPER_PKG_OPS_PATH = "ops";
const std::string SUB_PROC_HASH_CFG_FILE = "/etc/mdc/base-plat/process-manager/bin_hash.cfg";
const std::string HELPER_AICPU_OPKERNEL_PATH_HEAD = "/home/HwHiAiUser/inuse/";
const std::string HELPER_PKG_COMOP_LIB_PATH = "comop/lib64/";
const std::string AICPU_OPKERNEL_PATH_HEAD = "/home/HwHiAiUser/aicpu_kernels/";
const std::string DRIVER_EXTEND_PATH_HEAD = "/home/HwHiAiUser/device-sw-plugin/";
const std::string DRIVER_EXTEND_PACKAGE_DECOMPRESSION_DST_PATH = "/usr/lib64/device-sw-plugin/";

const std::string COMPUTE_BIN_NAME = "aicpu_scheduler";
const std::string CUSTOM_COMPUTE_BIN_NAME = "aicpu_custom_scheduler";
const std::string QUEUE_SCHEDULE_BIN_NAME = "queue_schedule";
const std::string HCCP_BIN_NAME = "hccp_service.bin";
const std::string COMPAT_PLUGIN_PACKAGE_DECOMPRESSION_DST_PATH = "/usr/lib64/device-compat-plugin/";
const std::string AICPU_EXTEND_HASH_CFG_FILE = "aicpuExtend_bin_hash.cfg";
const std::string ASCENDCPP_HASH_CFG_FILE = "ascendcpp_bin_hash.cfg";
}  // namespace

// /home/CustAiCpuUser2/cust_aicpu_1_2_10086/
std::string TsdPathMgr::BuildCustomSoVfIdPath(
    const uint32_t deviceId, const uint32_t vfId, const uint32_t uniqueVfId, const uint32_t fmkPid)
{
    (void)deviceId;
    (void)vfId;
    return BuildCustAiCpuUserPath(uniqueVfId).append(CUSTOM_SO_DIR_NAME_PREFIX)
    .append(std::to_string(deviceId))
        .append("_")
        .append(std::to_string(uniqueVfId))
        .append("_")
        .append(std::to_string(fmkPid))
        .append("/");
}

std::string TsdPathMgr::BuildAicpuPackageRootPath(const uint32_t uniqueVfId)
{
    std::string path(AICPU_OPKERNEL_PATH_HEAD);
    if ((uniqueVfId > 0U) && (uniqueVfId < VDEVICE_MAX_CPU_NUM)) {
        path.append(std::to_string(uniqueVfId)).append("/");
    }
    return path;
}

// /usr/lib64/aicpu_kernels/2/
std::string TsdPathMgr::BuildKernelSoRootPath(const uint32_t uniqueVfId, const std::string &destPath)
{
    if (!destPath.empty()) {
        std::string path = destPath;
        return path.append(std::string(HOME_SO_PATH_FOR_THREADMODE)).append(std::to_string(uniqueVfId)).append("/");
    }

    if (FeatureCtrl::IsHeterogeneousProduct()) {
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

std::string TsdPathMgr::BuildKernelHashCfgPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_KERNELS_SO_INNER_DIR_NAME).append(BASE_HASH_CFG_FILE);
}

std::string TsdPathMgr::BuildExtendKernelSoPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_EXTEND_KERNELS_SO_INNER_DIR_NAME);
}

std::string TsdPathMgr::BuildExtendKernelHashCfgPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_KERNELS_SO_INNER_DIR_NAME).append(AICPU_EXTEND_HASH_CFG_FILE);
}

std::string TsdPathMgr::BuildAscendcppSoPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_ASCENDCPP_SO_INNER_DIR_NAME);
}

std::string TsdPathMgr::BuildAscendcppKernelHashCfgPath(const std::string &kernelSoRootPath)
{
    return std::string(kernelSoRootPath).append(AICPU_KERNELS_SO_INNER_DIR_NAME).append(ASCENDCPP_HASH_CFG_FILE);
}

// /usr/lib64/aicpu_kernels/2/aicpu_kernels_device/version.info
std::string TsdPathMgr::AddVersionInfoName(const std::string &kernelSoPath)
{
    return std::string(kernelSoPath).append(VERSION_INFO_FILE_NAME);
}

// 使用/home/CustAiCpuUser1~16的目录，vDeviceId 32 33分到/home/CustAiCpuUser1，vDeviceId 34 35分到/home/CustAiCpuUser2。
std::string TsdPathMgr::BuildCustAiCpuUserPath(const uint32_t uniqueVfId)
{
    std::string soPath(CUST_USER_SO_PATH);
    if (uniqueVfId == DEFAULT_VFID) {
        (void)soPath.append("/");
    } else if (FeatureCtrl::IsVfModeCheckedByDeviceId(uniqueVfId)) {
        const uint32_t custNum = (uniqueVfId - VDEVICE_MIN_CPU_NUM) / DIV_NUM + 1U;
        (void)soPath.append(std::to_string(custNum)).append("/");
    } else {
        (void)soPath.append(std::to_string(uniqueVfId)).append("/");
    }

    return soPath;
}

std::string TsdPathMgr::BuildCustAicpuRootPath(const std::string &userId)
{
    return userId == "0" ? CUST_USER_SO_PATH : CUST_USER_SO_PATH + userId;
}

std::string TsdPathMgr::BuildCustAicpuLibPath(const std::string &userId)
{
    return BuildCustAicpuRootPath(userId) + "/lib/";
}

std::string TsdPathMgr::BuildCustAicpuLibLockerPath(const std::string &userId)
{
    return BuildCustAicpuRootPath(userId) + "/lib_locker";
}

std::string TsdPathMgr::BuildCustAicpuLibPath(const uint32_t uniqueVfId)
{
    return BuildCustAiCpuUserPath(uniqueVfId) + "/lib/";
}

std::string TsdPathMgr::BuildCustAicpuLibLockerPath(const uint32_t uniqueVfId)
{
    return BuildCustAiCpuUserPath(uniqueVfId) + "lib_locker";
}

// dev0/vf2/
std::string TsdPathMgr::BuildVfSubMultiLevelDir(const uint32_t deviceId, const uint32_t vfId)
{
    if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
        return std::string("dev").append(std::to_string(deviceId)).append("/");
    } else {
        return std::string("dev").append(std::to_string(deviceId)).append("/vf").append(std::to_string(vfId))
               .append("/");
    }
}

// /sys/fs/cgroup/memory/usermemory/dev0/vf2/
std::string TsdPathMgr::BuildMemoryConfigRootPath(const uint32_t deviceId, const uint32_t vfId)
{
    return std::string(MEMORY_CONTROL_BASE_PATH).append(TsdPathMgr::BuildVfSubMultiLevelDir(deviceId, vfId));
}

// /sys/fs/cgroup/memory/usermemory/dev0/vf2/memory.usage_in_bytes
std::string TsdPathMgr::BuildMemoryConfigUsageFileDir(const uint32_t deviceId, const uint32_t vfId)
{
    return TsdPathMgr::BuildMemoryConfigRootPath(deviceId, vfId) + "memory.usage_in_bytes";
}

// /sys/fs/cgroup/memory/usermemory/dev0/vf2/memory.limit_in_bytes
std::string TsdPathMgr::BuildMemoryConfigLimitFileDir(const uint32_t deviceId, const uint32_t vfId)
{
    return TsdPathMgr::BuildMemoryConfigRootPath(deviceId, vfId) + "memory.limit_in_bytes";
}

// CUSTOM_SO_DIR_NAME_PREFIX
std::string TsdPathMgr::GetCustomSoSubDirName()
{
    return CUSTOM_SO_DIR_NAME_PREFIX;
}

// CUSTOM_COMPUTE_PATCH_NAME
std::string TsdPathMgr::GetCustomComputePatchName(const uint32_t uniqueVfId)
{
    if (FeatureCtrl::IsAosCore()) {
        return (AOSCORE_DIR_PREFIX + CUSTOM_COMPUTE_PATCH_NAME);
    } else {
        std::string compatPath = TsdPathMgr::BuildCompatPluginPackageSoInstallPath(uniqueVfId)
            .append(CUSTOM_COMPUTE_BIN_NAME);
        if (access(compatPath.c_str(), X_OK) == 0) {
            return compatPath;
        }
        std::string tmpName = TsdPathMgr::BuildDriverExtendKernelSoRootPath(uniqueVfId).append(CUSTOM_COMPUTE_BIN_NAME);
        if (access(tmpName.c_str(), X_OK) == 0) {
            return tmpName;
        } else {
            return CUSTOM_COMPUTE_PATCH_NAME;
        }
    }
}

// COMPUTE_PATCH_NAME
std::string TsdPathMgr::GetComputePatchName(const uint32_t uniqueVfId)
{
    if (FeatureCtrl::IsAosCore()) {
        return (AOSCORE_DIR_PREFIX + COMPUTE_PATCH_NAME);
    } else {
        std::string compatPath = TsdPathMgr::BuildCompatPluginPackageSoInstallPath(uniqueVfId)
            .append(COMPUTE_BIN_NAME);
        if (access(compatPath.c_str(), X_OK) == 0) {
            return compatPath;
        }
        std::string tmpName = TsdPathMgr::BuildDriverExtendKernelSoRootPath(uniqueVfId).append(COMPUTE_BIN_NAME);
        if (access(tmpName.c_str(), X_OK) == 0) {
            return tmpName;
        } else {
            return COMPUTE_PATCH_NAME;
        }
    }
}

// QUEUE_SCHEDULE_PATCH_NAME
std::string TsdPathMgr::GetQueueSchPatchName(const uint32_t uniqueVfId)
{
    if (FeatureCtrl::IsAosCore()) {
        return (AOSCORE_DIR_PREFIX + QUEUE_SCHEDULE_PATCH_NAME);
    } else {
        std::string compatPath = TsdPathMgr::BuildCompatPluginPackageSoInstallPath(uniqueVfId)
            .append(QUEUE_SCHEDULE_BIN_NAME);
        if (access(compatPath.c_str(), X_OK) == 0) {
            return compatPath;
        }
        std::string tmpName = TsdPathMgr::BuildDriverExtendKernelSoRootPath(uniqueVfId).append(QUEUE_SCHEDULE_BIN_NAME);
        if (access(tmpName.c_str(), X_OK) == 0) {
            return tmpName;
        } else {
            return QUEUE_SCHEDULE_PATCH_NAME;
        }
    }
}

std::string TsdPathMgr::GetHccpPatchName(const uint32_t uniqueVfId)
{
    std::string compatPath = TsdPathMgr::BuildCompatPluginPackageSoInstallPath(uniqueVfId)
            .append(HCCP_BIN_NAME);
    if (access(compatPath.c_str(), X_OK) == 0) {
        return compatPath;
    }
    std::string tmpName = TsdPathMgr::BuildDriverExtendKernelSoRootPath(uniqueVfId).append(HCCP_BIN_NAME);
    if (access(tmpName.c_str(), X_OK) == 0) {
        return tmpName;
    } else {
        return HCCP_PATCH_NAME;
    }
}

std::string TsdPathMgr::GetHeterogeneousOmFileWholePath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(OMFILE_PKG_PATH);
}

std::string TsdPathMgr::GetSubProcHashFileName()
{
    return SUB_PROC_HASH_CFG_FILE;
}

std::string TsdPathMgr::GetHeterogeneousRemoteBinPath(const std::string &basePath)
{
    std::string finaBinPath;
    if ((basePath.length() > 0U) && ((basePath.at((basePath.length()) - 1U)) == '/')) {
        finaBinPath = basePath + HELPER_PKG_RUNTIME_BIN_PATH;
    } else {
        finaBinPath = basePath + "/" + HELPER_PKG_RUNTIME_BIN_PATH;
    }
    return finaBinPath;
}

std::string TsdPathMgr::GetHeterogeneousRemoteAicpuKernelSoPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::BuildKernelSoRootPath(uniqueVfId).append(AICPU_KERNELS_SO_INNER_DIR_NAME);
}

std::string TsdPathMgr::GetHeterogeneousRemoteComoplibPath(const std::string &basePath)
{
    std::string finaBinPath;
    if ((basePath.length() > 0U) && ((basePath.at((basePath.length()) - 1U)) == '/')) {
        finaBinPath = basePath + HELPER_PKG_COMOP_LIB_PATH;
    } else {
        finaBinPath = basePath + "/" + HELPER_PKG_COMOP_LIB_PATH;
    }
    return finaBinPath;
}

std::string TsdPathMgr::GetHeterogeneousRemoteRuntimelibPath(const std::string &basePath)
{
    std::string finaBinPath;
    if ((basePath.length() > 0U) && ((basePath.at((basePath.length()) - 1U)) == '/')) {
        finaBinPath = basePath + HELPER_PKG_RUNTIME_LIB_PATH;
    } else {
        finaBinPath = basePath + "/" + HELPER_PKG_RUNTIME_LIB_PATH;
    }
    return finaBinPath;
}

std::string TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(const uint32_t uniqueVfId)
{
    return std::string(HELPER_PKG_COMMON_PATH_PREFIX).append(std::to_string(uniqueVfId)).append("/");
}

std::string TsdPathMgr::GetHeterogeneousRuntimePkgBinPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(HELPER_PKG_RUNTIME_BIN_PATH);
}

std::string TsdPathMgr::GetHeterogeneousRuntimePkgLibPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(HELPER_PKG_RUNTIME_LIB_PATH);
}

std::string TsdPathMgr::GetHeterogeneousOmFilePrefixPath(const uint32_t uniqueVfId, const std::string &hostPidStr)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(OMFILE_PKG_PATH).
           append(hostPidStr).append("/");
}

std::string TsdPathMgr::GetHeterogeneousOmFilePrefixPath(const uint32_t uniqueVfId, const uint32_t hostPid)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(OMFILE_PKG_PATH)
       .append(std::to_string(hostPid)).append("/");
}

std::string TsdPathMgr::GetHeterogeneousRuntimePkgPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(RUNTIME_PKG_PATH);
}

std::string TsdPathMgr::GetHeterogeneousOppPkgPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(HELPER_PKG_OPP_PATH);
}

std::string TsdPathMgr::GetHeterogeneousOpsPkgPath(const uint32_t uniqueVfId)
{
    return TsdPathMgr::GetHeterogeneousPkgCommonPrefixPath(uniqueVfId).append(HELPER_PKG_OPS_PATH);
}

std::string TsdPathMgr::GetHostSinkSoPath(const uint32_t uniqueVfId, const uint32_t hostPid, const uint32_t deviceId)
{
    return std::string(AICPU_PACKAGE_DECOMPRESSION_PATH).append(std::to_string(uniqueVfId)).append("/")
        .append(AICPU_KERNELS_SO_INNER_DIR_NAME)
        .append(std::to_string(hostPid)).append("_").append(std::to_string(deviceId));
}

std::string TsdPathMgr::BuildDriverExtendPackageRootPath(const uint32_t uniqueVfId)
{
    std::string path(DRIVER_EXTEND_PATH_HEAD);
    if ((uniqueVfId > 0U) && (uniqueVfId < VDEVICE_MAX_CPU_NUM)) {
        (void)path.append(std::to_string(uniqueVfId)).append("/");
    }
    return path;
}

std::string TsdPathMgr::BuildDriverExtendKernelSoRootPath(const uint32_t uniqueVfId)
{
    return std::string(DRIVER_EXTEND_PACKAGE_DECOMPRESSION_DST_PATH).append(std::to_string(uniqueVfId)).append("/").
        append("device-sw-plugin/");
}

std::string TsdPathMgr::BuildDriverExtendPackageDecRootPath(const uint32_t uniqueVfId)
{
    return std::string(DRIVER_EXTEND_PACKAGE_DECOMPRESSION_DST_PATH).append(std::to_string(uniqueVfId)).append("/");
}

std::string TsdPathMgr::BuildCompatPluginPackageDecRootPath(const uint32_t uniqueVfId)
{
    return std::string(COMPAT_PLUGIN_PACKAGE_DECOMPRESSION_DST_PATH).append(std::to_string(uniqueVfId)).append("/");
}

std::string TsdPathMgr::BuildCompatPluginPackageSoInstallPath(const uint32_t uniqueVfId)
{
    return std::string(COMPAT_PLUGIN_PACKAGE_DECOMPRESSION_DST_PATH).append(std::to_string(uniqueVfId)).append("/");
}
}  // namespace tsd