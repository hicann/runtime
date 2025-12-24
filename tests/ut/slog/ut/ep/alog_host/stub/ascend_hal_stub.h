/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ASCEND_HAL_STUB_H
#define ASCEND_HAL_STUB_H

#include "ascend_hal.h"

#ifdef __cplusplus
extern "C" {
#endif

int readEndMsg(void *session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout);
void SetDrvCrlCmd(int cmd);
int readDeviceMsg(void *session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout);

int DrvBufReadSessionClose(void *session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout);
drvError_t drvHdcSessionConnectClose(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session);
drvError_t drvHdcClientCreate_failed(HDC_CLIENT *client, int maxSessionNum, int serviceType, int flag);

void SetServerType(long long value, int ret);
void ReSetServerType(void);
#ifdef __cplusplus
}
#endif
#endif // ASCEND_HAL_STUB_H

