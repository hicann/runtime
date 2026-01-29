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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd/status.h"
#define private public
#define protected public
#include "inc/process_util_common.h"
#include "inc/package_process_config.h"
#include "inc/client_manager.h"
#include "inc/process_mode_manager.h"
#include "inc/hdc_client.h"
#include "src/env_internal_api.h"
#include "inc/domain_socket_client.h"
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

void GetScheduleEnvStub1(const char_t * const envName, std::string &envValue)
{
    envValue = "1";
}

void GetScheduleEnvStub2(const char_t * const envName, std::string &envValue)
{
    envValue = "";
}

void GetScheduleEnvStub3(const char_t * const envName, std::string &envValue)
{
    envValue = "16b";
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

    drvError_t halGetDeviceInfoFake(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        *value = 2 << 8U;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoFake2(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        *value = 1024;
        cout <<"enter halGetDeviceInfoFake2"<< endl;
        return DRV_ERROR_NONE;
    }

    drvError_t drvGetPlatformInfoFake(uint32_t *info)
    {
        cout <<"enter drvGetPlatformInfoFake"<< endl;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoFakeZero(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        *value = 0;
        return DRV_ERROR_NONE;
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
    const uint32_t deviceIdChipMode = 3;
    MOCKER_CPP(&ProcessModeManager::CheckNeedToOpen)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::GetDeviceIdForChipMode)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
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
    int32_t type = 0;
    uint64_t ptr = 0UL;
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&(processModeManager.hdcTsdClient_->Init))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&(processModeManager.hdcTsdClient_->CreateHdcSession))
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
    MOCKER_CPP(&ProcessModeManager::WaitRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCapabilityMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.tsdStartStatus_.startCp_ = true;
    MOCKER_CPP(&(processModeManager.hdcTsdClient_->Init))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&(processModeManager.hdcTsdClient_->CreateHdcSession))
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
    tsd::TSD_StatusT ret = client->GetPackageTitle(packageTitle);
    EXPECT_EQ(packageTitleRes, packageTitle);
    GlobalMockObject::verify();
}


TEST_F(ProcessManagerTest, GetDeviceCheckCodeNoRspSuc)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    HDC_SESSION session = nullptr;
    processModeManager.hdcTsdClient_->hdcClientSessionMap_[0U] = session;
    processModeManager.hdcTsdClient_->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&HdcCommon::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));

    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeNoRspSuc2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    HDC_SESSION session = nullptr;
    processModeManager.hdcTsdClient_->hdcClientSessionMap_[0U] = session;
    processModeManager.hdcTsdClient_->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&HdcCommon::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 456U;
    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeFail002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    HDC_SESSION session = nullptr;
    processModeManager.hdcTsdClient_->hdcClientSessionMap_[0U] = session;
    processModeManager.hdcTsdClient_->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
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
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));
    processModeManager.packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)] = 456U;
    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, waitRspCloseNoRsp)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(13U));
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, waitRspFail001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30003";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT);
}

TEST_F(ProcessManagerTest, waitRspFail002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30004";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_SUBPROCESS_BINARY_FILE_DAMAGED);
}

TEST_F(ProcessManagerTest, waitRspFail003)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30006";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_VERIFY_OPP_FAIL);
}

TEST_F(ProcessManagerTest, waitRspFail004)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));
    processModeManager.startOrStopFailCode_ = "E30007";
    tsd::TSD_StatusT ret = processModeManager.WaitRsp(0U, false, true);
    EXPECT_EQ(ret, tsd::TSD_ADD_AICPUSD_TO_CGROUP_FAILED);
}

