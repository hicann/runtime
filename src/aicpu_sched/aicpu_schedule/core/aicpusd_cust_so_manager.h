/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_CUST_SO_MANAGER_H
#define CORE_AICPUSD_CUST_SO_MANAGER_H

#include <string>
#include <mutex>
#include "aicpu_context.h"
#include "aicpusd_common.h"
#include "aicpusd_info.h"

namespace AicpuSchedule {
    struct FileHashInfo {
        std::string filePath;
        uint64_t fileSize;
        uint64_t hashValue;
    };

    struct FileInfo {
        char_t *data;
        size_t size;
        std::string name;
    };

    class HashCalculator {
    public:
        HashCalculator() = default;
        ~HashCalculator() = default;
        bool GetSameFileInfo(const FileInfo &fileInfo, FileHashInfo &existedFileHashInfo);
        void SetSoRootPath(const std::string &soRootPath)
        {
            soRootPath_ = soRootPath;
        }
    private:
        void UpdateCache();
        bool GetSameHashFileFromCache(const uint64_t hashValue, FileHashInfo &existedFileHashInfo) const;
        int32_t GenerateFileHashInfo(const std::string &filePath, FileHashInfo &hashInfo) const;
        void AddHashInfoToCache(const FileHashInfo &hashInfo);
        bool IsFileInCache(const std::string &filePath) const;
        uint64_t GetQuickHash(const void *data, const size_t size) const;
        int32_t GetFileNameInDir(std::vector<std::string> &file_names) const;
        bool IsFileExist(const std::string &filePath) const;
        bool IsRegularFile(const std::string &filePath) const;

        std::vector<FileHashInfo> cache_ = {};
        std::string soRootPath_ = "";
    };

    class CustSoFileLock {
    public:
        CustSoFileLock() = default;
        ~CustSoFileLock() 
        {
            if (locker_ > 0) {
                (void)close(locker_);
            }
        }
        static CustSoFileLock &Instance();
        void InitFileLocker(const std::string &filePath);
        void LockFileLocker() const;
        void UnlockFileLocker() const;
        
    private:
        CustSoFileLock(const CustSoFileLock &) = delete;
        CustSoFileLock &operator=(const CustSoFileLock &) = delete;
        CustSoFileLock(CustSoFileLock &&) = delete;
        CustSoFileLock &&operator=(CustSoFileLock &&) = delete;

        int32_t locker_ = -1;
    };

    class AicpuCustSoManager {
    public:
        /**
         * @ingroup AicpuCustSoManager
         * @brief it is used to get instance of AicpuCustSoManager.
         * @return object of AicpuCustSoManager
         */
        static AicpuCustSoManager &GetInstance();

        /**
         * @ingroup AicpuCustSoManager
         * @brief it is used to init object of AicpuCustSoManager.
         * @param [in] mode aicpu run mode
         * @param [in] schedMode aicpu sched mode
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t InitAicpuCustSoManager(const aicpu::AicpuRunMode mode,
                                       const AicpuSchedMode schedMode);

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to check and create cust so from Buf.
         * @param [in] args: LoadOpFromBufArgs
         * @param [in|out] soName: real so name
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CheckAndCreateSoFile(const LoadOpFromBufArgs *const args, std::string &soName);

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to check and delete cust so.
         * @param [in] args: LoadOpFromBufArgs
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CheckAndDeleteSoFile(const LoadOpFromBufArgs *const args);

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to check and delete cust so dir.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CheckAndDeleteCustSoDir();

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to delete cust so dir.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t DeleteCustSoDir() const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to determine should support cust aicpu.
         * @return true: support, false: not support
         */
        bool IsSupportCustAicpu() const;

        inline std::string GetSoRootPath() const
        {
            return custSoRootPath_;
        }
    private:
        AicpuCustSoManager() : runMode_(aicpu::AicpuRunMode::THREAD_MODE) {};

        ~AicpuCustSoManager() = default;

        // not allow copy constructor and assignment operators
        AicpuCustSoManager(const AicpuCustSoManager &) = delete;

        AicpuCustSoManager &operator=(const AicpuCustSoManager &) = delete;

        AicpuCustSoManager(AicpuCustSoManager &&) = delete;

        AicpuCustSoManager &&operator=(AicpuCustSoManager &&) = delete;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to create cust so from Buf.
         * @param [in] fileInfo: the file info to generate file
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CreateSoFile(const FileInfo &fileInfo);

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to create cust so from Buf.
         * @param [in] fileInfo: the file info to generate file
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t DoCreateSoFile(const FileInfo &fileInfo);

        /**
         * @ingroup AicpuCustSoManager
         * @brief Get root path for cust aicpu so
         * @param [in] dirName: dir path name
         * @return  AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t GetDirForCustAicpuSo(std::string &dirName) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief Get path for cust aicpu so
         * @return  string: so dir path in pcie mode
         */
        std::string GetCustAicpuUserPath(const uint32_t uniqueVfId) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief Get path for cust aicpu so
         * @return  string: so dir path
         */
        std::string GetPathForCustAicpuRealSo() const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief Get path for cust aicpu so soft link
         * @return  string: soft link dir path
         */
        std::string GetPathForCustAicpuSoftLink() const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief Check so file is valid.
         * @param [in] soFullPath: full so path
         * @return  AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CheckSoFullPathValid(const std::string &soFullPath) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to check and make directory.
         * @param [in] dirName: the name to directory
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CheckOrMakeDirectory(const std::string &dirName) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to check if dir is empty.
         * @param [in] dirName: dir name
         * @return bool: true, false
         */
        bool CheckDirEmpty(const std::string &dirName) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to delete so.
         * @param [in] dirName: dir name
         * @param [in] soFullPath: so path
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t DeleteSoFile(const std::string &dirName, const std::string &soFullPath);

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to remove so.
         * @param [in] dirName: dir name
         * @param [in] soName: so name
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t RemoveSoFile(const std::string &dirName, const std::string &soFullPath) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to remove so.
         * @param [in] fileInfo: The file info to write so
         * @param [in] dirPath: The full path to write so
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t WriteBufToSoFile(const FileInfo &fileInfo, const std::string &dirPath) const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to create soft link to existed so.
         * @param [in] fileInfo: The file info to write so
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t CreateSoftLinkToSoFile(const std::string &softLinkPath, const std::string &existedSoPath);

        /**
         * @ingroup AicpuCustSoManager
         * @brief it use to check whether custSoDirName_ init.
         * @return bool: true, false
         */
        bool CheckCustSoPath() const;

        /**
         * @ingroup AicpuCustSoManager
         * @brief Generate the real so path
         * @return bool: true, false
         */
        std::string GenerateSoFullPath(const std::string &soName) const;

        // root path for cust so
        std::string custSoRootPath_;
        // dir name for cust so soft link
        std::string custSoDirName_;
        // mutex for so file and so dir
        std::mutex soFileMutex_;
        // aicpu run mode
        aicpu::AicpuRunMode runMode_;
        // aicpu sched mode
        AicpuSchedMode schedMode_;
        HashCalculator hashCalculator_;
        CustSoFileLock fileLocker_;
    };
}

#endif // CORE_AICPUSD_CUST_SO_MANAGER_H
