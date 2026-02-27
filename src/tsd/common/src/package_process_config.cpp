/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#include "inc/package_process_config.h"

#include <fstream>
#include <array>
#include <vector>
#include <unordered_set>
#include "inc/process_util_common.h"
#include "inc/package_worker.h"
#include "inc/internal_api.h"

namespace tsd {
    namespace {
        const std::string PACKAGE_CONFIG_NAME = "name:";
        const std::string COMMON_SINK_PKG_CONFIG_NAME = "ascend_package_load.ini";
        const std::string COMMON_SINK_PKG_CONFIG_DIR = "/conf/";
        const size_t MAX_CONFIG_NUM = 100UL;
    }

    PackageProcessConfig::PackageProcessConfig() : 
        configParaParseFuncMap_({
        {"install_path", &PackageProcessConfig::ParseInstallPath},
        {"optional", &PackageProcessConfig::ParseOptionalFlag},
        {"package_path", &PackageProcessConfig::ParsePackagePath},
        {"load_as_per_soc", &PackageProcessConfig::ParseLoadAsPerSocFlag}}) {}

    PackageProcessConfig* PackageProcessConfig::GetInstance()
    {
        static PackageProcessConfig instance;
        return &instance;
    }

    PackConfDetail PackageProcessConfig::GetConfigDetailInfo(const std::string &srcPath)
    {
        const std::lock_guard<std::mutex> lk(configMut_);
        const auto iter = configMap_.find(srcPath);
        if (iter != configMap_.end()) {
            return iter->second;
        } else {
            return PackConfDetail();
        }
    }

    bool PackageProcessConfig::SetConfigDataOnServer(const SinkPackageConfig &hdcConfig)
    {
        const std::string pkgName = hdcConfig.package_name();
        auto iter = configMap_.find(pkgName);
        if (iter != configMap_.end()) {
            iter->second.decDstDir = static_cast<DeviceInstallPath>(hdcConfig.file_dec_dst_dir());
            TSD_RUN_INFO("update package:%s config, dest dir:%u", pkgName.c_str(),
                static_cast<uint32_t>(iter->second.decDstDir));
        } else {
            if (configMap_.size() >= MAX_CONFIG_NUM) {
                TSD_RUN_WARN("current config map is full:%zu, threshold is:%zu", configMap_.size(), MAX_CONFIG_NUM);
                return true;
            }
            PackConfDetail tempNode;
            tempNode.decDstDir = static_cast<DeviceInstallPath>(hdcConfig.file_dec_dst_dir());
            tempNode.validFlag = true;
            tempNode.PrintfInfo(pkgName);
            try {
                configMap_[pkgName] = tempNode;
                TSD_RUN_INFO("insert package:%s config", pkgName.c_str());
            } catch (...) {
                TSD_ERROR("");
                return false;
            }
        }
        return true;
    }

    TSD_StatusT PackageProcessConfig::ParseConfigDataFromProtoBuf(const HDCMessage &hdcMsg)
    {
        const std::lock_guard<std::mutex> lk(configMut_);
        for (auto j = 0; j < hdcMsg.sink_pkg_con_list_size(); j++) {
            const SinkPackageConfig &hdcConfig = hdcMsg.sink_pkg_con_list(j);
            if (!SetConfigDataOnServer(hdcConfig)) {
                TSD_RUN_WARN("invalid config data");
                return TSD_START_FAIL;
            }
        }
        hashCode_ = hdcMsg.package_config_hash_code();
        TSD_RUN_INFO("package config has stored hash code:%s", hashCode_.c_str());
        return TSD_OK;
    }

    std::string PackageProcessConfig::GetHostFilePath(const std::string &fileDir, const std::string &fileName) const
    {
        std::string configPath;
        GetScheduleEnv("ASCEND_HOME_PATH", configPath);
        if (configPath.empty()) {
            configPath = "/usr/local/Ascend/latest/";
            TSD_INFO("ASCEND_HOME_PATH is not set, use default value[%s]", configPath.c_str());
        }

        configPath  = configPath + "/" + fileDir;
        if (access(configPath.c_str(), F_OK) != 0) {
            TSD_RUN_WARN("cannot get package path:%s, reason:%s", configPath.c_str(), SafeStrerror().c_str());
            return "";
        }
        configPath = configPath + fileName;
        if (access(configPath.c_str(), F_OK) != 0) {
            TSD_RUN_WARN("cannot get package file:%s, reason:%s", configPath.c_str(), SafeStrerror().c_str());
            return "";
        }
        TSD_INFO("get config path:%s", configPath.c_str());
        return configPath;
    }

