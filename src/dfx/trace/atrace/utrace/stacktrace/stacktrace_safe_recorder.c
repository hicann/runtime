/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_safe_recorder.h"
#include <errno.h>
#include "securec.h"
#include "stacktrace_logger.h"
#include "stacktrace_file_struct.h"
#include "trace_recorder.h"
#include "trace_system_api.h"
#include "trace_types.h"
#include "adiag_utils.h"
#include "adiag_print.h"

#define PROCESS_SECTION                     "[process]\n"
#define STACK_SECTION                       "[stack]\n"
#define MAPS_SECTION                        "[maps]\n"
#define MEMORY_SECTION                      "[system memory]\n"
#define STATUS_SECTION                      "[process status]\n"
#define LIMITS_SECTION                      "[process limits]\n"

#define PROC_MEMINFO_PATH                   "/proc/meminfo"

STATIC TraceStackInfo g_stackInfo = { 0 };
STATIC struct StackcoreBuffer g_stackBuff = { 0 };

/**
 * @brief       read a line data from file
 * @param [in]  fd:         file descriptor
 * @param [in]  data:       write data
 * @param [in]  len:        data buffer length
 * @return      >0  success; -1  failed
 */
ssize_t TraceSafeReadLine(int32_t fd, char *data, uint32_t len)
{
    if (fd < 0 || data == NULL || len == 0) {
        return -1;
    }

    ssize_t n = 1;
    char c = (char)EOF;
    char *ptr = data;
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

/**
 * @brief       safe write data to file
 * @param [in]  fd:         file descriptor
 * @param [in]  data:       write data
 * @param [in]  len:        data buffer length
 * @return      TraStatus
 */
STATIC TraStatus TraceSafeWrite(int32_t fd, const char *data, size_t len)
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

const char* TraceSafeGetFilePath(void)
{
    return TraceRecorderSafeGetFilePath();
}

/**
 * @brief       get fd to write stackcore file
                use for signal_callback_func, only call reentrant function
 * @param [in]  info:           info, for dir name and file name
 * @param [in]  suffix:         file suffix
 * @param [out] fd:             file handle
 * @return      TraStatus
 */
TraStatus TraceSafeGetFd(const TraceStackRecorderInfo *info, const char *suffix, int32_t *fd)
{
    if ((info == NULL) || (fd == NULL)) {
        return TRACE_INVALID_PARAM;
    }

    char timeString[TIMESTAMP_MAX_LENGTH] = { 0 };
    uint64_t fileTime = GetRealTime();
    TraStatus ret = TimestampToFileStr(fileTime, timeString, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    char objName[MAX_FILEPATH_LEN] = { 0 };
    int32_t err = snprintf_s(objName, MAX_FILEPATH_LEN, MAX_FILEPATH_LEN - 1U,
        "%d_%d_%s_%s", info->signo, info->tid, program_invocation_short_name, timeString);
    if (err == -1) {
        return TRACE_FAILURE;
    }

    // get dir time by crash time
    ret = TimestampToFileStr(info->crashTime, timeString, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }

    g_stackBuff.head.magic = STACK_HEAD_MAGIC;
    g_stackBuff.head.version = STACK_HEAD_VERSION;
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, info->pid, timeString };
    TraceFileInfo fileInfo = { TRACER_STACKCORE_NAME, objName, suffix };
    return TraceRecorderSafeGetFd(&dirInfo, &fileInfo, fd);
}

TraceStackInfo *TraceSafeGetStackBuffer(void)
{
    return &g_stackInfo;
}

/**
 * @brief       write "system memory" info
 * @param [in]  fd:     handle of stack core file
 * @return      TraStatus
 */
STATIC TraStatus TraceSafeWriteMemoryInfo(int32_t fd)
{
    // write title [system memory]
    TraStatus ret = TraceSafeWrite(fd, MEMORY_SECTION, strlen(MEMORY_SECTION));
    if (ret != TRACE_SUCCESS) {
        LOGE("write memory title failed, ret=%d, errno=%d", ret, errno);
        return ret;
    }

    // write memory info
    int32_t memFd = open(PROC_MEMINFO_PATH, O_RDONLY);
    if (memFd < 0) {
        LOGE("memory info file open failed, errno=%d", errno);
        return TRACE_FAILURE;
    }

    char info[CORE_BUFFER_LEN] = { 0 };
    while (TraceSafeReadLine(memFd, info, CORE_BUFFER_LEN) > 0) {
        ret = TraceSafeWrite(fd, info, strlen(info));
        if (ret != TRACE_SUCCESS) {
            LOGE("write memory info to file failed, ret=%d, errno=%d", ret, errno);
            TraceClose(&memFd);
            return ret;
        }
    }
    TraceClose(&memFd);
    (void)TraceSafeWrite(fd, "\n", 1);
    return TRACE_SUCCESS;
}

/**
 * @brief       write "process status" info
 * @param [in]  fd:     handle of stack core file
 * @param [in]  pid:    process id
 * @return      TraStatus
 */
STATIC TraStatus TraceSafeWriteStatusInfo(int32_t fd, int32_t pid)
{
    // write title [process status]
    TraStatus ret = TraceSafeWrite(fd, STATUS_SECTION, strlen(STATUS_SECTION));
    if (ret != TRACE_SUCCESS) {
        LOGE("write status title failed, ret=%d, errno=%d", ret, errno);
        return ret;
    }
    char path[CORE_BUFFER_LEN] = { 0 };
    int32_t err = snprintf_s(path, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U, "/proc/%d/status", pid);
    if (err == -1) {
        LOGE("snprintf_s status path failed");
        return TRACE_FAILURE;
    }
    // write status info
    int32_t statFd = open(path, O_RDONLY);
    if (statFd < 0) {
        LOGE("status file open failed, errno=%d", errno);
        return TRACE_FAILURE;
    }

    char info[CORE_BUFFER_LEN] = { 0 };
    while (TraceSafeReadLine(statFd, info, CORE_BUFFER_LEN) > 0) {
        ret = TraceSafeWrite(fd, info, strlen(info));
        if (ret != TRACE_SUCCESS) {
            LOGE("write status info to file failed, ret=%d, errno=%d", ret, errno);
            TraceClose(&statFd);
            return ret;
        }
    }
    TraceClose(&statFd);
    (void)TraceSafeWrite(fd, "\n", 1);
    return TRACE_SUCCESS;
}


/**
 * @brief       write "process limits" info
 * @param [in]  fd:     handle of stack core file
 * @param [in]  pid:    process id
 * @return      TraStatus
 */
STATIC TraStatus TraceSafeWriteLimitsInfo(int32_t fd, int32_t pid)
{
    // write title [process limits]
    TraStatus ret = TraceSafeWrite(fd, LIMITS_SECTION, strlen(LIMITS_SECTION));
    if (ret != TRACE_SUCCESS) {
        LOGE("write limits title failed, ret=%d, errno=%d", ret, errno);
        return ret;
    }
    char path[CORE_BUFFER_LEN] = { 0 };
    int32_t err = snprintf_s(path, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U, "/proc/%d/limits", pid);
    if (err == -1) {
        LOGE("snprintf_s limits path failed");
        return TRACE_FAILURE;
    }
    // write limits info
    int32_t limitsFd = open(path, O_RDONLY);
    if (limitsFd < 0) {
        LOGE("limits file open failed, errno=%d", errno);
        return TRACE_FAILURE;
    }

    char info[CORE_BUFFER_LEN] = { 0 };
    while (TraceSafeReadLine(limitsFd, info, CORE_BUFFER_LEN) > 0) {
        ret = TraceSafeWrite(fd, info, strlen(info));
        if (ret != TRACE_SUCCESS) {
            LOGE("write limits info to file failed, ret=%d, errno=%d", ret, errno);
            TraceClose(&limitsFd);
            return ret;
        }
    }
    TraceClose(&limitsFd);
    (void)TraceSafeWrite(fd, "\n", 1);
    return TRACE_SUCCESS;
}

/**
 * @brief       write "maps" info
 * @param [in]  fd:     handle of stack core file
 * @param [in]  pid:    process id
 * @return      TraStatus
 */
STATIC TraStatus TraceSafeWriteMapsInfo(int32_t fd, int32_t pid)
{
    // write title [maps]
    TraStatus ret = TraceSafeWrite(fd, MAPS_SECTION, strlen(MAPS_SECTION));
    if (ret != TRACE_SUCCESS) {
        LOGE("write maps title failed, ret=%d, errno=%d", ret, errno);
        return ret;
    }

    char path[CORE_BUFFER_LEN] = { 0 };
    int32_t err = snprintf_s(path, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U, "/proc/%d/maps", pid);
    if (err == -1) {
        LOGE("snprintf_s maps path failed");
        return TRACE_FAILURE;
    }
    // write maps info
    int32_t mapFd = open(path, O_RDONLY);
    if (mapFd < 0) {
        LOGE("self map open failed, errno=%d", errno);
        return TRACE_FAILURE;
    }

    char info[CORE_BUFFER_LEN] = { 0 };
    while (TraceSafeReadLine(mapFd, info, CORE_BUFFER_LEN) > 0) {
        ret = TraceSafeWrite(fd, info, strlen(info));
        if (ret != TRACE_SUCCESS) {
            LOGE("write maps info to file failed, ret=%d, errno=%d", ret, errno);
            TraceClose(&mapFd);
            return ret;
        }
    }
    TraceClose(&mapFd);
    (void)TraceSafeWrite(fd, "\n", 1);
    return TRACE_SUCCESS;
}

/**
 * @brief       write "system memory" info
 * @param [in]  fd:     handle of stack core file
 * @param [in]  pid:    process id
 * @return      TraStatus
 */
TraStatus TraceSafeWriteSystemInfo(int32_t fd, int32_t pid)
{
    TraStatus ret = TraceSafeWriteMapsInfo(fd, pid);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not write maps info to file, ret=%d.", ret);
    }

    ret = TraceSafeWriteMemoryInfo(fd);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not write memory info to file, ret=%d.", ret);
    }

    ret = TraceSafeWriteStatusInfo(fd, pid);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not write process info to file, ret=%d.", ret);
    }

    ret = TraceSafeWriteLimitsInfo(fd, pid);
    if (ret != TRACE_SUCCESS) {
        LOGW("can not write limits info to file, ret=%d.", ret);
    }

    return TRACE_SUCCESS;
}

