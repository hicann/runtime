/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "klogd.h"
#include "log_pm_sig.h"
#include "log_print.h"
#include "log_common.h"
#include "slog.h"
#include "start_single_process.h"
#include "log_config_api.h"
#include "log_pm.h"
#include "log_path_mgr.h"
#ifdef IAM_MONITOR
#include "iam.h"
#endif

#define COMMON_BUFSIZE 1024
#define BASE_HEX 16
#define BASE_DECIMAL 10
#define INDEX_UNIT 4
#define KLOG_BUFF_SIZE (16 * 1024 * 1024)
#define POSITION_UNIT 2
#define KLOG_PATH "/dev/kmsg"

static int g_fKlog = INVALID;

struct {
    int i;
    int n;
} g_argvOpt = { 0, 0 };

/**
 * @brief IsDigit: judge input character if digit or not
 * @param [in]c: input character
 * @return: 1(is digit), 0(not digit)
 */
STATIC INLINE int32_t IsDigit(char c)
{
    return ((c >= '0') && (c <= '9')) ? 1 : 0;
}

STATIC char GetChValue(char ch)
{
    char c = 0;
    if (IsDigit(ch) != 0) {
        // number_in_char - '0' = number
        c = ch - '0';
    } else if ((ch >= 'a') && (ch <= 'z')) {
        // hex char offset + BASE_DECIMAL = integer number
        c = (ch - 'a') + BASE_DECIMAL;
    } else if ((ch >= 'A') && (ch <= 'Z')) {
        c = (ch - 'A') + BASE_DECIMAL;
    } else {
        c = ch;
    }
    return c;
}

STATIC void DecodeMsg(char *msg, uint32_t length)
{
    if ((msg == NULL) || (length == 0)) {
        return;
    }
    int32_t idx = 0;
    char ch = '\0';
    const char *ptr = msg;
    uint32_t len = 0;
    while ((*ptr != '\0') && (len <= length)) {
        if ((*ptr == '\\') && (*(ptr + 1) == 'x')) {
            ptr += POSITION_UNIT;
            ch = (char)(((int32_t)GetChValue(*ptr) * BASE_HEX) + GetChValue(*(ptr + 1)));
            ptr += POSITION_UNIT;
            len = len + INDEX_UNIT;
        } else {
            ch = *ptr;
            ptr++;
            len++;
        }
        len++;
        msg[idx] = ch;
        idx++;
    }
    msg[idx] = '\0';
    idx++;
    return;
}

/**
 * @brief CheckProessBufParm: check param and malloc for heap, copy msg to heap
 * @param [in]msg: input msg
 * @param [in]length: malloc length for heapBuf
 * @param [in/out]heapBuf: pointer to msg copy
 * @return: EOK(0), INVALID(-1)
 */
STATIC int32_t CheckProessBufParm(const char *msg, uint32_t length, char **heapBuf)
{
    ONE_ACT_WARN_LOG(msg == NULL, return INVALID, "[input] message_buffer is null.");
    ONE_ACT_WARN_LOG((length == 0) || (length > KLOG_BUFF_SIZE), return INVALID,
                      "[input] length is invalid, length=%u.", length);
    ONE_ACT_WARN_LOG(heapBuf == NULL, return INVALID, "[input] heap buffer array is null.");

    *heapBuf = (char *)malloc(length);
    if (*heapBuf == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return INVALID;
    }
    (void)memset_s(*heapBuf, length, 0x00, length);

    int32_t ret = memcpy_s(*heapBuf, length, msg, length);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        XFREE(*heapBuf);
        return INVALID;
    }
    return EOK;
}