    TSD_StatusT PackageProcessConfig::ParseConfigDataFromFile(const std::string &pkgTitle)
    {
        const std::string conFile = GetHostFilePath(COMMON_SINK_PKG_CONFIG_DIR, COMMON_SINK_PKG_CONFIG_NAME);
        if (access(conFile.c_str(), R_OK) != 0) {
            TSD_INFO("cannot access file:%s, errno=%d, strerror=%s", conFile.c_str(), errno, strerror(errno));
            return TSD_OK;
        }

        const std::lock_guard<std::mutex> lk(configMut_);
        if (finishParse_) {
            TSD_INFO("config already set, skip parse");
            return TSD_OK;
        }

        std::ifstream inFile(conFile);
        if (!inFile) {
            TSD_ERROR("open file:%s nok, errno=%d, strerror=%s", conFile.c_str(), errno, strerror(errno));
            return TSD_START_FAIL;
        }
        const ScopeGuard fileGuard([&inFile] () { inFile.close(); });
        
        std::string inputLine;
        size_t itCnt = 0;
        while (getline(inFile, inputLine) && itCnt < MAX_CONFIG_NUM) {
            TSD_INFO("read config data current line:%s", inputLine.c_str());
            std::string packageName;
            const size_t pos = inputLine.find(PACKAGE_CONFIG_NAME);
            if (pos != std::string::npos) {
                packageName = inputLine.substr(pos + PACKAGE_CONFIG_NAME.size());
                Trim(packageName);
                if (packageName.empty()) {
                    TSD_ERROR("valid package name is empty read line:%s", inputLine.c_str());
                    configMap_.clear();
                    return TSD_START_FAIL;
                }
                if (configMap_.find(packageName) == configMap_.end()) { 
                    if (!SetConfigDataOnHost(inFile, packageName, pkgTitle)) {
                        TSD_ERROR("package:%s config read but not store, clear all config", packageName.c_str());
                        configMap_.clear();
                        return TSD_START_FAIL;
                    }
                }
                itCnt++;
            }
        }
        finishParse_ = true;
        return TSD_OK;
    }

    bool PackageProcessConfig::ParseSinglePara(std::string &inputLine, PackConfDetail &tempNode,
                                               std::unordered_set<std::string> &finishedParseItemSet) const
    {
        const std::size_t pos = inputLine.find(":");
        if (pos == std::string::npos) {
            TSD_ERROR("invalid config line:%s", inputLine.c_str());
            return false;
        }
        std::string key = inputLine.substr(0, pos);
        Trim(key);
        std::string value = inputLine.substr(pos + 1);
        Trim(value);
        const auto iter = configParaParseFuncMap_.find(key);
        if (iter == configParaParseFuncMap_.end()) {
            TSD_ERROR("invalid config item:%s, line:%s", key.c_str(), inputLine.c_str());
            return false;
        }
        if ((this->*(iter->second))(value, tempNode)) {
            finishedParseItemSet.insert(key);
            return true;
        }
        return false;
    }

    bool PackageProcessConfig::ParseInstallPath(const std::string &para, PackConfDetail &tempNode) const
    {
        if ((para == "0") || (para == "1") || (para == "2") || (para == "3")) {
            int32_t result = 0;
           (void)TransStrToInt(para, result);
           tempNode.decDstDir = static_cast<DeviceInstallPath>(result);
        } else {
            TSD_ERROR("invalid installPath:%s", para.c_str());
            return false;
        }
        return true;
    }

    bool PackageProcessConfig::ParseOptionalFlag(const std::string &para, PackConfDetail &tempNode) const
    {
        if ((para == "true") || (para == "false")) {
            tempNode.optionalFlag = para == "true" ? true : false;
        } else {
            TSD_ERROR("invalid optionalFlag:%s", para.c_str());
            return false;
        }
        return true;
    }

    bool PackageProcessConfig::ParsePackagePath(const std::string &para, PackConfDetail &tempNode) const
    {
        if (!para.empty()) {
            tempNode.findPath = para;
        } else {
            TSD_ERROR("invalid packagePath:%s", para.c_str());
            return false;
        }
        return true;
    }

    bool PackageProcessConfig::ParseLoadAsPerSocFlag(const std::string &para, PackConfDetail &tempNode) const
    {
        if ((para == "true") || (para == "false")) {
            tempNode.loadAsPerSocFlag = para == "true" ? true : false;
        } else {
            TSD_ERROR("invalid loadAsPerSocFlag:%s", para.c_str());
            return false;
        }
        return true;
    }

    bool PackageProcessConfig::SetConfigDataOnHost(std::ifstream &inFile, const std::string &fileName,
                                                   const std::string &pkgTitle)
    {
        std::string inputLine;
        uint32_t itCnt = 0U;
        const uint32_t configItemNum = static_cast<uint32_t>(configParaParseFuncMap_.size());
        PackConfDetail tempNode = {};
        std::unordered_set<std::string> finishedParseItemSet;
        while ((itCnt < configItemNum) && (getline(inFile, inputLine))) {
            if (!ParseSinglePara(inputLine, tempNode, finishedParseItemSet)) {
                TSD_ERROR("parse config line failed:%s", inputLine.c_str());
                return false;
            }
            itCnt++;
        }
        if (finishedParseItemSet.size() != configItemNum) {
            TSD_ERROR("not all config items parsed");
            return false;
        }
        tempNode.validFlag = true;
        try {
            if(!SetPkgHostTruePath(tempNode, fileName, pkgTitle)) {
                TSD_ERROR("set package:%s host true path failed", fileName.c_str());
                return false;
            }
            configMap_[fileName] = tempNode;
            tempNode.PrintfInfo(fileName);
            TSD_RUN_INFO("insert package:%s config", fileName.c_str());
        } catch (...) {
            TSD_ERROR("insert package:%s config failed", fileName.c_str());
            return false;
        }
        return true;
    }

