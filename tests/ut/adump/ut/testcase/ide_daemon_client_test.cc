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

#include "ide_daemon_stub.h"
#include "ide_common_util.h"
#include "ide_platform_util.h"
#include "ide_daemon_client_test.h"
#include "securec.h"
#include "white_list.h"
#include "ide_ssl_stub.h"
#include <termios.h>
#include "common/config.h"

using namespace IdeDaemon::Common::Config;

extern int g_sprintf_s_flag;
extern int g_exitCode;

class IDE_CMD_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
        g_sprintf_s_flag = 0;
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

extern int IdeCheckPath(const char *path, uint32_t pathLen);

TEST_F(IDE_CMD_UTEST, IdeGetFilePath)
{
    const char *filename = "src.log";
    const char *invalidname = "`src.log";
    std::string white_file_name;

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeGetFilePath(invalidname, white_file_name));
    EXPECT_EQ(IDE_DAEMON_OK, IdeGetFilePath(filename, white_file_name));
}

TEST_F(IDE_CMD_UTEST, CommandRes)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    int cmd_or_file = IDE_EXEC_COMMAND_REQ;

    MOCKER(ProcessRes)
        .stubs();

    MOCKER(select)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(1)); //Getpkt != IDE_DAEMON_OK

    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(EINTR))
        .then(returnValue(EINTR - 1));
    
    MOCKER(Getpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR)) //Getpkt != IDE_DAEMON_OK
        .then(returnValue(IDE_DAEMON_OK)) //Getpkt == IDE_DAEMON_OK 1.
        .then(returnValue(IDE_DAEMON_SOCK_CLOSE));

    EXPECT_EQ(IDE_DAEMON_OK, CommandRes(handle, cmd_or_file));    //select return = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, CommandRes(handle, cmd_or_file)); //select return < 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, CommandRes(handle, cmd_or_file)); //getpkg failed
    EXPECT_EQ(IDE_DAEMON_OK, CommandRes(handle, cmd_or_file));    //Getpkt succ
}

TEST_F(IDE_CMD_UTEST, IdeCmdCommonProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char command[] = "cd";
    unsigned int dev_id = 0;
    bool flag = true;

    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(CommandRes)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));


    MOCKER(IdeCreatePacket)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    //IdeCreatePacket failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCommonProcess(handle, dev_id, command, IDE_EXEC_COMMAND_REQ));
    //Putpkt failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCommonProcess(handle, dev_id, command, IDE_EXEC_COMMAND_REQ));
    //CommandRes failed
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCommonProcess(handle, dev_id, command, IDE_EXEC_COMMAND_REQ));
    //succ
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdCommonProcess(handle, dev_id, command, IDE_EXEC_COMMAND_REQ));
}

TEST_F(IDE_CMD_UTEST, ide_cmd_common_process_succ)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char command[] = "cd";
    unsigned int dev_id = 0;
    bool flag = false;

    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(CommandRes)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IsWhiteListCommand)
        .stubs()
        .with(any(), outBound(flag))
        .will(returnValue(true));

    MOCKER(IdeCreatePacket)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    //IsWhiteListCommand failed
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdCommonProcess(handle, dev_id, command, IDE_EXEC_COMMAND_REQ));
}

TEST_F(IDE_CMD_UTEST, IdeHostCmdCommandProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char *command = (char *)"ls";
    unsigned int dev_id = 0;

    MOCKER(IdeCmdCommonProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeHostCmdCommandProcess(handle, dev_id, command));
}

TEST_F(IDE_CMD_UTEST, IdeCmdDetectProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char *command = (char *)"ls";
    unsigned int dev_id = 0;

    MOCKER(IdeCmdCommonProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdDetectProcess(handle, dev_id, command));
}

