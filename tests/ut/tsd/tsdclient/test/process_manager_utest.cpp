/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/file.h>
#include <cstdio>
#include <fstream>
#include <unistd.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"
#define private public
#define protected public
#include "inc/package_process_config.h"
#include "inc/client_manager.h"
#include "inc/process_mode_manager.h"
#include "inc/plugin_pkg_version.h"
#include "device_comm.h"
#include "tsd_hdc_client.h"
#include "inc/weak_ascend_hal.h"
#include "env_internal_api.h"
#include "platform_manager_v2.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace
{
// clientManager is a singleton, so a deviceId can only point to one mode in all st
// we define 0 to ProcessMode, and 1 to ThreadMode
static const int deviceId = 0;
constexpr int32_t PROCESS_MODE = 0;
constexpr int32_t THREAD_MODE = 1;

auto mockerOpen = reinterpret_cast<int(*)(const char*, int)>(open);

int32_t mmScandir2Stub(const char *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    if ((path == nullptr) || (entryList == nullptr)) {
        return -1;
    }

    const uint32_t fileCount = 1U;

    mmDirent2 **list = (mmDirent2 **)malloc(fileCount * sizeof(mmDirent2 *));;
    list[0] = (mmDirent2 *)malloc(sizeof(mmDirent2));
    strcpy(list[0]->d_name, "Ascend910-aicpu_syskernels.tar.gz");

    *entryList = list;

    return fileCount;
}

int32_t mmScandir2Stub2(const char *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    if ((path == nullptr) || (entryList == nullptr)) {
        return -1;
    }

    const uint32_t fileCount = 1U;

    mmDirent2 **list = (mmDirent2 **)malloc(fileCount * sizeof(mmDirent2 *));;
    list[0] = (mmDirent2 *)malloc(sizeof(mmDirent2));
    strcpy(list[0]->d_name, "Ascend910-driver.run");

    *entryList = list;

    return fileCount;
}

std::string GetHostSoPathFake()
{
    return "test";
}

int dladdrFake1 (const void *__address, Dl_info *__info)
{
    __info->dli_fname = "test";
    return 1;
}

int dladdrFake2 (const void *__address, Dl_info *__info)
{
    __info->dli_fname = "/home/test";
    return 1;
}

drvError_t halGetSocVersionStub(uint32_t devId, char *socVersion, uint32_t len) 
{
    const char* version = "Ascend910B1"; 
    size_t required_len = strlen(version) + 1; 
    strncpy_s(socVersion, len, version, required_len); 
    return DRV_ERROR_NONE; 
}
}
namespace {
    int32_t g_Choice = 0;
    int halQueryDevpidFake(struct halQueryDevpidInfo info, pid_t *dev_pid)
    {
        *dev_pid = 22222;
        return 0;
    }

    struct queueInfoBuff {
        QueQueryQuesOfProcInfo qInfo[2];
    };
    drvError_t halQueueQueryFake(unsigned int devId, QueueQueryCmdType cmd,
                                     QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
    {
        if (g_Choice == 1) {
            queueInfoBuff *queueInfoList = reinterpret_cast<queueInfoBuff *>(outPut->outBuff);
            outPut->outLen = sizeof(queueInfoBuff);
            queueInfoList->qInfo[0].qid = 10;
            queueInfoList->qInfo[0].attr =  {1, 1, 1, 0};
            queueInfoList->qInfo[1].qid = 11;
            queueInfoList->qInfo[1].attr =  {0, 0, 1, 0};
            return DRV_ERROR_NONE;
        }
        if (g_Choice == 2) {
            outPut->outLen = 1U;
            return DRV_ERROR_NONE;
        }
        if (g_Choice == 3) {
            queueInfoBuff *queueInfoList = reinterpret_cast<queueInfoBuff *>(outPut->outBuff);
            outPut->outLen = sizeof(queueInfoBuff);
            queueInfoList->qInfo[0].qid = 100000;
            queueInfoList->qInfo[0].attr =  {1, 1, 1, 0};
            queueInfoList->qInfo[1].qid = 1000000;
            queueInfoList->qInfo[1].attr =  {0, 0, 1, 0};
            return DRV_ERROR_NONE;
        }
        cout<<"Wrong choice"<<endl;
        return DRV_ERROR_NOT_EXIST;
    }

    drvError_t halGetDeviceInfoFake2(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        *value = 1024;
        cout <<"enter halGetDeviceInfoFake2"<< endl;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoPluginFlag0(uint32_t, int32_t, int32_t, int64_t *value)
    {
        *value = 0;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoPluginFlag1(uint32_t, int32_t, int32_t, int64_t *value)
    {
        *value = 1;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoPluginFlag2(uint32_t, int32_t, int32_t, int64_t *value)
    {
        *value = 2;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoPluginFlagInvalid(uint32_t, int32_t, int32_t, int64_t *value)
    {
        *value = 3;
        return DRV_ERROR_NONE;
    }

    drvError_t drvGetPlatformInfoFake(uint32_t *info)
    {
        cout <<"enter drvGetPlatformInfoFake"<< endl;
        return DRV_ERROR_NONE;
    }
}

namespace {
    // 测试用 DeviceComm 桩：覆盖所有虚接口，返回值可在用例中按需配置。
    // 由于 mockcpp 的 JmpOnlyApiHookImpl 无法对虚成员函数的 PMF 进行打桩
    // （PMF 实际为 vtable 偏移而非函数地址，会触发 SIGSEGV），
    // 因此通过子类化 + 注入到 ProcessModeManager.devCommClient_ 的方式替代。
    class StubDeviceComm : public tsd::DeviceComm {
    public:
        explicit StubDeviceComm(uint32_t devId)
            : tsd::DeviceComm(devId, tsd::DeviceCommType::HDC),
              inspector_(std::make_shared<tsd::VersionVerify>()) {}

        tsd::TSD_StatusT CommInit(const uint32_t, const bool) override { return commInitRet_; }
        tsd::TSD_StatusT CommCreateSession(uint32_t& sid) override
        {
            sid = sessionIdStub_;
            return commCreateSessionRet_;
        }
        void CommDestroy() override { ++destroyCount_; }
        tsd::TSD_StatusT CommRecvData(const uint32_t, const bool, const uint32_t) override
        {
            return commRecvDataRet_;
        }
        tsd::TSD_StatusT CommGetConctStatus(int32_t& s) override
        {
            s = sessStat_;
            return commGetConctStatusRet_;
        }
        tsd::TSD_StatusT CommSendMsg(const uint32_t, const HDCMessage&) override
        {
            return commSendMsgRet_;
        }
        tsd::TSD_StatusT CommGetVersionVerify(const uint32_t,
                                              std::shared_ptr<tsd::VersionVerify>& v) override
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
        pm.devCommClient_ = stub;
        return stub;
    }
}

class ProcessManagerTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
        cout << "Before ProcessManagerTest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After ProcessManagerTest" << endl;
        std::string valueStr("PROCESS_MODE");
        ClientManager::SetRunMode(valueStr);
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        tsd::PackageProcessConfig::GetInstance()->hostPluginVersions_.clear();
    }
};

TEST_F(ProcessManagerTest, OpenReopenSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdStartStatus_.startCp_ = true;
    tsd::TSD_StatusT ret = processModeManager.Open(1);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, OpenFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdStartStatus_.startCp_ = true;
        MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(true));
    tsd::TSD_StatusT ret = processModeManager.Open(1);
    EXPECT_EQ(ret, tsd::TSD_OPEN_NOT_SUPPORT_FOR_ADC);
}

TEST_F(ProcessManagerTest, OpenProcessFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdStartStatus_.startCp_ = true;
    MOCKER_CPP(&ProcessModeManager::CheckNeedToOpen)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::LoadPackageConfigInfoToDevice)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::LoadSysOpKernel)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::LoadPackageToDeviceByConfig)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::ProcessQueueForAdc)
        .stubs()
        .will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.OpenProcess(1);
    EXPECT_EQ(ret, 1);
}

TEST_F(ProcessManagerTest, CloseSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    tsd::TSD_StatusT ret = processModeManager.Close(0);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, UpdateProfilingFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    tsd::TSD_StatusT ret = processModeManager.UpdateProfilingConf(1);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, CheckNeedToOpenTrue1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    TsdStartStatusInfo startInfo;
    uint32_t rankSize = 1;
    bool ret = processModeManager.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, true);
}

TEST_F(ProcessManagerTest, CheckNeedToOpenFalse1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdStartStatus_.startCp_ = true;
    TsdStartStatusInfo startInfo;
    uint32_t rankSize = 1;
    bool ret = processModeManager.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, false);
}

TEST_F(ProcessManagerTest, CheckNeedToOpenTrue2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    TsdStartStatusInfo startInfo;
    uint32_t rankSize = 2;
    bool ret = processModeManager.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, true);
}

