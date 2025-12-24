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
#include "adcore_api.h"
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include "hdclog_hdc_ut_stub.h"

int HdcRead(HDC_SESSION session, IdeRecvBuffT buf, int32_t *recvLen)
{
    return IDE_DAEMON_OK;
}

int HdcSessionConnect(int peerNode, const int peerDevid, const HDC_CLIENT client, HDC_SESSION *session)
{
    return IDE_DAEMON_OK;
}

int HdcSessionDestroy(HDC_SESSION session)
{
    return IDE_DAEMON_OK;
}

int AdxHdcWrite(HDC_SESSION session, const void *buf, int len)
{
    return IDE_DAEMON_OK;
}

HDC_CLIENT GetIdeDaemonHdcClient()
{
    return (HDC_CLIENT)0x100;
}

void IdeDeviceStartupRegister(int(*devStartupNotifier)(uint32_t num, uint32_t *dev))
{
    return;
}

void IdeDeviceStateNotifierRegister(int(*ideDevStateNotifier)(devdrv_state_info_t *stateInfo))
{
    return;
}

int32_t IdeSockWriteData(void *sockDesc, const void *buf, int32_t len)
{
    return 0;
}

