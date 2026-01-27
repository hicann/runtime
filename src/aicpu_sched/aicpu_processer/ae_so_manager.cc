/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ae_so_manager.hpp"
#include "host_cpu_processer.hpp"
#include <memory>
#include <mutex>
#include <cstdlib>
#include <string>
#include <climits>
#include <securec.h>
#include <dlfcn.h>
#include <fstream>
#include <sstream>
#include <vector>
#include "ae_def.hpp"
#include "ae_kernel_lib_aicpu.hpp"

namespace cce {
    namespace {
        // aicpu so root dir, must be absolute path
        constexpr const char_t *AICPU_SO_ROOT_DIR = "/usr/lib64/aicpu_kernels/";
        constexpr const char_t *AICPU_SO_ROOT_DIR_HOST = "opp/built-in/op_impl/host_aicpu/";
        // aicpu so root dir, old path only for hccl
        constexpr const char_t *AICPU_SO_ROOT_DIR_OLD_PATH = "/usr/lib64/";
        // cust so path for cust_aicpu_sd: CustAiCpuUser
        constexpr const char_t *CUST_USER_SO_PATH = "/home/CustAiCpuUser";
        // prefix of cust so dir name
        constexpr const char_t *CUSTOM_SO_DIR_NAME_PREFIX = "cust_aicpu_";
        // aicpu kernels tar uncompress path
        constexpr const char_t *AICPU_SO_UNCOMPRESS_DIR = "aicpu_kernels_device";
        // libretr_kernels.so
        constexpr const char_t *RETR_KERNELS_SO_NAME = "libretr_kernels.so";
        // libhccl_operator_call.so
        constexpr const char_t *HCCL_KERNELS_SO_NAME = "libhccl_operator_call.so";
        // libbuiltin_kernels.so
        constexpr const char_t *BUILTIN_KERNELS_SO_NAME = "libbuiltin_kernels.so";
        // pattern for custom so name
        constexpr const char_t *PATTERN_FOR_SO_NAME("abcdefghijklmnopqrstuvwxyz"
                                                    "ABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890-_.");
        // env variable name: inner aicpu kernel so path
        constexpr const char_t *AICPU_INNER_SO_PATH_ENV_VAR_NAME = "ASCEND_AICPU_KERNEL_PATH";
        // env variable name: custom aicpu kernel so path
        // If modify the env name, please modify the same env name in aicpusd_cust_so_manager.cpp
        constexpr const char_t *AICPU_CUSTOM_SO_PATH_ENV_VAR = "ASCEND_CUST_AICPU_KERNEL_CACHE_PATH";
        // physical machine VFID == 0 物理机场景
        constexpr uint32_t DEFAULT_VFID = 0U;
        // min number of vDeviceId
        constexpr const uint32_t VDEVICE_MIN_CPU_NUM = 32U;
        // max number of vDeviceId
        constexpr const uint32_t VDEVICE_MAX_CPU_NUM = 64U;
        constexpr const uint32_t DIV_NUM = 2U;
        // version.info TurstList info
        const std::string TRUST_SO_LIST_PREFIX = "Trustlist=";

        constexpr const char_t *THREAD_MODE_SO_PATH_FIX = "aicpu_kernels";
        constexpr const char_t *HELPER_AICPU_OPKERNEL_PATH_HEAD = "/home/HwHiAiUser/inuse/aicpu_kernels/";
    }

SingleSoManager::~SingleSoManager()
{
    // Step1.  clear the critical section apiCacher_
    AE_RW_LOCK_WR_LOCK(&rwLock_);
    apiCacher_.clear();
    AE_RW_LOCK_UN_LOCK(&rwLock_);

    // Step2.  destroy the Read Write lock
    AE_RW_LOCK_DESTROY(&rwLock_);

    // Step3. close so
    (void)CloseSo(soHandle_);
    soHandle_ = nullptr;
}

aeStatus_t SingleSoManager::Init(const std::string &guardDirName, const std::string &soFile)
{
    soName_.clear();
    apiCacher_.clear();

    aeStatus_t ret = CheckSoFile(guardDirName, soFile);
    if (ret != AE_STATUS_SUCCESS) {
        return ret;
    }

    void *handle = nullptr;
    ret = OpenSo(soFile, &handle);
    if ((ret == AE_STATUS_SUCCESS) && (handle != nullptr)) {
        soHandle_ = handle;
        soName_ = soFile;
    }
    return ret;
}

aeStatus_t SingleSoManager::CheckSoFile(const std::string &guardDirName, const std::string &soFile)
{
    if (guardDirName.empty()) {
        AE_INFO_LOG(AE_MODULE_ID, "guardDirName is empty, no need check");
        return AE_STATUS_SUCCESS;
    }

    if (soFile.length() >= static_cast<std::string::size_type>(PATH_MAX)) {
        AE_ERR_LOG(AE_MODULE_ID, "soFile file length[%zu] must less than PATH_MAX[%u]", soFile.length(), PATH_MAX);
        return AE_STATUS_SUCCESS;
    }

    std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Alloc memory for path failed.");
        return AE_STATUS_OPEN_SO_FAILED;
    }

