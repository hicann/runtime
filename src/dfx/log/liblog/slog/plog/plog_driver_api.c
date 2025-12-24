/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_driver_api.h"
#include "log_print.h"

#include "library_load.h"

#if (OS_TYPE_DEF == 0)
#define DRV_HDC_LIBRARY_NAME "libascend_hal.so"
#else
#define DRV_HDC_LIBRARY_NAME "libascend_hal.dll"
#endif

#define DRIVER_FUNCTION_NUM 16
static ArgPtr g_libHandle = NULL;
static SymbolInfo g_drvFuncInfo[DRIVER_FUNCTION_NUM] = {
    { "drvHdcClientCreate", NULL },
    { "drvHdcClientDestroy", NULL },
    { "drvHdcSessionConnect", NULL },
    { "drvHdcSessionClose", NULL },
    { "drvHdcAllocMsg", NULL },
    { "drvHdcFreeMsg", NULL },
    { "drvHdcReuseMsg", NULL },
    { "drvHdcAddMsgBuffer", NULL },
    { "drvHdcGetMsgBuffer", NULL },
    { "drvHdcSetSessionReference", NULL },
    { "drvGetPlatformInfo", NULL },
    { "drvHdcGetCapacity", NULL },
    { "halHdcSend", NULL },
    { "halHdcRecv", NULL },
    { "halCtl", NULL },
    { "drvGetDevNum", NULL}
};

int LoadDriverDllFunctions(void)
{
    g_libHandle = LoadRuntimeDll(DRV_HDC_LIBRARY_NAME);
    if (g_libHandle == NULL) {
        SELF_LOG_ERROR("load driver library failed.");
        return -1;
    }
    SELF_LOG_INFO("load driver library succeed.");
    int ret = LoadDllFunc(g_libHandle, g_drvFuncInfo, DRIVER_FUNCTION_NUM);
    if (ret != 0) {
        SELF_LOG_ERROR("load driver library function failed.");
        return -1;
    }
    SELF_LOG_INFO("load driver library function succeed.");
    return 0;
}

int UnloadDriverDllFunctions(void)
{
    int ret = UnloadRuntimeDll(g_libHandle);
    if (ret != 0) {
        SELF_LOG_ERROR("close driver library handle failed.");
    } else {
        SELF_LOG_INFO("close driver library handle succeed.");
    }
    return ret;
}

typedef drvError_t (*DRV_HDC_CLIENT_CREATE)(HDC_CLIENT *, int, int, int);
drvError_t LogdrvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag)
{
    DRV_HDC_CLIENT_CREATE func = (DRV_HDC_CLIENT_CREATE)g_drvFuncInfo[0].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(client, maxSessionNum, serviceType, flag);
}

typedef drvError_t (*DRV_HDC_CLIENT_DESTROY)(HDC_CLIENT);
drvError_t LogdrvHdcClientDestroy(HDC_CLIENT client)
{
    DRV_HDC_CLIENT_DESTROY func = (DRV_HDC_CLIENT_DESTROY)g_drvFuncInfo[1].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(client);
}

typedef drvError_t(*DRV_SESSION_CONNECT)(int, int, HDC_CLIENT, HDC_SESSION *);
drvError_t LogdrvHdcSessionConnect(int peerNode, int peerDevid, HDC_CLIENT client, HDC_SESSION *session)
{
    DRV_SESSION_CONNECT func = (DRV_SESSION_CONNECT)g_drvFuncInfo[2].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(peerNode, peerDevid, client, session);
}

typedef drvError_t (*DRV_HDC_SESSION_CLOSE)(HDC_SESSION);
drvError_t LogdrvHdcSessionClose(HDC_SESSION session)
{
    DRV_HDC_SESSION_CLOSE func = (DRV_HDC_SESSION_CLOSE)g_drvFuncInfo[3].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(session);
}

typedef drvError_t (*DRV_HDC_ALLOC_MSG)(HDC_SESSION, struct drvHdcMsg **, int);
drvError_t LogdrvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count)
{
    DRV_HDC_ALLOC_MSG func = (DRV_HDC_ALLOC_MSG)g_drvFuncInfo[4].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(session, ppMsg, count);
}

