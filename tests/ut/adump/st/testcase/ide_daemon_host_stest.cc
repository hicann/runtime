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
#define protected public
#define private public
#include <map>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <queue>
#include <memory>
#include "ascend_hal.h"
#include "ide_daemon_host_stest.h"
#include "ide_daemon_stub.h"
#include "ide_hdc_stub.h"
#include "ide_common_util.h"
#include "ide_daemon_host.h"
#include "mmpa_stub.h"
#include "ide_daemon_dev.h"
#include "ide_daemon_enc_dec.h"
#include "ide_daemon_hdc.h"
#include "adx_dump_record.h"
#include "common/config.h"
#include "adx_dsmi.h"
#include <vector>
extern "C"{
    #include "dsmi_common_interface.h"
}

using namespace IdeDaemon::Common::Config;

extern int g_sock_switch;
extern int g_ide_cmd_write_time;
extern int g_ide_cmd_read_time;
extern int g_ide_recv_time;
extern int g_ide_host_type;
extern int g_ide_cmd_recv_time_host1;
extern int g_ide_sync_time;
extern int g_mmCreateTaskFlag;
extern int g_mmCreateTaskWitchDeatchFlag;
extern int g_ide_daemon_send_file_req;
extern int g_netlink_notify_flag;
extern int gIdeHdcRecvTime;
extern int g_count;
extern enum cmd_class g_ide_daemon_host_req_type;
extern"C"{
extern int HdcDaemonServerRegister(uint32_t num, const std::vector<uint32_t> &dev);
extern void *IdeDaemonHdcCreateServerEvent(void *args);
extern int IdeSigError(int signo,const struct sigaction* act,struct sigaction* oact);
extern void IdeDeviceStateNotifierRegister(int (*ide_dev_state_notifier)(devdrv_state_info_t *stateInfo));
extern int IdeDaemonGetSwitch();
}
int32_t IdeGetDevList(IdeU32Pt devNum, std::vector<uint32_t> &devs, uint32_t len);
extern std::vector<std::string> IdeDaemonGetValueFromCfg(std::string key);
extern int SingleProcessStart(std::string &lock);
extern int IdeDaemonSockProcessEventOne(struct IdeSock &clientFd);

class IDE_DAEMON_HOST_STEST : public testing::Test {
protected:
    virtual void SetUp() {
        g_ide_cmd_write_time = 0;
        g_ide_cmd_read_time = 0;
        g_ide_recv_time = 0;
        g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
        g_ide_create_task_time = 1;
        g_mmCreateTaskWitchDeatchFlag = 1;
        g_ide_daemon_send_file_req = 0;
        g_netlink_notify_flag = 0;
        g_ide_sync_time = 0;
        MOCKER(DecryptExWithKMC)
        .stubs()
        .will(returnValue(0));
        MOCKER(EncWithoutHmacWithKMC)
        .stubs()
        .will(returnValue(0));
        MOCKER(SingleProcessStart)
        .stubs()
        .will(returnValue(0));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

static const int ret_size = sizeof(struct IdePack);

void mocker_common()
{
    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeFcntl)
        .stubs()
        .will(returnValue(0));

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

    MOCKER(mmSemWait)
        .stubs()
        .will(invoke(mmSemWait_stub));

    g_ide_create_task_time = 1;
}

void mocker_select()
{
    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(-1));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_cmd)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(recvmsg)
        .stubs()
        .will(invoke(recvmsg_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_cmd_fail)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
        mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(HdcSessionConnect)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(recvmsg)
        .stubs()
        .will(invoke(recvmsg_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}


TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_cmd_delsock)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
                .stubs()
                .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(recvmsg)
        .stubs()
        .will(invoke(recvmsg_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    g_netlink_notify_flag = 1;
    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}

extern int IdeExecStr(const std::string &exes);
TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMainDefaultTime)
{
    int argc = 2;
    char *argv[2];

    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetDefaultTime)
        .stubs()
        .will(returnValue(true));

    MOCKER(IdeExecStr)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}


TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_cmd_verify_error)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
            .stubs()
            .will(returnValue(true));

    MOCKER(SSL_CTX_load_verify_locations)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(SSL_CTX_set_default_verify_paths)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(SSL_CTX_use_certificate_file)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(SSL_CTX_use_PrivateKey_file)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(SSL_CTX_check_private_key)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    //SSL_CTX_load_verify_locations_error
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //SSL_CTX_set_default_verify_paths
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //SSL_CTX_use_certificate_file
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //SSL_CTX_use_PrivateKey_file
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //SSL_CTX_check_private_key
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_cmd_genrate_error)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    mocker_select();

    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
            .stubs()
            .will(returnValue(true));

    MOCKER(SSL_CTX_load_verify_locations)
        .stubs()
        .will(returnValue(1));

    MOCKER(SSL_CTX_set_default_verify_paths)
        .stubs()
        .will(returnValue(1));

    MOCKER(SSL_CTX_use_certificate_file)
        .stubs()
        .will(returnValue(1));

    MOCKER(SSL_CTX_use_PrivateKey_file)
        .stubs()
        .will(returnValue(1));

    MOCKER(SSL_CTX_check_private_key)
        .stubs()
        .will(returnValue(1));

    MOCKER(SslDecodeBase64)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmFtruncate)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(EN_OK));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(-1));

    //SslDecodeBase64
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //mmOpen2
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //mmFtruncate
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //mmLseek
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

    //mmWrite
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));

}


TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_cmd_IdeXmalloc_error)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    mocker_common();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void*)NULL));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv)); //ide_host_command_process

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_host_cmd)
{
    int argc = 2;
    char *argv[2];

    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_HOSTCMD_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));
    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_host_cmd_send_error)
{
    int argc = 2;
    char *argv[2];

    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_HOSTCMD_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
            .stubs()
            .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_host_cmd_recv_error)
{
    int argc = 2;
    char *argv[2];

    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_HOSTCMD_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_command_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_send_file)
{
        int argc = 2;

        char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_SEND_FILE_REQ;
    g_ide_daemon_send_file_req = IDE_SEND_FILE_REQ;
        mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

        MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_send_file_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_send_file_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_SEND_FILE_REQ;
    g_ide_daemon_send_file_req = IDE_SEND_FILE_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(IdeCheckPath)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_send_file_process

    GlobalMockObject::verify();

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_file_sync_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";
    
    g_ide_daemon_host_req_type = IDE_FILE_SYNC_REQ;
    g_ide_daemon_send_file_req = IDE_SEND_FILE_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));
    
    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));
    
    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    
    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //IdeHostSockFileProcess

    GlobalMockObject::verify();
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_sync)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_FILE_SYNC_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub1));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_api_device_status)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_API_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_api_device_info)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_API_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub1));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_device_info_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
    g_ide_cmd_read_time = 0;
    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_api_board_id)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";


    g_ide_daemon_host_req_type = IDE_EXEC_API_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_board_id_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_api_os_type)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";


    g_ide_daemon_host_req_type = IDE_EXEC_API_REQ;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_os_type_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_api_sys_version_process)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";
    g_ide_daemon_host_req_type = IDE_EXEC_API_REQ;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_sys_version_process_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_get)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";
    g_ide_daemon_host_req_type = IDE_FILE_GET_REQ;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub2));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(MAX_SEND_DADA_SIZE + 1));

    MOCKER(mmWriteFile)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, ide_daemon_main_get_file_failed)
{
     int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_daemon_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_FILE_GET_REQ;
    g_ide_cmd_recv_time_host1 = 0;
        g_ide_create_task_time = 0;
        g_mmCreateTaskFlag=0;
        mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(IdeCheckPath)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

        MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

        MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub2));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(1500));

    MOCKER(mmWriteFile)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmOpen2)
        .expects(exactly(2))
        .will(returnValue(1))
        .then(returnValue(1));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, ide_daemon_main_get_error)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_daemon_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_FILE_GET_REQ;
    g_ide_cmd_recv_time_host1 = 0;
    g_ide_create_task_time = 0;
    g_mmCreateTaskFlag=0;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub2));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(1500));

    MOCKER(mmWriteFile)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmOpen2)
        .expects(exactly(3))
        .will(returnValue(1))
        .then(returnValue(1))
        .then(returnValue(-1));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_error)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_FILE_GET_REQ;
    g_ide_cmd_recv_time_host1 = 0;
    g_ide_create_task_time = 0;
    g_mmCreateTaskFlag=0;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub2));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(1500));

    MOCKER(mmWriteFile)
        .stubs()
        .will(returnValue(1));

    MOCKER(IdeSendFrontData)
        .expects(once())
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_get_error)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_FILE_GET_REQ;
    g_ide_cmd_recv_time_host1 = 0;
    g_ide_create_task_time = 0;
    g_mmCreateTaskFlag=0;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub2));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(stat)
        .stubs()
        .will(returnValue(1500));

    MOCKER(mmWriteFile)
        .stubs()
        .will(returnValue(1));

    MOCKER(IdeSendLastData)
        .expects(once())
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_getd)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";
    g_ide_daemon_host_req_type = IDE_FILE_GETD_REQ;
    g_ide_cmd_recv_time_host1 = 0;
    g_ide_create_task_time = 0;
    g_mmCreateTaskFlag=0;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_getd_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(MAX_SEND_DADA_SIZE + 1));

    MOCKER(mmWriteFile)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_detect)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DETECT_REQ;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));
    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));

}
/*
TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_time)
{
    int argc = 2;
    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DETECT_REQ;
    g_ide_sync_time = 1;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));
    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
    g_ide_sync_time = 0;

}
*/
TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_detect_memcpy_s_fail)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DETECT_REQ;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(memcpy_s)
       .stubs()
       .will(returnValue(EOK-1));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));
        MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));

}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_ome_dump)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_OME_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag=0;
    g_mmSemwait_time = 0;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(IdeDaemonSockProcessEventOne)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(SockSend)
       .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

       MOCKER(SockRecv)
       .stubs()
       .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(drvHdcSessionAccept)
        .stubs()
        .will(invoke(drvHdcSessionAccept_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_ome_dump_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_ome_dump_strlen)
{
        int argc = 2;

        char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_OME_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag=0;
    g_mmSemwait_time = 0;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK-1));

        MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(IdeDaemonSockProcessEventOne)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

        MOCKER(SockSend)
       .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

        MOCKER(SockRecv)
       .stubs()
       .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(drvHdcSessionAccept)
        .stubs()
        .will(invoke(drvHdcSessionAccept_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_ome_dump_process
}


TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_ome_dump_plus)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_OME_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag=0;
    g_ide_cmd_read_time=1;
    g_mmSemwait_time = 0;
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(IdeDaemonSockProcessEventOne)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(SockSend)
       .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

       MOCKER(SockRecv)
       .stubs()
       .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(drvHdcSessionAccept)
        .stubs()
        .will(invoke(drvHdcSessionAccept_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_ome_dump_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_ome_dump_plus_Putpkt)
{
        int argc = 2;

        char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_OME_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag=0;
    g_ide_cmd_read_time=1;
    g_mmSemwait_time = 0;
        mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK))
        .then(returnValue(IDE_DAEMON_ERROR));

        MOCKER(halHdcRecv)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcRecv_stub));

    MOCKER(drvHdcGetMsgBuffer)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcGetMsgBuffer_stub));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(invoke(ide_hdc_host_drvHdcFreeMsg_stub));

    MOCKER(IdeDaemonSockProcessEventOne)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

        MOCKER(SockSend)
       .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

        MOCKER(SockRecv)
       .stubs()
       .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(drvHdcSessionAccept)
        .stubs()
        .will(invoke(drvHdcSessionAccept_stub));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_ome_dump_process
}


TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_dump)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag = 0;
    gIdeHdcRecvTime = 0;
    g_count = 0;
    g_mmSemwait_time = 0;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(invoke(mmCreateTaskWithThreadAttr_stub2));
    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_dump_start_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag = 0;
    gIdeHdcRecvTime = 0;
    g_mmSemwait_time = 0;

    mocker_common();
    mocker_select();

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(IdeWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_dump_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_dump_mmStrTokR_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag = 0;
    gIdeHdcRecvTime = 0;
    g_mmSemwait_time = 0;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(mmStrTokR)
        .stubs()
        .will(returnValue((char *)NULL));

    MOCKER(IdeWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_dump_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_dump_SockHandleIsValid_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag = 0;
    gIdeHdcRecvTime = 0;
    g_mmSemwait_time = 0;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockHandleIsValid)
        .stubs()
        .will(returnValue(-1));

    MOCKER(IdeWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_dump_process
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_dump_Putpkt_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_DUMP_REQ;
    g_ide_host_type = HOST_HDC;
    g_ide_create_task_time = 0; //use hdc thread
    g_mmCreateTaskFlag = 0;
    gIdeHdcRecvTime = 0;
    g_mmSemwait_time = 0;

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    std::vector<uint32_t> &dev_list{0};
    HdcDaemonServerRegister(1, dev_list);

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv)); //ide_host_dump_process
}

int ide_dev_state_notifier(devdrv_state_info_t *stateInfo){
    return 0;
}

TEST_F(IDE_DAEMON_HOST_STEST, ide_daemon_device_state_notify)
{
    IdeDeviceStateNotifierRegister(ide_dev_state_notifier);
    EXPECT_TRUE(g_ideInfo.devStateNotify.callbacks[0] != NULL);
    IdeDevStateNotifySetFlag(0, 1);
    EXPECT_EQ(1, g_ideInfo.devStateNotify.flag[0]);
    EXPECT_TRUE(IdeDevStateNotifyIsAllFlagSet());
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_linux_signal_error)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";
    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(sigaction)
        .stubs()
        .will(invoke(IdeSigError));

    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_linux_api_error)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    mocker_common();
    mocker_select();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_hdc_api_error)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    mocker_common();
    mocker_select();

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));

    MOCKER(SockAccept)
        .stubs()
        .will(returnValue(0));

    MOCKER(drvHdcAllocMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcAddMsgBuffer)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(halHdcSend)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(IdeWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    //1.drvHdcAllocMsg Failed
    g_ide_cmd_write_time = 0;
    g_ide_cmd_read_time = 0;
    g_ide_recv_time = 0;
    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, IdeDaemonTestMain_init_socket_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(setsid)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));
    MOCKER(mmSAStartup)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(mmBind)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(mmListen)
        .stubs()
        .will(returnValue(-1));

    //1. mmSAStartup failed
    EXPECT_NE(0, IdeDaemonTestMain(argc, argv));

    //2. setsockopt failed
    EXPECT_NE(0, IdeDaemonTestMain(argc, argv));

    //3. mmBind failed
    EXPECT_NE(0, IdeDaemonTestMain(argc, argv));

    //4. mmListen failed
    EXPECT_NE(0, IdeDaemonTestMain(argc, argv));
}

int hdc_error_test()
{
    mocker_common();
    mocker_select();

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_daemon_host_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_daemon_host_stub));
}

