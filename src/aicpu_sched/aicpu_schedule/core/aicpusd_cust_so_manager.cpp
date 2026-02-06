/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_cust_so_manager.h"

#include <fstream>
#include <cstring>
#include <dirent.h>
#include <errno.h>
#include <unistd.h>
#include <securec.h>
#include <sys/stat.h>
#include <sys/file.h>
#include <sys/types.h>
#include "aicpu_engine.h"
#include "aicpusd_status.h"
#include "aicpusd_info.h"
#include "aicpu_event_struct.h"
#include "common/aicpusd_util.h"
#include "core/aicpusd_drv_manager.h"
#include "aicpusd_feature_ctrl.h"

namespace {
    // cust so root path: CustAiCpuUser
    const std::string CP_CUSTOM_SO_ROOT_PATH = "/home/CustAiCpuUser";
    const std::string CP_CUSTOM_SO_LIB_NAME = "lib/";
    const std::string CP_CUSTOM_SO_LOCK_NAME =  "lib_locker";
    // prefix of cust so dir name
    constexpr const char *CP_CUSTOM_SO_DIR_NAME_PREFIX = "cust_aicpu_";
    // pattern for custom so name
    constexpr const char *CP_PATTERN_FOR_SO_NAME("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890-_.");
    constexpr const uint32_t DIV_NUM = 2U;
    // physical machine VFID == 0 物理机场景
    constexpr uint32_t CP_DEFAULT_VF_ID = 0U;
    // permissions
    constexpr uint32_t READ_OWNER = 256U;
    constexpr uint32_t WRITE_OWNER = 128U;
    constexpr uint32_t EXEC_OWNER = 64U;
    constexpr uint32_t READ_GROUP = 32U;
    constexpr uint32_t EXEC_GROUP = 8U;
    constexpr uint64_t MAX_FILE_SIZE = 0xc800000; // 200MB

    // permissions to 640
    constexpr mode_t MODE_640 = static_cast<mode_t>(READ_OWNER)  |
                                static_cast<mode_t>(WRITE_OWNER) |
                                static_cast<mode_t>(READ_GROUP);
    // permissions to 750
    constexpr mode_t MODE_750 = static_cast<mode_t>(READ_OWNER)  |
                                static_cast<mode_t>(WRITE_OWNER) |
                                static_cast<mode_t>(EXEC_OWNER)  |
                                static_cast<mode_t>(READ_GROUP)  |
                                static_cast<mode_t>(EXEC_GROUP);
}

namespace AicpuSchedule {
    AicpuCustSoManager &AicpuCustSoManager::GetInstance()
    {
        static AicpuCustSoManager instance;
        return instance;
    }

