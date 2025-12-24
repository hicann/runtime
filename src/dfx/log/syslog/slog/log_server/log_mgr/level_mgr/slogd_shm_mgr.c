/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_shm_mgr.h"
#include "share_mem.h"
#include "log_common.h"
#include "log_system_api.h"
#include "log_config_api.h"
#include "slogd_flush.h"
#include "log_print.h"

STATIC bool g_master = false;

LogStatus SlogdShmWriteLevelAttr(const char* levelStr, uint32_t length)
{
    if (!g_master) {
        return LOG_SUCCESS;  // vf slogd not write attr
    }
    if (length > LEVEL_ARR_LEN) {
        SELF_LOG_ERROR("Write level arr to shmem failed, level str length exceed the limit.");
        return LOG_FAILURE;
    }
    // write level info to shmem
    int32_t shmId = -1;
    ShmErr res = ShMemOpen(&shmId);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("Open shmem failed.");
        return LOG_FAILURE;
    }

    res = ShMemWrite(shmId, levelStr, LEVEL_ARR_LEN, CONFIG_PATH_LEN + GLOBAL_ARR_LEN + MODULE_ARR_LEN);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("Write level to shmem failed.");
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}


LogStatus SlogdShmWriteModuleAttr(const char* moduleStr, uint32_t length)
{
    if (!g_master) {
        return LOG_SUCCESS;  // vf slogd not write attr
    }
    if (length > MODULE_ARR_LEN) {
        SELF_LOG_ERROR("Write module arr to shmem failed, module str length exceed the limit.");
        return LOG_FAILURE;
    }
    // write module info to shmem
    int32_t shmId = -1;
    ShmErr res = ShMemOpen(&shmId);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("Open shmem failed.");
        return LOG_FAILURE;
    }
    // write shmem
    res = ShMemWrite(shmId, moduleStr, MODULE_ARR_LEN, CONFIG_PATH_LEN + GLOBAL_ARR_LEN);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("Write module arr to shmem failed, res=%d.", (int32_t)res);
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

/**
 * @brief ConstructGlobalStr: constuct global attr to string
 * @param [in/out]str: global attr string
 * @param [in]strLen: str max length
 */
STATIC LogStatus ConstructGlobalStr(char *str, uint32_t strLen)
{
    ONE_ACT_ERR_LOG(str == NULL, return LOG_FAILURE, "[input] pointer is null.");
    ONE_ACT_ERR_LOG(strLen < sizeof(GloablArr), return LOG_FAILURE, "strlen is invalid, strlen=%u.", strLen);

    GloablArr global;
    (void)memset_s(&global, sizeof(GloablArr), 0, sizeof(GloablArr));
    global.magicHead = MAGIC_HEAD;
    global.magicTail = MAGIC_TAIL;
    global.msgType = MSGTYPE_STRUCT;
    int32_t ret = memcpy_s(str, strLen, (const char*)&global, sizeof(GloablArr));
    ONE_ACT_ERR_LOG(ret != EOK, return LOG_FAILURE,
                    "memcpy failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
    return LOG_SUCCESS;
}

STATIC LogStatus SlogdShmWriteGlobalAttr(void)
{
    char globalStr[GLOBAL_ARR_LEN] = { 0 };
    int32_t ret = ConstructGlobalStr(globalStr, GLOBAL_ARR_LEN);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "construct global string failed, result=%d.", ret);

    // write global info to shmem
    int32_t shmId = -1;
    ShmErr res = ShMemOpen(&shmId);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("Open shmem failed.");
        return LOG_FAILURE;
    }

    res = ShMemWrite(shmId, globalStr, GLOBAL_ARR_LEN, CONFIG_PATH_LEN);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("Write level to shmem failed.");
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

/**
 * @brief : write config file path to share memory
 * @param [out]configPath: buffer to stor config path
 * @return: LOG_SUCCESS/LOG_FAILURE
 */
STATIC LogStatus LogSetConfigPathToShm(const char *configPath)
{
    // only call by slogd when init
    if (configPath == NULL) {
        SYSLOG_WARN("[input] config path is null.\n");
        return LOG_FAILURE;
    }
    size_t len = strlen(configPath);
    if ((len == 0) || (len > (uint32_t)SLOG_CONF_PATH_MAX_LENGTH)) {
        SYSLOG_WARN("[input] config Path length is invalid, length=%zu, max_length=%d.\n",
                    len, SLOG_CONF_PATH_MAX_LENGTH);
        return LOG_FAILURE;
    }
    int32_t shmId = 0;
    if (ShMemOpen(&shmId) == SHM_ERROR) {
        SYSLOG_WARN("can not open share memory, slogd maybe is not runing, please check!\n");
        return LOG_FAILURE;
    }
    if (ShMemWrite(shmId, configPath, CONFIG_PATH_LEN, 0) != SHM_SUCCEED) {
        // if write failed, should remove the share memory
        SYSLOG_WARN("can not write to share memory.\n");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
* @brief : judge config shared memory exist or not
* @return: LOG_SUCCESS: exist, LOG_FAILURE : not exist
*/
STATIC LogStatus IsConfigShmExist(void)
{
    int32_t shmId = 0;
    if (ShMemOpen(&shmId) == SHM_ERROR) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief: if shmem not exist, then create
 * @return: LOG_SUCCESS: shmem existed or created success.
 */
STATIC LogStatus InitShm(void)
{
    if (IsConfigShmExist() == LOG_SUCCESS) {
        // shm exist
        SlogdShmExit();
    }
    toolMode perm = SyncGroupToOther(SHM_MODE);
    int32_t shmId = 0;
    if (ShMemCreat(&shmId, perm) == SHM_ERROR) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

LogStatus SlogdShmInit(int32_t devId)
{
    g_master = (devId == -1) ? true : false;
    if (!g_master) {
        return LOG_SUCCESS;  // vf slogd not init shm
    }

    if (InitShm() != LOG_SUCCESS) {
        SELF_LOG_ERROR("create shmem failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // write config path to shared memory for libslog.so.
    LogStatus ret = LOG_FAILURE;
    const char *confPath = LogConfGetPath();
    if ((confPath != NULL) && (strlen(confPath) != 0)) {
        ret = LogSetConfigPathToShm(confPath);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "Set config path to share memory failed.");
    }

    ret = SlogdShmWriteGlobalAttr();
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "Set global attr to share memory failed.");
    return LOG_SUCCESS;
}

/**
* @brief : free shared memory
* @return: void
*/
void SlogdShmExit(void)
{
    if (g_master) {
        ShMemRemove();
    }
}

