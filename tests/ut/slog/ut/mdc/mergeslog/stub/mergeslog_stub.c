/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <limits.h>
#include "log_iam_pub.h"
#include "iam.h"
#include "slog.h"
#define GROUP_MAP_SIZE      (INVLID_MOUDLE_ID + 1)

typedef struct {
    char rootPath[PATH_MAX];
    char groupPath[PATH_MAX];
    char groupName[GROUP_MAP_SIZE][NAME_MAX];
} LogConfigInfo;

int32_t ioctl(struct IAMMgrFile *file, unsigned cmd, struct IAMIoctlArg *arg)
{
    (void)file;
    if (cmd != IAM_CMD_COLLECT_LOG_PATTERN) {
        return 0;
    }
    LogConfigInfo *configInfo = (LogConfigInfo *)(arg->argData);
    if (configInfo == NULL) {
        return -1;
    }
    (void)memset_s(configInfo, sizeof(LogConfigInfo), 0, sizeof(LogConfigInfo));
    snprintf_s(configInfo->rootPath, PATH_MAX, PATH_MAX - 1U, "/home/mdc/var/log/");
    snprintf_s(configInfo->groupPath, PATH_MAX, PATH_MAX - 1U, "/home/mdc/var/log");
    snprintf_s(configInfo->groupName[0], NAME_MAX, NAME_MAX - 1U, "device-0");
    snprintf_s(configInfo->groupName[1], NAME_MAX, NAME_MAX - 1U, "TSYNC");
    snprintf_s(configInfo->groupName[2], NAME_MAX, NAME_MAX - 1U, "DVPP");
    snprintf_s(configInfo->groupName[3], NAME_MAX, NAME_MAX - 1U, "DRV");
    snprintf_s(configInfo->groupName[4], NAME_MAX, NAME_MAX - 1U, "MEDIA");
    snprintf_s(configInfo->groupName[5], NAME_MAX, NAME_MAX - 1U, "ROS");
    snprintf_s(configInfo->groupName[6], NAME_MAX, NAME_MAX - 1U, "PROCMGR");
    snprintf_s(configInfo->groupName[7], NAME_MAX, NAME_MAX - 1U, "CAMERA");
    snprintf_s(configInfo->groupName[8], NAME_MAX, NAME_MAX - 1U, "AICPU");
    snprintf_s(configInfo->groupName[9], NAME_MAX, NAME_MAX - 1U, "RTS");
    snprintf_s(configInfo->groupName[10], NAME_MAX, NAME_MAX - 1U, "GE");
    snprintf_s(configInfo->groupName[11], NAME_MAX, NAME_MAX - 1U, "TOOLS");
    return 0;
}