/**
* @brief ProcessBuf: process kernel msg with timestamp, level and msg itself
* @param [in]msg: input kernel msg
* @param [in]length: length of input kernel msg
* @return: EOK(0)/INVALID(-1)(int)
*/
STATIC int32_t ProcessBuf(char *msg, unsigned int length)
{
    unsigned long int timestamp = 0;
    unsigned short level = 0;
    char *heapBuf = NULL;

    if (CheckProessBufParm(msg, length, &heapBuf) == INVALID) {
        return INVALID;
    }

    char *buf = heapBuf;
    for (; (*buf != '\0') && (IsDigit(*buf) != 0); buf++) {
        if (level > (((USHRT_MAX) - (*buf - '0')) / BASE_DECIMAL)) {
            XFREE(heapBuf);
            return INVALID;
        }
        level = (unsigned short)((level * BASE_DECIMAL) + (*buf - '0'));
    }
    level = level & SKLOG_PRIMASK;
    buf++;

    // skip leading sequence number
    for (; (*buf != '\0') && (IsDigit(*buf) != 0); buf++) {
    }
    buf++;

    // get timestamp
    for (; (*buf != '\0') && (IsDigit(*buf) != 0); buf++) {
        if (timestamp > (((unsigned long)((ULONG_MAX) - (*buf - '0'))) / BASE_DECIMAL)) {
            XFREE(heapBuf);
            return INVALID;
        }
        timestamp = (timestamp * BASE_DECIMAL) + (unsigned long)(*buf - '0');
    }
    buf++;

    // skip everything before message body
    while ((*buf != '\0') && (*buf != ';')) {
        buf++;
    }
    buf++;

    DecodeMsg(buf, length);
    (void)memset_s(msg, length, 0x00, length);

    int32_t ret = sprintf_s(msg, length - 1, "<%hu>[%lu.%06lu] %s", level,
                            timestamp / UNIT_US_TO_S, timestamp % UNIT_US_TO_S, buf);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        XFREE(heapBuf);
        return INVALID;
    }
    XFREE(heapBuf);
    return EOK;
}

STATIC void CloseKernelLog(void)
{
    LOG_CLOSE_FD(g_fKlog);
}

STATIC void OpenKernelLog(void)
{
    g_fKlog = open(KLOG_PATH, O_RDONLY, 0);
    if (g_fKlog == INVALID) {
        SELF_LOG_ERROR("open file failed, file=%s, strerr=%s.", KLOG_PATH, strerror(ToolGetErrorCode()));
        return;
    }

    off_t ret = lseek(g_fKlog, 0, SEEK_END);
    if (ret == INVALID) {
        SELF_LOG_ERROR("lseek file failed, file=%s, strerr=%s.", KLOG_PATH, strerror(ToolGetErrorCode()));
        CloseKernelLog();
    }
    return;
}

STATIC int32_t ReadKernelLog(char *bufP, size_t len)
{
    if ((bufP == NULL) || (g_fKlog == INVALID)) {
        return INVALID;
    }
    return (int32_t)read(g_fKlog, bufP, len);
}

STATIC void ParseArgv(int32_t argc, char * const *argv)
{
    int opts = getopt(argc, argv, "c:n");
    if (opts == INVALID) {
        return;
    }
    do {
        switch (opts) {
            case 'c':
                if (optarg == NULL) {
                    return;
                }
                g_argvOpt.i = atoi(optarg);
                break;
            case 'n':
                g_argvOpt.n = 1;
                break;
            default:
                break;
        }
        opts = getopt(argc, argv, "c:n");
    } while (opts != INVALID);
}

STATIC void KLogToSLog(uint32_t priority, const char *msg)
{
    if (msg != NULL) {
        switch (SKLOG_PRIMASK & priority) {
            case SKLOG_EMERG:
            case SKLOG_ALERT:
            case SKLOG_CRIT:
            case SKLOG_ERROR:
                dlog_error(((uint32_t)KERNEL | (uint32_t)DEBUG_LOG_MASK), "%s", msg);
                break;
            case SKLOG_WARNING:
                dlog_warn(((uint32_t)KERNEL | (uint32_t)DEBUG_LOG_MASK), "%s", msg);
                break;
            case SKLOG_NOTICE:
                dlog_info(((uint32_t)KERNEL | (uint32_t)RUN_LOG_MASK), "%s", msg);
                break;
            case SKLOG_INFO:
                dlog_info(((uint32_t)KERNEL | (uint32_t)DEBUG_LOG_MASK), "%s", msg);
                break;
            case SKLOG_DEBUG:
                dlog_debug(((uint32_t)KERNEL | (uint32_t)DEBUG_LOG_MASK), "%s", msg);
                break;
            default:
                dlog_info(((uint32_t)KERNEL | (uint32_t)DEBUG_LOG_MASK), "%s", msg);
                break;
        }
    }
}

STATIC void ParseKernelLog(const char *start)
{
    unsigned long priority = DLOG_INFO;
    char endptr = '\0';
    char *pendptr = &endptr;
    if (start == NULL) {
        SELF_LOG_ERROR("[input] start is null.");
        return;
    }

    const char *pos = start;
    if (*pos == '<') {
        pos++;
        if ((pos != NULL) && (*pos != '\0')) {
            priority = strtoul(pos, &pendptr, BASE_NUM);
        }

        if ((pendptr != NULL) && (*pendptr == '>')) {
            pendptr++;
        }
    }

    uint32_t level = (priority > (unsigned int)(UINT_MAX)) ? (DLOG_INFO) : ((unsigned int)priority);
    if ((pendptr != NULL) && (*pendptr != '\0')) {
        KLogToSLog(level, pendptr);
    }
}

