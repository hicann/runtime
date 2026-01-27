/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __IDE_DAEMON_STUB_STEST_H
#define __IDE_DAEMON_STUB_STEST_H

#include "ascend_hal.h"
#include "hdc_api.h"
#include <unistd.h>
#include <string.h>
#include "mmpa_api.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netdb.h>
#include <sys/syscall.h>

extern int g_getpkg_len_stub_flag;
extern int g_ide_create_task_time;
extern int g_nv_type;
enum host_type
{
    HOST_SOCK,
    HOST_HDC
};

#ifdef __cplusplus
extern "C" {
#endif
typedef struct IdeSockDesc sock_desc_t;
typedef mmSockHandle ssl_handle_t;
typedef struct IdeDevInfo dev_info_t;
typedef struct IdeCmdInfo cmd_info_t;
hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_dump_stub(struct drvHdcMsg *msg, int index,
        char **pBuf, int *pLen);

extern hdcError_t ide_hdc_host_drvHdcRecv_stub(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
                      unsigned long long flag, int *recvBufCount, unsigned int timeout);
extern hdcError_t ide_hdc_host_drvHdcRecv_stub1(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
                      unsigned long long flag, int *recvBufCount, unsigned int timeout);
extern hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen);
extern hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub1(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen);
extern hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub2(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen);
extern hdcError_t ide_hdc_host_drvHdcGetMsgBuffer_stub_nv (
    struct drvHdcMsg *msg, int index, char **pBuf, int *pLen);

extern hdcError_t ide_hdc_host_drvHdcFreeMsg_stub(struct drvHdcMsg *msg);
extern hdcError_t IdeHdcDeviceDrvHdcGetMsgBufferStub(struct drvHdcMsg *msg, int index,
        char **pBuf, int *pLen);

extern int hdc_init_mock(void);
extern int debug_init_mock(void);
extern int bbox_init_mock(void);
extern int log_init_mock(void);
extern int profile_init_mock(void);

extern int hdc_destroy_mock(void);
extern int debug_destroy_mock(void);
extern int bbox_destroy_mock(void);
extern int log_destroy_mock(void);
extern int profile_destroy_mock(void);

extern int debug_dev_process_stub(HDC_SESSION session, const struct tlv_req *req);
extern int debug_host_process_stub(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req);
extern int ide_host_sock_cmd_process_stub(void *sock_desc, HDC_CLIENT client, const struct tlv_req *req);
extern void _exit_stub(int exit_code);
extern pid_t fork_stub(void);
extern INT32 mmCreateTaskWithDetach_Stub(mmThread *pstThreadHandle, mmUserBlock_t *pstFuncBlock);
INT32 mmReadFile_stub(mmProcess fileId, VOID* buffer, INT32 len);
extern int getifaddrs_stub(struct ifaddrs **ifap);
extern int freeifaddrs_stub(struct ifaddrs *ifa);
extern int getnameinfo_stub(const struct sockaddr *addr, socklen_t addrlen,
                       char *host, socklen_t hostlen,
                       char *serv, socklen_t servlen, int flags);
extern drvError_t drvGetDevNum(uint32_t *devices);
extern drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len);
extern ssize_t recvmsg_stub(int sockfd, struct msghdr *msg, int flags);
extern INT32 mmSleep_stub(UINT32 millseconds);
extern int gettimeofday_stub(struct  timeval*tv,struct  timezone *tz );

extern int scanf_s_ret;
extern int close_stub(int fd);
extern int free_stub(int fd);
#ifdef __cplusplus
}
#endif

#endif

