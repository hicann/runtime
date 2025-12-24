/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_util.h"
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <ctype.h>
#include <sys/ptrace.h>
#include "securec.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "atrace_types.h"
#include "scd_log.h"

#define MIN(a, b) ((a) > (b) ? (b) : (a))

TraStatus ScdUtilTrim(char *start, uint32_t len, const char **pos)
{
    if ((start == NULL) || (len == 0)) {
        return TRACE_FAILURE;
    }

    char *end = start + strlen(start);
    if (start == end) {
        *pos = start;
        return TRACE_SUCCESS;
    }

    while ((start < end) && (isspace((int)(*start)) != 0)) {
        start++;
    }
    if (start == end) {
        *pos = start;
        return TRACE_SUCCESS;
    }

    while ((start < end) && (isspace((int)(*(end - 1))) != 0)) {
        end--;
    }

    *end = '\0';
    *pos = start;
    return TRACE_SUCCESS;
}

TraStatus ScdUtilReadStdin(void *buf, size_t len)
{
    SCD_CHK_PTR_ACTION(buf, return TRACE_FAILURE);
    size_t readLen = 0;

    while(len > readLen) {
        ssize_t readSize = SCD_UTIL_RETRY(read(STDIN_FILENO, (void *)((uint8_t *)buf + readLen), len - readLen));
        if (readSize <= 0) {
            SCD_DLOG_ERR("read from stdin failed, ret=%ld, errno=%d.", readSize, errno);
            return TRACE_FAILURE;
        }
        readLen += (size_t)readSize;
    }
    return TRACE_SUCCESS;
}

ssize_t ScdUtilReadLine(int32_t fd, char *buf, size_t len)
{
    if (fd < 0 || buf == NULL || len == 0) {
        return -1;
    }

    ssize_t n = 1;
    char c = (char)EOF;
    char *ptr = buf;
    while (n < (ssize_t)len) {
        ssize_t rc = read(fd, &c, 1);
        if (rc == 1) {
            *ptr = c;
            ptr++;
            if (c == '\n') {
                break;
            }
        } else if (rc == 0) {
            *ptr = '\0';
            return (n - 1);
        } else {
            if (errno == EINTR) {
                continue;
            }
            return -1;
        }
        n++;
    }
    *ptr = '\0';
    return n;
}

STATIC TraStatus ScdUtilGetTaskName(const char *path, char *buf, size_t len)
{
    int32_t fd = open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0) {
        SCD_DLOG_WAR("can not open file[%s], errno=%d.", path, errno);
        return TRACE_FAILURE;
    }
    // read a line
    char tmp[SCD_UTIL_TMP_BUF_LEN] = {0};
    ssize_t ret = ScdUtilReadLine(fd, tmp, SCD_UTIL_TMP_BUF_LEN);
    (void)close(fd);
    if (ret <= 0) {
        SCD_DLOG_WAR("can not read line from file[%s], errno=%d.", path, errno);
        return TRACE_FAILURE;
    }

    // trim
    const char *data = NULL;
    if ((ScdUtilTrim(tmp, SCD_UTIL_TMP_BUF_LEN, &data) != TRACE_SUCCESS) || (strlen(data) == 0)) {
        SCD_DLOG_WAR("file line is empty.");
        return TRACE_FAILURE;
    }
    size_t dataLen = strlen(data);
    size_t copyLen = SCD_MIN(len - 1U, dataLen);
    errno_t err = strncpy_s(buf, len, data, copyLen);
    if (err != EOK) {
        SCD_DLOG_WAR("can not strncpy_s, ret=%d, errno=%d", (int32_t)err, errno);
        return TRACE_FAILURE;
    }

    buf[copyLen] = '\0';
    return TRACE_SUCCESS;
}

STATIC void ScdUtilSetUnknown(char *buf, size_t len)
{
    errno_t ret = strncpy_s(buf, len, "unknown", strlen("unknown"));
    if (ret != 0) {
        SCD_DLOG_ERR("strncpy_s failed. (ret=%d)\n", (int32_t)ret);
    }
}

