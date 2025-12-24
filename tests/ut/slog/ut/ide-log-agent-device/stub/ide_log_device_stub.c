/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ide_log_device_stub.h"

int HdcSessionDestroy(HDC_SESSION session)
{
     return DRV_ERROR_NONE;
}

int HdcSessionClose(HDC_SESSION session)
{
     return DRV_ERROR_NONE;
}

int HdcRead(HDC_SESSION session, void **buf, int *recv_len)
{
    return IDE_DAEMON_OK;
}

int AdxHdcWrite(HDC_SESSION session, const void *buf, int len)
{
    if(session == NULL)
    {
        return DRV_ERROR_INVALID_VALUE;
    }
    return IDE_DAEMON_OK;
}

int HdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session)
{
    return IDE_DAEMON_OK;
}

HDC_CLIENT GetIdeDaemonHdcClient()
{
    return (HDC_CLIENT)0x100;
}

int pthread_create(pthread_t *thread, const pthread_attr_t *attr,void *(*start_routine) (void *), void *arg)
{
    printf("pthread_create succeed.\n");
    return 0;
}

int pthread_detach(pthread_t tid)
{
    printf("pthread_detached succeed.\n");
    return 0;
}

void pthread_exit(void *retval){
}

void IdeLog(int priority, const char *format, ...)
{
    return ;
}

int msgget(key_t ket, int flags)
{
    return 0;
}

int msgsnd(key_t key, const void *msgs, size_t msgsz, int msgflg)
{
    return 0;
}

ssize_t func()
{
    return 0;
}

void *SetLogLevel(void *arg)
{
    return NULL;
}

void BBPerrorMsg(const char *s, ...)
{
    return;
}

int GetDebugMode()
{
    return 0;
}

void SetDebugMode(int val)
{

}

int log_write_slog(int device_id, const char *in_buf, unsigned int buf_size, int *write_size, unsigned int timeout)
{
    return 0;
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
// driver_hdc
#define HDC_RECV_MAX_LEN 524288 // 512KB buffer space
drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_PCIE;
    capacity->maxSegment = HDC_RECV_MAX_LEN;
    return DRV_ERROR_NONE;
}

drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    value = 1; // 1 non-docker; 2 docker
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

void AdxDestroyCommHandle(AdxCommHandle handle)
{

}

int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    *value = 0;
    return 0;
}

int32_t AdxSendMsg(const CommHandle *handle, const char *data, uint32_t len)
{
    return 0;
}

int32_t AdxRecvMsg(AdxCommHandle handle, char **data, uint32_t *len, uint32_t timeout)
{
    return 0;
}

int32_t AdxSendMsgByHandle(const CommHandle *handle, CmdClassT type, IdeString data, uint32_t len)
{
    return 0;
}

drvError_t halGetDevNumEx(uint32_t hw_type, uint32_t *devNum)
{
    if (hw_type == 0) {
        *devNum = 1;
        return 0;
    } else {
        *devNum = 0;
        return 1;
    }
}

drvError_t halGetDevIDsEx(uint32_t hw_type, uint32_t *devices, uint32_t len)
{
    if (hw_type == 0) {
        devices[0] = 0;
        return 0;
    } else {
        return 1;
    }
}

DLLEXPORT drvError_t drvDeviceStatus(uint32_t devId, drvStatus_t *status)
{
    return DRV_ERROR_NONE;
}

int log_read(int device_id, char *buf, unsigned int *size, int timeout)
{
    return 0;
}

int log_get_channel_type(int device_id, int *channel_type_set, int *channel_type_num, int set_size)
{
    return 0;
}

int log_set_level(int device_id, int channel_type, unsigned int log_level)
{
    return 0;
}

int log_read_by_type(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type)
{
    (void)device_id;
    (void)buf;
    (void)size;
    (void)channel_type;
    usleep(timeout);
    return LOG_NOT_READY;
}

void LogPrintSelf(const char *format, ...)
{
    va_list args;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}

void LogPrintSys(int priority, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}

