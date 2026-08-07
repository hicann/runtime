/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"
#define private public
#define protected public
#include "inc/process_mode_manager.h"
#include "device_comm.h"
#include "tsd_hdc_client.h"
#include "weak_ascend_hal.h"
#include "env_internal_api.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace {
static const int deviceId = 0;
constexpr int32_t PROCESS_MODE = 0;
} // namespace
namespace {
int32_t g_Choice = 0;
int halQueryDevpidFake(struct halQueryDevpidInfo info, pid_t* dev_pid)
{
    *dev_pid = 22222;
    return 0;
}

struct queueInfoBuff {
    QueQueryQuesOfProcInfo qInfo[2];
};
drvError_t halQueueQueryFake(
    unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara* inPut, QueueQueryOutputPara* outPut)
{
    if (g_Choice == 1) {
        queueInfoBuff* queueInfoList = reinterpret_cast<queueInfoBuff*>(outPut->outBuff);
        outPut->outLen = sizeof(queueInfoBuff);
        queueInfoList->qInfo[0].qid = 10;
        queueInfoList->qInfo[0].attr = {1, 1, 1, 0};
        queueInfoList->qInfo[1].qid = 11;
        queueInfoList->qInfo[1].attr = {0, 0, 1, 0};
        return DRV_ERROR_NONE;
    }
    if (g_Choice == 2) {
        outPut->outLen = 1U;
        return DRV_ERROR_NONE;
    }
    if (g_Choice == 3) {
        queueInfoBuff* queueInfoList = reinterpret_cast<queueInfoBuff*>(outPut->outBuff);
        outPut->outLen = sizeof(queueInfoBuff);
        queueInfoList->qInfo[0].qid = 100000;
        queueInfoList->qInfo[0].attr = {1, 1, 1, 0};
        queueInfoList->qInfo[1].qid = 1000000;
        queueInfoList->qInfo[1].attr = {0, 0, 1, 0};
        return DRV_ERROR_NONE;
    }
    cout << "Wrong choice" << endl;
    return DRV_ERROR_NOT_EXIST;
}

} // namespace

namespace {
// 测试用 DeviceComm 桩：覆盖所有虚接口，返回值可在用例中按需配置。
// 由于 mockcpp 的 JmpOnlyApiHookImpl 无法对虚成员函数的 PMF 进行打桩
// （PMF 实际为 vtable 偏移而非函数地址，会触发 SIGSEGV），
// 因此通过子类化 + 注入到 ProcessModeManager.commAgent_.devCommClient_ 的方式替代。
class StubDeviceComm : public tsd::DeviceComm {
public:
    explicit StubDeviceComm(uint32_t devId)
        : tsd::DeviceComm(devId, tsd::DeviceCommType::HDC), inspector_(std::make_shared<tsd::VersionVerify>())
    {}

    tsd::TSD_StatusT CommInit(const uint32_t, const bool) override { return commInitRet_; }
    tsd::TSD_StatusT CommCreateSession(uint32_t& sid) override
    {
        sid = sessionIdStub_;
        return commCreateSessionRet_;
    }
    void CommDestroy() override { ++destroyCount_; }
    tsd::TSD_StatusT CommRecvData(const uint32_t, const bool, const uint32_t) override { return commRecvDataRet_; }
    tsd::TSD_StatusT CommGetConctStatus(int32_t& s) override
    {
        s = sessStat_;
        return commGetConctStatusRet_;
    }
    tsd::TSD_StatusT CommSendMsg(const uint32_t, const HDCMessage&) override { return commSendMsgRet_; }
    tsd::TSD_StatusT CommGetVersionVerify(const uint32_t, std::shared_ptr<tsd::VersionVerify>& v) override
    {
        v = inspector_;
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
    std::shared_ptr<tsd::VersionVerify> inspector_;
};

inline std::shared_ptr<StubDeviceComm> InjectStubComm(tsd::ProcessModeManager& pm, uint32_t devId)
{
    auto stub = std::make_shared<StubDeviceComm>(devId);
    pm.commAgent_.devCommClient_ = stub;
    return stub;
}
} // namespace

class TsdProcessControllerTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        g_Choice = 0;
        savedRunningMode_ = ClientManager::g_runningMode;
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
        cout << "Before TsdProcessControllerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After TsdProcessControllerTest" << endl;
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            g_Choice = 0;
            ClientManager::g_runningMode = savedRunningMode_;
            throw;
        }
        GlobalMockObject::reset();
        g_Choice = 0;
        ClientManager::g_runningMode = savedRunningMode_;
    }

    RunningMode savedRunningMode_ = RunningMode::UNSET_MODE;
};

