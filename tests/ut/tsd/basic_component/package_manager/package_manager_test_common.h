/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_MANAGER_TEST_COMMON_H
#define TSD_PACKAGE_MANAGER_TEST_COMMON_H

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"

#define private public
#define protected public
#include "inc/process_mode_manager.h"
#include "package_manager.h"
#include "package_process_config.h"
#include "plugin_pkg_version.h"
#include "platform_manager_v2.h"
#include "tsd_hdc_client.h"
#include "weak_ascend_hal.h"
#include "common_util_func.h"
#undef private
#undef protected

namespace tsdtest {

constexpr int deviceId = 0;
constexpr int32_t PROCESS_MODE = 0;

class PackageManagerComponentTest : public testing::Test {
protected:
    void SetUp() override
    {
        savedRunningMode_ = tsd::ClientManager::g_runningMode;
        ascendAicpuPathEnv_ = std::make_unique<tsd::ScopedEnvVar>("ASCEND_AICPU_PATH");
        packageProcessConfig_ = tsd::PackageProcessConfig::GetInstance();
        savedConfigMap_ = packageProcessConfig_->configMap_;
        savedHostPluginVersions_ = packageProcessConfig_->hostPluginVersions_;
        savedHashCode_ = packageProcessConfig_->hashCode_;
        savedFinishParse_ = packageProcessConfig_->finishParse_;
        ClearPackageProcessConfig();

        std::string mode("PROCESS_MODE");
        tsd::ClientManager::SetRunMode(mode);
        MOCKER_CPP(&tsd::ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
    }

    void TearDown() override
    {
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreSharedState();
            throw;
        }
        GlobalMockObject::reset();
        RestoreSharedState();
    }

private:
    void ClearPackageProcessConfig()
    {
        packageProcessConfig_->configMap_.clear();
        packageProcessConfig_->hostPluginVersions_.clear();
        packageProcessConfig_->hashCode_.clear();
        packageProcessConfig_->finishParse_ = false;
    }

    void RestoreSharedState()
    {
        packageProcessConfig_->configMap_ = savedConfigMap_;
        packageProcessConfig_->hostPluginVersions_ = savedHostPluginVersions_;
        packageProcessConfig_->hashCode_ = savedHashCode_;
        packageProcessConfig_->finishParse_ = savedFinishParse_;
        tsd::ClientManager::g_runningMode = savedRunningMode_;
        ascendAicpuPathEnv_.reset();
    }

    tsd::RunningMode savedRunningMode_ = tsd::RunningMode::UNSET_MODE;
    tsd::PackageProcessConfig* packageProcessConfig_ = nullptr;
    std::map<std::string, tsd::PackConfDetail> savedConfigMap_;
    std::map<std::string, tsd::PluginPkgVersion> savedHostPluginVersions_;
    std::string savedHashCode_;
    bool savedFinishParse_ = false;
    std::unique_ptr<tsd::ScopedEnvVar> ascendAicpuPathEnv_;
};

class StubPackageDeviceComm : public tsd::DeviceComm {
public:
    explicit StubPackageDeviceComm(uint32_t devId)
        : tsd::DeviceComm(devId, tsd::DeviceCommType::HDC), inspector_(std::make_shared<tsd::VersionVerify>())
    {}

    tsd::TSD_StatusT CommInit(const uint32_t, const bool) override { return commInitRet_; }
    tsd::TSD_StatusT CommCreateSession(uint32_t& sid) override
    {
        sid = sessionIdStub_;
        return commCreateSessionRet_;
    }
    void CommDestroy() override { ++destroyCount_; }
    tsd::TSD_StatusT CommRecvData(const uint32_t, const bool, const uint32_t) override
    {
        ++recvCount_;
        return commRecvDataRet_;
    }
    tsd::TSD_StatusT CommGetConctStatus(int32_t& status) override
    {
        status = sessStat_;
        return commGetConctStatusRet_;
    }
    tsd::TSD_StatusT CommSendMsg(const uint32_t, const tsd::HDCMessage& msg) override
    {
        ++sendCount_;
        lastMsg_ = msg;
        return commSendMsgRet_;
    }
    tsd::TSD_StatusT CommGetVersionVerify(const uint32_t, std::shared_ptr<tsd::VersionVerify>& verify) override
    {
        verify = inspector_;
        return commGetVersionVerifyRet_;
    }

    tsd::TSD_StatusT commInitRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commCreateSessionRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commRecvDataRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commGetConctStatusRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commSendMsgRet_ = tsd::TSD_OK;
    tsd::TSD_StatusT commGetVersionVerifyRet_ = tsd::TSD_OK;
    uint32_t sessionIdStub_ = 1U;
    int32_t sessStat_ = 0;
    int destroyCount_ = 0;
    int sendCount_ = 0;
    int recvCount_ = 0;
    tsd::HDCMessage lastMsg_;
    std::shared_ptr<tsd::VersionVerify> inspector_;
};

inline std::shared_ptr<StubPackageDeviceComm> InjectPackageStubComm(tsd::ProcessModeManager& manager, uint32_t devId)
{
    auto stub = std::make_shared<StubPackageDeviceComm>(devId);
    manager.commAgent_.devCommClient_ = stub;
    return stub;
}

} // namespace tsdtest

#endif // TSD_PACKAGE_MANAGER_TEST_COMMON_H