TEST_F(IDE_DAEMON_HOST_STEST, drvHdcGetCapacity_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    hdc_error_test();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(drvHdcGetCapacity)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, drvHdcAllocMsg_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    hdc_error_test();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(drvHdcAllocMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, drvHdcAddMsgBuffer_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    hdc_error_test();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(drvHdcAddMsgBuffer)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, drvHdcSend_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    hdc_error_test();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(halHdcSend)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, drvHdcReuseMsg_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    hdc_error_test();
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetSockSwitch)
        .stubs()
        .will(returnValue(true));

    MOCKER(drvHdcReuseMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

TEST_F(IDE_DAEMON_HOST_STEST, drvHdcFreeMsg_failed)
{
    int argc = 2;

    char *argv[2];
    argv[0] = (char *)"IdeDaemonTestMain";
    argv[1] = (char *)"9090";

    hdc_error_test();

    MOCKER(drvHdcFreeMsg)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_DEVICE));

    MOCKER(mmSleep)
        .stubs()
        .will(invoke(mmSleep_stub));

    EXPECT_EQ(0, IdeDaemonTestMain(argc, argv));
}

int devStartupNotifier(uint32_t num, uint32_t *dev)
{
    return 0;
}

int serviceCallBack(devdrv_state_info_t *)
{
    return 0;
}

TEST_F(IDE_DAEMON_HOST_STEST, register_callback)
{
    dev_info_t devInfo;
    g_ideGlobalInfo.mapDevInfo.insert(std::pair<int, dev_info_t>(1, devInfo));
    g_ideInfo.devStateNotify.idx = 1;
    g_ideInfo.devStateNotify.callbacks[0] = serviceCallBack;
    EXPECT_CALL(IdeDeviceStartupRegister(devStartupNotifier));
    devdrv_state_info_t stateInfo;
    stateInfo.state = GO_TO_DISABLE_DEV;
    stateInfo.devId = 0;
    DevStateCallBack(&stateInfo);
    g_ideGlobalInfo.mapDevInfo.erase(g_ideGlobalInfo.mapDevInfo.begin());
}

TEST_F(IDE_DAEMON_HOST_STEST, SingleProcessStart)
{
    GlobalMockObject::verify();
    std::string lock;
    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(IdeLockFcntl)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(IdeFcntl)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(-1))
        .then(returnValue(0));

    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(0, SingleProcessStart(lock));
}

TEST_F(IDE_DAEMON_HOST_STEST, AdxConfigManagerInit)
{
    GlobalMockObject::verify();
    int argc = 2;
    char *argv[2];

    argv[0] = (char *)"ide_host_main";
    argv[1] = (char *)"9090";

    g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(0));

    MOCKER(SingleProcessStart)
        .stubs()
        .will(returnValue(-1));
    std::string current = "./";
    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::GetCfgPath)
       .stubs()
       .will(returnValue(current));
    system("rm ide_daemon.cfg > /dev/null 2>&1 ");
    system("touch ide_daemon.cfg");
    system("echo HOST_PORT=22118 >> ide_daemon.cfg");
    system("echo DUMP_SIZE=60 >> ide_daemon.cfg");
    system("echo CERT_EXPIRE=60 >> ide_daemon.cfg");
    system("echo CERT_CIPHER=ECDHE-RSA-AES256-GCM-SHA384,ECDHE-RSA-AES128-GCM-SHA256 >> ide_daemon.cfg");
    system("echo TLS_OPTION=TLSv1.2,TLSv1.3 >> ide_daemon.cfg");
    system("echo DEFAULT_TIME=1 >> ide_daemon.cfg");
    system("echo LOG_PATH=~/ >> ide_daemon.cfg");
    system("echo DUMP_PATH=~/ >> ide_daemon.cfg");
    system("echo CERT_PATH=~/ >> ide_daemon.cfg");
    system("echo SECU=HELLO >> ide_daemon.cfg");
    system("echo STORE=WORLD >> ide_daemon.cfg");
    EXPECT_EQ(-1, IdeDaemonTestMain(argc, argv));
    system("rm ide_daemon.cfg");
}

