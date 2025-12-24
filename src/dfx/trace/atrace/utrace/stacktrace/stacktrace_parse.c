/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_parse.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include "securec.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "stacktrace_logger.h"
#include "stacktrace_file_struct.h"

#define MAX_BUFFER_LENGTH   1024U
#define TXT_FILE_MODE       0640U
#define PROCESS_SECTION                     "[process]\n"
#define STACK_SECTION                       "[stack]\n"

/**
 * @brief       safe write data to file
 * @param [in]  fd:         file descriptor
 * @param [in]  data:       write data
 * @param [in]  len:        data buffer length
 * @return      TraStatus
 */
static TraStatus TraceWrite(int32_t fd, const char *data, size_t len)
{
    if ((fd < 0) || (data == NULL) || (len == 0)) {
        return TRACE_INVALID_PARAM;
    }

    size_t reserved = len;
    do {
        ssize_t wrLen = write(fd, data + (len - reserved), reserved);
        if (wrLen < 0 && errno == EINTR) {
            wrLen = 0;
        } else if (wrLen < 0) {
            return TRACE_FAILURE;
        } else {
            ;
        }
        reserved -= (size_t)wrLen;
    } while (reserved != 0);
    return TRACE_SUCCESS;
}

static TraStatus TraceCheckBinPath(const char *filePath, uint32_t len)
{
    if (len >= TRACE_MAX_PATH) {
        LOGE("path length [%u] bytes exceeds [%d] bytes", len, TRACE_MAX_PATH);
        return TRACE_INVALID_PARAM;
    }
    if (len == 0) {
        LOGE("path length is 0 bytes");
        return TRACE_INVALID_PARAM;
    }
    if (access(filePath, F_OK) != 0) {
        LOGE("input path [%s] does not exist", filePath);
        return TRACE_INVALID_PARAM;
    }
    char *suffix = strrchr(filePath, '.');
    if ((suffix != NULL) && strcmp(suffix, ".bin") == 0) {
        return TRACE_SUCCESS;
    } else {
        LOGE("invalid path [%s]", filePath);
        return TRACE_INVALID_PARAM;
    }
}

static TraStatus TraceCheckBinHead(const struct ScHead *head)
{
    if ((head->magic == STACK_HEAD_MAGIC) && (head->version == STACK_HEAD_VERSION)) {
        LOGR("check head successfully, magic=%x, version=%x.", head->magic, head->version);
        return TRACE_SUCCESS;
    }
    LOGE("check head failed, magic=%x, version=%x.", head->magic, head->version);
    return TRACE_FAILURE;
}

STATIC int32_t TraceGetTxtFd(const char *filePath, uint32_t len)
{
    (void)len;
    char *fullPath = strdup(filePath);
    char *pos = strstr(fullPath, ".bin");
    if (pos == NULL) {
        LOGE("find string failed, path = %s.", filePath);
        ADIAG_SAFE_FREE(fullPath);
        return -1;
    }
    errno_t err = strncpy_s(pos, strlen(pos) + 1U, ".txt", strlen(".txt"));
    if (err != EOK) {
        LOGE("strncpy_s failed, path = %s.", filePath);
        ADIAG_SAFE_FREE(fullPath);
        return -1;
    }

    int32_t fd = open(fullPath, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND, TXT_FILE_MODE);
    if (fd >= 0) {
        (void)fchmod(fd, TXT_FILE_MODE);
    }
    ADIAG_SAFE_FREE(fullPath);
    return fd;
}

