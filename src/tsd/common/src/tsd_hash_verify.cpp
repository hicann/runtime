/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <fstream>
#include <stdio.h>
#include "inc/tsd_hash_verify.h"
#include "inc/tsd_event_interface.h"
#include "inc/tsd_feature_ctrl.h"
#include "inc/package_worker.h"
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"

namespace tsd {
    namespace {
        const std::string AICPUSD_HASH_NAME = "aicpu_scheduler=";
        const std::string CUSTAICPUSD_HASH_NAME = "aicpu_custom_scheduler=";
        const std::string HCCP_HASH_NAME = "hccp_service.bin=";
        const std::string QS_HASH_NAME = "queue_schedule=";
        constexpr const uint32_t HASH_FILE_MAX_LINE = 100U;
        constexpr const uint32_t SUB_PROC_HASH_INFO_MAX_LEN = 100U;
        constexpr size_t SUB_PROC_HASH_VALUE_LEN = 64UL;
        const std::string VAR_DIR_NAME = "/var/";
        const std::string SAND_BOX_DIR_NAME = "sand_box/";
        const std::string TENSORFLOW_SO_NAME = "libtensorflow.so";
        std::map<TsdSubProcessType, std::string> g_tsdSubprocHashList = {
            {TsdSubProcessType::PROCESS_COMPUTE, "aicpu_scheduler"},
            {TsdSubProcessType::PROCESS_CUSTOM_COMPUTE, "aicpu_custom_scheduler"},
            {TsdSubProcessType::PROCESS_HCCP, "hccp_service.bin"},
            {TsdSubProcessType::PROCESS_QUEUE_SCHEDULE, "queue_schedule "},
        };
    }

    TsdHashVerify* TsdHashVerify::GetInstance()
    {
        static TsdHashVerify instance;
        return &instance;
    }

    void TsdHashVerify::InsertOrUpdateHashValue(const std::string &readData, const HashMapType hashMapType)
    {
        std::size_t offsetEqualSign = readData.find("=");
        if (offsetEqualSign == std::string::npos) {
            TSD_RUN_WARN("hasf config data %s is not correct", readData.c_str());
            return;
        }
        TSD_INFO("read data:%s, offsetEqualSign:%d", readData.c_str(), offsetEqualSign);
        std::string keyStr = readData.substr(0U, offsetEqualSign);
        TSD_INFO("keyStr:%s", keyStr.c_str());
        std::string hashValueStr = readData.substr(offsetEqualSign + 1UL);
        TSD_INFO("hashValueStr:%s", hashValueStr.c_str());
        if ((!keyStr.empty()) && (!hashValueStr.empty())) {
            const uint32_t hashMapTypeTmp = static_cast<uint32_t>(hashMapType);
            auto iter = hashMap_[hashMapTypeTmp].find(keyStr);
            if (iter == hashMap_[hashMapTypeTmp].end()) {
                hashMap_[hashMapTypeTmp].insert(std::pair<std::string, std::string>(keyStr, hashValueStr));
                TSD_RUN_INFO("insert hash value key:%s, value:%s, hashMapType:%u", keyStr.c_str(), hashValueStr.c_str(), hashMapTypeTmp);
            } else {
                iter->second = hashValueStr;
                TSD_RUN_INFO("update hash value key:%s, value:%s, hashMapType:%u", keyStr.c_str(), hashValueStr.c_str(), hashMapTypeTmp);
            }
        }
    }

