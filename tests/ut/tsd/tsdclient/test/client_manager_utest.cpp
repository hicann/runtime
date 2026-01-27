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

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "tsd/status.h"

#define private public
#define protected public
#include "inc/client_manager.h"
#include "inc/process_mode_manager.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

namespace
{
std::mutex g_mmpaMutex;
mmDirent2** g_List;
INT32 mmScandir2_invoke(const CHAR *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    g_List = (mmDirent2**)malloc(sizeof(mmDirent2*) * 1);
    g_List[0] = (mmDirent2*)malloc(sizeof(mmDirent2));
    char name[256] = "Ascend310-aicpu_syskernels.tar.gz";
    strcpy(g_List[0]->d_name, name);
    // g_List[0]->d_name = name;
    *entryList = g_List;
    return 1;
}
void mmScandirFree2_invoke(mmDirent2 **entryList, INT32 count)
{
    free(g_List[0]);
    g_List[0] = nullptr;
    free(g_List);
    g_List = nullptr;
}
INT32 mmScandir2_invokeExtend(const CHAR *path, mmDirent2 ***entryList, mmFilter2 filterFunc, mmSort2 sort)
{
    g_List = (mmDirent2**)malloc(sizeof(mmDirent2*) * 2);
    g_List[0] = (mmDirent2*)malloc(sizeof(mmDirent2));
    g_List[1] = (mmDirent2*)malloc(sizeof(mmDirent2));
    char name[256] = "Ascend-aicpu_extend_syskernels.tar.gz";
    char name2[256] = "Ascend-aicpu_syskernels.tar.gz";
    strcpy(g_List[0]->d_name, name);
    strcpy(g_List[1]->d_name, name2);
    *entryList = g_List;
    return 2;
}
void mmScandirFree2_invokeExtend(mmDirent2 **entryList, INT32 count)
{
    free(g_List[0]);
    g_List[0] = nullptr;
    free(g_List[1]);
    g_List[1] = nullptr;
    free(g_List);
    g_List = nullptr;
}
int32_t drvGetPlatformInfo_invoke(uint32_t *info)
{
    *info = 1;

    return 0;
}

int32_t halGetDeviceInfo_invoke(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    *value = 1280;

    return 0;
}

bool GetConfigIniValueInt32RetProcessMode(const std::string &fileName, const std::string &key, int32_t &val)
{
    val = static_cast<int32_t>(RunningMode::PROCESS_MODE);
    return true;
}

bool GetConfigIniValueInt32RetAicpuThreadMode(const std::string &fileName, const std::string &key, int32_t &val)
{
    val = static_cast<int32_t>(RunningMode::AICPU_THREAD_MODE);
    return true;
}

drvError_t fake_drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 8;
    return DRV_ERROR_NONE;
}
 
drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if ((moduleType == MODULE_TYPE_SYSTEM) && (infoType == INFO_TYPE_VERSION)) {
        *value = CHIP_ASCEND_910A << 8;
    }
    return DRV_ERROR_NONE;
}
}

class ClientManagerTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before TsdClientTest" << endl;
        MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
        ClientManager::ResetPlatInfoFlag();
    }

    virtual void TearDown()
    {
        cout << "After TsdClientTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(ClientManagerTest, CheckPackageExistsNoMatch)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    //MOCKER(mmScandir2).stubs().will(returnValue(0));
    //MOCKER(mmScandirFree2).stubs().will(returnValue(0));
    bool ret = ClientManager::GetInstance(0)->CheckPackageExists();
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, CheckPackageExistsNoMatch2)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    MOCKER(mmScandir2).stubs().will(returnValue(-1));
    bool ret = ClientManager::GetInstance(0)->CheckPackageExists();
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, CheckPackageExistsMatch)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    MOCKER(mmScandir2).stubs().will(invoke(mmScandir2_invoke));
    MOCKER(mmScandirFree2).stubs().will(invoke(mmScandirFree2_invoke));
    bool ret = ClientManager::GetInstance(0)->CheckPackageExists();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, GetPackagePathSucc)
{
    char *envpath = "/home";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(envpath));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    std::string env = "";
    ClientManager::GetInstance(0)->GetPackagePath(env, 0U);
    EXPECT_EQ(env, "/home/opp/Ascend310/aicpu/");
}

