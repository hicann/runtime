/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_to_file.h"
#include <string.h>
#include "securec.h"
#include "log_config_api.h"
#include "log_print.h"
#include "log_queue.h"
#include "log_file_util.h"
#include "log_compress/log_compress.h"
#include "log_common.h"
#include "log_level_parse.h"
#include "slogd_config_mgr.h"
#include "log_time.h"
#include "slogd_dev_mgr.h"
#include "slogd_compress.h"
#include "slogd_appnum_watch.h"

#ifdef GROUP_LOG
#include "slogd_group_log.h"
#include "ascend_hal.h"
#include "slog.h"
#endif

#define WRITE_FILE_LABEL_MAX_SIZE  1024

static unsigned int g_openPrintNum = 0;
static unsigned int g_writeBPrintNum = 0;
static unsigned int g_rootMkPrintNum = 0;
static unsigned int g_subMkPrintNum = 0;
static unsigned int g_chmodFPrintNum = 0;
static char g_logRootPath[MAX_FILEDIR_LEN + 1U] = { 0 };

static const char * const SORT_DIR_NAME[(int32_t)LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME };
#ifdef GROUP_LOG
STATIC int g_chId2ModIdMapping[LOG_CHANNEL_TYPE_MAX] = { 0 };

void InitChId2ModIdMapping(void)
{
    for (int32_t i = 0; i < (int32_t)LOG_CHANNEL_TYPE_MAX; i++) {
        g_chId2ModIdMapping[i] = -1;
    }
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_TS] = TS;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_MCU_DUMP] = TSDUMP;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_LPM3] = LP;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_IMP] = IMP;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_IMU] = IMU;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_ISP] = ISP;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_SIS] = SIS;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_SIS_BIST] = SIS;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_HSM] = HSM;
    g_chId2ModIdMapping[LOG_CHANNEL_TYPE_RTC] = RTC;
}

STATIC int GetModuleIdByChannel(short chnId)
{
    if ((chnId < 0) || (chnId >= (short)LOG_CHANNEL_TYPE_MAX)) {
        return -1;
    }
    return g_chId2ModIdMapping[chnId];
}
#endif

STATIC bool IsPathValidbyLog(const char *ppath, size_t pathLen)
{
    ONE_ACT_WARN_LOG(ppath == NULL, return false, "[input] file realpath is null.");
    bool isValid = false;
    const char *suffixList[] = {".log", ".log.gz", NULL};
    uint32_t i = 0;
    for (; suffixList[i] != NULL; i++) {
        const char *suffix = suffixList[i];
        ONE_ACT_NO_LOG((pathLen == 0) || (pathLen < strlen(suffix)), continue);
        size_t len = pathLen - strlen(suffix);
        if (strcmp(&ppath[len], suffixList[i]) == 0) {
            isValid = true;
            break;
        }
    }
    return isValid;
}

/**
* @brief LogFilter: filter the log file
* @return: if input file is a log file (*.log.gz or *.log)
*/
STATIC int LogFilter(const ToolDirent *dir)
{
    if (dir == NULL) {
        return 0;
    }
    size_t cfgPathLen = strlen(dir->d_name);
    if (!IsPathValidbyLog(dir->d_name, cfgPathLen)) {
        return 0;
    } else {
        return 1;
    }
}

STATIC uint32_t GetLocalTimeHelper(size_t bufLen, char *timeBuffer)
{
    if (timeBuffer == NULL) {
        SELF_LOG_WARN("[input] time buffer is null.");
        return NOK;
    }
    struct timespec currentTimeval = { 0, 0 };
    static bool isTimeInit = false;
    static clockid_t clockId = LOG_CLOCK_ID_DEFAULT;
    ONE_ACT_ERR_LOG(LogGetTime(&currentTimeval, &isTimeInit, &clockId) != LOG_SUCCESS, return NOK,
                    "get log time failed.");
    struct tm timeInfo = { 0 };
    if (ToolLocalTimeR((&currentTimeval.tv_sec), &timeInfo) != SYS_OK) {
        SELF_LOG_ERROR("get local time failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return NOK;
    }

    int ret = snprintf_s(timeBuffer, bufLen, bufLen - 1U, "%04d%02d%02d%02d%02d%02d%03ld",
                         timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday, timeInfo.tm_hour,
                         timeInfo.tm_min, timeInfo.tm_sec, currentTimeval.tv_nsec / MS_TO_NS);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s time buffer failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return NOK;
    }

    return OK;
}

STATIC uint32_t LogGetFileSize(const char *fileName, uint32_t fileLen)
{
    (void)fileLen;
    ToolStat statbuff = { 0 };
    if (ToolStatGet(fileName, &statbuff) == SYS_OK) {
        return (uint32_t)statbuff.st_size;
    }
    return 0U;
}

/**
 * @brief       : remove dir of a specified size
 * @param [in]  : logList       StLogFileList struct pointer
 * @param [in]  : size          specified size to left
 * @return: void
 */
static void LogAgentRemoveDir(StSubLogFileList *logList, uint32_t size)
{
    if ((logList->dirNum == 0) || (logList->dirTotalSize < size)) {
        return;
    }
    uint32_t curDirSize = 0;
    for (int32_t i = 0; i < logList->dirNum; i++) {
        LogDirList *dir = (LogDirList *)(logList->dirList + i);
        if (dir->dirSize == 0) {
            continue;
        }
        curDirSize += dir->dirSize;
        if (curDirSize < size) {
            continue;
        }
        if (LogRemoveDir(dir->dirName, 0) != SYS_OK) {
            // if remove failed, try next time
            SELF_LOG_ERROR("remove dir failed, dir=%s, strerr=%s", dir->dirName, strerror(ToolGetErrorCode()));
            continue;
        }
        (void)memset_s(dir, sizeof(LogDirList), 0, sizeof(LogDirList));
        logList->dirTotalSize -= dir->dirSize;
        continue;
    }
}

static void LogAgentAgingFile(bool *isRemove, uint32_t *fileSize, const char *aucFileName, uint32_t *fileNum,
    StSubLogFileList *pstSubInfo)
{
    uint32_t size = LogGetFileSize(aucFileName, MAX_FULLPATH_LEN);
    if (!(*isRemove)) {
        if (((*fileSize + size) <= pstSubInfo->totalMaxFileSize) &&
            ((pstSubInfo->storage.maxFileNum == 0) || (*fileNum < pstSubInfo->storage.maxFileNum))) {
            (*fileSize) += size;
            (*fileNum)++;
        } else {
            *isRemove = true;
        }
    }

    // if fileSize > totalFileSize, delete old file
    if (*isRemove) {
        (void)LogAgentRemoveFile(aucFileName);
        return;
    }
    int32_t ret = ToolChmod(aucFileName, LOG_FILE_ARCHIVE_MODE);
    NO_ACT_WARN_LOG((ret != 0) && (ToolGetErrorCode() != ENOENT), "can not chmod file, file=%s, strerr=%s.",
                    aucFileName, strerror(ToolGetErrorCode()));
}

