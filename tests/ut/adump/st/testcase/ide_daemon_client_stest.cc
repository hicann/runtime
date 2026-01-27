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

#include "ide_daemon_client_stest.h"
#include "ide_daemon_stub.h"

#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/tcp.h>
#include <errno.h>
#include <unistd.h>
#include <sys/select.h>
#include <termios.h>

#include "ide_common_util.h"
#include "securec.h"
#include "ide_daemon_enc_dec.h"

extern int g_ide_cmd_write_time;
extern int g_ide_cmd_read_time;
extern int g_ide_cmd_recv_time;

extern int IdeCmdTestMain(int argc, char *argv[]);
extern ssize_t IdeRead(int fd, void *buf, size_t nbyte);
extern sock_handle_t RemoteOpen(char *host);
extern int RemoteHandle(const cmd_info_t &cmd_info);
extern SslCtxT *g_sslClientCtx;
class IDE_CMD_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        g_ide_cmd_write_time = 0;
        g_ide_cmd_read_time = 0;
        g_ide_cmd_recv_time = 0;
        g_sslClientCtx = (SslCtxT *)0x12345;
        optind = 1;
        MOCKER(DecryptExWithKMC)
        .stubs()
        .will(returnValue(0));
        /* MOCKER(EncWithoutHmacWithKMC)
        .stubs()
        .will(returnValue(0)); */
    }
    virtual void TearDown() {
        g_sslClientCtx = nullptr;
        GlobalMockObject::verify();
    }

};

TEST_F(IDE_CMD_STEST, ide_cmd_main_help)
{
    int argc1 = 12;
    char *argv1[argc1] = {0};
    argv1[0] = (char *)"ide_cmd";
    argv1[1] = (char *)"--host";
    argv1[2] = (char *)"10.174.28.162:3562";
    argv1[3] = (char *)"--bbox";
    argv1[4] = (char *)"bbox_cmd";
    argv1[5] = (char *)"--log";
    argv1[6] = (char *)"log_cmd";
    argv1[7] = (char *)"--profile";
    argv1[8] = (char *)"profile_cmd";
    argv1[9] = (char *)"--debug";
    argv1[10] = (char *)"debug_cmd";
    argv1[11] = (char *)"--others";

    sock_handle_t valid_handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    MOCKER(RemoteOpen)
        .stubs()
        .will(returnValue(valid_handle));

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));
    
    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    EXPECT_EQ(-1, IdeCmdTestMain(argc1, argv1));

    optind = 1;
    int argc2 = 4;
    char *argv2[argc2] = {0};
    argv2[0] = (char *)"ide_cmd";
    argv2[1] = (char *)"--host";
    argv2[2] = (char *)"10.174.28.162:3562";
    argv2[3] = (char *)"--help";
    EXPECT_EQ(0, IdeCmdTestMain(argc2, argv2));
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_host_cmd)
{
    const int number = 5;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--hostcmd", "cd ~/HIAI_PROJECTS/test/out;./test"};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));
    
    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));
    
    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));

    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_no_host)
{
    int argc = 3;
    char *argv[argc] = {0};
    argv[0] = (char *)"ide_cmd";
    argv[1] = (char *)"--cmd";
    argv[2] = (char *)"ls";
    argv[3] = NULL;
    sock_handle_t invalid_handle={IdeChannel::IDE_CHANNEL_SOCK, NULL,-1};

    MOCKER(RemoteOpen)
        .stubs()
        .will(returnValue(invalid_handle));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeCmdTestMain(argc, argv));
    free(invalid_handle.ssl);
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_profiler)
{
    const int number = 5;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--profile", "profile"};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));
    
    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));
    
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_api_device_status)
{
    const int number = 5;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--api", "device_status"};
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(1));      

    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));
    
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_api_board_type)
{
    const int number = 7;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118","--device","0", "--api", "board_type"};
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(1));      

    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));
    
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_device_invalid)
{
    const int number = 7;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118","--device","-1", "--api", "board_type"};
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(1));      

    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    EXPECT_EQ(-1, IdeCmdTestMain(argc, (char **)argv));
    
    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}


TEST_F(IDE_CMD_STEST, ide_cmd_main_log)
{
    const int number = 5;
    const int size = 64;
    int argc = number;

    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--log", "xxxxx"};

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(1));
    
    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));

    EXPECT_EQ(-1, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_sync)
{
    const int number = 6;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--sync", "source_file", "~/ide_daemon"};
     char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    
    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(size));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub1));
    
    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_bbox)
{
    const int number = 5;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--bbox", "xxxxx"};
    struct stat st;
    memset(&st, 0, sizeof(st));

    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));
    
    MOCKER(select)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(1));

    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(1));

    MOCKER(stat)
        .stubs()
        .with(any(), outBoundP(&st, sizeof(st)))
        .will(returnValue(0));
  
    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));
    

    EXPECT_EQ(-1, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}
