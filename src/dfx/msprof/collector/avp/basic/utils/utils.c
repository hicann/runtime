/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "utils.h"
#include <errno.h>
#include "securec.h"
#include "inttypes.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "osal/osal_mem.h"
#include "time.h"

void *MsprofRealloc(void *ptr, size_t oldSize, size_t newSize)
{
    if (oldSize == 0 || newSize == 0) {
        MSPROF_LOGE("Invalid ralloc oldSize %zu or newSize %zu", oldSize, newSize);
        return NULL;
    }
    void *newPtr = OsalMalloc(newSize);
    if (newPtr == NULL) {
        OsalFree(ptr);
        MSPROF_LOGE("ralloc failed, newSize=%zu.", newSize);
        return NULL;
    }

    int32_t ret = memcpy_s(newPtr, newSize, ptr, oldSize);
    OsalFree(ptr);
    if (ret != EOK) {
        OsalFree(newPtr);
        MSPROF_LOGE("memcpy_s from realloc failed, newSize=%zu.", newSize);
        return NULL;
    }

    return newPtr;
}

#ifndef LITE_OS
bool GetCwdString(const CHAR* path, CHAR* resultDir, size_t len)
{
    static char val[CWD_VAL_MAX_LEN];
    (void)memset_s(val, CWD_VAL_MAX_LEN, 0, CWD_VAL_MAX_LEN);
    int32_t ret = OsalGetCwd(val, CWD_VAL_MAX_LEN - 1);
    if (ret == OSAL_EN_OK) {
        ret = sprintf_s(resultDir, len, "%s/%s", val, path);
        if (ret < 0) {
            MSPROF_LOGE("sprintf fail for dir %s.", path);
            return false;
        }
    }
    return true;
}

bool RelativePathToAbsolutePath(const CHAR* path, CHAR* resultDir, size_t len)
{
    bool boolStatus = true;
    if (path == NULL || resultDir == NULL || strlen(path) == 0) {
        MSPROF_LOGE("Path or result path %s is empty", path);
        return false;
    }
    if (path[0] != '/') {
        boolStatus = GetCwdString(path, resultDir, len);
    } else {
        int32_t ret = strcpy_s(resultDir, len, path);
        PROF_CHK_EXPR_ACTION(ret != EOK, return false, "sprintf fail for dir %s.", path);
    }
    return boolStatus;
}

bool IsDir(const CHAR* path)
{
    if (strlen(path) == 0) {
        return false;
    }

    if (OsalIsDir(path) != OSAL_EN_OK) {
        return false;
    }

    return true;
}

bool IsDirAccessible(const CHAR* path)
{
    if (!IsDir(path)) {
        MSPROF_LOGW("Path %s is not a dir", path);
        return false;
    }
    if (OsalAccess2(path, OSAL_W_OK) == OSAL_EN_OK) {
        return true;
    }
    MSPROF_LOGW("No access to dir %s", path);
    return false;
}

bool IsFileExist(const CHAR* path)
{
    if (strlen(path) == 0) {
        return false;
    }

    if (OsalAccess(path) == OSAL_EN_OK) {
        return true;
    }

    return false;
}
#endif

#define SELF_PATH_LEN 24U
bool GetSelfPath(CHAR* resultDir)
{
#ifdef LITE_OS
    UNUSED(resultDir);
#else
    char selfPath[SELF_PATH_LEN];
    errno_t ret = EOK;
    ret = strcpy_s(selfPath, sizeof(selfPath), "/proc/self/exe");
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "SelfPath strcpy failed.");
    int32_t len = (int32_t)(readlink(selfPath, resultDir, OSAL_MAX_PATH));
    MSPROF_LOGI("Get self bin directory len: %d", len);
    if (len < 0) {
        ret = strcpy_s(selfPath, sizeof(selfPath), "/local/proc/self/exe");
        PROF_CHK_EXPR_ACTION(ret != EOK, return false, "Local selfPath strcpy failed.");
        len = (int32_t)(readlink(selfPath, resultDir, OSAL_MAX_PATH));
    }
    MSPROF_LOGI("Get proc self bin directory len: %d", len);
    if (len < 0 || len > OSAL_MAX_PATH) {
        MSPROF_LOGW("Can't Get self bin directory");
        return false;
    }
#endif
    return true;
}

/**
 * @brief      Enter the desired path. This method will recursively create the path.
 * @param [in] resultPath: output path, which is to be created.
 * @return     success: true
 *             failed : false
 */