void ScdUtilGetProcessName(int32_t pid, char *buf, size_t len)
{
    char path[SCD_UTIL_TMP_BUF_LEN] = {0};

    int32_t ret = snprintf_s(path, SCD_UTIL_TMP_BUF_LEN, SCD_UTIL_TMP_BUF_LEN - 1U, "/proc/%d/cmdline", pid);
    if (ret == -1) {
        SCD_DLOG_WAR("can not snprintf_s, set process name to unknown.");
        ScdUtilSetUnknown(buf, len);
        return;
    }

    if (ScdUtilGetTaskName(path, buf, len) != TRACE_SUCCESS) {
        SCD_DLOG_WAR("can not get process name by file[%s], set process name to unknown.", path);
        ScdUtilSetUnknown(buf, len);
    }
}

void ScdUtilGetThreadName(int32_t pid, int32_t tid, char *buf, size_t len)
{
    char path[SCD_UTIL_TMP_BUF_LEN] = {0};
    int32_t ret = snprintf_s(path, sizeof(path), sizeof(path) - 1U, "/proc/%d/task/%d/comm", pid, tid);
    if (ret == -1) {
        SCD_DLOG_WAR("can not snprintf_s, set thread name to unknown.");
        ScdUtilSetUnknown(buf, len);
        return;
    }

    if (ScdUtilGetTaskName(path, buf, len) != TRACE_SUCCESS) {
        SCD_DLOG_WAR("can not get thread name by file[%s], set thread name to unknown.", path);
        ScdUtilSetUnknown(buf, len);
    }
}

STATIC TraStatus ScdUtilPtraceReadLong(int32_t pid, uintptr_t addr, long *value)
{
    errno = 0;
    long ret = ptrace(PTRACE_PEEKTEXT, pid, addr, NULL);
    if (ret == -1 && errno != 0) {
        SCD_DLOG_ERR("ptrace peektext failed, ret %ld, error : %s", ret, strerror(errno));
        return TRACE_FAILURE; 
    }
    *value = ret;
    return TRACE_SUCCESS;
}

size_t ScdUtilsPtraceRead(int32_t pid, uintptr_t src, void *dst, size_t dstLen)
{
    size_t readSize = dstLen;
    void *dstPos = dst;
    uintptr_t srcAddr = src;
    long data = 0;
    size_t alignBytes = srcAddr & (sizeof(long) - 1U);
    if (alignBytes != 0) {
        TraStatus ret = ScdUtilPtraceReadLong(pid, srcAddr & ~(sizeof(long) - 1U), &data);
        if (ret != TRACE_SUCCESS) {
            return 0;
        }
        size_t readLen = MIN(readSize, sizeof(long) - alignBytes);
        errno_t err = memcpy_s(dstPos, readSize, (const void *)((uintptr_t)(&data) + alignBytes), readLen);
        if (err != EOK) {
            SCD_DLOG_ERR("memcpy_s failed, err = %d, errno = %d.", (int32_t)err, errno);
            return 0;
        }
        srcAddr += readLen;
        dstPos = (void *)((uintptr_t)dstPos + readLen);
        readSize -= readLen;
    }

    for (size_t i =  readSize / sizeof(long); i > 0; i--) {
        TraStatus ret = ScdUtilPtraceReadLong(pid, srcAddr, &data);
        if (ret != TRACE_SUCCESS) {
            return 0;
        }
        errno_t err = memcpy_s(dstPos, readSize, &data, sizeof(long));
        if (err != EOK) {
            SCD_DLOG_ERR("memcpy_s failed, err = %d, errno = %d.", (int32_t)err, errno);
            return 0;
        }
        srcAddr += sizeof(long);
        dstPos = (void *)((uintptr_t)dstPos + sizeof(long));
        readSize -= sizeof(long);
    }
    if (readSize != 0) {
        TraStatus ret = ScdUtilPtraceReadLong(pid, srcAddr, &data);
        if (ret != TRACE_SUCCESS) {
            return 0;
        }
        errno_t err = memcpy_s(dstPos, readSize, &data, readSize);
        if (err != EOK) {
            SCD_DLOG_ERR("memcpy_s failed, err = %d, errno = %d.", (int32_t)err, errno);
            return 0;
        }
    }
    return dstLen;
}