TEST_F(ProcessManagerTest, CheckNeedToOpenFalse2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    TsdStartStatusInfo startInfo;
    processModeManager.tsdStartStatus_.startCp_ = true;
    processModeManager.tsdStartStatus_.startHccp_ = true;
    uint32_t rankSize = 2;
    bool ret = processModeManager.CheckNeedToOpen(rankSize, startInfo);
    EXPECT_EQ(ret, false);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelSuccess)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(CalFileSize).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelPackageNotExist)
{
    // package is not exist
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_ERROR));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_ERROR));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelInvalidPackageName)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub2));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(CalFileSize).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelOnAdc)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::OFFLINE));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelCheckCodeFail)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));

    MOCKER_CPP(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER_CPP(mmScandir2).stubs().will(invoke(mmScandir2Stub));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode).stubs().will(returnValue(1));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_DEVICEID_ERROR);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelIgnorePack1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    processModeManager.SetPlatInfoMode(0);
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelFalse1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    processModeManager.SetPlatInfoMode(1);
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER(drvHdcGetTrustedBasePath)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelFalse2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    processModeManager.SetPlatInfoMode(1);
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode)
        .stubs()
        .will(returnValue(102U));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelSuccess1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER(CalFileSize).stubs().will(returnValue(0U));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelSuccess2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER(CalFileSize).stubs().will(returnValue(1));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSysOpKernelSuccess3)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    processModeManager.aicpuPackageExistInDevice_ = true;
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeSuccess1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = true;
    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_AICPUPACKAGE_EXISTED);
}

TEST_F(ProcessManagerTest, ServerToClientMsgProc)
{
    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_device_id(1);
    msg.set_tsd_rsp_code(1);
    ProcessModeManager::ServerToClientMsgProc(1, msg);
    std::shared_ptr<ProcessModeManager> client = std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    EXPECT_EQ(client->rspCode_, ResponseCode::FAIL);
}

TEST_F(ProcessManagerTest, PackageInfoMsgProc)
{
    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_check_code(1);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RSP);
    std::shared_ptr<ProcessModeManager> client = std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    client->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 0;
    ProcessModeManager::PackageInfoMsgProc(1, msg);
    EXPECT_EQ(client->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)], 1);
}

TEST_F(ProcessManagerTest, PackageInfoMsgProc2)
{
    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_check_code(1);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY_RSP);
    std::shared_ptr<ProcessModeManager> client = std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    client->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 0;
    ProcessModeManager::PackageInfoMsgProc(1, msg);
    EXPECT_EQ(client->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)], 1);
}

TEST_F(ProcessManagerTest, PackageInfoMsgProc3)
{
    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_check_code(1);
    msg.set_type(HDCMessage::INIT);
    std::shared_ptr<ProcessModeManager> client = std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    client->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 0;
    ProcessModeManager::PackageInfoMsgProc(1, msg);
    EXPECT_NE(client->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)], 1);
}

TEST_F(ProcessManagerTest, SyncQueueAuthorityFail01)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, SyncQueueAuthorityFail02)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(0));
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(returnValue(100)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, SyncQueueAuthorityEmptySucc)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(0));
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, OpenAicpuAdcSucc)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    g_Choice = 1;
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(invoke(halQueueQueryFake));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, OpenAicpuAdcDrvErrorFail)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    g_Choice = 2;
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(invoke(halQueueQueryFake));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, OpenAicpuAdcQueueInvalidFail)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));

    g_Choice = 3;
    MOCKER(halQueryDevpid).stubs().will(invoke(halQueryDevpidFake));
    MOCKER(halQueueQuery).stubs().will(invoke(halQueueQueryFake));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, OpenAicpuAdcQueueNotSupport)
{
    MOCKER(drvDeviceGetBareTgid).stubs().will(returnValue(1000));
    MOCKER(halQueueGrant).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(0));
    MOCKER(halQueryDevpid).stubs().will(returnValue(0xfffe));

    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.SyncQueueAuthority();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, TsdOpenCallSyncSucc)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    MOCKER_CPP(&ProcessModeManager::CheckNeedToOpen)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::LoadSysOpKernel)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SetTsdStartInfo)
        .stubs()
        .will(ignoreReturnValue());
    ProcessModeManager processModeManager(deviceId, 0);
    ret = processModeManager.Open(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, CapabilityResMsgProc_01)
{
    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_device_id(1);
    msg.set_tsd_rsp_code(1);
    msg.set_pid_of_qos(100);
    ProcessModeManager::CapabilityResMsgProc(1, msg);
    std::shared_ptr<ProcessModeManager> client = std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    EXPECT_EQ(client->rspCode_, ResponseCode::FAIL);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, CapabilityResMsgProc_02)
{
    HDCMessage msg;
    msg.set_real_device_id(deviceId);
    msg.set_device_id(1);
    msg.set_tsd_rsp_code(0);
    msg.set_pid_of_qos(100);
    ProcessModeManager::CapabilityResMsgProc(1, msg);
    std::shared_ptr<ProcessModeManager> client = std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    EXPECT_EQ(client->pidQos_, 100);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, CapabilityGet_01)
{
    ProcessModeManager processModeManager(deviceId, 0);
    int32_t type = 1;
    uint64_t ptr = 0UL;
    auto stub = InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.Open(2U);
    tsd::TSD_StatusT ret = processModeManager.CapabilityGet(type, ptr);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, CapabilityGet_02)
{
    ProcessModeManager processModeManager(deviceId, 0);
    int32_t type = 0;
    uint64_t result = 0;
    uint64_t *ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    auto stub = InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCapabilityMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.tsdStartStatus_.startCp_ = true;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.Open(2U);
    tsd::TSD_StatusT ret = processModeManager.CapabilityGet(type, ptrRes);
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, ConstructCapabilityMsg_01)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    processModeManager.ConstructCapabilityMsg(msg, 0);
    EXPECT_EQ(0, msg.device_id());
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadSysOpKernel1951dc)
{
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake2));
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfoFake));
    std::shared_ptr<ProcessModeManager> client =
        std::dynamic_pointer_cast<ProcessModeManager>(ClientManager::GetInstance(deviceId));
    client->GetPlatformInfo(deviceId);
    std::string packageTitle;
    std::string packageTitleRes = "Ascend310P";
    const auto ret = client->GetPackageTitle(packageTitle);
    EXPECT_TRUE(ret);
    EXPECT_EQ(packageTitleRes, packageTitle);
    GlobalMockObject::verify();
}


TEST_F(ProcessManagerTest, GetDeviceCheckCodeNoRspSuc)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientSessionMap_[0U] = session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&HdcCommon::SendNormalMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));

    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeNoRspSuc2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientSessionMap_[0U] = session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&HdcCommon::SendNormalMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 456U;
    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeFail002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientSessionMap_[0U] = session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeOnce)
        .stubs()
        .will(returnValue(1U));
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 456U;
    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, waitRspCloseNoRsp)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(13U));
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, waitRspFail001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30003";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT);
}

TEST_F(ProcessManagerTest, waitRspFail002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30004";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_SUBPROCESS_BINARY_FILE_DAMAGED);
}

TEST_F(ProcessManagerTest, waitRspFail003)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30006";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_VERIFY_OPP_FAIL);
}

TEST_F(ProcessManagerTest, waitRspFail004)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30007";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_ADD_AICPUSD_TO_CGROUP_FAILED);
}

TEST_F(ProcessManagerTest, ConstructCloseMsg_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    auto ret = processModeManager.ConstructCloseMsg(msg);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, ProcessQueueForAdc_001)
{
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ClientManager::GetPlatInfoMode)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(ModeType::OFFLINE)));
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::SyncQueueAuthority)
        .stubs()
        .will(returnValue(1));
    auto ret = processModeManager.ProcessQueueForAdc();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetLogLevel_Success_001)
{
    char env[] = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "101");
}

TEST_F(ProcessManagerTest, GetLogLevel_Success_002)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    char env[] = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessManagerTest, GetLogLevel_Success_003)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    char env[] = "16b";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessManagerTest, GetAscendLatestIntallPath_Succ)
{
    char env[] = "/usr/local/Asend/lastest";
    MOCKER(&mmSysGetEnv).stubs().will(returnValue(&env[0U]));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string pkgBasePath;
    processModeManager.GetAscendLatestIntallPath(pkgBasePath);
    EXPECT_EQ(pkgBasePath, "/usr/local/Asend/lastest");
}

TEST_F(ProcessManagerTest, LoadRuntimePkgToDevice_Succ)
{
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(0U));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadRuntimePkgToDevice_Fail)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_NE(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadRuntimePkgToDevice_Fail2)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    MOCKER(drvHdcGetTrustedBasePath).stubs().will(returnValue(DRV_ERROR_INVALID_DEVICE));
    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_NE(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, IsSupportHeterogeneousInterface_FAIL_CHIPERROR)
{
    MOCKER(usleep).stubs().will(returnValue(0));
    MOCKER(sleep).stubs().will(returnValue(0U));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.SetPlatInfoChipType(CHIP_BEGIN);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.IsSupportHeterogeneousInterface();
    EXPECT_EQ(ret, false);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, IsSupportHeterogeneousInterface_SUCC)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.SetPlatInfoChipType(CHIP_ASCEND_910B);
    processModeManager.tsdSupportLevel_ = 1U;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.IsSupportHeterogeneousInterface();
    EXPECT_EQ(ret, true);
    processModeManager.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(tsd::TSD_OK));
    ret = processModeManager.IsSupportHeterogeneousInterface();
    EXPECT_NE(ret, true);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, IsSupportHeterogeneousInterface_FAIL)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.SetPlatInfoChipType(CHIP_BEGIN);
    processModeManager.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.IsSupportHeterogeneousInterface();
    EXPECT_NE(ret, true);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, HelperCheckSupportFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.SetPlatInfoChipType(CHIP_BEGIN);
    processModeManager.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));

    auto ret = processModeManager.ProcessOpenSubProc(nullptr);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.ProcessCloseSubProc(0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.LoadFileToDevice(nullptr, 0U, nullptr, 0);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.RemoveFileOnDevice(nullptr, 0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.GetSubProcStatus(nullptr, 0U);
    EXPECT_NE(ret, tsd::TSD_OK);

    ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_NE(ret, tsd::TSD_OK);

    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadCannHsPkgToDeviceSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir=DeviceInstallPath::RUNTIME_PATH;
    config.findPath="compat";
    config.hostTruePath="test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);
    PackConfDetail hccdConfig = {};
    hccdConfig.decDstDir=DeviceInstallPath::RUNTIME_PATH;
    hccdConfig.findPath="compat";
    hccdConfig.hostTruePath="test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-hccd-compat.tar.gz", hccdConfig);

    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "12345";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::LoadPackageConfigInfoToDevice).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.rspCode_ = ResponseCode::SUCCESS;

    HDCMessage rspMsg = {};
    rspMsg.set_type(HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    SinkPackageHashCodeInfo *rspCon = rspMsg.add_package_hash_code_list();
    rspCon->set_package_name("cann-hccd-compat.tar.gz");
    rspCon->set_hash_code(hashVal);
    processModeManager.SaveDeviceCheckCode(rspMsg);
    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, LoadCannHsPkgToDeviceGetDrvPathFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir=DeviceInstallPath::RUNTIME_PATH;
    config.findPath="compat";
    config.hostTruePath="test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(1));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    std::string hashVal = "12345";
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.rspCode_ = ResponseCode::SUCCESS;

    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, LoadCannHsPkgToDeviceSendFileFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir=DeviceInstallPath::RUNTIME_PATH;
    config.findPath="compat";
    config.hostTruePath="test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(1));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "12345";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.rspCode_ = ResponseCode::SUCCESS;

    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, LoadCannHsPkgToDeviceRspFail)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir=DeviceInstallPath::RUNTIME_PATH;
    config.findPath="compat";
    config.hostTruePath="test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "123456";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.rspCode_ = ResponseCode::FAIL;

    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, LoadCannHsPkgToDeviceInitClientFail)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail config = {};
    config.decDstDir=DeviceInstallPath::RUNTIME_PATH;
    config.findPath="compat";
    config.hostTruePath="test/compat";
    PackageProcessConfig::GetInstance()->configMap_.emplace("cann-udf-compat.tar.gz", config);

    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(1U));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    std::string hashVal = "123456";
    MOCKER(CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.rspCode_ = ResponseCode::FAIL;

    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, CapabilityGet_capablity)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    int32_t type = 1;
    uint64_t result = 0;
    uint64_t *ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCapabilityMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.tsdStartStatus_.startCp_ = true;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.tsdSupportLevel_ = 1U;
    auto ret = processModeManager.CapabilityGet(type, ptrRes);
    EXPECT_EQ(ret, TSD_OK);

    processModeManager.tsdSupportLevel_ = 0U;
    ret = processModeManager.CapabilityGet(type, ptrRes);
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, DeviceMsgProc_helper)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_device_id(0);
    msg.set_capability_level(1);
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);
    processModeManager.DeviceMsgProcess(msg);
    msg.set_helper_sub_pid(1);
    msg.set_type(HDCMessage::TSD_OPEN_SUB_PROC_RSP);
    processModeManager.DeviceMsgProcess(msg);

    SubProcStatus *res = msg.add_sub_proc_status_list();
    res->set_proc_status(0);
    res->set_sub_proc_pid(0);
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    processModeManager.DeviceMsgProcess(msg);
    ProcStatusInfo statusInfo;
    processModeManager.pidArry_ = &statusInfo;
    processModeManager.pidArryLen_ = 0;
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    processModeManager.DeviceMsgProcess(msg);
    EXPECT_EQ(processModeManager.pidArry_, &statusInfo);
    EXPECT_EQ(processModeManager.pidArryLen_, 0);
    processModeManager.pidArryLen_ = 1;
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    processModeManager.DeviceMsgProcess(msg);
    EXPECT_EQ(processModeManager.pidArryLen_, 1);
}

TEST_F(ProcessManagerTest, DeviceMsgProc_helper1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_device_id(0);
    msg.set_capability_level(1);
    ErrInfo * const errorInfo = msg.mutable_error_info();
    ASSERT_TRUE(errorInfo != nullptr);

    errorInfo->set_error_code("E30004");
    msg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);
    processModeManager.startOrStopFailCode_ = "E30004";
    processModeManager.DeviceMsgProcess(msg);
    msg.set_helper_sub_pid(1);
    msg.set_type(HDCMessage::TSD_OPEN_SUB_PROC_RSP);
    processModeManager.startOrStopFailCode_ = "E30004";
    processModeManager.DeviceMsgProcess(msg);

    SubProcStatus *res = msg.add_sub_proc_status_list();
    res->set_proc_status(0);
    res->set_sub_proc_pid(0);
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    processModeManager.startOrStopFailCode_ = "E30004";
    processModeManager.DeviceMsgProcess(msg);
    ProcStatusInfo statusInfo;
    processModeManager.pidArry_ = &statusInfo;
    processModeManager.pidArryLen_ = 0;
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    processModeManager.DeviceMsgProcess(msg);
    EXPECT_EQ(processModeManager.pidArry_, &statusInfo);
    EXPECT_EQ(processModeManager.pidArryLen_, 0);
    processModeManager.pidArryLen_ = 1;
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    processModeManager.DeviceMsgProcess(msg);
    EXPECT_EQ(processModeManager.pidArryLen_, 1);
}

TEST_F(ProcessManagerTest, LoadDShapePkgToDevice_Succ)
{
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(0U));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    auto ret = processModeManager.LoadDShapePkgToDevice();
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadDShapePkgToDevice_Fail)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.LoadDShapePkgToDevice();
    EXPECT_NE(ret, TSD_OK);
    GlobalMockObject::verify();
}


TEST_F(ProcessManagerTest, ConstructCommonOpenMsg_FAIL)
{
    MOCKER_CPP(&ProcessModeManager::SetCommonOpenParamList).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    auto ret = processModeManager.ConstructCommonOpenMsg(hdcMsg, &procArgs);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, SetHeterogeneousOpenParamList_FAIL)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 200UL;
    auto ret = processModeManager.SetCommonOpenParamList(hdcMsg, &procArgs);
    EXPECT_EQ(ret, false);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, IsOkToLoadFileToDevice001)
{
    const char_t *fileName = "";
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.IsOkToLoadFileToDevice(fileName, 1U);
    EXPECT_EQ(ret, false);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc001)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_UDF;
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc002)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_BUILTIN_UDF;
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc003)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_ADPROF;
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc004)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_HCCP;
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCommonOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.openSubPid_ = curPid;
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_HCCP;
    closeList[0].pid = curPid;
    uint32_t listSize = 1U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.tsdSupportLevel_ = 4U;
    ret = processModeManager.ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, tsd::TSD_OK);
    processModeManager.Destroy();
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc005)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_HCCP;
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCommonOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.openSubPid_ = curPid;
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ret = processModeManager.ProcessCloseSubProc(curPid);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc006)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_HCCP;
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCommonOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::ExecuteClosePidList).stubs().will(returnValue(1U));
    ProcessModeManager processModeManager(deviceId, 0);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.openSubPid_ = curPid;
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_HCCP;
    closeList[0].pid = curPid;
    uint32_t listSize = 51U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.tsdSupportLevel_ = 4U;
    ret = processModeManager.ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, 1U);
    processModeManager.Destroy();
}

TEST_F(ProcessManagerTest, ProcessOpenSubProc007)
{
    ProcOpenArgs openArg = {};
    openArg.procType = TSD_SUB_PROC_HCCP;
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCommonOpenMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::ExecuteClosePidList).stubs().
        will(returnValue(tsd::TSD_OK)).then(returnValue(1U));
    ProcessModeManager processModeManager(deviceId, 0);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.openSubPid_ = curPid;
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    ProcStatusParam closeList[1];
    closeList[0].procType = TSD_SUB_PROC_HCCP;
    closeList[0].pid = curPid;
    uint32_t listSize = 51U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.tsdSupportLevel_ = 4U;
    ret = processModeManager.ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, 1U);
    processModeManager.Destroy();
}