TEST_F(ProcessManagerTest, InitDomainSocketClient_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&DomainSocketClient::Init)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&DomainSocketClient::TsdRecvData)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.InitDomainSocketClient();
    ret = processModeManager.WaitHostRsp();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, SendOpenMsgInHost_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::ConstructOpenMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.InitDomainSocketClient();
    ret = processModeManager.SendOpenMsgInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, SendOpenMsgInHost_Fail_001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::ConstructOpenMsg)
        .stubs()
        .will(returnValue(1));
    auto ret = processModeManager.SendOpenMsgInHost();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, SendOpenMsgInHost_Fail_002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::ConstructOpenMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(1));
    auto ret = processModeManager.InitDomainSocketClient();
    ret = processModeManager.SendOpenMsgInHost();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, OpenInHost_fail_3)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitDomainSocketClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsgInHost)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.OpenInHost();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, OpenInHost_fail_4)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitDomainSocketClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsgInHost)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(1));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.OpenInHost();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, OpenInHost_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitDomainSocketClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsgInHost)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.OpenInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, OpenInHost_fail_1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(1));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::InitDomainSocketClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendOpenMsgInHost)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    auto ret = processModeManager.OpenInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, CloseInHost_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCloseMsgInHost)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    processModeManager.initHostFlag_ = true;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    auto ret = processModeManager.CloseInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, CloseInHost_fail_1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(false));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    processModeManager.initHostFlag_ = true;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    auto ret = processModeManager.CloseInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, CloseInHost_fail_2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCloseMsgInHost)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    processModeManager.initHostFlag_ = false;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    auto ret = processModeManager.CloseInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, CloseInHost_fail_3)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCloseMsgInHost)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    processModeManager.initHostFlag_ = true;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    auto ret = processModeManager.CloseInHost();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, CloseInHost_fail_4)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ProcessModeManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(access).stubs()
        .will(returnValue(0));
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::SendCloseMsgInHost)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitHostRsp)
        .stubs()
        .will(returnValue(1));
    processModeManager.rspCode_ = ResponseCode::SUCCESS;
    processModeManager.initHostFlag_ = true;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    auto ret = processModeManager.CloseInHost();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, GetDeviceIdForChipMode_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(halGetDeviceCountFromChip).stubs()
        .will(returnValue(0));

    MOCKER(halGetDeviceFromChip).stubs()
        .will(returnValue(0));
    auto ret = processModeManager.GetDeviceIdForChipMode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetDeviceIdForChipMode_fail_1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(halGetDeviceCountFromChip).stubs()
        .will(returnValue(1));
    auto ret = processModeManager.GetDeviceIdForChipMode();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, GetDeviceIdForChipMode_fail_2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(halGetDeviceCountFromChip).stubs()
        .will(returnValue(0));
    MOCKER(halGetDeviceFromChip).stubs()
        .will(returnValue(1));
    auto ret = processModeManager.GetDeviceIdForChipMode();
    EXPECT_EQ(ret, tsd::TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, ConstructCloseMsg_test)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    auto ret = processModeManager.ConstructCloseMsg(msg);
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, SendCloseMsgInHost_01)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    auto ret = processModeManager.SendCloseMsgInHost();
    EXPECT_EQ(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, SendCloseMsgInHost_02)
{
    ProcessModeManager processModeManager(deviceId, 0);
    HDCMessage msg;
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    MOCKER_CPP(&DomainSocketClient::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::ConstructCloseMsg)
        .stubs()
        .will(returnValue(1));
    auto ret = processModeManager.SendCloseMsgInHost();
    EXPECT_NE(ret, tsd::TSD_OK);
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
    processModeManager.domainSocketClientPtr_ = DomainSocketClient::GetInstance(0U);
    auto ret = processModeManager.ProcessQueueForAdc();
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(ProcessManagerTest, GetLogLevel_Success_001)
{
    char *env = "1";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "101");
}

TEST_F(ProcessManagerTest, GetLogLevel_Success_002)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    char *env = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessManagerTest, GetLogLevel_Success_003)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    char *env = "16b";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessManagerTest, GetLogLevel_Excpetion_004)
{
    int32_t logLevel = 4;
    MOCKER(dlog_getlevel).stubs().will(returnValue(logLevel));
    MOCKER(&mmSysGetEnv).stubs().will(returnValue(nullptr));
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.GetLogLevel();
    EXPECT_EQ(processModeManager.logLevel_, "104");
}

TEST_F(ProcessManagerTest, GetAscendLatestIntallPath_Succ)
{
    char *env = "/usr/local/Asend/lastest";
    MOCKER(&mmSysGetEnv).stubs().will(returnValue(env));
    ProcessModeManager processModeManager(deviceId, 0);
    std::string pkgBasePath;
    processModeManager.GetAscendLatestIntallPath(pkgBasePath);
    EXPECT_EQ(pkgBasePath, "/usr/local/Asend/lastest");
}