/**
 * @brief       write "stack" info
 * @param [in]  fd:     handle of stack core file
 * @param [in]  info:   stack info
 * @return      TraStatus
 */
TraStatus TraceSafeWriteStackInfo(int32_t fd, const TraceStackInfo *info)
{
    if (info == NULL) {
        return TRACE_INVALID_PARAM;
    }

    // write title [stack]
    TraStatus ret = TRACE_FAILURE;
    if (info->threadIdx == 0) {
        ret = TraceSafeWrite(fd, STACK_SECTION, strlen(STACK_SECTION));
        if (ret != TRACE_SUCCESS) {
            LOGE("write stack title failed, errno=%d", errno);
            return ret;
        }
    }

    // write stack info
    char buf[CORE_BUFFER_LEN] = { 0 };
    (void)snprintf_s(buf, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U, "Thread %u (%d, %s)\n",
        info->threadIdx + 1U, info->threadTid, info->threadName);
    (void)TraceSafeWrite(fd, buf, strlen(buf));

    int32_t layer = info->layer;
    if (layer < 0) {
        (void)TraceSafeWrite(fd, info->errLog, strlen(info->errLog));
        (void)TraceSafeWrite(fd, "\n", 1);
        return TRACE_FAILURE;
    }
    if (layer >= MAX_STACK_LAYER) {
        LOGE("layer %d exceed the upper limit: %d", layer, MAX_STACK_LAYER);
        return TRACE_FAILURE;
    }
    for (int32_t i = 0; i <= layer; i++) {
        ret = TraceSafeWrite(fd, info->frame[i].info, strlen(info->frame[i].info));
        if (ret != TRACE_SUCCESS) {
            LOGE("write stack layer %d failed, ret=%d", i, ret);
            return ret;
        }
    }
    (void)TraceSafeWrite(fd, "\n", 1);
    return TRACE_SUCCESS;
}