TEST_F(ProcessManagerTest, ProcessCloseSubProc001)
{
    pid_t pid = 0;
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.ProcessCloseSubProc(pid);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetSubProcStatus001)
{
    ProcStatusInfo info;
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.GetSubProcStatus(&info, 1U);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, RemoveFileOnDevice001)
{
    const char_t *filePath = "";
    MOCKER(tsd::CheckValidatePath).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.RemoveFileOnDevice(filePath, 1U);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, SaveCapabilityResultOmInner)
{
    uint64_t result = 0;
    uint64_t *ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_EQ(processModeManager.SaveCapabilityResult(TSD_CAPABILITY_OM_INNER_DEC, ptrRes), tsd::TSD_OK);
    processModeManager.supportOmInnerDec_ = true;
    EXPECT_EQ(processModeManager.UseStoredCapabityInfo(TSD_CAPABILITY_OM_INNER_DEC, ptrRes), true);
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(1U));
    EXPECT_EQ(processModeManager.WaitCapabilityRsp(TSD_CAPABILITY_OM_INNER_DEC, ptrRes), tsd::TSD_OK);
    HDCMessage msg;
    processModeManager.SetCapabilityMsgType(msg, TSD_CAPABILITY_OM_INNER_DEC);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, SaveCapabilityResultBuiltInUdf)
{
    uint64_t result = 0;
    uint64_t *ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_EQ(processModeManager.SaveCapabilityResult(TSD_CAPABILITY_BUILTIN_UDF, ptrRes), tsd::TSD_OK);
    processModeManager.tsdSupportLevel_ = 3U;
    EXPECT_EQ(processModeManager.UseStoredCapabityInfo(TSD_CAPABILITY_BUILTIN_UDF, ptrRes), true);
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(1U));
    EXPECT_EQ(processModeManager.WaitCapabilityRsp(TSD_CAPABILITY_BUILTIN_UDF, ptrRes), tsd::TSD_OK);
    HDCMessage msg;
    processModeManager.SetCapabilityMsgType(msg, TSD_CAPABILITY_BUILTIN_UDF);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, SaveCapabilityResultAdprof)
{
    bool result = false;
    uint64_t ptrRes = reinterpret_cast<uint64_t>(&result);
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_EQ(processModeManager.SaveCapabilityResult(TSD_CAPABILITY_ADPROF, ptrRes), tsd::TSD_OK);
    ptrRes = 0;
    EXPECT_EQ(processModeManager.SaveCapabilityResult(TSD_CAPABILITY_ADPROF, ptrRes), tsd::TSD_CLT_OPEN_FAILED);
    HDCMessage msg;
    processModeManager.SetCapabilityMsgType(msg, TSD_CAPABILITY_ADPROF);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, GetSubProcListStatus)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcStatusParam pidInfo;
    pidInfo.procType = TSD_SUB_PROC_COMPUTE;
    auto ret = processModeManager.GetSubProcListStatus(&pidInfo, 1U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, SendExtendPackage_01)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdSupportLevel_ = 0U;
    const std::string path = "";
    const uint32_t packageType = 1;
    auto ret = processModeManager.SendCommonPackage(0, path, packageType);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendExtendPackage_02)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdSupportLevel_ = 0xFFFFFFFF;
     processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 13U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 123U;
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(1));
    const std::string path = "";
    const uint32_t packageType = 1;
    processModeManager.packageName_[1] = "test";
    auto ret = processModeManager.SendCommonPackage(0, path, packageType);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, SendExtendPackage_03)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdSupportLevel_ = 0xFFFFFFFF;
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(0));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)] = 123U;
    const std::string path = "";
    const uint32_t packageType = 1;
    auto ret = processModeManager.SendCommonPackage(0, path, packageType);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendExtendPackage_04)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdSupportLevel_ = 0xFFFFFFFF;
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(0));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 456U;
    const std::string path = "";
    const uint32_t packageType = 1;
    auto ret = processModeManager.SendCommonPackage(0, path, packageType);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendExtendAicpuPkg_05)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.tsdSupportLevel_ = 0xFFFFFFFF;
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(0));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    const std::string path = "";
    const uint32_t packageType = 1;
    auto ret = processModeManager.SendCommonPackage(0, path, packageType);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendExtendAicpuPkg_06)
{
    MOCKER(&IsAsanMmSysEnv).stubs().will(returnValue(false));
    MOCKER(&IsFpgaMmSysEnv).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.getCheckCodeRetrySupport_ = true;
    processModeManager.tsdSupportLevel_ = 0xFFFFFFFF;
    MOCKER(&drvHdcSendFile).stubs().will(returnValue(0));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    const std::string path = "";
    auto ret = processModeManager.SendAICPUPackage(0, path);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK))
        .then(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackageSimple)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(-1));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    MOCKER_CPP(&ProcessModeManager::SendMsgAndHostPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_003)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_004)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(100U));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    MOCKER(mockerOpen).stubs().will(returnValue(-1));
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    MOCKER_CPP(&ProcessModeManager::SendMsgAndHostPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 0U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_005)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(1U));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_006)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_007)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK))
        .then(returnValue(100U));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackageSimple)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return false;
    };
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 100U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_008)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK))
        .then(returnValue(1U));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackageSimple)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return false;
    };
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_009)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackageSimple)
        .stubs()
        .will(returnValue(1U));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return false;
    };
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_010)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackageSimple)
        .stubs()
        .will(returnValue(1U));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(-1));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return false;
    };
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 1U);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_012_OpenMutexFileFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };

    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    MOCKER(CheckRealPath).stubs().will(returnValue(true));
    MOCKER(mockerOpen).stubs().will(returnValue(-1));
    MOCKER_CPP(&ProcessModeManager::SendMsgAndHostPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_013_FileLockFailed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };

    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    MOCKER(CheckRealPath).stubs().will(returnValue(true));
    MOCKER(mockerOpen).stubs().will(returnValue(3));
    MOCKER(flock).stubs().will(returnValue(-1));
    MOCKER_CPP(&ProcessModeManager::SendMsgAndHostPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));

    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendAICPUPackageComplex_011)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeRetry)
        .stubs()
        .will(returnValue(100U));
    processModeManager.packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 123U;
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 1234U;
    const std::string srcFile = "Ascend-aicpu_kernels.tar.gz";
    const std::string dstFile = "123_Ascend-aicpu_kernels.tar.gz";
    MOCKER(flock).stubs().will(returnValue(0));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    auto aicpuPkgCompareMethd = []() {
        return true;
    };
    MOCKER(mockerOpen).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath)
        .stubs()
        .will(invoke(GetHostSoPathFake));
    auto ret = processModeManager.SendHostPackageComplex(0, srcFile, dstFile, msg,
        aicpuPkgCompareMethd, false);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 100U);
}

TEST_F(ProcessManagerTest, GetHostSoPath001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(dladdr).stubs().will(returnValue(0));
    std::string path = processModeManager.GetHostSoPath();
    EXPECT_EQ(path, "");
}

TEST_F(ProcessManagerTest, GetHostSoPath002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(dladdr).stubs().will(returnValue(1));
    std::string path = processModeManager.GetHostSoPath();
    EXPECT_EQ(path, "");
}

TEST_F(ProcessManagerTest, GetHostSoPath003)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(dladdr).stubs().will(invoke(dladdrFake1));
    std::string path = processModeManager.GetHostSoPath();
    EXPECT_EQ(path, "./");
}

TEST_F(ProcessManagerTest, GetHostSoPath004)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(dladdr).stubs().will(invoke(dladdrFake2));
    std::string path = processModeManager.GetHostSoPath();
    EXPECT_EQ(path, "/home/");
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetrySupport001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.GetDeviceCheckCodeRetrySupport();
    GlobalMockObject::verify();
    EXPECT_EQ(deviceId, 0);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetrySupport002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.tsdSessionId_ = 1U;
    processModeManager.GetDeviceCheckCodeRetrySupport();
    GlobalMockObject::verify();
    EXPECT_EQ(deviceId, 0);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetry001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeOnce)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetry002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_INSTANCE_NOT_FOUND);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetry003)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCodeOnce)
        .stubs()
        .will(returnValue(1));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetry004)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetry005)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(100U));
    HDCMessage msg;
    msg.set_real_device_id(0);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
    msg.set_check_code(0);
    msg.set_wait_flag(true);
    auto ret = processModeManager.GetDeviceCheckCodeRetry(msg);
    GlobalMockObject::verify();
    EXPECT_EQ(ret, 100U);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeExtend_pkg)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientSessionMap_[0U] = session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    processModeManager.packageName_[1] = "Ascend-aicpu_extend_syskernels.tar.gz";
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&HdcCommon::SendNormalMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(1U));

    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}


TEST_F(ProcessManagerTest, LoadSysOpKernel_Extend)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    HDC_SESSION session = nullptr;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientSessionMap_[0U] = session;
    std::dynamic_pointer_cast<HdcClient>(processModeManager.devCommClient_)->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    processModeManager.packageName_[1] = "Ascend-aicpu_extend_syskernels.tar.gz";
    MOCKER_CPP(&ProcessModeManager::CheckPackageExists)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ClientManager::GetPlatInfoMode)
        .stubs()
        .will(returnValue(1U));
    MOCKER_CPP(&HdcCommon::SendNormalMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackage)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCommonPackage)
        .stubs()
        .will(returnValue(1U));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, SaveDeviceCheckCode_extend)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RSP);
    msg.set_check_code(1U);
    msg.set_extendpkg_check_code(2U);
    msg.set_capability_level(5U);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.SaveDeviceCheckCode(msg);
    EXPECT_EQ(processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)], 1U);
    EXPECT_EQ(processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)], 2U);
    EXPECT_EQ(processModeManager.tsdSupportLevel_, 5U);
}