static void LogAgentHandleCompressFile(char *aucFileName, uint32_t len)
{
    if (LogCompressCheckUnzipSuffix(aucFileName)) {
        if (LogCompressFile(aucFileName) == LOG_SUCCESS) {
            NO_ACT_WARN_LOG(LogCompressAddSuffix(aucFileName, len) != LOG_SUCCESS,
                "can not add suffix for file(%s)", aucFileName);
        }
        return;
    }
    if (LogCompressCheckActiveFile(aucFileName)) {
        if (LogCompressFileRotate(aucFileName) == LOG_SUCCESS) {
            NO_ACT_WARN_LOG(LogCompressGetRotatePath(aucFileName, len) != LOG_SUCCESS,
                "can not get rotate path for file(%s)", aucFileName);
        }
    }
}

/**
* @brief LogAgentGetCurrentFileList: get current file list which is matched with specific filehead,
                                     and if filenum is over maxfilenum, old files will be removed.
* @param [in/out] pstSubInfo: strut to store file list
* @param [in] namelist: file list in directory
* @param [in] totalNum: file num in directory
* @return: OK: succeed; NOK: failed
*/
STATIC int32_t LogAgentGetCurrentFileList(StSubLogFileList *pstSubInfo,
                                          ToolDirent **namelist, int32_t toatalNum)
{
    char aucFileName[MAX_FULLPATH_LEN + 1U] = { 0 };
    size_t fileHeadLen = strnlen(pstSubInfo->fileHead, MAX_NAME_HEAD_LEN);
    uint32_t fileSize = 0U;
    uint32_t fileNum = 0;
    bool isRemove = false;
    ONE_ACT_NO_LOG(pstSubInfo->devWriteFileFlag == 1, (fileNum++)); // reserve for active file
    for (int32_t i = toatalNum - 1; i >= 0; i--) {
        ONE_ACT_NO_LOG(namelist[i] == NULL, continue);
        int32_t ret = strncmp(namelist[i]->d_name, pstSubInfo->fileHead, fileHeadLen);
        ONE_ACT_NO_LOG(ret != 0, continue);
        (void)memset_s(aucFileName, MAX_FULLPATH_LEN + 1U, 0, MAX_FULLPATH_LEN + 1U);
        ret = snprintf_s(aucFileName, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN,
                         "%s%s%s", pstSubInfo->filePath, FILE_SEPARATOR, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf file name failed, strerr=%s.", strerror(ToolGetErrorCode()));
        // active file transfer to rotate file when compress open
        if (LogCompressSwitch()) {
            LogAgentHandleCompressFile(aucFileName, MAX_FULLPATH_LEN);
        } else if ((fileNum == 0) && (pstSubInfo->devWriteFileFlag == 0)) { // 初始化阶段，不预留活跃文件空间和数量
            // add newest file to current fileName and skip, keep at least one log file
            errno_t err = strcpy_s(pstSubInfo->fileName, MAX_FILENAME_LEN + 1U, namelist[i]->d_name);
            ONE_ACT_ERR_LOG(err != EOK, continue, "strcpy_s failed, res=%d, strerr=%s.",
                err, strerror(ToolGetErrorCode()));
            fileNum++;
            continue;
        } else {
            ;
        }
        LogAgentAgingFile(&isRemove, &fileSize, aucFileName, &fileNum, pstSubInfo);
    }
    // after the file is deleted, delete the directory if total size is over.
    if (isRemove) {
        LogAgentRemoveDir(pstSubInfo, 0);
        return OK;
    }
    if (fileSize + pstSubInfo->dirTotalSize > pstSubInfo->totalMaxFileSize) {
        LogAgentRemoveDir(pstSubInfo, pstSubInfo->totalMaxFileSize - fileSize);
    }
    return OK;
}

/**
* @brief LogAgentGetFileListForModule: get file list in specified directory
* @param [in/out] pstSubInfo: strut to store file list
* @param [in] dir: directory to be scanned
* @return: OK: succeed; NOK: failed
*/
uint32_t LogAgentGetFileListForModule(StSubLogFileList *pstSubInfo, const char *dir)
{
    ToolDirent **namelist = NULL;
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return NOK, "[input] log file list info is null.");
    ONE_ACT_WARN_LOG(dir == NULL, return NOK, "[input] log directory is null.");

    // check if sub-dir for host&device exist, if not then return immediately
    int32_t ret = ToolAccess((const char *)pstSubInfo->filePath);
    ONE_ACT_NO_LOG(ret != SYS_OK, return OK);

    // get file lists
    int32_t toatalNum = ToolScandir((const char *)pstSubInfo->filePath, &namelist, LogFilter, alphasort);

    ONE_ACT_ERR_LOG(toatalNum < 0, return NOK, "scandir %s failed, result=%d, strerr=%s.",
                    dir, toatalNum, strerror(ToolGetErrorCode()));
    ONE_ACT_NO_LOG(namelist == NULL, return OK);
    ret = LogAgentGetCurrentFileList(pstSubInfo, namelist, toatalNum);
    ToolScandirFree(namelist, toatalNum);
    ONE_ACT_ERR_LOG(ret != OK, return NOK, "get current file list failed, dir = %s, module = %s.",
                    pstSubInfo->filePath, pstSubInfo->fileHead);
    return OK;
}

/**
* @brief LogAgentCreateNewFileName: get new log file name with timestamp
* @param [in/out] pstSubInfo: strut to store new file name
* @return: OK: succeed; NOK: failed
*/
uint32_t LogAgentCreateNewFileName(StSubLogFileList *pstSubInfo)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return NOK, "[input] log file list info is null.");
    char aucTime[TIME_STR_SIZE + 1] = { 0 };
    if (GetLocalTimeHelper(TIME_STR_SIZE, aucTime) != OK) {
        return NOK;
    }
    (void)memset_s(pstSubInfo->fileName, MAX_FILENAME_LEN + 1U, 0, MAX_FILENAME_LEN + 1U);
    const char* suffix = LogCompressSwitch() ? LOG_ACTIVE_FILE_GZ_SUFFIX : LOG_FILE_SUFFIX;
    int32_t err = snprintf_s(pstSubInfo->fileName, MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "%s%s%s",
                             pstSubInfo->fileHead, aucTime, suffix);
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s filename failed, result=%d, strerr=%s.", err, strerror(ToolGetErrorCode()));
        return NOK;
    }

    return OK;
}

/**
* @brief LogAgentRemoveFile: remove log file with given filename
* @param [in] filename: file name which will be deleted
* @return: OK: succeed; NOK: failed
*/
unsigned int LogAgentRemoveFile(const char *filename)
{
    if (filename == NULL) {
        SELF_LOG_WARN("[input] filename is null.");
        return NOK;
    }

    int ret = ToolChmod(filename, LOG_FILE_RDWR_MODE);
    // logFile may be deleted by user, then selflog will be ignored
    if ((ret != 0) && (ToolGetErrorCode() != ENOENT)) {
        SELF_LOG_WARN("can not chmod file, file=%s, strerr=%s.", filename, strerror(ToolGetErrorCode()));
    }

    ret = ToolUnlink(filename);
    if (ret == 0) {
        return OK;
    } else {
        // logFile may be deleted by user, then selflog will be ignored
        if (ToolGetErrorCode() != ENOENT) {
            SELF_LOG_WARN("can not unlink file, file=%s, strerr=%s.", filename, strerror(ToolGetErrorCode()));
        }
        return NOK;
    }
}

