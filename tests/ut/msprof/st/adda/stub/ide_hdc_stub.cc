/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal.h"
#include "hdc_api.h"
#include "securec.h"
#include "ide_daemon_hdc.h"
#include "cstring"

extern struct IdeGlobalCtrlInfo g_ideGlobalInfo;
int g_hdc_session_accept;
int g_hdc_server_create_flag;

hdcError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    *ppMsg = (struct drvHdcMsg*)0x12345678;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->maxSegment = 32 * 1024;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcReuseMsg(struct drvHdcMsg *msg)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcRecv(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
                      unsigned long long flag, int *recvBufCount, unsigned int timeout)
{
    *recvBufCount = 1;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcFreeMsg(struct drvHdcMsg *msg)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcGetMsgBuffer(struct drvHdcMsg *msg, int index,
                              char **pBuf, int *pLen)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *msg,
                      unsigned long long flag, unsigned int timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcServerDestroy(HDC_SERVER server)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcGetTrustedBasePath(int peer_node, int peer_devid,
    char *base_path, unsigned int path_len){
    if (path_len > strlen("/tmp")) {
        memcpy(base_path, "/tmp", strlen("/tmp"));
    }
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSendFile(int peer_node, int peer_devid, const char *file, const char *dst_path, 
                                    void (*progressNotifier)(struct drvHdcProgInfo *))
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcServerCreate(int devid, int serviceType, HDC_SERVER *pServer)
{
    *pServer = (HDC_SERVER)0x123245678;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSessionConnect(int peer_node, int peer_devid,
    HDC_CLIENT client, HDC_SESSION *session)
{
    *session = (HDC_SESSION)0x123245678;
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSessionConnectEx(int peer_node, int peer_devid,
    int host_pid, HDC_CLIENT client, HDC_SESSION *session)
{
    *session = (HDC_SESSION)0x123245678;
    return DRV_ERROR_NONE;
}


hdcError_t drvHdcSessionClose(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSessionAccept(HDC_SERVER server, HDC_SESSION *session)
{
    *session = (HDC_SESSION)0x123456789;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSessionAccept_stub(HDC_SERVER server, HDC_SESSION *session)
{
    *session = (HDC_SESSION)0x123456789;
    g_ideGlobalInfo.hdcHandleEventFlag = false;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcServerCreate_stub(int devid, int serviceType, HDC_SERVER *server)
{
    g_hdc_server_create_flag++;

    if(g_hdc_server_create_flag == 1) {
        *server = (HDC_SERVER)0x123245678;
        return DRV_ERROR_NONE;
    } else if (g_hdc_server_create_flag == 2){
        *server = (HDC_SERVER)0x123245678;
        return DRV_ERROR_DEVICE_NOT_READY;
    } else {
        *server = (HDC_SERVER)0x123245678;
        return DRV_ERROR_NONE;
    }
}

hdcError_t drvHdcSessionAccept_failed(HDC_SERVER server, HDC_SESSION *session)
{
    *session = (HDC_SESSION)0x123456789;
    g_hdc_session_accept++;

    if (g_hdc_session_accept == 1) {
        return DRV_ERROR_DEVICE_NOT_READY;
    } else if (g_hdc_session_accept == 2) {
        g_ideGlobalInfo.hdcHandleEventFlag = false;
        return DRV_ERROR_NONE;
    } else {
        return DRV_ERROR_NONE;
    }
}

hdcError_t drvHdcSetSessionReference(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    *client = (HDC_CLIENT)0x78563421;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcClientDestroy(HDC_CLIENT client)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    if (attr == HDC_SESSION_ATTR_DEV_ID) {
        *value = 0;
    } else if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = RUN_ENV_PHYSICAL;
    } else {
        *value = 0;
    }
    return DRV_ERROR_NONE;
}


#ifdef __cplusplus
extern "C" {
#endif
typedef int (*drvDeviceStartupNotify)(uint32_t num, uint32_t* devId);

drvError_t drvDeviceGetCount(int32_t *count)
{
    *count = 2;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceStartupRegister(drvDeviceStartupNotify startup_callback)
{
    uint32_t num[2]={1,2};
    startup_callback(2,num);
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceStateNotifierRegister(drvDeviceStateNotify state_callback)
{
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    *phyId = devIndex;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    *devIndex = phyId;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcEpollCreate(int size, HDC_EPOLL * epoll)
{
    *epoll = (HDC_EPOLL)0x12345678;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcEpollCtl(HDC_EPOLL epoll, int op, void * target, struct drvHdcEvent * event)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcEpollClose(HDC_EPOLL epoll)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcEpollWait(HDC_EPOLL epoll, struct drvHdcEvent * events, int maxevents, int timeout, int * eventnum)
{
    return DRV_ERROR_NONE;
}

#ifdef __cplusplus
}
#endif