TEST_F(TsdProcessControllerTest, OpenProcess_AdcQueueSetupFails_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    MOCKER_CPP(&TsdProcessController::CheckNeedToOpen).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageLoader::LoadPackageConfigInfoToDevice).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageLoader::LoadSysOpKernel).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::SendOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&PackageLoader::LoadPackageToDeviceByConfig).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(true));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&TsdProcessController::ProcessQueueForAdc).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.OpenProcess(1);
    EXPECT_EQ(ret, 1);
}

TEST_F(TsdProcessControllerTest, UpdateProfilingConf_ProcessNotStarted_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.UpdateProfilingConf(1);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdProcessControllerTest, CheckNeedToOpen_RankOneAndProcessStopped_ReturnsTrue)
{
    ProcessModeManager processModeManager(deviceId, 0);
    TsdStartStatusInfo startInfo;
    uint32_t rankSize = 1;
    bool ret = processModeManager.tsdCtrl_.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdProcessControllerTest, CheckNeedToOpen_RankOneAndProcessStarted_ReturnsFalse)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    TsdStartStatusInfo startInfo;
    uint32_t rankSize = 1;
    bool ret = processModeManager.tsdCtrl_.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdProcessControllerTest, CheckNeedToOpen_RankTwoAndProcessesStopped_ReturnsTrue)
{
    ProcessModeManager processModeManager(deviceId, 0);
    TsdStartStatusInfo startInfo;
    uint32_t rankSize = 2;
    bool ret = processModeManager.tsdCtrl_.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, true);
}

TEST_F(TsdProcessControllerTest, CheckNeedToOpen_RankTwoAndProcessesStarted_ReturnsFalse)
{
    ProcessModeManager processModeManager(deviceId, 0);
    TsdStartStatusInfo startInfo;
    processModeManager.tsdCtrl_.tsdStartStatus_.startCp_ = true;
    processModeManager.tsdCtrl_.tsdStartStatus_.startHccp_ = true;
    uint32_t rankSize = 2;
    bool ret = processModeManager.tsdCtrl_.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, false);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_DevicePidQueryUnavailable_ReturnsError)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_QueueQueryFails_ReturnsError)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(0));
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(returnValue(100)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_NoQueues_ReturnsOk)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(0));
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_GrantRetriesThenSucceeds_ReturnsOk)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    g_Choice = 1;
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(invoke(halQueueQueryFake));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_DevicePidDriverError_RemainsFailed)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    g_Choice = 2;
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(invoke(halQueueQueryFake));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_InvalidQueue_RemainsFailed)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    g_Choice = 3;
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(invoke(halQueueQueryFake));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(TsdProcessControllerTest, SyncQueueAuthority_QueueQueryUnsupported_ReturnsOk)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));
    MOCKER(halQueryDevpid).stubs().will(returnValue(0xfffe));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.tsdCtrl_.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(TsdProcessControllerTest, WaitRsp_CloseSocketAndIgnoreCloseError_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectStubComm(processModeManager, deviceId);
    stub->commRecvDataRet_ = TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED;
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdProcessControllerTest, WaitRsp_E30003_ReturnsSubprocessLimitError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.sharedCtx_.startOrStopFailCode = "E30003";
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT);
}

TEST_F(TsdProcessControllerTest, WaitRsp_E30004_ReturnsBinaryDamagedError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.sharedCtx_.startOrStopFailCode = "E30004";
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_SUBPROCESS_BINARY_FILE_DAMAGED);
}