TEST_F(ProcessManagerTest, LoadRuntimePkgToDevice_Succ)
{
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(0U));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadRuntimePkgToDevice_Fail)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    processModeManager.SetPlatInfoChipType(0);
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    processModeManager.SetPlatInfoChipType(CHIP_ASCEND_910B);
    processModeManager.tsdSupportLevel_ = 1U;
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(1U));
    auto ret = processModeManager.IsSupportHeterogeneousInterface();
    EXPECT_EQ(ret, true);
    processModeManager.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    ret = processModeManager.IsSupportHeterogeneousInterface();
    EXPECT_NE(ret, true);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, IsSupportHeterogeneousInterface_FAIL)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.SetPlatInfoChipType(0);
    processModeManager.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    processModeManager.SetPlatInfoChipType(0);
    processModeManager.tsdSupportLevel_ = 0U;
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    MOCKER_CPP(&ProcessUtilCommon::CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    MOCKER_CPP(&ProcessUtilCommon::CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    MOCKER_CPP(&ProcessUtilCommon::CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    MOCKER_CPP(&ProcessUtilCommon::CalFileSha256HashValue).stubs().will(returnValue(hashVal));
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    processModeManager.rspCode_ = ResponseCode::FAIL;

    auto ret = processModeManager.LoadRuntimePkgToDevice();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, CapabilityGet_capablity)
{
    ProcessModeManager processModeManager(deviceId, 0);
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
    MOCKER_CPP(&(processModeManager.hdcTsdClient_->Init))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&(processModeManager.hdcTsdClient_->CreateHdcSession))
        .stubs()
        .will(returnValue(tsd::TSD_OK));
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
    if (errorInfo == nullptr) {
        return TSD_INTERNAL_ERROR;
    }
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
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(mmAccess).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(mmIsDir).stubs().will(returnValue(EN_OK));
    MOCKER(tsd::CalFileSize).stubs().will(returnValue(0U));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.LoadDShapePkgToDevice();
    EXPECT_EQ(ret, TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, LoadDShapePkgToDevice_Fail)
{
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(true));
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    char_t fileName = "";
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.IsOkToLoadFileToDevice(&fileName, 1U);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    ProcessModeManager processModeManager(deviceId, 0);
    pid_t pid[1] = {10};
    openArg.subPid = pid;
    uint32_t curPid = 13768;
    processModeManager.openSubPid_ = curPid;
    auto ret = processModeManager.ProcessOpenSubProc(&openArg);
    EXPECT_EQ(ret, tsd::TSD_OK);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    processModeManager.tsdSupportLevel_ = 4U;
    ret = processModeManager.ProcessCloseSubProcList(&closeList[0], listSize);
    EXPECT_EQ(ret, 1U);
    processModeManager.Destroy();
}

TEST_F(ProcessManagerTest, ProcessCloseSubProc001)
{
    pid_t pid;
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
    char_t filePath = "";
    MOCKER(tsd::CheckValidatePath).stubs().will(returnValue(true));
    MOCKER_CPP(&ProcessModeManager::IsSupportHeterogeneousInterface).stubs().will(returnValue(false));
    ProcessModeManager processModeManager(deviceId, 0);
    auto ret = processModeManager.RemoveFileOnDevice(&filePath, 1U);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    ProcStatusParam pidInfo;
    pidInfo.procType = TSD_SUB_PROC_COMPUTE;
    auto ret = processModeManager.GetSubProcListStatus(&pidInfo, 1U);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, GetCurDriverPkgVersion_03)
{
    uint64_t result = 0;
    uint64_t *ptr = &result;
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER(&halGetAPIVersion).stubs().will(returnValue(1));
    auto ret = processModeManager.GetCurDriverPkgVersion(0UL);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(-1));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(-1));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    MOCKER(open, int(const char*, int)).stubs().will(returnValue(0));
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    processModeManager.GetDeviceCheckCodeRetrySupport();
    GlobalMockObject::verify();
    EXPECT_EQ(deviceId, 0);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetrySupport002)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    processModeManager.tsdSessionId_ = 1U;
    processModeManager.GetDeviceCheckCodeRetrySupport();
    GlobalMockObject::verify();
    EXPECT_EQ(deviceId, 0);
}

TEST_F(ProcessManagerTest, GetDeviceCheckCodeRetry001)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(1U));
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    HDC_SESSION session = nullptr;
    processModeManager.hdcTsdClient_->hdcClientSessionMap_[0U] = session;
    processModeManager.hdcTsdClient_->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
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
    MOCKER_CPP(&HdcCommon::SendMsg)
        .stubs()
        .will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::TsdRecvData)
        .stubs()
        .will(returnValue(1U));

    tsd::TSD_StatusT ret = processModeManager.GetDeviceCheckCode();
    EXPECT_EQ(ret, tsd::TSD_OK);
}


