/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "device_comm_agent.h"
#undef protected
#undef private
#include "error_code.h"
#include "tsd_util_func.h"

using namespace tsd;

namespace {
class ConfigurableDeviceComm final : public DeviceComm {
public:
    explicit ConfigurableDeviceComm(uint32_t deviceId) : DeviceComm(deviceId, DeviceCommType::HDC) {}

    TSD_StatusT CommInit(uint32_t clientPid, bool isAdcEnv) override
    {
        ++initCount;
        receivedPid = clientPid;
        receivedAdcEnv = isAdcEnv;
        return initResult;
    }

    TSD_StatusT CommCreateSession(uint32_t& sessionId) override
    {
        ++createSessionCount;
        sessionId = configuredSessionId;
        return createSessionResult;
    }

    void CommDestroy() override { ++destroyCount; }

    TSD_StatusT CommRecvData(uint32_t sessionId, bool ignoreRecvErr, uint32_t timeout) override
    {
        ++recvCount;
        receivedSessionId = sessionId;
        receivedIgnoreRecvErr = ignoreRecvErr;
        receivedTimeout = timeout;
        return recvResult;
    }

    TSD_StatusT CommGetConctStatus(int32_t& sessStat) override
    {
        ++statusCount;
        sessStat = configuredStatus;
        return statusResult;
    }

    TSD_StatusT CommSendMsg(uint32_t sessionId, const HDCMessage&) override
    {
        ++sendCount;
        receivedSessionId = sessionId;
        return sendResult;
    }

    TSD_StatusT CommGetVersionVerify(uint32_t sessionId, std::shared_ptr<VersionVerify>& inspector) override
    {
        ++versionCount;
        receivedSessionId = sessionId;
        inspector = configuredInspector;
        return versionResult;
    }

    TSD_StatusT initResult = TSD_OK;
    TSD_StatusT createSessionResult = TSD_OK;
    TSD_StatusT recvResult = TSD_OK;
    TSD_StatusT statusResult = TSD_OK;
    TSD_StatusT sendResult = TSD_OK;
    TSD_StatusT versionResult = TSD_OK;
    uint32_t configuredSessionId = 73U;
    int32_t configuredStatus = 9;
    std::shared_ptr<VersionVerify> configuredInspector = std::make_shared<VersionVerify>();
    uint32_t receivedPid = 0U;
    uint32_t receivedSessionId = 0U;
    uint32_t receivedTimeout = 0U;
    bool receivedAdcEnv = false;
    bool receivedIgnoreRecvErr = false;
    uint32_t initCount = 0U;
    uint32_t createSessionCount = 0U;
    uint32_t destroyCount = 0U;
    uint32_t recvCount = 0U;
    uint32_t statusCount = 0U;
    uint32_t sendCount = 0U;
    uint32_t versionCount = 0U;
};

drvError_t GetProcessSignFailed(process_sign*) { return DRV_ERROR_INVALID_VALUE; }
} // namespace

class DeviceCommAgentBehaviorUTest : public testing::Test {
protected:
    void SetUp() override
    {
        originalDeviceCommMap_ = *DeviceComm::DeviceCommMap();
        originalCreatorMap_ = *DeviceComm::CreatorMap();
    }

    void TearDown() override
    {
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            *DeviceComm::DeviceCommMap() = originalDeviceCommMap_;
            *DeviceComm::CreatorMap() = originalCreatorMap_;
            throw;
        }
        GlobalMockObject::reset();
        *DeviceComm::DeviceCommMap() = originalDeviceCommMap_;
        *DeviceComm::CreatorMap() = originalCreatorMap_;
    }

    std::shared_ptr<ConfigurableDeviceComm> InstallComm(DeviceCommAgent& agent, uint32_t deviceId)
    {
        auto comm = std::make_shared<ConfigurableDeviceComm>(deviceId);
        agent.devCommClient_ = comm;
        return comm;
    }

    std::shared_ptr<ConfigurableDeviceComm> RegisterComm(uint32_t deviceId)
    {
        auto comm = std::make_shared<ConfigurableDeviceComm>(deviceId);
        (*DeviceComm::DeviceCommMap())[KeyCompose(deviceId, DeviceCommType::HDC)] = comm;
        return comm;
    }

    std::map<uint64_t, std::shared_ptr<DeviceComm>> originalDeviceCommMap_;
    std::unordered_map<uint32_t, DeviceComm::CreatorFunc> originalCreatorMap_;
};

TEST_F(DeviceCommAgentBehaviorUTest, InitTsdClient_AlreadyInitialized_SkipsInitialization)
{
    DeviceCommAgent agent(41U);
    auto comm = InstallComm(agent, 41U);

    EXPECT_EQ(agent.InitTsdClient(true), TSD_OK);
    EXPECT_EQ(comm->initCount, 0U);
}

