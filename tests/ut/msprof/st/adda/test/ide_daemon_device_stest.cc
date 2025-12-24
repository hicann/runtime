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

#include "ide_daemon_device_stest.h"
#include <vector>
#include "ide_daemon_stub.h"
#include "mmpa_stub.h"
#include "ide_daemon_hdc.h"
#include "ide_platform_util.h"
#include "ide_hdc_stub.h"
#include "ide_task_register.h"

using namespace Adx;
using namespace Analysis::Dvvp::Adx;
extern int g_ide_cmd_write_time;
extern int g_ide_cmd_read_time;
extern int g_ide_recv_time;
extern int g_fork_time;
extern int g_mmCreateTaskWitchDeatchFlag;
extern int g_mmCreateTaskFlag;
extern int g_hdc_session_accept;
extern int g_hdc_server_create_flag;
extern int g_mmCreateTaskWithDetachTime;
extern int g_mmCreateTaskWithDetachThreahHold;
extern int g_HdcStorePackage_is_not_last;
extern int g_sprintf_s_flag;
extern enum cmd_class g_ide_daemon_device_req_type;
extern int SingleProcessStart(std::string &lockInfo);

class IDE_DAEMON_DEVICE_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        g_ide_cmd_write_time = 0;
        g_ide_cmd_read_time = 0;
        g_ide_recv_time = 0;
        g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
        g_fork_time = 0;
        g_ide_create_task_time = 1;
        g_mmCreateTaskWitchDeatchFlag = 1;
        g_hdc_session_accept = 0;
        g_hdc_server_create_flag = 0;
        g_mmCreateTaskWithDetachTime = 0;
        g_mmCreateTaskWithDetachThreahHold = 0;
        g_HdcStorePackage_is_not_last = 0;
        MOCKER(SingleProcessStart)
        .stubs()
        .will(returnValue(0));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

static void device_mocker_common()
{
    g_mmSemwait_time = 0;

    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(setsid)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(chdir)
        .stubs()
        .will(returnValue(0));

    MOCKER(getifaddrs)
        .stubs()
        .will(invoke(getifaddrs_stub));

    MOCKER(freeifaddrs)
        .stubs()
        .will(invoke(freeifaddrs_stub));

    MOCKER(getnameinfo)
        .stubs()
        .will(invoke(getnameinfo_stub));

    MOCKER(drvHdcServerCreate)
        .stubs()
        .will(invoke(drvHdcServerCreate_stub));

    MOCKER(drvHdcSessionAccept)
        .stubs()
        .will(invoke(drvHdcSessionAccept_failed));

    MOCKER(mmSemWait)
        .stubs()
        .will(invoke(mmSemWait_stub));

    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(-1));

    std::vector<uint32_t> dev_list{0};
    HdcDaemonServerRegister(1, dev_list);
}

TEST_F(IDE_DAEMON_DEVICE_STEST, HdcRead_drvHdcAllocMsg_failed)
{
    g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
    g_ide_create_task_time = 1;
    device_mocker_common();

    MOCKER(drvHdcAllocMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    EXPECT_EQ(0, IdeDaemonTestMain(0, NULL));
    g_ide_create_task_time = 0;
}

TEST_F(IDE_DAEMON_DEVICE_STEST, HdcRead_drvHdcRecv_failed)
{
    g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
    g_ide_create_task_time = 1;
    device_mocker_common();

    MOCKER(halHdcRecv)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    EXPECT_EQ(0, IdeDaemonTestMain(0, NULL));
    g_ide_create_task_time = 0;
}

TEST_F(IDE_DAEMON_DEVICE_STEST, HdcRead_drvHdcGetMsgBuffer_failed)
{
    g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
    g_ide_create_task_time = 1;
    device_mocker_common();

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(returnValue(hdcError_t(DRV_ERROR_INVALID_DEVICE)));

    EXPECT_EQ(0, IdeDaemonTestMain(0, NULL));
    g_ide_create_task_time = 0;
}

TEST_F(IDE_DAEMON_DEVICE_STEST, HdcRead_HdcStorePackage_failed)
{
    g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
    g_ide_create_task_time = 1;
    device_mocker_common();

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(HdcStorePackage)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(0, IdeDaemonTestMain(0, NULL));
    g_ide_create_task_time = 0;
}

TEST_F(IDE_DAEMON_DEVICE_STEST, HdcRead_drvHdcReuseMsg_failed)
{
    g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
    g_ide_create_task_time = 1;
    g_HdcStorePackage_is_not_last = 1;

    device_mocker_common();

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(drvHdcReuseMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    EXPECT_EQ(0, IdeDaemonTestMain(0, NULL));
    g_ide_create_task_time = 0;
}