TEST_F(ProcessManagerTest, SaveDeviceCheckCode_dshape)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.SaveDeviceCheckCode(msg);
    EXPECT_EQ(processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE)], 1);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.rspCode_), 0);
}

TEST_F(ProcessManagerTest, SaveDeviceCheckCode_runtime)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.SaveDeviceCheckCode(msg);
    EXPECT_EQ(processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME)], 1);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.rspCode_), 0);
}

TEST_F(ProcessManagerTest, SendUpdateProfilingMsgSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(TSD_OK));
    const auto ret = processModeManager.SendUpdateProfilingMsg(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendUpdateProfilingMsgFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.SendUpdateProfilingMsg(0);
    EXPECT_EQ(ret, TSD_CLT_UPDATE_PROFILING_FAILED);
}

TEST_F(ProcessManagerTest, CloseSuccess2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::SendCloseMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.Close(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, WaitRspFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.WaitRsp(10, false, true);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, WaitRspFail1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::RecvMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.initFlag_ = true;
    processModeManager.errMsg_ = "testlog";
    const auto ret = processModeManager.WaitRsp(10, false, true);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, SendCloseMsgSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    (void)InjectStubComm(processModeManager, deviceId);
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.SendCloseMsg();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendCloseMsgConstructFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::ConstructCloseMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.SendCloseMsg();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, SendCloseMsgSendFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&HdcCommon::SendNormalMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.SendCloseMsg();
    EXPECT_EQ(ret, TSD_CLT_CLOSE_FAILED);
}

TEST_F(ProcessManagerTest, UpdateProfilingConfSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::SendUpdateProfilingMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.UpdateProfilingConf(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, UpdateProfilingConfSendFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::SendUpdateProfilingMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.UpdateProfilingConf(0);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, UpdateProfilingConfWaitRspFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::SendUpdateProfilingMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.UpdateProfilingConf(0);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}


TEST_F(ProcessManagerTest, LoadSysOpKernelFailed_001)
{
    // send package to device success
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::ONLINE));
    MOCKER(&drvHdcGetTrustedBasePath).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::CheckPackageExists).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDeviceCheckCode).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendAICPUPackage).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    tsd::TSD_StatusT ret = processModeManager.LoadSysOpKernel();
    EXPECT_EQ(ret, static_cast<uint32_t>(TSD_INTERNAL_ERROR));
}

TEST_F(ProcessManagerTest, InitQsRepeat)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.tsdStartStatus_.startQs_ = true;
    InitFlowGwInfo info = {"test", 0U};
    const auto ret = processModeManager.InitQs(&info);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, IsSupportCommonInterfaceFail)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.tsdSupportLevel_ = 0;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::SendCapabilityMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.IsSupportCommonInterface(0);
    EXPECT_EQ(ret, false);
}

TEST_F(ProcessManagerTest, GetDeviceHsPkgCheckCodeInitClientFail)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.GetDeviceHsPkgCheckCode(0U, HDCMessage::INIT, false);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, OpenHccpLogLevel)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    procArgs.procType = SubProcType::TSD_SUB_PROC_HCCP;
    procArgs.envParaList = nullptr;
    procArgs.envCnt = 0UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    pid_t subpid = 0;
    procArgs.subPid = &subpid;
    const auto ret = processModeManager.ConstructCommonOpenMsg(hdcMsg, &procArgs);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, ParseModuleLogLevel)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    std::string envModuleLogLevel = "CCECPU=1";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    envModuleLogLevel = "CCECPU=1:AICPU";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    envModuleLogLevel = "CCECPU";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    envModuleLogLevel = "CCECPU=1:AICPU=1";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
    EXPECT_EQ(processModeManager.ccecpuLogLevel_, "1");
    EXPECT_EQ(processModeManager.aicpuLogLevel_ , "1");
    envModuleLogLevel = "CCECPU=a";
    processModeManager.ParseModuleLogLevel(envModuleLogLevel);
}

TEST_F(ProcessManagerTest, GetHdcConctStatus_001)
{
    int32_t hdcSessStat;
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.devCommClient_ = nullptr;
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(true));
    processModeManager.GetHdcConctStatus(hdcSessStat);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CONNECT);
}

TEST_F(ProcessManagerTest, GetHdcConctStatus_002)
{
    int32_t hdcSessStat;
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.devCommClient_ = nullptr;
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    processModeManager.GetHdcConctStatus(hdcSessStat);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CLOSE);
}

TEST_F(ProcessManagerTest, SaveDeviceCheckCode_normalpackage)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND));
    msg.set_device_idle(true);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.SaveDeviceCheckCode(msg);
    EXPECT_EQ(processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)], 1);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.rspCode_), 0);
    EXPECT_EQ(processModeManager.deviceIdle_, true);
}

TEST_F(ProcessManagerTest, SaveDeviceCheckCode_normalpackage_invalid)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    msg.set_check_code(1);
    msg.set_tsd_rsp_code(0);
    msg.set_package_type(0xff);
    msg.set_device_idle(true);
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.SaveDeviceCheckCode(msg);
    EXPECT_EQ(static_cast<uint32_t>(processModeManager.rspCode_), 1);
    EXPECT_EQ(processModeManager.deviceIdle_, false);
}

TEST_F(ProcessManagerTest, GetDriverExtendPkgName)
{
    std::string orgFile;
    std::string dstFile;
    int32_t peerNode;
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetDriverExtendPkgName(orgFile, dstFile, peerNode);
}

TEST_F(ProcessManagerTest, GetDriverExtendPkgName_success)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(&drvHdcGetTrustedBasePath).stubs().will(returnValue(DRV_ERROR_NONE));
    std::string orgFile;
    std::string dstFile;
    int32_t peerNode;
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetDriverExtendPkgName(orgFile, dstFile, peerNode);
}

TEST_F(ProcessManagerTest, InitTsdClient_Fail_ForInvalidDeviceId)
{
    ProcessModeManager processModeManager(128U, 0);
    EXPECT_EQ(processModeManager.InitTsdClient(), TSD_DEVICEID_ERROR);
}

TEST_F(ProcessManagerTest, AddParamEnvTestUdf)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 1UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    procArgs.subPid = nullptr;
    std::string testEnv = "TESTENV";
    std::string testEnvValue = "TESTTESTUDF";
    ProcEnvParam envParaList;
    envParaList.envName = testEnv.c_str();
    envParaList.nameLen = testEnv.size();
    envParaList.envValue = testEnvValue.c_str();
    envParaList.valueLen = testEnvValue.size();
    procArgs.envParaList = &envParaList;
    procArgs.procType = SubProcType::TSD_SUB_PROC_UDF;
    auto ret = processModeManager.SetCommonOpenParamList(hdcMsg, &procArgs);
    const HelperSubProcess &subProcessInfo = hdcMsg.helper_sub_proc();
    EXPECT_EQ(subProcessInfo.process_type(), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_UDF));
    EXPECT_EQ(subProcessInfo.env_list_size(), 1UL);
    EXPECT_EQ(subProcessInfo.env_list(0).env_name(), testEnv);
    EXPECT_EQ(subProcessInfo.env_list(0).env_value(), testEnvValue);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, AddParamEnvTestBuiltInUdf)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 1UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    procArgs.subPid = nullptr;
    std::string testEnv = "TESTENV";
    std::string testEnvValue = "TESTTESTBUILTINUDF";
    ProcEnvParam envParaList;
    envParaList.envName = testEnv.c_str();
    envParaList.nameLen = testEnv.size();
    envParaList.envValue = testEnvValue.c_str();
    envParaList.valueLen = testEnvValue.size();
    procArgs.envParaList = &envParaList;
    procArgs.procType = SubProcType::TSD_SUB_PROC_BUILTIN_UDF;
    auto ret = processModeManager.SetCommonOpenParamList(hdcMsg, &procArgs);
    const HelperSubProcess &subProcessInfo = hdcMsg.helper_sub_proc();
    EXPECT_EQ(subProcessInfo.process_type(), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_BUILTIN_UDF));
    EXPECT_EQ(subProcessInfo.env_list_size(), 1UL);
    EXPECT_EQ(subProcessInfo.env_list(0).env_name(), testEnv);
    EXPECT_EQ(subProcessInfo.env_list(0).env_value(), testEnvValue);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, AddParamEnvTestHccp)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage hdcMsg = {};
    ProcOpenArgs procArgs;
    procArgs.envCnt = 1UL;
    procArgs.filePath = nullptr;
    procArgs.pathLen = 0UL;
    procArgs.extParamList = nullptr;
    procArgs.extParamCnt = 0UL;
    procArgs.subPid = nullptr;
    std::string testEnv = "TESTENV";
    std::string testEnvValue = "TESTTESTHCCP";
    ProcEnvParam envParaList;
    envParaList.envName = testEnv.c_str();
    envParaList.nameLen = testEnv.size();
    envParaList.envValue = testEnvValue.c_str();
    envParaList.valueLen = testEnvValue.size();
    procArgs.envParaList = &envParaList;
    procArgs.procType = SubProcType::TSD_SUB_PROC_HCCP;
    auto ret = processModeManager.SetCommonOpenParamList(hdcMsg, &procArgs);
    const HelperSubProcess &subProcessInfo = hdcMsg.helper_sub_proc();
    EXPECT_EQ(subProcessInfo.process_type(), static_cast<uint32_t>(SubProcType::TSD_SUB_PROC_HCCP));
    EXPECT_EQ(subProcessInfo.env_list_size(), 0UL);
    EXPECT_EQ(ret, true);
}

