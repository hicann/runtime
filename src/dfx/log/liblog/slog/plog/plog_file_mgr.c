/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "plog_file_mgr.h"
#include "securec.h"
#include "log_print.h"
#include "log_platform.h"
#include "log_common.h"
#include "log_file_util.h"
#include "log_time.h"
#include "dlog_attr.h"
#include "mmpa_api.h"

#define DEFAULT_MAX_HOST_FILE_SIZE (20 * 1024 * 1024)
#define DEFAULT_MAX_HOST_FILE_NUM 10
#define PROC_DIR_NAME                        "plog"
#define PROC_HEAD                            "plog"

STATIC PlogFileMgrInfo *g_plogFileList = NULL;

STATIC bool PlogIsPathValidbyLog(const char *ppath, size_t pathLen)
{
    ONE_ACT_WARN_LOG(ppath == NULL, return false, "[input] file realpath is null.");
    bool isValid = false;
    const char* suffix = LOG_FILE_SUFFIX;

    ONE_ACT_NO_LOG(pathLen < strlen(suffix), return isValid);
    size_t len = pathLen - strlen(suffix);
    for (size_t j = len; j < pathLen; j++) {
        if (ppath[j] != suffix[j - len]) {
            break;
        }
        if (j == (pathLen - 1U)) {
            isValid = true;
            break;
        }
    }
    return isValid;
}

