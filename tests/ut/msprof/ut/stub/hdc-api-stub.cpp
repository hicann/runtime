/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdc-api-stub.h"
#include <stdio.h>
#define mmProcess int

namespace Analysis {
namespace Dvvp {
namespace Adx {
int HdcRead(HDC_SESSION session, void **buf, int *recv_len, uint32_t timeout) {
    return IDE_DAEMON_OK;
}

int HdcWrite(HDC_SESSION session, const void *buf, int len) {
    return IDE_DAEMON_OK;
}

int HdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session) {
    return IDE_DAEMON_OK;
}

int HdcSessionDestroy(HDC_SESSION session) {
    return IDE_DAEMON_OK;
}

int IdeSockWriteData(void *sock_desc, const void *buf, int len) {
    return IDE_DAEMON_OK;
}

int IdeSockReadData(void *sock_desc, void **read_buf, int *recv_len) {
    return IDE_DAEMON_OK;
}

void IdeSockDestroy(void *sock) {
}

int IdeCreatePacket(enum cmd_class type, const char *value, const unsigned int value_len, void **buf, int *buf_len) {
    return IDE_DAEMON_OK;
}

void IdeFreePacket(void *buf) {
}

int HdcSessionClose(HDC_SESSION session) {
    return IDE_DAEMON_OK;
}

int IdeGetDevIdBySession(HDC_SESSION session, int *devId) {
    *devId = 0;
    return IDE_DAEMON_OK;
}

int32_t IdeGetVfIdBySession(HDC_SESSION session, int32_t &vfId) {
    vfId = 0;
    return IDE_DAEMON_OK;
}

int32_t HdcClientDestroy(HDC_CLIENT client) {
    return IDE_DAEMON_OK;
}

void HdcServerDestroy(HDC_SERVER server) {
}

HDC_SERVER HdcServerCreate(int32_t logDevId, drvHdcServiceType type)
{
    return nullptr;
}

HDC_SESSION HdcServerAccept(HDC_SERVER server) {
    return nullptr;
}

HDC_CLIENT HdcClientCreate(drvHdcServiceType type) {
    return HDC_CLIENT(0x12345);
}

int32_t HalHdcSessionConnect(int32_t peerNode, int32_t peerDevid,
    int32_t hostPid, HDC_CLIENT client, HDC_SESSION *session) {
    return IDE_DAEMON_OK;
}

void IdeDeviceStateNotifierRegister(int (*ideDevStateNotifier)(devdrv_state_info_t *stateInfo)) {
}

HDC_CLIENT GetIdeDaemonHdcClient()
{
    return HDC_CLIENT(0x12345);
}

void *IdeSockDupCreate(void *sock)
{
    return (void *)0x12345;
}

void IdeSockDupDestroy(void* sock)
{

}


FILE* IdePopen(IdeString command, IdeStringBuffer env[], IdeString type, int *pid)
{
    return nullptr;
}

int IdePclose(FILE *fp)
{
    return IDE_DAEMON_ERROR;
}
}   // namespace
}   // namespace
}   // namespace
