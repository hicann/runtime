/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __IDE_LOG_DEVICE_STUB_H__
#define __IDE_LOG_DEVICE_STUB_H__

#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <sys/types.h>
#include <stdarg.h>
#include "ascend_hal.h"
#include "adcore_api.h"
#include "slog.h"
#include "operate_loglevel.h"
#include "log_common.h"
#include "securectype.h"
#include "log_system_api.h"

int HdcSessionDestroy(HDC_SESSION session);
int HdcSessionClose(HDC_SESSION session);
hdcError_t drvHdcSessionClose(HDC_SESSION session);
int HdcRead(HDC_SESSION session, void **buf, int *recv_len);
int AdxHdcWrite(HDC_SESSION session, const void *buf, int len);
int HdcSessionConnect(int peer_node, int peer_devid, HDC_CLIENT client, HDC_SESSION *session);
HDC_CLIENT GetIdeDaemonHdcClient();
int pthread_create(pthread_t *thread, const pthread_attr_t *attr,void *(*start_routine) (void *), void *arg);
int pthread_detach(pthread_t tid);
void pthread_exit(void *retval);
void IdeLog(int priority, const char *format, ...);
int msgget(key_t ket, int flags);
int msgsnd(key_t key, const void *msgs, size_t msgsz, int msgflg);
ssize_t func();
void *SetLogLevel(void *arg);
bool LogStrStartsWith(const char *string, const char *pattern);
void ToUpper(char *str);
void LogRecordSigNo(int sigNo);
void LogSignalActionSet(int sig, void (*handler)(int));
void SetErrNo(int err);
void BBPerrorMsg(const char *s, ...);
INT32 ToolRead (INT32 fd, VOID *buf, UINT32 bufLen);
toolSockHandle ToolSocket(INT32 sockFamily, INT32 type, INT32 protocol);
int LogReplaceDefaultByDir(const char *path, char *homeDir, unsigned int len);
int LogConfGetProcessPath(char *processDir, unsigned int len);
int LogConfGetProcessFile(char *configDir, unsigned int len);
int LogInitRootPath();
char *LogGetWorkspacePath();
char *LogGetSelfPath();
char *GetPidListPath();
int StrcatDir(char *path, const char *filename, const char *pDir, unsigned int maxlen);
void LogPrintSelf(const char *format, ...);
void SetRingFile(const char *slogdFile);
int log_get_channel_type(int device_id, int *channel_type_set, int *channel_type_num, int set_size);
int log_set_level(int device_id, int channel_type, unsigned int log_level);
#endif