STATIC void ProcKernelLog(void)
{
    char *logBuffer = (char *)malloc(COMMON_BUFSIZE);
    if (logBuffer == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return;
    }
    (void)memset_s(logBuffer, COMMON_BUFSIZE, 0x00, COMMON_BUFSIZE);
    while (LogGetSigNo() == 0) {
        int ret = ReadKernelLog(logBuffer, COMMON_BUFSIZE - 1);
        if (ret == -1) {
            ONE_ACT_NO_LOG(ToolGetErrorCode() == EINTR, continue);
            SELF_LOG_ERROR("read file(%s) failed, result=%d, strerr=%s.", KLOG_PATH, ret, strerror(ToolGetErrorCode()));
            (void)ToolSleep(ONE_SECOND);
            continue;
        }
        logBuffer[ret] = '\0';
        ret = ProcessBuf(logBuffer, COMMON_BUFSIZE);
        if (ret == INVALID) {
            continue;
        }
        ParseKernelLog(logBuffer);
        (void)memset_s(logBuffer, COMMON_BUFSIZE, 0x00, COMMON_BUFSIZE);
    }
    XFREE(logBuffer);
    return;
}

STATIC void SignalHandle(void)
{
    LogSignalIgn(SIGHUP);
    LogSignalRecord(SIGHUP);     // Close terminal, process end
    LogSignalRecord(SIGINT);     // Interrupt by ctrl+c
    LogSignalRecord(SIGTERM);
#ifdef IAM_MONITOR
    LogSignalIgn(SIGPIPE);
#else
    LogSignalRecord(SIGPIPE);    // Write to pipe with no readers
#endif
    LogSignalRecord(SIGQUIT);    // Interrupt by ctrl+"\"
    LogSignalRecord(SIGABRT);
    LogSignalRecord(SIGALRM);
    LogSignalRecord(SIGVTALRM);
    LogSignalRecord(SIGXCPU);    // Exceeds CPU time limit
    LogSignalRecord(SIGXFSZ);    // Exceeds file size limit
    LogSignalRecord(SIGUSR1);    // user custom signal, process end
    LogSignalRecord(SIGUSR2);
}

/**
* @brief    : sklogd init config file path and self log path
* @return   : SYS_OK: succeed; SYS_ERROR: failed
*/
STATIC void SklogdConfigInit(void)
{
    if (LogConfInit() != SYS_OK) {
        SYSLOG_WARN("can not init conf and continue.....");
    }

    if (LogPathMgrInit() != SYS_OK) {
        SYSLOG_WARN("can not init file path for self log and continue....\n");
    }
}

STATIC void SklogdConfigExit(void)
{
    LogConfListFree();
    LogPathMgrExit();
}

#ifdef __IDE_UT
int KlogdLltMain(int argc, char **argv)
#else
int main(int argc, char **argv)
#endif
{
    SklogdConfigInit();
    OpenKernelLog();
    ParseArgv(argc, argv);
    if (g_argvOpt.n == 0) {
        if (LogSetDaemonize() != LOG_SUCCESS) {
            SELF_LOG_ERROR("fork failed, strerr=%s, start sklogd failed.", strerror(ToolGetErrorCode()));
            goto SKLOGD_EXIT;
        }
    }

    ONE_ACT_NO_LOG(LogPmStart(SKLOGD_MONITOR_FLAG, false) != LOG_SUCCESS, goto SKLOGD_EXIT);

    SignalHandle();
    SELF_LOG_INFO("sklogd process started......");
    LogAttr logAttr = { 0 };
    logAttr.type = SYSTEM;
    logAttr.pid = 0;
    logAttr.deviceId = 0;
    if (DlogSetAttr(logAttr) != SYS_OK) {
        SELF_LOG_ERROR("Set log attr failed.");
    }
    ProcKernelLog();

    // call printself log before free source, or it will write to default path
    SELF_LOG_ERROR("sklogd process quit, signal=%d.", LogGetSigNo());
    LogPmStop();
SKLOGD_EXIT:
    CloseKernelLog();
    SklogdConfigExit();
    return EXIT_FAILURE;
}