TEST_F(ClientManagerTest, GetPlatInfoModeSuc1)
{
    auto instance = ClientManager::GetInstance(0);
    uint32_t platInfoMode = instance->GetPlatInfoMode();
    EXPECT_EQ(platInfoMode, 1);
}

TEST_F(ClientManagerTest, GetInstance1)
{
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(drvGetPlatformInfo).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(10));
}
 
TEST_F(ClientManagerTest, GetInstance2)
{
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(101));
}

TEST_F(ClientManagerTest, GetInstance3)
{
    std::string valueStr("PROCESS_MODE");
    ClientManager::SetRunMode(valueStr);
    uint32_t runMode = static_cast<uint32_t>(ClientManager::g_runningMode);
    EXPECT_EQ(1, runMode);
    EXPECT_NE(nullptr, ClientManager::GetInstance(2));
}

TEST_F(ClientManagerTest, GetInstance4)
{
    std::string valueStr("THREAD_MODE");
    ClientManager::SetRunMode(valueStr);
    uint32_t runMode = static_cast<uint32_t>(ClientManager::g_runningMode);
    EXPECT_EQ(2, runMode);
    EXPECT_NE(nullptr, ClientManager::GetInstance(3));
}

TEST_F(ClientManagerTest, GetInstance5)
{
    std::string valueStr("OTHER_MODE");
    ClientManager::SetRunMode(valueStr);
    uint32_t runMode = static_cast<uint32_t>(ClientManager::g_runningMode);
    EXPECT_EQ(0, runMode);
    EXPECT_NE(nullptr, ClientManager::GetInstance(4));
}

TEST_F(ClientManagerTest, GetInstance6)
{
    MOCKER_CPP(&ClientManager::GetPlatformInfo)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(0)));
    MOCKER_CPP(&ClientManager::GetClientRunMode)
        .stubs()
        .will(returnValue(RunningMode::UNSET_MODE));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(105));
}

TEST_F(ClientManagerTest, GetInstance7)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(1U));
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(TSD_OK));
    EXPECT_EQ(nullptr, ClientManager::GetInstance(106));
}

TEST_F(ClientManagerTest, GetPackageTitle1)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_invoke));
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfo_invoke));

    ClientManager::GetInstance(0)->GetPlatformInfo(0);

    std::string pkgTitle;
    ClientManager::GetInstance(0)->GetPackageTitle(pkgTitle);
    EXPECT_EQ(pkgTitle, "Ascend");
}

TEST_F(ClientManagerTest, GetHdcConctStatusThreadMode)
{
    std::string valueStr("THREAD_MODE");
    ClientManager::SetRunMode(valueStr);
    EXPECT_NE(nullptr, ClientManager::GetInstance(555));
    int32_t hdcSessStat;
    ClientManager::GetInstance(555)->GetHdcConctStatus(hdcSessStat);
}

TEST_F(ClientManagerTest, GetHdcConctStatusProcessMode)
{
    std::string valueStr("PROCESS_MODE");
    ClientManager::SetRunMode(valueStr);
    EXPECT_NE(nullptr, ClientManager::GetInstance(666));
    int32_t hdcSessStat;
    ClientManager::GetInstance(666)->GetHdcConctStatus(hdcSessStat);
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigToThreadMode)
{
    char_t *env = "./tsd";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(realpath).stubs().will(returnValue(env));

    int32_t val = 2;
    MOCKER(GetConfigIniValueInt32).stubs().with(mockcpp::any(), mockcpp::any(), outBound(val))
        .will(returnValue(true));
    RunningMode runningMode = RunningMode::UNSET_MODE;
    EXPECT_TRUE(ClientManager::ResetClientManagerByConfig(runningMode));
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigFailWithoutRunMode)
{
    char_t *env = "./tsd";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(realpath).stubs().will(returnValue(env));

    int32_t val = 4;
    MOCKER(GetConfigIniValueInt32).stubs().with(mockcpp::any(), mockcpp::any(), outBound(val))
        .will(returnValue(true));
    RunningMode runningMode = RunningMode::UNSET_MODE;
    EXPECT_FALSE(ClientManager::ResetClientManagerByConfig(runningMode));
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigFailMemset)
{
    char_t *env = "./tsd";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(memset_s).stubs().will(returnValue(-1));
    RunningMode runningMode = RunningMode::UNSET_MODE;
    EXPECT_FALSE(ClientManager::ResetClientManagerByConfig(runningMode));
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigFailRealpath)
{
    char_t *env = "./tsd";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(memset_s).stubs().will(returnValue(EOK));
    char *a = nullptr;
    MOCKER(realpath)
        .stubs()
        .will(returnValue(a));
    RunningMode runningMode = RunningMode::UNSET_MODE;
    EXPECT_FALSE(ClientManager::ResetClientManagerByConfig(runningMode));
}