/**
* @brief GetFileOfSize: get current writing files' size.
*                       if file size exceed limitation, change file mode to read only
*                       if specified file is removed, create new log file
* @param [in] logList: log file list
* @param [in] pstLogData: log data
* @param [in] pFileName: filename with full path
* @param [in] filesize: current log file size
* @return: OK: succeed; NOK: failed
*/
STATIC int32_t GetFileOfSize(StSubLogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                             const char *pFileName, off_t *filesize)
{
    ToolStat statbuff = { 0 };
    FILE *fp = NULL;

    char *ppath = (char *)LogMalloc(TOOL_MAX_PATH + 1);
    if (ppath == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }

    // get file length
    if (ToolRealPath(pFileName, ppath, TOOL_MAX_PATH + 1) == SYS_OK) {
        size_t cfgPathLen = strlen(ppath);
        if (IsPathValidbyLog(ppath, cfgPathLen) == false) {
            SELF_LOG_WARN("file realpath is invalid, file=%s, realpath=%s.", pFileName, ppath);
            XFREE(ppath);
            return CFG_FILE_INVALID;
        }

        fp = fopen(ppath, "r");
        if (fp != NULL) {
            if (ToolStatGet(ppath, &statbuff) == SYS_OK) {
                *filesize = statbuff.st_size;
            }
        }
    } else {
        *filesize = 0;
        (void)LogAgentCreateNewFileName(pstSubInfo);
    }
    if (*filesize > ((off_t)(UINT_MAX) - (off_t)pstLogData->ulDataLen)) {
        LOG_CLOSE_FILE(fp);
        XFREE(ppath);
        return NOK;
    }
    LOG_CLOSE_FILE(fp);
    XFREE(ppath);
    return OK;
}

/**
* @brief LogAgentGetFileName: get current writing log file's full path(contains filename)
* @param [in] pstSubInfo: log file list
* @param [in] pstLogData: log data
* @param [in/out] pFileName: file name to be gotten. contains full file path
* @param [in] ucMaxLen: max length of full log file path(contains filename)
* @return: OK: succeed; NOK: failed
*/
STATIC uint32_t LogAgentGetFileName(StSubLogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                                    char *pFileName, size_t ucMaxLen)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return NOK, "[input] log file list is null.");
    ONE_ACT_WARN_LOG(pstLogData == NULL, return NOK, "[input] log data is null.");
    ONE_ACT_WARN_LOG(pFileName == NULL, return NOK, "[input] log filename pointer is null.");

    // create new one if not exists
    if (LogStrlen(pstSubInfo->fileName) == 0U) {
        // modify for compress switch, restart with new logfile.
        // When no log file exists,need to deal with "devWriteFileFlag", the same as follows.
        pstSubInfo->devWriteFileFlag = 1;
        // check current file size and num before new file created
        (void)LogAgentGetFileListForModule(pstSubInfo, pstSubInfo->filePath);
        (void)LogAgentCreateNewFileName(pstSubInfo);
        return FilePathSplice(pstSubInfo, pFileName, ucMaxLen);
    }

    uint32_t ret = FilePathSplice(pstSubInfo, pFileName, ucMaxLen);
    ONE_ACT_NO_LOG(ret != OK, return NOK);

    off_t filesize = 0;
    int32_t err = GetFileOfSize(pstSubInfo, pstLogData, pFileName, &filesize);
    ONE_ACT_ERR_LOG((err != OK) || (filesize < 0), return NOK,
        "get file size failed, file=%s, result=%d.", pFileName, err);
    pstSubInfo->devWriteFileFlag = 1;

    // modify for compress switch, restart with new logfile
    if ((((uint32_t)filesize + pstLogData->ulDataLen) > pstSubInfo->maxFileSize) ||
        (pstSubInfo->devWriteFileFlag == 0)) {
        // check whether compression is required
        if (LogCompressSwitch() && LogCompressCheckActiveFile(pFileName)) {
            (void)LogCompressFileRotate(pFileName);
        } else {
            FsyncLogToDisk(pFileName);
        }

        pstSubInfo->devWriteFileFlag = 1;

        // if sum of file size > totalSize, delete oldest file
        ret = LogAgentGetFileListForModule(pstSubInfo, pstSubInfo->filePath);
        if (ret != OK) {
            SELF_LOG_ERROR("get %s log file list failed, directory=%s, result=%u",
                           pstSubInfo->fileHead, pstSubInfo->filePath, ret);
            return NOK;
        }
        (void)LogAgentCreateNewFileName(pstSubInfo);
    }

    return FilePathSplice(pstSubInfo, pFileName, ucMaxLen);
}

STATIC unsigned int LogAgentMkdir(const char *logPath)
{
    ONE_ACT_NO_LOG(logPath == NULL, return NOK);

    int32_t ret = ToolAccess((const char *)logPath);
    ONE_ACT_NO_LOG(ret == SYS_OK, return OK);
    LogRt err = LogMkdirRecur((const char *)g_logRootPath);
    if (err != SUCCESS) {
        SELF_LOG_ERROR_N(&g_rootMkPrintNum, GENERAL_PRINT_NUM,
                         "mkdir %s failed, strerr=%s, log_err=%d, print once every %u times.",
                         g_logRootPath, strerror(ToolGetErrorCode()), (int32_t)err, GENERAL_PRINT_NUM);
        return NOK;
    }
    // create log path
    // judge if sub-logdir is exist(for debug/run/security), if not, create one
    char sortPath[MAX_FILEDIR_LEN + 1U] = { 0 };
    for (int32_t idx = (int32_t)DEBUG_LOG; idx < (int32_t)LOG_TYPE_NUM; idx++) {
        (void)memset_s(sortPath, MAX_FILEDIR_LEN + 1U, 0, MAX_FILEDIR_LEN + 1U);
        ret = snprintf_s(sortPath, MAX_FILEDIR_LEN + 1U, MAX_FILEDIR_LEN, "%s/%s", g_logRootPath, SORT_DIR_NAME[idx]);
        ONE_ACT_ERR_LOG(ret == -1, return NOK, "snprintf_s failed, err=%s.", strerror(ToolGetErrorCode()));
        err = LogMkdir((const char *)sortPath);
        if (err != SUCCESS) {
            SELF_LOG_ERROR_N(&g_subMkPrintNum, GENERAL_PRINT_NUM,
                             "mkdir %s failed, strerr=%s, log_err=%d, print once every %u times.",
                             sortPath, strerror(ToolGetErrorCode()), (int32_t)err, GENERAL_PRINT_NUM);
            return NOK;
        }
    }
    err = LogMkdir(logPath);
    if (err != SUCCESS) {
        SELF_LOG_ERROR_N(&g_subMkPrintNum, GENERAL_PRINT_NUM,
                         "mkdir %s failed, strerr=%s, log_err=%d, print once every %u times.",
                         logPath, strerror(ToolGetErrorCode()), (int32_t)err, GENERAL_PRINT_NUM);
        return NOK;
    }
    return OK;
}