    const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Mem set error, ret=%d", eRet);
        return AE_STATUS_OPEN_SO_FAILED;
    }

    if (realpath(soFile.data(), path.get()) == nullptr) {
        AE_WARN_LOG(AE_MODULE_ID, "Format to realpath failed:%s, path:%s", soFile.data(), path.get());
        return AE_STATUS_OPEN_SO_FAILED;
    }

    DeployContext deployCtx = DeployContext::DEVICE;
    GetAicpuDeployContext(deployCtx);
    if (deployCtx != DeployContext::HOSTCPU) {
        std::string tmpGuardDirName(guardDirName);
        if (tmpGuardDirName[tmpGuardDirName.size() - 1UL] != '/') {
            (void)tmpGuardDirName.append("/");
        }

        const std::string pathStr(path.get());
        const std::string realSoPath = GetRealCustSoPath();
        if ((strncmp(path.get(), tmpGuardDirName.c_str(), tmpGuardDirName.length()) != 0) &&
            (pathStr.find(realSoPath) == std::string::npos)) {
            AE_ERR_LOG(AE_MODULE_ID, "Invalid so file with dir:%s so:%s, should be %s or %s",
                       path.get(), soFile.c_str(), tmpGuardDirName.data(), realSoPath.c_str());
            return AE_STATUS_OPEN_SO_FAILED;
        }
    }
    return AE_STATUS_SUCCESS;
}

std::string SingleSoManager::GetRealCustSoPath()
{
    aicpu::aicpuContext_t currentAicpuCtx;
    (void)aicpu::aicpuGetContext(&currentAicpuCtx);

    const uint32_t uniqueVfId = aicpu::GetUniqueVfId();

    std::string soPath = CUST_USER_SO_PATH;
    GetCustSoPathByUniqueVfId(soPath, uniqueVfId);
    (void)soPath.append("lib/");
    return soPath;
}

void SingleSoManager::GetCustSoPathByUniqueVfId(std::string &soPath, const uint32_t uniqueVfId)
{
    if (uniqueVfId == DEFAULT_VFID) {
        (void)soPath.append("/");
    } else if (uniqueVfId >= VDEVICE_MIN_CPU_NUM && uniqueVfId < VDEVICE_MAX_CPU_NUM) {
        const uint32_t custNum = (uniqueVfId - VDEVICE_MIN_CPU_NUM) / DIV_NUM + 1U;
        (void)soPath.append(std::to_string(custNum)).append("/");
    } else {
        (void)soPath.append(std::to_string(uniqueVfId)).append("/");
    }
}

aeStatus_t SingleSoManager::OpenSo(const std::string &soFile, void ** const retHandle)
{
    // Use API in glibc to open the so lib, load this so to process.
    std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Alloc memory for path failed.");
        return AE_STATUS_OPEN_SO_FAILED;
    }

    const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Mem set error, ret=%d", eRet);
        return AE_STATUS_OPEN_SO_FAILED;
    }

    if (realpath(soFile.data(), path.get()) == nullptr) {
        AE_WARN_LOG(AE_MODULE_ID, "Format to realpath failed:[%s], path:[%s]", soFile.data(), path.get());
        return AE_STATUS_OPEN_SO_FAILED;
    }

    AE_INFO_LOG(AE_MODULE_ID, "Open so %s begin.", path.get());
    void * const handle = dlopen(path.get(), static_cast<int32_t>(
                                 (static_cast<uint32_t>(RTLD_LAZY))|(static_cast<uint32_t>(RTLD_GLOBAL))));
    if (handle == nullptr) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Open so %s failed with error:%s", path.get(), dlerror());
        return AE_STATUS_OPEN_SO_FAILED;
    }

    *retHandle = handle;
    AE_INFO_LOG(AE_MODULE_ID, "Open so %s success.", soFile.c_str());
    return AE_STATUS_SUCCESS;
}

