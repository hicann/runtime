/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdarg.h>
#include <errno.h>
#include <limits.h>
#include <string.h>

#include "iam.h"
#include "log_iam_pub.h"
#include "log_print_syslog.h"
#include "securec.h"
#include "slog.h"

#define GROUP_MAP_SIZE (INVLID_MOUDLE_ID + 1)

typedef struct {
    char rootPath[PATH_MAX];
    char groupPath[PATH_MAX];
    char groupName[GROUP_MAP_SIZE][NAME_MAX];
} MergeSlogConfigInfo;

static uint32_t g_lastCmd;

void MergeSlogStubReset(void)
{
    g_lastCmd = 0U;
}

uint32_t MergeSlogStubGetLastCmd(void)
{
    return g_lastCmd;
}

int ioctl(int fd, unsigned long request, ...)
{
    (void)fd;
    if ((request != IAM_CMD_COLLECT_LOG) && (request != IAM_CMD_COLLECT_LOG_PATTERN)) {
        errno = ENOTTY;
        return -1;
    }
    g_lastCmd = (uint32_t)request;
    va_list args;
    va_start(args, request);
    struct IAMIoctlArg* arg = va_arg(args, struct IAMIoctlArg*);
    va_end(args);
    if ((request == IAM_CMD_COLLECT_LOG_PATTERN) && (arg != NULL) && (arg->argData != NULL)) {
        MergeSlogConfigInfo* info = (MergeSlogConfigInfo*)arg->argData;
        (void)strcpy_s(info->rootPath, sizeof(info->rootPath), "/tmp");
        (void)strcpy_s(info->groupPath, sizeof(info->groupPath), "/tmp");
        (void)strcpy_s(info->groupName[0], sizeof(info->groupName[0]), "device-0");
        (void)strcpy_s(info->groupName[1], sizeof(info->groupName[1]), "group-test");
    }
    return 0;
}

void LogPrintSys(int32_t priority, const char* format, ...)
{
    (void)priority;
    (void)format;
}