STATIC LogStatus PlogGetLocalTimeHelper(size_t bufLen, char *timeBuffer)
{
    if (timeBuffer == NULL) {
        SELF_LOG_WARN("[input] time buffer is null.");
        return LOG_FAILURE;
    }

    ToolTimeval currentTimeval = { 0 };
    if (ToolGetTimeOfDay(&currentTimeval, NULL) != SYS_OK) {
        SELF_LOG_ERROR("get time of day failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    const time_t sec = currentTimeval.tvSec;
    struct tm timeInfo = { 0 };
    if (ToolLocalTimeR((&sec), &timeInfo) != SYS_OK) {
        SELF_LOG_ERROR("get local time failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    long ms = currentTimeval.tvUsec / US_TO_MS_SIGNED;
    int32_t ret = snprintf_s(timeBuffer, bufLen, bufLen - 1U, "%04d%02d%02d%02d%02d%02d%03ld",
                             timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday, timeInfo.tm_hour,
                             timeInfo.tm_min, timeInfo.tm_sec, ms);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s time buffer failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

/**
* @brief : get new log file name with timestamp
* @param [in/out] pstSubInfo: strut to store new file name
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogCreateNewFileName(PlogFileList *pstSubInfo)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return LOG_FAILURE, "[input] log file list info is null.");

    if (pstSubInfo->currIndex >= pstSubInfo->maxFileNum) {
        SELF_LOG_WARN("current file number is illegal, file_bumber=%d, upper_limit=%d.",
                      pstSubInfo->currIndex, pstSubInfo->maxFileNum);
        return LOG_FAILURE;
    }

    int32_t frontIndex = (pstSubInfo->maxFileNum + pstSubInfo->currIndex - 1) % pstSubInfo->maxFileNum;
    const char *frontName = pstSubInfo->aucFileName[frontIndex];
    while (true) {
        char aucTime[TIME_STR_SIZE + 1] = { 0 };
        if (PlogGetLocalTimeHelper(TIME_STR_SIZE, aucTime) != LOG_SUCCESS) {
            return LOG_FAILURE;
        }

        const char* suffix = LOG_FILE_SUFFIX;
        int32_t err = snprintf_s(pstSubInfo->aucFileName[pstSubInfo->currIndex],
                                 MAX_FILENAME_LEN + 1U, MAX_FILENAME_LEN, "%s%s%s",
                                 pstSubInfo->aucFileHead, aucTime, suffix);
        if (err == -1) {
            SELF_LOG_ERROR("snprintf_s filename failed, result=%d, strerr=%s.", err, strerror(ToolGetErrorCode()));
            break;
        }

        char *currName = pstSubInfo->aucFileName[pstSubInfo->currIndex];
        if ((strncmp(frontName, currName, strlen(currName)) == 0) && (pstSubInfo->maxFileNum > 1)) {
            SELF_LOG_WARN("new log filename is repeat, filename=%s.", currName);
            (void)ToolSleep(1); // sleep 1ms
            continue;
        }
        break;
    }

    return LOG_SUCCESS;
}

/**
* @brief : remove log file with given filename
* @param [in] filename: file name which will be deleted
* @return: NA
*/
STATIC void PlogRemoveFile(const char *filename)
{
    int32_t ret = ToolChmod(filename, LOG_FILE_RDWR_MODE);
    // logFile may be deleted by user, then selflog will be ignored
    if ((ret != 0) && (ToolGetErrorCode() != ENOENT)) {
        SELF_LOG_WARN("can not chmod file, file=%s, strerr=%s.", filename, strerror(ToolGetErrorCode()));
    }

    ret = ToolUnlink(filename);
    if (ret == 0) {
        return;
    } else {
        // logFile may be deleted by user, then selflog will be ignored
        if (ToolGetErrorCode() != ENOENT) {
            SELF_LOG_WARN("can not unlink file, file=%s, strerr=%s.", filename, strerror(ToolGetErrorCode()));
        }
    }
    return;
}

/**
* @brief : remove current pointed log file
* @param [in] pstSubInfo: log file list
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogDeleteCurrentFile(const PlogFileList *pstSubInfo)
{
    if (pstSubInfo == NULL) {
        SELF_LOG_WARN("[input] log file list info is null.");
        return LOG_FAILURE;
    }

    if (pstSubInfo->currIndex >= pstSubInfo->maxFileNum) {
        SELF_LOG_WARN("current file number is illegal, file_number=%d, upper_limit=%d.",
                      pstSubInfo->currIndex, pstSubInfo->maxFileNum);
        return LOG_FAILURE;
    }

    char aucFileName[MAX_FULLPATH_LEN + 1U] = { 0 };
    int32_t ret = snprintf_s(aucFileName, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN,
                             "%s%s%s", pstSubInfo->aucFilePath, FILE_SEPARATOR,
                             pstSubInfo->aucFileName[pstSubInfo->currIndex]);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s filename failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    PlogRemoveFile(aucFileName);
    return LOG_SUCCESS;
}

/**
* @brief : concat log directory path with log filename
* @param [in] pstSubInfo: log file list
* @param [in] pFileName: filename with full path
* @param [in] ucMaxLen: max file path length
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogFilePathSplice(const PlogFileList *pstSubInfo, char *pFileName, size_t ucMaxLen)
{
    int32_t ret = snprintf_s(pFileName, ucMaxLen + 1U, ucMaxLen, "%s%s%s",
                             pstSubInfo->aucFilePath, FILE_SEPARATOR, pstSubInfo->aucFileName[pstSubInfo->currIndex]);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s filename failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief : sync buffer to disk
 * @param [in]logPath: log absolute path
 * @return : NA
 */
STATIC void PlogFsyncLogToDisk(const char *logPath)
{
    if (logPath == NULL) {
        return;
    }

    int32_t fd = ToolOpenWithMode(logPath, O_WRONLY | O_APPEND, LOG_FILE_RDWR_MODE);
    if (fd < 0) {
        SELF_LOG_ERROR("open file failed, file=%s.", logPath);
        return;
    }

    int32_t ret = ToolFsync(fd);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("fsync fail, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    }

    (void)ToolClose(fd);
}

/**
* @brief : get current writing files' size.
*          if file size exceed limitation, change file mode to read only
*          if specified file is removed, create new log file
* @param [in] logList: log file list
* @param [in] pstLogData: log data
* @param [in] pFileName: filename with full path
* @param [in] filesize: current log file size
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogGetFileOfSize(PlogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                                   const char *pFileName, off_t *filesize)
{
    ToolStat statbuff = { 0 };
    FILE *fp = NULL;

    char *ppath = (char *)LogMalloc(TOOL_MAX_PATH + 1);
    if (ppath == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // get file length
    if (ToolRealPath(pFileName, ppath, TOOL_MAX_PATH + 1) == SYS_OK) {
        size_t cfgPathLen = strlen(ppath);
        if (PlogIsPathValidbyLog(ppath, cfgPathLen) == false) {
            SELF_LOG_WARN("file realpath is invalid, file=%s, realpath=%s.", pFileName, ppath);
            XFREE(ppath);
            return LOG_FAILURE;
        }

        fp = fopen(ppath, "r");
        if (fp != NULL) {
            if (ToolStatGet(ppath, &statbuff) == SYS_OK) {
                *filesize = statbuff.st_size;
            }
        }
    } else {
        *filesize = 0;
        (void)PlogCreateNewFileName(pstSubInfo);
    }
    if (*filesize > ((off_t)(UINT_MAX) - (off_t)pstLogData->ulDataLen)) {
        LOG_CLOSE_FILE(fp);
        XFREE(ppath);
        return LOG_FAILURE;
    }
    if (((unsigned int)(*filesize) + pstLogData->ulDataLen) > pstSubInfo->maxFileSize) {
        if (fp != NULL) {
            PlogFsyncLogToDisk((const char *)ppath);
            (void)ToolChmod((const char *)ppath, LOG_FILE_ARCHIVE_MODE);
        }
    }
    LOG_CLOSE_FILE(fp);
    XFREE(ppath);
    return LOG_SUCCESS;
}

/**
* @brief : get current writing log file's full path(contains filename)
* @param [in] pstSubInfo: log file list
* @param [in] pstLogData: log data
* @param [in/out] pFileName: file name to be gotten. contains full file path
* @param [in] ucMaxLen: max length of full log file path(contains filename)
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogGetFileName(PlogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                                 char *pFileName, size_t ucMaxLen)
{
    off_t filesize = 0;
    char tmpFileName[MAX_FULLPATH_LEN + 1U] = { 0 };

    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return LOG_FAILURE, "[input] log file list is null.");
    ONE_ACT_WARN_LOG(pstLogData == NULL, return LOG_FAILURE, "[input] log data is null.");
    ONE_ACT_WARN_LOG(pFileName == NULL, return LOG_FAILURE, "[input] log filename pointer is null.");

    // create new one if not exists
    if (pstSubInfo->fileNum == 0) {
        pstSubInfo->currIndex = 0;
        pstSubInfo->fileNum = 1;
        // modify for compress switch, restart with new logfile.
        // When no log file exists,need to deal with "devWriteFileFlag", the same as follows.
        pstSubInfo->devWriteFileFlag = 1;
        (void)PlogCreateNewFileName(pstSubInfo);
        return PlogFilePathSplice(pstSubInfo, pFileName, ucMaxLen);
    }

    LogStatus ret = PlogFilePathSplice(pstSubInfo, pFileName, ucMaxLen);
    ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return LOG_FAILURE);
    pstSubInfo->devWriteFileFlag = 1;

    ret = PlogGetFileOfSize(pstSubInfo, pstLogData, pFileName, &filesize);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE,
                    "get file size failed, file=%s, result=%d.", pFileName, ret);

    // modify for compress switch, restart with new logfile
    if (((filesize + pstLogData->ulDataLen) > pstSubInfo->maxFileSize) || (pstSubInfo->devWriteFileFlag == 0)) {
        pstSubInfo->devWriteFileFlag = 1;
        pstSubInfo->currIndex++;
        if (pstSubInfo->currIndex != 0) {
            pstSubInfo->currIndex = pstSubInfo->currIndex % pstSubInfo->maxFileNum;
        }

        // if file num max, delete file current position
        if (pstSubInfo->fileNum == pstSubInfo->maxFileNum) {
            (void)PlogDeleteCurrentFile(pstSubInfo);
        }

        for (int32_t i = 0; i < pstSubInfo->fileNum; i++) {
            (void)memset_s(tmpFileName, sizeof(tmpFileName), 0x00, sizeof(tmpFileName));
            int32_t err = snprintf_s(tmpFileName, MAX_FULLPATH_LEN + 1U, ucMaxLen, "%s/%s",
                                     pstSubInfo->aucFilePath, pstSubInfo->aucFileName[i]);
            NO_ACT_ERR_LOG(err == -1, "snprintf_s filename failed, result=%d, strerr=%s.",
                           err, strerror(ToolGetErrorCode()));

            // logFile may be deleted by user, then selflog will be ignored
            err = ToolChmod((const char*)tmpFileName, LOG_FILE_ARCHIVE_MODE);
            NO_ACT_WARN_LOG((err != 0) && (ToolGetErrorCode() != ENOENT), "can not chmod file, file=%s, strerr=%s.",
                            tmpFileName, strerror(ToolGetErrorCode()));
        }
        pstSubInfo->fileNum = NUM_MIN((pstSubInfo->fileNum + 1), pstSubInfo->maxFileNum);
        (void)PlogCreateNewFileName(pstSubInfo);
    }

    return PlogFilePathSplice(pstSubInfo, pFileName, ucMaxLen);
}

STATIC LogStatus PlogChownPath(int32_t fd)
{
    int32_t ret = fchown(fd, DlogGetUid(), DlogGetGid());
    if (ret < 0) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
* @brief : write log without compression
* @param [in] pstSubInfo: log file list
* @param [in] pstLogData: log data to be written
* @param [in] aucFileName: filename with full path
* @param [in] aucFileNameLen: max file path length
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogWrite(PlogFileList *pstSubInfo, const StLogDataBlock *pstLogData,
                           char *const aucFileName, size_t aucFileNameLen)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return LOG_FAILURE, "[input] log file list is null.");
    ONE_ACT_WARN_LOG(pstLogData == NULL, return LOG_FAILURE, "[input] log data is null.");
    ONE_ACT_WARN_LOG(aucFileName == NULL, return LOG_FAILURE, "[input] log filename is null.");
    ONE_ACT_WARN_LOG(((aucFileNameLen == 0) || (aucFileNameLen > (MAX_FULLPATH_LEN + 1U))),
                     return LOG_FAILURE, "[input] log filename length is invalid, length=%zu", aucFileNameLen);

    const VOID *dataBuf = pstLogData->paucData;
    LogStatus ulRet = PlogGetFileName(pstSubInfo, pstLogData, aucFileName, MAX_FULLPATH_LEN);
    if (ulRet != LOG_SUCCESS) {
        SELF_LOG_ERROR("get filename failed, result=%d.", ulRet);
        return LOG_FAILURE;
    }
    int32_t fd = ToolOpenWithMode(aucFileName, O_CREAT | O_WRONLY | O_APPEND, LOG_FILE_RDWR_MODE);
    if (fd < 0) {
        SELF_LOG_ERROR("open file failed with mode, file=%s, strerr=%s.",
                       aucFileName, strerror(ToolGetErrorCode()));
        LOG_WARN_FPRINTF_ONCE("can not open file, file: %s, possible reason: %s.",
                              aucFileName, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    int32_t ret = ToolWrite(fd, dataBuf, pstLogData->ulDataLen);
    if ((ret < 0) || ((unsigned)ret != pstLogData->ulDataLen)) {
        LOG_CLOSE_FD(fd);
        SELF_LOG_ERROR("write to file failed, file=%s, data_length=%u bytes, write_length=%d bytes, strerr=%s.",
                       aucFileName, pstLogData->ulDataLen, ret, strerror(ToolGetErrorCode()));
        LOG_WARN_FPRINTF_ONCE("can not write log to file, file: %s, data_length: %u bytes, "
                              "write_length: %d bytes, possible reason: %s.",
                              aucFileName, pstLogData->ulDataLen, ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    ulRet = PlogChownPath(fd);
    if (ulRet != LOG_SUCCESS) {
        SELF_LOG_ERROR("change file owner failed, file=%s, log_err=%d, strerr=%s.",
                       aucFileName, ulRet, strerror(ToolGetErrorCode()));
    }
    LOG_CLOSE_FD(fd);
    return LOG_SUCCESS;
}

STATIC LogStatus PlogMkdir(const char *logPath)
{
    ONE_ACT_NO_LOG(logPath == NULL, return LOG_FAILURE);

    int32_t ret = ToolAccess((const char *)logPath);
    ONE_ACT_NO_LOG(ret == SYS_OK, return LOG_SUCCESS);
#if (OS_TYPE_DEF != WIN)
    LogRt err = LogMkdirRecur((const char *)g_plogFileList->rootPath);
#else
    LogRt err = LogMkdir((const char *)g_plogFileList->rootPath);
#endif
    if (err != SUCCESS) {
        SELF_LOG_ERROR("mkdir %s failed, strerr=%s, log_err=%d.",
                       g_plogFileList->rootPath, strerror(ToolGetErrorCode()), (int32_t)err);
        LOG_WARN_FPRINTF_ONCE("can not create directory, directory: %s, possible reason: %s.",
                              g_plogFileList->rootPath, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    // create log path
    // judge if sub-logdir is exist(for debug/run/security), if not, create one
    char sortPath[MAX_FILEDIR_LEN + 1U] = { 0 };
    const char *sortDirName[(int32_t)LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME };
    for (int32_t idx = (int32_t)DEBUG_LOG; idx < (int32_t)LOG_TYPE_NUM; idx++) {
        (void)memset_s(sortPath, MAX_FILEDIR_LEN + 1U, 0, MAX_FILEDIR_LEN + 1U);
        ret = snprintf_s(sortPath, MAX_FILEDIR_LEN + 1U, MAX_FILEDIR_LEN,
                         "%s/%s", g_plogFileList->rootPath, sortDirName[idx]);
        ONE_ACT_ERR_LOG(ret == -1, return LOG_FAILURE, "snprintf_s failed, err=%s.", strerror(ToolGetErrorCode()));
        err = LogMkdir((const char *)sortPath);
        if (err != SUCCESS) {
            SELF_LOG_ERROR("mkdir %s failed, strerr=%s, log_err=%d.",
                           sortPath, strerror(ToolGetErrorCode()), (int32_t)err);
            return LOG_FAILURE;
        }
    }

    err = LogMkdir(logPath);
    if (err != SUCCESS) {
        SELF_LOG_ERROR("mkdir %s failed, strerr=%s, log_err=%d.", logPath, strerror(ToolGetErrorCode()), (int32_t)err);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
* @brief : write log to file in zip or not zipped format
* @param [in] subList: log file list
* @param [in] logData: log data
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogWriteFile(PlogFileList *subList, StLogDataBlock *logData)
{
    ONE_ACT_NO_LOG(subList == NULL, return LOG_FAILURE);
    ONE_ACT_NO_LOG((logData == NULL) || (logData->paucData == NULL) || (logData->ulDataLen == 0), return LOG_SUCCESS);

    // judge if sub-logdir is exist(for debug), if not, create one
    if (PlogMkdir(subList->aucFilePath) == LOG_FAILURE) {
        return LOG_FAILURE;
    }

    char logFileName[MAX_FULLPATH_LEN + 1U] = { 0 };
    LogStatus ret = PlogWrite(subList, logData, logFileName, sizeof(logFileName));

    // change file mode if it was masked by umask
    if (ToolChmod((const char *)logFileName, (INT32)LOG_FILE_RDWR_MODE) != SYS_OK) {
        SELF_LOG_ERROR("change log file mode failed, file=%s.", logFileName);
    }
    return ret;
}

LogStatus PlogWriteHostLog(int32_t logType, char *msg, uint32_t len)
{
    ONE_ACT_WARN_LOG(msg == NULL, return LOG_FAILURE, "[input] device log buff is null.");
    ONE_ACT_WARN_LOG(len == 0, return LOG_FAILURE, "[input] device log buff size is 0.");
    ONE_ACT_WARN_LOG((logType < (int32_t)DEBUG_LOG) || (logType >= (int32_t)LOG_TYPE_NUM),
                     return LOG_FAILURE, "[input] wrong log type %d", logType);
    ONE_ACT_WARN_LOG(g_plogFileList == NULL, return LOG_FAILURE, "[input] plog file list is null.");

    StLogDataBlock stLogData = { 0 };
    stLogData.ucDeviceID = 0;
    stLogData.ulDataLen = len;
    stLogData.paucData = msg;
    return PlogWriteFile(&(g_plogFileList->hostLogList[logType]), &stLogData);
}

LogStatus PlogWriteDeviceLog(char *msg, const PlogDeviceLogInfo *info)
{
    ONE_ACT_WARN_LOG(msg == NULL, return LOG_FAILURE, "[input] log message is null.");
    ONE_ACT_WARN_LOG(info == NULL, return LOG_FAILURE, "[input] info is null.");
    ONE_ACT_WARN_LOG(g_plogFileList == NULL, return LOG_FAILURE, "[input] plog file list is null.");

    if ((info->deviceId > g_plogFileList->deviceNum) || (info->slogFlag == 1)) {
        SELF_LOG_WARN("[input] wrong device_id=%u, device_number=%u or slogFlag=%d.",
                      info->deviceId, info->deviceId, info->slogFlag);
        return LOG_FAILURE;
    }
    LogType logType = info->logType;
    if (logType >= LOG_TYPE_NUM) {
        logType = DEBUG_LOG;
    }

    int32_t num = (int32_t)logType;
    if (g_plogFileList->deviceLogList[num] == NULL) {
        SELF_LOG_WARN("[input] device log file list is null.");
        return LOG_FAILURE;
    }

    uint32_t deviceId = info->deviceId;
    StLogDataBlock stLogData = { 0 };
    stLogData.ucDeviceID = deviceId;
    stLogData.ulDataLen = info->len;
    stLogData.paucData = msg;
    return PlogWriteFile(&(g_plogFileList->deviceLogList[num][deviceId]), &stLogData);
}

/**
* @brief : free log file resources
* @param [in] logList: log file list
* @return: NA
*/
STATIC void PlogFreeFileNumArray(PlogFileList *pstSubInfo)
{
    if ((pstSubInfo == NULL) || (pstSubInfo->aucFileName == NULL)) {
        return;
    }

    for (int32_t idx = 0; idx < pstSubInfo->maxFileNum; idx++) {
        XFREE(pstSubInfo->aucFileName[idx]);
    }
    XFREE(pstSubInfo->aucFileName);
}

/**
* @brief : initialize struct for log file path and log name list
* @param [in] pstSubInfo: log file list
* @param [in] logPath: log sub directory path
* @param [in] length: logPath length
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogInitFileNumArray(PlogFileList *pstSubInfo)
{
    ONE_ACT_WARN_LOG(pstSubInfo == NULL, return LOG_FAILURE, "[input] log file list info is null.");

    size_t len = ((uint32_t)(pstSubInfo->maxFileNum)) * sizeof(char *);
    pstSubInfo->aucFileName = (char **)LogMalloc(len);
    if (pstSubInfo->aucFileName == NULL) {
        SELF_LOG_ERROR("malloc filename array failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    for (int32_t idx = 0; idx < pstSubInfo->maxFileNum; idx++) {
        pstSubInfo->aucFileName[idx] = (char *)LogMalloc(MAX_FILENAME_LEN + 1U);
        if (pstSubInfo->aucFileName[idx] == NULL) {
            SELF_LOG_ERROR("malloc filename failed, strerr=%s.", strerror(ToolGetErrorCode()));
            // don't need to free pstSubInfo->aucFileName
            PlogFreeFileNumArray(pstSubInfo);
            return LOG_FAILURE;
        }
    }
    return LOG_SUCCESS;
}

/**
* @brief : get plog or device app log send back to host by env(EP MODE)
* @return: plog or device app log file num
*/
STATIC int32_t PlogGetHostFileNum(void)
{
    int32_t ret = DEFAULT_MAX_HOST_FILE_NUM;
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_HOST_LOG_FILE_NUM, (env));
    if (env != NULL) {
        int64_t tmpL = -1;
        if ((LogStrToInt(env, &tmpL) == LOG_SUCCESS) && (tmpL >= MIN_FILE_NUM) && (tmpL <= MAX_FILE_NUM)) {
            ret = (int32_t)tmpL;
        }
    }
    SELF_LOG_INFO("host log file num = %d.", ret);
    return ret;
}

STATIC INLINE LogStatus PlogInitDeviceLogFileHead(char *fileHead, uint32_t length, uint32_t pid)
{
    int32_t err = snprintf_s(fileHead, length, length - 1U, "%s%u_", DEVICE_HEAD, pid);
    if (err == -1) {
        SELF_LOG_ERROR("get device header failed, result=%d, strerr=%s.",
                       err, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC INLINE LogStatus PlogInitDeviceLogFilePath(char *filePath, uint32_t length,
                                                  const char *rootPath, const char *sortName, uint32_t deviceId)
{
    int32_t err = snprintf_s(filePath, length, (size_t)length - 1U, "%s%s%s%s%s%u",
                             rootPath, FILE_SEPARATOR, sortName, FILE_SEPARATOR, DEVICE_HEAD, deviceId);
    if (err == -1) {
        SELF_LOG_ERROR("get device log dir path failed, device_id=%u, result=%d, strerr=%s.",
                       deviceId, err, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC LogStatus PlogInitDeviceMaxFileNum(PlogFileMgrInfo *logList)
{
    const char *sortDirName[(int32_t)LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME };
    int32_t maxFileNum = PlogGetHostFileNum();
    for (uint32_t iType = 0; iType < (uint32_t)LOG_TYPE_NUM; iType++) {
        for (uint32_t idx = 0; idx < logList->deviceNum; idx++) {
            PlogFileList* list = &(logList->deviceLogList[iType][idx]);
            ONE_ACT_WARN_LOG(list == NULL, return LOG_FAILURE, "[input] list is null.");
            (void)memset_s(list, sizeof(PlogFileList), 0, sizeof(PlogFileList));

            list->fileNum = 0;
            list->currIndex = 0;
            list->maxFileNum = maxFileNum;
            list->maxFileSize = DEFAULT_MAX_HOST_FILE_SIZE;
            list->pid = (uint32_t)ToolGetPid();

            LogStatus ret = PlogInitDeviceLogFileHead(list->aucFileHead, MAX_NAME_HEAD_LEN + 1U, list->pid);
            ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE,
                            "init sort[%u] device[%u] file head failed, result=%d.", iType, idx, ret);

            ret = PlogInitDeviceLogFilePath(list->aucFilePath, MAX_FILEPATH_LEN + 1U,
                                            logList->rootPath, sortDirName[iType], idx);
            ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE,
                            "init sort[%u] device[%u] file path failed, result=%d.", iType, idx, ret);

            ret = PlogInitFileNumArray(list);
            ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE,
                            "init max device filename list failed, result=%d.", ret);
        }
    }
    return LOG_SUCCESS;
}

STATIC LogStatus PlogInitDevice(PlogFileMgrInfo *logList)
{
    logList->deviceNum = MAX_DEV_NUM;

    for (uint32_t iType = 0; iType < (uint32_t)LOG_TYPE_NUM; iType++) {
        // multi devices init
        logList->deviceLogList[iType] = (PlogFileList *)LogMalloc(sizeof(PlogFileList) * logList->deviceNum);
        if (logList->deviceLogList[iType] == NULL) {
            SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
    }
    // init log file list
    if (PlogInitDeviceMaxFileNum(logList) != LOG_SUCCESS) {
        SELF_LOG_ERROR("init device file list failed.");
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

STATIC void PlogFreeDevice(PlogFileMgrInfo *logList)
{
    for (uint32_t iType = 0; iType < (uint32_t)LOG_TYPE_NUM; iType++) {
        if (logList->deviceLogList[iType] == NULL) {
            continue;
        }
        for (uint32_t idx = 0; idx < logList->deviceNum; idx++) {
            PlogFreeFileNumArray(&(logList->deviceLogList[iType][idx]));
        }
        XFREE(logList->deviceLogList[iType]);
    }
}

STATIC INLINE LogStatus PlogInitHostLogFileHead(char *fileHead, uint32_t length, uint32_t pid)
{
    int32_t err = snprintf_s(fileHead, length, length - 1U, "%s-%u_", PROC_HEAD, pid);
    if (err == -1) {
        SELF_LOG_ERROR("get proc header failed, result=%d, strerr=%s.",
                       err, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC INLINE LogStatus PlogInitHostLogFilePath(char *filePath, uint32_t length,
                                                const char *rootPath, const char *sortName)
{
    int32_t err = snprintf_s(filePath, length, (size_t)length - 1U, "%s%s%s%s%s",
                             rootPath, FILE_SEPARATOR, sortName, FILE_SEPARATOR, PROC_DIR_NAME);
    if (err == -1) {
        SELF_LOG_ERROR("get log dir path failed, result=%d, strerr=%s.",
                       err, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC LogStatus PlogInitHostLogList(PlogFileMgrInfo *logList)
{
    const char* sortDirName[(int32_t)LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME};
    int32_t maxFileNum = PlogGetHostFileNum();
    for (int32_t i = (int32_t)DEBUG_LOG; i < (int32_t)LOG_TYPE_NUM; i++) {
        PlogFileList* list = &(logList->hostLogList[i]);
        ONE_ACT_WARN_LOG(list == NULL, return LOG_FAILURE, "[input] list is null.");
        (void)memset_s(list, sizeof(PlogFileList), 0, sizeof(PlogFileList));

        list->fileNum = 0;
        list->currIndex = 0;
        list->maxFileNum = maxFileNum;
        list->maxFileSize = DEFAULT_MAX_HOST_FILE_SIZE;
        list->pid = (uint32_t)ToolGetPid();

        LogStatus ret = PlogInitHostLogFileHead(list->aucFileHead, MAX_NAME_HEAD_LEN + 1U, list->pid);
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE,
                        "init sort[%d] host file head failed, result=%d.", i, ret);

        ret = PlogInitHostLogFilePath(list->aucFilePath, MAX_FILEPATH_LEN + 1U, logList->rootPath, sortDirName[i]);
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE,
                        "init sort[%d] host file path failed, result=%d.", i, ret);

        ret = PlogInitFileNumArray(list);
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init max filename list failed, result=%d.", ret);
    }

    return LOG_SUCCESS;
}

STATIC LogStatus PlogInitHost(PlogFileMgrInfo *logList)
{
    // init log file list
    if (PlogInitHostLogList(logList) != LOG_SUCCESS) {
        SELF_LOG_ERROR("init max filename list failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC void PlogFreeHost(PlogFileMgrInfo *logList)
{
    for (int32_t i = (int32_t)DEBUG_LOG; i < (int32_t)LOG_TYPE_NUM; i++) {
        PlogFreeFileNumArray(&(logList->hostLogList[i]));
    }
}

/**
 * @brief       : get string of env
 * @param[out]  : buf       buffer to save string
 * @param[in]   : len       buffer length
 * @param[in]   : env       environment value obtained from the environment variable
 * @return      : LOG_SUCCESS: success; LOG_FAILURE: fail
 */
STATIC LogStatus PlogGetEnvString(char *buf, uint32_t len, const char* env)
{
    if (buf == NULL) {
         return LOG_FAILURE;
    }
    (void)memset_s(buf, len, 0, len);
    if ((env == NULL) || (strlen(env) == 0U) || (strlen(env) >= (size_t)len)) {
        return LOG_FAILURE;
    }

    char *path = (char *)LogMalloc(TOOL_MAX_PATH);
    ONE_ACT_ERR_LOG(path == NULL, return LOG_FAILURE, "malloc failed, strerror = %s.", strerror(ToolGetErrorCode()));

    errno_t err = strcpy_s(path, TOOL_MAX_PATH, env);
    TWO_ACT_ERR_LOG(err != EOK, XFREE(path), return LOG_FAILURE, "strcpy env string failed, ret=%d, strerr=%s.",
                    (int32_t)err, strerror(ToolGetErrorCode()));

    int32_t ret = GetValidPath(path, TOOL_MAX_PATH, buf, (int32_t)len);
    XFREE(path);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("get valid path failed, ret = %d.", ret);
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

/**
 * @brief       : get process log path by env
 * @param [out] : path         pointer to save plog path
 * @return      : LOG_SUCCESS: succeed; LOG_FAILURE: failed
 */
STATIC LogStatus PlogGetEnvPath(char *path)
{
    char *envPath = (char *)LogMalloc(TOOL_MAX_PATH);
    if (envPath == NULL) {
        return LOG_FAILURE;
    }

    const char *envStr = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_PROCESS_LOG_PATH, (envStr));
    LogStatus err = PlogGetEnvString(envPath, TOOL_MAX_PATH, envStr);
    if (err != LOG_SUCCESS) {
        MM_SYS_GET_ENV(MM_ENV_ASCEND_WORK_PATH, (envStr));
        err = PlogGetEnvString(envPath, TOOL_MAX_PATH, envStr);
        TWO_ACT_NO_LOG(err != LOG_SUCCESS, XFREE(envPath), return LOG_FAILURE);
        char subPath[] = "/log/";
        err = strncat_s(envPath, TOOL_MAX_PATH, subPath, strlen(subPath));
        TWO_ACT_NO_LOG(err != EOK, XFREE(envPath), return LOG_FAILURE);
    }
    int32_t ret = snprintf_truncated_s(path, MAX_FILEDIR_LEN + 1U, "%s", envPath);
    XFREE(envPath);
    ONE_ACT_ERR_LOG(ret < 0, return LOG_FAILURE, "get path failed, ret=%d.", ret);
    SELF_LOG_INFO("get env success, host log file path: %s", path);
    return LOG_SUCCESS;
}

/**
* @brief : get root log directory from config list
* @param [in] logList: log file list
* @return: LOG_SUCCESS: succeed; LOG_FAILURE: failed
*/
STATIC LogStatus PlogInitRootPath(PlogFileMgrInfo *logList)
{
    // get process log path
    char *homeDir = (char *)LogMalloc((size_t)(TOOL_MAX_PATH + 1));
    ONE_ACT_ERR_LOG(homeDir == NULL, return LOG_FAILURE, "calloc failed, strerr=%s", strerror(ToolGetErrorCode()));

    int32_t ret = LogGetHomeDir(homeDir, TOOL_MAX_PATH);
    TWO_ACT_ERR_LOG(ret != 0, XFREE(homeDir), return LOG_FAILURE, "get home directory failed, ret=%d.", ret);

    LogStatus err = PlogGetEnvPath(logList->rootPath);
    if (err != LOG_SUCCESS) {
        ret = snprintf_truncated_s(logList->rootPath, MAX_FILEDIR_LEN + 1U, "%s%s%s",
                                   homeDir, FILE_SEPARATOR, PROCESS_SUB_LOG_PATH);
        TWO_ACT_ERR_LOG(ret < 0, XFREE(homeDir), return LOG_FAILURE, "get home directory failed, ret=%d.", ret);
        SELF_LOG_INFO("use default host log file path: %s", logList->rootPath);
    }

    XFREE(homeDir);
    return LOG_SUCCESS;
}

LogStatus PlogFileMgrInit(void)
{
    // init g_plogFileList
    g_plogFileList = (PlogFileMgrInfo *)LogMalloc(sizeof(PlogFileMgrInfo));
    ONE_ACT_ERR_LOG(g_plogFileList == NULL, return LOG_FAILURE, "init file list failed.");
    // read configure file
    LogStatus ret = PlogInitRootPath(g_plogFileList);
    TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, XFREE(g_plogFileList), return LOG_FAILURE,
                    "init file root path failed, ret=%d.", ret);

    // init process log file list
    ret = PlogInitHost(g_plogFileList);
    if (ret != LOG_SUCCESS) {
        PlogFreeHost(g_plogFileList);
        XFREE(g_plogFileList);
        SELF_LOG_ERROR("init host file list failed, ret=%d.", ret);
        return LOG_FAILURE;
    }

    // init device log file list
    ret = PlogInitDevice(g_plogFileList);
    if (ret != LOG_SUCCESS) {
        PlogFreeHost(g_plogFileList);
        PlogFreeDevice(g_plogFileList);
        XFREE(g_plogFileList);
        SELF_LOG_ERROR("init dev file list failed, ret=%d.", ret);
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

void PlogFileMgrExit(void)
{
    ONE_ACT_WARN_LOG(g_plogFileList == NULL, return, "file list is null.");
    PlogFreeHost(g_plogFileList);
    PlogFreeDevice(g_plogFileList);
    XFREE(g_plogFileList);
}