extern int g_ide_cmd_get_pkt_time;
TEST_F(IDE_CMD_STEST, ide_cmd_main_get)
{
    const int number = 6;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--get", "local_path", "~/ide_daemon"};
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    char *real_path = "test.log";

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));

    MOCKER(realpath)
        .stubs()
        .will(returnValue(real_path));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub1));
    
    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    
    MOCKER(GetpktLen)
        .stubs()
        .will(invoke(GetpktLen_stub));    
    printf("Begin g_ide_cmd_get_pkt_time = %d \n", g_ide_cmd_get_pkt_time);
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));
    printf("End g_ide_cmd_get_pkt_time = %d \n", g_ide_cmd_get_pkt_time);

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_get_invalid_path)
{
    const int number = 6;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--get", "local_path", "/var/dlog/../remote_path"};
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;
    char *real_path = "test.log";

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

        MOCKER(select)
                .stubs()
                .will(returnValue(1));

    MOCKER(realpath)
        .stubs()
        .will(returnValue(real_path));

        MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));

    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub1));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));

    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));

    MOCKER(Putpkt)
                .stubs()
                .will(returnValue(IDE_DAEMON_OK));

    MOCKER(GetpktLen)
                .stubs()
                .will(invoke(GetpktLen_stub));

        EXPECT_EQ(-1, IdeCmdTestMain(argc, (char **)argv));

        for (i = 0; i < number; i++)
        {
                if (NULL != argv[i])
                {
                        free(argv[i]);
                        argv[i] = NULL;
                }
        }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_detect)
{
    const int number = 4;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--detect"};
    struct stat st;
    memset(&st, 0, sizeof(st));
    
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));
    
    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }    
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_time)
{
    const int number = 4;
    const int size = 64;
    int argc = number;
    char tmp[number][size] = {"ide_cmd",  "--host", "10.174.28.162:22118", "--time"};
    struct stat st;
    memset(&st, 0, sizeof(st));
    
    char *argv[number] = {0};
    int i = 0;
    for (; i < number; i++)
    {
        argv[i] = (char *)malloc(size);
        memset_s(argv[i], size, 0, sizeof(char)*size);
        memcpy_s(argv[i], size, tmp[i], sizeof(char)*sizeof(tmp[i]));
    }
    struct IdePack send_buf;

    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));

    MOCKER(SockSend)
        .stubs()
        .will(invoke(ide_write_ide_cmd_stub));
    
    MOCKER(SockRecv)
        .stubs()
        .will(invoke(IdeRead_ide_cmd_stub));

    MOCKER(SockConnect)
        .stubs()
        .will(invoke(SockConnect_stub));
    
    MOCKER(SslInit)
        .stubs()
        .will(returnValue(0));
    
    EXPECT_EQ(0, IdeCmdTestMain(argc, (char **)argv));

    for (i = 0; i < number; i++)
    {
        if (NULL != argv[i])
        {
            free(argv[i]);
            argv[i] = NULL;
        }
    }
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_time_for_RemoteOpen)
{
    const int size = 64;
    char tmp[size] = "10.174.28.162.11:22118";
    char tmp1[size] = "10.174.28.162:22118";


    MOCKER(setsockopt)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(0))
        .then(returnValue(1))
        .then(returnValue(0));

    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(IsSslClientInited)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(1));
    
    MOCKER(mmConnect)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(SockConnect)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    
    MOCKER(SslInit)
        .stubs()
        .will(returnValue(1));

    MOCKER(inet_pton)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(1));

    MOCKER(select)
        .stubs()
        .will(returnValue(1));
    
    RemoteOpen(tmp);
    RemoteOpen(tmp1);
    RemoteOpen(tmp1);
    RemoteOpen(tmp1);
    RemoteOpen(tmp1);
    RemoteOpen(tmp1);
    RemoteOpen(tmp1);
    EXPECT_CALL(RemoteOpen(tmp1));

}

TEST_F(IDE_CMD_STEST, ide_cmd_main_error)
{
    int argc = 4;
    char *argv[4];
    argv[0] = "ide_cmd";
    argv[1] = "--host";
    argv[2] = "10.174.28.162:22118";
    argv[3] = "--detect";

    MOCKER(mmSAStartup)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));   
    
    MOCKER(RemoteHandle)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(mmSACleanup)
        .stubs()
        .will(returnValue(EN_ERROR));

    optind = 1;
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    optind = 1;
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
    optind = 1;
    EXPECT_EQ(-1, IdeCmdTestMain(argc, argv));
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_key)
{
    int argc = 2;
    char *argv[2];
    argv[0] = "ide_cmd";
    argv[1] = "--key";

    scanf_s_ret = 10;

    MOCKER(mmSAStartup)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(mmSACleanup)
        .stubs()
        .will(returnValue(EN_OK));

     MOCKER(tcgetattr)
        .stubs()
        .then(returnValue(0));

    MOCKER(tcsetattr)
        .stubs()
        .then(returnValue(0));

    EXPECT_EQ(0, IdeCmdTestMain(argc, argv));
}

TEST_F(IDE_CMD_STEST, ide_cmd_main_key_success)
{
    int argc = 2;
    char *argv[2];
    argv[0] = "ide_cmd";
    argv[1] = "--key";

    scanf_s_ret = 0;

    MOCKER(mmSAStartup)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(mmSACleanup)
        .stubs()
        .will(returnValue(EN_OK));

     MOCKER(tcgetattr)
        .stubs()
        .then(returnValue(0));

    MOCKER(tcsetattr)
        .stubs()
        .then(returnValue(0));

    EXPECT_EQ(0, IdeCmdTestMain(argc, argv));
}

TEST_F(IDE_CMD_STEST, ide_cmd_main)
{
    int argc = 2;
    char *argv[2];
    argv[0] = "ide_cmd";
    argv[1] = "--key";

    scanf_s_ret = 1;

    MOCKER(mmSAStartup)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(mmSACleanup)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(tcgetattr)
        .stubs()
        .then(returnValue(0));

    MOCKER(tcsetattr)
        .stubs()
        .then(returnValue(0));

    EXPECT_EQ(0, IdeCmdTestMain(argc, argv));
}

