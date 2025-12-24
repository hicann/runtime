/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"

#include "ide_daemon_hdc_stest.h"
#include <vector>
#include "mmpa_stub.h"
#include "ide_platform_stub.h"
#include "ide_daemon_hdc.h"
#include "ide_common_util.h"
#include "adx_dsmi.h"
extern int g_mmSemwait_time;
extern int g_sprintf_s_flag;
extern int g_sprintf_s_flag2;
extern struct IdeGlobalCtrlInfo g_ideGlobalInfo;

extern int HdcDaemonServerRegister(uint32_t num, const std::vector<uint32_t> &dev);
extern int IdeDaemonHdcProcessEventOne(const struct DevSession &devSession);
extern int GetDevCount(uint32_t &devCount, std::vector<uint32_t> &devs);
extern int IdeHdcCheckRunEnv(HDC_SESSION session);
extern void IdeInitGlobalCtrlInfoDev();
extern void IdeDestroyGlobalCtrlInfoDev();
extern int HdcDaemonDestroy();
extern void IdeDestroyGlobalCtrlInfo();
extern IdeThreadArg HdcCreateHdcServerProc(IdeThreadArg args);
extern void IdeInitGlobalCtrlInfo();
extern int IdeDaemonReadReq(const struct IdeTransChannel &handle, IdeTlvReqAddr req);

using DevInfoT = struct IdeDevInfo;

class IDE_DAEMON_HDC_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

int devStartupNotifier(uint32_t num, uint32_t *dev)
{
    return 0;
}

TEST_F(IDE_DAEMON_HDC_STEST, HdcDaemonInit_get_dev_num_error)
{
    uint32_t count = DEVICE_NUM_MAX + 1;

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&count, sizeof(uint32_t)))
        .will(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcDaemonInit());
}

TEST_F(IDE_DAEMON_HDC_STEST, HdcDaemonInit)
{
    uint32_t count = 1;

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(drvHdcClientCreate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&count, sizeof(uint32_t)))
        .will(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_ERROR, HdcDaemonInit());
}

TEST_F(IDE_DAEMON_HDC_STEST, GetDevCount)
{
    uint32_t devCount = 0;
    std::vector<uint32_t> devs(DEVICE_NUM_MAX, 0);

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devCount, sizeof(uint32_t)))
        .will(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_OK, GetDevCount(devCount, devs));
}

TEST_F(IDE_DAEMON_HDC_STEST, IdeHdcCheckRunEnv)
{
    HDC_SESSION session = NULL;

    EXPECT_EQ(IDE_DAEMON_OK, IdeHdcCheckRunEnv(session));
}

TEST_F(IDE_DAEMON_HDC_STEST, IdeDestroyGlobalCtrlInfo)
{
    DevInfoT devInfo = {0};
    uint32_t phyDevId = 1;
    g_ideGlobalInfo.hdcClient = (HDC_CLIENT)1;

    devInfo.phyDevId = phyDevId;
    devInfo.server = nullptr;
    devInfo.createHdc = true;
    devInfo.devDisable = false;
    devInfo.serviceType = HDC_SERVICE_TYPE_IDE2;

    g_ideGlobalInfo.mapDevInfo.insert(std::pair<int, DevInfoT>(phyDevId, devInfo));

    MOCKER(drvHdcServerDestroy)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcClientDestroy)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(IDE_DAEMON_OK, HdcDaemonDestroy());

    std::map<int, DevInfoT>::iterator it = g_ideGlobalInfo.mapDevInfo.begin();
    it = g_ideGlobalInfo.mapDevInfo.find(devInfo.phyDevId);
    if (it != g_ideGlobalInfo.mapDevInfo.end()) {
        g_ideGlobalInfo.mapDevInfo.erase(it);
    }
}

TEST_F(IDE_DAEMON_HDC_STEST, HdcCreateHdcServerProc)
{
    DevInfoT devInfo = {0};
    uint32_t phyDevId = 1;
    uint32_t devCount = 0;
    IdeThreadArg args;
    g_ideGlobalInfo.hdcClient = (HDC_CLIENT)1;

    devInfo.phyDevId = phyDevId;
    devInfo.server = nullptr;
    devInfo.createHdc = false;
    devInfo.devDisable = false;
    devInfo.serviceType = HDC_SERVICE_TYPE_IDE2;

    g_ideGlobalInfo.mapDevInfo.insert(std::pair<int, DevInfoT>(phyDevId, devInfo));
    phyDevId += 1;
    devInfo.phyDevId = phyDevId;
    g_ideGlobalInfo.mapDevInfo.insert(std::pair<int, DevInfoT>(phyDevId, devInfo));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK))
        .then(returnValue(EN_ERR));

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devCount, sizeof(uint32_t)))
        .will(returnValue(DRV_ERROR_NONE));

    IdeInitGlobalCtrlInfo();
    EXPECT_EQ(nullptr, HdcCreateHdcServerProc(args));

    std::map<int, DevInfoT>::iterator it = g_ideGlobalInfo.mapDevInfo.begin();
    it = g_ideGlobalInfo.mapDevInfo.find(devInfo.phyDevId);
    if (it != g_ideGlobalInfo.mapDevInfo.end()) {
        g_ideGlobalInfo.mapDevInfo.erase(it);
    }
}

TEST_F(IDE_DAEMON_HDC_STEST, IdeDestroyGlobalCtrlInfoDev)
{
    std::vector<uint32_t> dev{1,2};
    uint32_t  num = 2;

    EXPECT_EQ(IDE_DAEMON_OK, HdcDaemonServerRegister(2,dev));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcDaemonServerRegister(0, dev));
    EXPECT_EQ(IDE_DAEMON_ERROR, HdcDaemonServerRegister(1125, dev));
    EXPECT_EQ(IDE_DAEMON_OK, HdcDaemonDestroy());
}
