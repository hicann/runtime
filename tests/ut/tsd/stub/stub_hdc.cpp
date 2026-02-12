/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include <stdint.h>
#include <sys/types.h>
#include <stdlib.h>
#include "inc/log.h"
#include <unistd.h>

#include <mutex>
#include <atomic>
#include <condition_variable>


extern "C" DVresult drvMemInitSvmDevice(pid_t hostpid);

extern "C" drvError_t drvGetDevNum(uint32_t *num_dev);

extern "C" drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len);

extern "C" hdcError_t drvHdcRecvPeek(HDC_SESSION session, int *msgLen, int flag);

std::atomic_bool                    g_drvRunning(false);    // 标记是否为工作状态.
std::mutex                          g_drvHdcMutex;          // 等待连接请求时的锁
std::condition_variable             g_drvHdcCond;           // 等待连接请求信号量

DVresult drvMemInitSvmDevice(pid_t hostpid)
{
    if((pid_t)0 == hostpid)
        return DRV_ERROR_NONE;
    return DRV_ERROR_NO_DEVICE;
}


hdcError_t  drvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSessionClose(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcClientDestroy(HDC_CLIENT client)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcServerCreate(int devid, int serviceType, HDC_SERVER *pServer)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcServerDestroy(HDC_SERVER server)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSessionAccept(HDC_SERVER server, HDC_SESSION *session)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **msg, int count)
{
    *msg = reinterpret_cast<drvHdcMsg*>(malloc(10));
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcFreeMsg(struct drvHdcMsg *msg)
{
    free(msg);
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcReuseMsg(struct drvHdcMsg *msg)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcGetMsgBuffer(struct drvHdcMsg *msg, int index, char **pBuf, int *pLen)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcRecv(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen, UINT64 flag, int *recvBufCount,
    UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcSend(HDC_SESSION session, struct drvHdcMsg *msg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->maxSegment = 1024 * 1024;
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcSetSessionReference(HDC_SESSION session)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 2;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    devices[0] = 100;
    devices[1] = 101;
    return DRV_ERROR_NONE;
}

hdcError_t halHdcFastSend(HDC_SESSION session, struct drvHdcFastSendMsg msg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcFastRecv(HDC_SESSION session, struct drvHdcFastRecvMsg *msg, UINT64 flag, UINT32 timeout)
{
    return DRV_ERROR_NONE;
}

void * drvHdcMalloc(HDC_SESSION session, enum drvHdcMemType mem_type, unsigned int len)
{
    return (void*)malloc(len);
}

hdcError_t drvHdcFree(HDC_SESSION session, enum drvHdcMemType mem_type, void *buf)
{
    if(nullptr != buf)
    {
        free(buf);
        buf = nullptr;
    }
    return DRV_ERROR_NONE;
}

char *tmpBuff = nullptr;
hdcError_t drvHdcDmaMap(enum drvHdcMemType mem_type, void *buf, int devid){return DRV_ERROR_NONE;}
hdcError_t drvHdcDmaUnMap(enum drvHdcMemType mem_type, void *buf){return DRV_ERROR_NONE;}
hdcError_t drvHdcDmaReMap(enum drvHdcMemType mem_type, void *buf, int devid){return DRV_ERROR_NONE;}

void * drvHdcMallocDev(enum drvHdcMemType mem_type, unsigned int len, int devid)
{
	if(tmpBuff)
	{
		delete []tmpBuff;
		tmpBuff = nullptr;
	}
	tmpBuff = new char[len];
	return tmpBuff;
}
hdcError_t drvHdcFreeDev(enum drvHdcMemType mem_type, void *buf, int devid)
{
	if(tmpBuff)
	{
		delete []tmpBuff;
		tmpBuff = nullptr;
	}
	return DRV_ERROR_NONE;
}

void * drvHdcMalloc(enum drvHdcMemType mem_type, unsigned int len)
{
	if(tmpBuff)
	{
		delete []tmpBuff;
		tmpBuff = nullptr;
	}
	tmpBuff = new char[len];
	return tmpBuff;
}
hdcError_t drvHdcFree(enum drvHdcMemType mem_type, void *buf)
{
	if(tmpBuff)
	{
		delete []tmpBuff;
		tmpBuff = nullptr;
	}
	return DRV_ERROR_NONE;
}

void *drvHdcMallocEx(enum drvHdcMemType mem_type, void *addr, unsigned int align,
    unsigned int len, int devid, unsigned int flag)
{
    if(tmpBuff)
    {
        delete []tmpBuff;
        tmpBuff = nullptr;
    }
    tmpBuff = new char[len];
    return tmpBuff;
}

hdcError_t drvHdcFreeEx(enum drvHdcMemType mem_type, void *buf)
{
    if(tmpBuff)
    {
        delete []tmpBuff;
        tmpBuff = nullptr;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvCreateAicpuWorkTasks(pid_t pid, int32_t mode)
{
    return (drvError_t)(1);
}

hdcError_t drvHdcRecvPeek(HDC_SESSION session, int *msgLen, int flag)
{
    return DRV_ERROR_NONE;
}

hdcError_t drvHdcRecvBuf(HDC_SESSION session, char *pBuf, int bufLen, int *msgLen)
{
    return DRV_ERROR_NONE;
}

DVresult halMemAlloc(void **pp, unsigned long long size, unsigned long long flag)
{
    return DRV_ERROR_NONE;
}

DVresult halMemFree(void *pp)
{
    return DRV_ERROR_NONE;
}

DVresult drvMemcpy(DVdeviceptr dst, size_t destMax,DVdeviceptr src, size_t ByteCount)
{
    return DRV_ERROR_NONE;
}

drvError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetAPIVersion(int *halAPIVersion) {
    *halAPIVersion = 0x05090E + 1;
    return DRV_ERROR_NONE;
}