static void TraceWriteProcessReg(int32_t fd, const ScProcessInfo *info)
{
    char tmpBuf[MAX_BUFFER_LENGTH] = { 0 };
    int32_t ret = -1;
#if defined(__aarch64__)
    ret = snprintf_s(tmpBuf, MAX_BUFFER_LENGTH, MAX_BUFFER_LENGTH - 1U,
        "crash registers:\n"
        "    x0  0x%016lx  x1  0x%016lx  x2  0x%016lx  x3  0x%016lx\n"
        "    x4  0x%016lx  x5  0x%016lx  x6  0x%016lx  x7  0x%016lx\n"
        "    x8  0x%016lx  x9  0x%016lx  x10 0x%016lx  x11 0x%016lx\n"
        "    x12 0x%016lx  x13 0x%016lx  x14 0x%016lx  x15 0x%016lx\n"
        "    x16 0x%016lx  x17 0x%016lx  x18 0x%016lx  x19 0x%016lx\n"
        "    x20 0x%016lx  x21 0x%016lx  x22 0x%016lx  x23 0x%016lx\n"
        "    x24 0x%016lx  x25 0x%016lx  x26 0x%016lx  x27 0x%016lx\n"
        "    x28 0x%016lx  x29 0x%016lx\n"
        "    sp  0x%016lx  lr  0x%016lx  pc  0x%016lx\n\n",
        info->regs[SCD_REGS_X0],
        info->regs[SCD_REGS_X1],
        info->regs[SCD_REGS_X2],
        info->regs[SCD_REGS_X3],
        info->regs[SCD_REGS_X4],
        info->regs[SCD_REGS_X5],
        info->regs[SCD_REGS_X6],
        info->regs[SCD_REGS_X7],
        info->regs[SCD_REGS_X8],
        info->regs[SCD_REGS_X9],
        info->regs[SCD_REGS_X10],
        info->regs[SCD_REGS_X11],
        info->regs[SCD_REGS_X12],
        info->regs[SCD_REGS_X13],
        info->regs[SCD_REGS_X14],
        info->regs[SCD_REGS_X15],
        info->regs[SCD_REGS_X16],
        info->regs[SCD_REGS_X17],
        info->regs[SCD_REGS_X18],
        info->regs[SCD_REGS_X19],
        info->regs[SCD_REGS_X20],
        info->regs[SCD_REGS_X21],
        info->regs[SCD_REGS_X22],
        info->regs[SCD_REGS_X23],
        info->regs[SCD_REGS_X24],
        info->regs[SCD_REGS_X25],
        info->regs[SCD_REGS_X26],
        info->regs[SCD_REGS_X27],
        info->regs[SCD_REGS_X28],
        info->regs[SCD_REGS_X29],
        info->regs[SCD_REGS_SP],
        info->regs[SCD_REGS_LR],
        info->regs[SCD_REGS_PC]);
#elif defined(__x86_64__)
    ret = snprintf_s(tmpBuf, MAX_BUFFER_LENGTH, MAX_BUFFER_LENGTH - 1U,
        "crash registers:\n"
        "    rax 0x%016lx  rbx 0x%016lx  rcx 0x%016lx  rdx 0x%016lx\n"
        "    r8  0x%016lx  r9  0x%016lx  r10 0x%016lx  r11 0x%016lx\n"
        "    r12 0x%016lx  r13 0x%016lx  r14 0x%016lx  r15 0x%016lx\n"
        "    rdi 0x%016lx  rsi 0x%016lx\n"
        "    rbp 0x%016lx  rsp 0x%016lx  rip 0x%016lx\n\n",
        info->regs[SCD_REGS_RAX],
        info->regs[SCD_REGS_RBX],
        info->regs[SCD_REGS_RCX],
        info->regs[SCD_REGS_RDX],
        info->regs[SCD_REGS_R8],
        info->regs[SCD_REGS_R9],
        info->regs[SCD_REGS_R10],
        info->regs[SCD_REGS_R11],
        info->regs[SCD_REGS_R12],
        info->regs[SCD_REGS_R13],
        info->regs[SCD_REGS_R14],
        info->regs[SCD_REGS_R15],
        info->regs[SCD_REGS_RDI],
        info->regs[SCD_REGS_RSI],
        info->regs[SCD_REGS_RBP],
        info->regs[SCD_REGS_RSP],
        info->regs[SCD_REGS_RIP]);
#else
    (void)info;
#endif

    if (ret == -1) {
        LOGE("snprintf_s failed, ret = %d, errno = %d.", ret, errno);
        return;
    }
    (void)TraceWrite(fd, tmpBuf, strlen(tmpBuf));
}

STATIC void TraceWriteKernelVersion(int32_t fd)
{
    char tmpBuf[MAX_BUFFER_LENGTH] = { 0 };
    int32_t ret = snprintf_s(tmpBuf, MAX_BUFFER_LENGTH, MAX_BUFFER_LENGTH - 1U,
        "kernel version: unknown\n");
    if (ret == -1) {
        LOGE("snprintf_s failed, ret = %d, errno = %d.", ret, errno);
        return;
    }

    FILE *fp = popen("uname -a", "r");
    if (fp == NULL) {
        LOGE("get kernel version failed, errno=%d.", errno);
        (void)TraceWrite(fd, tmpBuf, strlen(tmpBuf));
        return;
    }

    char kernelVersion[MAX_BUFFER_LENGTH] = { 0 };
    if (fgets(kernelVersion, (int32_t)sizeof(kernelVersion), fp) != NULL) {
        ret = snprintf_s(tmpBuf, MAX_BUFFER_LENGTH, MAX_BUFFER_LENGTH - 1U,
            "kernel version: %s", kernelVersion);
        if (ret == -1) {
            LOGE("snprintf_s failed, ret = %d, errno = %d.", ret, errno);
        }
    }
    (void)pclose(fp);
    (void)TraceWrite(fd, tmpBuf, strlen(tmpBuf));
}

