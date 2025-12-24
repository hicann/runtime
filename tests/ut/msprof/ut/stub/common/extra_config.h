/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_COMMON_EXTRA_CONFIG_H
#define IDE_DAEMON_COMMON_EXTRA_CONFIG_H
#define ARRAY_LEN(x, type) (sizeof(x) / sizeof(type))

#ifdef __cplusplus
extern "C" {
#endif

typedef void*                IdeSession;
typedef void*                IdeThreadArg;
typedef void*                IdeMemHandle;
typedef void*                IdeKmcHandle;
typedef void*                IdeKmcLock;
typedef void**               IdeKmcLockAddr;
typedef void*                IdeBuffT;
typedef void**               IdeRecvBuffT;
typedef const void*          IdeKmcConHandle;
typedef const void*          IdeSendBuffT;
typedef char*                IdeStringBuffer;
typedef const char*          IdeString;
typedef char**               IdeStrBufAddrT;
typedef unsigned char*       IdeU8Pt;
typedef int*                 IdeI32Pt;
typedef unsigned int*        IdeU32Pt;
typedef const unsigned char* IdeConU8Pt;
typedef const int*           IdeConI32Pt;
typedef const unsigned int*  IdeConU32Pt;
typedef int*                 IdePidPtr;

#define IDE_DAEMON_ERROR                 (-1)
#define IDE_DAEMON_OK                    (0)
#define IDE_DAEMON_SOCK_CLOSE            (1)
#define IDE_DAEMON_RECV_NODATA           (2)
#define IDE_DAEMON_DONE                  (3)
#define DEVICE_NUM_MAX                   (64)
#define MAX_SESSION_NUM                  (100)
#define MAX_TIME_LEN                     (100)
#define IDE_MAX_FILE_PATH                (512)
#define IDE_STATUS_LEN                   (256)
#define MAX_IP_LEN                       (16)
#define TCP_MAX_LISTEN_NUM               (100)
#define PACK_SIZE                        (102400)
#define SOCK_OK                          (0)
#define SOCK_ERROR                       (-1)
#define PASSWORD_MAX_LNE                 (32)

#define HDC_END_MSG                      ("###[HDC_MSG]hdc_end_msg_used_by_framework###")
#define ADX_SAFE_MALLOC(size)            ((size) > 0 ? calloc(1, size) : nullptr)
#define ADX_SAFE_CALLOC(n, size)         (((n) > 0 && (size) > 0) ? calloc(n, size) : nullptr)
#define ADX_SAFE_FREE(p)                 do { if ((p) != nullptr) { free(p); (p) = nullptr; } } while (0)
#ifdef __cplusplus
}
#endif

#endif

