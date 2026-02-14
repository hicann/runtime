/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_RECORDER_H
#define TRACE_RECORDER_H

#include "atrace_types.h"
#include "adiag_lock.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

enum {
    RECORDER_TYPE_FILE,
    RECORDER_TYPE_SLOG,
    RECORDER_TYPE_SYSLOG,
    RECORDER_TYPE_CONSOLE,
};

// file length
#define MAX_NAME_HEAD_LEN       64U
#define MAX_FILENAME_LEN        64U
#define MAX_FILEDIR_LEN         255U
#define MAX_FILEPATH_LEN        (MAX_FILEDIR_LEN + MAX_NAME_HEAD_LEN)
#define MAX_FULLPATH_LEN        (MAX_FILEPATH_LEN + MAX_FILENAME_LEN)
#define MAX_DIR_NUM             10U

typedef struct {
    const char *tracerName;
    const char *objName;
    const char *suffix;
} TraceFileInfo;
typedef struct {
    const char *eventName;
    int32_t pid;
    const char *dirTime;
    bool isDevice; // ture: device dir; false: host
} TraceDirInfo;

typedef struct TraceDirNode{
    char dirPath[MAX_FILEPATH_LEN + 1U]; // {$rootpath}/trace_{pgid}_{attr_pid}_{attr_time}/{event_name}_event_{pid}_time
    struct TraceDirNode *prev;
    struct TraceDirNode *next;
} TraceDirNode;

typedef struct TraceDirList{
    struct TraceDirNode *head;
    struct TraceDirNode *tail;
    int32_t count;
    AdiagLock lock;
} TraceDirList;

typedef struct {
    int32_t maxDirNum; // default is 10, controlled by environment variable ASCEND_TRACE_RECORD_NUM, range [10, 1000]
    AdiagLock lock;
    char rootPath[MAX_FILEDIR_LEN + 1U];    // ~/ascend/atrace
    TraceDirList hostDirList;
    TraceDirList deviceDirList;
    TraceDirNode *exitDir;
    char corePath[MAX_FULLPATH_LEN + 1U];
} TraceRecorderMgr;

TraStatus TraceRecorderInit(void);
void TraceRecorderExit(void);

const TraceDirNode *TraceRecorderGetDirPath(const TraceDirInfo *dirInfo);
TraStatus TraceRecorderGetFd(const TraceDirInfo *dirInfo, const TraceFileInfo *fileInfo, int32_t *fd);
TraStatus TraceRecorderWrite(int32_t fd, const char *msg, uint32_t len);

// for signal callback
TraStatus TraceRecorderSafeGetFd(const TraceDirInfo *dirInfo, const TraceFileInfo *fileInfo, int32_t *fd);
TraStatus TraceRecorderSafeMkdirPath(const TraceDirInfo *dirInfo);
TraStatus TraceRecorderSafeGetDirPath(const TraceDirInfo *dirInfo, char *path, size_t len);
const char* TraceRecorderSafeGetFilePath(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif