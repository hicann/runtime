/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sys/file.h>
#include "securec.h"
#include "log_path_mgr.h"
#include "log_print.h"

#define FILE_MASK_WC 0640
#define UNIT_THOUSAND 1000
#define LOG_PRINT_LOG_BUF_SZ            1024U
#define LOG_PRINT_LOG_TIME_STR_SIZE     128U
#define SLOGD_LOG_MAX_SIZE              (1U * 1024U * 1024U)
#define SLOGD_LOG_BUFFIX_LEN            7U

#define SYSLOG_ERR(format, ...)  do {                                               \
    LogPrintSys(LOG_ERR, "%s:%d: " format "\n", __FILE__, __LINE__, ##__VA_ARGS__); \
} while (0)

typedef struct {
    char *buff;
    size_t buffLen;
} Buffer;

/**
 * @brief GetLocalTimeForSelfLog: get local timestamp in string
 * @param [in]bufLen: length of timeBuffer
 * @param [in]timeBuffer: buffer to store timestamp
 */
STATIC void GetLocalTimeForSelfLog(size_t bufLen, char *timeBuffer)
{
    ToolTimeval currentTimeval = { 0 };
    struct tm timeInfo = { 0 };

    if (timeBuffer == NULL) {
        return;
    }

    if ((ToolGetTimeOfDay(&currentTimeval, NULL)) != SYS_OK) {
        return;
    }
    const time_t sec = currentTimeval.tvSec;
    if (ToolLocalTimeR(&sec, &timeInfo) != SYS_OK) {
        return;
    }

    int errT = snprintf_s(timeBuffer, bufLen, bufLen - 1U, "%04d-%02d-%02d %02d:%02d:%02d.%03ld",
                          timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday,
                          timeInfo.tm_hour, timeInfo.tm_min,
                          timeInfo.tm_sec, (currentTimeval.tvUsec / UNIT_THOUSAND));
    if (errT == -1) {
        return;
    }
}

STATIC int CatStr(const char *str1, size_t len1, const char *str2, size_t len2, Buffer *buffer)
{
    if ((str1 == NULL) || (str2 == NULL) || (buffer->buff == NULL) || ((len1 + len2) >= buffer->buffLen)) {
        return INVALID;
    }

    int ret = strcpy_s(buffer->buff, buffer->buffLen, str1);
    if (ret != EOK) {
        return INVALID;
    }
    // join two string
    ret = strcpy_s(buffer->buff + strlen(str1), buffer->buffLen - strlen(str1), str2);
    if (ret != EOK) {
        return INVALID;
    }
    return EOK;
}

/**
 * @brief SetRingFile: set self dfx log file ring. lock log file during log rotation
 * @param [in]slogdFile: slogd log file path
 */
STATIC void SetRingFile(const char *slogdFile)
{
    const char logFileBufFix[SLOGD_LOG_BUFFIX_LEN + 1U] = ".old";

    if (slogdFile == NULL) {
        return;
    }

    size_t len = strlen(slogdFile) + 1U;
    if (len <= 1U) {
        return;
    }
    char *newFileName = (char *)LogMalloc(len + SLOGD_LOG_BUFFIX_LEN);
    if (newFileName == NULL) {
        return;
    }

    Buffer buffer = { newFileName, len + SLOGD_LOG_BUFFIX_LEN };
    int32_t ret = CatStr(slogdFile, strlen(slogdFile), logFileBufFix,
                         strlen(logFileBufFix), &buffer);
    if (ret != EOK) {
        XFREE(newFileName);
        return;
    }

    int32_t lockFd = ToolOpenWithMode(LogGetSelfLockFile(), (uint32_t)O_CREAT | (uint32_t)O_RDWR, FILE_MASK_WC);
    if (lockFd < 0) {
        XFREE(newFileName);
        return;
    }
    // non-blocking lock. if failed to fetch lock, immediately exit func
    if (flock(lockFd, LOCK_EX | LOCK_NB) < 0) {
        LOG_CLOSE_FD(lockFd);
        XFREE(newFileName);
        return;
    }
    do {
        struct stat logStat = {0};
        ret = stat(LogGetSelfFile(), &logStat);
        if (ret < 0) {
            break;
        }
        // check log size to judge whether log file already rotated
        if ((logStat.st_size > 0) && ((uint64_t)logStat.st_size < (SLOGD_LOG_MAX_SIZE - LOG_PRINT_LOG_BUF_SZ))) {
            break;
        }
        (void)remove(newFileName);
        (void)ToolChmod(LogGetSelfOldFile(), (uint32_t)S_IRUSR | (uint32_t)S_IRGRP); // readonly, 440
        (void)rename(slogdFile, newFileName);
    } while (0);

    XFREE(newFileName);
    (void)flock(lockFd, LOCK_UN);
    LOG_CLOSE_FD(lockFd);
    (void)remove(LogGetSelfLockFile());
    return;
}

