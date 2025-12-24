/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_utils.h"
#include <ctype.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#include "log_system_api.h"
#include "msnpureport_print.h"
#include "ascend_hal.h"
#include "mmpa_api.h"

#define MAX_RECURSION_DEPTH 6
#define DIR_MODE 0700

void *MsnMalloc(size_t size)
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

void MsnFree(void *buffer)
{
    if (buffer != NULL) {
        free(buffer);
    }
}

void MsnToUpper(char *str, uint32_t len)
{
    uint32_t i = 0;
    while ((*str != 0) && (i < len)) {
        *str = (char)toupper(*str);
        str++;
        i++;
    }
}

bool MsnIsDockerEnv(void)
{
    return ToolAccess("/.dockerenv") == SYS_OK;
}

/**
 * @brief MsnGetDevIDs: get device num and device ids
 * @param [in/out]devNum: device number
 * @param [in/out]idArray: device id array
 * @return EN_OK/EN_ERROR
 */
int32_t MsnGetDevIDs(uint32_t *devNum, uint32_t *idArray, uint32_t length)
{
    drvError_t err = drvGetDevNum(devNum);
    ONE_ACT_ERR_LOG(err != DRV_ERROR_NONE, return EN_ERROR, "Get device num failed, ret=%d.", (int32_t)err);
    ONE_ACT_ERR_LOG(*devNum > MAX_DEV_NUM, return EN_ERROR, "Get device num %u invalid.", *devNum);
    ONE_ACT_ERR_LOG(*devNum == 0, return EN_ERROR, "No device is running.");

    err = drvGetDevIDs(idArray, length);
    ONE_ACT_ERR_LOG(err != DRV_ERROR_NONE, return EN_ERROR, "Get device id failed, ret=%d.", (int32_t)err);
    
    for (uint32_t i = 0; i < *devNum; i++) {
        if (*(idArray + i) >= MAX_DEV_NUM) {
            SELF_LOG_ERROR("Get device id %u invalid", *(idArray + i));
            return EN_ERROR;
        }
    }

    return EN_OK;
}

int32_t MsnCheckDeviceId(uint32_t deviceId)
{
    uint32_t devNum = 0;
    uint32_t devIds[MAX_DEV_NUM] = { 0 };
    if (MsnGetDevIDs(&devNum, devIds, MAX_DEV_NUM) != EN_OK) {
        return EN_ERROR;
    }
    for (uint32_t i = 0; i < devNum; i++) {
        if (devIds[i] == deviceId) {
            return EN_OK;
        }
    }
    return EN_ERROR;
}

/**
 * @brief MsnGetDevMasterId: get the master id corresponding to the logical id.
 * @param [in]devLogicId: device logic id
 * @param [in/out]devMasterId: device master id
 * @return EN_OK/EN_ERROR
 */
int32_t MsnGetDevMasterId(uint32_t devLogicId, uint32_t *phyId, int64_t *devMasterId)
{
    drvError_t err = drvDeviceGetPhyIdByIndex(devLogicId, phyId);
    if ((err != DRV_ERROR_NONE) || (*phyId >= MAX_DEV_NUM)) {
        SELF_LOG_ERROR("Get pyhsical id failed, dev_id=%u, ret=%d.", devLogicId, (int32_t)err);
        return EN_ERROR;
    }
    err = halGetDeviceInfo(*phyId, (int32_t)MODULE_TYPE_SYSTEM, (int32_t)INFO_TYPE_MASTERID, devMasterId);
    if ((err != DRV_ERROR_NONE) || (*devMasterId < 0) || (*devMasterId >= MAX_DEV_NUM)) {
        SELF_LOG_WARN("Can not get device os id, dev_id=%u, phy_id=%u, ret=%d.", devLogicId, *phyId, (int32_t)err);
        return EN_ERROR;
    }
    return EN_OK;
}

int32_t MsnGetTimeStr(char *timeBuffer, uint32_t bufLen)
{
    mmTimeval currentTimeval = { 0 };
    struct tm timeInfo = { 0 };

    int32_t ret = mmGetTimeOfDay(&currentTimeval, NULL);
    ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR, "get times failed.");

    const time_t sec = currentTimeval.tv_sec;
    ret = mmLocalTimeR(&sec, &timeInfo);
    ONE_ACT_ERR_LOG(ret != EN_OK, return EN_ERROR, "get timestamp failed.");

    ret = snprintf_s(timeBuffer, bufLen, bufLen - 1, "%04d%02d%02d%02d%02d%02d",
                     timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday,
                     timeInfo.tm_hour, timeInfo.tm_min, timeInfo.tm_sec);
    ONE_ACT_ERR_LOG(ret == -1, return EN_ERROR, "copy time buffer failed.");

    return EN_OK;
}

int32_t MsnMkdir(const char *path)
{
    ONE_ACT_ERR_LOG(path == NULL, return EN_ERROR, "input path is null.");
    if (mmAccess(path) == EN_OK) {
        return EN_OK;
    }

    int32_t ret = mmMkdir(path, (mmMode_t)DIR_MODE);
    if ((ret != EN_OK) && (errno != EEXIST)) {
        SELF_LOG_ERROR("mkdir %s failed, strerr=%s.", path, strerror(errno));
        return EN_ERROR;
    }
    return EN_OK;
}

/**
 * @brief          : create multi level directory
 * @param [in]     : path        destination directory path
 * @return         : EN_OK: succeed; EN_ERROR: failed
 */
int32_t MsnMkdirMulti(const char *path)
{
    ONE_ACT_ERR_LOG(path == NULL, return EN_ERROR, "input path is null.");
    if (mmAccess(path) == EN_OK) {
        return EN_OK;
    }

    char tmpPath[MMPA_MAX_PATH] = { 0 };
    errno_t ret = strcpy_s(tmpPath, MMPA_MAX_PATH, path);
    ONE_ACT_ERR_LOG(ret != EOK, return EN_ERROR, "strcpy_s path failed, ret:%d.", ret);
    size_t len = strlen(tmpPath);
    // 创建父目录
    for (size_t i = 1; i < len; ++i) {
        if (tmpPath[i] == '/') {
            tmpPath[i] = '\0';
            if (MsnMkdir(tmpPath) != EN_OK) {
                return EN_ERROR;
            }
            tmpPath[i] = '/';
        }
    }

    if (MsnMkdir(tmpPath) != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

bool MsnIsPoolEnv(void)
{
#ifdef _LOG_UT_
#ifndef HAL_PRODUCT_TYPE_POD
#define HAL_PRODUCT_TYPE_POD 100
#endif
#ifndef INFO_TYPE_PRODUCT_TYPE
#define INFO_TYPE_PRODUCT_TYPE 100
#endif
    int64_t devType = -1;
    drvError_t ret = halGetDeviceInfo(0, MODULE_TYPE_SYSTEM, INFO_TYPE_PRODUCT_TYPE, &devType);
    if (ret == DRV_ERROR_NOT_SUPPORT) {
        return false;
    }
    ONE_ACT_ERR_LOG((ret != DRV_ERROR_NONE), return false, "Get product type failed, ret=%d.", ret);
    devType = -1; // stub for esl
    if (devType == HAL_PRODUCT_TYPE_POD) {
        return true;
    } else {
        return false;
    }
#else
    return false;
#endif
}