TEST_F(IDE_CMD_UTEST, IdeCmdLogProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char *command = (char *)"ls";
    unsigned int dev_id = 0;

    MOCKER(IdeCmdCommonProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeCmdGetFileCommonProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdLogProcess(handle, dev_id, command));
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdLogProcess(handle, dev_id, "SetLogLevel(0)[info]"));
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdLogProcess(handle, dev_id, "GetLogList"));
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdLogProcess(handle, dev_id, "GetLogLevel"));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdLogProcess(handle, dev_id, "SyncLogFile"));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdLogProcess(handle, dev_id, "SyncLogFile:"));
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdLogProcess(handle, dev_id, "SyncLogFile:/etc/device-0_2012.log"));
}

TEST_F(IDE_CMD_UTEST, IdeCmdTimeProcess)
{
    cmd_info_t cmd_info = {{0}};
    sock_handle_t invalid_handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,-1};
    sock_handle_t valid_handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    MOCKER(RemoteOpen)
        .stubs()
        .will(returnValue(invalid_handle))
        .then(returnValue(valid_handle));
    
    char *command = (char *)"2019-02-26";
    unsigned int dev_id = 0;

    MOCKER(IdeCmdDetectProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdTimeProcess(cmd_info));
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdTimeProcess(cmd_info));
}


TEST_F(IDE_CMD_UTEST, IdeCmdApiProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char *command = "sys_version";
    unsigned int dev_id = 0;

    MOCKER(IdeCmdCommonProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdApiProcess(handle, dev_id, command));
    command = "sys";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdApiProcess(handle, dev_id, command));
}

TEST_F(IDE_CMD_UTEST, IdeCreateSendFilePath)
{
    std::string src_file_path="src.file";
    std::string dest_file_path = "dest.file";
    std::string sendPath;

    EXPECT_EQ(IDE_DAEMON_OK, IdeCreateSendFilePath(src_file_path, dest_file_path, sendPath));
    src_file_path="/src/file/";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCreateSendFilePath(src_file_path, dest_file_path, sendPath));
}

TEST_F(IDE_CMD_UTEST, IdeCmdFileProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    uint32_t dev_id = 0;
    const char *src_file_path = "src.file";
    const char *dest_file_path = "dest.file";
    enum cmd_class cmd_req = IDE_SEND_FILE_REQ;

    //IdeCreateSendFilePath failed
    MOCKER(IdeCreateSendFilePath)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();

    //IdeCreatePacket failed
    MOCKER(IdeCreatePacket)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();

    //Putpkt failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();

    //mmSocketRecv failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(SockRecv)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();


    //mmRealPath failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    char ret = '$';
    MOCKER(SockRecv)
        .stubs()
        .with(any(), outBoundP((void *)&ret, sizeof(ret)), eq(1), any())
        .will(returnValue(1));

    MOCKER(IdeDaemon::Common::Utils::CanonicalizePath)
        .stubs()
        .will(returnValue(std::string("")));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();

    //IdeSockSendFile failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    ret = '$';
    MOCKER(SockRecv)
        .stubs()
        .with(any(), outBoundP((void *)&ret, sizeof(ret)), eq(1), any())
        .will(returnValue(1));

    MOCKER(IdeSockSendFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();

    //CommandRes failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(SockRecv)
        .stubs()
        .with(any(), outBoundP((void *)&ret, sizeof(ret)), eq(1), any())
        .will(returnValue(1));

    MOCKER(IdeSockSendFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(CommandRes)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();

    //CommandRes succ
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(SockRecv)
        .stubs()
        .with(any(), outBoundP((void *)&ret, sizeof(ret)), eq(1), any())
        .will(returnValue(1));

    MOCKER(IdeSockSendFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(CommandRes)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdFileProcess(handle, dev_id, src_file_path, dest_file_path, cmd_req));
    GlobalMockObject::verify();
}

TEST_F(IDE_CMD_UTEST, IdeCmdSyncProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    char src_file_path[MAX_TMP_PATH];
    char des_file_path[MAX_TMP_PATH];
    unsigned int dev_id = 0;

    MOCKER(IdeCmdFileProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdSyncProcess(handle, dev_id, src_file_path, des_file_path));
        GlobalMockObject::verify();
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetTypeHelp)
{
    const int number = 2;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--help"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test parse paras
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_HELP))
        .then(returnValue(-1));
    EXPECT_EQ(IDE_DAEMON_DONE, IdeCmdGetType(argc, (const char **)argv, cmd_info));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
        GlobalMockObject::verify();
}

