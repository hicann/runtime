/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_SYSTEM_API_H
#define TRACE_SYSTEM_API_H

#include <stddef.h>
#include <pwd.h>
#include "mmpa_api.h"
#include "atrace_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define TRACE_MAX_PATH              MMPA_MAX_PATH
#define TRACE_PATH_SEPERATOR        MMPA_PATH_SEPARATOR_STR
#define TRACE_THREAD_STACK_SIZE     128 * 1024

typedef mmThread TraceThread;
typedef mmUserBlock_t TraceUserBlock;
typedef mmThreadAttr TraceThreadAttr;

typedef mmSockAddr TraceSockAddr;

typedef mmTimeval TraceTimeVal;
typedef mmTimezone TraceTimeZone;

#define TRACE_MUTEX_INITIALIZER MM_MUTEX_INITIALIZER

// load library
void *TraceDlopen(const char *libPath, int32_t mode);
void *TraceDlsym(void *handle, const char *funcName);
int32_t TraceDlclose(void *handle);

int32_t TraceGetPid(void);

int32_t TraceRaise(int32_t signo);
int32_t TraceChmod(const char *dirPath, uint32_t mode);
int32_t TraceChown(const char *dirPath, uint32_t uid, uint32_t gid);
TraStatus TraceMkdir(const char *dirPath, uint32_t mode, uint32_t uid, uint32_t gid);
int32_t TraceRmdir(const char *pathName);
int32_t TraceOpen(const char *filePath, int32_t flag, uint32_t mode);
void TraceClose(int32_t *fd);

TraStatus TraceHandleEnvString(const char *env, char *buf, uint32_t len);
int32_t TraceRealPath(const char *path, char *realPath, int32_t realPathLen);
int32_t TraceAccess(const char *path, int32_t mode);

// thread
int32_t TraceCreateTaskWithThreadAttr(TraceThread *threadHandle, const TraceUserBlock *funcBlock,
    const TraceThreadAttr *threadAttr);
int32_t TraceJoinTask(TraceThread *threadHandle);
int32_t TraceSetThreadName(const char *threadName);

int32_t TraceGetTimeOfDay(TraceTimeVal *timeVal, TraceTimeZone *timeZone);
int32_t TraceLocalTimeR(const time_t *timep, struct tm *result);

int32_t TraceSocket(int32_t sockFamily, int32_t type, int32_t protocol);
int32_t TraceBind(int32_t sockFd, TraceSockAddr *addr, size_t addrLen);
int32_t TraceCloseSocket(int32_t sockFd);
int32_t TraceConnect(int32_t sockFd, struct sockaddr *addr, size_t addrLen);

TraStatus TraceTimeDstInit(void);
TraStatus TimestampToStr(uint64_t timestamp, char *buffer, uint32_t bufSize);
TraStatus TimestampToFileStr(uint64_t timestamp, char *buffer, uint32_t bufSize);
TraStatus TraceGetTimeOffset(int32_t *offset);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif

