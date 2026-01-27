/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cpu_detect.h"
#include <pthread.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include "cpu_detect_print.h"
#include "cpu_detect_core.h"

STATIC pid_t g_pid = 0;
STATIC pthread_mutex_t g_cpuDetectMutex = PTHREAD_MUTEX_INITIALIZER;

STATIC INLINE void CpuDetectMutexLock(void)
{
    int32_t ret = pthread_mutex_lock(&g_cpuDetectMutex);
    ADETECT_CHK_EXPR(ret != 0, "mutex lock failed with %d.", ret);
}

STATIC INLINE void CpuDetectMutexUnLock(void)
{
    int32_t ret = pthread_mutex_unlock(&g_cpuDetectMutex);
    ADETECT_CHK_EXPR(ret != 0, "mutex unlock failed with %d.", ret);
}

STATIC pid_t CpuDetectCreateProcess(uint32_t timeout)
{
    pid_t id = fork();
    if (id == -1) {
        return 0;
    }
    if (id == 0) {
        // child
        CpudStatus ret = CpuDetectProcess(timeout);
        _exit(ret);
    } else {
        // parent
        return id;
    }
}

STATIC CpudStatus CpuDetectReleaseProcess(pid_t pid)
{
    int32_t wstatus = -1;
    int32_t ret = waitpid(pid, &wstatus, 0);
    if (ret > 0) {
        if (WIFEXITED(wstatus)) {
            ADETECT_INF("cpu detect process[%d] exit success, status: %d", pid, WEXITSTATUS(wstatus));
            return WEXITSTATUS(wstatus);
        } else if (WIFSIGNALED(wstatus)) {
            ADETECT_INF("cpu detect process[%d] be killed by signal: %d", pid, WTERMSIG(wstatus));
            return CPUD_ERROR_STOP;
        }
    } else if (ret == -1) {
        ADETECT_ERR("waitpid pid = %d, sub process exit abnormally", pid);
        return CPUD_FAILURE;
    }

    return CPUD_SUCCESS; 
}

CpudStatus CpuDetectStart(uint32_t timeout)
{
    ADETECT_CHK_EXPR_ACTION(((timeout == 0) || (timeout > CPUD_DETECT_MAX_TIME)), 
                            return CPUD_ERROR_PARAM, "invalid param timeout: %d", timeout);
    ADETECT_CHK_EXPR_ACTION(g_pid != 0, return CPUD_ERROR_BUSY, "cpu detect is running on process[%d].", g_pid);

    CpuDetectMutexLock();
    if (g_pid != 0) {
        ADETECT_INF("cpu detect is running on process[%d].", g_pid);
        CpuDetectMutexUnLock();
        return CPUD_ERROR_BUSY;
    }
    
    ADETECT_RUN_INF("cpu detect process start.");
    g_pid = CpuDetectCreateProcess(timeout);
    if (g_pid == 0) {
        ADETECT_ERR("create detect process failed.");
        CpuDetectMutexUnLock();
        return CPUD_ERROR_CREATE_PROCESS;
    } else {
        ADETECT_INF("start cpu detect process[%d] success", g_pid);
    }
    CpuDetectMutexUnLock();
    
    CpudStatus ret = CpuDetectReleaseProcess(g_pid);
    ADETECT_RUN_INF("cpu detect process[%d] end with %d.", g_pid, ret);
    
    g_pid = 0;
    return ret;
}

void CpuDetectStop(void)
{
    if (g_pid == 0) {
        ADETECT_INF("cpu detect is not running.");
        return;
    }

    CpuDetectMutexLock();
    if (g_pid != 0) {
        ADETECT_RUN_INF("cpu detect kill process[%d].", g_pid);
        int32_t ret = kill(g_pid, 9);
        if (ret != 0) {
            ADETECT_ERR("cpu detect stop process[%d] failed with %d.", g_pid, ret);
        }
    }
    CpuDetectMutexUnLock();
}