extern void SetDispMode(bool is_display);
extern int IdeDoKmcEnc(const char *lhs, int lhsLen, const char *rhs, int rhsLen);

static int scanf_s_ret = 0;

int scanf_s(const char* format, ...)
{
    return scanf_s_ret--;
}

TEST_F(IDE_CMD_UTEST, ide_do_kmc_enc)
{
    char key1[33] = "12345";
    char key2[33] = "12345";
    char key3[33] = "123456";

    MOCKER(EncWithoutHmacWithKMC)
        .stubs()
        .then(returnValue(0));
    
   EXPECT_EQ(IDE_DAEMON_ERROR, IdeDoKmcEnc(key1, -1, key2, -1));
   EXPECT_EQ(IDE_DAEMON_OK, IdeDoKmcEnc(key1, strlen(key1), key2, strlen(key2)));
   EXPECT_EQ(IDE_DAEMON_ERROR, IdeDoKmcEnc(key1, strlen(key1), key3, strlen(key3)));
   GlobalMockObject::verify();
}


TEST_F(IDE_CMD_UTEST, IdeCmdGetType_key)
{
    const int number = 2;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--key"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
            argv[i] = (char *)malloc(size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

        MOCKER(SetDispMode)
           .stubs();

        MOCKER(EncWithoutHmacWithKMC)
            .stubs()
            .then(returnValue(0));

        scanf_s_ret = 0;
    EXPECT_EQ(IDE_DAEMON_DONE, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
          free(argv[i]);
        argv[i] = NULL;
        }
    }
        GlobalMockObject::verify();
}

extern int IdeCmdPasswd();

