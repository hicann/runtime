/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ide_daemon_stub.h"
#include "ide_common_util.h"
#include "slog.h"
#include "ide_daemon_hdc.h"
#include <sys/types.h>
#include <asm/types.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include "ide_daemon_api.h"

using namespace Adx;
using namespace Analysis::Dvvp::Adx;


int PackData(struct IdePack &pack, IdeString buf, uint32_t size, uint32_t order, uint32_t isLast);

extern "C"{
#include "dsmi_common_interface.h"
}
unsigned int g_init_flag = 0;
#define MAX_SEND_DADA_SIZE 1024000
int g_netlink_notify_flag = 0;
int g_getpkg_len_stub_flag = 0;
int g_ide_cmd_write_time = 0;
int g_ide_cmd_read_time = 0;
int g_ide_cmd_recv_time = 0;
int g_ide_cmd_recv_time_host = 0;
int g_ide_cmd_recv_time_host1 = 0;
int g_ide_cmd_get_pkt_time = 0;
int g_ide_nv_recv_time = 0;
int g_ide_hiai_read_time = 0;
int g_ide_hiai_write_time = 0;
int g_ide_sync_time = 0;
int gIdeHdcRecvTime = 0;
int g_HdcStorePackage_is_not_last = 0;
enum host_type g_ide_host_type = HOST_SOCK;

int g_ide_recv_time = 0;
int g_fork_time = 0;
enum cmd_class g_ide_daemon_host_req_type = IDE_EXEC_COMMAND_REQ;
enum cmd_class g_ide_daemon_device_req_type = IDE_EXEC_COMMAND_REQ;
enum cmd_class g_ide_daemon_hiai_req_type = IDE_EXEC_COMMAND_REQ;
int g_ideDaemonHiaiOffsetFlag = 0;
int g_ide_daemon_send_file_req = 0;
int g_nv_type = 1;
char *g_msg_pbuf = NULL;

void ide_stub_create_tlv(enum cmd_class type, char *str, int str_len, struct tlv_req **req)
{
    struct tlv_req *tmp = NULL;
    int len = sizeof(struct tlv_req) + str_len;
    tmp = (struct tlv_req *)IdeXmalloc(len);
    tmp->type = type;
    tmp->len = str_len;
    tmp->dev_id = 0;
    memcpy(tmp->value, str, tmp->len);

    *req = tmp;
}

int ide_stub_get_tlv_len(struct tlv_req *req)
{
	return sizeof(struct tlv_req) + req->len;
}

hdcError_t ide_hdc_host_drvHdcRecv_stub(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
        unsigned long long flag, int *recvBufCount, unsigned int timeout)
{
    g_ide_recv_time++;
    *recvBufCount = 1;

    if(g_ide_host_type == HOST_SOCK)
    {
        if (1 == g_ide_recv_time)
        {
            return DRV_ERROR_NONE;
        }
        else if (2 == g_ide_recv_time)
        {
            return DRV_ERROR_SOCKET_CLOSE;
        }
    }
    else if(g_ide_host_type == HOST_HDC)
    {
        if (1 == g_ide_recv_time || 2 == g_ide_recv_time)
        {
            return DRV_ERROR_NONE;
        }
        else if (3 == g_ide_recv_time)
        {
            return DRV_ERROR_SOCKET_CLOSE;
        }
    }
}

hdcError_t ide_hdc_host_drvHdcRecv_stub1(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
					  unsigned long long flag, int *recvBufCount, unsigned int timeout)
{
	g_ide_recv_time++;
	*recvBufCount = 1;

    if (1 == g_ide_recv_time || 2 == g_ide_recv_time)
	    {
			return DRV_ERROR_NONE;
	    }
	    else if (3 == g_ide_recv_time)
	    {
			return DRV_ERROR_SOCKET_CLOSE;
	    }
}

hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub(struct drvHdcMsg *msg, int index,
        char **pBuf, int *pLen)
{
    int len = 0;
    struct tlv_req *tmp = NULL;
    struct IdeHdcPacket* packet=NULL;

    if(g_ide_host_type == HOST_SOCK)
    {
        len = sizeof(struct tlv_req) + sizeof("ls");
        tmp = (struct tlv_req *)IdeXmalloc(len);
        tmp->type = g_ide_daemon_device_req_type;
        tmp->len = sizeof("ls");
        tmp->dev_id = 0;
        memcpy(tmp->value, "ls", tmp->len);

    }

    packet = (struct IdeHdcPacket *)IdeXmalloc(len+sizeof(struct IdeHdcPacket));
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    if (!g_HdcStorePackage_is_not_last) {
        packet->isLast = static_cast<int8_t>(IdeLastPacket::IDE_LAST_PACK);
    } else {
        packet->isLast = static_cast<int8_t>(IdeLastPacket::IDE_NOT_LAST_PACK);
    }
    packet->len=len;
    memcpy(packet->value, tmp, len);
    *pBuf = (char *)packet;
    *pLen = len;

    g_msg_pbuf = *pBuf;

    IdeXfree(tmp);
    tmp = NULL;
    return DRV_ERROR_NONE;
}

hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub2(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen)
{
	int len = 0;
    int string_len = 0;
    char *tmp = NULL;
	struct IdeHdcPacket* packet=NULL;
    const char *string_tmp = NULL;

    if (1 == g_ide_recv_time) {
    } else {
        string_tmp = "debug-test";
        string_len = strlen("debug-test");
    }
    //string_tmp = CCE_GDBSERVER_CONNECT_SUCCESS_MSG;
	if(g_ide_host_type == HOST_HDC)
	{
		len = string_len + 1;
		tmp = (char *)IdeXmalloc(len);
        memset_s(tmp, len, 0, len);
		memcpy(tmp, string_tmp, string_len);
	}

	packet = (struct IdeHdcPacket *)IdeXmalloc(len+sizeof(struct IdeHdcPacket));
	packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
	packet->isLast = static_cast<int8_t>(IdeLastPacket::IDE_LAST_PACK);
	packet->len=len;
	memcpy(packet->value, tmp, len);
	*pBuf = (char *)packet;
	*pLen = len;

	g_msg_pbuf = *pBuf;

	IdeXfree(tmp);
	tmp = NULL;
	return DRV_ERROR_NONE;
}

hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub1(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen)
{
	int len = 0;
    int string_len = 0;
    char *tmp = NULL;
	struct IdeHdcPacket* packet=NULL;
    const char *string_tmp = NULL;

    if (1 == g_ide_recv_time) {
    } else {
        string_tmp = HDC_END_MSG;
        string_len = strlen(HDC_END_MSG);
    }
    //string_tmp = CCE_GDBSERVER_CONNECT_SUCCESS_MSG;
	if(g_ide_host_type == HOST_HDC)
	{
		len = string_len + 1;
		tmp = (char *)IdeXmalloc(len);
        memset_s(tmp, len, 0, len);
		memcpy(tmp, string_tmp, string_len);
	}

	packet = (struct IdeHdcPacket *)IdeXmalloc(len+sizeof(struct IdeHdcPacket));
	packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
	packet->isLast = static_cast<int8_t>(IdeLastPacket::IDE_LAST_PACK);
	packet->len=len;
	memcpy(packet->value, tmp, len);
	*pBuf = (char *)packet;
	*pLen = len;

	g_msg_pbuf = *pBuf;

	IdeXfree(tmp);
	tmp = NULL;
	return DRV_ERROR_NONE;
}

hdcError_t ide_hdc_host_drvHdcFreeMsg_stub(struct drvHdcMsg *msg)
{
    IdeXfree(g_msg_pbuf);
    g_msg_pbuf = NULL;
    return DRV_ERROR_NONE;
}

hdcError_t IdeHdcDeviceDrvHdcGetMsgBufferStub(struct drvHdcMsg *msg, int index,
        char **pBuf, int *pLen)
{
    int len = 0;
    struct tlv_req *tmp = NULL;
    struct IdeHdcPacket* packet=NULL;
    len = sizeof(struct tlv_req) + sizeof("/home/HwHiAiUser/ide_daemon/test.sh;/home/HwHiAiUser/ide_daemon/check.sh");
    tmp = (struct tlv_req *)IdeXmalloc(len);
    tmp->type = g_ide_daemon_device_req_type;
    tmp->len = sizeof("/home/HwHiAiUser/ide_daemon/test.sh;/home/HwHiAiUser/ide_daemon/check.sh");
    tmp->dev_id = 0;
    memcpy(tmp->value, "/home/HwHiAiUser/ide_daemon/test.sh;/home/HwHiAiUser/ide_daemon/check.sh", tmp->len);
    packet = (struct IdeHdcPacket *)IdeXmalloc(len+sizeof(struct IdeHdcPacket));
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    if (!g_HdcStorePackage_is_not_last) {
        packet->isLast = static_cast<int8_t>(IdeLastPacket::IDE_LAST_PACK);
    } else {
        packet->isLast = static_cast<int8_t>(IdeLastPacket::IDE_NOT_LAST_PACK);
    }
    packet->len=len;
    memcpy(packet->value, tmp, len);
    *pBuf = (char *)packet;
    *pLen = len;

    g_msg_pbuf = *pBuf;

    IdeXfree(tmp);
    tmp = NULL;

    return DRV_ERROR_NONE;
}


