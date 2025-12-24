/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_compress.h"
#include "log_software_zip.h"
#include "log_hardware_zip.h"
#include "log_print.h"
#include "log_file_info.h"
#include "log_file_util.h"

bool LogCompressSwitch(void)
{
#if defined(SOFTWARE_ZIP) || defined(HARDWARE_ZIP)
    return true;
#else
    return false;
#endif
}

LogStatus LogCompressFile(const char *file)
{
#if defined(SOFTWARE_ZIP)
    return SoftwareCompressFile(file);
#elif defined(HARDWARE_ZIP)
    return HardwareCompressFile(file);
#else
    (void)file;
    return LOG_SUCCESS;
#endif
}

/**
* @brief            : Check whether log file suffix is .log
* @param [in]       : fileName log file's full path(contains filename)
* @return           : true  unzip suffix; false not unzip suffix
*/
bool LogCompressCheckUnzipSuffix(const char *fileName)
{
    ONE_ACT_WARN_LOG(fileName == NULL, return false, "fileName is null.");
    char *suffix = strrchr(fileName, '.');
    if (suffix != NULL) {
        if (strcmp(suffix, GZIP_SUFFIX) == 0) {
            return false;
        }
        if (strcmp(suffix, LOG_FILE_SUFFIX) == 0) {
            return true;
        }
    }

    // invalid suffix
    SELF_LOG_WARN("cannot check whether the file %s is a compressed file.", fileName);
    return false;
}

/*
 * @brief: compress add file suffix
 * @param [in]file: source log file
 * @param [in]length: file name max length
 * @return: LOG_SUCCESS: succeed; others: failed;
 */
LogStatus LogCompressAddSuffix(char *file, uint32_t length)
{
#if defined(SOFTWARE_ZIP) || defined(HARDWARE_ZIP)
    ONE_ACT_ERR_LOG(file == NULL, return LOG_FAILURE, "[input] file is invalid.");
    ONE_ACT_ERR_LOG((length == 0) || (length > TOOL_MAX_PATH), return LOG_FAILURE,
                    "[input] file(%s) length(%u) is invalid.", file, length);
 
    int32_t ret = snprintf_s(file, length, (size_t)length - 1U, "%s%s", file, GZIP_SUFFIX);
    if (ret == -1) {
        SELF_LOG_ERROR("file(%s) add suffix(%s) failed, strerr=%s.",
                       file, GZIP_SUFFIX, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
#else
    (void)file;
    (void)length;
    return LOG_SUCCESS;
#endif
}

/*
 * @brief: remove "act" in file name
 * @param [in]file: source log file
 * @param [in]length: file name max length
 * @return: LOG_SUCCESS: succeed; others: failed;
 */
LogStatus LogCompressGetRotatePath(char *file, uint32_t length)
{
#if defined(SOFTWARE_ZIP) || defined(HARDWARE_ZIP)
    ONE_ACT_ERR_LOG(file == NULL, return LOG_FAILURE, "[input] file is invalid.");
    ONE_ACT_ERR_LOG((length == 0) || (length > TOOL_MAX_PATH), return LOG_FAILURE,
                    "[input] file(%s) length(%u) is invalid.", file, length);
    char oriFileName[TOOL_MAX_PATH] = { 0 };
    errno_t err = EOK;
    err = strcpy_s(oriFileName, TOOL_MAX_PATH, file);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "strcpy_s failed, can not copy active file name, ret = %d.",
        (int32_t)err);
    char *str = strstr(oriFileName, LOG_ACTIVE_STR);
    if ((str == NULL) || (str <= oriFileName)) {
        return LOG_SUCCESS;
    }
    (void)memset_s(file, length, 0, length);
    int64_t copyLen = str - oriFileName;
    err = strncpy_s(file, length, oriFileName, (size_t)copyLen);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "strncpy_s failed, can not rename active file name, ret = %d.",
        (int32_t)err);
    err = strcpy_s(file + copyLen, (size_t)length - (size_t)copyLen, str + strlen(LOG_ACTIVE_STR));
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "strcpy_s failed, can not rename active file name, ret = %d.",
        (int32_t)err);
    return LOG_SUCCESS;
#else
    (void)file;
    (void)length;
    return LOG_SUCCESS;
#endif
}

/*
 * @brief: compress file rotate
 * @param [in]file: source log file
 * @return: LOG_SUCCESS: succeed; others: failed;
 */
LogStatus LogCompressFileRotate(const char *file)
{
#if defined(SOFTWARE_ZIP) || defined(HARDWARE_ZIP)
    ONE_ACT_ERR_LOG(file == NULL, return LOG_FAILURE, "[input] file is invalid.");
    char newFileName[TOOL_MAX_PATH] = { 0 };
    errno_t err = strcpy_s(newFileName, TOOL_MAX_PATH, file);
    if (err != EOK) {
        SELF_LOG_ERROR("strcpy_s failed, init new file name failed, ret = %d.", (int32_t)err);
        return LOG_FAILURE;
    }
    ONE_ACT_ERR_LOG(LogCompressGetRotatePath(newFileName, TOOL_MAX_PATH) != LOG_SUCCESS, return LOG_FAILURE,
        "get rotate path failed.");
    ONE_ACT_ERR_LOG(ToolRename(file, newFileName) != LOG_SUCCESS, return LOG_FAILURE,
        "rename active file name failed.");
    FsyncLogToDisk(newFileName);
    return LOG_SUCCESS;
#else
    (void)file;
    return LOG_SUCCESS;
#endif
}

/*
* @brief LogCompressBuffer: compress <source> to <destination>
* @param [in]source: origin buffer
* @param [in]sourceLen: origin buffer length
* @param [out]dest: 2nd ptr point to output buffer
* @param [out]destLen: ptr point to output buffer length
* @return: LOG_SUCCESS: succeed; others: failed;
*/
LogStatus LogCompressBuffer(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen)
{
#if defined(HARDWARE_ZIP)
    return HardwareCompressBuffer(source, sourceLen, dest, destLen);
#else
    (void)source;
    (void)sourceLen;
    (void)dest;
    (void)destLen;
    return LOG_SUCCESS;
#endif
}

bool LogCompressCheckActiveFile(const char *fileName)
{
    ONE_ACT_WARN_LOG((fileName == NULL) || (strlen(fileName) == 0), return false, "fileName is null.");
    ONE_ACT_WARN_LOG(strlen(fileName) <= strlen(LOG_ACTIVE_FILE_GZ_SUFFIX), return false,
        "file name length is invaild, cannot check whether the file %s is a active file.", fileName);
    const char *suffix = fileName + strlen(fileName) - strlen(LOG_ACTIVE_FILE_GZ_SUFFIX);
    if (strcmp(suffix, LOG_ACTIVE_FILE_GZ_SUFFIX) == 0) {
        return true;
    } else {
        return false;
    }
}