int32_t ScdUtilOpen(const char *path)
{
    char realPath[TRACE_MAX_PATH] = {0};
    if ((TraceRealPath(path, realPath, TRACE_MAX_PATH) != EN_OK) && (AdiagGetErrorCode() != ENOENT)) {
        SCD_DLOG_ERR("can not get realpath, path=%s, strerr=%s.", path, strerror(AdiagGetErrorCode()));
        return -1;
    }

    int32_t fd = open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0) {
        SCD_DLOG_ERR("open %s failed, stderr=%s.", path, strerror(AdiagGetErrorCode()));
        return -1;
    }
    return fd;
}

size_t ScdUtilWrite(int32_t fd, const void *data, size_t len)
{
    if ((fd < 0) || (data == NULL) || (len == 0)) {
        SCD_DLOG_ERR("invalid input, fd=%d, data=%p, len=%zu.", fd, data, len);
        return 0;
    }

    size_t reserved = len;
    do {
        ssize_t wrLen = write(fd, (const void *)((uintptr_t)data + (len - reserved)), reserved);
        if ((wrLen < 0) || (errno == EINTR)) {
            SCD_DLOG_ERR("write failed, ret=%ld, errno=%d.", wrLen, errno);
            return len - reserved;
        }
        reserved -= (size_t)wrLen;
    } while (reserved != 0);
    return len;
}

void ScdUtilWriteTitle(int32_t fd, const char *title)
{
    (void)ScdUtilWrite(fd, title, strlen(title));
    ScdUtilWriteNewLine(fd);
}

void ScdUtilWriteNewLine(int32_t fd)
{
    (void)ScdUtilWrite(fd, "\n", 1);
}

int32_t ScdUtilGetProcFd(int32_t pid, const char* fileName)
{
    char path[SCD_UTIL_TMP_BUF_LEN] = {0};
    int32_t err;
    if (pid == -1) {
        err = snprintf_s(path, SCD_UTIL_TMP_BUF_LEN, SCD_UTIL_TMP_BUF_LEN - 1U, "/proc/%s", fileName);
    } else {
        err = snprintf_s(path, SCD_UTIL_TMP_BUF_LEN, SCD_UTIL_TMP_BUF_LEN - 1U, "/proc/%d/%s", pid, fileName);
    }
    if (err == -1) {
        SCD_DLOG_ERR("snprintf_s proc file name failed, pid=%d, file name[%s].", pid, fileName);
        return -1;
    }

    return ScdUtilOpen(path);
}

TraStatus ScdUtilWriteProcInfo(int32_t fd, int32_t pid, const char* fileName)
{
    int32_t procFd = ScdUtilGetProcFd(pid, fileName);
    if (procFd < 0) {
        return TRACE_FAILURE;
    }

    char info[SCD_UTIL_TMP_BUF_LEN] = { 0 };
    while (ScdUtilReadLine(procFd, info, SCD_UTIL_TMP_BUF_LEN) > 0) {
        size_t ret = ScdUtilWrite(fd, info, strlen(info));
        if (ret != strlen(info)) {
            SCD_DLOG_ERR("write proc info to file failed, ret=%d, errno=%d", ret, errno);
            (void)close(procFd);
            return TRACE_FAILURE;
        }
    }

    SCD_DLOG_INF("write proc file[%s] info to file successfully.", fileName);
    (void)close(procFd);
    return TRACE_SUCCESS;
}