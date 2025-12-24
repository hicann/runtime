/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef FILE_MONITOR_COMMON_H
#define FILE_MONITOR_COMMON_H

#include <regex.h>
#include "log_common.h"
#include "log_file_info.h"
#include "event_process_core.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_MONITOR_EVENT   64
#define FILE_MONITOR_EVENT_SIZE ((uint32_t)sizeof(struct inotify_event))
#define FILE_MONITOR_EVENT_BUF_LEN ((uint32_t)MAX_MONITOR_EVENT * (FILE_MONITOR_EVENT_SIZE + 16U))
#define MAX_FOLDER_DEPTH 10
#define MASTER_ID_STR_HEAD "dev-os-"
#define MASTER_ID_STR_LEN 10

typedef int32_t (*FileMonitorSyncFunc)(const char *srcFileName, const char *dstFileName);
typedef struct NotifyEvent {
    int32_t wd;
    char fileName[MAX_FULLPATH_LEN];
} NotifyEvent;

typedef struct MonitorEvent {
    struct {
        int32_t fd;
        NotifyEvent event[MAX_MONITOR_EVENT];
        EventHandle eventHandle;
    } notifyMonitor;
    struct {
        EventHandle eventHandle;
    } scanMonitor;
    FileMonitorSyncFunc fileSyncFunc;
} MonitorEvent;

typedef struct FileMonitor {
    void *argList;
    ToolMutex argListLock;
    MonitorEvent eventMonitor;
} FileMonitor;

int32_t FileMonitorSyncFileList(const char *srcFileName, const char *dstFileName, FileMonitorSyncFunc func,
    int32_t depth);
void FileMonitorSetMasterIdStr(const char *masterIdStr);
char *FileMonitorGetMasterIdStr(void);
int32_t FileMonitorAddWatch(const char *filePath, int32_t fd, int32_t *wd, uint32_t mask);

#ifdef __cplusplus
}
#endif
#endif