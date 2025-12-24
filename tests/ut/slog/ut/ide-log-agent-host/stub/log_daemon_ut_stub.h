/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __LOG_DAEMON_UT_STUB_H__
#define __LOG_DAEMON_UT_STUB_H__

#include "log_recv_interface.h"
#include "log_to_file.h"
#include "log_recv.h"
#include "start_single_process.h"
#include "log_system_api.h"
#include "bbox_dev_register.h"
#include "zip_sdk.h"

#define HZLIB_VERSION "1.0.1"
#define Z_STREAM_END 1
#define Z_OK 0
#define Z_ERRNO (-1)
#define Z_STREAM_ERROR (-2)
#define Z_DATA_ERROR   (-3)
#define Z_MEM_ERROR    (-4)
#define Z_VERSION_ERROR (-6)
#define GZIP_ENCODING (16)
#define Z_DEFAULT_COMPRESSION  (-1)
#define Z_DEFLATED   8
#define Z_DEFAULT_STRATEGY    0
#define MAX_WBITS   15 // 32K LZ77 window

extern void XFreeLogNode(LogNode **node);

extern void PrintNode(const void *node);

extern void* hostLogServerThread(void* arg);

extern void* HostRTGetDeviceIDThread(void* arg);

extern void* HostRTGetDeviceIDThread(void* arg);

extern int LogGetDeviceState(DrvDevStatT *stat);

extern void* SetupDeviceRecvThread(void* arg);
extern unsigned int TimerEnough(struct timespec* lastTv);
extern bool IsDeviceThreadCleanedUp(void);

void CatchUsualSig(int sig);
int LogDaemonTest(int argc, char *argv[]);

int JustStartAProcess(const char *file);

void SingleResourceCleanup(const char *file);
int LockReg(LockRegParams *params);
int log_read(int device_id, char *buf, unsigned int *size, int timeout);
int log_get_channel_type(int device_id, int *channel_type_set, int *channel_type_num, int set_size);
int log_set_level(int device_id, int channel_type, unsigned int log_level);
int log_read_by_type(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type);
int32_t CheckMutex(void);
#endif //__LOG_DAEMON_H__
