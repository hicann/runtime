/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal_stub.h"
#include "library_load.h"
#include "plog_drv.h"
#include "plog_stub.h"

static int64_t g_ServerTypeValue = -1;
static int32_t g_ServerTypeRet = DRV_ERROR_NOT_SUPPORT;
void SetServerType(long long value, int ret)
{
    g_ServerTypeValue = value;
    g_ServerTypeRet = ret;
}

void ReSetServerType(void)
{
    g_ServerTypeValue = -1;
    g_ServerTypeRet = DRV_ERROR_NOT_SUPPORT;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    *value = g_ServerTypeValue;
    return g_ServerTypeRet;
}

drvError_t drvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    uintptr_t clt = 1;
    *client = (HDC_CLIENT)clt;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcClientDestroy(HDC_CLIENT client)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session)
{
    uintptr_t ses = 1;
    *session = (HDC_SESSION)ses;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcSessionClose(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    struct drvHdcMsg *msg = (struct drvHdcMsg *)calloc(1, sizeof(struct drvHdcMsg));
    if (msg == NULL) {
        printf("calloc hdc msg failed.\n");
        return DRV_ERROR_RESERVED;
    }
    *ppMsg = msg;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcFreeMsg(struct drvHdcMsg *msg)
{
    free(msg);
    msg = NULL;
    return DRV_ERROR_NONE;
}

drvError_t drvHdcReuseMsg(struct drvHdcMsg *msg)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcGetMsgBuffer(struct drvHdcMsg *msg, int index, char **pBuf, int *pLen)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcSetSessionReference(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    *info = 1; // HOST_SIDE
    return DRV_ERROR_NONE;
}

drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    capacity->maxSegment = HDC_RECV_MAX_LEN;
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcRecv(HDC_SESSION session, struct drvHdcMsg *pMsg, int bufLen,
    UINT64 flag, int *recvBufCount, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

static int g_ctlCmd = HAL_CTL_REGISTER_RUN_LOG_OUT_HANDLE;
void SetDrvCrlCmd(int cmd)
{
    g_ctlCmd = cmd;
}

drvError_t halCtl(int cmd, void *param_value, size_t param_value_size, void *out_value, size_t *out_size_ret)
{
    if (cmd == HAL_CTL_UNREGISTER_LOG_OUT_HANDLE) {
        return DRV_ERROR_NONE;
    }

    if (cmd == g_ctlCmd) {
        return DRV_ERROR_NONE;
    } else {
        return DRV_ERROR_NOT_SUPPORT;
    }
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 1;
    return 0;
}

int readEndMsg(void *session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout)
{
    char *msg = (char *)calloc(1, sizeof(HDC_END_BUF) + 1);
    if (msg == NULL) {
        printf("calloc failed.\n");
        return -1;
    }
    void *ret = memcpy(msg, HDC_END_BUF, sizeof(HDC_END_BUF));
    if (ret == NULL) {
        printf("memcpy failed.\n");
        free(msg);
        return -1;
    }
    unsigned int msgLen = sizeof(HDC_END_BUF);
    *buf = msg;
    *bufLen = msgLen;
    return 0;
}

#define TEST_DEVICE_LOG "0[INFO] CCECPU(1123, aicpu_scheduler):2024-05-21-02:33:13.948.163 test for device log.\n\0"
int readDeviceMsg(void *session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout)
{
    static int count = 0;
    count++;
    usleep(timeout * 1000);
    if (count <= 10) {
        char *msg = (char *)calloc(1, sizeof(TEST_DEVICE_LOG) + 1);
        if (msg == NULL) {
            printf("calloc failed.\n");
            return -1;
        }
        void *ret = memcpy(msg, TEST_DEVICE_LOG, sizeof(TEST_DEVICE_LOG));
        if (ret == NULL) {
            printf("memcpy failed.\n");
            free(msg);
            return -1;
        }
        unsigned int msgLen = sizeof(TEST_DEVICE_LOG);
        *buf = msg;
        *bufLen = msgLen;
        return 0;
    } else {
        return readEndMsg(session, devId, buf, bufLen, timeout);
    }
}

int DrvBufReadSessionClose(void *session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout)
{
    return LOG_SESSION_CLOSE;
}

drvError_t drvHdcSessionConnectClose(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session)
{
    return 34;
}

drvError_t drvHdcClientCreate_failed(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    *client = 0;
    return DRV_ERROR_NONE;
}