TEST_F(ProcessManagerTest, OpenNetService_01)
{
    ProcessModeManager processModeManager(0U, 0);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    EXPECT_EQ(processModeManager.OpenNetService(nullptr), 201U);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, OpenNetService_02)
{
    ProcessModeManager processModeManager(0U, 0);
    (void)InjectStubComm(processModeManager, 0U);
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    NetServiceOpenArgs args;
    ProcExtParam extParamList;
    args.extParamCnt = 1U;
    std::string extPam("levevl=5");
    extParamList.paramInfo = extPam.c_str();
    extParamList.paramLen = extPam.size();
    args.extParamList = &extParamList;
    EXPECT_EQ(processModeManager.OpenNetService(&args), 0U);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, OpenNetService_03)
{
    ProcessModeManager processModeManager(0U, 0);
    (void)InjectStubComm(processModeManager, 0U);
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    EXPECT_EQ(processModeManager.OpenNetService(nullptr), TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, CloseNetService_01)
{
    ProcessModeManager processModeManager(0U, 0);
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.devCommClient_ = DeviceComm::GetInstance(deviceId, DeviceCommType::HDC);
    processModeManager.hccpPid_ = 123;
    EXPECT_EQ(processModeManager.CloseNetService(), tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadDriverExtendPkg_success)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDriverExtendPkgName)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(tsd::TSD_OK));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.LoadDriverExtendPkg();
    EXPECT_EQ(ret, tsd::TSD_OK);
    ret = processModeManager.LoadDriverExtendPkg();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_failed)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.loadPackageErrorMsg_ = "test error";
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, CompareAndSendCommonSinkPkg_Success)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::SendHostPackageComplex).stubs().will(returnValue(TSD_OK));
    EXPECT_EQ(processModeManager.CompareAndSendCommonSinkPkg("pkgPureName", "hostPkgHash", 0, "orgFile", "dstFile"),
              TSD_OK);
}

TEST_F(ProcessManagerTest, SupportLoadPkg)
{
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_TRUE(processModeManager.SupportLoadPkg("unknown_pkg"));

    EXPECT_FALSE(processModeManager.SupportLoadPkg("cann-udf-compat.tar.gz"));

    MOCKER_CPP(&ProcessModeManager::GetPlatInfoChipType).stubs().will(returnValue(static_cast<uint32_t>(tsd::CHIP_DC)));
    EXPECT_TRUE(processModeManager.SupportLoadPkg("aicpu_hcomm.tar.gz"));
    EXPECT_FALSE(processModeManager.SupportLoadPkg("cann-tsch-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, LoadPakcageToDeviceByConfig_Fail_For_Unsupport)
{
    ProcessModeManager processModeManager(deviceId, 0);

    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    EXPECT_EQ(processModeManager.LoadPackageToDeviceByConfig(), TSD_OK);
}

TEST_F(ProcessManagerTest, LoadPakcageToDeviceByConfig_Fail_For_Drv_Fail)
{
    ProcessModeManager processModeManager(deviceId, 0);

    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(processModeManager.LoadPackageToDeviceByConfig(), TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_Success)
{
    ProcessModeManager processModeManager(deviceId, 0);

    PackConfDetail detail = {};
    PackageProcessConfig pkgConInst;
    MOCKER_CPP(&PackageProcessConfig::GetInstance).stubs().will(returnValue(&pkgConInst));
    pkgConInst.configMap_["cann-tsch-compat.tar.gz"] = detail;

    std::string orgFile = "origin";
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs()
        .with(mockcpp::any(), orgFile, mockcpp::any(), mockcpp::any())
        .will(returnValue(TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg).stubs().will(returnValue(TSD_OK));

    EXPECT_EQ(processModeManager.LoadPackageToDeviceByConfig(), TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSinglePackageToDevice_HcommCompat_910B_NotSupported_Skip)
{
    // 910B 芯片 + device 不支持 TSD_SUPPORT_CANN_HCOMM_COMPAT_910B 能力位时，
    // cann-hcomm-compat.tar.gz 应被跳过加载，返回 TSD_OK，且不会进入下发流程。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    MOCKER_CPP(&ProcessModeManager::GetPlatInfoChipType)
        .stubs().will(returnValue(static_cast<uint32_t>(tsd::CHIP_ASCEND_910B)));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .expects(mockcpp::never()).will(returnValue(TSD_OK));
    EXPECT_EQ(processModeManager.LoadSinglePackageToDevice("cann-hcomm-compat.tar.gz", detail, 0, ""), TSD_OK);
}

TEST_F(ProcessManagerTest, LoadSinglePackageToDevice_HcommCompat_910B_Supported_PassesGate)
{
    // 910B 芯片 + device 支持该能力位时，不在门控处提前返回，而是继续后续流程；
    // 此处用 GetPkgHostAndDeviceDstPath 返回错误来观测是否“穿过门控”。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    MOCKER_CPP(&ProcessModeManager::GetPlatInfoChipType)
        .stubs().will(returnValue(static_cast<uint32_t>(tsd::CHIP_ASCEND_910B)));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    EXPECT_EQ(processModeManager.LoadSinglePackageToDevice("cann-hcomm-compat.tar.gz", detail, 0, ""),
              TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, LoadSinglePackageToDevice_HcommCompat_NonChip910B_NotGated)
{
    // 非 910B 芯片时不受该能力位门控，即使 device 不支持也应穿过门控继续后续流程。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    MOCKER_CPP(&ProcessModeManager::GetPlatInfoChipType)
        .stubs().will(returnValue(static_cast<uint32_t>(tsd::CHIP_ASCEND_950)));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    EXPECT_EQ(processModeManager.LoadSinglePackageToDevice("cann-hcomm-compat.tar.gz", detail, 0, ""),
              TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, LoadSinglePackageToDevice_OtherPkg_NotGatedByHcommCompatBit)
{
    // 非 cann-hcomm-compat.tar.gz 的包不受该能力位门控，即使在 910B 且 device 不支持也应穿过门控。
    ProcessModeManager processModeManager(deviceId, 0);
    PackConfDetail detail = {};
    detail.loadAsPerSocFlag = true;
    MOCKER_CPP(&ProcessModeManager::GetPlatInfoChipType)
        .stubs().will(returnValue(static_cast<uint32_t>(tsd::CHIP_ASCEND_910B)));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));
    MOCKER_CPP(&PackageProcessConfig::GetPkgHostAndDeviceDstPath)
        .stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    EXPECT_EQ(processModeManager.LoadSinglePackageToDevice("aicpu_hcomm.tar.gz", detail, 0, ""),
              TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, GetCurHostMutexFile)
{
    ProcessModeManager processModeManager(deviceId, 0);

    EXPECT_EQ(processModeManager.GetCurHostMutexFile(false), "libqueue_schedule.so");

    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(processModeManager.GetCurHostMutexFile(true), "libqueue_schedule.so");

    EXPECT_EQ(processModeManager.GetCurHostMutexFile(true), "sink_file_mutex_0.cfg");
}

TEST_F(ProcessManagerTest, GetCurHostMutexFile_drvDeviceGetPhyIdByIndex_failed)
{
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_EQ(processModeManager.GetCurHostMutexFile(false), "libqueue_schedule.so");
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    MOCKER(drvDeviceGetPhyIdByIndex).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(processModeManager.GetCurHostMutexFile(true), "libqueue_schedule.so");
}

TEST_F(ProcessManagerTest, GetCurHostMutexFile_success)
{
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_EQ(processModeManager.GetCurHostMutexFile(false), "libqueue_schedule.so");
    EXPECT_EQ(processModeManager.GetCurHostMutexFile(true), "sink_file_mutex_0.cfg");
}

TEST_F(ProcessManagerTest, IsSupportCommonSink_No_With_hostSoPathEmpty)
{
    ProcessModeManager processModeManager(deviceId, 0);
    std::string emptyPath = "";
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath).stubs().will(returnValue(emptyPath));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));

    EXPECT_FALSE(processModeManager.IsSupportCommonSink());
}

TEST_F(ProcessManagerTest, IsSupportCommonSink_No_With_hostSoPathInvalid)
{
    ProcessModeManager processModeManager(deviceId, 0);
    std::string hostSoPath = "/usr/local/ascend/driver/";
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath).stubs().will(returnValue(hostSoPath));
    MOCKER(CheckRealPath).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));

    EXPECT_FALSE(processModeManager.IsSupportCommonSink());
}

TEST_F(ProcessManagerTest, IsSupportCommonSink_Yes_With_hostSoPathValid)
{
    ProcessModeManager processModeManager(deviceId, 0);
    std::string hostSoPath = "/usr/local/ascend/driver/";
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath).stubs().will(returnValue(hostSoPath));
    MOCKER(CheckRealPath).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(false));

    EXPECT_TRUE(processModeManager.IsSupportCommonSink());
}

