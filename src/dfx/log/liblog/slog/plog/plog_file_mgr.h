/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLOG_FILE_MGR_H
#define PLOG_FILE_MGR_H

#include "log_file_info.h"
#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    uint32_t len;
    uint32_t deviceId;
    LogType logType;
    int16_t smpFlag;
    int16_t slogFlag;
    int16_t moduleId;
} PlogDeviceLogInfo;

typedef struct { // sub log file list paramter
    int32_t fileNum;
    int32_t currIndex;
    int32_t maxFileNum;
    uint32_t maxFileSize;
    uint32_t pid;
    char aucFilePath[MAX_FILEPATH_LEN + 1U];
    char aucFileHead[MAX_NAME_HEAD_LEN + 1U];
    char **aucFileName;
    unsigned char devWriteFileFlag;
} PlogFileList;

typedef struct { // log file list paramter
    uint32_t deviceNum;
    char rootPath[MAX_FILEPATH_LEN + 1U];
    PlogFileList hostLogList[LOG_TYPE_NUM];
    PlogFileList *deviceLogList[LOG_TYPE_NUM];
} PlogFileMgrInfo;

LogStatus PlogFileMgrInit(void);
void PlogFileMgrExit(void);

LogStatus PlogWriteDeviceLog(char *msg, const PlogDeviceLogInfo *info);
LogStatus PlogWriteHostLog(int32_t logType, char *msg, uint32_t len);

#ifdef __cplusplus
}
#endif
#endif /* PLOG_FILE_MGR_H */