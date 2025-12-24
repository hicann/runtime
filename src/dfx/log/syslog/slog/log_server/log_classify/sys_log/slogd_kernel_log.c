/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_kernel_log.h"
#include "log_level_parse.h"
#include "log_time.h"
#include "log_common.h"
#include "log_print.h"

#ifndef KERNEL_LOG_PATH
#define KERNEL_LOG_PATH                 "/dev/kmsg"
#endif
#define SLOGD_KERNEL_LOG_TIMESTAMP_LEN  128U
#define SLOGD_KERNEL_LOG_RECV_BUFSIZE   1024U
#define BASE_HEX        16
#define BASE_DECIMAL    10U
#define INDEX_UNIT      4U
#define POSITION_UNIT   2
#define UNIT_US_TO_S    1000000U
#define UNIT_US_TO_MS   1000
// syslog levels highest to lowest priority
#define SKLOG_EMERG     0 // system is unusable
#define SKLOG_ALERT     1 // action must be taken immediately
#define SKLOG_CRIT      2 // critical conditions
#define SKLOG_ERROR     3 // error conditions
#define SKLOG_WARNING   4 // warning conditions
#define SKLOG_NOTICE    5 // normal but significant condition
#define SKLOG_INFO      6 // informational
#define SKLOG_DEBUG     7 // debug-level messages
#define SKLOG_PRIMASK   0x07U // mask to extract priority part (internal)

STATIC SlogdKernelLogMgr g_kernelLogMgr = { INVALID, {0}, NULL, NULL};

STATIC bool SlogdKernelLogIsNeedInit(void)
{
#ifdef KERNEL_LOG
    return true;
#else
    return false;
#endif
}

/**
 * @brief       : judge input character if digit or not
 * @param[in]   : c         input character
 * @return      : 1(is digit), 0(not digit)
 */
STATIC INLINE int32_t SlogdKernelLogIsDigit(char c)
{
    return ((c >= '0') && (c <= '9')) ? 1 : 0;
}

STATIC char SlogdKernelLogGetChValue(char ch)
{
    int32_t offset = 0;
    if (SlogdKernelLogIsDigit(ch) != 0) {
        // number_in_char - '0' = number
        offset = ch - '0';
    } else if ((ch >= 'a') && (ch <= 'z')) {
        // hex char offset + BASE_DECIMAL = integer number
        offset = (ch - 'a') + (int32_t)BASE_DECIMAL;
    } else if ((ch >= 'A') && (ch <= 'Z')) {
        offset = (ch - 'A') + (int32_t)BASE_DECIMAL;
    } else {
        return ch;
    }
    return (char)offset;
}