TEST_F(ProcessManagerTest, IsSupportCommonSink_Yes_With_hostSoPathEmpty)
{
    ProcessModeManager processModeManager(deviceId, 0);
    std::string emptyPath = "";
    MOCKER_CPP(&ProcessModeManager::GetHostSoPath).stubs().will(returnValue(emptyPath));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));

    EXPECT_TRUE(processModeManager.IsSupportCommonSink());
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_not_support_load)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig tempPkgConfig;
    MOCKER_CPP(&PackageProcessConfig::GetInstance)
        .stubs()
        .will(returnValue(&tempPkgConfig));
    std::string pkgName = "not_support_pkg.tar.gz";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    tempPkgConfig.configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(false));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_hash_code_same)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    PackageProcessConfig tempPkgConfig;
    MOCKER_CPP(&PackageProcessConfig::GetInstance)
        .stubs()
        .will(returnValue(&tempPkgConfig));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string pkgName = "not_support_pkg.tar.gz";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    tempPkgConfig.configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_load_finish)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    PackageProcessConfig tempPkgConfig;
    MOCKER_CPP(&PackageProcessConfig::GetInstance)
        .stubs()
        .will(returnValue(&tempPkgConfig));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string pkgName = "load_finish.tar.gz";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    tempPkgConfig.configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_failed_verify_failed_does_not_match)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.loadPackageErrorMsg_ = "cms verify failed. certType [XXX] does not match verifyFlag [XXX]";
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_TRUE(processModeManager.loadPackageErrorMsg_.empty());
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_failed_verify_failed_verifyFlag_not_close_but_pkg_has_header)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.loadPackageErrorMsg_ = "cms verify failed. verifyFlag is not [Close], verifyFlag[XXX]";
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_TRUE(processModeManager.loadPackageErrorMsg_.empty());
}

TEST_F(ProcessManagerTest, LoadPackageToDeviceByConfig_failed_verify_failed_signature_verification_failed)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface)
        .stubs()
        .will(returnValue(true));
    MOCKER(drvHdcGetTrustedBasePathV2).stubs().will(returnValue(0));
    MOCKER(drvHdcSendFileV2).stubs().will(returnValue(0));
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    std::string pkgName = "LoadPackageToDeviceByConfig_failed_test";
    PackConfDetail packConfDetail;
    packConfDetail.hostTruePath = "tmp123";
    pkgConInst->configMap_[pkgName] = packConfDetail;
    MOCKER_CPP(&ProcessModeManager::SupportLoadPkg)
        .stubs()
        .will(returnValue(true));
    std::string hashcode = "12345666";
    MOCKER(CalFileSha256HashValue)
        .stubs()
        .will(returnValue(hashcode));
    MOCKER_CPP(&ProcessModeManager::IsCommonSinkHostAndDevicePkgSame).stubs().will(returnValue(false));
    MOCKER_CPP(&ProcessModeManager::CompareAndSendCommonSinkPkg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.loadPackageErrorMsg_ = "cms verify failed. Signature verification failed.";
    auto ret = processModeManager.LoadPackageToDeviceByConfig();
    EXPECT_EQ(ret, tsd::TSD_INTERNAL_ERROR);
    EXPECT_TRUE(processModeManager.loadPackageErrorMsg_.empty());
}

TEST_F(ProcessManagerTest, GetShortSocVersion_Success) 
{ 
    MOCKER(halGetSocVersion).stubs().will(invoke(halGetSocVersionStub)); 
    using GetPlatformResFnT = bool (fe::PlatFormInfos::*)(const std::string&, const std::string&, std::string&);
    MOCKER_CPP(static_cast<GetPlatformResFnT>(&fe::PlatFormInfos::GetPlatformRes))
        .stubs()
        .will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0); 
    std::string shortSocVersion;
    const auto ret = processModeManager.GetShortSocVersion(shortSocVersion); 
    EXPECT_EQ(ret, true); 
}

TEST_F(ProcessManagerTest, GetShortSocVersion_halGetSocVersionFailed_Failed) 
{ 
    MOCKER(halGetSocVersion).stubs().will(returnValue(1)); 
    ProcessModeManager processModeManager(deviceId, 0); 
    std::string shortSocVersion;
    const auto ret = processModeManager.GetShortSocVersion(shortSocVersion); 
    EXPECT_EQ(ret, false); 
}

TEST_F(ProcessManagerTest, GetShortSocVersion_GetPlatformInfos_Failed)
{
    MOCKER(halGetSocVersion).stubs().will(invoke(halGetSocVersionStub));
    MOCKER_CPP(&fe::PlatFormInfos::GetPlatformRes,
        bool (fe::PlatFormInfos::*)(const std::string& label, const std::string& key, std::string& val))
        .stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string shortSocVersion;
    const auto ret = processModeManager.GetShortSocVersion(shortSocVersion);
    EXPECT_EQ(ret, false);
}

TEST_F(ProcessManagerTest, GetDriverVersion)
{
    uint64_t result = 1UL;
    uint64_t *ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    ProcessModeManager processModeManager(deviceId, 0);
    EXPECT_TRUE(processModeManager.UseStoredCapabityInfo(TSD_CAPABILITY_DRIVER_VERSION, ptrRes));
    EXPECT_EQ(result, 0UL);
    GlobalMockObject::verify();
}

// ============================================================================
// 插件包(compat plugin)版本兼容机制 UT
// ============================================================================

namespace {
    // 在 /tmp 下生成一个临时 ini 文件，调用方负责删除
    std::string MakeTempIniFile(const std::string &content)
    {
        char path[] = "/tmp/plugin_pkg_ut_XXXXXX";
        int fd = mkstemp(path);
        if (fd < 0) {
            return "";
        }
        if (!content.empty()) {
            (void)write(fd, content.data(), content.size());
        }
        close(fd);
        return std::string(path);
    }
}

TEST_F(ProcessManagerTest, PluginVersion_CompareVersion_NumericSegments)
{
    using tsd::PluginPkgVersionUtil;
    EXPECT_EQ(PluginPkgVersionUtil::CompareVersion("8.5.0", "8.5.0"), 0);
    EXPECT_LT(PluginPkgVersionUtil::CompareVersion("8.5.0", "8.5.1"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareVersion("8.10.0", "8.5.0"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareVersion("9.0.0", "8.99.99"), 0);
    // 长度不同：8.5 vs 8.5.0 等价
    EXPECT_EQ(PluginPkgVersionUtil::CompareVersion("8.5", "8.5.0"), 0);
}

TEST_F(ProcessManagerTest, PluginVersion_CompareVersion_NonNumericFallback)
{
    using tsd::PluginPkgVersionUtil;
    // 非纯数字段降级为字典序
    EXPECT_LT(PluginPkgVersionUtil::CompareVersion("8.a", "8.b"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareVersion("8.b", "8.a"), 0);
    EXPECT_EQ(PluginPkgVersionUtil::CompareVersion("8.a", "8.a"), 0);
}

TEST_F(ProcessManagerTest, PluginVersion_CompareTimestamp)
{
    using tsd::PluginPkgVersionUtil;
    EXPECT_EQ(PluginPkgVersionUtil::CompareTimestamp("20260114_115609804", "20260114_115609804"), 0);
    EXPECT_LT(PluginPkgVersionUtil::CompareTimestamp("20260114_115609804", "20260115_115609804"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareTimestamp("20260114_115609805", "20260114_115609804"), 0);
}

TEST_F(ProcessManagerTest, PluginVersion_Compare_VersionThenTimestamp)
{
    using tsd::PluginPkgVersionUtil;
    tsd::PluginPkgVersion a{"8.5.0", "20260114_115609804"};
    tsd::PluginPkgVersion b{"8.5.0", "20260114_115609804"};
    EXPECT_EQ(PluginPkgVersionUtil::Compare(a, b), 0);

    tsd::PluginPkgVersion newerV{"8.5.1", "20260101_000000000"};
    EXPECT_GT(PluginPkgVersionUtil::Compare(newerV, a), 0);
    EXPECT_LT(PluginPkgVersionUtil::Compare(a, newerV), 0);

    tsd::PluginPkgVersion newerTs{"8.5.0", "20270101_000000000"};
    EXPECT_GT(PluginPkgVersionUtil::Compare(newerTs, a), 0);
}

TEST_F(ProcessManagerTest, PluginVersion_ParseLine)
{
    using tsd::PluginPkgVersionUtil;
    std::string k, v;
    EXPECT_TRUE(PluginPkgVersionUtil::ParseLine("version=8.5.0", k, v));
    EXPECT_EQ(k, "version");
    EXPECT_EQ(v, "8.5.0");
    EXPECT_TRUE(PluginPkgVersionUtil::ParseLine("  timestamp = 20260114_115609804  ", k, v));
    EXPECT_EQ(k, "timestamp");
    EXPECT_EQ(v, "20260114_115609804");
    // 注释 / 空行 / 非法行
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("# comment", k, v));
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("", k, v));
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("no_equal_sign", k, v));
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("=onlyvalue", k, v));
}