/**
* @brief : write log to unzip file
* @param [in] pstSubInfo: log file list
* @param [in] pstLogData: log data to be written
* @param [in] aucFileName: filename with full path
* @param [in] aucFileNameLen: max file path length
* @return: OK: succeed; NOK: failed
*/
STATIC uint32_t LogAgentWriteDataToFile(StSubLogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                                        char *const aucFileName, size_t aucFileNameLen)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return NOK, "[input] log file list is null.");
    ONE_ACT_WARN_LOG(pstLogData == NULL, return NOK, "[input] log data is null.");
    ONE_ACT_WARN_LOG(aucFileName == NULL, return NOK, "[input] log filename is null.");
    ONE_ACT_WARN_LOG(((aucFileNameLen == 0) || (aucFileNameLen > (MAX_FULLPATH_LEN + 1U))),
                     return NOK, "[input] log filename length is invalid, length=%zu", aucFileNameLen);
    const VOID *dataBuf = pstLogData->paucData;
    uint32_t ulRet = LogAgentGetFileName(pstSubInfo, pstLogData, aucFileName, MAX_FULLPATH_LEN);
    if (ulRet != OK) {
        SELF_LOG_ERROR("get filename failed, result=%u.", ulRet);
        return NOK;
    }

    int32_t fd = ToolOpenWithMode(aucFileName, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND,
        LOG_FILE_RDWR_MODE);
    if (fd < 0) {
        SELF_LOG_ERROR_N(&g_openPrintNum, GENERAL_PRINT_NUM,
                         "open file failed with mode, file=%s, strerr=%s, print once every %u times.",
                         aucFileName, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        return NOK;
    }

    int32_t ret = ToolWrite(fd, dataBuf, pstLogData->ulDataLen);
    if ((ret < 0) || ((uint32_t)ret != pstLogData->ulDataLen)) {
        LOG_CLOSE_FD(fd);
        SELF_LOG_ERROR_N(&g_writeBPrintNum, GENERAL_PRINT_NUM,
                         "write to file failed, file=%s, data_length=%u, write_length=%d, strerr=%s," \
                         " print once every %u time.",
                         aucFileName, pstLogData->ulDataLen, ret, strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
        return NOK;
    }
    int32_t err = ToolFChownPath(fd);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("change file owner failed, file=%s, log_err=%u, strerr=%s.",
                       aucFileName, (uint32_t)err, strerror(ToolGetErrorCode()));
    }
    LOG_CLOSE_FD(fd);
    return OK;
}

/**
* @brief splice log type and check whether current log data writing is limited
* @param [in] subList: log file list
* @param [in] dataLen: log data length
* @return: true: write log data; false: discard log data
*/
STATIC bool LogAgentWriteLimitCheck(StSubLogFileList *subList, uint32_t dataLen)
{
    char* buffer = strdup(subList->filePath);
    ONE_ACT_ERR_LOG(buffer == NULL, return false, "strdup file path failed, discard current log data.");

    size_t len = strlen(buffer);
    if (buffer[len - 1U] == '/') {
        buffer[len - 1U] = '\0';
    }

    char* lastSlash = strrchr(buffer, '/');
    if (lastSlash == NULL) {
        XFREE(buffer);
        SELF_LOG_ERROR("strrchr last slash fail, discard current log data.");
        return false;
    }

    char label[WRITE_FILE_LABEL_MAX_SIZE] = { 0 };
    char *lastValue = lastSlash + 1;
    if (strcmp(lastValue, DEBUG_DIR_NAME) == 0) {
        if (sprintf_s(label, WRITE_FILE_LABEL_MAX_SIZE, "%s/%s", lastValue, subList->fileHead) == -1) {
            XFREE(buffer);
            SELF_LOG_ERROR("sprintf_s label fail, discard current log data.");
            return false;
        }
        len = strlen(label);
        label[len - 1U] = '\0';
    } else {
        *lastSlash = '\0';
        char* penultimateSlash = strrchr(buffer, '/');
        if (penultimateSlash == NULL) {
            XFREE(buffer);
            SELF_LOG_ERROR("strrchr penultimate slash fail, discard current log data.");
            return false;
        }
        *lastSlash = '/';
        if (sprintf_s(label, WRITE_FILE_LABEL_MAX_SIZE, "%s", penultimateSlash + 1) == -1) {
            XFREE(buffer);
            SELF_LOG_ERROR("sprintf_s label fail, discard current log data.");
            return false;
        }
    }

    if (!WriteFileLimitCheck(subList->limit, dataLen, label)) {
        XFREE(buffer);
        return false;
    }

    XFREE(buffer);
    return true;
}

/**
* @brief LogAgentWriteFile: write log to file
* @param [in] subList: log file list
* @param [in] logData: log data
* @return: OK: succeed; NOK: failed
*/
unsigned int LogAgentWriteFile(StSubLogFileList *subList, StLogDataBlock *logData)
{
    ONE_ACT_NO_LOG(subList == NULL, return NOK);
    ONE_ACT_NO_LOG((logData == NULL) || (logData->paucData == NULL) || (logData->ulDataLen == 0), return OK);
    // judge if sub-logdir is exist(for debug), if not, create one
    if (LogAgentMkdir(subList->filePath) == NOK) {
        return NOK;
    }

    char *zippedBuf = NULL;
    if (LogCompressSwitch()) {
        uint32_t zippedBufLen = 0;
        int32_t res  = SlogdCompress(logData->paucData, logData->ulDataLen, &zippedBuf, &zippedBufLen);
        if (res == LOG_SERVICE_NOT_READY) {
            return NOK;
        }
        if (res != LOG_SUCCESS) {
            SELF_LOG_ERROR("compress log data failed, data_length=%u.", logData->ulDataLen);
            return NOK;
        }
        logData->paucData = zippedBuf;
        logData->ulDataLen = zippedBufLen;
    }

    if (!LogAgentWriteLimitCheck(subList, logData->ulDataLen)) {
        XFREE(zippedBuf);
        return OK;
    }

    char logFileName[MAX_FULLPATH_LEN + 1U] = { 0 };
    uint32_t ret = LogAgentWriteDataToFile(subList, logData, logFileName, sizeof(logFileName));
    XFREE(zippedBuf);
    // change file mode if it was masked by umask
    if (ToolChmod((const char *)logFileName, (INT32)LOG_FILE_RDWR_MODE) != OK) {
        SELF_LOG_ERROR_N(&g_chmodFPrintNum, GENERAL_PRINT_NUM,
                         "change log file mode failed, file=%s, print once every %u times.",
                         logFileName, GENERAL_PRINT_NUM);
    }
    return ret;
}

/**
* @brief LogAgentInitMaxFileNumHelper: initialize struct for log file path and log name list
* @param [in] pstSubInfo: log file list
* @param [in] logPath: log sub directory path
* @param [in] length: logPath length
* @return: OK: succeed; NOK: failed
*/
unsigned int LogAgentInitMaxFileNumHelper(StSubLogFileList *pstSubInfo, const char *logPath, int length)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return NOK, "[input] log file list info is null.");
    ONE_ACT_WARN_LOG(logPath == NULL, return NOK, "[input] log filepath is null.");
    ONE_ACT_WARN_LOG(length <= 0, return NOK, "[input] log filepath length is invalid, length=%d.", length);
    (void)memset_s(pstSubInfo->filePath, (MAX_FILEPATH_LEN + 1U), 0, (MAX_FILEPATH_LEN + 1U));
    errno_t err = snprintf_s(pstSubInfo->filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s", logPath);
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s file path failed, result=%d, strerr=%s.", err, strerror(ToolGetErrorCode()));
    }
    (void)memset_s((void *)pstSubInfo->fileName, MAX_FILENAME_LEN + 1U, 0, MAX_FILENAME_LEN + 1U);
    return OK;
}

/**
* @brief FilePathSplice: concat log directory path with log filename
* @param [in] pstSubInfo: log file list
* @param [in] pFileName: filename with full path
* @param [in] ucMaxLen: max file path length
* @return: OK: succeed; NOK: failed
*/
unsigned int FilePathSplice(const StSubLogFileList *pstSubInfo, char *pFileName, size_t ucMaxLen)
{
    int ret = snprintf_s(pFileName, ucMaxLen + 1U, ucMaxLen, "%s%s%s",
                         pstSubInfo->filePath, FILE_SEPARATOR, pstSubInfo->fileName);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s filename failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return NOK;
    }
    return OK;
}

STATIC uint32_t LogAgentGetDeviceOsFileList(StLogFileList *logList)
{
    if (logList == NULL) {
        SELF_LOG_WARN("[input] log file info is null.");
        return NOK;
    }

    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        StSubLogFileList *list = &(logList->sortDeviceOsLogList[i]);
        uint32_t ret = LogAgentGetFileListForModule(list, list->filePath);
        if (ret != OK) {
            SELF_LOG_ERROR("get device os log file list failed, directory=%s, result=%u", logList->aucFilePath, ret);
            return NOK;
        }
    }

    return OK;
}

/**
* @brief        : calculate current type log total file size without active file
* @param [in]   : fileSize      log file max size
* @param [in]   : fileNum       file number
* @return       : total file size without active file
*/
uint32_t LogCalTotalFileSize(uint32_t fileSize, int32_t fileNum)
{
    if (fileNum <= 0) {
        return 0U;
    }
    return fileSize * ((uint32_t)fileNum - 1U);
}

STATIC uint32_t LogAgentInitDeviceOsMaxFileNum(StLogFileList *logList)
{
    char deviceOsLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list is null.");
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        StSubLogFileList* list = &(logList->sortDeviceOsLogList[i]);
        ONE_ACT_WARN_LOG(list == NULL, return NOK, "[input] list is null.");
        if (i == (int32_t)DEBUG_LOG) {
            list->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxOsFileSize, logList->maxOsFileNum);
            list->maxFileSize = logList->ulMaxOsFileSize;
        } else if (i == (int32_t)SECURITY_LOG) {
            list->totalMaxFileSize = SECURITY_FILE_SIZE * (SECURITY_FILE_NUM - 1U);
            list->maxFileSize = SECURITY_FILE_SIZE;
        } else {
            list->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxNdebugFileSize, logList->maxNdebugFileNum);
            list->maxFileSize = logList->ulMaxNdebugFileSize;
        }
        int err = snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s_", DEVICE_OS_HEAD);
        ONE_ACT_ERR_LOG(err == -1, return NOK, "get device os header failed, result=%d, strerr=%s.", \
                        err, strerror(ToolGetErrorCode()));
        (void)memset_s(deviceOsLogPath, MAX_FILEPATH_LEN + 1U, 0, MAX_FILEPATH_LEN + 1U);
        err = snprintf_s(deviceOsLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s",
                         logList->aucFilePath, FILE_SEPARATOR, SORT_DIR_NAME[i], FILE_SEPARATOR, DEVICE_OS_HEAD);
        ONE_ACT_ERR_LOG(err == -1, return NOK, "get device os log dir path failed, result=%d, strerr=%s.",
                        err, strerror(ToolGetErrorCode()));
        unsigned int ret = LogAgentInitMaxFileNumHelper(list, deviceOsLogPath, MAX_FILEPATH_LEN);
        ONE_ACT_ERR_LOG(ret != OK, return NOK, "init max device os filename list failed, result=%u.", ret);
        (void)ToolMutexInit(&list->lock);
    }

    return OK;
}

STATIC uint32_t LogAgentInitDeviceOsWriteLimit(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list is null.");
    if (!SlogdConfigMgrGetWriteFileLimit()) {
        return OK;
    }
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        StSubLogFileList* list = &(logList->sortDeviceOsLogList[i]);
        ONE_ACT_WARN_LOG(list == NULL, return NOK, "[input] list is null.");
        uint32_t typeSize = SlogdConfigMgrGetTypeSpace(i);
        if (typeSize == 0) {
            continue;
        }
        if (WriteFileLimitInit(&list->limit, i, typeSize, list->totalMaxFileSize + list->maxFileSize) != LOG_SUCCESS) {
            SELF_LOG_ERROR("create device os write file limit param list failed.");
            return NOK;
        }
    }
    return OK;
}

LogStatus LogAgentInitDeviceOs(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "[input] log file list info is null.");
    (void)memset_s(logList, sizeof(StLogFileList), 0x00, sizeof(StLogFileList));
    int32_t ret = snprintf_truncated_s(logList->aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    ONE_ACT_ERR_LOG(ret < 0, return LOG_FAILURE, "snprintf_truncated_s failed.");

    if (LogAgentGetCfg(logList) != LOG_SUCCESS) {
        SELF_LOG_ERROR("init device os config failed.");
        return LOG_FAILURE;
    }
    if (LogAgentInitDeviceOsMaxFileNum(logList) != OK) {
        SELF_LOG_ERROR("init device os file list failed.");
        return LOG_FAILURE;
    }
    if (LogAgentGetDeviceOsFileList(logList) != OK) {
        SELF_LOG_ERROR("get current device os file list failed.");
        return LOG_FAILURE;
    }
    if (LogAgentInitDeviceOsWriteLimit(logList) != OK) {
        SELF_LOG_ERROR("init device os file list write limit failed.");
        return LOG_FAILURE;
    }
    if (LogAgentInitDevice(logList, MAX_DEV_NUM) != OK) {
        SELF_LOG_ERROR("get current device file list failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

uint32_t LogAgentWriteDeviceOsLog(int32_t logType, StSubLogFileList *subLogList, char *msg, unsigned int len)
{
    ONE_ACT_WARN_LOG(msg == NULL, return NOK, "[input] device log buff is null.");
    ONE_ACT_WARN_LOG(len == 0, return NOK, "[input] device log buff size is 0.");
    ONE_ACT_WARN_LOG(subLogList == NULL, return NOK, "[input] log file list is null.");
    StLogDataBlock stLogData = { 0 };
    stLogData.ucDeviceID = 0;
    stLogData.ulDataLen = len;
    stLogData.paucData = (char *)msg;
    ONE_ACT_WARN_LOG((logType < (int32_t)DEBUG_LOG) || (logType >= (int32_t)LOG_TYPE_NUM),
                     return NOK, "[input] wrong log type %d", logType);
    unsigned int ret = LogAgentWriteFile(subLogList, &stLogData);
    return ret;
}

void LogAgentCleanUpDevice(StLogFileList *logList)
{
    if (logList == NULL) {
        return;
    }

    for (unsigned int iType = 0; iType < (unsigned int)LOG_TYPE_NUM; iType++) {
        XFREE(logList->deviceLogList[iType]);
        XFREE(logList->sortDeviceAppLogList[iType].dirList);
    }
}

STATIC uint32_t LogAgentGetDeviceFileList(StLogFileList *logList)
{
    if (logList == NULL) {
        SELF_LOG_WARN("[input] log file list is null.");
        return NOK;
    }

    StSubLogFileList *list = NULL;
    for (uint32_t iType = 0; iType < (uint32_t)LOG_TYPE_NUM; iType++) {
        for (unsigned char idx = 0; idx < logList->ucDeviceNum; idx++) {
            list = &(logList->deviceLogList[iType][idx]);
            uint32_t ret = LogAgentGetFileListForModule(list, list->filePath);
            if (ret != OK) {
                SELF_LOG_ERROR("get device log file list failed, directory=%s, device_id=%d, result=%u.",
                               list->filePath, idx, ret);
                return NOK;
            }
        }
    }
    return OK;
}

unsigned int LogAgentInitDeviceMaxFileNum(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list info is null.");

    for (uint32_t iType = 0; iType < (uint32_t)LOG_TYPE_NUM; iType++) {
        for (uint32_t idx = 0; idx < logList->ucDeviceNum; idx++) {
            StSubLogFileList* list = &(logList->deviceLogList[iType][idx]);
            ONE_ACT_WARN_LOG(list == NULL, return NOK, "[input] list is null.");
            (void)memset_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, 0, MAX_NAME_HEAD_LEN + 1U);

            list->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxFileSize, logList->maxFileNum);
            list->maxFileSize = logList->ulMaxFileSize;
            int32_t err = snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN,
                                     "%s%u_", DEVICE_HEAD, GetHostDeviceID(idx));

            ONE_ACT_ERR_LOG(err == -1, return NOK, "get device header failed, result=%d, strerr=%s.",
                            err, strerror(ToolGetErrorCode()));
            char deviceLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
            // device log must be debug type
            err = snprintf_s(deviceLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s%u",
                             logList->aucFilePath, FILE_SEPARATOR, SORT_DIR_NAME[iType],
                             FILE_SEPARATOR, DEVICE_HEAD, GetHostDeviceID(idx));
            ONE_ACT_ERR_LOG(err == -1, return NOK,
                            "get device log dir path failed, device_id=%u, result=%d, strerr=%s.",
                            idx, err, strerror(ToolGetErrorCode()));
            uint32_t ret = LogAgentInitMaxFileNumHelper(list, deviceLogPath, MAX_FILEPATH_LEN);
            ONE_ACT_ERR_LOG(ret != OK, return NOK, "init max device filename list failed, result=%u.", ret);
        }
    }
    return OK;
}

STATIC uint32_t LogAgentInitDeviceWriteLimit(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list info is null.");
    if (!SlogdConfigMgrGetWriteFileLimit()) {
        return OK;
    }
    for (int32_t iType = 0; iType < (int32_t)LOG_TYPE_NUM; iType++) {
        uint32_t typeSize = SlogdConfigMgrGetTypeSpace(iType);
        if (typeSize == 0) {
            continue;
        }
        for (uint32_t idx = 0; idx < logList->ucDeviceNum; idx++) {
            StSubLogFileList* list = &(logList->deviceLogList[iType][idx]);
            ONE_ACT_WARN_LOG(list == NULL, return NOK, "[input] list is null.");
            if (WriteFileLimitInit(&list->limit, iType, typeSize, list->totalMaxFileSize + list->maxFileSize) != LOG_SUCCESS) {
                SELF_LOG_ERROR("create device write file limit param list failed.");
                return NOK;
            }
        }
    }

    return OK;
}

unsigned int LogAgentInitDevice(StLogFileList *logList, unsigned char deviceNum)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list is null.");
    logList->ucDeviceNum = deviceNum;

    size_t len = sizeof(StSubLogFileList) * deviceNum;
    ONE_ACT_WARN_LOG(len == 0, return NOK, "device number is invalid, device_number=%u.", deviceNum);

    unsigned int iType = 0;
    for (; iType < (unsigned int)LOG_TYPE_NUM; iType++) {
        // multi devices and os init
        logList->deviceLogList[iType] = (StSubLogFileList *)LogMalloc(len);
        if (logList->deviceLogList[iType] == NULL) {
            SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
            return NOK;
        }
    }
    // init log file list
    if (LogAgentInitDeviceMaxFileNum(logList) != OK) {
        SELF_LOG_ERROR("init device file list failed.");
        return NOK;
    }
    // get log dir files
    if (LogAgentGetDeviceFileList(logList) != OK) {
        SELF_LOG_ERROR("get current device file list failed.");
        return NOK;
    }
    // init log file list write limit
    if (LogAgentInitDeviceWriteLimit(logList) != OK) {
        SELF_LOG_ERROR("init device file list write limit failed.");
        return NOK;
    }
    return OK;
}

#ifdef GROUP_LOG
uint32_t LogAgentWriteDeviceLog(const StLogFileList *logList, char *msg, const DeviceWriteLogInfo *info)
{
    StLogDataBlock stLogData = { 0 };
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list info is null.");
    ONE_ACT_WARN_LOG(msg == NULL, return NOK, "[input] log message is null.");
    ONE_ACT_WARN_LOG(info == NULL, return NOK, "[input] info is null.");
    if ((info->logType < DEBUG_LOG) || (info->logType >= LOG_TYPE_NUM)) {
        SELF_LOG_WARN("[input] wrong logType=%d.", (int32_t)info->logType);
        return NOK;
    }
    uint32_t deviceId = info->deviceId;
    stLogData.ucDeviceID = deviceId;
    stLogData.ulDataLen = info->len;
    stLogData.paucData = msg;
    StSubLogFileList *subList = NULL;
    if (LogConfGroupGetSwitch() == false) {
        uint32_t deviceNum = logList->ucDeviceNum;
        if (deviceId > deviceNum) {
            SELF_LOG_WARN("[input] wrong device_id=%u, device_number=%u.", deviceId, deviceNum);
            return NOK;
        }
        subList = &(logList->deviceLogList[info->logType][deviceId]);
    } else {
        int32_t moduleId = GetModuleIdByChannel(info->moduleId);
        ONE_ACT_WARN_LOG(moduleId < 0, return NOK, \
                        "chn %u mismatch moduleId, log abandon.", info->moduleId);
        int32_t groupId = GetGroupIdByModuleId(moduleId);
        ONE_ACT_ERR_LOG(groupId < 0, return NOK, "[input] illegal module id %u.", info->moduleId);
        GroupInfo *group = GetGroupInfoById(groupId);
        ONE_ACT_ERR_LOG((group == NULL) || (group->deviceLogList == NULL),
            return NOK, "can't find target group[%d].", groupId);
        uint32_t deviceNum = group->deviceNum;
        if (info->deviceId > deviceNum) {
            SELF_LOG_WARN("[input] wrong device_id=%u, device_number=%u.", info->deviceId, deviceNum);
            return NOK;
        }
        subList = &(group->deviceLogList[deviceId]);
    }
    return LogAgentWriteFile(subList, &stLogData);
}
#else
uint32_t LogAgentWriteDeviceLog(const StLogFileList *logList, char *msg, const DeviceWriteLogInfo *info)
{
    StLogDataBlock stLogData = { 0 };
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list info is null.");
    ONE_ACT_WARN_LOG(msg == NULL, return NOK, "[input] log message is null.");
    ONE_ACT_WARN_LOG(info == NULL, return NOK, "[input] info is null.");

    if (info->deviceId > logList->ucDeviceNum) {
        SELF_LOG_WARN("[input] wrong device_id=%u, device_number=%u.",
                      info->deviceId, logList->ucDeviceNum);
        return NOK;
    }

    LogType logType = info->logType;
    if (logType >= LOG_TYPE_NUM) {
        logType = DEBUG_LOG;
    }

    int num = (int)logType;
    if (logList->deviceLogList[num] == NULL) {
        SELF_LOG_WARN("[input] device log file list is null.");
        return NOK;
    }

    unsigned int deviceId = info->deviceId;
    stLogData.ucDeviceID = deviceId;
    stLogData.ulDataLen = info->len;
    stLogData.paucData = msg;
    return LogAgentWriteFile(&(logList->deviceLogList[num][deviceId]), &stLogData);
}
#endif

