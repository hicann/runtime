/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_TO_FILE_H
#define LOG_TO_FILE_H
#include "log_common.h"
#include "log_config_api.h"
#include "log_file_info.h"
#include "slogd_recv_core.h"
#include "log_config_block.h"
#include "slogd_write_limit.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef OK
#define OK 0
#endif

#ifndef NOK
#define NOK 1
#endif

typedef struct {
    unsigned int len;
    unsigned int deviceId;
    LogType logType;
    short moduleId;
} DeviceWriteLogInfo;

typedef struct {
    char dirName[MAX_FULLPATH_LEN + 1U];
    uint32_t dirSize;
} LogDirList;

typedef struct {
    uint32_t period;
    uint32_t curTime;
    uint32_t maxFileNum;
} StorageRule;

typedef struct { // sub log file list paramter
    uint32_t maxFileSize;
    uint32_t totalMaxFileSize;
    char filePath[MAX_FILEPATH_LEN + 1U];
    char fileHead[MAX_NAME_HEAD_LEN + 1U];
    char fileName[MAX_FILENAME_LEN + 1U];
    ToolMutex lock;
    uint8_t devWriteFileFlag;
    LogDirList *dirList;
    int32_t dirNum;
    uint32_t dirTotalSize;
    StorageRule storage;
    WriteFileLimit *limit;
} StSubLogFileList;

typedef struct { // log file list paramter
    unsigned char ucDeviceNum;
    int32_t maxFileNum;
    int32_t maxOsFileNum;
    int32_t maxAppFileNum;
    int32_t maxNdebugFileNum;
    uint32_t ulMaxFileSize;
    uint32_t ulMaxOsFileSize;
    uint32_t ulMaxAppFileSize;
    uint32_t ulMaxNdebugFileSize;
    char aucFilePath[MAX_FILEPATH_LEN + 1U];
    StSubLogFileList sortDeviceOsLogList[LOG_TYPE_NUM];  // device-os
    StSubLogFileList sortDeviceAppLogList[LOG_TYPE_NUM]; // device-app
    StSubLogFileList *deviceLogList[LOG_TYPE_NUM];       // group log
    StSubLogFileList eventLogList;                       // event log
} StLogFileList;

unsigned int FilePathSplice(const StSubLogFileList *pstSubInfo, char *pFileName, size_t ucMaxLen);
uint32_t LogAgentGetFileListForModule(StSubLogFileList *pstSubInfo, const char *dir);
unsigned int LogAgentCreateNewFileName(StSubLogFileList *pstSubInfo);
unsigned int LogAgentWriteFile(StSubLogFileList *subList, StLogDataBlock *logData);
unsigned int LogAgentRemoveFile(const char *filename);
unsigned int LogAgentInitMaxFileNumHelper(StSubLogFileList *pstSubInfo, const char *logPath, int length);
unsigned int LogAgentInitDeviceMaxFileNum(StLogFileList *logList);

LogStatus LogAgentInitDeviceOs(StLogFileList *logList);
unsigned int LogAgentWriteDeviceOsLog(int32_t logType, StSubLogFileList *subLogList, char *msg, unsigned int len);

unsigned int LogAgentInitDevice(StLogFileList *logList, unsigned char deviceNum);
unsigned int LogAgentWriteDeviceLog(const StLogFileList *logList, char *msg, const DeviceWriteLogInfo *info);
void LogAgentCleanUpDevice(StLogFileList *logList);

LogStatus LogAgentInitDeviceApplication(StLogFileList *logList);
unsigned int LogAgentWriteDeviceApplicationLog(char *msg, unsigned int len, const LogInfo *logInfo,
    StLogFileList *logList);

uint32_t LogAgentWriteEventLog(StSubLogFileList *subLogList, char *msg, uint32_t len);

void InitChId2ModIdMapping(void);
int32_t LogAgentGetCfg(StLogFileList *logList);

uint32_t LogCalTotalFileSize(uint32_t fileSize, int32_t fileNum);
void LogFileMgrStorage(StSubLogFileList *subLogList);

void LogFileMgrInitClass(StSubLogFileList* list, LogConfClass *confClass);

#ifdef __cplusplus
}
#endif
#endif /* LOG_TO_FILE_H */
