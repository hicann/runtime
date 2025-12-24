/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_level_mgr.h"
#include "dlog_attr.h"
#include "log_file_info.h"
#include "dlog_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if (!defined LOG_CPP) && (!defined APP_LOG)
#define MAX_INOTIFY_BUFF 1024

static bool g_shmAvail = false;

STATIC int32_t GetGlobalLevel(char levelChar)
{
    ONE_ACT_NO_LOG(levelChar < 0, return DLOG_GLOABLE_DEFAULT_LEVEL);

    int32_t level = (int32_t)((((unsigned char)levelChar) >> 4U) & 0x7U) - 1; // high 6~4bit, & 0x7
    if ((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL)) {
        level = DLOG_GLOABLE_DEFAULT_LEVEL;
    }
    return level;
}

STATIC int32_t GetEventLevel(char levelChar)
{
    ONE_ACT_NO_LOG(levelChar < 0, return EVENT_ENABLE_VALUE);

    int32_t level = (int32_t)((((unsigned char)levelChar) >> 2U) & 0x3U) - 1; // low 3~2bit, & 0x3
    if ((level != EVENT_ENABLE_VALUE) && (level != EVENT_DISABLE_VALUE)) {
        level = EVENT_ENABLE_VALUE;
    }
    return level;
}

/**
 * @brief ParseGlobalLevel: parse global and event level
 * @param [in] : levelStr       level string from shmem
 * @return     : void
 */
STATIC void ParseGlobalLevel(const char *levelStr)
{
    ONE_ACT_NO_LOG(levelStr == NULL, return);
    // global
    SetGlobalLogTypeLevelVar(GetGlobalLevel(levelStr[0]), DLOG_GLOBAL_TYPE_MASK);
    DlogSetLogTypeLevelToAllModule(GetGlobalLevel(levelStr[0]), DLOG_GLOBAL_TYPE_MASK);
    // event
    SetGlobalEnableEventVar(GetEventLevel(levelStr[0]));
}

/**
 * @brief       : parse module level to global struct value
 * @param [in]  : levelStr       level string from shmem
 * @param [in]  : num            module num in global array
 * @param [in]  : moduleInfos    module info
 * @return      : NA
 */
STATIC void ParseModuleLevel(const char *levelStr, int32_t num, const ModuleInfo *moduleInfos)
{
    ONE_ACT_NO_LOG(moduleInfos == NULL, return);
    if ((levelStr == NULL) || (num < 0) || ((uint32_t)num >= LogStrlen(levelStr))) {
        (void)DlogSetLogTypeLevelByModuleId(moduleInfos->moduleId, DLOG_DEBUG_DEFAULT_LEVEL, DEBUG_LOG_MASK);
        return;
    }

    int32_t levell = (int32_t)(((unsigned char)levelStr[num] >> 4U) & 0x7U) - 1; // high 6~4bit, & 0x7
    if (levell < LOG_MIN_LEVEL || levell > LOG_MAX_LEVEL) {
        levell = DLOG_DEBUG_DEFAULT_LEVEL;
    }
    int32_t levelr = (int32_t)(((unsigned char)levelStr[num]) & 0x7U) - 1; // low 2~0bit, & 0x7
    if (levelr < LOG_MIN_LEVEL || levelr > LOG_MAX_LEVEL) {
        levelr = DLOG_RUN_DEFAULT_LEVEL;
    }
    (void)DlogSetLogTypeLevelByModuleId(moduleInfos->moduleId, levell, DEBUG_LOG_MASK);
}

/**
 * @brief      : parse log level to global struct value
 *  format:      0111|         11|         00|        0111|       0111|                 0111|               0111|...
 *             global|      event|    reserve| debug_level|  run_level| module[0].debugLevel| module[0].runLevel|...
 *        high 6~4bit| low 3~2bit| low 1~0bit| high 6~4bit| low 2~0bit| high 6~4bit         | low 2~0bit        |...
 * @param [in] : levelStr       level string from shmem
 * @param [in] : moduleStr      module string from shmem
 * @return     : SUCCESS: parse success; ARGV_NULL: param is null;
 */
