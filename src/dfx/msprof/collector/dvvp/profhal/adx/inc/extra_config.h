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

#ifdef __cplusplus
extern "C" {
#endif

typedef void*                IdeSession;
typedef void*                IdeThreadArg;
typedef void*                IdeMemHandle;
typedef void*                IdeBuffT;
typedef void**               IdeRecvBuffT;
typedef const void*          IdeSendBuffT;
typedef int*                 IdeI32Pt;
typedef unsigned int*        IdeU32Pt;
typedef char**               IdeStrBufAddrT;

using IdeStringBuffer = char *;
using IdeString = const char *;
using IdeU8Pt = unsigned char *;

const int IDE_DAEMON_ERROR = -1;
const int IDE_DAEMON_OK = 0;
const int IDE_DAEMON_SOCK_CLOSE = 1;
const int IDE_DAEMON_RECV_NODATA = 2;   // 2 : no data
const int MAX_SESSION_NUM = 96; // 96 : max session num
const int DEVICE_NUM_MAX = 1124;

#ifdef __cplusplus
}
#endif

#endif