TEST_F(TsdProcessControllerTest, WaitRsp_E30006_ReturnsOppVerificationError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.sharedCtx_.startOrStopFailCode = "E30006";
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_VERIFY_OPP_FAIL);
}

TEST_F(TsdProcessControllerTest, WaitRsp_E30007_ReturnsCgroupError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.sharedCtx_.startOrStopFailCode = "E30007";
    tsd::TSD_StatusT ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_ADD_AICPUSD_TO_CGROUP_FAILED);
}

TEST_F(TsdProcessControllerTest, ConstructCloseMsg_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    auto ret = processModeManager.tsdCtrl_.ConstructCloseMsg(msg);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(TsdProcessControllerTest, ProcessQueueForAdc_AuthoritySyncFails_ReturnsError)
{
    MOCKER_CPP(&ClientManager::IsAdcEnv).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::GetPlatInfoMode).stubs().will(returnValue(static_cast<uint32_t>(ModeType::OFFLINE)));
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&TsdProcessController::SyncQueueAuthority).stubs().will(returnValue(1));
    auto ret = processModeManager.tsdCtrl_.ProcessQueueForAdc();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(TsdProcessControllerTest, SendUpdateProfilingMsg_CommunicationSucceeds_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    const auto ret = processModeManager.tsdCtrl_.SendUpdateProfilingMsg(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(TsdProcessControllerTest, SendUpdateProfilingMsg_CommunicationFails_ReturnsProfilingError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectStubComm(processModeManager, deviceId);
    stub->commSendMsgRet_ = TSD_INTERNAL_ERROR;
    const auto ret = processModeManager.tsdCtrl_.SendUpdateProfilingMsg(0);
    EXPECT_EQ(ret, TSD_CLT_UPDATE_PROFILING_FAILED);
}

TEST_F(TsdProcessControllerTest, WaitRsp_DeviceResponseFailsWithoutMessage_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(10, false, true);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

TEST_F(TsdProcessControllerTest, WaitRsp_DeviceResponseFailsWithMessage_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.sharedCtx_.errMsg = "testlog";
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(10, false, true);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

TEST_F(TsdProcessControllerTest, SendCloseMsg_CommunicationSucceeds_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    const auto ret = processModeManager.tsdCtrl_.SendCloseMsg();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(TsdProcessControllerTest, SendCloseMsg_MessageConstructionFails_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::ConstructCloseMsg)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    const auto ret = processModeManager.tsdCtrl_.SendCloseMsg();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(TsdProcessControllerTest, SendCloseMsg_CommunicationFails_ReturnsCloseFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.tsdCtrl_.SendCloseMsg();
    EXPECT_EQ(ret, TSD_CLT_CLOSE_FAILED);
}

TEST_F(TsdProcessControllerTest, UpdateProfilingConf_SendAndWaitSucceed_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::SendUpdateProfilingMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    const auto ret = processModeManager.tsdCtrl_.UpdateProfilingConf(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(TsdProcessControllerTest, UpdateProfilingConf_SendFails_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::SendUpdateProfilingMsg)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    const auto ret = processModeManager.tsdCtrl_.UpdateProfilingConf(0);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(TsdProcessControllerTest, UpdateProfilingConf_WaitFails_ReturnsError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&TsdProcessController::SendUpdateProfilingMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.tsdCtrl_.UpdateProfilingConf(0);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(TsdProcessControllerTest, InitQs_AlreadyStarted_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.tsdCtrl_.tsdStartStatus_.startQs_ = true;
    InitFlowGwInfo info = {"test", 0U};
    const auto ret = processModeManager.tsdCtrl_.InitQs(&info);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(TsdProcessControllerTest, InitTsdClient_DeviceIdOutOfRange_ReturnsDeviceIdError)
{
    ProcessModeManager processModeManager(128U, 0);
    EXPECT_EQ(processModeManager.tsdCtrl_.InitTsdClient(), TSD_DEVICEID_ERROR);
}

namespace {
const char* g_mockAscendAicpuPath = nullptr;

char* MmSysGetEnvAscendAicpuPathStub(mmEnvId id)
{
    if (id == MM_ENV_ASCEND_AICPU_PATH && g_mockAscendAicpuPath != nullptr) {
        return const_cast<char*>(g_mockAscendAicpuPath);
    }
    return nullptr;
}

void SeedOpenMsgInputs(ProcessModeManager& mgr)
{
    mgr.logicDeviceId_ = 10U;
    mgr.tsdCtrl_.rankSize_ = 4U;
    mgr.profilingMode_ = ProfilingMode::PROFILING_OPEN;
    mgr.logLevel_ = "002";
    mgr.ccecpuLogLevel_ = "001";
    mgr.aicpuLogLevel_ = "003";
    mgr.tsdCtrl_.aicpuDeviceMode_ = 7U;
    mgr.commAgent_.procSign_.tgid = static_cast<pid_t>(1234);
    (void)strncpy_s(
        mgr.commAgent_.procSign_.sign, sizeof(mgr.commAgent_.procSign_.sign), "sign-abcd", sizeof("sign-abcd"));
    mgr.GetPackageManager().ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] =
        0xAAU;
    mgr.GetPackageManager()
        .ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 0xBBU;
    mgr.GetPackageManager().ctx_.hostCheckCode[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)] =
        0xCCU;
    mgr.SyncSharedCtxLogLevels();
    mgr.sharedCtx_.logicDeviceId = 10U;
    mgr.sharedCtx_.profilingMode = static_cast<uint32_t>(ProfilingMode::PROFILING_OPEN);
}
} // namespace

TEST_F(TsdProcessControllerTest, ConstructOpenMsg_DelegatesToBuilder)
{
    g_mockAscendAicpuPath = "/home/test/aicpu";
    MOCKER(mmSysGetEnv).stubs().will(invoke(MmSysGetEnvAscendAicpuPathStub));

    ProcessModeManager pm(deviceId, 0);
    SeedOpenMsgInputs(pm);

    HDCMessage hdcMsg;
    TsdStartStatusInfo info{true, true, false};
    EXPECT_EQ(pm.tsdCtrl_.ConstructOpenMsg(hdcMsg, info), tsd::TSD_OK);

    EXPECT_EQ(hdcMsg.device_id(), 10U % PER_OS_CHIP_NUM);
    EXPECT_EQ(hdcMsg.real_device_id(), 10U);
    EXPECT_EQ(hdcMsg.rank_size(), 4U);
    EXPECT_TRUE(hdcMsg.start_hccp());
    EXPECT_TRUE(hdcMsg.start_cp());
    EXPECT_EQ(hdcMsg.device_mode(), 7U);
    EXPECT_EQ(hdcMsg.check_code(), 0xAAU);
    EXPECT_EQ(hdcMsg.extendpkg_check_code(), 0xBBU);
    EXPECT_EQ(hdcMsg.ascendcpppkg_check_code(), 0xCCU);
    EXPECT_EQ(hdcMsg.type(), HDCMessage::TSD_START_PROC_MSG);
    EXPECT_EQ(hdcMsg.proc_sign_pid().proc_pid(), 1234U);
    EXPECT_EQ(hdcMsg.ascend_aicpu_path().ascend_aicpu_path(), "/home/test/aicpu");

    g_mockAscendAicpuPath = nullptr;
}

TEST_F(TsdProcessControllerTest, ConstructOpenMsg_NoPluginVersion_OmitsPluginInfo)
{
    auto* const config = PackageProcessConfig::GetInstance();
    config->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    ProcessModeManager pm(deviceId, 0);
    HDCMessage hdcMsg;
    TsdStartStatusInfo info{true, true, false};

    EXPECT_EQ(pm.tsdCtrl_.ConstructOpenMsg(hdcMsg, info), tsd::TSD_OK);
    EXPECT_EQ(hdcMsg.device_plugin_versions_size(), 0);

    config->hostPluginVersions_.clear();
}

// ConstructCloseMsg 经 BuildBaseMessageContext + HdcMessageBuilder::BuildClose
// 后，应正确写入 close 消息字段。
TEST_F(TsdProcessControllerTest, ConstructCloseMsg_DelegatesToBuilder)
{
    ProcessModeManager pm(deviceId, 0);
    SeedOpenMsgInputs(pm);

    HDCMessage msg;
    EXPECT_EQ(pm.tsdCtrl_.ConstructCloseMsg(msg), tsd::TSD_OK);

    EXPECT_EQ(msg.device_id(), 10U % PER_OS_CHIP_NUM);
    EXPECT_EQ(msg.real_device_id(), 10U);
    EXPECT_EQ(msg.type(), HDCMessage::TSD_CLOSE_PROC_MSG);
    EXPECT_EQ(msg.rank_size(), 4U);
    EXPECT_EQ(msg.proc_sign_pid().proc_pid(), 1234U);
}

// HdcMessageBuilder::BuildUpdateProfiling 写入 profiling 消息所需字段。
TEST_F(TsdProcessControllerTest, Close_CallsReleaseDeviceConnection)
{
    ProcessModeManager processModeManager(deviceId, 0);
    auto stub = InjectStubComm(processModeManager, deviceId);

    MOCKER_CPP(&TsdProcessController::SendCloseMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&TsdProcessController::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));

    auto ret = processModeManager.tsdCtrl_.Close(0);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(processModeManager.commAgent_.devCommClient_, nullptr);
    EXPECT_FALSE(processModeManager.commAgent_.IsInit());
    EXPECT_EQ(stub->destroyCount_, 1);
    GlobalMockObject::verify();
}

TEST_F(TsdProcessControllerTest, WaitRsp_CommunicationAndResponseSucceed_ReturnsOk)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.tsdSessionId_ = 0U;
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.commAgent_.devCommClient_)->hdcClientSessionMap_[0U] =
        session;
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.sharedCtx_.rspCode = ResponseCode::SUCCESS;
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, false);
    EXPECT_EQ(ret, TSD_OK);
}

// devCommClient_ 为 null → TSD_INSTANCE_NOT_INITIALED
TEST_F(TsdProcessControllerTest, WaitRsp_DeviceCommNull_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.rspCode = ResponseCode::SUCCESS;
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, false);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

// 通信失败 + sharedCtx_.startOrStopFailCode 为未知值 → TSD_CLT_OPEN_FAILED
TEST_F(TsdProcessControllerTest, WaitRsp_CommunicationFailsWithUnknownCode_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    processModeManager.sharedCtx_.rspCode = ResponseCode::SUCCESS;
    processModeManager.sharedCtx_.startOrStopFailCode = "E99999";
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, false);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

// 通信失败 + ignoreRecvErr=true → 仍返回错误码（跳过日志打印）
TEST_F(TsdProcessControllerTest, WaitRsp_CommunicationFailsWithIgnoredReceiveError_MapsFailCode)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    processModeManager.sharedCtx_.rspCode = ResponseCode::SUCCESS;
    processModeManager.sharedCtx_.startOrStopFailCode = "E30003";
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(0U, true, false);
    EXPECT_EQ(ret, TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT);
}

// sharedCtx_.rspCode=FAIL + errMsg/failCode 非空，返回映射后的设备错误码。
TEST_F(TsdProcessControllerTest, WaitRsp_DeviceFailureCode_ReturnsMappedStatus)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.commAgent_.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.sharedCtx_.errMsg = "device internal error";
    processModeManager.sharedCtx_.errorLog = "stack trace here";
    processModeManager.sharedCtx_.startOrStopFailCode = "E30006";
    const auto ret = processModeManager.tsdCtrl_.WaitRsp(0U, false, false);
    EXPECT_EQ(ret, TSD_VERIFY_OPP_FAIL);
}

// ====== MapFailCodeToStatus 各分支覆盖 ======
// 覆盖 E30003 / E30004 / E30006 / E30007 / 未知码 / 空字符串 六种情况

TEST_F(TsdProcessControllerTest, MapFailCodeToStatus_E30003_ReturnsSubprocessLimitStatus)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.startOrStopFailCode = "E30003";
    EXPECT_EQ(processModeManager.tsdCtrl_.MapFailCodeToStatus(), TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT);
}