TEST_F(ClientManagerTest, GetClientRunMode)
{
    MOCKER_CPP(&ClientManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(true));
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(0U));
    RunningMode mode = ClientManager::GetClientRunMode(0U);
    EXPECT_EQ(mode, RunningMode::THREAD_MODE);
}

TEST_F(ClientManagerTest, GetClientRunMode002)
{
    std::string valueStr("");
    ClientManager::SetRunMode(valueStr);
    MOCKER_CPP(&ClientManager::IsHostEnvironment)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&ClientManager::ResetClientManagerByConfig)
        .stubs()
        .will(returnValue(false));
    ProcessModeManager processModeManager(0, 0);
    processModeManager.SetPlatInfoMode(static_cast<uint32_t>(ModeType::OFFLINE));
    RunningMode mode = ClientManager::GetClientRunMode(0U);
    EXPECT_EQ(mode, RunningMode::THREAD_MODE);
}

TEST_F(ClientManagerTest, CheckPackageExistsMatchExtend)
{
    MOCKER(mmAccess).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    MOCKER(mmScandir2).stubs().will(invoke(mmScandir2_invokeExtend));
    MOCKER(mmScandirFree2).stubs().will(invoke(mmScandirFree2_invokeExtend));
    bool ret = ClientManager::GetInstance(0)->CheckPackageExists();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, GetAicpuThreadModeInstance)
{
    MOCKER_CPP(&ClientManager::GetClientRunMode).stubs().will(returnValue(RunningMode::AICPU_THREAD_MODE));
    const auto inst = ClientManager::GetInstance(199);
    EXPECT_NE(inst, nullptr);
}

TEST_F(ClientManagerTest, CheckPackageExistsFail)
{
    MOCKER_CPP(&ClientManager::GetPackagePath).stubs().will(returnValue(false));
    const bool ret = ClientManager::GetInstance(0)->CheckPackageExists();
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, GetPackagePathFail)
{
    MOCKER_CPP(&ClientManager::GetPackageTitle).stubs().will(returnValue(false));
    std::string kernelPath;
    const bool ret = ClientManager::GetInstance(0)->GetPackagePath(kernelPath, 0U);
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, GetPackageTitleForDefault)
{
    auto instance = ClientManager::GetInstance(0);
    ClientManager::SetPlatInfoChipType(CHIP_END);
    std::string pkgTitle;
    const bool ret = instance->GetPackageTitle(pkgTitle);
    EXPECT_EQ(ret, false);
    EXPECT_STREQ(pkgTitle.c_str(), "");
}