typedef drvError_t (*DRV_HDC_FREE_MSG)(struct drvHdcMsg *);
drvError_t LogdrvHdcFreeMsg(struct drvHdcMsg *msg)
{
    DRV_HDC_FREE_MSG func = (DRV_HDC_FREE_MSG)g_drvFuncInfo[5].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(msg);
}

typedef drvError_t (*DRV_HDC_REUSE_MSG)(struct drvHdcMsg *);
drvError_t LogdrvHdcReuseMsg(struct drvHdcMsg *msg)
{
    DRV_HDC_REUSE_MSG func = (DRV_HDC_REUSE_MSG)g_drvFuncInfo[6].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(msg);
}

typedef drvError_t (*DRV_HDC_ADD_MSG_BUF)(struct drvHdcMsg *, char *, int);
drvError_t LogdrvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len)
{
    DRV_HDC_ADD_MSG_BUF func = (DRV_HDC_ADD_MSG_BUF)g_drvFuncInfo[7].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(msg, pBuf, len);
}

typedef drvError_t (*DRV_HDC_GET_MSG_BUF)(struct drvHdcMsg *, int, char **, int *);
drvError_t LogdrvHdcGetMsgBuffer(struct drvHdcMsg *msg, int indexNum, char **pBuf, int *pLen)
{
    DRV_HDC_GET_MSG_BUF func = (DRV_HDC_GET_MSG_BUF)g_drvFuncInfo[8].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(msg, indexNum, pBuf, pLen);
}

typedef drvError_t (*DRV_HDC_SET_SESSION_REF)(HDC_SESSION);
drvError_t LogdrvHdcSetSessionReference(HDC_SESSION session)
{
    DRV_HDC_SET_SESSION_REF func = (DRV_HDC_SET_SESSION_REF)g_drvFuncInfo[9].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(session);
}

typedef drvError_t (*DRV_HDC_GET_PLATFORM_INFO)(uint32_t *);
drvError_t LogdrvGetPlatformInfo(uint32_t *info)
{
    DRV_HDC_GET_PLATFORM_INFO func = (DRV_HDC_GET_PLATFORM_INFO)g_drvFuncInfo[10].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(info);
}

typedef drvError_t (*DRV_HDC_GET_CAPACITY)(struct drvHdcCapacity *);
drvError_t LogdrvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    DRV_HDC_GET_CAPACITY func = (DRV_HDC_GET_CAPACITY)g_drvFuncInfo[11].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(capacity);
}

typedef hdcError_t (*DRV_HDC_SEND)(HDC_SESSION, struct drvHdcMsg *, UINT64, UINT32);
hdcError_t LogdrvHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout)
{
    DRV_HDC_SEND func = (DRV_HDC_SEND)g_drvFuncInfo[12].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(session, pMsg, flag, timeout);
}

typedef hdcError_t (*DRV_HDC_RECV)(HDC_SESSION, struct drvHdcMsg *, int, UINT64, int *, UINT32);
hdcError_t LogdrvHdcRecv(HDC_SESSION session, struct drvHdcMsg *pMsg, int bufLen,
                         UINT64 flag, int *recvBufCount, UINT32 timeout)
{
    DRV_HDC_RECV func = (DRV_HDC_RECV)g_drvFuncInfo[13].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(session, pMsg, bufLen, flag, recvBufCount, timeout);
}

typedef hdcError_t (*DRV_CTL)(int, void *, size_t, void *, size_t *);
drvError_t LogdrvCtl(int cmd, void *paramValue, size_t paramValueSize, void *outValue, size_t *outSizeRet)
{
    DRV_CTL func = (DRV_CTL)g_drvFuncInfo[14].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(cmd, paramValue, paramValueSize, outValue, outSizeRet);
}

typedef drvError_t (*DRV_DEV_NUM)(uint32_t *numDev);
drvError_t LogdrvGetDevNum(uint32_t *numDev)
{
    DRV_DEV_NUM func = (DRV_DEV_NUM)g_drvFuncInfo[15].handle;
    ONE_ACT_WARN_LOG(func == NULL, return DRV_ERROR_NOT_SUPPORT, "Can not find drv func.");
    return func(numDev);
}

