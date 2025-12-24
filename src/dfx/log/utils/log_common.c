/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void *LogMalloc(size_t size)
{
    if (size == 0) {
        return NULL;
    }

    void *buffer = malloc(size);
    if (buffer == NULL) {
        return NULL;
    }

    int32_t ret = memset_s(buffer, size, 0, size);
    if (ret != EOK) {
        free(buffer);
        return NULL;
    }
    return buffer;
}

void LogFree(void *buffer)
{
    if (buffer != NULL) {
        free(buffer);
    }
}

uint32_t LogStrlen(const char *str)
{
    size_t len = strlen(str);
    if (len > UINT32_MAX) {
        return UINT32_MAX;
    }
    return (uint32_t)len;
}

/**
 * @brief       : convert a string to an integer
 * @param[in]   : str       : string to be changed
 * @param[out]  : num       : dest number
 * @return      : SYS_OK: success; SYS_ERROR: fail
 */
LogStatus LogStrToInt(const char *str, int64_t *num)
{
    if ((str == NULL) || (num == NULL)) {
        return LOG_FAILURE;
    }

    errno = 0;
    char *endPtr = NULL;
    const int32_t numberBase = 10;
    *num = strtol(str, &endPtr, numberBase);
    if ((str == endPtr) || (*endPtr != '\0')) {
        return LOG_FAILURE;
    } else if (((*num == LONG_MIN) || (*num == LONG_MAX)) && (errno == ERANGE)) {
        return LOG_FAILURE;
    } else {
        return LOG_SUCCESS;
    }
}

LogStatus LogStrToUint(const char *str, uint32_t *num)
{
    if ((str == NULL) || (num == NULL)) {
        return LOG_FAILURE;
    }
    char *endPtr = NULL;
    errno = 0;
    const int32_t numberBase = 10;
    uint64_t ret = strtoul(str, &endPtr, numberBase);
    if ((str == endPtr) || (*endPtr != '\0')) {
        return LOG_FAILURE;
    } else if (((ret == 0U) || (ret == ULONG_MAX)) && (errno == ERANGE)) {
        return LOG_FAILURE;
    } else if (ret > UINT_MAX) {
        return LOG_FAILURE;
    } else {
        *num = (uint32_t)ret;
        return LOG_SUCCESS;
    }
}

LogStatus LogStrToUlong(const char *str, uint64_t *num)
{
    if ((str == NULL) || (num == NULL) || (str[0] == '-')) {
        return LOG_FAILURE;
    }
    char *endPtr = NULL;
    errno = 0;
    const int32_t numberBase = 10;
    uint64_t ret = strtoull(str, &endPtr, numberBase);
    int32_t error = LOG_SUCCESS;
    if ((str == endPtr) || (*endPtr != '\0')) {
        error = LOG_FAILURE;
    } else if (((ret == 0U) || (ret == ULLONG_MAX)) && (errno == ERANGE)) {
        error = LOG_FAILURE;
    } else {
        *num = ret;
    }
    return error;
}

// the str should not over INT_MAX, otherwise return false
bool LogStrCheckNaturalNum(const char *str)
{
    if ((str == NULL) || (*str == '\0')) {
        return false;
    }
    const char *tmpStr = str;
    if (*tmpStr == '0') {
        tmpStr++;
        return *tmpStr == '\0';
    }

    int64_t totalNum = 0;
    while (*tmpStr != '\0') {
        if ((*tmpStr > '9') || (*tmpStr < '0')) {
            return false;
        }

        // to check if str is over INT_MAX(2147483647)
        totalNum = (totalNum * 10) + (*tmpStr - '0');   // base num is 10
        if (totalNum > INT_MAX) {
            return false;
        }
        tmpStr++;
    }

    return true;
}

/**
 * @brief       : judge whether a character needs to be trimmed
 * @param [in]  : curChar       character need to judge
 * @return      : true  trim; false  non-trim
 */
STATIC INLINE bool LogIsTrimmedChar(char curChar)
{
    return ((curChar == ' ') || (curChar == '\t') || (curChar == '\n') || (curChar == '/')) ? true : false;
}

/**
 * @brief       : trim end of string by specific char
 * @param [out] : str          string need to trim
 */
void LogStrTrimEnd(char *str, int32_t len)
{
    if ((str == NULL) || (strlen(str) == 0U)) {
        return;
    }
    size_t end = strlen(str) - 1U;
    if ((int32_t)end >= len) {
        return;
    }
    // trim space '\t' '\n' '/'
    while ((end > 0) && LogIsTrimmedChar(str[end])) {
        str[end] = '\0';
        end--;
    }
}

bool LogStrStartsWith(const char *str, const char *pattern)
{
    if ((str == NULL) || (pattern == NULL)) {
        return false;
    }
    if (strncmp(str, pattern, strlen(pattern)) == 0) {
        return true;
    }
    return false;
}

/**
 * @brief : strcat filename to directory
 * @param [out]path: the full path
 * @param [in]filename: pointer to store file name
 * @param [in]dir:pointer to store dir
 * @param [in]maxlen:the maxlength of out path
 * @return:succeed: SYS_OK, failed:SYS_ERROR
 */
int32_t StrcatDir(char *path, const char *filename, const char *dir, uint32_t maxlen)
{
    if ((dir == NULL) || (filename == NULL) || (path == NULL)) {
        return SYS_ERROR;
    }
    uint32_t dirLen = LogStrlen(dir);
    uint32_t fileLen = LogStrlen(filename);
    if ((UINT32_MAX - dirLen) < fileLen) {
        return SYS_ERROR;
    }
    uint32_t len = dirLen + fileLen;
    if (len > maxlen) {
        return SYS_ERROR;
    }

    int32_t ret = strcpy_s(path, maxlen, dir);
    if (ret != EOK) {
        // 复制失败之后，将路径清空，防止继续对错误的路径进行操作
        (void)memset_s(path, (size_t)maxlen, 0, (size_t)maxlen);
        return SYS_ERROR;
    }
    ret = strcat_s(path, maxlen, filename);
    if (ret != EOK) {
        // 拼接失败之后，将路径清空，防止继续对错误的路径进行操作
        (void)memset_s(path, (size_t)maxlen, 0, (size_t)maxlen);
        return SYS_ERROR;
    }
    return SYS_OK;
}

#ifdef __cplusplus
}
#endif // __cplusplus

