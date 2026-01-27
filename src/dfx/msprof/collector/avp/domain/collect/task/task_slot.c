/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task_slot.h"
#include <string.h>
#include "errno/error_code.h"
#include "logger/logger.h"
#include "osal/osal.h"
#include "osal/osal_thread.h"

int32_t TaskSlotInitialize(TaskSlotAttribute *attr)
{
    attr->launchRepeatTimes = 0;
    attr->handle = (OsalThread)-1;
    attr->started = false;
    attr->quit = false;
    attr->jobAttr.isStart = false;
    (void)OsalCondInit(&attr->taskStartCond);
    (void)OsalCondInit(&attr->taskStopCond);
    (void)OsalCondInit(&attr->taskEndCond);
    (void)OsalMutexInit(&attr->taskMtx);
    return PROFILING_SUCCESS;
}

static OsalVoidPtr TaskSlotProcess(OsalVoidPtr args)
{
    TaskSlotAttribute *attr = (TaskSlotAttribute *)args;
    attr->jobAttr.deviceId = attr->deviceId;
    (void)OsalMutexLock(&attr->taskMtx);
    int32_t ret = JobManagerStart(&attr->jobAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start job manager for device %u failed, ret : %d", attr->deviceId, ret);
        attr->quit = true;
        (void)OsalCondSignal(&attr->taskStartCond);
        (void)OsalMutexUnlock(&attr->taskMtx);
        return NULL;
    }
    // wake up TaskSlotStart
    attr->started = true;
    (void)OsalCondSignal(&attr->taskStartCond);
    // wait for task stop signal
    MSPROF_LOGD("Wait for task stop signal.");
    OsalCondWait(&attr->taskStopCond, &attr->taskMtx);
    ret = JobManagerStop(&attr->jobAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Stop job manager for device %u failed, ret : %d", attr->deviceId, ret);
        attr->quit = true;
        (void)OsalCondSignal(&attr->taskEndCond);
        (void)OsalMutexUnlock(&attr->taskMtx);
        return NULL;
    }
    // wake up TaskSlotStop
    attr->quit = true;
    (void)OsalCondSignal(&attr->taskEndCond);
    (void)OsalMutexUnlock(&attr->taskMtx);
    return NULL;
}

 /**
 * @brief      start task slot for device and save device info to attr
 * @param [in]     params   : profiling params
 * @param [in/out] attr     : task slot attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t TaskSlotStart(const ProfileParam *params, TaskSlotAttribute *attr)
{
    attr->started = false;
    attr->quit = false;
    attr->jobAttr.params = params;
    OsalUserBlock userBlock;
    OsalThreadAttr threadAttr = {0, 0, 0, 0, 0, 1, OSAL_THREAD_MIN_STACK_SIZE};
    userBlock.procFunc = TaskSlotProcess;
    userBlock.pulArg = attr;
    int32_t ret = OsalCreateTaskWithThreadAttr(&attr->handle, &userBlock, &threadAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start task slot thread for device %u failed, errno : %d",
            attr->deviceId, OsalGetErrorCode());
        return ret;
    }
    (void)OsalMutexLock(&attr->taskMtx);
    if (!attr->started && !attr->quit) {
        // wait for device started success;
        MSPROF_LOGD("Wait for device started success.");
        OsalCondWait(&attr->taskStartCond, &attr->taskMtx);
    }
    if (attr->quit) {
        MSPROF_LOGE("Start task slot process for device %u failed.", attr->deviceId);
        (void)OsalMutexUnlock(&attr->taskMtx);
        return PROFILING_FAILED;
    }
    (void)OsalMutexUnlock(&attr->taskMtx);
    MSPROF_LOGI("Start task slot thread for device %u successfully", attr->deviceId);
    return PROFILING_SUCCESS;
}

int32_t TaskSlotStop(TaskSlotAttribute *attr)
{
    // wake up TaskSlotProcess
    (void)OsalMutexLock(&attr->taskMtx);
    (void)OsalCondSignal(&attr->taskStopCond);
    (void)OsalMutexUnlock(&attr->taskMtx);
    if (!attr->started) {
        return PROFILING_SUCCESS;
    }
    (void)OsalMutexLock(&attr->taskMtx);
    if (!attr->quit) {
        MSPROF_LOGD("Wait for task slot process thread end.");
        (void)OsalCondWait(&attr->taskEndCond, &attr->taskMtx);
    }
    (void)OsalMutexUnlock(&attr->taskMtx);
    attr->handle = (OsalThread)-1;
    MSPROF_LOGI("Stop task slot thread for device %u successfully", attr->deviceId);
    return PROFILING_SUCCESS;
}

int32_t TaskSlotFinalize(TaskSlotAttribute *attr)
{
    attr->started = false;
    return PROFILING_SUCCESS;
}