/**
 * @brief GetRingFd: get the logfile fd which to be written
 * @param [in]slogdFile: slogd log file path
 * @param [in]msg: log msg to be written
 * @return: success:fd, failed:INVALID(-1)
 */
STATIC int GetRingFd(const char *slogdFile, const char *msg)
{
    int getRenameFileFlag = 0;
    int fd = 0;
    int retryTime = 0;
    struct stat buf = { 0 };

    if ((slogdFile == NULL) || (msg == NULL)) {
        return INVALID;
    }

    do {
        fd = ToolOpenWithMode(slogdFile, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND, FILE_MASK_WC);
        if (fd < 0) {
            if ((retryTime == 0) && (CheckSelfLogPath() == SYS_OK)) {
                retryTime++;
                getRenameFileFlag = 1;
                continue;
            }
            break;
        }

        // get file slog.log Size
        if (fstat(fd, &buf) != 0) {
            SYSLOG_WARN("can not get file size, strerr=%s.\n", strerror(ToolGetErrorCode()));
            getRenameFileFlag = 0;
            LOG_CLOSE_FD(fd);
            continue;
        }
        unsigned int sum = (unsigned int)(buf.st_size) + (unsigned int)(strlen(msg));
        if ((sum > (unsigned int)buf.st_size) && (sum > (unsigned int)strlen(msg)) &&
            (sum >= (unsigned int)SLOGD_LOG_MAX_SIZE)) {
            LOG_CLOSE_FD(fd);
            SetRingFile(slogdFile);
            getRenameFileFlag = 1;
        } else {
            getRenameFileFlag = 0;
        }
    } while (getRenameFileFlag != 0);

    return fd;
}

STATIC int32_t LogOpenSelfFile(const char *msg)
{
    // to check it is a soft connection or not
    const char *file = LogGetSelfFile();
    struct stat buf = { 0 };

    if ((lstat(file, &buf) == 0) && (((uint32_t)S_IFMT & buf.st_mode) == S_IFLNK)) {
        return -1;
    }

    int32_t fd = GetRingFd(file, msg);
    if (fd < 0) {
        return -1;
    }
    return fd;
}

STATIC int32_t LogSetMessage(char *msg, uint32_t msgLen, const char *format, va_list arg)
{
    char timer[LOG_PRINT_LOG_TIME_STR_SIZE + 1U] = { 0 };
    GetLocalTimeForSelfLog(LOG_PRINT_LOG_TIME_STR_SIZE, timer);
    int32_t ret = strncpy_s(msg, msgLen, timer, strlen(timer));
    if (ret != EOK) {
        SYSLOG_ERR("strncpy_s time failed, result=%d, strerr=%s.\n", ret, strerror(ToolGetErrorCode()));
        return -1;
    }

    uint32_t len = LogStrlen(msg);
    return vsnprintf_truncated_s(msg + len, msgLen - len, format, arg);
}

void LogPrintSelf(const char *format, ...)
{
    if (format == NULL) {
        return;
    }
    va_list arg;
    va_start(arg, format);
    char msg[LOG_PRINT_LOG_BUF_SZ + 1U] = { 0 };
    int32_t used = LogSetMessage(msg, LOG_PRINT_LOG_BUF_SZ, format, arg);
    va_end(arg);
    if (used == -1) {
        return;
    }

    int32_t fd = LogOpenSelfFile(msg);
    if (fd < 0) {
        return;
    }
    (void)ToolWrite(fd, msg, (UINT32)strlen(msg));
    (void)ToolClose(fd);
}