TEST_F(IDE_CMD_UTEST, ide_cmd_passwd)
{
   MOCKER(SetDispMode)
       .stubs();

   MOCKER(IdeDoKmcEnc)
        .stubs()
        .then(returnValue(IDE_DAEMON_OK));

   MOCKER(memset_s)
       .stubs()
       .will(returnValue(EOK - 1));

   scanf_s_ret = 0;
   EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdPasswd());

   scanf_s_ret = 1;
   EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdPasswd());

   scanf_s_ret = 2;
   EXPECT_EQ(IDE_DAEMON_OK, IdeCmdPasswd());
   GlobalMockObject::verify();
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetType_host)
{
    const int number = 3;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--host", "192.168.1.100:22118"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --host
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_HOST))
        .then(returnValue(-1));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetType(argc, (const char **)argv, cmd_info));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetType_file)
{
    const int number = 4;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--file", "src.file", "dest.file"};
    cmd_info_t cmd_info = {{0}};
    cmd_info.outputFilePath = "/var/log";

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++) {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --file
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_SEND_FILE))
        .then(returnValue(-1));
    optarg = "src.file";

    MOCKER(IdeGetFilePath)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetType(argc, (const char **)argv, cmd_info));

    for (i = 0; i < number; i++) {
        if (NULL != argv[i]) {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetType_device_id)
{
    const int number = 6;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--device", "1"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_DEVICE_ID))
        .then(returnValue(-1));
    optarg = "1";
    
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    EXPECT_EQ(cmd_info.deviceId, 1);
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetTypeDeviceIdError)
{
    const int number = 6;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--device", "-1"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_DEVICE_ID))
        .then(returnValue(-1));
    optarg = "-1";
    
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}


TEST_F(IDE_CMD_UTEST, IdeCmdGetType_device_id_invalid)
{
    const int number = 6;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--device", "src.file"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_DEVICE_ID))
        .then(returnValue(-1));
    optarg = "xxxx";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetType_detect)
{
    const int number = 4;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--device", "0", "--detect"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_DETECT))
        .then(returnValue(-1));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    EXPECT_EQ(cmd_info.isDetectReq, 1);
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetType_time)
{
    const int number = 4;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--device", "0", "--time"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_TIME))
        .then(returnValue(-1));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    EXPECT_EQ(cmd_info.isTimeReq, 1);
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST,   IdeCmdGetTypeDump)
{
    const int number = 4;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--device", "--dump", "/home/HwHiAiUser/dump"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)IDE_ARGS_DUMP))
        .then(returnValue(-1));

    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetType_invalid)
{
    const int number = 2;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--other"};
    cmd_info_t cmd_info = {{0}};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    //test --device
    MOCKER(getopt_long)
        .stubs()
        .will(returnValue((int)'?'))
        .then(returnValue(-1));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetType(argc, (const char **)argv, cmd_info));
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, IdeCmdGetFileProcess)
{
        sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    uint32_t dev_id = 0;
    IdeString src_file_path = "src.file";
    IdeString dest_file_path = "dest.file";
    enum cmd_class cmd_req = IDE_FILE_GET_REQ;

    //IdeCreatePacket failed
    MOCKER(IdeCreatePacket)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetFileProcess(handle, dev_id, src_file_path, dest_file_path));
    GlobalMockObject::verify();

    //Putpkt failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetFileProcess(handle, dev_id, src_file_path, dest_file_path));
    GlobalMockObject::verify();

    //IdeSockSendFile failed

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERR));

    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetFileProcess(handle, dev_id, src_file_path, dest_file_path));
    GlobalMockObject::verify();

    //CommandRes failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(CommandRes)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetFileProcess(handle, dev_id, src_file_path, dest_file_path));
    GlobalMockObject::verify();

    //IdeFileNameIsReal
    /*
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeFileNameIsReal)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdGetFileProcess(handle, dev_id, src_file_path, dest_file_path));
    */
    GlobalMockObject::verify();

    //CommandRes failed
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(CommandRes)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdGetFileProcess(handle, dev_id, src_file_path, dest_file_path));
    GlobalMockObject::verify();
}

TEST_F(IDE_CMD_UTEST, IdeCheckPath)
{
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCheckPath(NULL, 0));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCheckPath("/var/../etc", 12));
}

TEST_F(IDE_CMD_UTEST, IdeCmdCheckValid)
{
    cmd_info_t cmd_info = {{0}};
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCheckValid(cmd_info));

    cmd_info.args[IDE_ARGS_HOST] = (char *)"172.9.1.192:3562";
    cmd_info.args[IDE_ARGS_CMD] = "ls";
    cmd_info.args[IDE_ARGS_HOST_CMD] = "ls";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCheckValid(cmd_info));

    cmd_info.args[IDE_ARGS_CMD] = NULL;
    cmd_info.args[IDE_ARGS_HOST_CMD] = NULL;
    cmd_info.fileType = IDE_ARGS_SEND_FILE;
    cmd_info.inputFilePath = "src.file";
    cmd_info.outputFilePath = "";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCheckValid(cmd_info));

    cmd_info.args[IDE_ARGS_CMD] = NULL;
    cmd_info.args[IDE_ARGS_HOST_CMD] = NULL;
    cmd_info.fileType = IDE_ARGS_SEND_FILE;
    cmd_info.inputFilePath = "src.file";
    cmd_info.outputFilePath = "/tmp/test";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCheckValid(cmd_info));

    cmd_info.fileType = 0;
    cmd_info.args[IDE_ARGS_CMD] = "ls";
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdCheckValid(cmd_info));

    cmd_info.fileType = 0;
    cmd_info.args[IDE_ARGS_CMD] = "date";
    EXPECT_EQ(IDE_DAEMON_OK, IdeCmdCheckValid(cmd_info));

}