/**
 * @brief       write "process" info
 * @param [in]  fd:     handle of stack_core file
 * @param [in]  info:   process info
 * @return      TraStatus
 */
TraStatus TraceSafeWriteProcessInfo(int32_t fd, const TraceStackProcessInfo *info)
{
    if (info == NULL) {
        return TRACE_INVALID_PARAM;
    }
    // write title [process]
    TraStatus ret = TraceSafeWrite(fd, PROCESS_SECTION, strlen(PROCESS_SECTION));
    if (ret != TRACE_SUCCESS) {
        LOGE("write process title failed, errno=%d", errno);
        return ret;
    }

    // write process info
    char data[CORE_BUFFER_LEN] = { 0 };
    int32_t err = snprintf_s(data, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U, 
        "crash reason:%d\ncrash pid:%d\ncrash tid:%d\ncrash stack base:0x%016lx\ncrash stack top:0x%016lx\n\n",
        info->signo, info->pid, info->tid, info->baseAddr, info->topAddr);
    if (err == -1) {
        LOGE("snprintf_s process info failed");
        return TRACE_FAILURE;
    }
    ret = TraceSafeWrite(fd, data, strlen(data));
    if (ret != TRACE_SUCCESS) {
        LOGE("write process info failed, info : %s", strerror(AdiagGetErrorCode()));
        return ret;
    }
    return TRACE_SUCCESS;
}