bool CreateDirectory(CHAR* resultPath)
{
#ifdef LITE_OS
    UNUSED(resultPath);
    return true;
#else
    PROF_CHK_EXPR_ACTION(resultPath == NULL, return false, "Input data resultPath is NULL.");
    if (strlen(resultPath) == 0) {
        MSPROF_LOGW("Input path is empty.");
        return false;
    }

    char tmp[DEFAULT_OUTPUT_MAX_LEGTH] = { 0 };
    errno_t ret = strcat_s(tmp, sizeof(tmp), resultPath);
    PROF_CHK_EXPR_ACTION(ret != EOK, return false,
        "Failed to strcat_s for dir: %s, ret: %d.", resultPath, ret);

    char path[DEFAULT_OUTPUT_MAX_LEGTH] = { 0 };
    char *context = NULL;
    const char *delim = "/";
    char *token = Strtok(tmp, delim, &context);
    PROF_CHK_EXPR_ACTION(errno == ERANGE, return false,
        "The errno is out of the range that can be represented after strtok.");
    while (token != NULL) {
        ret = strcat_s(path, sizeof(path), delim);
        PROF_CHK_EXPR_ACTION(ret != EOK, return false,
            "Failed to strcat_s '/' to dir: %s, ret is %d.", resultPath, ret);

        ret = strcat_s(path, sizeof(path), token);
        PROF_CHK_EXPR_ACTION(ret != EOK, return false,
            "Failed to strcat_s token to dir: %s, ret is %d.", resultPath, ret);

        token = Strtok(NULL, delim, &context);
        PROF_CHK_EXPR_ACTION(errno == ERANGE, return false,
            "The errno is out of the range that can be represented in recycling.");
        if (IsFileExist(path)) {
            MSPROF_LOGD("The file already exists, %s", path);
            continue;
        }
        const OsalMode defaultFileMode = (OsalMode)0750;  // 0750 means xwrx-r
        if ((OsalMkdir(path, defaultFileMode) != OSAL_EN_OK) && (errno != EEXIST)) {
            char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
            MSPROF_LOGE("Failed to mkdir, FilePath : %s, FileMode : %o, ErrorCode : %d, ERRORInfo : %s",
                path, (int32_t)defaultFileMode, OsalGetErrorCode(),
                OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
            return false;
        }
    }
    return true;
#endif
}

bool CheckIsUIntNum(const CHAR* numberStr)
{
    char maxUintValStr[] = "4294967295";
    return CheckStringNumRange(numberStr, maxUintValStr);
}

bool CheckStringNumRange(const CHAR* numberStr, const CHAR* target)
{
    if (strlen(numberStr) == 0) {
        return false;
    }

    if (strlen(numberStr) > strlen(target)) {
        MSPROF_LOGE("[CheckStringNumRange] numberStr(%s) is too long than (%s)", numberStr, target);
        return false;
    }

    for (uint32_t j = 0; j < strlen(numberStr); ++j) {
        if (numberStr[j] < '0' || numberStr[j] > '9') {
            MSPROF_LOGE("[CheckStringNumRange] numberStr(%s) is not a positive integer", numberStr);
            return false;
        }
    }

    if (strlen(numberStr) == strlen(target)) {
        for (uint32_t i = 0; i < strlen(numberStr); ++i) {
            if (numberStr[i] > target[i]) {
                MSPROF_LOGE("[CheckStringNumRange] numberStr(%s) is over than %s", numberStr, target);
                return false;
            } else if (numberStr[i] == target[i]) {
                continue;
            } else {
                break;
            }
        }
    }
    return true;
}

/**
 * @brief      Transfer uint32_t to string, which need to be free by caller
 * @param [in] num: uint32_t number
 * @return     success: str
 *             failed : NULL
 */
CHAR* TransferUint32ToString(uint32_t num)
{
    char* str = (char*)OsalMalloc(sizeof(char) * MAX_NUMBER_LEN);
    if (str == NULL) {
        return NULL;
    }

    int32_t ret = sprintf_s(str, MAX_NUMBER_LEN, "%u", num);
    if (ret == -1) {
        OSAL_MEM_FREE(str);
        MSPROF_LOGE("Failed to TransferUint32ToString, ret: %d, num: %u.", ret, num);
        return NULL;
    }

    return str;
}

/**
 * @brief      Transfer uint64_t to string, which need to be free by caller
 * @param [in] num: uint64_t number
 * @return     success: str
 *             failed : NULL
 */
CHAR* TransferUint64ToString(uint64_t num)
{
    char* strlong = (char*)OsalMalloc(sizeof(char) * MAX_NUMBER_LONG_LEN);
    if (strlong == NULL) {
        return NULL;
    }

    int32_t ret = sprintf_s(strlong, MAX_NUMBER_LONG_LEN, "%llu", num);
    if (ret == -1) {
        OSAL_MEM_FREE(strlong);
        MSPROF_LOGE("Failed to TransferUint64ToString, ret: %d, num: %" PRIu64 ".", ret, num);
        return NULL;
    }

    return strlong;
}

/**
 * @brief      Transfer float to string, which need to be free by caller
 * @param [in] num: float number
 * @return     success: str
 *             failed : NULL
 */
CHAR* TransferFloatToString(float num)
{
    char* strFloat = (char*)OsalMalloc(sizeof(char) * MAX_NUMBER_FLOAT_LEN);
    if (strFloat == NULL) {
        return NULL;
    }

    int32_t ret = sprintf_s(strFloat, MAX_NUMBER_FLOAT_LEN, "%.4f", num);
    if (ret == -1) {
        OSAL_MEM_FREE(strFloat);
        MSPROF_LOGE("Failed to TransferFloatToString, ret: %d, num: %.4f.", ret, num);
        return NULL;
    }

    return strFloat;
}

int64_t GetClockMonotonicTime(void)
{
    OsalTimespec now = OsalGetTickCount();
    return (now.tv_sec) * TRANSFER_FROM_S_TO_NS + now.tv_nsec;
}

uint64_t GetBkdrHashId(const CHAR *str)
{
    static const uint64_t SEED = 31;
    uint64_t hash = 0;
    while (*str != '\0') {
        hash = ((hash * SEED) + (uint64_t)(*str)) % UINT64_MAX;
        str++;
    }
    return hash;
}

uint64_t TransferStringToInt(CHAR *nptr, size_t nptrLen, CHAR **endptr, uint64_t base)
{
    (void)nptrLen;
    uint64_t result = 0;
    int32_t sign = 1;
    if (*nptr == '-') {
        sign = -1;
        nptr++;
    } else if (*nptr == '+') {
        nptr++;
    } else {
        ;  // No action required
    }
    while (*nptr >= '0' && *nptr <= '9') {
        result = result * base + (uint64_t)(*nptr - '0');
        nptr++;
    }
    if (sign == -1) {
        result = -result;
    }
    if (endptr != NULL) {
        *endptr = nptr;
    }
    return result;
}

double TransferStringToDouble(CHAR *nptr, size_t nptrLen, CHAR **endptr)
{
    (void)nptrLen;
    double result = 0.0;
    int32_t sign = 1;
    double baseTen = 10.0;
    if (*nptr == '-') {
        sign = -1;
        nptr++;
    }
    while (*nptr >= '0' && *nptr <= '9') {
        int32_t nums = *nptr - '0';
        result = result * baseTen + (double)(nums);
        nptr++;
    }
    if (*nptr == '.') {
        nptr++;
        double fraction = 0.0;
        double base = 0.1;
        while (*nptr >= '0' && *nptr <= '9') {
            fraction += (double)(*nptr - '0') * base;
            base /= baseTen;
            nptr++;
        }
        result += fraction;
    }
    if (sign == -1) {
        result = -result;
    }
    if (endptr != NULL) {
        *endptr = nptr;
    }
    return result;
}

char *TimestampToTime(uint64_t timestamp, uint32_t unit)
{
    PROF_CHK_EXPR_ACTION(unit == 0, return NULL, "TimestampToTime failed, divisor is 0.");
    uint32_t microTime = (uint32_t)(timestamp % (uint64_t)unit);
    uint64_t tmpTime = timestamp / unit;
    PROF_CHK_EXPR_ACTION(tmpTime > LONG_MAX, return NULL,
        "Failed to prepare for forced transfer. The data %" PRIu64 " exceeds the long type.", tmpTime);
    time_t t = (time_t)tmpTime;
    struct tm *lt = localtime(&t);
    char* dateStr = (char*)OsalMalloc(sizeof(char) * DATESTR_MAXLEN);
    if (dateStr == NULL) {
        return NULL;
    }
    size_t len = strftime(dateStr, DATESTR_MAXLEN, "%Y-%m-%d %H:%M:%S", lt);
    if (len == 0) {
        MSPROF_LOGE("TimestampToTime, dateStr too short");
    }
    char *microTimeStr = TransferUint64ToString(microTime);
    PROF_CHK_EXPR_ACTION(microTimeStr == NULL,
        {OSAL_MEM_FREE(dateStr); return NULL;}, "Failed to transfer microTimeStr.");
    int32_t ret = strcat_s(dateStr, DATESTR_MAXLEN, ".");
    PROF_CHK_EXPR_ACTION(ret != EOK,
        {OSAL_MEM_FREE(dateStr); OSAL_MEM_FREE(microTimeStr); return NULL;}, "Faild to strcat_s for TimestampToTime.");
    ret = strcat_s(dateStr, DATESTR_MAXLEN, microTimeStr);
    PROF_CHK_EXPR_ACTION(ret != EOK,
        {OSAL_MEM_FREE(dateStr); OSAL_MEM_FREE(microTimeStr); return NULL;}, "Faild to strcat_s for TimestampToTime.");
    OSAL_MEM_FREE(microTimeStr);
    return dateStr;
}

CHAR *Strtok(CHAR *strToken, const CHAR *delimit, CHAR **context)
{
#ifdef LITE_OS
    UNUSED(context);
    return strtok(strToken, delimit);
#else
    return strtok_s(strToken, delimit, context);
#endif
}