TEST_F(DeviceCommAgentBehaviorUTest, InitTsdClient_ProcessSignFails_ReturnsOpenFailed)
{
    DeviceCommAgent agent(42U);
    MOCKER(drvGetProcessSign).stubs().will(invoke(GetProcessSignFailed));

    EXPECT_EQ(agent.InitTsdClient(false), TSD_CLT_OPEN_FAILED);
    EXPECT_FALSE(agent.IsInit());
}

TEST_F(DeviceCommAgentBehaviorUTest, InitTsdClientRejectsDeviceIdAtUpperBoundary)
{
    DeviceCommAgent agent(MAX_DEVNUM_PER_HOST);

    EXPECT_EQ(agent.InitTsdClient(false), TSD_DEVICEID_ERROR);
    EXPECT_FALSE(agent.IsInit());
}

TEST_F(DeviceCommAgentBehaviorUTest, InitTsdClient_CommInitFails_ReleasesComm)
{
    constexpr uint32_t deviceId = 43U;
    DeviceCommAgent agent(deviceId);
    auto comm = RegisterComm(deviceId);
    comm->initResult = TSD_HDC_CLIENT_INIT_ERROR;

    EXPECT_EQ(agent.InitTsdClient(true), TSD_HDC_CLIENT_INIT_ERROR);
    EXPECT_EQ(comm->initCount, 1U);
    EXPECT_TRUE(comm->receivedAdcEnv);
    EXPECT_EQ(comm->destroyCount, 1U);
    EXPECT_FALSE(agent.IsInit());
}

TEST_F(DeviceCommAgentBehaviorUTest, InitTsdClient_ValidComm_CreatesSession)
{
    constexpr uint32_t deviceId = 44U;
    DeviceCommAgent agent(deviceId);
    auto comm = RegisterComm(deviceId);

    EXPECT_EQ(agent.InitTsdClient(false), TSD_OK);
    EXPECT_EQ(comm->initCount, 1U);
    EXPECT_EQ(comm->createSessionCount, 1U);
    EXPECT_EQ(agent.GetSessionId(), comm->configuredSessionId);
}

TEST_F(DeviceCommAgentBehaviorUTest, OperationsRejectMissingClient)
{
    DeviceCommAgent agent(45U);
    HDCMessage msg;
    std::shared_ptr<VersionVerify> inspector;

    EXPECT_EQ(agent.SendMsg(msg), TSD_INSTANCE_NOT_INITIALED);
    EXPECT_EQ(agent.RecvData(), TSD_INSTANCE_NOT_INITIALED);
    EXPECT_EQ(agent.GetVersionVerify(inspector), TSD_INSTANCE_NOT_INITIALED);
}

TEST_F(DeviceCommAgentBehaviorUTest, OperationsDelegateSessionAndArguments)
{
    DeviceCommAgent agent(46U);
    auto comm = InstallComm(agent, 46U);
    agent.tsdSessionId_ = 85U;
    HDCMessage msg;
    std::shared_ptr<VersionVerify> inspector;

    EXPECT_EQ(agent.SendMsg(msg), TSD_OK);
    EXPECT_EQ(agent.RecvData(true, 300U), TSD_OK);
    EXPECT_EQ(agent.GetVersionVerify(inspector), TSD_OK);
    EXPECT_EQ(comm->sendCount, 1U);
    EXPECT_EQ(comm->recvCount, 1U);
    EXPECT_EQ(comm->versionCount, 1U);
    EXPECT_EQ(comm->receivedSessionId, 85U);
    EXPECT_TRUE(comm->receivedIgnoreRecvErr);
    EXPECT_EQ(comm->receivedTimeout, 300U);
    EXPECT_EQ(inspector, comm->configuredInspector);
}

TEST_F(DeviceCommAgentBehaviorUTest, GetHdcConctStatusUsesEnvironmentWithoutClient)
{
    DeviceCommAgent agent(47U);
    int32_t status = -1;

    EXPECT_EQ(agent.GetHdcConctStatus(status, true), TSD_OK);
    EXPECT_EQ(status, HDC_SESSION_STATUS_CONNECT);
    EXPECT_EQ(agent.GetHdcConctStatus(status, false), TSD_OK);
    EXPECT_EQ(status, HDC_SESSION_STATUS_CLOSE);
}

TEST_F(DeviceCommAgentBehaviorUTest, GetHdcConctStatusDelegatesToClient)
{
    DeviceCommAgent agent(48U);
    auto comm = InstallComm(agent, 48U);
    int32_t status = -1;

    EXPECT_EQ(agent.GetHdcConctStatus(status, false), TSD_OK);
    EXPECT_EQ(status, comm->configuredStatus);
    EXPECT_EQ(comm->statusCount, 1U);
}

TEST_F(DeviceCommAgentBehaviorUTest, ReleaseDeviceConnectionIsIdempotent)
{
    DeviceCommAgent agent(49U);
    auto comm = InstallComm(agent, 49U);

    agent.ReleaseDeviceConnection();
    agent.ReleaseDeviceConnection();

    EXPECT_EQ(comm->destroyCount, 1U);
    EXPECT_FALSE(agent.IsInit());
}