aeStatus_t SingleSoManager::GetFunc(void * const soHandle, const char_t * const funcName, void ** const retFuncAddr)
{
    void * const theFuncAddr = dlsym(soHandle, funcName);
    if (static_cast<bool>(unlikely((theFuncAddr == nullptr)))) {
        AE_ERR_LOG(AE_MODULE_ID, "Get funcAddr %s from handle is NULL: %s", funcName, dlerror());
        return AE_STATUS_GET_KERNEL_NAME_FAILED;
    }
    *retFuncAddr = theFuncAddr;
    return AE_STATUS_SUCCESS;
}

aeStatus_t SingleSoManager::GetApi(const char_t * const soNamePtr, const char_t * const funcName,
                                   void ** const funcAddrPtr)
{
    if (static_cast<bool>(unlikely((soHandle_ == nullptr)))) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "soHandle_ is null, should be Init first.");
        return AE_STATUS_INNER_ERROR;
    }

    AE_RW_LOCK_RD_LOCK(&rwLock_);
    auto apiIter = apiCacher_.find(funcName);
    if (apiIter != apiCacher_.end()) {
        *funcAddrPtr = apiIter->second;
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return AE_STATUS_SUCCESS;
    }
    AE_RW_LOCK_UN_LOCK(&rwLock_);

    AE_RW_LOCK_WR_LOCK(&rwLock_);
    apiIter = apiCacher_.find(funcName);
    if (apiIter != apiCacher_.end()) {
        *funcAddrPtr = apiIter->second;
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return AE_STATUS_SUCCESS;
    }

    // get func
    void *theFuncAddr = nullptr;
    const aeStatus_t ret = GetFunc(soHandle_, funcName, &theFuncAddr);
    if (ret != AE_STATUS_SUCCESS) {
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return ret;
    }
    // cache func
    apiCacher_[funcName] = theFuncAddr;
    *funcAddrPtr = theFuncAddr;
    AE_RW_LOCK_UN_LOCK(&rwLock_);
    AE_RUN_INFO_LOG(AE_MODULE_ID, "Get api %s from so %s success.", funcName, soNamePtr);
    return AE_STATUS_SUCCESS;
}

aeStatus_t SingleSoManager::GetApi(const char_t * const soFile, const char_t * const funcName,
                                   void ** const funcAddrPtr, void ** const retHandle)
{
    void *handle = nullptr;
    const aeStatus_t retOpenSo = OpenSo(soFile, &handle);
    if ((retOpenSo == AE_STATUS_SUCCESS) && (handle != nullptr)) {
        void *theFuncAddr = nullptr;
        const aeStatus_t retGetFunc = GetFunc(handle, funcName, &theFuncAddr);
        if ((retGetFunc == AE_STATUS_SUCCESS) && (theFuncAddr != nullptr)) {
            *funcAddrPtr = theFuncAddr;
        }

        *retHandle = handle;
        return retGetFunc;
    }

    return retOpenSo;
}

aeStatus_t SingleSoManager::CloseSo(void * const retHandle)
{
    if (retHandle != nullptr) {
        const int32_t ret = dlclose(retHandle);
        if (ret != 0) {
            AE_ERR_LOG(AE_MODULE_ID, "Close so failed with error:%s", dlerror());
            return AE_STATUS_INNER_ERROR;
        } else {
            AE_DEBUG_LOG(AE_MODULE_ID, "Close success:");
            return AE_STATUS_SUCCESS;
        }
    }
    return AE_STATUS_SUCCESS;
}

