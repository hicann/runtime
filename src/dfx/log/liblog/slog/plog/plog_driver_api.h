/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PLOG_DRIVER_API_H
#define PLOG_DRIVER_API_H

#include "ascend_hal.h"

int LoadDriverDllFunctions(void);

int UnloadDriverDllFunctions(void);

drvError_t LogdrvHdcClientCreate(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag);

drvError_t LogdrvHdcClientDestroy(HDC_CLIENT client);

drvError_t LogdrvHdcSessionConnect(int peerNode, int peerDevid, HDC_CLIENT client, HDC_SESSION *session);

drvError_t LogdrvHdcSessionClose(HDC_SESSION session);

drvError_t LogdrvHdcAllocMsg(HDC_SESSION session, struct drvHdcMsg **ppMsg, int count);

drvError_t LogdrvHdcFreeMsg(struct drvHdcMsg *msg);

drvError_t LogdrvHdcReuseMsg(struct drvHdcMsg *msg);

drvError_t LogdrvHdcAddMsgBuffer(struct drvHdcMsg *msg, char *pBuf, int len);

drvError_t LogdrvHdcGetMsgBuffer(struct drvHdcMsg *msg, int indexNum, char **pBuf, int *pLen);

drvError_t LogdrvHdcSetSessionReference(HDC_SESSION session);

drvError_t LogdrvGetPlatformInfo(uint32_t *info);

drvError_t LogdrvHdcGetCapacity(struct drvHdcCapacity *capacity);

hdcError_t LogdrvHdcSend(HDC_SESSION session, struct drvHdcMsg *pMsg, UINT64 flag, UINT32 timeout);

hdcError_t LogdrvHdcRecv(HDC_SESSION session, struct drvHdcMsg *pMsg, int bufLen,
                         UINT64 flag, int *recvBufCount, UINT32 timeout);

drvError_t LogdrvCtl(int cmd, void *paramValue, size_t paramValueSize,
                     void *outValue, size_t *outSizeRet);

drvError_t LogdrvGetDevNum(uint32_t *numDev);
#endif