pid_t fork_stub(void)
{
    g_fork_time++;
    if(g_fork_time == 1)
        return 0;
    else
    {
        return fork();
    }
}

int hdc_init_mock(void)
{
	return IDE_DAEMON_OK;
}

int debug_init_mock(void)
{
	return IDE_DAEMON_OK;
}

int bbox_init_mock()
{
	return IDE_DAEMON_OK;
}

int log_init_mock(void)
{
	return IDE_DAEMON_OK;
}

int profile_init_mock()
{
	return IDE_DAEMON_OK;
}

int hdc_destroy_mock(void)
{
	return IDE_DAEMON_OK;
}

int debug_destroy_mock(void)
{
	return IDE_DAEMON_OK;
}

int bbox_destroy_mock(void)
{
	return IDE_DAEMON_OK;
}

int log_destroy_mock(void)
{
	return IDE_DAEMON_OK;
}

int profile_destroy_mock(void)
{
	return IDE_DAEMON_OK;
}

int debug_dev_process_stub(HDC_SESSION session, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}

int debug_host_process_stub(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}

int ide_host_sock_cmd_process_stub(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}

void _exit_stub(int exit_code)
{
	return;
}

#ifdef __cplusplus
extern "C"
{
#endif

int HdclogDeviceInit()
{
    return IDE_DAEMON_OK;
}

int HdclogDeviceDestroy()
{
    return IDE_DAEMON_OK;
}

int HdclogHostInit()
{
    return IDE_DAEMON_OK;
}

int HdclogHostDestroy()
{
    return IDE_DAEMON_OK;
}

int IdeDeviceLogProcess(HDC_SESSION session, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}
int BboxSockCommandProcess(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}
int BboxRemoteInit(void)
{
	return IDE_DAEMON_OK;
}

int BboxRemoteDestroy(void)
{
	return IDE_DAEMON_OK;
}

int BboxDevStartupNotify(uint32_t num, uint32_t *dev)
{
	return IDE_DAEMON_OK;
}

int BboxHostInit(void)
{
	return IDE_DAEMON_OK;
}

int BboxHostDestroy(void)
{
	return IDE_DAEMON_OK;
}

int BboxDaemonInit(void)
{
    return IDE_DAEMON_OK;
}

int BboxDaemonDestroy(void)
{
    return IDE_DAEMON_OK;
}

int IdeHostProfileInit()
{
	return IDE_DAEMON_OK;
}
int IdeHostProfileCleanup()
{
	return IDE_DAEMON_OK;
}
int IdeDeviceProfileInit()
{
	return IDE_DAEMON_OK;
}

int IdeDeviceProfileCleanup()
{
	return IDE_DAEMON_OK;
}

int IdeHostProfileProcess(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}

int IdeDeviceProfileProcess(HDC_SESSION session, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}

int IdeCmdProfileInit()
{
	return IDE_DAEMON_OK;
}

int IdeCmdProfileCmdRes(const char *str, int len)
{
	return IDE_DAEMON_OK;
}

int IdeHostLogProcess(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
{
	return IDE_DAEMON_OK;
}

int IdeCmdLogProcess(int sockfd, unsigned int dev_id, const char *cmd)
{
	return IDE_DAEMON_OK;
}

void StackInit(void) {};

void dlog_init(void) {};

int DlogSetAttr(LogAttr logAttr)
{
    return IDE_DAEMON_OK;
}

void DlogErrorInner(int module_id, const char *fmt, ...){
    va_list marker;
    va_start(marker, fmt);
    vprintf(fmt, marker);
    va_end(marker);
}

void DlogWarnInner(int module_id, const char *fmt, ...){
    va_list marker;
    va_start(marker, fmt);
    vprintf(fmt, marker);
    va_end(marker);
}

void DlogInfoInner(int module_id, const char *fmt, ...){
    va_list marker;
    va_start(marker, fmt);
    vprintf(fmt, marker);
    va_end(marker);
}

void DlogDebugInner(int module_id, const char *fmt, ...){
    va_list marker;
    va_start(marker, fmt);
    vprintf(fmt, marker);
    va_end(marker);
}

void DlogEventInner(int module_id, const char *fmt, ...){
    va_list marker;
    va_start(marker, fmt);
    vprintf(fmt, marker);
    va_end(marker);
}

void DlogRecord(int module_id, int level, const char *fmt, ...){
    va_list marker;
    va_start(marker, fmt);
    vprintf(fmt, marker);
    va_end(marker);
}

int CheckLogLevel(int moduleId, int level)
{
    return 0;
}

int BboxHDCAddSesssion(HDC_SESSION session, const struct tlv_req *req)
{
	return 0;
}

//static int drvGetDevNum_time = 0;
drvError_t drvGetDevNum(uint32_t *devices)
{
    *devices = 10;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    memset_s(devices, 64, 5, 10);
    return DRV_ERROR_NONE;
}

drvError_t drvGetDeviceLocalIDs(uint32_t *devices, uint32_t len)
{
    memset_s(devices, 64, 5, 10);
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    *status = DRV_STATUS_WORK;
    return DRV_ERROR_NONE;
}

int dsmi_get_board_info(int device_id, dsmi_board_info_stru * pboard_info)
{
    if (device_id == 0x0A)
    {
        return 2;
    }
    return 0;
}

int dsmi_get_version(int device_id, char* verison_str, unsigned int strLen, unsigned int *len)
{
    return 0;
}

int dsmi_dft_init()
{
    return 0;
}

int gettimeofday_stub(struct  timeval*tv,struct  timezone *tz )
{
    tv->tv_sec=0;
    return 0;
}

int getifaddrs_stub(struct ifaddrs **ifap)
{
    char *ifa_name = "lo";
    struct ifaddrs *pst_ifaddr = (struct ifaddrs *)malloc(sizeof(struct ifaddrs));
    struct sockaddr *ifa_addr = (struct sockaddr *)malloc(sizeof(struct sockaddr));
    struct ifaddrs *pst_ifaddr_next = (struct ifaddrs *)malloc(sizeof(struct ifaddrs));
    struct sockaddr *ifa_addr_next = (struct sockaddr *)malloc(sizeof(struct sockaddr));

    pst_ifaddr->ifa_name = ifa_name;
    pst_ifaddr->ifa_next = pst_ifaddr_next;
    pst_ifaddr->ifa_addr = ifa_addr;
    ifa_addr->sa_family = AF_UNSPEC;

    pst_ifaddr_next->ifa_name = ifa_name;
    pst_ifaddr_next->ifa_next = NULL;
    pst_ifaddr_next->ifa_addr = ifa_addr_next;
    ifa_addr_next->sa_family = AF_INET;


    *ifap = pst_ifaddr;
    return 0;
}

int freeifaddrs_stub(struct ifaddrs *ifa)
{
	free(ifa->ifa_next->ifa_addr);
    free(ifa->ifa_next);
	free(ifa->ifa_addr);
    free(ifa);
	return 0;
}

int getnameinfo_stub(const struct sockaddr *addr, socklen_t addrlen,
                       char *host, socklen_t hostlen,
                       char *serv, socklen_t servlen, int flags)
{
	strcpy(host, "127.0.0.1");
	return 0;
}

int IdeSigError(int signo,const struct sigaction* act,struct sigaction* oact)
{
    act->sa_handler(0);
    return -1;
}

ssize_t recvmsg_stub(int sockfd, struct msghdr *msg, int flags)
{

    struct nlmsghdr* nlh = (struct nlmsghdr*)msg->msg_iov->iov_base;
    nlh->nlmsg_len = 88;
    if (g_netlink_notify_flag == 0) {
        nlh->nlmsg_type = RTM_NEWADDR;
    } else if (g_netlink_notify_flag == 1) {
        nlh->nlmsg_type = RTM_DELADDR;
    } else {
        nlh->nlmsg_type = RTM_GETLINK;
    }

    struct ifaddrmsg *ifaddr = (struct ifaddrmsg *)NLMSG_DATA(nlh);
    ifaddr->ifa_family = 2;
    ifaddr->ifa_prefixlen = 24;
    ifaddr->ifa_flags = 128;
    ifaddr->ifa_scope = 0;
    ifaddr->ifa_index = 8;

    struct rtattr *attr = IFA_RTA (ifaddr);
    attr->rta_len = 8;
    attr->rta_type = 1;

    return 88;
}

INT32 mmSleep_stub(UINT32 millseconds)
{
    usleep(millseconds);
    return 0;
}

int scanf_s_ret = 0;
int scanf_s(const char* format, ...)
{
    return scanf_s_ret--;
}

void PrintIdeSelfLog(IdeString logFile, IdeString format, ...)
{
    return;
}
int close_stub(int fd)
{
    return 0;
}

int free_stub(int fd)
{
    return 0;
}

errno_t strncpy_s(char *strDest, size_t destMax, const char *strSrc, size_t count)
{
    return 0;
}

#ifdef __cplusplus
}
#endif

