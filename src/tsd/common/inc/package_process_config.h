/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef TSD_PACKAGE_PROCESS_CONFIG_H
#define TSD_PACKAGE_PROCESS_CONFIG_H

#include <string>
#include <memory>
#include <map>
#include "tsd/status.h"
#include "inc/log.h"
#include "proto/tsd_message.pb.h"

namespace tsd {
enum class DeviceInstallPath {
    RUNTIME_PATH          = 0,
    OM_PATH               = 1,
    AICPU_KERNELS_PATH    = 2,
    COMPAT_PLUGIN_PATH    = 3,
    MAX_PATH              = 255
};
struct PackConfDetail {
    DeviceInstallPath decDstDir = DeviceInstallPath::MAX_PATH;
    std::string findPath = "";
    std::string hostTruePath = "";
    bool optionalFlag = false;
    bool validFlag = false;
    PackConfDetail() : decDstDir(DeviceInstallPath::MAX_PATH), findPath(""),
        hostTruePath(""), optionalFlag(false), validFlag(false) {
    }
    void PrintfInfo(const std::string &pkgName) {
        TSD_INFO("package:%s, decDstDir:%u, findPath:%s, hostTruePath:%s, optionalFlag:%u, validFlag:%u",
            pkgName.c_str(), static_cast<uint32_t>(decDstDir), findPath.c_str(), hostTruePath.c_str(),
            static_cast<uint32_t>(optionalFlag), static_cast<uint32_t>(validFlag));
    }
};

class PackageProcessConfig {
public:
    static PackageProcessConfig* GetInstance();
    PackConfDetail GetConfigDetailInfo(const std::string &srcPath);
    TSD_StatusT ParseConfigDataFromProtoBuf(const HDCMessage &hdcMsg);
    TSD_StatusT ParseConfigDataFromFile(const std::string &pkgTitle);
    void ConstructPkgConfigMsg(HDCMessage &hdcMsg) const;
    bool IsNeedToUpdateConfig(const HDCMessage &hdcMsg) const;
    bool IsConfigPackageInfo(const std::string &oriPkgName);
    void SetAllCommonSinkPackageHashCode(const HDCMessage &msg, HDCMessage &rspMsg) const;
    std::map<std::string, PackConfDetail> GetAllPackageConfigInfo() const
    {
        return configMap_;
    }
    TSD_StatusT GetPkgHostAndDeviceDstPath(const std::string &pkgName, std::string &orgFile, std::string &dstFile,
        const pid_t hostPid);
    std::string GetPackageHostTruePath(const std::string &pkgName);
private:
    bool SetConfigDataOnServer(const SinkPackageConfig &hdcConfig);
    bool SetConfigDataOnHost(std::ifstream &inFile, const std::string &fileName, const std::string &pkgTitle);
    std::string GetHostFilePath(const std::string &fileDir, const std::string &fileName) const;
    bool FillDetailNode(const std::string &decDstDir, const std::string &optionalFlag, const std::string &findPath,
        PackConfDetail &tempNode) const;
    void SetPkgHostTruePath(PackConfDetail &tempNode, const std::string &pkgName, const std::string &pkgTitle) const;
    PackageProcessConfig();
    ~PackageProcessConfig() = default;
    std::map<std::string, PackConfDetail> configMap_;
    std::mutex configMut_;
    bool finishParse_ = false;
    std::string hashCode_;
};
}
#endif // TSD_PACKAGE_PROCESS_CONFIG_H