    int32_t AicpuCustSoManager::InitAicpuCustSoManager(const aicpu::AicpuRunMode mode,
                                                       const AicpuSchedMode schedMode)
    {
        runMode_ = mode;
        schedMode_ = schedMode;
        (void)GetDirForCustAicpuSo(custSoRootPath_);
        // init cust so soft link path
        custSoDirName_ = GetPathForCustAicpuSoftLink();
        if (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            hashCalculator_.SetSoRootPath(custSoRootPath_);
            fileLocker_.InitFileLocker(custSoRootPath_ + CP_CUSTOM_SO_LOCK_NAME);
        }

        aicpusd_run_info("Cust so manager init successfully, dir=%s, runMode=%u, schedMode=%u.",
                         custSoDirName_.c_str(), static_cast<uint32_t>(runMode_), static_cast<uint32_t>(schedMode));
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuCustSoManager::IsSupportCustAicpu() const
    {
        // only msgq mode not support cust aicpu
        if (schedMode_ == SCHED_MODE_MSGQ) {
            return false;
        }
        return true;
    }

    int32_t AicpuCustSoManager::CheckAndCreateSoFile(const LoadOpFromBufArgs *const args, std::string &soName)
    {
        // check init result
        if (!CheckCustSoPath()) {
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        if (args == nullptr) {
            aicpusd_err("cust so ptr is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check so buf
        char_t *const soBuf = PtrToPtr<void, char_t>(ValueToPtr(args->kernelSoBuf));
        if (soBuf == nullptr) {
            aicpusd_err("BatchLoadOpFromBuf kernel so buf ptr is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check so buf len
        const uint32_t soBufLen = static_cast<uint32_t>(args->kernelSoBufLen);
        if (soBufLen == 0U) {
            aicpusd_err("BatchLoadOpFromBuf kernel input param soBufLen must > 0");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check so name
        const char_t * const soNamePtr = static_cast<const char_t *>(ValueToPtr(args->kernelSoName));
        if (soNamePtr == nullptr) {
            aicpusd_err("BatchLoadOpFromBuf kernel so name ptr is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check so name len
        const uint32_t soNameLen = static_cast<uint32_t>(args->kernelSoNameLen);
        if ((soNameLen == 0U) || (soNameLen > MAX_CUST_SO_NAME_LEN)) {
            aicpusd_err("BatchLoadOpFromBuf kernel input param soNameLen=%u not in (0, %u].",
                soNameLen, MAX_CUST_SO_NAME_LEN);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        // crate so file
        const std::string realSoName(soNamePtr, static_cast<size_t>(soNameLen));
        const FileInfo fileInfo = {.data=soBuf, .size=soBufLen, .name=realSoName};
        const int32_t ret = CreateSoFile(fileInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Process BatchLoadOpFromBuf failed as parse so file failed, so name[%s].", realSoName.c_str());
            return ret;
        }
        soName = realSoName;
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckAndDeleteSoFile(const LoadOpFromBufArgs *const args)
    {
        // check init result
        if (!CheckCustSoPath()) {
            aicpusd_err("Check cust so path fail");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        if (args == nullptr) {
            aicpusd_err("cust so ptr is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check so name len
        const uint32_t soNameLen = static_cast<uint32_t>(args->kernelSoNameLen);
        if ((soNameLen == 0U) || (soNameLen > MAX_CUST_SO_NAME_LEN)) {
            aicpusd_err("LoadOpFromBuf kernel input param soNameLen=%u not in (0, %u].",
                soNameLen, MAX_CUST_SO_NAME_LEN);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check so name
        if (args->kernelSoName == 0U) {
            aicpusd_err("so name ptr is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const std::string realSoName(static_cast<const char_t *>(ValueToPtr(args->kernelSoName)),
            static_cast<size_t>(soNameLen));
        if (realSoName.find_first_not_of(CP_PATTERN_FOR_SO_NAME) != std::string::npos) {
            aicpusd_err("Cust so name %s is not invalid. Please check!", realSoName.c_str());
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        std::string fileName;
        (void) fileName.append(custSoDirName_).append(std::string(realSoName));
        if (access(fileName.c_str(), F_OK) != 0) {
            aicpusd_run_warn(
                "Check deleteCustOp's so full path:%s failed, error:%s", fileName.c_str(), strerror(errno));
            return AICPU_SCHEDULE_OK;
        }
        // check so file
        const int32_t ret = CheckSoFullPathValid(fileName);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        // delete so
        return DeleteSoFile(custSoDirName_, fileName);
    }

    int32_t AicpuCustSoManager::CheckAndDeleteCustSoDir()
    {
        // check init result
        if (!CheckCustSoPath()) {
            return AICPU_SCHEDULE_OK;
        }

        const std::string dirName(custSoDirName_);
        // check whether dir is empty. If empty, delete dir
        {
            const std::lock_guard<std::mutex> soFileLock(soFileMutex_);
            if (CheckDirEmpty(dirName)) {
                if (remove(dirName.c_str()) != 0) {
                    aicpusd_run_info("Delete dir:%s failed, error is %s.", dirName.c_str(), strerror(errno));
                } else {
                    aicpusd_info("Delete dir:%s success.", dirName.c_str());
                }
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CreateSoFile(const FileInfo &fileInfo)
    {
        aicpusd_info("begin to create so file. soName is %s", fileInfo.name.c_str());
        // check so name
        const std::string kernelSo(fileInfo.name);
        if (kernelSo.find_first_not_of(CP_PATTERN_FOR_SO_NAME) != std::string::npos) {
            aicpusd_err("Cust so name %s is not invalid. Please check!", kernelSo.c_str());
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const int32_t ret = DoCreateSoFile(fileInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Create so failed, path=%s", fileInfo.name.c_str());
            return ret;
        }

        // load so if current aicpu mode is thread mode(minirc/ctrlcpu/lhisi)
        if (runMode_ == aicpu::AicpuRunMode::THREAD_MODE) {
            const uint32_t loadSoNum = 1U;
            const char *soNames[loadSoNum] = {fileInfo.name.c_str()};
            (void)aeBatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, loadSoNum, &(soNames[0]));
        }
        aicpusd_info("Create so file %s success", fileInfo.name.c_str());
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::DoCreateSoFile(const FileInfo &fileInfo)
    {
        const std::lock_guard<std::mutex> soFileLock(soFileMutex_);
        const std::string softLinkPath = custSoDirName_ + fileInfo.name;
        if (runMode_ != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            aicpusd_info("Aicpu is not process mode, only write file. path=%s", softLinkPath.c_str());
            const FileInfo newFileInfo = {.data=fileInfo.data, .size=fileInfo.size, .name=softLinkPath};
            return WriteBufToSoFile(newFileInfo, GetPathForCustAicpuSoftLink());
        }

        int32_t ret = AICPU_SCHEDULE_OK;
        FileHashInfo existedFileInfo = {};
        const std::string soFullPath = GenerateSoFullPath(fileInfo.name); // The real so name, not is soft link
        const FileInfo newFileInfo = {.data=fileInfo.data, .size=fileInfo.size, .name=soFullPath};
        fileLocker_.LockFileLocker();
        if (hashCalculator_.GetSameFileInfo(newFileInfo, existedFileInfo)) {
            ret = CreateSoftLinkToSoFile(softLinkPath, existedFileInfo.filePath);
        } else {
            ret = WriteBufToSoFile(newFileInfo, GetPathForCustAicpuRealSo());
            if (ret == AICPU_SCHEDULE_OK) {
                ret = CreateSoftLinkToSoFile(softLinkPath, soFullPath);
            }
        }
        fileLocker_.UnlockFileLocker();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Create so file failed, so=%s", softLinkPath.c_str());
            return ret;
        }

        return ret;
    }

    int32_t AicpuCustSoManager::WriteBufToSoFile(const FileInfo &fileInfo, const std::string &dirPath) const
    {
        const std::string soName = fileInfo.name;
        // check and make dir
        int32_t ret = CheckOrMakeDirectory(dirPath);
        if (ret != 0) {
            aicpusd_err("Check or create directory:%s failed.", dirPath.c_str());
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        // serious security problem, must check realpath
        ret = CheckSoFullPathValid(soName);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        // check whether so exist
        if (access(soName.c_str(), F_OK) == 0) {
            aicpusd_info("%s already exists in the current directory, no need to write again.", soName.c_str());
            return AICPU_SCHEDULE_OK;
        }
        try {
            std::ofstream soFile(soName, std::ios::out | std::ios::binary);
            if (!soFile) {
                aicpusd_err("Fail to open file:%s. reason=%s", soName.c_str(), strerror(errno));
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
            const ScopeGuard fileGuard([&soFile] () { soFile.close(); });
            (void) soFile.write(fileInfo.data, static_cast<std::streamsize>(fileInfo.size));
            if (!soFile.good()) {
                aicpusd_err("Fail to write file:%s, length:%u, eof=%d, bad=%d, fail=%d, reason=%s. please check host so size",
                            soName.c_str(), fileInfo.size, soFile.eof(), soFile.bad(), soFile.fail(), strerror(errno));
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
        } catch (const std::ofstream::failure &err) {
            aicpusd_err("Fail to write file:%s, err=%s, reason=%s.", soName.c_str(), err.what(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        // change so file permissions to 640
        if (chmod(soName.c_str(), MODE_640) != 0) {
            aicpusd_err("Change file:%s mode failed.", soName.c_str());
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        aicpusd_run_info("Write buffer to so success, path=%s", soName.c_str());
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CreateSoftLinkToSoFile(const std::string &softLinkPath, const std::string &existedSoPath)
    {
        if (access(existedSoPath.c_str(), F_OK) != 0) {
            aicpusd_err("The target path is not existed in device, can not create. linkPath=%s, targetPath=%s",
                        softLinkPath.c_str(), existedSoPath.c_str());
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        if (access(softLinkPath.c_str(), F_OK) == 0) {
            aicpusd_info("The soft link has existed in device, can not create again. linkPath=%s, targetPath=%s",
                        softLinkPath.c_str(), existedSoPath.c_str());
            return AICPU_SCHEDULE_OK;
        }

        int32_t ret = CheckOrMakeDirectory(custSoDirName_);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("The dir to create so soft link is not exist, dir=%s", custSoDirName_.c_str());
            return ret;
        }

        ret = CheckSoFullPathValid(softLinkPath);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Invalid soft link path, linkPath=%s, targetPath=%s",
                        softLinkPath.c_str(), existedSoPath.c_str());
            return ret;
        }

        ret = symlink(existedSoPath.c_str(), softLinkPath.c_str());
        if (ret != 0) {
            aicpusd_err("Create soft links failed, ret=%d, linkPath=%s, targetPath=%s, reason=%s",
                        ret, softLinkPath.c_str(), existedSoPath.c_str(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        aicpusd_run_info("Create soft link so success, linkPath=%s, targetPath=%s",
                         softLinkPath.c_str(), existedSoPath.c_str());
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::GetDirForCustAicpuSo(std::string &dirName) const
    {
        const uint32_t uniqueVfId = AicpuDrvManager::GetInstance().GetUniqueVfId();
        if (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            dirName = GetCustAicpuUserPath(uniqueVfId);
        } else {
            // get cust aicpu so path
            bool envRet = false;
            std::string custDirName = "";
            if (runMode_ == aicpu::AicpuRunMode::THREAD_MODE) {
                envRet = AicpuUtil::GetEnvVal(ENV_NAME_CUST_SO_PATH, custDirName);
            }
            if (!envRet) {
                envRet = AicpuUtil::GetEnvVal(ENV_NAME_HOME, custDirName);
                if (!envRet) {
                    aicpusd_info("Get current home directory not success.");
                    return AICPU_SCHEDULE_ERROR_INNER_ERROR;
                }
            }

            dirName = custDirName;
            const size_t len = dirName.size();
            if ((len == 0U) || (len >= static_cast<size_t>(PATH_MAX))) {
                aicpusd_err("The length of custDirName is %zu which is invalid.", len);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
            if (dirName[dirName.size() - 1U] != '/') {
                (void) dirName.append("/");
            }
        }

        // check directory ${customUser} or ${currentUser}
        const int ret = access(dirName.c_str(), F_OK);
        if (ret != 0) {
            aicpusd_err("Check directory:%s failed, error is %s.", dirName.c_str(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        return AICPU_SCHEDULE_OK;
    }

    std::string AicpuCustSoManager::GetCustAicpuUserPath(const uint32_t uniqueVfId) const
    {
        // dc: ${CustAicpuUser${vfId}}/cust_aicpu_vf${vfId}/cust_aicpu_pid${hostpid}/
        // vfId is equal to 0, user is CustAicpuUser, other are CustAicpuUser${vfId}
        std::string dirName = CP_CUSTOM_SO_ROOT_PATH;
        if (uniqueVfId == CP_DEFAULT_VF_ID) {
            (void)dirName.append("/");
        } else if (FeatureCtrl::IsVfModeCheckedByDeviceId(uniqueVfId)) {
            const uint32_t custNum = (uniqueVfId - VDEVICE_MIN_CPU_NUM) / DIV_NUM + 1;
            (void)dirName.append(std::to_string(custNum)).append("/");
        } else {
            (void)dirName.append(std::to_string(uniqueVfId)).append("/");
        }

        return dirName;
    }

    std::string AicpuCustSoManager::GetPathForCustAicpuRealSo() const
    {
        return custSoRootPath_ + CP_CUSTOM_SO_LIB_NAME;
    }

    std::string AicpuCustSoManager::GetPathForCustAicpuSoftLink() const
    {
        const uint32_t uniqueVfId = AicpuDrvManager::GetInstance().GetUniqueVfId();
        std::string dirName = custSoRootPath_;
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        const pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
        (void) dirName.append(CP_CUSTOM_SO_DIR_NAME_PREFIX)
            .append(std::to_string(deviceId)).append("_")
            .append(std::to_string(uniqueVfId)).append("_")
            .append(std::to_string(static_cast<int32_t>(hostPid))).append("/");
        return dirName;
    }

    int32_t AicpuCustSoManager::CheckSoFullPathValid(const std::string &soFullPath) const
    {
        if (soFullPath.length() >= static_cast<size_t>(PATH_MAX)) {
            aicpusd_err("soFullPath file length[%zu] must less than PATH_MAX[%u]", soFullPath.length(), PATH_MAX);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        const std::string::size_type pos = soFullPath.rfind('/');
        if (pos == std::string::npos) {
            aicpusd_err("The path of current so file %s dose not contain /.", soFullPath.c_str());
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        // include last '/'
        const std::string realFilePath = soFullPath.substr(0U, pos + 1U);

        std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
        if (path == nullptr) {
            aicpusd_run_info("Alloc memory for path failed.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
        if (eRet != EOK) {
            aicpusd_run_info("Mem set not success, ret=%d", eRet);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (realpath(realFilePath.data(), path.get()) == nullptr) {
            aicpusd_err("Format to realpath failed:%s, path:%s", realFilePath.c_str(), path.get());
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // path after realpath
        std::string normalizedPath(path.get());
        if (normalizedPath[normalizedPath.length() - 1U] != '/') {
            (void) normalizedPath.append("/");
        }

        if (normalizedPath != realFilePath) {
            aicpusd_err("Invalid so file:%s, should be %s", realFilePath.c_str(), normalizedPath.c_str());
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        aicpusd_info("check so file %s success.", soFullPath.c_str());
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckOrMakeDirectory(const std::string &dirName) const
    {
        // input dirName is checked to be not nullptr
        int32_t ret = access(dirName.c_str(), F_OK);
        if (ret == -1) {
            // create directory and set permissions to 750
            ret = mkdir(dirName.c_str(), MODE_750);
            if (ret == -1) {
                const std::string errMsg = "Create directory:" + dirName + " failed, error:" + strerror(errno);
                aicpusd_err("%s", errMsg.c_str());
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
            ret = chmod(dirName.c_str(), MODE_750);
            if (ret != 0) {
                aicpusd_err("Change directory:%s mode failed, errno:%s.", dirName.c_str(), strerror(errno));
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuCustSoManager::CheckDirEmpty(const std::string &dirName) const
    {
        // open dir
        DIR *const dirHandle = opendir(dirName.c_str());
        if (dirHandle == nullptr) {
            aicpusd_err("Open dir:%s failed, error:%s.", dirName.c_str(), strerror(errno));
            return false;
        }
        // search dir
        dirent *ent = nullptr;
        while ((ent = readdir(dirHandle)) != nullptr) {
            // check whether . or ..
            if ((strcmp(".", ent->d_name) == 0) || (strcmp("..", ent->d_name) == 0)) {
                continue;
            }
            // if exist dir or file, return false
            const int32_t dType = static_cast<int32_t>(ent->d_type);
            if ((dType == DT_DIR) || (dType == DT_REG)) {
                // filter hidden file
                // If so is dlopen but not dlclose, a hidden file will be created when delete the so
                if (ent->d_name[0] != '.') {
                    aicpusd_info("Dir:%s is not empty, file name is %s.", dirName.c_str(), ent->d_name);
                    (void)closedir(dirHandle);
                    return false;
                } else {
                    aicpusd_run_info("Exist hidden file %s in dir:%s.", ent->d_name, dirName.c_str());
                }
            }
        }
        (void)closedir(dirHandle);
        aicpusd_info("Dir:%s is empty", dirName.c_str());
        return true;
    }

    int32_t AicpuCustSoManager::DeleteCustSoDir() const
    {
        if (custSoDirName_.empty()) {
            return AICPU_SCHEDULE_OK;
        }

        if (access(custSoDirName_.c_str(), F_OK) != 0) {
            aicpusd_run_info("Access cust so dir %s not success, reason is %s.",
                             custSoDirName_.c_str(), strerror(errno));
            return AICPU_SCHEDULE_OK;
        }
        const std::string command = "rm -rf " + custSoDirName_;

        const int32_t ret = AicpuUtil::ExecuteCmd(command.c_str());
        if (ret != 0) {
            aicpusd_err("Delete cust so dir %s failed, error is %s.", custSoDirName_.c_str(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::DeleteSoFile(const std::string &dirName, const std::string &soFullPath)
    {
        const std::lock_guard<std::mutex> soFileLock(soFileMutex_);
        const int32_t ret = RemoveSoFile(dirName, soFullPath);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        // in delete so process, cannot dlclose so, because current cust so may be use some third party library,
        // the third party library may use pthread_key_create to register destruct call back for current thread when
        // dlopen, if we dlclose the so, the destruct will get invalid pointer and cause coredump
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::RemoveSoFile(const std::string &dirName, const std::string &soFullPath) const
    {
        if (access(soFullPath.c_str(), F_OK) != 0) {
            aicpusd_info("%s not exists in the current directory, reason:%s.", soFullPath.c_str(), strerror(errno));
            return AICPU_SCHEDULE_OK;
        }
        if (chmod(dirName.c_str(), MODE_750) != 0) {
            aicpusd_err("Change deleteCustOp's directory:%s mode failed, error:%s.", dirName.c_str(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        if (remove(soFullPath.c_str()) != 0) {
            aicpusd_err("Delete so of custom op:%s failed, error:%s.", soFullPath.c_str(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuCustSoManager::CheckCustSoPath() const
    {
        if (custSoDirName_.empty()) {
            aicpusd_err("custSoDirName_ is empty. Please check log of init method.");
            return false;
        }
        return true;
    }

    std::string AicpuCustSoManager::GenerateSoFullPath(const std::string &soName) const
    {
        // Use pid to avoid same so name
        const pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
        const uint32_t uniqueVfId = AicpuDrvManager::GetInstance().GetUniqueVfId();
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        return GetPathForCustAicpuRealSo() + soName + "." + std::to_string(deviceId) + "." +
               std::to_string(uniqueVfId) + "." + std::to_string(hostPid);
    }

    bool HashCalculator::GetSameFileInfo(const FileInfo &fileInfo, FileHashInfo &existedFileHashInfo) {
        UpdateCache();

        const uint64_t hashValue = GetQuickHash(fileInfo.data, fileInfo.size);
        if (GetSameHashFileFromCache(hashValue, existedFileHashInfo)) {
            aicpusd_info("The file has same existed file after hash compare, so=%s, hash=%lu",
                         fileInfo.name.c_str(), hashValue);
            return true;
        }

        FileHashInfo hashInfo = {};
        hashInfo.filePath = fileInfo.name;
        hashInfo.fileSize = fileInfo.size;
        hashInfo.hashValue = hashValue;
        AddHashInfoToCache(hashInfo);

        return false;
    }

    void HashCalculator::UpdateCache()
    {
        std::vector<std::string> file_names = {};
        int32_t ret = GetFileNameInDir(file_names);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_warn("Get file name in dir failed");
            return;
        }

        for (const auto &file_name : file_names) {
            const std::string filePath = soRootPath_ + CP_CUSTOM_SO_LIB_NAME + file_name;
            if (IsFileInCache(filePath)) {
                continue;
            }

            aicpusd_info("Start to read so %s", filePath.c_str());
            FileHashInfo hashInfo = {};
            ret = GenerateFileHashInfo(filePath, hashInfo);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Get file hash info failed, filePath=%s", filePath.c_str());
            } else {
                AddHashInfoToCache(hashInfo);
            }
        }
    }

    bool HashCalculator::GetSameHashFileFromCache(const uint64_t hashValue, FileHashInfo &existedFileHashInfo) const
    {
        for (const auto &hashInfo : cache_) {
            if (hashValue == hashInfo.hashValue) {
                existedFileHashInfo = hashInfo;
                return true;
            }
        }

        return false;
    }

    int32_t HashCalculator::GenerateFileHashInfo(const std::string &filePath, FileHashInfo &hashInfo) const
    {
        if (!IsFileExist(filePath) || !IsRegularFile(filePath)) {
            aicpusd_err("The file is not a regular file or not exist, filePath=%s, exist=%d",
                        filePath.c_str(), static_cast<int32_t>(IsFileExist(filePath)));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        std::ifstream file(filePath, std::ios::binary | std::ios::ate);
        if (!file.is_open()) {
            aicpusd_err("Open file failed, filePath=%s, reason=%s", filePath.c_str(), strerror(errno));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        const ScopeGuard fileGuard([&file]() { (void)file.close(); });
        std::streamsize size = file.tellg();
        if (static_cast<uint64_t>(size) > MAX_FILE_SIZE) {
            aicpusd_err("The file size is large than max file size(200MB), size=%luBytes", static_cast<uint64_t>(size));
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        file.seekg(0, std::ios::beg);
        std::vector<char_t> buffer = {};
        buffer.resize(size);
        file.read(&buffer[0], size);

        hashInfo.hashValue = GetQuickHash(buffer.data(), size);
        hashInfo.fileSize = size;
        hashInfo.filePath = filePath;

        return AICPU_SCHEDULE_OK;
    }

    void HashCalculator::AddHashInfoToCache(const FileHashInfo &hashInfo)
    {
        cache_.emplace_back(hashInfo);
        aicpusd_info("Add file %s to cache, size=%lu, hash=%lu", hashInfo.filePath.c_str(),
                     hashInfo.fileSize, hashInfo.hashValue);
    }

    bool HashCalculator::IsFileInCache(const std::string &filePath) const
    {
        for (const auto &hashInfo : cache_) {
            if (filePath == hashInfo.filePath) {
                return true;
            }
        }

        return false;
    }

    uint64_t HashCalculator::GetQuickHash(const void *data, const size_t size) const
    {
        /*
        * Using the FNV-1a algorithm for hash computation offers faster speed.
        * Here, it is solely used to record whether files are consistent and does not involve security scenarios.
        * In the event of a hash collision, the worst consequence would merely be saving an additional copy of a file.
        */
        const uint8_t* bytes = static_cast<const uint8_t*>(data);
        const uint64_t prime = 1099511628211UL;
        uint64_t hash = 14695981039346656037UL;

        constexpr size_t parallelNum = 8UL;
        size_t i = 0UL;
        for (; i + parallelNum <= size; i += parallelNum) {
            hash ^= bytes[i];
            hash *= prime;
            hash ^= bytes[i + 1UL];
            hash *= prime;
            hash ^= bytes[i + 2UL];
            hash *= prime;
            hash ^= bytes[i + 3UL];
            hash *= prime;
            hash ^= bytes[i + 4UL];
            hash *= prime;
            hash ^= bytes[i + 5UL];
            hash *= prime;
            hash ^= bytes[i + 6UL];
            hash *= prime;
            hash ^= bytes[i + 7UL];
            hash *= prime;
        }

        for (; i < size; i++) {
            hash ^= bytes[i];
            hash *= prime;
        }

        return hash;
    }

    int32_t HashCalculator::GetFileNameInDir(std::vector<std::string> &file_names) const
    {
        const std::string dirPath = soRootPath_ + CP_CUSTOM_SO_LIB_NAME;
        DIR *dir = opendir(dirPath.c_str());
        if (dir == nullptr) {
            aicpusd_run_warn("Open dir failed, path=%s, reason=%s", dirPath.c_str(), strerror(errno));
            return AICPU_SCHEDULE_OK;
        }

        dirent *entry = nullptr;
        while ((entry = readdir(dir)) != nullptr)
        {
            if (entry->d_type == DT_REG) {
                file_names.emplace_back(entry->d_name);
            }
        }

        const int32_t ret = closedir(dir);
        if (ret != 0) {
            aicpusd_warn("Close dir failed, ret=%d, path=%s, reason=%s", ret, dirPath.c_str(), strerror(errno));
        }

        return AICPU_SCHEDULE_OK;
    }

    bool HashCalculator::IsFileExist(const std::string &filePath) const
    {
        struct stat st = {};
        return (stat(filePath.c_str(), &st) == 0);
    }

    bool HashCalculator::IsRegularFile(const std::string &filePath) const
    {
        struct stat st = {};
        if (stat(filePath.c_str(), &st) != 0) {
            return false;
        }

        return S_ISREG(st.st_mode);
    }

    void CustSoFileLock::InitFileLocker(const std::string &filePath)
    {
        locker_ = open(filePath.c_str(), O_RDONLY);
        if (locker_ < 0) {
            aicpusd_run_warn("Open file locker may not exist, path=%s, reason=%s", filePath.c_str(), strerror(errno));
        }

        aicpusd_info("Init cust so file locker success, path=%s, fd=%d", filePath.c_str(), locker_);
    }

    void CustSoFileLock::LockFileLocker() const
    {
        if (locker_ < 0) {
            return;
        }

        const int32_t ret = flock(locker_, LOCK_EX);
        if (ret != 0) {
            aicpusd_err("Lock write file lock failed, reason=%s", strerror(errno));
        }
    }

    void CustSoFileLock::UnlockFileLocker() const
    {
        if (locker_ < 0) {
            return;
        }

        const int32_t ret = flock(locker_, LOCK_UN);
        if (ret != 0) {
            aicpusd_err("Unlock file lock failed, reason=%s", strerror(errno));
        }
    }
}