    void PackageProcessConfig::ConstructPkgConfigMsg(HDCMessage &hdcMsg) const
    {
        for (auto iter = configMap_.begin(); iter != configMap_.end(); iter++) {
            SinkPackageConfig *curConf = hdcMsg.add_sink_pkg_con_list();
            curConf->set_package_name(iter->first);
            curConf->set_file_dec_dst_dir(static_cast<uint32_t>(iter->second.decDstDir));
        }
        const std::string hashCode = ProcessUtilCommon::CalFileSha256HashValue(
            GetHostFilePath(COMMON_SINK_PKG_CONFIG_DIR, COMMON_SINK_PKG_CONFIG_NAME));
        hdcMsg.set_package_config_hash_code(hashCode);
        TSD_INFO("set config hash code:%s", hashCode.c_str());
    }

    bool PackageProcessConfig::IsNeedToUpdateConfig(const HDCMessage &hdcMsg) const
    {
        return (hdcMsg.package_config_hash_code() == hashCode_);
    }

    bool PackageProcessConfig::IsConfigPackageInfo(const std::string &oriPkgName)
    {
        const size_t pos = oriPkgName.find("_");
        if ((pos == std::string::npos) || (pos == oriPkgName.size() - 1)) {
            return false;
        }
        const std::string tempName = oriPkgName.substr(pos + 1);
        const std::lock_guard<std::mutex> lk(configMut_);
        auto iter = configMap_.find(tempName);
        if (iter != configMap_.end()) {
            return true;
        } else {
            return false;
        }
    }

    void PackageProcessConfig::SetAllCommonSinkPackageHashCode(const HDCMessage &msg, HDCMessage &rspMsg) const
    {
        const std::shared_ptr<PackageWorker> worker = PackageWorker::GetInstance(msg.device_id(),
            static_cast<uint32_t>(msg.vf_id()));
        std::map<std::string, std::string> tempPkgHashMap;
        worker->GetAllPackageHashCode(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK, tempPkgHashMap);
        for (auto iter = tempPkgHashMap.begin(); iter != tempPkgHashMap.end(); iter++) {
            SinkPackageHashCodeInfo *curConf = rspMsg.add_package_hash_code_list();
            curConf->set_package_name(iter->first);
            curConf->set_hash_code(iter->second);
        }
    }

    TSD_StatusT PackageProcessConfig::GetPkgHostAndDeviceDstPath(const std::string &pkgName, std::string &orgFile,
        std::string &dstFile, const pid_t hostPid)
    {
        const PackConfDetail detailInfo = GetConfigDetailInfo(pkgName);
        orgFile = detailInfo.hostTruePath;

        if (orgFile.empty()) {
            if (!detailInfo.optionalFlag) {
                TSD_ERROR("cannot find package:%s", pkgName.c_str());
                return TSD_INTERNAL_ERROR;
            } else {
                TSD_INFO("cannot find package:%s", pkgName.c_str());
                return TSD_OK;
            }
        }

        dstFile = dstFile + "/" + std::to_string(hostPid) + "_" + pkgName;
        TSD_RUN_INFO("get orgFile:%s, dstFile:%s", orgFile.c_str(), dstFile.c_str());
        return TSD_OK;
    }

    bool PackageProcessConfig::SetPkgHostTruePath(PackConfDetail &tempNode, const std::string &pkgName,
        const std::string &pkgTitle) const
    {
        const auto pos = pkgTitle.find(';');
        std::string packageTitle;
        std::string shortSocVersion;
        if (pos == std::string::npos) {
            packageTitle = pkgTitle;
        } else {
            packageTitle = pkgTitle.substr(0, pos);
            shortSocVersion = pkgTitle.substr(pos + 1);
        }
        std::string fileDirWholePath;
        if (pkgName.find("-aicpu_legacy.tar.gz") != std::string::npos) {
            fileDirWholePath = tempNode.findPath + "/" + packageTitle + "/aicpu/";
        } else {
            fileDirWholePath = tempNode.findPath + "/";
        }
        if (tempNode.loadAsPerSocFlag) {
            if (shortSocVersion.empty()) {
                TSD_ERROR("short_soc_version is empty, package:%s", pkgName.c_str());
                return false;
            } else {
                fileDirWholePath = fileDirWholePath + shortSocVersion + "/";
            }
        }
        tempNode.hostTruePath = GetHostFilePath(fileDirWholePath, pkgName);
        TSD_INFO("get package:%s host real path:%s", pkgName.c_str(), tempNode.hostTruePath.c_str());
        return true;
    }

    std::string PackageProcessConfig::GetPackageHostTruePath(const std::string &pkgName)
    {
        const std::lock_guard<std::mutex> lk(configMut_);
        auto iter = configMap_.find(pkgName);
        if (iter != configMap_.end()) {
            return iter->second.hostTruePath;
        } else {
            return "";
        }
    }
} // namespace tsd