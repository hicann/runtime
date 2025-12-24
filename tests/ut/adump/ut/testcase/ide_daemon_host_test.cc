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
#include <memory>
#include <queue>
#include <thread>
#include "ascend_hal.h"
#include "ide_common_util.h"
#include "ide_daemon_host.h"
#include "adx_dump_record.h"
#include "ide_daemon_hdc.h"
#include "ide_daemon_stub.h"
#include "common/config.h"
extern "C" {
#include "dsmi_common_interface.h"
#include "peripheral_api.h"
}

using namespace IdeDaemon::Common::Config;
int g_fileResponseMsg = 0;
extern int g_sprintf_s_flag;
extern int g_sprintf_s_flag2;
int IdeHostHdcDumpDataDestroy();
extern int IdeTransferFile(struct IdeData &pdata, struct IdeSockHandle handle, int fd, uint32_t perSendSize);
extern int IdeSendFrontData(struct IdeData &pdata, int handler,
    struct IdeSockHandle handle, uint32_t perSendSize, long int& len);
extern int IdeSendLastData(struct IdeData &pdata, int handler,
    struct IdeSockHandle handle, uint32_t perSendSize, uint32_t remain);


class IDE_DAEMON_HOST_UTEST: public testing::Test {
protected:
	virtual void SetUp() {
        g_sprintf_s_flag = 0;
	}
	virtual void TearDown() {
        GlobalMockObject::verify();
	}
};

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockHostCommandProcess)
{
	sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
	sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc->handle = handle;
    sock_desc->type = IDE_EXEC_HOSTCMD_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("ls") + 10);
    strcpy(req->value, "ls");
    req->len = 2;

    MOCKER(IdeRunCmd)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockHostCommandProcess(sock_desc, client, req));
    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