STATIC unsigned int LogAgentGetDeviceAppFileList(StSubLogFileList *subFileList)
{
    if (subFileList == NULL) {
        SELF_LOG_WARN("[input] log file info is null.");
        return NOK;
    }
    uint32_t ret = LogAgentGetFileListForModule(subFileList, subFileList->filePath);
    if (ret != OK) {
        SELF_LOG_ERROR("get device app log file list failed, directory=%s, result=%u", subFileList->filePath, ret);
        return NOK;
    }
    return OK;
}

STATIC unsigned int LogAgentInitDeviceApp(const StLogFileList *logList, StSubLogFileList *subFileList,
                                          const LogInfo* logInfo)
{
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] log file list is null.");
    ONE_ACT_WARN_LOG(subFileList == NULL, return NOK, "[input] sub log file list is null.");
    ONE_ACT_WARN_LOG(logInfo == NULL, return NOK, "[input] log info is null.");
    unsigned int pid = logInfo->pid;
    subFileList->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxAppFileSize, logList->maxAppFileNum);
    subFileList->maxFileSize = logList->ulMaxAppFileSize;
    int ret;
    char appName[MAX_FILEPATH_LEN + 1U] = { 0 };
    if (logInfo->aosType == 0) {
        ret = snprintf_s(appName, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s-%u", DEVICE_APP_HEAD, pid);
    } else {
        ret = snprintf_s(appName, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s-%u", AOS_CORE_DEVICE_APP_HEAD, pid);
    }
    ONE_ACT_ERR_LOG(ret == -1, return NOK, "get app name failed, result=%d, strerr=%s.", \
                    ret, strerror(ToolGetErrorCode()));
    ret = snprintf_s(subFileList->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN,
                     "%s_", appName);
    ONE_ACT_ERR_LOG(ret == -1, return NOK, "get device app header failed, result=%d, strerr=%s.", \
                    ret, strerror(ToolGetErrorCode()));
    char deviceAppLogPath[MAX_FILEPATH_LEN + 1U] = { 0 };
    ret = snprintf_s(deviceAppLogPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s", logList->aucFilePath,
                     FILE_SEPARATOR, SORT_DIR_NAME[logInfo->type], FILE_SEPARATOR, appName);
    ONE_ACT_ERR_LOG(ret == -1, return NOK, "get device app log dir path failed, pid=%u, result=%d, strerr=%s.",
                    pid, ret, strerror(ToolGetErrorCode()));
    unsigned int res = LogAgentInitMaxFileNumHelper(subFileList, deviceAppLogPath, MAX_FILEPATH_LEN);
    ONE_ACT_ERR_LOG(res != OK, return NOK, "init max device app filename list failed, result=%u.", res);
    if (LogAgentGetDeviceAppFileList(subFileList) != OK) {
        SELF_LOG_ERROR("get current device app file list failed.");
        return NOK;
    }
    return OK;
}

STATIC int32_t AppLogPidDirFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((dir->d_type == (uint8_t)DT_DIR) && (LogStrStartsWith(dir->d_name, DEVICE_APP_DIR_NAME) == false) &&
        ((LogStrStartsWith(dir->d_name, DEVICE_APP_HEAD) != false) ||
         (LogStrStartsWith(dir->d_name, AOS_CORE_DEVICE_APP_HEAD) != false))) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

static void LogAgentAddLogDirList(const char *path, LogDirList *dirList, const char *dir)
{
    int32_t ret = snprintf_s(dirList->dirName, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN, "%s/%s", path, dir);
    if (ret == -1) {
        SELF_LOG_ERROR("get dirname failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return;
    }
    dirList->dirSize = LogGetDirSize(dirList->dirName, 0);
}

static uint32_t LogAgentSortDirList(const char *path, LogDirList *dir, ToolDirent **namelist, int32_t totalNum)
{
    int32_t start = 0;
    LogDirList *curDir = NULL;
    uint32_t totalSize = 0;
    while (start < totalNum) {
        // find the newest directory
        int32_t point = start;
        for (int32_t i = start; i < totalNum; i++) {
            const ToolDirent *cur = namelist[point];
            const ToolDirent *new = namelist[i];
            point = (SlogdApplogSortFileFunc(path, &cur, &new) == 0) ? i : point;
        }
        if (point != start) {
            // switch the newest item to [start]
            ToolDirent *temp = namelist[point];
            namelist[point] = namelist[start];
            namelist[start] = temp;
        }
        curDir = (LogDirList *)(dir + start);
        LogAgentAddLogDirList(path, curDir, namelist[start]->d_name);
        totalSize += curDir->dirSize;
        start++;
    }
    return totalSize;
}

static int32_t LogAgentInitDeviceAppDir(StLogFileList *logList, int32_t type)
{
    char path[MAX_FILEPATH_LEN + 1U] = { 0 };
    int32_t ret = snprintf_s(path, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s", logList->aucFilePath,
                             FILE_SEPARATOR, SORT_DIR_NAME[type]);
    if (ret == -1) {
        SELF_LOG_ERROR("get device app log dir[%d] path failed, result=%d, strerr=%s.",
                       type, ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    // check if sub-dir exist, if not then return immediately
    ONE_ACT_NO_LOG(ToolAccess(path) != SYS_OK, return LOG_SUCCESS);
    ToolDirent **namelist = NULL;
    int32_t totalNum = ToolScandir(path, &namelist, AppLogPidDirFilter, NULL);
    ONE_ACT_ERR_LOG((totalNum < 0) || ((totalNum > 0) && (namelist == NULL)), return LOG_FAILURE,
        "scan directory failed, result=%d, strerr=%s.", totalNum, strerror(ToolGetErrorCode()));
    ONE_ACT_INFO_LOG(totalNum == 0, return LOG_SUCCESS, "no device app log dir[%d] found.", type);

    LogDirList *dir = (LogDirList *)LogMalloc((size_t)totalNum * sizeof(LogDirList));
    if (dir == NULL) {
        SELF_LOG_ERROR("malloc failed for app log list[%d], strerr=%s.", type, strerror(ToolGetErrorCode()));
        ToolScandirFree(namelist, totalNum);
        return LOG_FAILURE;
    }
    StSubLogFileList *list = &(logList->sortDeviceAppLogList[type]);
    list->dirTotalSize = LogAgentSortDirList(path, dir, namelist, totalNum);
    list->dirList = dir;
    list->dirNum = totalNum;
    ToolScandirFree(namelist, totalNum);
    return LOG_SUCCESS;
}

LogStatus LogAgentInitDeviceApplication(StLogFileList *logList)
{
    ONE_ACT_WARN_LOG(logList == NULL, return LOG_FAILURE, "[input] log file list is null.");
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        if (SlogdConfigMgrGetStorageMode(DEBUG_APP_LOG_TYPE + i) != STORAGE_RULE_COMMON) {
            continue;
        }
        StSubLogFileList *list = &(logList->sortDeviceAppLogList[i]);
        list->totalMaxFileSize = LogCalTotalFileSize(logList->ulMaxAppFileSize, logList->maxAppFileNum);
        list->maxFileSize = logList->ulMaxAppFileSize;
        int32_t ret = snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s_", DEVICE_APP_HEAD);
        if (ret == -1) {
            SELF_LOG_ERROR("get device app header failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
        (void)memset_s(list->filePath, MAX_FILEPATH_LEN + 1U, 0, MAX_FILEPATH_LEN + 1U);
        ret = snprintf_s(list->filePath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s%s%s%s%s", logList->aucFilePath,
                         FILE_SEPARATOR, SORT_DIR_NAME[i], FILE_SEPARATOR, DEVICE_APP_DIR_NAME);
        if (ret == -1) {
            SELF_LOG_ERROR("get device app log dir[%d] path failed, result=%d, strerr=%s.",
                           i, ret, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
        ret = LogAgentInitDeviceAppDir(logList, i);
        NO_ACT_WARN_LOG(ret != LOG_SUCCESS, "can not init device app log dir, result=%d.", ret);
        uint32_t err = LogAgentGetFileListForModule(list, list->filePath);
        ONE_ACT_ERR_LOG(err != OK, return LOG_FAILURE, "get device app log file list failed, directory=%s, result=%u",
            logList->aucFilePath, err);
        uint32_t typeSize = SlogdConfigMgrGetTypeSpace(i);
        if (SlogdConfigMgrGetWriteFileLimit() && (typeSize != 0)) {
            LogAgentRemoveDir(list, list->totalMaxFileSize);
            if (WriteFileLimitInit(&list->limit, i, typeSize, list->totalMaxFileSize + list->maxFileSize) != LOG_SUCCESS) {
                SELF_LOG_ERROR("create device app write file limit param list failed.");
                return LOG_FAILURE;
            }
        }
        (void)ToolMutexInit(&list->lock);
    }
    return LOG_SUCCESS;
}

uint32_t LogAgentWriteDeviceApplicationLog(char *msg, unsigned int len, const LogInfo* logInfo,
                                           StLogFileList *logList)
{
    ONE_ACT_WARN_LOG((msg == NULL) || (len == 0), return NOK, "[input] device app log buff is null or len=%u.", len);
    ONE_ACT_WARN_LOG(logInfo == NULL, return NOK, "[input] device app log info is null.");
    ONE_ACT_WARN_LOG(logInfo->processType != APPLICATION, return NOK, "[input] wrong device app log type=%d.",
                     (int)logInfo->processType);
    ONE_ACT_WARN_LOG(logList == NULL, return NOK, "[input] config file info is null.");
    ONE_ACT_WARN_LOG(logInfo->type >= LOG_TYPE_NUM, return NOK,
                     "[input] wrong device app log type=%d.", (int)logInfo->type);
    StLogDataBlock stLogData = { 0 };
    stLogData.ucDeviceID = 0;
    // parameter [msg] is app log string, such as "0[DEBUG] this is a message." or "[DEBUG] this is a message."
    // at host, number 0-3 is processed into logType(debug, security, run, operation)
    // at device, number 0-3 is useless, because we can get logType from parameter [logInfo]
    if (msg[0] == '[') {
        stLogData.ulDataLen = len;
        stLogData.paucData = msg;
    } else {
        stLogData.ulDataLen = len - 1U;
        stLogData.paucData = msg + 1;
    }

    // app log record with pid, need init device app list every time
    uint32_t ret = 0;
    if (SlogdConfigMgrGetStorageMode(DEBUG_APP_LOG_TYPE + (int32_t)logInfo->type) == STORAGE_RULE_COMMON) {
        StSubLogFileList* subFileList = &(logList->sortDeviceAppLogList[(int32_t)logInfo->type]);
        (void)ToolMutexLock(&subFileList->lock);
        ret = LogAgentWriteFile(subFileList, &stLogData);
        (void)ToolMutexUnLock(&subFileList->lock);
    } else {
        StSubLogFileList subFileList = { 0 };
        (void)memset_s(&subFileList, sizeof(StSubLogFileList), 0, sizeof(StSubLogFileList));
        ret = LogAgentInitDeviceApp(logList, &subFileList, logInfo);
        ONE_ACT_ERR_LOG(ret != OK, return NOK, "get current device app file list failed.");
        subFileList.devWriteFileFlag = 1;
        ret = LogAgentWriteFile(&subFileList, &stLogData);
    }
    return ret;
}

uint32_t LogAgentWriteEventLog(StSubLogFileList *subLogList, char *msg, uint32_t len)
{
    ONE_ACT_WARN_LOG(msg == NULL, return NOK, "[input] device log buff is null.");
    ONE_ACT_WARN_LOG(len == 0, return NOK, "[input] device log buff size is 0.");
    ONE_ACT_WARN_LOG(subLogList == NULL, return NOK, "[input] log file list is null.");
    StLogDataBlock stLogData = { 0 };
    stLogData.ucDeviceID = 0;
    stLogData.ulDataLen = len;
    stLogData.paucData = msg;

    uint32_t ret = LogAgentWriteFile(subLogList, &stLogData);
    return ret;
}

int32_t LogAgentGetCfg(StLogFileList *logList)
{
    if (logList == NULL) {
        SELF_LOG_WARN("[input] log file list info is null.");
        return LOG_INVALID_PTR;
    }

    if (SlogdConfigMgrGetList(logList) != LOG_SUCCESS) {
        SELF_LOG_ERROR("init config failed.");
        return LOG_SUCCESS;
    }

    int32_t ret = strcpy_s(g_logRootPath, MAX_FILEDIR_LEN + 1U, logList->aucFilePath);
    if (ret != EOK) {
        SELF_LOG_ERROR("strcpy_s log directory path failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    }
    return LOG_SUCCESS;
}

void LogFileMgrStorage(StSubLogFileList *subLogList)
{
    ONE_ACT_WARN_LOG(subLogList == NULL, return, "[input] sub log list is null.");

    if ((LogStrlen(subLogList->fileName) == 0U) || (subLogList->storage.curTime < subLogList->storage.period)) {
        return;
    }
    char logFileName[TOOL_MAX_PATH] = { 0 };
    uint32_t ret = FilePathSplice(subLogList, logFileName, (size_t)TOOL_MAX_PATH - 1U);
    ONE_ACT_ERR_LOG(ret != OK, return, "get file name failed, stroage period failed.");
    if (LogCompressSwitch() && LogCompressCheckActiveFile(logFileName)) {
        (void)LogCompressFileRotate(logFileName);
    } else {
        FsyncLogToDisk(logFileName);
    }
    subLogList->storage.curTime = 0;
    // if reach to aging, delete oldest file
    ret = LogAgentGetFileListForModule(subLogList, subLogList->filePath);
    NO_ACT_ERR_LOG(ret != OK, "get %s log file list failed, directory=%s, result=%u",
                   subLogList->fileHead, subLogList->filePath, ret);
    (void)memset_s(subLogList->fileName, MAX_FILENAME_LEN + 1U, 0, MAX_FILENAME_LEN + 1U);
    return;
}

void LogFileMgrInitClass(StSubLogFileList* list, LogConfClass *confClass)
{
    list->maxFileSize = confClass->outputRule.fileSize;
    list->totalMaxFileSize = confClass->outputRule.totalSize - confClass->outputRule.fileSize;
    list->storage.period = confClass->storageRule.storagePeriod;
    list->storage.maxFileNum = confClass->outputRule.fileNum;
    list->storage.curTime = 0;
    if ((LogStrlen(confClass->className) != 0) &&
        (snprintf_s(list->fileHead, MAX_NAME_HEAD_LEN + 1U, MAX_NAME_HEAD_LEN, "%s_", confClass->className) == -1)) {
        SELF_LOG_ERROR("get class name failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }
}