STATIC LogRt ParseLogLevel(const char *levelStr, const char *moduleStr)
{
    ONE_ACT_NO_LOG(levelStr == NULL, return ARGV_NULL);
    ONE_ACT_NO_LOG(moduleStr == NULL, return ARGV_NULL);

    // update global and event level
    ParseGlobalLevel(levelStr);

    // update module level
    int32_t i = 0;
    int32_t n = 2; // skip global+event level and debug+run level
    size_t off = 0;
    size_t offPre = 0;
    size_t len = strlen(moduleStr);
    const ModuleInfo *moduleInfos = DlogGetModuleInfos();
    while (off < len) {
        if (moduleStr[off] != ';') {
            off++;
            continue;
        }
        int32_t pre = i;
        for (; i < INVLID_MOUDLE_ID; i++) {
            const char *name  = moduleInfos[i].moduleName;
            if (strncmp(name, moduleStr + offPre, strlen(name)) == 0) {
                ParseModuleLevel(levelStr, n, &moduleInfos[i]); // parse n module level
                break;
            }
        }
        if (i == INVLID_MOUDLE_ID) {
            i = pre;
        }
        n++; // next module in moduleStr
        off++; // ';' next
        offPre = off;
    }
    return SUCCESS;
}

/**
 * @brief ReadStrFromShm: read string from shmem
 * @param [in]shmId: shmem identifier ID
 * @param [in/out]str: string which read from shmem.
 *      The arg '*str' only malloc in the method, no need to malloc in caller.
 * @param [in]strLen: string max length
 * @param [in]offset: read offset in shmem
 * @return: SYS_ERROR/SYS_OK
 */