TEST_F(TsdProcessControllerTest, MapFailCodeToStatus_E30004_ReturnsBinaryDamagedStatus)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.startOrStopFailCode = "E30004";
    EXPECT_EQ(processModeManager.tsdCtrl_.MapFailCodeToStatus(), TSD_SUBPROCESS_BINARY_FILE_DAMAGED);
}

TEST_F(TsdProcessControllerTest, MapFailCodeToStatus_E30006_ReturnsOppVerificationFailure)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.startOrStopFailCode = "E30006";
    EXPECT_EQ(processModeManager.tsdCtrl_.MapFailCodeToStatus(), TSD_VERIFY_OPP_FAIL);
}

TEST_F(TsdProcessControllerTest, MapFailCodeToStatus_E30007_ReturnsCgroupAdditionFailure)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.startOrStopFailCode = "E30007";
    EXPECT_EQ(processModeManager.tsdCtrl_.MapFailCodeToStatus(), TSD_ADD_AICPUSD_TO_CGROUP_FAILED);
}

TEST_F(TsdProcessControllerTest, MapFailCodeToStatus_UnknownCode_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.startOrStopFailCode = "E99999";
    EXPECT_EQ(processModeManager.tsdCtrl_.MapFailCodeToStatus(), TSD_CLT_OPEN_FAILED);
}