TEST_F(ProcessManagerTest, LoadSysOpKernel_Extend)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.aicpuPackageExistInDevice_ = false;
    processModeManager.tsdSessionId_ = 0U;
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    HDC_SESSION session = nullptr;
    processModeManager.hdcTsdClient_->hdcClientSessionMap_[0U] = session;
    processModeManager.hdcTsdClient_->hdcClientVerifyMap_[0U] = std::make_shared<VersionVerify>();
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
    MOCKER_CPP(&HdcCommon::SendMsg)
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcCommon::SendMsg).stubs().will(returnValue(TSD_OK));
    const auto ret = processModeManager.SendUpdateProfilingMsg(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendUpdateProfilingMsgFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcCommon::SendMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.SendUpdateProfilingMsg(0);
    EXPECT_EQ(ret, TSD_CLT_UPDATE_PROFILING_FAILED);
}

TEST_F(ProcessManagerTest, CloseSuccess2)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&ProcessModeManager::SendCloseMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::CloseInHost).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.Close(0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, WaitRspFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.WaitRsp(10, false, true);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, WaitRspFail1)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcClient::TsdRecvData).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.rspCode_ = ResponseCode::FAIL;
    processModeManager.initFlag_ = true;
    processModeManager.errMsg_ = "testlog";
    const auto ret = processModeManager.WaitRsp(10, false, true);
    EXPECT_EQ(ret, TSD_CLT_OPEN_FAILED);
}

TEST_F(ProcessManagerTest, SendCloseMsgSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcCommon::SendMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.SendCloseMsg();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(ProcessManagerTest, SendCloseMsgConstructFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&ProcessModeManager::ConstructCloseMsg).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&HdcCommon::SendMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.SendCloseMsg();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, SendCloseMsgSendFail)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&HdcCommon::SendMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    processModeManager.initFlag_ = true;
    const auto ret = processModeManager.SendCloseMsg();
    EXPECT_EQ(ret, TSD_CLT_CLOSE_FAILED);
}

TEST_F(ProcessManagerTest, UpdateProfilingConfSuccess)
{
    ProcessModeManager processModeManager(deviceId, 0);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    processModeManager.tsdSupportLevel_ = 0;
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_OK)));
    MOCKER_CPP(&ProcessModeManager::SendCapabilityMsg).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.IsSupportCommonInterface(0);
    EXPECT_EQ(ret, false);
}

TEST_F(ProcessManagerTest, GetDeviceHsPkgCheckCodeInitClientFail)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
    MOCKER_CPP(&ProcessModeManager::InitTsdClient).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = processModeManager.GetDeviceHsPkgCheckCode(0U, 0, false);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ProcessManagerTest, OpenHccpLogLevel)
{
    ProcessModeManager processModeManager(deviceId, PROCESS_MODE);
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    processModeManager.hdcTsdClient_ = nullptr;
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
    processModeManager.hdcTsdClient_ = nullptr;
    MOCKER_CPP(&ClientManager::IsAdcEnv)
        .stubs()
        .will(returnValue(false));
    processModeManager.GetHdcConctStatus(hdcSessStat);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CLOSE);
}

TEST_F(ProcessManagerTest, GetCurDriverPkgVersion_VersionNok)
{
    uint64_t result = 0;
    uint64_t *ptr = &result;
    uint64_t ptrRes = static_cast<uint64_t>((reinterpret_cast<uintptr_t>(ptr)));
    ProcessModeManager processModeManager(deviceId, 0);
    MOCKER_CPP(&ClientManager::GetDriverVersion).stubs().will(returnValue(1));
    auto ret = processModeManager.GetCurDriverPkgVersion(ptrRes);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
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
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
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
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    EXPECT_EQ(processModeManager.OpenNetService(nullptr), TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(ProcessManagerTest, CloseNetService_01)
{
    ProcessModeManager processModeManager(0U, 0);
    MOCKER_CPP(&ProcessModeManager::IsSupportCommonInterface).stubs().will(returnValue(true));
    MOCKER_CPP(&HdcClient::Init).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::CreateHdcSession).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&HdcClient::SendMsg, tsd::TSD_StatusT(HdcClient::*)(const uint32_t, const HDCMessage&, const bool))
        .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER_CPP(&ProcessModeManager::WaitRsp).stubs().will(returnValue(tsd::TSD_OK));
    processModeManager.hdcTsdClient_ = HdcClient::GetInstance(deviceId, HDCServiceType::TSD);
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
    MOCKER_CPP(&ProcessUtilCommon::CalFileSha256HashValue)
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

TEST_F(ProcessManagerTest, GetCurHostMutexFile)
{
    ProcessModeManager processModeManager(deviceId, 0);

    EXPECT_EQ(processModeManager.GetCurHostMutexFile(false), "libqueue_schedule.so");

    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(processModeManager.GetCurHostMutexFile(true), "libqueue_schedule.so");

    EXPECT_EQ(processModeManager.GetCurHostMutexFile(true), "sink_file_mutex_0.cfg");
}