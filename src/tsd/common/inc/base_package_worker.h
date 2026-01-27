/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASE_PACKAGE_WORKER_H
#define TSD_BASE_PACKAGE_WORKER_H

#include <chrono>
#include <string>
#include <mutex>
#include <sstream>
#include <map>
#include "tsd/status.h"
#include "inc/log.h"
#include "inc/internal_api.h"
#include "inc/tsd_feature_ctrl.h"


namespace tsd {
using TimePoint = std::chrono::high_resolution_clock::time_point;

struct PackageWorkerParas {
    uint32_t deviceId;
    uint32_t vfId;

    PackageWorkerParas() : deviceId(0U), vfId(0U) {};
    PackageWorkerParas(const uint32_t devId, const uint32_t vfid) : deviceId(devId), vfId(vfid) {};

    std::string DebugString() const
    {
        std::stringstream oss;
        oss << "Package worker parameters, "
            << "deviceId=" << deviceId << ", "
            << "vfId=" << vfId;
 
        return oss.str();
    }
};
 
class BasePackageWorker {
public:
    explicit BasePackageWorker(const PackageWorkerParas paras) : deviceId_(paras.deviceId), vfId_(paras.vfId),
                                                                 uniqueVfId_(CalcUniqueVfId(paras.deviceId, paras.vfId)),
                                                                 originPackagePath_(), decomPackagePath_(),
                                                                 packageMtx_(), isVfMode_(false), isAsanMode_(false),
                                                                 originPackageSize_(0UL), checkCode_(0UL),
                                                                 decompressTime_()
    {
        isVfMode_ = FeatureCtrl::IsVfMode(deviceId_, vfId_);
    };
    virtual ~BasePackageWorker() {};

    virtual TSD_StatusT LoadPackage(const std::string &packagePath, const std::string &packageName) = 0;
    virtual TSD_StatusT UnloadPackage() = 0;
    virtual uint64_t GetPackageCheckCode();

    inline void ClearPackageCheckCode()
    {
        const std::lock_guard<std::mutex> lk(packageMtx_);
        checkCode_ = 0UL;
        return;
    }

    inline void SetAsanMode(bool mode)
    {
        const std::lock_guard<std::mutex> lk(packageMtx_);
        isAsanMode_ = mode;
        return;
    }

    virtual void GetAllPackageHashCode(std::map<std::string, std::string> &pkgHashMap)
    {
        (void)(pkgHashMap);
        return;
    }

    virtual std::string GetProcessedPkgHashCode(const std::string &pkgName)
    {
        (void)(pkgName);
        return "";
    }

protected:
    struct PackagePath {
        std::string path;
        std::string name;
        std::string realPath;

        PackagePath() : path(""), name(""), realPath("") {};
        PackagePath(const std::string &packagePath, const std::string &packageName) : path(packagePath),
                                                                                      name(packageName),
                                                                                      realPath("") {
            if (path.back() != '/') {
                path.append("/");
            }
            realPath = path + name;
        };

        void Clear()
        {
            path.clear();
            name.clear();
            realPath.clear();

            return;
        }
    };

    virtual void PreProcessPackage(const std::string &packagePath, const std::string &packageName);
    void DefaultPreProcessPackage(const std::string &packagePath, const std::string &packageName);
    virtual void SetDecompressPackagePath() = 0;
    virtual bool IsNeedLoadPackage();
    virtual TSD_StatusT MoveOriginPackageToDecompressDir() const;
    virtual std::string GetMovePackageToDecompressDirCmd() const = 0;
    virtual TSD_StatusT DecompressPackage() const;
    virtual std::string GetDecompressPackageCmd() const = 0;
    virtual TSD_StatusT PostProcessPackage();
    virtual void Clear();
    void DefaultClear();
    virtual bool IsNeedUnloadPackage();

    inline uint64_t GetCheckCode() const
    {
        return checkCode_;
    }

    inline TimePoint GetDecompressTime() const
    {
        return decompressTime_;
    }

    inline void SetCheckCode(const uint64_t checkCode)
    {
        checkCode_ = checkCode;

        return;
    }

    inline void SetOriginPackageSize(const uint64_t packageSize)
    {
        originPackageSize_ = packageSize;

        return;
    }

    inline uint64_t GetOriginPackageSize() const
    {
        return originPackageSize_;
    }

    inline void SetOriginPackagePath(const std::string &path, const std::string &fileName)
    {
        originPackagePath_ = PackagePath(path, fileName);

        return;
    }

    inline void SetDecompressTimeToNow()
    {
        decompressTime_ = std::chrono::high_resolution_clock::now();

        return;
    }

    inline bool IsVfMode() const
    {
        return isVfMode_;
    }

    inline bool IsAsanMode() const
    {
        return isAsanMode_;
    }

    const uint32_t deviceId_;
    const uint32_t vfId_;
    const uint32_t uniqueVfId_;
    PackagePath originPackagePath_; // Path where the package is first uploaded to the device, mostly is the hdcd dir.
    PackagePath decomPackagePath_; // Path where the package is move to and wait for decompress.
    std::mutex packageMtx_;

private:
    bool isVfMode_;
    bool isAsanMode_;
    uint64_t originPackageSize_;
    uint64_t checkCode_;
    TimePoint decompressTime_;
};

} // namespace tsd

#endif // TSD_BASE_PACKAGE_WORKER_H