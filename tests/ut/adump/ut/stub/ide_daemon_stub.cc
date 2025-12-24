/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <exception>
#include "ide_daemon_stub.h"
#include "slog.h"
#include <sys/types.h>
#include <asm/types.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include "common/config.h"

unsigned int g_init_flag = 0;
int g_getpkg_len_stub_flag = 0;
int g_getname_info_time;
int getifaddrs_time;
int g_netlink_notify_flag = 0;

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

int IdeHostLogProcess(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
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

int BboxHostInit(void)
{
    return IDE_DAEMON_OK;
}

int BboxHostDestroy(void)
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
int BboxSockCommandProcess(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req)
{
    return IDE_DAEMON_OK;
}

int IdeCmdProfileInit()
{
    return IDE_DAEMON_OK;
}

int IdeCmdProfileCmd(int sockfd, const char *cmd)
{
    return IDE_DAEMON_OK;
}

int IdeCmdProfileCmdRes(const char *str, int len)
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

int BboxDevStartupNotify(uint32_t num, uint32_t *dev)
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
    getifaddrs_time++;
    if (getifaddrs_time == 1)
    {
        return -1;
    }

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
    g_getname_info_time++;
    strcpy(host, "127.0.0.1");

    if (g_getname_info_time == 1) {
        return -1;
    }

    return 0;
}

hdcError_t drvGetDevNum(uint32_t *devices)
{
    *devices = 1;
    return DRV_ERROR_NONE;
}

hdcError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    memset_s(devices, len, 0, len);
    return DRV_ERROR_NONE;
}

hdcError_t drvGetDeviceLocalIDs(uint32_t *dev_id, uint32_t len)
{
    memset_s(dev_id, len, 0, len);
    return DRV_ERROR_NONE;
}


drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    return DRV_ERROR_NONE;
}

int mmGetPid()
{
    return getpid();
}

int mmGetTid()
{
    return syscall(SYS_gettid);
}

int mmGetOsType()
{
    return 0;
}

INT32 mmGetOptInd()
{
    return optind;
}

CHAR *mmGetOptArg()
{
    return optarg;
}

int mmScandir(const CHAR *path, mmDirent ***entryList, mmFilter filterFunc, mmSort sort)
{
    if ((path == NULL) || (entryList == NULL)) {
        return EN_INVALID_PARAM;
    }
    INT32 count = scandir(path, entryList, filterFunc, sort);
    if (count < MMPA_ZERO) {
        return EN_ERROR;
    }
    return count;
}

void mmScandirFree(mmDirent **entryList, INT32 count)
{
    if (entryList == NULL) {
        return;
    }
    int j;
    for (j = 0; j < count; j++) {
        if (entryList[j] != NULL) {
            free(entryList[j]);
            entryList[j] = NULL;
        }
    }
    free(entryList);
    entryList = NULL;
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

int close_stub(int fd)
{
    return 0;
}

int free_stub(int fd)
{
    return 0;
}

void DlogFlush(void)
{
    return;
}

#ifdef __cplusplus
}
#endif
