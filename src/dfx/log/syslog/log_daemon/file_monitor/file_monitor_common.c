/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_monitor_common.h"
#include "log_print.h"

static char g_fileMonitorMasterStr[MASTER_ID_STR_LEN] = { 0 };

void FileMonitorSetMasterIdStr(const char *masterIdStr)
{
    errno_t err = strcpy_s(g_fileMonitorMasterStr, MASTER_ID_STR_LEN, masterIdStr);
    if (err != EOK) {
        SELF_LOG_ERROR("strcpy failed, err = %d.", (int32_t)err);
    }
}

char *FileMonitorGetMasterIdStr(void)
{
    return g_fileMonitorMasterStr;
}

int32_t FileMonitorSyncFileList(const char *srcFileName, const char *dstFileName, FileMonitorSyncFunc func,
    int32_t depth)
{
    if (ToolAccess(srcFileName) != 0) {
        return LOG_SUCCESS;
    }
    ToolDirent **nameList = NULL;
    int32_t totalNum = ToolScandir(srcFileName, &nameList, NULL, alphasort);
    if ((totalNum < 0) || ((totalNum > 0) && (nameList == NULL))) {
        SELF_LOG_ERROR("scan dir %s failed, errno=%s", srcFileName, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    for (int32_t i = 0; i < totalNum; i++) {
        if ((nameList[i] == NULL) || (strcmp(nameList[i]->d_name, ".") == 0) ||
            (strcmp(nameList[i]->d_name, "..") == 0)) {
            continue;
        }
        char src[MAX_FULLPATH_LEN] = { 0 };
        char dst[MAX_FULLPATH_LEN] = { 0 };
        int32_t ret = sprintf_s(src, MAX_FULLPATH_LEN, "%s/%s", srcFileName, nameList[i]->d_name);
        if (ret == -1) {
            SELF_LOG_ERROR("sprintf failed, get src path failed, filename = %s.", nameList[i]->d_name);
            continue;
        }
        ret = sprintf_s(dst, MAX_FULLPATH_LEN, "%s/%s", dstFileName, nameList[i]->d_name);
        if (ret == -1) {
            SELF_LOG_ERROR("sprintf failed, get dst path failed, filename = %s.", nameList[i]->d_name);
            continue;
        }
        if (nameList[i]->d_type == (uint8_t)DT_DIR) {
            if (depth <= 0) {
                SELF_LOG_WARN("can not get file list, depth = %d, path = %s.", depth, nameList[i]->d_name);
                continue;
            }
            (void)FileMonitorSyncFileList(src, dst, func, depth - 1);
        }
        if (nameList[i]->d_type == (uint8_t)DT_REG) {
            func(src, dst);
        }
    }
    ToolScandirFree(nameList, totalNum);
    return LOG_SUCCESS;
}

int32_t FileMonitorAddWatch(const char *filePath, int32_t fd, int32_t *wd, uint32_t mask)
{
    if (wd == NULL) {
        return LOG_FAILURE;
    }
    if (ToolAccess(filePath) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    *wd = inotify_add_watch(fd, filePath, mask);
    if (*wd < 0) {
        SELF_LOG_ERROR("notify add watch failed, filePath = %s, wd = %d.", filePath, *wd);
        *wd = 0;
        return LOG_FAILURE;
    }
    SELF_LOG_INFO("add monitor success, filePath = %s.", filePath);
    return LOG_SUCCESS;
}