static int HdcRead_stub_flag = 0;
int HdcRead_stub(HDC_SESSION session, void **recv_buf, int *recv_len)
{
    if (HdcRead_stub_flag == 0){
        char *buf_stub = (char *)malloc(2);
        buf_stub[0] = '+';
        buf_stub[1] = '\0';
        *recv_buf = buf_stub;
        *recv_len = 1;
    }else {
        *recv_buf = NULL;
        *recv_len = 2;
    }
    HdcRead_stub_flag++;
    return IDE_DAEMON_OK;
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_SEND_FILE_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERR));

    MOCKER(IdeCheckPathIsValid)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));

    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess_succ)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_SEND_FILE_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERR));

    MOCKER(IdeCheckPathIsValid)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));
    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess_file_path_invalid)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_SEND_FILE_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;

    MOCKER(IdeCheckPath)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));

    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess_IdeXmalloc_failed)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_SEND_FILE_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;

    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void *)NULL));
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));

    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcessCheckDevicePath)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_SEND_FILE_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_SEND_FILE_REQ;

    MOCKER(IdeCheckPathIsValid)
        .stubs()
        .will(returnValue(-1));
    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(0));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));

    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess_realpath_is_not_valid)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_FILE_SYNC_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_FILE_SYNC_REQ;

    MOCKER(IdeHostGetResolvedPath)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));

    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess_sync_file)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
	sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_FILE_SYNC_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_FILE_SYNC_REQ;

    MOCKER(remove)
        .stubs()
        .will(returnValue(0));

	MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeSockRecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));

    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileProcess_file_path_error)
{
    const char *value = "a.txt;b.txt;123";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
	sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
    sock_desc->handle = handle;
    sock_desc->type = IDE_FILE_SYNC_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 10);
    strcpy(req->value, value);
    req->len = strlen(value);
    req->type = IDE_FILE_SYNC_REQ;

    MOCKER(mmStrTokR)
        .stubs()
        .will(returnValue((char*)NULL));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileProcess(sock_desc, client, req));
    IdeXfree(req);
    req = NULL;
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockDetectProcess)
{
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    sock_desc_t sock_desc;
    sock_desc.handle = handle;
    sock_desc.type = IDE_DETECT_REQ;

    struct tlv_req *req = NULL;
    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req)+strlen("detect")+1);
    req->len = 0;
    req->type = IDE_DETECT_REQ;
    strcpy(req->value,"detect");
    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeSockDestroy)
        .stubs();

    g_sprintf_s_flag = 0;
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockDetectProcess(&sock_desc, client, req));
    g_sprintf_s_flag = 1;
    IdeXfree(req);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostApiDeviceStatusProcess)
{
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_EXEC_API_REQ;

    MOCKER(IsChipAlive)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(1));

    MOCKER(IdeHostApiGetStatus)
        .stubs();

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    //IsChipAlive error
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiDeviceStatusProcess(&sock_desc));

    //sprintf_s error
    g_sprintf_s_flag = 1;
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiDeviceStatusProcess(&sock_desc));

    //succ
    g_sprintf_s_flag = 0;
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostApiDeviceStatusProcess(&sock_desc));
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostApiDeviceInfoProcess)
{
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_EXEC_API_REQ;
    uint32_t dev_cnt = 2;
    uint32_t devid_array[2] = {0, 1};
    drvStatus_t devStatus = DRV_STATUS_WORK;

    MOCKER(rtGetDeviceCount)
		.stubs()
        .with(outBoundP(&dev_cnt, sizeof(dev_cnt)))
		.will(returnValue(ACL_ERROR_RT_NO_DEVICE))
		.then(returnValue(RT_ERROR_NONE));

   MOCKER(rtGetDeviceIDs)
       .stubs()
       .with(outBoundP(devid_array, sizeof(devid_array)))
       .will(returnValue(RT_ERROR_NONE));

    MOCKER(rtGetDeviceStatus)
        .stubs()
        .with(any(), outBoundP(&devStatus, sizeof(devStatus)))
        .will(returnValue(RT_ERROR_NONE));

    MOCKER(IdeSockDestroy)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiDeviceInfoProcess(&sock_desc));
    g_sprintf_s_flag = 1;
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiDeviceInfoProcess(&sock_desc));
    g_sprintf_s_flag = 0;
    g_sprintf_s_flag2 = 1;
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiDeviceInfoProcess(&sock_desc));
    g_sprintf_s_flag = 0;
    g_sprintf_s_flag2 = 0;
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostApiDeviceInfoProcess(&sock_desc));
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostApiBoardIdProcess)
{
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_EXEC_API_REQ;
    struct dsmi_board_info_stru board_info;
    board_info.board_id = 0;

    MOCKER(dsmi_get_board_info)
        .stubs()
        .with(any(), outBoundP(&board_info, sizeof(board_info)))
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiBoardIdProcess(&sock_desc));
    g_sprintf_s_flag = 1;
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiBoardIdProcess(&sock_desc));
    g_sprintf_s_flag = 0;
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostApiBoardIdProcess(&sock_desc));


}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostApiBoardTypeProcess)
{
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_EXEC_API_REQ;

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_OK, IdeHostApiBoardTypeProcess(&sock_desc));
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostApiSysVersionProcess)
{
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_EXEC_API_REQ;

    MOCKER(dsmi_get_version)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostApiSysVersionProcess(&sock_desc));
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostApiSysVersionProcess(&sock_desc));
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockApiProcess)
{
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_EXEC_API_REQ;
    FILE* fd;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    struct tlv_req* req = NULL;

    MOCKER(IdeHostApiDeviceStatusProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(IdeHostApiDeviceInfoProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeHostApiBoardIdProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeHostApiSysVersionProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeSockDestroy)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("wrong argument") + 1);
    strcpy(req->value, "wrong argument");
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("device_status") + 1);
    strcpy(req->value, "device_status");
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("device_info") + 1);
    strcpy(req->value, "device_info");
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("os_type") + 1);
    strcpy(req->value, "os_type");
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("board_id") + 1);
    strcpy(req->value, "board_id");
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("sys_version") + 1);
    strcpy(req->value, "sys_version");
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);

    req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen("board_type") + 1);
    strcpy(req->value, "board_type");
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockApiProcess(&sock_desc, client, req));
    free(req);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostApiGetStatus)
{
    int count = 3;
    char status [3] = {0};
    int cameraIds[25];
    cameraIds[0] = 0;
    cameraIds[1] = 1;
    cameraIds[2] = 2;

    MOCKER(QueryCameraIds)
        .stubs()
        .with(outBoundP(cameraIds, sizeof(cameraIds)), outBoundP((uint32_t*)&count, sizeof(count)))
        .will(returnValue(0))
        .then(returnValue(1));

    IdeHostApiGetStatus(status, 2);
    IdeHostApiGetStatus(status, 2);
    EXPECT_CALL(IdeHostApiGetStatus(status, 2));
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostGetResolvedPath)
{
    char file_path[16] = "./a.txt";
    char dst_path[16] = "/var";
    std::string resolved_path;
    
    IdeHostGetResolvedPath(NULL, dst_path, resolved_path);
    EXPECT_STREQ("", resolved_path.c_str());
    GlobalMockObject::verify();

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERR));

    IdeHostGetResolvedPath(file_path, dst_path, resolved_path);
    GlobalMockObject::verify();

    //succ
    IdeHostGetResolvedPath(file_path, dst_path, resolved_path);
    EXPECT_STREQ("/var/a.txt", resolved_path.c_str());
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileSyncProcess)
{
    const char *value = "a.txt;/var/;";
    sock_desc_t sock_desc;
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc.handle = handle;
    sock_desc.type = IDE_FILE_SYNC_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 1);
    strcpy(req->value, value);

    MOCKER(IdeHostSockFileProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeSockWriteData)
            .stubs()
            .will(returnValue(IDE_DAEMON_OK));
    //fopen failed
    EXPECT_EQ(IDE_DAEMON_OK, IdeHostSockFileSyncProcess(&sock_desc, client, req));
    IdeXfree((void *)req);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileGetProcess)
{
    const char *value = "a.txt;/var/;";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc->handle = handle;
    sock_desc->type = IDE_FILE_GET_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 1);
    strcpy(req->value, value);

    MOCKER(IdeCheckPathIsValid)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeSockSendFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    //ide_file_is_exist fail
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileGetProcess(sock_desc, client, req));

    IdeXfree((void *)req);
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileGetProcess_file_path_invalid)
{
    const char *value = "a.txt;/var/;";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc->handle = handle;
    sock_desc->type = IDE_FILE_GET_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 1);
    strcpy(req->value, value);

    MOCKER(IdeCheckPath)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    //ide_file_is_exist fail
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileGetProcess(sock_desc, client, req));

    IdeXfree((void *)req);
    IdeXfree((void *)sock_desc);
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeHostSockFileGetProcess_path_is_valid)
{
    const char *value = "a.txt;/var/;";
    sock_desc_t *sock_desc = (sock_desc_t *)IdeXmalloc(sizeof(sock_desc_t));
    sock_handle_t handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,0};
    sock_desc->handle = handle;
    sock_desc->type = IDE_FILE_GET_REQ;
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;

    struct tlv_req *req = (struct tlv_req *)IdeXmalloc(sizeof(struct tlv_req) + strlen(value) + 1);
    strcpy(req->value, value);
    MOCKER(IdeCheckPathIsValid)
        .stubs()
        .will(returnValue(-1));
    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeHostSockFileGetProcess(sock_desc, client, req));
    IdeXfree((void *)req);
    IdeXfree((void *)sock_desc);

}

int HdcReadFileStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *okMsg = "[HDC_MSG]device file get success;/var/hdcd";
    const char *errorMsg = "[HDC_MSG]device file get failed";
    char *buf = nullptr;
    int len = 0;
    if (g_fileResponseMsg == 0) {
        buf = (char *)malloc(strlen(errorMsg) + 1);
        memcpy(buf, errorMsg, strlen(errorMsg));
        len = strlen(errorMsg);
    } else {
        buf = (char *)malloc(strlen(okMsg) + 1);
        memcpy(buf, okMsg, strlen(okMsg));
        len = strlen(okMsg);
    }
    *recvLen = len;
    *recvBuf = reinterpret_cast<IdeBuffT>(buf);
    return IDE_DAEMON_OK;
}

TEST_F(IDE_DAEMON_HOST_UTEST, IdeSendLastData)
{
   unsigned int remain = 10;
   sock_handle_t sock_handle={IdeChannel::IDE_CHANNEL_SOCK, (ssl_t*)0x123456,1};
   mmProcess handler = 123;
   int mem = sizeof(struct IdeData) + MAX_SEND_DADA_SIZE;
   struct IdeData* pdata = (struct IdeData*)IdeXmalloc(mem);

   MOCKER(mmCloseFile)
       .stubs()
       .will(returnValue(0));

   MOCKER(IdeTransferFile)
       .stubs()
       .will(returnValue(IDE_DAEMON_ERROR))
       .then(returnValue(IDE_DAEMON_OK));

    // fail
   EXPECT_EQ(IDE_DAEMON_ERROR, IdeSendLastData(*pdata, handler, sock_handle, mem, remain));

    //OK
   EXPECT_EQ(IDE_DAEMON_OK, IdeSendLastData(*pdata, handler, sock_handle, mem, remain));
   IdeXfree(pdata);

}
