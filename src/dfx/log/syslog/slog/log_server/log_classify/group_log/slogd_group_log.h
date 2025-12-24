/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SLOGD_GROUP_LOG_H
#define SLOGD_GROUP_LOG_H
#include "slog.h"
#include "log_print.h"
#include "log_to_file.h"
#include "slogd_flush.h"
#include "slogd_buffer.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct TagGroupInfo {
    int32_t groupId;
    int32_t fileSize;
    uint32_t totalMaxFileSize;
    uint32_t bufSize;
    char groupName[GROUP_NAME_MAX_LEN + 1];
    StSubLogFileList fileList;
    uint32_t deviceNum;
    StSubLogFileList *deviceLogList;
    struct TagGroupInfo *next;
} GroupInfo;

GroupInfo *GetGroupInfoById(const int groupId);
GroupInfo *GetGroupListHead(void);

LogStatus SlogdGroupLogInit(void);
void SlogdGroupLogExit(void);

#ifdef __cplusplus
}
#endif
#endif