MultiSoManager::~MultiSoManager()
{
    // Step1.  clear the critical section apiCacher_
    AE_RW_LOCK_WR_LOCK(&rwLock_);
    for (auto iter = soCacher_.begin(); iter != soCacher_.end(); ++iter) {
        const SingleSoManager * const soMngr = iter->second;
        if (soMngr != nullptr) {
            delete soMngr; // Release each SingleSoManager * stored in cache
        }
    }
    soCacher_.clear();
    AE_RW_LOCK_UN_LOCK(&rwLock_);
    // Step2.  destroy the Read Write lock
    AE_RW_LOCK_DESTROY(&rwLock_);
};

aeStatus_t MultiSoManager::Init()
{
    soCacher_.clear();
    const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode_);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Get aicpu runmode failed.");
        return AE_STATUS_INNER_ERROR;
    }
    // get aicpu so path
    const char_t * const innerDirName = getenv(AICPU_INNER_SO_PATH_ENV_VAR_NAME);
    if (innerDirName != nullptr) {
        const std::string str =  innerDirName;
        const size_t len = str.length();
        if ((len == 0U) || (len >= static_cast<size_t>(PATH_MAX))) {
            AE_ERR_LOG(AE_MODULE_ID, "Length of inner so dir %zu is invalid.", len);
            return AE_STATUS_INNER_ERROR;
        }
        innerKernelPath_ = str;
        if (innerKernelPath_[innerKernelPath_.size() - 1UL] != '/') {
            (void)innerKernelPath_.append("/");
        }
    }
    // get cust aicpu so path
    const char_t * const custDirName = getenv(AICPU_CUSTOM_SO_PATH_ENV_VAR);
    if (custDirName != nullptr) {
        const std::string str =  custDirName;
        const size_t len = str.length();
        if ((len == 0U) || (len >= static_cast<size_t>(PATH_MAX))) {
            AE_ERR_LOG(AE_MODULE_ID, "Length of cust so dir %zu is invalid.", len);
            return AE_STATUS_INNER_ERROR;
        }
        custKernelPath_ = str;
        if (custKernelPath_[custKernelPath_.size() - 1UL] != '/') {
            (void)custKernelPath_.append("/");
        }
    }
    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::GetApi(const aicpu::KernelType kernelType, const char_t * const soName,
                                  const char_t * const funcName, void ** const funcAddrPtr)
{
    SingleSoManager *soMgr = nullptr;
    const aeStatus_t ret = LoadSo(kernelType, soName, soMgr);
    if ((ret != AE_STATUS_SUCCESS) || (soMgr == nullptr)) {
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Load so %s failed.", soName);
        return AE_STATUS_OPEN_SO_FAILED;
    }
    return soMgr->GetApi(soName, funcName, funcAddrPtr);
}

aeStatus_t MultiSoManager::GetSoPath(const aicpu::KernelType kernelType, const std::string &soName,
                                     std::string &soPath) const
{
    if (kernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM || kernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC) {
        return GetCustSoPath(soPath);
    }
    return GetInnerSoPath(soName, soPath);
}