STATIC void SlogdKernelLogDecodeMsg(char *msg, uint32_t length)
{
    int32_t idx = 0;
    char ch = '\0';
    const char *ptr = msg;
    uint32_t len = 0;
    while ((*ptr != '\0') && (len <= length)) {
        if ((*ptr == '\\') && (*(ptr + 1) == 'x')) {
            ptr += POSITION_UNIT;
            ch = (char)(((int32_t)SlogdKernelLogGetChValue(*ptr) * BASE_HEX) + SlogdKernelLogGetChValue(*(ptr + 1)));
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
 * @brief       : check param and malloc for heap, copy msg to heap
 * @param[in]   : msg       input msg
 * @param[in]   : length    malloc length for heapBuf
 * @param[out]  : heapBuf   pointer to msg copy
 * @return      : LOG_SUCCESS success, LOG_FAILURE failure
 */
STATIC LogStatus SlogdKernelLogCheckParam(const char *msg, uint32_t length, char **heapBuf)
{
    ONE_ACT_WARN_LOG(msg == NULL, return LOG_FAILURE, "[input] message_buffer is null.");
    ONE_ACT_WARN_LOG(heapBuf == NULL, return LOG_FAILURE, "[input] heap buffer array is null.");

    *heapBuf = (char *)LogMalloc(length);
    ONE_ACT_ERR_LOG(*heapBuf == NULL, return LOG_FAILURE, "malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));

    int32_t ret = memcpy_s(*heapBuf, length, msg, length);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        XFREE(*heapBuf);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : process kernel msg with timestamp, level and msg itself
 * @param[in]   : msg       input msg
 * @param[in]   : length    length of input kernel msg
 * @return      : LOG_SUCCESS success, LOG_FAILURE failure
 */
STATIC LogStatus SlogdKernelLogProcessBuf(char *msg, uint32_t length)
{
    uint64_t timestamp = 0;
    uint16_t level = 0;
    int32_t value = 0;
    char *heapBuf = NULL;

    if (SlogdKernelLogCheckParam(msg, length, &heapBuf) == LOG_FAILURE) {
        return LOG_FAILURE;
    }

    char *buf = heapBuf;
    for (; (*buf != '\0') && (SlogdKernelLogIsDigit(*buf) != 0); buf++) {
        value = *buf - '0';
        if (level > (((uint16_t)USHRT_MAX - (uint16_t)value) / BASE_DECIMAL)) {
            XFREE(heapBuf);
            return LOG_FAILURE;
        }
        level = level * BASE_DECIMAL + (uint16_t)value;
    }
    level = level & SKLOG_PRIMASK;
    buf++;

    // skip leading sequence number
    for (; (*buf != '\0') && (SlogdKernelLogIsDigit(*buf) != 0); buf++) {
    }
    buf++;

    // get timestamp
    for (; (*buf != '\0') && (SlogdKernelLogIsDigit(*buf) != 0); buf++) {
        value = *buf - '0';
        if (timestamp > (((ULONG_MAX) - (uint64_t)value) / BASE_DECIMAL)) {
            XFREE(heapBuf);
            return LOG_FAILURE;
        }
        timestamp = timestamp * BASE_DECIMAL + (uint64_t)value;
    }
    buf++;

    // skip everything before message body
    while ((*buf != '\0') && (*buf != ';')) {
        buf++;
    }
    buf++;

    SlogdKernelLogDecodeMsg(buf, length);
    int32_t ret = sprintf_s(msg, length, "<%hu>[%lu.%06lu] %s", level, timestamp / UNIT_US_TO_S, timestamp % UNIT_US_TO_S, buf);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        XFREE(heapBuf);
        return LOG_FAILURE;
    }
    XFREE(heapBuf);
    return LOG_SUCCESS;
}

/**
 * @brief       : get local timestamp in string
 * @param[out]  : timeBuffer    buffer to store timestamp
 * @param[in]   : bufLen        length of timeBuffer
 * @return      : none
 */
STATIC void SlogdKernelLogGetLocalTime(char *timeBuffer, size_t bufLen)
{
    ToolTimeval currentTimeval = { 0 };
    struct tm timeInfo = { 0 };
    ONE_ACT_WARN_LOG((ToolGetTimeOfDay(&currentTimeval, NULL)) != SYS_OK, return, "can not get time of day.");

    const time_t sec = currentTimeval.tvSec;
    ONE_ACT_WARN_LOG((ToolLocalTimeR(&sec, &timeInfo)) != SYS_OK, return, "can not get local time.");

    int err = snprintf_s(timeBuffer, bufLen, bufLen - 1U, "%04d-%02d-%02d-%02d:%02d:%02d.%03ld.%03ld",
                          timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday,
                          timeInfo.tm_hour, timeInfo.tm_min, timeInfo.tm_sec,
                          (currentTimeval.tvUsec / UNIT_US_TO_MS), (currentTimeval.tvUsec % UNIT_US_TO_MS));
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return;
    }
}

STATIC void SlogdKernelLogWrite(uint64_t priority, const char *msg)
{
    LogInfo msgInfo = {0};
    msgInfo.processType = SYSTEM;
    msgInfo.pid = (uint32_t)ToolGetPid();
    msgInfo.moduleId = KERNEL;
    msgInfo.level = DLOG_INFO;
    msgInfo.type = DEBUG_LOG;
    switch (SKLOG_PRIMASK & priority) {
        case SKLOG_EMERG:
        case SKLOG_ALERT:
        case SKLOG_CRIT:
        case SKLOG_ERROR:
            msgInfo.level = DLOG_ERROR;
            break;
        case SKLOG_WARNING:
            msgInfo.level = DLOG_WARN;
            break;
        case SKLOG_NOTICE:
            msgInfo.type = RUN_LOG;
            break;
        case SKLOG_INFO:
            msgInfo.level = DLOG_INFO;
            break;
        case SKLOG_DEBUG:
            msgInfo.level = DLOG_DEBUG;
            break;
        default:
            break;
    }
    // check log level
    if ((msgInfo.type == DEBUG_LOG) && (msgInfo.level < SlogdGetModuleLevel(msgInfo.moduleId, DEBUG_LOG_MASK))) {
        return;
    }

    // construct base info
    char timer[SLOGD_KERNEL_LOG_TIMESTAMP_LEN] = { 0 };
    SlogdKernelLogGetLocalTime(timer, SLOGD_KERNEL_LOG_TIMESTAMP_LEN);
    char buffer[SLOGD_KERNEL_LOG_RECV_BUFSIZE] = {0};
    int32_t err = snprintf_s(buffer, SLOGD_KERNEL_LOG_RECV_BUFSIZE, SLOGD_KERNEL_LOG_RECV_BUFSIZE - 1U, "[%s] %s(%u,%s):%s [%s:%d]%s",
        GetLevelNameById(msgInfo.level), GetModuleNameById(msgInfo.moduleId), msgInfo.pid, "slogd", timer,
        __FILE__, __LINE__, msg);
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s failed, msg=%s, strerr=%s.", msg, strerror(ToolGetErrorCode()));
        return;
    }

    // write to syslog buffer
    if (g_kernelLogMgr.write != NULL) {
        (void)g_kernelLogMgr.write(buffer, LogStrlen(buffer), &msgInfo);
    }
}

STATIC void SlogdKernelLogParse(const char *start)
{
    uint64_t priority = DLOG_INFO;
    char endChar = '\0';
    char *ptrEndChar = &endChar;
    ONE_ACT_ERR_LOG(start == NULL, return, "[input] start is null.");

    const char *pos = start;
    if (*pos == '<') {
        pos++;
        if ((pos != NULL) && (*pos != '\0')) {
            priority = strtoul(pos, &ptrEndChar, BASE_NUM);
        }

        if ((((priority == 0U) || (priority == ULONG_MAX)) && (errno == ERANGE)) || (priority > UINT_MAX)) {
            priority = DLOG_INFO;
        }

        if ((ptrEndChar != NULL) && (*ptrEndChar == '>')) {
            ptrEndChar++;
        }
    }

    if ((ptrEndChar != NULL) && (*ptrEndChar != '\0')) {
        SlogdKernelLogWrite(priority, ptrEndChar);
    }
}

STATIC void SlogdKernelLogReceive(void *args)
{
    (void)args;
    errno_t err = memset_s(g_kernelLogMgr.recvBuf, SLOGD_KERNEL_LOG_RECV_BUFSIZE, 0, SLOGD_KERNEL_LOG_RECV_BUFSIZE);
    NO_ACT_WARN_LOG(err != EOK, "cannot memset recv buf.");

    int32_t ret = poll(&g_kernelLogMgr.pollFd, 1, ONE_SECOND);
    if (ret < 0) {
        ONE_ACT_NO_LOG(ToolGetErrorCode() == EINTR, return);
        SELF_LOG_ERROR("poll failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        (void)ToolSleep(ONE_SECOND);
        return;
    }
    if (ret == 0) {
        return; // poll timeout
    }
    if (((uint32_t)g_kernelLogMgr.pollFd.revents & (uint32_t)POLLIN) == 0) {
        return; // no data to read
    }
    ret = (int32_t)read(g_kernelLogMgr.fd, g_kernelLogMgr.recvBuf, SLOGD_KERNEL_LOG_RECV_BUFSIZE - 1U);
    if (ret == -1) {
        SELF_LOG_ERROR("read file(%s) failed, result=%d, strerr=%s.", KERNEL_LOG_PATH, ret, strerror(ToolGetErrorCode()));
        return;
    }
    if (ret == 0) {
        return; // no data to read
    }
    g_kernelLogMgr.recvBuf[ret] = '\0';
    ret = SlogdKernelLogProcessBuf(g_kernelLogMgr.recvBuf, SLOGD_KERNEL_LOG_RECV_BUFSIZE);
    ONE_ACT_NO_LOG(ret == LOG_FAILURE, return);
    SlogdKernelLogParse(g_kernelLogMgr.recvBuf);
}

LogStatus SlogdKernelLogInit(SysLogWriteFunc func)
{
    if (!SlogdKernelLogIsNeedInit()) {
        return LOG_SUCCESS;
    }
    SELF_LOG_INFO("init kernel log.");
    g_kernelLogMgr.fd = open(KERNEL_LOG_PATH, O_RDONLY | O_NONBLOCK, 0);
    ONE_ACT_ERR_LOG(g_kernelLogMgr.fd == INVALID, return LOG_FAILURE,
        "open file failed, file=%s, strerr=%s.", KERNEL_LOG_PATH, strerror(ToolGetErrorCode()))

    off_t ret = lseek(g_kernelLogMgr.fd, 0, SEEK_END);
    if (ret == INVALID) {
        SELF_LOG_ERROR("lseek file failed, file=%s, strerr=%s.", KERNEL_LOG_PATH, strerror(ToolGetErrorCode()));
        LOG_CLOSE_FD(g_kernelLogMgr.fd);
        return LOG_FAILURE;
    }
    g_kernelLogMgr.pollFd.fd = g_kernelLogMgr.fd;
    g_kernelLogMgr.pollFd.events = POLLIN;

    g_kernelLogMgr.recvBuf = (char *)LogMalloc(SLOGD_KERNEL_LOG_RECV_BUFSIZE);
    ONE_ACT_ERR_LOG(g_kernelLogMgr.recvBuf == NULL, return LOG_FAILURE,
        "malloc failed, strerr=%s.", strerror(ToolGetErrorCode()))
    g_kernelLogMgr.write = func;

    LogReceiveNode recvNode = {SYS_LOG_PRIORITY, SlogdKernelLogReceive};
    int32_t result = SlogdComReceiveRegister(&recvNode);
    ONE_ACT_ERR_LOG(result != LOG_SUCCESS, return LOG_FAILURE, "kernel log register receive node failed, ret=%d.", result);
    return LOG_SUCCESS;
}

void SlogdKernelLogExit(void)
{
    if (!SlogdKernelLogIsNeedInit()) {
        return;
    }
    LOG_CLOSE_FD(g_kernelLogMgr.fd);
    XFREE(g_kernelLogMgr.recvBuf);
    g_kernelLogMgr.write = NULL;
}