TEST_F(TsdProcessControllerTest, MapFailCodeToStatus_EmptyCode_ReturnsOpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.startOrStopFailCode = "";
    EXPECT_EQ(processModeManager.tsdCtrl_.MapFailCodeToStatus(), TSD_CLT_OPEN_FAILED);
}

// ====== BuildWaitRspErrReport 各分支覆盖 ======

// 通信失败分支：recvRet != TSD_OK，报告应包含 "check hdc service"
TEST_F(TsdProcessControllerTest, BuildWaitRspErrReport_ReceiveFails_IncludesHdcGuidance)
{
    ProcessModeManager processModeManager(deviceId, 0);
    const std::string report = processModeManager.tsdCtrl_.BuildWaitRspErrReport(TSD_INTERNAL_ERROR);
    EXPECT_NE(report.find("receive device response data failed"), std::string::npos);
    EXPECT_NE(report.find("check hdc service"), std::string::npos);
}

// 通信成功但 sharedCtx_.rspCode=FAIL，sharedCtx_.errMsg 为空 → "unknown device error"
TEST_F(TsdProcessControllerTest, BuildWaitRspErrReport_DeviceFailureWithoutErrorMessage_IncludesUnknownDeviceError)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.sharedCtx_.startOrStopFailCode = "";
    const std::string report = processModeManager.tsdCtrl_.BuildWaitRspErrReport(TSD_OK);
    EXPECT_NE(report.find("device response code[1]"), std::string::npos);
    EXPECT_NE(report.find("unknown device error"), std::string::npos);
}

// 通信成功但 sharedCtx_.rspCode=FAIL，sharedCtx_.errMsg 非空 → 报告包含 sharedCtx_.errMsg 和 sharedCtx_.errorLog
TEST_F(TsdProcessControllerTest, BuildWaitRspErrReport_RspCodeFailWithErrMsg)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.sharedCtx_.rspCode = ResponseCode::FAIL;
    processModeManager.sharedCtx_.errMsg = "device internal error";
    processModeManager.sharedCtx_.errorLog = "stack trace here";
    processModeManager.sharedCtx_.startOrStopFailCode = "E30006";
    const std::string report = processModeManager.tsdCtrl_.BuildWaitRspErrReport(TSD_OK);
    EXPECT_NE(report.find("device internal error"), std::string::npos);
    EXPECT_NE(report.find("stack trace here"), std::string::npos);
}