    void TsdHashVerify::VerifyHashMapPostProcess(const HashMapType hashMapType, const uint32_t deviceId, const uint32_t vfId) const
    {
        const std::shared_ptr<PackageWorker> worker = PackageWorker::GetInstance(deviceId, vfId);
        if (hashMapType == HashMapType::AICPU_KERNELS_HASHMAP) {
            const auto aicpuKernelWorker = worker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS);
            if (aicpuKernelWorker != nullptr) {
                aicpuKernelWorker->ClearPackageCheckCode();
            }
            const auto aicpuExtendWorker = worker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_EXTEND_PROCESS);
            if (aicpuExtendWorker != nullptr) {
                aicpuExtendWorker->ClearPackageCheckCode();
            }
            const auto ascendCppWorker = worker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_ASCENDCPP_PROCESS);
            if (ascendCppWorker != nullptr) {
                ascendCppWorker->ClearPackageCheckCode();
            }
            std::string removeCmd = "rm -rf /usr/lib64/aicpu_kernels/" + std::to_string(deviceId) + "/*";
            (void)PackSystem(removeCmd.c_str());
        }
    }

    std::string TsdHashVerify::GetRealFileName(const std::string fileName, const HashMapType hashMapType,
                                               const uint32_t uniqueVfId) const
    {
        if (hashMapType == HashMapType::AICPU_KERNELS_HASHMAP) {
            if (fileName == TENSORFLOW_SO_NAME) {
                return TsdPathMgr::BuildKernelSoPath(uniqueVfId).append(SAND_BOX_DIR_NAME).append(fileName);
            } else {
                return TsdPathMgr::BuildKernelSoPath(uniqueVfId).append(fileName);
            }
        } else {
            return "";
        }
    }

    bool TsdHashVerify::GetSubProcPreFixConfFromCompat(const TsdSubProcessType procType,
        std::string &filePreFix, std::string &valuePreFix) const
    {
        switch (procType) {
            case TsdSubProcessType::PROCESS_HCCP: {
                filePreFix = "hccp_compat";
                valuePreFix = HCCP_HASH_NAME;
                break;
            }
            case TsdSubProcessType::PROCESS_COMPUTE: {
                filePreFix = "aicpu_compat";
                valuePreFix = AICPUSD_HASH_NAME;
                break;
            }
            case TsdSubProcessType::PROCESS_CUSTOM_COMPUTE: {
                filePreFix = "aicpu_compat";
                valuePreFix = CUSTAICPUSD_HASH_NAME;
                break;
            }
            case TsdSubProcessType::PROCESS_QUEUE_SCHEDULE: {
                filePreFix = "aicpu_compat";
                valuePreFix = QS_HASH_NAME;
                break;
            }
            default: {
                break;
            }
        }
        if (filePreFix.empty()) {
            return false;
        }
        return true;
    }

    std::string TsdHashVerify::GetSubProcHashValueFromCompat(const TsdSubProcessType procType,
        const uint32_t uniqueVfId) const
    {
        std::string filePreFix;
        std::string valuePreFix;
        std::string hashValue;
        if (!GetSubProcPreFixConfFromCompat(procType, filePreFix, valuePreFix)) {
            return hashValue;
        }
        const std::string hashFile = TsdPathMgr::BuildCompatPluginPackageSoInstallPath(uniqueVfId) + filePreFix + 
        + "_bin_hash.cfg";

        std::ifstream ifs(hashFile, std::ifstream::in);
        if (!ifs.is_open()) {
            TSD_RUN_WARN("cannot open file[%s],reason[%s]", hashFile.c_str(), SafeStrerror().c_str());
            return hashValue;
        }
        std::string curline;
        uint32_t loopCnt = 0U;
        while ((std::getline(ifs, curline)) && (loopCnt < HASH_FILE_MAX_LINE)) {
            TSD_RUN_INFO("read data:%s", curline.c_str());
            if (strncmp(valuePreFix.c_str(), curline.c_str(), valuePreFix.length()) == 0) {
                hashValue = curline.substr(valuePreFix.length(), (curline.length() - valuePreFix.length()));
                TSD_RUN_INFO("get proc:%s, hash value:%s", valuePreFix.c_str(), hashValue.c_str());
                break;
            }
            loopCnt++;
        }
        ifs.close();
        return hashValue;
    }

    std::string TsdHashVerify::GetSubProcHashValue(const TsdSubProcessType procType, const uint32_t uniqueVfId)
    {
        std::string compatHashValue = GetSubProcHashValueFromCompat(procType, uniqueVfId);
        if (!compatHashValue.empty()) {
            return compatHashValue;
        }

        const auto it = g_tsdSubprocHashList.find(procType);
        if (it== g_tsdSubprocHashList.end()) {
            TSD_RUN_WARN("procType[%u] is not correct", static_cast<uint32_t>(procType));
            return "";
        }
        const std::string keyStr = it->second;
        const uint32_t hashMapTypeTmp = static_cast<uint32_t>(HashMapType::DRV_BASIC_HASHMAP);
        const std::lock_guard<std::mutex> lk(subProcHashMtx_);
        const auto iter = hashMap_[hashMapTypeTmp].find(keyStr);
        if (iter != hashMap_[hashMapTypeTmp].end()) {
            return iter->second;
        } else {
            return "";
        }
    }

    bool TsdHashVerify::VerifyHashValueOnce(const std::string fileName, const std::string hashValue, const HashMapType hashMapType,
                                            const uint32_t deviceId, const uint32_t vfId) const
    {
        const uint32_t uniqueVfId = CalcUniqueVfId(deviceId, vfId);
        const std::string realFileName = GetRealFileName(fileName, hashMapType, uniqueVfId);
        if (realFileName == "") {
            TSD_RUN_WARN("realFileName is empty");
            return true;
        }

        std::string cmd = "sha256sum " + realFileName;
        FILE *pip = popen(cmd.c_str(), "r");
        if (pip == nullptr) {
            TSD_RUN_WARN("Popen execute cmd[%s], return nullptr, error[%s]", cmd.c_str(), SafeStrerror().c_str());
            VerifyHashMapPostProcess(hashMapType, deviceId, vfId);
            return false;
        }

        const ScopeGuard popenGuarad([&pip]() {
            const auto ret = pclose(pip);
            if (ret == -1) {
                TSD_WARN("pclose failed, error[%s]", SafeStrerror().c_str());
            }
        });

        std::string queryHash = "";
        std::array<char_t, SUB_PROC_HASH_INFO_MAX_LEN> buffer;
        while (fgets(buffer.data(), static_cast<int32_t>(SUB_PROC_HASH_INFO_MAX_LEN), pip) != nullptr) {
            queryHash += buffer.data();
        }

        TSD_INFO("cmd:%s, queryHash:%s", cmd.c_str(), queryHash.c_str());
        if (queryHash.size() < SUB_PROC_HASH_VALUE_LEN) {
            TSD_ERROR("queryHash is less than %zu", SUB_PROC_HASH_VALUE_LEN);
            VerifyHashMapPostProcess(hashMapType, deviceId, vfId);
            return false;
        }
        if (strncmp(queryHash.c_str(), hashValue.c_str(), SUB_PROC_HASH_VALUE_LEN) == 0) {
            TSD_INFO("hash value verify ok, base:%s, cur:%s, name:%s", hashValue.c_str(), queryHash.c_str(),
                    fileName.c_str());
            return true;
        } else {
            TSD_ERROR("hash value compare error basevalue:%s, curvalue:%s, procfile:%s", hashValue.c_str(),
                    queryHash.c_str(), fileName.c_str());
            VerifyHashMapPostProcess(hashMapType, deviceId, vfId);
            return false;
        }
    }

    void TsdHashVerify::VerifyTsdHashMap(const HashMapType hashMapType, const uint32_t deviceId, const uint32_t vfId)
    {
        uint32_t hashMapTypeTmp = static_cast<uint32_t>(hashMapType);
        const std::lock_guard<std::mutex> lk(subProcHashMtx_);
        if (hashMap_[hashMapTypeTmp].size() == 0) {
            TSD_RUN_INFO("hash map is empty, skip to verify. hashMapType[%u]", hashMapType);
            return;
        }

        for (auto iter = hashMap_[hashMapTypeTmp].begin(); iter != hashMap_[hashMapTypeTmp].end(); iter++) {
            if (!VerifyHashValueOnce(iter->first, iter->second, hashMapType, deviceId, vfId)) {
                return;
            }
        }
    }

    void TsdHashVerify::ReadAndUpdateTsdHashValue(const std::string &hashFile, const HashMapType hashMapType)
    {
        const std::lock_guard<std::mutex> lk(subProcHashMtx_);
        std::ifstream ifs(hashFile, std::ifstream::in);
        if (!ifs.is_open()) {
            TSD_RUN_WARN("cannot open file[%s], error[%s]", hashFile.c_str(), SafeStrerror().c_str());
            return;
        }
        std::string curline;
        uint32_t loopCnt = 0U;
        while ((std::getline(ifs, curline)) && (loopCnt < HASH_FILE_MAX_LINE)) {
            TSD_INFO("read data:%s", curline.c_str());
            InsertOrUpdateHashValue(curline, hashMapType);
            loopCnt++;
        }
        ifs.close();
    }
}