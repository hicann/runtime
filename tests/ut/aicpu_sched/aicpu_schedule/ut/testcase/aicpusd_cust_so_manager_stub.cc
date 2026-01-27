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
#include "aicpusd_status.h"

namespace {
    // cust so root path: no longer CustAiCpuUser
    constexpr const char *CUSTOM_SO_ROOT_PATH = "/home/HwHiAiUser/";
    // prefix of cust so dir name
    constexpr const char *CUSTOM_SO_DIR_NAME_PREFIX = "cust_aicpu_";
    // pattern for custom so name
    constexpr const char *PATTERN_FOR_SO_NAME("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890-_.");
    // env variable name: custom aicpu kernel so path.
    // If modify the env name, please modify the same env name in ae_so_manager.cc
    constexpr const char *AICPU_CUSTOM_SO_PATH_ENV_VAR_NAME = "ASCEND_CUST_AICPU_KERNEL_CACHE_PATH";
}

namespace AicpuSchedule {

    AicpuCustSoManager &AicpuCustSoManager::GetInstance()
    {
        static AicpuCustSoManager instance;
        return instance;
    }

    int32_t AicpuCustSoManager::InitAicpuCustSoManager(const aicpu::AicpuRunMode runMode,
                                                       const AicpuSchedMode schedMode)
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckAndCreateSoFile(const LoadOpFromBufArgs * const args, std::string &soName)
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckAndDeleteSoFile(const LoadOpFromBufArgs * const args)
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckAndDeleteCustSoDir()
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CreateSoFile(const FileInfo &fileInfo)
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::DoCreateSoFile(const FileInfo &fileInfo)
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::GetDirForCustAicpuSo(std::string &dirName) const
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckSoFullPathValid(const std::string &soFullPath) const
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::CheckOrMakeDirectory(const std::string &dirName) const
    {
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustSoManager::DeleteCustSoDir() const
    {
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuCustSoManager::CheckDirEmpty(const std::string &dirName) const
    {
        return true;
    }

    int32_t AicpuCustSoManager::RemoveSoFile(const std::string &dirName, const std::string &soFullPath) const
    {
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuCustSoManager::CheckCustSoPath() const
    {
        return true;
    }

    bool HashCalculator::GetSameFileInfo(const FileInfo &fileInfo, FileHashInfo &existedFileHashInfo) {
        return true;
    }

    void HashCalculator::UpdateCache()
    {
        return;
    }

    bool HashCalculator::GetSameSizeFileFromCache(const size_t fileSize, FileHashInfo &existedFileHashInfo) const
    {
        return true;
    }

    bool HashCalculator::GetSameHashFileFromCache(const uint64_t hashValue, FileHashInfo &existedFileHashInfo) const
    {
        return true;
    }

    int32_t HashCalculator::GenerateFileHashInfo(const std::string &filePath, FileHashInfo &hashInfo) const
    {
        return AICPU_SCHEDULE_OK;
    }

    void HashCalculator::AddHashInfoToCache(const FileHashInfo &hashInfo)
    {
        return;
    }

    bool HashCalculator::IsFileInCache(const std::string &filePath) const
    {
        return true;
    }

    uint64_t HashCalculator::GetQuickHash(const void *data, const size_t size) const
    {
        return 0UL;
    }

    int32_t HashCalculator::GetFileNameInDir(std::vector<std::string> &file_names) const
    {
        return AICPU_SCHEDULE_OK;
    }

    bool HashCalculator::IsFileExist(const std::string &filePath) const
    {
        return true;
    }

    bool HashCalculator::IsRegularFile(const std::string &filePath) const
    {
        return true;
    }

    void CustSoFileLock::InitFileLocker(const std::string &filePath)
    {
        return;
    }

    void CustSoFileLock::LockFileLocker() const
    {
        return;
    }

    void CustSoFileLock::UnlockFileLocker() const
    {
        return;
    }
}