TEST_F(ProcessManagerTest, PluginVersion_GetIniNameByPkgName)
{
    using tsd::PluginPkgVersionUtil;
    EXPECT_EQ(PluginPkgVersionUtil::GetIniNameByPkgName("cann-hcomm-compat.tar.gz"), "cann-hcomm-compat.ini");
    EXPECT_EQ(PluginPkgVersionUtil::GetIniNameByPkgName("cann-tsch-compat.tar.gz"), "cann-tsch-compat.ini");
    // 没有 .tar.gz 后缀也能兜底
    EXPECT_EQ(PluginPkgVersionUtil::GetIniNameByPkgName("foo"), "foo.ini");
}

TEST_F(ProcessManagerTest, PluginVersion_ParseIniFile_Success)
{
    using tsd::PluginPkgVersionUtil;
    std::string path = MakeTempIniFile("# header comment\nversion=8.5.0\ntimestamp=20260114_115609804\n");
    ASSERT_FALSE(path.empty());
    tsd::PluginPkgVersion info;
    EXPECT_TRUE(PluginPkgVersionUtil::ParseIniFile(path, info));
    EXPECT_EQ(info.version, "8.5.0");
    EXPECT_EQ(info.timestamp, "20260114_115609804");
    EXPECT_FALSE(info.Empty());
    (void)remove(path.c_str());
}

TEST_F(ProcessManagerTest, PluginVersion_ParseIniFile_MissingVersion)
{
    using tsd::PluginPkgVersionUtil;
    std::string path = MakeTempIniFile("timestamp=20260114_115609804\n");
    ASSERT_FALSE(path.empty());
    tsd::PluginPkgVersion info;
    EXPECT_FALSE(PluginPkgVersionUtil::ParseIniFile(path, info));
    (void)remove(path.c_str());
}

TEST_F(ProcessManagerTest, PluginVersion_ParseIniFile_FileNotExist)
{
    using tsd::PluginPkgVersionUtil;
    tsd::PluginPkgVersion info;
    EXPECT_FALSE(PluginPkgVersionUtil::ParseIniFile("/tmp/path_must_not_exist_xxxxxx_abc.ini", info));
}

TEST_F(ProcessManagerTest, PluginVersion_ParseIniFile_KeyCaseInsensitive)
{
    using tsd::PluginPkgVersionUtil;
    // Version / TIMESTAMP / 混合大小写均应被识别
    std::string path = MakeTempIniFile("Version=8.5.0\nTIMESTAMP=20260114_115609804\n");
    ASSERT_FALSE(path.empty());
    tsd::PluginPkgVersion info;
    EXPECT_TRUE(PluginPkgVersionUtil::ParseIniFile(path, info));
    EXPECT_EQ(info.version, "8.5.0");
    EXPECT_EQ(info.timestamp, "20260114_115609804");
    (void)remove(path.c_str());
}

TEST_F(ProcessManagerTest, PluginVersion_IsCompatPluginPackage)
{
    ProcessModeManager pm(deviceId, 0);
    tsd::PackConfDetail detail;
    detail.decDstDir = tsd::DeviceInstallPath::COMPAT_PLUGIN_PATH;
    EXPECT_TRUE(pm.IsCompatPluginPackage(detail));
    detail.decDstDir = tsd::DeviceInstallPath::AICPU_KERNELS_PATH;
    EXPECT_FALSE(pm.IsCompatPluginPackage(detail));
    detail.decDstDir = tsd::DeviceInstallPath::OM_PATH;
    EXPECT_FALSE(pm.IsCompatPluginPackage(detail));
}

TEST_F(ProcessManagerTest, PluginVersion_GetPluginUpdateStrategy_DrvNotForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlag0));
    EXPECT_EQ(pm.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    // 第二次调用走缓存
    EXPECT_EQ(pm.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    EXPECT_TRUE(pm.hasComputedPluginStrategy_);
}

TEST_F(ProcessManagerTest, PluginVersion_GetPluginUpdateStrategy_DrvForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlag1));
    EXPECT_EQ(pm.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_FORCE_UPDATE);
    EXPECT_TRUE(pm.hasComputedPluginStrategy_);
}

TEST_F(ProcessManagerTest, PluginVersion_GetPluginUpdateStrategy_DrvNoUpdate)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlag2));
    EXPECT_EQ(pm.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_NO_UPDATE);
    EXPECT_TRUE(pm.hasComputedPluginStrategy_);
}

TEST_F(ProcessManagerTest, PluginVersion_GetPluginUpdateStrategy_DrvFail_FallbackNotForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    EXPECT_EQ(pm.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    // 失败不缓存，可重新尝试
    EXPECT_FALSE(pm.hasComputedPluginStrategy_);
}

TEST_F(ProcessManagerTest, PluginVersion_GetPluginUpdateStrategy_DrvInvalidValue_FallbackNotForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoPluginFlagInvalid));
    EXPECT_EQ(pm.GetPluginUpdateStrategy(), tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE);
    EXPECT_FALSE(pm.hasComputedPluginStrategy_);
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_NoUpdateStrategy)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NO_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    EXPECT_FALSE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_DrvFail_FallbackNotForce)
{
    ProcessModeManager pm(deviceId, 0);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.4.0", "20260114_115609804"};
    // DRV 失败退化为 NOT_FORCE_UPDATE 走版本比较：host 新于 device 需装包
    EXPECT_TRUE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_ForceUpdate)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    // FORCE_UPDATE 也走 checkcode 兑底：hash 不一致时才下发
    pm.pkgHostHashValue_["cann-hcomm-compat.tar.gz"] = "hash_host";
    pm.pkgDeviceHashValue_["cann-hcomm-compat.tar.gz"] = "hash_dev";
    EXPECT_TRUE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_ForceUpdate_HashSame)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    // FORCE_UPDATE 但 host/device checkcode 一致 => 不下发
    pm.pkgHostHashValue_["cann-hcomm-compat.tar.gz"] = "same";
    pm.pkgDeviceHashValue_["cann-hcomm-compat.tar.gz"] = "same";
    EXPECT_FALSE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_DeviceVersionEmpty)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    // device 侧未上报该包版本号 => 回落到 checkcode 比较
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"", ""};
    pm.pkgHostHashValue_["cann-hcomm-compat.tar.gz"] = "hash_host";
    pm.pkgDeviceHashValue_["cann-hcomm-compat.tar.gz"] = "hash_dev";
    EXPECT_TRUE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_DeviceVersionEmpty_HashSame)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"", ""};
    // device 未上报版本，但 checkcode 一致（上轮已下发同版本包）=> 不重复下发
    pm.pkgHostHashValue_["cann-hcomm-compat.tar.gz"] = "same";
    pm.pkgDeviceHashValue_["cann-hcomm-compat.tar.gz"] = "same";
    EXPECT_FALSE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_HostNewer)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.1", "20260114_115609804"};
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    EXPECT_TRUE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_HostOlder)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.4.0", "20260114_115609804"};
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    EXPECT_FALSE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_SameVersion_SkipDirectly)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    // 版本+时间戳完全相等：不再回落 checkcode，直接跳过下发
    pm.pkgHostHashValue_["cann-hcomm-compat.tar.gz"] = "hash_host";
    pm.pkgDeviceHashValue_["cann-hcomm-compat.tar.gz"] = "hash_dev";
    EXPECT_FALSE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ShouldLoadCompatPluginPkg_HostIniMissing)
{
    ProcessModeManager pm(deviceId, 0);
    pm.pluginUpdateStrategy_ = tsd::PluginUpdateStrategy::PLUGIN_NOT_FORCE_UPDATE;
    pm.hasComputedPluginStrategy_ = true;
    pm.devicePluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    // 不写入 hostPluginVersions_，模拟 .ini 缺失 → 跳过下发 + WARN
    pm.pkgHostHashValue_["cann-hcomm-compat.tar.gz"] = "h1";
    pm.pkgDeviceHashValue_["cann-hcomm-compat.tar.gz"] = "h2";
    EXPECT_FALSE(pm.ShouldLoadCompatPluginPkg("cann-hcomm-compat.tar.gz"));
}

TEST_F(ProcessManagerTest, PluginVersion_ConstructOpenMsg_DoesNotCarryPluginInfo)
{
    // openmsg 不携带任何插件包版本信息，该信息仅通过专用查询消息传递
    ProcessModeManager pm(deviceId, 0);
    PackageProcessConfig::GetInstance()->hostPluginVersions_["cann-hcomm-compat.tar.gz"] = {"8.5.0", "20260114_115609804"};
    HDCMessage hdcMsg;
    TsdStartStatusInfo info{true, true, false};
    EXPECT_EQ(pm.ConstructOpenMsg(hdcMsg, info), tsd::TSD_OK);
    EXPECT_EQ(hdcMsg.device_plugin_versions_size(), 0);
}