TEST_F(ClientManagerTest, GetPackageTitleForCloud)
{
    auto instance = ClientManager::GetInstance(0);
    ClientManager::SetPlatInfoChipType(CHIP_ASCEND_910A);
    std::string pkgTitle;
    const bool ret = instance->GetPackageTitle(pkgTitle);
    EXPECT_EQ(ret, true);
    EXPECT_STREQ(pkgTitle.c_str(), "Ascend910");
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigGetValFail)
{
    char_t *env = "./tsd_testa";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(realpath).stubs().will(returnValue(env));
    MOCKER_CPP(GetConfigIniValueInt32).stubs().will(returnValue(false));
    RunningMode mode;
    const bool ret = ClientManager::GetInstance(0)->ResetClientManagerByConfig(mode);
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigProcessMode)
{
    char_t *env = "./tsd_testa";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(realpath).stubs().will(returnValue(env));
    MOCKER_CPP(GetConfigIniValueInt32).stubs().will(invoke(GetConfigIniValueInt32RetProcessMode));
    RunningMode mode;
    const bool ret = ClientManager::GetInstance(0)->ResetClientManagerByConfig(mode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(mode, RunningMode::PROCESS_MODE);
}

TEST_F(ClientManagerTest, ResetClientManagerByConfigAicpuThreadMode)
{
    char_t *env = "./tsd_testa";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(realpath).stubs().will(returnValue(env));
    MOCKER_CPP(GetConfigIniValueInt32).stubs().will(invoke(GetConfigIniValueInt32RetAicpuThreadMode));
    RunningMode mode;
    const bool ret = ClientManager::GetInstance(0)->ResetClientManagerByConfig(mode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(mode, RunningMode::PROCESS_MODE);
}

TEST_F(ClientManagerTest, GetClientRunModeFail)
{
    MOCKER_CPP(&ClientManager::IsHostEnvironment).stubs().will(returnValue(true));
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    const auto ret = ClientManager::GetInstance(0)->GetClientRunMode(0);
    EXPECT_EQ(ret, RunningMode::UNSET_MODE);
}

TEST_F(ClientManagerTest, GetDriverVersionFail)
{

    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlsym).stubs().will(returnValue((void*)nullptr));
    uint64_t version;
    const auto ret = ClientManager::GetInstance(0)->GetDriverVersion(&version);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(ClientManagerTest, TestChangeUserDeviceIdToLogicDeviceIdSuccess002)
{
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::GetVisibleDevices).stubs().will(returnValue(true));
    uint32_t userDevId = 1U;
    uint32_t logicDevId = 1U;
    auto ret = ClientManager::ChangeUserDeviceIdToLogicDeviceId(userDevId, logicDevId);
    EXPECT_EQ(ret, TSD_OK);
}
 
TEST_F(ClientManagerTest, TestChangeUserDeviceIdToLogicDeviceIdSuccess001)
{
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    char_t *env = "7,6,5,4";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    uint32_t userDevId = 1;
    uint32_t logicDevId;
    auto ret = ClientManager::ChangeUserDeviceIdToLogicDeviceId(userDevId, logicDevId);
    EXPECT_EQ(logicDevId, 6U);
    
    userDevId = 4;
    ret = ClientManager::ChangeUserDeviceIdToLogicDeviceId(userDevId, logicDevId);
    EXPECT_EQ(ret, TSD_PARAMETER_INVALID);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices01)
{
    char_t *env = "";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices02)
{
    char_t *env = nullptr;
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, false);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices03)
{
    char_t *env = "4,5a,&6,7!";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices04)
{
    char_t *env = ",4,5a,&6,7!";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices05)
{
    char_t *env = "4,5,";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices06)
{
    char_t *env = "4,5,5,7";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices07)
{
    char_t *env = "4,5,6,7,8";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices08)
{
    char_t *env = "4,5,6,7";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestGetVisibleDevices09)
{
    char_t *env = "4,5,2147483648,7";
    MOCKER(mmSysGetEnv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = ClientManager::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}

TEST_F(ClientManagerTest, TestCheckDestructFlag01)
{
    MOCKER_CPP(&ClientManager::GetPlatformInfo)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(1)));
    uint32_t devId = 0U;
    auto ret = ClientManager::CheckDestructFlag(devId);
    EXPECT_EQ(ret, false);
}
 
TEST_F(ClientManagerTest, TestCheckDestructFlag02)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&ClientManager::GetPlatformInfo).stubs().will(returnValue(static_cast<uint32_t>(0)));
    MOCKER_CPP(&ClientManager::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&ClientManager::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(1U));
    uint32_t devId = 0U;
    auto ret = ClientManager::CheckDestructFlag(devId);
    EXPECT_EQ(ret, false);
}
 
TEST_F(ClientManagerTest, TestIsSupportSetVisibleDevices01)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoFake1));
    auto ret = ClientManager::GetPlatformInfo(0U);
    EXPECT_EQ(ret, 0);
    auto supRet = ClientManager::IsSupportSetVisibleDevices();
    EXPECT_EQ(supRet, true);
}