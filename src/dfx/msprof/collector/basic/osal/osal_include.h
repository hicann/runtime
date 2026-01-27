/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_OSAL_INCLUDE_H
#define ANALYSIS_DVVP_COMMON_OSAL_INCLUDE_H

#define LINUX 0
#define WIN 1

#ifdef OSAL
#ifdef FUNC_VISIBILITY
#define OSAL_FUNC_VISIBILITY __attribute__((visibility("default")))
#else
#define OSAL_FUNC_VISIBILITY
#endif

#ifndef LITE_OS
#include <semaphore.h>
#include <dirent.h>
#include <dlfcn.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/uio.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/msg.h>
#include <sys/statvfs.h>
#include <sys/wait.h>
#include <poll.h>
#include <linux/types.h>
#include <linux/hdreg.h>
#include <linux/fs.h>
#include <linux/limits.h>
#endif
#include <string.h>
#include <errno.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <syslog.h>
#include <stdlib.h>
#include <stdarg.h>
#include <limits.h>
#include <ctype.h>
#include <stddef.h>
#include <getopt.h>
#include <libgen.h>
#include <malloc.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <sys/mman.h>
#include <sys/un.h>
#include <sys/utsname.h>
#include "securec.h"
#else
#include "mmpa_api.h"
#define OSAL_FUNC_VISIBILITY MMPA_FUNC_VISIBILITY
#endif

#endif