STATIC int32_t ReadStrFromShm(int32_t shmId, char **str, size_t strLen, size_t offset)
{
    ONE_ACT_NO_LOG(shmId < 0, return SYS_ERROR);
    ONE_ACT_NO_LOG(str == NULL, return SYS_ERROR);
    ONE_ACT_NO_LOG((strLen == 0) || ((strLen + 1U) > SHM_SIZE), return SYS_ERROR);
    ONE_ACT_NO_LOG(((offset > SHM_SIZE) || ((offset + strLen) > SHM_SIZE)), return SYS_ERROR);

    size_t bufLen = strLen + 1U;
    char *tmpBuf = (char *)malloc(bufLen);
    if (tmpBuf == NULL) {
        SELF_LOG_ERROR("malloc failed, pid=%d, strerr=%s.", ToolGetPid(), strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    (void)memset_s(tmpBuf, bufLen, 0, bufLen);

    // read module arr
    ShmErr res = ShMemRead(shmId, tmpBuf, strLen, offset);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("read from shmem failed, pid=%d, strerr=%s.", ToolGetPid(), strerror(ToolGetErrorCode()));
        XFREE(tmpBuf);
        return SYS_ERROR;
    }
    *str = tmpBuf;
    return SYS_OK;
}

/**
 * @brief       : watch the file '/usr/slog/level_notify', when the file changed, then update log level.
 * @param       : NULL
 * @return      : SYS_OK: 0; SYS_ERROR: -1
 */
STATIC int32_t UpdateLogLevel(void)
{
    int32_t shmId = -1;
    char *moduleStr = NULL;
    char *levelStr = NULL;

    ShmErr ret = ShMemOpen(&shmId);
    if (ret == SHM_ERROR) {
        SELF_LOG_WARN("slogd is not ready, will try to open shmem again later, pid=%d.", ToolGetPid());
        return SYS_ERROR;
    }
    // read module info
    int32_t res = ReadStrFromShm(shmId, &moduleStr, MODULE_ARR_LEN, CONFIG_PATH_LEN + GLOBAL_ARR_LEN);
    if (res != SYS_OK) {
        SELF_LOG_ERROR("read module from shmem failed, pid=%d.", ToolGetPid());
        return SYS_ERROR;
    }
    // read level info
    res = ReadStrFromShm(shmId, &levelStr, LEVEL_ARR_LEN, CONFIG_PATH_LEN + GLOBAL_ARR_LEN + MODULE_ARR_LEN);
    if (res != SYS_OK) {
        SELF_LOG_ERROR("read level from shmem failed, pid=%d.", ToolGetPid());
        XFREE(moduleStr);
        return SYS_ERROR;
    }
    // parse level and update to global value
    LogRt err = ParseLogLevel(levelStr, moduleStr);
    XFREE(levelStr);
    XFREE(moduleStr);
    if (err != SUCCESS) {
        SELF_LOG_ERROR("parse level failed, log_err=%d, pid=%d.", (int32_t)err, ToolGetPid());
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief       : Obtain notify file pathname
 * @param [out] : notifyFile      notify file pathname
 * @param [in]  : length          notify file pathname max length
 * @return      : SYS_OK: 0; SYS_ERROR: -1
 */
STATIC int32_t ObtainNotifyFile(char *notifyFile, uint32_t length)
{
    size_t len = strlen(DEFAULT_LOG_WORKSPACE) + strlen(LEVEL_NOTIFY_FILE) + 1;
    int32_t res = sprintf_s(notifyFile, length, "%s/%s", DEFAULT_LOG_WORKSPACE,
                            LEVEL_NOTIFY_FILE);
    if (res != (int32_t)len) {
        SELF_LOG_ERROR("copy path failed, res=%d, strerr=%s, pid=%d, Thread(LevelNotifyWatcher) quit.",
                       res, strerror(ToolGetErrorCode()), ToolGetPid());
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief       : Check whether shm is available
 * @param       : NULL
 * @return      : SYS_OK: 0; SYS_ERROR: -1
 */
STATIC int32_t CheckShMemAvailable(void)
{
    int32_t shmId;
    if (ShMemOpen(&shmId) == SHM_ERROR) {
        return SYS_ERROR;
    }
    g_shmAvail = true;
    return SYS_OK;
}

/**
 * @brief AddNewWatch: check file access and add new watch
 * @param [in/out]pNotifyFd: pointer to nofity fd
 * @param [in/out]pWatchFd: pointer to watched fd
 * @param [in]notifyFile: notify file, default is "/usr/slog/level_notify"
 * @return: LogRt, SUCCESS/NOTIFY_WATCH_FAILED/ARGV_NULL/NOTIFY_INIT_FAILED
 */
STATIC LogRt AddNewWatch(int32_t *pNotifyFd, int32_t *pWatchFd, const char *notifyFile)
{
    ONE_ACT_NO_LOG(pNotifyFd == NULL, return ARGV_NULL);
    ONE_ACT_NO_LOG(pWatchFd == NULL, return ARGV_NULL);
    ONE_ACT_NO_LOG(notifyFile == NULL, return ARGV_NULL);

    uint32_t printNum = 0;
    while (ToolAccess(notifyFile) != SYS_OK) {
        SELF_LOG_WARN_N(&printNum, CONN_W_PRINT_NUM,
                        "can not access notify file, file=%s, pid=%d, print once every %d times.",
                        notifyFile, ToolGetPid(), CONN_W_PRINT_NUM);
        (void)ToolSleep(1000); // wait file created, sleep 1000ms
    }

    if ((*pNotifyFd != INVALID) && (*pWatchFd != INVALID)) {
        int32_t res = inotify_rm_watch(*pNotifyFd, *pWatchFd);
        NO_ACT_WARN_LOG(res != 0, "can not remove inotify but continue, res=%d, strerr=%s, pid=%d.",
                        res, strerror(ToolGetErrorCode()), ToolGetPid());
        LOG_CLOSE_FD(*pNotifyFd);
    }
    *pNotifyFd = INVALID;
    *pWatchFd = INVALID;

    // init notify
    int32_t notifyFd = inotify_init();
    ONE_ACT_ERR_LOG(notifyFd == INVALID, return NOTIFY_INIT_FAILED,
                    "init inotify failed, res=%d, strerr=%s, pid=%d.",
                    notifyFd, strerror(ToolGetErrorCode()), ToolGetPid());
    // add new watcher
    int32_t watchFd = inotify_add_watch(notifyFd, notifyFile, IN_DELETE_SELF | IN_CLOSE_WRITE);
    TWO_ACT_ERR_LOG(watchFd < 0, LOG_CLOSE_FD(notifyFd), return NOTIFY_WATCH_FAILED,
                    "add file watcher failed, res=%d, strerr=%s, pid=%d.",
                    watchFd, strerror(ToolGetErrorCode()), ToolGetPid());
    *pNotifyFd = notifyFd;
    *pWatchFd = watchFd;
    return SUCCESS;
}

/**
 * @brief       : get flag for thread exit
 * @return      : true exit; false not-exit
 */
STATIC bool IsWatcherThreadExit(void)
{
    return false;   // use in future
}

STATIC void *LevelNotifyWatcher(void *arg)
{
    (void)arg;
    NO_ACT_WARN_LOG(ToolSetThreadName("LogLevelWatcher") != SYS_OK,
                    "can not set thread_name(LogLevelWatcher), pid=%d.", ToolGetPid());
    int32_t notifyFd = INVALID;
    int32_t watchFd = INVALID;
    char notifyFile[CFG_WORKSPACE_PATH_MAX_LENGTH] = { 0 };
    char eventBuf[MAX_INOTIFY_BUFF] = { 0 };
    while (!IsWatcherThreadExit()) {
        if (!g_shmAvail) {
            if (CheckShMemAvailable() != SYS_OK) {
                (void)ToolSleep(ONE_SECOND); // shm not ok, sleep 1000ms and try again
                continue;
            }
            (void)UpdateLogLevel();
        }
        if (notifyFd == INVALID) {
            ONE_ACT_NO_LOG(ObtainNotifyFile(notifyFile, CFG_WORKSPACE_PATH_MAX_LENGTH) != SYS_OK, return NULL);
            LogRt err = AddNewWatch(&notifyFd, &watchFd, notifyFile);
            ONE_ACT_ERR_LOG(err != SUCCESS, return NULL,
                            "add watcher failed, err=%d, pid=%d, Thread(LevelNotifyWatcher) quit.",
                            (int32_t)err, ToolGetPid());
        }
        int32_t numRead = (int32_t)read(notifyFd, eventBuf, MAX_INOTIFY_BUFF);
        ONE_ACT_WARN_LOG(numRead <= 0, continue,
                         "can not read watcher event, res=%d, strerr=%s, pid=%d, but continue.",
                         numRead, strerror(ToolGetErrorCode()), ToolGetPid());
        char *tmpBuf = eventBuf;
        for (; tmpBuf < (eventBuf + numRead);) {
            struct inotify_event *event = (struct inotify_event *)tmpBuf;
            if (event->mask & IN_CLOSE_WRITE) {
                if (DlogCheckAttrSystem()) {
                    (void)UpdateLogLevel();
                }
            } else if (event->mask & IN_DELETE_SELF) {
                LogRt err = AddNewWatch(&notifyFd, &watchFd, (const char *)notifyFile);
                ONE_ACT_NO_LOG(err != SUCCESS, break);
                if (DlogCheckAttrSystem()) {
                    (void)UpdateLogLevel();
                }
            }
            tmpBuf += sizeof(struct inotify_event) + event->len;
        }
    }
    SELF_LOG_ERROR("Thread(LevelNotifyWatcher) quit, pid=%d.", ToolGetPid());
    int32_t res = inotify_rm_watch(notifyFd, watchFd);
    NO_ACT_ERR_LOG(res != 0, "remove inotify failed, res=%d, strerr=%s, pid=%d",
                   res, strerror(ToolGetErrorCode()), ToolGetPid());
    LOG_CLOSE_FD(notifyFd);
    return NULL;
}

/**
 * @brief       : start one thread to watch the file '/usr/slog/level_notify' and read level from shmem.
 * @param       : NULL
 * @return      : NULL
 */
STATIC void StartThreadForLevelChangeWatcher(void)
{
    // start thread
    ToolUserBlock thread;
    thread.procFunc = LevelNotifyWatcher;
    thread.pulArg = NULL;

    ToolThread tid = 0;
    ONE_ACT_ERR_LOG(ToolCreateTaskWithDetach(&tid, &thread) != SYS_OK, return,
                    "create task LevelWatcher failed, strerr=%s, pid=%d.",
                    strerror(ToolGetErrorCode()), ToolGetPid());
}

void DlogLevelInit(void)
{
    if (CheckShMemAvailable() == SYS_OK) {
        (void)UpdateLogLevel();
    }
    StartThreadForLevelChangeWatcher();
}

void DlogLevelReInit(void)
{
    StartThreadForLevelChangeWatcher();
}
#endif

#ifdef __cplusplus
}
#endif // __cplusplus