aeStatus_t MultiSoManager::GetThreadModeSoPath(std::string &soPath) const
{
    const char_t * const innerDirName = getenv("HOME");
    if (innerDirName != nullptr) {
        const std::string str =  innerDirName;
        const size_t len = str.length();
        if ((len == 0U) || (len >= static_cast<size_t>(PATH_MAX))) {
            AE_ERR_LOG(AE_MODULE_ID, "Length[%zu] of inner so dir is invalid.", len);
            return AE_STATUS_INNER_ERROR;
        }
        soPath = str;
        if (soPath[soPath.size() - 1UL] != '/') {
            (void)soPath.append("/");
        }
#ifdef AICPU_KERNEL_HELPER
        soPath.append("inuse").append("/");
#endif
        (void)soPath.append(THREAD_MODE_SO_PATH_FIX).append("/")
            .append(std::to_string(aicpu::GetUniqueVfId())).append("/")
            .append(AICPU_SO_UNCOMPRESS_DIR).append("/");
        return AE_STATUS_SUCCESS;
    } else {
        return AE_STATUS_INNER_ERROR;
    }
}
aeStatus_t MultiSoManager::GetInnerSoPath(const std::string &soName, std::string &soPath) const
{
    uint32_t runMode;
    aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AE_ERR_LOG(AE_MODULE_ID, "Get current aicpu ctx failed.");
        return AE_STATUS_INNER_ERROR;
    }

    // aicpu kernel path for lhisi from env: ASCEND_AICPU_KERNEL_PATH
    if ((runMode == aicpu::AicpuRunMode::THREAD_MODE) && (!innerKernelPath_.empty())) {
        soPath = innerKernelPath_;
        return AE_STATUS_SUCCESS;
    }

    // libretr_kernels.so in /usr/lib64/aicpu_kernel/
    if (soName == RETR_KERNELS_SO_NAME) {
        soPath = AICPU_SO_ROOT_DIR;
        return AE_STATUS_SUCCESS;
    }

    // libhccl_operator_call.so in /usr/lib64/
    if ((soName == HCCL_KERNELS_SO_NAME) || (soName == BUILTIN_KERNELS_SO_NAME)) {
        soPath = AICPU_SO_ROOT_DIR_OLD_PATH;
        return AE_STATUS_SUCCESS;
    }

    if (runMode == aicpu::AicpuRunMode::THREAD_MODE) {
        if (GetThreadModeSoPath(soPath) == AE_STATUS_SUCCESS) {
            return AE_STATUS_SUCCESS;
        }
        AE_RUN_WARN_LOG(AE_MODULE_ID, "thread mode home path invalid use default path [%s].", soPath.c_str());
    }
    // get aicpu context
    aicpu::aicpuContext_t currentAicpuCtx;
    status = aicpu::aicpuGetContext(&currentAicpuCtx);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AE_ERR_LOG(AE_MODULE_ID, "Get current ctx failed.");
        return AE_STATUS_INNER_ERROR;
    }
    DeployContext deployCtx = DeployContext::DEVICE;
    GetAicpuDeployContext(deployCtx);
    if (deployCtx == DeployContext::HOSTCPU) {
        std::string aicpuOpPath;
        const char_t *const envValue = std::getenv("ASCEND_AICPU_PATH");
        if ((envValue == nullptr) || (*envValue == '\0')) {
            AE_INFO_LOG(AE_MODULE_ID, "environment variable ASCEND_AICPU_PATH is not set");
        } else {
            aicpuOpPath = std::string(envValue);
        }

        if (aicpuOpPath.empty()) {
            aicpuOpPath = "/usr/local/Ascend/";
            AE_INFO_LOG(AE_MODULE_ID, "use default value[%s]", aicpuOpPath.c_str());
        }
        if ((aicpuOpPath.length() > 0U) && ((aicpuOpPath.at((aicpuOpPath.length()) - 1U)) == '/')) {
            soPath = aicpuOpPath + AICPU_SO_ROOT_DIR_HOST;
        } else {
            soPath = aicpuOpPath + "/" + AICPU_SO_ROOT_DIR_HOST;
        }
    } else {
        // libtf_kernels.so and libaicpu_kernels.so and libcpu_kernels.so and libpt_kernels.so path from context
        soPath = AICPU_SO_ROOT_DIR;
        (void) HELPER_AICPU_OPKERNEL_PATH_HEAD;
#ifdef AICPU_KERNEL_HELPER
        soPath = HELPER_AICPU_OPKERNEL_PATH_HEAD;
#endif
        (void)soPath.append(std::to_string(aicpu::GetUniqueVfId())).append("/").append(AICPU_SO_UNCOMPRESS_DIR)
                    .append("/");
    }

    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::BuildCustSoPath(std::string &soPath, const uint32_t uniqueVfId) const
{
    uint32_t runMode;
    const aicpu::status_t statusMode = aicpu::GetAicpuRunMode(runMode);
    if (statusMode != aicpu::AICPU_ERROR_NONE) {
        AE_ERR_LOG(AE_MODULE_ID, "Get current aicpu ctx failed.");
        return AE_STATUS_INNER_ERROR;
    }
    // dc
    if (runMode == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
        soPath = CUST_USER_SO_PATH;
        SingleSoManager::GetCustSoPathByUniqueVfId(soPath, uniqueVfId);
    } else if (runMode == aicpu::AicpuRunMode::PROCESS_SOCKET_MODE) {
        const char_t * const custDirName = getenv("HOME");
        if (custDirName == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Get current dir name by HOME in socket_mode failed.");
            return AE_STATUS_INNER_ERROR;
        }
        soPath = custDirName;
        AE_RUN_INFO_LOG(AE_MODULE_ID, "Get soPath[%s] in socket_mode", soPath.c_str());
        SingleSoManager::GetCustSoPathByUniqueVfId(soPath, uniqueVfId);
    } else {
        const char_t * const curDirName = getenv("HOME");
        if (curDirName == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Get current home directory failed.");
            return AE_STATUS_INNER_ERROR;
        }
        const std::string dirName = curDirName;
        const size_t len = dirName.length();
        if ((len == 0LU) || (len >= static_cast<size_t>(PATH_MAX))) {
            AE_ERR_LOG(AE_MODULE_ID, "Length of current dir name %zu is invalid.", len);
            return AE_STATUS_INNER_ERROR;
        }
        soPath = dirName;
        if (soPath[soPath.size() - 1LU] != '/') {
            (void)soPath.append("/");
        }
    }
    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::GetCustSoPath(std::string &soPath) const
{
    // get aicpu context
    aicpu::aicpuContext_t currentAicpuCtx;
    const aicpu::status_t status = aicpu::aicpuGetContext(&currentAicpuCtx);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AE_ERR_LOG(AE_MODULE_ID, "Get current ctx failed.");
        return AE_STATUS_INNER_ERROR;
    }
    const uint32_t uniqueVfId = aicpu::GetUniqueVfId();
    // minirc or ctrlcpu, cust so load in current user root path; else, so load in cust aicpu_sd thread
    // lhisi, so load path from env ASCEND_CUST_AICPU_KERNEL_PATH
    if (!custKernelPath_.empty()) {
        soPath = custKernelPath_;
    } else {
        const auto ret = BuildCustSoPath(soPath, uniqueVfId);
        if (ret != AE_STATUS_SUCCESS) {
            AE_ERR_LOG(AE_MODULE_ID, "BuildCustSoPath failed.");
            return ret;
        }
    }
    (void)soPath.append(CUSTOM_SO_DIR_NAME_PREFIX)
        .append(std::to_string(currentAicpuCtx.deviceId)).append("_")
        .append(std::to_string(uniqueVfId)).append("_")
        .append(std::to_string(static_cast<int32_t>(currentAicpuCtx.hostPid))).append("/");
    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::LoadSo(const aicpu::KernelType kernelType, const std::string &soName)
{
    SingleSoManager *soMgr = nullptr;
    return LoadSo(kernelType, soName, soMgr);
}

aeStatus_t MultiSoManager::LoadSo(const aicpu::KernelType kernelType,
                                  const std::string &soName, SingleSoManager *&soMgr)
{
    if (soName.empty()) {
        AE_ERR_LOG(AE_MODULE_ID, "So name is empty.");
        return AE_STATUS_BAD_PARAM;
    }

    if (!aicpu::IsCustAicpuSd())  {
        if ((runMode_ != aicpu::AicpuRunMode::THREAD_MODE) && ((kernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM) ||
            (kernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC))) {
            AE_ERR_LOG(AE_MODULE_ID, "runmode is not THREAD_MODE AND kernelType is [%u]", kernelType);
            return AE_STATUS_BAD_PARAM;
        }
    }

    AE_RW_LOCK_RD_LOCK(&rwLock_);
    auto soIter = soCacher_.find(soName);
    if ((soCacher_.end() != soIter) && (soIter->second != nullptr)) {
        soMgr = soIter->second;
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return AE_STATUS_SUCCESS;
    }
    AE_RW_LOCK_UN_LOCK(&rwLock_);

    AE_RW_LOCK_WR_LOCK(&rwLock_);
    soIter = soCacher_.find(soName);
    if ((soCacher_.end() != soIter) && (soIter->second != nullptr)) {
        soMgr = soIter->second;
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return AE_STATUS_SUCCESS;
    }
    const auto ret = CreateSingleSoMgr(kernelType, soName, soMgr);
    if (ret != AE_STATUS_SUCCESS) {
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return ret;
    }
    AE_RW_LOCK_UN_LOCK(&rwLock_);
    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::CreateSingleSoMgr(const aicpu::KernelType kernelType,
                                             const std::string &soName, SingleSoManager *&soMgr)
{
    // check so name
    if (soName.find_first_not_of(PATTERN_FOR_SO_NAME) != std::string::npos) {
        AE_ERR_LOG(AE_MODULE_ID, "So name %s is not invalid. Please check!", soName.c_str());
        return AE_STATUS_BAD_PARAM;
    }
    // get so real path
    std::string realSoPath;
    auto ret = GetSoPath(kernelType, soName, realSoPath);
    if (ret != AE_STATUS_SUCCESS) {
        return ret;
    }
    std::string soFile(realSoPath);
    (void)soFile.append(soName);
    AE_INFO_LOG(AE_MODULE_ID, "soname[%s]", soFile.c_str());
    // This thread get the lock and create the new single so Manager
    SingleSoManager * const newSSoMngr = new(std::nothrow) SingleSoManager();
    AE_MEMORY_LOG(AE_MODULE_ID, "MallocMemory, func=new, size=%zu, purpose=SingleSoManager object",
        sizeof(SingleSoManager));
    if (newSSoMngr == nullptr) {
        AE_ERR_LOG(AE_MODULE_ID, "Create newSSoMngr ptr failed");
        return AE_STATUS_INNER_ERROR;
    }
    ret = newSSoMngr->Init(realSoPath, soFile);
    if (ret != AE_STATUS_SUCCESS) {
        AE_RUN_INFO_LOG(AE_MODULE_ID, "So does not exist, try to load at another path. currentSoFile=%s.", soFile.c_str());
        if (realSoPath != AICPU_SO_ROOT_DIR) {
            // try to load so from /usr/lib64/aicpu_kernel/
            std::string oriPath = realSoPath;
            realSoPath = AICPU_SO_ROOT_DIR;
            soFile = realSoPath + soName;
            ret = newSSoMngr->Init(realSoPath, soFile);
            if (ret != AE_STATUS_SUCCESS) {
                ret = GetSoInHostPidPath(soName, oriPath, newSSoMngr, soFile);
            }
        }
    }

    // check init result
    if (ret != AE_STATUS_SUCCESS) {
        delete newSSoMngr;
        AE_RUN_WARN_LOG(AE_MODULE_ID, "Single so manager init failed, soFile is %s.", soFile.c_str());
        return ret;
    }
    // Cache it so that we can get it from cache next time.
    soCacher_[soName] = newSSoMngr;
    soMgr = newSSoMngr;
    AE_INFO_LOG(AE_MODULE_ID, "Load so success, soFile=%s.", soFile.c_str());
    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::CloseSo(const std::string &soName)
{
    if (soName.empty()) {
        AE_ERR_LOG(AE_MODULE_ID, "So name is empty.");
        return AE_STATUS_BAD_PARAM;
    }

    AE_RW_LOCK_WR_LOCK(&rwLock_);
    const auto iter = soCacher_.find(soName);
    if (iter != soCacher_.end()) {
        const SingleSoManager * const sSoMngr = iter->second;
        if (sSoMngr != nullptr) {
            delete sSoMngr;
        }
        (void)soCacher_.erase(iter);
    }
    AE_RW_LOCK_UN_LOCK(&rwLock_);

    return AE_STATUS_SUCCESS;
}

aeStatus_t MultiSoManager::GetSoInHostPidPath(const std::string &soName, std::string &oriPath,
                                              SingleSoManager * const newSSoMngr, std::string &soFile) const
{
    aicpu::aicpuContext_t currentAicpuCtx;
    const aicpu::status_t status = aicpu::aicpuGetContext(&currentAicpuCtx);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AE_ERR_LOG(AE_MODULE_ID, "Get current ctx failed.");
        return AE_STATUS_INNER_ERROR;
    }
    oriPath.append(std::to_string(currentAicpuCtx.hostPid)).append("_").
        append(std::to_string(currentAicpuCtx.deviceId)).append("/");
    soFile = oriPath + soName;
    AE_RUN_INFO_LOG(AE_MODULE_ID, "So does not exist, try to load at another path. currentSoFile=%s.", 
                soFile.c_str());
    return newSSoMngr->Init(oriPath, soFile);
}
}