static void TraceWriteProcess(int32_t fd, const ScProcessInfo *info)
{
    char tmpBuf[MAX_BUFFER_LENGTH] = { 0 };
    int32_t ret = snprintf_s(tmpBuf, MAX_BUFFER_LENGTH, MAX_BUFFER_LENGTH - 1U,
        PROCESS_SECTION
        "crash task:%s\n"
        "crash pid:%d\n"
        "crash tid:%d\n"
        "crash stack base:0x%016lx\n"
        "crash stack top:0x%016lx\n"
        "crash reason: signal %d\n",
        info->task,
        info->pid,
        info->crashTid,
        info->baseAddr,
        info->topAddr,
        info->signo);
    if (ret == -1) {
        LOGE("snprintf_s failed, ret = %d, errno = %d.", ret, errno);
        return;
    }
    (void)TraceWrite(fd, tmpBuf, strlen(tmpBuf));
    TraceWriteKernelVersion(fd);
    TraceWriteProcessReg(fd, info);
}

static void TraceWriteStack(int32_t fd, const struct ScThreadInfo *data)
{
    (void)TraceWrite(fd, STACK_SECTION, strlen(STACK_SECTION));
    char tmpBuf[MAX_BUFFER_LENGTH] = { 0 };
    for (uint32_t i = 0; i < MAX_THREAD_NUM; i++) {
        if(data[i].tid == 0) {
            break;
        }
        int32_t ret = snprintf_s(tmpBuf, MAX_BUFFER_LENGTH, MAX_BUFFER_LENGTH - 1U, "Thread %u (%d, %s)\n",
            i + 1U, data[i].tid, data[i].name);
        if (ret == -1) {
            LOGE("snprintf_s failed, ret = %d, errno = %d.", ret, errno);
            return;
        }
        (void)TraceWrite(fd, tmpBuf, strlen(tmpBuf));
        for (int32_t j = 0; j <= data[i].layer; j++) {
            (void)TraceWrite(fd, data[i].frames[j].frame, strlen(data[i].frames[j].frame));
        }
        (void)TraceWrite(fd, "\n", strlen("\n"));
    }
}

static void TraceWriteTxt(int32_t fd, const struct StackcoreBuffer *data)
{
    TraceWriteProcess(fd, &data->process);
    TraceWriteStack(fd, data->thread);
    return;
}

STATIC TraStatus TraceParseBinFile(const char *filePath, uint32_t len)
{
    int32_t binFile = open(filePath, O_RDONLY);
    if (binFile == -1) {
        LOGE("could not open file [%s]", filePath);
        return TRACE_INVALID_PARAM;
    }

    struct StackcoreBuffer *data = (struct StackcoreBuffer *)AdiagMalloc(sizeof(struct StackcoreBuffer));
    if (data == NULL) {
        TraceClose(&binFile);
        LOGE("malloc failed.");
        return TRACE_FAILURE;
    }

    ssize_t readBytes = read(binFile, data, sizeof(struct StackcoreBuffer));
    if ((size_t)readBytes != sizeof(struct StackcoreBuffer)) {
        TraceClose(&binFile);
        ADIAG_SAFE_FREE(data);
        LOGE("can not read data from file [%s]", filePath);
        return TRACE_INVALID_PARAM;
    }

    TraStatus ret = TraceCheckBinHead(&data->head);
    if (ret != TRACE_SUCCESS) {
        TraceClose(&binFile);
        ADIAG_SAFE_FREE(data);
        return ret;
    }

    int32_t txtFile = TraceGetTxtFd(filePath, len);
    if (txtFile == -1) {
        LOGE("could not open txt file[%s]", filePath);
        TraceClose(&binFile);
        ADIAG_SAFE_FREE(data);
        return TRACE_FAILURE;
    }

    TraceWriteTxt(txtFile, data);

    char tmpBuf[MAX_BUFFER_LENGTH] = { 0 };
    do {
        readBytes = read(binFile, tmpBuf, MAX_BUFFER_LENGTH);
        (void)TraceWrite(txtFile, tmpBuf, (size_t)readBytes);
    } while (readBytes > 0);

    ADIAG_SAFE_FREE(data);
    TraceClose(&binFile);
    TraceClose(&txtFile);
    return TRACE_SUCCESS;
}

TraStatus TraceStackParse(const char *filePath, uint32_t len)
{
    LOGR("start to parse bin file[%s]", filePath);
    TraStatus ret = TraceCheckBinPath(filePath, len);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    char realPath[TRACE_MAX_PATH] = { 0 };
    if ((TraceRealPath(filePath, realPath, TRACE_MAX_PATH) != EN_OK) && (AdiagGetErrorCode() != ENOENT)) {
        LOGE("can not get realpath, path=%s, strerr=%s.", filePath, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }

    ret = TraceParseBinFile(realPath, (uint32_t)strlen(realPath));
    if (ret != TRACE_SUCCESS) {
        return ret;
    }

    if (remove(realPath) != 0) {
        LOGW("can not remove file [%s]", realPath);
        return TRACE_SUCCESS;
    }

    return TRACE_SUCCESS;
}