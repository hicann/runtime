/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_FILE_UTIL_H
#define LOG_FILE_UTIL_H
#include "log_system_api.h"
#include "log_common.h"
#include "log_level.h"

#ifdef __cplusplus
extern "C" {
#endif

LogRt LogMkdir(const char *dirPath);
LogRt LogMkdirRecur(const char *fullPath);

int32_t LogGetHomeDir(char *const homedir, uint32_t len);
int32_t GetValidPath(char *path, int32_t pathLen, char *validPath, int32_t validPathLen);
int32_t LogRenameDir(const char *srcDir, const char *dstDir, ToolFilter filterFunc);
void FsyncLogToDisk(const char *logPath);

void ToolPathListFree(char **pathList, int32_t count);

uint32_t LogGetDirSize(const char *dirPath, int32_t level);
int32_t LogRemoveDir(const char *dirName, int32_t level);

LogStatus LogFileGets(char *buf, int32_t len, FILE *fp);
int64_t LogFileTell(FILE *fp);

#ifdef __cplusplus
}
#endif
#endif /* LOG_FILE_UTIL_H */