TEST_F(IDE_CMD_UTEST, RemoteHandle)
{
    cmd_info_t cmd_info = {{0}};
    sock_handle_t invalid_handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,-1};
    sock_handle_t valid_handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,33453};
    MOCKER(RemoteOpen)
        .stubs()
        .will(returnValue(invalid_handle))
        .then(returnValue(valid_handle));

    EXPECT_EQ(IDE_DAEMON_ERROR, RemoteHandle(cmd_info));

    //execute device command
    cmd_info.args[IDE_ARGS_CMD] = "ls";
    MOCKER(IdeCmdCommonProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.args[IDE_ARGS_CMD] = NULL;

    //execute host command
    cmd_info.args[IDE_ARGS_HOST_CMD] = "ls";
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.args[IDE_ARGS_HOST_CMD] = NULL;

    //execute profiler command
    cmd_info.args[IDE_ARGS_PROFILE] = "profiler";
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.args[IDE_ARGS_PROFILE] = NULL;

    //execute log command
    MOCKER(IdeCmdLogProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    cmd_info.args[IDE_ARGS_LOG] = "log";
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.args[IDE_ARGS_LOG] = NULL;

    //execute dump command
    cmd_info.args[IDE_ARGS_DUMP] = "bbox";
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.args[IDE_ARGS_DUMP] = NULL;

    //execute api command
    cmd_info.args[IDE_ARGS_API] = "sys_version";
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.args[IDE_ARGS_API] = NULL;

    //execute sync command
    MOCKER(IdeCmdSyncProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    cmd_info.fileType= IDE_ARGS_SYNC_FILE;
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));

    //execute get file command
    MOCKER(IdeCmdGetFileProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    cmd_info.fileType= IDE_ARGS_GET_FILE;
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
    cmd_info.fileType= 0;

    //execute send file command
    MOCKER(IdeCmdDetectProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeCmdTimeProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    cmd_info.isDetectReq = 1;
    cmd_info.isTimeReq = 1;
    EXPECT_EQ(IDE_DAEMON_OK, RemoteHandle(cmd_info));
}

TEST_F(IDE_CMD_UTEST, IdeCmdTestMain)
{
    const int number = 2;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd", "--other"};
    cmd_info_t cmd_info = {{0}};
    g_exitCode = 0;

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }

    MOCKER(mmSAStartup)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    MOCKER(IdeCmdGetType)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_DONE))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeCmdCheckValid)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(RemoteHandle)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER_CPP(&Adx::Manager::Config::AdxConfigManager::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER(mmSACleanup)
        .stubs()
        .will(returnValue(EN_OK))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    //mmSAStartup failed
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    //IdeCmdGetType failed
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    //IdeCmdGetType for help
    EXPECT_EQ(0, IdeCmdTestMain(argc, argv));
    //IdeCmdCheckValid failed
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    //AdxConfigManager Init failed
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    //RemoteHandle failed
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    //mmSACleanup failed
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    //succ
    EXPECT_EQ(0, IdeCmdTestMain(argc, argv));

    for (i = 0; i < number; i++) {
        if (NULL != argv[i]) {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_UTEST, ExtractExitCode)
{
    const char * const correct_exit_code = "cmd_exit_code=  2";
    const char * const error_exit_code = "aaa";
    const char * const invalid_exit_code = "cmd_exit_code=  a";
    EXPECT_EQ(IDE_DAEMON_OK, ExtractExitCode(correct_exit_code));
    EXPECT_EQ(IDE_DAEMON_ERROR, ExtractExitCode(error_exit_code));
    EXPECT_EQ(IDE_DAEMON_ERROR, ExtractExitCode(invalid_exit_code));
}