TraStatus TraceSaveProcessReg(uintptr_t *regs, uint32_t regSize)
{
    errno_t err = memcpy_s(g_stackBuff.process.regs, sizeof(uintptr_t) * TRACE_CORE_REG_NUM, regs, regSize);
    if (err != EOK) {
        LOGE("memcpy failed, err = %d, errno = %d.", (int32_t)err, errno);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceSaveProcessTask(int32_t pid)
{
    char path[CORE_BUFFER_LEN] = { 0 };
    int32_t err = snprintf_s(path, CORE_BUFFER_LEN, CORE_BUFFER_LEN - 1U, "/proc/%d/cmdline", pid);
    if (err == -1) {
        LOGE("snprintf_s cmdline path failed");
        return TRACE_FAILURE;
    }

    int32_t cmdFd = open(path, O_RDONLY);
    if (cmdFd < 0) {
        LOGE("cmdline file open failed, errno=%d", errno);
        return TRACE_FAILURE;
    }

    if (TraceSafeReadLine(cmdFd, g_stackBuff.process.task, (uint32_t)sizeof(g_stackBuff.process.task)) <= 0) {
        LOGE("read task info failed, errno=%d", errno);
        TraceClose(&cmdFd);
        return TRACE_FAILURE;
    }
    TraceClose(&cmdFd);
    return TRACE_SUCCESS;
}

/**
 * @brief       save process info
 * @param [in]  info:   stack info
 * @return      TraStatus
 */
TraStatus TraceSaveProcessInfo(const TraceStackProcessInfo *info)
{
    g_stackBuff.process.pid = info->pid;
    g_stackBuff.process.crashTid = info->tid;
    g_stackBuff.process.signo = info->signo;
    g_stackBuff.process.crashTime = info->crashTime;
    g_stackBuff.process.baseAddr = info->baseAddr;
    g_stackBuff.process.topAddr = info->topAddr;
    return TraceSaveProcessTask(info->pid);
}

/**
 * @brief       save stack info
 * @param [in]  info:   stack info
 * @return      TraStatus
 */
TraStatus TraceSaveStackInfo(const TraceStackInfo *info)
{
    if (info == NULL) {
        return TRACE_INVALID_PARAM;
    }
    if (info->threadIdx >= MAX_THREAD_NUM) {
        return TRACE_INVALID_PARAM;
    }

    ScThreadInfo *thread = &g_stackBuff.thread[info->threadIdx];
    thread->tid = info->threadTid;
    thread->layer = info->layer;
    errno_t err = strncpy_s(thread->name, THREAD_NAME_LEN, info->threadName, strlen(info->threadName));
    if (err != EOK) {
        LOGE("strcpy thread name failed");
        return TRACE_FAILURE;
    }

    int32_t layer = info->layer;
    if (layer < 0) {
        return TRACE_FAILURE;
    }
    if (layer >= MAX_STACK_LAYER) {
        LOGE("layer %d exceed the upper limit: %d", layer, MAX_STACK_LAYER);
        return TRACE_FAILURE;
    }

    err = memcpy_s(thread->frames, sizeof(ScdFrames) * (size_t)MAX_STACK_LAYER,
        info->frame, sizeof(TraceFrameInfo) * (size_t)MAX_STACK_LAYER);
    if (err != EOK) {
        LOGE("memcpy thread frames failed");
        return TRACE_FAILURE;
    }

    return TRACE_SUCCESS;
}

TraStatus TraceSafeWriteBuff(int32_t fd)
{
    TraStatus ret = TraceSafeWrite(fd, (const char *)&g_stackBuff, sizeof(g_stackBuff));
    (void)memset_s(&g_stackBuff, sizeof(struct StackcoreBuffer), 0, sizeof(struct StackcoreBuffer));
    if (ret != TRACE_SUCCESS) {
        LOGE("write buffer to file failed, info : %s", strerror(AdiagGetErrorCode()));
        return ret;
    }
    return TRACE_SUCCESS;
}

TraStatus TraceSafeMkdirPath(const TraceStackRecorderInfo *info)
{
    if (info == NULL) {
        return TRACE_INVALID_PARAM;
    }

    // get dir time by crash time
    char timeString[TIMESTAMP_MAX_LENGTH] = { 0 };
    TraStatus ret = TimestampToFileStr(info->crashTime, timeString, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        LOGE("get dir time failed, ret=%d", ret);
        return ret;
    }

    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, info->pid, timeString };
    return TraceRecorderSafeMkdirPath(&dirInfo);
}

TraStatus TraceSafeGetDirPath(const TraceStackRecorderInfo *info, char *path, size_t len)
{
    if ((info == NULL) || (path == NULL) || (len == 0)) {
        return TRACE_INVALID_PARAM;
    }

    // get dir time by crash time
    char timeString[TIMESTAMP_MAX_LENGTH] = { 0 };
    TraStatus ret = TimestampToFileStr(info->crashTime, timeString, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        LOGE("get dir time failed, ret=%d", ret);
        return ret;
    }

    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, info->pid, timeString };
    return TraceRecorderSafeGetDirPath(&dirInfo, path, len);
}

TraStatus TraceSafeGetFileName(const TraceStackRecorderInfo *info, char *name, size_t len)
{
    if ((info == NULL) || (name == NULL) || (len == 0)) {
        return TRACE_INVALID_PARAM;
    }
    char timeString[TIMESTAMP_MAX_LENGTH] = { 0 };
    uint64_t fileTime = GetRealTime();
    TraStatus ret = TimestampToFileStr(fileTime, timeString, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        LOGE("get dir time failed, ret=%d", ret);
        return ret;
    }

    int32_t err = snprintf_s(name, len, len - 1U, "%s_tracer_%d_%d_%s_%s",
        TRACER_STACKCORE_NAME, info->signo, info->tid, program_invocation_short_name, timeString);
    if (err == -1) {
        LOGE("snprintf_s file name failed, info : %s, signo=%d, tid=%d, name=%s",
            strerror(AdiagGetErrorCode()), info->signo, info->tid, program_invocation_short_name);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}